Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB0BE2D69DF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 22:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405027AbgLJV27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 16:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405007AbgLJV2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 16:28:41 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3EFC0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 13:28:01 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id c14so4944556qtn.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 13:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=znkhNnIS3r1tEBD7K4eIaXfiP9kPaMqnTLtmCTJQVyA=;
        b=PqG+LASskQ3owEZLeU6mT8YTJBB81lSWuT3PwZDqx6TGDVF1FYlcBKPcZ2jgfwBfVG
         kyeff85FKMojSTeh1iCuzkhuNGEvLtxGBkjJqx00l4wVMUEIcTzNneTYh4MMUTKULkZ9
         MBVUziUkZfNJpNP5/TzxZitth4UsbM5vXVenjpRywqW8Kbtt/AVEK63VXcsEHeoxtuSg
         yA9aiTq7KKkLKakubv4WexJtcqAcDiJkZY1u8+ddMTuK1DA7Q4Tum3ExFxqns+VrZAz/
         ZnkvelZgK6vbLEpS7V12awUAlQVgvePWhc5jQvQFuv1P7jlvkm9erXiqtfRGLwaw7KTA
         3W4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=znkhNnIS3r1tEBD7K4eIaXfiP9kPaMqnTLtmCTJQVyA=;
        b=s+VBBKxpNjSH8M3XzrsBkygtJrFsmP3yt+wc9bS0h4aokowkTBiHQcOQbNXz6N0WKz
         /z87IfcUHChCYNVLsIHhnqmH5kCNWuiq0+l5ZT9/hNvq2syFDmaoelqIUGe5BDN5UOCI
         TiW3LJ/bFpMbkVqMrhyxqsJ9oPnS0Hm+cpP2frcKTSPDLtOki/q9n3GEChqXoX9ooGYT
         gRUIuCVywBr+6x+Nuklxgh2nmJ+sL3F6d8r18UYy872ljZmaEx+yJfblgxJSxt5MnoUC
         UHD59DXred7NnsmD+SYIGDlO0DZg/7zAC1iDKYbqYVhlrtyArr/CxwFygKsInRzA19Y4
         JcRQ==
X-Gm-Message-State: AOAM533WGJcr+2mx+QCBV2I9BahGy56rchPPo/jXrXEM9V2RgBfU2zp2
        stqUrIPvu3dCJLaQuVDlcZ8=
X-Google-Smtp-Source: ABdhPJwV+5sZsY/kbhi3J4upW9OpmlLm7uqlBkYrHVHuMOU5am+ZKcpV/bq80OyQnIabmvd/4N3E2w==
X-Received: by 2002:ac8:24a1:: with SMTP id s30mr11847093qts.89.1607635680417;
        Thu, 10 Dec 2020 13:28:00 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:482:a80:6086:6f67:ecaf:b184])
        by smtp.gmail.com with ESMTPSA id a11sm4640096qtd.19.2020.12.10.13.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 13:27:59 -0800 (PST)
From:   Fabio Estevam <festevam@gmail.com>
To:     broonie@kernel.org
Cc:     yibin.gong@nxp.com, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] regulator: pfuze100: Convert the driver to DT-only
Date:   Thu, 10 Dec 2020 18:27:48 -0300
Message-Id: <20201210212748.5849-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 5.10-rc1 i.MX is a devicetree-only platform, so simplify the code
by removing the unused non-DT support.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/regulator/Kconfig              |  2 +-
 drivers/regulator/pfuze100-regulator.c | 34 +-------------------------
 include/linux/regulator/pfuze100.h     |  6 -----
 3 files changed, 2 insertions(+), 40 deletions(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index cffadf8b2c37..53fa84f4d1e1 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -830,7 +830,7 @@ config REGULATOR_PF8X00
 
 config REGULATOR_PFUZE100
 	tristate "Freescale PFUZE100/200/3000/3001 regulator driver"
-	depends on I2C
+	depends on I2C && OF
 	select REGMAP_I2C
 	help
 	  Say y here to support the regulators found on the Freescale
diff --git a/drivers/regulator/pfuze100-regulator.c b/drivers/regulator/pfuze100-regulator.c
index 01a12cfcea7c..d60d7d1b7fa2 100644
--- a/drivers/regulator/pfuze100-regulator.c
+++ b/drivers/regulator/pfuze100-regulator.c
@@ -105,15 +105,6 @@ static const int pfuze3000_sw2hi[] = {
 	2500000, 2800000, 2850000, 3000000, 3100000, 3150000, 3200000, 3300000,
 };
 
-static const struct i2c_device_id pfuze_device_id[] = {
-	{.name = "pfuze100", .driver_data = PFUZE100},
-	{.name = "pfuze200", .driver_data = PFUZE200},
-	{.name = "pfuze3000", .driver_data = PFUZE3000},
-	{.name = "pfuze3001", .driver_data = PFUZE3001},
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, pfuze_device_id);
-
 static const struct of_device_id pfuze_dt_ids[] = {
 	{ .compatible = "fsl,pfuze100", .data = (void *)PFUZE100},
 	{ .compatible = "fsl,pfuze200", .data = (void *)PFUZE200},
@@ -440,7 +431,6 @@ static struct pfuze_regulator pfuze3001_regulators[] = {
 	PFUZE100_VGEN_REG(PFUZE3001, VLDO4, PFUZE100_VGEN6VOL, 1800000, 3300000, 100000),
 };
 
-#ifdef CONFIG_OF
 /* PFUZE100 */
 static struct of_regulator_match pfuze100_matches[] = {
 	{ .name = "sw1ab",	},
@@ -578,22 +568,6 @@ static inline struct device_node *match_of_node(int index)
 {
 	return pfuze_matches[index].of_node;
 }
-#else
-static int pfuze_parse_regulators_dt(struct pfuze_chip *chip)
-{
-	return 0;
-}
-
-static inline struct regulator_init_data *match_init_data(int index)
-{
-	return NULL;
-}
-
-static inline struct device_node *match_of_node(int index)
-{
-	return NULL;
-}
-#endif
 
 static struct pfuze_chip *syspm_pfuze_chip;
 
@@ -708,8 +682,6 @@ static int pfuze100_regulator_probe(struct i2c_client *client,
 				    const struct i2c_device_id *id)
 {
 	struct pfuze_chip *pfuze_chip;
-	struct pfuze_regulator_platform_data *pdata =
-	    dev_get_platdata(&client->dev);
 	struct regulator_config config = { };
 	int i, ret;
 	const struct of_device_id *match;
@@ -802,10 +774,7 @@ static int pfuze100_regulator_probe(struct i2c_client *client,
 
 		desc = &pfuze_chip->regulator_descs[i].desc;
 
-		if (pdata)
-			init_data = pdata->init_data[i];
-		else
-			init_data = match_init_data(i);
+		init_data = match_init_data(i);
 
 		/* SW2~SW4 high bit check and modify the voltage value table */
 		if (i >= sw_check_start && i <= sw_check_end) {
@@ -879,7 +848,6 @@ static int pfuze100_regulator_remove(struct i2c_client *client)
 }
 
 static struct i2c_driver pfuze_driver = {
-	.id_table = pfuze_device_id,
 	.driver = {
 		.name = "pfuze100-regulator",
 		.of_match_table = pfuze_dt_ids,
diff --git a/include/linux/regulator/pfuze100.h b/include/linux/regulator/pfuze100.h
index d47e668d9ca8..c964fe8ab698 100644
--- a/include/linux/regulator/pfuze100.h
+++ b/include/linux/regulator/pfuze100.h
@@ -63,10 +63,4 @@
 #define PFUZE3001_VLDO3		8
 #define PFUZE3001_VLDO4		9
 
-struct regulator_init_data;
-
-struct pfuze_regulator_platform_data {
-	struct regulator_init_data *init_data[PFUZE100_MAX_REGULATOR];
-};
-
 #endif /* __LINUX_REG_PFUZE100_H */
-- 
2.17.1

