Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29BD2B3D75
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 08:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgKPHET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 02:04:19 -0500
Received: from mail-eopbgr140072.outbound.protection.outlook.com ([40.107.14.72]:57093
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726524AbgKPHES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 02:04:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CpXkqNbOlP4dd8WDw6yKMMqQp4oIRqwcneL62F/fYdK2XMC55gnHNA6lTpTOUu7ct0Kldv3W7vfPZHNCyD2WJ8cYaP25qszviKOs4/rxIqzCQpkgnuD9M8rkIvkaRmnAemsCCDErs+am5SMRuO6OUm85LkuvGiZfvlBP+P+ZgzqA7PKGdFTfeolIUOIab9ZgWYDxO1b7kngGgL2W8HF155DXYYhlVDotECjrjDBCNqhiRyORnXbqau3GreHr5ISY6N9nZfvvtHXFXkk8RllSt+OralMrhgafToquLdETf0YxuIPXxTjBqfcHFJautu0bDsy9V2YfKreqdZLOVZeFcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLm/ZWSV0WAqUXunwjuMjOCUsjCrHv38gbtj6Q1+a3M=;
 b=TyqsvKmfWIc/uz1hTfj716Otg/SwGPGNO+2J3UIJxaH2iM36Ju48i0ByZiU+75GIOb16EGxQ8Hn5k3FbhU9AkqRGvfIR8p3D8H8XC9n5TdpuQIxTcuiHnqA4aT/KRD9x92s3Xihf2qnxJJfh2L3U+pjbHsT2eiozbx950io9mn93LfFyQNAjn5VaQ1V2l5XA1wl7uYsQMGFCYfKUB7v2Y8PRa1vd03FCclwPMLWA/ApLbTHf1Rv6fDtmWUoRo1dQRVNsmMKYBxe84MALcamC7QVddewbhlWWX8o27rA3I9MmRPp/FR8w52uMaSVfxSjsVryEfHzyczst0HcJM1vavw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLm/ZWSV0WAqUXunwjuMjOCUsjCrHv38gbtj6Q1+a3M=;
 b=d/Rkr0c3Eb4NC32qRLoy0N1NOI+xF2MYGj1qdQlT4u9zOvqJNibA0dVvPKJ03Ts5TTVeJFWyhCCeJgwu1IgHrVskPFi25jtUKt0jmTq9KgWAEHQ7e6cBtNk8qV0GOmKJPFRlqw7GxvInTwSUAfbgAC6oAK7AHonTLRoZrsnIHh8=
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AS8PR04MB7941.eurprd04.prod.outlook.com (2603:10a6:20b:2a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Mon, 16 Nov
 2020 07:04:13 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::a968:d7c0:c9f8:b4db]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::a968:d7c0:c9f8:b4db%7]) with mapi id 15.20.3564.026; Mon, 16 Nov 2020
 07:04:13 +0000
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
Thread-Index: AQHWuayxOVgO/t1aJU2waONQ0YbJnKnH2OsAgAJ5pvA=
Date:   Mon, 16 Nov 2020 07:04:13 +0000
Message-ID: <AM6PR04MB60530B6F577A2A05B173748EE2E30@AM6PR04MB6053.eurprd04.prod.outlook.com>
References: <20201113110409.13546-1-alice.guo@nxp.com>
 <20201114164936.GA32552@kozik-lap>
In-Reply-To: <20201114164936.GA32552@kozik-lap>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 242647dd-9cf2-4ef6-a0e7-08d889fdd2f7
x-ms-traffictypediagnostic: AS8PR04MB7941:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AS8PR04MB7941DD4EEBDCBE28CF34CE2AE2E30@AS8PR04MB7941.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cIlxYUlwWBR2BBUuH6yc6Cme/X8lskCNUwmT1UzL5NDsK6yznQteAHqKKVGu5whLFB6TuUQ/eNJnElA0pxV6phAyN3K8+MGAqeZoXdQRLM7xpJGWe9Yf20yeb0nKsSpbYFs+w0MHkouw0HHCiobhaOx5qfil+nFn5YAsL1i8MFebhRzxsS2Iv6U9POdI9SMAupF6A7RijykybBl+kdEF3PbE2Vw6skKSoLI06Zdd08cN1iR14dkiTRdMiwU1HjatZX5GH+sZZUEh/TgIXa/mHgJogvUg/IiE7KJjlN96xatR8kwxDWO3ejPhvljy+wYfKvSzlRbRvWFvoyMHSSLIAKsYMcELST79y5ArNR8dY9rHTLerqmrAY/m/41V3p0pC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(396003)(376002)(366004)(5660300002)(26005)(7696005)(2906002)(76116006)(71200400001)(6916009)(33656002)(8936002)(55016002)(86362001)(83380400001)(8676002)(52536014)(44832011)(186003)(478600001)(316002)(66946007)(66446008)(64756008)(66556008)(9686003)(53546011)(4326008)(6506007)(66476007)(54906003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: xOQYjiRIOzAQzSNONEdnpkCpqcX3Qcb0Co0hqR4Cgp7WZx92waV9qp68S1aascBSlt4RiI21QOOyKYL5hq8FcjwrZmSxcmfdHBwphZyd4/eF9EdLbFIMHK3/2xTTh2tTO0u3HKHttby5ldwsmklWpVRQJrAC9hnRquIjSMZZxW4HkbngJSDtAC+zxQFqTDh/4At9aQbrRDDPYAVhc/GKRMOP2TN52cLZDg+JzYTD+lKVmsKT+h+gGjcnaz1ocaOMRFp9t6m+y/TMxEpxaLbx1IDlizb5OKBLpkmXpnX2STFhNCPM62a3/2OPHerDkxcW5GYDuvaas0diy1+ASw2fSsmFUesJyCFhjPKppmFxuqm+Y9FpFqCMy+nnPHvdu1aGq9hcgMZAxPo3FnBl11Aywq8AqhlmU7AS9UZWU91ea6ljz1rlKEPvRNPGmAySfV8bvqLA/57hEJT2Di3qRouFqsJP6W+OwJOhp9cj9B+rPBZxa2XZiUXL43PZP5FFd5tqeRhokoR7nZGW/KRtALzcXtVB9t8GRYGaOnmNZtt/afIVGkoWI2KRDEywIWplD4uyrGAKxizchI0kqJEPlCvIyV2vGZnnQX4w/EgqZq4bp/4uDIGrKh2vEUk5tZ6RHxiBeYBpP3a00psmp1VACEZd4ZY2MK2/VKBmuNGhzFpyr+BGfBsuyyv0WQaibB51MtjNUralIXsx2Zv2CGbdvowTyy7mjUT1rXA+Sv0GHCkznar0JgDbgBk2+zFqfrr1//adyipGjnqRAq0FFuzQ6dcZCLgBVWaWdhcuZyXrGJxLU2R6E45SeSXT6cJwBHzEOZLZXGn68m84+nzT/Uy1Gi48DVQC52Nl3gLpgEPeOcdrFOPEmEOYEar3hq4KlussY2HzRH3PReSYmQyGxZFn3CZRsw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 242647dd-9cf2-4ef6-a0e7-08d889fdd2f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2020 07:04:13.1410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W50hESoY8OmLbsrZ2JWhGva3Url3fMDy3XKamernCKtoAlJdDMbgjxmAW/NWl3KLcCbFhU1H7hByznyUWOce1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7941
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEtyenlzenRvZiBLb3psb3dz
a2kgPGtyemtAa2VybmVsLm9yZz4NCj4gU2VudDogMjAyMOW5tDEx5pyIMTXml6UgMDo1MA0KPiBU
bzogQWxpY2UgR3VvIDxhbGljZS5ndW9AbnhwLmNvbT4NCj4gQ2M6IHJvYmgrZHRAa2VybmVsLm9y
Zzsgc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsNCj4gZGwtbGlu
dXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPjsN
Cj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBb
RVhUXSBSZTogW1BBVENIIHYzIDEvNF0gZHQtYmluZGluZ3M6IHNvYzogaW14OG06IGFkZCBEVCBC
aW5kaW5nIGRvYw0KPiBmb3Igc29jIHVuaXF1ZSBJRA0KPiANCj4gQ2F1dGlvbjogRVhUIEVtYWls
DQo+IA0KPiBPbiBGcmksIE5vdiAxMywgMjAyMCBhdCAwNzowNDowNlBNICswODAwLCBBbGljZSBH
dW8gd3JvdGU6DQo+ID4gQWRkIERUIEJpbmRpbmcgZG9jIGZvciB0aGUgVW5pcXVlIElEIG9mIGku
TVggOE0gc2VyaWVzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQWxpY2UgR3VvIDxhbGljZS5n
dW9AbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2Zz
bC55YW1sICAgICAgICAgIHwgMjUNCj4gKysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnNsLnlhbWwNCj4gPiBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnNsLnlhbWwNCj4gPiBpbmRleCBlNGRiMGY5ZWQ2
NjQuLmY0ZmFlYmJiNTdkYSAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvYXJtL2ZzbC55YW1sDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2FybS9mc2wueWFtbA0KPiA+IEBAIC05MDEsNiArOTAxLDMxIEBAIHByb3Bl
cnRpZXM6DQo+ID4gICAgICAgICAgICAgICAgLSBmc2wsczMydjIzNC1ldmIgICAgICAgICAgICMg
UzMyVjIzNC1FVkIyIEN1c3RvbWVyDQo+IEV2YWx1YXRpb24gQm9hcmQNCj4gPiAgICAgICAgICAg
IC0gY29uc3Q6IGZzbCxzMzJ2MjM0DQo+ID4NCj4gPiArICBzb2M6DQo+ID4gKyAgICB0eXBlOiBv
YmplY3QNCj4gPiArICAgIHByb3BlcnRpZXM6DQo+ID4gKyAgICAgIGNvbXBhdGlibGU6DQo+ID4g
KyAgICAgICAgb25lT2Y6DQo+ID4gKyAgICAgICAgICAtIGRlc2NyaXB0aW9uOiBpLk1YOE0gU29D
cw0KPiA+ICsgICAgICAgICAgICBpdGVtczoNCj4gPiArICAgICAgICAgICAgICAtIGVudW06DQo+
ID4gKyAgICAgICAgICAgICAgICAgIC0gZnNsLGlteDhtbS1zb2MNCj4gPiArICAgICAgICAgICAg
ICAgICAgLSBmc2wsaW14OG1uLXNvYw0KPiA+ICsgICAgICAgICAgICAgICAgICAtIGZzbCxpbXg4
bXAtc29jDQo+ID4gKyAgICAgICAgICAgICAgICAgIC0gZnNsLGlteDhtcS1zb2MNCj4gPiArICAg
ICAgICAgICAgICAtIGNvbnN0OiBzaW1wbGUtYnVzDQo+ID4gKw0KPiA+ICsgICAgICAgICAgLSBk
ZXNjcmlwdGlvbjogT3RoZXIgU29Dcw0KPiA+ICsgICAgICAgICAgICBpdGVtczoNCj4gPiArICAg
ICAgICAgICAgICAtIGNvbnN0OiBzaW1wbGUtYnVzDQo+ID4gKw0KPiA+ICsgICAgICBudm1lbS1j
ZWxsczoNCj4gPiArICAgICAgICBtYXhJdGVtczogMQ0KPiA+ICsgICAgICAgIGRlc2NyaXB0aW9u
OiBQaGFuZGxlIHRvIHRoZSBTT0MgVW5pcXVlIElEIHByb3ZpZGVkIGJ5IGEgbnZtZW0NCj4gPiAr
IG5vZGUNCj4gPiArDQo+ID4gKyAgICAgIG52bWVtLWNlbGxzLW5hbWVzOg0KPiA+ICsgICAgICAg
IGNvbnN0OiBzb2NfdW5pcXVlX2lkDQo+ID4gKw0KPiA+ICBhZGRpdGlvbmFsUHJvcGVydGllczog
dHJ1ZQ0KPiANCj4gVGhlICJzb2MiIG5vZGUgc2hvdWxkIGJlIHJlcXVpcmVkIGZvciB0aGVzZSBj
b21wYXRpYmxlcy4gT3RoZXJ3aXNlIHlvdSB3aWxsDQo+IGhhdmUgdG8gc3RheSB3aXRoIHRoaXMg
YmFja3dhcmRzLWNvbXBhdGlibGUtRFRCLWRldmljZS1pbml0Y2FsbC1nbHVlIGZvciBtYW55DQo+
IHllYXJzLi4uIEkgdGhpbmsgeW91IGNhbiBhY2hpZXZlIGl0IHdpdGggYWxsT2YuDQo+IA0KW0Fs
aWNlIEd1b11IaSwNCkkgZmluZCB0aGF0IG15IGRlc2NyaXB0aW9uIGZvciBjb21wYXRpYmxlIGlz
IGFtYmlndW91cy4gVGhlcmUgYXJlIHR3byBraW5kcyBvZiBjb21wYXRpYmxlIG9mIHRoZSAic29j
IiBub2RlOg0KMS4gRm9yIGR0c2kgZmlsZXMgdXNlZCBmb3IgU29DcyBvdGhlciB0aGFuIGlteDht
IHNlcmllcyBTb0NzIGFuZCBvbGQgdmVyc2lvbiBkdHNpIGZpbGVzIHVzZWQgZm9yIGlteDhtIHNl
cmllcyBTb0NzLA0KY29tcGF0aWJsZSBvZiB0aGUgInNvYyIgbm9kZSBpcyAic2ltcGxlLWJ1cyIu
DQoyLiBGb3IgbmV3IHZlcnNpb24gZHRzaSBmaWxlcyB1c2VkIGZvciBpbXg4bSBzZXJpZXMgU29D
cywgY29tcGF0aWJsZSBvZiB0aGUgInNvYyIgbm9kZSBpcyB7ImZzbCxpbXg4bVgtc29jIiwic2lt
cGxlLWJ1cyJ9Lg0KDQoibnZtZW0tY2VsbCIgaXMgYW4gb3B0aW9uYWwgcHJvcGVydHkuDQoNCkkg
ZG8gbm90IHVuZGVyc3RhbmQgd2hhdCB5b3UgbWVhbi4gWW91IG1lYW4gdGhhdCBsaW1pdCB0aGUg
Y29tcGF0aWJsZSBvZiAic29jIiBub2RlIG11c3QgaW5jbHVkZSAiIGZzbCxpbXg4bVgtc29jIiBp
biBuZXcgdmVyc2lvbiBkdHMgZmlsZXMuIElzIG15IHVuZGVyc3RhbmRpbmcgY29ycmVjdD8NCg0K
QmVzdCByZWdhcmRzLA0KQWxpY2UNCg0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=
