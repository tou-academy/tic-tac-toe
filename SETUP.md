# Supabase setup

1. Create a free project at https://supabase.com (New project; save the database password somewhere).
2. Open **SQL Editor** > **New query**, paste everything from `supabase/schema.sql`, click **Run**.
3. Open **Project Settings > API**. Copy the **Project URL** and the **anon public** key into `config.js`.
4. Open **Authentication > Providers > Email**. For quick testing turn **Confirm email** off (otherwise new players must click a link in their inbox before logging in).
5. Open **Authentication > URL Configuration**. Set **Site URL** to where the game is hosted (for local testing, e.g. `http://localhost:8080`).
6. Serve the folder (e.g. `npx http-server .`) and open it in the browser. Sign up, play, close the tab, log in again and press **Continue**.
