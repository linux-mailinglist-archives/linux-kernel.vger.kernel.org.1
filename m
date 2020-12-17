Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA612DCAF4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 03:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgLQCUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 21:20:07 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:59744 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727073AbgLQCUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 21:20:06 -0500
X-UUID: ae4cb2eca6254e18a282764eb0c1842c-20201217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=sI/OBSMnUSmpUsrYV0tpYoTI7F39Re/i+rNgT7WIngc=;
        b=KvXv+jrGv++0o+9mtQVHiyMojFDniM0TS4QEOs08nbkuzeZod0pnqf+JnxkuouutsnNiTqqo5iW0Av6kzSzAf6G8JH93K631daLT+3v3Jc3bUtQCJAagPh5l9/SXH1dfQLvOESh1zWGaAPAcQlxeCBX92SYwxCWkeVQmIhTu5yc=;
X-UUID: ae4cb2eca6254e18a282764eb0c1842c-20201217
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1740282575; Thu, 17 Dec 2020 10:19:18 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 17 Dec
 2020 10:19:14 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Dec 2020 10:19:16 +0800
Message-ID: <1608171557.23328.53.camel@mhfsdcap03>
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
Date:   Thu, 17 Dec 2020 10:19:17 +0800
In-Reply-To: <CANMq1KDBmuoBNeizm9+f1yJgqF9oMqU5k26KfZrSdjrPQm_LwA@mail.gmail.com>
References: <20201216115125.5886-1-chunfeng.yun@mediatek.com>
         <20201216115125.5886-2-chunfeng.yun@mediatek.com>
         <CANMq1KDBmuoBNeizm9+f1yJgqF9oMqU5k26KfZrSdjrPQm_LwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 258AB31D0E0EDB8FD5AE2C67A085C1DEC82486880D7B9BDEC48198D85D9153E92000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTEyLTE2IGF0IDIwOjI4ICswODAwLCBOaWNvbGFzIEJvaWNoYXQgd3JvdGU6
DQo+IE9uIFdlZCwgRGVjIDE2LCAyMDIwIGF0IDc6NTMgUE0gQ2h1bmZlbmcgWXVuIDxjaHVuZmVu
Zy55dW5AbWVkaWF0ZWsuY29tPiB3cm90ZToNCj4gPg0KPiA+IFRoZSAwLjk2IHhIQ0kgY29udHJv
bGxlciBvbiBzb21lIHBsYXRmb3JtcyBkb2VzIG5vdCBzdXBwb3J0DQo+ID4gYnVsayBzdHJlYW0g
ZXZlbiBIQ0NQQVJBTVMgc2F5cyBzdXBwb3J0aW5nLCBkdWUgdG8gTWF4UFNBU2l6ZQ0KPiA+IGlz
IHNldCBhIG5vbi16ZXJvIGRlZmF1bHQgdmFsdWUgYnkgbWlzdGFrZSwgaGVyZSB1c2UNCj4gPiBY
SENJX0JST0tFTl9TVFJFQU1TIHF1aXJrIHRvIGZpeCBpdC4NCj4gPg0KPiA+IEZpeGVzOiA5NGE2
MzFkOTFhZDMgKCJ1c2I6IHhoY2ktbXRrOiBjaGVjayBoY2NfcGFyYW1zIGFmdGVyIGFkZGluZyBw
cmltYXJ5IGhjZCIpDQo+ID4gU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55
dW5AbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRr
LmMgfCA3ICsrKysrKy0NCj4gPiAgZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay5oIHwgMSArDQo+
ID4gIDIgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay5jIGIvZHJpdmVycy91
c2IvaG9zdC94aGNpLW10ay5jDQo+ID4gaW5kZXggOGYzMjFmMzlhYjk2Li4wOGRhYjk3NGQ4NDcg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay5jDQo+ID4gKysrIGIv
ZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay5jDQo+ID4gQEAgLTM5NSw2ICszOTUsOSBAQCBzdGF0
aWMgdm9pZCB4aGNpX210a19xdWlya3Moc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgeGhjaV9o
Y2QgKnhoY2kpDQo+ID4gICAgICAgICB4aGNpLT5xdWlya3MgfD0gWEhDSV9TUFVSSU9VU19TVUND
RVNTOw0KPiA+ICAgICAgICAgaWYgKG10ay0+bHBtX3N1cHBvcnQpDQo+ID4gICAgICAgICAgICAg
ICAgIHhoY2ktPnF1aXJrcyB8PSBYSENJX0xQTV9TVVBQT1JUOw0KPiA+ICsNCj4gPiArICAgICAg
IGlmIChtdGstPmJyb2tlbl9zdHJlYW1zKQ0KPiA+ICsgICAgICAgICAgICAgICB4aGNpLT5xdWly
a3MgfD0gWEhDSV9CUk9LRU5fU1RSRUFNUzsNCj4gPiAgfQ0KPiA+DQo+ID4gIC8qIGNhbGxlZCBk
dXJpbmcgcHJvYmUoKSBhZnRlciBjaGlwIHJlc2V0IGNvbXBsZXRlcyAqLw0KPiA+IEBAIC00NjAs
NiArNDYzLDggQEAgc3RhdGljIGludCB4aGNpX210a19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQ0KPiA+ICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+DQo+ID4gICAg
ICAgICBtdGstPmxwbV9zdXBwb3J0ID0gb2ZfcHJvcGVydHlfcmVhZF9ib29sKG5vZGUsICJ1c2Iz
LWxwbS1jYXBhYmxlIik7DQo+ID4gKyAgICAgICBtdGstPmJyb2tlbl9zdHJlYW1zID0NCj4gPiAr
ICAgICAgICAgICAgICAgb2ZfcHJvcGVydHlfcmVhZF9ib29sKG5vZGUsICJtZWRpYXRlayxicm9r
ZW5fc3RyZWFtc19xdWlyayIpOw0KPiANCj4gV291bGQgaXQgYmUgYmV0dGVyIHRvIGFkZCBhIGRh
dGEgZmllbGQgdG8gc3RydWN0IG9mX2RldmljZV9pZA0KPiBtdGtfeGhjaV9vZl9tYXRjaCwgYW5k
IGVuYWJsZSB0aGlzIHF1aXJrIG9uIG1lZGlhdGVrLG10ODE3My14aGNpIG9ubHk/DQpUaGlzIGlz
IHRoZSBjb21tb24gaXNzdWUgZm9yIGFsbCBTb0NzIChiZWZvcmUgMjAxNi4wNikgd2l0aCAwLjk2
IHhIQ0kNCndoZW4gdGhlIGNvbnRyb2xsZXIgZG9uJ3Qgc3VwcG9ydCBidWxrIHN0cmVhbS4gSWYg
ZW5hYmxlIHRoaXMgcXVpcmsgb25seQ0KZm9yIG10ODE3MywgdGhlbiBmb3Igb3RoZXIgU29Dcywg
dGhlIGNvbXBhdGlibGUgbmVlZCBpbmNsdWRlDQoibWVkaWF0ZWssbXQ4MTczLXhoY2kiIGluIGR0
cywgdGhpcyBtYXkgYmUgbm90IGZsZXhpYmxlIGZvciBzb21lIGNhc2VzLA0KZS5nLiBhIG5ldyBT
b0MgaGFzIHRoZSBicm9rZW4gc3RyZWFtIGFzIG10ODE3MywgYnV0IGFsc28gaGFzIGFub3RoZXIN
CmRpZmZlcmVudCBxdWlyaywgdGhlIHdheSB5b3Ugc3VnZ2VzdGVkIHdpbGwgbm90IGhhbmRsZSBp
dC4NCkFuZCBJIHBsYW4gdG8gcmVtb3ZlICJtZWRpYXRlayxtdDgxNzMteGhjaSIgaW4gbXRrX3ho
Y2lfb2ZfbWF0Y2ggYWZ0ZXINCmNvbnZlcnRpbmcgdGhlIGJpbmRpbmcgdG8gWU1BTC4NCg0KPiAN
Cj4gKElNSE8gdXNiMy1scG0tY2FwYWJsZSBkZXRlY3Rpb24gc2hvdWxkIGFsc28gYmUgZG9uZSBp
biB0aGUgc2FtZSB3YXkpDQpJIHByZWZlciB0byBwcm92aWRlIGEgcHJvcGVydHkgZm9yIGNvbW1v
biBpc3N1ZXMsIGFuZCB1c2UgdGhlIHdheSB5b3UNCnN1Z2dlc3RlZCBmb3IgdGhlIGlzc3VlIG9u
bHkgaGFwcGVuZWQgYXQgYSBzcGVjaWZpYyBTb0MuDQoNClRoYW5rIHlvdQ0KDQo+IA0KPiBUaGFu
a3MsDQo+IA0KPiA+ICAgICAgICAgLyogb3B0aW9uYWwgcHJvcGVydHksIGlnbm9yZSB0aGUgZXJy
b3IgaWYgaXQgZG9lcyBub3QgZXhpc3QgKi8NCj4gPiAgICAgICAgIG9mX3Byb3BlcnR5X3JlYWRf
dTMyKG5vZGUsICJtZWRpYXRlayx1M3AtZGlzLW1zayIsDQo+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAmbXRrLT51M3BfZGlzX21zayk7DQo+ID4gQEAgLTU0Niw3ICs1NTEsNyBAQCBz
dGF0aWMgaW50IHhoY2lfbXRrX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+
ID4gICAgICAgICBpZiAocmV0KQ0KPiA+ICAgICAgICAgICAgICAgICBnb3RvIHB1dF91c2IzX2hj
ZDsNCj4gPg0KPiA+IC0gICAgICAgaWYgKEhDQ19NQVhfUFNBKHhoY2ktPmhjY19wYXJhbXMpID49
IDQpDQo+ID4gKyAgICAgICBpZiAoIW10ay0+YnJva2VuX3N0cmVhbXMgJiYgSENDX01BWF9QU0Eo
eGhjaS0+aGNjX3BhcmFtcykgPj0gNCkNCj4gPiAgICAgICAgICAgICAgICAgeGhjaS0+c2hhcmVk
X2hjZC0+Y2FuX2RvX3N0cmVhbXMgPSAxOw0KPiA+DQo+ID4gICAgICAgICByZXQgPSB1c2JfYWRk
X2hjZCh4aGNpLT5zaGFyZWRfaGNkLCBpcnEsIElSUUZfU0hBUkVEKTsNCj4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay5oIGIvZHJpdmVycy91c2IvaG9zdC94aGNpLW10
ay5oDQo+ID4gaW5kZXggYTkzY2ZlODE3OTA0Li44NmFhNDk3ODkxNWUgMTAwNjQ0DQo+ID4gLS0t
IGEvZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay5oDQo+ID4gKysrIGIvZHJpdmVycy91c2IvaG9z
dC94aGNpLW10ay5oDQo+ID4gQEAgLTE0Nyw2ICsxNDcsNyBAQCBzdHJ1Y3QgeGhjaV9oY2RfbXRr
IHsNCj4gPiAgICAgICAgIHN0cnVjdCBwaHkgKipwaHlzOw0KPiA+ICAgICAgICAgaW50IG51bV9w
aHlzOw0KPiA+ICAgICAgICAgYm9vbCBscG1fc3VwcG9ydDsNCj4gPiArICAgICAgIGJvb2wgYnJv
a2VuX3N0cmVhbXM7DQo+ID4gICAgICAgICAvKiB1c2IgcmVtb3RlIHdha2V1cCAqLw0KPiA+ICAg
ICAgICAgYm9vbCB1d2tfZW47DQo+ID4gICAgICAgICBzdHJ1Y3QgcmVnbWFwICp1d2s7DQo+ID4g
LS0NCj4gPiAyLjE4LjANCg0K

