# docker dev nuxt tailwind daisy supabase

docker dev nuxt tailwind daisy supabase

### terminal A

1. Es würde in terminal A, ein nuxt project mit alle ihre dependencies in ein node-alpine shell container installiert.

```sh
docker run -it --rm node:18 sh


npx nuxi@latest init your_app_name
# auf die Frage, Initialize git repository ->no

cd your_app_name

npm i

# Tailwind

npm install -D tailwindcss postcss autoprefixer
npx tailwindcss init

#Daisy
npm i -D daisyui@latest

#supabase

npm install @supabase/supabase-js

```

### terminal B

2. Dann in Terminal B in der Folder wo wir unseren project möchten:

```sh

# container_id kopieren die gerade in terminal A gemacht haben

docker ps

# inhalt in dein project kopieren
docker cp container_id:your_app_name .

#rein gehen

cd your_app_name

#vsc offnen

code .

```

### IDE (zb VSC)

3. In VSC: Jetzt ein Dockerfile und .dockerignore hinzufugen

(Ich habe mit Abssicht die node_modules nicht hinzugefügt, um alle dependencies in node-alpine runterladen zu können )

```dockerfile
FROM node:18-alpine
WORKDIR /docker-nuxt
COPY . .
EXPOSE 3000
CMD ["npm","run", "dev", "--", "--host"]

```

Dann den Rest der Konfigurationen von Tailwind, Daisy und Supabase gemacht. Es würde geändert/hinzugefügt:

- tailwind.config.js

- nuxt.config.ts

- utils/supabase.js

- assets/css/main.css

- .env.local

Dann würde den Docker Image gemacht und dann ihre Container:

```
docker build -t name_of_the_image_you_want .

docker run -d -p new_port_you_want:port_in_dockerfile -v ABSOLUTE_PATH_YOUR_WORK_APP:PATH_OF_YOUR_IMAGE --name NAME_TO_YOUR_CONTAINER_you_WANT name_or_ID_of_the_image

```
zb: 

docker run -d -p 3030:3000 -v /Users/maria.rios-navarro/Documents/git_hub/nuxt_tailwind_supabase:/nuxt_tailwind_supabase --name superbase_nuxt_cont 6b8808cc505292754cbe71b93ab367f47397422e0c85c96e13035c37c6c1aa8d


Man kann jetzt etwas in den pages was ändern zu testen, man sollte die änderungen sofort sehen.



HINWEIS: Man kann das Container schnell in dein Docker-Desktop starten (oder stoppen) (Aktionen)

(als repo habe ich mein .gitignore so reduziert, damit alle dependencies wieder runterladen kann, um nicht den step 1 und 2 nicht wieder machen zu mussen)

```
# Logs
logs
*.log

# Misc
.DS_Store
.fleet
.idea

# Local env files
.env
.env.*
!.env.example
```
