Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9285273F84
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 12:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgIVKV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 06:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgIVKVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 06:21:22 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2997AC061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 03:21:22 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 34so11559867pgo.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 03:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V9hzjuF0yUErLrhnKbcblV75wxDoRjtOUd/Ws9rOPwM=;
        b=mIqGAanAACGTwur1n3K8HBdLO7I2eHL7uk74eIsQlYejIhwD85f5vPRs6rumxsqbB2
         Teptg/UiElR9YH4qd6vupwsmP3U/yTku4X/bpSAcmlwvb8TlaAwY/RGSJyZ6Y+15LBDh
         TeNOOsRcBvsE1AiZXjFUDSsSgks+2J6GLIi7TDdIsF2MX7gDcws1YhSFptFUF9HpYW5J
         +aBLiGa9MePAAKyPre/HuOdykawqSyFTi5sTmcaCLt0YbIVAB2e56hM3gcjiVbFpqPoB
         QkxBggTqhE46bz+UfLkqopxAcNqrR1DalbI+TWBIjmyH/P/cXqtNRwxRVhlEwPTKDAqG
         n60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V9hzjuF0yUErLrhnKbcblV75wxDoRjtOUd/Ws9rOPwM=;
        b=gM0FDIdbtT8ROaJyhFzWVsAVebC6sI6If7bWtLBHZOAJOMxK9L27UUpU/SRgyID/Ye
         qRU/EqaNX2XEX9ALsbGyHcn2WPFoqIlmgn+2ntBD/bs7n+3p88Pok/3SBcsiQz0sO67z
         52zQVS2xiiXTQYaWNcDyRoxDk7GDEWJp/Dm/oXAetBcvyevkTE5NRziYyi+OVhhCH2+0
         QUfdHJTOnkTRs84ZxQY+vn+mEFveCaYwvTvRxFmFGkR8Cpuz5wV8OlJk0rAJJ99CUsNx
         JtibAsPcg0AZfkls+yNnC+Abmi9TaD9YBQNZ+dsEUrXueZN2X8MlilL546qAfOdU+nDS
         RaeQ==
X-Gm-Message-State: AOAM531zJz91h58yWCEKj5XH7I4vyu78JfnG35NZl46YxnrQfGGC+9bV
        gKlRONzA1m40JJ+orhvl1Oo=
X-Google-Smtp-Source: ABdhPJxHfqAtsye+L7RXzBzq6HmwTmvZ1Z3IZSeaR+my1Se4Rg5yFyrrkuZOdS69/wOvl6/18fx06Q==
X-Received: by 2002:a63:de0a:: with SMTP id f10mr2932846pgg.88.1600770081687;
        Tue, 22 Sep 2020 03:21:21 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:489:56d9:501b:f524:c013:2733])
        by smtp.gmail.com with ESMTPSA id a15sm14859037pfi.119.2020.09.22.03.21.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Sep 2020 03:21:21 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: [PATCH v5 10/10] mfd: mt6360: Merge different sub-devices I2C read/write
Date:   Tue, 22 Sep 2020 18:20:18 +0800
Message-Id: <1600770019-11585-11-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600770019-11585-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1600770019-11585-1-git-send-email-gene.chen.richtek@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Merge different sub-devices I2C read/write functions into one Regmap,
because PMIC and LDO part need CRC bits for access protection.

Signed-off-by: Gene Chen <gene_chen@richtek.com>
---
 drivers/mfd/Kconfig       |   1 +
 drivers/mfd/mt6360-core.c | 224 ++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 190 insertions(+), 35 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 33df083..1dfe446 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -913,6 +913,7 @@ config MFD_MT6360
 	select MFD_CORE
 	select REGMAP_I2C
 	select REGMAP_IRQ
+	select CRC8
 	depends on I2C
 	help
 	  Say Y here to enable MT6360 PMU/PMIC/LDO functional support.
diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index 075b466..2ec9559 100644
--- a/drivers/mfd/mt6360-core.c
+++ b/drivers/mfd/mt6360-core.c
@@ -62,6 +62,18 @@ struct mt6360_ddata {
 
 #define MT6360_CRC8_POLYNOMIAL		0x7
 
+#define MT6360_CRC_I2C_ADDR_SIZE	1
+#define MT6360_CRC_REG_ADDR_SIZE	1
+/* prealloca read size = i2c device addr + i2c reg addr + val ... + crc8 */
+#define MT6360_ALLOC_READ_SIZE(_size)	(_size + 3)
+/* prealloca write size = i2c device addr + i2c reg addr + val ... + crc8 + dummy byte */
+#define MT6360_ALLOC_WRITE_SIZE(_size)	(_size + 4)
+#define MT6360_CRC_PREDATA_OFFSET	(MT6360_CRC_I2C_ADDR_SIZE + MT6360_CRC_REG_ADDR_SIZE)
+#define MT6360_CRC_CRC8_SIZE		1
+#define MT6360_CRC_DUMMY_BYTE_SIZE	1
+#define MT6360_REGMAP_REG_BYTE_SIZE	2
+#define I2C_ADDR_XLATE_8BIT(_addr, _rw)	(((_addr & 0x7F) << 1) + _rw)
+
 /* reg 0 -> 0 ~ 7 */
 #define MT6360_CHG_TREG_EVT		4
 #define MT6360_CHG_AICR_EVT		5
@@ -266,12 +278,6 @@ static const struct regmap_irq_chip mt6360_irq_chip = {
 	.use_ack = true,
 };
 
-static const struct regmap_config mt6360_pmu_regmap_config = {
-	.reg_bits = 8,
-	.val_bits = 8,
-	.max_register = MT6360_PMU_MAXREG,
-};
-
 static const struct resource mt6360_adc_resources[] = {
 	DEFINE_RES_IRQ_NAMED(MT6360_ADC_DONEI, "adc_donei"),
 };
@@ -334,7 +340,7 @@ static const struct mfd_cell mt6360_devs[] = {
 	OF_MFD_CELL("mt6360-led", mt6360_led_resources,
 		    NULL, 0, 0, "mediatek,mt6360-led"),
 	OF_MFD_CELL("mt6360-regulator", mt6360_regulator_resources,
-		    NULL, 0, 0, "mediatek,mt6360-regulator"),
+		    NULL, 0, 0, NULL),
 	OF_MFD_CELL("mt6360-tcpc", NULL,
 		    NULL, 0, 0, "mediatek,mt6360-tcpc"),
 };
@@ -349,7 +355,7 @@ static int mt6360_check_vendor_info(struct mt6360_ddata *ddata)
 		return ret;
 
 	if ((info & CHIP_VEN_MASK) != CHIP_VEN_MT6360) {
-		dev_err(&client->dev, "Device not supported\n");
+		dev_err(ddata->dev, "Device not supported\n");
 		return -ENODEV;
 	}
 
@@ -358,11 +364,161 @@ static int mt6360_check_vendor_info(struct mt6360_ddata *ddata)
 	return 0;
 }
 
-static const unsigned short mt6360_slave_addr[MT6360_SLAVE_MAX] = {
-	MT6360_PMU_SLAVEID,
+static const unsigned short mt6360_slave_addrs[MT6360_SLAVE_MAX] = {
+	MT6360_TCPC_SLAVEID,
 	MT6360_PMIC_SLAVEID,
 	MT6360_LDO_SLAVEID,
-	MT6360_TCPC_SLAVEID,
+	MT6360_PMU_SLAVEID,
+};
+
+static int mt6360_xlate_pmicldo_addr(u8 *addr, int rw_size)
+{
+	/* Address is already in encoded [5:0] */
+	*addr &= MT6360_ADDRESS_MASK;
+
+	switch (rw_size) {
+	case 1:
+		*addr |= MT6360_DATA_SIZE_1_BYTE;
+		break;
+	case 2:
+		*addr |= MT6360_DATA_SIZE_2_BYTES;
+		break;
+	case 3:
+		*addr |= MT6360_DATA_SIZE_3_BYTES;
+		break;
+	case 4:
+		*addr |= MT6360_DATA_SIZE_4_BYTES;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int mt6360_regmap_read(void *context, const void *reg, size_t reg_size,
+			      void *val, size_t val_size)
+{
+	struct mt6360_ddata *ddata = context;
+	u8 bank = *(u8 *)reg;
+	u8 reg_addr = *(u8 *)(reg + 1);
+	struct i2c_client *i2c = ddata->i2c[bank];
+	bool crc_needed = false;
+	u8 *buf;
+	int buf_len = MT6360_ALLOC_READ_SIZE(val_size);
+	int read_size = val_size;
+	u8 crc;
+	int ret;
+
+	if (bank == MT6360_SLAVE_PMIC || bank == MT6360_SLAVE_LDO) {
+		crc_needed = true;
+		ret = mt6360_xlate_pmicldo_addr(&reg_addr, val_size);
+		if (ret < 0)
+			return ret;
+		read_size += MT6360_CRC_CRC8_SIZE;
+	}
+
+	buf = kzalloc(buf_len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	buf[0] = I2C_ADDR_XLATE_8BIT(i2c->addr, I2C_SMBUS_READ);
+	buf[1] = reg_addr;
+
+	ret = i2c_smbus_read_i2c_block_data(i2c, reg_addr, read_size,
+					    buf + MT6360_CRC_PREDATA_OFFSET);
+	if (ret < 0)
+		goto out;
+	else if (ret != read_size) {
+		ret = -EIO;
+		goto out;
+	}
+
+	if (crc_needed) {
+		crc = crc8(ddata->crc8_tbl, buf, val_size + MT6360_CRC_PREDATA_OFFSET, 0);
+		if (crc != buf[val_size + MT6360_CRC_PREDATA_OFFSET]) {
+			ret = -EIO;
+			goto out;
+		}
+	}
+
+	memcpy(val, buf + MT6360_CRC_PREDATA_OFFSET, val_size);
+out:
+	kfree(buf);
+	return (ret < 0) ? ret : 0;
+}
+
+static int mt6360_regmap_write(void *context, const void *val, size_t val_size)
+{
+	struct mt6360_ddata *ddata = context;
+	u8 bank = *(u8 *)val;
+	u8 reg_addr = *(u8 *)(val + 1);
+	struct i2c_client *i2c = ddata->i2c[bank];
+	bool crc_needed = false;
+	u8 *buf;
+	int buf_len = MT6360_ALLOC_WRITE_SIZE(val_size);
+	int write_size = val_size - MT6360_REGMAP_REG_BYTE_SIZE;
+	int ret;
+
+	if (bank == MT6360_SLAVE_PMIC || bank == MT6360_SLAVE_LDO) {
+		crc_needed = true;
+		ret = mt6360_xlate_pmicldo_addr(&reg_addr, val_size - MT6360_REGMAP_REG_BYTE_SIZE);
+		if (ret < 0)
+			return ret;
+	}
+
+	buf = kzalloc(buf_len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	buf[0] = I2C_ADDR_XLATE_8BIT(i2c->addr, I2C_SMBUS_WRITE);
+	buf[1] = reg_addr;
+	memcpy(buf + MT6360_CRC_PREDATA_OFFSET, val + MT6360_REGMAP_REG_BYTE_SIZE, write_size);
+
+	if (crc_needed) {
+		buf[val_size] = crc8(ddata->crc8_tbl, buf, val_size, 0);
+		write_size += (MT6360_CRC_CRC8_SIZE + MT6360_CRC_DUMMY_BYTE_SIZE);
+	}
+
+	ret = i2c_smbus_write_i2c_block_data(i2c, reg_addr, write_size,
+					     buf + MT6360_CRC_PREDATA_OFFSET);
+
+	kfree(buf);
+	return ret;
+}
+
+static const struct regmap_bus mt6360_regmap_bus = {
+	.read		= mt6360_regmap_read,
+	.write		= mt6360_regmap_write,
+
+	/* Due to PMIC and LDO CRC access size limit */
+	.max_raw_read	= 4,
+	.max_raw_write	= 4,
+};
+
+static bool mt6360_is_readwrite_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MT6360_REG_TCPCSTART ... MT6360_REG_TCPCEND:
+		fallthrough;
+	case MT6360_REG_PMICSTART ... MT6360_REG_PMICEND:
+		fallthrough;
+	case MT6360_REG_LDOSTART ... MT6360_REG_LDOEND:
+		fallthrough;
+	case MT6360_REG_PMUSTART ... MT6360_REG_PMUEND:
+		return true;
+	}
+
+	return false;
+}
+
+static const struct regmap_config mt6360_regmap_config = {
+	.reg_bits		= 16,
+	.val_bits		= 8,
+	.reg_format_endian	= REGMAP_ENDIAN_BIG,
+	.max_register		= MT6360_REG_PMUEND,
+	.writeable_reg		= mt6360_is_readwrite_reg,
+	.readable_reg		= mt6360_is_readwrite_reg,
 };
 
 static int mt6360_probe(struct i2c_client *client)
@@ -375,9 +531,23 @@ static int mt6360_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	ddata->dev = &client->dev;
-	i2c_set_clientdata(client, ddata);
 
-	ddata->regmap = devm_regmap_init_i2c(client, &mt6360_pmu_regmap_config);
+	for (i = 0; i < MT6360_SLAVE_MAX - 1; i++) {
+		ddata->i2c[i] = devm_i2c_new_dummy_device(&client->dev,
+							  client->adapter,
+							  mt6360_slave_addrs[i]);
+		if (IS_ERR(ddata->i2c[i])) {
+			dev_err(&client->dev,
+				"Failed to get new dummy I2C device for address 0x%x",
+				mt6360_slave_addrs[i]);
+			return PTR_ERR(ddata->i2c[i]);
+		}
+	}
+	ddata->i2c[MT6360_SLAVE_MAX - 1] = client;
+
+	crc8_populate_msb(ddata->crc8_tbl, MT6360_CRC8_POLYNOMIAL);
+	ddata->regmap = devm_regmap_init(ddata->dev, &mt6360_regmap_bus, ddata,
+					 &mt6360_regmap_config);
 	if (IS_ERR(ddata->regmap)) {
 		dev_err(&client->dev, "Failed to register regmap\n");
 		return PTR_ERR(ddata->regmap);
@@ -387,34 +557,18 @@ static int mt6360_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
-	ret = devm_regmap_add_irq_chip(&client->dev, ddata->regmap, client->irq,
-				       0, 0, &mt6360_irq_chip,
-				       &ddata->irq_data);
+	ret = devm_regmap_add_irq_chip(&client->dev, ddata->regmap, client->irq, 0, 0,
+				       &mt6360_irq_chip, &ddata->irq_data);
 	if (ret) {
 		dev_err(&client->dev, "Failed to add Regmap IRQ Chip\n");
 		return ret;
 	}
 
-	ddata->i2c[0] = client;
-	for (i = 1; i < MT6360_SLAVE_MAX; i++) {
-		ddata->i2c[i] = devm_i2c_new_dummy_device(&client->dev,
-							client->adapter,
-							mt6360_slave_addr[i]);
-		if (IS_ERR(ddata->i2c[i])) {
-			dev_err(&client->dev,
-				"Failed to get new dummy I2C device for address 0x%x",
-				mt6360_slave_addr[i]);
-			return PTR_ERR(ddata->i2c[i]);
-		}
-		i2c_set_clientdata(ddata->i2c[i], ddata);
-	}
-
-	ret = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_AUTO,
-				   mt6360_devs, ARRAY_SIZE(mt6360_devs), NULL,
-				   0, regmap_irq_get_domain(ddata->irq_data));
+	ret = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_AUTO, mt6360_devs,
+				   ARRAY_SIZE(mt6360_devs), NULL, 0,
+				   regmap_irq_get_domain(ddata->irq_data));
 	if (ret) {
-		dev_err(&client->dev,
-			"Failed to register subordinate devices\n");
+		dev_err(&client->dev, "Failed to register subordinate devices\n");
 		return ret;
 	}
 
-- 
2.7.4

