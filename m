Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4653B276B03
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 09:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbgIXHkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 03:40:41 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:33639 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbgIXHkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 03:40:36 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 08O7eMfE5019868, This message is accepted by code: ctloc85258
Received: from RSEXMBS01.realsil.com.cn ([172.29.17.195])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 08O7eMfE5019868
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 24 Sep 2020 15:40:23 +0800
Received: from localhost (172.29.40.150) by RSEXMBS01.realsil.com.cn
 (172.29.17.195) with Microsoft SMTP Server id 15.1.2044.4; Thu, 24 Sep 2020
 15:40:22 +0800
From:   <rui_feng@realsil.com.cn>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <ulf.hansson@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, Rui Feng <rui_feng@realsil.com.cn>
Subject: [PATCH] mmc: rtsx: Add SD Express mode support for RTS5261
Date:   Thu, 24 Sep 2020 15:40:21 +0800
Message-ID: <1600933221-3496-1-git-send-email-rui_feng@realsil.com.cn>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.29.40.150]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rui Feng <rui_feng@realsil.com.cn>

RTS5261 support legacy SD mode and SD Express mode.
In SD7.x, SD association introduce SD Express as a new mode.
This patch makes RTS5261 support SD Express mode,
and this patch is based on patch "mmc: core: Initial support
for SD express card/host" committed by Ulf Hansson.

Signed-off-by: Rui Feng <rui_feng@realsil.com.cn>
---
 drivers/misc/cardreader/rts5261.c  |  4 ++
 drivers/misc/cardreader/rts5261.h  | 23 ------------
 drivers/misc/cardreader/rtsx_pcr.c |  5 +++
 drivers/mmc/host/rtsx_pci_sdmmc.c  | 59 ++++++++++++++++++++++++++++++
 include/linux/rtsx_pci.h           | 28 ++++++++++++++
 5 files changed, 96 insertions(+), 23 deletions(-)

diff --git a/drivers/misc/cardreader/rts5261.c b/drivers/misc/cardreader/rts5261.c
index 471961487ff8..536c90d4fd76 100644
--- a/drivers/misc/cardreader/rts5261.c
+++ b/drivers/misc/cardreader/rts5261.c
@@ -738,8 +738,12 @@ void rts5261_init_params(struct rtsx_pcr *pcr)
 {
 	struct rtsx_cr_option *option = &pcr->option;
 	struct rtsx_hw_param *hw_param = &pcr->hw_param;
+	u8 val;
 
 	pcr->extra_caps = EXTRA_CAPS_SD_SDR50 | EXTRA_CAPS_SD_SDR104;
+	rtsx_pci_read_register(pcr, RTS5261_FW_STATUS, &val);
+	if (!(val & RTS5261_EXPRESS_LINK_FAIL_MASK))
+		pcr->extra_caps |= EXTRA_CAPS_SD_EXPRESS;
 	pcr->num_slots = 1;
 	pcr->ops = &rts5261_pcr_ops;
 
diff --git a/drivers/misc/cardreader/rts5261.h b/drivers/misc/cardreader/rts5261.h
index ebfdd236a553..8d80f0d5d5d6 100644
--- a/drivers/misc/cardreader/rts5261.h
+++ b/drivers/misc/cardreader/rts5261.h
@@ -65,23 +65,6 @@
 #define RTS5261_FW_EXPRESS_TEST_MASK	(0x01<<0)
 #define RTS5261_FW_EA_MODE_MASK		(0x01<<5)
 
-/* FW config register */
-#define RTS5261_FW_CFG0			0xFF54
-#define RTS5261_FW_ENTER_EXPRESS	(0x01<<0)
-
-#define RTS5261_FW_CFG1			0xFF55
-#define RTS5261_SYS_CLK_SEL_MCU_CLK	(0x01<<7)
-#define RTS5261_CRC_CLK_SEL_MCU_CLK	(0x01<<6)
-#define RTS5261_FAKE_MCU_CLOCK_GATING	(0x01<<5)
-/*MCU_bus_mode_sel: 0=real 8051 1=fake mcu*/
-#define RTS5261_MCU_BUS_SEL_MASK	(0x01<<4)
-/*MCU_clock_sel:VerA 00=aux16M 01=aux400K 1x=REFCLK100M*/
-/*MCU_clock_sel:VerB 00=aux400K 01=aux16M 10=REFCLK100M*/
-#define RTS5261_MCU_CLOCK_SEL_MASK	(0x03<<2)
-#define RTS5261_MCU_CLOCK_SEL_16M	(0x01<<2)
-#define RTS5261_MCU_CLOCK_GATING	(0x01<<1)
-#define RTS5261_DRIVER_ENABLE_FW	(0x01<<0)
-
 /* FW status register */
 #define RTS5261_FW_STATUS		0xFF56
 #define RTS5261_EXPRESS_LINK_FAIL_MASK	(0x01<<7)
@@ -121,12 +104,6 @@
 #define RTS5261_DV3318_19		(0x04<<4)
 #define RTS5261_DV3318_33		(0x07<<4)
 
-#define RTS5261_LDO1_CFG0		0xFF72
-#define RTS5261_LDO1_OCP_THD_MASK	(0x07<<5)
-#define RTS5261_LDO1_OCP_EN		(0x01<<4)
-#define RTS5261_LDO1_OCP_LMT_THD_MASK	(0x03<<2)
-#define RTS5261_LDO1_OCP_LMT_EN		(0x01<<1)
-
 /* CRD6603-433 190319 request changed */
 #define RTS5261_LDO1_OCP_THD_740	(0x00<<5)
 #define RTS5261_LDO1_OCP_THD_800	(0x01<<5)
diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index 37ccc67f4914..6e5c16b4b7d1 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -990,6 +990,11 @@ static irqreturn_t rtsx_pci_isr(int irq, void *dev_id)
 		} else {
 			pcr->card_removed |= SD_EXIST;
 			pcr->card_inserted &= ~SD_EXIST;
+			if (PCI_PID(pcr) == PID_5261) {
+				rtsx_pci_write_register(pcr, RTS5261_FW_STATUS,
+					RTS5261_EXPRESS_LINK_FAIL_MASK, 0);
+				pcr->extra_caps |= EXTRA_CAPS_SD_EXPRESS;
+			}
 		}
 		pcr->dma_error_count = 0;
 	}
diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index 2763a376b054..efde374a4a5e 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -895,7 +895,9 @@ static int sd_set_bus_width(struct realtek_pci_sdmmc *host,
 static int sd_power_on(struct realtek_pci_sdmmc *host)
 {
 	struct rtsx_pcr *pcr = host->pcr;
+	struct mmc_host *mmc = host->mmc;
 	int err;
+	u32 val;
 
 	if (host->power_state == SDMMC_POWER_ON)
 		return 0;
@@ -922,6 +924,14 @@ static int sd_power_on(struct realtek_pci_sdmmc *host)
 	if (err < 0)
 		return err;
 
+	if (PCI_PID(pcr) == PID_5261) {
+		val = rtsx_pci_readl(pcr, RTSX_BIPR);
+		if (val & SD_WRITE_PROTECT) {
+			pcr->extra_caps &= ~EXTRA_CAPS_SD_EXPRESS;
+			mmc->caps2 &= ~(MMC_CAP2_SD_EXP | MMC_CAP2_SD_EXP_1_2V);
+		}
+	}
+
 	host->power_state = SDMMC_POWER_ON;
 	return 0;
 }
@@ -1127,6 +1137,8 @@ static int sdmmc_get_cd(struct mmc_host *mmc)
 	if (val & SD_EXIST)
 		cd = 1;
 
+	if (pcr->extra_caps & EXTRA_CAPS_SD_EXPRESS)
+		mmc->caps2 |= MMC_CAP2_SD_EXP | MMC_CAP2_SD_EXP_1_2V;
 	mutex_unlock(&pcr->pcr_mutex);
 
 	return cd;
@@ -1308,6 +1320,50 @@ static int sdmmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	return err;
 }
 
+static int sdmmc_init_sd_express(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	u32 relink_time, val;
+	struct realtek_pci_sdmmc *host = mmc_priv(mmc);
+	struct rtsx_pcr *pcr = host->pcr;
+
+	/*
+	 * If card has PCIe availability and WP if off,
+	 * reader switch to PCIe mode.
+	 */
+	val = rtsx_pci_readl(pcr, RTSX_BIPR);
+	if (!(val & SD_WRITE_PROTECT)) {
+		/* Set relink_time for changing to PCIe card */
+		relink_time = 0x8FFF;
+
+		rtsx_pci_write_register(pcr, 0xFF01, 0xFF, relink_time);
+		rtsx_pci_write_register(pcr, 0xFF02, 0xFF, relink_time >> 8);
+		rtsx_pci_write_register(pcr, 0xFF03, 0x01, relink_time >> 16);
+
+		rtsx_pci_write_register(pcr, PETXCFG, 0x80, 0x80);
+		rtsx_pci_write_register(pcr, LDO_VCC_CFG0,
+			RTS5261_LDO1_OCP_THD_MASK,
+			pcr->option.sd_800mA_ocp_thd);
+
+		if (pcr->ops->disable_auto_blink)
+			pcr->ops->disable_auto_blink(pcr);
+
+		/* For PCIe/NVMe mode can't enter delink issue */
+		pcr->hw_param.interrupt_en &= ~(SD_INT_EN);
+		rtsx_pci_writel(pcr, RTSX_BIER, pcr->hw_param.interrupt_en);
+
+		rtsx_pci_write_register(pcr, RTS5260_AUTOLOAD_CFG4,
+			RTS5261_AUX_CLK_16M_EN, RTS5261_AUX_CLK_16M_EN);
+		rtsx_pci_write_register(pcr, RTS5261_FW_CFG0,
+			RTS5261_FW_ENTER_EXPRESS, RTS5261_FW_ENTER_EXPRESS);
+		rtsx_pci_write_register(pcr, RTS5261_FW_CFG1,
+			RTS5261_MCU_BUS_SEL_MASK | RTS5261_MCU_CLOCK_SEL_MASK
+			| RTS5261_MCU_CLOCK_GATING | RTS5261_DRIVER_ENABLE_FW,
+			RTS5261_MCU_CLOCK_SEL_16M | RTS5261_MCU_CLOCK_GATING
+			| RTS5261_DRIVER_ENABLE_FW);
+	}
+	return 0;
+}
+
 static const struct mmc_host_ops realtek_pci_sdmmc_ops = {
 	.pre_req = sdmmc_pre_req,
 	.post_req = sdmmc_post_req,
@@ -1317,6 +1373,7 @@ static const struct mmc_host_ops realtek_pci_sdmmc_ops = {
 	.get_cd = sdmmc_get_cd,
 	.start_signal_voltage_switch = sdmmc_switch_voltage,
 	.execute_tuning = sdmmc_execute_tuning,
+	.init_sd_express = sdmmc_init_sd_express,
 };
 
 static void init_extra_caps(struct realtek_pci_sdmmc *host)
@@ -1338,6 +1395,8 @@ static void init_extra_caps(struct realtek_pci_sdmmc *host)
 		mmc->caps |= MMC_CAP_8_BIT_DATA;
 	if (pcr->extra_caps & EXTRA_CAPS_NO_MMC)
 		mmc->caps2 |= MMC_CAP2_NO_MMC;
+	if (pcr->extra_caps & EXTRA_CAPS_SD_EXPRESS)
+		mmc->caps2 |= MMC_CAP2_SD_EXP | MMC_CAP2_SD_EXP_1_2V;
 }
 
 static void realtek_init_host(struct realtek_pci_sdmmc *host)
diff --git a/include/linux/rtsx_pci.h b/include/linux/rtsx_pci.h
index 745f5e73f99a..cea8147e5992 100644
--- a/include/linux/rtsx_pci.h
+++ b/include/linux/rtsx_pci.h
@@ -658,6 +658,24 @@
 #define   PM_WAKE_EN			0x01
 #define PM_CTRL4			0xFF47
 
+#define RTS5261_FW_CFG0			0xFF54
+#define   RTS5261_FW_ENTER_EXPRESS	(0x01 << 0)
+
+#define RTS5261_FW_CFG1			0xFF55
+#define   RTS5261_SYS_CLK_SEL_MCU_CLK	(0x01 << 7)
+#define   RTS5261_CRC_CLK_SEL_MCU_CLK	(0x01 << 6)
+#define   RTS5261_FAKE_MCU_CLOCK_GATING	(0x01 << 5)
+#define   RTS5261_MCU_BUS_SEL_MASK	(0x01 << 4)
+#define   RTS5261_MCU_BUS_SEL_MASK	(0x01 << 4)
+#define   RTS5261_MCU_CLOCK_SEL_MASK	(0x03 << 2)
+#define   RTS5261_MCU_CLOCK_SEL_16M	(0x01 << 2)
+#define   RTS5261_MCU_CLOCK_GATING	(0x01 << 1)
+#define   RTS5261_DRIVER_ENABLE_FW	(0x01 << 0)
+#define   RTS5261_MCU_CLOCK_SEL_MASK	(0x03 << 2)
+#define   RTS5261_MCU_CLOCK_SEL_16M	(0x01 << 2)
+#define   RTS5261_MCU_CLOCK_GATING	(0x01 << 1)
+#define   RTS5261_DRIVER_ENABLE_FW	(0x01 << 0)
+
 #define REG_CFG_OOBS_OFF_TIMER 0xFEA6
 #define REG_CFG_OOBS_ON_TIMER 0xFEA7
 #define REG_CFG_VCM_ON_TIMER 0xFEA8
@@ -701,6 +719,13 @@
 #define   RTS5260_DVCC_TUNE_MASK	0x70
 #define   RTS5260_DVCC_33		0x70
 
+/*RTS5261*/
+#define RTS5261_LDO1_CFG0		0xFF72
+#define   RTS5261_LDO1_OCP_THD_MASK	(0x07 << 5)
+#define   RTS5261_LDO1_OCP_EN		(0x01 << 4)
+#define   RTS5261_LDO1_OCP_LMT_THD_MASK	(0x03 << 2)
+#define   RTS5261_LDO1_OCP_LMT_EN	(0x01 << 1)
+
 #define LDO_VCC_CFG1			0xFF73
 #define   LDO_VCC_REF_TUNE_MASK		0x30
 #define   LDO_VCC_REF_1V2		0x20
@@ -741,6 +766,8 @@
 
 #define RTS5260_AUTOLOAD_CFG4		0xFF7F
 #define   RTS5260_MIMO_DISABLE		0x8A
+/*RTS5261*/
+#define   RTS5261_AUX_CLK_16M_EN		(1 << 5)
 
 #define RTS5260_REG_GPIO_CTL0		0xFC1A
 #define   RTS5260_REG_GPIO_MASK		0x01
@@ -1191,6 +1218,7 @@ struct rtsx_pcr {
 #define EXTRA_CAPS_MMC_HS200		(1 << 4)
 #define EXTRA_CAPS_MMC_8BIT		(1 << 5)
 #define EXTRA_CAPS_NO_MMC		(1 << 7)
+#define EXTRA_CAPS_SD_EXPRESS		(1 << 8)
 	u32				extra_caps;
 
 #define IC_VER_A			0
-- 
2.17.1

