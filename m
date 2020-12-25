Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C108C2E29F0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 07:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgLYGNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 01:13:25 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:30251 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725781AbgLYGNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 01:13:24 -0500
X-UUID: 01b1ac4c049641bd9e070389b7f5466b-20201225
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=6uQYTXdICvOcbpvLdkCR21Rtp+nLkicnEhalJcMTfBQ=;
        b=osOE7VGB949RFAaD3VNFajzl5u1GmD2MOt/1guYmkSjchc2IOemPgpCIVSZ0T0zOWo3BI68mUWRjyVresfCP1Mg5g3ofgIDiQA0lMgYog6ArMdj6OO1JSP2x3C/pzQTklyvTOqPWVXp4/0C8eHTi2K2QcAL5kdboTXi/Que9xfY=;
X-UUID: 01b1ac4c049641bd9e070389b7f5466b-20201225
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 836817307; Fri, 25 Dec 2020 14:12:27 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 25 Dec
 2020 14:12:22 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 25 Dec 2020 14:12:22 +0800
Message-ID: <1608876743.7499.38.camel@mhfsdcap03>
Subject: Re: [PATCH 2/3] usb: xhci-mtk: fix UAS issue by XHCI_BROKEN_STREAMS
 quirk
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Nicolas Boichat <drinkcat@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Ikjoon Jang" <ikjn@chromium.org>
Date:   Fri, 25 Dec 2020 14:12:23 +0800
In-Reply-To: <20201221193533.GB407645@robh.at.kernel.org>
References: <20201216115125.5886-1-chunfeng.yun@mediatek.com>
         <20201216115125.5886-2-chunfeng.yun@mediatek.com>
         <CANMq1KDBmuoBNeizm9+f1yJgqF9oMqU5k26KfZrSdjrPQm_LwA@mail.gmail.com>
         <1608171557.23328.53.camel@mhfsdcap03>
         <CANMq1KA4L4PPRgHTmeisfSWu4qgjgNVFZRvxeuAOyq2_TimELA@mail.gmail.com>
         <1608186230.23328.78.camel@mhfsdcap03>
         <20201221193533.GB407645@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: CC79322889513D177F84654F153801002F6ADCE607B6FD4D675B9BFE8D94AAAF2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTEyLTIxIGF0IDEyOjM1IC0wNzAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gVGh1LCBEZWMgMTcsIDIwMjAgYXQgMDI6MjM6NTBQTSArMDgwMCwgQ2h1bmZlbmcgWXVuIHdy
b3RlOg0KPiA+IE9uIFRodSwgMjAyMC0xMi0xNyBhdCAxMTozMiArMDgwMCwgTmljb2xhcyBCb2lj
aGF0IHdyb3RlOg0KPiA+ID4gT24gVGh1LCBEZWMgMTcsIDIwMjAgYXQgMTA6MTkgQU0gQ2h1bmZl
bmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+
ID4gT24gV2VkLCAyMDIwLTEyLTE2IGF0IDIwOjI4ICswODAwLCBOaWNvbGFzIEJvaWNoYXQgd3Jv
dGU6DQo+ID4gPiA+ID4gT24gV2VkLCBEZWMgMTYsIDIwMjAgYXQgNzo1MyBQTSBDaHVuZmVuZyBZ
dW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+ID4gPiA+ID4NCj4gPiA+
ID4gPiA+IFRoZSAwLjk2IHhIQ0kgY29udHJvbGxlciBvbiBzb21lIHBsYXRmb3JtcyBkb2VzIG5v
dCBzdXBwb3J0DQo+ID4gPiA+ID4gPiBidWxrIHN0cmVhbSBldmVuIEhDQ1BBUkFNUyBzYXlzIHN1
cHBvcnRpbmcsIGR1ZSB0byBNYXhQU0FTaXplDQo+ID4gPiA+ID4gPiBpcyBzZXQgYSBub24temVy
byBkZWZhdWx0IHZhbHVlIGJ5IG1pc3Rha2UsIGhlcmUgdXNlDQo+ID4gPiA+ID4gPiBYSENJX0JS
T0tFTl9TVFJFQU1TIHF1aXJrIHRvIGZpeCBpdC4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBG
aXhlczogOTRhNjMxZDkxYWQzICgidXNiOiB4aGNpLW10azogY2hlY2sgaGNjX3BhcmFtcyBhZnRl
ciBhZGRpbmcgcHJpbWFyeSBoY2QiKQ0KPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQ2h1bmZl
bmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KPiA+ID4gPiA+ID4gLS0tDQo+ID4g
PiA+ID4gPiAgZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay5jIHwgNyArKysrKystDQo+ID4gPiA+
ID4gPiAgZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay5oIHwgMSArDQo+ID4gPiA+ID4gPiAgMiBm
aWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+ID4gPiA+
DQo+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay5jIGIv
ZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay5jDQo+ID4gPiA+ID4gPiBpbmRleCA4ZjMyMWYzOWFi
OTYuLjA4ZGFiOTc0ZDg0NyAxMDA2NDQNCj4gPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2hv
c3QveGhjaS1tdGsuYw0KPiA+ID4gPiA+ID4gKysrIGIvZHJpdmVycy91c2IvaG9zdC94aGNpLW10
ay5jDQo+ID4gPiA+ID4gPiBAQCAtMzk1LDYgKzM5NSw5IEBAIHN0YXRpYyB2b2lkIHhoY2lfbXRr
X3F1aXJrcyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCB4aGNpX2hjZCAqeGhjaSkNCj4gPiA+
ID4gPiA+ICAgICAgICAgeGhjaS0+cXVpcmtzIHw9IFhIQ0lfU1BVUklPVVNfU1VDQ0VTUzsNCj4g
PiA+ID4gPiA+ICAgICAgICAgaWYgKG10ay0+bHBtX3N1cHBvcnQpDQo+ID4gPiA+ID4gPiAgICAg
ICAgICAgICAgICAgeGhjaS0+cXVpcmtzIHw9IFhIQ0lfTFBNX1NVUFBPUlQ7DQo+ID4gPiA+ID4g
PiArDQo+ID4gPiA+ID4gPiArICAgICAgIGlmIChtdGstPmJyb2tlbl9zdHJlYW1zKQ0KPiA+ID4g
PiA+ID4gKyAgICAgICAgICAgICAgIHhoY2ktPnF1aXJrcyB8PSBYSENJX0JST0tFTl9TVFJFQU1T
Ow0KPiA+ID4gPiA+ID4gIH0NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiAgLyogY2FsbGVkIGR1
cmluZyBwcm9iZSgpIGFmdGVyIGNoaXAgcmVzZXQgY29tcGxldGVzICovDQo+ID4gPiA+ID4gPiBA
QCAtNDYwLDYgKzQ2Myw4IEBAIHN0YXRpYyBpbnQgeGhjaV9tdGtfcHJvYmUoc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqcGRldikNCj4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICByZXR1cm4gcmV0
Ow0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ICAgICAgICAgbXRrLT5scG1fc3VwcG9ydCA9IG9m
X3Byb3BlcnR5X3JlYWRfYm9vbChub2RlLCAidXNiMy1scG0tY2FwYWJsZSIpOw0KPiA+ID4gPiA+
ID4gKyAgICAgICBtdGstPmJyb2tlbl9zdHJlYW1zID0NCj4gPiA+ID4gPiA+ICsgICAgICAgICAg
ICAgICBvZl9wcm9wZXJ0eV9yZWFkX2Jvb2wobm9kZSwgIm1lZGlhdGVrLGJyb2tlbl9zdHJlYW1z
X3F1aXJrIik7DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBXb3VsZCBpdCBiZSBiZXR0ZXIgdG8gYWRk
IGEgZGF0YSBmaWVsZCB0byBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkDQo+ID4gPiA+ID4gbXRrX3hoY2lf
b2ZfbWF0Y2gsIGFuZCBlbmFibGUgdGhpcyBxdWlyayBvbiBtZWRpYXRlayxtdDgxNzMteGhjaSBv
bmx5Pw0KPiA+ID4gPiBUaGlzIGlzIHRoZSBjb21tb24gaXNzdWUgZm9yIGFsbCBTb0NzIChiZWZv
cmUgMjAxNi4wNikgd2l0aCAwLjk2IHhIQ0kNCj4gPiA+ID4gd2hlbiB0aGUgY29udHJvbGxlciBk
b24ndCBzdXBwb3J0IGJ1bGsgc3RyZWFtLiBJZiBlbmFibGUgdGhpcyBxdWlyayBvbmx5DQo+ID4g
PiA+IGZvciBtdDgxNzMsIHRoZW4gZm9yIG90aGVyIFNvQ3MsIHRoZSBjb21wYXRpYmxlIG5lZWQg
aW5jbHVkZQ0KPiA+ID4gPiAibWVkaWF0ZWssbXQ4MTczLXhoY2kiIGluIGR0cywgdGhpcyBtYXkg
YmUgbm90IGZsZXhpYmxlIGZvciBzb21lIGNhc2VzLA0KPiA+ID4gPiBlLmcuIGEgbmV3IFNvQyBo
YXMgdGhlIGJyb2tlbiBzdHJlYW0gYXMgbXQ4MTczLCBidXQgYWxzbyBoYXMgYW5vdGhlcg0KPiA+
ID4gPiBkaWZmZXJlbnQgcXVpcmssIHRoZSB3YXkgeW91IHN1Z2dlc3RlZCB3aWxsIG5vdCBoYW5k
bGUgaXQuDQo+ID4gPiANCj4gPiA+IEl0IGNhbiwgd2UgZG8gdGhpcyByZWd1bGFybHkgZm9yIG1h
bnkgb3RoZXIgY29tcG9uZW50cy4gT25lIGV4YW1wbGU6DQo+ID4gPiBodHRwczovL2VsaXhpci5i
b290bGluLmNvbS9saW51eC9sYXRlc3Qvc291cmNlL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtbXQ2
NXh4LmMjTDQwMg0KPiA+ID4gDQo+ID4gR290IGl0LiBJbmRlZWQgd29ya3Mgd2hlbiBhZGQgY29t
cGF0aWJsZSBwcml2YXRlIGRhdGEuDQo+ID4gDQo+ID4gRHVlIHRvIG1hbnkgU29DcyBzdXBwb3J0
cyBVU0IgYW5kIG5vdCB1cHN0cmVhbSwgSSdkIHByZWZlciB0byBhdm9pZA0KPiA+IGFkZGluZyBu
ZXcgY29tcGF0aWJsZSBpbiBkcml2ZXIgd2hlbiBzdXBwb3J0IG5ldyBTb0NzLCBhbmQgbGVhdmUg
dGhlDQo+ID4gY29kZSBhcyBzaW1wbGUgYXMgcG9zc2libGUuDQo+IA0KPiBOby4gVGhlIHByb2Js
ZW0gaXMgYWRkaW5nIG5ldyBmaXhlcyByZXF1aXJlcyB1cGRhdGluZyB0aGUgRFQuIFRoYXQgd291
bGQgDQo+IGJlIGZpbmUgaWYgeW91IGtuZXcgYWxsIHBvc3NpYmxlIGlzc3VlcyBhbmQgcXVpcmtz
IHVwIGZyb250LiBZb3UgbWF5IGZvciANCj4gc29tZSwgYnV0IHlvdSB3b24ndCBjYXRjaCB0aGVt
IGFsbC4NClllcy4NCkJ1dCBhbGwgU29DcyB1c2UgdGhlIGdlbmVyaWMgY29tcGF0aWJsZSAibWVk
aWF0ZWssbXRrLXhoY2kiIGV4Y2VwdA0KbXRrODE3My4gYXMgZm9sbG93aW5nOg0KY29tcGF0aWJs
ZSA9ICJtZWRpYXRlayxtdDxTb0M+LXhoY2kiLCAibWVkaWF0ZWssbXRrLXhoY2kiOw0KDQpJdCBt
YXkgYmUgYSBsaXR0bGUgbWVzc3kgd2hlbiB0aGUgZHJpdmVyIGZpbGwgbWFueSBjb21wYXRpYmxl
cyBhZnRlcg0Kc3VwcG9ydGluZyBzZXZlcmFsIHRlbnMgb3IgaHVuZHJlZHMgU29Dcy4NCg0KSSds
bCB0aGluayBhYm91dCBpdCBhZ2Fpbi4gDQo+IA0KPiBTYXZlIERUIHByb3BlcnRpZXMgZm9yIHBl
ciBib2FyZCBxdWlya3MvZmVhdHVyZXMsIG5vdCBwZXIgU29DIG9uZXMuDQpUaGlzIGlzIGZvciBV
U0IgSVAgcXVpcmtzL2ZlYXR1cmUsIG5vdCBib2FyZCBvciBTb0MNCg0KVGhhbmtzDQoNCj4gDQo+
ID4gDQo+ID4gPiA+IEFuZCBJIHBsYW4gdG8gcmVtb3ZlICJtZWRpYXRlayxtdDgxNzMteGhjaSIg
aW4gbXRrX3hoY2lfb2ZfbWF0Y2ggYWZ0ZXINCj4gPiA+ID4gY29udmVydGluZyB0aGUgYmluZGlu
ZyB0byBZTUFMLg0KPiA+ID4gPg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gKElNSE8gdXNiMy1scG0t
Y2FwYWJsZSBkZXRlY3Rpb24gc2hvdWxkIGFsc28gYmUgZG9uZSBpbiB0aGUgc2FtZSB3YXkpDQo+
IA0KPiBJIHRlbmQgdG8gYWdyZWUsIGJ1dCBhbSBtb3JlIHRvbGVyYWJsZSBvZiBzdGFuZGFyZCBV
U0IgZmVhdHVyZXMgdGhhbiANCj4gc3BlY2lmaWMgSVAgYmxvY2sgcXVpcmtzLg0KPiANCj4gUm9i
DQoNCg==

