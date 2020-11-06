Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7710E2A8F34
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 07:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgKFGKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 01:10:16 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:47129 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726367AbgKFGKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 01:10:13 -0500
X-UUID: 83317fa881914d0396396d624c632ab2-20201106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=xbJ4Jgj0E8NLElCm+7ybm+itcY8qXH1MqBxXBrR6TlE=;
        b=s7BUk7bKaez5HroUePtnVCErTfnrPTmIVSXI7G8WR2d66/ZkwSF3KuPR+mlGoSQsWx+ys3szizZegY8FRKSwbRpfyn8zFEC7DDOE8MiZg7uDVIQhAw35i23abE1TP7me2o/+bW1W7v4hrKqsFZEehkp3ONGC4wYvY9RKy5VJ5JU=;
X-UUID: 83317fa881914d0396396d624c632ab2-20201106
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 478649880; Fri, 06 Nov 2020 14:10:09 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 6 Nov 2020 14:10:05 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 6 Nov 2020 14:10:03 +0800
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
Subject: [PATCH v2 13/17] phy: rockchip: convert to devm_platform_ioremap_resource
Date:   Fri, 6 Nov 2020 14:08:46 +0800
Message-ID: <1604642930-29019-13-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1604642930-29019-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1604642930-29019-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 86C70527313290A44E6B1C6CF834D4339D864A835E8927062864AEE502B44A472000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZSB0byBzaW1wbGlmeSBjb2RlDQoNClNp
Z25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0t
LQ0KdjI6IG5vIGNoYW5nZXMNCi0tLQ0KIGRyaXZlcnMvcGh5L3JvY2tjaGlwL3BoeS1yb2NrY2hp
cC1pbm5vLWhkbWkuYyB8IDQgKy0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGh5L3JvY2tjaGlwL3BoeS1y
b2NrY2hpcC1pbm5vLWhkbWkuYyBiL2RyaXZlcnMvcGh5L3JvY2tjaGlwL3BoeS1yb2NrY2hpcC1p
bm5vLWhkbWkuYw0KaW5kZXggOWNhMjBjOTQ3MjgzLi5hMzdmM2YzNDI2NDIgMTAwNjQ0DQotLS0g
YS9kcml2ZXJzL3BoeS9yb2NrY2hpcC9waHktcm9ja2NoaXAtaW5uby1oZG1pLmMNCisrKyBiL2Ry
aXZlcnMvcGh5L3JvY2tjaGlwL3BoeS1yb2NrY2hpcC1pbm5vLWhkbWkuYw0KQEAgLTExNDQsNyAr
MTE0NCw2IEBAIHN0YXRpYyBpbnQgaW5ub19oZG1pX3BoeV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlICpwZGV2KQ0KIHsNCiAJc3RydWN0IGlubm9faGRtaV9waHkgKmlubm87DQogCXN0cnVj
dCBwaHlfcHJvdmlkZXIgKnBoeV9wcm92aWRlcjsNCi0Jc3RydWN0IHJlc291cmNlICpyZXM7DQog
CXZvaWQgX19pb21lbSAqcmVnczsNCiAJaW50IHJldDsNCiANCkBAIC0xMTU4LDggKzExNTcsNyBA
QCBzdGF0aWMgaW50IGlubm9faGRtaV9waHlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
cGRldikNCiAJaWYgKCFpbm5vLT5wbGF0X2RhdGEgfHwgIWlubm8tPnBsYXRfZGF0YS0+b3BzKQ0K
IAkJcmV0dXJuIC1FSU5WQUw7DQogDQotCXJlcyA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZShwZGV2
LCBJT1JFU09VUkNFX01FTSwgMCk7DQotCXJlZ3MgPSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoaW5u
by0+ZGV2LCByZXMpOw0KKwlyZWdzID0gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlKHBk
ZXYsIDApOw0KIAlpZiAoSVNfRVJSKHJlZ3MpKQ0KIAkJcmV0dXJuIFBUUl9FUlIocmVncyk7DQog
DQotLSANCjIuMTguMA0K

