Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC36B2FFA9D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 03:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbhAVCqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 21:46:09 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:38323 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726189AbhAVCqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 21:46:08 -0500
X-UUID: 5da1692a6ec344309d23943903b1b2e7-20210122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=X5v+utYffwyTYKqjma24lnBW4YqumRxZipWEo8CW1UA=;
        b=uB21AbQMY/Lzf0ceJ0Sx761xIJ+GFuEBdg3HWcpBKPm1dgux/GsjfQLu5zLrlsb3z/fkFGB6d8taTTA08lhISi8ejMyoFslIjRyXGsJMa2l6o+CHbjxxNoIC1tXM6Pkhxd6BOFmqJ/bejATI905JRQEpJ1gE9asm/Q4b8qrL6j0=;
X-UUID: 5da1692a6ec344309d23943903b1b2e7-20210122
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <hailong.fan@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 200082445; Fri, 22 Jan 2021 10:44:06 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 22 Jan
 2021 10:43:58 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 Jan 2021 10:43:57 +0800
Message-ID: <1611283438.2493.23.camel@mhfsdcap03>
Subject: Re: [PATCH RESEND] pinctrl: mediatek: Fix trigger type setting
 follow for unexpected interrupt
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
        Yong Wu <yong.wu@mediatek.com>, <zhengnan.chen@mediatek.com>
Date:   Fri, 22 Jan 2021 10:43:58 +0800
In-Reply-To: <CANMq1KCXrEGrNrOwivrchXyawzKySVzQoxA1goYC-eh-auNFCA@mail.gmail.com>
References: <20210121075149.1310-1-hailong.fan@mediatek.com>
         <CANMq1KBqKUofLaM+OEaTq6PSeYomNSLvn65c+Wyi1cKsLDNboQ@mail.gmail.com>
         <1611230975.2493.17.camel@mhfsdcap03>
         <CANMq1KCXrEGrNrOwivrchXyawzKySVzQoxA1goYC-eh-auNFCA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 228C2C3B488DEC2667858FCF6F39936DA79AEB4095B235C0ECF1B7731F7404092000:8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIxLTAxLTIxIGF0IDIwOjEzICswODAwLCBOaWNvbGFzIEJvaWNoYXQgd3JvdGU6
DQo+IE9uIFRodSwgSmFuIDIxLCAyMDIxIGF0IDg6MDkgUE0gbXRrMTUxMDMgPGhhaWxvbmcuZmFu
QG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBPbiBUaHUsIDIwMjEtMDEtMjEgYXQgMTY6
NTUgKzA4MDAsIE5pY29sYXMgQm9pY2hhdCB3cm90ZToNCj4gPiA+IE9uIFRodSwgSmFuIDIxLCAy
MDIxIGF0IDM6NTIgUE0gSGFpbG9uZyBGYW4gPGhhaWxvbmcuZmFuQG1lZGlhdGVrLmNvbT4gd3Jv
dGU6DQo+ID4gPiA+DQo+ID4gPiA+IFdoZW4gZmxpcHBpbmcgdGhlIHBvbGFyaXR5IHdpbGwgYmUg
Z2VuZXJhdGVkIGludGVycnVwdCB1bmRlciBjZXJ0YWluDQo+ID4gPiA+IGNpcmN1bXN0YW5jZXMs
IGJ1dCBHUElPIGV4dGVybmFsIHNpZ25hbCBoYXMgbm90IGNoYW5nZWQuDQo+ID4gPiA+IFRoZW4s
IG1hc2sgdGhlIGludGVycnVwdCBiZWZvcmUgcG9sYXJpdHkgc2V0dGluZywgYW5kIGNsZWFyIHRo
ZQ0KPiA+ID4gPiB1bmV4cGVjdGVkIGludGVycnVwdCBhZnRlciB0cmlnZ2VyIHR5cGUgc2V0dGlu
ZyBjb21wbGV0ZWQuDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEhhaWxvbmcgRmFu
IDxoYWlsb25nLmZhbkBtZWRpYXRlay5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiBSZXNlbmQg
c2luY2Ugc29tZSBzZXJ2ZXIgcmVqZWN0Lg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIGRyaXZlcnMv
cGluY3RybC9tZWRpYXRlay9tdGstZWludC5jIHwgMTMgKysrKysrKysrKystLQ0KPiA+ID4gPiAg
MSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4gPiA+
DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BpbmN0cmwvbWVkaWF0ZWsvbXRrLWVpbnQu
YyBiL2RyaXZlcnMvcGluY3RybC9tZWRpYXRlay9tdGstZWludC5jDQo+ID4gPiA+IGluZGV4IDIy
NzM2ZjYwYzE2Yy4uM2FjZGE2YmI0MDFlIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3Bp
bmN0cmwvbWVkaWF0ZWsvbXRrLWVpbnQuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL3BpbmN0cmwv
bWVkaWF0ZWsvbXRrLWVpbnQuYw0KPiA+ID4gPiBAQCAtMTU3LDYgKzE1Nyw3IEBAIHN0YXRpYyB2
b2lkIG10a19laW50X2FjayhzdHJ1Y3QgaXJxX2RhdGEgKmQpDQo+ID4gPiA+ICBzdGF0aWMgaW50
IG10a19laW50X3NldF90eXBlKHN0cnVjdCBpcnFfZGF0YSAqZCwgdW5zaWduZWQgaW50IHR5cGUp
DQo+ID4gPiA+ICB7DQo+ID4gPiA+ICAgICAgICAgc3RydWN0IG10a19laW50ICplaW50ID0gaXJx
X2RhdGFfZ2V0X2lycV9jaGlwX2RhdGEoZCk7DQo+ID4gPiA+ICsgICAgICAgdW5zaWduZWQgaW50
IHVubWFzazsNCj4gPiA+DQo+ID4gPiBib29sPw0KPiA+IFllcyx0aGFua3MuDQo+ID4gPg0KPiA+
ID4gPiAgICAgICAgIHUzMiBtYXNrID0gQklUKGQtPmh3aXJxICYgMHgxZik7DQo+ID4gPiA+ICAg
ICAgICAgdm9pZCBfX2lvbWVtICpyZWc7DQo+ID4gPiA+DQo+ID4gPiA+IEBAIC0xNzMsNiArMTc0
LDEzIEBAIHN0YXRpYyBpbnQgbXRrX2VpbnRfc2V0X3R5cGUoc3RydWN0IGlycV9kYXRhICpkLCB1
bnNpZ25lZCBpbnQgdHlwZSkNCj4gPiA+ID4gICAgICAgICBlbHNlDQo+ID4gPiA+ICAgICAgICAg
ICAgICAgICBlaW50LT5kdWFsX2VkZ2VbZC0+aHdpcnFdID0gMDsNCj4gPiA+ID4NCj4gPiA+ID4g
KyAgICAgICBpZiAoIW10a19laW50X2dldF9tYXNrKGVpbnQsIGQtPmh3aXJxKSkgew0KPiA+ID4g
PiArICAgICAgICAgICAgICAgbXRrX2VpbnRfbWFzayhkKTsNCj4gPiA+ID4gKyAgICAgICAgICAg
ICAgIHVubWFzayA9IDE7DQo+ID4gPiA+ICsgICAgICAgfSBlbHNlIHsNCj4gPiA+ID4gKyAgICAg
ICAgICAgICAgIHVubWFzayA9IDA7DQo+ID4gPiA+ICsgICAgICAgfQ0KPiA+ID4gPiArDQo+ID4g
PiA+ICAgICAgICAgaWYgKHR5cGUgJiAoSVJRX1RZUEVfTEVWRUxfTE9XIHwgSVJRX1RZUEVfRURH
RV9GQUxMSU5HKSkgew0KPiA+ID4gPiAgICAgICAgICAgICAgICAgcmVnID0gbXRrX2VpbnRfZ2V0
X29mZnNldChlaW50LCBkLT5od2lycSwgZWludC0+cmVncy0+cG9sX2Nscik7DQo+ID4gPiA+ICAg
ICAgICAgICAgICAgICB3cml0ZWwobWFzaywgcmVnKTsNCj4gPiA+ID4gQEAgLTE4OSw4ICsxOTcs
OSBAQCBzdGF0aWMgaW50IG10a19laW50X3NldF90eXBlKHN0cnVjdCBpcnFfZGF0YSAqZCwgdW5z
aWduZWQgaW50IHR5cGUpDQo+ID4gPiA+ICAgICAgICAgICAgICAgICB3cml0ZWwobWFzaywgcmVn
KTsNCj4gPiA+ID4gICAgICAgICB9DQo+ID4gPiA+DQo+ID4gPiA+IC0gICAgICAgaWYgKGVpbnQt
PmR1YWxfZWRnZVtkLT5od2lycV0pDQo+ID4gPiA+IC0gICAgICAgICAgICAgICBtdGtfZWludF9m
bGlwX2VkZ2UoZWludCwgZC0+aHdpcnEpOw0KPiA+ID4NCj4gPiA+IFdoeSBhcmUgeW91IGRyb3Bw
aW5nIHRoaXM/IEFyZW4ndCB3ZSBhdCByaXNrIHRvIG1pc3MgdGhlIGZpcnN0IGVkZ2UNCj4gPiA+
IGFmdGVyIG10a19laW50X3NldF90eXBlIGlzIGNhbGxlZD8NCj4gPiBtdGtfZWludF91bm1hc2so
KSB3aWxsIGRvIGl0Lg0KPiA+IElmIHVubWFzayAhPSAxLCB1c2VyIG5lZWQgdG8gY2FsbCBtdGtf
ZWludF91bm1hc2soKSB0byBlbmFibGUgdGhlDQo+ID4gaW50ZXJydXB0IGJlZm9yZSB1c2UgaXQs
IHRoYW5rcy4NCj4gDQo+IE1ha2VzIHNlbnNlLCBJIGp1c3QgaGF2ZSBvbmUgbW9yZSB3b3JyeToN
Cj4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvbGF0ZXN0L3NvdXJjZS9kcml2ZXJz
L3BpbmN0cmwvbWVkaWF0ZWsvbXRrLWVpbnQuYyNMMTIyDQo+IA0KPiBtdGtfZWludF91bm1hc2sg
dW5tYXNrcyB0aGUgaW50ZXJydXB0IF9iZWZvcmVfIHRoZSBlZGdlIGlzIGZsaXBwZWQsDQo+IGNv
dWxkIHRoaXMgY2F1c2UgYSBzcHVyaW91cyBpbnRlcnJ1cHQ/IE9uIGFueSB1bm1hc2sgb3BlcmF0
aW9uIC0tIG5vdA0KPiBqdXN0IG9uIG10a19laW50X3NldF90eXBlIChzbyB0aGlzIGlzIHRlY2hu
aWNhbGx5IGFub3RoZXIgcHJvYmxlbSwNCj4gdGhhdCBzaG91bGQgYmUgZml4ZWQgYXMgYSBzZXBh
cmF0ZSBwYXRjaCkNCg0KVGhpcyBzaXR1YXRpb24gd2lsbCBub3QgaGFwcGVuLg0KDQpTcHVyaW91
cyBpbnRlcnJ1cHQgb2NjdXIgY29uZGl0aW9uOiBlZGdlIGlycSBwb2xhcml0eSB2YWx1ZSBpcyBz
YW1lIHdpdGgNCmlucHV0IHNpZ25hbC4gDQplLmcuDQpEZWZhdWx0IHZhbHVlOiBHUElPIGlucHV0
IGlzIGhpZ2gsIHRyaWdnZXIgdHlwZSBpcyBmYWxsaW5nX2VkZ2UuDQpVc2VyIHdhbnQgbW9kaWZ5
IHRyaWdnZXIgdHlwZSBpcyByaXNpbmdfZWRnZSB1bmRlciBzb21lIGNlcnRhaW4NCmNpcmN1bXN0
YW5jZXMsIGl0IHdpbGwgZ2VuZXJhdGUgc3B1cmlvdXMgaW50ZXJydXB0IGJ1dCBleHRlcm5hbCBz
aWduYWwNCm1haW50YWluIGhpZ2guDQpTbyB3ZSBuZWVkIGFjayBpbnRlcnJ1cHQgYWZ0ZXIgdHJp
Z2dlcl90eXBlIHNldHRpbmcgaXMgY29tcGxldGVkLg0KDQptdGtfZWludF9mbGlwX2VkZ2UgaXMg
Zm9yIGR1YWxfZWRnZSwgdGhlIHBvbGFyaXR5IHNldHRpbmcgYmFzZWQgb24NCmN1cnJlbnQgZ3Bp
byBpbnB1dCBzaWduYWw6DQppZiAoaW5wdXQgPT0gaGlnaCkNCglwb2xhcml0eSA9IGxvdzsgLyog
ZmFsbGluZ19lZGdlICovDQplbHNlDQoJcG9sYXJpdHkgPSBoaWdoOyAvKiByaXNpbmdfZWRnZSAq
Lw0KVGhlbiBpdCdzIG5vdCBjYXVzZSBhIHNwdXJpb3VzIGludGVycnVwdC4NCj4gPiA+ID4gKyAg
ICAgICBtdGtfZWludF9hY2soZCk7DQo+ID4gPiA+ICsgICAgICAgaWYgKHVubWFzayA9PSAxKQ0K
PiA+ID4NCj4gPiA+IEp1c3QgYGlmICh1bm1hc2spYA0KPiA+IFllcyx0aGFua3MuDQo+ID4gPiA+
ICsgICAgICAgICAgICAgICBtdGtfZWludF91bm1hc2soZCk7DQo+ID4gPiA+DQo+ID4gPiA+ICAg
ICAgICAgcmV0dXJuIDA7DQo+ID4gPiA+ICB9DQo+ID4gPiA+IC0tDQo+ID4gPiA+IDIuMTguMA0K
PiA+DQoNCg==

