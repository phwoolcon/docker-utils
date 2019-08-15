Phwoolcon Image for Development
==

Use this image in your development environment.

```bash
git clone git@github.com:phwoolcon/bootstrap.git my-project-name
cd my-project-name
docker run -d -p 10080:80 --name my-project-name -v "$PWD"/ignore/docker:/mnt/data -v "$PWD":/srv/http --restart always -e "SET_UID=$UID" phwoolcon/phwoolcon-dev
```

Enjoy developing, and visit http://127.0.0.1:10080 to see your changes!
