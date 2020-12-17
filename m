Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8F9D2DD2F1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 15:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbgLQOWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 09:22:38 -0500
Received: from mail-eopbgr10073.outbound.protection.outlook.com ([40.107.1.73]:16329
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727185AbgLQOWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 09:22:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eyAaZmElUY0BFusunfjZWGu2xj648RtxKkF6FDcOkXzcPugJAqhfH49eYL38qaZh9GuRLzBB6DHexJ2bUjno1qMBeMka/drvVFNgnIb7iNgPY5jFfB0gtBR3nXFA3FK8j1IIbs3JMlsPIv6o1gMYl2yYZoKRO58AkVAUWVnNtVdNy//4YflVgI4dyzNhkLzXruIlefGDJHg7lg3xXzbupPXJuWlj2vInCQhrRYxB8xiivmAoQyCPQoDzFYKJpn7eyoDpB99ncyM/GbbgDXiOVmTSoVD7m/iBxX7gIcO7YBmQylA+JBJgT0XCJFyh4nVqIICeoi1GF2oyTMR/jIsjpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mz7umr91cEhUwK5abT/GPv6OJ/JA3O685iYBeE5AxsA=;
 b=NkIPMIu4AD+yco0FxS6Napb3Gp4gkhB7l0TP7RScwA8wUrJ6sf9jgj/lT7nADnbZNSQjVZtnd8L+y3IWGUl/Mvj9qTsqm5nhER7dP4lLBDRKevjsdA43bu5VJMhJ2LBarqEngBqlwkZPR0jLEkqU/hOsefDmhH4oXNcO0xHTHAX2GrzzAPVS7UYSh3uAUo+7gh1qrQo4/pY2iaJ1JqjAuHPHMZkbBNp1yPXNQKEbV0j8QPkdyNsmWwJQi+QHpO9KsSEYOZ5EF2s6DLDbkoQ4I64EKU3dt+E1AI7kvY65GTzqN1kw/lUbNARDqNU8cRj/I3oONdUu3ScKjc/ZyFcoNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mz7umr91cEhUwK5abT/GPv6OJ/JA3O685iYBeE5AxsA=;
 b=OU7ZJIr4ptKL0jij6dqrx+uqIxseKXRvjqvngAZuz5kMmdcnmPSYVfJcqArZFXEKfd5WSnOPWfH2ZBXYgdfCMfrkVKNrbfZgtYJLAf78jB1sTOi1cEAxSrfpg+5hO4QQO2P1ytWGepQpOyDoufW3wzdjY7l5uc3d1DrCoEeCjus=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR0302MB2809.eurprd03.prod.outlook.com (2603:10a6:3:f1::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12; Thu, 17 Dec 2020 14:21:47 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::f1f1:eb1d:2bf5:eb87]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::f1f1:eb1d:2bf5:eb87%7]) with mapi id 15.20.3676.025; Thu, 17 Dec 2020
 14:21:47 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "guido.gunther@puri.sm" <guido.gunther@puri.sm>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        linux-power <linux-power@fi.rohmeurope.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "angus.ainslie@puri.sm" <angus.ainslie@puri.sm>
Subject: Re: [PATCH 1/1] regulators: bd718x7: Add enable times
Thread-Topic: [PATCH 1/1] regulators: bd718x7: Add enable times
Thread-Index: AQHW05tyoY0RX9paika1ZtaJVmaczqn5psMAgAADl4CAAa5VAA==
Date:   Thu, 17 Dec 2020 14:21:46 +0000
Message-ID: <beba25e85db20649aa040fc0ae549895c9265f6f.camel@fi.rohmeurope.com>
References: <cover.1608116704.git.agx@sigxcpu.org>
         <d2b3d053d28ea0f35e7526b523287358c8fe20c2.1608116704.git.agx@sigxcpu.org>
         <7d4903f67ff81a9a749e75f24af0aea903213c43.camel@fi.rohmeurope.com>
         <20201216124133.GA31109@bogon.m.sigxcpu.org>
In-Reply-To: <20201216124133.GA31109@bogon.m.sigxcpu.org>
Reply-To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: puri.sm; dkim=none (message not signed)
 header.d=none;puri.sm; dmarc=none action=none header.from=fi.rohmeurope.com;
x-originating-ip: [62.78.225.252]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 11d51a1f-c8e0-4972-a034-08d8a297164e
x-ms-traffictypediagnostic: HE1PR0302MB2809:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HE1PR0302MB280943EB991BEB65970ABC75ADC40@HE1PR0302MB2809.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RqdRt6W+psoxjZvIRp7JjJag3Me1/S0lGCervDK/3Y2nj9maB/C3bYUAw2Zam3zLi+KUcysriVl1IAvzgWjywOJ5Uo0WmHF2A3motUN3Am8f/1Fa9dhjlRiT4rm8xVURQER+cA8iDSgW7xmLSXqwLgqZir8m7JaqT2psy4yedP2mWnMjJfYihPIkFyLux+zd8UE95OvQmU9I31mg6P54N3x3DOOWfXnCIeGq7fB1ctG7hXAc2g7ffGks30LifTZoKTHhWos43m7B4QCjopaTlRYMT3uJw+F9uuUdtOTHS3WJrc3zmUbddhuMbrkgMTR2OEc+QAoE/hxXdbAdxFjlxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39830400003)(366004)(376002)(136003)(346002)(66476007)(54906003)(6486002)(186003)(4001150100001)(5660300002)(83380400001)(6916009)(3450700001)(2616005)(4326008)(316002)(2906002)(26005)(64756008)(6512007)(8676002)(8936002)(71200400001)(66574015)(66556008)(76116006)(478600001)(86362001)(66446008)(66946007)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dm41bjZkYjVEV21kWUpadFpiYTRkR3JYSVVIWUdQMkxPemdqOEN5YmJ5eldT?=
 =?utf-8?B?WHUxcEQwUEdZYi9pUXRvQzBWRkxveURQNURNZnVIS1huZUFrb0NVUWZxNDFa?=
 =?utf-8?B?SXplaUV4L0RIQzl3czQrc2VWNHpYVFNOV3crMnVPUDB1Wms3RG01bERLbTNq?=
 =?utf-8?B?blBFck1xM1B6YXc3TlVZTXB5V2x2VDVmck5WekVmQmUwM1lhSytIaUtNWURk?=
 =?utf-8?B?UDhJM1VpNmIwaTYvMm0vNFJ3SUkzN2JDeHhzdlA4WFBnS0NPMzJVbUxMR0Nm?=
 =?utf-8?B?aW5sclZoZzByMW9OMDZRSm1UTURjSG9Hei9xMjFMR0JBcXhNQUx0Umc4QnJ4?=
 =?utf-8?B?aXE0QTZrOEprci9aQml5YVBRL2dmcFZDOGpTaCtXMGZmTmQ2OWhiWkJCbWNT?=
 =?utf-8?B?SWVxV2wvUFM5dlExUlJkc1ZXZU5Sd1JLL2hReW0zSFpwMm5HMnA3dDNhajRG?=
 =?utf-8?B?UjRxZ1crRi92S0pNNHhHLzllQmxFcHE3MkJmaUxIajRHV3RnZlB4QVlFMXBX?=
 =?utf-8?B?YVFOaUNEcHBXM0g4VzVUSkg4R2sxSm84aDhaQ3JWTU5XSk5yeklyOHRBN1VC?=
 =?utf-8?B?aUMxWVErTjB3YlVkeXRUdlNzWlc3SnpscEMyYmp6YUZNaHRqSFV1SkV1c3dj?=
 =?utf-8?B?a3RZNGtDY3dRTHVuZkZhb0FydzJrV1ZZQ0d3THlKeGZXdEc1RzZMZDRzeThL?=
 =?utf-8?B?L0hsSnRFYlpkWVNYamIwc2JTRXJUd0RTWTU0bmVFeVk4OUFTSTFhcVZZa2hS?=
 =?utf-8?B?c2JsbEZ5K2JTRkRVRnFjVW9MeWxTNWdqWlNVdHVwOGNRRmtZZ2l2elVXcW92?=
 =?utf-8?B?U21NUkRaTGRwVGg1RGpMVkU1VWpNRjZZUGFZWnJJMUtKbWVLc1Q3d1J6bDAw?=
 =?utf-8?B?TGQ0dGNWTUg4MmRrU3E3Vkg0Z29rOVN3VS9OVzhrUWlQU2UvY2NQdTkxVGlv?=
 =?utf-8?B?ckw5VlJQeklhVEk3SXFxZlZpNTg3M1JyTkdBelBNRU1lR2VOcmxnZzdMUWZL?=
 =?utf-8?B?dElnRjBLUjhpMVJzUG5Qa0ZjV1VOWnhUUUZaMDRjOC90a3FaVHdmVFZjWDd5?=
 =?utf-8?B?am42cEg4bGFwUE1SU2x5RUY4cUJ1MEwwRDhtc21heEE1ME1ibzBXWmZqYjE1?=
 =?utf-8?B?VUZuUHY0UFFTeDB2eHVtSXFsRkFCZm53ZVRXcUZRYURwSGVHUjVzNVZJVWV2?=
 =?utf-8?B?N3h3ZzZOMWRHa0xVMHpwY0VFS2k0czUrd2VyVmhiajVhVGZOY2xZYlZVNk9T?=
 =?utf-8?B?R052SHZJU0p6L2NXVk1Qa3NmdUVGamlmcmFDaGV1RUF5QW9HeHdzMmlhRDl6?=
 =?utf-8?Q?NgMu8ri6q6YVa5qkDNHbq4adxmIFBpOAtq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EBC4E5B6C98F3C4C81345C942420C18A@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d51a1f-c8e0-4972-a034-08d8a297164e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2020 14:21:46.9908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9nUInMUmEqlKCxY9JkABgwYZZBW58ljPxHPcdgmMJWHO4dHSxzH3qg/aKKHe9mCRvG8jHAhFNPvoQ695MGUvGA6l7cZqNmWhWcZlawSEmSDgSeuh1J7NkCYzgT3XxEMa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0302MB2809
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBXZWQsIDIwMjAtMTItMTYgYXQgMTM6NDEgKzAxMDAsIEd1aWRvIEfDvG50aGVyIHdyb3Rl
Og0KPiBIaSBNYXR0aSwNCj4gT24gV2VkLCBEZWMgMTYsIDIwMjAgYXQgMTI6Mjk6MjBQTSArMDAw
MCwgVmFpdHRpbmVuLCBNYXR0aSB3cm90ZToNCj4gPiBIZWxsbyBHdWlkbywNCj4gPiANCj4gPiBU
aGFua3MgZm9yIGxvb2tpbmcgYXQgdGhpcyENCj4gPiANCj4gPiBPbiBXZWQsIDIwMjAtMTItMTYg
YXQgMTI6MDUgKzAxMDAsIEd1aWRvIEfDvG50aGVyIHdyb3RlOg0KPiA+ID4gVXNlIHRoZSB0eXBp
Y2FsIHN0YXJ0dXAgdGltZXMgZnJvbSB0aGUgZGF0YSBzaGVldCBzbyBib2FyZHMgZ2V0IGENCj4g
PiA+IHJlYXNvbmFibGUgZGVmYXVsdC4gTm90IHNldHRpbmcgYW55IGVuYWJsZSB0aW1lIGNhbiBs
ZWFkIHRvIGJvYXJkDQo+ID4gPiBoYW5ncw0KPiA+ID4gd2hlbiBlLmcuIGNsb2NrcyBhcmUgZW5h
YmxlZCB0b28gc29vbiBhZnRlcndhcmRzLg0KPiA+ID4gDQo+ID4gPiBUaGlzIGZpeGVzIGdwdSBw
b3dlciBkb21haW4gcmVzdW1lIG9uIHRoZSBMaWJyZW0gNS4NCj4gPiA+IA0KPiA+ID4gU2lnbmVk
LW9mZi1ieTogR3VpZG8gR8O8bnRoZXIgPGFneEBzaWd4Y3B1Lm9yZz4NCj4gPiA+IC0tLQ0KPiA+
ID4gIGRyaXZlcnMvcmVndWxhdG9yL2JkNzE4eDctcmVndWxhdG9yLmMgfCAyNw0KPiA+ID4gKysr
KysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDI3IGluc2Vy
dGlvbnMoKykNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcmVndWxhdG9yL2Jk
NzE4eDctcmVndWxhdG9yLmMNCj4gPiA+IGIvZHJpdmVycy9yZWd1bGF0b3IvYmQ3MTh4Ny1yZWd1
bGF0b3IuYw0KPiA+ID4gaW5kZXggZTZkNWQ5OGMzY2VhLi5kNmQzNGFhNGVlMmUgMTAwNjQ0DQo+
ID4gPiAtLS0gYS9kcml2ZXJzL3JlZ3VsYXRvci9iZDcxOHg3LXJlZ3VsYXRvci5jDQo+ID4gPiAr
KysgYi9kcml2ZXJzL3JlZ3VsYXRvci9iZDcxOHg3LXJlZ3VsYXRvci5jDQo+ID4gPiBAQCAtNjEz
LDYgKzYxMyw3IEBAIHN0YXRpYyBzdHJ1Y3QgYmQ3MTh4eF9yZWd1bGF0b3JfZGF0YQ0KPiA+ID4g
YmQ3MTg0N19yZWd1bGF0b3JzW10gPSB7DQo+ID4gPiAgCQkJLnZzZWxfbWFzayA9IERWU19CVUNL
X1JVTl9NQVNLLA0KPiA+ID4gIAkJCS5lbmFibGVfcmVnID0gQkQ3MThYWF9SRUdfQlVDSzFfQ1RS
TCwNCj4gPiA+ICAJCQkuZW5hYmxlX21hc2sgPSBCRDcxOFhYX0JVQ0tfRU4sDQo+ID4gPiArCQkJ
LmVuYWJsZV90aW1lID0gMTQ0LA0KPiA+IA0KPiA+IFdoZXJlIGFyZSB0aGVzZSB2YWx1ZXMgb2J0
YWluZWQgZnJvbT8gSSBoYXZlIGEgZmVlbGluZyB0aGV5IG1pZ2h0DQo+ID4gYmUNCj4gPiBib2Fy
ZCAvIGxvYWQgc3BlY2lmaWMuIElmIHRoaXMgaXMgdGhlIGNhc2UgLSBjYW4gdGhlICJyZWd1bGF0
b3ItDQo+ID4gZW5hYmxlLQ0KPiA+IHJhbXAtZGVsYXkiIGZyb20gZGV2aWNlLXRyZWUgYmUgdXNl
ZCBpbnN0ZWFkIHRvIGF2b2lkIGhhcmQtY29kaW5nDQo+ID4gYm9hcmQNCj4gPiBzcGVjaWZpYyB2
YWx1ZXMgaW4gdGhlIGRyaXZlcj8gQWx0aG91Z2gsIHNhbmUgZGVmYXVsdHMgd291bGQNCj4gPiBw
cm9iYWJseQ0KPiA+IG5vdCBiZSBhIGJhZCBpZGVhIC0gaWYgSSByZWFkIGNvZGUgY29ycmVjdGx5
IHRoZW4gdGhlIGNvbnN0cmFpbnMNCj4gPiBmcm9tDQo+ID4gRFQgY2FuIGJlIHVzZWQgdG8gb3Zl
cnJpZGUgdGhlc2UgdmFsdWVzLg0KPiANCj4gVGhleSdyZSB0aGUgJ3R5cGljYWwgdmFsdWVzJyBm
cm9tIHRoZSBkYXRhIHNoZWV0IGFuZCBpdCdzIGJhc2ljYWxseQ0KPiBhbGwNCj4gYWJvdXQgc2V0
dGluZyBhIGRlZmF1bHQgZm9yICJyZWd1bGF0b3ItZW5hYmxlLXJhbXAtZGVsYXkiIHRvIGF2b2lk
DQo+IGhhdmluZyBldmVyeSBib2FyZCBkbyB0aGUgc2FtZS4gSWYgdGhhdCdzIG5vdCB0aGUgcmln
aHQgdGhpbmcgdG9kbw0KPiBsZXQNCj4gbWUga25vdyBhbmQgaSBhZGQgdGhlc2UgdG8gZWFjaCBv
ZiBvdXIgYm9hcmRzICh3aGljaCBpcyB3aGVyZSBpDQo+IGJhc2ljYWxseSBzdGFydGVkIGZyb20g
YnV0IHRoZW4gZmlndXJlZCB0aGF0IHRoaXMgd291bGQgYmUgYnVzeXdvcmsNCj4gYW5kIGV2ZXJ5
IGJvYXJkIHdvdWxkIGhpdCB0aGF0IHByb2JsZW0pLg0KPiANCj4gPiBJJ2QgcHJlZmVyIHdlbGwg
bmFtZWQgZGVmaW5lcyBvdmVyIHJhdyBudW1lcmljIHZhbHVlcyB0aG91Z2guDQo+IA0KPiBTbyBz
LnRoLiBsaWtlDQo+IA0KPiBCRDcxODM3X0JVQ0sxX1NUQVJUVVBfVElNRSAxNDQNCj4gDQo+ICh1
c2luZyB0aGUgdGVybWlub2xvZ3kgZnJvbSB0aGUgZGF0YXNoZWV0KT8gSWYgdGhhdCB3b3JrcyBJ
J2xsIHNlbmQgYQ0KPiB2Mi4NCg0KSnVzdCBub3RpY2VkIEkgbmV2ZXIgcmVwbGllZC4gU29ycnku
IFRoaXMgbG9va3MgZ29vZCB0byBtZSENCg0KQmVzdCBSZWdhcmRzDQogIC0tTWF0dGkNCg==
