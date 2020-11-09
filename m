Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B772AAEE9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 03:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729063AbgKICEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 21:04:00 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:57267 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728006AbgKICD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 21:03:59 -0500
X-UUID: 7dec71fd02864847bc6fd8c36d4da4a9-20201109
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=t6abyv7GQaCstliXITKrDOnJbXdw7pIR+rkQrfnHEvI=;
        b=eURTsWljrACT4cc0oIz2kutlB56jDOD8arqU3QIS/kgH4u5aIlRLl0bDB8o5zkNEjQQEdtUvm73YoOloLagIvZHiy6B2HZYfqqVDGDc7P8EtxbNLUv8Aed/bQ5XrtOldx+fBF2EGjcnwjxq+vadBsqURk6T8VMqI9Xgy5MSQJ48=;
X-UUID: 7dec71fd02864847bc6fd8c36d4da4a9-20201109
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1082000444; Mon, 09 Nov 2020 10:03:53 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 9 Nov 2020 10:03:53 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 9 Nov 2020 10:03:52 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>
Subject: [PATCH v5 09/24] clk: mediatek: Add mtk_clk_simple_probe() to simplify clock providers
Date:   Mon, 9 Nov 2020 10:03:34 +0800
Message-ID: <1604887429-29445-10-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1604887429-29445-1-git-send-email-weiyi.lu@mediatek.com>
References: <1604887429-29445-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TW9zdCBvZiBzdWJzeXN0ZW0gY2xvY2sgcHJvdmlkZXJzIG9ubHkgbmVlZCB0byByZWdpc3RlciBj
bG9jayBnYXRlcw0KaW4gdGhlaXIgcHJvYmUoKSBmdW5jdGlvbi4NClRvIHJlZHVjZSB0aGUgZHVw
bGljYXRlZCBjb2RlIGJ5IGFkZCBhIGdlbmVyaWMgZnVuY3Rpb24uDQoNClNpZ25lZC1vZmYtYnk6
IFdlaXlpIEx1IDx3ZWl5aS5sdUBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL2Nsay9tZWRp
YXRlay9jbGstbXRrLmMgfCAyMyArKysrKysrKysrKysrKysrKysrKysrKw0KIGRyaXZlcnMvY2xr
L21lZGlhdGVrL2Nsay1tdGsuaCB8ICA4ICsrKysrKysrDQogMiBmaWxlcyBjaGFuZ2VkLCAzMSBp
bnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXRr
LmMgYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXRrLmMNCmluZGV4IGNlYzFjOGEuLjY3Njkz
YjcgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXRrLmMNCisrKyBiL2Ry
aXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdGsuYw0KQEAgLTEzLDYgKzEzLDcgQEANCiAjaW5jbHVk
ZSA8bGludXgvY2xrZGV2Lmg+DQogI2luY2x1ZGUgPGxpbnV4L21mZC9zeXNjb24uaD4NCiAjaW5j
bHVkZSA8bGludXgvZGV2aWNlLmg+DQorI2luY2x1ZGUgPGxpbnV4L29mX2RldmljZS5oPg0KIA0K
ICNpbmNsdWRlICJjbGstbXRrLmgiDQogI2luY2x1ZGUgImNsay1nYXRlLmgiDQpAQCAtMjg2LDMg
KzI4NywyNSBAQCB2b2lkIG10a19jbGtfcmVnaXN0ZXJfZGl2aWRlcnMoY29uc3Qgc3RydWN0IG10
a19jbGtfZGl2aWRlciAqbWNkcywNCiAJCQljbGtfZGF0YS0+Y2xrc1ttY2QtPmlkXSA9IGNsazsN
CiAJfQ0KIH0NCisNCitpbnQgbXRrX2Nsa19zaW1wbGVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSAqcGRldikNCit7DQorCWNvbnN0IHN0cnVjdCBtdGtfY2xrX2Rlc2MgKm1jZDsNCisJc3Ry
dWN0IGNsa19vbmVjZWxsX2RhdGEgKmNsa19kYXRhOw0KKwlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5v
ZGUgPSBwZGV2LT5kZXYub2Zfbm9kZTsNCisJaW50IHI7DQorDQorCW1jZCA9IG9mX2RldmljZV9n
ZXRfbWF0Y2hfZGF0YSgmcGRldi0+ZGV2KTsNCisJaWYgKCFtY2QpDQorCQlyZXR1cm4gLUVJTlZB
TDsNCisNCisJY2xrX2RhdGEgPSBtdGtfYWxsb2NfY2xrX2RhdGEobWNkLT5udW1fY2xrcyk7DQor
CWlmICghY2xrX2RhdGEpDQorCQlyZXR1cm4gLUVOT01FTTsNCisNCisJciA9IG10a19jbGtfcmVn
aXN0ZXJfZ2F0ZXMobm9kZSwgbWNkLT5jbGtzLCBtY2QtPm51bV9jbGtzLCBjbGtfZGF0YSk7DQor
CWlmIChyKQ0KKwkJcmV0dXJuIHI7DQorDQorCXJldHVybiBvZl9jbGtfYWRkX3Byb3ZpZGVyKG5v
ZGUsIG9mX2Nsa19zcmNfb25lY2VsbF9nZXQsIGNsa19kYXRhKTsNCit9DQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ay5oIGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xr
LW10ay5oDQppbmRleCBjNTgwNjYzLi4yZjYxZmJhIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9jbGsv
bWVkaWF0ZWsvY2xrLW10ay5oDQorKysgYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXRrLmgN
CkBAIC0xMCw2ICsxMCw3IEBADQogI2luY2x1ZGUgPGxpbnV4L3JlZ21hcC5oPg0KICNpbmNsdWRl
IDxsaW51eC9iaXRvcHMuaD4NCiAjaW5jbHVkZSA8bGludXgvY2xrLXByb3ZpZGVyLmg+DQorI2lu
Y2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KIA0KIHN0cnVjdCBjbGs7DQogc3RydWN0
IGNsa19vbmVjZWxsX2RhdGE7DQpAQCAtMjUwLDQgKzI1MSwxMSBAQCB2b2lkIG10a19yZWdpc3Rl
cl9yZXNldF9jb250cm9sbGVyKHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAsDQogdm9pZCBtdGtfcmVn
aXN0ZXJfcmVzZXRfY29udHJvbGxlcl9zZXRfY2xyKHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAsDQog
CXVuc2lnbmVkIGludCBudW1fcmVncywgaW50IHJlZ29mcyk7DQogDQorc3RydWN0IG10a19jbGtf
ZGVzYyB7DQorCWNvbnN0IHN0cnVjdCBtdGtfZ2F0ZSAqY2xrczsNCisJc2l6ZV90IG51bV9jbGtz
Ow0KK307DQorDQoraW50IG10a19jbGtfc2ltcGxlX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgKnBkZXYpOw0KKw0KICNlbmRpZiAvKiBfX0RSVl9DTEtfTVRLX0ggKi8NCi0tIA0KMS44LjEu
MS5kaXJ0eQ0K

