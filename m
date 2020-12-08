Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10592D215E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 04:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbgLHDRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 22:17:32 -0500
Received: from mail-eopbgr150050.outbound.protection.outlook.com ([40.107.15.50]:20742
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726584AbgLHDRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 22:17:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UcNc9JOuWwil4Qvj9b94jcpd3wzKtVD9s3ScMkrPWwGxtJwjLL3CMePl2BztV1JsQPE3cDeN71N7+SOjA1TZyxg/6xPd4grDt9gpFunA8wENvHkocP8dEcjdaMwnbEdeoQtwVWysEiFF9rgC1sbI8C2cWwEhc3S9DVDZi8WHOdLSn8V21EDfzQ/vwCAQbsRi4vWSV70Tc1LNVhB62IM9hs9pwm7GFgjHpJqG/lCuy0YDP+GPd/NzzJ6vEvGz3ciK0j0rh7h1NQ2V/oZIvNcRsr8Us8K6vdpuPZ/Am79x5CsB83e3JzhuWoE47k2ErXSj28daRsIUsYAoTjwUCXoHfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMWG6bMIHk7ycboKEXLJLXFaOPElskgwEKf8CPZs+ew=;
 b=JlTSU1p6EgNpj8cXcOS9BLQVt/pNzySy/rlZSA8/2KnRl6vc7T/aTnKJUloidnEC3n6/6eCaM06D79e3tkJ+AMjzpM657Y0dhrZTSMPJSTowpgPLdQHm9dQqBPkhSCOEDFU1j2kM53HGOizKqXSziEwdqS/XcMpBN/pmbnGeqyMRt0bAtMb7dxyTfCQVUBagiBS0z2VnI+wXzA8+GRCEDbcnNCeb/y+u4ujDrNXHDehsxrzsBvamL5Y6noP5NPuOMpoBJ7yz6Zx3XLW61s0qCRh44r+eS3B9IlH7wkABrDLhVHKYiMUb6uUoF0gGKPsVXGNGmGtxBaouZ924OGCapA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMWG6bMIHk7ycboKEXLJLXFaOPElskgwEKf8CPZs+ew=;
 b=a24DKcjQlKfgKNZxGZfL0CdFUfXyXEqZfCZUcz8sf0L5DQhym4io/i0k1EX1G3ddIpPMj292K/5Qf/ipN0gGLlWi1NqvnN585jSEgt5eUZmhhTHkYJY0ZHglRDFKRSNJoOiSWVKvC8Uqr7MT84zS5PyoSXPNySaeCjmhH4F2BNk=
Received: from VI1PR0402MB3342.eurprd04.prod.outlook.com
 (2603:10a6:803:11::14) by VI1PR0402MB3504.eurprd04.prod.outlook.com
 (2603:10a6:803:8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.23; Tue, 8 Dec
 2020 03:16:35 +0000
Received: from VI1PR0402MB3342.eurprd04.prod.outlook.com
 ([fe80::4b3:7c0c:654c:7a61]) by VI1PR0402MB3342.eurprd04.prod.outlook.com
 ([fe80::4b3:7c0c:654c:7a61%6]) with mapi id 15.20.3632.023; Tue, 8 Dec 2020
 03:16:35 +0000
From:   "S.j. Wang" <shengjiu.wang@nxp.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: imx8mn: Fix duplicate node name
Thread-Topic: [PATCH] arm64: dts: imx8mn: Fix duplicate node name
Thread-Index: AdbNCU8grwTh+rdtR+OFS5nTKvvqnA==
Date:   Tue, 8 Dec 2020 03:16:35 +0000
Message-ID: <VI1PR0402MB334290B621E8C02EA852A6E9E3CD0@VI1PR0402MB3342.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 730f8950-0240-4cce-06b8-08d89b27ab78
x-ms-traffictypediagnostic: VI1PR0402MB3504:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB3504B553D5A9B259C0774EE2E3CD0@VI1PR0402MB3504.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qouIj2boSg/byDOzgeB5O6wcrLbA4O5Xp3zer/efixScFxaJUuO0SrvqVZDG9y2Ik/avE7wAav4ZYkbb1u5ujmCxWB1LfudS9gncb0hGLczwPKV9jctbC45+QzF54y9MvRR3JWrqZbeP14jRJfkhKTS3bAuFSDwfsSPQyj6+U4mtJimNQHljbdNWWtFFkBympfFaWKji9BHOilyRQU7lbgrMtKuW6CiezCOGzzDGSK8z8dBUmIlKw7AArPUbp/3btb+nlGJw+KrDIpEsWCARSat3SBhAgeO2flxEROYPbTvqE0sQlpqf1NFceAUW28MEJG1aEQcWpGHNXmtns3GfJjKZkO7NHrou8myuod6+Xe+DujraBj4sZq6sYG06XN+Q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3342.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(366004)(66476007)(66946007)(186003)(55016002)(6506007)(54906003)(2906002)(86362001)(6916009)(83380400001)(33656002)(9686003)(26005)(64756008)(8936002)(5660300002)(508600001)(4326008)(76116006)(71200400001)(8676002)(66556008)(7696005)(52536014)(66446008)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Z2g5VUZIaCtiSGZiR1pqbWcySTk3aUFvbUI1L29ZMW91R3FTSnIzSFF3Nm9t?=
 =?utf-8?B?WnFpd0g1KyswOE1sWm1GNnNNZExzV0xha3ZmalhKanpwTmh4cjJlaFk0Rnp2?=
 =?utf-8?B?Y0xrL24wRWZ3UnZLQUk1NXhhZHpja2RFVVZkNVd0SlJTK2VxNDRnWE9tZ1lF?=
 =?utf-8?B?NWNXZFFyTC9sTjFJaUU2VkRwdjFCTzcrVG02bzhhWTB6SmJqU3QzMTdObXpz?=
 =?utf-8?B?S3hxMzg4OFRsM0ZFUFlLbklkSWU4VlNvVUNveEFaMVl5L3BQWU52Y0s2YlUr?=
 =?utf-8?B?dXhjNFNhZzVOQS84ZS9EbzJWUzN6L2dTZkNRQ0V5dUpnWkhEdEFUZ1pNK2Vv?=
 =?utf-8?B?RmllNnQ1cXBXZ1R5QnRWSUdTcEJLOFl0UjBlSWt4SnFYSG1nWGpGNzJueUE2?=
 =?utf-8?B?VDZJT1pvalJTaHpncWpLOHNGWjl0VUFqWHp4VWVSSHpDK01nS0lQdU83dzRU?=
 =?utf-8?B?MmY0SWl5cC81U1lYRTBLMTR3SjF4NDhaZkRTSEowYlJDVEdzTm1kWVg2LzFp?=
 =?utf-8?B?MVZGSnNWMnA2a3FIM1ArMFZyMFM3c21uL2ZZdlRTS2x1em9GZ3NwS3FWR3A4?=
 =?utf-8?B?VmpOVjh0RXZDcUt1NzR2OGJOVDVCTm9xTHlIZXdJYm03c0R3RGZ6YWZSR01M?=
 =?utf-8?B?N21SZXJmK1FwaTVKWUtXOGM5SjNCNTh4dnFNNzVnZW01cWc0dFdJUk5TUGZq?=
 =?utf-8?B?dnNGWUk0WklPSDNvMTBaL2praE5XTGJiNkw4Zkc0K0NsNmRRaDhzeXRTRllF?=
 =?utf-8?B?RnhoamdkcG1sTXlqOTMyZ3JSWVJtWlhITmtuaFUyVFkvM2FsMVBCeC9lUVZv?=
 =?utf-8?B?aWxlTUJjZWtvMkRZMDJzRG00cnZyci8zLzN6blBIRE9aWGcvdjg0S1BsYzNm?=
 =?utf-8?B?aFZrVTN6RGVuYUtpdzNYay95TzZlaFJPaEZsNkRUb09MN09tcXNVbCtybUlJ?=
 =?utf-8?B?Wks3dHRTQjNacHNXb0d5a1RUSkE2ME5pdjZONTZlZXdIdm9xSEJOTWxwRFFz?=
 =?utf-8?B?S0xBcE5wN0IvNTMySzExMDhpTk5ZLzJnZjI4a0hHSmJuamorOHJQcGM5SUpn?=
 =?utf-8?B?elZGQmwzalQ5aEpwU2dvT1ZncW9GZFVpQlFOSE5lVXB6VWdGMlI0eUt3MGY2?=
 =?utf-8?B?aEduSmtaT3BQempFOHc1eHVmenlKcm04U1lnNExSS3ErazBVM0s2VjJJMjlQ?=
 =?utf-8?B?azhwWVpwczFweStUOHJxWnhqdTJhbEVCUHh3bTB2R2NvREJZS3Q2bkF2am9v?=
 =?utf-8?B?YXg3OGlEdW1QTVhWa2sxNWJ0NlBBN29mZUIwdmNHOTg4bnBxNE1lY3grczhQ?=
 =?utf-8?Q?5wI4YZq2GylGo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3342.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 730f8950-0240-4cce-06b8-08d89b27ab78
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2020 03:16:35.5045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LRCTaje0KGlTZkPqHAfNj3qV8UGYyAqvPwaOlCqMlPXyHEPD4cl/o8u0OHfVP4KUTdrmWLI2zBPG1rWz2ErkGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3504
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkNCg0KPiANCj4gT24gTW9uLCBEZWMgMDcsIDIwMjAgYXQgMDI6MjE6NDBQTSArMDEwMCwgS3J6
eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gPiBPbiBNb24sIERlYyAwNywgMjAyMCBhdCAwMjo1
MzoyNFBNICswODAwLCBTaGVuZ2ppdSBXYW5nIHdyb3RlOg0KPiA+ID4gRXJyb3IgbG9nOg0KPiA+
ID4gc3lzZnM6IGNhbm5vdCBjcmVhdGUgZHVwbGljYXRlIGZpbGVuYW1lDQo+ICcvYnVzL3BsYXRm
b3JtL2RldmljZXMvMzAwMDAwMDAuYnVzJw0KPiA+ID4NCj4gPiA+IFRoZSBzcGJhIGJ1cyBuYW1l
IGlzIGR1cGxpY2F0ZSB3aXRoIGFpcHMgYnVzIG5hbWUuDQo+ID4gPiBSZWZpbmUgc3BiYSBidXMg
bmFtZSB0byBmaXggdGhpcyBpc3N1ZS4NCj4gPiA+DQo+ID4gPiBGaXhlczogOTcwNDA2ZWFlZjNh
ICgiYXJtNjQ6IGR0czogaW14OG1uOiBFbmFibGUgQXN5bmNocm9ub3VzIFNhbXBsZQ0KPiA+ID4g
UmF0ZSBDb252ZXJ0ZXIiKQ0KPiA+ID4gU2lnbmVkLW9mZi1ieTogU2hlbmdqaXUgV2FuZyA8c2hl
bmdqaXUud2FuZ0BueHAuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgYXJjaC9hcm02NC9ib290L2R0
cy9mcmVlc2NhbGUvaW14OG1uLmR0c2kgfCAyICstDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbi5kdHNpDQo+ID4gPiBiL2FyY2gvYXJt
NjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbi5kdHNpDQo+ID4gPiBpbmRleCBmZDY2OWMwZjNm
ZTUuLjMwNzYyZWI0ZjBhNyAxMDA2NDQNCj4gPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMv
ZnJlZXNjYWxlL2lteDhtbi5kdHNpDQo+ID4gPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2Zy
ZWVzY2FsZS9pbXg4bW4uZHRzaQ0KPiA+ID4gQEAgLTI0Niw3ICsyNDYsNyBAQCBhaXBzMTogYnVz
QDMwMDAwMDAwIHsNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgI3NpemUtY2VsbHMgPSA8MT47
DQo+ID4gPiAgICAgICAgICAgICAgICAgICAgIHJhbmdlczsNCj4gPiA+DQo+ID4gPiAtICAgICAg
ICAgICAgICAgICAgIHNwYmE6IGJ1c0AzMDAwMDAwMCB7DQo+ID4gPiArICAgICAgICAgICAgICAg
ICAgIHNwYmE6IHNwYmEtYnVzQDMwMDAwMDAwIHsNCj4gPg0KPiA+IFRoZSBwcm9wZXIgbm9kZSBu
YW1lIGlzICJidXMiIHNvIGJhc2ljYWxseSB5b3UgaW50cm9kdWNlIHdyb25nIG5hbWUgdG8NCj4g
PiBvdGhlciBwcm9ibGVtLiAgSW50cm9kdWNpbmcgd3JvbmcgbmFtZXMgYXQgbGVhc3QgcmVxdWly
ZXMgYSBjb21tZW50Lg0KPiANCj4gSSBqdXN0IG5vdGljZWQgdGhhdCBteSBtZXNzYWdlIHdhcyBi
YXJlbHkgdW5kZXJzdGFuZGFibGUuLi4gc28gbGV0IG1lIGZpeCBpdDoNCj4gDQo+IFRoZSBwcm9w
ZXIgbm9kZSBuYW1lIGlzICJidXMiIHNvIGJhc2ljYWxseSB5b3UgaW50cm9kdWNlIHdyb25nIG5h
bWUgdG8NCj4gX2ZpeF8gb3RoZXIgcHJvYmxlbS4gIEludHJvZHVjaW5nIHdyb25nIG5hbWVzIGF0
IGxlYXN0IHJlcXVpcmVzIGEgY29tbWVudC4NCj4gDQo+ID4gSG93ZXZlciB0aGUgYWN0dWFsIHBy
b2JsZW0gaGVyZSBpcyBub3QgaW4gbm9kZSBuYW1lcyBidXQgaW4gYWRkcmVzc2VzOg0KPiA+DQo+
ID4gICAgICAgYWlwczE6IGJ1c0AzMDAwMDAwMCB7DQo+ID4gICAgICAgICAgICAgICBzcGJhOiBi
dXNAMzAwMDAwMDAgew0KPiA+DQo+ID4gWW91IGhhdmUgdG8gZGV2aWNlcyB3aXRoIHRoZSBzYW1l
IHVuaXQgYWRkcmVzcy4gSG93IGRvIHlvdSBzaGFyZSB0aGUNCj4gPiBhZGRyZXNzIHNwYWNlPw0K
PiA+DQo+ID4gSSB0aGluayB0aGlzIHNob3VsZCBiZSByYXRoZXIgZml4ZWQuDQo+IA0KPiBBbmQg
YWdhaW4sIGh1bmdyeSBrZXlib2FyZCBhdGUgYSBsZXR0ZXIsIHNvOg0KPiANCj4gWW91IGhhdmUg
X3R3b18gZGV2aWNlcyB3aXRoIHRoZSBzYW1lIHVuaXQgYWRkcmVzcy4gSG93IGRvIHlvdSBzaGFy
ZSB0aGUNCj4gYWRkcmVzcyBzcGFjZT8NCj4gSSB0aGluayB0aGlzIHNob3VsZCBiZSByYXRoZXIg
Zml4ZWQuDQo+IA0KDQpzcGJhIGlzIHRoZSBmaXJzdCBibG9jayBvZiBhaXBzMSBzcGFjZSwgc28g
aXQgaGFzIHNhbWUgc3RhcnQgYWRkcmVzcyBhcw0KYWlwczEuDQoNCkJlc3QgcmVnYXJkcw0KV2Fu
ZyBzaGVuZ2ppdSANCg==
