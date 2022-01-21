<?php
$node_ip     = getenv('NODE_IP') ?? "127.0.0.1";
$host_port   = getenv('HOST_PORT') ?? "0";
$mapped_port = getenv('MAPPED_PORT') ?? "0";
?>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>AT HashiCorp Demo</title>
  <link rel="shortcut icon" href="https://www.atcomputing.nl/assets/img/favicon.png" type="image/x-icon">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
  <link rel="stylesheet" href="style.css">
</head>

<body>
  <div class="container-fluid bg">
    <div class="display-6 fw-bold text-white text-center w-75 info">
      <div class="border-bottom mb-4">Information of the instance:</div>
      <div class="details">
        <div class="row">
          <div class="col-6 text-end">Node IP:</div>
          <div class="col-6 text-start results"><?= $node_ip ?></div>
        </div>
        <div class="row">
          <div class="col-6 text-end">Host port:</div>
          <div class="col-6 text-start results"><?= $host_port ?></div>
        </div>
        <div class="row">
          <div class="col-6 text-end">Mapped port:</div>
          <div class="col-6 text-start results"><?= $mapped_port ?></div>
        </div>
      </div>
    </div>
  </div>
</body>

</html>