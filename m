Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6179D300295
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 13:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbhAVMKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 07:10:47 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:52147 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727850AbhAVMEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 07:04:41 -0500
X-UUID: bac98e9f2202490c8623c171bf8d4b72-20210122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=NaVzE9cIz0mqzcYeID0kGbsmkZXY4JmtDNTBmt623ys=;
        b=KZazuwWkOxA7E/ro5iLGKRHXAwDi9K5nG3mcOhF4Ez7m/QTfpyw+eWWVMVrw/i0ZBDaaw9iYDg3vn5DsszAajRfDKwdWEwU5jcl5bf2viak3cahbQnT1A6cV5CzFTXawxnFTL4Lb9ZK2gO+2RU1kQ+/6D0IuI8/wB3MhLDmtMn4=;
X-UUID: bac98e9f2202490c8623c171bf8d4b72-20210122
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 230396973; Fri, 22 Jan 2021 20:03:45 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 Jan 2021 20:03:43 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 Jan 2021 20:03:42 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Min Guo <min.guo@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Subject: [PATCH next v2 12/17] arm64: dts: mediatek: mt8516: harmonize node names and compatibles
Date:   Fri, 22 Jan 2021 20:03:18 +0800
Message-ID: <20210122120323.4337-12-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210122120323.4337-1-chunfeng.yun@mediatek.com>
References: <20210122120323.4337-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 567D863AB8022F41CB8B44A4AE735647B85D90B255D8360C9A798BA4EBDAF3B52000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBpcyB1c2VkIHRvIGZpeCBkdGJzX2NoZWNrIHdhcm5pbmc6DQogIGhhcm1vbml6ZSBub2Rl
IG5hbWVzIGFuZCBjb21wYXRpYmxlczsNCiAgYWRkIHByb3BlcnR5ICJ1c2Itcm9sZS1zd2l0Y2gi
IGZvciBjb25uZWN0b3IgZGVwZW5kZW5jZS4NCg0KU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVu
IDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KLS0tDQp2Mjogbm8gY2hhbmdlcw0KLS0tDQog
YXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDg1MTYuZHRzaSAgICAgICAgIHwgOSArKysr
Ky0tLS0NCiBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL3B1bXBraW4tY29tbW9uLmR0c2kg
fCAxICsNCiAyIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkN
Cg0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4NTE2LmR0c2kg
Yi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODUxNi5kdHNpDQppbmRleCBlNmU0ZDlk
NjAwOTQuLjcwYzljNzQyM2JkNCAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVk
aWF0ZWsvbXQ4NTE2LmR0c2kNCisrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4
NTE2LmR0c2kNCkBAIC00NTAsNyArNDUwLDcgQEANCiAJCX07DQogDQogCQl1c2IwOiB1c2JAMTEx
MDAwMDAgew0KLQkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXRrLW11c2IiOw0KKwkJCWNvbXBh
dGlibGUgPSAibWVkaWF0ZWssbXQ4NTE2LW11c2IiLCAibWVkaWF0ZWssbXRrLW11c2IiOw0KIAkJ
CXJlZyA9IDwwIDB4MTExMDAwMDAgMCAweDEwMDA+Ow0KIAkJCWludGVycnVwdHMgPSA8R0lDX1NQ
SSA3MiBJUlFfVFlQRV9MRVZFTF9MT1c+Ow0KIAkJCWludGVycnVwdC1uYW1lcyA9ICJtYyI7DQpA
QCAtNDYzLDcgKzQ2Myw3IEBADQogCQl9Ow0KIA0KIAkJdXNiMTogdXNiQDExMTkwMDAwIHsNCi0J
CQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ay1tdXNiIjsNCisJCQljb21wYXRpYmxlID0gIm1l
ZGlhdGVrLG10ODUxNi1tdXNiIiwgIm1lZGlhdGVrLG10ay1tdXNiIjsNCiAJCQlyZWcgPSA8MCAw
eDExMTkwMDAwIDAgMHgxMDAwPjsNCiAJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMjEwIElSUV9U
WVBFX0xFVkVMX0xPVz47DQogCQkJaW50ZXJydXB0LW5hbWVzID0gIm1jIjsNCkBAIC00NzYsOCAr
NDc2LDkgQEANCiAJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KIAkJfTsNCiANCi0JCXVzYl9waHk6
IHVzYkAxMTExMDAwMCB7DQotCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxnZW5lcmljLXRwaHkt
djEiOw0KKwkJdXNiX3BoeTogdC1waHlAMTExMTAwMDAgew0KKwkJCWNvbXBhdGlibGUgPSAibWVk
aWF0ZWssbXQ4NTE2LXRwaHkiLA0KKwkJCQkgICAgICJtZWRpYXRlayxnZW5lcmljLXRwaHktdjEi
Ow0KIAkJCXJlZyA9IDwwIDB4MTExMTAwMDAgMCAweDgwMD47DQogCQkJI2FkZHJlc3MtY2VsbHMg
PSA8Mj47DQogCQkJI3NpemUtY2VsbHMgPSA8Mj47DQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9i
b290L2R0cy9tZWRpYXRlay9wdW1wa2luLWNvbW1vbi5kdHNpIGIvYXJjaC9hcm02NC9ib290L2R0
cy9tZWRpYXRlay9wdW1wa2luLWNvbW1vbi5kdHNpDQppbmRleCA2M2ZkNzAwODZiYjguLjdkNzM4
ZjAxY2Y4ZCAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvcHVtcGtp
bi1jb21tb24uZHRzaQ0KKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9wdW1wa2lu
LWNvbW1vbi5kdHNpDQpAQCAtMTg4LDYgKzE4OCw3IEBADQogJnVzYjAgew0KIAlzdGF0dXMgPSAi
b2theSI7DQogCWRyX21vZGUgPSAicGVyaXBoZXJhbCI7DQorCXVzYi1yb2xlLXN3aXRjaDsNCiAN
CiAJdXNiX2NvbjogY29ubmVjdG9yIHsNCiAJCWNvbXBhdGlibGUgPSAidXNiLWMtY29ubmVjdG9y
IjsNCi0tIA0KMi4xOC4wDQo=

