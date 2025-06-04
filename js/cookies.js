function saveOpinionToCookies(opinion) {
  let opiniones = getOpinionsFromCookies();
  opiniones.push(opinion);
  document.cookie = "opiniones=" + encodeURIComponent(JSON.stringify(opiniones)) + "; path=/";
}

function getOpinionsFromCookies() {
  const cookies = document.cookie.split(';').map(c => c.trim());
  const cookie = cookies.find(c => c.startsWith('opiniones='));
  if (cookie) {
    const value = decodeURIComponent(cookie.substring('opiniones='.length));
    try {
      return JSON.parse(value);
    } catch {
      return [];
    }
  }
  return [];
}
