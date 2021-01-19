Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928F32FAED1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 03:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394282AbhASCe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 21:34:56 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:11119 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728366AbhASCeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 21:34:12 -0500
X-UUID: da7fbddae4034b26aa993c0a4102f049-20210119
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=4kexQ2hHpQDh0WXQE4QqbROz+eLRj3yLnugH4alvgz4=;
        b=OLXAV9xEQ4eaEFkpPwAsAn1JPspckHz2lyq0rV3acNRhp+jeiBGURdkphgAddRr85Mvc5Zxagjkfc34dN3oogxQ7c12cHPq2isO0CDt1dR0pXHE6+ZM1rsxXo6q02VubM6agu3PkYrFuNiKKiCil3MttuNHyFzB6tulEivoPtQ8=;
X-UUID: da7fbddae4034b26aa993c0a4102f049-20210119
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 199284678; Tue, 19 Jan 2021 10:33:17 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 19 Jan
 2021 10:33:15 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 19 Jan 2021 10:33:14 +0800
Message-ID: <1611023594.11995.4.camel@mhfsdcap03>
Subject: Re: [PATCH v5] usb: xhci-mtk: fix unreleased bandwidth data
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Ikjoon Jang <ikjn@chromium.org>
CC:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, <linux-usb@vger.kernel.org>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Zhanyong Wang <zhanyong.wang@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Tue, 19 Jan 2021 10:33:14 +0800
In-Reply-To: <CAATdQgCb254YJ2tpiqWZ0RDHRiN59NuuHBuhavoYQT3STh=jkg@mail.gmail.com>
References: <20201229142406.v5.1.Id0d31b5f3ddf5e734d2ab11161ac5821921b1e1e@changeid>
         <2aea44f0-85e7-fd55-2c35-c1d994f20e03@linux.intel.com>
         <1610086308.24856.30.camel@mhfsdcap03>
         <e43632e2-08b3-7a1a-8272-1d493e25fc67@linux.intel.com>
         <CAATdQgD2OAmf7_NWSVwzyJE7mF0vngzE=QeE79PS7MJsgPhbtA@mail.gmail.com>
         <1610612988.30053.15.camel@mhfsdcap03>
         <CAATdQgCb254YJ2tpiqWZ0RDHRiN59NuuHBuhavoYQT3STh=jkg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: A6115A169AEB976A4B832476D0D8D2120FA2368B9779F77F46ED1A7ED5A498A62000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIxLTAxLTE1IGF0IDEwOjUxICswODAwLCBJa2pvb24gSmFuZyB3cm90ZToNCj4g
T24gVGh1LCBKYW4gMTQsIDIwMjEgYXQgNDozMCBQTSBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1
bkBtZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+DQo+ID4gSGkgSWtqb29uLA0KPiA+DQo+ID4gT24g
VHVlLCAyMDIxLTAxLTEyIGF0IDEzOjQ4ICswODAwLCBJa2pvb24gSmFuZyB3cm90ZToNCj4gPiA+
IE9uIEZyaSwgSmFuIDgsIDIwMjEgYXQgMTA6NDQgUE0gTWF0aGlhcyBOeW1hbg0KPiA+ID4gPG1h
dGhpYXMubnltYW5AbGludXguaW50ZWwuY29tPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gT24g
OC4xLjIwMjEgOC4xMSwgQ2h1bmZlbmcgWXVuIHdyb3RlOg0KPiA+ID4gPiA+IE9uIFRodSwgMjAy
MS0wMS0wNyBhdCAxMzowOSArMDIwMCwgTWF0aGlhcyBOeW1hbiB3cm90ZToNCj4gPiA+ID4gPj4g
T24gMjkuMTIuMjAyMCA4LjI0LCBJa2pvb24gSmFuZyB3cm90ZToNCj4gPiA+ID4gPj4+IHhoY2kt
bXRrIGhhcyBob29rcyBvbiBhZGRfZW5kcG9pbnQoKSBhbmQgZHJvcF9lbmRwb2ludCgpIGZyb20g
eGhjaQ0KPiA+ID4gPiA+Pj4gdG8gaGFuZGxlIGl0cyBvd24gc3cgYmFuZHdpZHRoIG1hbmFnZW1l
bnRzIGFuZCBzdG9yZXMgYmFuZHdpZHRoIGRhdGENCj4gPiA+ID4gPj4+IGludG8gaW50ZXJuYWwg
dGFibGUgZXZlcnkgdGltZSBhZGRfZW5kcG9pbnQoKSBpcyBjYWxsZWQsDQo+ID4gPiA+ID4+PiBz
byB3aGVuIGJhbmR3aWR0aCBhbGxvY2F0aW9uIGZhaWxzIGF0IG9uZSBlbmRwb2ludCwgYWxsIGVh
cmxpZXINCj4gPiA+ID4gPj4+IGFsbG9jYXRpb24gZnJvbSB0aGUgc2FtZSBpbnRlcmZhY2UgY291
bGQgc3RpbGwgcmVtYWluIGF0IHRoZSB0YWJsZS4NCj4gPiA+ID4gPj4+DQo+ID4gPiA+ID4+PiBU
aGlzIHBhdGNoIGFkZHMgdHdvIG1vcmUgaG9va3MgZnJvbSBjaGVja19iYW5kd2lkdGgoKSBhbmQN
Cj4gPiA+ID4gPj4+IHJlc2V0X2JhbmR3aWR0aCgpLCBhbmQgbWFrZSBtdGsteGhjaSB0byByZWxl
YXNlcyBhbGwgZmFpbGVkIGVuZHBvaW50cw0KPiA+ID4gPiA+Pj4gZnJvbSByZXNldF9iYW5kd2lk
dGgoKS4NCj4gPiA+ID4gPj4+DQo+ID4gPiA+ID4+PiBGaXhlczogMDhlNDY5ZGU4N2EyICgidXNi
OiB4aGNpLW10azogc3VwcG9ydHMgYmFuZHdpZHRoIHNjaGVkdWxpbmcgd2l0aCBtdWx0aS1UVCIp
DQo+ID4gPiA+ID4+PiBTaWduZWQtb2ZmLWJ5OiBJa2pvb24gSmFuZyA8aWtqbkBjaHJvbWl1bS5v
cmc+DQo+ID4gPiA+ID4+Pg0KPiA+ID4gPiA+Pg0KPiA+ID4gPiA+PiAuLi4NCj4gPiA+ID4gPj4N
Cj4gPiA+ID4gPj4+DQo+ID4gPiA+ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvaG9zdC94
aGNpLmMgYi9kcml2ZXJzL3VzYi9ob3N0L3hoY2kuYw0KPiA+ID4gPiA+Pj4gaW5kZXggZDRhOGQw
ZWZiYmM0Li5lMWZjZDNjZjcyM2YgMTAwNjQ0DQo+ID4gPiA+ID4+PiAtLS0gYS9kcml2ZXJzL3Vz
Yi9ob3N0L3hoY2kuYw0KPiA+ID4gPiA+Pj4gKysrIGIvZHJpdmVycy91c2IvaG9zdC94aGNpLmMN
Cj4gPiA+ID4gPj4+IEBAIC0yODgyLDYgKzI4ODIsMTIgQEAgc3RhdGljIGludCB4aGNpX2NoZWNr
X2JhbmR3aWR0aChzdHJ1Y3QgdXNiX2hjZCAqaGNkLCBzdHJ1Y3QgdXNiX2RldmljZSAqdWRldikN
Cj4gPiA+ID4gPj4+ICAgICB4aGNpX2RiZyh4aGNpLCAiJXMgY2FsbGVkIGZvciB1ZGV2ICVwXG4i
LCBfX2Z1bmNfXywgdWRldik7DQo+ID4gPiA+ID4+PiAgICAgdmlydF9kZXYgPSB4aGNpLT5kZXZz
W3VkZXYtPnNsb3RfaWRdOw0KPiA+ID4gPiA+Pj4NCj4gPiA+ID4gPj4+ICsgICBpZiAoeGhjaS0+
cXVpcmtzICYgWEhDSV9NVEtfSE9TVCkgew0KPiA+ID4gPiA+Pj4gKyAgICAgICAgICAgcmV0ID0g
eGhjaV9tdGtfY2hlY2tfYmFuZHdpZHRoKGhjZCwgdWRldik7DQo+ID4gPiA+ID4+PiArICAgICAg
ICAgICBpZiAocmV0IDwgMCkNCj4gPiA+ID4gPj4+ICsgICAgICAgICAgICAgICAgICAgcmV0dXJu
IHJldDsNCj4gPiA+ID4gPj4+ICsgICB9DQo+ID4gPiA+ID4+PiArDQo+ID4gPiA+ID4+DQo+ID4g
PiA+ID4+IEp1c3Qgbm90aWNlZCB0aGF0IFhIQ0lfTVRLX0hPU1QgcXVpcmsgaXMgb25seSBzZXQg
aW4geGhjaS1tdGsuYy4NCj4gPiA+ID4gPj4geGhjaS1tdGsuYyBjYWxscyB4aGNpX2luaXRfZHJp
dmVyKC4uLiwgeGhjaV9tdGtfb3ZlcnJpZGVzKSB3aXRoIGEgLnJlc2V0IG92ZXJyaWRlIGZ1bmN0
aW9uLg0KPiA+ID4gPiA+Pg0KPiA+ID4gPiA+PiB3aHkgbm90IGFkZCBvdmVycmlkZSBmdW5jdGlv
bnMgZm9yIC5jaGVja19iYW5kd2lkdGggYW5kIC5yZXNldF9iYW5kd2lkdGggdG8geGhjaV9tdGtf
b3ZlcnJpZGVzIGluc3RlYWQ/DQo+ID4gPiA+ID4+DQo+ID4gPiA+ID4+IEFub3RoZXIgcGF0Y2gg
dG8gYWRkIHNpbWlsYXIgb3ZlcnJpZGVzIGZvciAuYWRkX2VuZHBvaW50IGFuZCAuZHJvcF9lbmRw
b2ludCBzaG91bGQgcHJvYmFibHkgYmUNCj4gPiA+ID4gPj4gZG9uZSBzbyB0aGF0IHdlIGNhbiBn
ZXQgcmlkIG9mIHRoZSB4aGNpX210a19hZGQvZHJvcF9lcF9xdWlyaygpIGNhbGxzIGluIHhoY2ku
YyBhcyB3ZWxsDQo+ID4gPiA+ID4gWW91IG1lYW4sIHdlIGNhbiBleHBvcnQgeGhjaV9hZGQvZHJv
cF9lbmRwb2ludCgpPw0KPiA+ID4gPg0KPiA+ID4gPiBJIHRoaW5rIHNvLCB1bmxlc3MgeW91IGhh
dmUgYSBiZXR0ZXIgaWRlYS4NCj4gPiA+ID4gSSBwcmVmZXIgZXhwb3J0aW5nIHRoZSBnZW5lcmlj
IGFkZC9kcm9wX2VuZHBvaW50IGZ1bmN0aW9ucyByYXRoZXIgdGhhbiB0aGUgdmVuZG9yIHNwZWNp
ZmljIHF1aXJrIGZ1bmN0aW9ucy4NCj4gPiA+ID4NCj4gPiA+DQo+ID4gPiBXaGVuIG1vdmluZyBv
dXQgYWxsIE1US19IT1NUIHF1aXJrcyBhbmQgdW5saW5rIHhoY2ktbXRrLXNjaCBmcm9tIHhoY2ks
DQo+ID4gPiB4aGNpLW10ay1zY2ggc3RpbGwgbmVlZHMgdG8gdG91Y2ggdGhlIHhoY2kgaW50ZXJu
YWxzLCBhdCBsZWFzdCBzdHJ1Y3QNCj4gPiA+IHhoY2lfZXBfY3R4Lg0KPiA+ID4NCj4gPiA+IE15
IG5haXZlIGlkZWEgaXMganVzdCBsZXQgeGhjaSBleHBvcnQgb25lIG1vcmUgZnVuY3Rpb24gdG8g
ZXhwb3NlIHhoY2lfZXBfY3R4Lg0KPiA+ID4gQnV0IEknbSBub3Qgc3VyZSB3aGV0aGVyIHRoaXMg
aXMgYWNjZXB0YWJsZToNCj4gPiBJIGZpbmQgdGhhdCB4aGNpX2FkZF9lbmRwb2ludCgpIGlnbm9y
ZXMgc29tZSBlcnJvcnMgd2l0aCByZXR1cm4gMCwgZm9yDQo+ID4gdGhlc2UgY2FzZXMgd2UgbmVl
ZG4ndCBjYWxsIHhoY2lfbXRrX2FkZF9lcC1xdWlyaygpLCBzbyBtYXkgYmUgbm90IGENCj4gPiBn
b29kIHdheSB0byBqdXN0IGV4cG9ydCB4aGNpX2FkZF9lbmRwb2ludCgpLg0KPiANCj4geWVhaCwg
bWF5YmUgdGhhdCdzIGZyb20gZXAwIGNhc2U/DQo+IA0KPiBBbmQgSSd2ZSB0aG91Z2h0IHRoYXQg
d2UgY291bGQgYWxzbyB1bmxpbmsgeGhjaS1tdGstc2NoIGZyb20gdGhlIHhoY2kgbW9kdWxlDQo+
IGlmIE1US19IT1NUIHF1aXJrIGZ1bmN0aW9ucyBhcmUgbW92ZWQgb3V0IHRvIG10ayBwbGF0Zm9y
bSBkcml2ZXIncyBvdmVycmlkZXMuDQo+IEkgZ3Vlc3MgSSd2ZSBnb25lIHRvbyBmYXIuDQo+IA0K
PiBJZiB3ZSBrZWVwIHhoY2ktbXRrLXNjaCBiZWluZyBidWlsdCB3aXRoIHRoZSB4aGNpIG1vZHVs
ZSwNCj4geGhjaS1tdGstc2NoIGNhbiBkaXJlY3RseSBhY2Nlc3MgaW5wdXQgY29udHJvbCBjb250
ZXh0IGFuZCBpdHMgZHJvcC9hZGQgZmxhZ3MsDQo+IHNvIEkgdGhpbmsgd2UgY2FuIHNpbXBseSBy
ZW1vdmUge2FkZHxkcm9wfV9lbmRwb2ludCgpIHF1aXJrcyBhbmQganVzdCBoYW5kbGUNCj4gdGhl
bSBhbGwgaW4ge2NoZWNrfHJlc2V0fV9iYW5kd2lkdGgoKSBvdmVycmlkZXMuDQpJdCdzIG9rIGlm
IGNoZWNrX2JhbmR3aWR0aCgpIGNvdWxkIGdldCBhZGRlZCBlcCBhbmQgdXBkYXRlIGNvbnRleHQu
DQoNCkknbGwgc3BlbmQgc29tZSB0aW1lIHRvIGxvb2sgYXQgdGhlIGNvZGUgYW5kIHRlc3QgaXQu
DQoNClRoYW5rIHlvdQ0KDQo+IA0KPiA+DQo+ID4gPg0KPiA+ID4gK3N0cnVjdCB4aGNpX2VwX2N0
eCogeGhjaV9nZXRfZXBfY29udGV4KHN0cnVjdCB4aGNpX2hjZCAqeGhjaSwgc3RydWN0DQo+ID4g
PiB1c2JfaG9zdF9lbmRwb2ludCAqZXApDQo+ID4gPiAreyAuLi4gfQ0KPiA+ID4gK0VYUE9SVF9T
WU1CT0woeGhjaV9nZXRfZXBfY29udGV4dCk7DQo+ID4gPg0KPiA+ID4gQnV0IGZvciB2NiwgSSdt
IGdvaW5nIHRvIHN1Ym1pdCBhIHBhdGNoIHdpdGgge2NoZWNrfHJlc2V0fV9iYW5kd2lkdGgoKQ0K
PiA+ID4gcXVpcmsgZnVuY3Rpb24NCj4gPiA+ICBzd2l0Y2hlZCBpbnRvIHhoY2lfZHJpdmVyX292
ZXJyaWRlcyBmaXJzdC4gKGFuZCBwcmVzZXJ2ZSBleGlzdGluZw0KPiA+ID4gTVRLX0hPU1QgcXVp
cmsgZnVuY3Rpb25zKS4NCj4gPiA+DQo+ID4gPiBUaGFua3MhDQo+ID4gPg0KPiA+ID4gPiAtTWF0
aGlhcw0KPiA+ID4gPg0KPiA+DQoNCg==

