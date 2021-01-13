Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 732642F4924
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbhAMK6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 05:58:17 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:55578 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726459AbhAMK6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 05:58:17 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 10DAvSccD028238, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs01.realtek.com.tw[172.21.6.94])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 10DAvSccD028238
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 13 Jan 2021 18:57:28 +0800
Received: from localhost (172.22.88.222) by RTEXMBS01.realtek.com.tw
 (172.21.6.94) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 13 Jan
 2021 18:57:28 +0800
From:   <ricky_wu@realtek.com>
To:     <ulf.hansson@linaro.org>, <ricky_wu@realtek.com>,
        <gregkh@linuxfoundation.org>, <feng@realsil.com.cn>,
        <dianders@chromium.org>, <lee.jones@linaro.org>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] mmc: rtsx: add delay before power on
Date:   Wed, 13 Jan 2021 18:57:23 +0800
Message-ID: <20210113105723.7916-1-ricky_wu@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.22.88.222]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS01.realtek.com.tw (172.21.6.94)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ricky Wu <ricky_wu@realtek.com>

Make sure voltage below 0.5V before power on
when do power cycle
At mmc-core recognition card phase will do
power cycle quickly so our device need at least 100ms
to make voltage down to below 0.5V

Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
---
 drivers/mmc/host/rtsx_pci_sdmmc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index e6f5bbce5685..0e5043a03965 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -906,6 +906,8 @@ static int sd_power_on(struct realtek_pci_sdmmc *host)
 	if (host->power_state == SDMMC_POWER_ON)
 		return 0;
 
+	msleep(100);
+
 	rtsx_pci_init_cmd(pcr);
 	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, CARD_SELECT, 0x07, SD_MOD_SEL);
 	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, CARD_SHARE_MODE,
-- 
2.17.1

