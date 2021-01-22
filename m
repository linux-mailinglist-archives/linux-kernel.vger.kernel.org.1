Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6812FFE05
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 09:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbhAVIRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 03:17:52 -0500
Received: from mail-eopbgr1300104.outbound.protection.outlook.com ([40.107.130.104]:56026
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726555AbhAVIRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 03:17:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCzfdTTTi6/f8z9KBg27VGMrXb23eRotUhbfSEvJF9x5yluWjgNIOGbEYiHb7tm3rwu4HnAnK2dFhP6m2Eq7LsL9+uyUy5AyzShefV8+jAEbtDGmr3t1wqeG8o4vli2rpmPgME9dyTJWDK8q5S7+X6cnDLDX1xNbcrdr1lye13DwWkAqQqHc+hpyijejcV2D/6aDOhxj2e65k9EU7SoxR9HNDzp6hNRiChWmbj85I37L5oisyNtk6fRU0YR0e55YRwufS6XDT1mnNPrGE4UwRiQCMyOJXwznqtQZuIixcH6dS9kBTeshHcdHMx4VMIzb2iRldZs06KDmKT9Jum2+Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0HGXR3pNEZEPvrKBfjjakUo8r5mZ9bmbN9FSdQ28hk=;
 b=RKdhmlTI9QT0dGt6ZvCYo3wV4h94jM/vopKOZ6yjCZv5WBm0nr9vj4/Z/xOJpwEP9EDkgGHo5RUKqbSjiJGqz+HKbYKdZYBOZpx2+6yIZl4m3LNGUD2oHFMDhqe6+mCcR2deT/dqlN9GzuokaAC97pDT2QcMLYf7cSj/Wh497Ujc4bkQ5xxAh5z/RsZP5yckObBpNnxidhBn6+oL8j5TjB4kElJ8gAkl6UZCmxjby9T3arOs/b0iw0DmEMYeat1Zv31mp8hxF1mG8rqN8xrxyIt+7A2PJsbdjyj36terjuKs0IFX1wIps8h5gc8cWUKNXS/dsWWvwVGoSVOUqS8XVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
Received: from HK0PR06MB3380.apcprd06.prod.outlook.com (2603:1096:203:82::18)
 by HK0PR06MB3684.apcprd06.prod.outlook.com (2603:1096:203:b2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Fri, 22 Jan
 2021 08:15:34 +0000
Received: from HK0PR06MB3380.apcprd06.prod.outlook.com
 ([fe80::116:1437:5d9a:16e9]) by HK0PR06MB3380.apcprd06.prod.outlook.com
 ([fe80::116:1437:5d9a:16e9%6]) with mapi id 15.20.3763.016; Fri, 22 Jan 2021
 08:15:34 +0000
From:   Ryan Chen <ryan_chen@aspeedtech.com>
To:     Samuel Holland <samuel@sholland.org>,
        Stephen Boyd <sboyd@kernel.org>, Joel Stanley <joel@jms.id.au>
CC:     Andrew Jeffery <andrew@aj.id.au>,
        Michael Turquette <mturquette@baylibre.com>,
        BMC-SW <BMC-SW@aspeedtech.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: Re: [PATCH 1/1] clk: aspeed: modify some default clks are
 critical
Thread-Topic: Re: [PATCH 1/1] clk: aspeed: modify some default clks are
 critical
Thread-Index: AQHWlWUpDwyjj9Eb9EeIGPpnHXDUp6mWfroAgAAsCwCAAMXfgIAWmgkAgIX3RlA=
Date:   Fri, 22 Jan 2021 08:15:34 +0000
Message-ID: <HK0PR06MB338049BAE1D1DAE7567F620DF2A00@HK0PR06MB3380.apcprd06.prod.outlook.com>
References: <20200928070108.14040-1-ryan_chen@aspeedtech.com>
 <20200928070108.14040-2-ryan_chen@aspeedtech.com>
 <160264382296.310579.9835482254268204873@swboyd.mtv.corp.google.com>
 <CACPK8Xe-_hTey7hTJjG2-EcDsTN0qOw3bWBcrZZohEK3QOJuvg@mail.gmail.com>
 <160269577311.884498.8429245140509326318@swboyd.mtv.corp.google.com>
 <adadc9ef-32ab-0a79-327c-c499c1c04093@sholland.org>
In-Reply-To: <adadc9ef-32ab-0a79-327c-c499c1c04093@sholland.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: sholland.org; dkim=none (message not signed)
 header.d=none;sholland.org; dmarc=none action=none
 header.from=aspeedtech.com;
x-originating-ip: [211.20.114.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e38af6f0-7996-45b9-b8b1-08d8beade4bb
x-ms-traffictypediagnostic: HK0PR06MB3684:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR06MB368450580D257B708FE70153F2A00@HK0PR06MB3684.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T3TQ4tYYO5+MYJOd+7CRsHdZFkonRhaw/cSgBSZGMab5skwuwRT/VNqEz4T7QaCBpRqo9MierKyr+I8OYr5BJbugr/kg54wDgeEdaO/F0WahRoDFCh/YcMCfb76YAHQ32i5VaeGeTpGah4CMj7HJ3F0jhb3szQEQlgfau1pBwTw/4qMVUoHjDEC03pDCdqu6i1OlZ2hHK8ecnwBEszDHrrmr4M5OZAk2QRQ8CchcGB14zXZ+YeDZZljH6VCPLJnFTB8E32tIZePOndErPpOAn6gyKKyYaKWFpxTFTb5fmlN4iNZ5qM3u+dKdtxVhzAF9wq/vwYQBy8+PY0YJb49j5M4KUJU4v1dtI+tsCkScDkFMOU8dyRjbRMDDDO/UQPO4Z0Pkwlo5OKENLo0aDclpLy01Hd1H/PHUEcR/wnr4xZxvI7sqtsrbpa4TEcfB3BWBR+OCXXW+Cd7nux9ClHZZgg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3380.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(376002)(366004)(396003)(39840400004)(7696005)(55016002)(26005)(33656002)(9686003)(316002)(52536014)(5660300002)(478600001)(186003)(966005)(4326008)(86362001)(66946007)(66556008)(8676002)(4001150100001)(6506007)(66446008)(110136005)(53546011)(2906002)(8936002)(83380400001)(55236004)(76116006)(71200400001)(64756008)(54906003)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?YS9iUGQ2T05VeGd1d0RFNzBpWlY1akRGaHJSWUNIRTBCdTMyYi9UQnZPdTEy?=
 =?utf-8?B?dzNWbGN4NG1ZcjVaK1hmR1lSNjYvbEZwRUR3UnpER2prSFl6cjd6anRsemx3?=
 =?utf-8?B?Q1p3UHRLZHNCbG82Vlp2bDlWOUJSY2tNa2lwYXYrZjV5ek44VUdCYzNzMjQ1?=
 =?utf-8?B?S0E1ZGpvUUFRdDJ3NG1qZGExbG9wWE5YMjBrQ3NDVE1tc0YzWWQ3SFNGL2tL?=
 =?utf-8?B?V0QrZDN2VmVhU3ViY2N3ZWFRMGdTMFRXK3J0SC80Tzg4cTZaVDJNbzE2Q1lL?=
 =?utf-8?B?ZFd2anA1NG9sRXpxN0Z1Z3hwZmEzZnVmMTVjV043NDIvOGc1VmNkRmNySG00?=
 =?utf-8?B?cGtuVmhpOG12V1pTWVVjMXF2VFlINVdRWmVheTRsZDhSeEtIV1FzcDk1b05M?=
 =?utf-8?B?RUtNeGVaNEJBMERFeVQ5WHZkOTh0ZGtBODVycG5Kd0dIbWEvWEFlc2tuZXov?=
 =?utf-8?B?eGI2amdWNmtkN2E1Y2h3c25aY1Bna2lyV3FIOUxFR281Nzl4bUxRQVZ6b2F6?=
 =?utf-8?B?WDNOczlkdW5XcWNtQ3Zub0hDNHVFMXY0emhZY0VldDd5S0tZTnlDeDhZQjJ1?=
 =?utf-8?B?SnZPZjhKY0RaeGpxWFlyTGtOSUFZa3NJb1NKcmFFRTBzdlkvZWFiKzhqQVMx?=
 =?utf-8?B?cjRqR0UvaVdIaUwxUVJsK0g2RDQwZ0p6UkpVTEN5MndsbE5BOUtKb2FlMzVr?=
 =?utf-8?B?NW5wMkhsZnRZdjVxVy9NM3VYSWE1SjVwTWlCT0c3cS9DeFdyZEhJTnVsNmRC?=
 =?utf-8?B?V01rWk5FcWdVelhwQkxtRWN0a2hlVjAxRTFaUmViYVZFNkg0NGtZL1Urd3V4?=
 =?utf-8?B?bzhJK3ZGdENhQlNPVXdpVEpWQzF0Y09BWGoxeUpPckhnaklFMVVxdGFuUWpy?=
 =?utf-8?B?TVExZXJYZDdBZjFYemZZWXN2SWk4QTFjMVg4eTJaTGNNSXZjeGpPYVBnLzdR?=
 =?utf-8?B?YU1BQ1FISFI5YmdOaE9CbFZQZFNKU2Q4QWRBZUpZc09VMlJMK3dpQ1I2SmJs?=
 =?utf-8?B?LzlzM2VjTFpvMkxiMlJIYkZyRVhuTzc1UkV0U1JqTGxjSE1HQTlXbEdNNVpw?=
 =?utf-8?B?ZDRXNEoxdWRtT1N6QVRBSGJ2MnBOZWNzWXc3Sk1ZNXloTG5ZUmpKWUZsWDlT?=
 =?utf-8?B?aC95a1pKdDB1OTlZc1RCM0QzbWVLRzBwN0xOc01SMDlnU0tOeFdlMTBITXhN?=
 =?utf-8?B?OVJRd2JqSTNQcXZjNkpBTlFkditPZW9ENWZWWlVXc2xyQ3VscnVUVm1SazFo?=
 =?utf-8?B?VnZSelpvejJ2MWRHZ3JCc0V4N0dBYzZHYy9zcExWcW9lTzNCK2JyNUZhVFA4?=
 =?utf-8?Q?Q+qXFzHlZ0lJo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3380.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e38af6f0-7996-45b9-b8b1-08d8beade4bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2021 08:15:34.8598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 99wiz7vvSU/3PZqYeXIIbll8sCdtUiW113V9jomQEhZKISpC3B1Nf4DQ62bxT4CyP6uWAr1YPZnvSAjX1FV0E5nGpIPGSxpMWxbm1YM6Hmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB3684
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoJSG93IGFib3V0IHRoaXMgcGF0Y2ggcHJvZ3Jlc3M/DQoJSXQgZG9lcyBpbXBhY3Qg
YSBsb3Qgb2YgbWFjaGluZSB0aGF0IHdoZW4gQk1DIGJvb3QgYXQgdS1ib290LiANCglTVUFSVCBp
cyB3b3JrIGZvciBIb3N0LiBCdXQgYWZ0ZXIgYm9vdCBpbnRvIGtlcm5lbCwgZHVlIHRvIHRoZSBj
bGsgZGlzYWJsZWQuIA0KCVRoZSBTVUFSVCBpcyBub3Qgd29yayBmb3IgSG9zdCBhbnltb3JlLiAN
Cg0KUmVnYXJkcywNClJ5YW4NCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
U2FtdWVsIEhvbGxhbmQgPHNhbXVlbEBzaG9sbGFuZC5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBP
Y3RvYmVyIDI5LCAyMDIwIDEwOjI1IEFNDQo+IFRvOiBTdGVwaGVuIEJveWQgPHNib3lkQGtlcm5l
bC5vcmc+OyBKb2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1Pg0KPiBDYzogQW5kcmV3IEplZmZl
cnkgPGFuZHJld0Bhai5pZC5hdT47IE1pY2hhZWwgVHVycXVldHRlDQo+IDxtdHVycXVldHRlQGJh
eWxpYnJlLmNvbT47IFJ5YW4gQ2hlbiA8cnlhbl9jaGVuQGFzcGVlZHRlY2guY29tPjsNCj4gQk1D
LVNXIDxCTUMtU1dAYXNwZWVkdGVjaC5jb20+OyBMaW51eCBBUk0NCj4gPGxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZz47IGxpbnV4LWFzcGVlZA0KPiA8bGludXgtYXNwZWVkQGxp
c3RzLm96bGFicy5vcmc+OyBsaW51eC1jbGtAdmdlci5rZXJuZWwub3JnOyBMaW51eCBLZXJuZWwN
Cj4gTWFpbGluZyBMaXN0IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPg0KPiBTdWJqZWN0
OiBSZTogUmU6IFtQQVRDSCAxLzFdIGNsazogYXNwZWVkOiBtb2RpZnkgc29tZSBkZWZhdWx0IGNs
a3MgYXJlIGNyaXRpY2FsDQo+IA0KPiBTdGVwaGVuLA0KPiANCj4gT24gMTAvMTQvMjAgMTI6MTYg
UE0sIFN0ZXBoZW4gQm95ZCB3cm90ZToNCj4gPiBRdW90aW5nIEpvZWwgU3RhbmxleSAoMjAyMC0x
MC0xMyAyMjoyODowMCkNCj4gPj4gT24gV2VkLCAxNCBPY3QgMjAyMCBhdCAwMjo1MCwgU3RlcGhl
biBCb3lkIDxzYm95ZEBrZXJuZWwub3JnPiB3cm90ZToNCj4gPj4+DQo+ID4+PiBRdW90aW5nIFJ5
YW4gQ2hlbiAoMjAyMC0wOS0yOCAwMDowMTowOCkNCj4gPj4+PiBJbiBBU1BFRUQgU29DIExDTEsg
aXMgTFBDIGNsb2NrIGZvciBhbGwgU3VwZXJJTyBkZXZpY2UsIFVBUlQxL1VBUlQyDQo+ID4+Pj4g
YXJlIGRlZmF1bHQgZm9yIEhvc3QgU3VwZXJJTyBVQVJUIGRldmljZSwgZVNQSSBjbGsgZm9yIEhv
c3QgZVNQSQ0KPiA+Pj4+IGJ1cyBhY2Nlc3MgZVNQSSBzbGF2ZSBjaGFubmVsLCB0aG9zZSBjbGtz
IGNhbid0IGJlIGRpc2FibGUgc2hvdWxkDQo+ID4+Pj4ga2VlcCBkZWZhdWx0LCBvdGhlcndpc2Ug
d2lsbCBhZmZlY3QgSG9zdCBzaWRlIGFjY2VzcyBTdXBlcklPIGFuZCBTUEkgc2xhdmUNCj4gZGV2
aWNlLg0KPiA+Pj4+DQo+ID4+Pj4gU2lnbmVkLW9mZi1ieTogUnlhbiBDaGVuIDxyeWFuX2NoZW5A
YXNwZWVkdGVjaC5jb20+DQo+ID4+Pj4gLS0tDQo+ID4+Pg0KPiA+Pj4gSXMgdGhlcmUgcmVzb2x1
dGlvbiBvbiB0aGlzIHRocmVhZD8NCj4gPj4NCj4gPj4gTm90IHlldC4NCj4gPj4NCj4gPj4gV2Ug
aGF2ZSBhIHN5c3RlbSB3aGVyZSB0aGUgQk1DIChtYW5hZ2VtZW50IGNvbnRyb2xsZXIpIGNvbnRy
b2xzIHNvbWUNCj4gPj4gY2xvY2tzLCBidXQgdGhlIHBlcmlwaGVyYWxzIHRoYXQgaXQncyBjbG9j
a2luZyBhcmUgb3V0c2lkZSB0aGUgQk1DJ3MNCj4gPj4gY29udHJvbC4gSW4gdGhpcyBjYXNlLCB0
aGUgaG9zdCBwcm9jZXNzb3IgdXMgdXNpbmcgc29tZSBVQVJUcyBhbmQNCj4gPj4gd2hhdCBub3Qg
aW5kZXBlbmRlbnQgb2YgYW55IGNvZGUgcnVubmluZyBvbiB0aGUgQk1DLg0KPiA+Pg0KPiA+PiBS
eWFuIHdhbnRzIHRvIGhhdmUgdGhlbSBtYXJrZWQgYXMgY3JpdGljYWwgc28gdGhlIEJNQyBuZXZl
ciBwb3dlcnMgdGhlbQ0KPiBkb3duLg0KPiA+Pg0KPiA+PiBIb3dldmVyLCB0aGVyZSBhcmUgc3lz
dGVtcyB0aGF0IGRvbid0IHVzZSB0aGlzIHBhcnQgb2YgdGhlIHNvYywgc28NCj4gPj4gZm9yIHRo
b3NlIGltcGxlbWVudGF0aW9ucyB0aGV5IGFyZSBub3QgY3JpdGljYWwgYW5kIExpbnV4IG9uIHRo
ZSBCTUMNCj4gPj4gY2FuIHR1cm4gdGhlbSBvZmYuDQo+ID4+DQo+ID4+IERvIHlvdSBoYXZlIGFu
eSB0aG91Z2h0cz8gSGFzIGFueW9uZSBzb2x2ZWQgYSBzaW1pbGFyIHByb2JsZW0gYWxyZWFkeT8N
Cj4gPj4NCj4gPg0KPiA+IElzIHRoaXMgY3JpdGljYWwgY2xvY2tzIGluIERUPyBXaGVyZSB3ZSB3
YW50IHRvIGhhdmUgZGlmZmVyZW50IERUIGZvcg0KPiA+IGRpZmZlcmVudCBkZXZpY2UgY29uZmln
dXJhdGlvbnMgdG8gaW5kaWNhdGUgdGhhdCBzb21lIGNsa3Mgc2hvdWxkIGJlDQo+ID4gbWFya2Vk
IGNyaXRpY2FsIHNvIHRoZXkncmUgbmV2ZXIgdHVybmVkIG9mZiBhbmQgb3RoZXIgdGltZXMgdGhl
eQ0KPiA+IGFyZW4ndCBzbyB0aGV5J3JlIHR1cm5lZCBvZmY/DQo+ID4NCj4gPiBJdCBhbHNvIHNv
dW5kcyBzb3J0IG9mIGxpa2UgdGhlIHByb3RlY3RlZC1jbG9ja3MgYmluZGluZy4gV2hlcmUgeW91
DQo+ID4gZG9uJ3Qgd2FudCB0byB0b3VjaCBjZXJ0YWluIGNsa3MgZGVwZW5kaW5nIG9uIHRoZSB1
c2FnZSBjb25maWd1cmF0aW9uDQo+ID4gb2YgdGhlIFNvQy4gVGhlcmUgaXMgYSBwYXRjaCB0byBt
YWtlIHRoYXQgZ2VuZXJpYyB0aGF0IEkgaGF2ZW4ndA0KPiA+IGFwcGxpZWQgYmVjYXVzZSBpdCBs
b29rcyB3cm9uZyBhdCBmaXJzdCBnbGFuY2VbMV0uIE1heWJlIG5vdA0KPiA+IHJlZ2lzdGVyaW5n
IHRob3NlIGNsa3MgdG8gdGhlIGZyYW1ld29yayBvbiB0aGUgY29uZmlndXJhdGlvbiB0aGF0IFJ5
YW4gaGFzIGlzDQo+IGdvb2QgZW5vdWdoPw0KPiANCj4gQ291bGQgeW91IHBsZWFzZSBiZSBtb3Jl
IHNwZWNpZmljIHRoYW4gdGhlIHBhdGNoICJsb29rcyB3cm9uZyI/IEknbSBtb3JlDQo+IHRoYW4g
aGFwcHkgdG8gdXBkYXRlIHRoZSBwYXRjaCB0byBhZGRyZXNzIHlvdXIgY29uY2VybnMsIGJ1dCBJ
IGNhbm5vdCBkbyB0aGF0DQo+IHVubGVzcyBJIGtub3cgd2hhdCB5b3VyIGNvbmNlcm5zIGFyZS4N
Cj4gDQo+IFJlZ2FyZHMsDQo+IFNhbXVlbA0KPiANCj4gPiBbMV0NCj4gPiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9yLzIwMjAwOTAzMDQwMDE1LjU2MjctMi1zYW11ZWxAc2hvbGxhbmQub3JnDQo=
