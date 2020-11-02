Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D512A2531
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 08:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgKBH33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 02:29:29 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:54794 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728064AbgKBH31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 02:29:27 -0500
X-UUID: c4bb20b5ab7a4cc6aed752af9ebb52fa-20201102
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=q4bvGdMGyh2E0MZ8xSG66t4ZOKnXaBEU1VOFr3jNnss=;
        b=OG22lScNGiPMvdumuMg8CmHY5oKU0aClJMdYIm69ocu3fDe5kUu2aQFJ5fw3xXoQ+LIoMNSF0nivq9Vww4ksOMg4uR9LkKNSq/eWi3eUXWPB4Exjq6/vcDlCzz2BpWTpT/yVhl30YwDmcJEkffoiglnxxfHUcIrpz6HlMtIuDtw=;
X-UUID: c4bb20b5ab7a4cc6aed752af9ebb52fa-20201102
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1338950142; Mon, 02 Nov 2020 15:24:18 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 2 Nov 2020 15:24:16 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 2 Nov 2020 15:24:16 +0800
Message-ID: <1604301856.804.0.camel@mtkswgap22>
Subject: Re: [PATCH v8] Add MediaTek MT6779 devapc driver
From:   Neal Liu <neal.liu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Neal Liu <neal.liu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        wsd_upstream <wsd_upstream@mediatek.com>
Date:   Mon, 2 Nov 2020 15:24:16 +0800
In-Reply-To: <1602732276.13734.1.camel@mtkswgap22>
References: <1602732039-12179-1-git-send-email-neal.liu@mediatek.com>
         <1602732276.13734.1.camel@mtkswgap22>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R2VudGxlIHBpbmcgZm9yIHRoZXNlIHBhdGNoIHNlcmllcy4NClRoYW5rcyAhDQoNCk9uIFRodSwg
MjAyMC0xMC0xNSBhdCAxMToyNCArMDgwMCwgTmVhbCBMaXUgd3JvdGU6DQo+IGFkZCBzdWJqZWN0
DQo+IA0KPiBPbiBUaHUsIDIwMjAtMTAtMTUgYXQgMTE6MjAgKzA4MDAsIE5lYWwgTGl1IHdyb3Rl
Og0KPiA+IFRoZXNlIHBhdGNoIHNlcmllcyBpbnRyb2R1Y2UgYSBNZWRpYVRlayBNVDY3NzkgZGV2
YXBjIGRyaXZlci4NCj4gPiANCj4gPiBNZWRpYVRlayBidXMgZmFicmljIHByb3ZpZGVzIFRydXN0
Wm9uZSBzZWN1cml0eSBzdXBwb3J0IGFuZCBkYXRhIHByb3RlY3Rpb24gdG8gcHJldmVudCBzbGF2
ZXMgZnJvbSBiZWluZyBhY2Nlc3NlZCBieSB1bmV4cGVjdGVkIG1hc3RlcnMuDQo+ID4gVGhlIHNl
Y3VyaXR5IHZpb2xhdGlvbiBpcyBsb2dnZWQgYW5kIHNlbnQgdG8gdGhlIHByb2Nlc3NvciBmb3Ig
ZnVydGhlciBhbmFseXNpcyBvciBjb3VudGVybWVhc3VyZXMuDQo+ID4gDQo+ID4gQW55IG9jY3Vy
cmVuY2Ugb2Ygc2VjdXJpdHkgdmlvbGF0aW9uIHdvdWxkIHJhaXNlIGFuIGludGVycnVwdCwgYW5k
IGl0IHdpbGwgYmUgaGFuZGxlZCBieSBtdGstZGV2YXBjIGRyaXZlci4NCj4gPiBUaGUgdmlvbGF0
aW9uIGluZm9ybWF0aW9uIGlzIHByaW50ZWQgaW4gb3JkZXIgdG8gZmluZCB0aGUgbXVyZGVyZXIu
DQo+ID4gDQo+ID4gY2hhbmdlcyBzaW5jZSB2NzoNCj4gPiAtIGZpeCBWSU9fTU9EX1RPX1JFR19J
TkQgY2FsY3VsYXRpb24gd3JvbmcgcHJvYmxlbS4NCj4gPiAtIHJldmlzZSBwYXJhbWV0ZXIgdHlw
ZSBvZiBJU1IuDQo+ID4gDQo+ID4gY2hhbmdlcyBzaW5jZSB2NjoNCj4gPiAtIHJlbW92ZSB1bm5l
Y2Vzc2FyeSBtYXNrL3VubWFzayBtb2R1bGUgaXJxIGR1cmluZyBJU1IuDQo+ID4gDQo+ID4gY2hh
bmdlcyBzaW5jZSB2NToNCj4gPiAtIHJlbW92ZSByZWR1bmRhbnQgd3JpdGUgcmVnIG9wZXJhdGlv
bi4NCj4gPiAtIHVzZSBzdGF0aWMgdmFyaWFibGUgb2YgdmlvX2RiZ3MgaW5zdGVhZC4NCj4gPiAt
IGFkZCBzdG9wX2RldmFwYygpIGlmIGRyaXZlciBpcyByZW1vdmVkLg0KPiA+IA0KPiA+IGNoYW5n
ZXMgc2luY2UgdjQ6DQo+ID4gLSByZWZhY3RvciBkYXRhIHN0cnVjdHVyZS4NCj4gPiAtIG1lcmdl
IHR3byBzaW1wbGUgZnVuY3Rpb25zIGludG8gb25lLg0KPiA+IC0gcmVmYWN0b3IgcmVnaXN0ZXIg
c2V0dGluZyB0byBwcmV2ZW50IHRvbyBtYW55IGZ1bmN0aW9uIGNhbGwgb3ZlcmhlYWQuDQo+ID4g
DQo+ID4gY2hhbmdlcyBzaW5jZSB2MzoNCj4gPiAtIHJldmlzZSB2aW9sYXRpb24gaGFuZGxpbmcg
ZmxvdyB0byBtYWtlIGl0IG1vcmUgZWFzaWx5IHRvIHVuZGVyc3RhbmQNCj4gPiAgIGhhcmR3YXJl
IGJlaGF2aW9yLg0KPiA+IC0gYWRkIG1vcmUgY29tbWVudHMgdG8gdW5kZXJzdGFuZCBob3cgaGFy
ZHdhcmUgd29ya3MuDQo+ID4gDQo+ID4gY2hhbmdlcyBzaW5jZSB2MjoNCj4gPiAtIHBhc3MgcGxh
dGZvcm0gaW5mbyB0aHJvdWdoIERUIGRhdGEuDQo+ID4gLSByZW1vdmUgdW5uZWNlc3NhcnkgZnVu
Y3Rpb24uDQo+ID4gLSByZW1vdmUgc2xhdmVfdHlwZSBiZWNhdXNlIGl0IGFsd2F5cyBlcXVhbHMg
dG8gMSBpbiBjdXJyZW50IHN1cHBvcnQgU29DLg0KPiA+IC0gdXNlIHZpb19pZHhfbnVtIGluc3Ry
ZWFkIG9mIGxpc3QgYWxsIGRldmljZXMnIGluZGV4Lg0KPiA+IC0gYWRkIG1vcmUgY29tbWVudHMg
dG8gZGVzY3JpYmUgaGFyZHdhcmUgYmVoYXZpb3IuDQo+ID4gDQo+ID4gY2hhbmdlcyBzaW5jZSB2
MToNCj4gPiAtIG1vdmUgU29DIHNwZWNpZmljIHBhcnQgdG8gRFQgZGF0YS4NCj4gPiAtIHJlbW92
ZSB1bm5lY2Vzc2FyeSBib3VuZGFyeSBjaGVjay4NCj4gPiAtIHJlbW92ZSB1bm5lY2Vzc2FyeSBk
YXRhIHR5cGUgZGVjbGFyYXRpb24uDQo+ID4gLSB1c2UgcmVhZF9wb2xsX3RpbWVvdXQoKSBpbnN0
cmVhZCBvZiBmb3IgbG9vcCBwb2xsaW5nLg0KPiA+IC0gcmV2aXNlIGNvZGluZyBzdHlsZSBlbGVn
YW50bHkuDQo+ID4gDQo+ID4gDQo+ID4gKioqIEJMVVJCIEhFUkUgKioqDQo+ID4gDQo+ID4gTmVh
bCBMaXUgKDIpOg0KPiA+ICAgZHQtYmluZGluZ3M6IGRldmFwYzogYWRkIGJpbmRpbmdzIGZvciBt
dGstZGV2YXBjDQo+ID4gICBzb2M6IG1lZGlhdGVrOiBhZGQgbXQ2Nzc5IGRldmFwYyBkcml2ZXIN
Cj4gPiANCj4gPiAgLi4uL2JpbmRpbmdzL3NvYy9tZWRpYXRlay9kZXZhcGMueWFtbCAgICAgICAg
IHwgIDU4ICsrKysNCj4gPiAgZHJpdmVycy9zb2MvbWVkaWF0ZWsvS2NvbmZpZyAgICAgICAgICAg
ICAgICAgIHwgICA5ICsNCj4gPiAgZHJpdmVycy9zb2MvbWVkaWF0ZWsvTWFrZWZpbGUgICAgICAg
ICAgICAgICAgIHwgICAxICsNCj4gPiAgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWRldmFwYy5j
ICAgICAgICAgICAgIHwgMzA4ICsrKysrKysrKysrKysrKysrKw0KPiA+ICA0IGZpbGVzIGNoYW5n
ZWQsIDM3NiBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL21lZGlhdGVrL2RldmFwYy55YW1sDQo+ID4gIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstZGV2YXBjLmMNCj4gPiAN
Cj4gDQo+IA0KDQo=

