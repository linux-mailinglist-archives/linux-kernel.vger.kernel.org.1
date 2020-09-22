Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8805273B7F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 09:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbgIVHNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 03:13:20 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:57489 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728526AbgIVHNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 03:13:16 -0400
X-UUID: d2c6de1f2a0642c3b4370b26606d871f-20200922
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=y5qtueSnd0gmXTgqaU7WrKuS0UH/8TSj72WVkDhtRI4=;
        b=Dje6q1TmGkdE+S1arwuuvpcomXsB5uJj8NcGXs2/mInVgeXb75PlMTWmsiZ8cJGluR69zw9poVr5DCKqO4svW14kAkWnZ2GYU3rYkFxxY0/KmImbzKDbVBJ0+sFdAt774HLVTNoI3iHWfKzozNd9EblHrHR9S9cvaQyGydoWc/E=;
X-UUID: d2c6de1f2a0642c3b4370b26606d871f-20200922
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 618911528; Tue, 22 Sep 2020 15:13:11 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 22 Sep 2020 15:13:08 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 22 Sep 2020 15:13:08 +0800
Message-ID: <1600758789.19001.4.camel@mtkswgap22>
Subject: Re: [PATCH v7] Add MediaTek MT6779 devapc driver
From:   Neal Liu <neal.liu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Neal Liu <neal.liu@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        wsd_upstream <wsd_upstream@mediatek.com>
Date:   Tue, 22 Sep 2020 15:13:09 +0800
In-Reply-To: <1600246737.14155.3.camel@mtkswgap22>
References: <1598497593-15781-1-git-send-email-neal.liu@mediatek.com>
         <1599028813.32069.1.camel@mtkswgap22> <1599640627.6370.3.camel@mtkswgap22>
         <1600246737.14155.3.camel@mtkswgap22>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: D9A970872699FB66BF596432F982953E3F524122165F704DE10755B81CEC28102000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF0dGhpYXMsDQoNCldlIG5lZWQgdGhpcyBkcml2ZXIgc3VwcG9ydGVkIG9uIG1haW4tbGlu
ZS4NCkNvdWxkIHlvdSBzYXZlIHlvdXIgdGltZSBmb3IgdXMgdG8gcmV2aWV3IGl0Pw0KVGhhbmtz
DQoNCi1OZWFsDQoNCk9uIFdlZCwgMjAyMC0wOS0xNiBhdCAxNjo1OCArMDgwMCwgTmVhbCBMaXUg
d3JvdGU6DQo+IEhpIFJvYiwgTWF0dGhpYXMsIENodW4tS3VhbmcsDQo+IA0KPiBTb3JyeSBmb3Ig
cHVzaGluZyB5b3Ugc28gaGFyZC4NCj4gTWF5IEkga25vdyBpcyB0aGlzIHBhdGNoIHNldCBpcyBj
b21mb3J0YWJsZSB0byBhcHBseSBvbiBsYXRlc3Qga2VybmVsPw0KPiBUaGFua3MNCj4gDQo+IC1O
ZWFsDQo+IA0KPiBPbiBXZWQsIDIwMjAtMDktMDkgYXQgMTY6MzcgKzA4MDAsIE5lYWwgTGl1IHdy
b3RlOg0KPiA+IEhpIFJvYiwgTWF0dGhpYXMsIENodW4tS3VhbmcsDQo+ID4gDQo+ID4gUGxlYXNl
IGtpbmRseSBsZXQgbWUga25vdyB5b3VyIGNvbW1lbnRzIGFib3V0IHRoaXMgcGF0Y2ggc2V0Lg0K
PiA+IFRoYW5rcw0KPiA+IA0KPiA+IC1OZWFsDQo+ID4gDQo+ID4gT24gV2VkLCAyMDIwLTA5LTAy
IGF0IDE0OjQwICswODAwLCBOZWFsIExpdSB3cm90ZToNCj4gPiA+IEhpIFJvYiwgTWF0dGhpYXMs
IENodW4tS3VhbmcsDQo+ID4gPiANCj4gPiA+IEdlbnRsZSBwaW5nIGZvciB0aGlzIHBhdGNoIHNl
dC4NCj4gPiA+IFRoYW5rcw0KPiA+ID4gDQo+ID4gPiAtTmVhbA0KPiA+ID4gDQo+ID4gPiBPbiBU
aHUsIDIwMjAtMDgtMjcgYXQgMTE6MDYgKzA4MDAsIE5lYWwgTGl1IHdyb3RlOg0KPiA+ID4gPiBU
aGVzZSBwYXRjaCBzZXJpZXMgaW50cm9kdWNlIGEgTWVkaWFUZWsgTVQ2Nzc5IGRldmFwYyBkcml2
ZXIuDQo+ID4gPiA+IA0KPiA+ID4gPiBNZWRpYVRlayBidXMgZmFicmljIHByb3ZpZGVzIFRydXN0
Wm9uZSBzZWN1cml0eSBzdXBwb3J0IGFuZCBkYXRhIHByb3RlY3Rpb24gdG8gcHJldmVudCBzbGF2
ZXMgZnJvbSBiZWluZyBhY2Nlc3NlZCBieSB1bmV4cGVjdGVkIG1hc3RlcnMuDQo+ID4gPiA+IFRo
ZSBzZWN1cml0eSB2aW9sYXRpb24gaXMgbG9nZ2VkIGFuZCBzZW50IHRvIHRoZSBwcm9jZXNzb3Ig
Zm9yIGZ1cnRoZXIgYW5hbHlzaXMgb3IgY291bnRlcm1lYXN1cmVzLg0KPiA+ID4gPiANCj4gPiA+
ID4gQW55IG9jY3VycmVuY2Ugb2Ygc2VjdXJpdHkgdmlvbGF0aW9uIHdvdWxkIHJhaXNlIGFuIGlu
dGVycnVwdCwgYW5kIGl0IHdpbGwgYmUgaGFuZGxlZCBieSBtdGstZGV2YXBjIGRyaXZlci4NCj4g
PiA+ID4gVGhlIHZpb2xhdGlvbiBpbmZvcm1hdGlvbiBpcyBwcmludGVkIGluIG9yZGVyIHRvIGZp
bmQgdGhlIG11cmRlcmVyLg0KPiA+ID4gPiANCj4gPiA+ID4gY2hhbmdlcyBzaW5jZSB2NjoNCj4g
PiA+ID4gLSByZW1vdmUgdW5uZWNlc3NhcnkgbWFzay91bm1hc2sgbW9kdWxlIGlycSBkdXJpbmcg
SVNSLg0KPiA+ID4gPiANCj4gPiA+ID4gY2hhbmdlcyBzaW5jZSB2NToNCj4gPiA+ID4gLSByZW1v
dmUgcmVkdW5kYW50IHdyaXRlIHJlZyBvcGVyYXRpb24uDQo+ID4gPiA+IC0gdXNlIHN0YXRpYyB2
YXJpYWJsZSBvZiB2aW9fZGJncyBpbnN0ZWFkLg0KPiA+ID4gPiAtIGFkZCBzdG9wX2RldmFwYygp
IGlmIGRyaXZlciBpcyByZW1vdmVkLg0KPiA+ID4gPiANCj4gPiA+ID4gY2hhbmdlcyBzaW5jZSB2
NDoNCj4gPiA+ID4gLSByZWZhY3RvciBkYXRhIHN0cnVjdHVyZS4NCj4gPiA+ID4gLSBtZXJnZSB0
d28gc2ltcGxlIGZ1bmN0aW9ucyBpbnRvIG9uZS4NCj4gPiA+ID4gLSByZWZhY3RvciByZWdpc3Rl
ciBzZXR0aW5nIHRvIHByZXZlbnQgdG9vIG1hbnkgZnVuY3Rpb24gY2FsbCBvdmVyaGVhZC4NCj4g
PiA+ID4gDQo+ID4gPiA+IGNoYW5nZXMgc2luY2UgdjM6DQo+ID4gPiA+IC0gcmV2aXNlIHZpb2xh
dGlvbiBoYW5kbGluZyBmbG93IHRvIG1ha2UgaXQgbW9yZSBlYXNpbHkgdG8gdW5kZXJzdGFuZA0K
PiA+ID4gPiAgIGhhcmR3YXJlIGJlaGF2aW9yLg0KPiA+ID4gPiAtIGFkZCBtb3JlIGNvbW1lbnRz
IHRvIHVuZGVyc3RhbmQgaG93IGhhcmR3YXJlIHdvcmtzLg0KPiA+ID4gPiANCj4gPiA+ID4gY2hh
bmdlcyBzaW5jZSB2MjoNCj4gPiA+ID4gLSBwYXNzIHBsYXRmb3JtIGluZm8gdGhyb3VnaCBEVCBk
YXRhLg0KPiA+ID4gPiAtIHJlbW92ZSB1bm5lY2Vzc2FyeSBmdW5jdGlvbi4NCj4gPiA+ID4gLSBy
ZW1vdmUgc2xhdmVfdHlwZSBiZWNhdXNlIGl0IGFsd2F5cyBlcXVhbHMgdG8gMSBpbiBjdXJyZW50
IHN1cHBvcnQgU29DLg0KPiA+ID4gPiAtIHVzZSB2aW9faWR4X251bSBpbnN0cmVhZCBvZiBsaXN0
IGFsbCBkZXZpY2VzJyBpbmRleC4NCj4gPiA+ID4gLSBhZGQgbW9yZSBjb21tZW50cyB0byBkZXNj
cmliZSBoYXJkd2FyZSBiZWhhdmlvci4NCj4gPiA+ID4gDQo+ID4gPiA+IGNoYW5nZXMgc2luY2Ug
djE6DQo+ID4gPiA+IC0gbW92ZSBTb0Mgc3BlY2lmaWMgcGFydCB0byBEVCBkYXRhLg0KPiA+ID4g
PiAtIHJlbW92ZSB1bm5lY2Vzc2FyeSBib3VuZGFyeSBjaGVjay4NCj4gPiA+ID4gLSByZW1vdmUg
dW5uZWNlc3NhcnkgZGF0YSB0eXBlIGRlY2xhcmF0aW9uLg0KPiA+ID4gPiAtIHVzZSByZWFkX3Bv
bGxfdGltZW91dCgpIGluc3RyZWFkIG9mIGZvciBsb29wIHBvbGxpbmcuDQo+ID4gPiA+IC0gcmV2
aXNlIGNvZGluZyBzdHlsZSBlbGVnYW50bHkuDQo+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4g
KioqIEJMVVJCIEhFUkUgKioqDQo+ID4gPiA+IA0KPiA+ID4gPiBOZWFsIExpdSAoMik6DQo+ID4g
PiA+ICAgZHQtYmluZGluZ3M6IGRldmFwYzogYWRkIGJpbmRpbmdzIGZvciBtdGstZGV2YXBjDQo+
ID4gPiA+ICAgc29jOiBtZWRpYXRlazogYWRkIG10Njc3OSBkZXZhcGMgZHJpdmVyDQo+ID4gPiA+
IA0KPiA+ID4gPiAgLi4uL2JpbmRpbmdzL3NvYy9tZWRpYXRlay9kZXZhcGMueWFtbCAgICAgICAg
IHwgIDU4ICsrKysNCj4gPiA+ID4gIGRyaXZlcnMvc29jL21lZGlhdGVrL0tjb25maWcgICAgICAg
ICAgICAgICAgICB8ICAgOSArDQo+ID4gPiA+ICBkcml2ZXJzL3NvYy9tZWRpYXRlay9NYWtlZmls
ZSAgICAgICAgICAgICAgICAgfCAgIDEgKw0KPiA+ID4gPiAgZHJpdmVycy9zb2MvbWVkaWF0ZWsv
bXRrLWRldmFwYy5jICAgICAgICAgICAgIHwgMzA1ICsrKysrKysrKysrKysrKysrKw0KPiA+ID4g
PiAgNCBmaWxlcyBjaGFuZ2VkLCAzNzMgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPiAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvbWVkaWF0ZWsv
ZGV2YXBjLnlhbWwNCj4gPiA+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3NvYy9tZWRp
YXRlay9tdGstZGV2YXBjLmMNCj4gPiA+ID4gDQo+ID4gPiANCj4gPiA+IA0KPiA+IA0KPiA+IA0K
PiANCj4gDQoNCg==

