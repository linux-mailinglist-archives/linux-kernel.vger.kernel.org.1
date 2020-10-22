Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98A3129662E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 22:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371976AbgJVUvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 16:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S371963AbgJVUvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 16:51:08 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6888DC0613CF;
        Thu, 22 Oct 2020 13:51:06 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id b26so1986582pff.3;
        Thu, 22 Oct 2020 13:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KPCWMzUI39vPR5himTPEZbRuj8PfwZlQXkDGiE+SRb8=;
        b=DT7onatVljMWpFZmZdrehjTWqb6B8qsGuv2uyX8CH5ujMM9XMPC+Wbsn2K2EXOQ/0k
         ewcbJMATu3rEQ8x30tvFaYTcy/IrX7hrmVEbXp1OwkFnQ8qODJgtOMr4ksHrA+cjczDi
         /FhDq0SVlECMXFMdhfgfjDsr/yZsxPqC24sjB05x2O0XEIcelalIUxwHEj9n2G6nahwV
         7J/JlKR6rQ/QPK3Mperw37kaP7dokWJcKpBar7HcwU4An4TzdTIv3cNcpappuWDReAzB
         PiMjWpit7NaMS6iaGBgc+/cydCN5rsY9JnR9+psOdNa6IMn39c+oH9U5OCUHeicopfQe
         oZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KPCWMzUI39vPR5himTPEZbRuj8PfwZlQXkDGiE+SRb8=;
        b=Nvh/l83C1Amnv0cDkfM5m2poq4tu22QJM9TZ/nGw70ydW5Lt77M/xFHVOleUmDFXq6
         QClgBMeMBoqoLtxL1/Vk0T/78wRGckPaKOyUz6r5LGfmZappGnPvc3yYyB8nC/JbPSrp
         Bcfxzx8sE3+9xKcztH4qepyZq89y/zqHyU/pZe2ysVfvLAaUY1s2OLsbDOHF39/aBA3a
         bMsKYZoik55IagblSyoZDfnLRsXwMvfweccuqb4HXljL0X0kwB4Fmox2YiF88KSNsegE
         9WpFOBxmk4v38sgHb0im055eKPSnDhQXX/JCUUtBvEy4FIFCoDTNSgBjFqQs5W11gvVy
         JRLw==
X-Gm-Message-State: AOAM530UlMmRJDMLltkrySxlgjgzJAcDb38LyzhgvRtqqhQAeKI0uRnG
        +osHlcTOWMmP/zlzy0rb+BFwykU54NY=
X-Google-Smtp-Source: ABdhPJwn9p3aHCuPHfX58pQOkJDnKWWU037UWFk/DUsjiDMGuVBwwA9mBLGDLoGdisTSnncq3xsVPw==
X-Received: by 2002:a63:4c55:: with SMTP id m21mr3879223pgl.305.1603399865498;
        Thu, 22 Oct 2020 13:51:05 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id kc21sm2890803pjb.36.2020.10.22.13.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 13:51:04 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH v2 2/2] phy: phy-brcm-sata: Allow configuration SATA AFE TX amplitude
Date:   Thu, 22 Oct 2020 13:50:56 -0700
Message-Id: <20201022205056.233879-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201022205056.233879-1-f.fainelli@gmail.com>
References: <20201022205056.233879-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Read the 'brcm,tx-amplitude-millivolt' property from Device Tree and
propagate its value into the appropriate test transmit register to
change the TX amplitude.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/phy/broadcom/phy-brcm-sata.c | 32 ++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/phy/broadcom/phy-brcm-sata.c b/drivers/phy/broadcom/phy-brcm-sata.c
index 18251f232172..7be3586b16cb 100644
--- a/drivers/phy/broadcom/phy-brcm-sata.c
+++ b/drivers/phy/broadcom/phy-brcm-sata.c
@@ -65,6 +65,7 @@ struct brcm_sata_port {
 	bool ssc_en;
 	enum brcm_sata_phy_rxaeq_mode rxaeq_mode;
 	u32 rxaeq_val;
+	u32 tx_amplitude_val;
 };
 
 struct brcm_sata_phy {
@@ -84,6 +85,10 @@ enum sata_phy_regs {
 	BLOCK0_SPARE_OOB_CLK_SEL_MASK		= 0x3,
 	BLOCK0_SPARE_OOB_CLK_SEL_REFBY2		= 0x1,
 
+	BLOCK1_REG_BANK				= 0x10,
+	BLOCK1_TEST_TX				= 0x83,
+	BLOCK1_TEST_TX_AMP_SHIFT		= 12,
+
 	PLL_REG_BANK_0				= 0x050,
 	PLL_REG_BANK_0_PLLCONTROL_0		= 0x81,
 	PLLCONTROL_0_FREQ_DET_RESTART		= BIT(13),
@@ -379,6 +384,29 @@ static int brcm_stb_sata_16nm_ssc_init(struct brcm_sata_port *port)
 	brcm_sata_phy_wr(port, RXPMD_REG_BANK, RXPMD_RX_FREQ_MON_CONTROL1,
 			 ~tmp, RXPMD_MON_CORRECT_EN | value);
 
+	tmp = GENMASK(15, 12);
+	switch (port->tx_amplitude_val) {
+	case 400:
+		value = BIT(12) | BIT(13);
+		break;
+	case 500:
+		value = BIT(13);
+		break;
+	case 600:
+		value = BIT(12);
+		break;
+	case 800:
+		value = 0;
+		break;
+	default:
+		value = tmp;
+		break;
+	}
+
+	if (value != tmp)
+		brcm_sata_phy_wr(port, BLOCK1_REG_BANK, BLOCK1_TEST_TX, ~tmp,
+				 value);
+
 	/* Turn on/off SSC */
 	brcm_sata_phy_wr(port, TX_REG_BANK, TX_ACTRL5, ~TX_ACTRL5_SSC_EN,
 			 port->ssc_en ? TX_ACTRL5_SSC_EN : 0);
@@ -791,6 +819,10 @@ static int brcm_sata_phy_probe(struct platform_device *pdev)
 		if (port->rxaeq_mode == RXAEQ_MODE_MANUAL)
 			of_property_read_u32(child, "brcm,rxaeq-value",
 					     &port->rxaeq_val);
+
+		of_property_read_u32(child, "brcm,tx-amplitude-millivolt",
+				     &port->tx_amplitude_val);
+
 		port->ssc_en = of_property_read_bool(child, "brcm,enable-ssc");
 		if (IS_ERR(port->phy)) {
 			dev_err(dev, "failed to create PHY\n");
-- 
2.25.1

