Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475B41B8AB9
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Apr 2020 03:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgDZB0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Apr 2020 21:26:01 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:32805 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgDZB0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 21:26:01 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 03Q1PmK02016047, This message is accepted by code: ctloc85258
Received: from RS-CAS02.realsil.com.cn (msx.realsil.com.cn[172.29.17.3])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 03Q1PmK02016047
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Sun, 26 Apr 2020 09:25:48 +0800
Received: from localhost (172.29.40.150) by RS-CAS02.realsil.com.cn
 (172.29.17.3) with Microsoft SMTP Server id 14.3.439.0; Sun, 26 Apr 2020
 09:25:48 +0800
From:   <rui_feng@realsil.com.cn>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <ulf.hansson@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, Rui Feng <rui_feng@realsil.com.cn>
Subject: [PATCH] mmc: rtsx: Add SD Express mode support for RTS5261
Date:   Sun, 26 Apr 2020 09:25:46 +0800
Message-ID: <1587864346-3144-1-git-send-email-rui_feng@realsil.com.cn>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.29.40.150]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rui Feng <rui_feng@realsil.com.cn>

RTS5261 support legacy SD mode and SD Express mode.
In SD7.x, SD association introduce SD Express as a new mode.
SD Express mode is distinguished by CMD8.
Therefore, CMD8 has new bit for SD Express.
SD Express is based on PCIe/NVMe.
RTS5261 uses CMD8 to switch to SD Express mode.

Signed-off-by: Rui Feng <rui_feng@realsil.com.cn>
---
 drivers/misc/cardreader/Kconfig    |  8 ++++++
 drivers/misc/cardreader/Makefile   |  3 +++
 drivers/misc/cardreader/rts5261.c  |  7 +++++
 drivers/misc/cardreader/rtsx_pcr.c |  7 +++++
 drivers/mmc/core/sd_ops.c          |  9 ++++++-
 drivers/mmc/host/rtsx_pci_sdmmc.c  | 43 ++++++++++++++++++++++++++++++
 include/linux/mmc/host.h           |  1 +
 include/linux/rtsx_pci.h           | 15 +++++++++++
 8 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/cardreader/Kconfig b/drivers/misc/cardreader/Kconfig
index 022322dfb36e..1ce6bf1d121c 100644
--- a/drivers/misc/cardreader/Kconfig
+++ b/drivers/misc/cardreader/Kconfig
@@ -21,6 +21,14 @@ config MISC_RTSX_PCI
 	  such as Memory Stick, Memory Stick Pro, Secure Digital and
 	  MultiMediaCard.
 
+config MISC_RTSX_PCI_SD_EXPRESS
+        bool "Realtek PCI-E card reader support sd express card"
+        depends on MISC_RTSX_PCI
+        default y
+        help
+          RTS5261 support SD Express card.
+          Say Y here if you want to enable PCIe/NVMe mode.
+
 config MISC_RTSX_USB
 	tristate "Realtek USB card reader"
 	depends on USB
diff --git a/drivers/misc/cardreader/Makefile b/drivers/misc/cardreader/Makefile
index 1f56267ed2f4..589011999f78 100644
--- a/drivers/misc/cardreader/Makefile
+++ b/drivers/misc/cardreader/Makefile
@@ -2,4 +2,7 @@
 obj-$(CONFIG_MISC_ALCOR_PCI)	+= alcor_pci.o
 obj-$(CONFIG_MISC_RTSX_PCI)	+= rtsx_pci.o
 rtsx_pci-objs := rtsx_pcr.o rts5209.o rts5229.o rtl8411.o rts5227.o rts5249.o rts5260.o rts5261.o
+
+ccflags-$(CONFIG_MISC_RTSX_PCI_SD_EXPRESS) += -DMISC_RTSX_PCI_SD_EXPRESS
+
 obj-$(CONFIG_MISC_RTSX_USB)	+= rtsx_usb.o
diff --git a/drivers/misc/cardreader/rts5261.c b/drivers/misc/cardreader/rts5261.c
index 547db5ffd3f6..68cb0562c278 100644
--- a/drivers/misc/cardreader/rts5261.c
+++ b/drivers/misc/cardreader/rts5261.c
@@ -759,8 +759,14 @@ void rts5261_init_params(struct rtsx_pcr *pcr)
 {
 	struct rtsx_cr_option *option = &pcr->option;
 	struct rtsx_hw_param *hw_param = &pcr->hw_param;
+	u8 val;
 
 	pcr->extra_caps = EXTRA_CAPS_SD_SDR50 | EXTRA_CAPS_SD_SDR104;
+#ifdef MISC_RTSX_PCI_SD_EXPRESS
+	rtsx_pci_read_register(pcr, RTS5261_FW_STATUS, &val);
+	if (!(val & RTS5261_EXPRESS_LINK_FAIL_MASK))
+		pcr->extra_caps |= EXTRA_CAPS_SD_EXPRESS;
+#endif
 	pcr->num_slots = 1;
 	pcr->ops = &rts5261_pcr_ops;
 
@@ -791,6 +797,7 @@ void rts5261_init_params(struct rtsx_pcr *pcr)
 	option->ltr_l1off_snooze_sspwrgate = 0x78;
 	option->dev_aspm_mode = DEV_ASPM_DYNAMIC;
 
+	hw_param->interrupt_en |= DELINK_INT_EN;
 	option->ocp_en = 1;
 	hw_param->interrupt_en |= SD_OC_INT_EN;
 	hw_param->ocp_glitch =  SD_OCP_GLITCH_800U;
diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index 06038b325b02..2127c7b6b2e1 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -1026,6 +1026,13 @@ static irqreturn_t rtsx_pci_isr(int irq, void *dev_id)
 		} else {
 			pcr->card_removed |= SD_EXIST;
 			pcr->card_inserted &= ~SD_EXIST;
+#ifdef MISC_RTSX_PCI_SD_EXPRESS
+			if (PCI_PID(pcr) == PID_5261) {
+				rtsx_pci_write_register(pcr, RTS5261_FW_STATUS,
+					RTS5261_EXPRESS_LINK_FAIL_MASK, 0);
+				pcr->extra_caps |= EXTRA_CAPS_SD_EXPRESS;
+			}
+#endif
 		}
 		pcr->dma_error_count = 0;
 	}
diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
index 22bf528294b9..7c70d267644b 100644
--- a/drivers/mmc/core/sd_ops.c
+++ b/drivers/mmc/core/sd_ops.c
@@ -171,7 +171,14 @@ int mmc_send_if_cond(struct mmc_host *host, u32 ocr)
 	 * SD 1.0 cards.
 	 */
 	cmd.opcode = SD_SEND_IF_COND;
-	cmd.arg = ((ocr & 0xFF8000) != 0) << 8 | test_pattern;
+	/*
+	 * Host asks card's PCIe availability
+	 * if PCIe interface is supported by host.
+	 */
+	if ((ocr & 0xFF8000) && (host->caps2 & MMC_CAP2_SD_EXPRESS))
+		cmd.arg = 0x31 << 8 | test_pattern;
+	else
+		cmd.arg = ((ocr & 0xFF8000) != 0) << 8 | test_pattern;
 	cmd.flags = MMC_RSP_SPI_R7 | MMC_RSP_R7 | MMC_CMD_BCR;
 
 	err = mmc_wait_for_cmd(host, &cmd, 0);
diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index bd50935dc37d..87ad75b253eb 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -219,6 +219,7 @@ static void sd_send_cmd_get_rsp(struct realtek_pci_sdmmc *host,
 	int rsp_type;
 	int stat_idx;
 	bool clock_toggled = false;
+	u32 relink_time, val;
 
 	dev_dbg(sdmmc_dev(host), "%s: SD/MMC CMD %d, arg = 0x%08x\n",
 			__func__, cmd_idx, arg);
@@ -322,6 +323,44 @@ static void sd_send_cmd_get_rsp(struct realtek_pci_sdmmc *host,
 	if (err && clock_toggled)
 		rtsx_pci_write_register(pcr, SD_BUS_STAT,
 				SD_CLK_TOGGLE_EN | SD_CLK_FORCE_STOP, 0);
+
+	/*
+	 * If card has PCIe availability and WP if off,
+	 * reader switch to PCIe mode.
+	 */
+	val = rtsx_pci_readl(pcr, RTSX_BIPR);
+	if (cmd->opcode == 8 && ((cmd->resp[0] >> 8) & 0x10)
+		&& !(val & SD_WRITE_PROTECT)) {
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
+		cmd->error = -EPERM;
+	}
 }
 
 static int sd_read_data(struct realtek_pci_sdmmc *host, struct mmc_command *cmd,
@@ -1123,6 +1162,8 @@ static int sdmmc_get_cd(struct mmc_host *mmc)
 	dev_dbg(sdmmc_dev(host), "%s: RTSX_BIPR = 0x%08x\n", __func__, val);
 	if (val & SD_EXIST)
 		cd = 1;
+	if (pcr->extra_caps & EXTRA_CAPS_SD_EXPRESS)
+		mmc->caps2 |= MMC_CAP2_SD_EXPRESS;
 
 	mutex_unlock(&pcr->pcr_mutex);
 
@@ -1333,6 +1374,8 @@ static void init_extra_caps(struct realtek_pci_sdmmc *host)
 		mmc->caps |= MMC_CAP_1_8V_DDR;
 	if (pcr->extra_caps & EXTRA_CAPS_MMC_8BIT)
 		mmc->caps |= MMC_CAP_8_BIT_DATA;
+	if (pcr->extra_caps & EXTRA_CAPS_SD_EXPRESS)
+		mmc->caps2 |= MMC_CAP2_SD_EXPRESS;
 }
 
 static void realtek_init_host(struct realtek_pci_sdmmc *host)
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index ba703384bea0..ac1e3da4ad4f 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -369,6 +369,7 @@ struct mmc_host {
 #define MMC_CAP2_CQE_DCMD	(1 << 24)	/* CQE can issue a direct command */
 #define MMC_CAP2_AVOID_3_3V	(1 << 25)	/* Host must negotiate down from 3.3V */
 #define MMC_CAP2_MERGE_CAPABLE	(1 << 26)	/* Host can merge a segment over the segment size */
+#define MMC_CAP2_SD_EXPRESS	(1 << 27)	/* Host support sd express card */
 
 	int			fixed_drv_type;	/* fixed driver type for non-removable media */
 
diff --git a/include/linux/rtsx_pci.h b/include/linux/rtsx_pci.h
index 65b8142a7fed..2783dc5202ea 100644
--- a/include/linux/rtsx_pci.h
+++ b/include/linux/rtsx_pci.h
@@ -667,6 +667,16 @@
 #define   PM_WAKE_EN			0x01
 #define PM_CTRL4			0xFF47
 
+#define RTS5261_FW_CFG0			0xFF54
+#define RTS5261_FW_ENTER_EXPRESS	(0x01<<0)
+
+#define RTS5261_FW_CFG1			0xFF55
+#define RTS5261_MCU_BUS_SEL_MASK	(0x01<<4)
+#define RTS5261_MCU_CLOCK_SEL_MASK	(0x03<<2)
+#define RTS5261_MCU_CLOCK_SEL_16M	(0x01<<2)
+#define RTS5261_MCU_CLOCK_GATING	(0x01<<1)
+#define RTS5261_DRIVER_ENABLE_FW	(0x01<<0)
+
 /* Memory mapping */
 #define SRAM_BASE			0xE600
 #define RBUF_BASE			0xF400
@@ -704,6 +714,8 @@
 /*RTS5260*/
 #define   RTS5260_DVCC_TUNE_MASK	0x70
 #define   RTS5260_DVCC_33		0x70
+/*RTS5261*/
+#define   RTS5261_LDO1_OCP_THD_MASK	(0x07<<5)
 
 #define LDO_VCC_CFG1			0xFF73
 #define   LDO_VCC_REF_TUNE_MASK		0x30
@@ -745,6 +757,8 @@
 
 #define RTS5260_AUTOLOAD_CFG4		0xFF7F
 #define   RTS5260_MIMO_DISABLE		0x8A
+/*RTS5261*/
+#define   RTS5261_AUX_CLK_16M_EN		(1 << 5)
 
 #define RTS5260_REG_GPIO_CTL0		0xFC1A
 #define   RTS5260_REG_GPIO_MASK		0x01
@@ -1217,6 +1231,7 @@ struct rtsx_pcr {
 #define EXTRA_CAPS_MMC_HSDDR		(1 << 3)
 #define EXTRA_CAPS_MMC_HS200		(1 << 4)
 #define EXTRA_CAPS_MMC_8BIT		(1 << 5)
+#define EXTRA_CAPS_SD_EXPRESS		(1 << 6)
 	u32				extra_caps;
 
 #define IC_VER_A			0
-- 
2.17.1

