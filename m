Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4D94273F80
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 12:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgIVKVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 06:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgIVKVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 06:21:04 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CE0C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 03:21:03 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id f18so12003480pfa.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 03:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kmywJl/aDPZ8Djl80CkqitFsv9eXGzrnwpaDbuS6TqE=;
        b=mI662irKaxFvEueeJdbsdIG7iwm29QZNcXoS3egwQZFtKbCscVYzzikwea2PDAxTNp
         kT7ey1IZ4almugKtcPPe1sZhLHZkC1rOTuBNFGYbOjGUJj9EOY9eJHo0oBCOCpLOBxyw
         5UaPNrc3H1BC4uyqQLNmjbidvBmMo+8334cBNDEgoWGr7rSkScnOYxjzuOcDm2Y88c+y
         RUhXPithN/4vQd2n0KkfgL2bhBrf1T7Mg1pBetVG4zHQ5Odn5A8wYhO9Ukzls931fVto
         6hNVk8xw6qr60SLAOtpk/z7xiyprdpttlFbdAISBBI7rTZz/2lz/l9WF/ShWYcIFPuYT
         aJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kmywJl/aDPZ8Djl80CkqitFsv9eXGzrnwpaDbuS6TqE=;
        b=s4OMyMbb80LS79PX+vnawBC6pqkGwAQiHIHgwlzalQNbMXJFF7w/A6UVu/ory5OBwZ
         HrgU7KC/wV3dnQGN85e/a6Y/LAsmAziKhQdemEwj4icbEjLmuxfxevhkoqTYKXpi/AXe
         GVX+xd15Wt/4zpeCI7zh9cO3uut5GgpyOV0P/WupBK5tG6mwQlBM8ycxIJaryyAPO3sv
         UjZTXa+5AaIhu4Mpw1lvJvxe3wIfVaaPs5sxA4dxI1v/DonFNor8VCEc9RqmrL8fX45g
         i0CubhlEAuO8biSnSkLzA2HZjNYXGQphxkFqXE2U/Eu73DQr9GVpTk8npnwnC9nc+QhY
         aDkw==
X-Gm-Message-State: AOAM532SFXGhTmnW1AAi6uOHo8UMVAotiydj0cmu1llzY9zKQ+SgC5Mo
        8+wgvh7KvPGTKhUfGB0mprk=
X-Google-Smtp-Source: ABdhPJzqmoH+ygHv96fg9FV11x+5pVn8jXcAYhzyyoCk/HXS1UxfR1+lR4V1FFPrZMwvNjWEKNylHQ==
X-Received: by 2002:a17:902:eeca:b029:d2:1d73:46ba with SMTP id h10-20020a170902eecab02900d21d7346bamr3925814plb.28.1600770063340;
        Tue, 22 Sep 2020 03:21:03 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:489:56d9:501b:f524:c013:2733])
        by smtp.gmail.com with ESMTPSA id a15sm14859037pfi.119.2020.09.22.03.20.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Sep 2020 03:21:02 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: [PATCH v5 06/10] mfd: mt6360: Rename mt6360_pmu by mt6360
Date:   Tue, 22 Sep 2020 18:20:14 +0800
Message-Id: <1600770019-11585-7-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600770019-11585-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1600770019-11585-1-git-send-email-gene.chen.richtek@gmail.com>
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

