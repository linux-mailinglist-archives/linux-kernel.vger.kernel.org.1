Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E43B2E1171
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 02:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgLWBmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 20:42:06 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:40524 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726514AbgLWBmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 20:42:05 -0500
X-UUID: 196055863cf8486b935c4e8cc7f87ff0-20201223
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:Reply-To:From:Subject:Message-ID; bh=bCO1MdnugxBGFYFW+IFPDqIJhWdsGZS/W2S81orE9VU=;
        b=igIWUGCuSIo6X6qExWvY69gTOyBvdiIJGiz30XNEQXCUi8PjAxjA/MwWjVHsmdS1SNap6MCa9STHwIkxZ8er/yGuN9rR9gyKAzBysFamABmu/1loGq2fUZaBr8xIHylcPXccGPygGg2mpKkYDRerUsIjeMh0H04J7FrRltK1rHo=;
X-UUID: 196055863cf8486b935c4e8cc7f87ff0-20201223
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 927312940; Wed, 23 Dec 2020 09:41:19 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs05n1.mediatek.inc
 (172.21.101.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 23 Dec
 2020 09:41:14 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 23 Dec 2020 09:41:16 +0800
Message-ID: <1608687676.18252.11.camel@mhfsdcap03>
Subject: Re: [PATCH v2, 14/17] soc: mediatek: mmsys: Use function call for
 setting mmsys ovl mout register
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
Reply-To: Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
CC:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        "Rob Herring" <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 23 Dec 2020 09:41:16 +0800
In-Reply-To: <CANMq1KBu4Ft49CUgGMxYdsv6ymWzVWK+eNBhn1t+oEN0ZwP0YA@mail.gmail.com>
References: <1607746317-4696-1-git-send-email-yongqiang.niu@mediatek.com>
         <1607746317-4696-15-git-send-email-yongqiang.niu@mediatek.com>
         <CANMq1KBu4Ft49CUgGMxYdsv6ymWzVWK+eNBhn1t+oEN0ZwP0YA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTEyLTE1IGF0IDIxOjQyICswODAwLCBOaWNvbGFzIEJvaWNoYXQgd3JvdGU6
DQo+IE9uIFNhdCwgRGVjIDEyLCAyMDIwIGF0IDEyOjEzIFBNIFlvbmdxaWFuZyBOaXUNCj4gPHlv
bmdxaWFuZy5uaXVAbWVkaWF0ZWsuY29tPiB3cm90ZToNCj4gPg0KPiA+IFVzZSBmdW5jdGlvbiBj
YWxsIGZvciBzZXR0aW5nIG1tc3lzIG92bCBtb3V0IHJlZ2lzdGVyDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBZb25ncWlhbmcgTml1IDx5b25ncWlhbmcubml1QG1lZGlhdGVrLmNvbT4NCj4gPiAt
LS0NCj4gPiAgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbW1zeXMvbXRrLW1tc3lzLmMgfCAxOCArKysr
KysrKysrKysrKysrKysNCj4gPiAgaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLW1tc3lz
LmggfCAgMyArKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbW1zeXMvbXRrLW1tc3lzLmMg
Yi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tbXN5cy9tdGstbW1zeXMuYw0KPiA+IGluZGV4IGNiNzZl
NjQuLjI1NThiNDIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbW1zeXMv
bXRrLW1tc3lzLmMNCj4gPiArKysgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tbXN5cy9tdGstbW1z
eXMuYw0KPiA+IEBAIC03OCw2ICs3OCwxNSBAQCB2b2lkIG10a19tbXN5c19kZHBfY29ubmVjdChz
dHJ1Y3QgZGV2aWNlICpkZXYsDQo+ID4gICAgICAgICAgICAgICAgIHJlZyA9IHJlYWRsX3JlbGF4
ZWQobW1zeXMtPnJlZ3MgKyBhZGRyKSB8IHZhbHVlOw0KPiA+ICAgICAgICAgICAgICAgICB3cml0
ZWxfcmVsYXhlZChyZWcsIG1tc3lzLT5yZWdzICsgYWRkcik7DQo+ID4gICAgICAgICB9DQo+ID4g
Kw0KPiA+ICsgICAgICAgaWYgKCFmdW5jcy0+b3ZsX21vdXRfZW4pDQo+ID4gKyAgICAgICAgICAg
ICAgIHJldHVybjsNCj4gPiArDQo+ID4gKyAgICAgICB2YWx1ZSA9IGZ1bmNzLT5vdmxfbW91dF9l
bihjdXIsIG5leHQsICZhZGRyKTsNCj4gPiArICAgICAgIGlmICh2YWx1ZSkgew0KPiA+ICsgICAg
ICAgICAgICAgICByZWcgPSByZWFkbF9yZWxheGVkKG1tc3lzLT5yZWdzICsgYWRkcikgfCB2YWx1
ZTsNCj4gPiArICAgICAgICAgICAgICAgd3JpdGVsX3JlbGF4ZWQocmVnLCBtbXN5cy0+cmVncyAr
IGFkZHIpOw0KPiA+ICsgICAgICAgfQ0KPiANCj4gVGhpcyBpcyB0ZWNobmljYWxseSBjb3JyZWN0
LCBidXQgSSdtIGFmcmFpZCB0aGlzIG1heSBiZWNvbWUgYW5kIGlzc3VlDQo+IGxhdGVyIGlmIHdl
IGhhdmUgYW5vdGhlciBmdW5jdGlvbiBsaWtlIG92bF9tb3V0X2VuLg0KPiANCj4gU28gbWF5YmUg
aXQncyBiZXR0ZXIgdG8gZG86DQo+IGlmIChmdW5jcy0+b3ZsX21vdXRfZW4pIHsNCj4gICB2YWx1
ZSA9IGZ1bmNzLT5vdmxfbW91dF9lbihjdXIsIG5leHQsICZhZGRyKTsNCj4gICAuLi4NCj4gfQ0K
DQp3aWxsIGJlIGltcHJvdmVkIGxpa2UgdGhpcyBpbiBuZXh0IHZlcnNpb24NCj4gDQo+IE9yIGFu
b3RoZXIgb3B0aW9uOiBDcmVhdGUgYSBuZXcgZnVuY3Rpb24NCj4gc3RhdGljIHVuc2lnbmVkIGlu
dCBtdGtfbW1zeXNfb3ZsX21vdXRfZW4oLi4uKSB7DQo+ICAgIGlmICghZnVuY3MtPm92bF9tb3V0
X2VuKQ0KPiAgICAgICByZXR1cm4gMDsNCj4gfQ0KPiANCj4gYW5kIGNhbGwgdGhhdCwgZm9sbG93
aW5nIHRoZSBzYW1lIHBhdHRlcm4gYXMNCj4gbXRrX21tc3lzX2RkcF9tb3V0X2VuL210a19tbXN5
c19kZHBfc2VsX2luPw0KPiANCj4gPiAgfQ0KPiA+ICBFWFBPUlRfU1lNQk9MX0dQTChtdGtfbW1z
eXNfZGRwX2Nvbm5lY3QpOw0KPiA+DQo+ID4gQEAgLTEwMyw2ICsxMTIsMTUgQEAgdm9pZCBtdGtf
bW1zeXNfZGRwX2Rpc2Nvbm5lY3Qoc3RydWN0IGRldmljZSAqZGV2LA0KPiA+ICAgICAgICAgICAg
ICAgICByZWcgPSByZWFkbF9yZWxheGVkKG1tc3lzLT5yZWdzICsgYWRkcikgJiB+dmFsdWU7DQo+
ID4gICAgICAgICAgICAgICAgIHdyaXRlbF9yZWxheGVkKHJlZywgbW1zeXMtPnJlZ3MgKyBhZGRy
KTsNCj4gPiAgICAgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgICBpZiAoIWZ1bmNzLT5vdmxfbW91
dF9lbikNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuOw0KPiA+ICsNCj4gPiArICAgICAgIHZh
bHVlID0gZnVuY3MtPm92bF9tb3V0X2VuKGN1ciwgbmV4dCwgJmFkZHIpOw0KPiA+ICsgICAgICAg
aWYgKHZhbHVlKSB7DQo+ID4gKyAgICAgICAgICAgICAgIHJlZyA9IHJlYWRsX3JlbGF4ZWQobW1z
eXMtPnJlZ3MgKyBhZGRyKSAmIH52YWx1ZTsNCj4gPiArICAgICAgICAgICAgICAgd3JpdGVsX3Jl
bGF4ZWQocmVnLCBtbXN5cy0+cmVncyArIGFkZHIpOw0KPiA+ICsgICAgICAgfQ0KPiA+ICB9DQo+
ID4gIEVYUE9SVF9TWU1CT0xfR1BMKG10a19tbXN5c19kZHBfZGlzY29ubmVjdCk7DQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLW1tc3lzLmggYi9p
bmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstbW1zeXMuaA0KPiA+IGluZGV4IGFhNGY2MGUu
LjIyMDIwM2QgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRr
LW1tc3lzLmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstbW1zeXMu
aA0KPiA+IEBAIC00OSw2ICs0OSw5IEBAIHN0cnVjdCBtdGtfbW1zeXNfY29ubl9mdW5jcyB7DQo+
ID4gICAgICAgICB1MzIgKCptb3V0X2VuKShlbnVtIG10a19kZHBfY29tcF9pZCBjdXIsDQo+ID4g
ICAgICAgICAgICAgICAgICAgICAgICBlbnVtIG10a19kZHBfY29tcF9pZCBuZXh0LA0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgaW50ICphZGRyKTsNCj4gPiArICAgICAgIHUz
MiAoKm92bF9tb3V0X2VuKShlbnVtIG10a19kZHBfY29tcF9pZCBjdXIsDQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgZW51bSBtdGtfZGRwX2NvbXBfaWQgbmV4dCwNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgKmFkZHIpOw0KPiA+ICAgICAgICAgdTMy
ICgqc2VsX2luKShlbnVtIG10a19kZHBfY29tcF9pZCBjdXIsDQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgIGVudW0gbXRrX2RkcF9jb21wX2lkIG5leHQsDQo+ID4gICAgICAgICAgICAgICAgICAg
ICAgIHVuc2lnbmVkIGludCAqYWRkcik7DQo+ID4gLS0NCj4gPiAxLjguMS4xLmRpcnR5DQo+ID4g
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gPiBMaW51
eC1tZWRpYXRlayBtYWlsaW5nIGxpc3QNCj4gPiBMaW51eC1tZWRpYXRla0BsaXN0cy5pbmZyYWRl
YWQub3JnDQo+ID4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1tZWRpYXRlaw0KDQo=

