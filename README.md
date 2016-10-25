# VaporS3Signer

[Vapor](https://vapor.codes/) Provider for [S3SignerAWS](https://github.com/JustinM1/S3SignerAWS)

Generates authorization headers and pre-signed URLs for authenticating AWS S3 REST API requests
* Supports `GET, PUT, DELETE`

 ###Installation (SPM)

```ruby
.Package(url: "https://github.com/JustinM1/VaporS3Signer.git", majorVersion: 1)
 ```

###Config File

- Add `vapor-S3Signer.json` file to your Config/secrets folder.

The `vapor-S3Signer.json` file should contain your access key, secret key, and the region of your bucket.

Ex.
```ruby
{
"accessKey": "someKey",
"secretKey": "someSecretKey",
"region": "someRegionName"
}
```
Here are the names for each region:
##### US
* US East 1 Virginia = `"us-east-1"`
* US East 2 Ohio = `"us-east-2"`
* US West 1 = `"us-west-1"`
* US West 2 = `"us-west-2"`

##### EU

* EU West 1 = `"eu-west-1"`
* EU Central 1 = `"eu-central-1"`

##### AP

* AP South 1 = `"ap-south-1"`
* AP Southeast 1 = `"ap-southeast-1"`
* AP Southeast 2 = `"ap-southeast-2"`
* AP Northeast 1 = `"ap-northeast-1"`
* AP Northeast 2 = `"ap-northeast-2"`

##### SA

* SA East 1 = `"sa-east-1"`

###Usage
**Note:** Check [S3SignerAWS-README.md](https://github.com/JustinM1/S3SignerAWS/blob/master/README.md) for a detailed explanation on usage and capabilities.

VaporS3Signer makes it extremely easy to generate V4 auth headers and pre-signed URLs by adding an extension to `Droplet`.

#####V4 Auth Headers

```ruby
let drop = Droplet()

try drop.addProvider(VaporS3Signer.Provider.self)

drop.get("getS3TestImage") { req in

  guard let headers = try drop.s3Signer?.authHeaderV4(httpMethod: .get, urlString: "someS3_URL_String", headers: [:], payload: .none),
  let url = URL(string: "someS3_URL_String") else { throw Abort.serverError }

var request = URLRequest(url: url)
for header in headers {
    request.addValue(header.value, forHTTPHeaderField: header.key)
  }
request.httpMethod = HTTPMethod.get.rawValue

// execute request
}
```

#####V4 Pre-Signed URL

```ruby
 guard let presignedURL = try drop.s3Signer?.presignedURLV4(httpMethod: .get, urlString: "someS3_URL_String",
 expiration: TimeFromNow.oneHour, headers: [:]), let url = URL(string: presignedURL.urlString) else { throw Abort.serverError }

 var request = URLRequest(url: url)
    for header in presignedURL.headers {
        request.setValue(header.value, forHTTPHeaderField: header.key)
  }
request.httpMethod = HTTPMethod.get.rawValue

// execute request
```

* `TimeFromNow` has three default lengths, `30 minutes, 1 hour, and 3 hours`. There is also a custom option which takes `Seconds`: `typealias for Int`.

###Motivation

Found it quite painful to satisfy AWS S3 auth requirements, hoping to save others from some of that pain and suffering. Enjoy!

###Acknowledgements

Thanks [Tanner Nelson](https://github.com/tannernelson), [Logan Wright](https://github.com/LoganWright) and everyone in the [Vapor Slack Channel](http://vapor.team/)
