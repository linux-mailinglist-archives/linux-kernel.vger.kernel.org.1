Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E33127F829
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 05:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730556AbgJADTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 23:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730296AbgJADTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 23:19:39 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45116C061755;
        Wed, 30 Sep 2020 20:19:39 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id k8so3110371pfk.2;
        Wed, 30 Sep 2020 20:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KPCWMzUI39vPR5himTPEZbRuj8PfwZlQXkDGiE+SRb8=;
        b=malDPUJF0OPSFscTOo6xJqzE2wntxaT2K/1UrOLpm8t9eiJ+krb3wh1EH+rXXIcHXP
         PyUE87ySjkMAH7rzsJYoe8g9CTS2COYRZP6G9VpBi2ka6WPpJK9fl3rU++lNk9yNCE1M
         Aqi1AJyLbfXDfePeDRLg2R6X+5vqjXRQamcZfhA2/lbziQQLeBqWHTN0cuc4FstZdAky
         PZuCM+fsk3KzFS4qKYpzznJB3qofC1B3c+dPB/AjJSs8Kr7uKVxJyCw+LC+jA6Kg7C9M
         +i6ydrMzS8s/gLV3pwF0gTJMRvCS+0jEiTPwOcUw1AlzXbWmgBG0DrKrOLVb80KZ5DKh
         Xutg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KPCWMzUI39vPR5himTPEZbRuj8PfwZlQXkDGiE+SRb8=;
        b=oHudWHs1z9ENgTAtwUATxitUvTuCALXdyy3v7/Hw0BEVfhklbw7/+1yXvzt0V1qtMP
         zjCKD2hceDBPNDX5YMBI8ti67Mm1QLubKQ1vsM+Bjfg70Spyvi3XMJfO2IJ3aohng6n2
         ftGNbWLaSLYle70/wdNq369I1lwpmzhh+yfGkFyvum2qrFTD7JrnY2DanQ2MbLFSFNGD
         nIRwqBbca02SDvAUBObJhrJleNq5mIf5cuwM5p/vj/jfro1FP8TVwzulWV4eq20Npb6o
         QNKsKuT7cmKlt0f2R0xHnyivQ7zfcphogN9WhkT8xWIeXTC3CZOYSLwetxIIPL8tmrcG
         X8Yg==
X-Gm-Message-State: AOAM530W5n6ascPVEZBcN6hGa57Kkw+ZVidNS+Zdi7jByknYM49zR1rK
        m8APvsvtvBm61uJ+lMTswLB/1GUBLb4NqA==
X-Google-Smtp-Source: ABdhPJygh7UktBOsl/6Wmz0+pylmU0S3mXNLw7yW3KsoGbBg8+TG7oTQkYm9oAW2EmL1UKHm6O6IRg==
X-Received: by 2002:a62:1b4e:0:b029:13e:d13d:a135 with SMTP id b75-20020a621b4e0000b029013ed13da135mr5148198pfb.29.1601522378371;
        Wed, 30 Sep 2020 20:19:38 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id f17sm3369242pgd.86.2020.09.30.20.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 20:19:37 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH 2/2] phy: phy-brcm-sata: Allow configuration SATA AFE TX amplitude
Date:   Wed, 30 Sep 2020 20:19:16 -0700
Message-Id: <20201001031916.411999-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201001031916.411999-1-f.fainelli@gmail.com>
References: <20201001031916.411999-1-f.fainelli@gmail.com>
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

