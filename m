Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 009082A3B72
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 05:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgKCEiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 23:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgKCEiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 23:38:13 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AF9C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 20:38:13 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id w4so2470249pgg.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 20:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9GceZK4ciAeCqop9b1Rb6X2DCDZMt62Lqok/xRlnDwI=;
        b=GdsE7ywRxLmTLQddQqHjTdfGGLdIwdHyLWTICxjsEYocs7mHhh8Nc/hUZiYRQkmHXw
         X7ZsoZZA+rJ32jjjMs9l+1xaVIAra2fqlXnBJQl55hZ/ZF6jB0nwx6pPakPjO/xGAq/K
         Ndeco6Cb+oRWeuH1uA5Xb1fBb4zyPCXklF8E2qmX0rS669/GRkFiEPrKkuy5mANBmXn1
         frFbwFhxWPew0eKSZlYWEsHwzTJU8ex3zcMKicVF80lKn//N5VhMsJ/hco5jtEvva17y
         OLtJogPDZLi4qfrsgDxSk5EZprt6ddLSJwum2g0lJ13ciqmEUjf6ptDz0/Z4DvfoaGs/
         FDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9GceZK4ciAeCqop9b1Rb6X2DCDZMt62Lqok/xRlnDwI=;
        b=oxiyYeEVWSEqU4sSZ9z+ZLldtFye/hjwmA7W+JktPggrY8amBUT2ProXMyeXiHm+A8
         LeMlxwXY3Jb9Pkb4DX1f3OYDhEVjHdb+zcsDcUXUGlvc8n7JThmK3r/LaM8ejaFoq5PQ
         Uy/Yzz+1aFdRRz1XdnxdqURuxe0FVU9oe7YArAS1FY0eIQ71z6w/f6Dfhm11AFxYd9QS
         T8mo+EE3s0AfqaIon/jgNCmP3LWjzwf7Rf+cJW96SDDV8L00+jqyxkUt3XzyDiWOUsxv
         UqDm70ugBire7XsUUM+MkNfKhippnli+Q09BcJDKB1vvVGz7ZcpjheNwTH6pMiZQs72L
         suAg==
X-Gm-Message-State: AOAM532jBRQ2Pp+qw9XuhzyiQSpa8vZSF709GgYJvzEwk8TSNb96snOc
        f6y0glRJURiKJevjvPt/0BQ=
X-Google-Smtp-Source: ABdhPJy55kLAJIDI5ctckB372baVfeN1E0BOyGabuU8MWUzkNfifE3FSGziJWMGaNJyIkxWTVJFXCA==
X-Received: by 2002:a17:90a:318d:: with SMTP id j13mr1831845pjb.209.1604378292632;
        Mon, 02 Nov 2020 20:38:12 -0800 (PST)
Received: from localhost.localdomain ([8.210.202.142])
        by smtp.gmail.com with ESMTPSA id v16sm13630948pgk.26.2020.11.02.20.38.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Nov 2020 20:38:12 -0800 (PST)
From:   Yejune Deng <yejune.deng@gmail.com>
To:     khilman@baylibre.com, narmstrong@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        p.zabel@pengutronix.de, repk@triplefau.lt, yejune.deng@gmail.com,
        lorenzo.pieralisi@arm.com
Cc:     kishon@ti.com, vkoul@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH] phy: amlogic: Replace devm_reset_control_array_get()
Date:   Tue,  3 Nov 2020 12:37:54 +0800
Message-Id: <1604378274-6860-1-git-send-email-yejune.deng@gmail.com>
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
+		dom->rstc = devm_reset_control_array_get_exclusive(&pdev->dev)
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

