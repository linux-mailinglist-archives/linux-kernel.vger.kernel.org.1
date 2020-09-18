Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5107F26F57F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 07:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgIRFtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 01:49:00 -0400
Received: from mail-db8eur05on2056.outbound.protection.outlook.com ([40.107.20.56]:38785
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726420AbgIRFs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 01:48:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WMqid4MM8gQbX/Z1muhDM04U2xexeqpgSMLksPtCCFlCShBRHLAnbppvD6rxGabfcDBSu+PCcRdKVIczT/IFfbIHJ8X+ogqoWCOSmxRIflsg4wP9oKzks96qmRwOFcMWD/wFaazSuH4cmPlKwFQJ5w0wqjy8coVAv71ps3dplcguK9vz7UV/p8mTWx0ypJzeK+4bXs2ECDjhAmPkG+aVg2+egvykY8Zn8dqjvTdeLfFAf1MtBQ90s45L75Tu9Xswif1i8cSjkuz8sRwDW9HDVVHNpdOvkgLnc7AmyLkDy3a6q6lzZBNXwG+yJ8f1fKICLXSQtVdKYBM5KXwhLiOxLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RSlAm+A0cBk6W4JLRKhOZqse4H+gxG9cjinC63jP3Y=;
 b=L8W1inaFH5mdsH7D4Xr1IG6II/6lzzBr/2Mfq4/LtpOLKrtQVC+8YFoq3xVBkNkwD8nRBERjKtSW0bh9KDYrhFyA+j9KTPCO+RR5VfATPhogj8cCKH3EvuHwRxIozOPfWZpr94UbRGKC8/ZSps56I4v+hI91vs/Xdz+DQK4iBDiHVyLDOg7FqUyzDXWreOM20qpmndqXKdKX1YnwB9hqSmnTtWGM6w+s8OlwKTsIG7mwOA+ZlrXMneZNxjMAmI4+OcH4ojmvWgUBsVMczYFzuVU3qb5bV0JyWPwj6pbiRrA9D7lZPUp783tXdv2qAeF9MRqGkPSuv2nVu//ZoKr2UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RSlAm+A0cBk6W4JLRKhOZqse4H+gxG9cjinC63jP3Y=;
 b=RYMYIEfOH6xQf0LRcbeucoWlm6ZyWWvkIyZu1xpO1D12MN80OyDxJHo/t3PArBA2JcmzPh1X8BLfziuk17uocG0YYQSwPOyQl+F5RAw7/xdmPaNE96AQKNxPzGIU5ml3LSAMNe5LPc0JWUQAj2zzY3F0X75n0RWb8Dh0vwDydFI=
Received: from DB6PR03MB3160.eurprd03.prod.outlook.com (2603:10a6:6:37::21) by
 DBAPR03MB6424.eurprd03.prod.outlook.com (2603:10a6:10:192::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Fri, 18 Sep 2020 05:48:55 +0000
Received: from DB6PR03MB3160.eurprd03.prod.outlook.com
 ([fe80::3c50:c4c8:c54e:19e3]) by DB6PR03MB3160.eurprd03.prod.outlook.com
 ([fe80::3c50:c4c8:c54e:19e3%2]) with mapi id 15.20.3391.014; Fri, 18 Sep 2020
 05:48:55 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>
Subject: Re: [PATCH v2] dt-bindings: mfd: rohm,bd71837-pmic: Add common
 properties
Thread-Topic: [PATCH v2] dt-bindings: mfd: rohm,bd71837-pmic: Add common
 properties
Thread-Index: AQHWjSoOiuv+9mc+IEipLl5urzAe76lt5HOA
Date:   Fri, 18 Sep 2020 05:48:54 +0000
Message-ID: <cf55864a2d9ff7fcd397273b27cb10619029bd58.camel@fi.rohmeurope.com>
References: <20200917193754.542-1-krzk@kernel.org>
In-Reply-To: <20200917193754.542-1-krzk@kernel.org>
Reply-To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=fi.rohmeurope.com;
x-originating-ip: [213.255.186.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 03b0075a-3b25-42fd-a33d-08d85b968804
x-ms-traffictypediagnostic: DBAPR03MB6424:
x-microsoft-antispam-prvs: <DBAPR03MB64246DA9D5C3FAC4D523110EAD3F0@DBAPR03MB6424.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iE1FY/sdattjh0j04vVONcWweLI65jPK1Kosr32QKOY/nTNOI4ZYpSYpxm5VJBu/0BHPBBSHLKV7MeGH7fH1eiA+XjToPx9oCZbiEoLCeEYF7ve8yGGwmnx/skySdVaQs6P8Y+l3qR4cpFSoRnYKlJuQNMBHHX1mAkba/f7wz/OJ4YPT+thwq+2WkTxMXa2rY4Q6jYM2QbwxHehbbGA+9lYSG3sGz36T2cum9VN8GcXzf/tF9y0pPXFNhBMbf+Ow0Lye/pt71/dtBtaLtdToK6bK+haCyI3mVyi7doViukZ2+FDWkds7L9mU6K9g5yjZTLGFws2kJAlzFTKhXzTsyZM8bT9RsC5GFG6mWCA6QXIsvXZsHb7jDFvvgG6bQjIXim/ZvoB7Vgx599aw1ueyQ+fHtX4rU/+pcgKoGidx0Fk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR03MB3160.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39850400004)(396003)(346002)(376002)(136003)(2616005)(26005)(478600001)(3450700001)(83380400001)(6486002)(110136005)(8936002)(316002)(86362001)(66556008)(6512007)(66476007)(186003)(64756008)(66446008)(76116006)(5660300002)(91956017)(2906002)(6506007)(66946007)(8676002)(71200400001)(142933001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Gd9X/pIms3qx6gcpgmea4+UOS5As4HDiKJsmbWz7HYur1Iy5irh5hqMC35i5brlGI1aCu7sFCjkTsyi8DxIIViKyuOM+P6zs6LSUeVvbWiHcLY+PUBEqv/39g2l7lrzCYIKvAGGtdpQVdeAMytn5ubQG79dRm+ndzZlEHkotoCoydxW/6JVVh1y8wke48AtDwROZ+ViO+B6RrnjtK2r9ch19d8GyD+zjJWkgFj7OfZ6ZIeYXjBpMBZTMhN+peBLP3AeMc+DDiDzWJwCUsO5VlThuroeWQuMgUklAy+Bd3qEjFK6/kge7DLMCaVT36acI0zhcCMfSTAHm594//kweTIS7xsEOvjTfbekKAZ1Ga1aWZnLCmt/H4eySZPFnV1PCuu0RFd5kzseS1p6VfqoDApg/YGJCGQ8Jm1I2Hcs5RW35oVPDh1sOAGNeKuSy5NPQiZlCT/F3kdq4ooBlyH0MKLi8+TJirW6amWlcHr9PkRBdqPfyUoQGhm2vcy2P050lpwdOmXTwYcuXujZe/QpjGkHX/fL236doVzPdCdN9yH1Gj8EyGobbik+kS//3XnVQ/X6zo4UIhRw+Ajahog9Dq/lyX/pAQNQGZDBIOGkG0NdhWCvkqrwEea1S/6Ua72mxQn98sP5GOmCk1qVAtkKMxQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C8D1140C683DC498C60DE6C371A6623@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR03MB3160.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b0075a-3b25-42fd-a33d-08d85b968804
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2020 05:48:54.1432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ojmYdY4wdjRdpyALhzfavYOw6lBkDt9iUHDQijjycsRuEh2rDiGzHUm1KTyB/d9fatsiQ1bQlRzSOcmAqv4OwRjyipSf69P9u1+P1OP5sWCDjTrzNdX6jz/o/fzSoCAY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR03MB6424
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgZGVlZWUgSG8gcGVlcHMhDQoNCk9uIFRodSwgMjAyMC0wOS0xNyBhdCAyMTozNyArMDIwMCwg
S3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gQWRkIGNvbW1vbiBwcm9wZXJ0aWVzIGFwcGVh
cmluZyBpbiBEVFNlcyAoY2xvY2stbmFtZXMsDQo+IGNsb2NrLW91dHB1dC1uYW1lcykgd2l0aCB0
aGUgY29tbW9uIHZhbHVlcyAoYWN0dWFsbHkgdXNlZCBpbiBEVFNlcykNCj4gdG8NCj4gZml4IGR0
YnNfY2hlY2sgd2FybmluZ3MgbGlrZToNCj4gDQo+ICAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVl
c2NhbGUvaW14OG1xLWxpYnJlbTUtcjIuZHQueWFtbDoNCj4gICAgIHBtaWNANGI6ICdjbG9jay1u
YW1lcycsICdjbG9jay1vdXRwdXQtbmFtZXMnLCBkbyBub3QgbWF0Y2ggYW55IG9mDQo+IHRoZSBy
ZWdleGVzOiAncGluY3RybC1bMC05XSsnDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLcnp5c3p0b2Yg
S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+DQo+IA0KPiAtLS0NCj4gDQo+IENoYW5nZXMgc2lu
Y2UgdjE6DQo+IDEuIERlZmluZSB0aGUgbmFtZXMsIGFzIHVzZWQgaW4gZXhpc3RpbmcgRFRTIGZp
bGVzLg0KPiAtLS0NCj4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9yb2htLGJkNzE4Mzct
cG1pYy55YW1sICAgICAgICAgIHwgNg0KPiArKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGlu
c2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvbWZkL3JvaG0sYmQ3MTgzNy0NCj4gcG1pYy55YW1sIGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9yb2htLGJkNzE4MzctDQo+IHBtaWMueWFtbA0KPiBpbmRl
eCA2NTAxOGEwMTllMWQuLjNiZmRkMzM3MDJhZCAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9yb2htLGJkNzE4MzctcG1pYy55YW1sDQo+ICsrKyBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvcm9obSxiZDcxODM3LXBtaWMu
eWFtbA0KPiBAQCAtMzIsOSArMzIsMTUgQEAgcHJvcGVydGllczoNCj4gICAgY2xvY2tzOg0KPiAg
ICAgIG1heEl0ZW1zOiAxDQo+ICANCj4gKyAgY2xvY2stbmFtZXM6DQo+ICsgICAgY29uc3Q6IG9z
Yw0KDQpJIGd1ZXNzIGV4aXN0aW5nIGJvYXJkIGR0c2VzIHVzZSAib3NjIiB0aGVuPyBPay4NCg0K
PiAgICAiI2Nsb2NrLWNlbGxzIjoNCj4gICAgICBjb25zdDogMA0KPiAgDQo+ICsgIGNsb2NrLW91
dHB1dC1uYW1lczoNCj4gKyAgICBjb25zdDogcG1pY19jbGsNCg0KVGhpcyBpcyBub3QgYSBzdHJv
bmcgb3BpbmlvbiBidXQgSSBmZWVsIHRoYXQgcG1pY19jbGsgaXMgYSBiaXQgdG9vDQpnZW5lcmlj
IG5hbWU/IEkgbWVhbiwgd2hhdCBpZiB0aGVyZSBpcyBhIHN5c3RlbSB3aXRoIG1vcmUgdGhhbiBv
bmUNClBNSUNzPyAoSSBkb24ndCBzZWUgc3VjaCB1c2UtY2FzZSB3aXRoIHRoZSBCRDcxOHg3IHRo
b3VnaCAtIGJ1dCBwZXJoYXBzDQp0aGlzIGNhbiBzZXJ2ZSBhcyBhIG1pc2xlYWRpbmcgZXhhbXBs
ZSBmb3Igb3RoZXIgUE1JQ3M/IEZvciBleGFtcGxlDQp3aXRoIHRoZSBST0hNIEJEOTY4MDEgZmFt
aWx5IHRoZXJlIG1heSBiZSBtdWx0aXBsZSBQTUlDcyBpbiBvbmUNCnN5c3RlbSkuIEFueXdheXMg
LSBpZiBSb2IgaXMgaGFwcHkgd2l0aCB0aGlzIHRoZW4gcGxlYXNlIGdvIHdpdGggaXQgOikNCg0K
QWNrZWQtQnk6IE1hdHRpIFZhaXR0aW5lbiA8bWF0dGkudmFpdHRpbmVuQGZpLnJvaG1ldXJvcGUu
Y29tPg0KICogDQpUaGFua3MgYWdhaW4gZm9yIGltcHJvdmluZyB0aGVzZSBiaW5kaW5ncyEgSSBh
bSBjb25zdGFudGx5IHN0cnVnZ2xpbmcNCndpdGggdGhlc2UgeF94LiBXcml0aW5nIHRoZSBiaW5k
aW5ncyBpcyBwcm9iYWJseSBoYXJkZXN0IHBhcnQgb2YgUE1JQw0KZHJpdmVyIGRldmVsb3BtZW50
IC1fLTsNCg0KDQo=
