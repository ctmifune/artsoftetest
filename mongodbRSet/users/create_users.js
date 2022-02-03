db.createUser( {
     user: "oploguser",
     pwd: "opPass22",
     roles: [ { role: "read", db: "local" },{role: "clusterMonitor", db: "admin"}]
   });
db.createUser({
	user: "rocket",
	pwd: "roPass22",
	roles: [{role: "readWrite", db: "rocketchat"}, {role: "clusterMonitor", db: "admin"}]});
