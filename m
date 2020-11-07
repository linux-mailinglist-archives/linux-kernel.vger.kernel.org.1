Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 328022AA785
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 20:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbgKGTGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 14:06:01 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2069 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgKGTGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 14:06:01 -0500
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CT6BB1R4Pz67Grt;
        Sun,  8 Nov 2020 03:04:18 +0800 (CST)
Received: from lhreml735-chm.china.huawei.com (10.201.108.86) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Sat, 7 Nov 2020 20:05:59 +0100
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 lhreml735-chm.china.huawei.com (10.201.108.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Sat, 7 Nov 2020 19:05:57 +0000
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Sun, 8 Nov 2020 03:05:56 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     John Hubbard <jhubbard@nvidia.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Linuxarm <linuxarm@huawei.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Garry <john.garry@huawei.com>
Subject: RE: [PATCH] mm/gup_benchmark: GUP_BENCHMARK depends on DEBUG_FS
Thread-Topic: [PATCH] mm/gup_benchmark: GUP_BENCHMARK depends on DEBUG_FS
Thread-Index: AQHWspKkrOQfdWDOqkGzzyoK3BLHUam7SjKAgAG/lxA=
Date:   Sat, 7 Nov 2020 19:05:56 +0000
Message-ID: <9286e2d0e17a47a1874dc4a96d83a38f@hisilicon.com>
References: <20201104100552.20156-1-song.bao.hua@hisilicon.com>
 <e8ecbf3e-438e-934e-0335-ec9b3e097022@nvidia.com>
In-Reply-To: <e8ecbf3e-438e-934e-0335-ec9b3e097022@nvidia.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.58]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9obiBIdWJiYXJkIFtt
YWlsdG86amh1YmJhcmRAbnZpZGlhLmNvbV0NCj4gU2VudDogU2F0dXJkYXksIE5vdmVtYmVyIDcs
IDIwMjAgMToxMyBQTQ0KPiBUbzogU29uZyBCYW8gSHVhIChCYXJyeSBTb25nKSA8c29uZy5iYW8u
aHVhQGhpc2lsaWNvbi5jb20+Ow0KPiBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOyBsaW51eC1t
bUBrdmFjay5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IExpbnV4
YXJtIDxsaW51eGFybUBodWF3ZWkuY29tPjsgUmFscGggQ2FtcGJlbGwNCj4gPHJjYW1wYmVsbEBu
dmlkaWEuY29tPjsgSm9obiBHYXJyeSA8am9obi5nYXJyeUBodWF3ZWkuY29tPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIXSBtbS9ndXBfYmVuY2htYXJrOiBHVVBfQkVOQ0hNQVJLIGRlcGVuZHMgb24N
Cj4gREVCVUdfRlMNCj4gDQo+IE9uIDExLzQvMjAgMjowNSBBTSwgQmFycnkgU29uZyB3cm90ZToN
Cj4gPiBXaXRob3V0IERFQlVHX0ZTLCBhbGwgdGhlIGNvZGUgaW4gZ3VwX2JlbmNobWFyayBiZWNv
bWVzIG1lYW5pbmdsZXNzLg0KPiA+IEZvciBzdXJlIGtlcm5lbCBwcm92aWRlcyBkZWJ1Z2ZzIHN0
dWIgd2hpbGUgREVCVUdfRlMgaXMgZGlzYWJsZWQsIGJ1dA0KPiA+IHRoZSBwb2ludCBoZXJlIGlz
IHRoYXQgR1VQX0JFTkNITUFSSyBjYW4gZG8gbm90aGluZyB3aXRob3V0IERFQlVHX0ZTLg0KPiA+
DQo+ID4gQ2M6IEpvaG4gSHViYmFyZCA8amh1YmJhcmRAbnZpZGlhLmNvbT4NCj4gPiBDYzogUmFs
cGggQ2FtcGJlbGwgPHJjYW1wYmVsbEBudmlkaWEuY29tPg0KPiA+IEluc3BpcmVkLWJ5OiBKb2hu
IEdhcnJ5IDxqb2huLmdhcnJ5QGh1YXdlaS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogQmFycnkg
U29uZyA8c29uZy5iYW8uaHVhQGhpc2lsaWNvbi5jb20+DQo+ID4gLS0tDQo+ID4gICAqIGluc3Bp
cmVkIGJ5IEpvaG4ncyBjb21tZW50IGluIHRoaXMgcGF0Y2g6DQo+ID4NCj4gPiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9saW51eC1pb21tdS8xODQ3OTdiOC01MTJlLWUzZGEtZmFlNy0yNWM3ZDY2
MjY0DQo+ID4gOGJAaHVhd2VpLmNvbS8NCj4gPg0KPiA+ICAgbW0vS2NvbmZpZyB8IDEgKw0KPiA+
ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
bW0vS2NvbmZpZyBiL21tL0tjb25maWcNCj4gPiBpbmRleCBkNDI0MjNmLi45MWZhOTIzIDEwMDY0
NA0KPiA+IC0tLSBhL21tL0tjb25maWcNCj4gPiArKysgYi9tbS9LY29uZmlnDQo+ID4gQEAgLTgz
Niw2ICs4MzYsNyBAQCBjb25maWcgUEVSQ1BVX1NUQVRTDQo+ID4NCj4gPiAgIGNvbmZpZyBHVVBf
QkVOQ0hNQVJLDQo+ID4gICAJYm9vbCAiRW5hYmxlIGluZnJhc3RydWN0dXJlIGZvciBnZXRfdXNl
cl9wYWdlcygpIGFuZCByZWxhdGVkIGNhbGxzDQo+IGJlbmNobWFya2luZyINCj4gPiArCWRlcGVu
ZHMgb24gREVCVUdfRlMNCj4gDQo+IA0KPiBJIHRoaW5rICJzZWxlY3QgREVCVUdfRlMiIGlzIGJl
dHRlciBoZXJlLiAiZGVwZW5kcyBvbiIgaGFzIHRoZSBvYm5veGlvdXMNCj4gYmVoYXZpb3Igb2Yg
aGlkaW5nIHRoZSBjaG9pY2UgZnJvbSB5b3UsIGlmIHRoZSBkZXBlbmRlbmNpZXMgYXJlbid0IGFs
cmVhZHkgbWV0Lg0KPiBXaGVyZWFzIHdoYXQgdGhlIGRldmVsb3BlciAqcmVhbGx5KiB3YW50cyBp
cyBhIG5vLW5vbnNlbnNlIGFjdGl2YXRpb24gb2YgdGhlDQo+IGNob2ljZTogImVuYWJsZSBHVVBf
QkVOQ0hNQVJLIGFuZCB0aGUgZGVidWcgZnMgdGhhdCBpdCByZXF1aXJlcyIuDQo+IA0KDQpUbyBz
b21lIGV4dGVudCwgSSBhZ3JlZSB3aXRoIHlvdS4gQnV0IEkgc3RpbGwgdGhpbmsgaGVyZSBpdCBp
cyBiZXR0ZXIgdG8gdXNlICJkZXBlbmRzIG9uIi4NCkFjY29yZGluZyB0bw0KaHR0cHM6Ly93d3cu
a2VybmVsLm9yZy9kb2MvRG9jdW1lbnRhdGlvbi9rYnVpbGQva2NvbmZpZy1sYW5ndWFnZS50eHQN
Cg0KCXNlbGVjdCBzaG91bGQgYmUgdXNlZCB3aXRoIGNhcmUuIHNlbGVjdCB3aWxsIGZvcmNlDQoJ
YSBzeW1ib2wgdG8gYSB2YWx1ZSB3aXRob3V0IHZpc2l0aW5nIHRoZSBkZXBlbmRlbmNpZXMuDQoJ
QnkgYWJ1c2luZyBzZWxlY3QgeW91IGFyZSBhYmxlIHRvIHNlbGVjdCBhIHN5bWJvbCBGT08gZXZl
bg0KCWlmIEZPTyBkZXBlbmRzIG9uIEJBUiB0aGF0IGlzIG5vdCBzZXQuDQoJSW4gZ2VuZXJhbCB1
c2Ugc2VsZWN0IG9ubHkgZm9yIG5vbi12aXNpYmxlIHN5bWJvbHMNCgkobm8gcHJvbXB0cyBhbnl3
aGVyZSkgYW5kIGZvciBzeW1ib2xzIHdpdGggbm8gZGVwZW5kZW5jaWVzLg0KCVRoYXQgd2lsbCBs
aW1pdCB0aGUgdXNlZnVsbmVzcyBidXQgb24gdGhlIG90aGVyIGhhbmQgYXZvaWQNCgl0aGUgaWxs
ZWdhbCBjb25maWd1cmF0aW9ucyBhbGwgb3Zlci4NCg0KT24gdGhlIG90aGVyIGhhbmQsIGluIGtl
cm5lbCB0aGVyZSBhcmUgNzggImRlcGVuZHMgb24gREVCVUdfRlMiIGFuZA0Kb25seSAxNCAic2Vs
ZWN0IERFQlVHX0ZTIi4NCg0KJCBnaXQgZ3JlcCAiZGVwZW5kcyBvbiIgfCBncmVwIERFQlVHX0ZT
IHwgd2MgLWwNCjc4DQoNCiQgZ2l0IGdyZXAgInNlbGVjdCIgfCBncmVwIERFQlVHX0ZTIHwgd2Mg
LWwNCjE0DQoNCj4gU28gZGVwZW5kcyBvbiByZWFsbHkgb24gaXMgYmV0dGVyIGZvciB0aGluZ3Mg
dGhhdCB5b3UganVzdCBjYW4ndCBjb250cm9sLCBzdWNoIGFzDQo+IHRoZSBjcHUgYXJjaCB5b3Un
cmUgb24sIGV0Yy4NCj4gDQo+IEFsc28gbm90ZSB0aGF0IHRoaXMgd2lsbCBoYXZlIHNvbWUgbWlu
b3IgbWVyZ2UgY29uZmxpY3Qgd2l0aCBtbW90bSwgRHVlIHRvDQo+IHJlbmFtaW5nIHRvIEdVUF9U
RVNULiBObyBiaWcgZGVhbCB0aG91Z2guDQo+IA0KPiANCj4gdGhhbmtzLA0KPiAtLQ0KPiBKb2hu
IEh1YmJhcmQNCj4gTlZJRElBDQoNClRoYW5rcw0KQmFycnkNCg0K
