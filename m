Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F692C3EB5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 12:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbgKYLDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 06:03:46 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:27639 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726189AbgKYLDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 06:03:46 -0500
X-UUID: 0772767d57e343e6891beb8ab16b4e8e-20201125
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=xI/ceqZKKONm10j9fLWN04WfsGQ+Y6PfpXlP79ucbtc=;
        b=Vy5FClWJFnjQyR2mZzAmi3S6inaTOenZU3qhbvrxlXtKflmvFTy6blSm+77b7dpHtGZ3iPP21cHe4J/o2+EYEqhFX0NXMoKAj5iRO99L8uhKXaq/X7K1aZ1sCha+O5L0PmBAPQyTnynkabuPPr2SCqhXMSHQDL3iZHpLJkfkkY4=;
X-UUID: 0772767d57e343e6891beb8ab16b4e8e-20201125
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 617537765; Wed, 25 Nov 2020 19:03:36 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 25 Nov
 2020 19:03:34 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 25 Nov 2020 19:03:33 +0800
Message-ID: <1606302214.26323.141.camel@mhfsdcap03>
Subject: Re: [PATCH] iommu: Improve the performance for direct_mapping
From:   Yong Wu <yong.wu@mediatek.com>
To:     Will Deacon <will@kernel.org>
CC:     <youlin.pei@mediatek.com>, <anan.sun@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <srv_heupstream@mediatek.com>, <chao.hao@mediatek.com>,
        Joerg Roedel <joro@8bytes.org>, <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        <iommu@lists.linux-foundation.org>,
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 25 Nov 2020 19:03:34 +0800
In-Reply-To: <20201124110520.GA12980@willie-the-truck>
References: <20201120090628.6566-1-yong.wu@mediatek.com>
         <20201123123258.GC10233@willie-the-truck>
         <1606209884.26323.132.camel@mhfsdcap03>
         <20201124110520.GA12980@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 3E37F2948B73A16F8990BEF5FB644CD56B780219D1EF19A777FBD0308C48F13A2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTExLTI0IGF0IDExOjA1ICswMDAwLCBXaWxsIERlYWNvbiB3cm90ZToNCj4g
T24gVHVlLCBOb3YgMjQsIDIwMjAgYXQgMDU6MjQ6NDRQTSArMDgwMCwgWW9uZyBXdSB3cm90ZToN
Cj4gPiBPbiBNb24sIDIwMjAtMTEtMjMgYXQgMTI6MzIgKzAwMDAsIFdpbGwgRGVhY29uIHdyb3Rl
Og0KPiA+ID4gT24gRnJpLCBOb3YgMjAsIDIwMjAgYXQgMDU6MDY6MjhQTSArMDgwMCwgWW9uZyBX
dSB3cm90ZToNCj4gPiA+ID4gKwkJCQl1bm1hcHBlZF9zeiA9IDA7DQo+ID4gPiA+ICsJCQl9DQo+
ID4gPiA+ICsJCQlzdGFydCArPSBwZ19zaXplOw0KPiA+ID4gPiArCQl9DQo+ID4gPiA+ICsJCWlm
ICh1bm1hcHBlZF9zeikgew0KPiA+ID4gPiArCQkJcmV0ID0gaW9tbXVfbWFwKGRvbWFpbiwgc3Rh
cnQsIHN0YXJ0LCB1bm1hcHBlZF9zeiwNCj4gPiA+ID4gKwkJCQkJZW50cnktPnByb3QpOw0KPiA+
ID4gDQo+ID4gPiBDYW4geW91IGF2b2lkIHRoaXMgaHVuayBieSBjaGFuZ2luZyB5b3VyIGxvb3Ag
Y2hlY2sgdG8gc29tZXRoaW5nIGxpa2U6DQo+ID4gPiANCj4gPiA+IAlpZiAoIXBoeXNfYWRkcikg
ew0KPiA+ID4gCQltYXBfc2l6ZSArPSBwZ19zaXplOw0KPiA+ID4gCQlpZiAoYWRkciArIHBnX3Np
emUgPCBlbmQpDQo+ID4gPiAJCQljb250aW51ZTsNCj4gPiA+IAl9DQo+ID4gDQo+ID4gVGhhbmtz
IGZvciB5b3VyIHF1aWNrIHJldmlldy4gSSBoYXZlIGZpeGVkIGFuZCB0ZXN0ZWQgaXQuIHRoZSBw
YXRjaCBpcw0KPiA+IHNpbXBsZS4gSSBjb3B5IGl0IGhlcmUuIElzIHRoaXMgcmVhZGFibGUgZm9y
IHlvdSBub3c/DQo+ID4gDQo+ID4gDQo+ID4gLS0tIGEvZHJpdmVycy9pb21tdS9pb21tdS5jDQo+
ID4gKysrIGIvZHJpdmVycy9pb21tdS9pb21tdS5jDQo+ID4gQEAgLTczNyw2ICs3MzcsNyBAQCBz
dGF0aWMgaW50DQo+ID4gaW9tbXVfY3JlYXRlX2RldmljZV9kaXJlY3RfbWFwcGluZ3Moc3RydWN0
IGlvbW11X2dyb3VwICpncm91cCwNCj4gPiAgCS8qIFdlIG5lZWQgdG8gY29uc2lkZXIgb3Zlcmxh
cHBpbmcgcmVnaW9ucyBmb3IgZGlmZmVyZW50IGRldmljZXMgKi8NCj4gPiAgCWxpc3RfZm9yX2Vh
Y2hfZW50cnkoZW50cnksICZtYXBwaW5ncywgbGlzdCkgew0KPiA+ICAJCWRtYV9hZGRyX3Qgc3Rh
cnQsIGVuZCwgYWRkcjsNCj4gPiArCQlzaXplX3QgbWFwX3NpemUgPSAwOw0KPiA+ICANCj4gPiAg
CQlpZiAoZG9tYWluLT5vcHMtPmFwcGx5X3Jlc3ZfcmVnaW9uKQ0KPiA+ICAJCQlkb21haW4tPm9w
cy0+YXBwbHlfcmVzdl9yZWdpb24oZGV2LCBkb21haW4sIGVudHJ5KTsNCj4gPiBAQCAtNzUyLDEy
ICs3NTMsMjEgQEAgc3RhdGljIGludA0KPiA+IGlvbW11X2NyZWF0ZV9kZXZpY2VfZGlyZWN0X21h
cHBpbmdzKHN0cnVjdCBpb21tdV9ncm91cCAqZ3JvdXAsDQo+ID4gIAkJCXBoeXNfYWRkcl90IHBo
eXNfYWRkcjsNCj4gPiAgDQo+ID4gIAkJCXBoeXNfYWRkciA9IGlvbW11X2lvdmFfdG9fcGh5cyhk
b21haW4sIGFkZHIpOw0KPiA+IC0JCQlpZiAocGh5c19hZGRyKQ0KPiA+IC0JCQkJY29udGludWU7
DQo+ID4gKwkJCWlmICghcGh5c19hZGRyKSB7DQo+ID4gKwkJCQltYXBfc2l6ZSArPSBwZ19zaXpl
Ow0KPiA+ICsJCQkJaWYgKGFkZHIgKyBwZ19zaXplIDwgZW5kKQ0KPiA+ICsJCQkJCWNvbnRpbnVl
Ow0KPiA+ICsJCQkJZWxzZQ0KPiANCj4gWW91IGRvbid0IG5lZWQgdGhlICdlbHNlJyBoZXJlICBe
Xl4NCj4gDQo+ID4gKwkJCQkJYWRkciArPSBwZ19zaXplOyAvKlBvaW50IHRvIEVuZCAqLw0KPiAN
Cj4gYWRkciA9IGVuZCA/DQo+IA0KPiBUaGF0IHNhaWQsIG1heWJlIHdlIGNvdWxkIHNpbXBsaWZ5
IHRoaXMgZnVydGhlciBieSBjaGFuZ2luZyB0aGUgbG9vcCBib3VuZHMNCj4gdG8gYmU6DQo+IA0K
PiAJZm9yIChhZGRyID0gc3RhcnQ7IGFkZHIgPD0gZW5kOyBhZGRyICs9IHBnX3NpemUpDQo+IA0K
PiBhbmQgY2hlY2tpbmc6DQo+IA0KPiAJaWYgKCFwaHlzX2FkZHIgJiYgYWRkciAhPSBlbmQpIHsN
Cj4gCQltYXBfc2l6ZSArPSBwZ19zaXplOw0KPiAJCWNvbnRpbnVlOw0KPiAJfQ0KPiANCj4gZG9l
cyB0aGF0IHdvcms/DQoNCkl0IHdvcmtzIGJ1dCBJIHRoaW5rIHdlIGNhbiBub3QgY2hlY2sgaW9t
bXVfaW92YV90b19waHlzKGRvbWFpbiwgZW5kKS4NCldlIHNob3VsZCBhZGQgYSAiaWYiLCBsaWtl
Og0KDQpmb3IgKGFkZHIgPSBzdGFydDsgYWRkciA8PSBlbmQ7IGFkZHIgKz0gcGdfc2l6ZSkgew0K
Li4uDQoJaWYgKGFkZHIgPCBlbmQpIHsNCgkJcGh5c19hZGRyID0gaW9tbXVfaW92YV90b19waHlz
KGRvbWFpbiwgYWRkcik7DQoJCWlmICghcGh5c19hZGRyKSB7DQoJCQltYXBfc2l6ZSArPSBwZ19z
aXplOw0KCQkJY29udGludWU7DQoJCX0NCgl9DQouLi4NCg0KDQpJZiB5b3UgZG9uJ3QgbGlrZSB0
aGlzICJpZiAoYWRkciA8IGVuZCkiLCB0aGVuIHdlIGhhdmUgdG8gYWRkIGEgImdvdG8iLg0KbGlr
ZSB0aGlzOg0KDQoNCmZvciAoYWRkciA9IHN0YXJ0OyBhZGRyIDw9IGVuZDsgYWRkciArPSBwZ19z
aXplKSB7DQogCXBoeXNfYWRkcl90IHBoeXNfYWRkcjsNCiANCglpZiAoYWRkciA9PSBlbmQpDQoJ
CWdvdG8gbWFwX2xhc3Q7DQoNCglwaHlzX2FkZHIgPSBpb21tdV9pb3ZhX3RvX3BoeXMoZG9tYWlu
LCBhZGRyKTsNCglpZiAoIXBoeXNfYWRkcikgew0KCQltYXBfc2l6ZSArPSBwZ19zaXplOw0KCQlj
b250aW51ZTsNCgl9DQoNCm1hcF9sYXN0Og0KCWlmICghbWFwX3NpemUpDQoJCWNvbnRpbnVlOw0K
CXJldCA9IGlvbW11X21hcChkb21haW4sIGFkZHIgLSBtYXBfc2l6ZSwNCgkJCWFkZHIgLSBtYXBf
c2l6ZSwgbWFwX3NpemUsIGVudHJ5LT5wcm90KTsNCglpZiAocmV0KQ0KCQlnb3RvIG91dDsNCn0N
Cg0KV2hpY2ggb25lIGlzIGJldHRlcj8NCg0KPiANCj4gV2lsbA0KPiANCj4gX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gTGludXgtbWVkaWF0ZWsgbWFp
bGluZyBsaXN0DQo+IExpbnV4LW1lZGlhdGVrQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1tZWRpYXRlaw0KDQo=

