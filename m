Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 328202B5A19
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 08:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgKQHMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 02:12:22 -0500
Received: from mail-eopbgr80070.outbound.protection.outlook.com ([40.107.8.70]:60538
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726205AbgKQHMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 02:12:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7YKpWwSiR6WNIx4tDWPR6Md8yqTeWc+Z5tL6Qfy3rkG3oUMcAXimi6bKdZGYPuNrvd/ulJENEoCaU39gye/G1qqdIO3piO/nyY8vM+9++32MPfNQ9gDF4ASdIPz9vmbi3+S8zGRmRDqfnyMjo9XGSzQwATR/PJziLeRhqpry9UdtmoA/ohsqAG6B+J8I+Qbx7yelOTqvEyPVzT/NdnzXlVqLYiQDKg8lCmO6hTlweMPl7HNQKzrp5deZtpEpKSnM4dzpJOd08rUjtkiEx28648s1jbz8HtbG3DQLqnA2pZ650+MnCl4LncsIfCulXZN9ZK1a0ZWeNgZ66Ub3n3ZWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eiru8nDI7bNh3iCQGnk3i/XAq8ejbj4l3S8m/GblAnk=;
 b=kJoANhdBh0joURguz9DT3K2BPh7mowL1DNUggwb2yS4pDHDwWQN/nkMvxidta8Tz8urDNuHw7gKiyYX/nIcAgjp1aJtv0m89OOI5osQytt65fNaV5galhKThGrykBZsXU7tp0iiC2cMF2daPxdYKaSmKgASE6rT0TKq4wsF7O/EG4noMmftd92CVenqpSm7ZHeAIbCyHdHnVEPAXvKfAZZXotXfe2iE3IQEPm6bFhIemO7DrXZBJCmxQlAeiQOmjpVi1FAX+uTbfBrQBmJKIn/dGajRACmpu8twNn24Z/lGFiOGfpg04QLtxDVUd9rREyU87ibveTv5px6183GcSyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eiru8nDI7bNh3iCQGnk3i/XAq8ejbj4l3S8m/GblAnk=;
 b=AwFqG2I8tO1dvdtaZjPHxfaMij1Awx2RfHCrDAaKRkojpbTH0H2aUBJCFPpcSLlhVZHzNAXht6gVIQodIlaVvqIPIjLHUvqfmzggmGzcFQVYvEot7GI8gLSTZAAUVGS4eYqlem0AULiSCp2AU2+AQeiey9fLcxjstMjPg2rUD3o=
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM6PR04MB6263.eurprd04.prod.outlook.com (2603:10a6:20b:b8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Tue, 17 Nov
 2020 07:12:16 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::a968:d7c0:c9f8:b4db]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::a968:d7c0:c9f8:b4db%7]) with mapi id 15.20.3564.029; Tue, 17 Nov 2020
 07:12:16 +0000
From:   Alice Guo <alice.guo@nxp.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v3 1/4] dt-bindings: soc: imx8m: add DT Binding
 doc for soc unique ID
Thread-Topic: [EXT] Re: [PATCH v3 1/4] dt-bindings: soc: imx8m: add DT Binding
 doc for soc unique ID
Thread-Index: AQHWuayxOVgO/t1aJU2waONQ0YbJnKnH2OsAgAJ5pvCAAJ4PAIAA/ehA
Date:   Tue, 17 Nov 2020 07:12:16 +0000
Message-ID: <AM6PR04MB60532214E80F39DECB3AA615E2E20@AM6PR04MB6053.eurprd04.prod.outlook.com>
References: <20201113110409.13546-1-alice.guo@nxp.com>
 <20201114164936.GA32552@kozik-lap>
 <AM6PR04MB60530B6F577A2A05B173748EE2E30@AM6PR04MB6053.eurprd04.prod.outlook.com>
 <20201116160314.GA25108@kozik-lap>
In-Reply-To: <20201116160314.GA25108@kozik-lap>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fa18f4fc-1017-4a12-ae2c-08d88ac81d8b
x-ms-traffictypediagnostic: AM6PR04MB6263:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB6263DE69DF0FA3C4AFB158ECE2E20@AM6PR04MB6263.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:404;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8aDKOF/VMcAnFlkmI37UWXtLwPWr+fzfrtu+awiV+lP9KLVRy+KC8QCtP0xB+tSg3VDzvcDjtFOP9UGjlKIfpeWjuQhmATHcT/ZK4iETjgzV+893f2MPcUDEoRUOTCZW5ZT/6Dbz9V9uTY6EzQOclW4OjrHggGQQmFRR1B5+dAx31NedFaDdPliYCJwkxqTmmXnxonOQ5BRH0jlVl2HDsostgDdZWjy7ve9T4njRxumrsoov5LPWyUQ3K/vG2SAEEPNbea4Dlkzq9uxaowc4ZJSx+9EAJX4sV0mrmgZIiNfxe7Lis+P6yh1cSdk0PNRfkhcCJLQgE2Ym9WYNkMnCVK+mjxI5N2SVOHFXjcIlfBCtsCyfTV+pmXX9dTcbjXGZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(316002)(44832011)(54906003)(7696005)(66556008)(55016002)(9686003)(478600001)(186003)(86362001)(6506007)(53546011)(33656002)(26005)(52536014)(76116006)(66946007)(83380400001)(8936002)(66476007)(64756008)(2906002)(6916009)(8676002)(4326008)(5660300002)(66446008)(71200400001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: DyvYbqUgN/DTupsFSuGwTx4qDJPKrQMuARpFOczMcS/SrePU/9t97f7BQLpyoRr4MY+TWt+zl5HC92XJBe4nhBZCny3uduf/tQN4WYSYlubEb04qjoDY4ngBleoccXBuZ3fo4kelJsZOX3mqLwXNjMJG/FbVdftqVI36ND5ii9nqVdxMgEHOblASR/gLhOt88kjYq2/XyNbLicDYoi8bUouEz58aM3W2WTqnzES61oEvXEk6hU1r1ScWbGJg1XHrEeIhJM6Xac/PS4YvNp8+X/dRpE+8tpX0mMGVeJPexjkchAO8f5EG9nxGYV6zJnVL7w9NakDVSf6TdMToJObHHsoYaVz99y5MJCBq/kTQcGcyZH2hqefFsf41MEtMdnTQ0IJ2K3YEcNesFGEbNy+7irv7KATBKhKfVz5SHSatBYXKjx15zYLh4BQO2rCw/oDVb91zN1gTFQCqlpvNiaok+7pjSVGgycIdLJezNwoRSF10WMcOfAADUgfi5gMPnGLJ3PYVlSlvZSUZcNyfChVZTBQDkPWgtRD2waIHL3prX0fLya40+fL7ZgZUUWQ13XvAiMRm8i6z8IK6yw4XxhHH4VPxUY6bMOauAhsE7eZYst6toqEWOqobivtmlld3KdsW59M+/r1UW08QUVSiB5A33HD1JNW8aKnruzi/+NacRvnqcxBfWQFDKhwXi82FfrvjVQlMH87cxr+wIAc185UXfAdMpKPoDsXVO5R4ab05owZ6VZTso+zhdq04HlcMT8boSw4QTOxnrxM4SAk+VwCp364lPy1O3tsj/5AV1MqtMjW6QnExUPdP350g7GlLVsq1Xyd8ulWdIHiFVFsGfQQYFZf9gMdG2HiZX3kzOlKVlqtNVdHPyLhr69LpGAzopZS7IlOakqn3Lx7sf96mPKkNWg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa18f4fc-1017-4a12-ae2c-08d88ac81d8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2020 07:12:16.5251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GmvsHTLKqt+iz/43zuWmnS/OS6V4fB4n8F4ymDTnorjcbjZgSQc1+BHUCHeZVZ41rEP3C/pg4NteD4NuouX2Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6263
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiAyMDIw5bm0MTHmnIgxN+aXpSAwOjAzDQo+
IFRvOiBBbGljZSBHdW8gPGFsaWNlLmd1b0BueHAuY29tPg0KPiBDYzogcm9iaCtkdEBrZXJuZWwu
b3JnOyBzaGF3bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOw0KPiBkbC1s
aW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsgUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+
Ow0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IFN1YmplY3Q6
IFJlOiBbRVhUXSBSZTogW1BBVENIIHYzIDEvNF0gZHQtYmluZGluZ3M6IHNvYzogaW14OG06IGFk
ZCBEVCBCaW5kaW5nDQo+IGRvYyBmb3Igc29jIHVuaXF1ZSBJRA0KPiANCj4gQ2F1dGlvbjogRVhU
IEVtYWlsDQo+IA0KPiBPbiBNb24sIE5vdiAxNiwgMjAyMCBhdCAwNzowNDoxM0FNICswMDAwLCBB
bGljZSBHdW8gd3JvdGU6DQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
ID4gPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+DQo+ID4gPiBT
ZW50OiAyMDIw5bm0MTHmnIgxNeaXpSAwOjUwDQo+ID4gPiBUbzogQWxpY2UgR3VvIDxhbGljZS5n
dW9AbnhwLmNvbT4NCj4gPiA+IENjOiByb2JoK2R0QGtlcm5lbC5vcmc7IHNoYXduZ3VvQGtlcm5l
bC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7DQo+ID4gPiBkbC1saW51eC1pbXggPGxpbnV4
LWlteEBueHAuY29tPjsgUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+Ow0KPiA+ID4gZGV2aWNl
dHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4g
PiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gPiA+IFN1YmplY3Q6IFtF
WFRdIFJlOiBbUEFUQ0ggdjMgMS80XSBkdC1iaW5kaW5nczogc29jOiBpbXg4bTogYWRkIERUDQo+
ID4gPiBCaW5kaW5nIGRvYyBmb3Igc29jIHVuaXF1ZSBJRA0KPiA+ID4NCj4gPiA+IENhdXRpb246
IEVYVCBFbWFpbA0KPiA+ID4NCj4gPiA+IE9uIEZyaSwgTm92IDEzLCAyMDIwIGF0IDA3OjA0OjA2
UE0gKzA4MDAsIEFsaWNlIEd1byB3cm90ZToNCj4gPiA+ID4gQWRkIERUIEJpbmRpbmcgZG9jIGZv
ciB0aGUgVW5pcXVlIElEIG9mIGkuTVggOE0gc2VyaWVzLg0KPiA+ID4gPg0KPiA+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBBbGljZSBHdW8gPGFsaWNlLmd1b0BueHAuY29tPg0KPiA+ID4gPiAtLS0NCj4g
PiA+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mc2wueWFtbCAgICAgICAgICB8IDI1
DQo+ID4gPiArKysrKysrKysrKysrKysrKysrDQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjUg
aW5zZXJ0aW9ucygrKQ0KPiA+ID4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mc2wueWFtbA0KPiA+ID4gPiBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnNsLnlhbWwNCj4gPiA+ID4gaW5kZXggZTRkYjBm
OWVkNjY0Li5mNGZhZWJiYjU3ZGEgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnNsLnlhbWwNCj4gPiA+ID4gKysrIGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mc2wueWFtbA0KPiA+ID4gPiBAQCAtOTAxLDYg
KzkwMSwzMSBAQCBwcm9wZXJ0aWVzOg0KPiA+ID4gPiAgICAgICAgICAgICAgICAtIGZzbCxzMzJ2
MjM0LWV2YiAgICAgICAgICAgIyBTMzJWMjM0LUVWQjINCj4gQ3VzdG9tZXINCj4gPiA+IEV2YWx1
YXRpb24gQm9hcmQNCj4gPiA+ID4gICAgICAgICAgICAtIGNvbnN0OiBmc2wsczMydjIzNA0KPiA+
ID4gPg0KPiA+ID4gPiArICBzb2M6DQo+ID4gPiA+ICsgICAgdHlwZTogb2JqZWN0DQo+ID4gPiA+
ICsgICAgcHJvcGVydGllczoNCj4gPiA+ID4gKyAgICAgIGNvbXBhdGlibGU6DQo+ID4gPiA+ICsg
ICAgICAgIG9uZU9mOg0KPiA+ID4gPiArICAgICAgICAgIC0gZGVzY3JpcHRpb246IGkuTVg4TSBT
b0NzDQo+ID4gPiA+ICsgICAgICAgICAgICBpdGVtczoNCj4gPiA+ID4gKyAgICAgICAgICAgICAg
LSBlbnVtOg0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgLSBmc2wsaW14OG1tLXNvYw0KPiA+
ID4gPiArICAgICAgICAgICAgICAgICAgLSBmc2wsaW14OG1uLXNvYw0KPiA+ID4gPiArICAgICAg
ICAgICAgICAgICAgLSBmc2wsaW14OG1wLXNvYw0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAg
LSBmc2wsaW14OG1xLXNvYw0KPiA+ID4gPiArICAgICAgICAgICAgICAtIGNvbnN0OiBzaW1wbGUt
YnVzDQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgICAgICAtIGRlc2NyaXB0aW9uOiBPdGhlciBT
b0NzDQo+ID4gPiA+ICsgICAgICAgICAgICBpdGVtczoNCj4gPiA+ID4gKyAgICAgICAgICAgICAg
LSBjb25zdDogc2ltcGxlLWJ1cw0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAgICBudm1lbS1jZWxs
czoNCj4gPiA+ID4gKyAgICAgICAgbWF4SXRlbXM6IDENCj4gPiA+ID4gKyAgICAgICAgZGVzY3Jp
cHRpb246IFBoYW5kbGUgdG8gdGhlIFNPQyBVbmlxdWUgSUQgcHJvdmlkZWQgYnkgYQ0KPiA+ID4g
PiArIG52bWVtIG5vZGUNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgbnZtZW0tY2VsbHMtbmFt
ZXM6DQo+ID4gPiA+ICsgICAgICAgIGNvbnN0OiBzb2NfdW5pcXVlX2lkDQo+ID4gPiA+ICsNCj4g
PiA+ID4gIGFkZGl0aW9uYWxQcm9wZXJ0aWVzOiB0cnVlDQo+ID4gPg0KPiA+ID4gVGhlICJzb2Mi
IG5vZGUgc2hvdWxkIGJlIHJlcXVpcmVkIGZvciB0aGVzZSBjb21wYXRpYmxlcy4gT3RoZXJ3aXNl
DQo+ID4gPiB5b3Ugd2lsbCBoYXZlIHRvIHN0YXkgd2l0aCB0aGlzDQo+ID4gPiBiYWNrd2FyZHMt
Y29tcGF0aWJsZS1EVEItZGV2aWNlLWluaXRjYWxsLWdsdWUgZm9yIG1hbnkgeWVhcnMuLi4gSSB0
aGluayB5b3UNCj4gY2FuIGFjaGlldmUgaXQgd2l0aCBhbGxPZi4NCj4gPiA+DQo+ID4gW0FsaWNl
IEd1b11IaSwNCj4gPiBJIGZpbmQgdGhhdCBteSBkZXNjcmlwdGlvbiBmb3IgY29tcGF0aWJsZSBp
cyBhbWJpZ3VvdXMuIFRoZXJlIGFyZSB0d28ga2luZHMgb2YNCj4gY29tcGF0aWJsZSBvZiB0aGUg
InNvYyIgbm9kZToNCj4gPiAxLiBGb3IgZHRzaSBmaWxlcyB1c2VkIGZvciBTb0NzIG90aGVyIHRo
YW4gaW14OG0gc2VyaWVzIFNvQ3MgYW5kIG9sZA0KPiA+IHZlcnNpb24gZHRzaSBmaWxlcyB1c2Vk
IGZvciBpbXg4bSBzZXJpZXMgU29DcywgY29tcGF0aWJsZSBvZiB0aGUgInNvYyIgbm9kZSBpcw0K
PiAic2ltcGxlLWJ1cyIuDQo+ID4gMi4gRm9yIG5ldyB2ZXJzaW9uIGR0c2kgZmlsZXMgdXNlZCBm
b3IgaW14OG0gc2VyaWVzIFNvQ3MsIGNvbXBhdGlibGUgb2YgdGhlDQo+ICJzb2MiIG5vZGUgaXMg
eyJmc2wsaW14OG1YLXNvYyIsInNpbXBsZS1idXMifS4NCj4gPg0KPiA+ICJudm1lbS1jZWxsIiBp
cyBhbiBvcHRpb25hbCBwcm9wZXJ0eS4NCj4gPg0KPiA+IEkgZG8gbm90IHVuZGVyc3RhbmQgd2hh
dCB5b3UgbWVhbi4gWW91IG1lYW4gdGhhdCBsaW1pdCB0aGUgY29tcGF0aWJsZSBvZg0KPiAic29j
IiBub2RlIG11c3QgaW5jbHVkZSAiIGZzbCxpbXg4bVgtc29jIiBpbiBuZXcgdmVyc2lvbiBkdHMg
ZmlsZXMuIElzIG15DQo+IHVuZGVyc3RhbmRpbmcgY29ycmVjdD8NCj4gDQo+IEFsbCBuZXcgRFRT
IGZpbGVzIHNob3VsZCBoYXZlIHNvYyBub2RlIHdpdGggImZzbCxpbXg4bVgtc29jIiBhbmQgdGhp
cyBzaG91bGQgYmUNCj4gcmVxdWlyZWQgYnkgZHRzY2hlbWEuIFRoZSBudm1lbS1jZWxscyBhbmQg
cmVsYXRlZCBwcm9wZXJ0aWVzIGRvIG5vdCBsb29rIGxpa2UNCj4gb3B0aW9uYWwuIEZyb20gdGhl
IGhhcmR3YXJlIHBlcnNwZWN0aXZlIC0gdGhleSBhcmUgYWx3YXlzIHByZXNlbnQuIEZyb20gdGhl
DQo+IGRyaXZlciBwb2ludCBvZiB2aWV3OiB0aGV5IGFyZSByZXF1aXJlZCBhbmQgZHJpdmVyIHdp
bGwgZmFpbCB0byB3b3JrLg0KDQpbQWxpY2UgR3VvXSANCltBbGljZSBHdW9dIA0KKyAgc29jOg0K
KyAgICB0eXBlOiBvYmplY3QNCisgICAgcHJvcGVydGllczoNCisgICAgICBjb21wYXRpYmxlOg0K
KyAgICAgICAgb25lT2Y6DQorICAgICAgICAgIC0gZGVzY3JpcHRpb246IG5ldyB2ZXJzaW9uIERU
UyBmb3IgaS5NWDhNIFNvQ3MNCisgICAgICAgICAgICBpdGVtczoNCisgICAgICAgICAgICAgIC0g
ZW51bToNCisgICAgICAgICAgICAgICAgICAtIGZzbCxpbXg4bW0tc29jDQorICAgICAgICAgICAg
ICAgICAgLSBmc2wsaW14OG1uLXNvYw0KKyAgICAgICAgICAgICAgICAgIC0gZnNsLGlteDhtcC1z
b2MNCisgICAgICAgICAgICAgICAgICAtIGZzbCxpbXg4bXEtc29jDQorICAgICAgICAgICAgICAt
IGNvbnN0OiBzaW1wbGUtYnVzDQorDQorICAgICAgICAgIC0gZGVzY3JpcHRpb246IG90aGVyIFNv
Q3MgYW5kIG9sZCB2ZXJzaW9uIERUUyBmb3IgaS5NWDhNIFNvQ3MNCisgICAgICAgICAgICBpdGVt
czoNCisgICAgICAgICAgICAgIC0gY29uc3Q6IHNpbXBsZS1idXMNCisNCisgICAgICBudm1lbS1j
ZWxsczoNCisgICAgICAgIG1heEl0ZW1zOiAxDQorICAgICAgICBkZXNjcmlwdGlvbjogUGhhbmRs
ZSB0byB0aGUgU09DIFVuaXF1ZSBJRCBwcm92aWRlZCBieSBhIG52bWVtIA0KKyBub2RlDQorDQor
ICAgICAgbnZtZW0tY2VsbHMtbmFtZXM6DQorICAgICAgICBjb25zdDogc29jX3VuaXF1ZV9pZA0K
Kw0KKyAgICBhbGxPZjoNCisgICAgICAtIGlmOg0KKyAgICAgICAgICBwcm9wZXJ0aWVzOg0KKyAg
ICAgICAgICAgIGNvbXBhdGlibGU6DQorICAgICAgICAgICAgICBjb250YWluczoNCisgICAgICAg
ICAgICAgICAgZW51bToNCisgICAgICAgICAgICAgICAgICAtIGZzbCxpbXg4bW0tc29jDQorICAg
ICAgICAgICAgICAgICAgLSBmc2wsaW14OG1uLXNvYw0KKyAgICAgICAgICAgICAgICAgIC0gZnNs
LGlteDhtcC1zb2MNCisgICAgICAgICAgICAgICAgICAtIGZzbCxpbXg4bXEtc29jDQorICAgICAg
ICAgICAgICAgIGNvbnN0OiBzaW1wbGUtYnVzDQorDQorICAgICAgICB0aGVuOg0KKyAgICAgICAg
ICByZXF1aXJlZDoNCisgICAgICAgICAgICAtIG52bWVtLWNlbGxzDQorICAgICAgICAgICAgLSBu
dm1lbS1jZWxscy1uYW1lcw0KDQpUaGUgYWJvdmUgaXMgbXkgbW9kaWZpY2F0aW9uLiBJcyB0aGF0
IG9rPw0KDQpCZXN0IHJlZ2FyZHMsDQpBbGljZQ0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRv
Zg0KDQo=
