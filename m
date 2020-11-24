Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A402A2C2114
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 10:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731113AbgKXJYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 04:24:55 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:2919 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730978AbgKXJYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 04:24:54 -0500
X-UUID: 1173a46cb11f40ad99644152fce63674-20201124
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=wruLeV1VxmJT3h8u8aTdJS9aBT3lPk6fj9q+96T1tpA=;
        b=m2MMLnmti+zD9v0lImNo8ElL5aR2YjwrH071EJaqDUgT7ZPCb9jIYWxOaEMU3HpRQDtoYc1rFHCBGeoEoiR1IHGVPXI4SzkmEIxuOXmv21BV1LLiQrDx/6AVdlNnU/eVSsK4TLIfWOu3BNRFFkonQJv5OQeceN6vpL8HCzPIPTI=;
X-UUID: 1173a46cb11f40ad99644152fce63674-20201124
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1399213662; Tue, 24 Nov 2020 17:24:46 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32N2.mediatek.inc
 (172.27.4.72) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 24 Nov
 2020 17:24:45 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 24 Nov 2020 17:24:43 +0800
Message-ID: <1606209884.26323.132.camel@mhfsdcap03>
Subject: Re: [PATCH] iommu: Improve the performance for direct_mapping
From:   Yong Wu <yong.wu@mediatek.com>
To:     Will Deacon <will@kernel.org>
CC:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <youlin.pei@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <chao.hao@mediatek.com>
Date:   Tue, 24 Nov 2020 17:24:44 +0800
In-Reply-To: <20201123123258.GC10233@willie-the-truck>
References: <20201120090628.6566-1-yong.wu@mediatek.com>
         <20201123123258.GC10233@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: EBCB8F6C7AAB7CEFD384B30FE7D298E2FA4811C473B599035C7F59E811168DC42000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTExLTIzIGF0IDEyOjMyICswMDAwLCBXaWxsIERlYWNvbiB3cm90ZToNCj4g
T24gRnJpLCBOb3YgMjAsIDIwMjAgYXQgMDU6MDY6MjhQTSArMDgwMCwgWW9uZyBXdSB3cm90ZToN
Cj4gPiBDdXJyZW50bHkgZGlyZWN0X21hcHBpbmcgYWx3YXlzIHVzZSB0aGUgc21hbGxlc3QgcGdz
aXplIHdoaWNoIGlzIFNaXzRLDQo+ID4gbm9ybWFsbHkgdG8gbWFwcGluZy4gVGhpcyBpcyB1bm5l
Y2Vzc2FyeS4gd2UgY291bGQgZ2F0aGVyIHRoZSBzaXplLCBhbmQNCj4gPiBjYWxsIGlvbW11X21h
cCB0aGVuLCBpb21tdV9tYXAgY291bGQgZGVjaWRlIGhvdyB0byBtYXAgYmV0dGVyIHdpdGggdGhl
DQo+ID4ganVzdCByaWdodCBwZ3NpemUuDQo+ID4gDQo+ID4gRnJvbSB0aGUgb3JpZ2luYWwgY29t
bWVudCwgd2Ugc2hvdWxkIHRha2UgY2FyZSBvdmVybGFwLCBvdGhlcndpc2UsDQo+ID4gaW9tbXVf
bWFwIG1heSByZXR1cm4gLUVFWElTVC4gSW4gdGhpcyBvdmVybGFwIGNhc2UsIHdlIHNob3VsZCBt
YXAgdGhlDQo+ID4gcHJldmlvdXMgcmVnaW9uIGJlZm9yZSBvdmVybGFwIGZpcnN0bHkuIHRoZW4g
bWFwIHRoZSBsZWZ0IHBhcnQuDQo+ID4gDQo+ID4gRWFjaCBhIGlvbW11IGRldmljZSB3aWxsIGNh
bGwgdGhpcyBkaXJlY3RfbWFwcGluZyB3aGVuIGl0cyBpb21tdQ0KPiA+IGluaXRpYWxpemUsIFRo
aXMgcGF0Y2ggaXMgZWZmZWN0aXZlIHRvIGltcHJvdmUgdGhlIGJvb3QvaW5pdGlhbGl6YXRpb24N
Cj4gPiB0aW1lIGVzcGVjaWFsbHkgd2hpbGUgaXQgb25seSBuZWVkcyBsZXZlbCAxIG1hcHBpbmcu
DQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQW5hbiBTdW4gPGFuYW4uc3VuQG1lZGlhdGVrLmNv
bT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBZb25nIFd1IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4NCj4g
PiAtLS0NCj4gPiAgZHJpdmVycy9pb21tdS9pb21tdS5jIHwgMjAgKysrKysrKysrKysrKysrKysr
LS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
DQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW9tbXUuYyBiL2RyaXZlcnMv
aW9tbXUvaW9tbXUuYw0KPiA+IGluZGV4IGRmODdjOGU4MjVmNy4uODU0YThmY2I5MjhkIDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW9tbXUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvaW9t
bXUvaW9tbXUuYw0KPiA+IEBAIC03MzcsNiArNzM3LDcgQEAgc3RhdGljIGludCBpb21tdV9jcmVh
dGVfZGV2aWNlX2RpcmVjdF9tYXBwaW5ncyhzdHJ1Y3QgaW9tbXVfZ3JvdXAgKmdyb3VwLA0KPiA+
ICAJLyogV2UgbmVlZCB0byBjb25zaWRlciBvdmVybGFwcGluZyByZWdpb25zIGZvciBkaWZmZXJl
bnQgZGV2aWNlcyAqLw0KPiA+ICAJbGlzdF9mb3JfZWFjaF9lbnRyeShlbnRyeSwgJm1hcHBpbmdz
LCBsaXN0KSB7DQo+ID4gIAkJZG1hX2FkZHJfdCBzdGFydCwgZW5kLCBhZGRyOw0KPiA+ICsJCXNp
emVfdCB1bm1hcHBlZF9zeiA9IDA7DQo+IA0KPiBJIHRoaW5rICJ1bm1hcHBlZCIgaXMgdGhlIHdy
b25nIHdvcmQgaGVyZSwgYXMgdGhpcyB2YXJpYWJsZSBhY3R1YWxseQ0KPiByZXByZXNlbnRzIHRo
ZSBhbW91bnQgd2Ugd2FudCB0byBtYXAhIEkgc3VnZ2VzdCAibWFwX3NpemUiIGluc3RlYWQuDQo+
IA0KPiA+ICAJCWlmIChkb21haW4tPm9wcy0+YXBwbHlfcmVzdl9yZWdpb24pDQo+ID4gIAkJCWRv
bWFpbi0+b3BzLT5hcHBseV9yZXN2X3JlZ2lvbihkZXYsIGRvbWFpbiwgZW50cnkpOw0KPiA+IEBA
IC03NTIsMTAgKzc1MywyNSBAQCBzdGF0aWMgaW50IGlvbW11X2NyZWF0ZV9kZXZpY2VfZGlyZWN0
X21hcHBpbmdzKHN0cnVjdCBpb21tdV9ncm91cCAqZ3JvdXAsDQo+ID4gIAkJCXBoeXNfYWRkcl90
IHBoeXNfYWRkcjsNCj4gPiAgDQo+ID4gIAkJCXBoeXNfYWRkciA9IGlvbW11X2lvdmFfdG9fcGh5
cyhkb21haW4sIGFkZHIpOw0KPiA+IC0JCQlpZiAocGh5c19hZGRyKQ0KPiA+ICsJCQlpZiAocGh5
c19hZGRyID09IDApIHsNCj4gPiArCQkJCXVubWFwcGVkX3N6ICs9IHBnX3NpemU7IC8qIEdhdGhl
ciB0aGUgc2l6ZS4gKi8NCj4gPiAgCQkJCWNvbnRpbnVlOw0KPiA+ICsJCQl9DQo+ID4gIA0KPiA+
IC0JCQlyZXQgPSBpb21tdV9tYXAoZG9tYWluLCBhZGRyLCBhZGRyLCBwZ19zaXplLCBlbnRyeS0+
cHJvdCk7DQo+ID4gKwkJCWlmICh1bm1hcHBlZF9zeikgew0KPiA+ICsJCQkJLyogTWFwIHRoZSBy
ZWdpb24gYmVmb3JlIHRoZSBvdmVybGFwLiAqLw0KPiA+ICsJCQkJcmV0ID0gaW9tbXVfbWFwKGRv
bWFpbiwgc3RhcnQsIHN0YXJ0LA0KPiA+ICsJCQkJCQl1bm1hcHBlZF9zeiwgZW50cnktPnByb3Qp
Ow0KPiA+ICsJCQkJaWYgKHJldCkNCj4gPiArCQkJCQlnb3RvIG91dDsNCj4gPiArCQkJCXN0YXJ0
ICs9IHVubWFwcGVkX3N6Ow0KPiANCj4gSSB0aGluayBpdCdzIGEgYml0IGNvbmZ1c2luZyB0byB1
cGRhdGUgc3RhcnQgbGlrZSB0aGlzLiBDYW4gd2UgY2FsbA0KPiBpb21tdV9tYXAoZG9tYWluLCBh
ZGRyIC0gbWFwX3NpemUsIGFkZHIgLSBtYXBfc2l6ZSwgbWFwX3NpemUsIGVudHJ5LT5wcm90KQ0K
PiBpbnN0ZWFkPw0KPiANCj4gPiArCQkJCXVubWFwcGVkX3N6ID0gMDsNCj4gPiArCQkJfQ0KPiA+
ICsJCQlzdGFydCArPSBwZ19zaXplOw0KPiA+ICsJCX0NCj4gPiArCQlpZiAodW5tYXBwZWRfc3op
IHsNCj4gPiArCQkJcmV0ID0gaW9tbXVfbWFwKGRvbWFpbiwgc3RhcnQsIHN0YXJ0LCB1bm1hcHBl
ZF9zeiwNCj4gPiArCQkJCQllbnRyeS0+cHJvdCk7DQo+IA0KPiBDYW4geW91IGF2b2lkIHRoaXMg
aHVuayBieSBjaGFuZ2luZyB5b3VyIGxvb3AgY2hlY2sgdG8gc29tZXRoaW5nIGxpa2U6DQo+IA0K
PiAJaWYgKCFwaHlzX2FkZHIpIHsNCj4gCQltYXBfc2l6ZSArPSBwZ19zaXplOw0KPiAJCWlmIChh
ZGRyICsgcGdfc2l6ZSA8IGVuZCkNCj4gCQkJY29udGludWU7DQo+IAl9DQoNClRoYW5rcyBmb3Ig
eW91ciBxdWljayByZXZpZXcuIEkgaGF2ZSBmaXhlZCBhbmQgdGVzdGVkIGl0LiB0aGUgcGF0Y2gg
aXMNCnNpbXBsZS4gSSBjb3B5IGl0IGhlcmUuIElzIHRoaXMgcmVhZGFibGUgZm9yIHlvdSBub3c/
DQoNCg0KLS0tIGEvZHJpdmVycy9pb21tdS9pb21tdS5jDQorKysgYi9kcml2ZXJzL2lvbW11L2lv
bW11LmMNCkBAIC03MzcsNiArNzM3LDcgQEAgc3RhdGljIGludA0KaW9tbXVfY3JlYXRlX2Rldmlj
ZV9kaXJlY3RfbWFwcGluZ3Moc3RydWN0IGlvbW11X2dyb3VwICpncm91cCwNCiAJLyogV2UgbmVl
ZCB0byBjb25zaWRlciBvdmVybGFwcGluZyByZWdpb25zIGZvciBkaWZmZXJlbnQgZGV2aWNlcyAq
Lw0KIAlsaXN0X2Zvcl9lYWNoX2VudHJ5KGVudHJ5LCAmbWFwcGluZ3MsIGxpc3QpIHsNCiAJCWRt
YV9hZGRyX3Qgc3RhcnQsIGVuZCwgYWRkcjsNCisJCXNpemVfdCBtYXBfc2l6ZSA9IDA7DQogDQog
CQlpZiAoZG9tYWluLT5vcHMtPmFwcGx5X3Jlc3ZfcmVnaW9uKQ0KIAkJCWRvbWFpbi0+b3BzLT5h
cHBseV9yZXN2X3JlZ2lvbihkZXYsIGRvbWFpbiwgZW50cnkpOw0KQEAgLTc1MiwxMiArNzUzLDIx
IEBAIHN0YXRpYyBpbnQNCmlvbW11X2NyZWF0ZV9kZXZpY2VfZGlyZWN0X21hcHBpbmdzKHN0cnVj
dCBpb21tdV9ncm91cCAqZ3JvdXAsDQogCQkJcGh5c19hZGRyX3QgcGh5c19hZGRyOw0KIA0KIAkJ
CXBoeXNfYWRkciA9IGlvbW11X2lvdmFfdG9fcGh5cyhkb21haW4sIGFkZHIpOw0KLQkJCWlmIChw
aHlzX2FkZHIpDQotCQkJCWNvbnRpbnVlOw0KKwkJCWlmICghcGh5c19hZGRyKSB7DQorCQkJCW1h
cF9zaXplICs9IHBnX3NpemU7DQorCQkJCWlmIChhZGRyICsgcGdfc2l6ZSA8IGVuZCkNCisJCQkJ
CWNvbnRpbnVlOw0KKwkJCQllbHNlDQorCQkJCQlhZGRyICs9IHBnX3NpemU7IC8qUG9pbnQgdG8g
RW5kICovDQorCQkJfQ0KIA0KLQkJCXJldCA9IGlvbW11X21hcChkb21haW4sIGFkZHIsIGFkZHIs
IHBnX3NpemUsIGVudHJ5LT5wcm90KTsNCi0JCQlpZiAocmV0KQ0KLQkJCQlnb3RvIG91dDsNCisJ
CQlpZiAobWFwX3NpemUpIHsNCisJCQkJcmV0ID0gaW9tbXVfbWFwKGRvbWFpbiwgYWRkciAtIG1h
cF9zaXplLCBhZGRyIC0gbWFwX3NpemUsDQorCQkJCQkJbWFwX3NpemUsIGVudHJ5LT5wcm90KTsN
CisJCQkJaWYgKHJldCkNCisJCQkJCWdvdG8gb3V0Ow0KKwkJCQltYXBfc2l6ZSA9IDA7DQorCQkJ
fQ0KIAkJfQ0KDQo+IA0KPiBXaWxsDQoNCg==

