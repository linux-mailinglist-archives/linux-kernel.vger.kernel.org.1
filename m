Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4BE22EF35E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 14:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbhAHNqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 08:46:02 -0500
Received: from mail-lf1-f53.google.com ([209.85.167.53]:41479 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbhAHNqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 08:46:01 -0500
Received: by mail-lf1-f53.google.com with SMTP id s26so22969319lfc.8;
        Fri, 08 Jan 2021 05:45:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hcPn4TWQQPUZScLPb9Qm3OsZ30QXjS5mL4RQ1+HMCzU=;
        b=hj29WVjBW16HMeYTXIxtTBHytzhHW21ZRrJjqyWU3vD+kTLdvq/U6gRvjCu+YNbM9N
         aWPhTBjrZB0x88qGav8nZ28vXc+gPp6OXV+ixfWIH8KMuenN3vcR97Pu8AzDM8b2C9sl
         fFh3PbzPrxcMIj1OlSsa7fOppPQkGGSfHQ0XLff4dMHjxKkdrr6EjRaFsMpIEao6qj2T
         KMHBsG9am04GLoN6aVVrN2/3qX63FTvM230kvT41f4z5I6t9Xn8mZO4L/bIpyeTLDPTU
         mnqrRhFjE274uz3iX3k77WCbRrjKSZXg0b/Xyb83rJZWkjnFt/1xxgLJvSb2G+zH8l5o
         N77g==
X-Gm-Message-State: AOAM530ANyH3Zr6eafu+WHbn+WlsmrHyOEQ7S/THP+w/j0RDxelxKyg1
        NeFQiFFlUSlyZJBqEMq7hwc=
X-Google-Smtp-Source: ABdhPJzQdbbDSXsC04NpQ3qkGR7Bk8zzRBsAOmlfHghDqN0zZsCVMKH5urw/OMvAqTxTMNU4fdSMKA==
X-Received: by 2002:a2e:9792:: with SMTP id y18mr1632815lji.204.1610113519286;
        Fri, 08 Jan 2021 05:45:19 -0800 (PST)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id w23sm1163793lff.84.2021.01.08.05.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 05:45:18 -0800 (PST)
Date:   Fri, 8 Jan 2021 15:45:12 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Lee Jones <lee.jones@linaro.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-power@fi.rohmeurope.com, linux-clk@vger.kernel.org
Subject: [PATCH 13/15] clk: bd718x7: Add support for clk gate on ROHM BD71815
 PMIC
Message-ID: <d7d070abbebcff9f3304f566b571e9ad16bda73d.1610110144.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1610110144.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1610110144.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ROHM BD71815 also provide clk signal for RTC. Add control
for gating this clock.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

clk Kconfig fix
---
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
