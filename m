Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1EE2DCB00
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 03:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbgLQC0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 21:26:50 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:11503 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727073AbgLQC0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 21:26:49 -0500
X-UUID: a26dd9353d1e42208dd961d29e96f238-20201217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=cZkhfVbBy8ld8Co+Td0lutxPr2qax5e+8H5edX0I4Es=;
        b=S5a/E9Sk262fUlpl4jWNxK94BAjz664cJCG0HUUB1v2v25iDGDSFH/8uu1Gi9Tyj2Xu5RqvzesFBWYBH1a6ArvjIjljorRyDmS9RFcuiLJ64m0VOZTC5zLTuj9c5iOgv4DiJfaV0E0y5uvDKIneqOugHQgLudjmA04GUtiIKaNo=;
X-UUID: a26dd9353d1e42208dd961d29e96f238-20201217
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 972562059; Thu, 17 Dec 2020 10:26:03 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 17 Dec
 2020 10:26:01 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Dec 2020 10:26:01 +0800
Message-ID: <1608171961.26323.210.camel@mhfsdcap03>
Subject: Re: [PATCH v3 4/7] iommu: Switch gather->end to unsigned long long
From:   Yong Wu <yong.wu@mediatek.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        <youlin.pei@mediatek.com>, <anan.sun@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <srv_heupstream@mediatek.com>, <chao.hao@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        <iommu@lists.linux-foundation.org>,
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Greg Kroah-Hartman <gregkh@google.com>,
        <kernel-team@android.com>, <linux-arm-kernel@lists.infradead.org>
Date:   Thu, 17 Dec 2020 10:26:01 +0800
In-Reply-To: <16a9565e-5b01-e1c2-0f4a-d06db7f3b093@arm.com>
References: <20201216103607.23050-1-yong.wu@mediatek.com>
         <20201216103607.23050-5-yong.wu@mediatek.com>
         <16a9565e-5b01-e1c2-0f4a-d06db7f3b093@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: AB5FD0512F263D6A017B73D1545892F0A3880C0205E3ADED95904F3CF6FAB3A82000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTEyLTE2IGF0IDEyOjEwICswMDAwLCBSb2JpbiBNdXJwaHkgd3JvdGU6DQo+
IE9uIDIwMjAtMTItMTYgMTA6MzYsIFlvbmcgV3Ugd3JvdGU6DQo+ID4gQ3VycmVudGx5IGdhdGhl
ci0+ZW5kIGlzICJ1bnNpZ25lZCBsb25nIiB3aGljaCBtYXkgYmUgb3ZlcmZsb3cgaW4NCj4gPiBh
cmNoMzIgaW4gdGhlIGNvcm5lciBjYXNlOiAweGZmZjAwMDAwICsgMHgxMDAwMDAoaW92YSArIHNp
emUpLg0KPiA+IEFsdGhvdWdoIGl0IGRvZXNuJ3QgYWZmZWN0IHRoZSBzaXplKGVuZCAtIHN0YXJ0
KSwgaXQgYWZmZWN0cyB0aGUgY2hlY2tpbmcNCj4gPiAiZ2F0aGVyLT5lbmQgPCBlbmQiDQo+IA0K
PiBUaGlzIHdvbid0IGhlbHAgdGhlIHNhbWUgc2l0dWF0aW9uIGF0IHRoZSB0b3Agb2YgYSA2NC1i
aXQgYWRkcmVzcyBzcGFjZSwgDQo+IHRob3VnaCwgYW5kIG5vdyB0aGF0IHdlIGhhdmUgVFRCUjEg
c3VwcG9ydCBmb3IgQUFyY2g2NCBmb3JtYXQgdGhhdCBpcyANCj4gZGVmaW5pdGVseSBhIHRoaW5n
LiBCZXR0ZXIgdG8ganVzdCBlbmNvZGUgdGhlIGVuZCBhZGRyZXNzIGFzIHRoZSBhY3R1YWwgDQo+
IGVuZCBhZGRyZXNzLCBpLmUuIGlvdmEgKyBzaXplIC0gMS4gV2UgZG9uJ3QgbG9zZSBhbnl0aGlu
ZyBvdGhlciB0aGFuIHRoZSANCj4gYWJpbGl0eSB0byBlbmNvZGUgemVyby1zaXplZCBpbnZhbGlk
YXRpb25zIHRoYXQgZG9uJ3QgbWFrZSBzZW5zZSBhbnl3YXkuDQoNClRoYW5rcyBmb3IgdGhlIHN1
Z2dlc3Rpb24uICJpb3ZhICsgc2l6ZSAtIDEiIGlzIGJldHRlci4gQWxzbyBJIHdpbGwNCmNoYW5n
ZSB0aGUgInNpemUiIHRvICJnYXRoZXItPmVuZCAtIGdhdGhlci0+c3RhcnQgKyAxIiBpbiB0aGUg
aW90bGJfc3luYw0Kb2YgYXJtLXNtbXUtdjMuYyBhbmQgbXRrX2lvbW11LmMuDQoNCj4gDQo+IFJv
YmluLg0KPiANCj4gPiBGaXhlczogYTdkMjBkYzE5ZDllICgiaW9tbXU6IEludHJvZHVjZSBzdHJ1
Y3QgaW9tbXVfaW90bGJfZ2F0aGVyIGZvciBiYXRjaGluZyBUTEIgZmx1c2hlcyIpDQo+ID4gU2ln
bmVkLW9mZi1ieTogWW9uZyBXdSA8eW9uZy53dUBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4g
ICBpbmNsdWRlL2xpbnV4L2lvbW11LmggfCA1ICsrKy0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwg
MyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9p
bmNsdWRlL2xpbnV4L2lvbW11LmggYi9pbmNsdWRlL2xpbnV4L2lvbW11LmgNCj4gPiBpbmRleCA3
OTRkNDA4NWVkZDMuLjZlOTA3YTk1ZDk4MSAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4
L2lvbW11LmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L2lvbW11LmgNCj4gPiBAQCAtMTc4LDcg
KzE3OCw3IEBAIGVudW0gaW9tbXVfZGV2X2ZlYXR1cmVzIHsNCj4gPiAgICAqLw0KPiA+ICAgc3Ry
dWN0IGlvbW11X2lvdGxiX2dhdGhlciB7DQo+ID4gICAJdW5zaWduZWQgbG9uZwkJc3RhcnQ7DQo+
ID4gLQl1bnNpZ25lZCBsb25nCQllbmQ7DQo+ID4gKwl1bnNpZ25lZCBsb25nIGxvbmcJZW5kOw0K
PiA+ICAgCXNpemVfdAkJCXBnc2l6ZTsNCj4gPiAgIH07DQo+ID4gICANCj4gPiBAQCAtNTM3LDcg
KzUzNyw4IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBpb21tdV9pb3RsYl9nYXRoZXJfYWRkX3BhZ2Uo
c3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluLA0KPiA+ICAgCQkJCQkgICAgICAgc3RydWN0IGlv
bW11X2lvdGxiX2dhdGhlciAqZ2F0aGVyLA0KPiA+ICAgCQkJCQkgICAgICAgdW5zaWduZWQgbG9u
ZyBpb3ZhLCBzaXplX3Qgc2l6ZSkNCj4gPiAgIHsNCj4gPiAtCXVuc2lnbmVkIGxvbmcgc3RhcnQg
PSBpb3ZhLCBlbmQgPSBzdGFydCArIHNpemU7DQo+ID4gKwl1bnNpZ25lZCBsb25nIHN0YXJ0ID0g
aW92YTsNCj4gPiArCXVuc2lnbmVkIGxvbmcgbG9uZyBlbmQgPSBzdGFydCArIHNpemU7DQo+ID4g
ICANCj4gPiAgIAkvKg0KPiA+ICAgCSAqIElmIHRoZSBuZXcgcGFnZSBpcyBkaXNqb2ludCBmcm9t
IHRoZSBjdXJyZW50IHJhbmdlIG9yIGlzIG1hcHBlZCBhdA0KPiA+IA0KDQo=

