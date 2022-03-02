CREATE CONSTRAINT ON(u:User)
ASSERT u.id IS unique;
:param keysToKeep => ["name", "username", "bio", "following", "followers"];
CALL apoc.load.json("https://raw.githubusercontent.com/Ariadnadpd/BDOG_y_consulta-DAW2/main/BD_twitter.json")
YIELD value
MERGE (u:User {id: value.user.id })
SET u += value.user
FOREACH (following IN value.following |  
  MERGE (f1:User {id: following})  
  MERGE (u)-[:FOLLOWS]->(f1))
FOREACH (follower IN value.followers |  
  MERGE(f2:User {id: follower})  
  MERGE (u)<-[:FOLLOWS]-(f2));
  