Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D0E2AA909
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 05:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgKHEFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 23:05:40 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2071 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbgKHEFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 23:05:40 -0500
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CTL961B86z67Hq6;
        Sun,  8 Nov 2020 12:04:10 +0800 (CST)
Received: from lhreml733-chm.china.huawei.com (10.201.108.84) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Sun, 8 Nov 2020 05:05:38 +0100
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 lhreml733-chm.china.huawei.com (10.201.108.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Sun, 8 Nov 2020 04:05:36 +0000
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Sun, 8 Nov 2020 12:05:35 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     John Hubbard <jhubbard@nvidia.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Linuxarm <linuxarm@huawei.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Garry <john.garry@huawei.com>
Subject: RE: [PATCH] mm/gup_benchmark: GUP_BENCHMARK depends on DEBUG_FS
Thread-Topic: [PATCH] mm/gup_benchmark: GUP_BENCHMARK depends on DEBUG_FS
Thread-Index: AQHWspKkrOQfdWDOqkGzzyoK3BLHUam7SjKAgAG/lxD//4AMgIAAM28AgAAckACAAK7tEP//hnEAgACOzKA=
Date:   Sun, 8 Nov 2020 04:05:35 +0000
Message-ID: <fa4163a5c9d34f0690d120f119f8c8ed@hisilicon.com>
References: <20201104100552.20156-1-song.bao.hua@hisilicon.com>
 <e8ecbf3e-438e-934e-0335-ec9b3e097022@nvidia.com>
 <9286e2d0e17a47a1874dc4a96d83a38f@hisilicon.com>
 <e6b74390-6a80-9aae-17b2-536ffa0d1aae@nvidia.com>
 <a5f5b63a-ff9d-ed74-212f-f959f038b781@infradead.org>
 <2c968615-587c-b978-7961-8391c70382b2@nvidia.com>
 <869059977c224a3aa31bfb42a4a8148d@hisilicon.com>
 <dd9e5f78-d627-89d6-2b9d-f2912213171f@nvidia.com>
In-Reply-To: <dd9e5f78-d627-89d6-2b9d-f2912213171f@nvidia.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.224]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9obiBIdWJiYXJkIFtt
YWlsdG86amh1YmJhcmRAbnZpZGlhLmNvbV0NCj4gU2VudDogU3VuZGF5LCBOb3ZlbWJlciA4LCAy
MDIwIDQ6MTQgUE0NCj4gVG86IFNvbmcgQmFvIEh1YSAoQmFycnkgU29uZykgPHNvbmcuYmFvLmh1
YUBoaXNpbGljb24uY29tPjsgUmFuZHkgRHVubGFwDQo+IDxyZHVubGFwQGluZnJhZGVhZC5vcmc+
OyBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOyBsaW51eC1tbUBrdmFjay5vcmc7DQo+IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IExpbnV4YXJtIDxsaW51eGFybUBodWF3ZWku
Y29tPjsgUmFscGggQ2FtcGJlbGwNCj4gPHJjYW1wYmVsbEBudmlkaWEuY29tPjsgSm9obiBHYXJy
eSA8am9obi5nYXJyeUBodWF3ZWkuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBtbS9ndXBf
YmVuY2htYXJrOiBHVVBfQkVOQ0hNQVJLIGRlcGVuZHMgb24NCj4gREVCVUdfRlMNCj4gDQo+IE9u
IDExLzcvMjAgNjo1OCBQTSwgU29uZyBCYW8gSHVhIChCYXJyeSBTb25nKSB3cm90ZToNCj4gPj4g
T24gMTEvNy8yMCAyOjIwIFBNLCBSYW5keSBEdW5sYXAgd3JvdGU6DQo+ID4+PiBPbiAxMS83LzIw
IDExOjE2IEFNLCBKb2huIEh1YmJhcmQgd3JvdGU6DQo+ID4+Pj4gT24gMTEvNy8yMCAxMTowNSBB
TSwgU29uZyBCYW8gSHVhIChCYXJyeSBTb25nKSB3cm90ZToNCj4gPj4+Pj4+IEZyb206IEpvaG4g
SHViYmFyZCBbbWFpbHRvOmpodWJiYXJkQG52aWRpYS5jb21dDQo+ID4+Pj4gLi4uDQo+ID4+IEJ1
dCBpZiB5b3UgcmVhbGx5IGRpc2FncmVlLCB0aGVuIEknZCBnbyB3aXRoLCBqdXN0IGRyb3AgdGhl
IHBhdGNoIGVudGlyZWx5LA0KPiBiZWNhdXNlDQo+ID4+IGl0IGRvZXNuJ3QgcmVhbGx5IG1ha2Ug
dGhpbmdzIGJldHRlciBhcyB3cml0dGVuLi4uSU1ITyBhbnl3YXkuIDopDQo+ID4NCj4gPiBKdXN0
IGltYWdpbmUgYSBjYXNlLCB3ZSBkb24ndCBlbmFibGUgREVCVUdfRlMgYnV0IHdlIGVuYWJsZSBH
VVBfVEVTVCwgd2UNCj4gd2lsbA0KPiA+IGdldCBhbiBpbWFnZSB3aXRoIHRvdGFsbHkgdXNlbGVz
cyBjb2RlIHNlY3Rpb24gc2luY2UgR1VQX1RFU1QgZGVwZW5kcyBvbg0KPiBkZWJ1Z2ZzDQo+ID4g
ZW50cnkgdG8gcGVyZm9ybSBhbnkgdXNlZnVsIGZ1bmN0aW9uYWxpdHkuDQo+ID4NCj4gDQo+IExv
b2tpbmcgYXQgdGhlIGNob2ljZXMsIGZyb20gdGhlIHVzZXIncyAodXN1YWxseSBrZXJuZWwgZGV2
ZWxvcGVyJ3MpIGV4cGVyaWVuY2U6DQo+IA0KPiBhKSBUaGUgdXNlciBlbmFibGVzIEdVUF9URVNU
LCB0aGVuIGJvb3RzIHVwLCBydW5zLCBhbmQgaXMgYnJpZWZseSBzdXJwcmlzZWQgYnkgYQ0KPiBy
dW50aW1lIGZhaWx1cmUuIEJ1dCBpdCdzIGEgdmVyeSBxdWljayBkaWFnbm9zaXM6ICJvcGVuOiBO
byBzdWNoIGZpbGUgb3INCj4gZGlyZWN0b3J5IiwNCj4gd2hlbiB0cnlpbmcgdG8gbWFrZSB0aGF0
IGlvY3RsIGNhbGwuIFRoZSBwYXRoIGluZGljYXRlcyB0aGF0IGl0J3MgYSBkZWJ1ZyBmcyBwYXRo
LA0KPiBzbyB0aGUgc29sdXRpb24gaXMgcHJldHR5IGNsZWFyLCBhdCBsZWFzdCBmb3IgdGhlIG1h
aW4gYXVkaWVuY2UuDQoNCnVzZXJzIGNvdWxkIGhhdmUgdGhlc2UgdHdvIGRpZmZlcmVudCBzdG9y
aWVzOg0KU3RvcnkgQToNCnVzZXJzIHdhbnQgdG8gdXNlIEdVUF9URVNULCBzbyB0aGV5IHNpbXBs
eSBlbmFibGUgR1VQX1RFU1QsIGJ1aWxkIGEga2VybmVsDQphbmQgcnVuIHRoZSB0ZXN0LiBUaGVu
IHRoZXkgZ2V0IGZhaWxlZCBhdCBydW50aW1lIGJ1dCB0aGUga2VybmVsIGJ1aWxkIGhhcyBubw0K
YW55IGlzc3VlLg0KDQpUaGVuIHRoZXkgaGF2ZSB0byByZWFkIHRoZSBjb2RlLCBhbmQgZmlndXJl
IG91dCBERUJVR19GUyBpcyBhIG11c3QtaGF2ZSwgdGhlbg0KdGhleSBlbmFibGUgREVCVUdfRlMg
YWZ0ZXJ3YXJkcy4gQWZ0ZXIgdGhhdCwgdGhleSByZS1idWlsZCBrZXJuZWwgYW5kIHJlLXRlc3Qu
DQoNClVzZXJzIG1pZ2h0IGhhdmUgd2FzdGVkIG9uZSBob3VyIG9uIGl0Lg0KDQpTdG9yeSBCOg0K
aWYgd2UgcHV0ICJkZXBlbmRzIG9uIiwgdXNlcnMgd2FudCB0byB1c2UgR1VQX1RFU1QsIHRoZW4g
dGhleSB0cnkgdG8NCmVuYWJsZSAiR1VQX1RFU1QiLCBidXQgdGhleSBjb3VsZG4ndCBlbmFibGUg
aXQgYXQgYWxsIHNpbmNlIERFQlVHX0ZTIGlzDQpub3QgZW5hYmxlZC4NCg0KQW5kIHRoZXkgdXNl
ICIvIiB0byBzZWFyY2ggR1VQX1RFU1QsIG1lbnVjb25maWcgd2lsbCBzaG93ICJHVVBfVEVTVCIN
CmRlcGVuZCBvbiAiREVCVUdfRlMiLCB0aGV5IHdpbGwgZW5hYmxlIERFQlVHX0ZTIHRvIGdldCBH
VVBfVEVTVA0KZW5hYmxlZC4NCg0KRm9yIHN0b3J5IEIsIHVzZXJzIG9ubHkgc3BlbmQgb25lIG1p
bnV0ZSBpbiBtZW51Y29uZmlnIDotKQ0KDQo+IA0KPiBiKSBUaGUgb3RoZXIgY2hvaWNlOiB0aGUg
dXNlciAqbmV2ZXIgZXZlbiBzZWVzKiBHVVBfVEVTVCBhcyBhIGNob2ljZS4gVGhpcw0KPiBlc3Bl
Y2lhbGx5DQo+IGJvdGhlcnMgbWUgYmVjYXVzZSBzb21ldGltZXMgeW91IGZpbmQgdGhpbmdzIGJ5
IHBva2luZyBhcm91bmQgaW4gdGhlIG1lbnUsDQo+IGFsdGhvdWdoDQo+IG9mIGNvdXJzZSAieW91
IHNob3VsZCBhbHJlYWR5IGtub3cgYWJvdXQgaXQiLi4uYnV0IHRoZXJlJ3MgYSBsb3QgdG8gImFs
cmVhZHkNCj4ga25vdyINCj4gaW4gYSBsYXJnZSBrZXJuZWwuDQo+IA0KPiAgRnJvbSBhIHVzZXIg
ZXhwZXJpZW5jZSwgaXQncyB3YXkgYmV0dGVyIHRvIHNpbXBseSBzZWUgd2hhdCB5b3Ugd2FudCwg
YW5kDQo+IHNlbGVjdCBpdA0KPiBpbiB0aGUgbWVudS4gT3IsIGF0IGxlYXN0IGdldCBzb21lIHBy
b21wdCB0aGF0IHlvdSBuZWVkIHRvIHByZS1zZWxlY3QNCj4gc29tZXRoaW5nIGVsc2UuDQo+IA0K
DQpJZiB3ZSB0eXBlICIvIiB0byBzZWFyY2ggR1VQX1RFU1QsIG1lbnVjb25maWcgd2lsbCBzaG93
IGl0IGRlcGVuZHMgb24NCkRFQlVHX0ZTIGFuZCBzaG93IHRoZSBzdGF0dXMgb2YgREVCVUdfRlMg
WSBvciBOLiBXb3VsZG4ndCBpdCBoYXMgYmVlbg0KYSBwcm9tcHQ/DQoNCj4gDQo+ID4gVGhlIGRp
ZmZlcmVuY2UgYmV0d2VlbiAiZGVwZW5kcyBvbiIgYW5kICJzZWxlY3QiIGZvciB0aGlzIGNhc2Ug
aXMgbGlrZToNCj4gPiBkZXBlbmRzIG9uOiBpZiB3ZSB3YW50IHRvIHVzZSBHVVBfVEVTVCwgd2Ug
aGF2ZSB0byBlbmFibGUgREVCVUdfRlMgZmlyc3Q7DQo+ID4gc2VsZWN0OiBpZiB3ZSBlbmFibGUg
R1VQX1RFU1QsIEtjb25maWcgd2lsbCBlbmFibGUgREVCVUdfRlMgYXV0b21hdGljYWxseS4NCj4g
Pg0KPiA+IFRvIG1lLCBJIGFtIDYwJSBpbmNsaW5lZCB0byAiZGVwZW5kcyBvbiIgYXMgSSB0aGlu
ayAiREVCVUdfRlMiIGlzIG1vcmUNCj4gPiBvZiBhIHByZS1jb25kaXRpb24gb2YgR1VQX1RFU1Qg
dGhhbiBhbiBpbnRlcm5hbCBwYXJ0IG9mIEdVUF9URVNULiBTbyBwZW9wbGUNCj4gPiBzaG91bGQg
cmVhbGl6ZSB0aGUgcHJlLWNvbmRpdGlvbiBtdXN0IGJlIG1ldCBiZWZvcmUgdXNpbmcgR1VQX1RF
U1QgYW5kDQo+IA0KPiANCj4gUmlnaHQsIGJ1dCBmaXJzdCBvZiBjb3Vyc2UgdGhleSBtdXN0IHJl
YWQgZXZlcnkgc2luZ2xlIGxpbmUgb2YgdGhlIHRlc3QgY29kZQ0KPiBjYXJlZnVsbHkuIEFuZCB3
aGlsZSBpdCBpcyB0cnVlIHRoZSB5b3Ugb2Z0ZW4gKmRvKiBlbmQgdXAgcmVhZGluZyBtb3N0IG9y
DQo+IGFsbCBvZiB0aGUgdGVzdCBjb2RlLCB0aGVyZSBhcmUgc2l0dWF0aW9ucyBpbiB3aGljaCB5
b3UgZG9uJ3QgbmVlZCB0by4gV2UnZA0KPiBiZSB0YWtpbmcgYXdheSBzb21lIG9mIHRob3NlIHNp
dHVhdGlvbnMuIDopDQo+IA0KDQpBbiBjYXJlbGVzcyBlbmdpbmVlciBsaWtlIG1lIG9mdGVuIGln
bm9yZSBzb21lIGRlcGVuZGVuY3kgZXZlbiBhZnRlciBJIGhhdmUNCnJlYWQgY29kZSBjYXJlZnVs
bHkuICJkZXBlbmRzIG9uIiB3aWxsIGVuZm9yY2UgbWUgdG8gcmVzb2x2ZSB0aGUgZGVwZW5kZW5j
eQ0KZHVyaW5nIGJ1aWxkIHN0YWdlIGFuZCBzYXZlIG1lIG11Y2ggdGltZSA6LSkNCg0KPiANCj4g
PiB0aGV5IG11c3QgbWFudWFsbHkgZW5hYmxlIGl0IGlmIHRoZXkgaGF2ZW4ndC4gVGhhdCdzIHdo
eSBJIHRoaW5rIHRoaXMgcGF0Y2ggaXMNCj4gPiBtYWtpbmcgdGhpbmdzIGJldHRlci4NCj4gPg0K
PiANCj4gLi4ud2hpY2ggbWFrZXMgdGhpbmdzIGEgbGl0dGxlIGJpdCB3b3JzZS4NCg0KRm9yIHRo
aXMgY2FzZSwgSSBhbSBhbHNvIGhhcHB5IHdpdGggInNlbGVjdCIgYXMgaXQgYWxzbyByZXNvbHZl
cyB0aGUgcHJvYmxlbSBvZg0Kc3RvcnkgQS4gSnVzdCBrY29uZmlnIGRvY3VtZW50YXRpb24gc2F5
cyAic2VsZWN0IiBzaG91bGQgYmUgdXNlZCB3aXRoIGNhcmUuDQoNCj4gDQo+IA0KPiB0aGFua3Ms
DQo+IC0tDQo+IEpvaG4gSHViYmFyZA0KPiBOVklESUENCg0KVGhhbmtzDQpCYXJyeQ0KDQo=
