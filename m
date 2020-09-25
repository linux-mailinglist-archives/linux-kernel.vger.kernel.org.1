Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C99B278161
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 09:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbgIYHSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 03:18:50 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:40619 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727067AbgIYHSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 03:18:50 -0400
X-UUID: c0dcd319fdae4ed2b6d0e2f26bad7245-20200925
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=+dWfAWVSC8G82KV3JSBP7Prglhd5Yr0C7+OX0zeM2BU=;
        b=ojRsscfIzTXQLgXYBEn2hJnJi4bPMNVbwMB8Oc9SDnJp2Cg7GmME9bG68g5h49B6+v7EVNFdVW/YCsozJYSHE6fl+wb3P7KS4LVBlTiwdHWmb5/aDytI5CMF8/IM+xD/js94Cq4xBNoNwFFBAuE/Um+FMKZ5e6bsUhz/f15WYTI=;
X-UUID: c0dcd319fdae4ed2b6d0e2f26bad7245-20200925
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 271370887; Fri, 25 Sep 2020 15:18:46 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 25 Sep 2020 15:18:42 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 25 Sep 2020 15:18:43 +0800
Message-ID: <1601018323.28162.4.camel@mtksdccf07>
Subject: Re: [PATCH v4 1/6] timer: kasan: record timer stack
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Marco Elver <elver@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        "Alexander Potapenko" <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Andrey Konovalov" <andreyknvl@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>
Date:   Fri, 25 Sep 2020 15:18:43 +0800
In-Reply-To: <87h7rm97js.fsf@nanos.tec.linutronix.de>
References: <20200924040335.30934-1-walter-zh.wu@mediatek.com>
         <87h7rm97js.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 3C3089F7FF02F5E21612A0E8793CCC1F5A4AAE300078785DD5266310F77958DD2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTA5LTI0IGF0IDIzOjQxICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IE9uIFRodSwgU2VwIDI0IDIwMjAgYXQgMTI6MDMsIFdhbHRlciBXdSB3cm90ZToNCj4gPiBX
aGVuIGFuYWx5emUgdXNlLWFmdGVyLWZyZWUgb3IgZG91YmxlLWZyZWUgaXNzdWUsIHJlY29yZGlu
ZyB0aGUgdGltZXINCj4gPiBzdGFja3MgaXMgaGVscGZ1bCB0byBwcmVzZXJ2ZSB1c2FnZSBoaXN0
b3J5IHdoaWNoIHBvdGVudGlhbGx5IGdpdmVzDQo+ID4gYSBoaW50IGFib3V0IHRoZSBhZmZlY3Rl
ZCBjb2RlLg0KPiA+DQo+ID4gUmVjb3JkIHRoZSBtb3N0IHJlY2VudCB0d28gdGltZXIgaW5pdCBj
YWxscyBpbiBLQVNBTiB3aGljaCBhcmUgcHJpbnRlZA0KPiA+IG9uIGZhaWx1cmUgaW4gdGhlIEtB
U0FOIHJlcG9ydC4NCj4gPg0KPiA+IEZvciB0aW1lcnMgaXQgaGFzIHR1cm5lZCBvdXQgdG8gYmUg
dXNlZnVsIHRvIHJlY29yZCB0aGUgc3RhY2sgdHJhY2UNCj4gPiBvZiB0aGUgdGltZXIgaW5pdCBj
YWxsLg0KPiANCj4gSW4gd2hpY2ggd2F5PyBBbmQgd2hhdCBraW5kIG9mIGJ1ZyBkb2VzIGl0IGNh
dGNoIHdoaWNoIGNhbm5vdCBiZSBjYXRjaGVkDQo+IGJ5IGV4aXN0aW5nIGRlYnVnIG1lY2hhbmlz
bXMgYWxyZWFkeT8NCj4gDQoNCldlIG9ubHkgcHJvdmlkZSBhbm90aGVyIGRlYnVnIG1lY2hhbmlz
bXMgdG8gZGVidWcgdXNlLWFmdGVyLWZyZWUgb3INCmRvdWJsZS1mcmVlLCBpdCBjYW4gYmUgZGlz
cGxheWVkIHRvZ2V0aGVyIGluIEtBU0FOIHJlcG9ydCBhbmQgaGF2ZSBhDQpjaGFuY2UgdG8gZGVi
dWcsIGFuZCBpdCBkb2Vzbid0IG5lZWQgdG8gZW5hYmxlIGV4aXN0aW5nIGRlYnVnIG1lY2hhbmlz
bXMNCmF0IHRoZSBzYW1lIHRpbWUuIHRoZW4gaXQgaGFzIGEgY2hhbmNlIHRvIHJlc29sdmUgaXNz
dWUuDQoNCj4gPiBCZWNhdXNlIGlmIHRoZSBVQUYgcm9vdCBjYXVzZSBpcyBpbiB0aW1lciBpbml0
LCB0aGVuIHVzZXIgY2FuIHNlZQ0KPiA+IEtBU0FOIHJlcG9ydCB0byBnZXQgd2hlcmUgaXQgaXMg
cmVnaXN0ZXJlZCBhbmQgZmluZCBvdXQgdGhlIHJvb3QNCj4gPiBjYXVzZS4NCj4gDQo+IFdoYXQ/
IElmIHRoZSBVQUYgcm9vdCBjYXVzZSBpcyBpbiB0aW1lciBpbml0LCB0aGVuIHJlZ2lzdGVyaW5n
IGl0IGFmdGVyDQo+IHVzaW5nIGl0IGluIHRoYXQgdmVyeSBzYW1lIGZ1bmN0aW9uIGlzIHByZXR0
eSBwb2ludGxlc3MuDQo+IA0KDQpTZWUgWzFdLCB0aGUgY2FsbCBzdGFjayBzaG93cyBVQUYgaGFw
cGVuIGF0IGR1bW15X3RpbWVyKCksIGl0IGlzIHRoZQ0KY2FsbGJhY2sgZnVuY3Rpb24gYW5kIHNl
dCBieSB0aW1lcl9zZXR1cCgpLCBpZiBLQVNBTiByZXBvcnQgc2hvd3MgdGhlDQp0aW1lciBjYWxs
IHN0YWNrLCBpdCBzaG91bGQgYmUgdXNlZnVsIGZvciBwcm9ncmFtbWVyLg0KDQpbMV0NCmh0dHBz
Oi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL2J1Zz9pZD0zNGU2OWI3YzhjMDE2NTY1OGNiYzk4N2Rh
MGI2MWRhZGVjNjQ0YjZiDQoNCg0KPiA+IEl0IGRvbid0IG5lZWQgdG8gZW5hYmxlIERFQlVHX09C
SkVDVFNfVElNRVJTLCBidXQgdGhleSBoYXZlIGEgY2hhbmNlDQo+ID4gdG8gZmluZCBvdXQgdGhl
IHJvb3QgY2F1c2UuDQo+IA0KPiBUaGVyZSBpcyBhIGxvdCBvZiBoYW5kd2F2aW5nIGhvdyB1c2Vm
dWwgdGhpcyBpcywgYnV0IFRCSCBJIGRvbid0IHNlZSB0aGUNCj4gdmFsdWUgYXQgYWxsLg0KPiAN
Cj4gREVCVUdfT0JKRUNUU19USU1FUlMgZG9lcyBhIGxvdCBtb3JlIHRoYW4gY3Jhc2hpbmcgb24g
VUFGLiBJZiBLQVNBTg0KPiBwcm92aWRlcyBhZGRpdGlvbmFsIHZhbHVlIG92ZXIgREVCVUdfT0JK
RUNUU19USU1FUlMgdGhlbiBzcGVsbCBpdCBvdXQsDQo+IGJ1dCBqdXN0IHNheWluZyB0aGF0IHlv
dSBkb24ndCBuZWVkIHRvIGVuYWJsZSBERUJVR19PQkpFQ1RTX1RJTUVSUyBpcw0KPiBub3QgbWFr
aW5nIGFuIGFyZ3VtZW50IGZvciB0aGF0IGNoYW5nZS4NCj4gDQoNCldlIGRvbid0IHdhbnQgdG8g
cmVwbGFjZSBERUJVR19PQkpFQ1RTX1RJTUVSUyB3aXRoIHRoaXMgcGF0Y2hlcywgb25seQ0KaG9w
ZSB0byB1c2UgbG93IG92ZXJoZWFkKGNvbXBhcmUgd2l0aCBERUJVR19PQkpFQ1RTX1RJTUVSUykg
dG8gZGVidWcNCnVzZS1hZnRlci1mcmVlL2RvdWJsZS1mcmVlIGlzc3VlLiBJZiB5b3UgaGF2ZSBz
b21lIGNvbmNlcm5zLCB3ZSBjYW4gYWRkDQp0aG9zZSBtZXNzYWdlIGludG8gY29tbWl0IGxvZy4N
Cg0KVGhhbmtzLg0KDQpXYWx0ZXINCg==

