Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8112B597E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 06:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgKQF6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 00:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgKQF63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 00:58:29 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7751C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 21:58:29 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id j5so9651897plk.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 21:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xnycLun0wGTXJ5w4SlwLZ5E7rhEFIbLoOAivxoxcjMU=;
        b=YX38hifiak7WQOUJqn8+5xtTz1bzKEG2biRDzQ72ZLpGENMfpQ85YAAfyYA+RDyKOU
         JaWlSIO4kzBv/fpo/tePuCNr/1zE/jMari7BYAuIINQWpVutDSBzyKJCM6HdctbTUamX
         AS5yVzczEJjEFpVI52zDlYBcg1NleXqWfzF8x9FYgyedqHqq6GMIf7k+CYctNyxRR2CQ
         TFSpXA5SQbKekjMySkJnu3hNCf2hsqgMwcqUFTTylN/cDywnmrSU2jGfhEMLj+liT+D6
         iQyaTOJbWFMV9xFkyB/Tu8SwUMNZP6A/UKENrvFu3AWoXKtzbWq2GqondpIf1uxfZsmK
         YkqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xnycLun0wGTXJ5w4SlwLZ5E7rhEFIbLoOAivxoxcjMU=;
        b=mX3568hDuqz8F6a5ANf7MDdPwMjl0ulKg1pq+12mbYWhiFPhmJa1a7ClhPTKXL0snv
         Qi4xqZVBues+X2iM0Ci+V0i+9dCqoCHiXFgnT6D2Adu4vwixmgn8U8bULNb1O6PluLte
         c4/aW+7y5ZiOOSb0p2Wi535vlWzk5YjOXBT1Fzq/bQAS76COqAD46q9A+fCe238WiLvy
         1Kg86i7SI7Y4MX2PJKS5dnCv4VQWZZO96OBeQdNenzi3/UfQEOY+fukxznsOY8Mu2EJc
         2SiMQndzHMODnj8fs6NY5ADlXVMBcuWtZnQI+LjpXvs3JmyNxk3G1XuEXbkiC8VspDan
         6+uA==
X-Gm-Message-State: AOAM531jQtxw0QOdYcfA4qDScTjUQrhEZl6JDgqMQ+CoB9fnfamgjtIp
        jKYzhBl7sKJMpdtegZFcTxA=
X-Google-Smtp-Source: ABdhPJxMktzZl30xTOJeJFAJhDVALgcXZJ+/C9qIfyy0vXG3fQUNueITrB+y/WqASXZI4yww3+e5BA==
X-Received: by 2002:a17:902:6b8c:b029:d6:d32e:4a8c with SMTP id p12-20020a1709026b8cb02900d6d32e4a8cmr15885726plk.28.1605592709342;
        Mon, 16 Nov 2020 21:58:29 -0800 (PST)
Received: from localhost.localdomain ([8.210.202.142])
        by smtp.gmail.com with ESMTPSA id s21sm5955013pgm.65.2020.11.16.21.58.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Nov 2020 21:58:28 -0800 (PST)
From:   Yejune Deng <yejune.deng@gmail.com>
To:     kishon@ti.com, vkoul@kernel.org, khilman@baylibre.com,
        narmstrong@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, p.zabel@pengutronix.de
Cc:     lorenzo.pieralisi@arm.com, repk@triplefau.lt,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        yejune.deng@gmail.com
Subject: [PATCH] phy: amlogic: Replace devm_reset_control_array_get()
Date:   Tue, 17 Nov 2020 13:58:09 +0800
Message-Id: <1605592689-10108-1-git-send-email-yejune.deng@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_reset_control_array_get_exclusive() looks more readable

Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
---
 drivers/phy/amlogic/phy-meson-axg-pcie.c       | 2 +-
 drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c | 2 +-
 drivers/soc/amlogic/meson-ee-pwrc.c            | 3 +--
 drivers/soc/amlogic/meson-gx-pwrc-vpu.c        | 2 +-
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/amlogic/phy-meson-axg-pcie.c b/drivers/phy/amlogic/phy-meson-axg-pcie.c
index 377ed0d..3204f02 100644
--- a/drivers/phy/amlogic/phy-meson-axg-pcie.c
+++ b/drivers/phy/amlogic/phy-meson-axg-pcie.c
@@ -155,7 +155,7 @@ static int phy_axg_pcie_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->regmap))
 		return PTR_ERR(priv->regmap);
 
-	priv->reset = devm_reset_control_array_get(dev, false, false);
+	priv->reset = devm_reset_control_array_get_exclusive(dev);
 	if (IS_ERR(priv->reset))
 		return PTR_ERR(priv->reset);
 
diff --git a/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c b/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c
index 08e3227..bab6345 100644
--- a/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c
+++ b/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c
@@ -418,7 +418,7 @@ static int phy_g12a_usb3_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_disable_clk_ref;
 
-	priv->reset = devm_reset_control_array_get(dev, false, false);
+	priv->reset = devm_reset_control_array_get_exclusive(dev);
 	if (IS_ERR(priv->reset))
 		return PTR_ERR(priv->reset);
 
diff --git a/drivers/soc/amlogic/meson-ee-pwrc.c b/drivers/soc/amlogic/meson-ee-pwrc.c
index ed7d2fb..3a879a4 100644
--- a/drivers/soc/amlogic/meson-ee-pwrc.c
+++ b/drivers/soc/amlogic/meson-ee-pwrc.c
@@ -413,8 +413,7 @@ static int meson_ee_pwrc_init_domain(struct platform_device *pdev,
 			dev_warn(&pdev->dev, "Invalid resets count %d for domain %s\n",
 				 count, dom->desc.name);
 
-		dom->rstc = devm_reset_control_array_get(&pdev->dev, false,
-							 false);
+		dom->rstc = devm_reset_control_array_get_exclusive(&pdev->dev);
 		if (IS_ERR(dom->rstc))
 			return PTR_ERR(dom->rstc);
 	}
diff --git a/drivers/soc/amlogic/meson-gx-pwrc-vpu.c b/drivers/soc/amlogic/meson-gx-pwrc-vpu.c
index 8790627..b4615b2 100644
--- a/drivers/soc/amlogic/meson-gx-pwrc-vpu.c
+++ b/drivers/soc/amlogic/meson-gx-pwrc-vpu.c
@@ -304,7 +304,7 @@ static int meson_gx_pwrc_vpu_probe(struct platform_device *pdev)
 		return PTR_ERR(regmap_hhi);
 	}
 
-	rstc = devm_reset_control_array_get(&pdev->dev, false, false);
+	rstc = devm_reset_control_array_get_exclusive(&pdev->dev);
 	if (IS_ERR(rstc)) {
 		if (PTR_ERR(rstc) != -EPROBE_DEFER)
 			dev_err(&pdev->dev, "failed to get reset lines\n");
-- 
1.9.1

