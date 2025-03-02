// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

// Setup type definitions for built-in Supabase Runtime APIs
import "jsr:@supabase/functions-js/edge-runtime.d.ts";
Deno.serve(async (req) => {
  const { voting_data } = await req.json();

  const encryptionKey = Deno.env.get("AES_PASSPHRASE");
  const iv = Deno.env
    .get("AES_IV")
    .split(",")
    .map((num) => parseInt(num));

  if (!encryptionKey) {
    return new Response(
      JSON.stringify({ error: "AES_PASSPHRASE is not set" }),
      { status: 500 }
    );
  }

  if (!iv) {
    return new Response(JSON.stringify({ error: "AES_IV is not set" }), {
      status: 500,
    });
  }

  const ivArray = new Uint8Array(iv);
  const encoder = new TextEncoder();
  const data = encoder.encode(voting_data);

  const key = await crypto.subtle.importKey(
    "raw",
    encoder.encode(encryptionKey),
    { name: "AES-GCM" },
    false,
    ["encrypt", "decrypt"]
  );

  console.log(key);

  const encryptedData = await crypto.subtle.encrypt(
    {
      name: "AES-GCM",
      iv: ivArray,
    },
    key,
    data
  );

  // Convert encrypted data to a Uint8Array
  const encryptedDataUint8 = new Uint8Array(encryptedData);
  // Convert binary data to a base64 string
  let binaryString = "";
  for (let i = 0; i < encryptedDataUint8.byteLength; i++) {
    binaryString += String.fromCharCode(encryptedDataUint8[i]);
  }
  const base64EncryptedData = btoa(binaryString);

  console.log(base64EncryptedData);

  return new Response(
    JSON.stringify({
      data: base64EncryptedData,
    }),
    {
      headers: { "Content-Type": "application/json" },
    }
  );
});

/* To invoke locally:

  1. Run `supabase start` (see: https://supabase.com/docs/reference/cli/supabase-start)
  2. Make an HTTP request:

  curl -i --location --request POST 'http://127.0.0.1:54321/functions/v1/encrypt-votes' \
    --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0' \
    --header 'Content-Type: application/json' \
    --data '{"name":"Functions"}'

      curl -i --location --request POST 'http://127.0.0.1:54321/functions/v1/encrypt-votes' --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0' --header 'Content-Type: application/json' --data '{"name":"Functions"}'
*/
