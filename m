Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6BE41CC5A8
	for <lists+linux-kernel@lfdr.de>; Sun, 10 May 2020 02:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgEJAC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 May 2020 20:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726026AbgEJAC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 20:02:27 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FA8C061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 17:02:25 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z8so6335518wrw.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 17:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fQzGy3v9hKaT3BaEQfeDFwhae5OJF4kM7SRTGmxroKo=;
        b=dHFzB357zh2xfWscpNqBxQ2GdJYUM2q98zdT/fq6kJpUw8VqPQotY/QFufJ0ZcVeHd
         /jh2NHGKWTJGspUBmPIEyPwnEIExOYmR9LVjGfB+zuNDBKzzgO4P5o4I7FoT4XDr6mF4
         AXTgCjLLlzK8US+bGeeliKAZ2l7clp8UiHXaJZ9/OCqTg1UT6M35iI2Ok26Z+CYao+BW
         m62W9dYOvWkzlss54bQPnqRNCsJkFQjPkbmDdcwO8KyOjdxKKqEbrq/QaRLRbhIgTJ19
         k94/UvqCJI22xVK9N3l02hFg/iU+eIrmOEO7oKPtR50+Zzo3WZma8/0ytoOkAU2+KpUr
         0NSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fQzGy3v9hKaT3BaEQfeDFwhae5OJF4kM7SRTGmxroKo=;
        b=gZrtg/A7O8334/FXRwYiD9dzvL9isu0ioozlglYzmStm0CSGJXuv4nwSXkOuRNq83H
         V+U9KAEelbP4gBXPtPl7dv+KxOPWkdxLkoj8WwRpyljODz5QG5IGj4Dz8FVJiTNe5qsC
         q+pFIR47Sd5+ugH/hByeptdD/5R8oMHv/eXEV+YfuypcvyMWyaf/tDtPMHcDeZlbnUSQ
         754YEcQffXLNUYRwHfoHsV5Kdo/+5B94Ibs9QNCxhdEmg/r0CBs/ezK0A81fpuQUwL6k
         u7JukmVy5UAarxSOLvPKb+lWhGdWXswbft8LeFJ5zp887SP1tCHIYYDiCJHFwv9orkcf
         nb0w==
X-Gm-Message-State: AGi0PuZbTN7rAEiu7O4gVmhwnO1Zz12h0P9Fp9aB317aZuXCBMecbdbq
        FiL9piko5qEvBzmqGsOo2ro=
X-Google-Smtp-Source: APiQypKm2+Z6RZ28WstX+8TMRgW5TciCb1cn+mRfSdlAX2JXxzFG0CjDR1R8OePEsmjZimN5qbE60Q==
X-Received: by 2002:adf:ec09:: with SMTP id x9mr10635246wrn.21.1589068944008;
        Sat, 09 May 2020 17:02:24 -0700 (PDT)
Received: from akira-laptop.home ([2a01:cb19:8b28:7600:48ff:3af:e1d8:fd19])
        by smtp.googlemail.com with ESMTPSA id a67sm21081186wmc.30.2020.05.09.17.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2020 17:02:23 -0700 (PDT)
From:   Akira Shimahara <akira215corp@gmail.com>
To:     greg@kroah.com
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org,
        Akira Shimahara <akira215corp@gmail.com>
Subject: [PATCH v5 7/9] w1_therm: optimizing temperature read timings
Date:   Sun, 10 May 2020 02:02:16 +0200
Message-Id: <20200510000216.425295-1-akira215corp@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Optimizing temperature reading by reducing waiting conversion time
according to device resolution settings, as per device specification.
This is device dependent as not all the devices supports resolution
setting, so it has been added in device family structures.

The process to read the temperature on the device has been adapted in a
new function 'convert_t()', which replace the former 'read_therm()', is
introduce to deal with this timing. Strong pull up is also applied during
the required time, according to device power status needs and
'strong_pullup' module parameter.

'temperature_from_RAM()' function is introduced to get the correct
temperature computation (device dependent) from device RAM data.

An new sysfs entry has been added to ouptut only temperature. The old
entry w1_slave has been kept for compatibility, without changing its
output format.

Updating Documentation/ABI/testing/sysfs-driver-w1_therm accordingly.

Signed-off-by: Akira Shimahara <akira215corp@gmail.com>
---
Changes in v5:
- All patch serie in one .c file
- Correcting some comments
- adding <linux/string.h> include

 .../ABI/testing/sysfs-driver-w1_therm         |  12 +
 drivers/w1/slaves/w1_therm.c                  | 278 ++++++++++++------
 2 files changed, 195 insertions(+), 95 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-w1_therm b/Documentation/ABI/testing/sysfs-driver-w1_therm
index 8b7ee89..6ffd3e3 100644
--- a/Documentation/ABI/testing/sysfs-driver-w1_therm
+++ b/Documentation/ABI/testing/sysfs-driver-w1_therm
@@ -41,6 +41,18 @@ Users:		any user space application which wants to communicate with
 		w1_term device
 
 
+What:		/sys/bus/w1/devices/.../temperature
+Date:		May 2020
+Contact:	Akira Shimahara <akira215corp@gmail.com>
+Description:
+		(RO) return the temperature in 1/1000 degC.
+		Note that the conversion duration depend on the resolution (if
+		device support this feature). It takes 94ms in 9bits
+		resolution, 750ms for 12bits.
+Users:		any user space application which wants to communicate with
+		w1_term device
+
+
 What:		/sys/bus/w1/devices/.../w1_slave
 Date:		May 2020
 Contact:	Akira Shimahara <akira215corp@gmail.com>
diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index d3f83f8..2955cae 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -94,6 +94,7 @@ struct w1_therm_family_converter {
 	u16		reserved;
 	struct w1_family	*f;
 	int		(*convert)(u8 rom[9]);
+	int		(*get_conversion_time)(struct w1_slave *sl);
 	int		(*set_resolution)(struct w1_slave *sl, int val);
 	int		(*get_resolution)(struct w1_slave *sl);
 };
@@ -144,6 +145,13 @@ struct therm_info {
  */
 static int reset_select_slave(struct w1_slave *sl);
 
+/** convert_t()
+ * \param sl pointer to the slave to read
+ * \param info pointer to a structure to store the read results
+ * \return 0 if success, -kernel error code otherwise
+ */
+static int convert_t(struct w1_slave *sl, struct therm_info *info);
+
 /** read_scratchpad()
  * \param sl pointer to the slave to read
  * \param info pointer to a structure to store the read results
@@ -201,6 +209,15 @@ static ssize_t w1_slave_store(struct device *device,
 static ssize_t w1_seq_show(struct device *device,
 	struct device_attribute *attr, char *buf);
 
+/** \brief A callback function to output the temperature
+ *  Main differences with w1_slave :
+ *	No hardware check (just read the stored device infos)
+ *	No formatting
+ *  \return temperature (1/1000°)
+ */
+static ssize_t temperature_show(struct device *device,
+	struct device_attribute *attr, char *buf);
+
 /** \brief A callback function to output the power mode of the device
  *	Once done, it is stored in the sl->family_data to avoid doing the test
  *	during data read
@@ -235,6 +252,7 @@ static ssize_t eeprom_store(struct device *device,
 
 static DEVICE_ATTR_RW(w1_slave);
 static DEVICE_ATTR_RO(w1_seq);
+static DEVICE_ATTR_RO(temperature);
 static DEVICE_ATTR_RO(ext_power);
 static DEVICE_ATTR_RW(resolution);
 static DEVICE_ATTR_WO(eeprom);
@@ -258,6 +276,7 @@ static void w1_therm_remove_slave(struct w1_slave *sl);
 
 static struct attribute *w1_therm_attrs[] = {
 	&dev_attr_w1_slave.attr,
+	&dev_attr_temperature.attr,
 	&dev_attr_ext_power.attr,
 	&dev_attr_resolution.attr,
 	&dev_attr_eeprom.attr,
@@ -266,6 +285,7 @@ static struct attribute *w1_therm_attrs[] = {
 
 static struct attribute *w1_ds18s20_attrs[] = {
 	&dev_attr_w1_slave.attr,
+	&dev_attr_temperature.attr,
 	&dev_attr_ext_power.attr,
 	&dev_attr_eeprom.attr,
 	NULL,
@@ -274,6 +294,7 @@ static struct attribute *w1_ds18s20_attrs[] = {
 static struct attribute *w1_ds28ea00_attrs[] = {
 	&dev_attr_w1_slave.attr,
 	&dev_attr_w1_seq.attr,
+	&dev_attr_temperature.attr,
 	&dev_attr_ext_power.attr,
 	&dev_attr_resolution.attr,
 	&dev_attr_eeprom.attr,
@@ -388,6 +409,37 @@ static struct w1_family w1_therm_family_DS1825 = {
 
 /*----------------------------Device dependent func-------------------------*/
 
+static inline int w1_DS18B20_convert_time(struct w1_slave *sl)
+{
+	int ret;
+
+	if (!sl->family_data)
+		return -ENODEV;	/* device unknown */
+
+	/* return time in ms for conversion operation */
+	switch (SLAVE_RESOLUTION(sl)) {
+	case 9:
+		ret = 95;
+		break;
+	case 10:
+		ret = 190;
+		break;
+	case 11:
+		ret = 375;
+		break;
+	case 12:
+	default:
+		ret = 750;
+	}
+	return ret;
+}
+
+static inline int w1_DS18S20_convert_time(struct w1_slave *sl)
+{
+	(void)(sl);
+	return 750; /* always 750ms for DS18S20 */
+}
+
 static inline int w1_DS18B20_write_data(struct w1_slave *sl,
 				const u8 *data)
 {
@@ -464,8 +516,10 @@ static inline int w1_DS18S20_convert_temp(u8 rom[9])
 {
 	int t, h;
 
-	if (!rom[7])
+	if (!rom[7]) {
+		pr_debug("%s: Invalid argument for conversion\n", __func__);
 		return 0;
+	}
 
 	if (rom[1] == 0)
 		t = ((s32)rom[0] >> 1)*1000;
@@ -484,34 +538,39 @@ static inline int w1_DS18S20_convert_temp(u8 rom[9])
 
 static struct w1_therm_family_converter w1_therm_families[] = {
 	{
-		.f		= &w1_therm_family_DS18S20,
-		.convert	= w1_DS18S20_convert_temp,
-		.set_resolution	= NULL,	// no config register
-		.get_resolution	= NULL,	// no config register
+		.f				= &w1_therm_family_DS18S20,
+		.convert			= w1_DS18S20_convert_temp,
+		.get_conversion_time	= w1_DS18S20_convert_time,
+		.set_resolution		= NULL,	// no config register
+		.get_resolution		= NULL,	// no config register
 	},
 	{
-		.f		= &w1_therm_family_DS1822,
-		.convert	= w1_DS18B20_convert_temp,
-		.set_resolution	= w1_DS18B20_set_resolution,
-		.get_resolution	= w1_DS18B20_get_resolution,
+		.f				= &w1_therm_family_DS1822,
+		.convert			= w1_DS18B20_convert_temp,
+		.get_conversion_time	= w1_DS18B20_convert_time,
+		.set_resolution		= w1_DS18B20_set_resolution,
+		.get_resolution		= w1_DS18B20_get_resolution,
 	},
 	{
-		.f		= &w1_therm_family_DS18B20,
-		.convert	= w1_DS18B20_convert_temp,
-		.set_resolution	= w1_DS18B20_set_resolution,
-		.get_resolution	= w1_DS18B20_get_resolution,
+		.f				= &w1_therm_family_DS18B20,
+		.convert			= w1_DS18B20_convert_temp,
+		.get_conversion_time	= w1_DS18B20_convert_time,
+		.set_resolution		= w1_DS18B20_set_resolution,
+		.get_resolution		= w1_DS18B20_get_resolution,
 	},
 	{
-		.f		= &w1_therm_family_DS28EA00,
-		.convert	= w1_DS18B20_convert_temp,
-		.set_resolution	= w1_DS18B20_set_resolution,
-		.get_resolution	= w1_DS18B20_get_resolution,
+		.f				= &w1_therm_family_DS28EA00,
+		.convert			= w1_DS18B20_convert_temp,
+		.get_conversion_time	= w1_DS18B20_convert_time,
+		.set_resolution		= w1_DS18B20_set_resolution,
+		.get_resolution		= w1_DS18B20_get_resolution,
 	},
 	{
-		.f		= &w1_therm_family_DS1825,
-		.convert	= w1_DS18B20_convert_temp,
-		.set_resolution	= w1_DS18B20_set_resolution,
-		.get_resolution	= w1_DS18B20_get_resolution,
+		.f				= &w1_therm_family_DS1825,
+		.convert			= w1_DS18B20_convert_temp,
+		.get_conversion_time	= w1_DS18B20_convert_time,
+		.set_resolution		= w1_DS18B20_set_resolution,
+		.get_resolution		= w1_DS18B20_get_resolution,
 	}
 };
 
@@ -560,15 +619,36 @@ static inline bool bus_mutex_lock(struct mutex *lock)
 	return true;
 }
 
-static inline int w1_convert_temp(u8 rom[9], u8 fid)
+/** conversion_time() get the Tconv for the slave
+ *  \param sl device to get the conversion time
+ *  \return conversion time in ms, negative values kernel error code
+ */
+static inline int conversion_time(struct w1_slave *sl)
+{
+	if (SLAVE_SPECIFIC_FUNC(sl))
+		return SLAVE_SPECIFIC_FUNC(sl)->get_conversion_time(sl);
+
+	dev_info(&sl->dev,
+		"%s: Device not supported by the driver\n", __func__);
+
+	return -ENODEV;  /* No device family */
+}
+
+/** temperature_from_RAM() return the temperature in 1/100°
+ *  \brief Device dependent, it will select the correct computation method
+ *  \param sl device that sent the RAM data
+ *  \param rom ram read value
+ *  \return temperature in 1/1000°
+ */
+static inline int temperature_from_RAM(struct w1_slave *sl, u8 rom[9])
 {
-	int i;
+	if (SLAVE_SPECIFIC_FUNC(sl))
+		return SLAVE_SPECIFIC_FUNC(sl)->convert(rom);
 
-	for (i = 0; i < ARRAY_SIZE(w1_therm_families); ++i)
-		if (w1_therm_families[i].f->fid == fid)
-			return w1_therm_families[i].convert(rom);
+	dev_info(&sl->dev,
+		"%s: Device not supported by the driver\n", __func__);
 
-	return 0;
+	return 0;  /* No device family */
 }
 
 /*-------------------------Interface Functions------------------------------*/
@@ -647,96 +727,74 @@ static int reset_select_slave(struct w1_slave *sl)
 	return 0;
 }
 
-static ssize_t read_therm(struct device *device,
-			  struct w1_slave *sl, struct therm_info *info)
+static int convert_t(struct w1_slave *sl, struct therm_info *info)
 {
-	struct w1_master *dev = sl->master;
-	u8 external_power;
-	int ret, max_trying = 10;
-	u8 *family_data = sl->family_data;
+	struct w1_master *dev_master = sl->master;
+	int max_trying = W1_THERM_MAX_TRY;
+	int t_conv;
+	int ret = -ENODEV;
+	bool strong_pullup;
 
-	if (!family_data) {
-		ret = -ENODEV;
+	if (!sl->family_data)
 		goto error;
-	}
 
-	/* prevent the slave from going away in sleep */
-	atomic_inc(THERM_REFCNT(family_data));
+	strong_pullup = (w1_strong_pullup == 2 ||
+					(!SLAVE_POWERMODE(sl) &&
+					w1_strong_pullup));
 
-	ret = mutex_lock_interruptible(&dev->bus_mutex);
-	if (ret != 0)
-		goto dec_refcnt;
+	/* get conversion duration device and id dependent */
+	t_conv = conversion_time(sl);
 
 	memset(info->rom, 0, sizeof(info->rom));
 
-	while (max_trying--) {
+	// prevent the slave from going away in sleep
+	atomic_inc(THERM_REFCNT(sl->family_data));
+
+	if (!bus_mutex_lock(&dev_master->bus_mutex)) {
+		ret = -EAGAIN;	// Didn't acquire the mutex
+		goto dec_refcnt;
+	}
+
+	while (max_trying-- && ret) { /* ret should be 0 */
 
 		info->verdict = 0;
 		info->crc = 0;
-
+		/* safe version to select slave */
 		if (!reset_select_slave(sl)) {
-			int count = 0;
-			unsigned int tm = 750;
 			unsigned long sleep_rem;
 
-			w1_write_8(dev, W1_READ_PSUPPLY);
-			external_power = w1_read_8(dev);
-
-			if (reset_select_slave(sl))
-				continue;
-
 			/* 750ms strong pullup (or delay) after the convert */
-			if (w1_strong_pullup == 2 ||
-					(!external_power && w1_strong_pullup))
-				w1_next_pullup(dev, tm);
-
-			w1_write_8(dev, W1_CONVERT_TEMP);
+			if (strong_pullup)
+				w1_next_pullup(dev_master, t_conv);
 
-			if (external_power) {
-				mutex_unlock(&dev->bus_mutex);
+			w1_write_8(dev_master, W1_CONVERT_TEMP);
 
-				sleep_rem = msleep_interruptible(tm);
+			if (strong_pullup) { /*some device need pullup */
+				sleep_rem = msleep_interruptible(t_conv);
 				if (sleep_rem != 0) {
 					ret = -EINTR;
-					goto dec_refcnt;
+					goto mt_unlock;
 				}
+				mutex_unlock(&dev_master->bus_mutex);
+			} else { /*no device need pullup */
+				mutex_unlock(&dev_master->bus_mutex);
 
-				ret = mutex_lock_interruptible(&dev->bus_mutex);
-				if (ret != 0)
-					goto dec_refcnt;
-			} else if (!w1_strong_pullup) {
-				sleep_rem = msleep_interruptible(tm);
+				sleep_rem = msleep_interruptible(t_conv);
 				if (sleep_rem != 0) {
 					ret = -EINTR;
-					goto mt_unlock;
+					goto dec_refcnt;
 				}
 			}
-
-			if (!reset_select_slave(sl)) {
-
-				w1_write_8(dev, W1_READ_SCRATCHPAD);
-				count = w1_read_block(dev, info->rom, 9);
-				if (count != 9) {
-					dev_warn(device, "w1_read_block() "
-						"returned %u instead of 9.\n",
-						count);
-				}
-
-				info->crc = w1_calc_crc8(info->rom, 8);
-
-				if (info->rom[8] == info->crc)
-					info->verdict = 1;
-			}
+			ret = read_scratchpad(sl, info);
+			goto dec_refcnt;
 		}
 
-		if (info->verdict)
-			break;
 	}
 
 mt_unlock:
-	mutex_unlock(&dev->bus_mutex);
+	mutex_unlock(&dev_master->bus_mutex);
 dec_refcnt:
-	atomic_dec(THERM_REFCNT(family_data));
+	atomic_dec(THERM_REFCNT(sl->family_data));
 error:
 	return ret;
 }
@@ -967,27 +1025,33 @@ static ssize_t w1_slave_show(struct device *device,
 	u8 *family_data = sl->family_data;
 	int ret, i;
 	ssize_t c = PAGE_SIZE;
-	u8 fid = sl->family->fid;
 
-	ret = read_therm(device, sl, &info);
-	if (ret)
-		return ret;
+	ret = convert_t(sl, &info);
+
+	if (ret < 0) {
+		dev_dbg(device,
+			"%s: Temperature data may be corrupted. err=%d\n",
+			__func__, ret);
+		return 0;
+	}
 
 	for (i = 0; i < 9; ++i)
 		c -= snprintf(buf + PAGE_SIZE - c, c, "%02x ", info.rom[i]);
 	c -= snprintf(buf + PAGE_SIZE - c, c, ": crc=%02x %s\n",
 		      info.crc, (info.verdict) ? "YES" : "NO");
+
 	if (info.verdict)
 		memcpy(family_data, info.rom, sizeof(info.rom));
 	else
-		dev_warn(device, "Read failed CRC check\n");
+		dev_warn(device, "%s:Read failed CRC check\n", __func__);
 
 	for (i = 0; i < 9; ++i)
 		c -= snprintf(buf + PAGE_SIZE - c, c, "%02x ",
 			      ((u8 *)family_data)[i]);
 
 	c -= snprintf(buf + PAGE_SIZE - c, c, "t=%d\n",
-			w1_convert_temp(info.rom, fid));
+			temperature_from_RAM(sl, info.rom));
+
 	ret = PAGE_SIZE - c;
 	return ret;
 }
@@ -1030,6 +1094,31 @@ static ssize_t w1_slave_store(struct device *device,
 	return size; /* always return size to avoid infinite calling */
 }
 
+static ssize_t temperature_show(struct device *device,
+	struct device_attribute *attr, char *buf)
+{
+	struct w1_slave *sl = dev_to_w1_slave(device);
+	struct therm_info info;
+	int ret = 0;
+
+	if ((!sl->family_data) || (!SLAVE_SPECIFIC_FUNC(sl))) {
+		dev_info(device,
+			"%s: Device not supported by the driver\n", __func__);
+		return 0;  /* No device family */
+	}
+
+	ret = convert_t(sl, &info);
+
+	if (ret < 0) {
+		dev_dbg(device,
+			"%s: Temperature data may be corrupted. err=%d\n",
+			__func__, ret);
+		return 0;
+	}
+
+	return sprintf(buf, "%d\n", temperature_from_RAM(sl, info.rom));
+}
+
 static ssize_t ext_power_show(struct device *device,
 	struct device_attribute *attr, char *buf)
 {
@@ -1138,12 +1227,11 @@ static int w1_read_temp(struct device *device, u32 attr, int channel,
 {
 	struct w1_slave *sl = dev_get_drvdata(device);
 	struct therm_info info;
-	u8 fid = sl->family->fid;
 	int ret;
 
 	switch (attr) {
 	case hwmon_temp_input:
-		ret = read_therm(device, sl, &info);
+		ret = convert_t(sl, &info);
 		if (ret)
 			return ret;
 
@@ -1152,7 +1240,7 @@ static int w1_read_temp(struct device *device, u32 attr, int channel,
 			return ret;
 		}
 
-		*val = w1_convert_temp(info.rom, fid);
+		*val = temperature_from_RAM(sl, info.rom);
 		ret = 0;
 		break;
 	default:
-- 
2.26.2

