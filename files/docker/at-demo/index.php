<?php
$favicon    = getenv("FAVICON") ?? "fhttps://www.atcomputing.nl/assets/img/favicon.png";
$img_source = getenv("IMG_SOURCE") ?? "https://www.atcomputing.nl/assets/img/atcomputing_white.png";
$port       = getenv('PORT') ?? "0";
$node_ip    = getenv('NODE_IP') ?? "127.0.0.1";
?>
<!DOCTYPE html>
<html>

<head>
  <link rel="shortcut icon" type="image/x-icon" href="/<?= $favicon ?>" />
  <title>AT HashiCorp Demo</title>
  <style type="text/css">
  div {
    display: flex;
    justify-content: center;
    vertical-align: middle;
  }

  img {
    width: 640px;
    margin-top: 15%;
  }

  p {
    font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
    text-align: center;
    font-size: 2rem;
  }
  </style>
</head>

<body>
  <div>
    <img src="<?= $img_source ?>">
  </div>
  <div>
    <p>Running on host: <?= $node_ip ?> on port <?= $port ?>
    <p>
  </div>

</body>

</html>