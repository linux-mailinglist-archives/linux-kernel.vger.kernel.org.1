Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B39272BFD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 18:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbgIUQZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 12:25:56 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:41748 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726795AbgIUQZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 12:25:53 -0400
X-UUID: 4525052a9fc94ad78410c8aa92d2a3a3-20200922
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Wqur0A/O4zCVq+R1isOtEyenroFb1CxOmxqgph5t7K8=;
        b=QKd/jSJrHQBWbNJbHDv/cRTkTgSNh2JEb4G1Hu0mGc4J+To8yClG33Thd1Pp/TielJ5SNhNKT4MgQ/Y/p8yiCbU6wkSUZ+TlPI3ydIJ3eXwywfEkmKXvebgW22XitMSobzHWcFM9osPE9WgPhChiuLEVcLAEmFbQEEELxysu+Lo=;
X-UUID: 4525052a9fc94ad78410c8aa92d2a3a3-20200922
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2094375674; Tue, 22 Sep 2020 00:25:46 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 22 Sep 2020 00:25:42 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 22 Sep 2020 00:25:43 +0800
Message-ID: <1600705544.26565.0.camel@mtkswgap22>
Subject: Re: [PATCH v3 8/9] soc: mediatek: cmdq: add clear option in
 cmdq_pkt_wfe api
From:   Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        HS Liao <hs.liao@mediatek.com>
Date:   Tue, 22 Sep 2020 00:25:44 +0800
In-Reply-To: <728ace99-e5e6-f8bf-1687-e9b51dfae8d7@gmail.com>
References: <1594136714-11650-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1594136714-11650-9-git-send-email-dennis-yc.hsieh@mediatek.com>
         <728ace99-e5e6-f8bf-1687-e9b51dfae8d7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: CF75B351C78BB23BFE95C06D5BB530850A195FB215A3BAA5AF935BDF06F4FA5B2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF0dGhpYXMsDQoNCg0KT24gTW9uLCAyMDIwLTA5LTIxIGF0IDE4OjE5ICswMjAwLCBNYXR0
aGlhcyBCcnVnZ2VyIHdyb3RlOg0KPiANCj4gT24gMDcvMDcvMjAyMCAxNzo0NSwgRGVubmlzIFlD
IEhzaWVoIHdyb3RlOg0KPiA+IEFkZCBjbGVhciBwYXJhbWV0ZXIgdG8gbGV0IGNsaWVudCBkZWNp
ZGUgaWYNCj4gPiBldmVudCBzaG91bGQgYmUgY2xlYXIgdG8gMCBhZnRlciBHQ0UgcmVjZWl2ZSBp
dC4NCj4gPiANCj4gPiBDaGFuZ2Ugc2luY2UgdjI6DQo+ID4gLSBLZWVwIGJlaGF2aW9yIGluIGRy
bSBjcnRjIGRyaXZlciBhbmQNCj4gPiAgICBzZXBhcmF0ZSBidWcgZml4IGNvZGUgaW50byBhbm90
aGVyIHBhdGNoLg0KPiANCj4gVGhpcywgc2hvdWxkIGdvLi4uDQo+IA0KPiA+IA0KPiA+IFNpZ25l
ZC1vZmYtYnk6IERlbm5pcyBZQyBIc2llaCA8ZGVubmlzLXljLmhzaWVoQG1lZGlhdGVrLmNvbT4N
Cj4gPiAtLS0NCj4gDQo+IC4uLmhlcmUgOikNCj4gDQo+IEkgZml4ZWQgdG8gY29tbWl0IG1lc3Nh
Z2UgYW5kIHB1c2hlZCB0aGUgcGF0Y2ggdG8gdjUuOS1uZXh0L3NvYw0KDQpnb3QgaXQsIHRoYW5r
cyBhIGxvdA0KDQoNClJlZ2FyZHMsDQpEZW5uaXMNCg0KPiANCj4gVGhhbmtzIQ0KPiANCj4gPiAg
IGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYyAgfCAgICAyICstDQo+ID4g
ICBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyAgIHwgICAgNSArKystLQ0K
PiA+ICAgaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaCB8ICAgIDMgKy0t
DQo+ID4gICBpbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oICAgIHwgICAgNSAr
KystLQ0KPiA+ICAgNCBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25z
KC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHJtX2NydGMuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KPiA+
IGluZGV4IGVjNmM5ZmZiZjM1ZS4uYzg0ZTdhMTRkNGE4IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KPiA+IEBAIC00OTAsNyArNDkwLDcgQEAgc3Rh
dGljIHZvaWQgbXRrX2RybV9jcnRjX2h3X2NvbmZpZyhzdHJ1Y3QgbXRrX2RybV9jcnRjICptdGtf
Y3J0YykNCj4gPiAgIAkJbWJveF9mbHVzaChtdGtfY3J0Yy0+Y21kcV9jbGllbnQtPmNoYW4sIDIw
MDApOw0KPiA+ICAgCQljbWRxX2hhbmRsZSA9IGNtZHFfcGt0X2NyZWF0ZShtdGtfY3J0Yy0+Y21k
cV9jbGllbnQsIFBBR0VfU0laRSk7DQo+ID4gICAJCWNtZHFfcGt0X2NsZWFyX2V2ZW50KGNtZHFf
aGFuZGxlLCBtdGtfY3J0Yy0+Y21kcV9ldmVudCk7DQo+ID4gLQkJY21kcV9wa3Rfd2ZlKGNtZHFf
aGFuZGxlLCBtdGtfY3J0Yy0+Y21kcV9ldmVudCk7DQo+ID4gKwkJY21kcV9wa3Rfd2ZlKGNtZHFf
aGFuZGxlLCBtdGtfY3J0Yy0+Y21kcV9ldmVudCwgdHJ1ZSk7DQo+ID4gICAJCW10a19jcnRjX2Rk
cF9jb25maWcoY3J0YywgY21kcV9oYW5kbGUpOw0KPiA+ICAgCQljbWRxX3BrdF9maW5hbGl6ZShj
bWRxX2hhbmRsZSk7DQo+ID4gICAJCWNtZHFfcGt0X2ZsdXNoX2FzeW5jKGNtZHFfaGFuZGxlLCBk
ZHBfY21kcV9jYiwgY21kcV9oYW5kbGUpOw0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9t
ZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRx
LWhlbHBlci5jDQo+ID4gaW5kZXggZDU1ZGMzMjk2MTA1Li41MDU2NTFiMGQ3MTUgMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gPiArKysg
Yi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiA+IEBAIC0zMTYsMTUg
KzMxNiwxNiBAQCBpbnQgY21kcV9wa3Rfd3JpdGVfc19tYXNrX3ZhbHVlKHN0cnVjdCBjbWRxX3Br
dCAqcGt0LCB1OCBoaWdoX2FkZHJfcmVnX2lkeCwNCj4gPiAgIH0NCj4gPiAgIEVYUE9SVF9TWU1C
T0woY21kcV9wa3Rfd3JpdGVfc19tYXNrX3ZhbHVlKTsNCj4gPiAgIA0KPiA+IC1pbnQgY21kcV9w
a3Rfd2ZlKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgZXZlbnQpDQo+ID4gK2ludCBjbWRxX3Br
dF93ZmUoc3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiBldmVudCwgYm9vbCBjbGVhcikNCj4gPiAg
IHsNCj4gPiAgIAlzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiBpbnN0ID0geyB7MH0gfTsNCj4gPiAr
CXUzMiBjbGVhcl9vcHRpb24gPSBjbGVhciA/IENNRFFfV0ZFX1VQREFURSA6IDA7DQo+ID4gICAN
Cj4gPiAgIAlpZiAoZXZlbnQgPj0gQ01EUV9NQVhfRVZFTlQpDQo+ID4gICAJCXJldHVybiAtRUlO
VkFMOw0KPiA+ICAgDQo+ID4gICAJaW5zdC5vcCA9IENNRFFfQ09ERV9XRkU7DQo+ID4gLQlpbnN0
LnZhbHVlID0gQ01EUV9XRkVfT1BUSU9OOw0KPiA+ICsJaW5zdC52YWx1ZSA9IENNRFFfV0ZFX09Q
VElPTiB8IGNsZWFyX29wdGlvbjsNCj4gPiAgIAlpbnN0LmV2ZW50ID0gZXZlbnQ7DQo+ID4gICAN
Cj4gPiAgIAlyZXR1cm4gY21kcV9wa3RfYXBwZW5kX2NvbW1hbmQocGt0LCBpbnN0KTsNCj4gPiBk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaCBiL2lu
Y2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmgNCj4gPiBpbmRleCBlZmJkOGE5
ZWIyZDEuLmQ1YTk4M2Q2NWYwNSAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L21haWxi
b3gvbXRrLWNtZHEtbWFpbGJveC5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9tYWlsYm94L210
ay1jbWRxLW1haWxib3guaA0KPiA+IEBAIC0yOCw4ICsyOCw3IEBADQo+ID4gICAgKiBiaXQgMTYt
Mjc6IHVwZGF0ZSB2YWx1ZQ0KPiA+ICAgICogYml0IDMxOiAxIC0gdXBkYXRlLCAwIC0gbm8gdXBk
YXRlDQo+ID4gICAgKi8NCj4gPiAtI2RlZmluZSBDTURRX1dGRV9PUFRJT04JCQkoQ01EUV9XRkVf
VVBEQVRFIHwgQ01EUV9XRkVfV0FJVCB8IFwNCj4gPiAtCQkJCQlDTURRX1dGRV9XQUlUX1ZBTFVF
KQ0KPiA+ICsjZGVmaW5lIENNRFFfV0ZFX09QVElPTgkJCShDTURRX1dGRV9XQUlUIHwgQ01EUV9X
RkVfV0FJVF9WQUxVRSkNCj4gPiAgIA0KPiA+ICAgLyoqIGNtZHEgZXZlbnQgbWF4aW11bSAqLw0K
PiA+ICAgI2RlZmluZSBDTURRX01BWF9FVkVOVAkJCTB4M2ZmDQo+ID4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggYi9pbmNsdWRlL2xpbnV4L3NvYy9t
ZWRpYXRlay9tdGstY21kcS5oDQo+ID4gaW5kZXggMzQzNTRlOTUyZjYwLi45NjA3MDRkNzU5OTQg
MTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0K
PiA+ICsrKyBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4gPiBAQCAt
MTgyLDExICsxODIsMTIgQEAgaW50IGNtZHFfcGt0X3dyaXRlX3NfbWFza192YWx1ZShzdHJ1Y3Qg
Y21kcV9wa3QgKnBrdCwgdTggaGlnaF9hZGRyX3JlZ19pZHgsDQo+ID4gICAvKioNCj4gPiAgICAq
IGNtZHFfcGt0X3dmZSgpIC0gYXBwZW5kIHdhaXQgZm9yIGV2ZW50IGNvbW1hbmQgdG8gdGhlIENN
RFEgcGFja2V0DQo+ID4gICAgKiBAcGt0Ogl0aGUgQ01EUSBwYWNrZXQNCj4gPiAtICogQGV2ZW50
Ogl0aGUgZGVzaXJlZCBldmVudCB0eXBlIHRvICJ3YWl0IGFuZCBDTEVBUiINCj4gPiArICogQGV2
ZW50Ogl0aGUgZGVzaXJlZCBldmVudCB0eXBlIHRvIHdhaXQNCj4gPiArICogQGNsZWFyOgljbGVh
ciBldmVudCBvciBub3QgYWZ0ZXIgZXZlbnQgYXJyaXZlDQo+ID4gICAgKg0KPiA+ICAgICogUmV0
dXJuOiAwIGZvciBzdWNjZXNzOyBlbHNlIHRoZSBlcnJvciBjb2RlIGlzIHJldHVybmVkDQo+ID4g
ICAgKi8NCj4gPiAtaW50IGNtZHFfcGt0X3dmZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IGV2
ZW50KTsNCj4gPiAraW50IGNtZHFfcGt0X3dmZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IGV2
ZW50LCBib29sIGNsZWFyKTsNCj4gPiAgIA0KPiA+ICAgLyoqDQo+ID4gICAgKiBjbWRxX3BrdF9j
bGVhcl9ldmVudCgpIC0gYXBwZW5kIGNsZWFyIGV2ZW50IGNvbW1hbmQgdG8gdGhlIENNRFEgcGFj
a2V0DQo+ID4gDQoNCg==

