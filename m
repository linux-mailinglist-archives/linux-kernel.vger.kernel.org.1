Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5752D38E8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 03:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgLICll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 21:41:41 -0500
Received: from mail-am6eur05on2084.outbound.protection.outlook.com ([40.107.22.84]:57189
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726604AbgLICll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 21:41:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ogj3q/uWY654PnN0uxOcO4z812dd5NIgO3tvcpdeX5BBuA078xHrq3gYxn0FFmA8tTlZZQDGIRlMtL3bNRQjbNIvZgI8X4GhZKQoIC+X1o990lU3EDCge7xctBjWWK4DeNm7ebtn0bNwImU94VxoPPi8DkLRfAm9xl4Dx9cUzw3I9MzKovp7WROgZ/Pijh5CCR4NgAn3fLKO1UDAAx2N6m2y0caHrIWuxSeVlB4z/WhlZcSBBRSeqysI2xuwH2jTxB8l74XB6j0+M5B6Dh7jGjmj1TjnwdOf2ApRDkfzKysXOSj6p6KSQOUtC+/OMhTLFGC/l/su9kQJ2OnRLuNSRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qyh03ONJFBKb5jU6sGtuVoDkTCGIF0fwsHKcFZIj5nQ=;
 b=kgmSGMLiVZwPexrFc4DWLR1rsL+37vQMf/YL1ICGB8z1M603O6uqTEsynknwN6qPCTEVSbdE1cQez4GAcSNp7K7PK/fMHXYjk8QNmPiON7lW/02z9fW8iQ/2zGfZLGHll3fvQ4ISEq+4FTLDfVL1LSsUFi3neYhLuUBWEM3Qdw/fGqyBGhdKewDTeEhIL9syV7xOdJXLnitED3FXiqo4IqAXQK1toC8mP4hMTZpP5lVGe2S2rVtbzNV8NJjgB7esQcQSKDKM+6W06rVEv24cYS6S5tH8RN74s3v9N8aEBgLG40yKbkexz5rYWjwRIWDlN7u9WTDgXNcSAcwLOzZkPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qyh03ONJFBKb5jU6sGtuVoDkTCGIF0fwsHKcFZIj5nQ=;
 b=rpxwtruvsCPrszUM/yOGDLnbrUkw0q+PK1mXvvaQeaKc02fCMDDmZSBWkhdVjLZLCKEXJmt2uQ5O9xne74TsYrDvN7GuK1cAoBcxZpdsUqfSitYosm/HLHyN3SAGEi/Vt2GEm2gq0nE0ibr17XHqOkcAjjNKM8TqOgbTOC5yKfU=
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9)
 by DB6PR0402MB2758.eurprd04.prod.outlook.com (2603:10a6:4:96::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.19; Wed, 9 Dec
 2020 02:40:58 +0000
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c]) by DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c%5]) with mapi id 15.20.3632.023; Wed, 9 Dec 2020
 02:40:58 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Pawel Laszczak <pawell@cadence.com>, Roger Quadros <rogerq@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: [PATCH -next] usb: cdns3: fix warning when USB_CDNS_HOST is not
 set
Thread-Topic: [PATCH -next] usb: cdns3: fix warning when USB_CDNS_HOST is not
 set
Thread-Index: AQHWzZwkj0GjYM34DkSt3eQw8FfQQKnuDiHA
Date:   Wed, 9 Dec 2020 02:40:58 +0000
Message-ID: <DBBPR04MB7979502194410BB1AE96DF038BCC0@DBBPR04MB7979.eurprd04.prod.outlook.com>
References: <20201208195547.30076-1-rdunlap@infradead.org>
In-Reply-To: <20201208195547.30076-1-rdunlap@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [180.164.155.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e4e00b5f-ec70-4b60-f42e-08d89bebdbf2
x-ms-traffictypediagnostic: DB6PR0402MB2758:
x-microsoft-antispam-prvs: <DB6PR0402MB2758ABD4FE1AAF7ED219EC6A8BCC0@DB6PR0402MB2758.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:345;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R+YPcAnOe6+wbjvJZYkrVqBGiejDYw+xPE3bQqKrm9dcqsVPgDX1pLr+Y2bCnwvTV2IuZoy/lssTJLcgn+IXXqxWCqiLo0BUb7KNi2Eha5IwuqPq70zzAbnuOBQnZg5ZO8/90yLtRo62HCjEWIUKizUe3NLp5B1vf+DiEMMfHGiigz+pRuY2cVMjYqVhRlD8samYzhte0MBs5i5af005qHp2I0xJcmB/aKLUUqIyiKFDVk6z0iX2SYhX7OprKEbdcXPlAPE3wqbv7HRAyQETRb5YXQcC2GtQqmcDl0a0YbvuVc0ylCxcSvFoHJiuqsVDhkisl/xqpsPjVk07EO+QqQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7979.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(376002)(2906002)(4326008)(8676002)(26005)(83380400001)(33656002)(508600001)(71200400001)(44832011)(9686003)(6506007)(86362001)(55016002)(7696005)(54906003)(110136005)(186003)(4744005)(8936002)(66446008)(64756008)(76116006)(66946007)(66476007)(66556008)(52536014)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?YzJDMGQzSEZBWk1kYW1CZHdTa0h0RTA3SE1scDBTeERGOGhrNGJLajlQTFpu?=
 =?utf-8?B?bGEzNjd0aE1KRWZobVNYWTNwVTNQYnRZRENMb1JRa2wwbTJwMUVzeUFFbERP?=
 =?utf-8?B?SlR5NWVmUGh5SzFxdHQxQUFOcUVnNy83NHhUajNkeE53cHFNYlZuY1phMkRF?=
 =?utf-8?B?RUV1SWx0b29HUGl2bGhrOVFvc2FudHlrUjRiTGJiM29nQlZlcmRWa0c5VmRT?=
 =?utf-8?B?NXBDV29ybS8zOFVEUGxEZzZYeFRzeWpQYVBvYXZQRXk5YTJKY0UwNkVJMjJz?=
 =?utf-8?B?biszMDNiSlpwOExPbFVvY3NKN2taL0c2Ukc3RlZ6MUt4akRKM3JhRTIyMTJX?=
 =?utf-8?B?eXlzMTZPV3dLK3pscHpxWnpMejM1RUdWYkoxY1ZXUU9ZQWRZTHBhZmdQeVhT?=
 =?utf-8?B?eVh6Nm0ydmd4WjYrUVlaYm5qQnc5OXBoZU8xMndTQmR6Z1RYa1dHRWE4M3c0?=
 =?utf-8?B?aUlzTVdncHdCL010UlR2emFuMXRxSkNOeGQ5ZlMxQnJuUFFOejNGQzZBWTZi?=
 =?utf-8?B?b1NRTHRQb3l4aVNwSE1wVnpOa1U0Qm5yaXczMjQvb3g5YjA1RDVRYm5JUGRR?=
 =?utf-8?B?SmV1Nlk1UHlOQnV4SVlyZGVUKzk3NFpJY0M2S1BqS0ZrMDJSaHYxME81QkEw?=
 =?utf-8?B?dUdVTWhqdFAzNThXU2ZoMWNYZWwrL1VReWRWbU4vWmZRZE5xdzNVVkNLNGc3?=
 =?utf-8?B?VFRmM1RmVkk1MytzaDA2dGpiTG8xR3lEMDJsODlIQUhsZzdVOHRrTHBXVWQ3?=
 =?utf-8?B?T3hjM094YmdIVkM2YVoxRkRsVlRZK2twcHRWblhoZGFMU2tlaGJFRFlNdnk0?=
 =?utf-8?B?SldjUzhmeXdNcHh5QzJkeVFrbnRTamVHN1dEWHZSK2szblBZbVdFdE5qQzF4?=
 =?utf-8?B?a29pN0JZd0lBMjdUa2hqazNFWlpuc1NSNE4weHF2Uy9ad0MyUWh0YlIrWm00?=
 =?utf-8?B?L3JaTFllY2ZTUjNvOEFsSTBaYTRUTlU5RDAwYzh6RGJvRnZzME9NSGI3OU40?=
 =?utf-8?B?UE5oZTl3YnpLdWhVSzRNUWdObFp6TnRQYXV3dE1DV0dNR1hEY0RyUUN4SklI?=
 =?utf-8?B?V2U2Y0RGcWZPTjNteVRRajREcmN1Ykd1eVdLa3BJMHRUV2lPUXBRS3dRRWt2?=
 =?utf-8?B?M05PTzN2eXhITXFBanBuekZ5ZXF6ZS9qN3Vkb3ZsN3Y5WmYvbHBDdk1PYnlL?=
 =?utf-8?B?TWpwRzBCYUdSd3NHUGF5SFhqd0tCTnFJZzlRd051bWN6WXVnVEc2a0ZXUlBU?=
 =?utf-8?B?aG5OZlArdlJQY0pUaDNvU21wa1RyUWEzblBEWElRUXc4OFBxanF2MkRXSHdB?=
 =?utf-8?Q?0A6hdaBxpiBIg=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7979.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e00b5f-ec70-4b60-f42e-08d89bebdbf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2020 02:40:58.2169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: urfP3g4y9M5dapX+BkPYhU+24sSfD9tQjlsm/wfG717t5PeYaGZ0yV4SOOzjsHj4RmWwUmX4Q5yffEY7XNEjNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2758
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IA0KPiBJbiBmaWxlIGluY2x1ZGVkIGZyb20gLi4vZHJpdmVycy91c2IvY2RuczMvY29yZS5jOjIz
OjA6DQo+IC4uL2RyaXZlcnMvdXNiL2NkbnMzL2hvc3QtZXhwb3J0Lmg6Mjc6NTE6IHdhcm5pbmc6
IOKAmHN0cnVjdCB1c2JfaGNk4oCZIGRlY2xhcmVkDQo+IGluc2lkZSBwYXJhbWV0ZXIgbGlzdCB3
aWxsIG5vdCBiZSB2aXNpYmxlIG91dHNpZGUgb2YgdGhpcyBkZWZpbml0aW9uIG9yIGRlY2xhcmF0
aW9uDQo+IHN0YXRpYyBpbmxpbmUgaW50IHhoY2lfY2RuczNfc3VzcGVuZF9xdWlyayhzdHJ1Y3Qg
dXNiX2hjZCAqaGNkKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBefn5+fn5+DQo+IA0KDQpBcHBsaWVkIGJvdGgsIHRoYW5rcy4NCg0KUGV0ZXIN
Cg0KPiBTaWduZWQtb2ZmLWJ5OiBSYW5keSBEdW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9yZz4N
Cj4gQ2M6IFBldGVyIENoZW4gPHBldGVyLmNoZW5AbnhwLmNvbT4NCj4gQ2M6IFBhd2VsIExhc3pj
emFrIDxwYXdlbGxAY2FkZW5jZS5jb20+DQo+IENjOiBSb2dlciBRdWFkcm9zIDxyb2dlcnFAdGku
Y29tPg0KPiBDYzogbGludXgtdXNiQHZnZXIua2VybmVsLm9yZw0KPiBDYzogR3JlZyBLcm9haC1I
YXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gLS0tDQo+ICBkcml2ZXJzL3Vz
Yi9jZG5zMy9ob3N0LWV4cG9ydC5oIHwgICAgNCArKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gLS0tIGxpbnV4LW5leHQtMjAyMDEy
MDgub3JpZy9kcml2ZXJzL3VzYi9jZG5zMy9ob3N0LWV4cG9ydC5oDQo+ICsrKyBsaW51eC1uZXh0
LTIwMjAxMjA4L2RyaXZlcnMvdXNiL2NkbnMzL2hvc3QtZXhwb3J0LmgNCj4gQEAgLTksMTAgKzks
MTAgQEANCj4gICNpZm5kZWYgX19MSU5VWF9DRE5TM19IT1NUX0VYUE9SVA0KPiAgI2RlZmluZSBf
X0xJTlVYX0NETlMzX0hPU1RfRVhQT1JUDQo+IA0KPiAtI2lmIElTX0VOQUJMRUQoQ09ORklHX1VT
Ql9DRE5TX0hPU1QpDQo+IC0NCj4gIHN0cnVjdCB1c2JfaGNkOw0KPiANCj4gKyNpZiBJU19FTkFC
TEVEKENPTkZJR19VU0JfQ0ROU19IT1NUKQ0KPiArDQo+ICBpbnQgY2Ruc19ob3N0X2luaXQoc3Ry
dWN0IGNkbnMgKmNkbnMpOw0KPiAgaW50IHhoY2lfY2RuczNfc3VzcGVuZF9xdWlyayhzdHJ1Y3Qg
dXNiX2hjZCAqaGNkKTsNCj4gDQo=
