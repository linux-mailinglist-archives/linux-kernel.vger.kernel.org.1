Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7FB2F953F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 21:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730337AbhAQUuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 15:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbhAQUuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 15:50:00 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C415C061573
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 12:49:20 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id n6so265010edt.10
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 12:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=message-id:subject:from:reply-to:to:cc:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=43wUehoRm238nThD1O76f+iMIDwiavu4bsnfwU9oTGs=;
        b=HbI6PSu8ACdceUPVxDLUVcASE9QwDibTTmh1Bch+XC0pE+2w5i/VJvg/baE51W09f6
         XiL92CSK2FPiblUIM32AWFEt7nz7Ef26C/uKOc50sSlX4KxVwJO4v/kOREIvTrKrY+OM
         riaeURcwkdBUV0e3YVhXKq6i+taie12qzlnyGsZCOiuRiReI2ysTqqwmZS1IaEIXwX8z
         HEHo2FJIeq8+j3RTUT4wZzoAFTdhuWBNNjAb9dSZy51nLXOukLiQ5WtjKJ/hs7EgYT/f
         B+YB4mOh++iEQOfH5SL9Xsdd2pTh1RSQ7bDBCiKhB6fHCycAecXRiM0Tz5atKTNrOeyD
         A8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :user-agent:mime-version:content-transfer-encoding;
        bh=43wUehoRm238nThD1O76f+iMIDwiavu4bsnfwU9oTGs=;
        b=mb34oMbXJr6+YbzT1bzuYduqFhUBlTH13Jaf7xbmUz3Tf2yxadNRaEH+pooQfUpxNI
         TaMBcacw6ZANesWxo6Gwyt26SDAkpfv5sSVTbDFzwKRF6dPsBcoR1Y1txfSg8ljbqzri
         g/FJJxQX4YFS+QnUTDBiFpS2wopzTXk+5hgQ62Sx/+TlOqaidvCQ4BBhufvuOC06aksX
         nlyXbImgvN9XkP8+z5EXg3d9X3TiiQhT8C9ueb9i9UWHFj9guGUmGIjYHoXGXMN0q09n
         l+2BMYwHgQU/4PfPUCE65+P6NJZpy4BgEsq3mxJvSod0UEnn6MtQ7sphkfjtPVmPkFRH
         sFuA==
X-Gm-Message-State: AOAM530149AsIPg10SeHCywOs9sxMVL/Xk5bLig1yC7mW0pG3Q9B1+yb
        nihzgGCCaihW3Ccojl39o7hW/u74DVAPDA==
X-Google-Smtp-Source: ABdhPJxvCHtFfKcPSepu6zyoPU9ItyXzii86aERbtUYOMKl1KNjA38fAM+B4ARHooFAjwReAYMGqmg==
X-Received: by 2002:aa7:cdc3:: with SMTP id h3mr16698530edw.52.1610916559030;
        Sun, 17 Jan 2021 12:49:19 -0800 (PST)
Received: from mars.fritz.box ([2a02:8070:b9d:f200:6139:400d:8db4:21a5])
        by smtp.gmail.com with ESMTPSA id h12sm9087784edb.16.2021.01.17.12.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 12:49:18 -0800 (PST)
Message-ID: <4c2e79d4fa96befdc9a6c59c3ff27b0a34f9fb56.camel@googlemail.com>
Subject: [PATCH] regulator: pf8x00: Add suspend support
From:   Christoph Fritz <chf.fritz@googlemail.com>
Reply-To: chf.fritz@googlemail.com
To:     Mark Brown <broonie@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     Adrien Grassein <adrien.grassein@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sun, 17 Jan 2021 21:49:17 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds suspend/resume support so that it is possible to
configure the LDOs and BUCKs as on or off during suspend phase as
well as to configure suspend specific voltages.

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 drivers/regulator/pf8x00-regulator.c | 75 ++++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/pf8x00-regulator.c b/drivers/regulator/pf8x00-regulator.c
index 1e5582d73405..02892e04acce 100644
--- a/drivers/regulator/pf8x00-regulator.c
+++ b/drivers/regulator/pf8x00-regulator.c
@@ -125,8 +125,12 @@ enum pf8x00_devid {
 #define PF8X00_DEVICE_FAM_MASK		GENMASK(7, 4)
 #define PF8X00_DEVICE_ID_MASK		GENMASK(3, 0)
 
-struct pf8x00_regulator {
+struct pf8x00_regulator_data {
 	struct regulator_desc desc;
+	unsigned int suspend_enable_reg;
+	unsigned int suspend_enable_mask;
+	unsigned int suspend_voltage_reg;
+	unsigned int suspend_voltage_cache;
 };
 
 struct pf8x00_chip {
@@ -276,6 +280,53 @@ static int pf8x00_of_parse_cb(struct device_node *np,
 	return 0;
 }
 
+static int pf8x00_suspend_enable(struct regulator_dev *rdev)
+{
+	struct pf8x00_regulator_data *regl = rdev_get_drvdata(rdev);
+	struct regmap *rmap = rdev_get_regmap(rdev);
+
+	return regmap_update_bits(rmap, regl->suspend_enable_reg,
+				  regl->suspend_enable_mask,
+				  regl->suspend_enable_mask);
+}
+
+static int pf8x00_suspend_disable(struct regulator_dev *rdev)
+{
+	struct pf8x00_regulator_data *regl = rdev_get_drvdata(rdev);
+	struct regmap *rmap = rdev_get_regmap(rdev);
+
+	return regmap_update_bits(rmap, regl->suspend_enable_reg,
+				  regl->suspend_enable_mask, 0);
+}
+
+static int pf8x00_set_suspend_voltage(struct regulator_dev *rdev, int uV)
+{
+	struct pf8x00_regulator_data *regl = rdev_get_drvdata(rdev);
+	int ret;
+
+	if (regl->suspend_voltage_cache == uV)
+		return 0;
+
+	ret = regulator_map_voltage_iterate(rdev, uV, uV);
+	if (ret < 0) {
+		dev_err(rdev_get_dev(rdev), "failed to map %i uV\n", uV);
+		return ret;
+	}
+
+	dev_dbg(rdev_get_dev(rdev), "uV: %i, reg: 0x%x, msk: 0x%x, val: 0x%x\n",
+		uV, regl->suspend_voltage_reg, regl->desc.vsel_mask, ret);
+	ret = regmap_update_bits(rdev->regmap, regl->suspend_voltage_reg,
+				 regl->desc.vsel_mask, ret);
+	if (ret < 0) {
+		dev_err(rdev_get_dev(rdev), "failed to set %i uV\n", uV);
+		return ret;
+	}
+
+	regl->suspend_voltage_cache = uV;
+
+	return 0;
+}
+
 static const struct regulator_ops pf8x00_ldo_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
@@ -283,6 +334,9 @@ static const struct regulator_ops pf8x00_ldo_ops = {
 	.list_voltage = regulator_list_voltage_table,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_suspend_enable = pf8x00_suspend_enable,
+	.set_suspend_disable = pf8x00_suspend_disable,
+	.set_suspend_voltage = pf8x00_set_suspend_voltage,
 };
 
 
@@ -295,6 +349,9 @@ static const struct regulator_ops pf8x00_buck1_6_ops = {
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.get_current_limit = regulator_get_current_limit_regmap,
 	.set_current_limit = regulator_set_current_limit_regmap,
+	.set_suspend_enable = pf8x00_suspend_enable,
+	.set_suspend_disable = pf8x00_suspend_disable,
+	.set_suspend_voltage = pf8x00_set_suspend_voltage,
 };
 
 static const struct regulator_ops pf8x00_buck7_ops = {
@@ -306,6 +363,8 @@ static const struct regulator_ops pf8x00_buck7_ops = {
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.get_current_limit = regulator_get_current_limit_regmap,
 	.set_current_limit = regulator_set_current_limit_regmap,
+	.set_suspend_enable = pf8x00_suspend_enable,
+	.set_suspend_disable = pf8x00_suspend_disable,
 };
 
 static const struct regulator_ops pf8x00_vsnvs_ops = {
@@ -337,6 +396,9 @@ static const struct regulator_ops pf8x00_vsnvs_ops = {
 			.disable_val = 0x0,			\
 			.enable_mask = 2,			\
 		},						\
+		.suspend_enable_reg = (base) + LDO_CONFIG2,	\
+		.suspend_enable_mask = 1,			\
+		.suspend_voltage_reg = (base) + LDO_STBY_VOLT,	\
 	}
 
 #define PF8X00BUCK(_id, _name, base, voltages)			\
@@ -367,6 +429,9 @@ static const struct regulator_ops pf8x00_vsnvs_ops = {
 			.enable_mask = 0x3,			\
 			.enable_time = 500,			\
 		},						\
+		.suspend_enable_reg = (base) + SW_MODE1,	\
+		.suspend_enable_mask = 0xc,			\
+		.suspend_voltage_reg = (base) + SW_STBY_VOLT,	\
 	}
 
 #define PF8X00BUCK7(_name, base, voltages)			\
@@ -415,7 +480,7 @@ static const struct regulator_ops pf8x00_vsnvs_ops = {
 		},						\
 	}
 
-static struct pf8x00_regulator pf8x00_regulators_data[PF8X00_MAX_REGULATORS] = {
+static struct pf8x00_regulator_data pf8x00_regs_data[PF8X00_MAX_REGULATORS] = {
 	PF8X00LDO(1, "ldo1", PF8X00_LDO_BASE(PF8X00_LDO1), pf8x00_ldo_voltages),
 	PF8X00LDO(2, "ldo2", PF8X00_LDO_BASE(PF8X00_LDO2), pf8x00_ldo_voltages),
 	PF8X00LDO(3, "ldo3", PF8X00_LDO_BASE(PF8X00_LDO3), pf8x00_ldo_voltages),
@@ -500,12 +565,12 @@ static int pf8x00_i2c_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
-	for (id = 0; id < ARRAY_SIZE(pf8x00_regulators_data); id++) {
-		struct pf8x00_regulator *data = &pf8x00_regulators_data[id];
+	for (id = 0; id < ARRAY_SIZE(pf8x00_regs_data); id++) {
+		struct pf8x00_regulator_data *data = &pf8x00_regs_data[id];
 		struct regulator_dev *rdev;
 
 		config.dev = chip->dev;
-		config.driver_data = chip;
+		config.driver_data = data;
 		config.regmap = chip->regmap;
 
 		rdev = devm_regulator_register(&client->dev, &data->desc, &config);
-- 
2.29.2


