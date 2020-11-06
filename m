Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5032A8F36
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 07:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgKFGK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 01:10:28 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:16126 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726103AbgKFGK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 01:10:27 -0500
X-UUID: b19cdcc7b676458ca93e9d4c98b0da29-20201106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=9WnGz+IS7H2UGNGbzXXA9+mRl9+Op988EvcCwWjyl1s=;
        b=DdGVyfk3MdkN4lQcR4roZEvwri6fqey1kZu6y9WGEU5sJbBc31NwaevKeMexFnDPi5Z5XByAqANyTLRAwf+9LVWXs3Ll1dWVlGl/RgYvajziwAi/WUUz/bAS6asZC3zRoRrAGDHvGHlZAfu31yO+14ppRM2sj8UrCJpryQdG9Ao=;
X-UUID: b19cdcc7b676458ca93e9d4c98b0da29-20201106
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 944184745; Fri, 06 Nov 2020 14:10:22 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 6 Nov 2020 14:10:20 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 6 Nov 2020 14:10:17 +0800
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
Subject: [PATCH v2 15/17] phy: phy-stm32-usbphyc: convert to devm_platform_ioremap_resource
Date:   Fri, 6 Nov 2020 14:08:48 +0800
Message-ID: <1604642930-29019-15-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1604642930-29019-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1604642930-29019-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: EFD9E1E2B992AEB5ADB5BF5B3ED927FA5564FAD6F08C4EA53AAF509C7A4E78BF2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZSB0byBzaW1wbGlmeSBjb2RlDQoNClNp
Z25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NClJl
dmlld2VkLWJ5OiBBbWVsaWUgRGVsYXVuYXkgPGFtZWxpZS5kZWxhdW5heUBzdC5jb20+DQotLS0N
CnYyOiBhZGQgUmV2aWV3ZWQtYnkgQW1lbGllDQotLS0NCiBkcml2ZXJzL3BoeS9zdC9waHktc3Rt
MzItdXNicGh5Yy5jIHwgNCArLS0tDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAz
IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9waHkvc3QvcGh5LXN0bTMyLXVz
YnBoeWMuYyBiL2RyaXZlcnMvcGh5L3N0L3BoeS1zdG0zMi11c2JwaHljLmMNCmluZGV4IDJiMzYz
OWNiYTUxYS4uMGFiMThmMjA3OGRiIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9waHkvc3QvcGh5LXN0
bTMyLXVzYnBoeWMuYw0KKysrIGIvZHJpdmVycy9waHkvc3QvcGh5LXN0bTMyLXVzYnBoeWMuYw0K
QEAgLTMxMSw3ICszMTEsNiBAQCBzdGF0aWMgaW50IHN0bTMyX3VzYnBoeWNfcHJvYmUoc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJc3RydWN0IHN0bTMyX3VzYnBoeWMgKnVzYnBoeWM7
DQogCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQogCXN0cnVjdCBkZXZpY2Vfbm9k
ZSAqY2hpbGQsICpucCA9IGRldi0+b2Zfbm9kZTsNCi0Jc3RydWN0IHJlc291cmNlICpyZXM7DQog
CXN0cnVjdCBwaHlfcHJvdmlkZXIgKnBoeV9wcm92aWRlcjsNCiAJdTMyIHZlcnNpb247DQogCWlu
dCByZXQsIHBvcnQgPSAwOw0KQEAgLTMyMiw4ICszMjEsNyBAQCBzdGF0aWMgaW50IHN0bTMyX3Vz
YnBoeWNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJdXNicGh5Yy0+ZGV2
ID0gZGV2Ow0KIAlkZXZfc2V0X2RydmRhdGEoZGV2LCB1c2JwaHljKTsNCiANCi0JcmVzID0gcGxh
dGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsNCi0JdXNicGh5Yy0+
YmFzZSA9IGRldm1faW9yZW1hcF9yZXNvdXJjZShkZXYsIHJlcyk7DQorCXVzYnBoeWMtPmJhc2Ug
PSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UocGRldiwgMCk7DQogCWlmIChJU19FUlIo
dXNicGh5Yy0+YmFzZSkpDQogCQlyZXR1cm4gUFRSX0VSUih1c2JwaHljLT5iYXNlKTsNCiANCi0t
IA0KMi4xOC4wDQo=

