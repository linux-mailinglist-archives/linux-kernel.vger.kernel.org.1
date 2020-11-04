Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621E42A5F10
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 09:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbgKDIEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 03:04:44 -0500
Received: from mail-vi1eur05on2052.outbound.protection.outlook.com ([40.107.21.52]:38089
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726152AbgKDIEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 03:04:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UtHDfd193Q2FjJPtbhCo3U2IF5iPDPLH/I4KvVDvJ10N4fZzjdbnNZzLrRnzqwYHPoGZZId7hkf5ozv403Ma050vXODOM+aB5uEVykvBnZWgNh6kCbbXsyIJTY4ViyIwgj5h3+4cfoR8swV6rfGuNRQIIcPadgRoSr734cypf+kFiue1+vbokRAZGqu3xMUJF5J2yLHRrGig+S1E8UW0Mv5pGKV4iYa/CXq8C9VdCzLU615FduKd0J/6wYML2WIRi9D4vL6PrceOTEo337RDudWhTk1oyrFgHSvIHI4a2vLXssNvnwbOcRNEAgiCeF/sAtz7pDvhAbiMxrBA2W7BKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOfBnBwAZuV4AtrBxpzTl664ivFoc0UKSGDqbsE/CNo=;
 b=oBU86RCPVo0oGUUmUIlTN6RmjfCUD5ky77flU1DPwPv/asljLJ7ANlWZ+8eX8OTsT6GPMGUknH7Db9UpT+6KWZdU66Xmzns7FVE+ADZlYbHZN3HoFWaNfABf6ST1zx+fa9NuGCLLVtfv2XXTQ4naOYgKs4nPSMGVsezF1iUM041Xzvmn0pTm+AquF05popSEQmSLUuZ4+2PxKGOkUcBKWr76LCZoEUiyOMGKbKFzKOPerW7js3mnY1ctyvrdos3voQ3s20nqLCxMz9PjERpOkx/K78FMuWlNvuyGp2C4of28Oadxw/n/XlViInNV61uQRrv2RHcMbDv6uisbhI8oFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOfBnBwAZuV4AtrBxpzTl664ivFoc0UKSGDqbsE/CNo=;
 b=U0lZe3SrI3in4O7do5dbKr9jmCa9QXrUIsVcsGz46fgb3nn4Of3xffLVCEclOp1Oh/MTzi9nNu+kLeEPX56S0rM6/ie9w+xsr8hvAkaFGevI+LoigXDyBEXq1xUuMUDRLDxV3K4Sexiue9ygvwgwN5IZc4gEb1qfS6InM2BStls=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DBBPR04MB7593.eurprd04.prod.outlook.com (2603:10a6:10:20c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Wed, 4 Nov
 2020 08:04:39 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::ec42:b6d0:7666:19ef]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::ec42:b6d0:7666:19ef%8]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 08:04:39 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Alice Guo <alice.guo@nxp.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v1 1/4] LF-2571-1: dt-bindings: soc: imx8m: add DT Binding
 doc for soc unique ID
Thread-Topic: [PATCH v1 1/4] LF-2571-1: dt-bindings: soc: imx8m: add DT
 Binding doc for soc unique ID
Thread-Index: AQHWsleZjv/BdR8iX0+npfVuvnx3Zqm3m+GAgAAA8EA=
Date:   Wed, 4 Nov 2020 08:04:39 +0000
Message-ID: <DB6PR0402MB27608D5A8A11C2D3779C4D0188EF0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20201104030645.12931-1-alice.guo@nxp.com>
 <20201104030645.12931-2-alice.guo@nxp.com>
 <CAJKOXPd_sArJ5-Ka2btZNxn3aBGFioDGOmQKbqeVNgtpUZUw=A@mail.gmail.com>
In-Reply-To: <CAJKOXPd_sArJ5-Ka2btZNxn3aBGFioDGOmQKbqeVNgtpUZUw=A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 70c87391-55d6-4049-0e33-08d8809847bb
x-ms-traffictypediagnostic: DBBPR04MB7593:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DBBPR04MB75931964BC33256536601ACD88EF0@DBBPR04MB7593.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: et0PWLSsSHI35CP+NXdWluC4KYkQTyia7h0AvUsfqDdw27KRBj/DoKBSGx7/E1MjXZ1Wrj4fQFMlulJZwEA0jPcCgehsEI6ncposXv6j3TAH5xpnr9cxsyHKEzYnJF/tACwiN7gclovMOTf8DVKZdUWsbz5C3WRqZSp5wdq/c+hFkIQuVABoVDO0cYm6FmBEVC39dQhqVYBryRBOZoij4sduEfVjQRUiz+1Ct+BIAQgl7r6JjMTS5OzKkUDmKnAuP9+Hlqc5beX1q6SFhtDZAeoM2ZYb3bi2rEFEJHX5T7W5yZ/aP6J/kYaHIr+rXu+yy5PJV1Y+ieLf39IMc21vGplWnje3Bk6kXY35dQdOWzNJjeZKAqLM13YPCewi6K/zXOIpYX3WipFy3uahk6m7NkFQC8tzFQSwk3NQqttrsBCzPh4H4lztHpCRZnTVyQH0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(52536014)(54906003)(8936002)(8676002)(110136005)(186003)(5660300002)(4326008)(316002)(6636002)(6506007)(44832011)(2906002)(55016002)(26005)(76116006)(64756008)(7696005)(9686003)(45080400002)(86362001)(66946007)(33656002)(66446008)(478600001)(66476007)(71200400001)(66556008)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ftOObLlCGlcMS6rOPqf05TQj3mNU2gU4CyR3RK8joFf4v9s6oUKfsK1EtnI+Dhi7ZuLkn6+qQwJ96qVNtnCktfi7XAxL515ddt1PXh9v5yH+Og8Hp6XIrSaXISbf0bNHFmbvPgHcE4umC+3grjYHXSIgfG5WMQU6kfdRxdY1o16feEkqO5U3K8WbSa7wEeS4ATM4oONfGdv9FasbsvZxxUvLtp8r48iUIxm01D7i7dtBbTq/P4GpeGN5elez2JkhkZe+LJ0I+zOqLtn7wimq9TEQgWFL1tAy4I0dv49yrwmwtk417az7sj+yec/czejWYXk5QFBrBBKCHZPuFuRQTtFJkoM0969N1yyFpGKH2GyzJbMpeq3yxnjqxDA8iDKpzx9SGEaDBfUEAX6fGblhjWF3DDJKe+kVQSr2vfDq04glNhs9LYEAB4yaeUVvak6vsm9L5iB33QsxgvbVFTK+2bNYdSoTFPzCJxTTvseYn32UXX7HVKwbbp0fw1Sa1RWCwg78tVvB/t1w13WBDqmzTdzeb+C5DfatMK1SvtBzJysA0g/lQR17sQn1FK73NMXa/BZ9tCmjd4LneufJS7GzOAzi0IbGsA+ZKKMmpxl+WFCZyDJSLgZ9k48MYPtE3pjzK+fgVxDycjMpW249hgLqdA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c87391-55d6-4049-0e33-08d8809847bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2020 08:04:39.8981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0wjj2ENSnxgbWuXcahkVDLzARtvR0QnvNP+n4wmW9SDEEDMOv6nHa3jjPMqNff3UANPP9dhi6fgFH0TRs5Qy6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7593
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDEvNF0gTEYtMjU3MS0xOiBkdC1iaW5kaW5nczogc29j
OiBpbXg4bTogYWRkIERUDQo+IEJpbmRpbmcgZG9jIGZvciBzb2MgdW5pcXVlIElEDQo+IA0KPiBP
biBXZWQsIDQgTm92IDIwMjAgYXQgMDQ6MDksIEFsaWNlIEd1byA8YWxpY2UuZ3VvQG54cC5jb20+
IHdyb3RlOg0KPiA+DQo+ID4gQWRkIERUIEJpbmRpbmcgZG9jIGZvciB0aGUgVW5pcXVlIElEIG9m
IGkuTVggOE0gc2VyaWVzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQWxpY2UgR3VvIDxhbGlj
ZS5ndW9AbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2JpbmRpbmdzL3NvYy9pbXgvaW14OG0t
dW5pcXVlLWlkLnlhbWwgICAgIHwgMzINCj4gKysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZp
bGUgY2hhbmdlZCwgMzIgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4g
PiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL2lteC9pbXg4bS11bmlxdWUt
aWQueWFtbA0KPiA+DQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3NvYy9pbXgvaW14OG0tdW5pcXVlLWlkLnlhbWwNCj4gPiBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvaW14L2lteDhtLXVuaXF1ZS1pZC55YW1sDQo+
ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLmYxZTQ1NDU4
Y2VjNw0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3Mvc29jL2lteC9pbXg4bS11bmlxdWUtaWQueWFtbA0KPiA+IEBAIC0wLDAgKzEs
MzIgQEANCj4gPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiA+ICslWUFN
TCAxLjINCj4gPiArLS0tDQo+ID4gKyRpZDoNCj4gPiAraHR0cHM6Ly9ldXIwMS5zYWZlbGlua3Mu
cHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHAlM0ElMkYlMkZkZXZpDQo+ID4NCj4gK2Nl
dHJlZS5vcmclMkZzY2hlbWFzJTJGYXJtJTJGbnhwJTJGaW14OG0tdW5pcXVlLWlkLnlhbWwlMjMm
YW1wDQo+IDtkYXRhPTANCj4gPg0KPiArNCU3QzAxJTdDcGVuZy5mYW4lNDBueHAuY29tJTdDY2Qy
M2I0YzhmNjFjNGNlYTVmZWMwOGQ4ODA5Nzc0YjcNCj4gJTdDNjg2ZQ0KPiA+DQo+ICthMWQzYmMy
YjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2Mzc0MDA3MzUyODI2MzQxMTklN0MNCj4g
VW5rbm93biU3DQo+ID4NCj4gK0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJ
am9pVjJsdU16SWlMQ0pCVGlJNklrMWhhVw0KPiB3aUxDSlgNCj4gPg0KPiArVkNJNk1uMCUzRCU3
QzEwMDAmYW1wO3NkYXRhPUk4SWN5U1dZQW1GaGxtN3hOb1V5cHR4UjJjeE1BZlkNCj4gQVB2NmJm
JTJCcA0KPiA+ICtjSEc4JTNEJmFtcDtyZXNlcnZlZD0wDQo+ID4gKyRzY2hlbWE6DQo+ID4gK2h0
dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwJTNB
JTJGJTJGZGV2aQ0KPiA+DQo+ICtjZXRyZWUub3JnJTJGbWV0YS1zY2hlbWFzJTJGY29yZS55YW1s
JTIzJmFtcDtkYXRhPTA0JTdDMDElN0NwZQ0KPiBuZy5mYW4lDQo+ID4NCj4gKzQwbnhwLmNvbSU3
Q2NkMjNiNGM4ZjYxYzRjZWE1ZmVjMDhkODgwOTc3NGI3JTdDNjg2ZWExZDNiYzJiNGM2DQo+IGZh
OTJjZDkNCj4gPg0KPiArOWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM3NDAwNzM1MjgyNjM0MTE5JTdD
VW5rbm93biU3Q1RXRnBiDQo+IEdac2IzZDhleUpXSQ0KPiA+DQo+ICtqb2lNQzR3TGpBd01EQWlM
Q0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTcNCj4gQzEwMDAm
DQo+ID4NCj4gK2FtcDtzZGF0YT1tOFQ0VUFPSW4zZkRoTzVPVXJYeWdUJTJCUm13d1pYUVc5ZEM1
ekZRYVhsOVElMw0KPiBEJmFtcDtyZXNlcnYNCj4gPiArZWQ9MA0KPiA+ICsNCj4gPiArdGl0bGU6
IE5YUCBpLk1YOE0gUGxhdGZvcm1zIERldmljZSBUcmVlIEJpbmRpbmdzDQo+IA0KPiBUaGlzIGlz
IG5vdCBhIHRpdGxlIGZvciB0aGVzZSBiaW5kaW5ncy4gUGxlYXNlIGRlc2NyaWJlIHRoZSBiaW5k
aW5ncyBmb3IgdGhpcw0KPiBkZXZpY2UuIEJhc2VkIG9uIGRlc2NyaXB0aW9uLCB0aGlzIG1pZ2h0
IGNvdWxkIGdvIHRvIGJpbmRpbmdzL252bWVtDQo+IGRpcmVjdG9yeS4NCg0KSXQgbWlnaHQgYmUg
bWlzbGVhZGluZyBoZXJlLiBJIHRoaW5rIHRoZSBiaW5kaW5ncyBpcyBmb3IgU29DLCBqdXN0IGxp
a2UNCiJhcm0scmVhbHZpZXctZWItc29jIiBpbg0KRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2FybS9hcm0scmVhbHZpZXcueWFtbA0KDQpSZWFkaW5nIHRoZSBwYXRjaCwgaXQgaXMg
dG8gY29udmVydCBzb2MtaW14OG0uYyB0byBwbGF0Zm9ybSBkcml2ZXIsDQpzbyBuZWVkIHRvIGFk
ZCBhIGNvbXBhdGlibGUgc3RyaW5nIGZvciB0aGUgc29jIGRldmljZSwNCkkgdGhpbmsgRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mc2wueWFtbCBzaG91bGQgYmUNCmEgYmV0
dGVyIHBsYWNlLg0KDQpSZWdhcmRzLA0KUGVuZy4NCg0KPiANCj4gPiArDQo+ID4gK3Byb3BlcnRp
ZXM6DQo+ID4gKyAgY29tcGF0aWJsZToNCj4gPiArICAgIG9uZU9mOg0KPiANCj4gTm8gbmVlZCBm
b3Igb25lT2YuDQo+IA0KPiA+ICsgICAgICAtIGl0ZW1zOg0KPiA+ICsgICAgICAgICAgLSBlbnVt
Og0KPiA+ICsgICAgICAgICAgICAgIC0gZnNsLGlteDhtbS1zb2MNCj4gPiArICAgICAgICAgICAg
ICAtIGZzbCxpbXg4bW4tc29jDQo+ID4gKyAgICAgICAgICAgICAgLSBmc2wsaW14OG1wLXNvYw0K
PiA+ICsgICAgICAgICAgICAgIC0gZnNsLGlteDhtcS1zb2MNCj4gPiArICAgICAgICAgIC0gY29u
c3Q6IHNpbXBsZS1idXMNCj4gPiArDQo+ID4gKyAgbnZtZW0tY2VsbHM6DQo+ID4gKyAgICBtYXhJ
dGVtczogMQ0KPiA+ICsgICAgZGVzY3JpcHRpb246DQo+ID4gKyAgICAgIFJlZmVyZW5jZSB0byBh
biBudm1lbSBub2RlIGZvciB0aGUgU09DIFVuaXF1ZSBJRC4NCj4gDQo+IE1pc2xlYWRpbmcgZGVz
Y3JpcHRpb24gLSBudm1lbS1jZWxscyBkbyBub3QgY29udGFpbiBhIHJlZmVyZW5jZS4gSnVzdCBz
a2lwIGl0LA0KPiBudm1lbS1jZWxscyBzaG91bGQgYmUgb2J2aW91cyBmcm9tIHRoZSBudm1lbSBw
cm92aWRlciBiaW5kaW5ncy4NCj4gDQo+ID4gKw0KPiA+ICsgIG52bWVtLWNlbGxzLW5hbWVzOg0K
PiA+ICsgICAgY29uc3Q6IHNvY191bmlxdWVfaWQNCj4gDQo+IGFkZGl0aW9uYWxQcm9wZXJ0aWVz
OiBmYWxzZQ0KPiANCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo=
