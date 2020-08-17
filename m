Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C06F72464C9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 12:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgHQKtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 06:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbgHQKs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 06:48:58 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4877CC061345
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 03:48:58 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id e4so7641225pjd.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 03:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kmywJl/aDPZ8Djl80CkqitFsv9eXGzrnwpaDbuS6TqE=;
        b=VhTYIUiZazs/3aCichIfi5PlWg0lrfmDf4ySM34Dt/dNpDGcqo0FlhiSMf3OwpirTu
         L7M2dLXZVtUwyiCbE2rXXYqeBLaUjkEETdtuskqEBJE03oigwRbgt3Gx3uPzcGzbAzCV
         SqAN/XZwKH4I3Aq6mQK77NjGpTYrwwlsJ8+yHrYWidTmqOarnPnkW8T3PzCtZ/nIMnuS
         cnjdfNMNJkBRjec/gytfd/Dp1CZpz3HrpAnSNvaKIBaooz3G3mplYE9Ef3Lr8+NBIPce
         WkidKGQ9TEGvQnVtAbbloHIMzKTFLJhxh66Wj7fbfip+Whk8rBKz8gmGHi5nTioIoiPb
         AdTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kmywJl/aDPZ8Djl80CkqitFsv9eXGzrnwpaDbuS6TqE=;
        b=gHt9qD46h4jOWnHtmDHX7+G8w3ctEqTMUYxBmMUSrquY0HU76qO9tpNKkJmAa5fWK+
         /99QIUQJ8fe/+wc5VYGZkfA4rWmyrbqTlR2XLnkxeewl/YCi7BcZvnBgy0eeqA8MegQ6
         kXDh2qzVZGEL/Y0vIYFaLbIr8H5XsRj4YhObGhItuZ65oYSb8yKg3q6aDmmRMT5w3/C2
         qm/EBOTmQ3P4/dNiaZtGqicV287VzlWMMUsuJisdTnSIwSivyNXvCYg0q5YIDbFDUXbs
         s5z11TFFxKjIVkZJz/s6jfvhInbTqMBkmXVR4WQqPgNKlVodUGfRGD2vWF5UqOFIj7Xa
         1WDA==
X-Gm-Message-State: AOAM533KcjtTLWh1lh0zMteN/yQn4toI6SOQK/Gjb1+qBmcLWUqAVKnB
        SWx9QVwFNF/KYONeGUNcjzI=
X-Google-Smtp-Source: ABdhPJyIZl9m0K3LnTtpxEZag1sbrl5jluGOy5JEr/5ZhNW/oUqhEVDXyO8zUv4eaUWujF8HAXoBcg==
X-Received: by 2002:a17:902:16a:: with SMTP id 97mr10872177plb.207.1597661337694;
        Mon, 17 Aug 2020 03:48:57 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:577:c217:67e6:a40c:a3bf:1945])
        by smtp.gmail.com with ESMTPSA id k12sm16976528pjp.38.2020.08.17.03.48.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Aug 2020 03:48:57 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, benjamin.chao@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: [PATCH v4 6/9] mfd: mt6360: Rename mt6360_pmu by mt6360
Date:   Mon, 17 Aug 2020 18:47:54 +0800
Message-Id: <1597661277-27862-7-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597661277-27862-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1597661277-27862-1-git-send-email-gene.chen.richtek@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Rename mt6360_pmu by mt6360, because of including
not only PMU part, but also entire MT6360 IC

Signed-off-by: Gene Chen <gene_chen@richtek.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/mt6360-core.c | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index 332eb5d..f75122b 100644
--- a/drivers/mfd/mt6360-core.c
+++ b/drivers/mfd/mt6360-core.c
@@ -119,7 +119,7 @@
 #define MT6360_LDO6_PGB_EVT		126
 #define MT6360_LDO7_PGB_EVT		127
 
-static const struct regmap_irq mt6360_pmu_irqs[] =  {
+static const struct regmap_irq mt6360_irqs[] =  {
 	REGMAP_IRQ_REG_LINE(MT6360_CHG_TREG_EVT, 8),
 	REGMAP_IRQ_REG_LINE(MT6360_CHG_AICR_EVT, 8),
 	REGMAP_IRQ_REG_LINE(MT6360_CHG_MIVR_EVT, 8),
@@ -216,9 +216,9 @@ static int mt6360_pmu_handle_post_irq(void *irq_drv_data)
 		MT6360_PMU_IRQ_SET, MT6360_IRQ_RETRIG, MT6360_IRQ_RETRIG);
 }
 
-static struct regmap_irq_chip mt6360_pmu_irq_chip = {
-	.irqs = mt6360_pmu_irqs,
-	.num_irqs = ARRAY_SIZE(mt6360_pmu_irqs),
+static struct regmap_irq_chip mt6360_irq_chip = {
+	.irqs = mt6360_irqs,
+	.num_irqs = ARRAY_SIZE(mt6360_irqs),
 	.num_regs = MT6360_PMU_IRQ_REGNUM,
 	.mask_base = MT6360_PMU_CHG_MASK1,
 	.status_base = MT6360_PMU_CHG_IRQ1,
@@ -308,7 +308,7 @@ static const unsigned short mt6360_slave_addr[MT6360_SLAVE_MAX] = {
 	MT6360_TCPC_SLAVEID,
 };
 
-static int mt6360_pmu_probe(struct i2c_client *client)
+static int mt6360_probe(struct i2c_client *client)
 {
 	struct mt6360_ddata *ddata;
 	unsigned int reg_data;
@@ -339,10 +339,10 @@ static int mt6360_pmu_probe(struct i2c_client *client)
 		return -ENODEV;
 	}
 
-	mt6360_pmu_irq_chip.irq_drv_data = ddata;
+	mt6360_irq_chip.irq_drv_data = ddata;
 	ret = devm_regmap_add_irq_chip(&client->dev, ddata->regmap, client->irq,
 				       IRQF_TRIGGER_FALLING, 0,
-				       &mt6360_pmu_irq_chip, &ddata->irq_data);
+				       &mt6360_irq_chip, &ddata->irq_data);
 	if (ret) {
 		dev_err(&client->dev, "Failed to add Regmap IRQ Chip\n");
 		return ret;
@@ -374,7 +374,7 @@ static int mt6360_pmu_probe(struct i2c_client *client)
 	return 0;
 }
 
-static int __maybe_unused mt6360_pmu_suspend(struct device *dev)
+static int __maybe_unused mt6360_suspend(struct device *dev)
 {
 	struct i2c_client *i2c = to_i2c_client(dev);
 
@@ -384,7 +384,7 @@ static int __maybe_unused mt6360_pmu_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused mt6360_pmu_resume(struct device *dev)
+static int __maybe_unused mt6360_resume(struct device *dev)
 {
 
 	struct i2c_client *i2c = to_i2c_client(dev);
@@ -395,25 +395,24 @@ static int __maybe_unused mt6360_pmu_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(mt6360_pmu_pm_ops,
-			 mt6360_pmu_suspend, mt6360_pmu_resume);
+static SIMPLE_DEV_PM_OPS(mt6360_pm_ops, mt6360_suspend, mt6360_resume);
 
-static const struct of_device_id __maybe_unused mt6360_pmu_of_id[] = {
-	{ .compatible = "mediatek,mt6360_pmu", },
+static const struct of_device_id __maybe_unused mt6360_of_id[] = {
+	{ .compatible = "mediatek,mt6360", },
 	{},
 };
-MODULE_DEVICE_TABLE(of, mt6360_pmu_of_id);
+MODULE_DEVICE_TABLE(of, mt6360_of_id);
 
-static struct i2c_driver mt6360_pmu_driver = {
+static struct i2c_driver mt6360_driver = {
 	.driver = {
-		.name = "mt6360_pmu",
-		.pm = &mt6360_pmu_pm_ops,
-		.of_match_table = of_match_ptr(mt6360_pmu_of_id),
+		.name = "mt6360",
+		.pm = &mt6360_pm_ops,
+		.of_match_table = of_match_ptr(mt6360_of_id),
 	},
-	.probe_new = mt6360_pmu_probe,
+	.probe_new = mt6360_probe,
 };
-module_i2c_driver(mt6360_pmu_driver);
+module_i2c_driver(mt6360_driver);
 
 MODULE_AUTHOR("Gene Chen <gene_chen@richtek.com>");
-MODULE_DESCRIPTION("MT6360 PMU I2C Driver");
+MODULE_DESCRIPTION("MT6360 I2C Driver");
 MODULE_LICENSE("GPL v2");
-- 
2.7.4

