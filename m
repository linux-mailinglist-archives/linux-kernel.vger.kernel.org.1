Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F6A295ED6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 14:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898676AbgJVMne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 08:43:34 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:44200 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2506347AbgJVMnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 08:43:32 -0400
X-UUID: 13fb070031214982969e6fa8294fdbd6-20201022
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=aBzxpn89OHFE6mNwRbJORzl7ZATcKhhfOKp4Ir7+2g4=;
        b=pvsBarbJBQFgg6mDFTY/g2xxohivfbbPNvG+SVwg7yQ9axWKtW+7tY6NUeK1m06iQyRy9TuaGwZBs75YsCKFwl/NPJnJYAVE1Z6FBufIu1VkIJ/tG8jAWPdBuUh3IlpPnXFbsmumYsnxuLvKNBWt6MGTcDcXjwkYIQd8N+I2WOI=;
X-UUID: 13fb070031214982969e6fa8294fdbd6-20201022
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1924466255; Thu, 22 Oct 2020 20:37:58 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 22 Oct 2020 20:37:56 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Oct 2020 20:37:56 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v4 31/34] clk: mediatek: Add MT8192 scp adsp clock support
Date:   Thu, 22 Oct 2020 20:37:24 +0800
Message-ID: <1603370247-30437-32-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1603370247-30437-1-git-send-email-weiyi.lu@mediatek.com>
References: <1603370247-30437-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIE1UODE5MiBzY3AgYWRzcCBjbG9jayBwcm92aWRlcg0KDQpTaWduZWQtb2ZmLWJ5OiBXZWl5
aSBMdSA8d2VpeWkubHVAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9jbGsvbWVkaWF0ZWsv
S2NvbmZpZyAgICAgICAgICAgICAgIHwgIDYgKysrKw0KIGRyaXZlcnMvY2xrL21lZGlhdGVrL01h
a2VmaWxlICAgICAgICAgICAgICB8ICAxICsNCiBkcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4
MTkyLXNjcF9hZHNwLmMgfCA1NyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCiAzIGZp
bGVzIGNoYW5nZWQsIDY0IGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVy
cy9jbGsvbWVkaWF0ZWsvY2xrLW10ODE5Mi1zY3BfYWRzcC5jDQoNCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2Nsay9tZWRpYXRlay9LY29uZmlnIGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsvS2NvbmZpZw0K
aW5kZXggNGI4Y2FlNi4uMjJkMDY5OSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvY2xrL21lZGlhdGVr
L0tjb25maWcNCisrKyBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL0tjb25maWcNCkBAIC01NjMsNiAr
NTYzLDEyIEBAIGNvbmZpZyBDT01NT05fQ0xLX01UODE5Ml9NU0RDDQogCWhlbHANCiAJICBUaGlz
IGRyaXZlciBzdXBwb3J0cyBNZWRpYVRlayBNVDgxOTIgbXNkYyBjbG9ja3MuDQogDQorY29uZmln
IENPTU1PTl9DTEtfTVQ4MTkyX1NDUF9BRFNQDQorCWJvb2wgIkNsb2NrIGRyaXZlciBmb3IgTWVk
aWFUZWsgTVQ4MTkyIHNjcF9hZHNwIg0KKwlkZXBlbmRzIG9uIENPTU1PTl9DTEtfTVQ4MTkyDQor
CWhlbHANCisJICBUaGlzIGRyaXZlciBzdXBwb3J0cyBNZWRpYVRlayBNVDgxOTIgc2NwX2Fkc3Ag
Y2xvY2tzLg0KKw0KIGNvbmZpZyBDT01NT05fQ0xLX01UODUxNg0KIAlib29sICJDbG9jayBkcml2
ZXIgZm9yIE1lZGlhVGVrIE1UODUxNiINCiAJZGVwZW5kcyBvbiBBUkNIX01FRElBVEVLIHx8IENP
TVBJTEVfVEVTVA0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL21lZGlhdGVrL01ha2VmaWxlIGIv
ZHJpdmVycy9jbGsvbWVkaWF0ZWsvTWFrZWZpbGUNCmluZGV4IDMxZTEzNGIuLjY2MmNkMWEgMTAw
NjQ0DQotLS0gYS9kcml2ZXJzL2Nsay9tZWRpYXRlay9NYWtlZmlsZQ0KKysrIGIvZHJpdmVycy9j
bGsvbWVkaWF0ZWsvTWFrZWZpbGUNCkBAIC04MSw1ICs4MSw2IEBAIG9iai0kKENPTkZJR19DT01N
T05fQ0xLX01UODE5Ml9NRkdDRkcpICs9IGNsay1tdDgxOTItbWZnLm8NCiBvYmotJChDT05GSUdf
Q09NTU9OX0NMS19NVDgxOTJfTU1TWVMpICs9IGNsay1tdDgxOTItbW0ubw0KIG9iai0kKENPTkZJ
R19DT01NT05fQ0xLX01UODE5Ml9NU0RDX1RPUCkgKz0gY2xrLW10ODE5Mi1tc2RjX3RvcC5vDQog
b2JqLSQoQ09ORklHX0NPTU1PTl9DTEtfTVQ4MTkyX01TREMpICs9IGNsay1tdDgxOTItbXNkYy5v
DQorb2JqLSQoQ09ORklHX0NPTU1PTl9DTEtfTVQ4MTkyX1NDUF9BRFNQKSArPSBjbGstbXQ4MTky
LXNjcF9hZHNwLm8NCiBvYmotJChDT05GSUdfQ09NTU9OX0NMS19NVDg1MTYpICs9IGNsay1tdDg1
MTYubw0KIG9iai0kKENPTkZJR19DT01NT05fQ0xLX01UODUxNl9BVURTWVMpICs9IGNsay1tdDg1
MTYtYXVkLm8NCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTkyLXNj
cF9hZHNwLmMgYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTkyLXNjcF9hZHNwLmMNCm5l
dyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwLi4zYzA1MTQwDQotLS0gL2Rldi9udWxs
DQorKysgYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTkyLXNjcF9hZHNwLmMNCkBAIC0w
LDAgKzEsNTcgQEANCisvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5DQor
Ly8NCisvLyBDb3B5cmlnaHQgKGMpIDIwMjAgTWVkaWFUZWsgSW5jLg0KKy8vIEF1dGhvcjogV2Vp
eWkgTHUgPHdlaXlpLmx1QG1lZGlhdGVrLmNvbT4NCisNCisjaW5jbHVkZSA8bGludXgvY2xrLXBy
b3ZpZGVyLmg+DQorI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KKw0KKyNpbmNs
dWRlICJjbGstbXRrLmgiDQorI2luY2x1ZGUgImNsay1nYXRlLmgiDQorDQorI2luY2x1ZGUgPGR0
LWJpbmRpbmdzL2Nsb2NrL210ODE5Mi1jbGsuaD4NCisNCitzdGF0aWMgY29uc3Qgc3RydWN0IG10
a19nYXRlX3JlZ3Mgc2NwX2Fkc3BfY2dfcmVncyA9IHsNCisJLnNldF9vZnMgPSAweDE4MCwNCisJ
LmNscl9vZnMgPSAweDE4MCwNCisJLnN0YV9vZnMgPSAweDE4MCwNCit9Ow0KKw0KKyNkZWZpbmUg
R0FURV9TQ1BfQURTUChfaWQsIF9uYW1lLCBfcGFyZW50LCBfc2hpZnQpCVwNCisJR0FURV9NVEso
X2lkLCBfbmFtZSwgX3BhcmVudCwgJnNjcF9hZHNwX2NnX3JlZ3MsIF9zaGlmdCwgJm10a19jbGtf
Z2F0ZV9vcHNfbm9fc2V0Y2xyKQ0KKw0KK3N0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2dhdGUgc2Nw
X2Fkc3BfY2xrc1tdID0gew0KKwlHQVRFX1NDUF9BRFNQKENMS19TQ1BfQURTUF9BVURJT0RTUCwg
InNjcF9hZHNwX2F1ZGlvZHNwIiwgImFkc3Bfc2VsIiwgMCksDQorfTsNCisNCitzdGF0aWMgaW50
IGNsa19tdDgxOTJfc2NwX2Fkc3BfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikN
Cit7DQorCXN0cnVjdCBjbGtfb25lY2VsbF9kYXRhICpjbGtfZGF0YTsNCisJc3RydWN0IGRldmlj
ZV9ub2RlICpub2RlID0gcGRldi0+ZGV2Lm9mX25vZGU7DQorCWludCByOw0KKw0KKwljbGtfZGF0
YSA9IG10a19hbGxvY19jbGtfZGF0YShDTEtfU0NQX0FEU1BfTlJfQ0xLKTsNCisJaWYgKCFjbGtf
ZGF0YSkNCisJCXJldHVybiAtRU5PTUVNOw0KKw0KKwlyID0gbXRrX2Nsa19yZWdpc3Rlcl9nYXRl
cyhub2RlLCBzY3BfYWRzcF9jbGtzLCBBUlJBWV9TSVpFKHNjcF9hZHNwX2Nsa3MpLCBjbGtfZGF0
YSk7DQorCWlmIChyKQ0KKwkJcmV0dXJuIHI7DQorDQorCXJldHVybiBvZl9jbGtfYWRkX3Byb3Zp
ZGVyKG5vZGUsIG9mX2Nsa19zcmNfb25lY2VsbF9nZXQsIGNsa19kYXRhKTsNCit9DQorDQorc3Rh
dGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgb2ZfbWF0Y2hfY2xrX210ODE5Ml9zY3BfYWRz
cFtdID0gew0KKwl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5Mi1zY3BfYWRzcCIsIH0s
DQorCXt9DQorfTsNCisNCitzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBjbGtfbXQ4MTky
X3NjcF9hZHNwX2RydiA9IHsNCisJLnByb2JlID0gY2xrX210ODE5Ml9zY3BfYWRzcF9wcm9iZSwN
CisJLmRyaXZlciA9IHsNCisJCS5uYW1lID0gImNsay1tdDgxOTItc2NwX2Fkc3AiLA0KKwkJLm9m
X21hdGNoX3RhYmxlID0gb2ZfbWF0Y2hfY2xrX210ODE5Ml9zY3BfYWRzcCwNCisJfSwNCit9Ow0K
Kw0KK2J1aWx0aW5fcGxhdGZvcm1fZHJpdmVyKGNsa19tdDgxOTJfc2NwX2Fkc3BfZHJ2KTsNCi0t
IA0KMS44LjEuMS5kaXJ0eQ0K

