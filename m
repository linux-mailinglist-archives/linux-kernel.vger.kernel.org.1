Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A19F286D7E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 06:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgJHESO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 00:18:14 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:47299 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgJHESN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 00:18:13 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 0984HmamE025802, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb01.realtek.com.tw[172.21.6.94])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 0984HmamE025802
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 8 Oct 2020 12:17:48 +0800
Received: from localhost (172.22.88.222) by RTEXMB01.realtek.com.tw
 (172.21.6.94) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Thu, 8 Oct 2020
 12:17:48 +0800
From:   <ricky_wu@realtek.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <ricky_wu@realtek.corp-partner.google.com>,
        <ulf.hansson@linaro.org>, <kdlnx@doth.eu>,
        <rui_feng@realsil.com.cn>, <swboyd@chromium.org>,
        <levinale@chromium.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] misc: rtsx: rts522a support L1 substate
Date:   Thu, 8 Oct 2020 12:17:42 +0800
Message-ID: <20201008041742.5511-1-ricky_wu@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.22.88.222]
X-ClientProxiedBy: RTEXMB01.realtek.com.tw (172.21.6.94) To
 RTEXMB01.realtek.com.tw (172.21.6.94)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ricky Wu <ricky_wu@realtek.corp-partner.google.com>

add rts522a L1 substate functions for kernel 5.4

Signed-off-by: Ricky Wu <ricky_wu@realtek.corp-partner.google.com>
---
 drivers/misc/cardreader/rts5227.c  | 111 ++++++++++++++++++++++++++++-
 drivers/misc/cardreader/rtsx_pcr.c |  30 ++++++++
 drivers/misc/cardreader/rtsx_pcr.h |   2 +
 include/linux/rtsx_pci.h           |   5 ++
 4 files changed, 146 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/cardreader/rts5227.c b/drivers/misc/cardreader/rts5227.c
index 3a9467aaa435..0d59106c7228 100644
--- a/drivers/misc/cardreader/rts5227.c
+++ b/drivers/misc/cardreader/rts5227.c
@@ -89,10 +89,73 @@ static void rts5227_force_power_down(struct rtsx_pcr *pcr, u8 pm_state)
 	rtsx_pci_write_register(pcr, FPDCTL, 0x03, 0x03);
 }
 
+static void rts5227_init_from_cfg(struct rtsx_pcr *pcr)
+{
+	struct pci_dev *pdev = pcr->pci;
+	int l1ss;
+	u32 lval;
+	struct rtsx_cr_option *option = &pcr->option;
+
+	l1ss = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_L1SS);
+	if (!l1ss)
+		return;
+
+	pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL1, &lval);
+
+	if (CHK_PCI_PID(pcr, 0x522A)) {
+		if (0 == (lval & 0x0F))
+			rtsx_pci_enable_oobs_polling(pcr);
+		else
+			rtsx_pci_disable_oobs_polling(pcr);
+	}
+
+	if (lval & PCI_L1SS_CTL1_ASPM_L1_1)
+		rtsx_set_dev_flag(pcr, ASPM_L1_1_EN);
+	else
+		rtsx_clear_dev_flag(pcr, ASPM_L1_1_EN);
+
+	if (lval & PCI_L1SS_CTL1_ASPM_L1_2)
+		rtsx_set_dev_flag(pcr, ASPM_L1_2_EN);
+	else
+		rtsx_clear_dev_flag(pcr, ASPM_L1_2_EN);
+
+	if (lval & PCI_L1SS_CTL1_PCIPM_L1_1)
+		rtsx_set_dev_flag(pcr, PM_L1_1_EN);
+	else
+		rtsx_clear_dev_flag(pcr, PM_L1_1_EN);
+
+	if (lval & PCI_L1SS_CTL1_PCIPM_L1_2)
+		rtsx_set_dev_flag(pcr, PM_L1_2_EN);
+	else
+		rtsx_clear_dev_flag(pcr, PM_L1_2_EN);
+
+	if (option->ltr_en) {
+		u16 val;
+
+		pcie_capability_read_word(pcr->pci, PCI_EXP_DEVCTL2, &val);
+		if (val & PCI_EXP_DEVCTL2_LTR_EN) {
+			option->ltr_enabled = true;
+			option->ltr_active = true;
+			rtsx_set_ltr_latency(pcr, option->ltr_active_latency);
+		} else {
+			option->ltr_enabled = false;
+		}
+	}
+
+	if (rtsx_check_dev_flag(pcr, ASPM_L1_1_EN | ASPM_L1_2_EN
+				| PM_L1_1_EN | PM_L1_2_EN))
+		option->force_clkreq_0 = false;
+	else
+		option->force_clkreq_0 = true;
+
+}
+
 static int rts5227_extra_init_hw(struct rtsx_pcr *pcr)
 {
 	u16 cap;
+	struct rtsx_cr_option *option = &pcr->option;
 
+	rts5227_init_from_cfg(pcr);
 	rtsx_pci_init_cmd(pcr);
 
 	/* Configure GPIO as output */
@@ -114,9 +177,17 @@ static int rts5227_extra_init_hw(struct rtsx_pcr *pcr)
 	rts5227_fill_driving(pcr, OUTPUT_3V3);
 	/* Configure force_clock_req */
 	if (pcr->flags & PCR_REVERSE_SOCKET)
-		rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PETXCFG, 0xB8, 0xB8);
+		rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PETXCFG, 0x30, 0x30);
+	else
+		rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PETXCFG, 0x30, 0x00);
+
+	if (option->force_clkreq_0)
+		rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PETXCFG,
+				FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_LOW);
 	else
-		rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PETXCFG, 0xB8, 0x88);
+		rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PETXCFG,
+				FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_HIGH);
+
 	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, pcr->reg_pm_ctrl3, 0x10, 0x00);
 
 	return rtsx_pci_send_cmd(pcr, 100);
@@ -372,6 +443,28 @@ static int rts522a_switch_output_voltage(struct rtsx_pcr *pcr, u8 voltage)
 	return rtsx_pci_send_cmd(pcr, 100);
 }
 
+static void rts522a_set_l1off_cfg_sub_d0(struct rtsx_pcr *pcr, int active)
+{
+	struct rtsx_cr_option *option = &pcr->option;
+	int aspm_L1_1, aspm_L1_2;
+	u8 val = 0;
+
+	aspm_L1_1 = rtsx_check_dev_flag(pcr, ASPM_L1_1_EN);
+	aspm_L1_2 = rtsx_check_dev_flag(pcr, ASPM_L1_2_EN);
+
+	if (active) {
+		/* run, latency: 60us */
+		if (aspm_L1_1)
+			val = option->ltr_l1off_snooze_sspwrgate;
+	} else {
+		/* l1off, latency: 300us */
+		if (aspm_L1_2)
+			val = option->ltr_l1off_sspwrgate;
+	}
+
+	rtsx_set_l1off_sub(pcr, val);
+}
+
 
 /* rts522a operations mainly derived from rts5227, except phy/hw init setting.
  */
@@ -389,15 +482,29 @@ static const struct pcr_ops rts522a_pcr_ops = {
 	.cd_deglitch = NULL,
 	.conv_clk_and_div_n = NULL,
 	.force_power_down = rts5227_force_power_down,
+	.set_l1off_cfg_sub_d0 = rts522a_set_l1off_cfg_sub_d0,
 };
 
 void rts522a_init_params(struct rtsx_pcr *pcr)
 {
+	struct rtsx_cr_option *option = &pcr->option;
+
 	rts5227_init_params(pcr);
 	pcr->ops = &rts522a_pcr_ops;
 	pcr->tx_initial_phase = SET_CLOCK_PHASE(20, 20, 11);
 	pcr->reg_pm_ctrl3 = RTS522A_PM_CTRL3;
 
+	option->dev_flags = LTR_L1SS_PWR_GATE_EN;
+	option->ltr_en = true;
+
+	/* init latency of active, idle, L1OFF to 60us, 300us, 3ms */
+	option->ltr_active_latency = LTR_ACTIVE_LATENCY_DEF;
+	option->ltr_idle_latency = LTR_IDLE_LATENCY_DEF;
+	option->ltr_l1off_latency = LTR_L1OFF_LATENCY_DEF;
+	option->l1_snooze_delay = L1_SNOOZE_DELAY_DEF;
+	option->ltr_l1off_sspwrgate = 0x7F;
+	option->ltr_l1off_snooze_sspwrgate = 0x78;
+
 	pcr->option.ocp_en = 1;
 	if (pcr->option.ocp_en)
 		pcr->hw_param.interrupt_en |= SD_OC_INT_EN;
diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index f20a6d52149b..ebac27212f07 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -1229,6 +1229,36 @@ void rtsx_pci_clear_ocpstat(struct rtsx_pcr *pcr)
 	}
 }
 
+void rtsx_pci_enable_oobs_polling(struct rtsx_pcr *pcr)
+{
+	u16 val;
+
+	if ((PCI_PID(pcr) != PID_525A) && (PCI_PID(pcr) != PID_5260)) {
+		rtsx_pci_read_phy_register(pcr, 0x01, &val);
+		val |= 1<<9;
+		rtsx_pci_write_phy_register(pcr, 0x01, val);
+	}
+	rtsx_pci_write_register(pcr, REG_CFG_OOBS_OFF_TIMER, 0xFF, 0x32);
+	rtsx_pci_write_register(pcr, REG_CFG_OOBS_ON_TIMER, 0xFF, 0x05);
+	rtsx_pci_write_register(pcr, REG_CFG_VCM_ON_TIMER, 0xFF, 0x83);
+	rtsx_pci_write_register(pcr, REG_CFG_OOBS_POLLING, 0xFF, 0xDE);
+
+}
+
+void rtsx_pci_disable_oobs_polling(struct rtsx_pcr *pcr)
+{
+	u16 val;
+
+	if ((PCI_PID(pcr) != PID_525A) && (PCI_PID(pcr) != PID_5260)) {
+		rtsx_pci_read_phy_register(pcr, 0x01, &val);
+		val &= ~(1<<9);
+		rtsx_pci_write_phy_register(pcr, 0x01, val);
+	}
+	rtsx_pci_write_register(pcr, REG_CFG_VCM_ON_TIMER, 0xFF, 0x03);
+	rtsx_pci_write_register(pcr, REG_CFG_OOBS_POLLING, 0xFF, 0x00);
+
+}
+
 int rtsx_sd_power_off_card3v3(struct rtsx_pcr *pcr)
 {
 	rtsx_pci_write_register(pcr, CARD_CLK_EN, SD_CLK_EN |
diff --git a/drivers/misc/cardreader/rtsx_pcr.h b/drivers/misc/cardreader/rtsx_pcr.h
index ed391df52f4f..77c11d80157e 100644
--- a/drivers/misc/cardreader/rtsx_pcr.h
+++ b/drivers/misc/cardreader/rtsx_pcr.h
@@ -101,6 +101,8 @@ void rtsx_pci_disable_ocp(struct rtsx_pcr *pcr);
 void rtsx_pci_enable_ocp(struct rtsx_pcr *pcr);
 int rtsx_pci_get_ocpstat(struct rtsx_pcr *pcr, u8 *val);
 void rtsx_pci_clear_ocpstat(struct rtsx_pcr *pcr);
+void rtsx_pci_enable_oobs_polling(struct rtsx_pcr *pcr);
+void rtsx_pci_disable_oobs_polling(struct rtsx_pcr *pcr);
 int rtsx_sd_power_off_card3v3(struct rtsx_pcr *pcr);
 int rtsx_ms_power_off_card3v3(struct rtsx_pcr *pcr);
 
diff --git a/include/linux/rtsx_pci.h b/include/linux/rtsx_pci.h
index 65b8142a7fed..588005fc9b97 100644
--- a/include/linux/rtsx_pci.h
+++ b/include/linux/rtsx_pci.h
@@ -667,6 +667,11 @@
 #define   PM_WAKE_EN			0x01
 #define PM_CTRL4			0xFF47
 
+#define REG_CFG_OOBS_OFF_TIMER 0xFEA6
+#define REG_CFG_OOBS_ON_TIMER 0xFEA7
+#define REG_CFG_VCM_ON_TIMER 0xFEA8
+#define REG_CFG_OOBS_POLLING 0xFEA9
+
 /* Memory mapping */
 #define SRAM_BASE			0xE600
 #define RBUF_BASE			0xF400
-- 
2.17.1

