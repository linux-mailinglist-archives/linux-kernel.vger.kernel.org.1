Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9F52CBAB3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 11:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729485AbgLBKjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 05:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbgLBKjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 05:39:32 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B1CC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 02:38:52 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id z9so650240qtn.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 02:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mV1p8/cTOhIl3icxdE2Ji4asKgGKkxP3UCtu80k0nyo=;
        b=UjRyf8L5N8FlEvvIhnEPinYHqNCi+199anr9DfIoruwBYEkVRmRP6vAOb/RYKvM9hf
         /DdcK/j55C1ccbYoDSHutChOt8ete5Xob1swGWjJgfYbQ07Xl58iBOFW+vIYy04AoSCI
         XT+pbXMyNGzGLuip39gqrfuwnPOkskGwugQR3vaFvDuBeix3X+wZlfJ2O9NWuEnsP6Gh
         l0FDXJahwnLmy3OT0KVcvNzM8GtDkQYlS7/rK1Wer6sIDRbysMtPUXtI5SJdues/RN5p
         9KHkQhESglsSjiqtvI8/GMz+7BXe/x/EjR2uZOVbTpRkaxmepHY4l3pfu9oz48bbaGDG
         5XqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mV1p8/cTOhIl3icxdE2Ji4asKgGKkxP3UCtu80k0nyo=;
        b=fgVLBtfwM8v/jfIwnXRABqsx9dv3R8OWwGZbWuCne6oF7dBxxk/nDlLRJIyIE8cckj
         0K5B42g83FxJFZ5rU5O4JwuRMIyeP1yrCfhwvPFbsxF6L/yfOIS+1QSX79JF7KOQGYFX
         jmwEFEP3gfl/BaU+Gs2ICioAM1L2JQixWKo9A8f+OcM1k6fKKJegMEw3cpgM+E60XyMR
         rd3VRjhKbaESpVVkDjQVj79jZCA6W1zLLN4+DoofpnRec1T8GdkoxbgAJ+P2N+3gFhFU
         J8HgFPs8i4WCy77D3615oLs9XlmQMDS8yBSN8VJr9oE0hDBLCAzE7LWRrLS4CFFyfKS8
         W3mA==
X-Gm-Message-State: AOAM533fSkeYbJG4NvL/9HAV1gBEk1b3aas7L4c2vIJWxkOYK7w1kHPB
        8TVTwxyk0b8kaZ83bqmLdbI=
X-Google-Smtp-Source: ABdhPJwPcicd8p1UGpJazg/IWR6VTClzi2r6wxqVrHNtm/+xAz2MmAY98nCXJ3WzeQgsBdmcBZASCw==
X-Received: by 2002:ac8:5994:: with SMTP id e20mr1893949qte.219.1606905531360;
        Wed, 02 Dec 2020 02:38:51 -0800 (PST)
Received: from localhost.localdomain ([177.194.72.74])
        by smtp.gmail.com with ESMTPSA id b186sm1248725qkc.111.2020.12.02.02.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 02:38:50 -0800 (PST)
From:   Fabio Estevam <festevam@gmail.com>
To:     p.zabel@pengutronix.de
Cc:     mchehab@kernel.org, linux-kernel@vger.kernel.org,
        hverkuil-cisco@xs4all.nl, Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2] media: coda: Convert the driver to DT-only
Date:   Wed,  2 Dec 2020 07:35:52 -0300
Message-Id: <20201202103552.19162-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 5.10-rc1 i.MX is a devicetree-only platform, so simplify the code
by removing the unused non-DT support.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v1:
- Drop include/linux/platform_data/media/coda.h and pdata - Hans

 drivers/media/platform/coda/coda-common.c | 27 ++---------------------
 include/linux/platform_data/media/coda.h  | 14 ------------
 2 files changed, 2 insertions(+), 39 deletions(-)
 delete mode 100644 include/linux/platform_data/media/coda.h

diff --git a/drivers/media/platform/coda/coda-common.c b/drivers/media/platform/coda/coda-common.c
index d30eafea701d..995e95272e51 100644
--- a/drivers/media/platform/coda/coda-common.c
+++ b/drivers/media/platform/coda/coda-common.c
@@ -25,7 +25,6 @@
 #include <linux/slab.h>
 #include <linux/videodev2.h>
 #include <linux/of.h>
-#include <linux/platform_data/media/coda.h>
 #include <linux/ratelimit.h>
 #include <linux/reset.h>
 
@@ -3102,13 +3101,6 @@ static const struct coda_devtype coda_devdata[] = {
 	},
 };
 
-static const struct platform_device_id coda_platform_ids[] = {
-	{ .name = "coda-imx27", .driver_data = CODA_IMX27 },
-	{ /* sentinel */ }
-};
-MODULE_DEVICE_TABLE(platform, coda_platform_ids);
-
-#ifdef CONFIG_OF
 static const struct of_device_id coda_dt_ids[] = {
 	{ .compatible = "fsl,imx27-vpu", .data = &coda_devdata[CODA_IMX27] },
 	{ .compatible = "fsl,imx51-vpu", .data = &coda_devdata[CODA_IMX51] },
@@ -3118,14 +3110,9 @@ static const struct of_device_id coda_dt_ids[] = {
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, coda_dt_ids);
-#endif
 
 static int coda_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *of_id =
-			of_match_device(of_match_ptr(coda_dt_ids), &pdev->dev);
-	const struct platform_device_id *pdev_id;
-	struct coda_platform_data *pdata = pdev->dev.platform_data;
 	struct device_node *np = pdev->dev.of_node;
 	struct gen_pool *pool;
 	struct coda_dev *dev;
@@ -3135,14 +3122,7 @@ static int coda_probe(struct platform_device *pdev)
 	if (!dev)
 		return -ENOMEM;
 
-	pdev_id = of_id ? of_id->data : platform_get_device_id(pdev);
-
-	if (of_id)
-		dev->devtype = of_id->data;
-	else if (pdev_id)
-		dev->devtype = &coda_devdata[pdev_id->driver_data];
-	else
-		return -EINVAL;
+	dev->devtype = of_device_get_match_data(&pdev->dev);
 
 	dev->dev = &pdev->dev;
 	dev->clk_per = devm_clk_get(&pdev->dev, "per");
@@ -3200,10 +3180,8 @@ static int coda_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	/* Get IRAM pool from device tree or platform data */
+	/* Get IRAM pool from device tree */
 	pool = of_gen_pool_get(np, "iram", 0);
-	if (!pool && pdata)
-		pool = gen_pool_get(pdata->iram_dev, NULL);
 	if (!pool) {
 		dev_err(&pdev->dev, "iram pool not available\n");
 		return -ENOMEM;
@@ -3342,7 +3320,6 @@ static struct platform_driver coda_driver = {
 		.of_match_table = of_match_ptr(coda_dt_ids),
 		.pm	= &coda_pm_ops,
 	},
-	.id_table = coda_platform_ids,
 };
 
 module_platform_driver(coda_driver);
diff --git a/include/linux/platform_data/media/coda.h b/include/linux/platform_data/media/coda.h
deleted file mode 100644
index 293b61b60c9d..000000000000
--- a/include/linux/platform_data/media/coda.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (C) 2013 Philipp Zabel, Pengutronix
- */
-#ifndef PLATFORM_CODA_H
-#define PLATFORM_CODA_H
-
-struct device;
-
-struct coda_platform_data {
-	struct device *iram_dev;
-};
-
-#endif
-- 
2.17.1

