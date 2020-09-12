Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB82267C46
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 22:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbgILUtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 16:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgILUsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 16:48:51 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF6EC061574
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 13:48:51 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id u4so15315732ljd.10
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 13:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DDuxTXn0uuPAM2vxYu+cFK96JLH5syK3DF9zQ5UtSqw=;
        b=hqQW1SrDHdtt8RmDczxEwr1y5LY9AJdwTXSgkrIiOZ615cCYIic5+o1jdp587rFaVb
         Cw4XcnxilUv6o1zmyGnEporemb9jS+p5Yd5+AvkUi3JhMVuH/qhtEYkZcSBdj/tUnqXU
         GCmW2T2BJ4LWuRmRdrmFd/vhZ5WBWEeB2LkfxJ5DsDfCXztO/EQa54c3OF53rr5qcTe0
         FFlTPIW1YsZCiAdb0UHYQsjMDl0QN1Qlo1ullucaos+KDng4vHwyCY5nxy7X3p8rQUhd
         lBEjXN5cVkCd126HnuIYwKTbGgDt6dYXtjORZSyTIG2cvM7i5q86HGsDRmY7SYQPSH5j
         5NiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DDuxTXn0uuPAM2vxYu+cFK96JLH5syK3DF9zQ5UtSqw=;
        b=P8K+KNVyVLEhVPypq2NCLqF1kA7csm0X+Iuaf1ybXmc7IK1ZXi4xLJKjBtuytmAUH5
         7kBtiiZyFVfhRPU31QaBAUzhRaLZVGBNn9c5AN3JGGJirjfg2eLE6LfuI2l6X8PhwQph
         GARShMmPsRV75Ouqk3vT2b++Q45Pv6tAWwqU5dSZmRJvI54eifnibY7qTrBWMhJxwzfb
         LhaKwUHKiZuQ+/oDJ/LFSnJ9v0VFTIAoZJu9hfnTABn8Uf5Tt3LbwJYIdtQJJ4Y4tbqH
         AaBIqXRhJyJAiKuOfK7HDbOXOtQx3Ko6T67PVj5oIXIUI+mJE2z+FjtId+2cgHqQFCgS
         T/6A==
X-Gm-Message-State: AOAM533ZYwPH1GDCJotaufYrV229lByMZ/t+Re9950wR7JykvKmzrRQd
        O28IopG5+MIR2v5di8uzBc4=
X-Google-Smtp-Source: ABdhPJxmTmwQUA/nLiWmSi3AR8WjikaUT6f2STvKbZPVL1eK7LpHlkmtsiH62KOZG/Nl0acAzug71Q==
X-Received: by 2002:a2e:85a:: with SMTP id g26mr2909659ljd.294.1599943729554;
        Sat, 12 Sep 2020 13:48:49 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id r7sm1729753lfn.84.2020.09.12.13.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 13:48:48 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Peter Chen <peter.chen@nxp.com>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Yuti Amonkar <yamonkar@cadence.com>,
        Sanket Parmar <sparmar@cadence.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 1/3] phy: cadence: Sierra: Constify static structs
Date:   Sat, 12 Sep 2020 22:46:37 +0200
Message-Id: <20200912204639.501669-2-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200912204639.501669-1-rikard.falkeborn@gmail.com>
References: <20200912204639.501669-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The static cdns_reg_pairs and regmap_config structs are not modified and
can be made const. This allows the compiler to put them in read-only
memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index faed652b73f7..453ef26fa1c7 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -172,10 +172,10 @@ struct cdns_sierra_data {
 		u32 pcie_ln_regs;
 		u32 usb_cmn_regs;
 		u32 usb_ln_regs;
-		struct cdns_reg_pairs *pcie_cmn_vals;
-		struct cdns_reg_pairs *pcie_ln_vals;
-		struct cdns_reg_pairs *usb_cmn_vals;
-		struct cdns_reg_pairs *usb_ln_vals;
+		const struct cdns_reg_pairs *pcie_cmn_vals;
+		const struct cdns_reg_pairs *pcie_ln_vals;
+		const struct cdns_reg_pairs *usb_cmn_vals;
+		const struct cdns_reg_pairs *usb_ln_vals;
 };
 
 struct cdns_regmap_cdb_context {
@@ -233,7 +233,7 @@ static int cdns_regmap_read(void *context, unsigned int reg, unsigned int *val)
 	.reg_read = cdns_regmap_read, \
 }
 
-static struct regmap_config cdns_sierra_lane_cdb_config[] = {
+static const struct regmap_config cdns_sierra_lane_cdb_config[] = {
 	SIERRA_LANE_CDB_REGMAP_CONF("0"),
 	SIERRA_LANE_CDB_REGMAP_CONF("1"),
 	SIERRA_LANE_CDB_REGMAP_CONF("2"),
@@ -252,7 +252,7 @@ static struct regmap_config cdns_sierra_lane_cdb_config[] = {
 	SIERRA_LANE_CDB_REGMAP_CONF("15"),
 };
 
-static struct regmap_config cdns_sierra_common_cdb_config = {
+static const struct regmap_config cdns_sierra_common_cdb_config = {
 	.name = "sierra_common_cdb",
 	.reg_stride = 1,
 	.fast_io = true,
@@ -260,7 +260,7 @@ static struct regmap_config cdns_sierra_common_cdb_config = {
 	.reg_read = cdns_regmap_read,
 };
 
-static struct regmap_config cdns_sierra_phy_config_ctrl_config = {
+static const struct regmap_config cdns_sierra_phy_config_ctrl_config = {
 	.name = "sierra_phy_config_ctrl",
 	.reg_stride = 1,
 	.fast_io = true,
@@ -274,7 +274,7 @@ static int cdns_sierra_phy_init(struct phy *gphy)
 	struct cdns_sierra_phy *phy = dev_get_drvdata(gphy->dev.parent);
 	struct regmap *regmap;
 	int i, j;
-	struct cdns_reg_pairs *cmn_vals, *ln_vals;
+	const struct cdns_reg_pairs *cmn_vals, *ln_vals;
 	u32 num_cmn_regs, num_ln_regs;
 
 	/* Initialise the PHY registers, unless auto configured */
@@ -654,7 +654,7 @@ static int cdns_sierra_phy_remove(struct platform_device *pdev)
 }
 
 /* refclk100MHz_32b_PCIe_cmn_pll_ext_ssc */
-static struct cdns_reg_pairs cdns_pcie_cmn_regs_ext_ssc[] = {
+static const struct cdns_reg_pairs cdns_pcie_cmn_regs_ext_ssc[] = {
 	{0x2106, SIERRA_CMN_PLLLC_LF_COEFF_MODE1_PREG},
 	{0x2106, SIERRA_CMN_PLLLC_LF_COEFF_MODE0_PREG},
 	{0x8A06, SIERRA_CMN_PLLLC_BWCAL_MODE1_PREG},
@@ -663,7 +663,7 @@ static struct cdns_reg_pairs cdns_pcie_cmn_regs_ext_ssc[] = {
 };
 
 /* refclk100MHz_32b_PCIe_ln_ext_ssc */
-static struct cdns_reg_pairs cdns_pcie_ln_regs_ext_ssc[] = {
+static const struct cdns_reg_pairs cdns_pcie_ln_regs_ext_ssc[] = {
 	{0x813E, SIERRA_CLKPATHCTRL_TMR_PREG},
 	{0x8047, SIERRA_RX_CREQ_FLTR_A_MODE3_PREG},
 	{0x808F, SIERRA_RX_CREQ_FLTR_A_MODE2_PREG},
@@ -674,7 +674,7 @@ static struct cdns_reg_pairs cdns_pcie_ln_regs_ext_ssc[] = {
 };
 
 /* refclk100MHz_20b_USB_cmn_pll_ext_ssc */
-static struct cdns_reg_pairs cdns_usb_cmn_regs_ext_ssc[] = {
+static const struct cdns_reg_pairs cdns_usb_cmn_regs_ext_ssc[] = {
 	{0x2085, SIERRA_CMN_PLLLC_LF_COEFF_MODE1_PREG},
 	{0x2085, SIERRA_CMN_PLLLC_LF_COEFF_MODE0_PREG},
 	{0x0000, SIERRA_CMN_PLLLC_BWCAL_MODE0_PREG},
@@ -682,7 +682,7 @@ static struct cdns_reg_pairs cdns_usb_cmn_regs_ext_ssc[] = {
 };
 
 /* refclk100MHz_20b_USB_ln_ext_ssc */
-static struct cdns_reg_pairs cdns_usb_ln_regs_ext_ssc[] = {
+static const struct cdns_reg_pairs cdns_usb_ln_regs_ext_ssc[] = {
 	{0xFE0A, SIERRA_DET_STANDEC_A_PREG},
 	{0x000F, SIERRA_DET_STANDEC_B_PREG},
 	{0x55A5, SIERRA_DET_STANDEC_C_PREG},
-- 
2.28.0

