Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C57B327E235
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 09:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbgI3HKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 03:10:15 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:41325 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725440AbgI3HKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 03:10:13 -0400
X-UUID: 6f26092053ff44b8976356b9dcdae94f-20200930
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=sNcH4x4lnYgToeUd+jBjU/sTj/7ms1xPJ3DnTKAMxb0=;
        b=IJjmJYa54QMzOQ4aIJE1Kqqymid1LeFZFuHde+2ZBHWOv1E/mV9T+ht3ZbasLuB3NYvPpcLoJzYJdezEcVOAtdrZU644oyIOg0K6tJSG9uugzXX01oy8PRPU2WntM2GIexVhU5rCznx9Kvmq/Kk25KHzzAVk20xaje5ICmzqvGQ=;
X-UUID: 6f26092053ff44b8976356b9dcdae94f-20200930
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1367246400; Wed, 30 Sep 2020 15:10:10 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 30 Sep 2020 15:10:08 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Sep 2020 15:10:09 +0800
Message-ID: <1601449808.7564.2.camel@mtkswgap22>
Subject: Re: [PATCH v7] Add MediaTek MT6779 devapc driver
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
Date:   Wed, 30 Sep 2020 15:10:08 +0800
In-Reply-To: <1600758789.19001.4.camel@mtkswgap22>
References: <1598497593-15781-1-git-send-email-neal.liu@mediatek.com>
         <1599028813.32069.1.camel@mtkswgap22> <1599640627.6370.3.camel@mtkswgap22>
         <1600246737.14155.3.camel@mtkswgap22> <1600758789.19001.4.camel@mtkswgap22>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: E6C5B16061FD81EDFCF10D81456BBBA9DCB241534B9CF99787AEE3C8644984D12000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF0dCwNCg0KSG9wZSB0aGlzIG1haWwgY291bGQgZmluZCB5b3Ugd2VsbC4NCklzIGV2ZXJ5
dGhpbmcgb2theT8NCkl0IHdvdWxkIGJlIGdsYWQgaWYgeW91IGNvdWxkIHJlcGx5IG1lIG5vIG1h
dHRlciB0aGUgcmV2aWV3IHN0YXR1cy4NCg0KVGhhbmtzDQoNCi1OZWFsDQoNCk9uIFR1ZSwgMjAy
MC0wOS0yMiBhdCAxNToxMyArMDgwMCwgTmVhbCBMaXUgd3JvdGU6DQo+IEhpIE1hdHRoaWFzLA0K
PiANCj4gV2UgbmVlZCB0aGlzIGRyaXZlciBzdXBwb3J0ZWQgb24gbWFpbi1saW5lLg0KPiBDb3Vs
ZCB5b3Ugc2F2ZSB5b3VyIHRpbWUgZm9yIHVzIHRvIHJldmlldyBpdD8NCj4gVGhhbmtzDQo+IA0K
PiAtTmVhbA0KPiANCj4gT24gV2VkLCAyMDIwLTA5LTE2IGF0IDE2OjU4ICswODAwLCBOZWFsIExp
dSB3cm90ZToNCj4gPiBIaSBSb2IsIE1hdHRoaWFzLCBDaHVuLUt1YW5nLA0KPiA+IA0KPiA+IFNv
cnJ5IGZvciBwdXNoaW5nIHlvdSBzbyBoYXJkLg0KPiA+IE1heSBJIGtub3cgaXMgdGhpcyBwYXRj
aCBzZXQgaXMgY29tZm9ydGFibGUgdG8gYXBwbHkgb24gbGF0ZXN0IGtlcm5lbD8NCj4gPiBUaGFu
a3MNCj4gPiANCj4gPiAtTmVhbA0KPiA+IA0KPiA+IE9uIFdlZCwgMjAyMC0wOS0wOSBhdCAxNjoz
NyArMDgwMCwgTmVhbCBMaXUgd3JvdGU6DQo+ID4gPiBIaSBSb2IsIE1hdHRoaWFzLCBDaHVuLUt1
YW5nLA0KPiA+ID4gDQo+ID4gPiBQbGVhc2Uga2luZGx5IGxldCBtZSBrbm93IHlvdXIgY29tbWVu
dHMgYWJvdXQgdGhpcyBwYXRjaCBzZXQuDQo+ID4gPiBUaGFua3MNCj4gPiA+IA0KPiA+ID4gLU5l
YWwNCj4gPiA+IA0KPiA+ID4gT24gV2VkLCAyMDIwLTA5LTAyIGF0IDE0OjQwICswODAwLCBOZWFs
IExpdSB3cm90ZToNCj4gPiA+ID4gSGkgUm9iLCBNYXR0aGlhcywgQ2h1bi1LdWFuZywNCj4gPiA+
ID4gDQo+ID4gPiA+IEdlbnRsZSBwaW5nIGZvciB0aGlzIHBhdGNoIHNldC4NCj4gPiA+ID4gVGhh
bmtzDQo+ID4gPiA+IA0KPiA+ID4gPiAtTmVhbA0KPiA+ID4gPiANCj4gPiA+ID4gT24gVGh1LCAy
MDIwLTA4LTI3IGF0IDExOjA2ICswODAwLCBOZWFsIExpdSB3cm90ZToNCj4gPiA+ID4gPiBUaGVz
ZSBwYXRjaCBzZXJpZXMgaW50cm9kdWNlIGEgTWVkaWFUZWsgTVQ2Nzc5IGRldmFwYyBkcml2ZXIu
DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gTWVkaWFUZWsgYnVzIGZhYnJpYyBwcm92aWRlcyBUcnVz
dFpvbmUgc2VjdXJpdHkgc3VwcG9ydCBhbmQgZGF0YSBwcm90ZWN0aW9uIHRvIHByZXZlbnQgc2xh
dmVzIGZyb20gYmVpbmcgYWNjZXNzZWQgYnkgdW5leHBlY3RlZCBtYXN0ZXJzLg0KPiA+ID4gPiA+
IFRoZSBzZWN1cml0eSB2aW9sYXRpb24gaXMgbG9nZ2VkIGFuZCBzZW50IHRvIHRoZSBwcm9jZXNz
b3IgZm9yIGZ1cnRoZXIgYW5hbHlzaXMgb3IgY291bnRlcm1lYXN1cmVzLg0KPiA+ID4gPiA+IA0K
PiA+ID4gPiA+IEFueSBvY2N1cnJlbmNlIG9mIHNlY3VyaXR5IHZpb2xhdGlvbiB3b3VsZCByYWlz
ZSBhbiBpbnRlcnJ1cHQsIGFuZCBpdCB3aWxsIGJlIGhhbmRsZWQgYnkgbXRrLWRldmFwYyBkcml2
ZXIuDQo+ID4gPiA+ID4gVGhlIHZpb2xhdGlvbiBpbmZvcm1hdGlvbiBpcyBwcmludGVkIGluIG9y
ZGVyIHRvIGZpbmQgdGhlIG11cmRlcmVyLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IGNoYW5nZXMg
c2luY2UgdjY6DQo+ID4gPiA+ID4gLSByZW1vdmUgdW5uZWNlc3NhcnkgbWFzay91bm1hc2sgbW9k
dWxlIGlycSBkdXJpbmcgSVNSLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IGNoYW5nZXMgc2luY2Ug
djU6DQo+ID4gPiA+ID4gLSByZW1vdmUgcmVkdW5kYW50IHdyaXRlIHJlZyBvcGVyYXRpb24uDQo+
ID4gPiA+ID4gLSB1c2Ugc3RhdGljIHZhcmlhYmxlIG9mIHZpb19kYmdzIGluc3RlYWQuDQo+ID4g
PiA+ID4gLSBhZGQgc3RvcF9kZXZhcGMoKSBpZiBkcml2ZXIgaXMgcmVtb3ZlZC4NCj4gPiA+ID4g
PiANCj4gPiA+ID4gPiBjaGFuZ2VzIHNpbmNlIHY0Og0KPiA+ID4gPiA+IC0gcmVmYWN0b3IgZGF0
YSBzdHJ1Y3R1cmUuDQo+ID4gPiA+ID4gLSBtZXJnZSB0d28gc2ltcGxlIGZ1bmN0aW9ucyBpbnRv
IG9uZS4NCj4gPiA+ID4gPiAtIHJlZmFjdG9yIHJlZ2lzdGVyIHNldHRpbmcgdG8gcHJldmVudCB0
b28gbWFueSBmdW5jdGlvbiBjYWxsIG92ZXJoZWFkLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IGNo
YW5nZXMgc2luY2UgdjM6DQo+ID4gPiA+ID4gLSByZXZpc2UgdmlvbGF0aW9uIGhhbmRsaW5nIGZs
b3cgdG8gbWFrZSBpdCBtb3JlIGVhc2lseSB0byB1bmRlcnN0YW5kDQo+ID4gPiA+ID4gICBoYXJk
d2FyZSBiZWhhdmlvci4NCj4gPiA+ID4gPiAtIGFkZCBtb3JlIGNvbW1lbnRzIHRvIHVuZGVyc3Rh
bmQgaG93IGhhcmR3YXJlIHdvcmtzLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IGNoYW5nZXMgc2lu
Y2UgdjI6DQo+ID4gPiA+ID4gLSBwYXNzIHBsYXRmb3JtIGluZm8gdGhyb3VnaCBEVCBkYXRhLg0K
PiA+ID4gPiA+IC0gcmVtb3ZlIHVubmVjZXNzYXJ5IGZ1bmN0aW9uLg0KPiA+ID4gPiA+IC0gcmVt
b3ZlIHNsYXZlX3R5cGUgYmVjYXVzZSBpdCBhbHdheXMgZXF1YWxzIHRvIDEgaW4gY3VycmVudCBz
dXBwb3J0IFNvQy4NCj4gPiA+ID4gPiAtIHVzZSB2aW9faWR4X251bSBpbnN0cmVhZCBvZiBsaXN0
IGFsbCBkZXZpY2VzJyBpbmRleC4NCj4gPiA+ID4gPiAtIGFkZCBtb3JlIGNvbW1lbnRzIHRvIGRl
c2NyaWJlIGhhcmR3YXJlIGJlaGF2aW9yLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IGNoYW5nZXMg
c2luY2UgdjE6DQo+ID4gPiA+ID4gLSBtb3ZlIFNvQyBzcGVjaWZpYyBwYXJ0IHRvIERUIGRhdGEu
DQo+ID4gPiA+ID4gLSByZW1vdmUgdW5uZWNlc3NhcnkgYm91bmRhcnkgY2hlY2suDQo+ID4gPiA+
ID4gLSByZW1vdmUgdW5uZWNlc3NhcnkgZGF0YSB0eXBlIGRlY2xhcmF0aW9uLg0KPiA+ID4gPiA+
IC0gdXNlIHJlYWRfcG9sbF90aW1lb3V0KCkgaW5zdHJlYWQgb2YgZm9yIGxvb3AgcG9sbGluZy4N
Cj4gPiA+ID4gPiAtIHJldmlzZSBjb2Rpbmcgc3R5bGUgZWxlZ2FudGx5Lg0KPiA+ID4gPiA+IA0K
PiA+ID4gPiA+IA0KPiA+ID4gPiA+ICoqKiBCTFVSQiBIRVJFICoqKg0KPiA+ID4gPiA+IA0KPiA+
ID4gPiA+IE5lYWwgTGl1ICgyKToNCj4gPiA+ID4gPiAgIGR0LWJpbmRpbmdzOiBkZXZhcGM6IGFk
ZCBiaW5kaW5ncyBmb3IgbXRrLWRldmFwYw0KPiA+ID4gPiA+ICAgc29jOiBtZWRpYXRlazogYWRk
IG10Njc3OSBkZXZhcGMgZHJpdmVyDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gIC4uLi9iaW5kaW5n
cy9zb2MvbWVkaWF0ZWsvZGV2YXBjLnlhbWwgICAgICAgICB8ICA1OCArKysrDQo+ID4gPiA+ID4g
IGRyaXZlcnMvc29jL21lZGlhdGVrL0tjb25maWcgICAgICAgICAgICAgICAgICB8ICAgOSArDQo+
ID4gPiA+ID4gIGRyaXZlcnMvc29jL21lZGlhdGVrL01ha2VmaWxlICAgICAgICAgICAgICAgICB8
ICAgMSArDQo+ID4gPiA+ID4gIGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1kZXZhcGMuYyAgICAg
ICAgICAgICB8IDMwNSArKysrKysrKysrKysrKysrKysNCj4gPiA+ID4gPiAgNCBmaWxlcyBjaGFu
Z2VkLCAzNzMgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9tZWRpYXRlay9kZXZhcGMueWFtbA0K
PiA+ID4gPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWRl
dmFwYy5jDQo+ID4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+IA0KPiA+ID4gDQo+
ID4gDQo+ID4gDQo+IA0KPiANCg0K

