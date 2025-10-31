<?php
require("../db.php");
// autharization
	$headers = apache_request_headers();

/* 	if (!isset($headers["Authorization"])) {
		http_response_code(401);
		exit;
	}

	if ($headers["Authorization"] !== "1234") {
		http_response_code(403);
		exit;
	} */

function validateID() {
    global $conn;
    if (empty($_GET["id"])) {
        http_response_code(400);
        exit;
    }

    $id = $_GET["id"];

    if (!is_numeric($id)) {
        header("Content-Type: application/json; charset=utf-8");
        http_response_code(400);
        echo json_encode(["message" => "ID is malformed"]);
        exit;
    }

    $id = intval($id, 10);

    $stmt = $conn->prepare("SELECT * FROM characters WHERE id = :id");
    $stmt->bindParam(":id", $id, PDO::PARAM_INT);
    $stmt->execute();
    $result = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!is_array($result)) {
        http_response_code(404);
        exit;
    }

    return $id;
}

// HENT ALLE KARAKTERER (with type filter: ?type=demon or ?type=slayer)
if ($_SERVER["REQUEST_METHOD"] === "GET" && empty($_GET["id"])) {

    $limit = isset($_GET["limit"]) ? intval($_GET["limit"]) : 10;
    $offset = isset($_GET["offset"]) ? intval($_GET["offset"]) : 0;

    // Filter by type (demon, slayer, other)
    $type = isset($_GET["type"]) ? $_GET["type"] : null;  

    $whereClause = "";
    $params = [];
    if ($type !== null) {
        $whereClause = "WHERE type = :type";
        $params[":type"] = $type;
    }

    $stmt = $conn->prepare("SELECT COUNT(id) FROM characters $whereClause");
    foreach ($params as $key => $value) {
        $stmt->bindValue($key, $value);
    }
    $stmt->execute();
    $count = $stmt->fetch(PDO::FETCH_ASSOC);
    
    $stmt = $conn->prepare("SELECT id, name FROM characters $whereClause LIMIT :limit OFFSET :offset");
    $stmt->bindParam(":limit", $limit, PDO::PARAM_INT);
    $stmt->bindParam(":offset", $offset, PDO::PARAM_INT);
    foreach ($params as $key => $value) {
        $stmt->bindValue($key, $value);
    }
    $stmt->execute();
    $results = $stmt->fetchAll(PDO::FETCH_ASSOC);

    $nextOffset = $offset + $limit;
    $prevOffset = $offset - $limit;

    $next = "http://localhost/demon-slayer/characters?offset=$nextOffset&limit=$limit" . ($type ? "&type=$type" : "");
    $prev = "http://localhost/demon-slayer/characters?offset=$prevOffset&limit=$limit" . ($type ? "&type=$type" : "");

    // Tilføj Hypermedia Controls
    for ($i = 0; $i < count($results); $i++) {
        $results[$i]["url"] = "http://localhost/demon-slayer/characters/" . $results[$i]["id"];
        unset($results[$i]["id"]);
    }

    header("Content-Type: application/json; charset=utf-8");
    $output = [
        "count" => $count["COUNT(id)"],
        "next" => $nextOffset < $count["COUNT(id)"] ? $next : null,
        "prev" => $offset <= 0 ? null : $prev,
        "results" => $results
    ];
    echo json_encode($output);
}

// HENT ENKELT KARAKTER
if ($_SERVER["REQUEST_METHOD"] === "GET" && !empty($_GET["id"])) {
    $id = validateID();

    $stmt = $conn->prepare("SELECT 
                    characters.id, characters.name,
                    characters.description, characters.rank, characters.type,
                    characters.abilities, images.url AS url
    FROM characters
        LEFT JOIN character_images ON character_images.character_id = characters.id
        LEFT JOIN images ON images.id = character_images.image_id
    WHERE characters.id = :id");
    $stmt->bindParam(":id", $id, PDO::PARAM_INT);
    $stmt->execute();

    $results = $stmt->fetchAll(PDO::FETCH_ASSOC);

    $output = [
        "id" => $results[0]["id"],
        "name" => $results[0]["name"],
        "description" => $results[0]["description"],
        "rank" => $results[0]["rank"],
        "type" => $results[0]["type"],
        "abilities" => $results[0]["abilities"],
        "media" => [],
    ];

    for ($i = 0; $i < count($results); $i++) {
        if (!empty($results[$i]["url"])) {
            $output["media"][] = $results[$i]["url"];
        }
    }

    header("Content-Type: application/json; charset=utf-8");
    echo json_encode($output);
} 

// OPRET ET KARAKTER
if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $name = $_POST["name"];
    $description = $_POST["description"];
    $rank = $_POST["rank"];
    $abilities = $_POST["abilities"];
    $type = $_POST["type"];  
    try { 
        $stmt = $conn->prepare("INSERT INTO characters (`name`, `description`, `rank`, `type`, `abilities`)
                                                    VALUES(:name, :description, :rank, :type, :abilities)");
    
        $stmt->bindParam(":description", $description);
        $stmt->bindParam(":name", $name);
        $stmt->bindParam(":rank", $rank);
        $stmt->bindParam(":type", $type);
        $stmt->bindParam(":abilities", $abilities);

        $stmt->execute();
        http_response_code(201);
    }
    catch (Exception $e) {
        http_response_code(400);
        echo "Error creating character: " . $e->getMessage();
    }
}

// REDIGER ET KARAKTER (PUT)
if ($_SERVER["REQUEST_METHOD"] === "PUT") {
    $id = validateID();

    parse_str(file_get_contents("php://input"), $body);

    if (empty($body["name"])
        || empty($body["description"])
        || empty($body["rank"])
        || empty($body["type"])  
        || empty($body["abilities"])) {
            header("Content-Type: application/json; charset=utf-8");
            http_response_code(400);
            echo json_encode(["message" => "missing field(s). Required fields: 'name', 'description', 'rank', 'type', 'abilities'"]);
            exit;
    }
    
    $stmt = $conn->prepare("UPDATE characters
            SET name = :name, description = :description, rank = :rank, type = :type, abilities = :abilities WHERE id = :id");
    
    $stmt->bindParam(":description", $body["description"]);
    $stmt->bindParam(":name", $body["name"]);
    $stmt->bindParam(":rank", $body["rank"]);
    $stmt->bindParam(":type", $body["type"]);
    $stmt->bindParam(":abilities", $body["abilities"]);
    $stmt->bindParam(":id", $id, PDO::PARAM_INT);

    $stmt->execute();

    $stmt = $conn->prepare("SELECT * FROM characters WHERE id = :id");
    $stmt->bindParam(":id", $id, PDO::PARAM_INT);
    $stmt->execute();

    header("Content-Type: application/json; charset=utf-8");
    http_response_code(200);
    echo json_encode($stmt->fetch(PDO::FETCH_ASSOC));
}

// SLET ET KARAKTER
if ($_SERVER["REQUEST_METHOD"] === "DELETE") {
    if (empty($_GET["id"])) {
        http_response_code(400);
        exit;
    }

    $id = $_GET["id"];

    $stmt = $conn->prepare("DELETE FROM characters WHERE id = :id");
    $stmt->bindParam(":id", $id, PDO::PARAM_INT);

    $stmt->execute();
    http_response_code(204);
    if ($stmt->rowCount() > 0) {
        header("Content-Type: application/json; charset=utf-8");
        http_response_code(200);
        echo json_encode(["message" => "Success: Deleted"]);
    } else {
        header("Content-Type: application/json; charset=utf-8");
        http_response_code(404);
        echo json_encode(["message" => "Failed: Not found"]);
    }
}