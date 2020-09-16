Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B1B26BFF7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 10:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgIPI7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 04:59:05 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:28793 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726243AbgIPI7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 04:59:04 -0400
X-UUID: 9cb0937626874d6ab6b4c3a4c04e2d2f-20200916
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=6/Tv0FndX29EmMtcgOUoLXSwSSkphI8VR0atrPZZgPQ=;
        b=ePcc68cAqwZlX+YDeW3Mwfw89EPll3Xlg10AGizm8HWlBN1e+aW6j/bmfL8GeMZfwr6OfLY4TUBbqLw69l4WOsMrskRnOsXGXd1c12PhVgxoqu3zLPzvr5kiIGUwhWgM8RsUv4wPoUAmVnnTvyNfJTxY1qHa/9X7yGxT6y/aTyE=;
X-UUID: 9cb0937626874d6ab6b4c3a4c04e2d2f-20200916
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1235013453; Wed, 16 Sep 2020 16:58:58 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Sep 2020 16:58:55 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Sep 2020 16:58:55 +0800
Message-ID: <1600246737.14155.3.camel@mtkswgap22>
Subject: Re: [PATCH v7] Add MediaTek MT6779 devapc driver
From:   Neal Liu <neal.liu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Neal Liu <neal.liu@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        wsd_upstream <wsd_upstream@mediatek.com>
Date:   Wed, 16 Sep 2020 16:58:57 +0800
In-Reply-To: <1599640627.6370.3.camel@mtkswgap22>
References: <1598497593-15781-1-git-send-email-neal.liu@mediatek.com>
         <1599028813.32069.1.camel@mtkswgap22> <1599640627.6370.3.camel@mtkswgap22>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLCBNYXR0aGlhcywgQ2h1bi1LdWFuZywNCg0KU29ycnkgZm9yIHB1c2hpbmcgeW91IHNv
IGhhcmQuDQpNYXkgSSBrbm93IGlzIHRoaXMgcGF0Y2ggc2V0IGlzIGNvbWZvcnRhYmxlIHRvIGFw
cGx5IG9uIGxhdGVzdCBrZXJuZWw/DQpUaGFua3MNCg0KLU5lYWwNCg0KT24gV2VkLCAyMDIwLTA5
LTA5IGF0IDE2OjM3ICswODAwLCBOZWFsIExpdSB3cm90ZToNCj4gSGkgUm9iLCBNYXR0aGlhcywg
Q2h1bi1LdWFuZywNCj4gDQo+IFBsZWFzZSBraW5kbHkgbGV0IG1lIGtub3cgeW91ciBjb21tZW50
cyBhYm91dCB0aGlzIHBhdGNoIHNldC4NCj4gVGhhbmtzDQo+IA0KPiAtTmVhbA0KPiANCj4gT24g
V2VkLCAyMDIwLTA5LTAyIGF0IDE0OjQwICswODAwLCBOZWFsIExpdSB3cm90ZToNCj4gPiBIaSBS
b2IsIE1hdHRoaWFzLCBDaHVuLUt1YW5nLA0KPiA+IA0KPiA+IEdlbnRsZSBwaW5nIGZvciB0aGlz
IHBhdGNoIHNldC4NCj4gPiBUaGFua3MNCj4gPiANCj4gPiAtTmVhbA0KPiA+IA0KPiA+IE9uIFRo
dSwgMjAyMC0wOC0yNyBhdCAxMTowNiArMDgwMCwgTmVhbCBMaXUgd3JvdGU6DQo+ID4gPiBUaGVz
ZSBwYXRjaCBzZXJpZXMgaW50cm9kdWNlIGEgTWVkaWFUZWsgTVQ2Nzc5IGRldmFwYyBkcml2ZXIu
DQo+ID4gPiANCj4gPiA+IE1lZGlhVGVrIGJ1cyBmYWJyaWMgcHJvdmlkZXMgVHJ1c3Rab25lIHNl
Y3VyaXR5IHN1cHBvcnQgYW5kIGRhdGEgcHJvdGVjdGlvbiB0byBwcmV2ZW50IHNsYXZlcyBmcm9t
IGJlaW5nIGFjY2Vzc2VkIGJ5IHVuZXhwZWN0ZWQgbWFzdGVycy4NCj4gPiA+IFRoZSBzZWN1cml0
eSB2aW9sYXRpb24gaXMgbG9nZ2VkIGFuZCBzZW50IHRvIHRoZSBwcm9jZXNzb3IgZm9yIGZ1cnRo
ZXIgYW5hbHlzaXMgb3IgY291bnRlcm1lYXN1cmVzLg0KPiA+ID4gDQo+ID4gPiBBbnkgb2NjdXJy
ZW5jZSBvZiBzZWN1cml0eSB2aW9sYXRpb24gd291bGQgcmFpc2UgYW4gaW50ZXJydXB0LCBhbmQg
aXQgd2lsbCBiZSBoYW5kbGVkIGJ5IG10ay1kZXZhcGMgZHJpdmVyLg0KPiA+ID4gVGhlIHZpb2xh
dGlvbiBpbmZvcm1hdGlvbiBpcyBwcmludGVkIGluIG9yZGVyIHRvIGZpbmQgdGhlIG11cmRlcmVy
Lg0KPiA+ID4gDQo+ID4gPiBjaGFuZ2VzIHNpbmNlIHY2Og0KPiA+ID4gLSByZW1vdmUgdW5uZWNl
c3NhcnkgbWFzay91bm1hc2sgbW9kdWxlIGlycSBkdXJpbmcgSVNSLg0KPiA+ID4gDQo+ID4gPiBj
aGFuZ2VzIHNpbmNlIHY1Og0KPiA+ID4gLSByZW1vdmUgcmVkdW5kYW50IHdyaXRlIHJlZyBvcGVy
YXRpb24uDQo+ID4gPiAtIHVzZSBzdGF0aWMgdmFyaWFibGUgb2YgdmlvX2RiZ3MgaW5zdGVhZC4N
Cj4gPiA+IC0gYWRkIHN0b3BfZGV2YXBjKCkgaWYgZHJpdmVyIGlzIHJlbW92ZWQuDQo+ID4gPiAN
Cj4gPiA+IGNoYW5nZXMgc2luY2UgdjQ6DQo+ID4gPiAtIHJlZmFjdG9yIGRhdGEgc3RydWN0dXJl
Lg0KPiA+ID4gLSBtZXJnZSB0d28gc2ltcGxlIGZ1bmN0aW9ucyBpbnRvIG9uZS4NCj4gPiA+IC0g
cmVmYWN0b3IgcmVnaXN0ZXIgc2V0dGluZyB0byBwcmV2ZW50IHRvbyBtYW55IGZ1bmN0aW9uIGNh
bGwgb3ZlcmhlYWQuDQo+ID4gPiANCj4gPiA+IGNoYW5nZXMgc2luY2UgdjM6DQo+ID4gPiAtIHJl
dmlzZSB2aW9sYXRpb24gaGFuZGxpbmcgZmxvdyB0byBtYWtlIGl0IG1vcmUgZWFzaWx5IHRvIHVu
ZGVyc3RhbmQNCj4gPiA+ICAgaGFyZHdhcmUgYmVoYXZpb3IuDQo+ID4gPiAtIGFkZCBtb3JlIGNv
bW1lbnRzIHRvIHVuZGVyc3RhbmQgaG93IGhhcmR3YXJlIHdvcmtzLg0KPiA+ID4gDQo+ID4gPiBj
aGFuZ2VzIHNpbmNlIHYyOg0KPiA+ID4gLSBwYXNzIHBsYXRmb3JtIGluZm8gdGhyb3VnaCBEVCBk
YXRhLg0KPiA+ID4gLSByZW1vdmUgdW5uZWNlc3NhcnkgZnVuY3Rpb24uDQo+ID4gPiAtIHJlbW92
ZSBzbGF2ZV90eXBlIGJlY2F1c2UgaXQgYWx3YXlzIGVxdWFscyB0byAxIGluIGN1cnJlbnQgc3Vw
cG9ydCBTb0MuDQo+ID4gPiAtIHVzZSB2aW9faWR4X251bSBpbnN0cmVhZCBvZiBsaXN0IGFsbCBk
ZXZpY2VzJyBpbmRleC4NCj4gPiA+IC0gYWRkIG1vcmUgY29tbWVudHMgdG8gZGVzY3JpYmUgaGFy
ZHdhcmUgYmVoYXZpb3IuDQo+ID4gPiANCj4gPiA+IGNoYW5nZXMgc2luY2UgdjE6DQo+ID4gPiAt
IG1vdmUgU29DIHNwZWNpZmljIHBhcnQgdG8gRFQgZGF0YS4NCj4gPiA+IC0gcmVtb3ZlIHVubmVj
ZXNzYXJ5IGJvdW5kYXJ5IGNoZWNrLg0KPiA+ID4gLSByZW1vdmUgdW5uZWNlc3NhcnkgZGF0YSB0
eXBlIGRlY2xhcmF0aW9uLg0KPiA+ID4gLSB1c2UgcmVhZF9wb2xsX3RpbWVvdXQoKSBpbnN0cmVh
ZCBvZiBmb3IgbG9vcCBwb2xsaW5nLg0KPiA+ID4gLSByZXZpc2UgY29kaW5nIHN0eWxlIGVsZWdh
bnRseS4NCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiAqKiogQkxVUkIgSEVSRSAqKioNCj4gPiA+IA0K
PiA+ID4gTmVhbCBMaXUgKDIpOg0KPiA+ID4gICBkdC1iaW5kaW5nczogZGV2YXBjOiBhZGQgYmlu
ZGluZ3MgZm9yIG10ay1kZXZhcGMNCj4gPiA+ICAgc29jOiBtZWRpYXRlazogYWRkIG10Njc3OSBk
ZXZhcGMgZHJpdmVyDQo+ID4gPiANCj4gPiA+ICAuLi4vYmluZGluZ3Mvc29jL21lZGlhdGVrL2Rl
dmFwYy55YW1sICAgICAgICAgfCAgNTggKysrKw0KPiA+ID4gIGRyaXZlcnMvc29jL21lZGlhdGVr
L0tjb25maWcgICAgICAgICAgICAgICAgICB8ICAgOSArDQo+ID4gPiAgZHJpdmVycy9zb2MvbWVk
aWF0ZWsvTWFrZWZpbGUgICAgICAgICAgICAgICAgIHwgICAxICsNCj4gPiA+ICBkcml2ZXJzL3Nv
Yy9tZWRpYXRlay9tdGstZGV2YXBjLmMgICAgICAgICAgICAgfCAzMDUgKysrKysrKysrKysrKysr
KysrDQo+ID4gPiAgNCBmaWxlcyBjaGFuZ2VkLCAzNzMgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL21l
ZGlhdGVrL2RldmFwYy55YW1sDQo+ID4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvc29j
L21lZGlhdGVrL210ay1kZXZhcGMuYw0KPiA+ID4gDQo+ID4gDQo+ID4gDQo+IA0KPiANCg0K

