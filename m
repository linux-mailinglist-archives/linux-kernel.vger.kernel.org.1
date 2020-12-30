Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54CAB2E774B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 10:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgL3JFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 04:05:06 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:40013 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbgL3JFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 04:05:05 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0BU94GW10013715, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs01.realtek.com.tw[172.21.6.94])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0BU94GW10013715
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 30 Dec 2020 17:04:16 +0800
Received: from localhost (172.22.88.222) by RTEXMBS01.realtek.com.tw
 (172.21.6.94) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 30 Dec
 2020 17:04:16 +0800
From:   <ricky_wu@realtek.com>
To:     <ulf.hansson@linaro.org>, <ricky_wu@realtek.com>,
        <gregkh@linuxfoundation.org>, <rui_feng@realsil.com.cn>,
        <rmfrfs@gmail.com>, <dianders@chromium.org>,
        <lee.jones@linaro.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] mmc: rtsx: Add MMC_CAP2_NO_SDIO flag
Date:   Wed, 30 Dec 2020 17:04:01 +0800
Message-ID: <20201230090401.12627-2-ricky_wu@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201230090401.12627-1-ricky_wu@realtek.com>
References: <20201230090401.12627-1-ricky_wu@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.22.88.222]
X-ClientProxiedBy: RTEXMBS01.realtek.com.tw (172.21.6.94) To
 RTEXMBS01.realtek.com.tw (172.21.6.94)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ricky Wu <ricky_wu@realtek.com>

Added flag MMC_CAP2_NO_SDIO to mmc->caps2
Card Reader not support SDIO

Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
---
 drivers/mmc/host/rtsx_pci_sdmmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index d21b99962b36..6a8b0282f272 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -1427,7 +1427,8 @@ static void realtek_init_host(struct realtek_pci_sdmmc *host)
 		MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25;
 	if (pcr->rtd3_en)
 		mmc->caps = mmc->caps | MMC_CAP_AGGRESSIVE_PM;
-	mmc->caps2 = MMC_CAP2_NO_PRESCAN_POWERUP | MMC_CAP2_FULL_PWR_CYCLE;
+	mmc->caps2 = MMC_CAP2_NO_PRESCAN_POWERUP | MMC_CAP2_FULL_PWR_CYCLE |
+		MMC_CAP2_NO_SDIO;
 	mmc->max_current_330 = 400;
 	mmc->max_current_180 = 800;
 	mmc->ops = &realtek_pci_sdmmc_ops;
-- 
2.17.1

