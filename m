Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C822A8F35
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 07:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgKFGKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 01:10:20 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:20362 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725835AbgKFGKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 01:10:19 -0500
X-UUID: fca9b31b148b4c6b92468852ff29197e-20201106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=QnknwOw5l77wPruk4vzgXllX2A4RYHq3J6NsfS/iU7w=;
        b=aabFUYgMjX6XH3SERBm7LVMniGgoepVlHgByXhqJoNA6zpvGk+b/Dv69fx/us+gt61X0Pxhw0XseXVCxmXqPiMPG+FX8lOZZTAC+z0AIGTPFrCsjEypab3/WMAdy16ODcA9546TMvnYS0u9+POXbXggv+/MbwReK6Ar+3oZ2Btg=;
X-UUID: fca9b31b148b4c6b92468852ff29197e-20201106
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1174908276; Fri, 06 Nov 2020 14:09:30 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 6 Nov 2020 14:09:28 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 6 Nov 2020 14:09:26 +0800
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
Subject: [PATCH v2 02/17] phy: amlogic: convert to devm_platform_ioremap_resource
Date:   Fri, 6 Nov 2020 14:08:35 +0800
Message-ID: <1604642930-29019-2-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1604642930-29019-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1604642930-29019-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E509EC81D2244ACD2C759A93FBE90B601C3C1BC8A1029C86FB7DC98D396B82152000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZSB0byBzaW1wbGlmeSBjb2RlDQoNClNp
Z25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NClJl
dmlld2VkLWJ5OiBSZW1pIFBvbW1hcmVsIDxyZXBrQHRyaXBsZWZhdS5sdD4NCi0tLQ0KdjI6IA0K
IDEuIGFiYW5kb24gbW9kaWZpY2F0aW9uIG9mIHBoeS1tZXNvbi1heGctbWlwaS1wY2llLWFuYWxv
Zy5jIHN1Z2dlc3RlZCBieSBSZW1pDQogMi4gYWRkIFJldmlld2VkLWJ5IFJlbWkNCi0tLQ0KIGRy
aXZlcnMvcGh5L2FtbG9naWMvcGh5LW1lc29uLWF4Zy1wY2llLmMgICAgICAgfCA0ICstLS0NCiBk
cml2ZXJzL3BoeS9hbWxvZ2ljL3BoeS1tZXNvbi1nMTJhLXVzYjIuYyAgICAgIHwgNCArLS0tDQog
ZHJpdmVycy9waHkvYW1sb2dpYy9waHktbWVzb24tZzEyYS11c2IzLXBjaWUuYyB8IDQgKy0tLQ0K
IGRyaXZlcnMvcGh5L2FtbG9naWMvcGh5LW1lc29uLWd4bC11c2IyLmMgICAgICAgfCA0ICstLS0N
CiA0IGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pDQoNCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL3BoeS9hbWxvZ2ljL3BoeS1tZXNvbi1heGctcGNpZS5jIGIvZHJp
dmVycy9waHkvYW1sb2dpYy9waHktbWVzb24tYXhnLXBjaWUuYw0KaW5kZXggMzc3ZWQwZGNkMGQ5
Li41OGE3NTA3YTg0MjIgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3BoeS9hbWxvZ2ljL3BoeS1tZXNv
bi1heGctcGNpZS5jDQorKysgYi9kcml2ZXJzL3BoeS9hbWxvZ2ljL3BoeS1tZXNvbi1heGctcGNp
ZS5jDQpAQCAtMTI5LDcgKzEyOSw2IEBAIHN0YXRpYyBpbnQgcGh5X2F4Z19wY2llX3Byb2JlKHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2
LT5kZXY7DQogCXN0cnVjdCBwaHlfYXhnX3BjaWVfcHJpdiAqcHJpdjsNCiAJc3RydWN0IGRldmlj
ZV9ub2RlICpucCA9IGRldi0+b2Zfbm9kZTsNCi0Jc3RydWN0IHJlc291cmNlICpyZXM7DQogCXZv
aWQgX19pb21lbSAqYmFzZTsNCiAJaW50IHJldDsNCiANCkBAIC0xNDUsOCArMTQ0LDcgQEAgc3Rh
dGljIGludCBwaHlfYXhnX3BjaWVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikN
CiAJCXJldHVybiByZXQ7DQogCX0NCiANCi0JcmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBk
ZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsNCi0JYmFzZSA9IGRldm1faW9yZW1hcF9yZXNvdXJjZShk
ZXYsIHJlcyk7DQorCWJhc2UgPSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UocGRldiwg
MCk7DQogCWlmIChJU19FUlIoYmFzZSkpDQogCQlyZXR1cm4gUFRSX0VSUihiYXNlKTsNCiANCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL3BoeS9hbWxvZ2ljL3BoeS1tZXNvbi1nMTJhLXVzYjIuYyBiL2Ry
aXZlcnMvcGh5L2FtbG9naWMvcGh5LW1lc29uLWcxMmEtdXNiMi5jDQppbmRleCBiMjZlMzBlMWFm
YWYuLjlkMWVmYTBkOTM5NCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvcGh5L2FtbG9naWMvcGh5LW1l
c29uLWcxMmEtdXNiMi5jDQorKysgYi9kcml2ZXJzL3BoeS9hbWxvZ2ljL3BoeS1tZXNvbi1nMTJh
LXVzYjIuYw0KQEAgLTI5Miw3ICsyOTIsNiBAQCBzdGF0aWMgaW50IHBoeV9tZXNvbl9nMTJhX3Vz
YjJfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiB7DQogCXN0cnVjdCBkZXZp
Y2UgKmRldiA9ICZwZGV2LT5kZXY7DQogCXN0cnVjdCBwaHlfcHJvdmlkZXIgKnBoeV9wcm92aWRl
cjsNCi0Jc3RydWN0IHJlc291cmNlICpyZXM7DQogCXN0cnVjdCBwaHlfbWVzb25fZzEyYV91c2Iy
X3ByaXYgKnByaXY7DQogCXN0cnVjdCBwaHkgKnBoeTsNCiAJdm9pZCBfX2lvbWVtICpiYXNlOw0K
QEAgLTMwNSw4ICszMDQsNyBAQCBzdGF0aWMgaW50IHBoeV9tZXNvbl9nMTJhX3VzYjJfcHJvYmUo
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJcHJpdi0+ZGV2ID0gZGV2Ow0KIAlwbGF0
Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2LCBwcml2KTsNCiANCi0JcmVzID0gcGxhdGZvcm1fZ2V0X3Jl
c291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsNCi0JYmFzZSA9IGRldm1faW9yZW1hcF9y
ZXNvdXJjZShkZXYsIHJlcyk7DQorCWJhc2UgPSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3Vy
Y2UocGRldiwgMCk7DQogCWlmIChJU19FUlIoYmFzZSkpDQogCQlyZXR1cm4gUFRSX0VSUihiYXNl
KTsNCiANCmRpZmYgLS1naXQgYS9kcml2ZXJzL3BoeS9hbWxvZ2ljL3BoeS1tZXNvbi1nMTJhLXVz
YjMtcGNpZS5jIGIvZHJpdmVycy9waHkvYW1sb2dpYy9waHktbWVzb24tZzEyYS11c2IzLXBjaWUu
Yw0KaW5kZXggMDhlMzIyNzg5ZTU5Li5lYmUzZDBkZGQzMDQgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L3BoeS9hbWxvZ2ljL3BoeS1tZXNvbi1nMTJhLXVzYjMtcGNpZS5jDQorKysgYi9kcml2ZXJzL3Bo
eS9hbWxvZ2ljL3BoeS1tZXNvbi1nMTJhLXVzYjMtcGNpZS5jDQpAQCAtMzg2LDcgKzM4Niw2IEBA
IHN0YXRpYyBpbnQgcGh5X2cxMmFfdXNiM19wY2llX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgKnBkZXYpDQogCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQogCXN0cnVjdCBk
ZXZpY2Vfbm9kZSAqbnAgPSBkZXYtPm9mX25vZGU7DQogCXN0cnVjdCBwaHlfZzEyYV91c2IzX3Bj
aWVfcHJpdiAqcHJpdjsNCi0Jc3RydWN0IHJlc291cmNlICpyZXM7DQogCXN0cnVjdCBwaHlfcHJv
dmlkZXIgKnBoeV9wcm92aWRlcjsNCiAJdm9pZCBfX2lvbWVtICpiYXNlOw0KIAlpbnQgcmV0Ow0K
QEAgLTM5NSw4ICszOTQsNyBAQCBzdGF0aWMgaW50IHBoeV9nMTJhX3VzYjNfcGNpZV9wcm9iZShz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAlpZiAoIXByaXYpDQogCQlyZXR1cm4gLUVO
T01FTTsNCiANCi0JcmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0Vf
TUVNLCAwKTsNCi0JYmFzZSA9IGRldm1faW9yZW1hcF9yZXNvdXJjZShkZXYsIHJlcyk7DQorCWJh
c2UgPSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UocGRldiwgMCk7DQogCWlmIChJU19F
UlIoYmFzZSkpDQogCQlyZXR1cm4gUFRSX0VSUihiYXNlKTsNCiANCmRpZmYgLS1naXQgYS9kcml2
ZXJzL3BoeS9hbWxvZ2ljL3BoeS1tZXNvbi1neGwtdXNiMi5jIGIvZHJpdmVycy9waHkvYW1sb2dp
Yy9waHktbWVzb24tZ3hsLXVzYjIuYw0KaW5kZXggNDNlYzliZjI0YWJmLi44NzVhZmIyNjcyYzcg
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL3BoeS9hbWxvZ2ljL3BoeS1tZXNvbi1neGwtdXNiMi5jDQor
KysgYi9kcml2ZXJzL3BoeS9hbWxvZ2ljL3BoeS1tZXNvbi1neGwtdXNiMi5jDQpAQCAtMjMwLDcg
KzIzMCw2IEBAIHN0YXRpYyBpbnQgcGh5X21lc29uX2d4bF91c2IyX3Byb2JlKHN0cnVjdCBwbGF0
Zm9ybV9kZXZpY2UgKnBkZXYpDQogew0KIAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2
Ow0KIAlzdHJ1Y3QgcGh5X3Byb3ZpZGVyICpwaHlfcHJvdmlkZXI7DQotCXN0cnVjdCByZXNvdXJj
ZSAqcmVzOw0KIAlzdHJ1Y3QgcGh5X21lc29uX2d4bF91c2IyX3ByaXYgKnByaXY7DQogCXN0cnVj
dCBwaHkgKnBoeTsNCiAJdm9pZCBfX2lvbWVtICpiYXNlOw0KQEAgLTI0Miw4ICsyNDEsNyBAQCBz
dGF0aWMgaW50IHBoeV9tZXNvbl9neGxfdXNiMl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpwZGV2KQ0KIA0KIAlwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2LCBwcml2KTsNCiANCi0JcmVz
ID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsNCi0JYmFz
ZSA9IGRldm1faW9yZW1hcF9yZXNvdXJjZShkZXYsIHJlcyk7DQorCWJhc2UgPSBkZXZtX3BsYXRm
b3JtX2lvcmVtYXBfcmVzb3VyY2UocGRldiwgMCk7DQogCWlmIChJU19FUlIoYmFzZSkpDQogCQly
ZXR1cm4gUFRSX0VSUihiYXNlKTsNCiANCi0tIA0KMi4xOC4wDQo=

