Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF76C2AA916
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 05:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbgKHEeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 23:34:24 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2072 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbgKHEeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 23:34:23 -0500
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CTLpQ6pvSz67HfG;
        Sun,  8 Nov 2020 12:33:02 +0800 (CST)
Received: from lhreml722-chm.china.huawei.com (10.201.108.73) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Sun, 8 Nov 2020 05:34:21 +0100
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 lhreml722-chm.china.huawei.com (10.201.108.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Sun, 8 Nov 2020 04:34:20 +0000
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Sun, 8 Nov 2020 12:34:18 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Linuxarm <linuxarm@huawei.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Garry <john.garry@huawei.com>
Subject: RE: [PATCH] mm/gup_benchmark: GUP_BENCHMARK depends on DEBUG_FS
Thread-Topic: [PATCH] mm/gup_benchmark: GUP_BENCHMARK depends on DEBUG_FS
Thread-Index: AQHWspKkrOQfdWDOqkGzzyoK3BLHUam7SjKAgAG/lxD//4AMgIAAM28AgAAckACAAK7tEP//hnEAgAACPYCAAA3ogIAAig1A
Date:   Sun, 8 Nov 2020 04:34:18 +0000
Message-ID: <5b76cc7a3ca44e958e18f48ed4c5291d@hisilicon.com>
References: <20201104100552.20156-1-song.bao.hua@hisilicon.com>
 <e8ecbf3e-438e-934e-0335-ec9b3e097022@nvidia.com>
 <9286e2d0e17a47a1874dc4a96d83a38f@hisilicon.com>
 <e6b74390-6a80-9aae-17b2-536ffa0d1aae@nvidia.com>
 <a5f5b63a-ff9d-ed74-212f-f959f038b781@infradead.org>
 <2c968615-587c-b978-7961-8391c70382b2@nvidia.com>
 <869059977c224a3aa31bfb42a4a8148d@hisilicon.com>
 <dd9e5f78-d627-89d6-2b9d-f2912213171f@nvidia.com>
 <8eaa47c0-a62d-46da-4fd6-93f2b5b2910d@nvidia.com>
 <e08c812d-80bf-12ec-794e-a726a1b37433@infradead.org>
In-Reply-To: <e08c812d-80bf-12ec-794e-a726a1b37433@infradead.org>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFuZHkgRHVubGFwIFtt
YWlsdG86cmR1bmxhcEBpbmZyYWRlYWQub3JnXQ0KPiBTZW50OiBTdW5kYXksIE5vdmVtYmVyIDgs
IDIwMjAgNToxMiBQTQ0KPiBUbzogSm9obiBIdWJiYXJkIDxqaHViYmFyZEBudmlkaWEuY29tPjsg
U29uZyBCYW8gSHVhIChCYXJyeSBTb25nKQ0KPiA8c29uZy5iYW8uaHVhQGhpc2lsaWNvbi5jb20+
OyBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOw0KPiBsaW51eC1tbUBrdmFjay5vcmc7IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IExpbnV4YXJtIDxsaW51eGFybUBodWF3ZWku
Y29tPjsgUmFscGggQ2FtcGJlbGwNCj4gPHJjYW1wYmVsbEBudmlkaWEuY29tPjsgSm9obiBHYXJy
eSA8am9obi5nYXJyeUBodWF3ZWkuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBtbS9ndXBf
YmVuY2htYXJrOiBHVVBfQkVOQ0hNQVJLIGRlcGVuZHMgb24NCj4gREVCVUdfRlMNCj4gDQo+IE9u
IDExLzcvMjAgNzoyMiBQTSwgSm9obiBIdWJiYXJkIHdyb3RlOg0KPiA+IE9uIDExLzcvMjAgNzox
NCBQTSwgSm9obiBIdWJiYXJkIHdyb3RlOg0KPiA+PiBPbiAxMS83LzIwIDY6NTggUE0sIFNvbmcg
QmFvIEh1YSAoQmFycnkgU29uZykgd3JvdGU6DQo+ID4+Pj4gT24gMTEvNy8yMCAyOjIwIFBNLCBS
YW5keSBEdW5sYXAgd3JvdGU6DQo+ID4+Pj4+IE9uIDExLzcvMjAgMTE6MTYgQU0sIEpvaG4gSHVi
YmFyZCB3cm90ZToNCj4gPj4+Pj4+IE9uIDExLzcvMjAgMTE6MDUgQU0sIFNvbmcgQmFvIEh1YSAo
QmFycnkgU29uZykgd3JvdGU6DQo+ID4+Pj4+Pj4+IEZyb206IEpvaG4gSHViYmFyZCBbbWFpbHRv
OmpodWJiYXJkQG52aWRpYS5jb21dDQo+ID4+Pj4+PiAuLi4NCj4gPj4+PiBCdXQgaWYgeW91IHJl
YWxseSBkaXNhZ3JlZSwgdGhlbiBJJ2QgZ28gd2l0aCwganVzdCBkcm9wIHRoZSBwYXRjaCBlbnRp
cmVseSwNCj4gYmVjYXVzZQ0KPiA+Pj4+IGl0IGRvZXNuJ3QgcmVhbGx5IG1ha2UgdGhpbmdzIGJl
dHRlciBhcyB3cml0dGVuLi4uSU1ITyBhbnl3YXkuIDopDQo+ID4+Pg0KPiA+Pj4gSnVzdCBpbWFn
aW5lIGEgY2FzZSwgd2UgZG9uJ3QgZW5hYmxlIERFQlVHX0ZTIGJ1dCB3ZSBlbmFibGUgR1VQX1RF
U1QsDQo+IHdlIHdpbGwNCj4gPj4+IGdldCBhbiBpbWFnZSB3aXRoIHRvdGFsbHkgdXNlbGVzcyBj
b2RlIHNlY3Rpb24gc2luY2UgR1VQX1RFU1QgZGVwZW5kcyBvbg0KPiBkZWJ1Z2ZzDQo+ID4+PiBl
bnRyeSB0byBwZXJmb3JtIGFueSB1c2VmdWwgZnVuY3Rpb25hbGl0eS4NCj4gPj4+DQo+ID4+DQo+
ID4+IExvb2tpbmcgYXQgdGhlIGNob2ljZXMsIGZyb20gdGhlIHVzZXIncyAodXN1YWxseSBrZXJu
ZWwgZGV2ZWxvcGVyJ3MpDQo+IGV4cGVyaWVuY2U6DQo+ID4+DQo+ID4+IGEpIFRoZSB1c2VyIGVu
YWJsZXMgR1VQX1RFU1QsIHRoZW4gYm9vdHMgdXAsIHJ1bnMsIGFuZCBpcyBicmllZmx5IHN1cnBy
aXNlZA0KPiBieSBhDQo+ID4+IHJ1bnRpbWUgZmFpbHVyZS4gQnV0IGl0J3MgYSB2ZXJ5IHF1aWNr
IGRpYWdub3NpczogIm9wZW46IE5vIHN1Y2ggZmlsZSBvcg0KPiBkaXJlY3RvcnkiLA0KPiA+PiB3
aGVuIHRyeWluZyB0byBtYWtlIHRoYXQgaW9jdGwgY2FsbC4gVGhlIHBhdGggaW5kaWNhdGVzIHRo
YXQgaXQncyBhIGRlYnVnIGZzDQo+IHBhdGgsDQo+ID4+IHNvIHRoZSBzb2x1dGlvbiBpcyBwcmV0
dHkgY2xlYXIsIGF0IGxlYXN0IGZvciB0aGUgbWFpbiBhdWRpZW5jZS4NCj4gPj4NCj4gPj4gYikg
VGhlIG90aGVyIGNob2ljZTogdGhlIHVzZXIgKm5ldmVyIGV2ZW4gc2VlcyogR1VQX1RFU1QgYXMg
YSBjaG9pY2UuIFRoaXMNCj4gZXNwZWNpYWxseQ0KPiA+PiBib3RoZXJzIG1lIGJlY2F1c2Ugc29t
ZXRpbWVzIHlvdSBmaW5kIHRoaW5ncyBieSBwb2tpbmcgYXJvdW5kIGluIHRoZQ0KPiBtZW51LCBh
bHRob3VnaA0KPiA+PiBvZiBjb3Vyc2UgInlvdSBzaG91bGQgYWxyZWFkeSBrbm93IGFib3V0IGl0
Ii4uLmJ1dCB0aGVyZSdzIGEgbG90IHRvICJhbHJlYWR5DQo+IGtub3ciDQo+ID4+IGluIGEgbGFy
Z2Uga2VybmVsLg0KPiA+Pg0KPiA+PiDCoEZyb20gYSB1c2VyIGV4cGVyaWVuY2UsIGl0J3Mgd2F5
IGJldHRlciB0byBzaW1wbHkgc2VlIHdoYXQgeW91IHdhbnQsIGFuZA0KPiBzZWxlY3QgaXQNCj4g
Pj4gaW4gdGhlIG1lbnUuIE9yLCBhdCBsZWFzdCBnZXQgc29tZSBwcm9tcHQgdGhhdCB5b3UgbmVl
ZCB0byBwcmUtc2VsZWN0DQo+IHNvbWV0aGluZyBlbHNlLg0KPiA+Pg0KPiA+DQo+ID4gLi4uYW5k
IGFnYWluLCB0aGlzIGlzIGFsbCBmYWxsb3V0IGZyb20gS2NvbmZpZy4gSSBtaWdodCBiZSBtaXNz
aW5nIHNvbWUgYWR2YW5jZWQNCj4gPiBmZWF0dXJlLCBiZWNhdXNlIGl0IHNlZW1zIHN1cnByaXNp
bmcgdG8gb25seSBiZSBhbGxvd2VkIHRvIGNob29zZSBiZXR3ZWVuDQo+ID4gbWlzc2luZyBkZXBl
bmRlbmNpZXMgKHdoaWNoIHRoaXMgcGF0Y2ggd291bGQgY29ycmVjdCksIG9yIGEgcG9vcmVyIHVz
ZXINCj4gZXhwZXJpZW5jZQ0KPiA+ICh3aGljaCBJIGFyZ3VlIHRoYXQgdGhpcyBwYXRjaCB3b3Vs
ZCBhbHNvIHByb3ZpZGUpLg0KPiA+DQo+ID4gSWRlYWxseSwgd2UnZCBqdXN0IHNldCB1cCB0aGUg
ZGVwZW5kZW5jaWVzLCBhbmQgdGhlbiBoYXZlIHNvbWUgb3B0aW9ucyBmb3INCj4gPiB2aXNpYmls
aXR5LCBidXQgSSdtIG5vdCBhd2FyZSBvZiBhbnkgd2F5IHRvIGRvIHRoYXQuLi5hbmQgYWZ0ZXIg
YSBxdWljayBwZWVrDQo+ID4gYXQgRG9jdW1lbnRhdGlvbi9rYnVpbGQva2NvbmZpZy1tYWNyby1s
YW5ndWFnZS5yc3QgaXQgbG9va3MgcHJldHR5IGJhcmUNCj4gYm9uZXMuDQo+IA0KPiBMb29rIGF0
IGtjb25maWctbGFuZ3VhZ2UucnN0IGluc3RlYWQuDQo+IA0KPiBPbmUgdGhpbmcgdGhhdCBjb3Vs
ZCBiZSBkb25lIChhbmQgaXMgZG9uZSBpbiBhIGZldyBwbGFjZXMgZm9yIG90aGVyIHJlYXNvbnMp
IGlzDQo+IHRvIGFkZA0KPiBhIEtjb25maWcgY29tbWVudCBpZiBERUJVR19GUyBpcyBub3QgZW5h
YmxlZDoNCj4gDQo+IGNvbW1lbnQgIkdVUF9URVNUIG5lZWRzIHRvIGhhdmUgREVCVUdfRlMgZW5h
YmxlZCINCj4gCWRlcGVuZHMgb24gIUdVUF9URVNUICYmICFERUJVR19GUw0KPiANCj4gZS5nLiBk
cml2ZXJzL2hpZC91c2JoaWQvS2NvbmZpZzoNCj4gDQo+IGNvbW1lbnQgIklucHV0IGNvcmUgc3Vw
cG9ydCBpcyBuZWVkZWQgZm9yIFVTQiBISUQgaW5wdXQgbGF5ZXIgb3IgSElEQlANCj4gc3VwcG9y
dCINCj4gCWRlcGVuZHMgb24gVVNCX0hJRCAmJiBJTlBVVD1uDQoNCg0KVGhpcyBpcyBpbnRlcmVz
dGluZy4NClRoYW5rcyBmb3Igc2hhcmluZyB0aGlzLiBJJ3ZlIG5ldmVyIHJlYWxpemVkIHdlIGNh
biBkbyB0aGlzIGtpbmQgb2YgY29tbWVudHMuDQpXaGF0IEkgaGF2ZSBiZWVuIGFsd2F5cyBkb2lu
ZyBpcyBzaW1wbHkgcmVhZGluZyB0aGUgc3RhdHVzIGZyb20gbWVudWNvbmZpZy4NCkZvciBleGFt
cGxlLCB0byB1c2UgSUlPX0NPTlNVTUVSU19QRVJfVFJJR0dFUiwgSSBzZWFyY2ggaXQgaW4gbWVu
dWNvbmZpZw0KYnkgIi8iLCBJIGdldDoNCg0KU3ltYm9sOiBJSU9fQ09OU1VNRVJTX1BFUl9UUklH
R0VSIFs9XQ0KICDilIIgVHlwZSAgOiBpbnRlZ2VyDQogIOKUgiBEZWZpbmVkIGF0IGRyaXZlcnMv
aWlvL0tjb25maWc6NDENCiAg4pSCICAgUHJvbXB0OiBNYXhpbXVtIG51bWJlciBvZiBjb25zdW1l
cnMgcGVyIHRyaWdnZXINCiAg4pSCICAgRGVwZW5kcyBvbjogSUlPIFs9bl0gJiYgSUlPX1RSSUdH
RVIgWz1uXQ0KICDilIIgICBMb2NhdGlvbjoNCiAg4pSCICAgICAtPiBEZXZpY2UgRHJpdmVycw0K
ICDilIIgKDEpICAgLT4gSW5kdXN0cmlhbCBJL08gc3VwcG9ydCAoSUlPIFs9bl0pDQogIOKUgiAg
ICAgICAgIC0+IEVuYWJsZSB0cmlnZ2VyZWQgc2FtcGxpbmcgc3VwcG9ydCAoSUlPX1RSSUdHRVIg
Wz1uXSkNCiAg4pSCDQoNClRoZSBtZW51Y29uZmlnIHRlbGxzIG1lIGl0IGRlcGVuZHMgb24gSUlP
IGFuZCBJSU9fVFJJR0dFUi4gQnV0IGJvdGggb2YNCnRoZW0gYXJlICJuIi4gc28gdGhlIG5leHQg
c3RlcCwgSSBhbSBnb2luZyB0byBtYWtlIElJTyBhbmQgSUlPX1RSSUdHRVINCiJ5Ii4NCg0KDQo+
IA0KPiANCj4gLS0NCj4gflJhbmR5DQoNClRoYW5rcw0KQmFycnkNCg0K
