Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A03827E22C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 09:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgI3HJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 03:09:46 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:50577 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725440AbgI3HJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 03:09:46 -0400
X-UUID: 037e6f42bcc0412c9290e78684c34370-20200930
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=JcmdGf1tbwWxv9BVjsAg+AHjaleWPK/+Qqe58lDd1XI=;
        b=oYVnmnPaCrIgu9+zcuVNPUi3Jl470Fw0IiRZqMAi2rbmVPB4xIl62ZIAUbRnKKKTuK0EDJavhozqV2qvlgFaehWPoKsff/P8lZgbCBr96hk2OdZzBpDXExQ8Siy6qEu1ba+CG9G8mnR7hYzedb8dBReeMCQYyrMicTGj8LgJXqw=;
X-UUID: 037e6f42bcc0412c9290e78684c34370-20200930
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1768970375; Wed, 30 Sep 2020 15:09:41 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 30 Sep 2020 15:09:39 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Sep 2020 15:09:39 +0800
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
Subject: [PATCH v3 13/24] iommu/mediatek: Add device link for smi-common and m4u
Date:   Wed, 30 Sep 2020 15:06:36 +0800
Message-ID: <20200930070647.10188-14-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200930070647.10188-1-yong.wu@mediatek.com>
References: <20200930070647.10188-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: CDE450FF0684FFB6D676A5EEF365F04D0BFE5E2C3181397D656404828B20D2812000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW4gdGhlIGxhc3Rlc3QgU29DLCBNNFUgaGFzIGl0cyBzcGVjaWFsIHBvd2VyIGRvbWFpbi4gdGh1
cywgSWYgdGhlIGVuZ2luZQ0KYmVnaW4gdG8gd29yaywgaXQgc2hvdWxkIGhlbHAgZW5hYmxlIHRo
ZSBwb3dlciBmb3IgTTRVIGZpcnN0bHkuDQpDdXJyZW50bHkgaWYgdGhlIGVuZ2luZSB3b3JrLCBp
dCBhbHdheXMgZW5hYmxlIHRoZSBwb3dlci9jbG9ja3MgZm9yDQpzbWktbGFyYnMvc21pLWNvbW1v
bi4gVGhpcyBwYXRjaCBhZGRzIGRldmljZV9saW5rIGZvciBzbWktY29tbW9uIGFuZCBNNFUuDQp0
aGVuLCBpZiBzbWktY29tbW9uIHBvd2VyIGlzIGVuYWJsZWQsIHRoZSBNNFUgcG93ZXIgYWxzbyBp
cyBwb3dlcmVkIG9uDQphdXRvbWF0aWNhbGx5Lg0KDQpOb3JtYWxseSBNNFUgY29ubmVjdCB3aXRo
IHNldmVyYWwgc21pLWxhcmJzIGFuZCB0aGVpciBzbWktY29tbW9uIGFsd2F5cw0KYXJlIHRoZSBz
YW1lLCBJbiB0aGlzIHBhdGNoIGl0IGdldCBzbWktY29tbW9uIGRldiBmcm9tIHRoZSBmaXJzdCBz
bWktbGFyYg0KZGV2aWNlKGk9PTApLCB0aGVuIGFkZCB0aGUgZGV2aWNlX2xpbmsgb25seSB3aGls
ZSBtNHUgaGFzIHBvd2VyLWRvbWFpbi4NCg0KU2lnbmVkLW9mZi1ieTogWW9uZyBXdSA8eW9uZy53
dUBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL2lvbW11L210a19pb21tdS5jIHwgMjQgKysr
KysrKysrKysrKysrKysrKysrKystDQogZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaCB8ICAxICsN
CiAyIGZpbGVzIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L210a19p
b21tdS5jDQppbmRleCA5NDBiN2E5MTkxYjIuLjU2MjU0NThiMjFiYSAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCisrKyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMN
CkBAIC0yMCw2ICsyMCw3IEBADQogI2luY2x1ZGUgPGxpbnV4L29mX2lycS5oPg0KICNpbmNsdWRl
IDxsaW51eC9vZl9wbGF0Zm9ybS5oPg0KICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2Uu
aD4NCisjaW5jbHVkZSA8bGludXgvcG1fcnVudGltZS5oPg0KICNpbmNsdWRlIDxsaW51eC9zbGFi
Lmg+DQogI2luY2x1ZGUgPGxpbnV4L3NwaW5sb2NrLmg+DQogI2luY2x1ZGUgPGFzbS9iYXJyaWVy
Lmg+DQpAQCAtNjgxLDcgKzY4Miw3IEBAIHN0YXRpYyBpbnQgbXRrX2lvbW11X3Byb2JlKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCQlyZXR1cm4gbGFyYl9ucjsNCiANCiAJZm9yIChp
ID0gMDsgaSA8IGxhcmJfbnI7IGkrKykgew0KLQkJc3RydWN0IGRldmljZV9ub2RlICpsYXJibm9k
ZTsNCisJCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbGFyYm5vZGUsICpzbWljb21tX25vZGU7DQogCQlz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwbGFyYmRldjsNCiAJCXUzMiBpZDsNCiANCkBAIC03MDcs
NiArNzA4LDE1IEBAIHN0YXRpYyBpbnQgbXRrX2lvbW11X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpDQogDQogCQljb21wb25lbnRfbWF0Y2hfYWRkX3JlbGVhc2UoZGV2LCAmbWF0
Y2gsIHJlbGVhc2Vfb2YsDQogCQkJCQkgICAgY29tcGFyZV9vZiwgbGFyYm5vZGUpOw0KKwkJaWYg
KCFpKSB7DQorCQkJc21pY29tbV9ub2RlID0gb2ZfcGFyc2VfcGhhbmRsZShsYXJibm9kZSwgIm1l
ZGlhdGVrLHNtaSIsIDApOw0KKwkJCWlmICghc21pY29tbV9ub2RlKQ0KKwkJCQlyZXR1cm4gLUVJ
TlZBTDsNCisNCisJCQlwbGFyYmRldiA9IG9mX2ZpbmRfZGV2aWNlX2J5X25vZGUoc21pY29tbV9u
b2RlKTsNCisJCQlvZl9ub2RlX3B1dChzbWljb21tX25vZGUpOw0KKwkJCWRhdGEtPnNtaWNvbW1f
ZGV2ID0gJnBsYXJiZGV2LT5kZXY7DQorCQl9DQogCX0NCiANCiAJcGxhdGZvcm1fc2V0X2RydmRh
dGEocGRldiwgZGF0YSk7DQpAQCAtNzI5LDYgKzczOSwxNiBAQCBzdGF0aWMgaW50IG10a19pb21t
dV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAlpZiAoIWlvbW11X3ByZXNl
bnQoJnBsYXRmb3JtX2J1c190eXBlKSkNCiAJCWJ1c19zZXRfaW9tbXUoJnBsYXRmb3JtX2J1c190
eXBlLCAmbXRrX2lvbW11X29wcyk7DQogDQorCWlmIChkZXYtPnBtX2RvbWFpbikgew0KKwkJc3Ry
dWN0IGRldmljZV9saW5rICpsaW5rOw0KKw0KKwkJbGluayA9IGRldmljZV9saW5rX2FkZChkYXRh
LT5zbWljb21tX2RldiwgZGV2LA0KKwkJCQkgICAgICAgRExfRkxBR19TVEFURUxFU1MgfCBETF9G
TEFHX1BNX1JVTlRJTUUpOw0KKwkJaWYgKCFsaW5rKSB7DQorCQkJZGV2X2VycihkZXYsICJVbmFi
bGUgbGluayAlcy5cbiIsIGRldl9uYW1lKGRhdGEtPnNtaWNvbW1fZGV2KSk7DQorCQkJcmV0dXJu
IC1FSU5WQUw7DQorCQl9DQorCX0NCiAJcmV0dXJuIGNvbXBvbmVudF9tYXN0ZXJfYWRkX3dpdGhf
bWF0Y2goZGV2LCAmbXRrX2lvbW11X2NvbV9vcHMsIG1hdGNoKTsNCiB9DQogDQpAQCAtNzQzLDYg
Kzc2Myw4IEBAIHN0YXRpYyBpbnQgbXRrX2lvbW11X3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQ0KIAkJYnVzX3NldF9pb21tdSgmcGxhdGZvcm1fYnVzX3R5cGUsIE5VTEwpOw0K
IA0KIAljbGtfZGlzYWJsZV91bnByZXBhcmUoZGF0YS0+YmNsayk7DQorCWlmIChwZGV2LT5kZXYu
cG1fZG9tYWluKQ0KKwkJZGV2aWNlX2xpbmtfcmVtb3ZlKGRhdGEtPnNtaWNvbW1fZGV2LCAmcGRl
di0+ZGV2KTsNCiAJZGV2bV9mcmVlX2lycSgmcGRldi0+ZGV2LCBkYXRhLT5pcnEsIGRhdGEpOw0K
IAljb21wb25lbnRfbWFzdGVyX2RlbCgmcGRldi0+ZGV2LCAmbXRrX2lvbW11X2NvbV9vcHMpOw0K
IAlyZXR1cm4gMDsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5oIGIvZHJp
dmVycy9pb21tdS9tdGtfaW9tbXUuaA0KaW5kZXggYTJlMmM4NDRiOTZlLi5hZTc5MDk4MTVjZGIg
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5oDQorKysgYi9kcml2ZXJzL2lv
bW11L210a19pb21tdS5oDQpAQCAtNjcsNiArNjcsNyBAQCBzdHJ1Y3QgbXRrX2lvbW11X2RhdGEg
ew0KIA0KIAlzdHJ1Y3QgaW9tbXVfZGV2aWNlCQlpb21tdTsNCiAJY29uc3Qgc3RydWN0IG10a19p
b21tdV9wbGF0X2RhdGEgKnBsYXRfZGF0YTsNCisJc3RydWN0IGRldmljZQkJCSpzbWljb21tX2Rl
djsNCiANCiAJc3RydWN0IGRtYV9pb21tdV9tYXBwaW5nCSptYXBwaW5nOyAvKiBGb3IgbXRrX2lv
bW11X3YxLmMgKi8NCiANCi0tIA0KMi4xOC4wDQo=

