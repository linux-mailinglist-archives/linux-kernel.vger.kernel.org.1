Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B980527C012
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 10:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbgI2IwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 04:52:23 -0400
Received: from mail-eopbgr140042.outbound.protection.outlook.com ([40.107.14.42]:10119
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725372AbgI2IwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 04:52:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CAcsr6JqThpUZqBOqh+NB86M7vCV2vvurr0xL9YY5d8rFx8cATlaSahXa4Ygckdy0J4QbsOfOd09u0NUILXShmXeX7bA84sfB8ErzfqTIbjwxZm36EGLz6pPRNMM5bAX0TU6mm2LsVWeJ1ARdf8ZgXM86ay/jacn1FWAS5upwcG4DiL+hAEkFW4FLoKvEhGOjiwW9l/9ZM2twqp891/Z90/uPbE/BjbrEmR/FwBSR/33FjERPtM8dFNFsjN0Gb4hYhCXXi/6h9Gg8yB6cL2ETATU25CPGha5nv6BAR2epRe81un6kkqd/CYw1oTaD1Wj6TzUZa9Zy4G6768YA7+ySg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DUDT1lLjkPXPf2bKauEls05Ve0xY0v6yTvqPFfqdoI=;
 b=HqXzhHqrkHXk2DEXCVp9mWqi5EWdPqauTrz96Y8SOoJUE8yebvlOKCULypc1BKEwrZIzmGw/ph26RTecxwgLlGBu6aeK+8Q8tFNinoHwBfn+Tg+7iHM1RaAT4mGtuFeQmSszHpWGBn189SWpFqHRn+9pN9kQht6UjMMEGYBQl0J3O7WIIbGLanDsb3kDcwTiYEoLokRo5581RrKg/FteoMpDcQYgTeAahUvFZHMVBGZDjDWeQddFDIhYUkGLbn039t47eKGX0nbEFfYUdcohJzAFa7kFUkS2BMT/GFIREnrh6cV6Z83a2P/xHZWG1PSbE7UsO+BTmwEW8wlMZTueZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DUDT1lLjkPXPf2bKauEls05Ve0xY0v6yTvqPFfqdoI=;
 b=THj/BvLyUcF6ja95ZjC7mGayFhHOED3R071qseRP5MGsI0yS6OsMzRSu4+YF+t33RJZr4toBGYMcegu6zye1aFJyWJ7DZawR4Zj4VL7eiu6QSx2wm+B1V10d5bAoz+wvK7/3myT0xDoj2qqxQ1Mi106sdmJ/Q+JuAC1tFeC3AoI=
Received: from AM6PR04MB4917.eurprd04.prod.outlook.com (2603:10a6:20b:1::27)
 by AM7PR04MB6984.eurprd04.prod.outlook.com (2603:10a6:20b:de::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23; Tue, 29 Sep
 2020 08:52:19 +0000
Received: from AM6PR04MB4917.eurprd04.prod.outlook.com
 ([fe80::8862:61c7:e29a:b886]) by AM6PR04MB4917.eurprd04.prod.outlook.com
 ([fe80::8862:61c7:e29a:b886%7]) with mapi id 15.20.3412.028; Tue, 29 Sep 2020
 08:52:19 +0000
From:   Jacky Bai <ping.bai@nxp.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] arm64: dts: imx8mp: adjust GIC CPU mask to match
 number of CPUs
Thread-Topic: [PATCH 3/3] arm64: dts: imx8mp: adjust GIC CPU mask to match
 number of CPUs
Thread-Index: AQHWljw1lDVkJRQtuUSo4C648CLUxKl/TUYQ
Date:   Tue, 29 Sep 2020 08:52:19 +0000
Message-ID: <AM6PR04MB49175C3F7455B26ED187E98C87320@AM6PR04MB4917.eurprd04.prod.outlook.com>
References: <20200929084015.7178-1-krzk@kernel.org>
 <20200929084015.7178-3-krzk@kernel.org>
In-Reply-To: <20200929084015.7178-3-krzk@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 203e86df-368a-4c84-f6f3-08d86454f98a
x-ms-traffictypediagnostic: AM7PR04MB6984:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM7PR04MB6984E72B7B6D8BB5B0648FDE87320@AM7PR04MB6984.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FXztMewi/boJwvm9J+94HgICtVU56sXBnCFUHvrAPrtl6cgpRQPEayIvP5eH4UHnb4GARHAIyf2tbfsiT1fCBBVUXNBVVc/B56eCe4trEpuA5jQZljpL9CsrBxyq/5TWn55JSbQycqzfaBncuWljDHD5X1xItg2R5fJ2py9PisRjsizjAjHXXokUbslTvTN1M99gyVT41erouwdiorGiwmVvbjQ+PzRiM8uB74T7UXX4nyuZh4MIeOfabH9yu20kZLyVxdoRPqoH4eRvDc3Glcq+yjyiFcpXhHKXA9kPEicF3q+u3gXKOaPxd7FjcaELtYPCtzo9lZA8f26A8rsotXjE8jXkNrBw2u/N+8jBRdb9b3iG5L2obApyPvGRRAwhSRmNq46pRommXag9lPTXv1WSaGjQvegx18A7401Cj/oqGEG/g+n7douZfnD9+ngE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4917.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(8936002)(66946007)(66556008)(64756008)(66446008)(66476007)(76116006)(71200400001)(52536014)(110136005)(9686003)(83380400001)(316002)(186003)(86362001)(5660300002)(33656002)(8676002)(478600001)(2906002)(55016002)(7696005)(6506007)(53546011)(26005)(32563001)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: T+cnp7LTMDZ4JtLpGkhVq8/uk2wd4OgZtZK33zYSKlwV5Giq2QQBzTwWP3cUNRamS8Z7mz1YlnR1Qie/AF1M5LynXJ3J15+7bcXCkUQK4KoBr0qpiQuFr0zLPeotXm7x+cZVLvq8hj4PRf4QPVMtq4A1bPg2W8dUCxdZxnaYNKHj7wbCVwjg4puusrSJJutV2rdVRD++uKKVfBSoUFOyVdx1sZ9TU0ZAryhe5y/Db5CTLHhugAoGXtKOA5ksTlm9WZ9PeUsztmrJ3cL/tRInYeP+GDFnczE/7eFRdBEudxBWBPmZnVLtonN4B8dCf1T9WL2kbYSSuYuCnsFizIQ0mXxbqZWELFCmkI/+qtRePrjg7syYMrnlJQGuymvQ8BAsC/69QQHFHcWUidCbn72YvERE64cC2+UmCEAj7YksNKNd/Cl/+PxUP1axK77ZT1yTMH0ehxOt6bnxLv+grSPACJVNGy0fNWTneTa/hMD+ZIsrz/yAN5JhsIR55TrblkLmUcJslmB/d37JE5rUB4ANgWDdBCL1uksHpEDSXOjwjuGsZ0UUNRm843vQX7V4KsnnP5KwhXYPz/QwcELpbkA1oyT3sNjd3kHc5LzubhEQWjcGzDAbpiVLJobG1rjqdSGCNMjacdG1WqtdgjHw4CGUWA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4917.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 203e86df-368a-4c84-f6f3-08d86454f98a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 08:52:19.8630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LfNroWeuulrKVcDWz5U01BfavJu7wk13+K06vEaebfZF/5dJS7F5dCe+E7TpxgcHifkYqecvgEyLZtMEnDfFEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6984
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IFttYWlsdG86a3J6a0BrZXJuZWwub3JnXQ0KPiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMjks
IDIwMjAgNDo0MCBQTQ0KPiBUbzogUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IFNo
YXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz47DQo+IFNhc2NoYSBIYXVlciA8cy5oYXVlckBw
ZW5ndXRyb25peC5kZT47IFBlbmd1dHJvbml4IEtlcm5lbCBUZWFtDQo+IDxrZXJuZWxAcGVuZ3V0
cm9uaXguZGU+OyBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+Ow0KPiBkbC1saW51
eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsgQW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5j
b20+Ow0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiBK
YWNreSBCYWkgPHBpbmcuYmFpQG54cC5jb20+OyBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtl
cm5lbC5vcmc+DQo+IFN1YmplY3Q6IFtQQVRDSCAzLzNdIGFybTY0OiBkdHM6IGlteDhtcDogYWRq
dXN0IEdJQyBDUFUgbWFzayB0byBtYXRjaA0KPiBudW1iZXIgb2YgQ1BVcw0KPiANCj4gaS5NWCA4
TSBQbHVzIGhhcyBmb3VyIENvcnRleC1BIENQVXMsIG5vdCBzaXguICBVc2luZyBoaWdoZXIgdmFs
dWUgaXMgaGFybWxlc3MNCj4gYnV0IGFkanVzdCBpdCB0byBtYXRjaCByZWFsIEhXLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwub3JnPg0KDQpG
b3IgdGhpcyBwYXRjaHNldA0KDQpSZXZpZXdlZC1ieTogSmFja3kgQmFpIDxwaW5nLmJhaUBueHAu
Y29tPg0KDQpCUg0KDQo+IC0tLQ0KPiAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14
OG1wLmR0c2kgfCA4ICsrKystLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCsp
LCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMv
ZnJlZXNjYWxlL2lteDhtcC5kdHNpDQo+IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
aW14OG1wLmR0c2kNCj4gaW5kZXggNjAzOGY2NmFlZmMxLi5jNjljMjA2MDY4YTQgMTAwNjQ0DQo+
IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC5kdHNpDQo+ICsrKyBi
L2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC5kdHNpDQo+IEBAIC0yMDIsMTAg
KzIwMiwxMCBAQA0KPiANCj4gIAl0aW1lciB7DQo+ICAJCWNvbXBhdGlibGUgPSAiYXJtLGFybXY4
LXRpbWVyIjsNCj4gLQkJaW50ZXJydXB0cyA9IDxHSUNfUFBJIDEzIChHSUNfQ1BVX01BU0tfU0lN
UExFKDYpIHwNCj4gSVJRX1RZUEVfTEVWRUxfTE9XKT4sDQo+IC0JCQkgICAgIDxHSUNfUFBJIDE0
IChHSUNfQ1BVX01BU0tfU0lNUExFKDYpIHwNCj4gSVJRX1RZUEVfTEVWRUxfTE9XKT4sDQo+IC0J
CQkgICAgIDxHSUNfUFBJIDExIChHSUNfQ1BVX01BU0tfU0lNUExFKDYpIHwNCj4gSVJRX1RZUEVf
TEVWRUxfTE9XKT4sDQo+IC0JCQkgICAgIDxHSUNfUFBJIDEwIChHSUNfQ1BVX01BU0tfU0lNUExF
KDYpIHwNCj4gSVJRX1RZUEVfTEVWRUxfTE9XKT47DQo+ICsJCWludGVycnVwdHMgPSA8R0lDX1BQ
SSAxMyAoR0lDX0NQVV9NQVNLX1NJTVBMRSg0KSB8DQo+IElSUV9UWVBFX0xFVkVMX0xPVyk+LA0K
PiArCQkJICAgICA8R0lDX1BQSSAxNCAoR0lDX0NQVV9NQVNLX1NJTVBMRSg0KSB8DQo+IElSUV9U
WVBFX0xFVkVMX0xPVyk+LA0KPiArCQkJICAgICA8R0lDX1BQSSAxMSAoR0lDX0NQVV9NQVNLX1NJ
TVBMRSg0KSB8DQo+IElSUV9UWVBFX0xFVkVMX0xPVyk+LA0KPiArCQkJICAgICA8R0lDX1BQSSAx
MCAoR0lDX0NQVV9NQVNLX1NJTVBMRSg0KSB8DQo+IElSUV9UWVBFX0xFVkVMX0xPVyk+Ow0KPiAg
CQljbG9jay1mcmVxdWVuY3kgPSA8ODAwMDAwMD47DQo+ICAJCWFybSxuby10aWNrLWluLXN1c3Bl
bmQ7DQo+ICAJfTsNCj4gLS0NCj4gMi4xNy4xDQoNCg==
