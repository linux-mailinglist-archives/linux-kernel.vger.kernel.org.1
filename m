Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B90C22BA567
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 10:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbgKTJC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 04:02:27 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:11990 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726335AbgKTJC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:02:26 -0500
X-UUID: a13e9e7876b24e11b8b92e7003cf77cd-20201120
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=NOnBEeD5QcqRy5ACxANNtYY5eIEEbKNWhHFCVwRq7Bk=;
        b=DwfGG6wPx8bwL1YuhPBQqay0GjEFZHN+7ZklUtK4gmQpzaPr/NDBddmO2BU28NP5qJQfzbDbLIVuq5U1cuKBqwtmkVYH+wPJCNIGgrOa7qBQ1ACmWXmMOP6J+eSscooV+ERUSIlPtefL/KwuPyOL7CLQnClG9kSBbCNW7sh9+Yk=;
X-UUID: a13e9e7876b24e11b8b92e7003cf77cd-20201120
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <min.guo@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1925620927; Fri, 20 Nov 2020 17:02:17 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 20 Nov
 2020 17:02:16 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 20 Nov 2020 17:02:15 +0800
Message-ID: <1605862935.3995.20.camel@mhfsdcap03>
Subject: Re: [PATCH] usb: musb: remove unused variable 'devctl'
From:   Min Guo <min.guo@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Bin Liu <b-liu@ti.com>, Matthias Brugger <matthias.bgg@gmail.com>,
        <chunfeng.yun@mediatek.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Fri, 20 Nov 2020 17:02:15 +0800
In-Reply-To: <X7eAEaTN/fM3fkkp@kroah.com>
References: <20201117082125.7619-1-min.guo@mediatek.com>
         <X7UKJtWtE0UZgqAQ@kroah.com> <1605854930.3995.8.camel@mhfsdcap03>
         <X7doKlP1k824LGGN@kroah.com> <1605858126.3995.14.camel@mhfsdcap03>
         <X7eAEaTN/fM3fkkp@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: F523D46BD23D8F2D4C4167306D0A9C11AFC2932A6549B7623E792AD4C4C739792000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTExLTIwIGF0IDA5OjM2ICswMTAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3Jv
dGU6DQo+IE9uIEZyaSwgTm92IDIwLCAyMDIwIGF0IDAzOjQyOjA2UE0gKzA4MDAsIE1pbiBHdW8g
d3JvdGU6DQo+ID4gT24gRnJpLCAyMDIwLTExLTIwIGF0IDA3OjU0ICswMTAwLCBHcmVnIEtyb2Fo
LUhhcnRtYW4gd3JvdGU6DQo+ID4gPiBPbiBGcmksIE5vdiAyMCwgMjAyMCBhdCAwMjo0ODo1MFBN
ICswODAwLCBNaW4gR3VvIHdyb3RlOg0KPiA+ID4gPiBIaSBncmVnIGstaDoNCj4gPiA+ID4gT24g
V2VkLCAyMDIwLTExLTE4IGF0IDEyOjQ4ICswMTAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3JvdGU6
DQo+ID4gPiA+ID4gT24gVHVlLCBOb3YgMTcsIDIwMjAgYXQgMDQ6MjE6MjVQTSArMDgwMCwgbWlu
Lmd1b0BtZWRpYXRlay5jb20gd3JvdGU6DQo+ID4gPiA+ID4gPiBGcm9tOiBNaW4gR3VvIDxtaW4u
Z3VvQG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gUmVtb3ZlIHVudXNl
ZCAnZGV2Y3RsJyB2YXJpYWJsZSB0byBmaXggY29tcGlsZSB3YXJuaW5nczoNCj4gPiA+ID4gPiA+
IA0KPiA+ID4gPiA+ID4gICAgIGRyaXZlcnMvdXNiL211c2IvbXVzYmhzZG1hLmM6IEluIGZ1bmN0
aW9uICdkbWFfY29udHJvbGxlcl9pcnEnOg0KPiA+ID4gPiA+ID4gICAgIGRyaXZlcnMvdXNiL211
c2IvbXVzYmhzZG1hLmM6MzI0Ojg6IHdhcm5pbmc6IHZhcmlhYmxlICdkZXZjdGwnIHNldA0KPiA+
ID4gPiA+ID4gICAgIGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtYnV0LXNldC12YXJpYWJsZV0NCj4g
PiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogTWluIEd1byA8bWluLmd1b0Bt
ZWRpYXRlay5jb20+DQo+ID4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiA+ICBkcml2ZXJzL3VzYi9t
dXNiL211c2Joc2RtYS5jIHwgNCAtLS0tDQo+ID4gPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDQg
ZGVsZXRpb25zKC0pDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3VzYi9tdXNiL211c2Joc2RtYS5jIGIvZHJpdmVycy91c2IvbXVzYi9tdXNiaHNkbWEuYw0K
PiA+ID4gPiA+ID4gaW5kZXggMGFhY2ZjOGJlNWExLi43YWNkMTYzNTg1MGQgMTAwNjQ0DQo+ID4g
PiA+ID4gPiAtLS0gYS9kcml2ZXJzL3VzYi9tdXNiL211c2Joc2RtYS5jDQo+ID4gPiA+ID4gPiAr
KysgYi9kcml2ZXJzL3VzYi9tdXNiL211c2Joc2RtYS5jDQo+ID4gPiA+ID4gPiBAQCAtMzIxLDgg
KzMyMSw2IEBAIGlycXJldHVybl90IGRtYV9jb250cm9sbGVyX2lycShpbnQgaXJxLCB2b2lkICpw
cml2YXRlX2RhdGEpDQo+ID4gPiA+ID4gPiAgCQkJCW11c2JfY2hhbm5lbC0+Y2hhbm5lbC5zdGF0
dXMgPQ0KPiA+ID4gPiA+ID4gIAkJCQkJTVVTQl9ETUFfU1RBVFVTX0JVU19BQk9SVDsNCj4gPiA+
ID4gPiA+ICAJCQl9IGVsc2Ugew0KPiA+ID4gPiA+ID4gLQkJCQl1OCBkZXZjdGw7DQo+ID4gPiA+
ID4gPiAtDQo+ID4gPiA+ID4gPiAgCQkJCWFkZHIgPSBtdXNiX3JlYWRfaHNkbWFfYWRkcihtYmFz
ZSwNCj4gPiA+ID4gPiA+ICAJCQkJCQliY2hhbm5lbCk7DQo+ID4gPiA+ID4gPiAgCQkJCWNoYW5u
ZWwtPmFjdHVhbF9sZW4gPSBhZGRyDQo+ID4gPiA+ID4gPiBAQCAtMzM2LDggKzMzNCw2IEBAIGly
cXJldHVybl90IGRtYV9jb250cm9sbGVyX2lycShpbnQgaXJxLCB2b2lkICpwcml2YXRlX2RhdGEp
DQo+ID4gPiA+ID4gPiAgCQkJCQkJPCBtdXNiX2NoYW5uZWwtPmxlbikgPw0KPiA+ID4gPiA+ID4g
IAkJCQkJIj0+IHJlY29uZmlnIDAiIDogIj0+IGNvbXBsZXRlIik7DQo+ID4gPiA+ID4gPiAgDQo+
ID4gPiA+ID4gPiAtCQkJCWRldmN0bCA9IG11c2JfcmVhZGIobWJhc2UsIE1VU0JfREVWQ1RMKTsN
Cj4gPiA+ID4gPiANCj4gPiA+ID4gPiBBcmUgeW91IHN1cmUgdGhhdCB0aGUgaGFyZHdhcmUgZG9l
cyBub3QgcmVxdWlyZSB0aGlzIHJlYWQgdG8gY29tcGxldGUNCj4gPiA+ID4gPiB0aGUgY29tbWFu
ZD8gIExvdHMgb2YgaGFyZHdhcmUgaXMgdGhhdCB3YXksIHNvIGJlIHZlcnkgY2FyZWZ1bCBhYm91
dA0KPiA+ID4gPiA+IHRoaXMuICBEaWQgeW91IHRlc3QgaXQ/DQo+ID4gPiA+IA0KPiA+ID4gPiBJ
IGhhdmUgdGVzdGVkIHRoaXMgcGF0Y2ggb24gTWVkaWF0ZWsncyBwbGF0Zm9ybSwgYW5kIG5vdCBz
dXJlIGlmIGl0DQo+ID4gPiA+IHdpbGwgYWZmZWN0IG90aGVyIHZlbmRvcnMnIHBsYXRmb3Jtcy4N
Cj4gPiA+ID4gDQo+ID4gPiA+IERlYXIgQmluOg0KPiA+ID4gPiANCj4gPiA+ID4gRG9lcyB0aGlz
IHBhdGNoIHdpbGwgYWZmZWN0IG90aGVyIHZlbmRvcnMnIHBsYXRmb3Jtcz8NCj4gPiA+IA0KPiA+
ID4gVGhlIGhhcmR3YXJlIHNwZWNzIHdpbGwgYW5zd2VyIHRoaXMgcXVlc3Rpb24sIHdoYXQgZG8g
dGhleSBzYXkgYWJvdXQNCj4gPiA+IHRoaXMgcmVhZD8NCj4gPiANCj4gPiBTb3JyeSwgSSBkaWRu
J3Qgc2VlbiB0aGUgY29tbWVudCBvbiB0aGUgaGFyZHdhcmUgc3BlY3MgaW5kaWNhdGUgdGhhdA0K
PiA+IGRldmN0bCByZWdpc3RlciBuZWVkcyB0byByZWFkIG9uY2UgdG8gdGFrZSBlZmZlY3QuDQo+
IA0KPiBQZXJoYXBzIHlvdSBtaWdodCB3YW50IHRvIGFkZCBhIGNvbW1lbnQgaGVyZSBzbyB0aGF0
IHBlb3BsZSB3aWxsIG5vdA0KPiBrZWVwIG1ha2luZyB0aGlzIHNhbWUgbWlzdGFrZSB3aGVuIHRo
ZXkgcnVuIGF1dG8tY2hlY2tlcnMgb24gdGhlDQo+IGNvZGViYXNlPw0KDQpTb3JyeSBmb3IgY29u
ZnVzZWQgeW91LCBJIHNlYXJjaGVkIHRoZSBoYXJkd2FyZSBzcGVjcywgYnV0IGRpZCBub3QgZmlu
ZA0KdGhlIHNwZWNpYWwgZGVzY3JpcHRpb24gb2YgdGhlIHJlZ2lzdGVyIGRldmN0bCBpbmRpY2F0
aW5nIHRoYXQgaXQgbmVlZHMNCnRvIGJlIHJlYWQgb3V0IGJlZm9yZSB0aGUgaGFyZHdhcmUgY2Fu
IHdvcmsuDQoNCj4gdGhhbmtzLA0KPiANCj4gZ3JlZyBrLWgNCg0K

