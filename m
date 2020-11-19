Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8D82B8A42
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 04:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgKSDDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 22:03:04 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:44872 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726077AbgKSDDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 22:03:04 -0500
X-UUID: 0f511bbd3f45460f84e17550318a7a90-20201119
X-UUID: 0f511bbd3f45460f84e17550318a7a90-20201119
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <yong.mao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 589672973; Thu, 19 Nov 2020 11:02:57 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 19 Nov 2020 11:02:55 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 19 Nov 2020 11:02:55 +0800
From:   Yong Mao <yong.mao@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        yong mao <yong.mao@mediatek.com>
Subject: [PATCH V1] mmc: mediatek: correct the setting of recheck_sdio_irq
Date:   Thu, 19 Nov 2020 11:02:37 +0800
Message-ID: <20201119030237.9414-1-yong.mao@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yong mao <yong.mao@mediatek.com>

correct the setting of recheck_sdio_irq for each mediatek SoC.

Signed-off-by: Yong Mao <yong.mao@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index fc5ee5df91ad..d49e5ccfca9e 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -463,7 +463,7 @@ struct msdc_host {
 
 static const struct mtk_mmc_compatible mt8135_compat = {
 	.clk_div_bits = 8,
-	.recheck_sdio_irq = false,
+	.recheck_sdio_irq = true,
 	.hs400_tune = false,
 	.pad_tune_reg = MSDC_PAD_TUNE,
 	.async_fifo = false,
@@ -502,7 +502,7 @@ static const struct mtk_mmc_compatible mt8183_compat = {
 
 static const struct mtk_mmc_compatible mt2701_compat = {
 	.clk_div_bits = 12,
-	.recheck_sdio_irq = false,
+	.recheck_sdio_irq = true,
 	.hs400_tune = false,
 	.pad_tune_reg = MSDC_PAD_TUNE0,
 	.async_fifo = true,
@@ -528,7 +528,7 @@ static const struct mtk_mmc_compatible mt2712_compat = {
 
 static const struct mtk_mmc_compatible mt7622_compat = {
 	.clk_div_bits = 12,
-	.recheck_sdio_irq = false,
+	.recheck_sdio_irq = true,
 	.hs400_tune = false,
 	.pad_tune_reg = MSDC_PAD_TUNE0,
 	.async_fifo = true,
@@ -541,7 +541,7 @@ static const struct mtk_mmc_compatible mt7622_compat = {
 
 static const struct mtk_mmc_compatible mt8516_compat = {
 	.clk_div_bits = 12,
-	.recheck_sdio_irq = false,
+	.recheck_sdio_irq = true,
 	.hs400_tune = false,
 	.pad_tune_reg = MSDC_PAD_TUNE0,
 	.async_fifo = true,
@@ -552,7 +552,7 @@ static const struct mtk_mmc_compatible mt8516_compat = {
 
 static const struct mtk_mmc_compatible mt7620_compat = {
 	.clk_div_bits = 8,
-	.recheck_sdio_irq = false,
+	.recheck_sdio_irq = true,
 	.hs400_tune = false,
 	.pad_tune_reg = MSDC_PAD_TUNE,
 	.async_fifo = false,
@@ -565,6 +565,7 @@ static const struct mtk_mmc_compatible mt7620_compat = {
 
 static const struct mtk_mmc_compatible mt6779_compat = {
 	.clk_div_bits = 12,
+	.recheck_sdio_irq = false,
 	.hs400_tune = false,
 	.pad_tune_reg = MSDC_PAD_TUNE0,
 	.async_fifo = true,
-- 
2.18.0

