Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC5027E23C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 09:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbgI3HKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 03:10:32 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:41525 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725440AbgI3HKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 03:10:31 -0400
X-UUID: 3012554c69ee4cf9b474eee6741de7aa-20200930
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=nevF8TOMCP6TM9eSDhUCz2BThWkCdrWjmk4H0qqzNTc=;
        b=da7u8j9mZGBx+bfM/BTSQaYYeiWsYYc6b5Zbr9vQ3ma9MMEXOcb99/yVhW2pff12ZZHhe8IxTjBabJ5kCojT+vNZvQ0W4LgwVe7FBxiQjRZJA4ggeRcmU2HI/MjwHk6/MUuIdQXu3O27YtK5DfUUQemxRyIx84MQYpYVyRhxOms=;
X-UUID: 3012554c69ee4cf9b474eee6741de7aa-20200930
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 173674371; Wed, 30 Sep 2020 15:10:27 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 30 Sep 2020 15:10:24 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Sep 2020 15:10:24 +0800
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
Subject: [PATCH v3 17/24] iommu/mediatek: Add single domain
Date:   Wed, 30 Sep 2020 15:06:40 +0800
Message-ID: <20200930070647.10188-18-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200930070647.10188-1-yong.wu@mediatek.com>
References: <20200930070647.10188-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: DA869CDE9D35E654ECB38AE90AA4E9286629CEE0AE83DF861D8E2709C31037692000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVmYXVsdGx5IHRoZSBpb3ZhIHJhbmdlIGlzIDAtNEcuIGhlcmUgd2UgYWRkIGEgc2luZ2xlLWRv
bWFpbigwLTRHKQ0KZm9yIHRoZSBwcmV2aW91cyBTb0MuIHRoaXMgYWxzbyBpcyBhIHByZXBhcmlu
ZyBwYXRjaCBmb3Igc3VwcG9ydGluZw0KbXVsdGktZG9tYWlucy4NCg0KU2lnbmVkLW9mZi1ieTog
WW9uZyBXdSA8eW9uZy53dUBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL2lvbW11L210a19p
b21tdS5jIHwgMTIgKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMo
KykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgYi9kcml2ZXJzL2lv
bW11L210a19pb21tdS5jDQppbmRleCA4ZTJhOGUyOWQxM2MuLjg3Y2E0ZjQ3ZTQ5NCAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCisrKyBiL2RyaXZlcnMvaW9tbXUvbXRr
X2lvbW11LmMNCkBAIC0xNTgsNiArMTU4LDEwIEBAIHN0cnVjdCBtdGtfaW9tbXVfaW92YV9yZWdp
b24gew0KIAl1bnNpZ25lZCBsb25nIGxvbmcJc2l6ZTsNCiB9Ow0KIA0KK3N0YXRpYyBjb25zdCBz
dHJ1Y3QgbXRrX2lvbW11X2lvdmFfcmVnaW9uIHNpbmdsZV9kb21haW5bXSA9IHsNCisJey5pb3Zh
X2Jhc2UgPSAwLAkJLnNpemUgPSBTWl80R30sDQorfTsNCisNCiAvKg0KICAqIFRoZXJlIG1heSBi
ZSAxIG9yIDIgTTRVIEhXcywgQnV0IHdlIGFsd2F5cyBleHBlY3QgdGhleSBhcmUgaW4gdGhlIHNh
bWUgZG9tYWluDQogICogZm9yIHRoZSBwZXJmb3JtYW5jZS4NCkBAIC04ODYsNiArODkwLDggQEAg
c3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfaW9tbXVfcGxhdF9kYXRhIG10MjcxMl9kYXRhID0gew0K
IAkubTR1X3BsYXQgICAgID0gTTRVX01UMjcxMiwNCiAJLmZsYWdzICAgICAgICA9IEhBU180R0Jf
TU9ERSB8IEhBU19CQ0xLIHwgSEFTX1ZMRF9QQV9STkcsDQogCS5pbnZfc2VsX3JlZyAgPSBSRUdf
TU1VX0lOVl9TRUxfR0VOMSwNCisJLmlvdmFfcmVnaW9uICA9IHNpbmdsZV9kb21haW4sDQorCS5p
b3ZhX3JlZ2lvbl9uciA9IEFSUkFZX1NJWkUoc2luZ2xlX2RvbWFpbiksDQogCS5sYXJiaWRfcmVt
YXAgPSB7ezB9LCB7MX0sIHsyfSwgezN9LCB7NH0sIHs1fSwgezZ9LCB7N319LA0KIH07DQogDQpA
QCAtODkzLDYgKzg5OSw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0
YSBtdDY3NzlfZGF0YSA9IHsNCiAJLm00dV9wbGF0ICAgICAgPSBNNFVfTVQ2Nzc5LA0KIAkuZmxh
Z3MgICAgICAgICA9IEhBU19TVUJfQ09NTSB8IE9VVF9PUkRFUl9XUl9FTiB8IFdSX1RIUk9UX0VO
LA0KIAkuaW52X3NlbF9yZWcgICA9IFJFR19NTVVfSU5WX1NFTF9HRU4yLA0KKwkuaW92YV9yZWdp
b24gICA9IHNpbmdsZV9kb21haW4sDQorCS5pb3ZhX3JlZ2lvbl9uciA9IEFSUkFZX1NJWkUoc2lu
Z2xlX2RvbWFpbiksDQogCS5sYXJiaWRfcmVtYXAgID0ge3swfSwgezF9LCB7Mn0sIHszfSwgezV9
LCB7NywgOH0sIHsxMH0sIHs5fX0sDQogfTsNCiANCkBAIC05MDAsNiArOTA4LDggQEAgc3RhdGlj
IGNvbnN0IHN0cnVjdCBtdGtfaW9tbXVfcGxhdF9kYXRhIG10ODE3M19kYXRhID0gew0KIAkubTR1
X3BsYXQgICAgID0gTTRVX01UODE3MywNCiAJLmZsYWdzCSAgICAgID0gSEFTXzRHQl9NT0RFIHwg
SEFTX0JDTEsgfCBSRVNFVF9BWEksDQogCS5pbnZfc2VsX3JlZyAgPSBSRUdfTU1VX0lOVl9TRUxf
R0VOMSwNCisJLmlvdmFfcmVnaW9uICA9IHNpbmdsZV9kb21haW4sDQorCS5pb3ZhX3JlZ2lvbl9u
ciA9IEFSUkFZX1NJWkUoc2luZ2xlX2RvbWFpbiksDQogCS5sYXJiaWRfcmVtYXAgPSB7ezB9LCB7
MX0sIHsyfSwgezN9LCB7NH0sIHs1fX0sIC8qIExpbmVhciBtYXBwaW5nLiAqLw0KIH07DQogDQpA
QCAtOTA3LDYgKzkxNyw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0
YSBtdDgxODNfZGF0YSA9IHsNCiAJLm00dV9wbGF0ICAgICA9IE00VV9NVDgxODMsDQogCS5mbGFn
cyAgICAgICAgPSBSRVNFVF9BWEksDQogCS5pbnZfc2VsX3JlZyAgPSBSRUdfTU1VX0lOVl9TRUxf
R0VOMSwNCisJLmlvdmFfcmVnaW9uICA9IHNpbmdsZV9kb21haW4sDQorCS5pb3ZhX3JlZ2lvbl9u
ciA9IEFSUkFZX1NJWkUoc2luZ2xlX2RvbWFpbiksDQogCS5sYXJiaWRfcmVtYXAgPSB7ezB9LCB7
NH0sIHs1fSwgezZ9LCB7N30sIHsyfSwgezN9LCB7MX19LA0KIH07DQogDQotLSANCjIuMTguMA0K

