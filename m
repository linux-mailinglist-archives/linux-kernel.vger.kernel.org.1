Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3D31CE5AF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 22:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731746AbgEKUhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 16:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbgEKUhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:37:01 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A354BC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 13:37:00 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id z72so11286217wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 13:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oGtEWu/llWADpeucmbd1whSNwyr7njwb/k1Ov1gjARc=;
        b=nhf9piqONG+9E/St0EcxgOxrjGavYRBbZSgy3axxOIPOrGcy1ArSv1aJrrIyK8JN4x
         4ZZ76T73bSuGUpYwCXf/jF2iKjRVivii1clZdETEBtN3vWlnnNddArwVjG8Al613SITN
         jpv/gCw8K1uSrzX0R9WanaCMSxaPQwl2cuWG3cd/Jzkza2VdNSRVyv8crpgNZqgz8CBa
         VS0mZyU1npzNS3q/kXCcI91rm+w4fP5+QZXA4xqZrnhljVwHhhP0J1TtglhHF64OqrTF
         /bOuiIkLr80533AsQgxm3XH9lcNHczQ+gYpcfCL7kqy/+drikSkYEwa1IcVFyZV7NGgC
         HVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oGtEWu/llWADpeucmbd1whSNwyr7njwb/k1Ov1gjARc=;
        b=c7DAt4Ri0DeFrvvgYgCk5GpfPkXP8ICx0J28j+uMV/VE48Yq8befNO0aMm28DfRCYo
         k+GL+T72OCMn4/umSud1od76zptePVf4NXjb7Ooj0l3KSc4+iz1Tc4O+5NZQBnUuNg5K
         zpp6x+h0jWtGnUwgv/TmcfjZqurmq5bQiJYWDXK2YZnVSMYONvA+qoD7Ko5+odyOP439
         a7vyF3aXvMQchh1+Vj0qDNkkb1x8xBNlnb0qnmjxDfZ0uEThmxKQ+xpStrby79BC5SqI
         gpeUZnwe/TEN39x9Xy14gMlb0v5RIkmNm8/1rZam7drN0y4nUAYak/0GnHruItbQD1s7
         bneQ==
X-Gm-Message-State: AGi0Pub4xfIA5wHSSRXZZHuLq6K4XlknkLjN7PnHO9H8ZittBktcXoNB
        +yOjHblPo/e1OfpVFHhJQak=
X-Google-Smtp-Source: APiQypIWs54m6O5N6EX64sY58lcqiYrFxH6+orb0lM6TjingH0vpki3JpHVHNRh18eObDJP+pb5lYw==
X-Received: by 2002:a1c:750a:: with SMTP id o10mr33081419wmc.124.1589229419303;
        Mon, 11 May 2020 13:36:59 -0700 (PDT)
Received: from akira-laptop.home ([2a01:cb19:8b28:7600:a0b9:1c6f:cfba:2b21])
        by smtp.googlemail.com with ESMTPSA id m18sm12535452wru.78.2020.05.11.13.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 13:36:58 -0700 (PDT)
From:   Akira Shimahara <akira215corp@gmail.com>
To:     greg@kroah.com, rdunlap@infradead.org
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org,
        Akira Shimahara <akira215corp@gmail.com>
Subject: [PATCH v7 4/9] w1_therm: adding ext_power sysfs entry
Date:   Mon, 11 May 2020 22:36:50 +0200
Message-Id: <20200511203650.410439-1-akira215corp@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding ext_power sysfs entry (RO). Return the power status of the device:
 - 0: device parasite powered
 - 1: device externally powered
 - xx: xx is kernel error

The power status of each device is check when the device is
discover by the bus master, in 'w1_therm_add_slave(struct w1_slave *)'.
The status is stored in the device structure w1_therm_family_data so
that the driver always knows the power state of each device, which could
be used later to determine the required strong pull up to apply on the
line.

The power status is re evaluate each time the sysfs ext_power read by
a user.

The hardware function 'read_powermode(struct w1_slave *sl)' act just as
per device specifications, sending W1_READ_PSUPPLY command on the bus,
and issue a read time slot, reading only one bit.

A helper function 'bool bus_mutex_lock(struct mutex *lock)' is introduced.
It try to aquire the bus mutex several times (W1_THERM_MAX_TRY), waiting
W1_THERM_RETRY_DELAY between two attempt.

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

 .../ABI/testing/sysfs-driver-w1_therm         |  12 ++
 drivers/w1/slaves/w1_therm.c                  | 137 ++++++++++++++++++
 2 files changed, 149 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-w1_therm b/Documentation/ABI/testing/sysfs-driver-w1_therm
index 4a85663..99d73ee 100644
--- a/Documentation/ABI/testing/sysfs-driver-w1_therm
+++ b/Documentation/ABI/testing/sysfs-driver-w1_therm
@@ -1,3 +1,15 @@
+What:		/sys/bus/w1/devices/.../ext_power
+Date:		May 2020
+Contact:	Akira Shimahara <akira215corp@gmail.com>
+Description:
+		(RO) return the power status by asking the device
+			* '0': device parasite powered
+			* '1': device externally powered
+			* '-xx': xx is kernel error when reading power status
+Users:		any user space application which wants to communicate with
+		w1_term device
+
+
 What:		/sys/bus/w1/devices/.../w1_slave
 Date:		May 2020
 Contact:	Akira Shimahara <akira215corp@gmail.com>
diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index 6a54fc4..a148f2d 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -43,8 +43,21 @@
 static int w1_strong_pullup = 1;
 module_param_named(strong_pullup, w1_strong_pullup, int, 0);
 
+/* Nb of try for an operation */
+#define W1_THERM_MAX_TRY		5
+
+/* ms delay to retry bus mutex */
+#define W1_THERM_RETRY_DELAY		20
+
 /* Helpers Macros */
 
+/*
+ * return the power mode of the sl slave : 1-ext, 0-parasite, <0 unknown
+ * always test family data existence before using this macro
+ */
+#define SLAVE_POWERMODE(sl) \
+	(((struct w1_therm_family_data *)(sl->family_data))->external_powered)
+
 /* return the address of the refcnt in the family data */
 #define THERM_REFCNT(family_data) \
 	(&((struct w1_therm_family_data *)family_data)->refcnt)
@@ -73,10 +86,14 @@ struct w1_therm_family_converter {
  * struct w1_therm_family_data - device data
  * @rom: ROM device id (64bit Lasered ROM code + 1 CRC byte)
  * @refcnt: ref count
+ * @external_powered:	1 device powered externally,
+ *				0 device parasite powered,
+ *				-x error or undefined
  */
 struct w1_therm_family_data {
 	uint8_t rom[9];
 	atomic_t refcnt;
+	int external_powered;
 };
 
 /**
@@ -109,6 +126,20 @@ struct therm_info {
  */
 static int reset_select_slave(struct w1_slave *sl);
 
+/**
+ * read_powermode() - Query the power mode of the slave
+ * @sl: slave to retrieve the power mode
+ *
+ * Ask the device to get its power mode (external or parasite)
+ * and store the power status in the &struct w1_therm_family_data.
+ *
+ * Return:
+ * * 0 parasite powered device
+ * * 1 externally powered device
+ * * <0 kernel error code
+ */
+static int read_powermode(struct w1_slave *sl);
+
 /* Sysfs interface declaration */
 
 static ssize_t w1_slave_show(struct device *device,
@@ -120,10 +151,14 @@ static ssize_t w1_slave_store(struct device *device,
 static ssize_t w1_seq_show(struct device *device,
 	struct device_attribute *attr, char *buf);
 
+static ssize_t ext_power_show(struct device *device,
+	struct device_attribute *attr, char *buf);
+
 /* Attributes declarations */
 
 static DEVICE_ATTR_RW(w1_slave);
 static DEVICE_ATTR_RO(w1_seq);
+static DEVICE_ATTR_RO(ext_power);
 
 /* Interface Functions declaration */
 
@@ -151,12 +186,14 @@ static void w1_therm_remove_slave(struct w1_slave *sl);
 
 static struct attribute *w1_therm_attrs[] = {
 	&dev_attr_w1_slave.attr,
+	&dev_attr_ext_power.attr,
 	NULL,
 };
 
 static struct attribute *w1_ds28ea00_attrs[] = {
 	&dev_attr_w1_slave.attr,
 	&dev_attr_w1_seq.attr,
+	&dev_attr_ext_power.attr,
 	NULL,
 };
 
@@ -432,6 +469,34 @@ static struct w1_therm_family_converter w1_therm_families[] = {
 
 /* Helpers Functions */
 
+/**
+ * bus_mutex_lock() - Acquire the mutex
+ * @lock: w1 bus mutex to acquire
+ *
+ * It try to acquire the mutex W1_THERM_MAX_TRY times and wait
+ * W1_THERM_RETRY_DELAY between 2 attempts.
+ *
+ * Return: true is mutex is acquired and lock, false otherwise
+ */
+static inline bool bus_mutex_lock(struct mutex *lock)
+{
+	int max_trying = W1_THERM_MAX_TRY;
+
+	/* try to acquire the mutex, if not, sleep retry_delay before retry) */
+	while (mutex_lock_interruptible(lock) != 0 && max_trying > 0) {
+		unsigned long sleep_rem;
+
+		sleep_rem = msleep_interruptible(W1_THERM_RETRY_DELAY);
+		if (!sleep_rem)
+			max_trying--;
+	}
+
+	if (!max_trying)
+		return false;	/* Didn't acquire the bus mutex */
+
+	return true;
+}
+
 /**
  * w1_convert_temp() - temperature conversion binding function
  * @rom: data read from device RAM (8 data bytes + 1 CRC byte)
@@ -461,7 +526,19 @@ static int w1_therm_add_slave(struct w1_slave *sl)
 		GFP_KERNEL);
 	if (!sl->family_data)
 		return -ENOMEM;
+
 	atomic_set(THERM_REFCNT(sl->family_data), 1);
+
+	/* Getting the power mode of the device {external, parasite} */
+	SLAVE_POWERMODE(sl) = read_powermode(sl);
+
+	if (SLAVE_POWERMODE(sl) < 0) {
+		/* no error returned as device has been added */
+		dev_warn(&sl->dev,
+			"%s: Device has been added, but power_mode may be corrupted. err=%d\n",
+			 __func__, SLAVE_POWERMODE(sl));
+	}
+
 	return 0;
 }
 
@@ -661,6 +738,44 @@ error:
 	return ret;
 }
 
+static int read_powermode(struct w1_slave *sl)
+{
+	struct w1_master *dev_master = sl->master;
+	int max_trying = W1_THERM_MAX_TRY;
+	int  ret = -ENODEV;
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
+	while ((max_trying--) && (ret < 0)) {
+		/* safe version to select slave */
+		if (!reset_select_slave(sl)) {
+			w1_write_8(dev_master, W1_READ_PSUPPLY);
+			/*
+			 * Emit a read time slot and read only one bit,
+			 * 1 is externally powered,
+			 * 0 is parasite powered
+			 */
+			ret = w1_touch_bit(dev_master, 1);
+			/* ret should be either 1 either 0 */
+		}
+	}
+	mutex_unlock(&dev_master->bus_mutex);
+
+dec_refcnt:
+	atomic_dec(THERM_REFCNT(sl->family_data));
+error:
+	return ret;
+}
+
 /* Sysfs Interface definition */
 
 static ssize_t w1_slave_show(struct device *device,
@@ -722,6 +837,28 @@ static ssize_t w1_slave_store(struct device *device,
 	return ret ? : size;
 }
 
+static ssize_t ext_power_show(struct device *device,
+	struct device_attribute *attr, char *buf)
+{
+	struct w1_slave *sl = dev_to_w1_slave(device);
+
+	if (!sl->family_data) {
+		dev_info(device,
+			"%s: Device not supported by the driver\n", __func__);
+		return 0;  /* No device family */
+	}
+
+	/* Getting the power mode of the device {external, parasite} */
+	SLAVE_POWERMODE(sl) = read_powermode(sl);
+
+	if (SLAVE_POWERMODE(sl) < 0) {
+		dev_dbg(device,
+			"%s: Power_mode may be corrupted. err=%d\n",
+			__func__, SLAVE_POWERMODE(sl));
+	}
+	return sprintf(buf, "%d\n", SLAVE_POWERMODE(sl));
+}
+
 #if IS_REACHABLE(CONFIG_HWMON)
 static int w1_read_temp(struct device *device, u32 attr, int channel,
 			long *val)
-- 
2.26.2

