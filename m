Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5FEF276C60
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 10:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbgIXIvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 04:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbgIXIvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 04:51:19 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41F1C0613D5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 01:51:18 -0700 (PDT)
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 5E76B83646;
        Thu, 24 Sep 2020 20:51:15 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1600937475;
        bh=9xreXWAlI/bnBh7uoAGoOaCSwiyYKTwbzPOdWaFnnjY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=dzEv6Cx5MFlKLBncqt5rrOwpjdwFQbZokXKlIK8AfL/1iCQ0UbViKtvuMZDl58rIW
         Zi0mP7DyoI6yPn4aBCDLY7fsyl9UFPUmtu8tRfwFivMIzYD/D3OFy1ls1ahYzq6jGG
         acP64mpO/eV1Bwu9UJnL+C05+AbR95ogsebTWDWTeQRTidJ02xWqV4sQYZwBEeulao
         B4IO6N0K8Vm58GWtvM8BlMO/AYvlkyhfJetStHBruRL+Ct5zxDatZ/2FYXdIZiW72g
         DK5Ip7hcgAtEK7YwYgKCOsQf/25HjCjQ+bPyKSqVISNM3zvcKE5I522SLQm7DtSYcc
         r7mE8aF0Mxn5g==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5f6c5e030001>; Thu, 24 Sep 2020 20:51:15 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 4501E13EEBA;
        Thu, 24 Sep 2020 20:51:14 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 17C5C28005C; Thu, 24 Sep 2020 20:51:15 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 2/3] hwmon: (adm9240) Create functions for updating measure and config
Date:   Thu, 24 Sep 2020 20:51:01 +1200
Message-Id: <20200924085102.15219-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200924085102.15219-1-chris.packham@alliedtelesis.co.nz>
References: <20200924085102.15219-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split the body of adm9240_update_device() into two helper functions
adm9240_update_measure() and adm9240_update_config(). Although neither
of the new helpers returns an error yet lay the groundwork for
propagating failures through to the sysfs readers.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/hwmon/adm9240.c | 202 +++++++++++++++++++++++++++-------------
 1 file changed, 138 insertions(+), 64 deletions(-)

diff --git a/drivers/hwmon/adm9240.c b/drivers/hwmon/adm9240.c
index f95dde1b9c7f..951674de0b35 100644
--- a/drivers/hwmon/adm9240.c
+++ b/drivers/hwmon/adm9240.c
@@ -158,53 +158,100 @@ static void adm9240_write_fan_div(struct i2c_clien=
t *client, int nr,
 		nr + 1, 1 << old, 1 << fan_div);
 }
=20
-static struct adm9240_data *adm9240_update_device(struct device *dev)
+static int adm9240_update_measure(struct adm9240_data *data)
 {
-	struct adm9240_data *data =3D dev_get_drvdata(dev);
 	struct i2c_client *client =3D data->client;
 	int i;
=20
+	for (i =3D 0; i < 6; i++) { /* read voltages */
+		data->in[i] =3D i2c_smbus_read_byte_data(client,
+				ADM9240_REG_IN(i));
+	}
+	data->alarms =3D i2c_smbus_read_byte_data(client,
+			ADM9240_REG_INT(0)) |
+		i2c_smbus_read_byte_data(client,
+				ADM9240_REG_INT(1)) << 8;
+
+	/*
+	 * read temperature: assume temperature changes less than
+	 * 0.5'C per two measurement cycles thus ignore possible
+	 * but unlikely aliasing error on lsb reading. --Grant
+	 */
+	data->temp =3D (i2c_smbus_read_byte_data(client,
+				ADM9240_REG_TEMP) << 8) |
+		i2c_smbus_read_byte_data(client,
+				ADM9240_REG_TEMP_CONF);
+
+	for (i =3D 0; i < 2; i++) { /* read fans */
+		data->fan[i] =3D i2c_smbus_read_byte_data(client,
+				ADM9240_REG_FAN(i));
+
+		/* adjust fan clock divider on overflow */
+		if (data->valid && data->fan[i] =3D=3D 255 &&
+				data->fan_div[i] < 3) {
+
+			adm9240_write_fan_div(client, i,
+					++data->fan_div[i]);
+
+			/* adjust fan_min if active, but not to 0 */
+			if (data->fan_min[i] < 255 &&
+					data->fan_min[i] >=3D 2)
+				data->fan_min[i] /=3D 2;
+		}
+	}
+
+	return 0;
+}
+
+static int adm9240_update_config(struct adm9240_data *data)
+{
+	struct i2c_client *client =3D data->client;
+	int i;
+
+	for (i =3D 0; i < 6; i++) {
+		data->in_min[i] =3D i2c_smbus_read_byte_data(client,
+				ADM9240_REG_IN_MIN(i));
+		data->in_max[i] =3D i2c_smbus_read_byte_data(client,
+				ADM9240_REG_IN_MAX(i));
+	}
+	for (i =3D 0; i < 2; i++) {
+		data->fan_min[i] =3D i2c_smbus_read_byte_data(client,
+				ADM9240_REG_FAN_MIN(i));
+	}
+	for (i =3D 0; i < 2; i++) {
+		data->temp_max[i] =3D i2c_smbus_read_byte_data(client,
+				ADM9240_REG_TEMP_MAX(i));
+	}
+
+	/* read fan divs and 5-bit VID */
+	i =3D i2c_smbus_read_byte_data(client, ADM9240_REG_VID_FAN_DIV);
+	data->fan_div[0] =3D (i >> 4) & 3;
+	data->fan_div[1] =3D (i >> 6) & 3;
+	data->vid =3D i & 0x0f;
+	data->vid |=3D (i2c_smbus_read_byte_data(client,
+				ADM9240_REG_VID4) & 1) << 4;
+	/* read analog out */
+	data->aout =3D i2c_smbus_read_byte_data(client,
+			ADM9240_REG_ANALOG_OUT);
+
+	return 0;
+}
+
+static struct adm9240_data *adm9240_update_device(struct device *dev)
+{
+	struct adm9240_data *data =3D dev_get_drvdata(dev);
+	int err;
+
 	mutex_lock(&data->update_lock);
=20
 	/* minimum measurement cycle: 1.75 seconds */
 	if (time_after(jiffies, data->last_updated_measure + (HZ * 7 / 4))
 			|| !data->valid) {
-
-		for (i =3D 0; i < 6; i++) { /* read voltages */
-			data->in[i] =3D i2c_smbus_read_byte_data(client,
-					ADM9240_REG_IN(i));
-		}
-		data->alarms =3D i2c_smbus_read_byte_data(client,
-					ADM9240_REG_INT(0)) |
-					i2c_smbus_read_byte_data(client,
-					ADM9240_REG_INT(1)) << 8;
-
-		/*
-		 * read temperature: assume temperature changes less than
-		 * 0.5'C per two measurement cycles thus ignore possible
-		 * but unlikely aliasing error on lsb reading. --Grant
-		 */
-		data->temp =3D (i2c_smbus_read_byte_data(client,
-					ADM9240_REG_TEMP) << 8) |
-					i2c_smbus_read_byte_data(client,
-					ADM9240_REG_TEMP_CONF);
-
-		for (i =3D 0; i < 2; i++) { /* read fans */
-			data->fan[i] =3D i2c_smbus_read_byte_data(client,
-					ADM9240_REG_FAN(i));
-
-			/* adjust fan clock divider on overflow */
-			if (data->valid && data->fan[i] =3D=3D 255 &&
-					data->fan_div[i] < 3) {
-
-				adm9240_write_fan_div(client, i,
-						++data->fan_div[i]);
-
-				/* adjust fan_min if active, but not to 0 */
-				if (data->fan_min[i] < 255 &&
-						data->fan_min[i] >=3D 2)
-					data->fan_min[i] /=3D 2;
-			}
+		err =3D adm9240_update_measure(data);
+		if (err < 0) {
+			data->valid =3D 0;
+			mutex_unlock(&data->update_lock);
+			return ERR_PTR(err);
 		}
 		data->last_updated_measure =3D jiffies;
 	}
@@ -212,33 +259,12 @@ static struct adm9240_data *adm9240_update_device(s=
truct device *dev)
 	/* minimum config reading cycle: 300 seconds */
 	if (time_after(jiffies, data->last_updated_config + (HZ * 300))
 			|| !data->valid) {
-
-		for (i =3D 0; i < 6; i++) {
-			data->in_min[i] =3D i2c_smbus_read_byte_data(client,
-					ADM9240_REG_IN_MIN(i));
-			data->in_max[i] =3D i2c_smbus_read_byte_data(client,
-					ADM9240_REG_IN_MAX(i));
+		err =3D adm9240_update_config(data);
+		if (err < 0) {
+			data->valid =3D 0;
+			mutex_unlock(&data->update_lock);
+			return ERR_PTR(err);
 		}
-		for (i =3D 0; i < 2; i++) {
-			data->fan_min[i] =3D i2c_smbus_read_byte_data(client,
-					ADM9240_REG_FAN_MIN(i));
-		}
-		for (i =3D 0; i < 2; i++) {
-			data->temp_max[i] =3D i2c_smbus_read_byte_data(client,
-					ADM9240_REG_TEMP_MAX(i));
-		}
-
-		/* read fan divs and 5-bit VID */
-		i =3D i2c_smbus_read_byte_data(client, ADM9240_REG_VID_FAN_DIV);
-		data->fan_div[0] =3D (i >> 4) & 3;
-		data->fan_div[1] =3D (i >> 6) & 3;
-		data->vid =3D i & 0x0f;
-		data->vid |=3D (i2c_smbus_read_byte_data(client,
-					ADM9240_REG_VID4) & 1) << 4;
-		/* read analog out */
-		data->aout =3D i2c_smbus_read_byte_data(client,
-				ADM9240_REG_ANALOG_OUT);
-
 		data->last_updated_config =3D jiffies;
 		data->valid =3D 1;
 	}
@@ -253,6 +279,10 @@ static ssize_t temp1_input_show(struct device *dev,
 				struct device_attribute *dummy, char *buf)
 {
 	struct adm9240_data *data =3D adm9240_update_device(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
 	return sprintf(buf, "%d\n", data->temp / 128 * 500); /* 9-bit value */
 }
=20
@@ -261,6 +291,10 @@ static ssize_t max_show(struct device *dev, struct d=
evice_attribute *devattr,
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
 	struct adm9240_data *data =3D adm9240_update_device(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
 	return sprintf(buf, "%d\n", data->temp_max[attr->index] * 1000);
 }
=20
@@ -295,6 +329,10 @@ static ssize_t in_show(struct device *dev, struct de=
vice_attribute *devattr,
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
 	struct adm9240_data *data =3D adm9240_update_device(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
 	return sprintf(buf, "%d\n", IN_FROM_REG(data->in[attr->index],
 				attr->index));
 }
@@ -304,6 +342,10 @@ static ssize_t in_min_show(struct device *dev,
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
 	struct adm9240_data *data =3D adm9240_update_device(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
 	return sprintf(buf, "%d\n", IN_FROM_REG(data->in_min[attr->index],
 				attr->index));
 }
@@ -313,6 +355,10 @@ static ssize_t in_max_show(struct device *dev,
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
 	struct adm9240_data *data =3D adm9240_update_device(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
 	return sprintf(buf, "%d\n", IN_FROM_REG(data->in_max[attr->index],
 				attr->index));
 }
@@ -386,6 +432,10 @@ static ssize_t fan_show(struct device *dev, struct d=
evice_attribute *devattr,
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
 	struct adm9240_data *data =3D adm9240_update_device(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
 	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[attr->index],
 				1 << data->fan_div[attr->index]));
 }
@@ -395,6 +445,10 @@ static ssize_t fan_min_show(struct device *dev,
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
 	struct adm9240_data *data =3D adm9240_update_device(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
 	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan_min[attr->index],
 				1 << data->fan_div[attr->index]));
 }
@@ -404,6 +458,10 @@ static ssize_t fan_div_show(struct device *dev,
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
 	struct adm9240_data *data =3D adm9240_update_device(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
 	return sprintf(buf, "%d\n", 1 << data->fan_div[attr->index]);
 }
=20
@@ -490,6 +548,10 @@ static ssize_t alarms_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct adm9240_data *data =3D adm9240_update_device(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
 	return sprintf(buf, "%u\n", data->alarms);
 }
 static DEVICE_ATTR_RO(alarms);
@@ -499,6 +561,10 @@ static ssize_t alarm_show(struct device *dev, struct=
 device_attribute *attr,
 {
 	int bitnr =3D to_sensor_dev_attr(attr)->index;
 	struct adm9240_data *data =3D adm9240_update_device(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
 	return sprintf(buf, "%u\n", (data->alarms >> bitnr) & 1);
 }
 static SENSOR_DEVICE_ATTR_RO(in0_alarm, alarm, 0);
@@ -516,6 +582,10 @@ static ssize_t cpu0_vid_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
 	struct adm9240_data *data =3D adm9240_update_device(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
 	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
 }
 static DEVICE_ATTR_RO(cpu0_vid);
@@ -525,6 +595,10 @@ static ssize_t aout_output_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct adm9240_data *data =3D adm9240_update_device(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
 	return sprintf(buf, "%d\n", AOUT_FROM_REG(data->aout));
 }
=20
--=20
2.28.0

