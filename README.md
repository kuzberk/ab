# Kurcala

Platformdan bağımsız kişisel akış. Her paylaşım bir markdown dosyası, site Hugo ile üretilir, GitHub Pages yayınlar.

## İlk kurulum (10 dakika)

1. GitHub'da `kuzberk/kurcala` adında boş bir depo aç.
2. Bu klasörün içeriğini depoya it:
   ```bash
   git init -b main
   git add .
   git commit -m "ilk kurulum"
   git remote add origin git@github.com:kuzberk/kurcala.git
   git push -u origin main
   ```
3. Depoda **Settings → Pages → Source: GitHub Actions** seç.
4. Actions sekmesinde "Yayınla" çalışınca site `https://kuzberk.github.io/kurcala/` adresinde açılır.
5. `hugo.toml` içindeki `slogan`, `author`, `authorBio`, `github` alanlarını kendine göre düzenle.
6. `content/hakkimda.md` ve `content/iletisim.md` içindeki yönergeleri sil, kendi metnini yaz.
7. Örnek akış, yazı ve kaynak dosyalarını sil.

Yerelde denemek için [Hugo extended](https://gohugo.io/installation/) kur ve `hugo server` çalıştır.

## Paylaşmanın üç yolu

**Komut satırı**
```bash
scripts/paylas.sh "Bugün statik siteye geçtim." notlar,github
```
Dosyayı oluşturur, commit'ler ve push'lar. Etiketler isteğe bağlı.

**Telefondan (GitHub Issues)**
Depoda **Issues → New issue → Akış paylaşımı** şablonunu seç, metni gövdeye yaz ve gönder. `issue-to-akis.yml` workflow'u metni akışa ekler, issue'yu kapatır ve siteyi yeniden yayınlar. Yalnızca depo sahibinin açtığı issue'lar işlenir. Metin boşsa başlık kullanılır.

**Elle**
`hugo new akis/2026-10-15-0900.md` ya da `content/akis/` altına doğrudan dosya ekle.

## Yapı

```
content/
  _index.md          ana sayfa metni
  buradan-basla.md   yeni gelenler için
  hakkimda.md
  iletisim.md
  akis/              kısa paylaşımlar (başlıksız)
  yazilar/           uzun yazılar (başlık + özet)
  kaynaklar/         indirilebilir materyaller
layouts/             şablonlar (ana sayfa, liste, tekil, RSS, JSON Feed)
assets/css/main.css  tek stil dosyası, açık/koyu tema
scripts/paylas.sh    hızlı paylaşım
.github/workflows/   yayın ve issue'dan paylaşım
```

Bölüm başlığı ve açıklaması her bölümün `_index.md` dosyasından gelir, ana sayfadaki kapılar da oradan beslenir.

## Yazı ve kaynak eklemek

```bash
hugo new yazilar/yeni-yazi.md      # taslak olarak açılır, yayınlamak için draft: false yap
hugo new kaynaklar/sablon.md
```
Kaynakta indirilebilir dosya için dosyayı `static/dosyalar/` içine koy ve front matter'a `dosya: "dosyalar/sablon.pdf"` yaz. Sayfada İndir düğmesi çıkar.

## Özel alan adı

1. Alan adının DNS'inde `kurcala` için GitHub Pages kayıtlarını ekle ([rehber](https://docs.github.com/pages/configuring-a-custom-domain-for-your-github-pages-site)).
2. Settings → Pages → Custom domain alanına yaz, HTTPS'i etkinleştir.
3. İstersen `hugo.toml` içindeki `baseURL`'i güncelle. Deploy sırasında zaten otomatik ezilir.

## Takip

- RSS: `/index.xml`
- JSON Feed: `/feed.json`

İkisi de akış ve yazıları içerir, son 30 girdiyle sınırlıdır. Kaynaklar ve statik sayfalar akışa girmez.

## Notlar

- Hugo sürümü `deploy.yml` içinde `HUGO_VERSION` ile sabitlenmiştir. Zaman zaman güncelle.
- Dışarıdan font, script ya da izleyici yüklenmez.
- E-posta bülteni istersen servisin form/sayfa adresini `hugo.toml` içinde `bulten` alanına yaz, altbilgide bağlantı olarak çıkar.
