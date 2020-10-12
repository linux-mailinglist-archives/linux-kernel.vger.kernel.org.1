Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA27728B4BB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 14:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbgJLMij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 08:38:39 -0400
Received: from mail-db8eur05on2082.outbound.protection.outlook.com ([40.107.20.82]:12608
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726348AbgJLMii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 08:38:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+P8c36vy22Q6t0WOr1pxHNRPqbfjuhcLY18aq3ry6r9OZlIg/Uk8B3lX5umfcPcRkBXvHGWLFOc16nwmg9PS4nQWdxUXXWUFCcdmzgr8MgsEQWVXYHLn4Rx194uE5LUD3c4BSDx4PLDxF/xdRG4WOLwhBfblkO3/beU8qi3ohuhz3RPM6ZhLdDycbMFfRB4XGN43nyDk7vvZX3FrKqycoBRxl5pz6jCQEX0FS+e86qJ/tUM4ZQmO2VnSUlse4LbrqoLjFMEkkBQQKxfvHpBld6n6Jhcya93OpqlGPaVH7e5X1d94122JZBo4kiAnx1v0wQqJEC1burE8c1omXGB6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8T8b7Vvi5ELDfKYU2vLzEXAJTB807HEJsn0TBoB3Ms=;
 b=LIgjWNgK1qm6oijUzT5z8uWoIQkYYrvu3RryapgJOA8dm6Sm2D6G/gQAQ2uuQKRYip9NC8tYDjJT0G6dH+t36nbAsrxjO7fmfcjxXZQvg7vHrWr3J6gCN1gD8M/9eoHSKj1cpNROzn4QVEChj3BkkHVzAtJWyzP5UUTNVGk02B4PFrXJn6RLC183U+9QnNYxHUp5l6Jk6e1zn6mEhgVFBD3Z4OKvPAS5l1/zsUUZyOTKoXxYIevyOLv7wBE+kqKwBWKj5pUGh7qXjHpvDwA6yGPt+UPagrJVgfsHo+/IVATQjchp06B/nPOQrSFTPt/pE/Z2ttbJBhhlcLdyrd17sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8T8b7Vvi5ELDfKYU2vLzEXAJTB807HEJsn0TBoB3Ms=;
 b=R83xZz9nEmZwPafkOA0eI+PNVRfaW86R4ULZAQeXigxmG0TcdEgVupA2zfa56Ang0hjQz9joQHxrdoa88krtliuNQ+mrgSj99FBDKxSihvPnBkcfgjmM4s6xP41Q3V/ZRFYmP8S0XUv51WZS60Qe+VO/UY2By7gxxeGS0irCCss=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB7PR04MB4940.eurprd04.prod.outlook.com (2603:10a6:10:22::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.28; Mon, 12 Oct
 2020 12:38:34 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::b039:ef5c:7b37:9901]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::b039:ef5c:7b37:9901%7]) with mapi id 15.20.3455.030; Mon, 12 Oct 2020
 12:38:34 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "aford173@gmail.com" <aford173@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Peter Chen <peter.chen@nxp.com>,
        "alifer.wsdm@gmail.com" <alifer.wsdm@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>, Robin Gong <yibin.gong@nxp.com>,
        Jun Li <jun.li@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/3] arm64: dts: imx8mm: Correct WDOG_B pin configuration
Thread-Topic: [PATCH 1/3] arm64: dts: imx8mm: Correct WDOG_B pin configuration
Thread-Index: AQHWnhEidVwnMy9d2USIkaxNNqUMoKmTjG0AgABfZcA=
Date:   Mon, 12 Oct 2020 12:38:34 +0000
Message-ID: <DB3PR0402MB3916DF1213556C1187F5EB32F5070@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1602229667-13165-1-git-send-email-Anson.Huang@nxp.com>
 <CAJKOXPdwsoN1Dnqs9gZTibqoy5vRTPwpLLmohHoguSCiq+UWHA@mail.gmail.com>
In-Reply-To: <CAJKOXPdwsoN1Dnqs9gZTibqoy5vRTPwpLLmohHoguSCiq+UWHA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c2790cfd-09e1-4cd2-056a-08d86eabbbeb
x-ms-traffictypediagnostic: DB7PR04MB4940:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB4940DAD6EA57CFD5FBB6C107F5070@DB7PR04MB4940.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FaBoeo0xIwRW7+f+A6IrK603PwJ3YMVe+8c2Uzq+N/kBPTNs2ufNiukf+X1wzK1HQv05TutsUYfPAeiTq5DJ25FD2vUn6qCohMrebBE/aMOl/n+5+YjYHtDWlFlpcjohDIqsH6ZNgKswZP8Kic8C00SLrH2LRx19hZH5686I1RwPwyzZAIzKqHVeOeb6hW/8cQO43KRyMN1PtmmGRvuefUCLtB31GXZsQkreFYZL5g8l55I5O3yL7EMeOfu4h6dKrJULWAUz0QDdRjsQv65oyANnjel8q7q3fT1a99LEH7LUY5oa9irHelE06ht5YwLeGBiPlRxPWQTdzYQKuOifTyghQu7SJ0ZqsOsB48V5GW8quvfLLE2npnr3s1g7024P
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(7696005)(478600001)(316002)(186003)(44832011)(86362001)(83380400001)(6916009)(9686003)(26005)(6506007)(2906002)(71200400001)(7416002)(5660300002)(8936002)(76116006)(66946007)(66476007)(66556008)(64756008)(66446008)(52536014)(55016002)(8676002)(4326008)(33656002)(54906003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 4qebuksCHvmhctOnjgDlARi32zsvunSr+AunIQO+OPozPt+WjeJA4dwX6nXY3qDztoC99cwhoDK79EZ4KpGwxY7mJzJWVdmXUzhl3nNx7yun2H5fNBjOsXVRJP67ItGP49PHg/pWpaut+a0r1qJrdi2Svmm3GGh0VpUubqT38L4fgd+9tYuu/6SricsIcW8ITPMfDByEoBw3o+5pOyCKUjaQaWDxXF+rKR9gcdjRrlyzncCJhB1wySZiBFx+RO+Wvxoyyjj3JciChSQRbwbcAmktWeYbGx4SRc3vb960UTqyVVzf29NAy7WOef7CIAEq+X1LkF6IZnBcea6mXIjE1ipMM8EaPvWspe1fSU9rFWVmylit11UEYQnllz6t5rWsoBDTTeapPkELOuQr0TkVePr4RE4zuqJXef5Dd8uLSlT6kG5H5zR2nETBVTZjY2SIipCzlJwlFxkv3NB7FkyDoTWHG7Vzek0cmhuvVH31wdMYOCMCYZYcV04G7jzYLcf1QaRq5fflWnGg1XqmtpQJSQ3fgTWDj2NPa0j4tXfv5iRRemkkyzYne9UAu5nSUJ1gqnACyGbdQrtIacTkW0mAbukR4Z7IvC7MSDA9uBvUZ0OMwjbBpItkjFClLLvNPocfwmHsKmaO53yxNpf4aHJ/9Q==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0402MB3916.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2790cfd-09e1-4cd2-056a-08d86eabbbeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2020 12:38:34.3260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GMkiyojZIqHS+un8DwKw9L8bkCnegqA6/j9aVKaLJsfaVAlPitPkYVIY1LxQPA6613Zt/RVP3+3Edq75kULHkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4940
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEtyenlzenRvZg0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8zXSBhcm02NDogZHRzOiBp
bXg4bW06IENvcnJlY3QgV0RPR19CIHBpbg0KPiBjb25maWd1cmF0aW9uDQo+IA0KPiBPbiBGcmks
IDkgT2N0IDIwMjAgYXQgMDk6NTIsIEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPiB3
cm90ZToNCj4gPg0KPiA+IERpZmZlcmVudCByZXZpc2lvbiBvZiBpLk1YOE1NIEVWSyBib2FyZHMg
bWF5IGhhdmUgZGlmZmVyZW50IGV4dGVybmFsDQo+ID4gcHVsbCB1cCByZWdpc3RvciBkZXNpZ24s
IHNvbWUgYXJlIGVuYWJsZWQgd2hpbGUgc29tZSBhcmUgTk9ULCB0byBtYWtlDQo+ID4gc3VyZSB0
aGUgV0RPR19CIHBpbiB3b3JrcyBwcm9wZXJseSwgYmV0dGVyIHRvIGVuYWJsZSBpbnRlcm5hbCBw
dWxsIHVwDQo+ID4gcmVzaXN0b3IuIFNpbmNlIGVuYWJsaW5nIGludGVybmFsIHB1bGwgdXAgcmVz
aXN0b3IgaXMgTk9UIGhhcm1mdWwgYW5kDQo+ID4gaGF2aW5nIGJlbmVmaXQgb2YgZmxleGliaWxp
dHkgb24gZGlmZmVyZW50IGJvYXJkIGRlc2lnbiwganVzdCBlbmFibGUNCj4gPiBpdCBmb3IgYWxs
IGkuTVg4TU0gYm9hcmRzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFu
c29uLkh1YW5nQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL2lteDhtbS1iZWFjb24tc29tLmR0c2kgfCAyICstDQo+ID4gIGFyY2gvYXJtNjQvYm9v
dC9kdHMvZnJlZXNjYWxlL2lteDhtbS1ldmsuZHRzaSAgICAgICAgfCAyICstDQo+ID4gIGFyY2gv
YXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS12YXItc29tLmR0c2kgICAgfCAyICstDQo+
ID4gIDMgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS1i
ZWFjb24tc29tLmR0c2kNCj4gPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDht
bS1iZWFjb24tc29tLmR0c2kNCj4gPiBpbmRleCA2ZGU4NmE0Li5hOTQxMzAxIDEwMDY0NA0KPiA+
IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS1iZWFjb24tc29tLmR0
c2kNCj4gPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tYmVhY29u
LXNvbS5kdHNpDQo+ID4gQEAgLTM5OCw3ICszOTgsNyBAQA0KPiA+DQo+ID4gICAgICAgICAgICAg
ICAgIHBpbmN0cmxfd2RvZzogd2RvZ2dycCB7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ZnNsLHBpbnMgPSA8DQo+ID4gLQ0KPiBNWDhNTV9JT01VWENfR1BJTzFfSU8wMl9XRE9HMV9XRE9H
X0IgICAgICAgICAgICAweGM2DQo+ID4gKw0KPiBNWDhNTV9JT01VWENfR1BJTzFfSU8wMl9XRE9H
MV9XRE9HX0IgICAgICAgICAgICAweDE2Ng0KPiANCj4gRW5hYmxpbmcgcHVsbCB1cCBtYWtlcyBz
ZW5zZSBidXQgeW91IGNoYW5nZSBvdGhlciBiaXRzIC0gZGlzYWJsZSBTY2htaXR0IGlucHV0DQo+
IGFuZCBlbmFibGUgb3BlbiBkcmFpbi4gVGhpcyBjaGFuZ2UgaXMgbm90IGRvY3VtZW50ZWQgLyBl
eHBsYWluZWQgaW4gY29tbWl0DQo+IG1zZy4NCg0KVGhlIFNjaG1pdHQgaW5wdXQgaXMgTk9UIG5l
Y2Vzc2FyeSBmb3IgV0RPR19CIHBpbiB3aGljaCBpcyBmb3Igb3V0cHV0IE9OTFkuDQpUaGUgb3Bl
biBkcmFpbiBpcyB0byBsZXQgcHVsbCB1cCB2b2x0YWdlIHRvIGRlY2lkZSB0aGUgYWN0dWFsIG91
dHB1dCB2b2x0YWdlLA0Kc28gaXQgaXMgTk9UIGhhcm1mdWwgZm9yIFdET0dfQiBwaW4sIGhlbmNl
IHdlIHNldCBpdCB0b2dldGhlci4NCkkgd2lsbCBzZW5kIGEgVjIgcGF0Y2ggdG8gYWRkIHRoZXNl
IGluZm8gaW4gY29tbWl0IG1zZy4NCg0KVGhhbmtzLA0KQW5zb24NCiANCg0K
