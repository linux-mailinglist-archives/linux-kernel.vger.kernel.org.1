Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31AD82DAA04
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 10:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbgLOJYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 04:24:11 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:50263 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727879AbgLOJXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 04:23:55 -0500
X-UUID: fe9865edfae24668b01a6edbe17d15fb-20201215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=3A3MDRQZ+3g3GIYPtsPrmJUDA8Vs0qbcwBwsyH9jWRw=;
        b=Xe0po7REhhl9W0OPImOn0FvTHGSiHutY+EqJzZ2OMInDTitQe30QloVxAyGSdfBFWbxvNTHu1FE6olsusZXi/HRKmrmcyEzCn6kv3lzrTeHEF+e/od/FDEFJLNZOQl4T9d3+0hlpS/QsILOljB2b9cc1j38vsu4WIg5jEJKV8a4=;
X-UUID: fe9865edfae24668b01a6edbe17d15fb-20201215
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 808679129; Tue, 15 Dec 2020 17:23:09 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 15 Dec 2020 17:23:08 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Dec 2020 17:23:08 +0800
Message-ID: <1608024188.29527.2.camel@mtksdaap41>
Subject: Re: [PATCH v3 5/8] regulator: mt6359: Add support for MT6359
 regulator
From:   Hsin-hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        Wen Su <wen.su@mediatek.com>
Date:   Tue, 15 Dec 2020 17:23:08 +0800
In-Reply-To: <20201124170732.GI4933@sirena.org.uk>
References: <1606103290-15034-1-git-send-email-hsin-hsiung.wang@mediatek.com>
         <1606103290-15034-6-git-send-email-hsin-hsiung.wang@mediatek.com>
         <20201124170732.GI4933@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIFR1ZSwgMjAyMC0xMS0yNCBhdCAxNzowNyArMDAwMCwgTWFyayBCcm93biB3cm90
ZToNCj4gT24gTW9uLCBOb3YgMjMsIDIwMjAgYXQgMTE6NDg6MDdBTSArMDgwMCwgSHNpbi1Ic2l1
bmcgV2FuZyB3cm90ZToNCj4gDQo+ID4gK3N0YXRpYyBpbnQgbXQ2MzU5X2dldF9saW5lYXJfdm9s
dGFnZV9zZWwoc3RydWN0IHJlZ3VsYXRvcl9kZXYgKnJkZXYpDQo+ID4gK3sNCj4gPiArCXN0cnVj
dCBtdDYzNTlfcmVndWxhdG9yX2luZm8gKmluZm8gPSByZGV2X2dldF9kcnZkYXRhKHJkZXYpOw0K
PiA+ICsJaW50IHJldCwgcmVndmFsOw0KPiA+ICsNCj4gPiArCXJldCA9IHJlZ21hcF9yZWFkKHJk
ZXYtPnJlZ21hcCwgaW5mby0+ZGFfdnNlbF9yZWcsICZyZWd2YWwpOw0KPiA+ICsJaWYgKHJldCAh
PSAwKSB7DQo+ID4gKwkJZGV2X2VycigmcmRldi0+ZGV2LA0KPiA+ICsJCQkiRmFpbGVkIHRvIGdl
dCBtdDYzNTkgQnVjayAlcyB2c2VsIHJlZzogJWRcbiIsDQo+ID4gKwkJCWluZm8tPmRlc2MubmFt
ZSwgcmV0KTsNCj4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCXJldCA9
IChyZWd2YWwgPj4gaW5mby0+ZGFfdnNlbF9zaGlmdCkgJiBpbmZvLT5kYV92c2VsX21hc2s7DQo+
ID4gKw0KPiA+ICsJcmV0dXJuIHJldDsNCj4gPiArfQ0KPiANCj4gVGhpcyBsb29rcyBsaWtlIGl0
IGNvdWxkIGp1c3QgYmUgcmVnbWFwX2dldF92b2x0YWdlX3NlbF9yZWdtYXAoKT8NCj4gT3RoZXJ3
aXNlIHRoZSBkcml2ZXIgbG9va3MgZ29vZC4NCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KTVQ2
MzU5IHJlZ3VsYXRvciBoYXMgc2VsX3JlZyBhbmQgc3RhdHVzX3JlZywgc28gd2UgdXNlDQptdDYz
NTlfZ2V0X2xpbmVhcl92b2x0YWdlX3NlbCBmb3Igc3RhdHVzX3JlZyBpbnN0ZWFkIG9mDQpyZWdt
YXBfZ2V0X3ZvbHRhZ2Vfc2VsX3JlZ21hcCgpIHdoaWNoIHVzZXMgc2VsX3JlZy4NCg0KVGhhbmtz
Lg0K

