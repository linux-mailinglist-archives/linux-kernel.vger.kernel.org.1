Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 888C6279B31
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 19:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbgIZRL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 13:11:59 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:44684 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726244AbgIZRL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 13:11:59 -0400
X-UUID: 1bb9e9cc36024dd6a690cf0789c923d6-20200927
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=ftBotKe73TtK65EhVOkqgCswQ7tnRRnYOTiRhxGmAnU=;
        b=ERhpLLwMmjPQQd9FApwv/3I45ag0P/1it/RkPOLL0SwkjyiDBVHNSC1u5lJdG8biv6AYfhtd3H4zVAc4kt0XhgxMpdYu6Pa2piaqh35m4qG7xF704MtORiqsBsi4psLCslpPFbFaf2DyHjRDW3EV/p8GrZVWg9yiiJKUg5hx/NM=;
X-UUID: 1bb9e9cc36024dd6a690cf0789c923d6-20200927
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 725674751; Sun, 27 Sep 2020 01:11:54 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 27 Sep 2020 01:11:51 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 27 Sep 2020 01:11:52 +0800
Message-ID: <1601140312.15228.12.camel@mtksdccf07>
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
Date:   Sun, 27 Sep 2020 01:11:52 +0800
In-Reply-To: <87wo0htqco.fsf@nanos.tec.linutronix.de>
References: <20200924040335.30934-1-walter-zh.wu@mediatek.com>
         <87h7rm97js.fsf@nanos.tec.linutronix.de>
         <1601018323.28162.4.camel@mtksdccf07>
         <87lfgyutf8.fsf@nanos.tec.linutronix.de>
         <1601025346.2255.2.camel@mtksdccf07>
         <87wo0htqco.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVGhvbWFzLA0KDQpPbiBTYXQsIDIwMjAtMDktMjYgYXQgMDA6NTkgKzAyMDAsIFRob21hcyBH
bGVpeG5lciB3cm90ZToNCj4gT24gRnJpLCBTZXAgMjUgMjAyMCBhdCAxNzoxNSwgV2FsdGVyIFd1
IHdyb3RlOg0KPiA+IE9uIEZyaSwgMjAyMC0wOS0yNSBhdCAxMDo1NSArMDIwMCwgVGhvbWFzIEds
ZWl4bmVyIHdyb3RlOg0KPiA+PiA+IFdlIGRvbid0IHdhbnQgdG8gcmVwbGFjZSBERUJVR19PQkpF
Q1RTX1RJTUVSUyB3aXRoIHRoaXMgcGF0Y2hlcywgb25seQ0KPiA+PiA+IGhvcGUgdG8gdXNlIGxv
dyBvdmVyaGVhZChjb21wYXJlIHdpdGggREVCVUdfT0JKRUNUU19USU1FUlMpIHRvIGRlYnVnDQo+
ID4+IA0KPiA+PiBLQVNBTiBoYXMgbG93ZXIgb3ZlcmhlYWQgdGhhbiBERUJVR19PQkpFQ1RTX1RJ
TUVSUz8gTWF5YmUgaW4gYSBkaWZmZXJlbnQNCj4gPj4gdW5pdmVyc2UuDQo+ID4+IA0KPiA+IEkg
bWVhbiBLQVNBTiArIG91ciBwYXRjaCB2cyBLQVNBTiArIERFQlVHX09CSkVDVFNfVElNRVJTLiBU
aGUgZnJvbnQgb25lDQo+ID4gaGF2ZSB0aGUgaW5mb3JtYXRpb24gdG8gdGhlIG9yaWdpbmFsIGNh
bGxlciBhbmQgaGVscCB0byBkZWJ1Zy4gSXQgaXMNCj4gPiBzbWFsbGVyIG92ZXJoZWFkIHRoYW4g
dGhlIG9uZSBiZWhpbmQuDQo+IA0KPiBGb3IgT05FIHNwZWNpZmljIHByb2JsZW0gcmVsYXRlZCB0
byB0aW1lcnMgYW5kIHlvdSBoYXZlIHN0aWxsIG5vdCBzaG93bg0KPiBhIHNpbmdsZSB1c2VmdWwg
ZGVidWcgb3V0cHV0IHdoZXJlIHRoaXMgaW5mb3JtYXRpb24gaGVscHMgdG8gZGVidWcNCj4gYW55
dGhpbmcuDQo+IA0KPiA+IEkgYWdyZWUgeW91ciBzYXlpbmcsIHNvIHRoYXQgSSBuZWVkIHRvIGZp
bmQgb3V0IGEgdXNlIGNhc2UgdG8gZXhwbGFpbiB0bw0KPiA+IHlvdS4NCj4gDQo+IEluZGVlZC4N
Cj4gDQoNCkZpcnN0LCBJIHRoaW5rIHRoZSBjb21taXQgbG9nIOKAnEJlY2F1c2UgaWYgdGhlIFVB
RiByb290IGNhdXNlIGlzIGluIHRpbWVyDQppbml0IOKApuKAnSBuZWVkcyB0byBiZSByZW1vdmVk
LCB0aGlzIHBhdGNoIGhvcGVzIHRvIGhlbHAgcHJvZ3JhbW1lciBnZXRzDQp0aW1lciBjYWxsYmFj
ayBpcyB3aGVyZSBpcyByZWdpc3RlcmVkLiBJdCBpcyB1c2VmdWwgb25seSBpZiBmcmVlIHN0YWNr
DQppcyBjYWxsZWQgZnJvbSB0aW1lciBjYWxsYmFjaywgYmVjYXVzZSBwcm9ncmFtbWVyIGNhbiBz
ZWUgd2h5ICYgd2hlcmUNCnJlZ2lzdGVyIHRoaXMgZnVuY3Rpb24uDQoNClNlY29uZCwgc2VlIFsx
XSwgaXQgc2hvdWxkIHNhdGlzZmllcyBmaXJzdCBwb2ludC4gVGhlIGZyZWUgc3RhY2sgaXMgZnJv
bQ0KdGltZXIgY2FsbGJhY2ssIGlmIHdlIGtub3cgd2hlcmUgcmVnaXN0ZXIgdGhpcyBmdW5jdGlv
biwgdGhlbiBpdCBzaG91bGQNCmJlIHVzZWZ1bCB0byBzb2x2ZSBVQUYuDQoNClsxXWh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2xpbnV4LXVzYi8wMDAwMDAwMDAwMDA1OTBmNmIwNWExYzA1ZDE1QGdv
b2dsZS5jb20vDQoNCg0KDQpUaGFua3MNCg0KV2FsdGVyDQoNCg0KDQoNCg0KPiBUaGFua3MsDQo+
IA0KPiAgICAgICAgIHRnbHgNCj4gDQoNCg==

