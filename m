Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 735EF1A198A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 03:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgDHB3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 21:29:12 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36769 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbgDHB3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 21:29:12 -0400
Received: by mail-pl1-f194.google.com with SMTP id g2so1924888plo.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 18:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gUT1UBZ/cLdcgRruxv8fykLkslu1hy1Oai+1Js7WnQs=;
        b=bA7POAMDBBVIblwxUFl2kEbwTY3Tw7ahb5M/3q7FRqpXxgzBjyE8ONfnWPNoIIeODE
         eIfZcygsSA8vidjqzP8s59euw270sdyai/R3Jh5gME3xD/CAFkcQl8iQdnJx9OkPP8an
         7yRiifnSgZPxPd6MJU3VRrn2CbANyBThV5xRjEUAOmeVCqXBG6wcXz59ZgPy2Y87pbz+
         dcQt1a2tpIvRiZ5Uia0VnSakP7Z5GFJxriDWP+CbCJLccbjA6hha8UIPcpvygY0nZw98
         aw4wt/8NQu7E3aMZRdhM6zp4L2InuyjhbRb5zQP+N4NpHBuhCrejd7i5wcU6OEmHjBCU
         WOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gUT1UBZ/cLdcgRruxv8fykLkslu1hy1Oai+1Js7WnQs=;
        b=CjwboMIl3Dlhu9PJuH6ww0UYz/HqItpYBH8jHickSiN2C1s/Ga6fBfapjg646LfOs/
         kMtwSeVv+q44Tb8Sh3tCnwBLrERBAivXBKzc/Ci4XYf2GISEwWrVS7myt7AajmLohKg0
         BsyVvC4YW84hm1fVVEmIsZ5LaUZTmUazT0r4TMBmC4MnVK0RF99ccDyL1BILGHUBsWMC
         FbWieRay0Zu5iQ4MxFXUPHiEl1Sdh+E0STxwQzFK3I8ixMs9wIvMBs4UTUmx3tYqPdUz
         3sd7LFFlh3kdKmqRt7N9fgY+SzB6JBAbI0M1lkqeHmxazd/Ajbjgkx1UmqavHVyUdIKS
         Wrrg==
X-Gm-Message-State: AGi0PuYqxwtsPrzFtjhaLtLDTA7Q1DSmEjwQH+ETY4L+3RWlSiOKTzLS
        Ji5OVuDOtlhkLdDVEKpXPZBcAA==
X-Google-Smtp-Source: APiQypJLGWK8bVJyTIV0UUYPYJaONdblV0C0myaNUlIYg3H2zGorOc4XQDGwfLNAIVYK6yv0Yhsdww==
X-Received: by 2002:a17:90a:1b42:: with SMTP id q60mr2461669pjq.84.1586309351560;
        Tue, 07 Apr 2020 18:29:11 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id u129sm15007868pfb.101.2020.04.07.18.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 18:29:10 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc:     Shawn Guo <shawn.guo@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] phy: qualcomm: usb-hs-28nm: Prepare clocks in init
Date:   Tue,  7 Apr 2020 18:28:54 -0700
Message-Id: <20200408012854.3070187-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AHB clock must be on for qcom_snps_hsphy_init() to be able to write
the initialization sequence to the hardware, so move the clock
enablement to phy init and exit.

Fixes: 67b27dbeac4d ("phy: qualcomm: Add Synopsys 28nm Hi-Speed USB PHY driver")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-usb-hs-28nm.c | 32 ++++++++++++++-------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-usb-hs-28nm.c b/drivers/phy/qualcomm/phy-qcom-usb-hs-28nm.c
index d998e65c89c8..a52a9bf13b75 100644
--- a/drivers/phy/qualcomm/phy-qcom-usb-hs-28nm.c
+++ b/drivers/phy/qualcomm/phy-qcom-usb-hs-28nm.c
@@ -160,18 +160,11 @@ static int qcom_snps_hsphy_power_on(struct phy *phy)
 	ret = regulator_bulk_enable(VREG_NUM, priv->vregs);
 	if (ret)
 		return ret;
-	ret = clk_bulk_prepare_enable(priv->num_clks, priv->clks);
-	if (ret)
-		goto err_disable_regulator;
+
 	qcom_snps_hsphy_disable_hv_interrupts(priv);
 	qcom_snps_hsphy_exit_retention(priv);
 
 	return 0;
-
-err_disable_regulator:
-	regulator_bulk_disable(VREG_NUM, priv->vregs);
-
-	return ret;
 }
 
 static int qcom_snps_hsphy_power_off(struct phy *phy)
@@ -180,7 +173,6 @@ static int qcom_snps_hsphy_power_off(struct phy *phy)
 
 	qcom_snps_hsphy_enter_retention(priv);
 	qcom_snps_hsphy_enable_hv_interrupts(priv);
-	clk_bulk_disable_unprepare(priv->num_clks, priv->clks);
 	regulator_bulk_disable(VREG_NUM, priv->vregs);
 
 	return 0;
@@ -266,21 +258,39 @@ static int qcom_snps_hsphy_init(struct phy *phy)
 	struct hsphy_priv *priv = phy_get_drvdata(phy);
 	int ret;
 
-	ret = qcom_snps_hsphy_reset(priv);
+	ret = clk_bulk_prepare_enable(priv->num_clks, priv->clks);
 	if (ret)
 		return ret;
 
+	ret = qcom_snps_hsphy_reset(priv);
+	if (ret)
+		goto disable_clocks;
+
 	qcom_snps_hsphy_init_sequence(priv);
 
 	ret = qcom_snps_hsphy_por_reset(priv);
 	if (ret)
-		return ret;
+		goto disable_clocks;
+
+	return 0;
+
+disable_clocks:
+	clk_bulk_disable_unprepare(priv->num_clks, priv->clks);
+	return ret;
+}
+
+static int qcom_snps_hsphy_exit(struct phy *phy)
+{
+	struct hsphy_priv *priv = phy_get_drvdata(phy);
+
+	clk_bulk_disable_unprepare(priv->num_clks, priv->clks);
 
 	return 0;
 }
 
 static const struct phy_ops qcom_snps_hsphy_ops = {
 	.init = qcom_snps_hsphy_init,
+	.exit = qcom_snps_hsphy_exit,
 	.power_on = qcom_snps_hsphy_power_on,
 	.power_off = qcom_snps_hsphy_power_off,
 	.set_mode = qcom_snps_hsphy_set_mode,
-- 
2.24.0

