Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54DFA2423B9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 03:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgHLBbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 21:31:55 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:22774 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbgHLBbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 21:31:39 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4BRBxh6yjWzfQ;
        Wed, 12 Aug 2020 03:31:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1597195897; bh=kiF0CpOycT2tZVHH9McmSsAvlWcdJUYf+gz4LPvBWxQ=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=LZbU9xZfq8x78Yo81hOtACa1JCH0ucPqPx5H5e/FegrMOhX8XvFJzJhUAoe/yJU27
         lPap67ecI8Vigz0sFG2KYeDrZIinwEOBoWKkaLTF8GASTV9gjykEPGDpVUXRW+65N5
         HEciKItKDv3+f4jC1povXq3HSFgOqzyePt+EcXPDFtX7P7CmwZNl7K/59DsJeui/Dy
         XWQ87SIw+KttezFbCeX6FEEdRPN3n6YWQo+/yIJ5HDI4VDBAzvho6DodlhiwWK/vof
         ACGBBN+gZXpgGkvRwGCKuF6BHdxZD+erWFdKWko6N05cdBrRHFcrCsRvDrzoLOmeys
         jATEklfTzu82Q==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Wed, 12 Aug 2020 03:31:36 +0200
Message-Id: <f5035b1b4d40745e66bacd571bbbb5e4644d21a1.1597195321.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1597195321.git.mirq-linux@rere.qmqm.pl>
References: <cover.1597195321.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 5/7] regulator: plug of_node leak in regulator_register()'s
 error path
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Vladimir Zapolskiy <vz@mleia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By calling device_initialize() earlier and noting that kfree(NULL) is
ok, we can save a bit of code in error handling and plug of_node leak.
Fixed commit already did part of the work.

Cc: stable@vger.kernel.org
Fixes: 9177514ce349 ("regulator: fix memory leak on error path of regulator_register()")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Acked-by: Vladimir Zapolskiy <vz@mleia.com>
---
 drivers/regulator/core.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 71749f48caee..448a267641df 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5137,6 +5137,7 @@ regulator_register(const struct regulator_desc *regulator_desc,
 		ret = -ENOMEM;
 		goto rinse;
 	}
+	device_initialize(&rdev->dev);
 
 	/*
 	 * Duplicate the config so the driver could override it after
@@ -5144,9 +5145,8 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	 */
 	config = kmemdup(cfg, sizeof(*cfg), GFP_KERNEL);
 	if (config == NULL) {
-		kfree(rdev);
 		ret = -ENOMEM;
-		goto rinse;
+		goto clean;
 	}
 
 	init_data = regulator_of_get_init_data(dev, regulator_desc, config,
@@ -5158,10 +5158,8 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	 * from a gpio extender or something else.
 	 */
 	if (PTR_ERR(init_data) == -EPROBE_DEFER) {
-		kfree(config);
-		kfree(rdev);
 		ret = -EPROBE_DEFER;
-		goto rinse;
+		goto clean;
 	}
 
 	/*
@@ -5214,7 +5212,6 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	}
 
 	/* register with sysfs */
-	device_initialize(&rdev->dev);
 	rdev->dev.class = &regulator_class;
 	rdev->dev.parent = dev;
 	dev_set_name(&rdev->dev, "regulator.%lu",
@@ -5292,13 +5289,11 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	mutex_lock(&regulator_list_mutex);
 	regulator_ena_gpio_free(rdev);
 	mutex_unlock(&regulator_list_mutex);
-	put_device(&rdev->dev);
-	rdev = NULL;
 clean:
 	if (dangling_of_gpiod)
 		gpiod_put(config->ena_gpiod);
-	kfree(rdev);
 	kfree(config);
+	put_device(&rdev->dev);
 rinse:
 	if (dangling_cfg_gpiod)
 		gpiod_put(cfg->ena_gpiod);
-- 
2.20.1

