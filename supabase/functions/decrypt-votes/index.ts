import "jsr:@supabase/functions-js/edge-runtime.d.ts";
Deno.serve(async (req) => {
  const { encrypted_voting_data } = await req.json();

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
  const data = Uint8Array.from(atob(encrypted_voting_data), c => c.charCodeAt(0));

  const key = await crypto.subtle.importKey(
    "raw",
    encoder.encode(encryptionKey),
    { name: "AES-GCM" },
    false,
    ["encrypt", "decrypt"]
  );

  console.log(key, ivArray);

  const decryptedData = await crypto.subtle.decrypt(
    {
      name: "AES-GCM",
      iv: ivArray,
    },
    key,
    data
  );

  const decryptedText = new TextDecoder().decode(decryptedData);
  console.log(decryptedText);


  return new Response(
    JSON.stringify({
      decrypted_result: decryptedText,
    }),
    {
      headers: { "Content-Type": "application/json" },
    }
  );
});

