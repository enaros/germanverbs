Package.describe({
  summary: "Parse XML into JSON"
});

Npm.depends({
	xml2js: "0.2.6",
	cheerio: "0.12.1"
});

Package.on_use(function (api) {
  api.add_files("xml2js.js", "server");
});
