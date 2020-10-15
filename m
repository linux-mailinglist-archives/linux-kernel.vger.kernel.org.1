Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4738128EB7E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 05:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbgJODYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 23:24:44 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:50481 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727200AbgJODYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 23:24:42 -0400
X-UUID: 3d5a04955d9340ad906a7b8c40d7c756-20201015
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=pmsobvcv+HjZGQVWkOFXSSxEvgvct9280t38GO0t+XY=;
        b=vEB+V7YrMQaCEfsArsA+Bnm2LxAL6BcL813uSLVl/Fw2sZuKkVRrgfwNUoV37uSf9tDt+N45ujd4P3fdF0n4UPl8xW68dkC5bxdRdIGRqKDpiVt70jJhOLUIKL/sixjf0sYnP5fMmmX11sWLGvPqi5SzAgIDx64qBFiFBcL5gdE=;
X-UUID: 3d5a04955d9340ad906a7b8c40d7c756-20201015
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 505195856; Thu, 15 Oct 2020 11:24:38 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 15 Oct 2020 11:24:37 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 15 Oct 2020 11:24:36 +0800
Message-ID: <1602732276.13734.1.camel@mtkswgap22>
Subject: [PATCH v8] Add MediaTek MT6779 devapc driver
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
Date:   Thu, 15 Oct 2020 11:24:36 +0800
In-Reply-To: <1602732039-12179-1-git-send-email-neal.liu@mediatek.com>
References: <1602732039-12179-1-git-send-email-neal.liu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YWRkIHN1YmplY3QNCg0KT24gVGh1LCAyMDIwLTEwLTE1IGF0IDExOjIwICswODAwLCBOZWFsIExp
dSB3cm90ZToNCj4gVGhlc2UgcGF0Y2ggc2VyaWVzIGludHJvZHVjZSBhIE1lZGlhVGVrIE1UNjc3
OSBkZXZhcGMgZHJpdmVyLg0KPiANCj4gTWVkaWFUZWsgYnVzIGZhYnJpYyBwcm92aWRlcyBUcnVz
dFpvbmUgc2VjdXJpdHkgc3VwcG9ydCBhbmQgZGF0YSBwcm90ZWN0aW9uIHRvIHByZXZlbnQgc2xh
dmVzIGZyb20gYmVpbmcgYWNjZXNzZWQgYnkgdW5leHBlY3RlZCBtYXN0ZXJzLg0KPiBUaGUgc2Vj
dXJpdHkgdmlvbGF0aW9uIGlzIGxvZ2dlZCBhbmQgc2VudCB0byB0aGUgcHJvY2Vzc29yIGZvciBm
dXJ0aGVyIGFuYWx5c2lzIG9yIGNvdW50ZXJtZWFzdXJlcy4NCj4gDQo+IEFueSBvY2N1cnJlbmNl
IG9mIHNlY3VyaXR5IHZpb2xhdGlvbiB3b3VsZCByYWlzZSBhbiBpbnRlcnJ1cHQsIGFuZCBpdCB3
aWxsIGJlIGhhbmRsZWQgYnkgbXRrLWRldmFwYyBkcml2ZXIuDQo+IFRoZSB2aW9sYXRpb24gaW5m
b3JtYXRpb24gaXMgcHJpbnRlZCBpbiBvcmRlciB0byBmaW5kIHRoZSBtdXJkZXJlci4NCj4gDQo+
IGNoYW5nZXMgc2luY2Ugdjc6DQo+IC0gZml4IFZJT19NT0RfVE9fUkVHX0lORCBjYWxjdWxhdGlv
biB3cm9uZyBwcm9ibGVtLg0KPiAtIHJldmlzZSBwYXJhbWV0ZXIgdHlwZSBvZiBJU1IuDQo+IA0K
PiBjaGFuZ2VzIHNpbmNlIHY2Og0KPiAtIHJlbW92ZSB1bm5lY2Vzc2FyeSBtYXNrL3VubWFzayBt
b2R1bGUgaXJxIGR1cmluZyBJU1IuDQo+IA0KPiBjaGFuZ2VzIHNpbmNlIHY1Og0KPiAtIHJlbW92
ZSByZWR1bmRhbnQgd3JpdGUgcmVnIG9wZXJhdGlvbi4NCj4gLSB1c2Ugc3RhdGljIHZhcmlhYmxl
IG9mIHZpb19kYmdzIGluc3RlYWQuDQo+IC0gYWRkIHN0b3BfZGV2YXBjKCkgaWYgZHJpdmVyIGlz
IHJlbW92ZWQuDQo+IA0KPiBjaGFuZ2VzIHNpbmNlIHY0Og0KPiAtIHJlZmFjdG9yIGRhdGEgc3Ry
dWN0dXJlLg0KPiAtIG1lcmdlIHR3byBzaW1wbGUgZnVuY3Rpb25zIGludG8gb25lLg0KPiAtIHJl
ZmFjdG9yIHJlZ2lzdGVyIHNldHRpbmcgdG8gcHJldmVudCB0b28gbWFueSBmdW5jdGlvbiBjYWxs
IG92ZXJoZWFkLg0KPiANCj4gY2hhbmdlcyBzaW5jZSB2MzoNCj4gLSByZXZpc2UgdmlvbGF0aW9u
IGhhbmRsaW5nIGZsb3cgdG8gbWFrZSBpdCBtb3JlIGVhc2lseSB0byB1bmRlcnN0YW5kDQo+ICAg
aGFyZHdhcmUgYmVoYXZpb3IuDQo+IC0gYWRkIG1vcmUgY29tbWVudHMgdG8gdW5kZXJzdGFuZCBo
b3cgaGFyZHdhcmUgd29ya3MuDQo+IA0KPiBjaGFuZ2VzIHNpbmNlIHYyOg0KPiAtIHBhc3MgcGxh
dGZvcm0gaW5mbyB0aHJvdWdoIERUIGRhdGEuDQo+IC0gcmVtb3ZlIHVubmVjZXNzYXJ5IGZ1bmN0
aW9uLg0KPiAtIHJlbW92ZSBzbGF2ZV90eXBlIGJlY2F1c2UgaXQgYWx3YXlzIGVxdWFscyB0byAx
IGluIGN1cnJlbnQgc3VwcG9ydCBTb0MuDQo+IC0gdXNlIHZpb19pZHhfbnVtIGluc3RyZWFkIG9m
IGxpc3QgYWxsIGRldmljZXMnIGluZGV4Lg0KPiAtIGFkZCBtb3JlIGNvbW1lbnRzIHRvIGRlc2Ny
aWJlIGhhcmR3YXJlIGJlaGF2aW9yLg0KPiANCj4gY2hhbmdlcyBzaW5jZSB2MToNCj4gLSBtb3Zl
IFNvQyBzcGVjaWZpYyBwYXJ0IHRvIERUIGRhdGEuDQo+IC0gcmVtb3ZlIHVubmVjZXNzYXJ5IGJv
dW5kYXJ5IGNoZWNrLg0KPiAtIHJlbW92ZSB1bm5lY2Vzc2FyeSBkYXRhIHR5cGUgZGVjbGFyYXRp
b24uDQo+IC0gdXNlIHJlYWRfcG9sbF90aW1lb3V0KCkgaW5zdHJlYWQgb2YgZm9yIGxvb3AgcG9s
bGluZy4NCj4gLSByZXZpc2UgY29kaW5nIHN0eWxlIGVsZWdhbnRseS4NCj4gDQo+IA0KPiAqKiog
QkxVUkIgSEVSRSAqKioNCj4gDQo+IE5lYWwgTGl1ICgyKToNCj4gICBkdC1iaW5kaW5nczogZGV2
YXBjOiBhZGQgYmluZGluZ3MgZm9yIG10ay1kZXZhcGMNCj4gICBzb2M6IG1lZGlhdGVrOiBhZGQg
bXQ2Nzc5IGRldmFwYyBkcml2ZXINCj4gDQo+ICAuLi4vYmluZGluZ3Mvc29jL21lZGlhdGVrL2Rl
dmFwYy55YW1sICAgICAgICAgfCAgNTggKysrKw0KPiAgZHJpdmVycy9zb2MvbWVkaWF0ZWsvS2Nv
bmZpZyAgICAgICAgICAgICAgICAgIHwgICA5ICsNCj4gIGRyaXZlcnMvc29jL21lZGlhdGVrL01h
a2VmaWxlICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ICBkcml2ZXJzL3NvYy9tZWRpYXRlay9t
dGstZGV2YXBjLmMgICAgICAgICAgICAgfCAzMDggKysrKysrKysrKysrKysrKysrDQo+ICA0IGZp
bGVzIGNoYW5nZWQsIDM3NiBpbnNlcnRpb25zKCspDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9tZWRpYXRlay9kZXZhcGMueWFtbA0K
PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1kZXZhcGMuYw0K
PiANCg0K

