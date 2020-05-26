Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B478E1CE5B6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 22:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731780AbgEKUhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 16:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729846AbgEKUhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:37:38 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F472C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 13:37:37 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id m24so9860548wml.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 13:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zwPM4CBdeKih2C+OJM7Sir4vxzDvnL4F9Yt0AXfN6i8=;
        b=iS92wYf6QFibOHIP0gapdp/NVRfPS4pIDzLwx2p4ZcTpGuPYq8PQnaBUjjHse2SFKD
         61Q4GVlkeKxp3wxnZBfL/0xw5AJRD1ei/CBgpsZPl+aFWkRBx72tIJaV756a5oc2lOkI
         6WVlO6LVPdLNi0x92BibS2/TyT7FWFgZypruW3EmWqGtBDZMXVURZmgj8zFbBvNIq3JY
         5r21DNXmh4Tyl00wyRWKyAFlYuUMBllartIJ2xpcgIdAOezIxa9R0N1WgiyZy5sqqW4G
         2GjI9Xbig26T8XrGpSvwiMcaOaY1kn5f8SjXq0b9GguO8+2NQIU3JYDzYnWjJ/m7MP5l
         JyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zwPM4CBdeKih2C+OJM7Sir4vxzDvnL4F9Yt0AXfN6i8=;
        b=P4Kb3YE79ROJNKlhQnpfGa8I2/OxYejB6WbMRbAnhjlp6440oHPy6sxB22WKlLzrov
         7iY258UWig7q5gjZByA3+72/F/cJqwD9tDH17TqgRzzmAxQl9Njhm99h0669YVQuY/3R
         M9QrZiK7N/i4EYIG/tTbGac786a155nml9SiQrIp2xSqlgm3/g2MtZAFGA1EPOh5R2/9
         ZakOxCiq3lk5g2IjJrvdQaKE76nccoTRLbX6hIfZJLUh7fMu7wN5PGYrMGyY/J54YZM2
         yVoSuZgpHTQU9+74LbWTOVUn/m/IEzeNpiyW3/hkgK/JnBPYX9xGlAVXfB4cz3P8Hn+7
         sAGw==
X-Gm-Message-State: AGi0PuZo5QvgJQotES6Q9NNUg9UGzxFXdr1paCwGOcAGt4lxs9/XZygt
        qarphZBKXjaMuoP7p9wkmDbtK5JL
X-Google-Smtp-Source: APiQypKArOteYE/UY8SupiPa12+TWO4FNZPnFWusxgpIDXPyUlWASktjgvwyxkCvhtyznMGx9Vb74A==
X-Received: by 2002:a1c:e903:: with SMTP id q3mr32365949wmc.76.1589229455893;
        Mon, 11 May 2020 13:37:35 -0700 (PDT)
Received: from akira-laptop.home ([2a01:cb19:8b28:7600:a0b9:1c6f:cfba:2b21])
        by smtp.googlemail.com with ESMTPSA id h188sm30815313wme.8.2020.05.11.13.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 13:37:35 -0700 (PDT)
From:   Akira Shimahara <akira215corp@gmail.com>
To:     greg@kroah.com, rdunlap@infradead.org
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org,
        Akira Shimahara <akira215corp@gmail.com>
Subject: [PATCH v7 6/9] w1_therm: adding eeprom sysfs entry
Date:   Mon, 11 May 2020 22:37:25 +0200
Message-Id: <20200511203725.410844-1-akira215corp@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver implement 2 hardware functions to access device RAM:
 * copy_scratchpad
 * recall_scratchpad
They act according to device specifications.

As EEPROM operations are not device dependent (all w1_therm can perform
EEPROM read/write operation following the same protocol), it is removed
from device families structures.

Updating Documentation/ABI/testing/sysfs-driver-w1_therm accordingly.

Signed-off-by: Akira Shimahara <akira215corp@gmail.com>
---
Changes in v5:
- All patch serie in one .c file
- Correcting some comments
- adding <linux/string.h> include
Changes in v6:
- Formatting code comments according to kernel-doc requirements
Changes in v7:
- Formatting code comments and correcting comments mistakes

 .../ABI/testing/sysfs-driver-w1_therm         |  14 ++
 drivers/w1/slaves/w1_therm.c                  | 175 ++++++++++++------
 2 files changed, 132 insertions(+), 57 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-w1_therm b/Documentation/ABI/testing/sysfs-driver-w1_therm
index 7ed95e9..8b7ee89 100644
--- a/Documentation/ABI/testing/sysfs-driver-w1_therm
+++ b/Documentation/ABI/testing/sysfs-driver-w1_therm
@@ -1,3 +1,17 @@
+What:		/sys/bus/w1/devices/.../eeprom
+Date:		May 2020
+Contact:	Akira Shimahara <akira215corp@gmail.com>
+Description:
+		(WO) writing that file will either trigger a save of the
+		device data to its embedded EEPROM, either restore data
+		embedded in device EEPROM. Be aware that devices support
+		limited EEPROM writing cycles (typical 50k)
+			* 'save': save device RAM to EEPROM
+			* 'restore': restore EEPROM data in device RAM
+Users:		any user space application which wants to communicate with
+		w1_term device
+
+
 What:		/sys/bus/w1/devices/.../ext_power
 Date:		May 2020
 Contact:	Akira Shimahara <akira215corp@gmail.com>
diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index e30dab8..957b503 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -43,12 +43,21 @@
 static int w1_strong_pullup = 1;
 module_param_named(strong_pullup, w1_strong_pullup, int, 0);
 
+/* This command should be in public header w1.h but is not */
+#define W1_RECALL_EEPROM	0xB8
+
 /* Nb of try for an operation */
 #define W1_THERM_MAX_TRY		5
 
 /* ms delay to retry bus mutex */
 #define W1_THERM_RETRY_DELAY		20
 
+/* delay in ms to write in EEPROM */
+#define W1_THERM_EEPROM_WRITE_DELAY	10
+
+#define EEPROM_CMD_WRITE    "save"	/* cmd for write eeprom sysfs */
+#define EEPROM_CMD_READ     "restore"	/* cmd for read eeprom sysfs */
+
 /* Helpers Macros */
 
 /*
@@ -86,7 +95,6 @@ module_param_named(strong_pullup, w1_strong_pullup, int, 0);
  * @convert: pointer to the device conversion function
  * @set_resolution: pointer to the device set_resolution function
  * @get_resolution: pointer to the device get_resolution function
- * @eeprom: pointer to eeprom function
  */
 struct w1_therm_family_converter {
 	u8		broken;
@@ -95,7 +103,6 @@ struct w1_therm_family_converter {
 	int		(*convert)(u8 rom[9]);
 	int		(*set_resolution)(struct w1_slave *sl, int val);
 	int		(*get_resolution)(struct w1_slave *sl);
-	int		(*eeprom)(struct device *device);
 };
 
 /**
@@ -165,6 +172,22 @@ static int read_scratchpad(struct w1_slave *sl, struct therm_info *info);
  */
 static int write_scratchpad(struct w1_slave *sl, const u8 *data, u8 nb_bytes);
 
+/**
+ * copy_scratchpad() - Copy the content of scratchpad in device EEPROM
+ * @sl: slave involved
+ *
+ * Return: 0 if success, -kernel error code otherwise
+ */
+static int copy_scratchpad(struct w1_slave *sl);
+
+/**
+ * recall_eeprom() - Restore EEPROM data to device RAM
+ * @sl: slave involved
+ *
+ * Return: 0 if success, -kernel error code otherwise
+ */
+static int recall_eeprom(struct w1_slave *sl);
+
 /**
  * read_powermode() - Query the power mode of the slave
  * @sl: slave to retrieve the power mode
@@ -199,12 +222,16 @@ static ssize_t resolution_show(struct device *device,
 static ssize_t resolution_store(struct device *device,
 	struct device_attribute *attr, const char *buf, size_t size);
 
+static ssize_t eeprom_store(struct device *device,
+	struct device_attribute *attr, const char *buf, size_t size);
+
 /* Attributes declarations */
 
 static DEVICE_ATTR_RW(w1_slave);
 static DEVICE_ATTR_RO(w1_seq);
 static DEVICE_ATTR_RO(ext_power);
 static DEVICE_ATTR_RW(resolution);
+static DEVICE_ATTR_WO(eeprom);
 
 /* Interface Functions declaration */
 
@@ -234,12 +261,14 @@ static struct attribute *w1_therm_attrs[] = {
 	&dev_attr_w1_slave.attr,
 	&dev_attr_ext_power.attr,
 	&dev_attr_resolution.attr,
+	&dev_attr_eeprom.attr,
 	NULL,
 };
 
 static struct attribute *w1_ds18s20_attrs[] = {
 	&dev_attr_w1_slave.attr,
 	&dev_attr_ext_power.attr,
+	&dev_attr_eeprom.attr,
 	NULL,
 };
 
@@ -248,6 +277,7 @@ static struct attribute *w1_ds28ea00_attrs[] = {
 	&dev_attr_w1_seq.attr,
 	&dev_attr_ext_power.attr,
 	&dev_attr_resolution.attr,
+	&dev_attr_eeprom.attr,
 	NULL,
 };
 
@@ -359,9 +389,6 @@ static struct w1_family w1_therm_family_DS1825 = {
 
 /* Device dependent func */
 
-/* write configuration to eeprom */
-static inline int w1_therm_eeprom(struct device *device);
-
 static inline int w1_DS18B20_write_data(struct w1_slave *sl,
 				const u8 *data)
 {
@@ -477,35 +504,30 @@ static struct w1_therm_family_converter w1_therm_families[] = {
 		.convert	= w1_DS18S20_convert_temp,
 		.set_resolution	= NULL,	/* no config register */
 		.get_resolution	= NULL,	/* no config register */
-		.eeprom		= w1_therm_eeprom
 	},
 	{
 		.f		= &w1_therm_family_DS1822,
 		.convert	= w1_DS18B20_convert_temp,
 		.set_resolution	= w1_DS18B20_set_resolution,
 		.get_resolution	= w1_DS18B20_get_resolution,
-		.eeprom		= w1_therm_eeprom
 	},
 	{
 		.f		= &w1_therm_family_DS18B20,
 		.convert	= w1_DS18B20_convert_temp,
 		.set_resolution	= w1_DS18B20_set_resolution,
 		.get_resolution	= w1_DS18B20_get_resolution,
-		.eeprom		= w1_therm_eeprom
 	},
 	{
 		.f		= &w1_therm_family_DS28EA00,
 		.convert	= w1_DS18B20_convert_temp,
 		.set_resolution	= w1_DS18B20_set_resolution,
 		.get_resolution	= w1_DS18B20_get_resolution,
-		.eeprom		= w1_therm_eeprom
 	},
 	{
 		.f		= &w1_therm_family_DS1825,
 		.convert	= w1_DS18B20_convert_temp,
 		.set_resolution	= w1_DS18B20_set_resolution,
 		.get_resolution	= w1_DS18B20_get_resolution,
-		.eeprom		= w1_therm_eeprom
 	}
 };
 
@@ -838,75 +860,94 @@ error:
 	return ret;
 }
 
-static inline int w1_therm_eeprom(struct device *device)
+static int copy_scratchpad(struct w1_slave *sl)
 {
-	struct w1_slave *sl = dev_to_w1_slave(device);
-	struct w1_master *dev = sl->master;
-	u8 rom[9], external_power;
-	int ret, max_trying = 10;
-	u8 *family_data = sl->family_data;
+	struct w1_master *dev_master = sl->master;
+	int max_trying = W1_THERM_MAX_TRY;
+	int t_write, ret = -ENODEV;
+	bool strong_pullup;
 
-	if (!sl->family_data) {
-		ret = -ENODEV;
+	if (!sl->family_data)
 		goto error;
-	}
+
+	t_write = W1_THERM_EEPROM_WRITE_DELAY;
+	strong_pullup = (w1_strong_pullup == 2 ||
+					(!SLAVE_POWERMODE(sl) &&
+					w1_strong_pullup));
 
 	/* prevent the slave from going away in sleep */
-	atomic_inc(THERM_REFCNT(family_data));
+	atomic_inc(THERM_REFCNT(sl->family_data));
 
-	ret = mutex_lock_interruptible(&dev->bus_mutex);
-	if (ret != 0)
+	if (!bus_mutex_lock(&dev_master->bus_mutex)) {
+		ret = -EAGAIN;	/* Didn't acquire the mutex */
 		goto dec_refcnt;
+	}
 
-	memset(rom, 0, sizeof(rom));
-
-	while (max_trying--) {
+	while (max_trying-- && ret) { /* ret should be 0 */
+		/* safe version to select slave */
 		if (!reset_select_slave(sl)) {
-			unsigned int tm = 10;
 			unsigned long sleep_rem;
 
-			/* check if in parasite mode */
-			w1_write_8(dev, W1_READ_PSUPPLY);
-			external_power = w1_read_8(dev);
-
-			if (reset_select_slave(sl))
-				continue;
-
-			/* 10ms strong pullup/delay after the copy command */
-			if (w1_strong_pullup == 2 ||
-			    (!external_power && w1_strong_pullup))
-				w1_next_pullup(dev, tm);
+			/* 10ms strong pullup (or delay) after the convert */
+			if (strong_pullup)
+				w1_next_pullup(dev_master, t_write);
 
-			w1_write_8(dev, W1_COPY_SCRATCHPAD);
-
-			if (external_power) {
-				mutex_unlock(&dev->bus_mutex);
+			w1_write_8(dev_master, W1_COPY_SCRATCHPAD);
 
-				sleep_rem = msleep_interruptible(tm);
-				if (sleep_rem != 0) {
-					ret = -EINTR;
-					goto dec_refcnt;
-				}
-
-				ret = mutex_lock_interruptible(&dev->bus_mutex);
-				if (ret != 0)
-					goto dec_refcnt;
-			} else if (!w1_strong_pullup) {
-				sleep_rem = msleep_interruptible(tm);
+			if (strong_pullup) {
+				sleep_rem = msleep_interruptible(t_write);
 				if (sleep_rem != 0) {
 					ret = -EINTR;
 					goto mt_unlock;
 				}
 			}
-
-			break;
+			ret = 0;
 		}
+
 	}
 
 mt_unlock:
-	mutex_unlock(&dev->bus_mutex);
+	mutex_unlock(&dev_master->bus_mutex);
 dec_refcnt:
-	atomic_dec(THERM_REFCNT(family_data));
+	atomic_dec(THERM_REFCNT(sl->family_data));
+error:
+	return ret;
+}
+
+static int recall_eeprom(struct w1_slave *sl)
+{
+	struct w1_master *dev_master = sl->master;
+	int max_trying = W1_THERM_MAX_TRY;
+	int ret = -ENODEV;
+
+	if (!sl->family_data)
+		goto error;
+
+	/* prevent the slave from going away in sleep */
+	atomic_inc(THERM_REFCNT(sl->family_data));
+
+	if (!bus_mutex_lock(&dev_master->bus_mutex)) {
+		ret = -EAGAIN;	/* Didn't acquire the mutex */
+		goto dec_refcnt;
+	}
+
+	while (max_trying-- && ret) { /* ret should be 0 */
+		/* safe version to select slave */
+		if (!reset_select_slave(sl)) {
+
+			w1_write_8(dev_master, W1_RECALL_EEPROM);
+
+			ret = 1; /* Slave will pull line to 0 */
+			while (ret)
+				ret = 1 - w1_touch_bit(dev_master, 1);
+		}
+
+	}
+
+	mutex_unlock(&dev_master->bus_mutex);
+
+dec_refcnt:
+	atomic_dec(THERM_REFCNT(sl->family_data));
 error:
 	return ret;
 }
@@ -1006,7 +1047,7 @@ static ssize_t w1_slave_store(struct device *device,
 	}
 
 	if (val == 0)	/* val=0 : trigger a EEPROM save */
-		ret = SLAVE_SPECIFIC_FUNC(sl)->eeprom(device);
+		ret = copy_scratchpad(sl);
 	else {
 		if (SLAVE_SPECIFIC_FUNC(sl)->set_resolution)
 			ret = SLAVE_SPECIFIC_FUNC(sl)->set_resolution(sl, val);
@@ -1105,6 +1146,26 @@ static ssize_t resolution_store(struct device *device,
 	return size;
 }
 
+static ssize_t eeprom_store(struct device *device,
+	struct device_attribute *attr, const char *buf, size_t size)
+{
+	struct w1_slave *sl = dev_to_w1_slave(device);
+	int ret = -EINVAL; /* Invalid argument */
+
+	if (size == sizeof(EEPROM_CMD_WRITE)) {
+		if (!strncmp(buf, EEPROM_CMD_WRITE, sizeof(EEPROM_CMD_WRITE)-1))
+			ret = copy_scratchpad(sl);
+	} else if (size == sizeof(EEPROM_CMD_READ)) {
+		if (!strncmp(buf, EEPROM_CMD_READ, sizeof(EEPROM_CMD_READ)-1))
+			ret = recall_eeprom(sl);
+	}
+
+	if (ret)
+		dev_info(device, "%s: error in process %d\n", __func__, ret);
+
+	return size;
+}
+
 #if IS_REACHABLE(CONFIG_HWMON)
 static int w1_read_temp(struct device *device, u32 attr, int channel,
 			long *val)
-- 
2.26.2

