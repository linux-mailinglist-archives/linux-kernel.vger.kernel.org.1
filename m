Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2D72EE9E1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 00:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbhAGXmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 18:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbhAGXmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 18:42:22 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C8BC0612F8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 15:41:42 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id b131so13120303ybc.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 15:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=E7U4y6f6fCTA1c1lfgDAQLQv0BC0j20W4BBoLaKmuXo=;
        b=ZK+woJKJUDMYY+l3oIQFIMyhAQ/Nl50mAk5fJtGnnfLudnr6ldkKpshauoLrpy+bc6
         WwXdzU+5P/zd9dWzf3tbUnS7P3x1DFb8CTs/4pT5i4SFVr3CmggrZu6dEFgVSRJ3eYR2
         OBhqlZcAnIlWdky4/nNI835Cg+zzwbo8OB0y4Ed4BLz8uLEoGKe8Lj/wZ+YTHbqCsqvZ
         I38CBRMDPkUAbHH8+khunLQiYsfJKu0lh/CQs2V32dcUMWWlxPMs5w3onHHnDJyuzd/S
         760F/azdUFwsw1zxTk7Y8xr45FlfRBzlFFNckaYN1S3gnmoZ1pRBGOcm8i+uxRj+2vis
         xwlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=E7U4y6f6fCTA1c1lfgDAQLQv0BC0j20W4BBoLaKmuXo=;
        b=LKQurJ+5zNmrTqj/89Zb7gUr+4oc6pD0D9CH1qepV45tvCy5nXtTU0gtvK67nxwjWM
         JIi3sl8XsWfDY6TO8oRi1ZYoNcHAlMITusGO47XDwO8XrKQV4gvBuX0kX82GiKAmdmyJ
         IJyCypBl24S7tLBGdCK13sd8w8d5qAFvnBeDzimzMXxMbgMiltjaVrKWLUN+DYwJbJ7b
         pkkSV+drZBunVjpYeFzfONuPUD2T6ySaqJJitVOb0Y3+fTooqQdo4IY9Of9O/4eREmbd
         5nClgxURbfyZHddo8f761v3Q4nsA+/jHWJVfYWRh9pQ+2kGVl5FU0xfAl/xxEGNSHFm2
         t8RA==
X-Gm-Message-State: AOAM532nBpZy0RXMhSCtzO+PQIxT7FhYz5VUXBRoEH/9GCpkET+yfbCO
        5FQBK6fsie8i+JNEwi3DlE2vWVtIE/ZnJDo=
X-Google-Smtp-Source: ABdhPJxKmOBqt5322ua8/SoJlklpM5/Go991H/gXTFHrjywnTjfxnSzwXIo/tNHVaLv+Wl2iijcHrfn9e/l7m2M=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:a25:d4e:: with SMTP id
 75mr1757542ybn.340.1610062901494; Thu, 07 Jan 2021 15:41:41 -0800 (PST)
Date:   Thu,  7 Jan 2021 15:41:36 -0800
Message-Id: <20210107234136.740371-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH v2] driver core: Fix device link device name collision
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     stable@vger.kernel.org, Michael Walle <michael@walle.cc>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device link device's name was of the form:
<supplier-dev-name>--<consumer-dev-name>

This can cause name collision as reported here [1] as device names are
not globally unique. Since device names have to be unique within the
bus/class, add the bus/class name as a prefix to the device names used to
construct the device link device name.

So the devuce link device's name will be of the form:
<supplier-bus-name>:<supplier-dev-name>--<consumer-bus-name>:<consumer-dev-name>

[1] - https://lore.kernel.org/lkml/20201229033440.32142-1-michael@walle.cc/

Cc: stable@vger.kernel.org
Fixes: 287905e68dd2 ("driver core: Expose device link details in sysfs")
Reported-by: Michael Walle <michael@walle.cc>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 Documentation/ABI/testing/sysfs-class-devlink    |  4 ++--
 Documentation/ABI/testing/sysfs-devices-consumer |  5 +++--
 Documentation/ABI/testing/sysfs-devices-supplier |  5 +++--
 drivers/base/core.c                              | 13 ++++++-------
 include/linux/device.h                           | 12 ++++++++++++
 5 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-devlink b/Documentation/ABI/testing/sysfs-class-devlink
index b662f747c83e..8a21ce515f61 100644
--- a/Documentation/ABI/testing/sysfs-class-devlink
+++ b/Documentation/ABI/testing/sysfs-class-devlink
@@ -5,8 +5,8 @@ Description:
 		Provide a place in sysfs for the device link objects in the
 		kernel at any given time.  The name of a device link directory,
 		denoted as ... above, is of the form <supplier>--<consumer>
-		where <supplier> is the supplier device name and <consumer> is
-		the consumer device name.
+		where <supplier> is the supplier bus:device name and <consumer>
+		is the consumer bus:device name.
 
 What:		/sys/class/devlink/.../auto_remove_on
 Date:		May 2020
diff --git a/Documentation/ABI/testing/sysfs-devices-consumer b/Documentation/ABI/testing/sysfs-devices-consumer
index 1f06d74d1c3c..0809fda092e6 100644
--- a/Documentation/ABI/testing/sysfs-devices-consumer
+++ b/Documentation/ABI/testing/sysfs-devices-consumer
@@ -4,5 +4,6 @@ Contact:	Saravana Kannan <saravanak@google.com>
 Description:
 		The /sys/devices/.../consumer:<consumer> are symlinks to device
 		links where this device is the supplier. <consumer> denotes the
-		name of the consumer in that device link. There can be zero or
-		more of these symlinks for a given device.
+		name of the consumer in that device link and is of the form
+		bus:device name. There can be zero or more of these symlinks
+		for a given device.
diff --git a/Documentation/ABI/testing/sysfs-devices-supplier b/Documentation/ABI/testing/sysfs-devices-supplier
index a919e0db5e90..207f5972e98d 100644
--- a/Documentation/ABI/testing/sysfs-devices-supplier
+++ b/Documentation/ABI/testing/sysfs-devices-supplier
@@ -4,5 +4,6 @@ Contact:	Saravana Kannan <saravanak@google.com>
 Description:
 		The /sys/devices/.../supplier:<supplier> are symlinks to device
 		links where this device is the consumer. <supplier> denotes the
-		name of the supplier in that device link. There can be zero or
-		more of these symlinks for a given device.
+		name of the supplier in that device link and is of the form
+		bus:device name. There can be zero or more of these symlinks
+		for a given device.
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 25e08e5f40bd..1927e70eb71a 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -470,12 +470,12 @@ static int devlink_add_symlinks(struct device *dev,
 	if (ret)
 		goto err_con;
 
-	snprintf(buf, len, "consumer:%s", dev_name(con));
+	snprintf(buf, len, "consumer:%s:%s", dev_bus_name(con), dev_name(con));
 	ret = sysfs_create_link(&sup->kobj, &link->link_dev.kobj, buf);
 	if (ret)
 		goto err_con_dev;
 
-	snprintf(buf, len, "supplier:%s", dev_name(sup));
+	snprintf(buf, len, "supplier:%s:%s", dev_bus_name(sup), dev_name(sup));
 	ret = sysfs_create_link(&con->kobj, &link->link_dev.kobj, buf);
 	if (ret)
 		goto err_sup_dev;
@@ -737,8 +737,9 @@ struct device_link *device_link_add(struct device *consumer,
 
 	link->link_dev.class = &devlink_class;
 	device_set_pm_not_required(&link->link_dev);
-	dev_set_name(&link->link_dev, "%s--%s",
-		     dev_name(supplier), dev_name(consumer));
+	dev_set_name(&link->link_dev, "%s:%s--%s:%s",
+		     dev_bus_name(supplier), dev_name(supplier),
+		     dev_bus_name(consumer), dev_name(consumer));
 	if (device_register(&link->link_dev)) {
 		put_device(consumer);
 		put_device(supplier);
@@ -1808,9 +1809,7 @@ const char *dev_driver_string(const struct device *dev)
 	 * never change once they are set, so they don't need special care.
 	 */
 	drv = READ_ONCE(dev->driver);
-	return drv ? drv->name :
-			(dev->bus ? dev->bus->name :
-			(dev->class ? dev->class->name : ""));
+	return drv ? drv->name : dev_bus_name(dev);
 }
 EXPORT_SYMBOL(dev_driver_string);
 
diff --git a/include/linux/device.h b/include/linux/device.h
index 89bb8b84173e..1779f90eeb4c 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -609,6 +609,18 @@ static inline const char *dev_name(const struct device *dev)
 	return kobject_name(&dev->kobj);
 }
 
+/**
+ * dev_bus_name - Return a device's bus/class name, if at all possible
+ * @dev: struct device to get the bus/class name of
+ *
+ * Will return the name of the bus/class the device is attached to.  If it is
+ * not attached to a bus/class, an empty string will be returned.
+ */
+static inline const char *dev_bus_name(const struct device *dev)
+{
+	return dev->bus ? dev->bus->name : (dev->class ? dev->class->name : "");
+}
+
 __printf(2, 3) int dev_set_name(struct device *dev, const char *name, ...);
 
 #ifdef CONFIG_NUMA
-- 
2.29.2.729.g45daf8777d-goog

