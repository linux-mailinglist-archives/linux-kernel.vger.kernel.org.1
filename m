Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A502783BD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 11:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbgIYJPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 05:15:54 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:44185 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726990AbgIYJPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 05:15:53 -0400
X-UUID: b377c338c36e441fa181cdb2e44b81ba-20200925
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=wYZQKOZQHIfcecchTzNpFHCWhysG2MkETQF4DKJWtpw=;
        b=MHPfO+56Lvs0cVAsoafWeEXIVmcaD79P+HUVuF3Q0ob6Z/vMVS8TmJuszuiDLav5BTNcmgUpaRODTSuSx1/igM89HmaYzTnpfvfyxvKvId94eUL2bHcpjEZ9J7vyiQO41RboXPnAtjkExn8LDHBxqBJhaQUoQmKh0C/PhDVtrp8=;
X-UUID: b377c338c36e441fa181cdb2e44b81ba-20200925
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 256298133; Fri, 25 Sep 2020 17:15:49 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 25 Sep 2020 17:15:45 +0800
Received: from [172.21.84.99] (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 25 Sep 2020 17:15:45 +0800
Message-ID: <1601025346.2255.2.camel@mtksdccf07>
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
Date:   Fri, 25 Sep 2020 17:15:46 +0800
In-Reply-To: <87lfgyutf8.fsf@nanos.tec.linutronix.de>
References: <20200924040335.30934-1-walter-zh.wu@mediatek.com>
         <87h7rm97js.fsf@nanos.tec.linutronix.de>
         <1601018323.28162.4.camel@mtksdccf07>
         <87lfgyutf8.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 226A7A570B87CE4811210E74AF646C2772ABB9F1C3FA85FE059A86BBF585F5742000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTA5LTI1IGF0IDEwOjU1ICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IFdhbHRlciwNCj4gDQo+IE9uIEZyaSwgU2VwIDI1IDIwMjAgYXQgMTU6MTgsIFdhbHRlciBX
dSB3cm90ZToNCj4gPiBPbiBUaHUsIDIwMjAtMDktMjQgYXQgMjM6NDEgKzAyMDAsIFRob21hcyBH
bGVpeG5lciB3cm90ZToNCj4gPj4gPiBGb3IgdGltZXJzIGl0IGhhcyB0dXJuZWQgb3V0IHRvIGJl
IHVzZWZ1bCB0byByZWNvcmQgdGhlIHN0YWNrIHRyYWNlDQo+ID4+ID4gb2YgdGhlIHRpbWVyIGlu
aXQgY2FsbC4NCj4gPj4gDQo+ID4+IEluIHdoaWNoIHdheT8gQW5kIHdoYXQga2luZCBvZiBidWcg
ZG9lcyBpdCBjYXRjaCB3aGljaCBjYW5ub3QgYmUgY2F0Y2hlZA0KPiA+PiBieSBleGlzdGluZyBk
ZWJ1ZyBtZWNoYW5pc21zIGFscmVhZHk/DQo+ID4+IA0KPiA+IFdlIG9ubHkgcHJvdmlkZSBhbm90
aGVyIGRlYnVnIG1lY2hhbmlzbXMgdG8gZGVidWcgdXNlLWFmdGVyLWZyZWUgb3INCj4gPiBkb3Vi
bGUtZnJlZSwgaXQgY2FuIGJlIGRpc3BsYXllZCB0b2dldGhlciBpbiBLQVNBTiByZXBvcnQgYW5k
IGhhdmUgYQ0KPiA+IGNoYW5jZSB0byBkZWJ1ZywgYW5kIGl0IGRvZXNuJ3QgbmVlZCB0byBlbmFi
bGUgZXhpc3RpbmcgZGVidWcgbWVjaGFuaXNtcw0KPiA+IGF0IHRoZSBzYW1lIHRpbWUuIHRoZW4g
aXQgaGFzIGEgY2hhbmNlIHRvIHJlc29sdmUgaXNzdWUuDQo+IA0KPiBBZ2Fpbi4gS0FTQU4gY2Fu
IG9ubHkgY292ZXIgVUFGLCBidXQgdGhlcmUgYXJlIGEgZG96ZW4gb3RoZXIgd2F5cyB0bw0KPiB3
cmVjayB0aGUgc3lzdGVtIHdpdGggd3JvbmcgdXNhZ2Ugb2YgdGltZXJzIHdoaWNoIGNhbid0IGJl
IGNhdWdodCBieQ0KPiBLQVNBTi4NCj4gDQo+ID4+ID4gQmVjYXVzZSBpZiB0aGUgVUFGIHJvb3Qg
Y2F1c2UgaXMgaW4gdGltZXIgaW5pdCwgdGhlbiB1c2VyIGNhbiBzZWUNCj4gPj4gPiBLQVNBTiBy
ZXBvcnQgdG8gZ2V0IHdoZXJlIGl0IGlzIHJlZ2lzdGVyZWQgYW5kIGZpbmQgb3V0IHRoZSByb290
DQo+ID4+ID4gY2F1c2UuDQo+ID4+IA0KPiA+PiBXaGF0PyBJZiB0aGUgVUFGIHJvb3QgY2F1c2Ug
aXMgaW4gdGltZXIgaW5pdCwgdGhlbiByZWdpc3RlcmluZyBpdCBhZnRlcg0KPiA+PiB1c2luZyBp
dCBpbiB0aGF0IHZlcnkgc2FtZSBmdW5jdGlvbiBpcyBwcmV0dHkgcG9pbnRsZXNzLg0KPiA+PiAN
Cj4gPiBTZWUgWzFdLCB0aGUgY2FsbCBzdGFjayBzaG93cyBVQUYgaGFwcGVuIGF0IGR1bW15X3Rp
bWVyKCksIGl0IGlzIHRoZQ0KPiA+IGNhbGxiYWNrIGZ1bmN0aW9uIGFuZCBzZXQgYnkgdGltZXJf
c2V0dXAoKSwgaWYgS0FTQU4gcmVwb3J0IHNob3dzIHRoZQ0KPiA+IHRpbWVyIGNhbGwgc3RhY2ss
IGl0IHNob3VsZCBiZSB1c2VmdWwgZm9yIHByb2dyYW1tZXIuDQo+IA0KPiBUaGUgcmVwb3J0IHlv
dSBsaW5rZWQgdG8gaGFzIGFic29sdXRlbHkgbm90aGluZyB0byBkbyB3aXRoIGEgdGltZXINCj4g
cmVsYXRlZCBVQUYuIFRoZSB0aW1lciBjYWxsYmFjayBjYWxscyBrZnJlZV9za2IoKSBvbiBzb21l
dGhpbmcgd2hpY2ggaXMNCj4gYWxyZWFkeSBmcmVlZC4gU28gdGhlIHJvb3QgY2F1c2Ugb2YgdGhp
cyBpcyBOT1QgaW4gdGltZXIgaW5pdCBhcyB5b3UNCj4gY2xhaW1lZCBhYm92ZS4gVGhlIHRpbWVy
IGNhbGxiYWNrIGlzIGp1c3QgZXhwb3NpbmcgYSBwcm9ibGVtIGluIHRoZSBVUkINCj4gbWFuYWdl
bWVudCBvZiB0aGlzIGRyaXZlci4gSU9XIHRoZSByZWNvcmRpbmcgb2YgdGhlIHRpbWVyIGluaXQg
c3RhY2sgaXMNCj4gY29tcGxldGVseSB1c2VsZXNzIGZvciBkZWNvZGluZyB0aGlzIHByb2JsZW0u
DQo+IA0KPiA+PiBUaGVyZSBpcyBhIGxvdCBvZiBoYW5kd2F2aW5nIGhvdyB1c2VmdWwgdGhpcyBp
cywgYnV0IFRCSCBJIGRvbid0IHNlZSB0aGUNCj4gPj4gdmFsdWUgYXQgYWxsLg0KPiA+PiANCj4g
Pj4gREVCVUdfT0JKRUNUU19USU1FUlMgZG9lcyBhIGxvdCBtb3JlIHRoYW4gY3Jhc2hpbmcgb24g
VUFGLiBJZiBLQVNBTg0KPiA+PiBwcm92aWRlcyBhZGRpdGlvbmFsIHZhbHVlIG92ZXIgREVCVUdf
T0JKRUNUU19USU1FUlMgdGhlbiBzcGVsbCBpdCBvdXQsDQo+ID4+IGJ1dCBqdXN0IHNheWluZyB0
aGF0IHlvdSBkb24ndCBuZWVkIHRvIGVuYWJsZSBERUJVR19PQkpFQ1RTX1RJTUVSUyBpcw0KPiA+
PiBub3QgbWFraW5nIGFuIGFyZ3VtZW50IGZvciB0aGF0IGNoYW5nZS4NCj4gPj4gDQo+ID4gV2Ug
ZG9uJ3Qgd2FudCB0byByZXBsYWNlIERFQlVHX09CSkVDVFNfVElNRVJTIHdpdGggdGhpcyBwYXRj
aGVzLCBvbmx5DQo+ID4gaG9wZSB0byB1c2UgbG93IG92ZXJoZWFkKGNvbXBhcmUgd2l0aCBERUJV
R19PQkpFQ1RTX1RJTUVSUykgdG8gZGVidWcNCj4gDQo+IEtBU0FOIGhhcyBsb3dlciBvdmVyaGVh
ZCB0aGFuIERFQlVHX09CSkVDVFNfVElNRVJTPyBNYXliZSBpbiBhIGRpZmZlcmVudA0KPiB1bml2
ZXJzZS4NCj4gDQoNCkkgbWVhbiBLQVNBTiArIG91ciBwYXRjaCB2cyBLQVNBTiArIERFQlVHX09C
SkVDVFNfVElNRVJTLiBUaGUgZnJvbnQgb25lDQpoYXZlIHRoZSBpbmZvcm1hdGlvbiB0byB0aGUg
b3JpZ2luYWwgY2FsbGVyIGFuZCBoZWxwIHRvIGRlYnVnLiBJdCBpcw0Kc21hbGxlciBvdmVyaGVh
ZCB0aGFuIHRoZSBvbmUgYmVoaW5kLg0KDQo+IFRoYXQgc2FpZCwgSSdtIG5vdCBvcHBvc2VkIHRv
IHRoZSBjaGFuZ2UgcGVyIHNlLCBidXQgd2l0aG91dCBhIHNlbnNpYmxlDQo+IGp1c3RpZmljYXRp
b24gdGhpcyBpcyBqdXN0IHBvaW50bGVzcy4NCj4gDQo+IFNwcmlua2xpbmcga2FzYW5fZm9vKCkg
YWxsIG92ZXIgdGhlIHBsYWNlIGFuZCBjbGFpbWluZyBpdCdzIHVzZWZ1bA0KPiB3aXRob3V0IGEg
dmFsaWQgZXhhbXBsZSBkb2VzIG5vdCBwcm92aWRlIGFueSB2YWx1ZS4NCj4gDQo+IFF1aXRlIHRo
ZSBjb250cmFyeSBpdCBnaXZlcyB0aGUgY29tcGxldGVseSB3cm9uZyBzZW5zZSB3aGF0IEtBU0FO
IGNhbiBkbw0KPiBhbmQgd2hhdCBub3QuDQo+IA0KDQpJIGFncmVlIHlvdXIgc2F5aW5nLCBzbyB0
aGF0IEkgbmVlZCB0byBmaW5kIG91dCBhIHVzZSBjYXNlIHRvIGV4cGxhaW4gdG8NCnlvdS4NCg0K
VGhhbmtzDQoNCldhbHRlcg0KDQo+IFRoYW5rcywNCj4gDQo+ICAgICAgICAgdGdseA0KPiANCg0K

