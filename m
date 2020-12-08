Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B57D2D2686
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 09:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgLHIpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 03:45:43 -0500
Received: from mail-eopbgr140040.outbound.protection.outlook.com ([40.107.14.40]:30212
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726830AbgLHIpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 03:45:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=duwqysFlOhZY8j0QsN2Dl1TaNPcacGJpKwmuFj+tHSUMudXfW6gxcfYS5Qm5eRurDiwxtCgszhhm3RihY8mDynPVHyP2ofRqn72iSIH0wpQU7gy8XdXaGegBSjEE8JHdZcifN8VP3A9QgkKuIbf4Idr8IhMP5eX2J0BKUhiSH1nD1zcT9DdQ7wvOXAhUQmqnYwk3xNYOKFULnjTUMYPNz8q99SdAheCXRjgovV7N+LmBllyaZUK6yR4tKuEUkSfTD/DuDsOzBH9KzFCYdrGynjpGvZdj+owoR40n0bkYTRtQ/LteUgDMv7bzUvQxuELN47GprtymS4tvJ7HZE5uMOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XK5rxuK9Kv6F6zbGZt+doreCvDOcNtTilj6kM6fOlU=;
 b=TBVJnv15vWDbcK3PXGeA0Y8cu9nY9MPzuPLvAg76EgvKOtZFsMq3daJvUs2ep/TWoLqjYGuZSmQyMQYQqcPl9N1BzhelMCJG5LZCmbdVOztVmlbsZlhhWzLUOafq4MapS+Dy31517LeIY6clv2dyr7rjrXV2hJrSAbeSVVQGIE0xyNNXab2GiI73q08Y5eQd2tLegmbX3rfVyh757uSLuYjypvf9V6FWfa/PMDhc3U4hZb2C6ldlMfWuF47goWGoxNhPGgGBUPRkQdfrEW8Mv/n5PQX0kneW3vl5mpa1Eqt+6iT2fw6SksW/W7jZuw3PWBRWkTZ11NaEeGGnJ8WbuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XK5rxuK9Kv6F6zbGZt+doreCvDOcNtTilj6kM6fOlU=;
 b=GRiQ8qaQ4rXL9HQWN32vmJrLxeeRm4xPAFdcVZ/abfi2nzyUiW/xyog8Mo+QqptLEwQoBc6G32dOYPNx+TDdPgiJ8aqWFCUbCcDhcrlOUWGU5A2t9HpZeUv5Adg2PCdXX3Pg0L/9mBrLYboesoFkC9Dcza6ZO90awRYs4NwXasw=
Received: from VI1PR0402MB3342.eurprd04.prod.outlook.com
 (2603:10a6:803:11::14) by VI1PR0402MB3648.eurprd04.prod.outlook.com
 (2603:10a6:803:1d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Tue, 8 Dec
 2020 08:44:51 +0000
Received: from VI1PR0402MB3342.eurprd04.prod.outlook.com
 ([fe80::4b3:7c0c:654c:7a61]) by VI1PR0402MB3342.eurprd04.prod.outlook.com
 ([fe80::4b3:7c0c:654c:7a61%6]) with mapi id 15.20.3632.023; Tue, 8 Dec 2020
 08:44:51 +0000
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
Thread-Index: AdbNPmLhwRLRaLoBR0W+YTteb5OStg==
Date:   Tue, 8 Dec 2020 08:44:51 +0000
Message-ID: <VI1PR0402MB3342A173BDB558D436A5C514E3CD0@VI1PR0402MB3342.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c201f76d-5cc2-4a46-78a8-08d89b55875a
x-ms-traffictypediagnostic: VI1PR0402MB3648:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB3648AD2D32B96CBF549EE687E3CD0@VI1PR0402MB3648.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s+qrnyb3aswI2c5FtCLZYN6UR1z4ZxwiMgTUSPXCdSPLEiTcFW0YRLxNG2GYGS59kNWePlaNoiJwQU17h5bMUdH2ItigBHV4BLmcd3UMqA2V0sR1VHmKNY4vwzbvHgGyxishwu4nW9uc83QUkZIt3XSUkoIPQw9QfbvGe6zajgnL0/M4XGjZqHGwvNSnXWEgSkikVCTcJ7X5BQ9EyVjYYyIT24qF43haUO2DreQMHZkjmQRN5tcC6e55cV/PEElC3+q81yW/TRmBcIUxNenD7DNab1Fbhi0VuaB9FDi/rskF8lqh2iSGNW1w+jkZisKKYoNrMUzQjm54pqTo7RBU9tlsgkmqoVmFDm8aywU+CYI6wHjOP4/2AfsjgIb3GgUW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3342.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(71200400001)(64756008)(8936002)(55016002)(86362001)(54906003)(4326008)(5660300002)(66476007)(33656002)(7696005)(76116006)(2906002)(26005)(186003)(66946007)(66446008)(52536014)(66556008)(9686003)(6916009)(508600001)(6506007)(83380400001)(8676002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Z3RuUndBNFFKY21zNENsVWtMSFhLSXAweldHWEovYkFvQTBRNTFwNXpDaWxv?=
 =?utf-8?B?aU1ha0NGY2Y2MlNkU21iWlFaakF6T2svVnNKMk02dTE0Yy8zZUJPTnlZbHJN?=
 =?utf-8?B?dDIwL0tXcGNad250QWhUMDVkc3dUdjVMcWVTVU5DSXFrRHR3YmcxR2dxTyt2?=
 =?utf-8?B?WitLRDd4eW1XNTdBSlM2Z0JnOVNORkFRM0hmNFI2amIvT25BbVpNMlFURWFT?=
 =?utf-8?B?NE5MY21VVXlKL1VsdEF0VW9hTmduQ3lOazhvaDdmdDl1Z1F4d2doanB1K2dq?=
 =?utf-8?B?SXdSdm5Ld2xuelF0S1VBRzIyb3hEZkNBT0xnZkZVR0JLaG9UYURtOCtRdFBS?=
 =?utf-8?B?WFdvQXZnOUkrdEhtRGxlVm95RHp6cTdPaERIcnJZaFNwWE1sMGptTVg1KzFu?=
 =?utf-8?B?Vk9EVk90RXlLbS8zZVM5UWEzOUtsYWZLMlEzVFVpK1B5UkhzbE84dXBoNm5K?=
 =?utf-8?B?WlZFT0FlOEpuT1R6bVV3UlNYZjZDSFdqNGwwYWxvUGJmb0RmMzRiWDN3WWk5?=
 =?utf-8?B?Znk2bVJubjVWZ0t2elFOemY1K1IxS2grR29zQkJGbWZXZnFYQVk3OWdmbCtS?=
 =?utf-8?B?NXR1RHg2YnZpUzZsT096eS9zeXNqeGJuYnd1UU43ekd5Y2dFaVUveldNaVE5?=
 =?utf-8?B?NkYrNnkyTHVCRlFOWk1jTFZ0SUI5VitseHBxbGZvWXN4NW9ub3FGQ0NJc01J?=
 =?utf-8?B?NFU1WmtzdFdoY3JiZmJuRUkxd1F5b1IyZloyZjJnTG1hcmtYeVpEQVZMQTdY?=
 =?utf-8?B?MGlabnlXMk1hbU5Id1NuVXlCTlZPRHFmQVpaQVFkMnA1cmN1Tmp5TEZsYXgz?=
 =?utf-8?B?dURUYnRTc1FtVEE3V0twdzNlcFF4UEgyMWlIU3hWMUl3aytsRnJXNmI2eFBn?=
 =?utf-8?B?aENaRU1ibVpqbGZqcDVPL3FJeTExYlBNL2lOb1hVTjRjS2ZUcTVzM3V1UHc5?=
 =?utf-8?B?bEVDOThDTVNuNEFQbzdYZzlpR0ppWm5OS2lHMHZ2RlJSbjcxdTRzN1p1dDIy?=
 =?utf-8?B?WGxNU3ZWaU5vVGVIbDhIZmE5YzBmNjd5M0hudzBYL0RvWm95dHBCWFlqTG9Y?=
 =?utf-8?B?dTNuRUV5cUtvbFQrN3FpMVlmNVI0SnNrUDZVRm51NkRqSTBrNy9UZ3NIM0NM?=
 =?utf-8?B?c1Avek5YVURXK3JpOXo5My9sbk1UbHI1bGRlSGRuQ2V5Y282dnRGdEZRVEY2?=
 =?utf-8?B?SW9lY0ZCbUloVmhCa3pKNmlKcjBSbFFuYzJkb21xTnhqajM1dk5HVWVWU2hy?=
 =?utf-8?B?RE5VSnpMRWd2UUZMTmlNMGtiUm5XN1VBMHhudmtId2pYM1lVR00zNW1ESitp?=
 =?utf-8?Q?O9/1joktNb7Lg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3342.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c201f76d-5cc2-4a46-78a8-08d89b55875a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2020 08:44:51.7664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GmNl6k8ruJjC7TbBlDk+TunLiRaPFILB0XmPPzK3HPfIJH7k2i5+KoSBgInVV43d2v/SYMygRpb4e3G0wn43Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3648
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ID4gPg0KPiA+ID4gPiBPbiBNb24sIERlYyAwNywgMjAyMCBhdCAwMjoyMTo0MFBNICswMTAw
LCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiA+ID4gPiA+IE9uIE1vbiwgRGVjIDA3LCAy
MDIwIGF0IDAyOjUzOjI0UE0gKzA4MDAsIFNoZW5naml1IFdhbmcgd3JvdGU6DQo+ID4gPiA+ID4g
PiBFcnJvciBsb2c6DQo+ID4gPiA+ID4gPiBzeXNmczogY2Fubm90IGNyZWF0ZSBkdXBsaWNhdGUg
ZmlsZW5hbWUNCj4gPiA+ID4gJy9idXMvcGxhdGZvcm0vZGV2aWNlcy8zMDAwMDAwMC5idXMnDQo+
ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gVGhlIHNwYmEgYnVzIG5hbWUgaXMgZHVwbGljYXRlIHdp
dGggYWlwcyBidXMgbmFtZS4NCj4gPiA+ID4gPiA+IFJlZmluZSBzcGJhIGJ1cyBuYW1lIHRvIGZp
eCB0aGlzIGlzc3VlLg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEZpeGVzOiA5NzA0MDZlYWVm
M2EgKCJhcm02NDogZHRzOiBpbXg4bW46IEVuYWJsZSBBc3luY2hyb25vdXMNCj4gPiA+ID4gPiA+
IFNhbXBsZSBSYXRlIENvbnZlcnRlciIpDQo+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBTaGVu
Z2ppdSBXYW5nIDxzaGVuZ2ppdS53YW5nQG54cC5jb20+DQo+ID4gPiA+ID4gPiAtLS0NCj4gPiA+
ID4gPiA+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW4uZHRzaSB8IDIgKy0N
Cj4gPiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24o
LSkNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290
L2R0cy9mcmVlc2NhbGUvaW14OG1uLmR0c2kNCj4gPiA+ID4gPiA+IGIvYXJjaC9hcm02NC9ib290
L2R0cy9mcmVlc2NhbGUvaW14OG1uLmR0c2kNCj4gPiA+ID4gPiA+IGluZGV4IGZkNjY5YzBmM2Zl
NS4uMzA3NjJlYjRmMGE3IDEwMDY0NA0KPiA+ID4gPiA+ID4gLS0tIGEvYXJjaC9hcm02NC9ib290
L2R0cy9mcmVlc2NhbGUvaW14OG1uLmR0c2kNCj4gPiA+ID4gPiA+ICsrKyBiL2FyY2gvYXJtNjQv
Ym9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbi5kdHNpDQo+ID4gPiA+ID4gPiBAQCAtMjQ2LDcgKzI0
Niw3IEBAIGFpcHMxOiBidXNAMzAwMDAwMDAgew0KPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAg
ICAgICAjc2l6ZS1jZWxscyA9IDwxPjsNCj4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAg
cmFuZ2VzOw0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IC0gICAgICAgICAgICAgICAgICAgc3Bi
YTogYnVzQDMwMDAwMDAwIHsNCj4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgc3BiYTog
c3BiYS1idXNAMzAwMDAwMDAgew0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVGhlIHByb3BlciBub2Rl
IG5hbWUgaXMgImJ1cyIgc28gYmFzaWNhbGx5IHlvdSBpbnRyb2R1Y2Ugd3JvbmcNCj4gPiA+ID4g
PiBuYW1lIHRvIG90aGVyIHByb2JsZW0uICBJbnRyb2R1Y2luZyB3cm9uZyBuYW1lcyBhdCBsZWFz
dCByZXF1aXJlcyBhDQo+IGNvbW1lbnQuDQo+ID4gPiA+DQo+ID4gPiA+IEkganVzdCBub3RpY2Vk
IHRoYXQgbXkgbWVzc2FnZSB3YXMgYmFyZWx5IHVuZGVyc3RhbmRhYmxlLi4uIHNvIGxldCBtZQ0K
PiBmaXggaXQ6DQo+ID4gPiA+DQo+ID4gPiA+IFRoZSBwcm9wZXIgbm9kZSBuYW1lIGlzICJidXMi
IHNvIGJhc2ljYWxseSB5b3UgaW50cm9kdWNlIHdyb25nDQo+ID4gPiA+IG5hbWUgdG8gX2ZpeF8g
b3RoZXIgcHJvYmxlbS4gIEludHJvZHVjaW5nIHdyb25nIG5hbWVzIGF0IGxlYXN0DQo+IHJlcXVp
cmVzIGEgY29tbWVudC4NCj4gPiA+ID4NCj4gPiA+ID4gPiBIb3dldmVyIHRoZSBhY3R1YWwgcHJv
YmxlbSBoZXJlIGlzIG5vdCBpbiBub2RlIG5hbWVzIGJ1dCBpbg0KPiBhZGRyZXNzZXM6DQo+ID4g
PiA+ID4NCj4gPiA+ID4gPiAgICAgICBhaXBzMTogYnVzQDMwMDAwMDAwIHsNCj4gPiA+ID4gPiAg
ICAgICAgICAgICAgIHNwYmE6IGJ1c0AzMDAwMDAwMCB7DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBZ
b3UgaGF2ZSB0byBkZXZpY2VzIHdpdGggdGhlIHNhbWUgdW5pdCBhZGRyZXNzLiBIb3cgZG8geW91
IHNoYXJlDQo+ID4gPiA+ID4gdGhlIGFkZHJlc3Mgc3BhY2U/DQo+ID4gPiA+ID4NCj4gPiA+ID4g
PiBJIHRoaW5rIHRoaXMgc2hvdWxkIGJlIHJhdGhlciBmaXhlZC4NCj4gPiA+ID4NCj4gPiA+ID4g
QW5kIGFnYWluLCBodW5ncnkga2V5Ym9hcmQgYXRlIGEgbGV0dGVyLCBzbzoNCj4gPiA+ID4NCj4g
PiA+ID4gWW91IGhhdmUgX3R3b18gZGV2aWNlcyB3aXRoIHRoZSBzYW1lIHVuaXQgYWRkcmVzcy4g
SG93IGRvIHlvdQ0KPiA+ID4gPiBzaGFyZSB0aGUgYWRkcmVzcyBzcGFjZT8NCj4gPiA+ID4gSSB0
aGluayB0aGlzIHNob3VsZCBiZSByYXRoZXIgZml4ZWQuDQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4g
c3BiYSBpcyB0aGUgZmlyc3QgYmxvY2sgb2YgYWlwczEgc3BhY2UsIHNvIGl0IGhhcyBzYW1lIHN0
YXJ0IGFkZHJlc3MNCj4gPiA+IGFzIGFpcHMxLg0KPiA+DQo+ID4gVGhlIHJlZmVyZW5jZSBtYW51
YWwgZGVzY3JpYmVzIGl0ICJSZXNlcnZlZCBmb3IgU0RNQTIgaW50ZXJuYWwNCj4gPiBtZW1vcnki
LCBzbyBpbmRlZWQgaXQgaXMgZmlyc3QgYWRkcmVzcyBidXQgZG9lcyBpdCBoYXZlIHRvIGJlIG1h
cHBlZD8NCj4gPiBBbnl3YXksIHdoeSBkb24ndCB5b3UgdXNlIHJhbmdlcyB0byByZW1vdmUgdGhl
IGNvbmZsaWN0Pw0KPiANCj4gVGhlIElPIGFkZHJlc3Mgc3BhY2UgcmVtYXBwaW5nIGNvdWxkIGJl
IGEgc29sdXRpb24gYnV0IHRoZXJlIGlzIGFub3RoZXINCj4gcHJvYmxlbSAtIHRoZSBoYXJkd2Fy
ZSByZXByZXNlbnRhdGlvbiBpbiBEVCBkb2VzIG5vdCBtYXRjaCB3aGF0IHJlZmVyZW5jZQ0KPiBt
YW51YWwgaXMgc2F5aW5nLg0KPiANCj4gVGhlIEFJUFMgYnVzIEAzMDAwMDAwMCBoYXMgc2V2ZXJh
bCBJUHM6DQo+ICAtIFNBSTJAMzAwMjAwMDANCj4gIC0gLi4uDQo+ICAtIEdQSU8xQDMwMjAwMDAw
DQo+IA0KPiBIb3dldmVyIGluIERUUyB5b3Ugd2lsbCBmaW5kIGFkZGl0aW9uYWwgU1BCQSBidXMg
Zm9yIDMwMDAwMDAwIC0gMzAwYzAwMDAuDQo+IEl0J3Mgbm90IHJlYWxseSB0aGUgU0RNQSwgYXMg
U0RNQSBpcyBhdCBkaWZmZXJlbnQgYWRkcmVzcy4gSXQgaXMgcmF0aGVyIGFuDQo+IGFkZHJlc3Mg
c3BhY2Ugd2hpY2ggU0RNQSBzaG91bGQgbWFwLi4uIGJ1dCBpdCBpcyBub3QgYSBidXMgd2l0aCBj
aGlsZHJlbi4NCj4gQWRkaW5nIHNwYmEtYnVzQDMwMDAwMDAwIHdpdGggaXRzIGNoaWxkcmVuIGRv
ZXMgbm90IGxvb2sgbGlrZSBjb3JyZWN0DQo+IHJlcHJlc2VudGF0aW9uIG9mIEhXIGluIERUUy4N
Cj4gDQoNCkluIHRoZSBSTSwgaXQgc2F5cyBBSVBTLTEgKHNfYl8xLCB2aWEgU1BCQSkgR2xvYi4g
TW9kdWxlIEVuYWJsZS4NClJhbmdlIGlzICgzMDAwMDAwMCAtIDMwMEZGRkZGKQ0KDQpTUEJBIGlz
IGEgc3ViLWJ1cyB1bmRlciBBSVBTMS4gVGhlIFNBSTJAMzAwMjAwMDAgLSAgQVNSQ0AzMDBjMDAw
MA0KQXJlIHRoZSBkZXZpY2VzIHVuZGVyIFNQQkEgYnVzLg0KDQpTbyBpdCBkb2Vzbid0IHZpb2xh
dGUgUk0uDQoNCkJlc3QgcmVnYXJkcw0KV2FuZyBzaGVuZ2ppdQ0KDQoNCg==
