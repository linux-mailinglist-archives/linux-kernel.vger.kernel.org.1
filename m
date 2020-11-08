Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF8A2AA9F9
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 08:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgKHHfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 02:35:55 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2073 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgKHHfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 02:35:55 -0500
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CTQqt11y5z67H9k;
        Sun,  8 Nov 2020 15:34:34 +0800 (CST)
Received: from lhreml735-chm.china.huawei.com (10.201.108.86) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Sun, 8 Nov 2020 08:35:53 +0100
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 lhreml735-chm.china.huawei.com (10.201.108.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Sun, 8 Nov 2020 07:35:51 +0000
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Sun, 8 Nov 2020 15:35:50 +0800
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
Thread-Index: AQHWspKkrOQfdWDOqkGzzyoK3BLHUam7SjKAgAG/lxD//4AMgIAAM28AgAAckACAAK7tEP//hnEAgAACPYCAAA3ogIAADE2AgACrcZA=
Date:   Sun, 8 Nov 2020 07:35:50 +0000
Message-ID: <a7a56afecfd7484cb0cce8e1d51a8242@hisilicon.com>
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
 <28eb72a6-37de-6e60-9127-d1678aac5f5c@nvidia.com>
In-Reply-To: <28eb72a6-37de-6e60-9127-d1678aac5f5c@nvidia.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.59]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9obiBIdWJiYXJkIFtt
YWlsdG86amh1YmJhcmRAbnZpZGlhLmNvbV0NCj4gU2VudDogU3VuZGF5LCBOb3ZlbWJlciA4LCAy
MDIwIDU6NTYgUE0NCj4gVG86IFJhbmR5IER1bmxhcCA8cmR1bmxhcEBpbmZyYWRlYWQub3JnPjsg
U29uZyBCYW8gSHVhIChCYXJyeSBTb25nKQ0KPiA8c29uZy5iYW8uaHVhQGhpc2lsaWNvbi5jb20+
OyBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOw0KPiBsaW51eC1tbUBrdmFjay5vcmc7IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IExpbnV4YXJtIDxsaW51eGFybUBodWF3ZWku
Y29tPjsgUmFscGggQ2FtcGJlbGwNCj4gPHJjYW1wYmVsbEBudmlkaWEuY29tPjsgSm9obiBHYXJy
eSA8am9obi5nYXJyeUBodWF3ZWkuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBtbS9ndXBf
YmVuY2htYXJrOiBHVVBfQkVOQ0hNQVJLIGRlcGVuZHMgb24NCj4gREVCVUdfRlMNCj4gDQo+IE9u
IDExLzcvMjAgODoxMSBQTSwgUmFuZHkgRHVubGFwIHdyb3RlOg0KPiAuLi4NCj4gPiBMb29rIGF0
IGtjb25maWctbGFuZ3VhZ2UucnN0IGluc3RlYWQuDQo+IA0KPiBhaGEsIHllcy4NCj4gDQo+ID4N
Cj4gPiBPbmUgdGhpbmcgdGhhdCBjb3VsZCBiZSBkb25lIChhbmQgaXMgZG9uZSBpbiBhIGZldyBw
bGFjZXMgZm9yIG90aGVyIHJlYXNvbnMpDQo+IGlzIHRvIGFkZA0KPiA+IGEgS2NvbmZpZyBjb21t
ZW50IGlmIERFQlVHX0ZTIGlzIG5vdCBlbmFibGVkOg0KPiA+DQo+ID4gY29tbWVudCAiR1VQX1RF
U1QgbmVlZHMgdG8gaGF2ZSBERUJVR19GUyBlbmFibGVkIg0KPiA+IAlkZXBlbmRzIG9uICFHVVBf
VEVTVCAmJiAhREVCVUdfRlMNCj4gPg0KPiANCj4gU3dlZXQtLUkganVzdCBhcHBsaWVkIHRoYXQg
aGVyZSwgYW5kIGl0IGRvZXMgZXhhY3RseSB3aGF0IEkgd2FudGVkOiBwdXRzIGEgbmljZQ0KPiBj
bGVhcg0KPiBtZXNzYWdlIG9uIHRoZSAibWFrZSBtZW51Y29uZmlnIiBzY3JlZW4uIE5vIG1vcmUg
aGlkZGVuIGl0ZW0uIEJyaWxsaWFudCENCj4gDQo+IExldCdzIGdvIHdpdGggdGhhdCwgc2hhbGwg
d2U/DQoNCkRvIHlvdSB3YW50IHRoaXMNCg0KKENvZGUgQSkNCg0KZGlmZiAtLWdpdCBhL21tL0tj
b25maWcgYi9tbS9LY29uZmlnDQppbmRleCAwMWIwYWUwY2Q5ZDMuLmQ4MDgzOWQxZmFkOCAxMDA2
NDQNCi0tLSBhL21tL0tjb25maWcNCisrKyBiL21tL0tjb25maWcNCkBAIC04NTMsNiArODUzLDkg
QEAgY29uZmlnIEdVUF9URVNUDQoNCiAgICAgICAgICBTZWUgdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMvdm0vZ3VwX3Rlc3QuYw0KDQorY29tbWVudCAiR1VQX1RFU1QgbmVlZHMgdG8gaGF2ZSBERUJV
R19GUyBlbmFibGVkIg0KKyAgICAgICBkZXBlbmRzIG9uICFHVVBfVEVTVCAmJiAhREVCVUdfRlMN
CisNCiBjb25maWcgR1VQX0dFVF9QVEVfTE9XX0hJR0gNCiAgICAgICAgYm9vbA0KDQpPciBkbyB5
b3Ugd2FudCB0aGlzID8NCg0KKENvZGUgQikNCmRpZmYgLS1naXQgYS9tbS9LY29uZmlnIGIvbW0v
S2NvbmZpZw0KaW5kZXggMDFiMGFlMGNkOWQzLi5hN2ZmMGQzMWFmZDUgMTAwNjQ0DQotLS0gYS9t
bS9LY29uZmlnDQorKysgYi9tbS9LY29uZmlnDQpAQCAtODM2LDYgKzgzNiw3IEBAIGNvbmZpZyBQ
RVJDUFVfU1RBVFMNCg0KIGNvbmZpZyBHVVBfVEVTVA0KICAgICAgICBib29sICJFbmFibGUgaW5m
cmFzdHJ1Y3R1cmUgZm9yIGdldF91c2VyX3BhZ2VzKCktcmVsYXRlZCB1bml0IHRlc3RzIg0KKyAg
ICAgICBkZXBlbmRzIG9uIERFQlVHX0ZTDQogICAgICAgIGhlbHANCiAgICAgICAgICBQcm92aWRl
cyAvc3lzL2tlcm5lbC9kZWJ1Zy9ndXBfdGVzdCwgd2hpY2ggaW4gdHVybiBwcm92aWRlcyBhIHdh
eQ0KICAgICAgICAgIHRvIG1ha2UgaW9jdGwgY2FsbHMgdGhhdCBjYW4gbGF1bmNoIGtlcm5lbC1i
YXNlZCB1bml0IHRlc3RzIGZvcg0KQEAgLTg1Myw2ICs4NTQsOSBAQCBjb25maWcgR1VQX1RFU1QN
Cg0KICAgICAgICAgIFNlZSB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy92bS9ndXBfdGVzdC5jDQoN
Citjb21tZW50ICJHVVBfVEVTVCBuZWVkcyB0byBoYXZlIERFQlVHX0ZTIGVuYWJsZWQiDQorICAg
ICAgIGRlcGVuZHMgb24gIUdVUF9URVNUICYmICFERUJVR19GUw0KKw0KIGNvbmZpZyBHVVBfR0VU
X1BURV9MT1dfSElHSA0KICAgICAgICBib29sDQoNClRvIGJlIGhvbmVzdCwgSSBhbSBub3QgYSBi
aWcgZmFuIG9mIGJvdGggb2YgY29kZSBBIGFuZCBCLiBJIHRoaW5rICJkZXBlbmRzIG9uIiBoYXMN
CmNsZWFybHkgc2FpZCBldmVyeXRoaW5nIHRoZSByZWR1bmRhbnQgY29tbWVudCB3YW50cyB0byBz
YXkuDQoNCiAg4pSCIFN5bWJvbDogR1VQX1RFU1QgWz1dDQogIOKUgiBUeXBlICA6IGJvb2wNCiAg
4pSCIERlZmluZWQgYXQgbW0vS2NvbmZpZzo4MzcNCiAg4pSCICAgUHJvbXB0OiBFbmFibGUgaW5m
cmFzdHJ1Y3R1cmUgZm9yIGdldF91c2VyX3BhZ2VzKCktcmVsYXRlZCB1bml0IHRlc3RzDQogIOKU
giAgIERlcGVuZHMgb246IERFQlVHX0ZTIFs9bl0NCiAg4pSCICAgTG9jYXRpb246DQogIOKUgiAo
MSkgLT4gTWVtb3J5IE1hbmFnZW1lbnQgb3B0aW9uDQoNCk1lbnVjb25maWcgc2hvd3MgR1VQX1RF
U1QgZGVwZW5kcyBvbiBERUJVR19GUyBhbmQgcmlnaHQgbm93IERFQlVHX0ZTIGlzDQoibiIuIHNv
IGl0IGlzIGltcG9zc2libGUgdG8gZW5hYmxlIEdVUF9URVNULg0KDQoiY29tbWVudCIgaXMgYSBn
b29kIHRoaW5nLCBidXQgaXQgaXMgbW9yZSBsaWtlbHkgdG8gYmUgdXNlZCBmb3IgYSBtZW51IG9y
IGEgZ3JvdXANCm9mIGNvbmZpZ3VyYXRpb25zIHRvIGV4dGVuZCBhIGJ1bmRsZSBvZiB0aGluZ3Mu
DQoNCk9uIHRoZSBvdGhlciBoYW5kLCBJZiB0aGlzIHBhcnRpY3VsYXIgY2FzZSBuZWVkcyB0aGlz
IGNvbW1lbnQsIHNvIGRvIGNvdW50bGVzcw0Kb3RoZXIgY29uZmlndXJhdGlvbnMgaW4gaHVuZHJl
ZHMgb2YgS2NvbmZpZyBmaWxlcy4NCg0KTXkgZmF2b3JpdGUgb3JkZXIgaXMNCjEuIGRlcGVuZHMg
b24NCjIuIHNlbGVjdA0KMy4gZGVwZW5kcyBvbiArIGNvbW1lbnQoY29kZSBCKQ0KNC4gY29tbWVu
dCBvbmx5KGNvZGUgQSkNCg0KSSB3b24ndCBhY2NlcHQgNCwgYnV0IGl0IHNlZW1zIHdlIGNhbid0
IGdldCBhZ3JlZW1lbnQgb24gMSB3aGljaCBpcyBteSBmYXZvcml0ZS4gDQpTbyBpZiB5b3Ugd2Fu
dCBlaXRoZXIgb25lIG9mIDIgYW5kIDMsIEkgYW0gaGFwcHkgdG8gc2VuZCB2MiBmb3IgdGhhdC4g
U28gd2hpY2ggb25lDQppcyB5b3VyIGZhdm9yaXRlPyAyIG9yIDM/DQoNCj4gDQo+IHRoYW5rcywN
Cj4gLS0NCj4gSm9obiBIdWJiYXJkDQo+IE5WSURJQQ0KDQpUaGFua3MNCkJhcnJ5DQo=
