Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C1629878E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 08:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770956AbgJZHmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 03:42:19 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:63675 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1770191AbgJZHmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 03:42:19 -0400
X-UUID: b451202fb9eb4ca7b6d1941c66e6ee5b-20201026
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=KDA+LpW6FDBz49qbTaYvO3XwD3JWyDQOAMzmFaf86MU=;
        b=JrwCHtZFB/nCXCepC9MG9nKlZ7OeettQ0mHd0/YgOk0O572rD+nH+Se1SZ1G/4XcO0bvGGqndoBO4Rqpz75j4g13cWW3bjBtkeeIWngGaRcU8aWFocPcp8Af67Bc2gPfhP6+Mrw/UKtLGYT7Axex7f0/rjJ8lgzUs1iuKnMyxqs=;
X-UUID: b451202fb9eb4ca7b6d1941c66e6ee5b-20201026
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 166890295; Mon, 26 Oct 2020 15:42:01 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 26 Oct
 2020 15:41:23 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 26 Oct 2020 15:41:22 +0800
Message-ID: <1603698083.26323.87.camel@mhfsdcap03>
Subject: Re: [PATCH v3 11/24] iommu/io-pgtable-arm-v7s: Quad lvl1 pgtable
 for MediaTek
From:   Yong Wu <yong.wu@mediatek.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzk@kernel.org>,
        Will Deacon <will@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <youlin.pei@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <chao.hao@mediatek.com>,
        <ming-fan.chen@mediatek.com>,
        Greg Kroah-Hartman <gregkh@google.com>,
        <kernel-team@android.com>
Date:   Mon, 26 Oct 2020 15:41:23 +0800
In-Reply-To: <a5713949-1d95-40f1-d35d-d99735b48294@arm.com>
References: <20200930070647.10188-1-yong.wu@mediatek.com>
         <20200930070647.10188-12-yong.wu@mediatek.com>
         <a5713949-1d95-40f1-d35d-d99735b48294@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 020A65BDCF4EA27467567D031B54810B516A69E7C2B6BB71FC4C0F5EDD0582DF2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTEwLTIzIGF0IDE1OjEwICswMTAwLCBSb2JpbiBNdXJwaHkgd3JvdGU6DQo+
IE9uIDIwMjAtMDktMzAgMDg6MDYsIFlvbmcgV3Ugd3JvdGU6DQo+ID4gVGhlIHN0YW5kYXJkIGlu
cHV0IGlvdmEgYml0cyBpcyAzMi4gTWVkaWFUZWsgcXVhZCB0aGUgbHZsMSBwYWdldGFibGUNCj4g
PiAoNCAqIGx2bDEpLiBObyBjaGFuZ2UgZm9yIGx2bDIgcGFnZXRhYmxlLiBUaGVuIHRoZSBpb3Zh
IGJpdHMgY2FuIHJlYWNoDQo+ID4gMzRiaXQuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogWW9u
ZyBXdSA8eW9uZy53dUBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2lvbW11
L2lvLXBndGFibGUtYXJtLXY3cy5jIHwgMTMgKysrKysrKysrKy0tLQ0KPiA+ICAgZHJpdmVycy9p
b21tdS9tdGtfaW9tbXUuYyAgICAgICAgICB8ICAyICstDQo+ID4gICAyIGZpbGVzIGNoYW5nZWQs
IDExIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvaW9tbXUvaW8tcGd0YWJsZS1hcm0tdjdzLmMgYi9kcml2ZXJzL2lvbW11L2lvLXBn
dGFibGUtYXJtLXY3cy5jDQo+ID4gaW5kZXggODM2MmZkZjc2NjU3Li4zMDZiYWUyNzU1ZWQgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9pb21tdS9pby1wZ3RhYmxlLWFybS12N3MuYw0KPiA+ICsr
KyBiL2RyaXZlcnMvaW9tbXUvaW8tcGd0YWJsZS1hcm0tdjdzLmMNCj4gPiBAQCAtNTAsMTAgKzUw
LDE3IEBADQo+ID4gICAgKi8NCj4gPiAgICNkZWZpbmUgQVJNX1Y3U19BRERSX0JJVFMJCTMyDQo+
ID4gICAjZGVmaW5lIF9BUk1fVjdTX0xWTF9CSVRTKGx2bCkJCSgxNiAtIChsdmwpICogNCkNCj4g
PiArLyogTWVkaWFUZWs6IHRvdGFsbHkgMzRiaXRzLCAxNGJpdHMgYXQgbHZsMSBhbmQgOGJpdHMg
YXQgbHZsMi4gKi8NCj4gPiArI2RlZmluZSBfQVJNX1Y3U19MVkxfQklUU19NVEsobHZsKQkoMjAg
LSAobHZsKSAqIDYpDQo+IA0KPiBUaGlzIHNob3VsZCBkZWZpbmVkIGluIHRlcm1zIG9mIGJvdGgg
bHZsIGFuZCBjZmctPmlhcy4gVGhlIGZvcm11bGEgaGVyZSANCj4gaXMgbm90aGluZyBtb3JlIHRo
YW4gYSBkaXNndXN0aW5nIHRyaWNrIEkgbWFkZSB1cCBzaW5jZSBhIGxpbmVhciANCj4gaW50ZXJw
b2xhdGlvbiBoYXBwZW5lZCB0byBmaXQgdGhlIHJlcXVpcmVkIG51bWJlcnMuIFRoYXQgc2FpZCwg
YWxsIG9mIA0KPiB0aGVzZSBiaXRzIHByZXRlbmRpbmcgdGhhdCBzaG9ydC1kZXNjcmlwdG9yIGlz
IGEgd2VsbC1kZWZpbmVkIHJlY3Vyc2l2ZSANCj4gZm9ybWF0IG9ubHkgc2VydmVkIHRvIGFsbG93
IHRoZSByZXN0IG9mIHRoZSBjb2RlIHRvIGxvb2sgbW9yZSBsaWtlIHRoZSANCj4gTFBBRSBjb2Rl
IC0gSUlSQyB0aGV5J3ZlIGFscmVhZHkgZGl2ZXJnZWQgYSBmYWlyIGJpdCBzaW5jZSB0aGVuLCBz
byANCj4gZnJhbmtseSBhIGxvdCBvZiB0aGlzIGNvdWxkIHN0YW5kIHRvIGJlIHVucGlja2VkIGFu
ZCBtYWRlIGNvbnNpZGVyYWJseSANCj4gY2xlYXJlciBieSBzaW1wbHkgYWNjZXB0aW5nIHRoYXQg
bGV2ZWwgMSBhbmQgbGV2ZWwgMiBhcmUgZGlmZmVyZW50IGZyb20gDQo+IGVhY2ggb3RoZXIuDQoN
CklmIHRoZSBmb3JtdWxhIGlzIG5vdCBnb29kIGFuZCBtYWtlIGl0IGNsZWFyZXIsIEhvdyBhYm91
dCB0aGlzPw0KDQoNCi8qDQogKiBXZSBoYXZlIDMyIGJpdHMgdG90YWw7IDEyIGJpdHMgcmVzb2x2
ZWQgYXQgbGV2ZWwgMSwgOCBiaXRzIGF0IGxldmVsDQoyLA0KLSogYW5kIDEyIGJpdHMgaW4gYSBw
YWdlLiBXaXRoIHNvbWUgY2FyZWZ1bGx5LWNob3NlbiBjb2VmZmljaWVudHMgd2UgY2FuDQotKiBo
aWRlIHRoZSB1Z2x5IGluY29uc2lzdGVuY2llcyBiZWhpbmQgdGhlc2UgbWFjcm9zIGFuZCBhdCBs
ZWFzdCBsZXQNCnRoZQ0KLSogcmVzdCBvZiB0aGUgY29kZSBwcmV0ZW5kIHRvIGJlIHNvbWV3aGF0
IHNhbmUuDQorKiBhbmQgMTIgYml0cyBpbiBhIHBhZ2UuDQorKg0KKyogTWVkaWFUZWsgZXh0ZW5k
IDIgYml0cyB0byByZWFjaCAzNCBiaXRzLCAxNCBiaXRzIGF0IGx2bDEgYW5kIDggYml0cw0KYXQg
bHZsMi4NCiAqLw0KDQotI2RlZmluZSBfQVJNX1Y3U19MVkxfQklUUyhsdmwpCQkoMTYgLSAobHZs
KSAqIDQpDQorI2RlZmluZSBfQVJNX1Y3U19MVkwxX0JJVFNfTlIoY2ZnKSAgICAgKCgoY2ZnKS0+
aWFzID09IDMyKSA/IDEyIDogMTQpDQorI2RlZmluZSBfQVJNX1Y3U19MVkwyX0JJVFNfTlIJCTgN
CisNCisjZGVmaW5lIF9BUk1fVjdTX0xWTF9CSVRTKGx2bCwgY2ZnKSAgICBcDQorICAgICAgKCgo
bHZsKSA9PSAxKSA/IF9BUk1fVjdTX0xWTDFfQklUU19OUihjZmcpOl9BUk1fVjdTX0xWTDJfQklU
U19OUikNCg0KPiBSb2Jpbi4NCj4gDQo+ID4gICAjZGVmaW5lIEFSTV9WN1NfTFZMX1NISUZUKGx2
bCkJCShBUk1fVjdTX0FERFJfQklUUyAtICg0ICsgOCAqIChsdmwpKSkNCj4gPiAgICNkZWZpbmUg
QVJNX1Y3U19UQUJMRV9TSElGVAkJMTANCj4gPiAgIA0KPiA+IC0jZGVmaW5lIEFSTV9WN1NfUFRF
U19QRVJfTFZMKGx2bCwgY2ZnKQkoMSA8PCBfQVJNX1Y3U19MVkxfQklUUyhsdmwpKQ0KPiA+ICsj
ZGVmaW5lIEFSTV9WN1NfUFRFU19QRVJfTFZMKGx2bCwgY2ZnKQkoewkJCQlcDQo+ID4gKwlpbnQg
X2x2bCA9IGx2bDsJCQkJCQkJXA0KPiA+ICsJIWFybV92N3NfaXNfbXRrX2VuYWJsZWQoY2ZnKSA/
CQkJCQlcDQo+ID4gKwkgKDEgPDwgX0FSTV9WN1NfTFZMX0JJVFMoX2x2bCkpIDogKDEgPDwgX0FS
TV9WN1NfTFZMX0JJVFNfTVRLKF9sdmwpKTtcDQo+ID4gK30pDQo+ID4gKw0KPiA+ICAgI2RlZmlu
ZSBBUk1fVjdTX1RBQkxFX1NJWkUobHZsLCBjZmcpCQkJCQlcDQo+ID4gICAJKEFSTV9WN1NfUFRF
U19QRVJfTFZMKGx2bCwgY2ZnKSAqIHNpemVvZihhcm1fdjdzX2lvcHRlKSkNCj4gPiAgIA0KPiA+
IEBAIC02Myw3ICs3MCw3IEBADQo+ID4gICAjZGVmaW5lIF9BUk1fVjdTX0lEWF9NQVNLKGx2bCwg
Y2ZnKQkoQVJNX1Y3U19QVEVTX1BFUl9MVkwobHZsLCBjZmcpIC0gMSkNCj4gPiAgICNkZWZpbmUg
QVJNX1Y3U19MVkxfSURYKGFkZHIsIGx2bCwgY2ZnKQkoewkJCVwNCj4gPiAgIAlpbnQgX2wgPSBs
dmw7CQkJCQkJCVwNCj4gPiAtCSgodTMyKShhZGRyKSA+PiBBUk1fVjdTX0xWTF9TSElGVChfbCkp
ICYgX0FSTV9WN1NfSURYX01BU0soX2wsIGNmZyk7IFwNCj4gPiArCSgoYWRkcikgPj4gQVJNX1Y3
U19MVkxfU0hJRlQoX2wpKSAmIF9BUk1fVjdTX0lEWF9NQVNLKF9sLCBjZmcpOyBcDQo+ID4gICB9
KQ0KPiA+ICAgDQo+ID4gICAvKg0KPiA+IEBAIC03NTUsNyArNzYyLDcgQEAgc3RhdGljIHN0cnVj
dCBpb19wZ3RhYmxlICphcm1fdjdzX2FsbG9jX3BndGFibGUoc3RydWN0IGlvX3BndGFibGVfY2Zn
ICpjZmcsDQo+ID4gICB7DQo+ID4gICAJc3RydWN0IGFybV92N3NfaW9fcGd0YWJsZSAqZGF0YTsN
Cj4gPiAgIA0KPiA+IC0JaWYgKGNmZy0+aWFzID4gQVJNX1Y3U19BRERSX0JJVFMpDQo+ID4gKwlp
ZiAoY2ZnLT5pYXMgPiAoYXJtX3Y3c19pc19tdGtfZW5hYmxlZChjZmcpID8gMzQgOiBBUk1fVjdT
X0FERFJfQklUUykpDQo+ID4gICAJCXJldHVybiBOVUxMOw0KPiA+ICAgDQo+ID4gICAJaWYgKGNm
Zy0+b2FzID4gKGFybV92N3NfaXNfbXRrX2VuYWJsZWQoY2ZnKSA/IDM1IDogQVJNX1Y3U19BRERS
X0JJVFMpKQ0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jIGIvZHJp
dmVycy9pb21tdS9tdGtfaW9tbXUuYw0KPiA+IGluZGV4IGY2YTJlM2ViNTlkMi4uNmU4NWM5OTc2
YTMzIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCj4gPiArKysg
Yi9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQo+ID4gQEAgLTMxNiw3ICszMTYsNyBAQCBzdGF0
aWMgaW50IG10a19pb21tdV9kb21haW5fZmluYWxpc2Uoc3RydWN0IG10a19pb21tdV9kb21haW4g
KmRvbSkNCj4gPiAgIAkJCUlPX1BHVEFCTEVfUVVJUktfVExCSV9PTl9NQVAgfA0KPiA+ICAgCQkJ
SU9fUEdUQUJMRV9RVUlSS19BUk1fTVRLX0VYVCwNCj4gPiAgIAkJLnBnc2l6ZV9iaXRtYXAgPSBt
dGtfaW9tbXVfb3BzLnBnc2l6ZV9iaXRtYXAsDQo+ID4gLQkJLmlhcyA9IDMyLA0KPiA+ICsJCS5p
YXMgPSAzNCwNCj4gPiAgIAkJLm9hcyA9IDM1LA0KPiA+ICAgCQkudGxiID0gJm10a19pb21tdV9m
bHVzaF9vcHMsDQo+ID4gICAJCS5pb21tdV9kZXYgPSBkYXRhLT5kZXYsDQo+ID4gDQoNCg==

