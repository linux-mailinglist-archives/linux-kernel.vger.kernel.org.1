Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E4D28D99E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 07:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387553AbgJNFjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 01:39:13 -0400
Received: from mail-eopbgr1320135.outbound.protection.outlook.com ([40.107.132.135]:47199
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387447AbgJNFjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 01:39:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKratqy8P/EbJA19rYhqeVS46HxcO9nK/TEMy57H7OsJjaFoPjO9ZImmz7ss5WlAN4nUs5eRqTZD7f/BTgNPnK5si5pzRj/EItGx4e3tiLYri6xAc/MF/z2fOB9mwvEuoXu1TWilBu4RG6QmTtSbqzF6KTXNC8dfDCs9qy7GqZigMOyFlnQNamiPxgkhgQq0Jbt+Tjj5+1qnvOzvfGt3dcCcuZVZl2Dl5bHV2mUkGmL+R+2jfiQhISXOb2f9YyhIhsY6vYe0ThGKngDz5t/jIVerzE9VZm8omKLK9bpWe2g07dYWhRqP9ZGcQRJA3GkoLbkCsXCgBPf9716xsQHyDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9U3XdJ6VtGEk1fHBu0bLKR0mRyODxJrAQTLEOegahM=;
 b=W8nSOZQ4VD4H3YiU2Zd6ZvcERh9KDUigm+sFgiTuMwg7Svq6gm9KVn9htnQ/w1o4TRt8l8znO9fY+x8HTW9exGMhoLlj5R0bM+ktTIh9RVr5l2Yip5GnSGUxmLFvY50OHyUedYub/A6lYQAbDZOLexGkgIAdQGOEkchxep4Do6GCsbfq1mATCQOyG13KoZKKbEHBFwuf4jRduD8GEcPTV+wNWrmkD1vHmVrCJTbivWk/92NG7bBWcvqk2LlUvp32iENURwit/pP55aiaKrxO2GSQPh+eVEbp6nKNTNlzq0fq0Kflf4IUQRSF05cVhtSP99HieSJGSOmSL2+5+cm+/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
Received: from HK0PR06MB3380.apcprd06.prod.outlook.com (2603:1096:203:82::18)
 by HK0PR06MB3649.apcprd06.prod.outlook.com (2603:1096:203:b4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Wed, 14 Oct
 2020 05:39:08 +0000
Received: from HK0PR06MB3380.apcprd06.prod.outlook.com
 ([fe80::6def:b61:3beb:f3d5]) by HK0PR06MB3380.apcprd06.prod.outlook.com
 ([fe80::6def:b61:3beb:f3d5%6]) with mapi id 15.20.3455.030; Wed, 14 Oct 2020
 05:39:08 +0000
From:   Ryan Chen <ryan_chen@aspeedtech.com>
To:     Joel Stanley <joel@jms.id.au>, Stephen Boyd <sboyd@kernel.org>
CC:     Andrew Jeffery <andrew@aj.id.au>,
        Michael Turquette <mturquette@baylibre.com>,
        BMC-SW <BMC-SW@aspeedtech.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] clk: aspeed: modify some default clks are critical
Thread-Topic: [PATCH 1/1] clk: aspeed: modify some default clks are critical
Thread-Index: AQHWlWUpDwyjj9Eb9EeIGPpnHXDUp6mWfroAgAAsCwCAAAG5YA==
Date:   Wed, 14 Oct 2020 05:39:08 +0000
Message-ID: <HK0PR06MB33800F099D8191D0EC65A2E7F2050@HK0PR06MB3380.apcprd06.prod.outlook.com>
References: <20200928070108.14040-1-ryan_chen@aspeedtech.com>
 <20200928070108.14040-2-ryan_chen@aspeedtech.com>
 <160264382296.310579.9835482254268204873@swboyd.mtv.corp.google.com>
 <CACPK8Xe-_hTey7hTJjG2-EcDsTN0qOw3bWBcrZZohEK3QOJuvg@mail.gmail.com>
In-Reply-To: <CACPK8Xe-_hTey7hTJjG2-EcDsTN0qOw3bWBcrZZohEK3QOJuvg@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: jms.id.au; dkim=none (message not signed)
 header.d=none;jms.id.au; dmarc=none action=none header.from=aspeedtech.com;
x-originating-ip: [211.20.114.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5543554b-012d-4737-aabd-08d8700378af
x-ms-traffictypediagnostic: HK0PR06MB3649:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR06MB3649A8FD9CEEA90E0A2A4F36F2050@HK0PR06MB3649.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wHCxSE6SpVU0S+DEuZlvdtIUFqTqYI8HH6qyl8KfF4AbQUnVhdS2f0r/bp29J4eaylZjjvLjfrd6UEvbzYWnfs4xUTbNFp6qX07hYHX04es+mPLhHFZelI9eEvZEZRMqO3vMqbvYAwZ0AOIB9d4CKttI+IHumlduECmV2aZsAIFv8E5j5sm+jwXCe8sLGUjAi/7pRcaySuweQYCivT+aIj0xzkRztpRa16/+Fg4B58uGMIJAvNYEpLWXvOqUh3q1COaod68/WcG/TSIkCBTaenMHelGF66nz+5ws/lPi5obXVd3yh0r3DL3h0FYa6S+fviQaYVtY6t+S8iirN1lcrQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3380.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(39830400003)(136003)(366004)(76116006)(64756008)(66446008)(478600001)(66946007)(2906002)(7696005)(4326008)(86362001)(52536014)(71200400001)(55016002)(26005)(83380400001)(186003)(33656002)(6506007)(53546011)(9686003)(55236004)(110136005)(54906003)(66556008)(8676002)(66476007)(316002)(8936002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: XlB7TMKDFQojIdCW+ja3hjhiFWuKei5OLNMF8YigzHin/MFB7oa7ckFEXwsiY5zjvbyomG3qSJ4yfr9Si8dotlyjWUTz4oPrU30t0cuHHYs1CskkAcevlaVOKuClN0K4KNAiZMsTlGuGmsjKccbm8vLssmEIE3MKy4jBLHvBZd9u2T2TQJN2wYUOuADKe67mOzbZ9JpXiYNYUb70j02kfY9vw9FZpR3+WI+TIEHUuap3iw0KwOUK9VAgT2JCkW+qijQ42tM5gBrkiPRYAZrjXR283/RGEL5cjkH9oG/URCnZ/P1CzjBk9ZF28Mpz9Xt+doDIxI+Kq7q4bfOB+LIvuPqAwUcOVkXsyETE9YUA+oODBOGBHJ5iVobqZTRAGWVFcBogvjoFl8FPsylj4ZSqoWKvGY5OaPdNgifzT2Tzw00VNbtnM+LKBW1VKme37YCfOT/+rSOyktaBTSCp/V1RN+GW1fUM7JvJB29zOgRhGZVJsNE6ftNiXXdlI1WbGHaSkuD8up2DXoUdVV7GnxNqQ2MnHNBbEzdao3N4l6zNEwuADe2uuoVYVm3Qm6l9iJO1IQu/pu6mDkqNcHPh2LtHe2sEtrYEL5Kw8ngWkYHkPwuh1qDH3QrtOTWrejJ2ZqRH51tcQn5lAu5zGUNicE/HEQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3380.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5543554b-012d-4737-aabd-08d8700378af
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2020 05:39:08.4536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IPinxIFdVlbD49n6CYz8kL9v98AQvk58IGedn5eYLlraRGHGq7IEyjslsuuU2QcJVjhaE3j40SQ2NAIdXyiKmJbcCDVLCWT1Irp1/c7aT3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB3649
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb2VsIFN0YW5sZXkgPGpvZWxA
am1zLmlkLmF1Pg0KPiBTZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgMTQsIDIwMjAgMToyOCBQTQ0K
PiBUbzogU3RlcGhlbiBCb3lkIDxzYm95ZEBrZXJuZWwub3JnPg0KPiBDYzogQW5kcmV3IEplZmZl
cnkgPGFuZHJld0Bhai5pZC5hdT47IE1pY2hhZWwgVHVycXVldHRlDQo+IDxtdHVycXVldHRlQGJh
eWxpYnJlLmNvbT47IFJ5YW4gQ2hlbiA8cnlhbl9jaGVuQGFzcGVlZHRlY2guY29tPjsNCj4gQk1D
LVNXIDxCTUMtU1dAYXNwZWVkdGVjaC5jb20+OyBMaW51eCBBUk0NCj4gPGxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZz47IGxpbnV4LWFzcGVlZA0KPiA8bGludXgtYXNwZWVkQGxp
c3RzLm96bGFicy5vcmc+OyBsaW51eC1jbGtAdmdlci5rZXJuZWwub3JnOyBMaW51eCBLZXJuZWwN
Cj4gTWFpbGluZyBMaXN0IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIDEvMV0gY2xrOiBhc3BlZWQ6IG1vZGlmeSBzb21lIGRlZmF1bHQgY2xrcyBh
cmUgY3JpdGljYWwNCj4gDQo+IE9uIFdlZCwgMTQgT2N0IDIwMjAgYXQgMDI6NTAsIFN0ZXBoZW4g
Qm95ZCA8c2JveWRAa2VybmVsLm9yZz4gd3JvdGU6DQo+ID4NCj4gPiBRdW90aW5nIFJ5YW4gQ2hl
biAoMjAyMC0wOS0yOCAwMDowMTowOCkNCj4gPiA+IEluIEFTUEVFRCBTb0MgTENMSyBpcyBMUEMg
Y2xvY2sgZm9yIGFsbCBTdXBlcklPIGRldmljZSwgVUFSVDEvVUFSVDINCj4gPiA+IGFyZSBkZWZh
dWx0IGZvciBIb3N0IFN1cGVySU8gVUFSVCBkZXZpY2UsIGVTUEkgY2xrIGZvciBIb3N0IGVTUEkg
YnVzDQo+ID4gPiBhY2Nlc3MgZVNQSSBzbGF2ZSBjaGFubmVsLCB0aG9zZSBjbGtzIGNhbid0IGJl
IGRpc2FibGUgc2hvdWxkIGtlZXANCj4gPiA+IGRlZmF1bHQsIG90aGVyd2lzZSB3aWxsIGFmZmVj
dCBIb3N0IHNpZGUgYWNjZXNzIFN1cGVySU8gYW5kIFNQSSBzbGF2ZSBkZXZpY2UuDQo+ID4gPg0K
PiA+ID4gU2lnbmVkLW9mZi1ieTogUnlhbiBDaGVuIDxyeWFuX2NoZW5AYXNwZWVkdGVjaC5jb20+
DQo+ID4gPiAtLS0NCj4gPg0KPiA+IElzIHRoZXJlIHJlc29sdXRpb24gb24gdGhpcyB0aHJlYWQ/
DQo+IA0KPiBOb3QgeWV0Lg0KPiANCj4gV2UgaGF2ZSBhIHN5c3RlbSB3aGVyZSB0aGUgQk1DICht
YW5hZ2VtZW50IGNvbnRyb2xsZXIpIGNvbnRyb2xzIHNvbWUNCj4gY2xvY2tzLCBidXQgdGhlIHBl
cmlwaGVyYWxzIHRoYXQgaXQncyBjbG9ja2luZyBhcmUgb3V0c2lkZSB0aGUgQk1DJ3MgY29udHJv
bC4gSW4NCj4gdGhpcyBjYXNlLCB0aGUgaG9zdCBwcm9jZXNzb3IgdXMgdXNpbmcgc29tZSBVQVJU
cyBhbmQgd2hhdCBub3QgaW5kZXBlbmRlbnQgb2YNCj4gYW55IGNvZGUgcnVubmluZyBvbiB0aGUg
Qk1DLg0KPiANCj4gUnlhbiB3YW50cyB0byBoYXZlIHRoZW0gbWFya2VkIGFzIGNyaXRpY2FsIHNv
IHRoZSBCTUMgbmV2ZXIgcG93ZXJzIHRoZW0NCj4gZG93bi4NCj4gDQo+IEhvd2V2ZXIsIHRoZXJl
IGFyZSBzeXN0ZW1zIHRoYXQgZG9uJ3QgdXNlIHRoaXMgcGFydCBvZiB0aGUgc29jLCBzbyBmb3Ig
dGhvc2UNCj4gaW1wbGVtZW50YXRpb25zIHRoZXkgYXJlIG5vdCBjcml0aWNhbCBhbmQgTGludXgg
b24gdGhlIEJNQyBjYW4gdHVybiB0aGVtIG9mZi4NCj4gDQpUYWtlIGFuIGV4YW1wbGUsIGNvbmZs
aWN0IHRob3VnaHQgYWJvdXQgQVNQRUVEX0NMS19HQVRFX0JDTEsgaXMgQ0xLX0lTX0NSSVRJQ0FM
IGluIGNsay1hc3QyNjAwLmMNCkluIG15IG9waW5pb24sIHRoZSBkcml2ZXIgc2hvdWxkIGtlZXAg
dGhlIFNvQyBkZWZhdWx0IGNsayBzZXR0aW5nLiBJdCBpcyBvcmlnaW5hbCBjaGlwIGZlYXR1cmUu
ICANCg0KPiBEbyB5b3UgaGF2ZSBhbnkgdGhvdWdodHM/IEhhcyBhbnlvbmUgc29sdmVkIGEgc2lt
aWxhciBwcm9ibGVtIGFscmVhZHk/DQo+IA0K
