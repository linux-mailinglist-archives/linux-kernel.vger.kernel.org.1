Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037A42EAB28
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 13:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbhAEMsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 07:48:45 -0500
Received: from mail-lf1-f44.google.com ([209.85.167.44]:40540 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728318AbhAEMso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 07:48:44 -0500
Received: by mail-lf1-f44.google.com with SMTP id m12so72260383lfo.7;
        Tue, 05 Jan 2021 04:48:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=WVVIx6PVhLwLplystJZYvhWeXG//TClji/7GLWGokI8=;
        b=GH+3aDIfIEnaSoFnFu/3KBG5w4E4ehNViUVPv5Aen+YqRSsE0+Yt5D/dSdpNHQUtYA
         ewgl7DayBomFlv1zg3YSG3jIRaBJsgq8MjQXoGuexW6ttJ5AUOIbnAZQPsqZnJ4aVVFT
         7Olcwme+or2lJhraAPvqJ9Z2wXV9KSiyvjwzJ9xZLG/QmDmap+fFRBtYGIubl0FwmS6e
         N4lwuWJ4ORdsgt5z5F/bDT7aDF008s7r/JBin21B0o9Xg8qUt1wsNqfKLrTWXMlcx0Zo
         uWTLthTGJGfbBUIBoUK0JFil8NC2rF4ZccTT/VvZm0AHv6ZL/+RGxilY5byXfZTvo3sw
         2goQ==
X-Gm-Message-State: AOAM533xmyMdTKkx4fuwZpuh9tcRnKdy+Jk92eceXBCBXJA6MlmG6nQm
        EAMOFLJi0xxrdnFk4sWdHwY=
X-Google-Smtp-Source: ABdhPJwynyN+uxLUCFSfpexwN6aD1GsIHPuTSLZtETHD0K2xhW+5jQnW2bSBTwfcDIv7SGh9zc9TWg==
X-Received: by 2002:a19:cb12:: with SMTP id b18mr36124105lfg.480.1609850881466;
        Tue, 05 Jan 2021 04:48:01 -0800 (PST)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id v7sm7600621lfg.9.2021.01.05.04.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 04:48:00 -0800 (PST)
Date:   Tue, 5 Jan 2021 14:47:54 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-power@fi.rohmeurope.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: BD718x7: Do not depend on parent driver data
Message-ID: <20210105123028.GA3409663@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bd718x7 only needs a regmap from parent device. This can be
obtained by call to dev_get_regmap. Do not require parent to
populate the driver data for this.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/clk/clk-bd718x7.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/clk-bd718x7.c b/drivers/clk/clk-bd718x7.c
index b52e8d6f660c..17d90e09f1c0 100644
--- a/drivers/clk/clk-bd718x7.c
+++ b/drivers/clk/clk-bd718x7.c
@@ -31,12 +31,12 @@ struct bd718xx_clk {
 	u8 reg;
 	u8 mask;
 	struct platform_device *pdev;
-	struct rohm_regmap_dev *mfd;
+	struct regmap *regmap;
 };
 
 static int bd71837_clk_set(struct bd718xx_clk *c, unsigned int status)
 {
-	return regmap_update_bits(c->mfd->regmap, c->reg, c->mask, status);
+	return regmap_update_bits(c->regmap, c->reg, c->mask, status);
 }
 
 static void bd71837_clk_disable(struct clk_hw *hw)
@@ -62,7 +62,7 @@ static int bd71837_clk_is_enabled(struct clk_hw *hw)
 	int rval;
 	struct bd718xx_clk *c = container_of(hw, struct bd718xx_clk, hw);
 
-	rval = regmap_read(c->mfd->regmap, c->reg, &enabled);
+	rval = regmap_read(c->regmap, c->reg, &enabled);
 
 	if (rval)
 		return rval;
@@ -82,7 +82,6 @@ static int bd71837_clk_probe(struct platform_device *pdev)
 	int rval = -ENOMEM;
 	const char *parent_clk;
 	struct device *parent = pdev->dev.parent;
-	struct rohm_regmap_dev *mfd = dev_get_drvdata(parent);
 	struct clk_init_data init = {
 		.name = "bd718xx-32k-out",
 		.ops = &bd71837_clk_ops,
@@ -93,6 +92,10 @@ static int bd71837_clk_probe(struct platform_device *pdev)
 	if (!c)
 		return -ENOMEM;
 
+	c->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!c->regmap)
+		return -ENODEV;
+
 	init.num_parents = 1;
 	parent_clk = of_clk_get_parent_name(parent->of_node, 0);
 
@@ -119,7 +122,6 @@ static int bd71837_clk_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Unknown clk chip\n");
 		return -EINVAL;
 	}
-	c->mfd = mfd;
 	c->pdev = pdev;
 	c->hw.init = &init;
 
-- 
2.25.4


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 
