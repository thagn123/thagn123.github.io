$ErrorActionPreference = 'Stop'
$root = $PSScriptRoot
$origin = 'https://thagn123.github.io'

foreach ($page in @(
    @{ Path = 'index.html'; Description = 'SafeDrive AI — Agent Armor for Automotive LLM' },
    @{ Path = 'device-bridge/index.html'; Description = 'SafeDrive AI — Public USB Device Bridge' }
)) {
    $target = Join-Path $root $page.Path
    $previous = [System.IO.File]::ReadAllText($target)
    $fontMatch = [regex]::Match($previous, '<style data-vinext-fonts>.*?</style>', [System.Text.RegularExpressions.RegexOptions]::Singleline)
    if (-not $fontMatch.Success) { throw "Font styles not found: $($page.Path)" }
    $fontStyles = $fontMatch.Value
    $html = @"
<!doctype html>
<html lang="vi">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>SafeDrive AI — Agent Armor for Automotive LLM</title>
  <meta name="description" content="$($page.Description)">
  <meta property="og:title" content="SafeDrive AI — Agent Armor for Automotive LLM">
  <meta property="og:description" content="$($page.Description)">
  <meta property="og:url" content="$origin$($(if($page.Path -eq 'index.html'){'/'}else{'/device-bridge/'}))">
  <meta property="og:image" content="$origin/og.png">
  <link rel="icon" href="/favicon.svg">
  <link rel="stylesheet" href="/_next/static/css/index.CTO6wCfH.css">
  <link rel="preload" href="/_next/static/_vinext_fonts/geist-8ac0455e797f/geist-98bbbccb.woff2" as="font" type="font/woff2" crossorigin>
  $fontStyles
</head>
<body class="__variable_geist_19ysh9d __variable_geist_mono_1001rt9">
  <div id="root"><main style="max-width:36rem;margin:12vh auto;padding:2rem;font:16px sans-serif;color:#fff">Đang tải SafeDrive...</main></div>
  <script type="module" src="/bootstrap.js"></script>
</body>
</html>
"@
    [System.IO.File]::WriteAllText($target, $html, [System.Text.UTF8Encoding]::new($false))
    Write-Output "STATICIZED=$($page.Path)"
}
