Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9F6273F82
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 12:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgIVKVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 06:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgIVKVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 06:21:08 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33119C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 03:21:08 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id b124so11982394pfg.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 03:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sie6Ok4mlr9HWDpV1MC03OrgT3qnjwcXYjtFoY6fZME=;
        b=otWeUcTKx/UNzKWUeg61Z1E3NrT6TBCSkXl028uvXKJgQlGgBuyTzj5hl6sMqm5VfZ
         KdWZ7nKpPZODjsNDVRS5dTwfT39V3q8QVX5WKkTdO4rXPoDowZ4jNdunjSPjXU52xvD5
         sMgHrfwwiT9RilnqQ3J64qwdb0TPkrUej6DbqoQeUx06QevcqsFmftcT+VhMM1v5IiVa
         QagqXSP68aVaxv2rMNccMKn/8RDTMbit7aF3V/Lg8fuGxP3pjPSZqDht1Ah4oPG1N/wQ
         FqJ+z/GfGGnYnQFxLPDF6VrzpBuNOtQ3FWo9jMw74oOfI5O5gqmh9cv8hA7F8mYRz2Tq
         aENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sie6Ok4mlr9HWDpV1MC03OrgT3qnjwcXYjtFoY6fZME=;
        b=O7gHApLgQdbDJEyYgtOgMtfvmPgSn3SRKW1pV19Kr+vS3xixNzePXsLd6X9MvnmKtI
         S2AQ5pTVu1JTsJ/zHzGGBbRhHTwULwXh0XZa47CSpPzJTJAVpOYd4QO3+/txwjxBo2u2
         PUhu/NeRPqQTG70FYmcVM6/EhoiUvLs/U6xAZ1IFaGEabu2yiBO6avV8gkWCTNqHYs+e
         OSblAJ/4/OD/AYhJIzzGL9WF/f10w5MPPHfA5Ow8zbM1fAICuhVqabhPjFIKCP7T2Gc3
         IjJxY/pO+uACVVn4IcstKyst+v5s8ysjnzXj+orSx7ZIud4hOol5xtOHk+evv7UOk0AH
         Ot/w==
X-Gm-Message-State: AOAM5310Bg2jdnyTTc+k9VH1pFJzzhoDdmVgZvg7+IIUcSRsVUvNCzjD
        rg3A7B+QDQGlBJzW9LeafvI=
X-Google-Smtp-Source: ABdhPJwlWzhfwcTkd1VFhdbJOI3bAObjg7ROqG6ZjIFUUt6R2kwuwErRy8IOpI0g2eZOuukSte2leg==
X-Received: by 2002:a65:5881:: with SMTP id d1mr2959406pgu.193.1600770067727;
        Tue, 22 Sep 2020 03:21:07 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:489:56d9:501b:f524:c013:2733])
        by smtp.gmail.com with ESMTPSA id a15sm14859037pfi.119.2020.09.22.03.21.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Sep 2020 03:21:07 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: [PATCH v5 07/10] mfd: mt6360: Remove handle_post_irq callback function
Date:   Tue, 22 Sep 2020 18:20:15 +0800
Message-Id: <1600770019-11585-8-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600770019-11585-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1600770019-11585-1-git-send-email-gene.chen.richtek@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Remove handle_post_irq which is used to retrigger IRQ.
Set IRQ level low trigger in dtsi to keep IRQ always be handled.

Signed-off-by: Gene Chen <gene_chen@richtek.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/mt6360-core.c  | 17 ++++-------------
 include/linux/mfd/mt6360.h |  2 +-
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index f75122b..2356d99 100644
--- a/drivers/mfd/mt6360-core.c
+++ b/drivers/mfd/mt6360-core.c
@@ -208,15 +208,8 @@ static const struct regmap_irq mt6360_irqs[] =  {
 	REGMAP_IRQ_REG_LINE(MT6360_LDO7_PGB_EVT, 8),
 };
 
-static int mt6360_pmu_handle_post_irq(void *irq_drv_data)
-{
-	struct mt6360_ddata *ddata = irq_drv_data;
-
-	return regmap_update_bits(ddata->regmap,
-		MT6360_PMU_IRQ_SET, MT6360_IRQ_RETRIG, MT6360_IRQ_RETRIG);
-}
-
-static struct regmap_irq_chip mt6360_irq_chip = {
+static const struct regmap_irq_chip mt6360_irq_chip = {
+	.name = "mt6360_irqs",
 	.irqs = mt6360_irqs,
 	.num_irqs = ARRAY_SIZE(mt6360_irqs),
 	.num_regs = MT6360_PMU_IRQ_REGNUM,
@@ -225,7 +218,6 @@ static struct regmap_irq_chip mt6360_irq_chip = {
 	.ack_base = MT6360_PMU_CHG_IRQ1,
 	.init_ack_masked = true,
 	.use_ack = true,
-	.handle_post_irq = mt6360_pmu_handle_post_irq,
 };
 
 static const struct regmap_config mt6360_pmu_regmap_config = {
@@ -339,10 +331,9 @@ static int mt6360_probe(struct i2c_client *client)
 		return -ENODEV;
 	}
 
-	mt6360_irq_chip.irq_drv_data = ddata;
 	ret = devm_regmap_add_irq_chip(&client->dev, ddata->regmap, client->irq,
-				       IRQF_TRIGGER_FALLING, 0,
-				       &mt6360_irq_chip, &ddata->irq_data);
+				       0, 0, &mt6360_irq_chip,
+				       &ddata->irq_data);
 	if (ret) {
 		dev_err(&client->dev, "Failed to add Regmap IRQ Chip\n");
 		return ret;
diff --git a/include/linux/mfd/mt6360.h b/include/linux/mfd/mt6360.h
index 81bca7c..ef8257d 100644
--- a/include/linux/mfd/mt6360.h
+++ b/include/linux/mfd/mt6360.h
@@ -230,7 +230,7 @@ struct mt6360_ddata {
 #define MT6360_PMU_MAXREG			MT6360_PMU_LDO_MASK2
 
 /* MT6360_PMU_IRQ_SET */
-#define MT6360_PMU_IRQ_REGNUM	(MT6360_PMU_LDO_IRQ2 - MT6360_PMU_CHG_IRQ1 + 1)
+#define MT6360_PMU_IRQ_REGNUM	16
 #define MT6360_IRQ_RETRIG	BIT(2)
 
 #define CHIP_VEN_MASK				0xF0
-- 
2.7.4

