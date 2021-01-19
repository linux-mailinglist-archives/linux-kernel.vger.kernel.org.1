Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B8D2FAF06
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 04:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394829AbhASDF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 22:05:58 -0500
Received: from mail-eopbgr1310115.outbound.protection.outlook.com ([40.107.131.115]:23872
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2394839AbhASDFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 22:05:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ah3UCewUA7i6HEJurCbxwILK056R4OFcACFeB2/190bPj4AwEvScLzTzC0+x0Pyo/j82fs3xIW8hkQ6UYsagaPGQLaY9vFl5vUPQuin9hH6NqoIgRQ3eJaFdH6WN0Nt/aTk7uVYXf/xxBMNmn/65AvBax46KHUkHAZYQw18uAamqhDbrfM8M64Unp8N5CeBPCIDJeE0w8V9bGjFkSvO4soNEEEGZ/jYhPbFgCCpxZXKW7U2LN8EaELq1Rfep5vjf5gYrgLDlhXHOPox2qAA082sWVvbvNKTMsf9DhwQPsmDofOkGIDnnfMt6qo8Sz4oxIRZnQNxof82ZjbT82ffkFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLcD4v7Nt4PQqoOmt/Q3zgkr4tT6U8N0Pl2jR2lNMHY=;
 b=hqO5ImjhOUCmOqupxHHMJ+sZvGM6TFAjWlMQy0nqtOeRMER+N6wSCSiGJqcQm267LOxUkt7CPdg2DRvemB7bxFBdY7N8LAR/Z4Hq3+LvYS4BXyLzcgoyQIVSgBp4UbK1MlWk3jx17bImMai1sXty1GEmFuPHohL0K4yDiJ9kOZlMucYISt1MEaUDOF1avH8mHCdkVxaqLXqNdKnZ0jbVnKQclu+3mo8/1apPv3bnmDeCzEgVWy9XfXxiqKOtxlXol2ypOmxyjM/dwD/vMcSMcX2wu1Rp3de5WaPkRakpf5ZLUWAscRxYNR2moTTapkDJzybuHEZxEu/dVJ8Vzub9vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
Received: from HK0PR06MB3380.apcprd06.prod.outlook.com (2603:1096:203:82::18)
 by HK0PR06MB2706.apcprd06.prod.outlook.com (2603:1096:203:58::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Tue, 19 Jan
 2021 03:04:13 +0000
Received: from HK0PR06MB3380.apcprd06.prod.outlook.com
 ([fe80::116:1437:5d9a:16e9]) by HK0PR06MB3380.apcprd06.prod.outlook.com
 ([fe80::116:1437:5d9a:16e9%6]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 03:04:13 +0000
From:   Ryan Chen <ryan_chen@aspeedtech.com>
To:     Joel Stanley <joel@linux.ibm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andrewrj@au1.ibm.com" <andrewrj@au1.ibm.com>,
        BMC-SW <BMC-SW@aspeedtech.com>
CC:     "joel@jms.id.au" <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Subject: RE: [PATCH 1/1] clk: aspeed: Fix APLL calculate formula for
 ast2600-A2
Thread-Topic: [PATCH 1/1] clk: aspeed: Fix APLL calculate formula for
 ast2600-A2
Thread-Index: AQHW7YHZdhH4w0G0EUiHJl1Fb3UNq6ouOC+AgAAL2OA=
Date:   Tue, 19 Jan 2021 03:04:13 +0000
Message-ID: <HK0PR06MB3380AC1A1DF9C0883E83F752F2A30@HK0PR06MB3380.apcprd06.prod.outlook.com>
References: <20210118100813.30821-1-ryan_chen@aspeedtech.com>
         <20210118100813.30821-2-ryan_chen@aspeedtech.com>
 <02b792c847ea1841603629ba0377cfdfff479882.camel@linux.ibm.com>
In-Reply-To: <02b792c847ea1841603629ba0377cfdfff479882.camel@linux.ibm.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none
 header.from=aspeedtech.com;
x-originating-ip: [211.20.114.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64afa696-61f0-486a-c428-08d8bc26e695
x-ms-traffictypediagnostic: HK0PR06MB2706:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR06MB27060AAA31EAB94289FA5DA7F2A30@HK0PR06MB2706.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:386;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EGFz9M7Z3AUHseDvT8q+8dMx6ZXRuw+m/M4Ivl8j/XQPEazLdYJfSOiaXzE1LaQmZivdGusGtEV//7EeCQbmxb2knwKthOARYaKMnobShh4AU6bJLVYhgnCraxqgWX8ArGKEMSklxM2NoupncLQaQmH/1QpqYQfG29Q6z81rmjjdvtCyRfHTKFcOtwUoF6xBUBXaUwkdpYpH/AC+aZkg3kexEEbC0YXPKa1QDPOe9S8Vn21McG4Z+2gBCe1eI5ZAI5DkemR/vduaGQZGiJetdUV5OPGEA6C1EBuhPSYWDVRJsDiMPldT44dHvK7OfLwDa4d2Qk+9LkisRECotwuWd2byY9DrnKkPyWFKQ1oodMyd1gml8ueiWWOff8g7tYwCS/rzJo7eVYw9wriApJt8xw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3380.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(396003)(39840400004)(136003)(6506007)(8936002)(66476007)(53546011)(9686003)(5660300002)(186003)(55236004)(86362001)(71200400001)(54906003)(33656002)(8676002)(316002)(83380400001)(4326008)(64756008)(52536014)(2906002)(55016002)(66556008)(26005)(66446008)(478600001)(76116006)(6636002)(66946007)(7696005)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?TlVNUjhMNG9vM1JVZDJwUldUTW5OT05WclNTTTBpR3QzZHNSRDZTQnRyOThX?=
 =?utf-8?B?M2Q4MXVKRmRaUGd1NGNUeWxSVU00SlF3THdjbnR5dUFmdUNoT1RWcjNOb1kz?=
 =?utf-8?B?YUFQUitYNHZLZlArN3Jsa3RXRHVzc3JIMldicjJjZVRxK0ZZWGYrcHJBZlhZ?=
 =?utf-8?B?RlRVNTNKcnZxT2VVMjVBK25FdHEwNk5RWlAzMlBNbWlBdGJYRkVpMTBvZG5s?=
 =?utf-8?B?RStJNXNQb0JMM1VwbXBrUHB3d0NSUzhGMCtnWmJ6N2l5eXQvc1R3Z3BRZ2lY?=
 =?utf-8?B?R2MrU3ZUTElzRkFmbVNiSGxVRElBamV6L2xlNEdBVi90QkY0alhza2UvbWZD?=
 =?utf-8?B?a21pM0pCSk9HMERjMGlqcSsrdXhHeVo3ejlwNG1MeXFjaU5KaXd2UEIrRFcr?=
 =?utf-8?B?S2VqRitXWStUb0dSOHd5bmtrM2tQdU9LTyttbDVmRlZBc05kUjFuaElOZ04r?=
 =?utf-8?B?N2d1WTdid0hlSnFSYlp1M09HWnNCaVBaeWdTcndkOGE4Rk40Z29LVmtyOEJq?=
 =?utf-8?B?TlowVFpqMk02YnJIUml5anJ2SHozUkhoZWZoMktGbzBhSGVwZGJSNHgzVUV6?=
 =?utf-8?B?SWhmZFNFckJRc2dQTzFWMnREYkdSaFpQdFlpTGN3b1FtRXkxR2p3dGRaV3Nv?=
 =?utf-8?B?cVRjOXVWeGdhTXNxTGZyTzFCdVdVU0oxcWYwR1YvNlRFYlRLN1hUdlBWc1ky?=
 =?utf-8?B?dEZTd0RSdmJNYmlhWWx6M1gxWHN5bzByWmRiejNUSjVyNjNySElNLzVJQjBC?=
 =?utf-8?B?a05RVERTakF2alpkeFU2K1hjVHRKNEc5QktoT3d4cnFGSWpkT2xncWg2WnRp?=
 =?utf-8?B?RVpwSWFUdnBCOStyeGhsUG5FWm11L1IzaldrYld3QVg5N1FSem9hZHArclVX?=
 =?utf-8?B?RnRoNSsyYnB6N2dKUk5WenN0amxvWmN6N0djWXFEeXNaUURIRmRLVmZ3NWk1?=
 =?utf-8?B?SHZuTnJkUjMvRVJaTVdwMFMvdDZoU3EyYUR2allTN0NXOGxVTVJHOGZyY28w?=
 =?utf-8?B?ck9UckVHRHRIZHh1dCthMkJ5U3ZPeWdZUUJ2QXQvOTZmb3NWSEV1OW9hYjhK?=
 =?utf-8?B?OElIVmtGUVVDMGtXL3NOdGpyUW1HQnF2dGZTMCt1bXZrZGM5OTgzQVBLN09z?=
 =?utf-8?B?cFdZNDQ1UmZUYXp3WTBPQjA1ZzdoSWZ5QytST0VIemNLN0F0NVI5RHVSamJC?=
 =?utf-8?B?L1UyekhWRzRNbFE0blVBK085OWVBVXdGbEp1cXZocW5oMHVXWVRpb2RNaW1a?=
 =?utf-8?B?dVFYOG1pdTNUVG5IUi85QkVndFZXMjZVWlZnVlVwbitHaTdOblkrZDJUeWFr?=
 =?utf-8?Q?5UTwZ5YZK2UTI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3380.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64afa696-61f0-486a-c428-08d8bc26e695
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2021 03:04:13.5854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qm+PhTuv8F4xgVC7wQ+etpOJDiZt65fGfCxTO/AcR3tA48Wdr9yLwqgzd6YJzD3IJAUZ961N14k68ddulJfb4hMPQkpAjlDokWGuBlzJM4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2706
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb2VsIFN0YW5sZXkgPGpvZWxA
bGludXguaWJtLmNvbT4NCj4gU2VudDogVHVlc2RheSwgSmFudWFyeSAxOSwgMjAyMSAxMDoyMCBB
TQ0KPiBUbzogUnlhbiBDaGVuIDxyeWFuX2NoZW5AYXNwZWVkdGVjaC5jb20+OyBNaWNoYWVsIFR1
cnF1ZXR0ZQ0KPiA8bXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb20+OyBTdGVwaGVuIEJveWQgPHNib3lk
QGtlcm5lbC5vcmc+Ow0KPiBsaW51eC1jbGtAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOw0KPiBhbmRyZXdyakBhdTEuaWJtLmNvbTsgQk1DLVNXIDxCTUMtU1dA
YXNwZWVkdGVjaC5jb20+DQo+IENjOiBqb2VsQGptcy5pZC5hdTsgQW5kcmV3IEplZmZlcnkgPGFu
ZHJld0Bhai5pZC5hdT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzFdIGNsazogYXNwZWVkOiBG
aXggQVBMTCBjYWxjdWxhdGUgZm9ybXVsYSBmb3IgYXN0MjYwMC1BMg0KPiANCj4gT24gTW9uLCAy
MDIxLTAxLTE4IGF0IDE4OjA4ICswODAwLCBSeWFuIENoZW4gd3JvdGU6DQo+ID4gQVNUMjYwMEEx
L0EyIGhhdmUgZGlmZmVyZW50IHBsbCBjYWxjdWxhdGUgZm9ybXVsYS4NCj4gDQo+IFRvIGNsYXJp
ZnksIG9ubHkgdGhlIEEwIGhhcyB0aGUgb2xkIGNhbGN1bGF0aW9uLCBhbmQgYWxsIHN1YnNlcXVl
bnQgcmV2aXNpb25zIHVzZQ0KPiB0aGUgbmV3IGNhbGN1bGF0aW9uPw0KPiANCj4gSWYgdGhpcyBp
cyB0aGUgY2FzZSwgZG8gd2UgbmVlZCB0byBzdXBwb3J0IEEwIGluIG1haW5saW5lIGxpbnV4LCBv
ciBzaG91bGQgd2UNCj4gZHJvcCBzdXBwb3J0IGZvciBBMCBhbmQgb25seSBzdXBwb3J0IEExLCBB
MiBhbmQgb253YXJkcz8NCj4gDQpBMC9BMSBpcyB1c2Ugb2xkZXIgY2FsY3VsYXRlIGZvcm11bGEN
CkFmdGVyIEEyIGlzIG5ldyBjYWxjdWxhdGUgZm9ybXVsYSBhcyB0aGUgcGF0Y2guIA0KDQo+IFlv
dSBzaG91bGQgYWRkIGEgbGluZSB0byBpbmRpY2F0ZSB0aGlzIGlzIGEgZml4Og0KPiANCj4gRml4
ZXM6IGQzZDA0ZjZjMzMwYSAoImNsazogQWRkIHN1cHBvcnQgZm9yIEFTVDI2MDAgU29DIikNCj4g
DQpHb3QgaXQuIHNvIHNob3VsZCBJIHNlbmQgbmV3IHBhdGNoPyANCg0KPiBBbHNvLCB3aGVuIHNl
bmRpbmcgc2luZ2xlIHBhdGNoZXMgeW91IGRvIG5vdCBuZWVkIHRvIGluY2x1ZGUgdGhlIGNvdmVy
IGxldHRlci4NCj4gWW91IHNob3VsZCBpbmNsdWRlIGFsbCBvZiB0aGUgcmVsZXZhbnQgaW5mb3Jt
YXRpb24gaW4gdGhlIHBhdGNoJ3MgY29tbWl0DQo+IG1lc3NhZ2UuDQo+IA0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogUnlhbiBDaGVuIDxyeWFuX2NoZW5AYXNwZWVkdGVjaC5jb20+DQo+ID4gLS0t
DQo+ID4gwqBkcml2ZXJzL2Nsay9jbGstYXN0MjYwMC5jIHwgMzcgKysrKysrKysrKysrKysrKysr
KysrKysrKysrLS0tLS0tLS0tLQ0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDI3IGluc2VydGlvbnMo
KyksIDEwIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2Ns
ay1hc3QyNjAwLmMgYi9kcml2ZXJzL2Nsay9jbGstYXN0MjYwMC5jDQo+ID4gaW5kZXggYmJhY2Fj
Y2FkNTU0Li44OTMzYmQxNTA2YjMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9jbGsvY2xrLWFz
dDI2MDAuYw0KPiA+ICsrKyBiL2RyaXZlcnMvY2xrL2Nsay1hc3QyNjAwLmMNCj4gPiBAQCAtMTcs
NyArMTcsOCBAQA0KPiA+DQo+ID4gwqAjZGVmaW5lIEFTUEVFRF9HNl9OVU1fQ0xLU8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgNzENCj4gPg0KPiA+IC0jZGVmaW5lIEFTUEVFRF9HNl9TSUxJQ09O
X1JFVsKgwqDCoMKgwqDCoMKgwqDCoMKgMHgwMDQNCj4gPiArI2RlZmluZSBBU1BFRURfRzZfU0lM
SUNPTl9SRVbCoMKgwqDCoMKgwqDCoMKgwqDCoDB4MDE0ICNkZWZpbmUNCj4gQ0hJUF9SRVZJU0lP
Tl9JRA0KPiA+ICtHRU5NQVNLKDIzLCAxNikNCj4gPg0KPiA+IMKgI2RlZmluZSBBU1BFRURfRzZf
UkVTRVRfQ1RSTMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAweDA0MA0KPiA+IMKgI2RlZmluZSBBU1BF
RURfRzZfUkVTRVRfQ1RSTDLCoMKgwqDCoMKgwqDCoMKgwqDCoDB4MDUwIEBAIC0xOTAsMTgNCj4g
KzE5MSwzNCBAQA0KPiA+IHN0YXRpYyBzdHJ1Y3QgY2xrX2h3ICphc3QyNjAwX2NhbGNfcGxsKGNv
bnN0IGNoYXIgKm5hbWUsIHUzMiB2YWwpDQo+ID4gwqBzdGF0aWMgc3RydWN0IGNsa19odyAqYXN0
MjYwMF9jYWxjX2FwbGwoY29uc3QgY2hhciAqbmFtZSwgdTMyIHZhbCkNCj4gPiDCoHsNCj4gPiDC
oMKgwqDCoMKgwqDCoMKgdW5zaWduZWQgaW50IG11bHQsIGRpdjsNCj4gPiArwqDCoMKgwqDCoMKg
wqB1MzIgY2hpcF9pZCA9IHJlYWRsKHNjdV9nNl9iYXNlICsgQVNQRUVEX0c2X1NJTElDT05fUkVW
KTsNCj4gPg0KPiA+IC3CoMKgwqDCoMKgwqDCoGlmICh2YWwgJiBCSVQoMjApKSB7DQo+ID4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8qIFBhc3MgdGhyb3VnaCBtb2RlICovDQo+ID4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG11bHQgPSBkaXYgPSAxOw0KPiA+ICvCoMKg
wqDCoMKgwqDCoGlmICgoKGNoaXBfaWQgJiBDSElQX1JFVklTSU9OX0lEKSA+PiAxNikgPj0gMikg
ew0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAodmFsICYgQklUKDI0KSkg
ew0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLyog
UGFzcyB0aHJvdWdoIG1vZGUgKi8NCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoG11bHQgPSBkaXYgPSAxOw0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqB9IGVsc2Ugew0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgLyogRiA9IDI1TWh6ICogWyhtICsgMSkgLyAobiArIDEpXSAvIChwICsN
Cj4gMSkNCj4gPiAqLw0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgdTMyIG0gPSB2YWwgJiAweDFmZmY7DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB1MzIgbiA9ICh2YWwgPj4gMTMpICYgMHgzZjsNCj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHUzMiBwID0g
KHZhbCA+PiAxOSkgJiAweGY7DQo+ID4gKw0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgbXVsdCA9IChtICsgMSk7DQo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkaXYgPSAobiArIDEpICogKHAgKyAxKTsN
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQ0KPiA+IMKgwqDCoMKgwqDCoMKg
wqB9IGVsc2Ugew0KPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAvKiBGID0gMjVN
aHogKiAoMi1vZCkgKiBbKG0gKyAyKSAvIChuICsgMSldICovDQo+ID4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHUzMiBtID0gKHZhbCA+PiA1KSAmIDB4M2Y7DQo+ID4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHUzMiBvZCA9ICh2YWwgPj4gNCkgJiAweDE7DQo+ID4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHUzMiBuID0gdmFsICYgMHhmOw0KPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAodmFsICYgQklUKDIwKSkgew0KPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLyogUGFzcyB0aHJvdWdo
IG1vZGUgKi8NCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoG11bHQgPSBkaXYgPSAxOw0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9
IGVsc2Ugew0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgLyogRiA9IDI1TWh6ICogKDItb2QpICogWyhtICsgMikgLyAobiArDQo+IDEpXQ0KPiA+ICov
DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB1MzIg
bSA9ICh2YWwgPj4gNSkgJiAweDNmOw0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgdTMyIG9kID0gKHZhbCA+PiA0KSAmIDB4MTsNCj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHUzMiBuID0gdmFsICYgMHhm
Ow0KPiA+DQo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG11bHQgPSAoMiAtIG9k
KSAqIChtICsgMik7DQo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRpdiA9IG4g
KyAxOw0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
bXVsdCA9ICgyIC0gb2QpICogKG0gKyAyKTsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRpdiA9IG4gKyAxOw0KPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqB9DQo+ID4gwqDCoMKgwqDCoMKgwqDCoH0NCj4gPiDCoMKgwqDCoMKgwqDC
oMKgcmV0dXJuIGNsa19od19yZWdpc3Rlcl9maXhlZF9mYWN0b3IoTlVMTCwgbmFtZSwgImNsa2lu
IiwgMCwNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBtdWx0LCBkaXYpOw0KPiANCg0K
