Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 094BF274919
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 21:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgIVT1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 15:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbgIVT1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 15:27:11 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A32C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 12:27:11 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id y11so19315305lfl.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 12:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zg6ilJOJPijk+82aRAFHt7wNQSPk2Nri12CuIZN1pbI=;
        b=qryF1qeVUWrQeTcTH3EEwVlwDoJGpvp5Y0gz9QhWYXj6eSKMSbdvrcZkuHt/JBSl34
         HMgXo87bp0vgZg5cW5bCcHjSujwhVAOtulhMesO+Hs4GH389nIFQkdGxTBeGDY/ahR5w
         /V75nrmmCfVHGO5Wk8iC5pxKWRj1nH23O1uS+0s7MvQv/lLL7WwQd+PhtqhioKtebvwr
         08mewC6v9x8Ln0+8CSPh7d8TaJdvxSWiMuPZF3okM6SJXkOfS/y/yk+d0EFIev8RSvIS
         aPSdwUlKuq/KHw7azPa1cOg0MK0x0vO5wCtXeNPy8B7u6HfjuCNNHUGrkVaJCdRARAKW
         imXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zg6ilJOJPijk+82aRAFHt7wNQSPk2Nri12CuIZN1pbI=;
        b=tY1hBTx2us2/uYPXjo2PMplt+y5jig5cUwoyMv/P2t9jmv65uq0NGeODgHThiKEwBU
         YKG96LNxxmDCRAI1tvnzNBadJOEkV7tcrN4gJMYN4oVeFyC77l1IYQzoPPrCUoTN+ElE
         yg5DrdnHIV1QTMxCeIFFQ/d+c28cCBas/YkKbpaN1WFOU/96AblNTNfexfxkJW+1AYQH
         ldb+FE1s0E8Y1kGWCfKvV2OEV8NRde4UgeqZ2knMNFRLDfirZN/+MOIfIHlKYdyGiCzG
         84CcnSBibNBI0pKVV2Q/S2OXquLWPX5nyZF/6mo5dK9aoHvWUL7CN4BzC1j73/K8+Dqp
         ZLTA==
X-Gm-Message-State: AOAM530AZGx8H+6ycYPb+9S6jdYXmN/smD3NbhIrYxtnHRLD4j7Mu2jK
        3qPwvaEQ6oi15rpi5qWXH1s=
X-Google-Smtp-Source: ABdhPJxQBSI8aDCLTDagNGHnc3s/M4o+M388lEFb2d9oBJl0jRRi+kv+CSFx53B/iJDzEpbG1zEaDQ==
X-Received: by 2002:a19:ac49:: with SMTP id r9mr2030828lfc.582.1600802829605;
        Tue, 22 Sep 2020 12:27:09 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id r132sm3770013lff.167.2020.09.22.12.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 12:27:08 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 2/8] mfd: intel: Constify static struct resource
Date:   Tue, 22 Sep 2020 21:26:53 +0200
Message-Id: <20200922192659.14535-3-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922192659.14535-1-rikard.falkeborn@gmail.com>
References: <20200922192659.14535-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Constify a number of static struct resource. The only usage of the
structs are to assign their address to the resources field in the
mfd_cell struct. This allows the compiler to put them in read-only
memory. Done with the help of Coccinelle.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/mfd/intel_msic.c              | 18 +++++++++---------
 drivers/mfd/intel_soc_pmic_bxtwc.c    | 14 +++++++-------
 drivers/mfd/intel_soc_pmic_chtdc_ti.c | 10 +++++-----
 drivers/mfd/intel_soc_pmic_chtwc.c    |  4 ++--
 drivers/mfd/intel_soc_pmic_crc.c      | 10 +++++-----
 5 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/mfd/intel_msic.c b/drivers/mfd/intel_msic.c
index bb24c2a07900..daa772f8146b 100644
--- a/drivers/mfd/intel_msic.c
+++ b/drivers/mfd/intel_msic.c
@@ -50,23 +50,23 @@ struct intel_msic {
 	void __iomem			*irq_base;
 };
 
-static struct resource msic_touch_resources[] = {
+static const struct resource msic_touch_resources[] = {
 	DEFINE_RES_IRQ(0),
 };
 
-static struct resource msic_adc_resources[] = {
+static const struct resource msic_adc_resources[] = {
 	DEFINE_RES_IRQ(0),
 };
 
-static struct resource msic_battery_resources[] = {
+static const struct resource msic_battery_resources[] = {
 	DEFINE_RES_IRQ(0),
 };
 
-static struct resource msic_gpio_resources[] = {
+static const struct resource msic_gpio_resources[] = {
 	DEFINE_RES_IRQ(0),
 };
 
-static struct resource msic_audio_resources[] = {
+static const struct resource msic_audio_resources[] = {
 	DEFINE_RES_IRQ_NAMED(0, "IRQ"),
 	/*
 	 * We will pass IRQ_BASE to the driver now but this can be removed
@@ -75,19 +75,19 @@ static struct resource msic_audio_resources[] = {
 	DEFINE_RES_MEM_NAMED(MSIC_IRQ_STATUS_ACCDET, 1, "IRQ_BASE"),
 };
 
-static struct resource msic_hdmi_resources[] = {
+static const struct resource msic_hdmi_resources[] = {
 	DEFINE_RES_IRQ(0),
 };
 
-static struct resource msic_thermal_resources[] = {
+static const struct resource msic_thermal_resources[] = {
 	DEFINE_RES_IRQ(0),
 };
 
-static struct resource msic_power_btn_resources[] = {
+static const struct resource msic_power_btn_resources[] = {
 	DEFINE_RES_IRQ(0),
 };
 
-static struct resource msic_ocd_resources[] = {
+static const struct resource msic_ocd_resources[] = {
 	DEFINE_RES_IRQ(0),
 };
 
diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index eba89780dbe7..47d0d3a69a58 100644
--- a/drivers/mfd/intel_soc_pmic_bxtwc.c
+++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
@@ -200,32 +200,32 @@ static struct regmap_irq_chip bxtwc_regmap_irq_chip_crit = {
 	.num_regs = 1,
 };
 
-static struct resource gpio_resources[] = {
+static const struct resource gpio_resources[] = {
 	DEFINE_RES_IRQ_NAMED(BXTWC_GPIO_LVL1_IRQ, "GPIO"),
 };
 
-static struct resource adc_resources[] = {
+static const struct resource adc_resources[] = {
 	DEFINE_RES_IRQ_NAMED(BXTWC_ADC_IRQ, "ADC"),
 };
 
-static struct resource usbc_resources[] = {
+static const struct resource usbc_resources[] = {
 	DEFINE_RES_IRQ(BXTWC_USBC_IRQ),
 };
 
-static struct resource charger_resources[] = {
+static const struct resource charger_resources[] = {
 	DEFINE_RES_IRQ_NAMED(BXTWC_CHGR0_IRQ, "CHARGER"),
 	DEFINE_RES_IRQ_NAMED(BXTWC_CHGR1_IRQ, "CHARGER1"),
 };
 
-static struct resource thermal_resources[] = {
+static const struct resource thermal_resources[] = {
 	DEFINE_RES_IRQ(BXTWC_THRM_LVL1_IRQ),
 };
 
-static struct resource bcu_resources[] = {
+static const struct resource bcu_resources[] = {
 	DEFINE_RES_IRQ_NAMED(BXTWC_BCU_IRQ, "BCU"),
 };
 
-static struct resource tmu_resources[] = {
+static const struct resource tmu_resources[] = {
 	DEFINE_RES_IRQ_NAMED(BXTWC_TMU_IRQ, "TMU"),
 };
 
diff --git a/drivers/mfd/intel_soc_pmic_chtdc_ti.c b/drivers/mfd/intel_soc_pmic_chtdc_ti.c
index 64b5c3cc30e7..1c7577b881ff 100644
--- a/drivers/mfd/intel_soc_pmic_chtdc_ti.c
+++ b/drivers/mfd/intel_soc_pmic_chtdc_ti.c
@@ -32,23 +32,23 @@ enum {
 	CHTDC_TI_CCEOCAL = 7,	/* battery */
 };
 
-static struct resource power_button_resources[] = {
+static const struct resource power_button_resources[] = {
 	DEFINE_RES_IRQ(CHTDC_TI_PWRBTN),
 };
 
-static struct resource thermal_resources[] = {
+static const struct resource thermal_resources[] = {
 	DEFINE_RES_IRQ(CHTDC_TI_DIETMPWARN),
 };
 
-static struct resource adc_resources[] = {
+static const struct resource adc_resources[] = {
 	DEFINE_RES_IRQ(CHTDC_TI_ADCCMPL),
 };
 
-static struct resource pwrsrc_resources[] = {
+static const struct resource pwrsrc_resources[] = {
 	DEFINE_RES_IRQ(CHTDC_TI_VBUSDET),
 };
 
-static struct resource battery_resources[] = {
+static const struct resource battery_resources[] = {
 	DEFINE_RES_IRQ(CHTDC_TI_VBATLOW),
 	DEFINE_RES_IRQ(CHTDC_TI_CCEOCAL),
 };
diff --git a/drivers/mfd/intel_soc_pmic_chtwc.c b/drivers/mfd/intel_soc_pmic_chtwc.c
index be84bb2aa837..49c5f71664bc 100644
--- a/drivers/mfd/intel_soc_pmic_chtwc.c
+++ b/drivers/mfd/intel_soc_pmic_chtwc.c
@@ -41,11 +41,11 @@ enum {
 	CHT_WC_CRIT_IRQ = 7,
 };
 
-static struct resource cht_wc_pwrsrc_resources[] = {
+static const struct resource cht_wc_pwrsrc_resources[] = {
 	DEFINE_RES_IRQ(CHT_WC_PWRSRC_IRQ),
 };
 
-static struct resource cht_wc_ext_charger_resources[] = {
+static const struct resource cht_wc_ext_charger_resources[] = {
 	DEFINE_RES_IRQ(CHT_WC_EXT_CHGR_IRQ),
 };
 
diff --git a/drivers/mfd/intel_soc_pmic_crc.c b/drivers/mfd/intel_soc_pmic_crc.c
index 429efa1f8e55..38acb20e2d60 100644
--- a/drivers/mfd/intel_soc_pmic_crc.c
+++ b/drivers/mfd/intel_soc_pmic_crc.c
@@ -28,23 +28,23 @@
 #define CRYSTAL_COVE_IRQ_GPIO		5
 #define CRYSTAL_COVE_IRQ_VHDMIOCP	6
 
-static struct resource gpio_resources[] = {
+static const struct resource gpio_resources[] = {
 	DEFINE_RES_IRQ_NAMED(CRYSTAL_COVE_IRQ_GPIO, "GPIO"),
 };
 
-static struct resource pwrsrc_resources[] = {
+static const struct resource pwrsrc_resources[] = {
 	DEFINE_RES_IRQ_NAMED(CRYSTAL_COVE_IRQ_PWRSRC, "PWRSRC"),
 };
 
-static struct resource adc_resources[] = {
+static const struct resource adc_resources[] = {
 	DEFINE_RES_IRQ_NAMED(CRYSTAL_COVE_IRQ_ADC, "ADC"),
 };
 
-static struct resource thermal_resources[] = {
+static const struct resource thermal_resources[] = {
 	DEFINE_RES_IRQ_NAMED(CRYSTAL_COVE_IRQ_THRM, "THERMAL"),
 };
 
-static struct resource bcu_resources[] = {
+static const struct resource bcu_resources[] = {
 	DEFINE_RES_IRQ_NAMED(CRYSTAL_COVE_IRQ_BCU, "BCU"),
 };
 
-- 
2.28.0

