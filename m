Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C7027E239
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 09:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbgI3HKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 03:10:20 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:50984 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725440AbgI3HKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 03:10:20 -0400
X-UUID: ff5ce9857e17491db4a124e29d10d057-20200930
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Cd85HbGdomIatcszaQsBe028Lmk8A4DWmIet/rjvJNA=;
        b=GWLZfJvEIhax1zcJzT7uX2coW9dCL9m+JqhZqO7eecHoQaHDeyaepMzm4sAU5B0P4MT8RpqaTGTtTPBnEXnt9Kg/3lyYpAF3hE6yeoF8EBrdgbiG51e7f9oxqyAID+Mcc3swZFUzbqAczak7hniteP7OesEyJncV8oxX9z6ICqA=;
X-UUID: ff5ce9857e17491db4a124e29d10d057-20200930
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1118781204; Wed, 30 Sep 2020 15:10:15 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 30 Sep 2020 15:10:13 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Sep 2020 15:10:13 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Will Deacon <will@kernel.org>
CC:     Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <chao.hao@mediatek.com>,
        <ming-fan.chen@mediatek.com>,
        Greg Kroah-Hartman <gregkh@google.com>,
        <kernel-team@android.com>
Subject: [PATCH v3 16/24] iommu/mediatek: Add iova reserved function
Date:   Wed, 30 Sep 2020 15:06:39 +0800
Message-ID: <20200930070647.10188-17-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200930070647.10188-1-yong.wu@mediatek.com>
References: <20200930070647.10188-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 55AB3C9BE1447268D24CD38B123F0E26462D1AE382557C45894227B167097E4F2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rm9yIG11bHRpcGxlIGlvbW11X2RvbWFpbnMsIHdlIG5lZWQgdG8gcmVzZXJ2ZSBzb21lIGlvdmEg
cmVnaW9ucy4gVGFrZSBhDQpleGFtcGxlLCBJZiB0aGUgZGVmYXVsdCBpb3ZhIHJlZ2lvbiBpcyAw
IH4gNEcsIGJ1dCB0aGUgMHg0MDAwXzAwMDAgfg0KMHg0M2ZmX2ZmZmYgaXMgb25seSBmb3IgdGhl
IHNwZWNpYWwgQ0NVMCBkb21haW4uIFRodXMgd2Ugc2hvdWxkIGV4Y2x1ZGUNCnRoaXMgcmVnaW9u
IGZvciB0aGUgZGVmYXVsdCBpb3ZhIHJlZ2lvbi4NCg0KVGhpcyBwYXRjaCBhZGRzIGlvdmEgcmVz
ZXJ2ZWQgZmxvdy4gSXQncyBhIHByZXBhcmluZyBwYXRjaCBmb3Igc3VwcG9ydGluZw0KbXVsdGkt
ZG9tYWluLg0KDQpTaWduZWQtb2ZmLWJ5OiBBbmFuIHN1biA8YW5hbi5zdW5AbWVkaWF0ZWsuY29t
Pg0KU2lnbmVkLW9mZi1ieTogQ2hhbyBIYW8gPGNoYW8uaGFvQG1lZGlhdGVrLmNvbT4NClNpZ25l
ZC1vZmYtYnk6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9p
b21tdS9tdGtfaW9tbXUuYyB8IDI4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysNCiBkcml2
ZXJzL2lvbW11L210a19pb21tdS5oIHwgIDUgKysrKysNCiAyIGZpbGVzIGNoYW5nZWQsIDMzIGlu
c2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgYi9k
cml2ZXJzL2lvbW11L210a19pb21tdS5jDQppbmRleCAxZTZlNmQzZmE3ZjEuLjhlMmE4ZTI5ZDEz
YyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCisrKyBiL2RyaXZlcnMv
aW9tbXUvbXRrX2lvbW11LmMNCkBAIC0xNTMsNiArMTUzLDExIEBAIHN0YXRpYyBMSVNUX0hFQUQo
bTR1bGlzdCk7CS8qIExpc3QgYWxsIHRoZSBNNFUgSFdzICovDQogDQogI2RlZmluZSBmb3JfZWFj
aF9tNHUoZGF0YSkJbGlzdF9mb3JfZWFjaF9lbnRyeShkYXRhLCAmbTR1bGlzdCwgbGlzdCkNCiAN
CitzdHJ1Y3QgbXRrX2lvbW11X2lvdmFfcmVnaW9uIHsNCisJZG1hX2FkZHJfdAkJaW92YV9iYXNl
Ow0KKwl1bnNpZ25lZCBsb25nIGxvbmcJc2l6ZTsNCit9Ow0KKw0KIC8qDQogICogVGhlcmUgbWF5
IGJlIDEgb3IgMiBNNFUgSFdzLCBCdXQgd2UgYWx3YXlzIGV4cGVjdCB0aGV5IGFyZSBpbiB0aGUg
c2FtZSBkb21haW4NCiAgKiBmb3IgdGhlIHBlcmZvcm1hbmNlLg0KQEAgLTUzOSw2ICs1NDQsMjcg
QEAgc3RhdGljIGludCBtdGtfaW9tbXVfb2ZfeGxhdGUoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1
Y3Qgb2ZfcGhhbmRsZV9hcmdzICphcmdzKQ0KIAlyZXR1cm4gaW9tbXVfZndzcGVjX2FkZF9pZHMo
ZGV2LCBhcmdzLT5hcmdzLCAxKTsNCiB9DQogDQorc3RhdGljIHZvaWQgbXRrX2lvbW11X2dldF9y
ZXN2X3JlZ2lvbnMoc3RydWN0IGRldmljZSAqZGV2LA0KKwkJCQkgICAgICAgc3RydWN0IGxpc3Rf
aGVhZCAqaGVhZCkNCit7DQorCXN0cnVjdCBtdGtfaW9tbXVfZGF0YSAqZGF0YSA9IGRldl9pb21t
dV9wcml2X2dldChkZXYpOw0KKwljb25zdCBzdHJ1Y3QgbXRrX2lvbW11X2lvdmFfcmVnaW9uICpy
ZXN2Ow0KKwlzdHJ1Y3QgaW9tbXVfcmVzdl9yZWdpb24gKnJlZ2lvbjsNCisJaW50IHByb3QgPSBJ
T01NVV9XUklURSB8IElPTU1VX1JFQUQ7DQorCXVuc2lnbmVkIGludCBpOw0KKw0KKwlmb3IgKGkg
PSAwOyBpIDwgZGF0YS0+cGxhdF9kYXRhLT5pb3ZhX3JlZ2lvbl9ucjsgaSsrKSB7DQorCQlyZXN2
ID0gZGF0YS0+cGxhdF9kYXRhLT5pb3ZhX3JlZ2lvbiArIGk7DQorDQorCQlyZWdpb24gPSBpb21t
dV9hbGxvY19yZXN2X3JlZ2lvbihyZXN2LT5pb3ZhX2Jhc2UsIHJlc3YtPnNpemUsDQorCQkJCQkJ
IHByb3QsIElPTU1VX1JFU1ZfUkVTRVJWRUQpOw0KKwkJaWYgKCFyZWdpb24pDQorCQkJcmV0dXJu
Ow0KKw0KKwkJbGlzdF9hZGRfdGFpbCgmcmVnaW9uLT5saXN0LCBoZWFkKTsNCisJfQ0KK30NCisN
CiBzdGF0aWMgY29uc3Qgc3RydWN0IGlvbW11X29wcyBtdGtfaW9tbXVfb3BzID0gew0KIAkuZG9t
YWluX2FsbG9jCT0gbXRrX2lvbW11X2RvbWFpbl9hbGxvYywNCiAJLmRvbWFpbl9mcmVlCT0gbXRr
X2lvbW11X2RvbWFpbl9mcmVlLA0KQEAgLTU1Myw2ICs1NzksOCBAQCBzdGF0aWMgY29uc3Qgc3Ry
dWN0IGlvbW11X29wcyBtdGtfaW9tbXVfb3BzID0gew0KIAkucmVsZWFzZV9kZXZpY2UJPSBtdGtf
aW9tbXVfcmVsZWFzZV9kZXZpY2UsDQogCS5kZXZpY2VfZ3JvdXAJPSBtdGtfaW9tbXVfZGV2aWNl
X2dyb3VwLA0KIAkub2ZfeGxhdGUJPSBtdGtfaW9tbXVfb2ZfeGxhdGUsDQorCS5nZXRfcmVzdl9y
ZWdpb25zID0gbXRrX2lvbW11X2dldF9yZXN2X3JlZ2lvbnMsDQorCS5wdXRfcmVzdl9yZWdpb25z
ID0gZ2VuZXJpY19pb21tdV9wdXRfcmVzdl9yZWdpb25zLA0KIAkucGdzaXplX2JpdG1hcAk9IFNa
XzRLIHwgU1pfNjRLIHwgU1pfMU0gfCBTWl8xNk0sDQogfTsNCiANCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2lvbW11L210a19pb21tdS5oIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaA0KaW5kZXgg
YWU3OTA5ODE1Y2RiLi5kNDVjMTNjOWQzMjQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2lvbW11L210
a19pb21tdS5oDQorKysgYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5oDQpAQCAtNDQsMTAgKzQ0
LDE1IEBAIGVudW0gbXRrX2lvbW11X3BsYXQgew0KIAlNNFVfTVQ4MTgzLA0KIH07DQogDQorc3Ry
dWN0IG10a19pb21tdV9pb3ZhX3JlZ2lvbjsNCisNCiBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0
YSB7DQogCWVudW0gbXRrX2lvbW11X3BsYXQgbTR1X3BsYXQ7DQogCXUzMiAgICAgICAgICAgICAg
ICAgZmxhZ3M7DQogCXUzMiAgICAgICAgICAgICAgICAgaW52X3NlbF9yZWc7DQorDQorCXVuc2ln
bmVkIGludCAgICAgICAgaW92YV9yZWdpb25fbnI7DQorCWNvbnN0IHN0cnVjdCBtdGtfaW9tbXVf
aW92YV9yZWdpb24gICAqaW92YV9yZWdpb247DQogCXVuc2lnbmVkIGNoYXIgICAgICAgbGFyYmlk
X3JlbWFwW01US19MQVJCX0NPTV9NQVhdW01US19MQVJCX1NVQkNPTV9NQVhdOw0KIH07DQogDQot
LSANCjIuMTguMA0K

