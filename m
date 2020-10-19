Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57E129314C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 00:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388252AbgJSWee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 18:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388236AbgJSWed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 18:34:33 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E910BC0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 15:34:32 -0700 (PDT)
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 2F39983645;
        Tue, 20 Oct 2020 11:34:28 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1603146868;
        bh=C7imuprKH5EkYwefKLXs/kY7ZitXCMJHdjsT8B/ieS0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=r/ZsQSzJSdzf0gCJPwiakW6hBsSaOYMqVhvawzBVs5JxLArpLCr+eqz5J2TfA90QW
         eSEJhGvBYAayrPxJf274eGbtTdACiNfst6vM+KAAqEMQBlpQsERThdAxRQ1/W3TIj2
         4rwR/YdGHmKaR9W7FRdKfpSAyKYGbUEVbdc7rurpJ1J67sBqEoCE33Ce1JEdsYvMtO
         kH2TBxWKH0qzJ0lAvWDy2u7ATSqe0nGQtcua2dtNSjEKu3m6h1c9sF8Kx+Y5g3Jdmk
         2AUiVtMMEet/IGB1QW6r9UnTA3bPqT57tEEB0DDusTll/rpFgQI6EiTkZxsACrawNZ
         +A32HQbhnzkjg==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5f8e14730002>; Tue, 20 Oct 2020 11:34:27 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id D0DB413EEBB;
        Tue, 20 Oct 2020 11:34:27 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 0CC5B283A9C; Tue, 20 Oct 2020 11:34:28 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     jdelvare@suse.com, linux@roeck-us.net,
        Tobi Wulff <tobi.wulff@alliedtelesis.co.nz>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 2/2] hwmon: (adt7470) Convert to regmap
Date:   Tue, 20 Oct 2020 11:34:23 +1300
Message-Id: <20201019223423.31488-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201019223423.31488-1-chris.packham@alliedtelesis.co.nz>
References: <20201019223423.31488-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the adt7470 to using regmap and add error handling.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/hwmon/adt7470.c | 388 ++++++++++++++++++++++++++--------------
 1 file changed, 250 insertions(+), 138 deletions(-)

diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
index 2e8feacccf84..d20aeb3a2fdc 100644
--- a/drivers/hwmon/adt7470.c
+++ b/drivers/hwmon/adt7470.c
@@ -18,6 +18,7 @@
 #include <linux/delay.h>
 #include <linux/log2.h>
 #include <linux/kthread.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/util_macros.h>
=20
@@ -137,7 +138,7 @@ static const unsigned short normal_i2c[] =3D { 0x2C, =
0x2E, 0x2F, I2C_CLIENT_END };
 #define ADT7470_FREQ_SHIFT	4
=20
 struct adt7470_data {
-	struct i2c_client	*client;
+	struct regmap		*regmap;
 	struct mutex		lock;
 	char			sensors_valid;
 	char			limits_valid;
@@ -171,51 +172,73 @@ struct adt7470_data {
  * 16-bit registers on the ADT7470 are low-byte first.  The data sheet s=
ays
  * that the low byte must be read before the high byte.
  */
-static inline int adt7470_read_word_data(struct i2c_client *client, u8 r=
eg)
+static inline int adt7470_read_word_data(struct adt7470_data *data, u8 r=
eg)
 {
-	u16 foo;
-	foo =3D i2c_smbus_read_byte_data(client, reg);
-	foo |=3D ((u16)i2c_smbus_read_byte_data(client, reg + 1) << 8);
-	return foo;
+	u8 val[2];
+	int err;
+
+	err =3D regmap_bulk_read(data->regmap, reg, &val, 2);
+	if (err < 0)
+		return err;
+
+	return val[0] | (val[1] << 8);
 }
=20
-static inline int adt7470_write_word_data(struct i2c_client *client, u8 =
reg,
+static inline int adt7470_write_word_data(struct adt7470_data *data, u8 =
reg,
 					  u16 value)
 {
-	return i2c_smbus_write_byte_data(client, reg, value & 0xFF)
-	       || i2c_smbus_write_byte_data(client, reg + 1, value >> 8);
+	u8 val[2];
+
+	val[0] =3D value & 0xFF;
+	val[1] =3D value >> 8;
+
+	return regmap_bulk_write(data->regmap, reg, &val, 2);
 }
=20
 /* Probe for temperature sensors.  Assumes lock is held */
-static int adt7470_read_temperatures(struct i2c_client *client,
-				     struct adt7470_data *data)
+static int adt7470_read_temperatures(struct adt7470_data *data)
 {
 	unsigned long res;
+	int err;
 	int i;
 	u8 cfg, pwm[4], pwm_cfg[2];
=20
 	/* save pwm[1-4] config register */
-	pwm_cfg[0] =3D i2c_smbus_read_byte_data(client, ADT7470_REG_PWM_CFG(0))=
;
-	pwm_cfg[1] =3D i2c_smbus_read_byte_data(client, ADT7470_REG_PWM_CFG(2))=
;
+	err =3D regmap_raw_read(data->regmap, ADT7470_REG_PWM_CFG(0), &pwm_cfg[=
0], 1);
+	if (err < 0)
+		return err;
+	err =3D regmap_raw_read(data->regmap, ADT7470_REG_PWM_CFG(2), &pwm_cfg[=
1], 1);
+	if (err < 0)
+		return err;
=20
 	/* set manual pwm to whatever it is set to now */
-	for (i =3D 0; i < ADT7470_FAN_COUNT; i++)
-		pwm[i] =3D i2c_smbus_read_byte_data(client, ADT7470_REG_PWM(i));
+	err =3D regmap_bulk_read(data->regmap, ADT7470_REG_PWM(0), &pwm[0], ADT=
7470_FAN_COUNT);
+	if (err < 0)
+		return err;
=20
 	/* put pwm in manual mode */
-	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM_CFG(0),
-		pwm_cfg[0] & ~(ADT7470_PWM_AUTO_MASK));
-	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM_CFG(2),
-		pwm_cfg[1] & ~(ADT7470_PWM_AUTO_MASK));
+	pwm_cfg[0] &=3D ~ADT7470_PWM_AUTO_MASK;
+	err =3D regmap_raw_write(data->regmap, ADT7470_REG_PWM_CFG(0), &pwm_cfg=
[0], 1);
+	if (err < 0)
+		return err;
+	pwm_cfg[1] &=3D ~ADT7470_PWM_AUTO_MASK;
+	err =3D regmap_raw_write(data->regmap, ADT7470_REG_PWM_CFG(2), &pwm_cfg=
[1], 1);
+	if (err < 0)
+		return err;
=20
 	/* write pwm control to whatever it was */
-	for (i =3D 0; i < ADT7470_FAN_COUNT; i++)
-		i2c_smbus_write_byte_data(client, ADT7470_REG_PWM(i), pwm[i]);
+	err =3D regmap_bulk_write(data->regmap, ADT7470_REG_PWM(0), &pwm[0], AD=
T7470_FAN_COUNT);
+	if (err < 0)
+		return err;
=20
 	/* start reading temperature sensors */
-	cfg =3D i2c_smbus_read_byte_data(client, ADT7470_REG_CFG);
+	err =3D regmap_raw_read(data->regmap, ADT7470_REG_CFG, &cfg, 1);
+	if (err < 0)
+		return err;
 	cfg |=3D 0x80;
-	i2c_smbus_write_byte_data(client, ADT7470_REG_CFG, cfg);
+	err =3D regmap_raw_write(data->regmap, ADT7470_REG_CFG, &cfg, 1);
+	if (err < 0)
+		return err;
=20
 	/* Delay is 200ms * number of temp sensors. */
 	res =3D msleep_interruptible((data->num_temp_sensors >=3D 0 ?
@@ -223,13 +246,21 @@ static int adt7470_read_temperatures(struct i2c_cli=
ent *client,
 				    TEMP_COLLECTION_TIME));
=20
 	/* done reading temperature sensors */
-	cfg =3D i2c_smbus_read_byte_data(client, ADT7470_REG_CFG);
+	err =3D regmap_raw_read(data->regmap, ADT7470_REG_CFG, &cfg, 1);
+	if (err < 0)
+		return err;
 	cfg &=3D ~0x80;
-	i2c_smbus_write_byte_data(client, ADT7470_REG_CFG, cfg);
+	err =3D regmap_raw_write(data->regmap, ADT7470_REG_CFG, &cfg, 1);
+	if (err < 0)
+		return err;
=20
 	/* restore pwm[1-4] config registers */
-	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM_CFG(0), pwm_cfg[0]);
-	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM_CFG(2), pwm_cfg[1]);
+	err =3D regmap_raw_write(data->regmap, ADT7470_REG_PWM_CFG(0), &pwm_cfg=
[0], 1);
+	if (err < 0)
+		return err;
+	err =3D regmap_raw_write(data->regmap, ADT7470_REG_PWM_CFG(2), &pwm_cfg=
[1], 1);
+	if (err < 0)
+		return err;
=20
 	if (res) {
 		pr_err("ha ha, interrupted\n");
@@ -240,13 +271,16 @@ static int adt7470_read_temperatures(struct i2c_cli=
ent *client,
 	if (data->num_temp_sensors >=3D 0)
 		return 0;
=20
+	err =3D regmap_bulk_read(data->regmap, ADT7470_TEMP_REG(0), &data->temp=
[0],
+			       ADT7470_TEMP_COUNT);
+	if (err < 0)
+		return err;
 	for (i =3D 0; i < ADT7470_TEMP_COUNT; i++) {
-		data->temp[i] =3D i2c_smbus_read_byte_data(client,
-						ADT7470_TEMP_REG(i));
 		if (data->temp[i])
 			data->num_temp_sensors =3D i + 1;
 	}
 	data->temperatures_probed =3D 1;
+
 	return 0;
 }
=20
@@ -254,10 +288,11 @@ static int adt7470_update_thread(void *p)
 {
 	struct i2c_client *client =3D p;
 	struct adt7470_data *data =3D i2c_get_clientdata(client);
+	int err =3D 0;
=20
 	while (!kthread_should_stop()) {
 		mutex_lock(&data->lock);
-		adt7470_read_temperatures(client, data);
+		err =3D adt7470_read_temperatures(data);
 		mutex_unlock(&data->lock);
=20
 		set_current_state(TASK_INTERRUPTIBLE);
@@ -267,94 +302,124 @@ static int adt7470_update_thread(void *p)
 		schedule_timeout(msecs_to_jiffies(data->auto_update_interval));
 	}
=20
-	return 0;
+	return err;
 }
=20
 static int adt7470_update_sensors(struct adt7470_data *data)
 {
-	struct i2c_client *client =3D data->client;
+	int alarms_mask;
+	u8 vals[2];
 	u8 cfg;
+	int err;
 	int i;
=20
 	if (!data->temperatures_probed)
-		adt7470_read_temperatures(client, data);
+		err =3D adt7470_read_temperatures(data);
 	else
-		for (i =3D 0; i < ADT7470_TEMP_COUNT; i++)
-			data->temp[i] =3D i2c_smbus_read_byte_data(client,
-						ADT7470_TEMP_REG(i));
+		err =3D regmap_bulk_read(data->regmap, ADT7470_TEMP_REG(0), &data->tem=
p[0],
+				       ADT7470_TEMP_COUNT);
+	if (err < 0)
+		return err;
=20
-	for (i =3D 0; i < ADT7470_FAN_COUNT; i++)
-		data->fan[i] =3D adt7470_read_word_data(client,
-						ADT7470_REG_FAN(i));
+	for (i =3D 0; i < ADT7470_FAN_COUNT; i++) {
+		int val =3D adt7470_read_word_data(data, ADT7470_REG_FAN(i));
=20
-	for (i =3D 0; i < ADT7470_PWM_COUNT; i++) {
-		int reg;
-		int reg_mask;
+		if (val < 0)
+			return val;
+
+		data->fan[i] =3D	val;
+	}
=20
-		data->pwm[i] =3D i2c_smbus_read_byte_data(client,
-						ADT7470_REG_PWM(i));
+	err =3D regmap_bulk_read(data->regmap, ADT7470_REG_PWM(0), &data->pwm[0=
], ADT7470_PWM_COUNT);
+	if (err < 0)
+		return err;
+
+	for (i =3D 0; i < ADT7470_PWM_COUNT; i++) {
+		u8 mask;
+		u8 val;
=20
 		if (i % 2)
-			reg_mask =3D ADT7470_PWM2_AUTO_MASK;
+			mask =3D ADT7470_PWM2_AUTO_MASK;
 		else
-			reg_mask =3D ADT7470_PWM1_AUTO_MASK;
+			mask =3D ADT7470_PWM1_AUTO_MASK;
=20
-		reg =3D ADT7470_REG_PWM_CFG(i);
-		if (i2c_smbus_read_byte_data(client, reg) & reg_mask)
+		err =3D regmap_raw_read(data->regmap, ADT7470_REG_PWM_CFG(i), &val, 1)=
;
+		if (err < 0)
+			return err;
+		if (val & mask)
 			data->pwm_automatic[i] =3D 1;
 		else
 			data->pwm_automatic[i] =3D 0;
=20
-		reg =3D ADT7470_REG_PWM_AUTO_TEMP(i);
-		cfg =3D i2c_smbus_read_byte_data(client, reg);
+		err =3D regmap_raw_read(data->regmap, ADT7470_REG_PWM_AUTO_TEMP(i), &v=
al, 1);
+		if (err < 0)
+			return err;
 		if (!(i % 2))
-			data->pwm_auto_temp[i] =3D cfg >> 4;
+			data->pwm_auto_temp[i] =3D val >> 4;
 		else
-			data->pwm_auto_temp[i] =3D cfg & 0xF;
+			data->pwm_auto_temp[i] =3D val & 0xF;
 	}
=20
-	if (i2c_smbus_read_byte_data(client, ADT7470_REG_CFG) &
-	    ADT7470_FSPD_MASK)
+	err =3D regmap_raw_read(data->regmap, ADT7470_REG_CFG, &cfg, 1);
+	if (err < 0)
+		return err;
+	if (cfg & ADT7470_FSPD_MASK)
 		data->force_pwm_max =3D 1;
 	else
 		data->force_pwm_max =3D 0;
=20
-	data->alarm =3D i2c_smbus_read_byte_data(client, ADT7470_REG_ALARM1);
+	err =3D regmap_bulk_read(data->regmap, ADT7470_REG_ALARM1, &vals[0], 2)=
;
+	if (err < 0)
+		return err;
+	data->alarm =3D vals[0];
 	if (data->alarm & ADT7470_OOL_ALARM)
-		data->alarm |=3D ALARM2(i2c_smbus_read_byte_data(client,
-							ADT7470_REG_ALARM2));
-	data->alarms_mask =3D adt7470_read_word_data(client,
-						   ADT7470_REG_ALARM1_MASK);
+		data->alarm |=3D ALARM2(vals[1]);
+
+	alarms_mask =3D adt7470_read_word_data(data, ADT7470_REG_ALARM1_MASK);
+	if (alarms_mask < 0)
+		return alarms_mask;
+	data->alarms_mask =3D alarms_mask;
=20
 	return 0;
 }
=20
 static int adt7470_update_limits(struct adt7470_data *data)
 {
-	struct i2c_client *client =3D data->client;
+	int err;
 	int i;
=20
 	for (i =3D 0; i < ADT7470_TEMP_COUNT; i++) {
-		data->temp_min[i] =3D i2c_smbus_read_byte_data(client,
-						ADT7470_TEMP_MIN_REG(i));
-		data->temp_max[i] =3D i2c_smbus_read_byte_data(client,
-						ADT7470_TEMP_MAX_REG(i));
+		err =3D regmap_raw_read(data->regmap, ADT7470_TEMP_MIN_REG(i), &data->=
temp_min[i], 1);
+		if (err < 0)
+			return err;
+		err =3D regmap_raw_read(data->regmap, ADT7470_TEMP_MAX_REG(i), &data->=
temp_max[i], 1);
+		if (err < 0)
+			return err;
 	}
=20
 	for (i =3D 0; i < ADT7470_FAN_COUNT; i++) {
-		data->fan_min[i] =3D adt7470_read_word_data(client,
-						ADT7470_REG_FAN_MIN(i));
-		data->fan_max[i] =3D adt7470_read_word_data(client,
-						ADT7470_REG_FAN_MAX(i));
+		int val;
+
+		val =3D adt7470_read_word_data(data, ADT7470_REG_FAN_MIN(i));
+		if (val < 0)
+			return val;
+		data->fan_min[i] =3D val;
+		val =3D adt7470_read_word_data(data, ADT7470_REG_FAN_MAX(i));
+		if (val < 0)
+			return val;
+		data->fan_max[i] =3D val;
 	}
=20
 	for (i =3D 0; i < ADT7470_PWM_COUNT; i++) {
-		data->pwm_max[i] =3D i2c_smbus_read_byte_data(client,
-						ADT7470_REG_PWM_MAX(i));
-		data->pwm_min[i] =3D i2c_smbus_read_byte_data(client,
-						ADT7470_REG_PWM_MIN(i));
-		data->pwm_tmin[i] =3D i2c_smbus_read_byte_data(client,
-						ADT7470_REG_PWM_TMIN(i));
+		err =3D regmap_raw_read(data->regmap, ADT7470_REG_PWM_MAX(i), &data->p=
wm_max[i], 1);
+		if (err < 0)
+			return err;
+		err =3D regmap_raw_read(data->regmap, ADT7470_REG_PWM_MIN(i), &data->p=
wm_min[i], 1);
+		if (err < 0)
+			return err;
+		err =3D regmap_raw_read(data->regmap, ADT7470_REG_PWM_TMIN(i), &data->=
pwm_tmin[i], 1);
+		if (err < 0)
+			return err;
 	}
=20
 	return 0;
@@ -490,8 +555,8 @@ static ssize_t temp_min_store(struct device *dev,
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
 	struct adt7470_data *data =3D dev_get_drvdata(dev);
-	struct i2c_client *client =3D data->client;
 	long temp;
+	int err;
=20
 	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
@@ -501,11 +566,11 @@ static ssize_t temp_min_store(struct device *dev,
=20
 	mutex_lock(&data->lock);
 	data->temp_min[attr->index] =3D temp;
-	i2c_smbus_write_byte_data(client, ADT7470_TEMP_MIN_REG(attr->index),
-				  temp);
+	err =3D regmap_raw_write(data->regmap, ADT7470_TEMP_MIN_REG(attr->index=
),
+			       &data->temp_min[attr->index], 1);
 	mutex_unlock(&data->lock);
=20
-	return count;
+	return err < 0 ? err : count;
 }
=20
 static ssize_t temp_max_show(struct device *dev,
@@ -526,8 +591,8 @@ static ssize_t temp_max_store(struct device *dev,
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
 	struct adt7470_data *data =3D dev_get_drvdata(dev);
-	struct i2c_client *client =3D data->client;
 	long temp;
+	int err;
=20
 	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
@@ -537,11 +602,11 @@ static ssize_t temp_max_store(struct device *dev,
=20
 	mutex_lock(&data->lock);
 	data->temp_max[attr->index] =3D temp;
-	i2c_smbus_write_byte_data(client, ADT7470_TEMP_MAX_REG(attr->index),
-				  temp);
+	err =3D regmap_raw_write(data->regmap, ADT7470_TEMP_MAX_REG(attr->index=
),
+			       &data->temp_max[attr->index], 1);
 	mutex_unlock(&data->lock);
=20
-	return count;
+	return err < 0 ? err : count;
 }
=20
 static ssize_t temp_show(struct device *dev, struct device_attribute *de=
vattr,
@@ -574,6 +639,7 @@ static ssize_t alarm_mask_store(struct device *dev,
 {
 	struct adt7470_data *data =3D dev_get_drvdata(dev);
 	long mask;
+	int err;
=20
 	if (kstrtoul(buf, 0, &mask))
 		return -EINVAL;
@@ -583,10 +649,10 @@ static ssize_t alarm_mask_store(struct device *dev,
=20
 	mutex_lock(&data->lock);
 	data->alarms_mask =3D mask;
-	adt7470_write_word_data(data->client, ADT7470_REG_ALARM1_MASK, mask);
+	err =3D adt7470_write_word_data(data, ADT7470_REG_ALARM1_MASK, mask);
 	mutex_unlock(&data->lock);
=20
-	return count;
+	return err < 0 ? err : count;
 }
=20
 static ssize_t fan_max_show(struct device *dev,
@@ -611,7 +677,6 @@ static ssize_t fan_max_store(struct device *dev,
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
 	struct adt7470_data *data =3D dev_get_drvdata(dev);
-	struct i2c_client *client =3D data->client;
 	long temp;
=20
 	if (kstrtol(buf, 10, &temp) || !temp)
@@ -622,7 +687,7 @@ static ssize_t fan_max_store(struct device *dev,
=20
 	mutex_lock(&data->lock);
 	data->fan_max[attr->index] =3D temp;
-	adt7470_write_word_data(client, ADT7470_REG_FAN_MAX(attr->index), temp)=
;
+	adt7470_write_word_data(data, ADT7470_REG_FAN_MAX(attr->index), temp);
 	mutex_unlock(&data->lock);
=20
 	return count;
@@ -650,7 +715,6 @@ static ssize_t fan_min_store(struct device *dev,
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
 	struct adt7470_data *data =3D dev_get_drvdata(dev);
-	struct i2c_client *client =3D data->client;
 	long temp;
=20
 	if (kstrtol(buf, 10, &temp) || !temp)
@@ -661,7 +725,7 @@ static ssize_t fan_min_store(struct device *dev,
=20
 	mutex_lock(&data->lock);
 	data->fan_min[attr->index] =3D temp;
-	adt7470_write_word_data(client, ADT7470_REG_FAN_MIN(attr->index), temp)=
;
+	adt7470_write_word_data(data, ADT7470_REG_FAN_MIN(attr->index), temp);
 	mutex_unlock(&data->lock);
=20
 	return count;
@@ -699,8 +763,8 @@ static ssize_t force_pwm_max_store(struct device *dev=
,
 				   const char *buf, size_t count)
 {
 	struct adt7470_data *data =3D dev_get_drvdata(dev);
-	struct i2c_client *client =3D data->client;
 	long temp;
+	int err;
 	u8 reg;
=20
 	if (kstrtol(buf, 10, &temp))
@@ -708,15 +772,18 @@ static ssize_t force_pwm_max_store(struct device *d=
ev,
=20
 	mutex_lock(&data->lock);
 	data->force_pwm_max =3D temp;
-	reg =3D i2c_smbus_read_byte_data(client, ADT7470_REG_CFG);
+	err =3D regmap_raw_read(data->regmap, ADT7470_REG_CFG, &reg, 1);
+	if (err < 0)
+		goto out;
 	if (temp)
 		reg |=3D ADT7470_FSPD_MASK;
 	else
 		reg &=3D ~ADT7470_FSPD_MASK;
-	i2c_smbus_write_byte_data(client, ADT7470_REG_CFG, reg);
+	err =3D regmap_raw_write(data->regmap, ADT7470_REG_CFG, &reg, 1);
+out:
 	mutex_unlock(&data->lock);
=20
-	return count;
+	return err < 0 ? err : count;
 }
=20
 static ssize_t pwm_show(struct device *dev, struct device_attribute *dev=
attr,
@@ -736,8 +803,8 @@ static ssize_t pwm_store(struct device *dev, struct d=
evice_attribute *devattr,
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
 	struct adt7470_data *data =3D dev_get_drvdata(dev);
-	struct i2c_client *client =3D data->client;
 	long temp;
+	int err;
=20
 	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
@@ -746,10 +813,11 @@ static ssize_t pwm_store(struct device *dev, struct=
 device_attribute *devattr,
=20
 	mutex_lock(&data->lock);
 	data->pwm[attr->index] =3D temp;
-	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM(attr->index), temp);
+	err =3D regmap_raw_write(data->regmap, ADT7470_REG_PWM(attr->index),
+			       &data->pwm[attr->index], 1);
 	mutex_unlock(&data->lock);
=20
-	return count;
+	return err < 0 ? err : count;
 }
=20
 /* These are the valid PWM frequencies to the nearest Hz */
@@ -761,13 +829,21 @@ static ssize_t pwm1_freq_show(struct device *dev,
 			      struct device_attribute *devattr, char *buf)
 {
 	struct adt7470_data *data =3D adt7470_update_device(dev);
-	unsigned char cfg_reg_1;
-	unsigned char cfg_reg_2;
+	u8 cfg_reg_1;
+	u8 cfg_reg_2;
 	int index;
+	int err;
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
=20
 	mutex_lock(&data->lock);
-	cfg_reg_1 =3D i2c_smbus_read_byte_data(data->client, ADT7470_REG_CFG);
-	cfg_reg_2 =3D i2c_smbus_read_byte_data(data->client, ADT7470_REG_CFG_2)=
;
+	err =3D regmap_raw_read(data->regmap, ADT7470_REG_CFG, &cfg_reg_1, 1);
+	if (err < 0)
+		goto out;
+	err =3D regmap_raw_read(data->regmap, ADT7470_REG_CFG_2, &cfg_reg_2, 1)=
;
+	if (err < 0)
+		goto out;
 	mutex_unlock(&data->lock);
=20
 	index =3D (cfg_reg_2 & ADT7470_FREQ_MASK) >> ADT7470_FREQ_SHIFT;
@@ -777,6 +853,10 @@ static ssize_t pwm1_freq_show(struct device *dev,
 		index =3D ARRAY_SIZE(adt7470_freq_map) - 1;
=20
 	return scnprintf(buf, PAGE_SIZE, "%d\n", adt7470_freq_map[index]);
+
+out:
+	mutex_unlock(&data->lock);
+	return err;
 }
=20
 static ssize_t pwm1_freq_store(struct device *dev,
@@ -784,11 +864,11 @@ static ssize_t pwm1_freq_store(struct device *dev,
 			       const char *buf, size_t count)
 {
 	struct adt7470_data *data =3D dev_get_drvdata(dev);
-	struct i2c_client *client =3D data->client;
 	long freq;
 	int index;
 	int low_freq =3D ADT7470_CFG_LF;
-	unsigned char val;
+	int err;
+	u8 val;
=20
 	if (kstrtol(buf, 10, &freq))
 		return -EINVAL;
@@ -804,16 +884,26 @@ static ssize_t pwm1_freq_store(struct device *dev,
=20
 	mutex_lock(&data->lock);
 	/* Configuration Register 1 */
-	val =3D i2c_smbus_read_byte_data(client, ADT7470_REG_CFG);
-	i2c_smbus_write_byte_data(client, ADT7470_REG_CFG,
-				  (val & ~ADT7470_CFG_LF) | low_freq);
+	err =3D regmap_raw_read(data->regmap, ADT7470_REG_CFG, &val, 1);
+	if (err < 0)
+		goto out;
+	val &=3D ~ADT7470_CFG_LF;
+	val |=3D low_freq;
+	err =3D regmap_raw_write(data->regmap, ADT7470_REG_CFG, &val, 1);
+	if (err < 0)
+		goto out;
+
 	/* Configuration Register 2 */
-	val =3D i2c_smbus_read_byte_data(client, ADT7470_REG_CFG_2);
-	i2c_smbus_write_byte_data(client, ADT7470_REG_CFG_2,
-		(val & ~ADT7470_FREQ_MASK) | (index << ADT7470_FREQ_SHIFT));
+	err =3D regmap_raw_read(data->regmap, ADT7470_REG_CFG_2, &val, 1);
+	if (err < 0)
+		goto out;
+	val &=3D ~ADT7470_FREQ_MASK;
+	val |=3D index << ADT7470_FREQ_SHIFT;
+	err =3D regmap_raw_write(data->regmap, ADT7470_REG_CFG_2, &val, 1);
+out:
 	mutex_unlock(&data->lock);
=20
-	return count;
+	return err < 0 ? err : count;
 }
=20
 static ssize_t pwm_max_show(struct device *dev,
@@ -834,8 +924,8 @@ static ssize_t pwm_max_store(struct device *dev,
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
 	struct adt7470_data *data =3D dev_get_drvdata(dev);
-	struct i2c_client *client =3D data->client;
 	long temp;
+	int err;
=20
 	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
@@ -844,11 +934,11 @@ static ssize_t pwm_max_store(struct device *dev,
=20
 	mutex_lock(&data->lock);
 	data->pwm_max[attr->index] =3D temp;
-	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM_MAX(attr->index),
-				  temp);
+	err =3D regmap_raw_write(data->regmap, ADT7470_REG_PWM_MAX(attr->index)=
,
+			       &data->pwm_max[attr->index], 1);
 	mutex_unlock(&data->lock);
=20
-	return count;
+	return err < 0 ? err : count;
 }
=20
 static ssize_t pwm_min_show(struct device *dev,
@@ -869,8 +959,8 @@ static ssize_t pwm_min_store(struct device *dev,
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
 	struct adt7470_data *data =3D dev_get_drvdata(dev);
-	struct i2c_client *client =3D data->client;
 	long temp;
+	int err;
=20
 	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
@@ -878,12 +968,11 @@ static ssize_t pwm_min_store(struct device *dev,
 	temp =3D clamp_val(temp, 0, 255);
=20
 	mutex_lock(&data->lock);
-	data->pwm_min[attr->index] =3D temp;
-	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM_MIN(attr->index),
-				  temp);
+	err =3D regmap_raw_write(data->regmap, ADT7470_REG_PWM_MIN(attr->index)=
,
+			       &data->pwm_min[attr->index], 1);
 	mutex_unlock(&data->lock);
=20
-	return count;
+	return err < 0 ? err : count;
 }
=20
 static ssize_t pwm_tmax_show(struct device *dev,
@@ -917,8 +1006,8 @@ static ssize_t pwm_tmin_store(struct device *dev,
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
 	struct adt7470_data *data =3D dev_get_drvdata(dev);
-	struct i2c_client *client =3D data->client;
 	long temp;
+	int err;
=20
 	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
@@ -928,11 +1017,11 @@ static ssize_t pwm_tmin_store(struct device *dev,
=20
 	mutex_lock(&data->lock);
 	data->pwm_tmin[attr->index] =3D temp;
-	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM_TMIN(attr->index),
-				  temp);
+	err =3D regmap_raw_write(data->regmap, ADT7470_REG_PWM_TMIN(attr->index=
),
+			       &data->pwm_tmin[attr->index], 1);
 	mutex_unlock(&data->lock);
=20
-	return count;
+	return err < 0 ? err : count;
 }
=20
 static ssize_t pwm_auto_show(struct device *dev,
@@ -953,10 +1042,10 @@ static ssize_t pwm_auto_store(struct device *dev,
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
 	struct adt7470_data *data =3D dev_get_drvdata(dev);
-	struct i2c_client *client =3D data->client;
 	int pwm_auto_reg =3D ADT7470_REG_PWM_CFG(attr->index);
 	int pwm_auto_reg_mask;
 	long temp;
+	int err;
 	u8 reg;
=20
 	if (kstrtol(buf, 10, &temp))
@@ -973,15 +1062,18 @@ static ssize_t pwm_auto_store(struct device *dev,
=20
 	mutex_lock(&data->lock);
 	data->pwm_automatic[attr->index] =3D temp;
-	reg =3D i2c_smbus_read_byte_data(client, pwm_auto_reg);
+	err =3D regmap_raw_read(data->regmap, pwm_auto_reg, &reg, 1);
+	if (err < 0)
+		goto out;
 	if (temp)
 		reg |=3D pwm_auto_reg_mask;
 	else
 		reg &=3D ~pwm_auto_reg_mask;
-	i2c_smbus_write_byte_data(client, pwm_auto_reg, reg);
+	err =3D regmap_raw_write(data->regmap, pwm_auto_reg, &reg, 1);
+out:
 	mutex_unlock(&data->lock);
=20
-	return count;
+	return err < 0 ? err : count;
 }
=20
 static ssize_t pwm_auto_temp_show(struct device *dev,
@@ -1016,9 +1108,9 @@ static ssize_t pwm_auto_temp_store(struct device *d=
ev,
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
 	struct adt7470_data *data =3D dev_get_drvdata(dev);
-	struct i2c_client *client =3D data->client;
 	int pwm_auto_reg =3D ADT7470_REG_PWM_AUTO_TEMP(attr->index);
 	long temp;
+	int err;
 	u8 reg;
=20
 	if (kstrtol(buf, 10, &temp))
@@ -1030,7 +1122,10 @@ static ssize_t pwm_auto_temp_store(struct device *=
dev,
=20
 	mutex_lock(&data->lock);
 	data->pwm_automatic[attr->index] =3D temp;
-	reg =3D i2c_smbus_read_byte_data(client, pwm_auto_reg);
+
+	err =3D regmap_raw_read(data->regmap, pwm_auto_reg, &reg, 1);
+	if (err < 0)
+		goto out;
=20
 	if (!(attr->index % 2)) {
 		reg &=3D 0xF;
@@ -1040,10 +1135,11 @@ static ssize_t pwm_auto_temp_store(struct device =
*dev,
 		reg |=3D temp & 0xF;
 	}
=20
-	i2c_smbus_write_byte_data(client, pwm_auto_reg, reg);
+	err =3D regmap_raw_write(data->regmap, pwm_auto_reg, &reg, 1);
+out:
 	mutex_unlock(&data->lock);
=20
-	return count;
+	return err < 0 ? err : count;
 }
=20
 static ssize_t alarm_show(struct device *dev,
@@ -1287,23 +1383,35 @@ static int adt7470_detect(struct i2c_client *clie=
nt,
 	return 0;
 }
=20
-static void adt7470_init_client(struct i2c_client *client)
+static int adt7470_init_client(struct device *dev, struct adt7470_data *=
data)
 {
-	int reg =3D i2c_smbus_read_byte_data(client, ADT7470_REG_CFG);
+	int err;
+	u8 val;
=20
-	if (reg < 0) {
-		dev_err(&client->dev, "cannot read configuration register\n");
-	} else {
-		/* start monitoring (and do a self-test) */
-		i2c_smbus_write_byte_data(client, ADT7470_REG_CFG, reg | 3);
+	err =3D regmap_raw_read(data->regmap, ADT7470_REG_CFG, &val, 1);
+	if (err < 0) {
+		dev_err(dev, "cannot read configuration register\n");
+		return err;
 	}
+
+	val |=3D 3;
+
+	return regmap_raw_write(data->regmap, ADT7470_REG_CFG, &val, 1);
 }
=20
+static const struct regmap_config adt7470_regmap_config =3D {
+	.reg_bits =3D 8,
+	.val_bits =3D 8,
+	.use_single_read =3D true,
+	.use_single_write =3D true,
+};
+
 static int adt7470_probe(struct i2c_client *client)
 {
 	struct device *dev =3D &client->dev;
 	struct adt7470_data *data;
 	struct device *hwmon_dev;
+	int err;
=20
 	data =3D devm_kzalloc(dev, sizeof(struct adt7470_data), GFP_KERNEL);
 	if (!data)
@@ -1311,15 +1419,19 @@ static int adt7470_probe(struct i2c_client *clien=
t)
=20
 	data->num_temp_sensors =3D -1;
 	data->auto_update_interval =3D AUTO_UPDATE_INTERVAL;
+	data->regmap =3D devm_regmap_init_i2c(client, &adt7470_regmap_config);
+	if (IS_ERR(data->regmap))
+		return PTR_ERR(data->regmap);
=20
 	i2c_set_clientdata(client, data);
-	data->client =3D client;
 	mutex_init(&data->lock);
=20
 	dev_info(&client->dev, "%s chip found\n", client->name);
=20
 	/* Initialize the ADT7470 chip */
-	adt7470_init_client(client);
+	err =3D adt7470_init_client(dev, data);
+	if (err < 0)
+		return err;
=20
 	/* Register sysfs hooks */
 	hwmon_dev =3D devm_hwmon_device_register_with_groups(dev, client->name,
--=20
2.28.0

