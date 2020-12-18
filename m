Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D1A2DE0D5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 11:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389084AbgLRKP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 05:15:28 -0500
Received: from mail-eopbgr150053.outbound.protection.outlook.com ([40.107.15.53]:26052
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728246AbgLRKP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 05:15:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4rNiayZzHygVTYFaPGgabU/1UBqQdElAUDcnGGAwxoI0o67+BrOtDcOnQsk6MbbahF7w7EuwikNVi9xvHdCkDYug27IbZFulO/Ns25CuyeqZHPcoMwreyHk4r+5QE9HSObiu5GTtY/xMZcFcIRM7gdhcMwvKmkdpvnEyO0oTpYtOax2dEgyBq5uS1r6pdl7T6FsErHjNzAZfQJyzgnukDyw+m6D+WcAAbwXYe4uGNiofW3F6gD7oIlu4lNb2UUKJV7UuEp/9B89NzFpG+x0YxvcvL6eufEliQJtwb4dWaeai3jFEply+8PrMg9ScsvXqF+UBIXw49BWfanFFlmCfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2WFd3wuV6Wx3PKVrQ5qkUXLNP5s8YJc8UUY8OfDhto=;
 b=ZSdHw/zx5xhxvPoY7zrRzkftLy+tNm76TGQnVy8x9kOu6NXD2Ghu6L1kbYzTc97ONwir3QWaXH62Dv1C+hVHW2wwKDWoVQ0qNbmhjCmZKuTCRA1dA7CJXfP2V7oBKZmLnS2r8dKm3acX0upQQwD4iqGG7ZIDKIzpbNlonA2iCl6ywQrMcgbp/6voMDMfY6SUibbzz6wtsj/76Ze63LcyNXSaNh20UOtgHBPBxx2kwxjXFemA8h0E+oVJuefoJzgqR13kHzdiq6/jpOEz7Z8Zmtzwr9OGoOC6Y1Id+odNWSEj6BxbffRsDm9BGU6oK3u262OaKFdClRo6UJM4kQK/Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2WFd3wuV6Wx3PKVrQ5qkUXLNP5s8YJc8UUY8OfDhto=;
 b=ICju6Nof+qZN431ioocUDuVSgP7JprTCjnKzF4eutZVvHx1jna4MkG/Q3UNBH+4xyiRSHOxIyKlszEPaU1Ro7wP4o5X0pDmWIpUzn+Iw4vhmPIZgaYt5ztnZtISM/IoifW8QwhSr+/UWKA31p27I4y15JKWKfKt6EgfetcBL4KQ=
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM6PR04MB4197.eurprd04.prod.outlook.com (2603:10a6:209:44::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.13; Fri, 18 Dec
 2020 10:14:35 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631%7]) with mapi id 15.20.3676.025; Fri, 18 Dec 2020
 10:14:35 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v8 1/4] dt-bindings: soc: imx8m: add DT Binding doc for
 soc unique ID
Thread-Topic: [PATCH v8 1/4] dt-bindings: soc: imx8m: add DT Binding doc for
 soc unique ID
Thread-Index: AQHW1RkPpji9TbVGY0Ki90hKbr4yE6n8jAGAgAADhwCAAAjagIAABRgA
Date:   Fri, 18 Dec 2020 10:14:35 +0000
Message-ID: <AM6PR04MB60534C972777EED96FD105D2E2C30@AM6PR04MB6053.eurprd04.prod.outlook.com>
References: <20201218083726.16427-1-alice.guo@oss.nxp.com>
 <20201218085223.GA17306@kozik-lap>
 <AM6PR04MB6053A65F794B316659CDE638E2C30@AM6PR04MB6053.eurprd04.prod.outlook.com>
 <20201218093641.GA38684@kozik-lap>
In-Reply-To: <20201218093641.GA38684@kozik-lap>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8ad224d7-ffc3-4171-f9e9-08d8a33db839
x-ms-traffictypediagnostic: AM6PR04MB4197:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB41971FEEF4741D7CDDDCA2AEA3C30@AM6PR04MB4197.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JpQScihbAuAYn5FUkgw3h8sGeAFq5k0+C4aqfqY0sST2oXECqzidrz8cI/Tf7+dhOHwnJP3tJKDa0hdgF9GMZygs5P99Y5AyjhCBpvuEKCYFtPiJhEXb4CzwD8KSojB8Y6F73ao0lnB9x+P83zwhAObZBx7IK3ogXGZaCjiljGZO5iFQ4ubWXg9qgwqBVHz5WCdCOX5tDedd2q5WVSPZpf1kA7j266rc5YjdJeO9tDBLDPzsljTB7exqjymoxDijJ80d4ZLwXeSW2Qzb+tNLHC6qZ9UCK8zB+1yKdYBXOjzPCEvj2vaeA0/3ikd/sWiuIniu1T/JPznsqLsS6o4o2T8gkml7X4ssp5/0Jy61lRO6s7YtCpYrMep7t7TdtSllgvvsbMLxoOnVViODwxPzeZO7mg+gs5DrBDrk3bfCxQxKGSvYdxQOx4mX2WKhuePC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(366004)(66946007)(54906003)(71200400001)(8676002)(66556008)(7696005)(316002)(6506007)(86362001)(55016002)(66476007)(64756008)(83380400001)(9686003)(33656002)(186003)(26005)(52536014)(2906002)(66446008)(4326008)(8936002)(478600001)(76116006)(110136005)(53546011)(966005)(5660300002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UHRLZ0JtOVRZMnBBRkdUZ0lvZ1V3RGt4SmFiVjAxd1ZMM25FYnNTY3lTQlFL?=
 =?utf-8?B?OHN3UjlZeFY4azBLa1I5cnFXOE1WUEFHY3dsM0NyWVVxalR5VE5RSlBmUlJJ?=
 =?utf-8?B?a1FCQWwyMytMVmZkelJ6UVhpZ2RjRW1CUS9yaG1JZmtSR1pVTXFNeFdVL0pY?=
 =?utf-8?B?TFB5NGxqRzZ6SCs5eFhoUHpoanZ0cU9UbHVKcDIwQW85U05IelNmTERNKy9O?=
 =?utf-8?B?dStrQlY4c0FRVnY2WERUang3TG5kekdpa2dsM3RqRnA5WVZkWk14dGhhbkJT?=
 =?utf-8?B?TTFtL1NjejNYT2RzZzBDemdhd2xpNjJteWdvUmtSVWZ3Y3QrdlFzTHlLcWZu?=
 =?utf-8?B?a3hHV0c4Y1FmVFl4a3VRbzJXdGpnSzc1NkRSamdTaDdPZzJSTlRRWnYydEcw?=
 =?utf-8?B?bXByVWZXUUhJSzQyLzNJeEJIU21SRVd4S2xDTXk3UFV6WHArWUtvVUM1YktW?=
 =?utf-8?B?UFIycERYR0VGbUZVMTYzZitnRUNWQ0RvbS9wU1psd25xRk1KcGg4a3VTbGQ2?=
 =?utf-8?B?SzQzTktrdXpxTGcrZUdsRDIyaW9IVHViL1RFUTB6OUpnZWVndGhlWXk4Qml3?=
 =?utf-8?B?VG15bmdyU2k4ZXhKTHpvdVpMb2NIanB0bXpjTUJYUUdvZXErUjEwYngwTm14?=
 =?utf-8?B?YmNlOW42L0FhQno3alNBWXZrQXl5a2pQbEdmT2E5cS90ZkEraXppZE1nUXVF?=
 =?utf-8?B?VHU5Z0t1U0FYS1hiL1Bwd3dTTWtnUTBuSFliM1d1QnI3Sk5iK3Zoell5RTEx?=
 =?utf-8?B?OHN2VjQ5VjJDb1p1N090OGl2akZ2aTZLc1kvUWFDS3R4RXhtZUVhSEx6UUV1?=
 =?utf-8?B?UmlQclRwNGdjdzFMMlJkbjZ0RTRjRzNhYnUwUmI0MTNxclZPL3FBYktzSEdV?=
 =?utf-8?B?ditVZkFIUHpwbTFNWWZjTi9LRDJSYXdiZ1BGQmZ4YkNEYUVzUm9QRXdyWWFR?=
 =?utf-8?B?dnptaUxTcGpxRTNLM3MvcVNGU2FidGtYUEc0YXVGNHFraGRvWFhucG4walFK?=
 =?utf-8?B?a0xkbStXK244ajN2WXdMUHpqK2g2d0Nsd1VFdWZDb0UwdWpLWmU1WVQxUHNB?=
 =?utf-8?B?OVRNTFhNTXpwNng2SGJKWGZScGkyWEhQdlZUWjFTRDI1QmZyc0tDS3JDVStv?=
 =?utf-8?B?TGdoMmFkNUFPblZNS3RhT0QydWFRa2tVaXNVaDN6Y3VnU1V6U3dZb0FwSW5m?=
 =?utf-8?B?WXRCb2hRL3JsZi9lY0tObS9LQ01RSXRhVjhpcUEvTGR1TTV6NzBXZlVqeHp5?=
 =?utf-8?B?N1lubUJ4dDNSYlBzYStYcjIwSm9BRWNCV3RieHVvY2gvR0tHZ1c3cmFSZUZT?=
 =?utf-8?Q?QVIx1+j3ykVuU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad224d7-ffc3-4171-f9e9-08d8a33db839
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2020 10:14:35.0825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R3Mog1z4OQAYzPhufw5TpNe/zdPLQ3FSEOod8UjqihWthIFLYEwKyXHtEV0evyVnamLMdcqFhisOr2HZgoWBoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4197
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiAyMDIw5bm0MTLmnIgxOOaXpSAxNzozNw0K
PiBUbzogQWxpY2UgR3VvIChPU1MpIDxhbGljZS5ndW9Ab3NzLm54cC5jb20+DQo+IENjOiByb2Jo
K2R0QGtlcm5lbC5vcmc7IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXgu
ZGU7DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOyBkZXZpY2V0
cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXgNCj4gPGxpbnV4
LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY4IDEvNF0gZHQtYmluZGluZ3M6
IHNvYzogaW14OG06IGFkZCBEVCBCaW5kaW5nIGRvYyBmb3Igc29jDQo+IHVuaXF1ZSBJRA0KPiAN
Cj4gT24gRnJpLCBEZWMgMTgsIDIwMjAgYXQgMDk6MDU6MDBBTSArMDAwMCwgQWxpY2UgR3VvIChP
U1MpIHdyb3RlOg0KPiAgPiA+ICsgICAgcmVxdWlyZWQ6DQo+ID4gPiA+ICsgICAgICAtIGNvbXBh
dGlibGUNCj4gPiA+ID4gKyAgICAgIC0gbnZtZW0tY2VsbHMNCj4gPiA+ID4gKyAgICAgIC0gbnZt
ZW0tY2VsbC1uYW1lcw0KPiA+ID4gPiArDQo+ID4gPiA+ICthZGRpdGlvbmFsUHJvcGVydGllczog
dHJ1ZQ0KPiA+ID4NCj4gPiA+IERvbid0IGxlYXZlIGNvbW1lbnRzIHVucmVzb2x2ZWQgKG9yIHJl
c29sdmUgdGhlbSBhZ2FpbnN0IHJldmlldw0KPiA+ID4gd2l0aG91dCBkaXNjdXNzaW9uKS4gUm9i
IGFza2VkIGZvciBjaGFuZ2luZyBpdC4gVGhlIHNhbWUgYXMgd2l0aCBhbGwNCj4gPiA+IHNjaGVt
YXMgLSB5b3UgbmVlZCB0byBkZXNjcmliZSB0aGUgbWlzc2luZyBwcm9wZXJ0aWVzLg0KPiA+ID4N
Cj4gPiA+IEJlc3QgcmVnYXJkcywNCj4gPiA+IEtyenlzenRvZg0KPiA+DQo+ID4gSGksDQo+ID4g
VGhhbmsgeW91IGZvciB5b3VyIGFkdmljZS4gSSByZXBsaWVkIHRvIGhpbSBhbmQgbGV0IGhpbSBr
bm93IEkgcmVtYWluZWQgaGVyZQ0KPiB1bmNoYW5nZWQuIFRoZXJlIHdpbGwgYmUgZXJyb3JzIGFj
Y29yZGluZyB0byBoaXMgc3VnZ2VzdGlvbi4NCj4gDQo+IFRoZW4gdGhlIHNvbHV0aW9uIGlzIHRv
IGNvcnJlY3QgdGhlIGVycm9ycyAtIGRlc2NyaWJlIG1pc3NpbmcgcHJvcGVydGllcw0KPiAtIGlu
c3RlYWQgb2YgaWdub3JpbmcgdGhlIHN1Z2dlc3Rpb24gYW5kIG1ha2luZyBhIHJlc3VibWl0IHJp
Z2h0IGF3YXkuDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQpIaSwNCkkgYW0g
c29ycnkgSSBkbyBub3QgRFQgQmluZGluZyBkb2MgdmVyeSB3ZWxsLg0KDQpJIGNoZWNrZWQgdGhl
IHVzYWdlIG9mIHBhdHRlcm5Qcm9wZXJ0aWVzIGFuZCBhZGRpdGlvbmFsUHJvcGVydGllcyBpbiBo
dHRwczovL2pzb24tc2NoZW1hLm9yZy91bmRlcnN0YW5kaW5nLWpzb24tc2NoZW1hL3JlZmVyZW5j
ZS9vYmplY3QuaHRtbC4NCkkgbm90aWNlZCBhIHNlbnRlbmNlIG9uIHRoZSB3ZWJzaXRlOiAiIElm
IGFkZGl0aW9uYWxQcm9wZXJ0aWVzIGlzIGEgYm9vbGVhbiBhbmQgc2V0IHRvIGZhbHNlLCBubyBh
ZGRpdGlvbmFsIHByb3BlcnRpZXMgd2lsbCBiZSBhbGxvd2VkLiIsIHNvIEkgdGhpbmsgdGhhdA0K
aWYgYWRkaXRpb25hbFByb3BlcnRpZXMgaXMgYSBib29sZWFuIGFuZCBzZXQgdG8gdHJ1ZSwgYWRk
aXRpb25hbCBwcm9wZXJ0aWVzIHdpbGwgYmUgYWxsb3dlZC4gTGV0dGluZyBoZXJlIHVuY2hhbmdl
ZCBpcyBteSBzb2x1dGlvbiB0byBjb3JyZWN0IHRoZSBlcnJvcnMuDQpJIGFtIG5vdCBzdXJlLCBJ
IGFza2VkIFJvYiBmb3IgYWR2aWNlIG9uIHRoZSB2NiBieSBlbWFpbCwgYnV0IGhlIGRpZG4ndCBy
ZXBseSB0byBtZSwgc28gSSBtYWRlIGEgcmVzdWJtaXQuDQoNClRoYW5rIHlvdSBmb3IgeW91ciBj
b21tZW50IGFnYWluLg0KDQpCZXN0IHJlZ2FyZHMsDQpBbGljZQ0KDQo=
