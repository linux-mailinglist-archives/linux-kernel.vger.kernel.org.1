Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C75273F7F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 12:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgIVKVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 06:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgIVKU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 06:20:59 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBDEC061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 03:20:59 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id k8so12022247pfk.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 03:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0+hwdde/9osqDF4pD01phKptpQ7KgGy01PbwrfMbdCM=;
        b=bKqRy+LMO/iDA+ahSlPvzSOBVAQB97uaBDJQoZXGrt+YTZggvFK5tyd+KIBtSeHHos
         CIwObu4GZ0j/tV4sb4Vg3YItVql6zVRP+lshGWLXGSFzs6DG7D0gpIX3HyhCHCazSsjq
         qaVo9jSnbYVcY2NEqG7YYwWiTs4uLyS3cgkxo1rSPDeeOrdAVAxc1603Yuz8PUatXLav
         D/PvwWkzoTTNbl1MX183QEJ15dFANxyS+GvLy+HQzcxD0JS25Biw0Lp6uIFjGnxXNcDa
         OZbVN73+6AcJmOl8ZQgpeGezeonxNu0muPpfuVc3IKo5LbFJyN2r1bwn9VEO+zbFgFkY
         /03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0+hwdde/9osqDF4pD01phKptpQ7KgGy01PbwrfMbdCM=;
        b=eNQt5K08co3d2NxCF2OmiTpoXRXtul4guCSs+YNgYCUQN7xNq/dZQQs2ujlRuzKgQ4
         3sJSisvNnzb3TEXhi2kg1L7ZdJNGGdPbEVTt3NSsQT2ORqPbBnsBLXxmO4YHtRlz/nPU
         13LP9qXllCPwFV2Pf49PrexyoRQIaNaiRwG0q1AqEXpn3DAX46TcLQbwEyrCFdLUG10f
         VLYtrhBoRJ31dx0DkKb7oZeo+xPJ9hC3tzTlhiRAbLj0seIyK+rRraHXc1f4Yu/GpG5x
         uGGIiIG3t0ZqsyF75JIHjMaM4tCFEdEtuiGVJvyIS5em8I+85T3VoIr0eSow7vJ3SUdK
         MYbA==
X-Gm-Message-State: AOAM532UHjlWrwbdV9M2cMw/iTRGpwe9RRyVAdMPKm8akTw5ZWbkIiaU
        ENCR++95m/5QgQ5LxyKsZ98=
X-Google-Smtp-Source: ABdhPJywg1ZPRerJN+Bl7Givl4CzGRtlOJxgL96O7QNDYzm6gINGKxSTwe8zIdew4lefJIdzGQ9qOA==
X-Received: by 2002:aa7:8ede:0:b029:13e:d13d:a053 with SMTP id b30-20020aa78ede0000b029013ed13da053mr3426165pfr.25.1600770058961;
        Tue, 22 Sep 2020 03:20:58 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:489:56d9:501b:f524:c013:2733])
        by smtp.gmail.com with ESMTPSA id a15sm14859037pfi.119.2020.09.22.03.20.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Sep 2020 03:20:58 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: [PATCH v5 05/10] mfd: mt6360: Rename mt6360_pmu_data by mt6360_ddata
Date:   Tue, 22 Sep 2020 18:20:13 +0800
Message-Id: <1600770019-11585-6-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600770019-11585-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1600770019-11585-1-git-send-email-gene.chen.richtek@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Rename mt6360_pmu_data by mt6360_ddata because of including
not only PMU part, but also entire MT6360 IC.

Signed-off-by: Gene Chen <gene_chen@richtek.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/mt6360-core.c  | 44 ++++++++++++++++++++++----------------------
 include/linux/mfd/mt6360.h |  2 +-
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index 5119e51..332eb5d 100644
--- a/drivers/mfd/mt6360-core.c
+++ b/drivers/mfd/mt6360-core.c
@@ -210,9 +210,9 @@ static const struct regmap_irq mt6360_pmu_irqs[] =  {
 
 static int mt6360_pmu_handle_post_irq(void *irq_drv_data)
 {
-	struct mt6360_pmu_data *mpd = irq_drv_data;
+	struct mt6360_ddata *ddata = irq_drv_data;
 
-	return regmap_update_bits(mpd->regmap,
+	return regmap_update_bits(ddata->regmap,
 		MT6360_PMU_IRQ_SET, MT6360_IRQ_RETRIG, MT6360_IRQ_RETRIG);
 }
 
@@ -310,61 +310,61 @@ static const unsigned short mt6360_slave_addr[MT6360_SLAVE_MAX] = {
 
 static int mt6360_pmu_probe(struct i2c_client *client)
 {
-	struct mt6360_pmu_data *mpd;
+	struct mt6360_ddata *ddata;
 	unsigned int reg_data;
 	int i, ret;
 
-	mpd = devm_kzalloc(&client->dev, sizeof(*mpd), GFP_KERNEL);
-	if (!mpd)
+	ddata = devm_kzalloc(&client->dev, sizeof(*ddata), GFP_KERNEL);
+	if (!ddata)
 		return -ENOMEM;
 
-	mpd->dev = &client->dev;
-	i2c_set_clientdata(client, mpd);
+	ddata->dev = &client->dev;
+	i2c_set_clientdata(client, ddata);
 
-	mpd->regmap = devm_regmap_init_i2c(client, &mt6360_pmu_regmap_config);
-	if (IS_ERR(mpd->regmap)) {
+	ddata->regmap = devm_regmap_init_i2c(client, &mt6360_pmu_regmap_config);
+	if (IS_ERR(ddata->regmap)) {
 		dev_err(&client->dev, "Failed to register regmap\n");
-		return PTR_ERR(mpd->regmap);
+		return PTR_ERR(ddata->regmap);
 	}
 
-	ret = regmap_read(mpd->regmap, MT6360_PMU_DEV_INFO, &reg_data);
+	ret = regmap_read(ddata->regmap, MT6360_PMU_DEV_INFO, &reg_data);
 	if (ret) {
 		dev_err(&client->dev, "Device not found\n");
 		return ret;
 	}
 
-	mpd->chip_rev = reg_data & CHIP_REV_MASK;
-	if (mpd->chip_rev != CHIP_VEN_MT6360) {
+	ddata->chip_rev = reg_data & CHIP_REV_MASK;
+	if (ddata->chip_rev != CHIP_VEN_MT6360) {
 		dev_err(&client->dev, "Device not supported\n");
 		return -ENODEV;
 	}
 
-	mt6360_pmu_irq_chip.irq_drv_data = mpd;
-	ret = devm_regmap_add_irq_chip(&client->dev, mpd->regmap, client->irq,
+	mt6360_pmu_irq_chip.irq_drv_data = ddata;
+	ret = devm_regmap_add_irq_chip(&client->dev, ddata->regmap, client->irq,
 				       IRQF_TRIGGER_FALLING, 0,
-				       &mt6360_pmu_irq_chip, &mpd->irq_data);
+				       &mt6360_pmu_irq_chip, &ddata->irq_data);
 	if (ret) {
 		dev_err(&client->dev, "Failed to add Regmap IRQ Chip\n");
 		return ret;
 	}
 
-	mpd->i2c[0] = client;
+	ddata->i2c[0] = client;
 	for (i = 1; i < MT6360_SLAVE_MAX; i++) {
-		mpd->i2c[i] = devm_i2c_new_dummy_device(&client->dev,
+		ddata->i2c[i] = devm_i2c_new_dummy_device(&client->dev,
 							client->adapter,
 							mt6360_slave_addr[i]);
-		if (IS_ERR(mpd->i2c[i])) {
+		if (IS_ERR(ddata->i2c[i])) {
 			dev_err(&client->dev,
 				"Failed to get new dummy I2C device for address 0x%x",
 				mt6360_slave_addr[i]);
-			return PTR_ERR(mpd->i2c[i]);
+			return PTR_ERR(ddata->i2c[i]);
 		}
-		i2c_set_clientdata(mpd->i2c[i], mpd);
+		i2c_set_clientdata(ddata->i2c[i], ddata);
 	}
 
 	ret = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_AUTO,
 				   mt6360_devs, ARRAY_SIZE(mt6360_devs), NULL,
-				   0, regmap_irq_get_domain(mpd->irq_data));
+				   0, regmap_irq_get_domain(ddata->irq_data));
 	if (ret) {
 		dev_err(&client->dev,
 			"Failed to register subordinate devices\n");
diff --git a/include/linux/mfd/mt6360.h b/include/linux/mfd/mt6360.h
index 72edf13..81bca7c 100644
--- a/include/linux/mfd/mt6360.h
+++ b/include/linux/mfd/mt6360.h
@@ -21,7 +21,7 @@ enum {
 #define MT6360_LDO_SLAVEID	0x64
 #define MT6360_TCPC_SLAVEID	0x4E
 
-struct mt6360_pmu_data {
+struct mt6360_ddata {
 	struct i2c_client *i2c[MT6360_SLAVE_MAX];
 	struct device *dev;
 	struct regmap *regmap;
-- 
2.7.4

