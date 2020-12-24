Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5429C2E252E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 08:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgLXHS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 02:18:58 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:50126 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725747AbgLXHS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 02:18:58 -0500
X-UUID: 86225fd0b8ff45e895aa11c0222e15b0-20201224
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Mi1mCEIU36uks+SRhET60de/V1o2twi7lWkb9sYvoBw=;
        b=iDTOVMqKRYY/QWsaOR1sFS6/usBvO4fgE6j32WA9Aco9nbP14tgDYOtL6JeH8RJOy20K9B7tQu3LsV9regVhqopOv6PZEGNElhialrNV+q5g9BIXDPem32YIR/zzEvNaD/OEFM0UhctMSbivsfAYdP/vUOyvjGo1Mb278ekw94o=;
X-UUID: 86225fd0b8ff45e895aa11c0222e15b0-20201224
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1350213302; Thu, 24 Dec 2020 15:18:07 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32DR.mediatek.inc
 (172.27.6.104) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 24 Dec
 2020 15:18:05 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 24 Dec 2020 15:18:04 +0800
Message-ID: <1608794285.23328.79.camel@mhfsdcap03>
Subject: Re: [PATCH 2/3] usb: xhci-mtk: fix UAS issue by XHCI_BROKEN_STREAMS
 quirk
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Rosen Penev <rosenp@gmail.com>
CC:     Nicolas Boichat <drinkcat@chromium.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Date:   Thu, 24 Dec 2020 15:18:05 +0800
In-Reply-To: <CAKxU2N8q1XjDbWbv5ksqYr7RMEedV7fng7OUccVggsT89Oyf5w@mail.gmail.com>
References: <20201216115125.5886-1-chunfeng.yun@mediatek.com>
         <20201216115125.5886-2-chunfeng.yun@mediatek.com>
         <CANMq1KDBmuoBNeizm9+f1yJgqF9oMqU5k26KfZrSdjrPQm_LwA@mail.gmail.com>
         <1608171557.23328.53.camel@mhfsdcap03>
         <CAKxU2N8q1XjDbWbv5ksqYr7RMEedV7fng7OUccVggsT89Oyf5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 789013F5892AA70359C8E0AD768F3F63F5C84F45D63E14F2459F4B4C630AC0A42000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTEyLTE2IGF0IDE5OjQzIC0wODAwLCBSb3NlbiBQZW5ldiB3cm90ZToNCj4g
T24gV2VkLCBEZWMgMTYsIDIwMjAgYXQgNjoyOSBQTSBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1
bkBtZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+DQo+ID4gT24gV2VkLCAyMDIwLTEyLTE2IGF0IDIw
OjI4ICswODAwLCBOaWNvbGFzIEJvaWNoYXQgd3JvdGU6DQo+ID4gPiBPbiBXZWQsIERlYyAxNiwg
MjAyMCBhdCA3OjUzIFBNIENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4g
d3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+IFRoZSAwLjk2IHhIQ0kgY29udHJvbGxlciBvbiBzb21l
IHBsYXRmb3JtcyBkb2VzIG5vdCBzdXBwb3J0DQo+ID4gPiA+IGJ1bGsgc3RyZWFtIGV2ZW4gSEND
UEFSQU1TIHNheXMgc3VwcG9ydGluZywgZHVlIHRvIE1heFBTQVNpemUNCj4gPiA+ID4gaXMgc2V0
IGEgbm9uLXplcm8gZGVmYXVsdCB2YWx1ZSBieSBtaXN0YWtlLCBoZXJlIHVzZQ0KPiA+ID4gPiBY
SENJX0JST0tFTl9TVFJFQU1TIHF1aXJrIHRvIGZpeCBpdC4NCj4gPiA+ID4NCj4gPiA+ID4gRml4
ZXM6IDk0YTYzMWQ5MWFkMyAoInVzYjogeGhjaS1tdGs6IGNoZWNrIGhjY19wYXJhbXMgYWZ0ZXIg
YWRkaW5nIHByaW1hcnkgaGNkIikNCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVu
IDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIGRyaXZl
cnMvdXNiL2hvc3QveGhjaS1tdGsuYyB8IDcgKysrKysrLQ0KPiA+ID4gPiAgZHJpdmVycy91c2Iv
aG9zdC94aGNpLW10ay5oIHwgMSArDQo+ID4gPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy91c2IvaG9zdC94aGNpLW10ay5jIGIvZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay5jDQo+
ID4gPiA+IGluZGV4IDhmMzIxZjM5YWI5Ni4uMDhkYWI5NzRkODQ3IDEwMDY0NA0KPiA+ID4gPiAt
LS0gYS9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy91
c2IvaG9zdC94aGNpLW10ay5jDQo+ID4gPiA+IEBAIC0zOTUsNiArMzk1LDkgQEAgc3RhdGljIHZv
aWQgeGhjaV9tdGtfcXVpcmtzKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IHhoY2lfaGNkICp4
aGNpKQ0KPiA+ID4gPiAgICAgICAgIHhoY2ktPnF1aXJrcyB8PSBYSENJX1NQVVJJT1VTX1NVQ0NF
U1M7DQo+ID4gPiA+ICAgICAgICAgaWYgKG10ay0+bHBtX3N1cHBvcnQpDQo+ID4gPiA+ICAgICAg
ICAgICAgICAgICB4aGNpLT5xdWlya3MgfD0gWEhDSV9MUE1fU1VQUE9SVDsNCj4gPiA+ID4gKw0K
PiA+ID4gPiArICAgICAgIGlmIChtdGstPmJyb2tlbl9zdHJlYW1zKQ0KPiA+ID4gPiArICAgICAg
ICAgICAgICAgeGhjaS0+cXVpcmtzIHw9IFhIQ0lfQlJPS0VOX1NUUkVBTVM7DQo+ID4gPiA+ICB9
DQo+ID4gPiA+DQo+ID4gPiA+ICAvKiBjYWxsZWQgZHVyaW5nIHByb2JlKCkgYWZ0ZXIgY2hpcCBy
ZXNldCBjb21wbGV0ZXMgKi8NCj4gPiA+ID4gQEAgLTQ2MCw2ICs0NjMsOCBAQCBzdGF0aWMgaW50
IHhoY2lfbXRrX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gPiA+ICAg
ICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+ID4gPg0KPiA+ID4gPiAgICAgICAgIG10ay0+
bHBtX3N1cHBvcnQgPSBvZl9wcm9wZXJ0eV9yZWFkX2Jvb2wobm9kZSwgInVzYjMtbHBtLWNhcGFi
bGUiKTsNCj4gPiA+ID4gKyAgICAgICBtdGstPmJyb2tlbl9zdHJlYW1zID0NCj4gPiA+ID4gKyAg
ICAgICAgICAgICAgIG9mX3Byb3BlcnR5X3JlYWRfYm9vbChub2RlLCAibWVkaWF0ZWssYnJva2Vu
X3N0cmVhbXNfcXVpcmsiKTsNCj4gPiA+DQo+ID4gPiBXb3VsZCBpdCBiZSBiZXR0ZXIgdG8gYWRk
IGEgZGF0YSBmaWVsZCB0byBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkDQo+ID4gPiBtdGtfeGhjaV9vZl9t
YXRjaCwgYW5kIGVuYWJsZSB0aGlzIHF1aXJrIG9uIG1lZGlhdGVrLG10ODE3My14aGNpIG9ubHk/
DQo+ID4gVGhpcyBpcyB0aGUgY29tbW9uIGlzc3VlIGZvciBhbGwgU29DcyAoYmVmb3JlIDIwMTYu
MDYpIHdpdGggMC45NiB4SENJDQo+ID4gd2hlbiB0aGUgY29udHJvbGxlciBkb24ndCBzdXBwb3J0
IGJ1bGsgc3RyZWFtLiBJZiBlbmFibGUgdGhpcyBxdWlyayBvbmx5DQo+ID4gZm9yIG10ODE3Mywg
dGhlbiBmb3Igb3RoZXIgU29DcywgdGhlIGNvbXBhdGlibGUgbmVlZCBpbmNsdWRlDQo+ID4gIm1l
ZGlhdGVrLG10ODE3My14aGNpIiBpbiBkdHMsIHRoaXMgbWF5IGJlIG5vdCBmbGV4aWJsZSBmb3Ig
c29tZSBjYXNlcywNCj4gPiBlLmcuIGEgbmV3IFNvQyBoYXMgdGhlIGJyb2tlbiBzdHJlYW0gYXMg
bXQ4MTczLCBidXQgYWxzbyBoYXMgYW5vdGhlcg0KPiA+IGRpZmZlcmVudCBxdWlyaywgdGhlIHdh
eSB5b3Ugc3VnZ2VzdGVkIHdpbGwgbm90IGhhbmRsZSBpdC4NCj4gPiBBbmQgSSBwbGFuIHRvIHJl
bW92ZSAibWVkaWF0ZWssbXQ4MTczLXhoY2kiIGluIG10a194aGNpX29mX21hdGNoIGFmdGVyDQo+
ID4gY29udmVydGluZyB0aGUgYmluZGluZyB0byBZTUFMLg0KPiBJJ20gZ3Vlc3NpbmcgdGhpcyBh
bHNvIGFwcGxpZXMgdG8gbXQ3NjIxPw0KWWVzLCBtdDc2MjEgZG9lc24ndCBzdXBwb3J0IGJ1bGsg
c3RyZWFtDQoNCj4gPg0KPiA+ID4NCj4gPiA+IChJTUhPIHVzYjMtbHBtLWNhcGFibGUgZGV0ZWN0
aW9uIHNob3VsZCBhbHNvIGJlIGRvbmUgaW4gdGhlIHNhbWUgd2F5KQ0KPiA+IEkgcHJlZmVyIHRv
IHByb3ZpZGUgYSBwcm9wZXJ0eSBmb3IgY29tbW9uIGlzc3VlcywgYW5kIHVzZSB0aGUgd2F5IHlv
dQ0KPiA+IHN1Z2dlc3RlZCBmb3IgdGhlIGlzc3VlIG9ubHkgaGFwcGVuZWQgYXQgYSBzcGVjaWZp
YyBTb0MuDQo+ID4NCj4gPiBUaGFuayB5b3UNCj4gPg0KPiA+ID4NCj4gPiA+IFRoYW5rcywNCj4g
PiA+DQo+ID4gPiA+ICAgICAgICAgLyogb3B0aW9uYWwgcHJvcGVydHksIGlnbm9yZSB0aGUgZXJy
b3IgaWYgaXQgZG9lcyBub3QgZXhpc3QgKi8NCj4gPiA+ID4gICAgICAgICBvZl9wcm9wZXJ0eV9y
ZWFkX3UzMihub2RlLCAibWVkaWF0ZWssdTNwLWRpcy1tc2siLA0KPiA+ID4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICZtdGstPnUzcF9kaXNfbXNrKTsNCj4gPiA+ID4gQEAgLTU0Niw3
ICs1NTEsNyBAQCBzdGF0aWMgaW50IHhoY2lfbXRrX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgKnBkZXYpDQo+ID4gPiA+ICAgICAgICAgaWYgKHJldCkNCj4gPiA+ID4gICAgICAgICAgICAg
ICAgIGdvdG8gcHV0X3VzYjNfaGNkOw0KPiA+ID4gPg0KPiA+ID4gPiAtICAgICAgIGlmIChIQ0Nf
TUFYX1BTQSh4aGNpLT5oY2NfcGFyYW1zKSA+PSA0KQ0KPiA+ID4gPiArICAgICAgIGlmICghbXRr
LT5icm9rZW5fc3RyZWFtcyAmJiBIQ0NfTUFYX1BTQSh4aGNpLT5oY2NfcGFyYW1zKSA+PSA0KQ0K
PiA+ID4gPiAgICAgICAgICAgICAgICAgeGhjaS0+c2hhcmVkX2hjZC0+Y2FuX2RvX3N0cmVhbXMg
PSAxOw0KPiA+ID4gPg0KPiA+ID4gPiAgICAgICAgIHJldCA9IHVzYl9hZGRfaGNkKHhoY2ktPnNo
YXJlZF9oY2QsIGlycSwgSVJRRl9TSEFSRUQpOw0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy91c2IvaG9zdC94aGNpLW10ay5oIGIvZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay5oDQo+ID4g
PiA+IGluZGV4IGE5M2NmZTgxNzkwNC4uODZhYTQ5Nzg5MTVlIDEwMDY0NA0KPiA+ID4gPiAtLS0g
YS9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLmgNCj4gPiA+ID4gKysrIGIvZHJpdmVycy91c2Iv
aG9zdC94aGNpLW10ay5oDQo+ID4gPiA+IEBAIC0xNDcsNiArMTQ3LDcgQEAgc3RydWN0IHhoY2lf
aGNkX210ayB7DQo+ID4gPiA+ICAgICAgICAgc3RydWN0IHBoeSAqKnBoeXM7DQo+ID4gPiA+ICAg
ICAgICAgaW50IG51bV9waHlzOw0KPiA+ID4gPiAgICAgICAgIGJvb2wgbHBtX3N1cHBvcnQ7DQo+
ID4gPiA+ICsgICAgICAgYm9vbCBicm9rZW5fc3RyZWFtczsNCj4gPiA+ID4gICAgICAgICAvKiB1
c2IgcmVtb3RlIHdha2V1cCAqLw0KPiA+ID4gPiAgICAgICAgIGJvb2wgdXdrX2VuOw0KPiA+ID4g
PiAgICAgICAgIHN0cnVjdCByZWdtYXAgKnV3azsNCj4gPiA+ID4gLS0NCj4gPiA+ID4gMi4xOC4w
DQo+ID4NCj4gPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xw0KPiA+IGxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0DQo+ID4gbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+ID4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsDQoNCg==

