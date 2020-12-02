Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEBA2CB23B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 02:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgLBBXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 20:23:11 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:42877 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727731AbgLBBXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 20:23:11 -0500
X-UUID: 9e56c2ef1aff4e988b1401ccd7d4429c-20201202
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=aFh6DrFU7jAcnRRxu+a/aUKMgiC608ISwon0hAJWMbM=;
        b=BcCp9VTjpgJ6ETurY7dkzQDQHBpDn5/J//dd41fnUHj22xiLGknLUW/eo8vhESkrEtorZs2O6fsAYUPdzZYAn6PiuGDXPsikaBOvqYTHekt8qHsgtWJ/+I2/MUd1Num+Ltm3z1p3X4dTwimXfSzeSzNCeGFVDehkjI4lzmCVqZo=;
X-UUID: 9e56c2ef1aff4e988b1401ccd7d4429c-20201202
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 551974189; Wed, 02 Dec 2020 09:22:28 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 2 Dec 2020 09:22:20 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 2 Dec 2020 09:22:20 +0800
Message-ID: <1606872145.1015.5.camel@mtksdccf07>
Subject: Re: [PATCH v4 0/6] kasan: add workqueue and timer stack for generic
 KASAN
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Dmitry Vyukov <dvyukov@google.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Stultz <john.stultz@linaro.org>,
        "Stephen Boyd" <sboyd@kernel.org>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        "Andrey Konovalov" <andreyknvl@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>
Date:   Wed, 2 Dec 2020 09:22:25 +0800
In-Reply-To: <CACT4Y+Yy8S0L18u3q1Y1K1r-qqXRWzrVVLPNR_En0hJ9nX7Tbw@mail.gmail.com>
References: <20200924040152.30851-1-walter-zh.wu@mediatek.com>
         <87h7rfi8pn.fsf@nanos.tec.linutronix.de>
         <CACT4Y+a=GmYVZwwjyXwO=_AeGy4QB9X=5x7cL76erwjPvRW6Zw@mail.gmail.com>
         <1606821422.6563.10.camel@mtksdccf07>
         <CACT4Y+Yy8S0L18u3q1Y1K1r-qqXRWzrVVLPNR_En0hJ9nX7Tbw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: C1099CD3A8527B7642F07659FBF80227BD8F9D554DF4ECC02ABA034D081813CC2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTEyLTAxIGF0IDE1OjAyICswMTAwLCAnRG1pdHJ5IFZ5dWtvdicgdmlhIGth
c2FuLWRldiB3cm90ZToNCj4gT24gVHVlLCBEZWMgMSwgMjAyMCBhdCAxMjoxNyBQTSBXYWx0ZXIg
V3UgPHdhbHRlci16aC53dUBtZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+DQo+ID4gSGkgRG1pdHJ5
LA0KPiA+DQo+ID4gT24gVHVlLCAyMDIwLTEyLTAxIGF0IDA4OjU5ICswMTAwLCAnRG1pdHJ5IFZ5
dWtvdicgdmlhIGthc2FuLWRldiB3cm90ZToNCj4gPiA+IE9uIFdlZCwgU2VwIDMwLCAyMDIwIGF0
IDU6MjkgUE0gVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+IHdyb3RlOg0KPiA+
ID4gPg0KPiA+ID4gPiBPbiBUaHUsIFNlcCAyNCAyMDIwIGF0IDEyOjAxLCBXYWx0ZXIgV3Ugd3Jv
dGU6DQo+ID4gPiA+ID4gU3l6Ym90IHJlcG9ydHMgbWFueSBVQUYgaXNzdWVzIGZvciB3b3JrcXVl
dWUgb3IgdGltZXIsIHNlZSBbMV0gYW5kIFsyXS4NCj4gPiA+ID4gPiBJbiBzb21lIG9mIHRoZXNl
IGFjY2Vzcy9hbGxvY2F0aW9uIGhhcHBlbmVkIGluIHByb2Nlc3Nfb25lX3dvcmsoKSwNCj4gPiA+
ID4gPiB3ZSBzZWUgdGhlIGZyZWUgc3RhY2sgaXMgdXNlbGVzcyBpbiBLQVNBTiByZXBvcnQsIGl0
IGRvZXNuJ3QgaGVscA0KPiA+ID4gPiA+IHByb2dyYW1tZXJzIHRvIHNvbHZlIFVBRiBvbiB3b3Jr
cXVldWUuIFRoZSBzYW1lIG1heSBzdGFuZCBmb3IgdGltZXMuDQo+ID4gPiA+ID4NCj4gPiA+ID4g
PiBUaGlzIHBhdGNoc2V0IGltcHJvdmVzIEtBU0FOIHJlcG9ydHMgYnkgbWFraW5nIHRoZW0gdG8g
aGF2ZSB3b3JrcXVldWUNCj4gPiA+ID4gPiBxdWV1ZWluZyBzdGFjayBhbmQgdGltZXIgc3RhY2sg
aW5mb3JtYXRpb24uIEl0IGlzIHVzZWZ1bCBmb3IgcHJvZ3JhbW1lcnMNCj4gPiA+ID4gPiB0byBz
b2x2ZSB1c2UtYWZ0ZXItZnJlZSBvciBkb3VibGUtZnJlZSBtZW1vcnkgaXNzdWUuDQo+ID4gPiA+
ID4NCj4gPiA+ID4gPiBHZW5lcmljIEtBU0FOIGFsc28gcmVjb3JkcyB0aGUgbGFzdCB0d28gd29y
a3F1ZXVlIGFuZCB0aW1lciBzdGFja3MgYW5kDQo+ID4gPiA+ID4gcHJpbnRzIHRoZW0gaW4gS0FT
QU4gcmVwb3J0LiBJdCBpcyBvbmx5IHN1aXRhYmxlIGZvciBnZW5lcmljIEtBU0FOLg0KPiA+ID4N
Cj4gPiA+IFdhbHRlciwgZGlkIHlvdSBtYWlsIHY1Pw0KPiA+ID4gQ2hlY2tpbmcgc3RhdHVzZXMg
b2YgS0FTQU4gaXNzdWVzIGFuZCB0aGlzIHNlZW1zIHRvIGJlIG5vdCBpbiBsaW51eC1uZXh0Lg0K
PiA+ID4NCj4gPg0KPiA+IFNvcnJ5IGZvciB0aGUgZGVsYXkgaW4gcmVzcG9uZGluZyB0byB0aGlz
IHBhdGNoLiBJJ20gYnVzeSB0aGVzZSBmZXcNCj4gPiBtb250aHMsIHNvIHRoYXQgc3VzcGVuZCBw
cm9jZXNzaW5nIGl0Lg0KPiA+IFllcywgSSB3aWxsIHNlbmQgaXQgbmV4dCB3ZWVrLiBCdXQgdjQg
bmVlZCB0byBjb25maXJtIHRoZSB0aW1lciBzdGFjayBpcw0KPiA+IHVzZWZ1bC4gSSBoYXZlbid0
IGZvdW5kIGFuIGV4YW1wbGUuIERvIHlvdSBoYXZlIHNvbWUgc3VnZ2VzdGlvbiBhYm91dA0KPiA+
IHRpbWVyPw0KPiANCj4gR29vZCBxdWVzdGlvbi4NCj4gDQo+IFdlIGhhZCBzb21lIHVzZS1hZnRl
ci1mcmVlJ3Mgd2hhdCBtZW50aW9uIGNhbGxfdGltZXJfZm46DQo+IGh0dHBzOi8vZ3JvdXBzLmdv
b2dsZS5jb20vZy9zeXprYWxsZXItYnVncy9zZWFyY2g/cT0lMjJrYXNhbiUyMiUyMCUyMnVzZS1h
ZnRlci1mcmVlJTIyJTIwJTIyZXhwaXJlX3RpbWVycyUyMiUyMCUyMmNhbGxfdGltZXJfZm4lMjIl
MjANCj4gSW4gdGhlIHJlcG9ydHMgSSBjaGVja2VkIGNhbGxfdGltZXJfZm4gYXBwZWFycyBpbiB0
aGUgImFjY2VzcyIgc3RhY2sNCj4gcmF0aGVyIGluIHRoZSAiZnJlZSIgc3RhY2suDQo+IA0KWWVz
LCBjYWxsIHN0YWNrIGFscmVhZHkgaXMgdXNlZnVsIGZvciBpdCBpbiBLQVNBTiByZXBvcnQuDQoN
Cj4gTG9va2luZyBhdCB0aGVzZSByZXBvcnRzIEkgY2Fubm90IGNvbmNsdWRlIHRoYXQgZG9faW5p
dF90aW1lciBzdGFjaw0KPiB3b3VsZCBiZSB1c2VmdWwuDQo+IEkgYW0gbWlsZGx5IGxlYW5pbmcg
dG93YXJkcyBub3QgbWVtb3JpemluZyBkb19pbml0X3RpbWVyIHN0YWNrIGZvciBub3cNCj4gKHVu
dGlsIHdlIGhhdmUgY2xlYXIgdXNlIGNhc2VzKSBhcyB0aGUgbnVtYmVyIG9mIGF1eCBzdGFja3Mg
aXMgdmVyeQ0KPiBsaW1pdGVkICgyKS4NCj4gDQpHb3QgaXQuIEkgd2lsbCByZW1vdmUgdGltZXIg
cGF0Y2ggYW5kIHNlbmQgdjUuDQpUaGFua3MgZm9yIHlvdXIgc3VnZ2VzdGlvbi4NCg0KV2FsdGVy
DQoNCg==

