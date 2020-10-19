Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4944729314B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 00:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388245AbgJSWee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 18:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388233AbgJSWed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 18:34:33 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB57CC0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 15:34:32 -0700 (PDT)
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 1F860806B7;
        Tue, 20 Oct 2020 11:34:28 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1603146868;
        bh=EU38qN+YqCsUiqj2K33O5O6r/SOBEf0Cm79FoZmV1bQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=iPMcb/W4PyML6CeTLEIXXD+WOUTkqkPUPSHIxLiDQBZqg8A71FXHzQCWXWgYu4mZw
         o6wG14VJfxku0J4eiEx52g87A5PPtpIFzXObfJskUWNSOwv9+gVg/zXN1DZDTvtL1J
         Vm9FZUqKdARqEDKmFguY2NqwcXTmVmM9CzFhLBQytGIb3KDI768sR0RTSdo7b8LWcD
         tR0AG5DzYVS0InfLhZYtXXGv92N4g4/EYsA7wzVsb3n6lo3+StwBF9tA1Q6Mqkn9GX
         5yJnghTFW15c8ciQyDzJGG1GQlPf04p2x3n004ONuPQAQT63ihBCCoFAo189mt4WrG
         EqtGou383SyUg==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5f8e14730001>; Tue, 20 Oct 2020 11:34:27 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id A016A13EEBB;
        Tue, 20 Oct 2020 11:34:27 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id D02DD283A9C; Tue, 20 Oct 2020 11:34:27 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     jdelvare@suse.com, linux@roeck-us.net,
        Tobi Wulff <tobi.wulff@alliedtelesis.co.nz>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 1/2] hwmon: (adt7470) Create functions for updating readings and limits
Date:   Tue, 20 Oct 2020 11:34:22 +1300
Message-Id: <20201019223423.31488-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201019223423.31488-1-chris.packham@alliedtelesis.co.nz>
References: <20201019223423.31488-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split the body of adt7470_update_device() into two helper functions
adt7470_update_sensors() and adt7470_update_limits(). Although neither
of the new helpers returns an error yet lay the groundwork for
propagating failures through to the sysfs readers.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/hwmon/adt7470.c | 154 ++++++++++++++++++++++++++++++----------
 1 file changed, 118 insertions(+), 36 deletions(-)

diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
index 740f39a54ab0..2e8feacccf84 100644
--- a/drivers/hwmon/adt7470.c
+++ b/drivers/hwmon/adt7470.c
@@ -270,37 +270,11 @@ static int adt7470_update_thread(void *p)
 	return 0;
 }
=20
-static struct adt7470_data *adt7470_update_device(struct device *dev)
+static int adt7470_update_sensors(struct adt7470_data *data)
 {
-	struct adt7470_data *data =3D dev_get_drvdata(dev);
 	struct i2c_client *client =3D data->client;
-	unsigned long local_jiffies =3D jiffies;
 	u8 cfg;
 	int i;
-	int need_sensors =3D 1;
-	int need_limits =3D 1;
-
-	/*
-	 * Figure out if we need to update the shadow registers.
-	 * Lockless means that we may occasionally report out of
-	 * date data.
-	 */
-	if (time_before(local_jiffies, data->sensors_last_updated +
-			SENSOR_REFRESH_INTERVAL) &&
-	    data->sensors_valid)
-		need_sensors =3D 0;
-
-	if (time_before(local_jiffies, data->limits_last_updated +
-			LIMIT_REFRESH_INTERVAL) &&
-	    data->limits_valid)
-		need_limits =3D 0;
-
-	if (!need_sensors && !need_limits)
-		return data;
-
-	mutex_lock(&data->lock);
-	if (!need_sensors)
-		goto no_sensor_update;
=20
 	if (!data->temperatures_probed)
 		adt7470_read_temperatures(client, data);
@@ -352,12 +326,13 @@ static struct adt7470_data *adt7470_update_device(s=
truct device *dev)
 	data->alarms_mask =3D adt7470_read_word_data(client,
 						   ADT7470_REG_ALARM1_MASK);
=20
-	data->sensors_last_updated =3D local_jiffies;
-	data->sensors_valid =3D 1;
+	return 0;
+}
=20
-no_sensor_update:
-	if (!need_limits)
-		goto out;
+static int adt7470_update_limits(struct adt7470_data *data)
+{
+	struct i2c_client *client =3D data->client;
+	int i;
=20
 	for (i =3D 0; i < ADT7470_TEMP_COUNT; i++) {
 		data->temp_min[i] =3D i2c_smbus_read_byte_data(client,
@@ -382,12 +357,55 @@ static struct adt7470_data *adt7470_update_device(s=
truct device *dev)
 						ADT7470_REG_PWM_TMIN(i));
 	}
=20
-	data->limits_last_updated =3D local_jiffies;
-	data->limits_valid =3D 1;
+	return 0;
+}
=20
+static struct adt7470_data *adt7470_update_device(struct device *dev)
+{
+	struct adt7470_data *data =3D dev_get_drvdata(dev);
+	unsigned long local_jiffies =3D jiffies;
+	int need_sensors =3D 1;
+	int need_limits =3D 1;
+	int err;
+
+	/*
+	 * Figure out if we need to update the shadow registers.
+	 * Lockless means that we may occasionally report out of
+	 * date data.
+	 */
+	if (time_before(local_jiffies, data->sensors_last_updated +
+			SENSOR_REFRESH_INTERVAL) &&
+	    data->sensors_valid)
+		need_sensors =3D 0;
+
+	if (time_before(local_jiffies, data->limits_last_updated +
+			LIMIT_REFRESH_INTERVAL) &&
+	    data->limits_valid)
+		need_limits =3D 0;
+
+	if (!need_sensors && !need_limits)
+		return data;
+
+	mutex_lock(&data->lock);
+	if (need_sensors) {
+		err =3D adt7470_update_sensors(data);
+		if (err < 0)
+			goto out;
+		data->sensors_last_updated =3D local_jiffies;
+		data->sensors_valid =3D 1;
+	}
+
+	if (need_limits) {
+		err =3D adt7470_update_limits(data);
+		if (err < 0)
+			goto out;
+		data->limits_last_updated =3D local_jiffies;
+		data->limits_valid =3D 1;
+	}
 out:
 	mutex_unlock(&data->lock);
-	return data;
+
+	return err < 0 ? ERR_PTR(err) : data;
 }
=20
 static ssize_t auto_update_interval_show(struct device *dev,
@@ -395,6 +413,10 @@ static ssize_t auto_update_interval_show(struct devi=
ce *dev,
 					 char *buf)
 {
 	struct adt7470_data *data =3D adt7470_update_device(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
 	return sprintf(buf, "%d\n", data->auto_update_interval);
 }
=20
@@ -422,6 +444,10 @@ static ssize_t num_temp_sensors_show(struct device *=
dev,
 				     char *buf)
 {
 	struct adt7470_data *data =3D adt7470_update_device(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
 	return sprintf(buf, "%d\n", data->num_temp_sensors);
 }
=20
@@ -451,6 +477,10 @@ static ssize_t temp_min_show(struct device *dev,
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
 	struct adt7470_data *data =3D adt7470_update_device(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
 	return sprintf(buf, "%d\n", 1000 * data->temp_min[attr->index]);
 }
=20
@@ -483,6 +513,10 @@ static ssize_t temp_max_show(struct device *dev,
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
 	struct adt7470_data *data =3D adt7470_update_device(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
 	return sprintf(buf, "%d\n", 1000 * data->temp_max[attr->index]);
 }
=20
@@ -515,6 +549,10 @@ static ssize_t temp_show(struct device *dev, struct =
device_attribute *devattr,
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
 	struct adt7470_data *data =3D adt7470_update_device(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
 	return sprintf(buf, "%d\n", 1000 * data->temp[attr->index]);
 }
=20
@@ -524,6 +562,9 @@ static ssize_t alarm_mask_show(struct device *dev,
 {
 	struct adt7470_data *data =3D adt7470_update_device(dev);
=20
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
 	return sprintf(buf, "%x\n", data->alarms_mask);
 }
=20
@@ -554,6 +595,9 @@ static ssize_t fan_max_show(struct device *dev,
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
 	struct adt7470_data *data =3D adt7470_update_device(dev);
=20
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
 	if (FAN_DATA_VALID(data->fan_max[attr->index]))
 		return sprintf(buf, "%d\n",
 			       FAN_PERIOD_TO_RPM(data->fan_max[attr->index]));
@@ -590,6 +634,9 @@ static ssize_t fan_min_show(struct device *dev,
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
 	struct adt7470_data *data =3D adt7470_update_device(dev);
=20
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
 	if (FAN_DATA_VALID(data->fan_min[attr->index]))
 		return sprintf(buf, "%d\n",
 			       FAN_PERIOD_TO_RPM(data->fan_min[attr->index]));
@@ -626,6 +673,9 @@ static ssize_t fan_show(struct device *dev, struct de=
vice_attribute *devattr,
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
 	struct adt7470_data *data =3D adt7470_update_device(dev);
=20
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
 	if (FAN_DATA_VALID(data->fan[attr->index]))
 		return sprintf(buf, "%d\n",
 			       FAN_PERIOD_TO_RPM(data->fan[attr->index]));
@@ -637,6 +687,10 @@ static ssize_t force_pwm_max_show(struct device *dev=
,
 				  struct device_attribute *devattr, char *buf)
 {
 	struct adt7470_data *data =3D adt7470_update_device(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
 	return sprintf(buf, "%d\n", data->force_pwm_max);
 }
=20
@@ -670,6 +724,10 @@ static ssize_t pwm_show(struct device *dev, struct d=
evice_attribute *devattr,
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
 	struct adt7470_data *data =3D adt7470_update_device(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
 	return sprintf(buf, "%d\n", data->pwm[attr->index]);
 }
=20
@@ -763,6 +821,10 @@ static ssize_t pwm_max_show(struct device *dev,
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
 	struct adt7470_data *data =3D adt7470_update_device(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
 	return sprintf(buf, "%d\n", data->pwm_max[attr->index]);
 }
=20
@@ -794,6 +856,10 @@ static ssize_t pwm_min_show(struct device *dev,
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
 	struct adt7470_data *data =3D adt7470_update_device(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
 	return sprintf(buf, "%d\n", data->pwm_min[attr->index]);
 }
=20
@@ -825,6 +891,10 @@ static ssize_t pwm_tmax_show(struct device *dev,
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
 	struct adt7470_data *data =3D adt7470_update_device(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
 	/* the datasheet says that tmax =3D tmin + 20C */
 	return sprintf(buf, "%d\n", 1000 * (20 + data->pwm_tmin[attr->index]));
 }
@@ -834,6 +904,10 @@ static ssize_t pwm_tmin_show(struct device *dev,
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
 	struct adt7470_data *data =3D adt7470_update_device(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
 	return sprintf(buf, "%d\n", 1000 * data->pwm_tmin[attr->index]);
 }
=20
@@ -866,6 +940,10 @@ static ssize_t pwm_auto_show(struct device *dev,
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
 	struct adt7470_data *data =3D adt7470_update_device(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
 	return sprintf(buf, "%d\n", 1 + data->pwm_automatic[attr->index]);
 }
=20
@@ -911,8 +989,12 @@ static ssize_t pwm_auto_temp_show(struct device *dev=
,
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
 	struct adt7470_data *data =3D adt7470_update_device(dev);
-	u8 ctrl =3D data->pwm_auto_temp[attr->index];
+	u8 ctrl;
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
=20
+	ctrl =3D data->pwm_auto_temp[attr->index];
 	if (ctrl)
 		return sprintf(buf, "%d\n", 1 << (ctrl - 1));
 	else
--=20
2.28.0

