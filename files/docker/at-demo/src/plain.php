<?php
$node_ip     = getenv('NODE_IP') ?? "127.0.0.1";
$host_port   = getenv('HOST_PORT') ?? "0";
$mapped_port = getenv('MAPPED_PORT') ?? "0";
?>
Information of the instance:<br>
----------------------------<br>
Node IP:     <?= $node_ip ?><br>
Host Port:   <?= $host_port ?><br>
Mapped Port: <?= $mapped_port ?><br>
