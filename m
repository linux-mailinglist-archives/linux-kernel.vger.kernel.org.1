Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F363020C8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 04:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbhAYDS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 22:18:29 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:42707 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727024AbhAYDRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 22:17:40 -0500
X-UUID: 8f3baea1f7b840a08ffedcf7441ee9f1-20210125
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=lLKMVs8fE2vVdWsZajBheeSZ7xutmr1c+2PDYuBc2xA=;
        b=KNxbYJs9w7tq3lEVE6nW+oWXR98auhBoBMxvnSqCKNygV8Uu8+CmyT6PoIKVzNFOtUtt6NKdwJOkIDh30WriPJFauHknPRlsDtrNvdNmY6/wlf+am1oJhjdipkcKhpMga917aboFB2XYb1CMORgz3QR+qMMTc/0qkLsqTO2vyKg=;
X-UUID: 8f3baea1f7b840a08ffedcf7441ee9f1-20210125
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <hailong.fan@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1414889028; Mon, 25 Jan 2021 11:16:51 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 25 Jan
 2021 11:16:44 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 25 Jan 2021 11:16:43 +0800
Message-ID: <1611544603.1248.4.camel@mhfsdcap03>
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
        Yong Wu <yong.wu@mediatek.com>, <zhengnan.chen@mediatek.com>,
        <hailong.fan@mediatek>
Date:   Mon, 25 Jan 2021 11:16:43 +0800
In-Reply-To: <CANMq1KDa_aO_wtQAZofruN7r7BuvRTNGKkmfgTf2oM7ab9425g@mail.gmail.com>
References: <20210121075149.1310-1-hailong.fan@mediatek.com>
         <CANMq1KBqKUofLaM+OEaTq6PSeYomNSLvn65c+Wyi1cKsLDNboQ@mail.gmail.com>
         <1611230975.2493.17.camel@mhfsdcap03>
         <CANMq1KCXrEGrNrOwivrchXyawzKySVzQoxA1goYC-eh-auNFCA@mail.gmail.com>
         <1611283438.2493.23.camel@mhfsdcap03>
         <CANMq1KDa_aO_wtQAZofruN7r7BuvRTNGKkmfgTf2oM7ab9425g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 9A7BAF05F21477708E1562AEFAEB3544FFCDA7ABFCCC70DE90D0C7139706089C2000:8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIxLTAxLTIyIGF0IDE4OjU0ICswODAwLCBOaWNvbGFzIEJvaWNoYXQgd3JvdGU6
DQo+IE9uIEZyaSwgSmFuIDIyLCAyMDIxIGF0IDEwOjQ0IEFNIG10azE1MTAzIDxoYWlsb25nLmZh
bkBtZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+DQo+ID4gT24gVGh1LCAyMDIxLTAxLTIxIGF0IDIw
OjEzICswODAwLCBOaWNvbGFzIEJvaWNoYXQgd3JvdGU6DQo+ID4gPiBPbiBUaHUsIEphbiAyMSwg
MjAyMSBhdCA4OjA5IFBNIG10azE1MTAzIDxoYWlsb25nLmZhbkBtZWRpYXRlay5jb20+IHdyb3Rl
Og0KPiA+ID4gPg0KPiA+ID4gPiBPbiBUaHUsIDIwMjEtMDEtMjEgYXQgMTY6NTUgKzA4MDAsIE5p
Y29sYXMgQm9pY2hhdCB3cm90ZToNCj4gPiA+ID4gPiBPbiBUaHUsIEphbiAyMSwgMjAyMSBhdCAz
OjUyIFBNIEhhaWxvbmcgRmFuIDxoYWlsb25nLmZhbkBtZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+
ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFdoZW4gZmxpcHBpbmcgdGhlIHBvbGFyaXR5IHdpbGwgYmUg
Z2VuZXJhdGVkIGludGVycnVwdCB1bmRlciBjZXJ0YWluDQo+ID4gPiA+ID4gPiBjaXJjdW1zdGFu
Y2VzLCBidXQgR1BJTyBleHRlcm5hbCBzaWduYWwgaGFzIG5vdCBjaGFuZ2VkLg0KPiA+ID4gPiA+
ID4gVGhlbiwgbWFzayB0aGUgaW50ZXJydXB0IGJlZm9yZSBwb2xhcml0eSBzZXR0aW5nLCBhbmQg
Y2xlYXIgdGhlDQo+ID4gPiA+ID4gPiB1bmV4cGVjdGVkIGludGVycnVwdCBhZnRlciB0cmlnZ2Vy
IHR5cGUgc2V0dGluZyBjb21wbGV0ZWQuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gU2lnbmVk
LW9mZi1ieTogSGFpbG9uZyBGYW4gPGhhaWxvbmcuZmFuQG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4g
PiA+IC0tLQ0KPiA+ID4gPiA+ID4gUmVzZW5kIHNpbmNlIHNvbWUgc2VydmVyIHJlamVjdC4NCj4g
PiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ID4gIGRyaXZlcnMvcGluY3RybC9tZWRpYXRlay9tdGst
ZWludC5jIHwgMTMgKysrKysrKysrKystLQ0KPiA+ID4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAx
MSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BpbmN0cmwvbWVkaWF0ZWsvbXRrLWVpbnQuYyBiL2RyaXZl
cnMvcGluY3RybC9tZWRpYXRlay9tdGstZWludC5jDQo+ID4gPiA+ID4gPiBpbmRleCAyMjczNmY2
MGMxNmMuLjNhY2RhNmJiNDAxZSAxMDA2NDQNCj4gPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvcGlu
Y3RybC9tZWRpYXRlay9tdGstZWludC5jDQo+ID4gPiA+ID4gPiArKysgYi9kcml2ZXJzL3BpbmN0
cmwvbWVkaWF0ZWsvbXRrLWVpbnQuYw0KPiA+ID4gPiA+ID4gQEAgLTE1Nyw2ICsxNTcsNyBAQCBz
dGF0aWMgdm9pZCBtdGtfZWludF9hY2soc3RydWN0IGlycV9kYXRhICpkKQ0KPiA+ID4gPiA+ID4g
IHN0YXRpYyBpbnQgbXRrX2VpbnRfc2V0X3R5cGUoc3RydWN0IGlycV9kYXRhICpkLCB1bnNpZ25l
ZCBpbnQgdHlwZSkNCj4gPiA+ID4gPiA+ICB7DQo+ID4gPiA+ID4gPiAgICAgICAgIHN0cnVjdCBt
dGtfZWludCAqZWludCA9IGlycV9kYXRhX2dldF9pcnFfY2hpcF9kYXRhKGQpOw0KPiA+ID4gPiA+
ID4gKyAgICAgICB1bnNpZ25lZCBpbnQgdW5tYXNrOw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gYm9v
bD8NCj4gPiA+ID4gWWVzLHRoYW5rcy4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gICAgICAgICB1
MzIgbWFzayA9IEJJVChkLT5od2lycSAmIDB4MWYpOw0KPiA+ID4gPiA+ID4gICAgICAgICB2b2lk
IF9faW9tZW0gKnJlZzsNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBAQCAtMTczLDYgKzE3NCwx
MyBAQCBzdGF0aWMgaW50IG10a19laW50X3NldF90eXBlKHN0cnVjdCBpcnFfZGF0YSAqZCwgdW5z
aWduZWQgaW50IHR5cGUpDQo+ID4gPiA+ID4gPiAgICAgICAgIGVsc2UNCj4gPiA+ID4gPiA+ICAg
ICAgICAgICAgICAgICBlaW50LT5kdWFsX2VkZ2VbZC0+aHdpcnFdID0gMDsNCj4gPiA+ID4gPiA+
DQo+ID4gPiA+ID4gPiArICAgICAgIGlmICghbXRrX2VpbnRfZ2V0X21hc2soZWludCwgZC0+aHdp
cnEpKSB7DQo+ID4gPiA+ID4gPiArICAgICAgICAgICAgICAgbXRrX2VpbnRfbWFzayhkKTsNCj4g
PiA+ID4gPiA+ICsgICAgICAgICAgICAgICB1bm1hc2sgPSAxOw0KPiA+ID4gPiA+ID4gKyAgICAg
ICB9IGVsc2Ugew0KPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgIHVubWFzayA9IDA7DQo+ID4g
PiA+ID4gPiArICAgICAgIH0NCj4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ICAgICAgICAgaWYg
KHR5cGUgJiAoSVJRX1RZUEVfTEVWRUxfTE9XIHwgSVJRX1RZUEVfRURHRV9GQUxMSU5HKSkgew0K
PiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgIHJlZyA9IG10a19laW50X2dldF9vZmZzZXQoZWlu
dCwgZC0+aHdpcnEsIGVpbnQtPnJlZ3MtPnBvbF9jbHIpOw0KPiA+ID4gPiA+ID4gICAgICAgICAg
ICAgICAgIHdyaXRlbChtYXNrLCByZWcpOw0KPiA+ID4gPiA+ID4gQEAgLTE4OSw4ICsxOTcsOSBA
QCBzdGF0aWMgaW50IG10a19laW50X3NldF90eXBlKHN0cnVjdCBpcnFfZGF0YSAqZCwgdW5zaWdu
ZWQgaW50IHR5cGUpDQo+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgd3JpdGVsKG1hc2ssIHJl
Zyk7DQo+ID4gPiA+ID4gPiAgICAgICAgIH0NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiAtICAg
ICAgIGlmIChlaW50LT5kdWFsX2VkZ2VbZC0+aHdpcnFdKQ0KPiA+ID4gPiA+ID4gLSAgICAgICAg
ICAgICAgIG10a19laW50X2ZsaXBfZWRnZShlaW50LCBkLT5od2lycSk7DQo+ID4gPiA+ID4NCj4g
PiA+ID4gPiBXaHkgYXJlIHlvdSBkcm9wcGluZyB0aGlzPyBBcmVuJ3Qgd2UgYXQgcmlzayB0byBt
aXNzIHRoZSBmaXJzdCBlZGdlDQo+ID4gPiA+ID4gYWZ0ZXIgbXRrX2VpbnRfc2V0X3R5cGUgaXMg
Y2FsbGVkPw0KPiA+ID4gPiBtdGtfZWludF91bm1hc2soKSB3aWxsIGRvIGl0Lg0KPiA+ID4gPiBJ
ZiB1bm1hc2sgIT0gMSwgdXNlciBuZWVkIHRvIGNhbGwgbXRrX2VpbnRfdW5tYXNrKCkgdG8gZW5h
YmxlIHRoZQ0KPiA+ID4gPiBpbnRlcnJ1cHQgYmVmb3JlIHVzZSBpdCwgdGhhbmtzLg0KPiA+ID4N
Cj4gPiA+IE1ha2VzIHNlbnNlLCBJIGp1c3QgaGF2ZSBvbmUgbW9yZSB3b3JyeToNCj4gPiA+IGh0
dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L2xhdGVzdC9zb3VyY2UvZHJpdmVycy9waW5j
dHJsL21lZGlhdGVrL210ay1laW50LmMjTDEyMg0KPiA+ID4NCj4gPiA+IG10a19laW50X3VubWFz
ayB1bm1hc2tzIHRoZSBpbnRlcnJ1cHQgX2JlZm9yZV8gdGhlIGVkZ2UgaXMgZmxpcHBlZCwNCj4g
PiA+IGNvdWxkIHRoaXMgY2F1c2UgYSBzcHVyaW91cyBpbnRlcnJ1cHQ/IE9uIGFueSB1bm1hc2sg
b3BlcmF0aW9uIC0tIG5vdA0KPiA+ID4ganVzdCBvbiBtdGtfZWludF9zZXRfdHlwZSAoc28gdGhp
cyBpcyB0ZWNobmljYWxseSBhbm90aGVyIHByb2JsZW0sDQo+ID4gPiB0aGF0IHNob3VsZCBiZSBm
aXhlZCBhcyBhIHNlcGFyYXRlIHBhdGNoKQ0KPiA+DQo+ID4gVGhpcyBzaXR1YXRpb24gd2lsbCBu
b3QgaGFwcGVuLg0KPiA+DQo+ID4gU3B1cmlvdXMgaW50ZXJydXB0IG9jY3VyIGNvbmRpdGlvbjog
ZWRnZSBpcnEgcG9sYXJpdHkgdmFsdWUgaXMgc2FtZSB3aXRoDQo+ID4gaW5wdXQgc2lnbmFsLg0K
PiA+IGUuZy4NCj4gPiBEZWZhdWx0IHZhbHVlOiBHUElPIGlucHV0IGlzIGhpZ2gsIHRyaWdnZXIg
dHlwZSBpcyBmYWxsaW5nX2VkZ2UuDQo+ID4gVXNlciB3YW50IG1vZGlmeSB0cmlnZ2VyIHR5cGUg
aXMgcmlzaW5nX2VkZ2UgdW5kZXIgc29tZSBjZXJ0YWluDQo+ID4gY2lyY3Vtc3RhbmNlcywgaXQg
d2lsbCBnZW5lcmF0ZSBzcHVyaW91cyBpbnRlcnJ1cHQgYnV0IGV4dGVybmFsIHNpZ25hbA0KPiA+
IG1haW50YWluIGhpZ2guDQo+ID4gU28gd2UgbmVlZCBhY2sgaW50ZXJydXB0IGFmdGVyIHRyaWdn
ZXJfdHlwZSBzZXR0aW5nIGlzIGNvbXBsZXRlZC4NCj4gPg0KPiA+IG10a19laW50X2ZsaXBfZWRn
ZSBpcyBmb3IgZHVhbF9lZGdlLCB0aGUgcG9sYXJpdHkgc2V0dGluZyBiYXNlZCBvbg0KPiA+IGN1
cnJlbnQgZ3BpbyBpbnB1dCBzaWduYWw6DQo+ID4gaWYgKGlucHV0ID09IGhpZ2gpDQo+ID4gICAg
ICAgICBwb2xhcml0eSA9IGxvdzsgLyogZmFsbGluZ19lZGdlICovDQo+ID4gZWxzZQ0KPiA+ICAg
ICAgICAgcG9sYXJpdHkgPSBoaWdoOyAvKiByaXNpbmdfZWRnZSAqLw0KPiA+IFRoZW4gaXQncyBu
b3QgY2F1c2UgYSBzcHVyaW91cyBpbnRlcnJ1cHQuDQo+IA0KPiBPa2F5IGxldCBtZSB0cnkgdG8g
bWFrZSBzdXJlIEkgZm9sbG93Og0KPiANCj4gLSBTYXkgaW50ZXJydXB0IGlzIGN1cnJlbnRseSBJ
UlFfVFlQRV9FREdFX0ZBTExJTkcgKGFuZCBHUElPIGlzIGhpZ2ggYW5kIHN0YWJsZSkNCj4gLSBt
dGtfZWludF9zZXRfdHlwZShkLCBJUlFfVFlQRV9FREdFX0JPVEgpDQo+IC0gbXRrX2VpbnRfbWFz
ayhkKQ0KPiAtIChubyBtYXNrIGNoYW5nZWQsIGp1c3QgZWludC0+ZHVhbF9lZGdlKQ0KPiAtIG10
a19laW50X2FjayhkKSAobm90IGFjdHVhbGx5IG5lZWRlZCBpbiB0aGlzIGV4YW1wbGUpDQo+IC0g
bXRrX2VpbnRfdW5tYXNrKGQpDQo+ICAgLSBIVyByZWcgdW5tYXNrIChjYW4ndCBnZW5lcmF0ZSBh
biBpbnRlcnJ1cHQgYXMgYW55dGhpbmcgdGhhdCB3b3VsZA0KPiBoYXZlIGhhcHBlbmVkIGlzIGFj
a2VkIGFscmVhZHkgLS0gZXZlbiB3aXRoIGRpZmZlcmVudCBwcmV2aW91cy9uZXcNCj4gdHlwZXMg
dGhhbiBteSBleGFtcGxlKQ0KPiAgIC0gZmxpcF9lZGdlICh3aWxsIHN3YXAgcG9sYXJpdHkgYXMg
bmVlZGVkIGJ1dCBjYW4ndCBnZW5lcmF0ZQ0KPiBpbnRlcnJ1cHQgYXMgaXQgd29uJ3Qgc2V0IHRo
ZSBwb2xhcml0eSB0byBiZSB0aGUgc2FtZSBhcyB0aGUgY3VycmVudA0KPiBHUElPIHN0YXRlKQ0K
PiANCj4gT2theSwgSSB0aGluayBJJ20gY29udmluY2VkLg0KPiANCj4gUGxlYXNlIGZpeCB0aGUg
bml0cyBhbmQgdGhlbiB5b3UgY2FuIGFkZA0KVGhhbmtzIGEgbG90IGZvciB5b3VyIGNvbW1lbnRz
Lg0KVjIgcGF0Y2ggaGFzIGJlZW4gc2VudCB0byB5b3UsIHBsZWFzZSBoZWxwIHJldmlldyBpdCwg
dGh4Lg0KDQo+IA0KPiBSZXZpZXdlZC1ieTogTmljb2xhcyBCb2ljaGF0IDxkcmlua2NhdEBjaHJv
bWl1bS5vcmc+DQo+IA0KPiA+ID4gPiA+ID4gKyAgICAgICBtdGtfZWludF9hY2soZCk7DQo+ID4g
PiA+ID4gPiArICAgICAgIGlmICh1bm1hc2sgPT0gMSkNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEp1
c3QgYGlmICh1bm1hc2spYA0KPiA+ID4gPiBZZXMsdGhhbmtzLg0KPiA+ID4gPiA+ID4gKyAgICAg
ICAgICAgICAgIG10a19laW50X3VubWFzayhkKTsNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiAg
ICAgICAgIHJldHVybiAwOw0KPiA+ID4gPiA+ID4gIH0NCj4gPiA+ID4gPiA+IC0tDQo+ID4gPiA+
ID4gPiAyLjE4LjANCj4gPiA+ID4NCj4gPg0KDQo=

