Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAC32AF59F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 16:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgKKP7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 10:59:12 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:54455 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727590AbgKKP7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 10:59:12 -0500
X-UUID: 813a5772f24d40769f49b36f6ed8fdaf-20201111
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=xCmbhg/5jmIuPqUldt+rGLMqL6600tVUbwxVNv5GAVU=;
        b=R2JddcGGHFBS3Pu3jj0xR4PeWbdnS3Eyeybpm/CVWKB+mj27gv4Q6LMqc9e9OyG16zYQ03fSlSDJfjbGbCiUjrU7WtoUyd+eFVx9kHI8H8zecCvOev/OP6YzywrvjlvSeMSYBMYfPmdFljEsMFIhW5i5oE6qohBjDZ7D8Cf3bBo=;
X-UUID: 813a5772f24d40769f49b36f6ed8fdaf-20201111
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <frankie.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2072451480; Wed, 11 Nov 2020 23:59:07 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 11 Nov 2020 23:59:03 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 11 Nov 2020 23:59:03 +0800
Message-ID: <1605110345.11768.39.camel@mtkswgap22>
Subject: Re: [PATCH v13 3/3] binder: add transaction latency tracer
From:   Frankie Chang <Frankie.Chang@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        Jian-Min Liu <Jian-Min.Liu@mediatek.com>
Date:   Wed, 11 Nov 2020 23:59:05 +0800
In-Reply-To: <X6v/VAffVOOy56bG@kroah.com>
References: <X6quBb28IVvyRhox@kroah.com>
         <1605063764-12930-1-git-send-email-Frankie.Chang@mediatek.com>
         <1605063764-12930-4-git-send-email-Frankie.Chang@mediatek.com>
         <X6uT941IJ3uf/7aE@kroah.com> <1605106986.11768.14.camel@mtkswgap22>
         <X6v/VAffVOOy56bG@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: FA6BA9D4587340939BBF11940F277C78D12E5456F541ABF8A772CB8D0B57DF952000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTExLTExIGF0IDE2OjEyICswMTAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3Jv
dGU6DQo+IE9uIFdlZCwgTm92IDExLCAyMDIwIGF0IDExOjAzOjA2UE0gKzA4MDAsIEZyYW5raWUg
Q2hhbmcgd3JvdGU6DQo+ID4gT24gV2VkLCAyMDIwLTExLTExIGF0IDA4OjM0ICswMTAwLCBHcmVn
IEtyb2FoLUhhcnRtYW4gd3JvdGU6DQo+ID4gPiA+IC0gVGhlIHJlYXNvbiB3aHkgcHJpbnRpbmcg
dGhlIHJlbGF0ZWQgaW5mb3JtYXRpb24gdG8NCj4gPiA+ID4gICBrZXJuZWwgaW5mb3JtYXRpb24g
bG9nIGJ1dCBub3QgdHJhY2UgYnVmZmVyIGlzIHRoYXQNCj4gPiA+ID4gICBzb21lIGFibm9ybWFs
IHRyYW5zYWN0aW9ucyBtYXkgYmUgcGVuZGluZyBmb3IgYSBsb25nDQo+ID4gPiA+ICAgdGltZSBh
Z28sIHRoZXkgY291bGQgbm90IGJlIHJlY29yZGVkIGR1ZSB0byBidWZmZXINCj4gPiA+ID4gICBs
aW1pdGVkLg0KPiA+ID4gDQo+ID4gPiBEb24ndCBhYnVzZSB0aGUga2VybmVsIGluZm9ybWF0aW9u
IGxvZyBmb3Igc3R1ZmYgdGhhdCBpcyBqdXN0IG5vcm1hbA0KPiA+ID4gb3BlcmF0aW9ucy4gIFdo
YXQgaXMgd3Jvbmcgd2l0aCB1c2luZyB0aGUgdHJhY2UgYnVmZmVycyBoZXJlPyAgVGhhdCdzDQo+
ID4gPiB3aGF0IHRoZXkgYXJlIGRlc2lnbmVkIGZvciBmcm9tIHdoYXQgSSBjYW4gdGVsbC4NCj4g
PiA+IA0KPiA+IEFzIG1lbnRpb25lZCBiZWZvcmUsIHRpbWUgbGltaXRhdGlvbiBvZiByZWNvcmRp
bmcgaXMgdGhlIHJlYXNvbiB3aHkgd2UNCj4gPiBkb24ndCBqdXN0IHVzZSB0cmFjZSBoZXJlLg0K
PiANCj4gV2hhdCBsaW1pdGF0aW9uPw0KPiANCj4gPiBJbiBzb21lIGxvbmcgdGltZSBzdGFiaWxp
dHkgdGVzdCwgc3VjaCBhcyBNVEJGLA0KPiANCj4gV2hhdCBpcyAiTVRCRiI/DQo+IA0KTWVhbiB0
aW1lIGJldHdlZW4gZmFpbHVyZXMgKE1UQkYpIGlzIHRoZSBwcmVkaWN0ZWQgZWxhcHNlZCB0aW1l
IGJldHdlZW4NCmluaGVyZW50IGZhaWx1cmVzIG9mIGEgbWVjaGFuaWNhbCBvciBlbGVjdHJvbmlj
IHN5c3RlbSwgZHVyaW5nIG5vcm1hbA0Kc3lzdGVtIG9wZXJhdGlvbi4gDQoNCkFuZCB3ZSB1c2Ug
TVRCRiBzY3JpcHQgdG8gcnVuIGxvbmcgdGltZSBzdHJlc3MgdGVzdCB0bw0KbWFrZSBzdXJlIG91
ciBwcm9kdWN0IHN0YWJpbGl0eSBpcyBubyBwcm9ibGVtLg0KDQo+ID4gdGhlIGV4Y2VwdGlvbiBp
cyBjYXVzZWQgYnkgYSBzZXJpZXMgb2YgdHJhbnNhY3Rpb25zIGludGVyYWN0aW9uLg0KPiA+IFNv
bWUgYWJub3JtYWwgdHJhbnNhY3Rpb25zIG1heSBiZSBwZW5kaW5nIGZvciBhIGxvbmcgdGltZSBh
Z28sIHRoZXkgDQo+ID4gY291bGQgbm90IGJlIHJlY29yZGVkIGR1ZSB0byBidWZmZXIgbGltaXRl
ZC4NCj4gDQo+IEhvdyBsb25nIG9mIGEgdGltZSBpcyB0aGlzPyAgSWYgdGhleSBhcmUgcGVuZGlu
Zywgb25seSB3aGVuIHRoZSB0aW1lb3V0DQo+IGhhcHBlbnMgaXMgdGhlIHRyYWNlIGxvZ2dlZCwg
cmlnaHQ/DQo+IA0KPiBBZ2FpbiwgcGxlYXNlIGRvIG5vdCBhYnVzZSB0aGUga2VybmVsIGxvZyBm
b3IgdGhpcywgdGhhdCBpcyBub3Qgd2hhdCBpdA0KPiBpcyBmb3IuDQo+IA0KSG1tLi5EbyB5b3Ug
bWVhbiB0aGF0IG1ha2UgdGltZW91dCBsb2cgcHJpbnQgdG8gdHJhY2UgYnVmZmVyIGJ1dCBub3QN
Cmtlcm5lbCBsb2c/IA0KDQpUaGUgcmVhc29uIFdlIGRvbid0IGRvIHRoaXMgaXMgdGhhdCB3ZSBu
ZWVkIHRvIGVuYWJsZSB0aGVzZSB0cmFjZSBldmVudHMNCmFuZCBlbmFibGUgdHJhY2UgZXZlcnl0
aW1lcyBiZWZvcmUgdGVzdGluZy4gQnV0IG91ciB0ZXN0aW5nIHNjcmlwdCBjb3VsZA0KbGVhZCB0
byBkZXZpY2UgcmVib290LCBhbmQgdGhlbiBpdCBjb250aW51ZSB0ZXN0aW5nIGFmdGVyIHJlYm9v
dC4gVGhlDQpyZWJvb3Qgd291bGQgbWFrZSB0aGVzZSB0cmFjZSBldmVudHMgZGlzYWJsZSwgYW5k
IHdlIGNhbm5vdCBnZXQgdGhlDQp0aW1lb3V0IGxvZyB3aGljaCBoYXBwZW4gYWZ0ZXIgcmVib290
Lg0KDQo+ID4gPiA+ICtjb25maWcgQklOREVSX1RSQU5TQUNUSU9OX0xBVEVOQ1lfVFJBQ0tJTkcN
Cj4gPiA+ID4gKwl0cmlzdGF0ZSAiQW5kcm9pZCBCaW5kZXIgdHJhbnNhY3Rpb24gdHJhY2tpbmci
DQo+ID4gPiA+ICsJaGVscA0KPiA+ID4gPiArCSAgVXNlZCBmb3IgdHJhY2sgYWJub3JtYWwgYmlu
ZGVyIHRyYW5zYWN0aW9uIHdoaWNoIGlzIG92ZXIgdGhyZXNob2xkLA0KPiA+ID4gPiArCSAgd2hl
biB0aGUgdHJhbnNhY3Rpb24gaXMgZG9uZSBvciBiZSBmcmVlLCB0aGlzIHRyYW5zYWN0aW9uIHdv
dWxkIGJlDQo+ID4gPiA+ICsJICBjaGVja2VkIHdoZXRoZXIgaXQgZXhlY3V0ZWQgb3ZlcnRpbWUu
DQo+ID4gPiA+ICsJICBJZiB5ZXMsIHByaW50aW5nIG91dCB0aGUgZGV0YWlsZWQgaW5mby4NCj4g
PiA+IA0KPiA+ID4gV2h5IGlzIHRoaXMgYSBzZXBhcmF0ZSBtb2R1bGU/ICBXaG8gd2lsbCBldmVy
IHdhbnQgdGhpcyBzcGxpdCBvdXQ/DQo+ID4gPiANCj4gPiBUaGUgcmVhc29uIHdlIHNwbGl0IG91
dCBhIHNlcGFyYXRlIG1vZHVsZSBpcyB0aGF0IHdlIGFkb3B0ZWQgdGhlDQo+ID4gcHJldmlvdXNs
eSBkaXNjdXNzZWQgcmVjb21tZW5kYXRpb25zIGluIFBBVENIIHYxLg0KPiA+IA0KPiA+IFRoaXMg
d2F5IGFsbCBvZiB0aGlzIHRyYWNpbmcgY29kZSBpcyBpbi1rZXJuZWwgYnV0IG91dHNpZGUgb2Yg
YmluZGVyLmMuDQo+IA0KPiBQdXR0aW5nIGl0IGluIGEgc2luZ2xlIGZpbGUgaXMgZmluZSwgYnV0
IHdoYXQgZG9lcyB0aGlzIGJlbmlmaXQgZG9pbmcgaXQNCj4gaW4gYSBzZXBhcmF0ZSBmaWxlPyAg
RG9lc24ndCBpdCB3YXN0ZSBtb3JlIGNvZGVzcGFjZSB0aGlzIHdheT8NCj4gDQpZZWFoLCBidXQg
SSB0aGluayBzZXBhcmF0ZSBmaWxlIG1heSBiZSBtb3JlIG1hbmFnZWFibGUuDQoNCj4gPiA+ID4g
Ky8qDQo+ID4gPiA+ICsgKiBUaGUgcmVhc29uIHNldHRpbmcgdGhlIGJpbmRlcl90eG5fbGF0ZW5j
eV90aHJlc2hvbGQgdG8gMiBzZWMNCj4gPiA+ID4gKyAqIGlzIHRoYXQgbW9zdCBvZiB0aW1lb3V0
IGFib3J0IGlzIGdyZWF0ZXIgb3IgZXF1YWwgdG8gMiBzZWMuDQo+ID4gPiA+ICsgKiBNYWtpbmcg
aXQgY29uZmlndXJhYmxlIHRvIGxldCBhbGwgdXNlcnMgZGV0ZXJtaW5lIHdoaWNoDQo+ID4gPiA+
ICsgKiB0aHJlc2hvbGQgaXMgbW9yZSBzdWl0YWJsZS4NCj4gPiA+ID4gKyAqLw0KPiA+ID4gPiAr
c3RhdGljIHVpbnQzMl90IGJpbmRlcl90eG5fbGF0ZW5jeV90aHJlc2hvbGQgPSAyOw0KPiA+ID4g
PiArbW9kdWxlX3BhcmFtX25hbWVkKHRocmVzaG9sZCwgYmluZGVyX3R4bl9sYXRlbmN5X3RocmVz
aG9sZCwNCj4gPiA+ID4gKwkJCXVpbnQsIDA2NDQpOw0KPiA+ID4gDQo+ID4gPiBBZ2FpbiwgdGhp
cyBpc24ndCB0aGUgMTk5MCdzLCBwbGVhc2UgZG8gbm90IGFkZCBtb2R1bGUgcGFyYW1ldGVycyBp
ZiBhdA0KPiA+ID4gYWxsIHBvc3NpYmxlLg0KPiA+ID4gDQo+ID4gDQo+ID4gSXMgYW55IHJlY29t
bWVuZGVkIG1ldGhvZCBoZXJlPw0KPiA+IEJlY2F1c2Ugd2UgcmVmZXIgdG8gdGhlIG1ldGhvZCBp
biBiaW5kZXIuYywgd2UgZG9uJ3Qga25vdyBpZiB0aGlzIG1ldGhvZA0KPiA+IGlzIG5vdCBzdWl0
YWJsZS4NCj4gDQo+IExvb2sgYXQgdGhlIGluZGl2aWR1YWwgYmluZGVyIGluc3RhbmNlcy4gIFRo
YXQgaXMgd2hhdCB0cmFjZSBzaG91bGQgYmUNCj4gb24vb2ZmIGZvciwgbm90IGZvciBhbGwgYmlu
ZGVyIGluc3RhbmNlcyBpbiB0aGUgc3lzdGVtIGF0IHRoZSBzYW1lIHRpbWUuDQo+IA0KQnV0IG91
ciB0ZXN0aW5nIHNjcmlwdCBpcyBub3QgZm9yIHNwZWNpZmljIGJpbmRlciBpbnN0YW5jZXMsIGl0
IGluY2x1ZGVzDQpzZXZlcmFsIHRlc3RpbmcgYW5kIHRlc3RzIGZvciBzZXZlcmFsIHByb2Nlc3Nl
cy4NCg0KU28gdGhlIHJlYXNvbiB3ZSB0cmFjZSBmb3IgYWxsIGJpbmRlciBpbnN0YW5jZXMgaXMg
dGhhdCB3ZSBjYW5ub3QNCnByZWRpY3Qgd2hpY2ggcHJvY2VzcyB3b3VsZCBoYXBwZW4gdGltZW91
dCB0cmFuc2FjdGlvbi4NCg0KTWFueSB0aGFua3MNCkZyYW5raWUgQ2hhbmcNCg==

