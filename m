Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6172EF30D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 14:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbhAHNcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 08:32:48 -0500
Received: from mail-lf1-f51.google.com ([209.85.167.51]:42003 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbhAHNcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 08:32:47 -0500
Received: by mail-lf1-f51.google.com with SMTP id b26so22903753lff.9;
        Fri, 08 Jan 2021 05:32:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W4lO/s0iMGk19qMdPoDZMWO0rMg1GjXtK6eR1C/M5p4=;
        b=ayQAfDHlZnuCFZ8CIEBCIPFz/iPrHhSC+w7W4PzVSdi3fh0Bw110XjHm5yNx2SgFm6
         fb6485AowWDSnB7qS7gh5PKA1XnWLuMH+cC2EOFntV6amYMcKX8B1kwTGFQBsaKlMNAO
         oizfWvy9UDmCtPaC7DinE2Z6jJpwqN74ZAR9OrMiu4/lrj90y9mXm75UXDXIgf9YnsoF
         te/W08MVAYwt08tl4x+DiZO7NZV5QalPKuMBcOixyBDEU+PdhF8svPUj9hU/zml9mxAL
         F77XWIxncxqYEHcqUSTZMIm8G53MvBnHl+qfmMscIJQUEAAgB3Quw4cnFeWal3HdldgE
         v5dQ==
X-Gm-Message-State: AOAM5336IiMxpV6fazm398F1IDm5skkGMAGXNAsjseIPe/Eoctl1xy8C
        l1pAq+W4D+2s8vJVpoc0hxA=
X-Google-Smtp-Source: ABdhPJzNeNcWW331RO5MgKjZvd31biHvCz3tM5gWXozpEtYwSSjNaxmnc2YLuJL/rJz2qjsfbPXzOw==
X-Received: by 2002:a2e:586:: with SMTP id 128mr1656161ljf.273.1610112725049;
        Fri, 08 Jan 2021 05:32:05 -0800 (PST)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id j18sm1960739lfb.77.2021.01.08.05.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 05:32:04 -0800 (PST)
Date:   Fri, 8 Jan 2021 15:31:57 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Lee Jones <lee.jones@linaro.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-power@fi.rohmeurope.com,
        linux-clk@vger.kernel.org
Subject: [PATCH 02/15] clk: BD718x7: Do not depend on parent driver data
Message-ID: <831b5fd8f595599b628303c1b678a9c74d73907d.1610110144.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1610110144.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1610110144.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bd718x7 only needs a regmap from parent device. This can be
obtained by call to dev_get_regmap. Do not require parent to
populate the driver data for this.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---

Please note that this same change has been sent individually:
https://lore.kernel.org/lkml/20210105123028.GA3409663@localhost.localdomain/
It is present in this series only because some patches depend on it.

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
