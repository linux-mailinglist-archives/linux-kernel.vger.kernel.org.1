Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A1A2A8F38
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 07:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgKFGKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 01:10:37 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:23431 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726320AbgKFGKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 01:10:36 -0500
X-UUID: ebe35849da674f17aebd772a15f13129-20201106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=zhPGloZsKYH70pD64IqLi9e6Z3H0sSFRjHjf/LGQPMk=;
        b=YrlSoss0rpNU3mSh95dX0QbERhKtwFrBTdQEWpmsPnX5t2Tm7F0QO0Js6/q7mq/KfMXJ5WunKBBsU5vIawDzBaeNO4G74X/Nr3lNqhd5Nxyqoy1Is/5fHRGPY12FYn93oan219xMepGFEdefKbrjfQBDW57EWoAoP4vNw2CH52I=;
X-UUID: ebe35849da674f17aebd772a15f13129-20201106
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1018794509; Fri, 06 Nov 2020 14:10:27 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 6 Nov 2020 14:10:24 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 6 Nov 2020 14:10:23 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Ondrej Jirman <megous@megous.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Remi Pommarel <repk@triplefau.lt>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Yue Wang <yue.wang@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Joe Perches <joe@perches.com>,
        Bharat Gooty <bharat.gooty@broadcom.com>,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Peter Chen <peter.chen@nxp.com>, Roger Quadros <rogerq@ti.com>,
        Jyri Sarha <jsarha@ti.com>,
        Sanket Parmar <sparmar@cadence.com>,
        Anil Varughese <aniljoy@cadence.com>, Li Jun <jun.li@nxp.com>,
        Ma Feng <mafeng.ma@huawei.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 17/17] phy: ti: convert to devm_platform_ioremap_resource(_byname)
Date:   Fri, 6 Nov 2020 14:08:50 +0800
Message-ID: <1604642930-29019-17-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1604642930-29019-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1604642930-29019-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: D8457DDF41A86BD7A8A76CCFBE5E0E3DB9E888E7619A5D95075F3CC13754BA312000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZShfYnluYW1lKSB0byBzaW1wbGlmeSBj
b2RlDQoNClNpZ25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVr
LmNvbT4NCi0tLQ0KdjI6IG5vIGNoYW5nZXMNCi0tLQ0KIGRyaXZlcnMvcGh5L3RpL3BoeS1vbWFw
LWNvbnRyb2wuYyB8IDE3ICsrKysrKy0tLS0tLS0tLS0tDQogZHJpdmVycy9waHkvdGkvcGh5LW9t
YXAtdXNiMi5jICAgIHwgIDQgKy0tLQ0KIGRyaXZlcnMvcGh5L3RpL3BoeS10aS1waXBlMy5jICAg
ICB8IDE1ICsrKystLS0tLS0tLS0tLQ0KIDMgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygr
KSwgMjUgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3BoeS90aS9waHktb21h
cC1jb250cm9sLmMgYi9kcml2ZXJzL3BoeS90aS9waHktb21hcC1jb250cm9sLmMNCmluZGV4IGNj
ZDBlNGUwMDQ1MS4uNDc0ODJmMTA2ZmFiIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9waHkvdGkvcGh5
LW9tYXAtY29udHJvbC5jDQorKysgYi9kcml2ZXJzL3BoeS90aS9waHktb21hcC1jb250cm9sLmMN
CkBAIC0yNjgsNyArMjY4LDYgQEAgTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgb21hcF9jb250cm9s
X3BoeV9pZF90YWJsZSk7DQogDQogc3RhdGljIGludCBvbWFwX2NvbnRyb2xfcGh5X3Byb2JlKHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogew0KLQlzdHJ1Y3QgcmVzb3VyY2UJKnJlczsN
CiAJY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCAqb2ZfaWQ7DQogCXN0cnVjdCBvbWFwX2NvbnRy
b2xfcGh5ICpjb250cm9sX3BoeTsNCiANCkBAIC0yODUsMTYgKzI4NCwxMyBAQCBzdGF0aWMgaW50
IG9tYXBfY29udHJvbF9waHlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJ
Y29udHJvbF9waHktPnR5cGUgPSAqKGVudW0gb21hcF9jb250cm9sX3BoeV90eXBlICopb2ZfaWQt
PmRhdGE7DQogDQogCWlmIChjb250cm9sX3BoeS0+dHlwZSA9PSBPTUFQX0NUUkxfVFlQRV9PVEdI
Uykgew0KLQkJcmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlX2J5bmFtZShwZGV2LCBJT1JFU09V
UkNFX01FTSwNCi0JCQkib3RnaHNfY29udHJvbCIpOw0KLQkJY29udHJvbF9waHktPm90Z2hzX2Nv
bnRyb2wgPSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoDQotCQkJJnBkZXYtPmRldiwgcmVzKTsNCisJ
CWNvbnRyb2xfcGh5LT5vdGdoc19jb250cm9sID0NCisJCQlkZXZtX3BsYXRmb3JtX2lvcmVtYXBf
cmVzb3VyY2VfYnluYW1lKHBkZXYsICJvdGdoc19jb250cm9sIik7DQogCQlpZiAoSVNfRVJSKGNv
bnRyb2xfcGh5LT5vdGdoc19jb250cm9sKSkNCiAJCQlyZXR1cm4gUFRSX0VSUihjb250cm9sX3Bo
eS0+b3RnaHNfY29udHJvbCk7DQogCX0gZWxzZSB7DQotCQlyZXMgPSBwbGF0Zm9ybV9nZXRfcmVz
b3VyY2VfYnluYW1lKHBkZXYsIElPUkVTT1VSQ0VfTUVNLA0KLQkJCQkicG93ZXIiKTsNCi0JCWNv
bnRyb2xfcGh5LT5wb3dlciA9IGRldm1faW9yZW1hcF9yZXNvdXJjZSgmcGRldi0+ZGV2LCByZXMp
Ow0KKwkJY29udHJvbF9waHktPnBvd2VyID0NCisJCQlkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVz
b3VyY2VfYnluYW1lKHBkZXYsICJwb3dlciIpOw0KIAkJaWYgKElTX0VSUihjb250cm9sX3BoeS0+
cG93ZXIpKSB7DQogCQkJZGV2X2VycigmcGRldi0+ZGV2LCAiQ291bGRuJ3QgZ2V0IHBvd2VyIHJl
Z2lzdGVyXG4iKTsNCiAJCQlyZXR1cm4gUFRSX0VSUihjb250cm9sX3BoeS0+cG93ZXIpOw0KQEAg
LTMxMiw5ICszMDgsOCBAQCBzdGF0aWMgaW50IG9tYXBfY29udHJvbF9waHlfcHJvYmUoc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJfQ0KIA0KIAlpZiAoY29udHJvbF9waHktPnR5cGUg
PT0gT01BUF9DVFJMX1RZUEVfUENJRSkgew0KLQkJcmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNl
X2J5bmFtZShwZGV2LCBJT1JFU09VUkNFX01FTSwNCi0JCQkJCQkgICAicGNpZV9wY3MiKTsNCi0J
CWNvbnRyb2xfcGh5LT5wY2llX3BjcyA9IGRldm1faW9yZW1hcF9yZXNvdXJjZSgmcGRldi0+ZGV2
LCByZXMpOw0KKwkJY29udHJvbF9waHktPnBjaWVfcGNzID0NCisJCQlkZXZtX3BsYXRmb3JtX2lv
cmVtYXBfcmVzb3VyY2VfYnluYW1lKHBkZXYsICJwY2llX3BjcyIpOw0KIAkJaWYgKElTX0VSUihj
b250cm9sX3BoeS0+cGNpZV9wY3MpKQ0KIAkJCXJldHVybiBQVFJfRVJSKGNvbnRyb2xfcGh5LT5w
Y2llX3Bjcyk7DQogCX0NCmRpZmYgLS1naXQgYS9kcml2ZXJzL3BoeS90aS9waHktb21hcC11c2Iy
LmMgYi9kcml2ZXJzL3BoeS90aS9waHktb21hcC11c2IyLmMNCmluZGV4IDRmZWM5MGQyNjI0Zi4u
ZWJjZWIxNTIwY2U4IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9waHkvdGkvcGh5LW9tYXAtdXNiMi5j
DQorKysgYi9kcml2ZXJzL3BoeS90aS9waHktb21hcC11c2IyLmMNCkBAIC0zNjYsNyArMzY2LDYg
QEAgc3RhdGljIGludCBvbWFwX3VzYjJfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRl
dikNCiB7DQogCXN0cnVjdCBvbWFwX3VzYgkqcGh5Ow0KIAlzdHJ1Y3QgcGh5ICpnZW5lcmljX3Bo
eTsNCi0Jc3RydWN0IHJlc291cmNlICpyZXM7DQogCXN0cnVjdCBwaHlfcHJvdmlkZXIgKnBoeV9w
cm92aWRlcjsNCiAJc3RydWN0IHVzYl9vdGcgKm90ZzsNCiAJc3RydWN0IGRldmljZV9ub2RlICpu
b2RlID0gcGRldi0+ZGV2Lm9mX25vZGU7DQpAQCAtNDAzLDggKzQwMiw3IEBAIHN0YXRpYyBpbnQg
b21hcF91c2IyX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogDQogCW9tYXBf
dXNiMl9pbml0X2VycmF0YShwaHkpOw0KIA0KLQlyZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2Uo
cGRldiwgSU9SRVNPVVJDRV9NRU0sIDApOw0KLQlwaHktPnBoeV9iYXNlID0gZGV2bV9pb3JlbWFw
X3Jlc291cmNlKCZwZGV2LT5kZXYsIHJlcyk7DQorCXBoeS0+cGh5X2Jhc2UgPSBkZXZtX3BsYXRm
b3JtX2lvcmVtYXBfcmVzb3VyY2UocGRldiwgMCk7DQogCWlmIChJU19FUlIocGh5LT5waHlfYmFz
ZSkpDQogCQlyZXR1cm4gUFRSX0VSUihwaHktPnBoeV9iYXNlKTsNCiANCmRpZmYgLS1naXQgYS9k
cml2ZXJzL3BoeS90aS9waHktdGktcGlwZTMuYyBiL2RyaXZlcnMvcGh5L3RpL3BoeS10aS1waXBl
My5jDQppbmRleCBlOTMzMmM5MGY3NWYuLjJjYmM5MWU1MzVkNCAxMDA2NDQNCi0tLSBhL2RyaXZl
cnMvcGh5L3RpL3BoeS10aS1waXBlMy5jDQorKysgYi9kcml2ZXJzL3BoeS90aS9waHktdGktcGlw
ZTMuYw0KQEAgLTc0NSwzNSArNzQ1LDI4IEBAIHN0YXRpYyBpbnQgdGlfcGlwZTNfZ2V0X3N5c2N0
cmwoc3RydWN0IHRpX3BpcGUzICpwaHkpDQogDQogc3RhdGljIGludCB0aV9waXBlM19nZXRfdHhf
cnhfYmFzZShzdHJ1Y3QgdGlfcGlwZTMgKnBoeSkNCiB7DQotCXN0cnVjdCByZXNvdXJjZSAqcmVz
Ow0KIAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSBwaHktPmRldjsNCiAJc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSAqcGRldiA9IHRvX3BsYXRmb3JtX2RldmljZShkZXYpOw0KIA0KLQlyZXMgPSBwbGF0Zm9y
bV9nZXRfcmVzb3VyY2VfYnluYW1lKHBkZXYsIElPUkVTT1VSQ0VfTUVNLA0KLQkJCQkJICAgInBo
eV9yeCIpOw0KLQlwaHktPnBoeV9yeCA9IGRldm1faW9yZW1hcF9yZXNvdXJjZShkZXYsIHJlcyk7
DQorCXBoeS0+cGh5X3J4ID0gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlX2J5bmFtZShw
ZGV2LCAicGh5X3J4Iik7DQogCWlmIChJU19FUlIocGh5LT5waHlfcngpKQ0KIAkJcmV0dXJuIFBU
Ul9FUlIocGh5LT5waHlfcngpOw0KIA0KLQlyZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2VfYnlu
YW1lKHBkZXYsIElPUkVTT1VSQ0VfTUVNLA0KLQkJCQkJICAgInBoeV90eCIpOw0KLQlwaHktPnBo
eV90eCA9IGRldm1faW9yZW1hcF9yZXNvdXJjZShkZXYsIHJlcyk7DQorCXBoeS0+cGh5X3R4ID0g
ZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlX2J5bmFtZShwZGV2LCAicGh5X3R4Iik7DQog
DQogCXJldHVybiBQVFJfRVJSX09SX1pFUk8ocGh5LT5waHlfdHgpOw0KIH0NCiANCiBzdGF0aWMg
aW50IHRpX3BpcGUzX2dldF9wbGxfYmFzZShzdHJ1Y3QgdGlfcGlwZTMgKnBoeSkNCiB7DQotCXN0
cnVjdCByZXNvdXJjZSAqcmVzOw0KIAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSBwaHktPmRldjsNCiAJ
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiA9IHRvX3BsYXRmb3JtX2RldmljZShkZXYpOw0K
IA0KIAlpZiAocGh5LT5tb2RlID09IFBJUEUzX01PREVfUENJRSkNCiAJCXJldHVybiAwOw0KIA0K
LQlyZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2VfYnluYW1lKHBkZXYsIElPUkVTT1VSQ0VfTUVN
LA0KLQkJCQkJICAgInBsbF9jdHJsIik7DQotCXBoeS0+cGxsX2N0cmxfYmFzZSA9IGRldm1faW9y
ZW1hcF9yZXNvdXJjZShkZXYsIHJlcyk7DQorCXBoeS0+cGxsX2N0cmxfYmFzZSA9DQorCQlkZXZt
X3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2VfYnluYW1lKHBkZXYsICJwbGxfY3RybCIpOw0KIAly
ZXR1cm4gUFRSX0VSUl9PUl9aRVJPKHBoeS0+cGxsX2N0cmxfYmFzZSk7DQogfQ0KIA0KLS0gDQoy
LjE4LjANCg==

