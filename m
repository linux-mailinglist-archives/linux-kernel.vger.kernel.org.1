Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE392AB594
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 11:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgKIK5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 05:57:09 -0500
Received: from mail-eopbgr00044.outbound.protection.outlook.com ([40.107.0.44]:9295
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727303AbgKIK5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 05:57:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESfA+BhQEJ85jS8kpNodIA1eG/LsA32sg0945IXpT9JJxBSXGvCzGTs3g2bgiXmuGY6OCgpoRuGyft+/oaY7Sse6pKtGz/yeSw+k/1Bex/Zq0a+wnyczIqBfr9ABQRyKT6xvJrQpyYdF2iD17RPDweaNWrSMv2VJiChcAnfi106m8bGGrwzvA3YaHigvHhgrvRUdDGtB+pUIwnq8AHylBufTEoZtDA7weRWE2h7h8tNiUD79nDDGlTQiSQbN5ABecOjFYJdJgBUn3qSMMIzJER505KscDOuyFg6GIec+yCQFgCA4F5FICkdcOIMX6X6hpcRJD+j0yPdQxeZQFXjIJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOcEwvn+lAmOBSd5dACMEbCiMmn2NKsTH/onGPFgGc8=;
 b=hsjTtYNWZqNosTMACxepICPeiA+yCgsDJ8jhJ3yTeJb2y3eWn94yzD/qqAu5n0NN3fpgbE+kaRMz9qEQ+h9EozdLo9Rwd3C9+EGQcb3cW4dZfjWyq58guuivkB9/9+84u3ZRJm90+YQCiCr72fXcNIbzODUA1iAZYk0p6pcoLamDPIWMUT8GgYxMSi1LnzefNUefeNoOEKUmTZyHNrRpsvP822y1Ya3BO013yKM+qESK/6WBZt/jiS5zBH9jK1dHQY4bjspmc5PzdErwRE+P3Q5HXb/AwNaYWSmgs5AWqten/esfOJN2NxCaulcP7ooDTHvdlcdqOzsccDLjHXc41A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOcEwvn+lAmOBSd5dACMEbCiMmn2NKsTH/onGPFgGc8=;
 b=V4Tt+pFokoXZH7nDsuo12GzRprygHm9/3UIhN678ZX41uQv0PsvEcFk2X8dUXffwXo93gyXGZ5xtIvYekGvSyEPTE5O8x/qaM96cG0hR51ZLZguGEhW7muxscxZbvr1IF1+Q/3aPJ3TpuHpNdMyf1SslucmJIe1N6lM8Jn7KYkQ=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR0402MB3446.eurprd04.prod.outlook.com (2603:10a6:209:6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 9 Nov
 2020 10:57:05 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::546f:92f0:f3c5:a148]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::546f:92f0:f3c5:a148%7]) with mapi id 15.20.3499.032; Mon, 9 Nov 2020
 10:57:05 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
CC:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: RE: [PATCH RESEND] driver core: export device_is_bound() to fix build
 failure
Thread-Topic: [PATCH RESEND] driver core: export device_is_bound() to fix
 build failure
Thread-Index: AQHWtVhC0iFw3JVhoky1GSU0i1GD9am95iCAgAGxewCAAAY6gIAAATqA
Date:   Mon, 9 Nov 2020 10:57:05 +0000
Message-ID: <AM6PR04MB4966B90C0DEC71A6C86067AA80EA0@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <20201107224727.11015-1-sudipm.mukherjee@gmail.com>
 <20201108082317.GA40741@kroah.com>
 <CADVatmN8SbZWVGf_xe_K1g7M9ArHXF8TUhYyBgQcydBF4_zp9g@mail.gmail.com>
 <20201109103703.GA1310551@kroah.com>
In-Reply-To: <20201109103703.GA1310551@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e9d44e26-3d50-4564-0145-08d8849e3264
x-ms-traffictypediagnostic: AM6PR0402MB3446:
x-microsoft-antispam-prvs: <AM6PR0402MB3446A42AD0C33503ADD21D3180EA0@AM6PR0402MB3446.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qEOfDvkht8xyzYF4pFncH0QS5A99HjE9Rzv0BqSke7tnSnwqjsJoscZAcC3JBq79Wma+a+mTCiktHduM7N+zs3wdDazpUHVWS8lt7Iq8nSJRCZ+ZGY4qgCdPLSxG1Arz0qSoqYW6pSK9/gOizDIi5sdzXp2eG0emrXbYjKp4nSnIrOqRyfRawo+DnDjQwVU4Chqc0r7urEVKZnjhCykhVC6EzD15hEsG5zhT+0S3nonrANUR7Rc7IRSE63S6y8skr+Aa9KcuoSzVySA3X6KRzI1wrcah5u6yiz7gzansE+uwGmC+8xds9Cnph3Xwifca
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(66946007)(9686003)(8936002)(478600001)(186003)(71200400001)(66556008)(5660300002)(33656002)(53546011)(6506007)(52536014)(54906003)(66476007)(83380400001)(86362001)(64756008)(110136005)(44832011)(8676002)(7696005)(76116006)(316002)(55016002)(2906002)(4326008)(26005)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: hJbTP3NzXBpzxv5E9uZLUjhm3NJ5x0fGv9PvrDLc5GyL2Derl37kh3yXgiuI6MoQOB2YTdVay2JjY0EZlInpzsazzimeqjXoi3rgP3K/wCmdDrpRSbRf6q2qMH6WDmrJO2SYgAKHdTVP2zUfmNurGOi9E5BtNCHYX4Uy2cY/Wj+fzeOX1nvl4WjU1sdIXdQuWU7zQN1Ajbs5yWt/QwA4n+gBu6DU7nxpKfakGdwEbS72tQAgTdLW4MfU0uuA/H4oJAb8Bnvw1mis9ma0gQSFR1et4ntaWTn/ZUtMmStk24h3KXsAs7mvYM8HcOZq8nIN1sLd3lgYkkXI9XOOML/AfP9EoNhUHX6ESVKDOnYpbxcGsglh5h6WqJFHG3qr9hBxy5ApclrOs+OrWO6u1S6bFiEhiVfMb+IeLXaSQ8g++cyL6XPLA45i2xMTtBT061xMbqsnrg/B7H2UWozuXjs2OXVyjJDVLvSsyLEQPL5Y6jRQGEkLBaBce/YtYvb9TKtC2a67LxelOZId1o3Ui2xVrwUjYe2vzUzsAgUrX5bf2cDTtcL6by5pXou1u2ttz9HJSg2Y1dDjkRAwhysPgXfN6XPkXn1LQ4M89WHxrdud6pUIO1FnS3Z0yaMzR6feBd3OBDIW7HEYlm/+MJxkIh3wtQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d44e26-3d50-4564-0145-08d8849e3264
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2020 10:57:05.7269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d5K68uYeXoZ0EU3MkWgJj5c3cPtOEgAEqUQ/jAtwcPWlRnprdb1zUNIdtw+okS8ewci0N+pi6p2a8Gr65hPq1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3446
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3JlZywNCg0KPiBGcm9tOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5k
YXRpb24ub3JnPg0KPiBTZW50OiBNb25kYXksIE5vdmVtYmVyIDksIDIwMjAgNjozNyBQTQ0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIFJFU0VORF0gZHJpdmVyIGNvcmU6IGV4cG9ydCBkZXZpY2VfaXNf
Ym91bmQoKSB0byBmaXggYnVpbGQNCj4gZmFpbHVyZQ0KPiANCj4gT24gTW9uLCBOb3YgMDksIDIw
MjAgYXQgMTA6MTQ6NDZBTSArMDAwMCwgU3VkaXAgTXVraGVyamVlIHdyb3RlOg0KPiA+IEhpIEdy
ZWcsDQo+ID4NCj4gPiBPbiBTdW4sIE5vdiA4LCAyMDIwIGF0IDg6MjMgQU0gR3JlZyBLcm9haC1I
YXJ0bWFuDQo+ID4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPiB3cm90ZToNCj4gPiA+DQo+
ID4gPiBPbiBTYXQsIE5vdiAwNywgMjAyMCBhdCAxMDo0NzoyN1BNICswMDAwLCBTdWRpcCBNdWto
ZXJqZWUgd3JvdGU6DQo+ID4gPiA+IFdoZW4gQ09ORklHX01YQ19DTEtfU0NVIGlzIGNvbmZpZ3Vy
ZWQgYXMgJ20nIHRoZSBidWlsZCBmYWlscyBhcyBpdA0KPiA+ID4gPiBpcyB1bmFibGUgdG8gZmlu
ZCBkZXZpY2VfaXNfYm91bmQoKS4gVGhlIGVycm9yIGJlaW5nOg0KPiA+ID4gPiBFUlJPUjogbW9k
cG9zdDogImRldmljZV9pc19ib3VuZCIgW2RyaXZlcnMvY2xrL2lteC9jbGstaW14LXNjdS5rb10N
Cj4gPiA+ID4gICAgICAgdW5kZWZpbmVkIQ0KPiA+ID4gPg0KPiA+ID4gPiBFeHBvcnQgdGhlIHN5
bWJvbCBzbyB0aGF0IHRoZSBtb2R1bGUgZmluZHMgaXQuDQo+ID4gPiA+DQo+ID4gPiA+IEZpeGVz
OiA3N2Q4ZjMwNjhjNjMgKCJjbGs6IGlteDogc2N1OiBhZGQgdHdvIGNlbGxzIGJpbmRpbmcNCj4g
PiA+ID4gc3VwcG9ydCIpDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFN1ZGlwIE11a2hlcmplZSA8
c3VkaXBtLm11a2hlcmplZUBnbWFpbC5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPg0KPiA+ID4g
PiByZXNlbmRpbmcgd2l0aCB0aGUgRml4ZXM6IHRhZy4NCj4gPiA+ID4NCj4gPiA+ID4gIGRyaXZl
cnMvYmFzZS9kZC5jIHwgMSArDQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KykNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmFzZS9kZC5jIGIvZHJp
dmVycy9iYXNlL2RkLmMgaW5kZXgNCj4gPiA+ID4gMTQ4ZTgxOTY5ZTA0Li5hNzk2YTU3ZTVlZmIg
MTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvYmFzZS9kZC5jDQo+ID4gPiA+ICsrKyBiL2Ry
aXZlcnMvYmFzZS9kZC5jDQo+ID4gPiA+IEBAIC0zNTMsNiArMzUzLDcgQEAgYm9vbCBkZXZpY2Vf
aXNfYm91bmQoc3RydWN0IGRldmljZSAqZGV2KSAgew0KPiA+ID4gPiAgICAgICByZXR1cm4gZGV2
LT5wICYmIGtsaXN0X25vZGVfYXR0YWNoZWQoJmRldi0+cC0+a25vZGVfZHJpdmVyKTsNCj4gPiA+
ID4gIH0NCj4gPiA+ID4gK0VYUE9SVF9TWU1CT0woZGV2aWNlX2lzX2JvdW5kKTsNCj4gPiA+DQo+
ID4gPiBFWFBPUlRfU1lNQk9MX0dQTCgpIHBsZWFzZSwgbGlrZSBhbGwgdGhlIG90aGVyIGV4cG9y
dHMgaW4gdGhpcyBmaWxlLg0KPiA+ID4NCj4gPiA+IEFsc28sIHdhaXQsIG5vLCBkb24ndCBjYWxs
IHRoaXMsIGFyZSB5b3Ugc3VyZSB5b3UgYXJlIGNhbGxpbmcgaXQgaW4NCj4gPiA+IGEgcmFjZS1m
cmVlIHdheT8gIEFuZCB3aGF0IGJyYW5jaC90cmVlIGlzIHRoZSBhYm92ZSBjb21taXQgaW4/DQo+
ID4NCj4gPiBJIGhhdmUgbm90IGNoZWNrZWQgZnVsbHkgYnV0IHNpbmNlIGl0IGlzIGJlaW5nIGNh
bGxlZCBmcm9tIHByb2JlKCkgSQ0KPiA+IGFzc3VtZSB0aGUgbG9jayB3aWxsIGJlIGhlbGQgYXQg
dGhhdCB0aW1lLg0KPiANCj4gcHJvYmUoKSBzaG91bGQgbmV2ZXIgY2FsbCB0aGlzIGZ1bmN0aW9u
IGFzIGl0IG1ha2VzIG5vIHNlbnNlIGF0IGFsbCBhdCB0aGF0IHBvaW50IGluDQo+IHRpbWUuICBU
aGUgZHJpdmVyIHNob3VsZCBiZSBmaXhlZC4NCg0KV291bGQgeW91IHN1Z2dlc3QgaWYgYW55IG90
aGVyIEFQSSB3ZSBjYW4gdXNlIHRvIGFsbG93IHRoZSBkcml2ZXIgdG8ga25vdyB3aGV0aGVyDQph
bm90aGVyIGRldmljZSBoYXMgYmVlbiBwcm9iZWQ/DQoNCkZvciBpbXggc2N1IGRyaXZlciBpbiBx
dWVzdGlvbiwgaXQgaGFzIGEgc3BlY2lhbCByZXF1aXJlbWVudCB0aGF0IGl0IGRlcGVuZHMgb24g
c2N1IHBvd2VyIGRvbWFpbg0KZHJpdmVyLiBIb3dldmVyLCB0aGVyZSdyZSBhIGh1Z2UgbnVtYmVy
ICgyMDArKSBvZiBwb3dlciBkb21haW5zIGZvciBlYWNoIGRldmljZSBjbG9jaywgd2UgY2FuJ3Qg
ZGVmaW5lDQp0aGVtIGFsbCBpbiBEVCBmb3IgYSBzaW5nbGUgY2xvY2sgY29udHJvbGxlciBub2Rl
Lg0KDQpUaGF0J3Mgd2h5IHdlIHdhbnRlZCB0byB1c2UgZGV2aWNlX2lzX2JvdW5kKCkgYmVmb3Jl
IHRvIGNoZWNrIGlmIHNjdSBwb3dlciBkb21haW4gaXMgcmVhZHkgb3Igbm90IHRvDQpzdXBwb3J0
IGRlZmVyIHByb2JlLg0KDQpSZWdhcmRzDQpBaXNoZW5nDQoNCj4gDQo+IFRoaXMgZnVuY3Rpb24g
c2hvdWxkIG5vdCBiZSBleHBvcnRlZCwgc29ycnkuDQo+IA0KPiB0aGFua3MsDQo+IA0KPiBncmVn
IGstaA0K
