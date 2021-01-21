Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDBE12FE9B4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 13:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbhAUMMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 07:12:23 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:33315 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730429AbhAUMK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 07:10:26 -0500
X-UUID: 5a2df3b9216b4d6690159d9618ec6e75-20210121
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=zNZH3/LsBp9Y/OdU986Oo7orqrZZnPxXD4joO6JpwMc=;
        b=TC1PjYU0iNC3U8lh4RGmEi4O8Sd2vpPVBtSc84oBnDo4mGJT2yC/Uhv/bPwxAF7ezMxjYyTDa62ZEFgvKbUOKm2zNi3ZH1pMPxTZ8ZZ590nunUUACLQz1jOr/qhyRIaXq7C92H+bX/Unf9HZCcGveHNmg2vdLT7TFVmU8n50V94=;
X-UUID: 5a2df3b9216b4d6690159d9618ec6e75-20210121
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <hailong.fan@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1776075303; Thu, 21 Jan 2021 20:09:38 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 21 Jan
 2021 20:09:35 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 21 Jan 2021 20:09:35 +0800
Message-ID: <1611230975.2493.17.camel@mhfsdcap03>
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
        Yong Wu <yong.wu@mediatek.com>
Date:   Thu, 21 Jan 2021 20:09:35 +0800
In-Reply-To: <CANMq1KBqKUofLaM+OEaTq6PSeYomNSLvn65c+Wyi1cKsLDNboQ@mail.gmail.com>
References: <20210121075149.1310-1-hailong.fan@mediatek.com>
         <CANMq1KBqKUofLaM+OEaTq6PSeYomNSLvn65c+Wyi1cKsLDNboQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 4E6329E5FCAF1294E2B63B436C20D324CBD425A786A4F33099F48BD4223BC63E2000:8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIxLTAxLTIxIGF0IDE2OjU1ICswODAwLCBOaWNvbGFzIEJvaWNoYXQgd3JvdGU6
DQo+IE9uIFRodSwgSmFuIDIxLCAyMDIxIGF0IDM6NTIgUE0gSGFpbG9uZyBGYW4gPGhhaWxvbmcu
ZmFuQG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBXaGVuIGZsaXBwaW5nIHRoZSBwb2xh
cml0eSB3aWxsIGJlIGdlbmVyYXRlZCBpbnRlcnJ1cHQgdW5kZXIgY2VydGFpbg0KPiA+IGNpcmN1
bXN0YW5jZXMsIGJ1dCBHUElPIGV4dGVybmFsIHNpZ25hbCBoYXMgbm90IGNoYW5nZWQuDQo+ID4g
VGhlbiwgbWFzayB0aGUgaW50ZXJydXB0IGJlZm9yZSBwb2xhcml0eSBzZXR0aW5nLCBhbmQgY2xl
YXIgdGhlDQo+ID4gdW5leHBlY3RlZCBpbnRlcnJ1cHQgYWZ0ZXIgdHJpZ2dlciB0eXBlIHNldHRp
bmcgY29tcGxldGVkLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSGFpbG9uZyBGYW4gPGhhaWxv
bmcuZmFuQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiBSZXNlbmQgc2luY2Ugc29tZSBzZXJ2
ZXIgcmVqZWN0Lg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3BpbmN0cmwvbWVkaWF0ZWsvbXRrLWVp
bnQuYyB8IDEzICsrKysrKysrKysrLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9waW5j
dHJsL21lZGlhdGVrL210ay1laW50LmMgYi9kcml2ZXJzL3BpbmN0cmwvbWVkaWF0ZWsvbXRrLWVp
bnQuYw0KPiA+IGluZGV4IDIyNzM2ZjYwYzE2Yy4uM2FjZGE2YmI0MDFlIDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvcGluY3RybC9tZWRpYXRlay9tdGstZWludC5jDQo+ID4gKysrIGIvZHJpdmVy
cy9waW5jdHJsL21lZGlhdGVrL210ay1laW50LmMNCj4gPiBAQCAtMTU3LDYgKzE1Nyw3IEBAIHN0
YXRpYyB2b2lkIG10a19laW50X2FjayhzdHJ1Y3QgaXJxX2RhdGEgKmQpDQo+ID4gIHN0YXRpYyBp
bnQgbXRrX2VpbnRfc2V0X3R5cGUoc3RydWN0IGlycV9kYXRhICpkLCB1bnNpZ25lZCBpbnQgdHlw
ZSkNCj4gPiAgew0KPiA+ICAgICAgICAgc3RydWN0IG10a19laW50ICplaW50ID0gaXJxX2RhdGFf
Z2V0X2lycV9jaGlwX2RhdGEoZCk7DQo+ID4gKyAgICAgICB1bnNpZ25lZCBpbnQgdW5tYXNrOw0K
PiANCj4gYm9vbD8NClllcyx0aGFua3MuDQo+IA0KPiA+ICAgICAgICAgdTMyIG1hc2sgPSBCSVQo
ZC0+aHdpcnEgJiAweDFmKTsNCj4gPiAgICAgICAgIHZvaWQgX19pb21lbSAqcmVnOw0KPiA+DQo+
ID4gQEAgLTE3Myw2ICsxNzQsMTMgQEAgc3RhdGljIGludCBtdGtfZWludF9zZXRfdHlwZShzdHJ1
Y3QgaXJxX2RhdGEgKmQsIHVuc2lnbmVkIGludCB0eXBlKQ0KPiA+ICAgICAgICAgZWxzZQ0KPiA+
ICAgICAgICAgICAgICAgICBlaW50LT5kdWFsX2VkZ2VbZC0+aHdpcnFdID0gMDsNCj4gPg0KPiA+
ICsgICAgICAgaWYgKCFtdGtfZWludF9nZXRfbWFzayhlaW50LCBkLT5od2lycSkpIHsNCj4gPiAr
ICAgICAgICAgICAgICAgbXRrX2VpbnRfbWFzayhkKTsNCj4gPiArICAgICAgICAgICAgICAgdW5t
YXNrID0gMTsNCj4gPiArICAgICAgIH0gZWxzZSB7DQo+ID4gKyAgICAgICAgICAgICAgIHVubWFz
ayA9IDA7DQo+ID4gKyAgICAgICB9DQo+ID4gKw0KPiA+ICAgICAgICAgaWYgKHR5cGUgJiAoSVJR
X1RZUEVfTEVWRUxfTE9XIHwgSVJRX1RZUEVfRURHRV9GQUxMSU5HKSkgew0KPiA+ICAgICAgICAg
ICAgICAgICByZWcgPSBtdGtfZWludF9nZXRfb2Zmc2V0KGVpbnQsIGQtPmh3aXJxLCBlaW50LT5y
ZWdzLT5wb2xfY2xyKTsNCj4gPiAgICAgICAgICAgICAgICAgd3JpdGVsKG1hc2ssIHJlZyk7DQo+
ID4gQEAgLTE4OSw4ICsxOTcsOSBAQCBzdGF0aWMgaW50IG10a19laW50X3NldF90eXBlKHN0cnVj
dCBpcnFfZGF0YSAqZCwgdW5zaWduZWQgaW50IHR5cGUpDQo+ID4gICAgICAgICAgICAgICAgIHdy
aXRlbChtYXNrLCByZWcpOw0KPiA+ICAgICAgICAgfQ0KPiA+DQo+ID4gLSAgICAgICBpZiAoZWlu
dC0+ZHVhbF9lZGdlW2QtPmh3aXJxXSkNCj4gPiAtICAgICAgICAgICAgICAgbXRrX2VpbnRfZmxp
cF9lZGdlKGVpbnQsIGQtPmh3aXJxKTsNCj4gDQo+IFdoeSBhcmUgeW91IGRyb3BwaW5nIHRoaXM/
IEFyZW4ndCB3ZSBhdCByaXNrIHRvIG1pc3MgdGhlIGZpcnN0IGVkZ2UNCj4gYWZ0ZXIgbXRrX2Vp
bnRfc2V0X3R5cGUgaXMgY2FsbGVkPw0KbXRrX2VpbnRfdW5tYXNrKCkgd2lsbCBkbyBpdC4NCklm
IHVubWFzayAhPSAxLCB1c2VyIG5lZWQgdG8gY2FsbCBtdGtfZWludF91bm1hc2soKSB0byBlbmFi
bGUgdGhlDQppbnRlcnJ1cHQgYmVmb3JlIHVzZSBpdCwgdGhhbmtzLg0KPiA+ICsgICAgICAgbXRr
X2VpbnRfYWNrKGQpOw0KPiA+ICsgICAgICAgaWYgKHVubWFzayA9PSAxKQ0KPiANCj4gSnVzdCBg
aWYgKHVubWFzaylgDQpZZXMsdGhhbmtzLg0KPiA+ICsgICAgICAgICAgICAgICBtdGtfZWludF91
bm1hc2soZCk7DQo+ID4NCj4gPiAgICAgICAgIHJldHVybiAwOw0KPiA+ICB9DQo+ID4gLS0NCj4g
PiAyLjE4LjANCg0K

