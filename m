Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D771CC5A4
	for <lists+linux-kernel@lfdr.de>; Sun, 10 May 2020 01:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbgEIX7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 May 2020 19:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726026AbgEIX7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 19:59:41 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3792C061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 16:59:40 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k12so13954848wmj.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 16:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iCKqAH/C9qpLzkgEoM2CMw9RQMUSEWeDv3LLagx+ZWc=;
        b=MHv5riqe3N4YQZlPuzQs3ZSzJxu1XnRhIH6NN+83YMtdBldI8YDpyh6hT5EWbTzIzJ
         q+fzyz0wgtoOeHtxKbv9rgP0dbcshsB/LdQvdfVxqjAxyd/sKeDqJOtC6PQrifCBsEE1
         InUi3cqp2FcJFu653hiJN38T6luhTONT7oZ04+PCqEu6/UN/HQJ1SjVvBB39bhJypn4o
         vDQzk9SCraBnD+1AHMY33cGzZ1gIcTO82U1nXBuTZtiKUjQ5yLtazOczBIvYPJnXvGmb
         YHJt/0SpoJ1rPMZg94bquNnmTV8DnVfWB5ERQKUSEumODhBJBQqRaH+Hfhv0Tw4N0LUY
         KsFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iCKqAH/C9qpLzkgEoM2CMw9RQMUSEWeDv3LLagx+ZWc=;
        b=iHgZvnLLmy5zho9sbArnAj3vZbqT/aB+CRXCwu8QD/NuBcVKeAaOjqr+1ynH20kLTb
         VxxaPabjZU71USKcqchRfjZnuorkd8AtHxuYqgvzYeg86HCCST5gIBQvkbuM4CzkjJaw
         qUrW49bJ8D68Gd3fhQehvO58BQaofBUWo6FNkBxTWexjlzV0J8LzccquKFJTfMZNGc+r
         Ps7Ae17IX+7OkLrp1sIWji1rgSXzZ3aEgqT8GhNN51hMvk1622+CEhPg+Ku/S5iGg9bg
         z6dAeS9uOfe1INRtRRuU7vZv9dRIffF1+jcmdSSklsurje/nk344WYzsIjd8VENIs35m
         NVUw==
X-Gm-Message-State: AGi0PuYxfVM4zCx3ae+joKYh3tMign1Gsb/4pOjesfdtnaqzM6VIfx5k
        LhZMpF9SaQZuPGNPqPam32c=
X-Google-Smtp-Source: APiQypLICL1uSQN6wq1jmXMDrpP5BgbxUjBDhJ+G4vWfYV3dPl2WXleOb2q83R8ii6JcS8txazX9ig==
X-Received: by 2002:a1c:3581:: with SMTP id c123mr12467251wma.150.1589068779380;
        Sat, 09 May 2020 16:59:39 -0700 (PDT)
Received: from akira-laptop.home ([2a01:cb19:8b28:7600:48ff:3af:e1d8:fd19])
        by smtp.googlemail.com with ESMTPSA id v5sm10212600wrr.93.2020.05.09.16.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2020 16:59:38 -0700 (PDT)
From:   Akira Shimahara <akira215corp@gmail.com>
To:     greg@kroah.com
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org,
        Akira Shimahara <akira215corp@gmail.com>
Subject: [PATCH v5 4/9] w1_therm: adding ext_power sysfs entry
Date:   Sun, 10 May 2020 01:59:31 +0200
Message-Id: <20200509235931.423702-1-akira215corp@gmail.com>
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

 .../ABI/testing/sysfs-driver-w1_therm         |  12 ++
 drivers/w1/slaves/w1_therm.c                  | 129 ++++++++++++++++++
 2 files changed, 141 insertions(+)

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
index 4dd139b..ab15cca 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -42,8 +42,20 @@
 static int w1_strong_pullup = 1;
 module_param_named(strong_pullup, w1_strong_pullup, int, 0);
 
+/* Nb of try for an operation */
+#define W1_THERM_MAX_TRY		5
+
+/* ms delay to retry bus mutex */
+#define W1_THERM_RETRY_DELAY		20
+
 /*-------------------------------Macros-------------------------------------*/
 
+/* return the power mode of the sl slave : 1-ext, 0-parasite, <0 unknown
+ * always test family data existence before
+ */
+#define SLAVE_POWERMODE(sl) \
+	(((struct w1_therm_family_data *)(sl->family_data))->external_powered)
+
 /* return the address of the refcnt in the family data */
 #define THERM_REFCNT(family_data) \
 	(&((struct w1_therm_family_data *)family_data)->refcnt)
@@ -78,6 +90,7 @@ struct w1_therm_family_converter {
 struct w1_therm_family_data {
 	uint8_t rom[9];
 	atomic_t refcnt;
+	int external_powered;
 };
 
 /**
@@ -108,6 +121,15 @@ struct therm_info {
  */
 static int reset_select_slave(struct w1_slave *sl);
 
+/** read_powermode()
+ * \brief ask the device to get its power mode {external, parasite}
+ * \param sl slave to be interrogated
+ * \return	0 parasite powered device
+ *			1 externally powered device
+ *			<0 kernel error code
+ */
+static int read_powermode(struct w1_slave *sl);
+
 /*-----------------------Interface sysfs declaration------------------------*/
 
 /** \brief A callback function to output the temperature Old way
@@ -128,10 +150,21 @@ static ssize_t w1_slave_store(struct device *device,
 static ssize_t w1_seq_show(struct device *device,
 	struct device_attribute *attr, char *buf);
 
+/** \brief A callback function to output the power mode of the device
+ *	Once done, it is stored in the sl->family_data to avoid doing the test
+ *	during data read
+ *  \return	0 : device parasite powered
+ *		1 : device externally powered
+ *		-xx : xx is kernel error code
+ */
+static ssize_t ext_power_show(struct device *device,
+	struct device_attribute *attr, char *buf);
+
 /*-----------------------------Attributes declarations----------------------*/
 
 static DEVICE_ATTR_RW(w1_slave);
 static DEVICE_ATTR_RO(w1_seq);
+static DEVICE_ATTR_RO(ext_power);
 
 /*--------------------Interface Functions declaration-----------------------*/
 
@@ -152,12 +185,14 @@ static void w1_therm_remove_slave(struct w1_slave *sl);
 
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
 
@@ -419,6 +454,29 @@ static struct w1_therm_family_converter w1_therm_families[] = {
 
 /*-------------------------- Helpers Functions------------------------------*/
 
+/** bus_mutex_lock() get the mutex & retry W1_THERM_MAX_TRY times
+ *  \param lock w1 bus mutex to get
+ *  \return value true is mutex is acquired and lock, false otherwise
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
 static inline int w1_convert_temp(u8 rom[9], u8 fid)
 {
 	int i;
@@ -438,7 +496,19 @@ static int w1_therm_add_slave(struct w1_slave *sl)
 		GFP_KERNEL);
 	if (!sl->family_data)
 		return -ENOMEM;
+
 	atomic_set(THERM_REFCNT(sl->family_data), 1);
+
+	/* Getting the power mode of the device {external, parasite}*/
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
 
@@ -638,6 +708,43 @@ error:
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
+		ret = -EAGAIN;	// Didn't acquire the mutex
+		goto dec_refcnt;
+	}
+
+	while ((max_trying--) && (ret < 0)) {
+		/* safe version to select slave */
+		if (!reset_select_slave(sl)) {
+			w1_write_8(dev_master, W1_READ_PSUPPLY);
+			/* Read only one bit,
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
 /*-----------------------------Interface sysfs------------------------------*/
 
 static ssize_t w1_slave_show(struct device *device,
@@ -699,6 +806,28 @@ static ssize_t w1_slave_store(struct device *device,
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
+	/* Getting the power mode of the device {external, parasite}*/
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

