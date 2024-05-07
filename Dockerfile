FROM node:18-alpine
WORKDIR /nuxt_tailwind_supabase
COPY . .
EXPOSE 3000
CMD ["npm","run", "dev", "--", "--host"]
