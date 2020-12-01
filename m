Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE0C2CA11E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 12:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbgLALRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 06:17:51 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:46972 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727177AbgLALRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 06:17:50 -0500
X-UUID: 32672f8005c64d499a0df082931e5787-20201201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=pDpaexdIMd2G1eFG8LLARx//qLgP1bMHu0BH8xeP5SE=;
        b=kbo2RJQIjH9WkHY8T8jFRQi5fIFjRJv/biOPqNms7mCl7zTCkpYNMUqzZfDcn2byNUKgUSOZ8JljvU4kY704Lmh9HT9DG+UgxDFV/CTNa64Ml2px5ZEbLW6jxYPZ3w5MlPreMCjV11mzpImurimLtDl/8WudZDZhfbsy9GTw/Hk=;
X-UUID: 32672f8005c64d499a0df082931e5787-20201201
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 818032829; Tue, 01 Dec 2020 19:17:04 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 1 Dec 2020 19:17:00 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 1 Dec 2020 19:16:59 +0800
Message-ID: <1606821422.6563.10.camel@mtksdccf07>
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
Date:   Tue, 1 Dec 2020 19:17:02 +0800
In-Reply-To: <CACT4Y+a=GmYVZwwjyXwO=_AeGy4QB9X=5x7cL76erwjPvRW6Zw@mail.gmail.com>
References: <20200924040152.30851-1-walter-zh.wu@mediatek.com>
         <87h7rfi8pn.fsf@nanos.tec.linutronix.de>
         <CACT4Y+a=GmYVZwwjyXwO=_AeGy4QB9X=5x7cL76erwjPvRW6Zw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRG1pdHJ5LA0KDQpPbiBUdWUsIDIwMjAtMTItMDEgYXQgMDg6NTkgKzAxMDAsICdEbWl0cnkg
Vnl1a292JyB2aWEga2FzYW4tZGV2IHdyb3RlOg0KPiBPbiBXZWQsIFNlcCAzMCwgMjAyMCBhdCA1
OjI5IFBNIFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPiB3cm90ZToNCj4gPg0K
PiA+IE9uIFRodSwgU2VwIDI0IDIwMjAgYXQgMTI6MDEsIFdhbHRlciBXdSB3cm90ZToNCj4gPiA+
IFN5emJvdCByZXBvcnRzIG1hbnkgVUFGIGlzc3VlcyBmb3Igd29ya3F1ZXVlIG9yIHRpbWVyLCBz
ZWUgWzFdIGFuZCBbMl0uDQo+ID4gPiBJbiBzb21lIG9mIHRoZXNlIGFjY2Vzcy9hbGxvY2F0aW9u
IGhhcHBlbmVkIGluIHByb2Nlc3Nfb25lX3dvcmsoKSwNCj4gPiA+IHdlIHNlZSB0aGUgZnJlZSBz
dGFjayBpcyB1c2VsZXNzIGluIEtBU0FOIHJlcG9ydCwgaXQgZG9lc24ndCBoZWxwDQo+ID4gPiBw
cm9ncmFtbWVycyB0byBzb2x2ZSBVQUYgb24gd29ya3F1ZXVlLiBUaGUgc2FtZSBtYXkgc3RhbmQg
Zm9yIHRpbWVzLg0KPiA+ID4NCj4gPiA+IFRoaXMgcGF0Y2hzZXQgaW1wcm92ZXMgS0FTQU4gcmVw
b3J0cyBieSBtYWtpbmcgdGhlbSB0byBoYXZlIHdvcmtxdWV1ZQ0KPiA+ID4gcXVldWVpbmcgc3Rh
Y2sgYW5kIHRpbWVyIHN0YWNrIGluZm9ybWF0aW9uLiBJdCBpcyB1c2VmdWwgZm9yIHByb2dyYW1t
ZXJzDQo+ID4gPiB0byBzb2x2ZSB1c2UtYWZ0ZXItZnJlZSBvciBkb3VibGUtZnJlZSBtZW1vcnkg
aXNzdWUuDQo+ID4gPg0KPiA+ID4gR2VuZXJpYyBLQVNBTiBhbHNvIHJlY29yZHMgdGhlIGxhc3Qg
dHdvIHdvcmtxdWV1ZSBhbmQgdGltZXIgc3RhY2tzIGFuZA0KPiA+ID4gcHJpbnRzIHRoZW0gaW4g
S0FTQU4gcmVwb3J0LiBJdCBpcyBvbmx5IHN1aXRhYmxlIGZvciBnZW5lcmljIEtBU0FOLg0KPiAN
Cj4gV2FsdGVyLCBkaWQgeW91IG1haWwgdjU/DQo+IENoZWNraW5nIHN0YXR1c2VzIG9mIEtBU0FO
IGlzc3VlcyBhbmQgdGhpcyBzZWVtcyB0byBiZSBub3QgaW4gbGludXgtbmV4dC4NCj4gDQoNClNv
cnJ5IGZvciB0aGUgZGVsYXkgaW4gcmVzcG9uZGluZyB0byB0aGlzIHBhdGNoLiBJJ20gYnVzeSB0
aGVzZSBmZXcNCm1vbnRocywgc28gdGhhdCBzdXNwZW5kIHByb2Nlc3NpbmcgaXQuDQpZZXMsIEkg
d2lsbCBzZW5kIGl0IG5leHQgd2Vlay4gQnV0IHY0IG5lZWQgdG8gY29uZmlybSB0aGUgdGltZXIg
c3RhY2sgaXMNCnVzZWZ1bC4gSSBoYXZlbid0IGZvdW5kIGFuIGV4YW1wbGUuIERvIHlvdSBoYXZl
IHNvbWUgc3VnZ2VzdGlvbiBhYm91dA0KdGltZXI/DQoNClRoYW5rcy4NCldhbHRlcg0KDQo+ID4g
PiBbMV1odHRwczovL2dyb3Vwcy5nb29nbGUuY29tL2cvc3l6a2FsbGVyLWJ1Z3Mvc2VhcmNoP3E9
JTIydXNlLWFmdGVyLWZyZWUlMjIrcHJvY2Vzc19vbmVfd29yaw0KPiA+ID4gWzJdaHR0cHM6Ly9n
cm91cHMuZ29vZ2xlLmNvbS9nL3N5emthbGxlci1idWdzL3NlYXJjaD9xPSUyMnVzZS1hZnRlci1m
cmVlJTIyJTIwZXhwaXJlX3RpbWVycw0KPiA+DQo+ID4gSG93IGFyZSB0aGVzZSBsaW5rcyB1c2Vm
dWwgZm9yIHBlb3BsZSB3aG8gZG8gbm90IGhhdmUgYSBndXJnbGUgYWNjb3VudD8NCj4gDQo+IFRo
aXMgaXMgYSBwdWJsaWMgbWFpbGluZyBsaXN0IGFyY2hpdmUsIHNvIGVmZmVjdGl2ZWx5IHRoZSBz
YW1lIHdheSBhcw0KPiBsb3JlIGxpbmtzIDspDQo+IA0KDQo=

