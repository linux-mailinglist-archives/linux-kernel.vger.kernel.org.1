Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D9D2A8F30
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 07:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgKFGKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 01:10:03 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:64545 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726241AbgKFGKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 01:10:02 -0500
X-UUID: a2375fee6f274994b3e47a71768c87e9-20201106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Vv5JfyijMFP4q6lF2MjfNMhN+aJ47SiZq4p6rMFLGaI=;
        b=MDDarNYk0Sj72yQ2lpFVJPgyS2pRFtGM+G+fH822+/JDHF2k2UpnqQ6j6ksep+sLHQU8TFb5zAUAZITkQALRoxm5bTcYg5Aj/0m88lgIQph5eEjW66e5BnuGqzc5CdzdTMJehTgs5uzxXknQLLcnzdEU3GrndOn6/bPqT5hxy8g=;
X-UUID: a2375fee6f274994b3e47a71768c87e9-20201106
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 923017171; Fri, 06 Nov 2020 14:09:38 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 6 Nov 2020 14:09:36 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 6 Nov 2020 14:09:34 +0800
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
Subject: [PATCH v2 05/17] phy: freescale: convert to devm_platform_ioremap_resource
Date:   Fri, 6 Nov 2020 14:08:38 +0800
Message-ID: <1604642930-29019-5-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1604642930-29019-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1604642930-29019-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: F939225C95C083321A204A58C720B8F21DC2D93F564C7C6A52DB08C180F68BC52000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZSB0byBzaW1wbGlmeSBjb2RlDQoNClNp
Z25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NClJl
dmlld2VkLWJ5OiBQZXRlciBDaGVuIDxwZXRlci5jaGVuQG54cC5jb20+DQotLS0NCnYyOiBhZGQg
UmV2aWV3ZWQtYnkgUGV0ZXINCi0tLQ0KIGRyaXZlcnMvcGh5L2ZyZWVzY2FsZS9waHktZnNsLWlt
eDgtbWlwaS1kcGh5LmMgfCA0ICstLS0NCiBkcml2ZXJzL3BoeS9mcmVlc2NhbGUvcGh5LWZzbC1p
bXg4bXEtdXNiLmMgICAgIHwgNCArLS0tDQogMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDYgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3BoeS9mcmVlc2NhbGUv
cGh5LWZzbC1pbXg4LW1pcGktZHBoeS5jIGIvZHJpdmVycy9waHkvZnJlZXNjYWxlL3BoeS1mc2wt
aW14OC1taXBpLWRwaHkuYw0KaW5kZXggOWYyYzFkYTE0ZjVhLi5hOTU1NzJiMzk3Y2EgMTAwNjQ0
DQotLS0gYS9kcml2ZXJzL3BoeS9mcmVlc2NhbGUvcGh5LWZzbC1pbXg4LW1pcGktZHBoeS5jDQor
KysgYi9kcml2ZXJzL3BoeS9mcmVlc2NhbGUvcGh5LWZzbC1pbXg4LW1pcGktZHBoeS5jDQpAQCAt
NDM0LDcgKzQzNCw2IEBAIHN0YXRpYyBpbnQgbWl4ZWxfZHBoeV9wcm9iZShzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpwZGV2KQ0KIAlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gZGV2LT5vZl9ub2Rl
Ow0KIAlzdHJ1Y3QgcGh5X3Byb3ZpZGVyICpwaHlfcHJvdmlkZXI7DQogCXN0cnVjdCBtaXhlbF9k
cGh5X3ByaXYgKnByaXY7DQotCXN0cnVjdCByZXNvdXJjZSAqcmVzOw0KIAlzdHJ1Y3QgcGh5ICpw
aHk7DQogCXZvaWQgX19pb21lbSAqYmFzZTsNCiANCkBAIC00NDksOCArNDQ4LDcgQEAgc3RhdGlj
IGludCBtaXhlbF9kcGh5X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCWlm
ICghcHJpdi0+ZGV2ZGF0YSkNCiAJCXJldHVybiAtRUlOVkFMOw0KIA0KLQlyZXMgPSBwbGF0Zm9y
bV9nZXRfcmVzb3VyY2UocGRldiwgSU9SRVNPVVJDRV9NRU0sIDApOw0KLQliYXNlID0gZGV2bV9p
b3JlbWFwX3Jlc291cmNlKGRldiwgcmVzKTsNCisJYmFzZSA9IGRldm1fcGxhdGZvcm1faW9yZW1h
cF9yZXNvdXJjZShwZGV2LCAwKTsNCiAJaWYgKElTX0VSUihiYXNlKSkNCiAJCXJldHVybiBQVFJf
RVJSKGJhc2UpOw0KIA0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGh5L2ZyZWVzY2FsZS9waHktZnNs
LWlteDhtcS11c2IuYyBiL2RyaXZlcnMvcGh5L2ZyZWVzY2FsZS9waHktZnNsLWlteDhtcS11c2Iu
Yw0KaW5kZXggNjJkNmQ2ODQ5YWQ2Li4wYjllZTJiMTcxNmYgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L3BoeS9mcmVlc2NhbGUvcGh5LWZzbC1pbXg4bXEtdXNiLmMNCisrKyBiL2RyaXZlcnMvcGh5L2Zy
ZWVzY2FsZS9waHktZnNsLWlteDhtcS11c2IuYw0KQEAgLTE1Miw3ICsxNTIsNiBAQCBzdGF0aWMg
aW50IGlteDhtcV91c2JfcGh5X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQog
CXN0cnVjdCBwaHlfcHJvdmlkZXIgKnBoeV9wcm92aWRlcjsNCiAJc3RydWN0IGRldmljZSAqZGV2
ID0gJnBkZXYtPmRldjsNCiAJc3RydWN0IGlteDhtcV91c2JfcGh5ICppbXhfcGh5Ow0KLQlzdHJ1
Y3QgcmVzb3VyY2UgKnJlczsNCiAJY29uc3Qgc3RydWN0IHBoeV9vcHMgKnBoeV9vcHM7DQogDQog
CWlteF9waHkgPSBkZXZtX2t6YWxsb2MoZGV2LCBzaXplb2YoKmlteF9waHkpLCBHRlBfS0VSTkVM
KTsNCkBAIC0xNjUsOCArMTY0LDcgQEAgc3RhdGljIGludCBpbXg4bXFfdXNiX3BoeV9wcm9iZShz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAkJcmV0dXJuIFBUUl9FUlIoaW14X3BoeS0+
Y2xrKTsNCiAJfQ0KIA0KLQlyZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UocGRldiwgSU9SRVNP
VVJDRV9NRU0sIDApOw0KLQlpbXhfcGh5LT5iYXNlID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKGRl
diwgcmVzKTsNCisJaW14X3BoeS0+YmFzZSA9IGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJj
ZShwZGV2LCAwKTsNCiAJaWYgKElTX0VSUihpbXhfcGh5LT5iYXNlKSkNCiAJCXJldHVybiBQVFJf
RVJSKGlteF9waHktPmJhc2UpOw0KIA0KLS0gDQoyLjE4LjANCg==

