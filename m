Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFD5276C5F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 10:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbgIXIvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 04:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbgIXIvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 04:51:19 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4630C0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 01:51:18 -0700 (PDT)
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 690DE891B0;
        Thu, 24 Sep 2020 20:51:15 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1600937475;
        bh=dw8/4cI00nGKg65iKVLysmqOcgoxO4mJj6EMHJSKR8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=wPUT5Svuq723boupeITUvzMFUOPc++dyCtZACcBqRTr/j3hpMitje0paP6jKXtwIq
         C5JrEE1JcUtlx+tcvg9rSPyRnv8rEbyOBcZdS0IICz5lKC/g3Uh++kKZzo62vR552+
         KbnKu/3Et0YP8VlynfelMi+X5MVor6zi2IztiYeQgB6QAsV24h2/cpE5FVdV81qICl
         VVg+R2p7bPSWL9PtYZ5Yc95wp4G2NNwyYBb4UC3zSxj31mHt8Ho/ba81fHu5QpP3rn
         swzEswHAvnbhSVoCeb8/w1JSooxLS00lOk+3FdqZpoZHvv48DziOC2l3nlOBGp5HRH
         TrRssg00kBgbQ==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5f6c5e040000>; Thu, 24 Sep 2020 20:51:16 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 6FAE013EEBA;
        Thu, 24 Sep 2020 20:51:14 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 40E3F28005C; Thu, 24 Sep 2020 20:51:15 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 3/3] hwmon: (adm9240) Convert to regmap
Date:   Thu, 24 Sep 2020 20:51:02 +1200
Message-Id: <20200924085102.15219-4-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200924085102.15219-1-chris.packham@alliedtelesis.co.nz>
References: <20200924085102.15219-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the adm9240 driver to using regmap and add error handling.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/hwmon/adm9240.c | 215 +++++++++++++++++++++++++---------------
 1 file changed, 136 insertions(+), 79 deletions(-)

diff --git a/drivers/hwmon/adm9240.c b/drivers/hwmon/adm9240.c
index 951674de0b35..f55c9409d904 100644
--- a/drivers/hwmon/adm9240.c
+++ b/drivers/hwmon/adm9240.c
@@ -38,6 +38,7 @@
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <linux/jiffies.h>
+#include <linux/regmap.h>
=20
 /* Addresses to scan */
 static const unsigned short normal_i2c[] =3D { 0x2c, 0x2d, 0x2e, 0x2f,
@@ -123,6 +124,7 @@ static inline unsigned int AOUT_FROM_REG(u8 reg)
 /* per client data */
 struct adm9240_data {
 	struct i2c_client *client;
+	struct regmap *regmap;
 	struct mutex update_lock;
 	char valid;
 	unsigned long last_updated_measure;
@@ -143,55 +145,72 @@ struct adm9240_data {
 };
=20
 /* write new fan div, callers must hold data->update_lock */
-static void adm9240_write_fan_div(struct i2c_client *client, int nr,
+static int adm9240_write_fan_div(struct adm9240_data *data, int nr,
 		u8 fan_div)
 {
-	u8 reg, old, shift =3D (nr + 2) * 2;
+	unsigned int reg, old, shift =3D (nr + 2) * 2;
+	int err;
=20
-	reg =3D i2c_smbus_read_byte_data(client, ADM9240_REG_VID_FAN_DIV);
+	err =3D regmap_read(data->regmap, ADM9240_REG_VID_FAN_DIV, &reg);
+	if (err < 0)
+		return err;
 	old =3D (reg >> shift) & 3;
 	reg &=3D ~(3 << shift);
 	reg |=3D (fan_div << shift);
-	i2c_smbus_write_byte_data(client, ADM9240_REG_VID_FAN_DIV, reg);
-	dev_dbg(&client->dev,
+	err =3D regmap_write(data->regmap, ADM9240_REG_VID_FAN_DIV, reg);
+	if (err < 0)
+		return err;
+	dev_dbg(&data->client->dev,
 		"fan%d clock divider changed from %u to %u\n",
 		nr + 1, 1 << old, 1 << fan_div);
+
+	return 0;
 }
=20
 static int adm9240_update_measure(struct adm9240_data *data)
 {
-	struct i2c_client *client =3D data->client;
+	unsigned int val;
+	u8 regs[2];
+	int err;
 	int i;
=20
-	for (i =3D 0; i < 6; i++) { /* read voltages */
-		data->in[i] =3D i2c_smbus_read_byte_data(client,
-				ADM9240_REG_IN(i));
-	}
-	data->alarms =3D i2c_smbus_read_byte_data(client,
-			ADM9240_REG_INT(0)) |
-		i2c_smbus_read_byte_data(client,
-				ADM9240_REG_INT(1)) << 8;
+	err =3D regmap_bulk_read(data->regmap, ADM9240_REG_IN(0), &data->in[0],=
 6);
+	if (err < 0)
+		return err;
+	err =3D regmap_bulk_read(data->regmap, ADM9240_REG_INT(0), &regs, 2);
+	if (err < 0)
+		return err;
+
+	data->alarms =3D regs[0] | regs[1] << 8;
=20
 	/*
 	 * read temperature: assume temperature changes less than
 	 * 0.5'C per two measurement cycles thus ignore possible
 	 * but unlikely aliasing error on lsb reading. --Grant
 	 */
-	data->temp =3D (i2c_smbus_read_byte_data(client,
-				ADM9240_REG_TEMP) << 8) |
-		i2c_smbus_read_byte_data(client,
-				ADM9240_REG_TEMP_CONF);
+	err =3D regmap_read(data->regmap, ADM9240_REG_TEMP, &val);
+	if (err < 0)
+		return err;
+	data->temp =3D val << 8;
+	err =3D regmap_read(data->regmap, ADM9240_REG_TEMP_CONF, &val);
+	if (err < 0)
+		return err;
+	data->temp |=3D val;
=20
-	for (i =3D 0; i < 2; i++) { /* read fans */
-		data->fan[i] =3D i2c_smbus_read_byte_data(client,
-				ADM9240_REG_FAN(i));
+	err =3D regmap_bulk_read(data->regmap, ADM9240_REG_FAN(0),
+			       &data->fan[0], 2);
+	if (err < 0)
+		return err;
=20
+	for (i =3D 0; i < 2; i++) { /* read fans */
 		/* adjust fan clock divider on overflow */
 		if (data->valid && data->fan[i] =3D=3D 255 &&
 				data->fan_div[i] < 3) {
=20
-			adm9240_write_fan_div(client, i,
+			err =3D adm9240_write_fan_div(data, i,
 					++data->fan_div[i]);
+			if (err < 0)
+				return err;
=20
 			/* adjust fan_min if active, but not to 0 */
 			if (data->fan_min[i] < 255 &&
@@ -205,36 +224,45 @@ static int adm9240_update_measure(struct adm9240_da=
ta *data)
=20
 static int adm9240_update_config(struct adm9240_data *data)
 {
-	struct i2c_client *client =3D data->client;
+	unsigned int val;
 	int i;
+	int err;
=20
 	for (i =3D 0; i < 6; i++) {
-		data->in_min[i] =3D i2c_smbus_read_byte_data(client,
-				ADM9240_REG_IN_MIN(i));
-		data->in_max[i] =3D i2c_smbus_read_byte_data(client,
-				ADM9240_REG_IN_MAX(i));
-	}
-	for (i =3D 0; i < 2; i++) {
-		data->fan_min[i] =3D i2c_smbus_read_byte_data(client,
-				ADM9240_REG_FAN_MIN(i));
-	}
-	for (i =3D 0; i < 2; i++) {
-		data->temp_max[i] =3D i2c_smbus_read_byte_data(client,
-				ADM9240_REG_TEMP_MAX(i));
+		err =3D regmap_raw_read(data->regmap, ADM9240_REG_IN_MIN(i),
+				      &data->in_min[i], 1);
+		if (err < 0)
+			return err;
+		err =3D regmap_raw_read(data->regmap, ADM9240_REG_IN_MAX(i),
+				      &data->in_max[i], 1);
+		if (err < 0)
+			return err;
 	}
+	err =3D regmap_bulk_read(data->regmap, ADM9240_REG_FAN_MIN(0),
+				      &data->fan_min[0], 2);
+	if (err < 0)
+		return err;
+	err =3D regmap_bulk_read(data->regmap, ADM9240_REG_TEMP_MAX(0),
+				      &data->temp_max[0], 2);
+	if (err < 0)
+		return err;
=20
 	/* read fan divs and 5-bit VID */
-	i =3D i2c_smbus_read_byte_data(client, ADM9240_REG_VID_FAN_DIV);
-	data->fan_div[0] =3D (i >> 4) & 3;
-	data->fan_div[1] =3D (i >> 6) & 3;
-	data->vid =3D i & 0x0f;
-	data->vid |=3D (i2c_smbus_read_byte_data(client,
-				ADM9240_REG_VID4) & 1) << 4;
+	err =3D regmap_read(data->regmap, ADM9240_REG_VID_FAN_DIV, &val);
+	if (err < 0)
+		return err;
+	data->fan_div[0] =3D (val >> 4) & 3;
+	data->fan_div[1] =3D (val >> 6) & 3;
+	data->vid =3D val & 0x0f;
+	err =3D regmap_read(data->regmap, ADM9240_REG_VID4, &val);
+	if (err < 0)
+		return err;
+	data->vid |=3D (val & 1) << 4;
 	/* read analog out */
-	data->aout =3D i2c_smbus_read_byte_data(client,
-			ADM9240_REG_ANALOG_OUT);
+	err =3D regmap_raw_read(data->regmap, ADM9240_REG_ANALOG_OUT,
+			      &data->aout, 1);
=20
-	return 0;
+	return err;
 }
=20
 static struct adm9240_data *adm9240_update_device(struct device *dev)
@@ -303,7 +331,6 @@ static ssize_t max_store(struct device *dev, struct d=
evice_attribute *devattr,
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
 	struct adm9240_data *data =3D dev_get_drvdata(dev);
-	struct i2c_client *client =3D data->client;
 	long val;
 	int err;
=20
@@ -313,10 +340,10 @@ static ssize_t max_store(struct device *dev, struct=
 device_attribute *devattr,
=20
 	mutex_lock(&data->update_lock);
 	data->temp_max[attr->index] =3D TEMP_TO_REG(val);
-	i2c_smbus_write_byte_data(client, ADM9240_REG_TEMP_MAX(attr->index),
-			data->temp_max[attr->index]);
+	err =3D regmap_write(data->regmap, ADM9240_REG_TEMP_MAX(attr->index),
+			   data->temp_max[attr->index]);
 	mutex_unlock(&data->update_lock);
-	return count;
+	return err < 0 ? err : count;
 }
=20
 static DEVICE_ATTR_RO(temp1_input);
@@ -369,7 +396,6 @@ static ssize_t in_min_store(struct device *dev,
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
 	struct adm9240_data *data =3D dev_get_drvdata(dev);
-	struct i2c_client *client =3D data->client;
 	unsigned long val;
 	int err;
=20
@@ -379,10 +405,10 @@ static ssize_t in_min_store(struct device *dev,
=20
 	mutex_lock(&data->update_lock);
 	data->in_min[attr->index] =3D IN_TO_REG(val, attr->index);
-	i2c_smbus_write_byte_data(client, ADM9240_REG_IN_MIN(attr->index),
-			data->in_min[attr->index]);
+	err =3D regmap_write(data->regmap, ADM9240_REG_IN_MIN(attr->index),
+			   data->in_min[attr->index]);
 	mutex_unlock(&data->update_lock);
-	return count;
+	return err < 0 ? err : count;
 }
=20
 static ssize_t in_max_store(struct device *dev,
@@ -391,7 +417,6 @@ static ssize_t in_max_store(struct device *dev,
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
 	struct adm9240_data *data =3D dev_get_drvdata(dev);
-	struct i2c_client *client =3D data->client;
 	unsigned long val;
 	int err;
=20
@@ -401,10 +426,10 @@ static ssize_t in_max_store(struct device *dev,
=20
 	mutex_lock(&data->update_lock);
 	data->in_max[attr->index] =3D IN_TO_REG(val, attr->index);
-	i2c_smbus_write_byte_data(client, ADM9240_REG_IN_MAX(attr->index),
-			data->in_max[attr->index]);
+	err =3D regmap_write(data->regmap, ADM9240_REG_IN_MAX(attr->index),
+			   data->in_max[attr->index]);
 	mutex_unlock(&data->update_lock);
-	return count;
+	return err < 0 ? err : count;
 }
=20
 static SENSOR_DEVICE_ATTR_RO(in0_input, in, 0);
@@ -527,13 +552,13 @@ static ssize_t fan_min_store(struct device *dev,
=20
 	if (new_div !=3D data->fan_div[nr]) {
 		data->fan_div[nr] =3D new_div;
-		adm9240_write_fan_div(client, nr, new_div);
+		adm9240_write_fan_div(data, nr, new_div);
 	}
-	i2c_smbus_write_byte_data(client, ADM9240_REG_FAN_MIN(nr),
-			data->fan_min[nr]);
+	err =3D regmap_write(data->regmap, ADM9240_REG_FAN_MIN(nr),
+			   data->fan_min[nr]);
=20
 	mutex_unlock(&data->update_lock);
-	return count;
+	return err < 0 ? err : count;
 }
=20
 static SENSOR_DEVICE_ATTR_RO(fan1_input, fan, 0);
@@ -607,7 +632,6 @@ static ssize_t aout_output_store(struct device *dev,
 				 const char *buf, size_t count)
 {
 	struct adm9240_data *data =3D dev_get_drvdata(dev);
-	struct i2c_client *client =3D data->client;
 	long val;
 	int err;
=20
@@ -617,9 +641,9 @@ static ssize_t aout_output_store(struct device *dev,
=20
 	mutex_lock(&data->update_lock);
 	data->aout =3D AOUT_TO_REG(val);
-	i2c_smbus_write_byte_data(client, ADM9240_REG_ANALOG_OUT, data->aout);
+	err =3D regmap_write(data->regmap, ADM9240_REG_ANALOG_OUT, data->aout);
 	mutex_unlock(&data->update_lock);
-	return count;
+	return err < 0 ? err : count;
 }
 static DEVICE_ATTR_RW(aout_output);
=20
@@ -627,17 +651,19 @@ static ssize_t alarm_store(struct device *dev, stru=
ct device_attribute *attr,
 			   const char *buf, size_t count)
 {
 	struct adm9240_data *data =3D dev_get_drvdata(dev);
-	struct i2c_client *client =3D data->client;
 	unsigned long val;
+	int err;
=20
 	if (kstrtoul(buf, 10, &val) || val !=3D 0)
 		return -EINVAL;
=20
 	mutex_lock(&data->update_lock);
-	i2c_smbus_write_byte_data(client, ADM9240_REG_CHASSIS_CLEAR, 0x80);
+	err =3D regmap_write(data->regmap, ADM9240_REG_CHASSIS_CLEAR, 0x80);
 	data->valid =3D 0;		/* Force cache refresh */
 	mutex_unlock(&data->update_lock);
-	dev_dbg(&client->dev, "chassis intrusion latch cleared\n");
+	if (err < 0)
+		return err;
+	dev_dbg(&data->client->dev, "chassis intrusion latch cleared\n");
=20
 	return count;
 }
@@ -736,11 +762,18 @@ static int adm9240_detect(struct i2c_client *new_cl=
ient,
 	return 0;
 }
=20
-static void adm9240_init_client(struct i2c_client *client)
+static int adm9240_init_client(struct i2c_client *client, struct adm9240=
_data *data)
 {
-	struct adm9240_data *data =3D i2c_get_clientdata(client);
-	u8 conf =3D i2c_smbus_read_byte_data(client, ADM9240_REG_CONFIG);
-	u8 mode =3D i2c_smbus_read_byte_data(client, ADM9240_REG_TEMP_CONF) & 3=
;
+	u8 conf, mode;
+	int err;
+
+	err =3D regmap_raw_read(data->regmap, ADM9240_REG_CONFIG, &conf, 1);
+	if (err < 0)
+		return err;
+	err =3D regmap_raw_read(data->regmap, ADM9240_REG_TEMP_CONF, &mode, 1);
+	if (err < 0)
+		return err;
+	mode &=3D 3;
=20
 	data->vrm =3D vid_which_vrm(); /* need this to report vid as mV */
=20
@@ -756,44 +789,68 @@ static void adm9240_init_client(struct i2c_client *=
client)
 		int i;
=20
 		for (i =3D 0; i < 6; i++) {
-			i2c_smbus_write_byte_data(client,
-					ADM9240_REG_IN_MIN(i), 0);
-			i2c_smbus_write_byte_data(client,
-					ADM9240_REG_IN_MAX(i), 255);
+			err =3D regmap_write(data->regmap,
+					   ADM9240_REG_IN_MIN(i), 0);
+			if (err < 0)
+				return err;
+			err =3D regmap_write(data->regmap,
+					   ADM9240_REG_IN_MAX(i), 255);
+			if (err < 0)
+				return err;
 		}
 		for (i =3D 0; i < 2; i++) {
-			i2c_smbus_write_byte_data(client,
+			err =3D regmap_write(data->regmap,
 					ADM9240_REG_FAN_MIN(i), 255);
+			if (err < 0)
+				return err;
 		}
 		for (i =3D 0; i < 2; i++) {
-			i2c_smbus_write_byte_data(client,
+			err =3D regmap_write(data->regmap,
 					ADM9240_REG_TEMP_MAX(i), 127);
+			if (err < 0)
+				return err;
 		}
=20
 		/* start measurement cycle */
-		i2c_smbus_write_byte_data(client, ADM9240_REG_CONFIG, 1);
+		err =3D regmap_write(data->regmap, ADM9240_REG_CONFIG, 1);
+		if (err < 0)
+			return err;
=20
 		dev_info(&client->dev,
 			 "cold start: config was 0x%02x mode %u\n", conf, mode);
 	}
+
+	return 0;
 }
=20
+static const struct regmap_config adm9240_regmap_config =3D {
+	.reg_bits =3D 8,
+	.val_bits =3D 8,
+	.use_single_read =3D true,
+	.use_single_write =3D true,
+};
+
 static int adm9240_probe(struct i2c_client *new_client,
 			 const struct i2c_device_id *id)
 {
 	struct device *dev =3D &new_client->dev;
 	struct device *hwmon_dev;
 	struct adm9240_data *data;
+	int err;
=20
 	data =3D devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
=20
-	i2c_set_clientdata(new_client, data);
 	data->client =3D new_client;
 	mutex_init(&data->update_lock);
+	data->regmap =3D devm_regmap_init_i2c(new_client, &adm9240_regmap_confi=
g);
+	if (IS_ERR(data->regmap))
+		return PTR_ERR(data->regmap);
=20
-	adm9240_init_client(new_client);
+	err =3D adm9240_init_client(new_client, data);
+	if (err < 0)
+		return err;
=20
 	hwmon_dev =3D devm_hwmon_device_register_with_groups(dev,
 							   new_client->name,
--=20
2.28.0

