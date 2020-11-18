Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFBBE2B7D64
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 13:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgKRMIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 07:08:06 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:58889 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727995AbgKRMID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 07:08:03 -0500
X-UUID: 9fc82882d8684ab3a16a0434c0759710-20201118
X-UUID: 9fc82882d8684ab3a16a0434c0759710-20201118
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 483358233; Wed, 18 Nov 2020 20:07:59 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 18 Nov 2020 20:07:57 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 18 Nov 2020 20:07:57 +0800
From:   Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <fshao@chromium.org>, Argus Lin <argus.lin@mediatek.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Subject: [PATCH v4 4/5] soc: mediatek: pwrap: add pwrap driver for MT6873/8192 SoCs
Date:   Wed, 18 Nov 2020 20:01:33 +0800
Message-ID: <1605700894-32699-5-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1605700894-32699-1-git-send-email-hsin-hsiung.wang@mediatek.com>
References: <1605700894-32699-1-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT6873/8192 are highly integrated SoCs and use PMIC_MT6359 for
power management. This patch adds pwrap master driver to
access PMIC_MT6359.

Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index 5678f46..d1cd050 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -632,6 +632,17 @@ static int mt6797_regs[] = {
 	[PWRAP_DCM_DBC_PRD] =		0x1D4,
 };
 
+static int mt6873_regs[] = {
+	[PWRAP_INIT_DONE2] =		0x0,
+	[PWRAP_TIMER_EN] =		0x3E0,
+	[PWRAP_INT_EN] =		0x448,
+	[PWRAP_WACS2_CMD] =		0xC80,
+	[PWRAP_SWINF_2_WDATA_31_0] =	0xC84,
+	[PWRAP_SWINF_2_RDATA_31_0] =	0xC94,
+	[PWRAP_WACS2_VLDCLR] =		0xCA4,
+	[PWRAP_WACS2_RDATA] =		0xCA8,
+};
+
 static int mt7622_regs[] = {
 	[PWRAP_MUX_SEL] =		0x0,
 	[PWRAP_WRAP_EN] =		0x4,
@@ -1050,6 +1061,7 @@ enum pwrap_type {
 	PWRAP_MT6765,
 	PWRAP_MT6779,
 	PWRAP_MT6797,
+	PWRAP_MT6873,
 	PWRAP_MT7622,
 	PWRAP_MT8135,
 	PWRAP_MT8173,
@@ -1512,6 +1524,7 @@ static int pwrap_init_cipher(struct pmic_wrapper *wrp)
 	case PWRAP_MT7622:
 		pwrap_writel(wrp, 0, PWRAP_CIPHER_EN);
 		break;
+	case PWRAP_MT6873:
 	case PWRAP_MT8183:
 		break;
 	}
@@ -1948,6 +1961,19 @@ static const struct pmic_wrapper_type pwrap_mt6797 = {
 	.init_soc_specific = NULL,
 };
 
+static const struct pmic_wrapper_type pwrap_mt6873 = {
+	.regs = mt6873_regs,
+	.type = PWRAP_MT6873,
+	.arb_en_all = 0x777f,
+	.int_en_all = BIT(4) | BIT(5),
+	.int1_en_all = 0,
+	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
+	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
+	.caps = PWRAP_CAP_ARB,
+	.init_reg_clock = pwrap_common_init_reg_clock,
+	.init_soc_specific = NULL,
+};
+
 static const struct pmic_wrapper_type pwrap_mt7622 = {
 	.regs = mt7622_regs,
 	.type = PWRAP_MT7622,
@@ -2026,6 +2052,9 @@ static const struct of_device_id of_pwrap_match_tbl[] = {
 		.compatible = "mediatek,mt6797-pwrap",
 		.data = &pwrap_mt6797,
 	}, {
+		.compatible = "mediatek,mt6873-pwrap",
+		.data = &pwrap_mt6873,
+	}, {
 		.compatible = "mediatek,mt7622-pwrap",
 		.data = &pwrap_mt7622,
 	}, {
-- 
2.6.4

