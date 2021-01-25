Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B0C30210E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 05:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbhAYETZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 23:19:25 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:19922 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726686AbhAYETX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 23:19:23 -0500
X-UUID: 082c04f9b66e4470ac725876ae67500e-20210125
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=zv3J9Bwp8oMXENNoQfKm4XuCtmDJwj7XViVU0ew869s=;
        b=qV3LcROr1XuhuVuTfj+CdJg4/czGP4tBJ8BXi/iSuOJnRhNTKbajfYEb9pBtz7cgA61jqh9EsDQL9+wYJNrwWMyh7Gu78RHcSQ2eT2tCW+rfOzSRGib6EZc9i5sOxY88Jtn/MOtREQRLAakCT6CBhakAL3yHHsoD3vjKa170n7A=;
X-UUID: 082c04f9b66e4470ac725876ae67500e-20210125
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <hailong.fan@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 195057741; Mon, 25 Jan 2021 12:18:23 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 25 Jan
 2021 12:18:22 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 25 Jan 2021 12:18:21 +0800
Message-ID: <1611548301.1248.9.camel@mhfsdcap03>
Subject: Re: [PATCH] pinctrl: mediatek: Fix trigger type setting follow for
 unexpected interrupt
From:   mtk15103 <hailong.fan@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
CC:     Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>, <youlin.pei@mediatek.com>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Chen-Tsung Hsieh <chentsung@chromium.org>,
        <gtk_pangao@mediatek.com>, Hanks Chen <hanks.chen@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>
Date:   Mon, 25 Jan 2021 12:18:21 +0800
In-Reply-To: <CANMq1KCfBy9dRELP-hMjY5FraachcRGHEC9mmaMjJCLQzdu+ZA@mail.gmail.com>
References: <20210125031513.1741-1-hailong.fan@mediatek.com>
         <CANMq1KCfBy9dRELP-hMjY5FraachcRGHEC9mmaMjJCLQzdu+ZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 69D5DEF50C9E688764BC44E9346C8EF33B761D0F15BD9C0A9A5ED8E0C4687B3D2000:8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTAxLTI1IGF0IDExOjI0ICswODAwLCBOaWNvbGFzIEJvaWNoYXQgd3JvdGU6
DQo+IE9uIE1vbiwgSmFuIDI1LCAyMDIxIGF0IDExOjE1IEFNIEhhaWxvbmcgRmFuIDxoYWlsb25n
LmZhbkBtZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+DQo+ID4gV2hlbiBmbGlwcGluZyB0aGUgcG9s
YXJpdHkgd2lsbCBiZSBnZW5lcmF0ZWQgaW50ZXJydXB0IHVuZGVyIGNlcnRhaW4NCj4gPiBjaXJj
dW1zdGFuY2VzLCBidXQgR1BJTyBleHRlcm5hbCBzaWduYWwgaGFzIG5vdCBjaGFuZ2VkLg0KPiA+
IFRoZW4sIG1hc2sgdGhlIGludGVycnVwdCBiZWZvcmUgcG9sYXJpdHkgc2V0dGluZywgYW5kIGNs
ZWFyIHRoZQ0KPiA+IHVuZXhwZWN0ZWQgaW50ZXJydXB0IGFmdGVyIHRyaWdnZXIgdHlwZSBzZXR0
aW5nIGNvbXBsZXRlZC4NCj4gDQo+IEknZCBhZGQgYSBzaG9ydCBub3RlIGFib3V0IHdoeSB5b3Ug
cmVtb3ZlIG10a19laW50X2ZsaXBfZWRnZSwgdGhhdCBpcywNCj4gYmVjYXVzZSBtdGtfZWludF91
bm1hc2sgYWxyZWFkeSBjYWxscyBpdC4NCkFkZCBpdCBvbiBWMywgdGh4Lg0KIA0KPiA+DQo+ID4g
U2lnbmVkLW9mZi1ieTogSGFpbG9uZyBGYW4gPGhhaWxvbmcuZmFuQG1lZGlhdGVrLmNvbT4NCj4g
PiAtLS0NCj4gPiBbVjJdDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGluY3RybC9tZWRpYXRlay9t
dGstZWludC5jIHwgMTMgKysrKysrKysrKystLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3BpbmN0cmwvbWVkaWF0ZWsvbXRrLWVpbnQuYyBiL2RyaXZlcnMvcGluY3RybC9tZWRpYXRlay9t
dGstZWludC5jDQo+ID4gaW5kZXggMjI3MzZmNjBjMTZjLi4wMDQyZjMyYzdlN2UgMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy9waW5jdHJsL21lZGlhdGVrL210ay1laW50LmMNCj4gPiArKysgYi9k
cml2ZXJzL3BpbmN0cmwvbWVkaWF0ZWsvbXRrLWVpbnQuYw0KPiA+IEBAIC0xNTcsNiArMTU3LDcg
QEAgc3RhdGljIHZvaWQgbXRrX2VpbnRfYWNrKHN0cnVjdCBpcnFfZGF0YSAqZCkNCj4gPiAgc3Rh
dGljIGludCBtdGtfZWludF9zZXRfdHlwZShzdHJ1Y3QgaXJxX2RhdGEgKmQsIHVuc2lnbmVkIGlu
dCB0eXBlKQ0KPiA+ICB7DQo+ID4gICAgICAgICBzdHJ1Y3QgbXRrX2VpbnQgKmVpbnQgPSBpcnFf
ZGF0YV9nZXRfaXJxX2NoaXBfZGF0YShkKTsNCj4gPiArICAgICAgIGJvb2wgdW5tYXNrZWQ7DQo+
IA0KPiBXZWxsLCB0aGlzIGlzIHRydWUgaWYgdGhlIGludGVycnVwdCBoYXMgYmVlbiBtYXNrZWQg
KG9yLCBlcXVpdmFsZW50bHksDQo+IGlmIHdlIG5lZWQgdG8gdW5tYXNrIGl0IGxhdGVyKS4NCj4g
DQo+IFNvIEkgdGhpbmsgZWl0aGVyICJtYXNrZWQiIG9yICJ1bm1hc2siIGFyZSBiZXR0ZXIgYXMg
dmFyaWFibGUgbmFtZXMuDQpZZXMsIG1hc2tlZCBpcyBiZXR0ZXIuDQo+IA0KPiA+ICAgICAgICAg
dTMyIG1hc2sgPSBCSVQoZC0+aHdpcnEgJiAweDFmKTsNCj4gPiAgICAgICAgIHZvaWQgX19pb21l
bSAqcmVnOw0KPiA+DQo+ID4gQEAgLTE3Myw2ICsxNzQsMTMgQEAgc3RhdGljIGludCBtdGtfZWlu
dF9zZXRfdHlwZShzdHJ1Y3QgaXJxX2RhdGEgKmQsIHVuc2lnbmVkIGludCB0eXBlKQ0KPiA+ICAg
ICAgICAgZWxzZQ0KPiA+ICAgICAgICAgICAgICAgICBlaW50LT5kdWFsX2VkZ2VbZC0+aHdpcnFd
ID0gMDsNCj4gPg0KPiA+ICsgICAgICAgaWYgKCFtdGtfZWludF9nZXRfbWFzayhlaW50LCBkLT5o
d2lycSkpIHsNCj4gPiArICAgICAgICAgICAgICAgbXRrX2VpbnRfbWFzayhkKTsNCj4gPiArICAg
ICAgICAgICAgICAgdW5tYXNrZWQgPSB0cnVlOw0KPiA+ICsgICAgICAgfSBlbHNlIHsNCj4gPiAr
ICAgICAgICAgICAgICAgdW5tYXNrZWQgPSBmYWxzZTsNCj4gPiArICAgICAgIH0NCj4gPiArDQo+
ID4gICAgICAgICBpZiAodHlwZSAmIChJUlFfVFlQRV9MRVZFTF9MT1cgfCBJUlFfVFlQRV9FREdF
X0ZBTExJTkcpKSB7DQo+ID4gICAgICAgICAgICAgICAgIHJlZyA9IG10a19laW50X2dldF9vZmZz
ZXQoZWludCwgZC0+aHdpcnEsIGVpbnQtPnJlZ3MtPnBvbF9jbHIpOw0KPiA+ICAgICAgICAgICAg
ICAgICB3cml0ZWwobWFzaywgcmVnKTsNCj4gPiBAQCAtMTg5LDggKzE5Nyw5IEBAIHN0YXRpYyBp
bnQgbXRrX2VpbnRfc2V0X3R5cGUoc3RydWN0IGlycV9kYXRhICpkLCB1bnNpZ25lZCBpbnQgdHlw
ZSkNCj4gPiAgICAgICAgICAgICAgICAgd3JpdGVsKG1hc2ssIHJlZyk7DQo+ID4gICAgICAgICB9
DQo+ID4NCj4gPiAtICAgICAgIGlmIChlaW50LT5kdWFsX2VkZ2VbZC0+aHdpcnFdKQ0KPiA+IC0g
ICAgICAgICAgICAgICBtdGtfZWludF9mbGlwX2VkZ2UoZWludCwgZC0+aHdpcnEpOw0KPiA+ICsg
ICAgICAgbXRrX2VpbnRfYWNrKGQpOw0KPiA+ICsgICAgICAgaWYgKHVubWFza2VkKQ0KPiA+ICsg
ICAgICAgICAgICAgICBtdGtfZWludF91bm1hc2soZCk7DQo+ID4NCj4gPiAgICAgICAgIHJldHVy
biAwOw0KPiA+ICB9DQo+ID4gLS0NCj4gPiAyLjE4LjANCg0K

