Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E122C6005
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 07:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392553AbgK0GVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 01:21:41 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:9470 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2392545AbgK0GVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 01:21:41 -0500
X-UUID: 0166de49f31e400fbe36e0a6b4f576b7-20201127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=k6991k1USSeF9xBY2RrFpj24tWMV0+Y0E7njcNgEzrA=;
        b=WSUb2JkeLbCR7ASWwSPHvXoBOxCiLeZxB9PcOr1TeSr4lXi1/1u8dxwYjPnsRqLRc9ae/lcfDKyHZYlsUW9C/kKoMhFYXx+CWkKFna25lN/pUYCX49lpgJ3l6b7OqwIkigCMS+MZYKhTgD/sWrK39L3l0L/TS6BPOlpLkEZaUgI=;
X-UUID: 0166de49f31e400fbe36e0a6b4f576b7-20201127
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2031242701; Fri, 27 Nov 2020 14:21:34 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 27 Nov
 2020 14:21:32 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 27 Nov 2020 14:21:31 +0800
Message-ID: <1606458092.26323.192.camel@mhfsdcap03>
Subject: Re: [PATCH v4 17/24] iommu/mediatek: Add single domain
From:   Yong Wu <yong.wu@mediatek.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <youlin.pei@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <chao.hao@mediatek.com>,
        Greg Kroah-Hartman <gregkh@google.com>,
        <kernel-team@android.com>
Date:   Fri, 27 Nov 2020 14:21:32 +0800
In-Reply-To: <22e49f08-6d23-86cf-bb9c-79d54ce55beb@arm.com>
References: <20201111123838.15682-1-yong.wu@mediatek.com>
         <20201111123838.15682-18-yong.wu@mediatek.com>
         <22e49f08-6d23-86cf-bb9c-79d54ce55beb@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: DFD6FF2D0FFC111E8E3A9221E6491E4E883A7AD97F964DC7A2DB8863C42809542000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTExLTI2IGF0IDE3OjExICswMDAwLCBSb2JpbiBNdXJwaHkgd3JvdGU6DQo+
IE9uIDIwMjAtMTEtMTEgMTI6MzgsIFlvbmcgV3Ugd3JvdGU6DQo+ID4gRGVmYXVsdGx5IHRoZSBp
b3ZhIHJhbmdlIGlzIDAtNEcuIGhlcmUgd2UgYWRkIGEgc2luZ2xlLWRvbWFpbigwLTRHKQ0KPiA+
IGZvciB0aGUgcHJldmlvdXMgU29DLiB0aGlzIGFsc28gaXMgYSBwcmVwYXJpbmcgcGF0Y2ggZm9y
IHN1cHBvcnRpbmcNCj4gPiBtdWx0aS1kb21haW5zLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6
IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9p
b21tdS9tdGtfaW9tbXUuYyB8IDEyICsrKysrKysrKysrKw0KPiA+ICAgMSBmaWxlIGNoYW5nZWQs
IDEyIGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9t
dGtfaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCj4gPiBpbmRleCBiZjNmNGUw
ZjQ3NDguLmE3NzI3YTM4OTlkMSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lvbW11L210a19p
b21tdS5jDQo+ID4gKysrIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KPiA+IEBAIC0xNjEs
NiArMTYxLDEwIEBAIHN0cnVjdCBtdGtfaW9tbXVfaW92YV9yZWdpb24gew0KPiA+ICAgCXVuc2ln
bmVkIGxvbmcgbG9uZwlzaXplOw0KPiA+ICAgfTsNCj4gPiAgIA0KPiA+ICtzdGF0aWMgY29uc3Qg
c3RydWN0IG10a19pb21tdV9pb3ZhX3JlZ2lvbiBzaW5nbGVfZG9tYWluW10gPSB7DQo+ID4gKwl7
LmlvdmFfYmFzZSA9IDAsCQkuc2l6ZSA9IFNaXzRHfSwNCj4gPiArfTsNCj4gDQo+IEhhbmcgb24s
IGdpdmVuIGhvdyB0aGUgcHJldmlvdXMgcGF0Y2ggd29ya3MsIHN1cmVseSB0aGlzIG1lYW5zIHlv
dSdyZSANCj4gbm93IGdvaW5nIHRvICpyZXNlcnZlKiB0aGUgZW50aXJlIGFkZHJlc3Mgc3BhY2U/
IFRoYXQgZG9lc24ndCBzZWVtIA0KPiByaWdodC4uLiA6Lw0KDQpDb3VsZCB5b3UgaGVscCBzaGFy
ZSBtb3JlPyBpbiB3aGljaCBjYXNlIGl0IGlzIG5vdCByaWdodD8NCg0KSW4gdGhlIGNvZGU6DQpk
b21haW4tPmdlb21ldHJ5LmFwZXJ0dXJlX2VuZCA9IGlvdmFfYmFzZSArIHNpemUgLSAxLiANCg0K
dGhpcyBpcyBzYW1lIHdpdGggRE1BX0JJVF9NQVNLKDMyKS4gSXQgbG9va3MgZG9uJ3QgY2hhbmdl
IGFueXRoaW5nLg0KDQo+IA0KPiBSb2Jpbi4NCj4gDQo+ID4gKw0KPiA+ICAgLyoNCj4gPiAgICAq
IFRoZXJlIG1heSBiZSAxIG9yIDIgTTRVIEhXcywgQnV0IHdlIGFsd2F5cyBleHBlY3QgdGhleSBh
cmUgaW4gdGhlIHNhbWUgZG9tYWluDQo+ID4gICAgKiBmb3IgdGhlIHBlcmZvcm1hbmNlLg0KPiA+
IEBAIC05MjIsNiArOTI2LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfaW9tbXVfcGxhdF9k
YXRhIG10MjcxMl9kYXRhID0gew0KPiA+ICAgCS5tNHVfcGxhdCAgICAgPSBNNFVfTVQyNzEyLA0K
PiA+ICAgCS5mbGFncyAgICAgICAgPSBIQVNfNEdCX01PREUgfCBIQVNfQkNMSyB8IEhBU19WTERf
UEFfUk5HLA0KPiA+ICAgCS5pbnZfc2VsX3JlZyAgPSBSRUdfTU1VX0lOVl9TRUxfR0VOMSwNCj4g
PiArCS5pb3ZhX3JlZ2lvbiAgPSBzaW5nbGVfZG9tYWluLA0KPiA+ICsJLmlvdmFfcmVnaW9uX25y
ID0gQVJSQVlfU0laRShzaW5nbGVfZG9tYWluKSwNCj4gPiAgIAkubGFyYmlkX3JlbWFwID0ge3sw
fSwgezF9LCB7Mn0sIHszfSwgezR9LCB7NX0sIHs2fSwgezd9fSwNCj4gPiAgIH07DQo+ID4gICAN
Cj4gPiBAQCAtOTI5LDYgKzkzNSw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2lvbW11X3Bs
YXRfZGF0YSBtdDY3NzlfZGF0YSA9IHsNCj4gPiAgIAkubTR1X3BsYXQgICAgICA9IE00VV9NVDY3
NzksDQo+ID4gICAJLmZsYWdzICAgICAgICAgPSBIQVNfU1VCX0NPTU0gfCBPVVRfT1JERVJfV1Jf
RU4gfCBXUl9USFJPVF9FTiwNCj4gPiAgIAkuaW52X3NlbF9yZWcgICA9IFJFR19NTVVfSU5WX1NF
TF9HRU4yLA0KPiA+ICsJLmlvdmFfcmVnaW9uICAgPSBzaW5nbGVfZG9tYWluLA0KPiA+ICsJLmlv
dmFfcmVnaW9uX25yID0gQVJSQVlfU0laRShzaW5nbGVfZG9tYWluKSwNCj4gPiAgIAkubGFyYmlk
X3JlbWFwICA9IHt7MH0sIHsxfSwgezJ9LCB7M30sIHs1fSwgezcsIDh9LCB7MTB9LCB7OX19LA0K
PiA+ICAgfTsNCj4gPiAgIA0KPiA+IEBAIC05NDQsNiArOTUyLDggQEAgc3RhdGljIGNvbnN0IHN0
cnVjdCBtdGtfaW9tbXVfcGxhdF9kYXRhIG10ODE3M19kYXRhID0gew0KPiA+ICAgCS5mbGFncwkg
ICAgICA9IEhBU180R0JfTU9ERSB8IEhBU19CQ0xLIHwgUkVTRVRfQVhJIHwNCj4gPiAgIAkJCUhB
U19MRUdBQ1lfSVZSUF9QQUREUiwNCj4gPiAgIAkuaW52X3NlbF9yZWcgID0gUkVHX01NVV9JTlZf
U0VMX0dFTjEsDQo+ID4gKwkuaW92YV9yZWdpb24gID0gc2luZ2xlX2RvbWFpbiwNCj4gPiArCS5p
b3ZhX3JlZ2lvbl9uciA9IEFSUkFZX1NJWkUoc2luZ2xlX2RvbWFpbiksDQo+ID4gICAJLmxhcmJp
ZF9yZW1hcCA9IHt7MH0sIHsxfSwgezJ9LCB7M30sIHs0fSwgezV9fSwgLyogTGluZWFyIG1hcHBp
bmcuICovDQo+ID4gICB9Ow0KPiA+ICAgDQo+ID4gQEAgLTk1MSw2ICs5NjEsOCBAQCBzdGF0aWMg
Y29uc3Qgc3RydWN0IG10a19pb21tdV9wbGF0X2RhdGEgbXQ4MTgzX2RhdGEgPSB7DQo+ID4gICAJ
Lm00dV9wbGF0ICAgICA9IE00VV9NVDgxODMsDQo+ID4gICAJLmZsYWdzICAgICAgICA9IFJFU0VU
X0FYSSwNCj4gPiAgIAkuaW52X3NlbF9yZWcgID0gUkVHX01NVV9JTlZfU0VMX0dFTjEsDQo+ID4g
KwkuaW92YV9yZWdpb24gID0gc2luZ2xlX2RvbWFpbiwNCj4gPiArCS5pb3ZhX3JlZ2lvbl9uciA9
IEFSUkFZX1NJWkUoc2luZ2xlX2RvbWFpbiksDQo+ID4gICAJLmxhcmJpZF9yZW1hcCA9IHt7MH0s
IHs0fSwgezV9LCB7Nn0sIHs3fSwgezJ9LCB7M30sIHsxfX0sDQo+ID4gICB9Ow0KPiA+ICAgDQo+
ID4gDQoNCg==

