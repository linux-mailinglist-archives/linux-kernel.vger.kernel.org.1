Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF0552DCC71
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 07:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgLQGYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 01:24:50 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:4571 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725930AbgLQGYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 01:24:46 -0500
X-UUID: d2d0cc4550d947f9800f232a8071bc2e-20201217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=RV8fWtJixVJsdBrLusXjxNOKP7+KPKBTMLVxNEwmSh4=;
        b=j0xQzTCC89Kq8wj2X7iVl9V6/o5AR8PwmGY7jE2ZpEre1l9crgwnXTxYDWhEHvCZBaCvtlcj67EPD+6fmAeYpHRE1YdtGQIgvBpyg7AbGv3Ck35OTExSLmAj+6sNrZf7wmDqvoiAd/wABPg5+Kh+tU87c7kKkVhnclLjDFw+bTs=;
X-UUID: d2d0cc4550d947f9800f232a8071bc2e-20201217
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2108793375; Thu, 17 Dec 2020 14:23:54 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32N2.mediatek.inc
 (172.27.4.72) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 17 Dec
 2020 14:23:50 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Dec 2020 14:23:50 +0800
Message-ID: <1608186230.23328.78.camel@mhfsdcap03>
Subject: Re: [PATCH 2/3] usb: xhci-mtk: fix UAS issue by XHCI_BROKEN_STREAMS
 quirk
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "Hsin-Yi Wang" <hsinyi@chromium.org>,
        Ikjoon Jang <ikjn@chromium.org>
Date:   Thu, 17 Dec 2020 14:23:50 +0800
In-Reply-To: <CANMq1KA4L4PPRgHTmeisfSWu4qgjgNVFZRvxeuAOyq2_TimELA@mail.gmail.com>
References: <20201216115125.5886-1-chunfeng.yun@mediatek.com>
         <20201216115125.5886-2-chunfeng.yun@mediatek.com>
         <CANMq1KDBmuoBNeizm9+f1yJgqF9oMqU5k26KfZrSdjrPQm_LwA@mail.gmail.com>
         <1608171557.23328.53.camel@mhfsdcap03>
         <CANMq1KA4L4PPRgHTmeisfSWu4qgjgNVFZRvxeuAOyq2_TimELA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: ED6A86936AB121403639494CDB402CE4A1CF19B2194A5888403A55922E4C5A1A2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTEyLTE3IGF0IDExOjMyICswODAwLCBOaWNvbGFzIEJvaWNoYXQgd3JvdGU6
DQo+IE9uIFRodSwgRGVjIDE3LCAyMDIwIGF0IDEwOjE5IEFNIENodW5mZW5nIFl1biA8Y2h1bmZl
bmcueXVuQG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBPbiBXZWQsIDIwMjAtMTItMTYg
YXQgMjA6MjggKzA4MDAsIE5pY29sYXMgQm9pY2hhdCB3cm90ZToNCj4gPiA+IE9uIFdlZCwgRGVj
IDE2LCAyMDIwIGF0IDc6NTMgUE0gQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsu
Y29tPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gVGhlIDAuOTYgeEhDSSBjb250cm9sbGVyIG9u
IHNvbWUgcGxhdGZvcm1zIGRvZXMgbm90IHN1cHBvcnQNCj4gPiA+ID4gYnVsayBzdHJlYW0gZXZl
biBIQ0NQQVJBTVMgc2F5cyBzdXBwb3J0aW5nLCBkdWUgdG8gTWF4UFNBU2l6ZQ0KPiA+ID4gPiBp
cyBzZXQgYSBub24temVybyBkZWZhdWx0IHZhbHVlIGJ5IG1pc3Rha2UsIGhlcmUgdXNlDQo+ID4g
PiA+IFhIQ0lfQlJPS0VOX1NUUkVBTVMgcXVpcmsgdG8gZml4IGl0Lg0KPiA+ID4gPg0KPiA+ID4g
PiBGaXhlczogOTRhNjMxZDkxYWQzICgidXNiOiB4aGNpLW10azogY2hlY2sgaGNjX3BhcmFtcyBh
ZnRlciBhZGRpbmcgcHJpbWFyeSBoY2QiKQ0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBDaHVuZmVu
ZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAg
ZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay5jIHwgNyArKysrKystDQo+ID4gPiA+ICBkcml2ZXJz
L3VzYi9ob3N0L3hoY2ktbXRrLmggfCAxICsNCj4gPiA+ID4gIDIgZmlsZXMgY2hhbmdlZCwgNyBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLmMgYi9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRr
LmMNCj4gPiA+ID4gaW5kZXggOGYzMjFmMzlhYjk2Li4wOGRhYjk3NGQ4NDcgMTAwNjQ0DQo+ID4g
PiA+IC0tLSBhL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1tdGsuYw0KPiA+ID4gPiArKysgYi9kcml2
ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLmMNCj4gPiA+ID4gQEAgLTM5NSw2ICszOTUsOSBAQCBzdGF0
aWMgdm9pZCB4aGNpX210a19xdWlya3Moc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgeGhjaV9o
Y2QgKnhoY2kpDQo+ID4gPiA+ICAgICAgICAgeGhjaS0+cXVpcmtzIHw9IFhIQ0lfU1BVUklPVVNf
U1VDQ0VTUzsNCj4gPiA+ID4gICAgICAgICBpZiAobXRrLT5scG1fc3VwcG9ydCkNCj4gPiA+ID4g
ICAgICAgICAgICAgICAgIHhoY2ktPnF1aXJrcyB8PSBYSENJX0xQTV9TVVBQT1JUOw0KPiA+ID4g
PiArDQo+ID4gPiA+ICsgICAgICAgaWYgKG10ay0+YnJva2VuX3N0cmVhbXMpDQo+ID4gPiA+ICsg
ICAgICAgICAgICAgICB4aGNpLT5xdWlya3MgfD0gWEhDSV9CUk9LRU5fU1RSRUFNUzsNCj4gPiA+
ID4gIH0NCj4gPiA+ID4NCj4gPiA+ID4gIC8qIGNhbGxlZCBkdXJpbmcgcHJvYmUoKSBhZnRlciBj
aGlwIHJlc2V0IGNvbXBsZXRlcyAqLw0KPiA+ID4gPiBAQCAtNDYwLDYgKzQ2Myw4IEBAIHN0YXRp
YyBpbnQgeGhjaV9tdGtfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiA+
ID4gICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gPiA+DQo+ID4gPiA+ICAgICAgICAg
bXRrLT5scG1fc3VwcG9ydCA9IG9mX3Byb3BlcnR5X3JlYWRfYm9vbChub2RlLCAidXNiMy1scG0t
Y2FwYWJsZSIpOw0KPiA+ID4gPiArICAgICAgIG10ay0+YnJva2VuX3N0cmVhbXMgPQ0KPiA+ID4g
PiArICAgICAgICAgICAgICAgb2ZfcHJvcGVydHlfcmVhZF9ib29sKG5vZGUsICJtZWRpYXRlayxi
cm9rZW5fc3RyZWFtc19xdWlyayIpOw0KPiA+ID4NCj4gPiA+IFdvdWxkIGl0IGJlIGJldHRlciB0
byBhZGQgYSBkYXRhIGZpZWxkIHRvIHN0cnVjdCBvZl9kZXZpY2VfaWQNCj4gPiA+IG10a194aGNp
X29mX21hdGNoLCBhbmQgZW5hYmxlIHRoaXMgcXVpcmsgb24gbWVkaWF0ZWssbXQ4MTczLXhoY2kg
b25seT8NCj4gPiBUaGlzIGlzIHRoZSBjb21tb24gaXNzdWUgZm9yIGFsbCBTb0NzIChiZWZvcmUg
MjAxNi4wNikgd2l0aCAwLjk2IHhIQ0kNCj4gPiB3aGVuIHRoZSBjb250cm9sbGVyIGRvbid0IHN1
cHBvcnQgYnVsayBzdHJlYW0uIElmIGVuYWJsZSB0aGlzIHF1aXJrIG9ubHkNCj4gPiBmb3IgbXQ4
MTczLCB0aGVuIGZvciBvdGhlciBTb0NzLCB0aGUgY29tcGF0aWJsZSBuZWVkIGluY2x1ZGUNCj4g
PiAibWVkaWF0ZWssbXQ4MTczLXhoY2kiIGluIGR0cywgdGhpcyBtYXkgYmUgbm90IGZsZXhpYmxl
IGZvciBzb21lIGNhc2VzLA0KPiA+IGUuZy4gYSBuZXcgU29DIGhhcyB0aGUgYnJva2VuIHN0cmVh
bSBhcyBtdDgxNzMsIGJ1dCBhbHNvIGhhcyBhbm90aGVyDQo+ID4gZGlmZmVyZW50IHF1aXJrLCB0
aGUgd2F5IHlvdSBzdWdnZXN0ZWQgd2lsbCBub3QgaGFuZGxlIGl0Lg0KPiANCj4gSXQgY2FuLCB3
ZSBkbyB0aGlzIHJlZ3VsYXJseSBmb3IgbWFueSBvdGhlciBjb21wb25lbnRzLiBPbmUgZXhhbXBs
ZToNCj4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvbGF0ZXN0L3NvdXJjZS9kcml2
ZXJzL2kyYy9idXNzZXMvaTJjLW10NjV4eC5jI0w0MDINCj4gDQpHb3QgaXQuIEluZGVlZCB3b3Jr
cyB3aGVuIGFkZCBjb21wYXRpYmxlIHByaXZhdGUgZGF0YS4NCg0KRHVlIHRvIG1hbnkgU29DcyBz
dXBwb3J0cyBVU0IgYW5kIG5vdCB1cHN0cmVhbSwgSSdkIHByZWZlciB0byBhdm9pZA0KYWRkaW5n
IG5ldyBjb21wYXRpYmxlIGluIGRyaXZlciB3aGVuIHN1cHBvcnQgbmV3IFNvQ3MsIGFuZCBsZWF2
ZSB0aGUNCmNvZGUgYXMgc2ltcGxlIGFzIHBvc3NpYmxlLg0KDQo+ID4gQW5kIEkgcGxhbiB0byBy
ZW1vdmUgIm1lZGlhdGVrLG10ODE3My14aGNpIiBpbiBtdGtfeGhjaV9vZl9tYXRjaCBhZnRlcg0K
PiA+IGNvbnZlcnRpbmcgdGhlIGJpbmRpbmcgdG8gWU1BTC4NCj4gPg0KPiA+ID4NCj4gPiA+IChJ
TUhPIHVzYjMtbHBtLWNhcGFibGUgZGV0ZWN0aW9uIHNob3VsZCBhbHNvIGJlIGRvbmUgaW4gdGhl
IHNhbWUgd2F5KQ0KPiA+IEkgcHJlZmVyIHRvIHByb3ZpZGUgYSBwcm9wZXJ0eSBmb3IgY29tbW9u
IGlzc3VlcywgYW5kIHVzZSB0aGUgd2F5IHlvdQ0KPiA+IHN1Z2dlc3RlZCBmb3IgdGhlIGlzc3Vl
IG9ubHkgaGFwcGVuZWQgYXQgYSBzcGVjaWZpYyBTb0MuDQo+IA0KPiBVbmRlcnN0YW5kLCBpdCdz
IGp1c3QgZGlmZmVyZW50IGFwcHJvYWNoZXMsIA0KWWVzDQoNCj4gdGhlcmUgc2VlbXMgdG8gYmUN
Cj4gcHJlY2VkZW50IChhdCBsZWFzdCBpbiB0aGlzIGRyaXZlci9iaW5kaW5nKSBmb3IgdXNpbmcg
cHJvcGVydGllcywgc28NCj4gSSdsbCBsZXQgdGhlIFVTQiBtYWludGFpbmVycyBzcGVhayB1cCAs
LSkNCj4gDQo+ID4NCj4gPiBUaGFuayB5b3UNCj4gPg0KPiA+ID4NCj4gPiA+IFRoYW5rcywNCj4g
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
DQo+ID4NCg0K

