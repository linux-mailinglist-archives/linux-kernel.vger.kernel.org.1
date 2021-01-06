Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30DD22EC6DC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 00:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbhAFX1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 18:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbhAFX1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 18:27:32 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621C4C061786
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 15:26:52 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id v9so3503895qtw.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 15:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=5AAGWLCZrSWvHnZ2GmyTLtHlPAjis9UMQ895Y6HPUqA=;
        b=Djpx0oshoX4oLiACX7q7hPy7kR9ONIyXwQyjja6p8ZVrXtGFAtq9fxBTdTA+Imw6Q0
         KCIuYpXjlBH1t5BjTTE3WzYZ1PcxGdrOu3HTtcl5O/9Ne5zlDBDtYeY1CpqYZxpKt5IR
         T//ThYeYwsry6qGPnCAShU8UQ1VNleL6PmJUIKwNbOcMg7dnp/qdCY0XNpChMTG1kQJv
         fXjW5abJJBi5wqCpEkuqr9z4NJtvZqqQinHPWRhswAWZJsZzrSa4OwCXd8c1ouDQEYC2
         BlKuN8mI5NnNl45Bx2B7U+bwJBh7+HRTsa2lpZBYFT6dqzBg3/HrI0LiLT9T5e8O4rsp
         c3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=5AAGWLCZrSWvHnZ2GmyTLtHlPAjis9UMQ895Y6HPUqA=;
        b=QYfYBKx4uN7Q9mqkQW09eFtbodqRJNKFsl5mvuygt7v6hFPr7g45qNqjEBy+M3WGn9
         Gi3i9ozrgs5vku6kWbVFjiAHH1Ly93OWTvT1JmY3i4+7q4oGN6SZrpyFsqf/T10y15ug
         VPL3CZbqPXUW9odzC9Qy9r4o7cENuUi052ReTOPet06OKEfp5ZXFxytIRazrh7H/TOUT
         91cMlzouNnD7kMZAggElRFykNhU/ZNWnlDg30GHfrOXAWNjsF/i9y6OR28wUUJs+Wkl+
         DKa8EXCnFc90zTTJQcJkuNKTiphupkdIKEhXLc8c8nR8iplr/o3BCN5DfOsCn5Jv9/9X
         a0ig==
X-Gm-Message-State: AOAM532EOAzWyC95r5Sok8IrEYi/PsoA4WceERIlN0C0Vbj6hdDApQ20
        r/ecGzX8bvHb+mRJmKpmLlg6akvoUjsRmPQ=
X-Google-Smtp-Source: ABdhPJw7tDyQxcWGY4CnMXy1oEX2SUSE9M+POrw2V6FklCxEjl2mQIEyMtO4o3kAkV7A3Sakix5MQ1i38Pka3G0=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:a05:6214:20a1:: with SMTP id
 1mr5970150qvd.61.1609975611540; Wed, 06 Jan 2021 15:26:51 -0800 (PST)
Date:   Wed,  6 Jan 2021 15:26:41 -0800
Message-Id: <20210106232641.459081-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH v1] driver core: Fix device link device name collision
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Michael Walle <michael@walle.cc>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
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
<supplier-bus-name>:<supplier-dev-name>--<consumer-bus-name><consumer-dev-name>

[1] - https://lore.kernel.org/lkml/20201229033440.32142-1-michael@walle.cc/
Reported-by: Michael Walle <michael@walle.cc>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---

Michael,

Can you please test this? This should fix your issue.

Having said that, do you have some local DT changes when you are testing
this? Because it's not obvious from the DT in upstream what dependency
is even being derived from the firmware. I don't see any dependency in
upstream DT files between mdio_bus/0000:00:00.1 and
pci0000:00/0000:00:00.1

Thanks,
Saravana

 Documentation/ABI/testing/sysfs-class-devlink |  4 ++--
 drivers/base/core.c                           |  9 ++++-----
 include/linux/device.h                        | 12 ++++++++++++
 3 files changed, 18 insertions(+), 7 deletions(-)

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
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 25e08e5f40bd..e54c51926250 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
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

