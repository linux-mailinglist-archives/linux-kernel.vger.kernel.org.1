Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF0B2A8F31
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 07:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgKFGKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 01:10:05 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:11999 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726274AbgKFGKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 01:10:03 -0500
X-UUID: 8cd5f98befd946ac9afb501c6257520a-20201106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=v7bDNbWdcgylNmWI6ZBN5+MvjPV0WLnN0muwDXmdefA=;
        b=MF5IsEl9R1MciWKOr8vu01yLIZxiA4Ht0FDvn5XiMPRFppBGcgxDkLg5Nwv1JbpVOQLO8Mcff6wxi2LoNwY4uHSz9Q/OPNhv7uZ7fq+UumINRxKM3ba2/YsmvVPhawBf7t0wjFMMepcb19qCMZ0vWQAE0MdD57y/DZJKpO4FTIg=;
X-UUID: 8cd5f98befd946ac9afb501c6257520a-20201106
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 274608983; Fri, 06 Nov 2020 14:09:55 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 6 Nov 2020 14:09:53 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 6 Nov 2020 14:09:51 +0800
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
Subject: [PATCH v2 11/17] phy: phy-ralink-usb: convert to devm_platform_ioremap_resource
Date:   Fri, 6 Nov 2020 14:08:44 +0800
Message-ID: <1604642930-29019-11-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1604642930-29019-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1604642930-29019-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 120EC321554EFDCBFDEAFDCB42294258B8B353D568DE2EF946017CB25CAC343F2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZSB0byBzaW1wbGlmeSBjb2RlDQoNClNp
Z25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0t
LQ0KdjI6IG5vIGNoYW5nZXMNCi0tLQ0KIGRyaXZlcnMvcGh5L3JhbGluay9waHktcmFsaW5rLXVz
Yi5jIHwgNCArLS0tDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAzIGRlbGV0aW9u
cygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9waHkvcmFsaW5rL3BoeS1yYWxpbmstdXNiLmMg
Yi9kcml2ZXJzL3BoeS9yYWxpbmsvcGh5LXJhbGluay11c2IuYw0KaW5kZXggOTVkZmE5ZmQyODRk
Li4yYmQ4YWQyZTc2ZWQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3BoeS9yYWxpbmsvcGh5LXJhbGlu
ay11c2IuYw0KKysrIGIvZHJpdmVycy9waHkvcmFsaW5rL3BoeS1yYWxpbmstdXNiLmMNCkBAIC0x
NzAsNyArMTcwLDYgQEAgTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgcmFsaW5rX3VzYl9waHlfb2Zf
bWF0Y2gpOw0KIHN0YXRpYyBpbnQgcmFsaW5rX3VzYl9waHlfcHJvYmUoc3RydWN0IHBsYXRmb3Jt
X2RldmljZSAqcGRldikNCiB7DQogCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQot
CXN0cnVjdCByZXNvdXJjZSAqcmVzOw0KIAlzdHJ1Y3QgcGh5X3Byb3ZpZGVyICpwaHlfcHJvdmlk
ZXI7DQogCWNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgKm1hdGNoOw0KIAlzdHJ1Y3QgcmFsaW5r
X3VzYl9waHkgKnBoeTsNCkBAIC0xOTQsOCArMTkzLDcgQEAgc3RhdGljIGludCByYWxpbmtfdXNi
X3BoeV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIA0KIAkvKiBUaGUgTVQ3
NjI4IGFuZCBNVDc2ODggcmVxdWlyZSBleHRyYSBzZXR1cCBvZiBQSFkgcmVnaXN0ZXJzLiAqLw0K
IAlpZiAob2ZfZGV2aWNlX2lzX2NvbXBhdGlibGUoZGV2LT5vZl9ub2RlLCAibWVkaWF0ZWssbXQ3
NjI4LXVzYnBoeSIpKSB7DQotCQlyZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UocGRldiwgSU9S
RVNPVVJDRV9NRU0sIDApOw0KLQkJcGh5LT5iYXNlID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKCZw
ZGV2LT5kZXYsIHJlcyk7DQorCQlwaHktPmJhc2UgPSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVz
b3VyY2UocGRldiwgMCk7DQogCQlpZiAoSVNfRVJSKHBoeS0+YmFzZSkpIHsNCiAJCQlkZXZfZXJy
KGRldiwgImZhaWxlZCB0byByZW1hcCByZWdpc3RlciBtZW1vcnlcbiIpOw0KIAkJCXJldHVybiBQ
VFJfRVJSKHBoeS0+YmFzZSk7DQotLSANCjIuMTguMA0K

