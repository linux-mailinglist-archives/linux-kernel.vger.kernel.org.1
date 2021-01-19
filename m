Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684702FB304
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 08:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbhASHcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 02:32:19 -0500
Received: from mail-lf1-f46.google.com ([209.85.167.46]:40891 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731022AbhASHbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 02:31:16 -0500
Received: by mail-lf1-f46.google.com with SMTP id v24so21046771lfr.7;
        Mon, 18 Jan 2021 23:31:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XisBtQoP/h2Art6/IseMNTK1FqmH5E0sUU7cL3tMI1Q=;
        b=j5Yiy0GNvKe+N6YIJdudvAM0+pvm0+ZfBBzgJ/TokZhLTAG5Ia1BD746pbJ+RAvG7t
         L6RG9kHz2DKftw+7weJGhosrqgjNE6nz7BpEBk9NM5y8b10SlD0NS9+ZQIdsnTIupvgm
         IlzY8j+qZ/zr9f/q+Bdrasd6Bwr3AQtzu1IzBSrGSdw9G/cnJb5N1tpLFOA2Gl+/A1ue
         1azF5UqVVo02q+6rLjDo1viWuQ4157PgxN6PEO9SsZvunh7aZP+vYS28JHKw1dHjDFTz
         agEO2SLxzartl+W/1YqxniktOFpXvkTreE7VWWSxNwTsuv4UtUhEpzys8AzhcFvZcnFf
         x/Vg==
X-Gm-Message-State: AOAM530oQHVRZNvQzH/ADlE4BjkllMguZuMGIGeK3xoIP3nUhkS4uZrM
        6O0Q5JtM4sTq9oumD9uqC+o=
X-Google-Smtp-Source: ABdhPJwgAi159NofUTB5nRfYBYUd8MsJfhOdlcvkh3mTtkPy4WcBttk0ZNGEfhN2S+HP/ep5jSkT3g==
X-Received: by 2002:a19:a40a:: with SMTP id q10mr1241256lfc.39.1611041434272;
        Mon, 18 Jan 2021 23:30:34 -0800 (PST)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id t18sm476102lja.52.2021.01.18.23.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 23:30:33 -0800 (PST)
Date:   Tue, 19 Jan 2021 09:30:26 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Lee Jones <lee.jones@linaro.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-power@fi.rohmeurope.com, linux-clk@vger.kernel.org
Subject: [PATCH v2 15/17] clk: bd718x7: Add support for clk gate on ROHM
 BD71815 PMIC
Message-ID: <0f44b1d32d28f64b5a33a8319319506fdf317487.1611037866.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1611037866.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1611037866.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ROHM BD71815 also provide clk signal for RTC. Add control
for gating this clock.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---

Changes since v1:
removed squash-commit leftover from commit message

 drivers/clk/clk-bd718x7.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-bd718x7.c b/drivers/clk/clk-bd718x7.c
index 17d90e09f1c0..d9e70e506d18 100644
--- a/drivers/clk/clk-bd718x7.c
+++ b/drivers/clk/clk-bd718x7.c
@@ -13,6 +13,8 @@
 #include <linux/regmap.h>
 
 /* clk control registers */
+/* BD71815 */
+#define BD71815_REG_OUT32K	0x1d
 /* BD70528 */
 #define BD70528_REG_OUT32K	0x2c
 /* BD71828 */
@@ -118,6 +120,10 @@ static int bd71837_clk_probe(struct platform_device *pdev)
 		c->reg = BD70528_REG_OUT32K;
 		c->mask = CLK_OUT_EN_MASK;
 		break;
+	case ROHM_CHIP_TYPE_BD71815:
+		c->reg = BD71815_REG_OUT32K;
+		c->mask = CLK_OUT_EN_MASK;
+		break;
 	default:
 		dev_err(&pdev->dev, "Unknown clk chip\n");
 		return -EINVAL;
@@ -146,6 +152,7 @@ static const struct platform_device_id bd718x7_clk_id[] = {
 	{ "bd71847-clk", ROHM_CHIP_TYPE_BD71847 },
 	{ "bd70528-clk", ROHM_CHIP_TYPE_BD70528 },
 	{ "bd71828-clk", ROHM_CHIP_TYPE_BD71828 },
+	{ "bd71815-clk", ROHM_CHIP_TYPE_BD71815 },
 	{ },
 };
 MODULE_DEVICE_TABLE(platform, bd718x7_clk_id);
@@ -161,6 +168,6 @@ static struct platform_driver bd71837_clk = {
 module_platform_driver(bd71837_clk);
 
 MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
-MODULE_DESCRIPTION("BD71837/BD71847/BD70528 chip clk driver");
+MODULE_DESCRIPTION("BD718(15/18/28/37/47/50) and BD70528 chip clk driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:bd718xx-clk");
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
