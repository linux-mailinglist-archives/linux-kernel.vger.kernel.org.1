Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979142B92BE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 13:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbgKSMqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 07:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726848AbgKSMqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 07:46:20 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6333C0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 04:46:19 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kfjKL-00084m-Qp; Thu, 19 Nov 2020 13:46:17 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kfjKJ-0003gX-UA; Thu, 19 Nov 2020 13:46:15 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki " <rafael@kernel.org>
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 1/3] driver core: platform: reorder functions
Date:   Thu, 19 Nov 2020 13:46:09 +0100
Message-Id: <20201119124611.2573057-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This way all callbacks and structures used to initialize
platform_bus_type are defined just before platform_bus_type and in the
same order. Also move platform_drv_probe_fail just before it's only
user.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/base/platform.c | 333 ++++++++++++++++++++--------------------
 1 file changed, 167 insertions(+), 166 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 88aef93eb4dd..b36ab5831cb6 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -772,11 +772,6 @@ static int platform_drv_probe(struct device *_dev)
 	return ret;
 }
 
-static int platform_drv_probe_fail(struct device *_dev)
-{
-	return -ENXIO;
-}
-
 static int platform_drv_remove(struct device *_dev)
 {
 	struct platform_driver *drv = to_platform_driver(_dev->driver);
@@ -827,6 +822,11 @@ void platform_driver_unregister(struct platform_driver *drv)
 }
 EXPORT_SYMBOL_GPL(platform_driver_unregister);
 
+static int platform_drv_probe_fail(struct device *_dev)
+{
+	return -ENXIO;
+}
+
 /**
  * __platform_driver_probe - register driver for non-hotpluggable device
  * @drv: platform driver structure
@@ -1017,129 +1017,6 @@ void platform_unregister_drivers(struct platform_driver * const *drivers,
 }
 EXPORT_SYMBOL_GPL(platform_unregister_drivers);
 
-/* modalias support enables more hands-off userspace setup:
- * (a) environment variable lets new-style hotplug events work once system is
- *     fully running:  "modprobe $MODALIAS"
- * (b) sysfs attribute lets new-style coldplug recover from hotplug events
- *     mishandled before system is fully running:  "modprobe $(cat modalias)"
- */
-static ssize_t modalias_show(struct device *dev,
-			     struct device_attribute *attr, char *buf)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-	int len;
-
-	len = of_device_modalias(dev, buf, PAGE_SIZE);
-	if (len != -ENODEV)
-		return len;
-
-	len = acpi_device_modalias(dev, buf, PAGE_SIZE - 1);
-	if (len != -ENODEV)
-		return len;
-
-	return sysfs_emit(buf, "platform:%s\n", pdev->name);
-}
-static DEVICE_ATTR_RO(modalias);
-
-static ssize_t driver_override_store(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf, size_t count)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-	char *driver_override, *old, *cp;
-
-	/* We need to keep extra room for a newline */
-	if (count >= (PAGE_SIZE - 1))
-		return -EINVAL;
-
-	driver_override = kstrndup(buf, count, GFP_KERNEL);
-	if (!driver_override)
-		return -ENOMEM;
-
-	cp = strchr(driver_override, '\n');
-	if (cp)
-		*cp = '\0';
-
-	device_lock(dev);
-	old = pdev->driver_override;
-	if (strlen(driver_override)) {
-		pdev->driver_override = driver_override;
-	} else {
-		kfree(driver_override);
-		pdev->driver_override = NULL;
-	}
-	device_unlock(dev);
-
-	kfree(old);
-
-	return count;
-}
-
-static ssize_t driver_override_show(struct device *dev,
-				    struct device_attribute *attr, char *buf)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-	ssize_t len;
-
-	device_lock(dev);
-	len = sysfs_emit(buf, "%s\n", pdev->driver_override);
-	device_unlock(dev);
-
-	return len;
-}
-static DEVICE_ATTR_RW(driver_override);
-
-static ssize_t numa_node_show(struct device *dev,
-			      struct device_attribute *attr, char *buf)
-{
-	return sysfs_emit(buf, "%d\n", dev_to_node(dev));
-}
-static DEVICE_ATTR_RO(numa_node);
-
-static umode_t platform_dev_attrs_visible(struct kobject *kobj, struct attribute *a,
-		int n)
-{
-	struct device *dev = container_of(kobj, typeof(*dev), kobj);
-
-	if (a == &dev_attr_numa_node.attr &&
-			dev_to_node(dev) == NUMA_NO_NODE)
-		return 0;
-
-	return a->mode;
-}
-
-static struct attribute *platform_dev_attrs[] = {
-	&dev_attr_modalias.attr,
-	&dev_attr_numa_node.attr,
-	&dev_attr_driver_override.attr,
-	NULL,
-};
-
-static struct attribute_group platform_dev_group = {
-	.attrs = platform_dev_attrs,
-	.is_visible = platform_dev_attrs_visible,
-};
-__ATTRIBUTE_GROUPS(platform_dev);
-
-static int platform_uevent(struct device *dev, struct kobj_uevent_env *env)
-{
-	struct platform_device	*pdev = to_platform_device(dev);
-	int rc;
-
-	/* Some devices have extra OF data and an OF-style MODALIAS */
-	rc = of_device_uevent_modalias(dev, env);
-	if (rc != -ENODEV)
-		return rc;
-
-	rc = acpi_device_uevent_modalias(dev, env);
-	if (rc != -ENODEV)
-		return rc;
-
-	add_uevent_var(env, "MODALIAS=%s%s", PLATFORM_MODULE_PREFIX,
-			pdev->name);
-	return 0;
-}
-
 static const struct platform_device_id *platform_match_id(
 			const struct platform_device_id *id,
 			struct platform_device *pdev)
@@ -1154,44 +1031,6 @@ static const struct platform_device_id *platform_match_id(
 	return NULL;
 }
 
-/**
- * platform_match - bind platform device to platform driver.
- * @dev: device.
- * @drv: driver.
- *
- * Platform device IDs are assumed to be encoded like this:
- * "<name><instance>", where <name> is a short description of the type of
- * device, like "pci" or "floppy", and <instance> is the enumerated
- * instance of the device, like '0' or '42'.  Driver IDs are simply
- * "<name>".  So, extract the <name> from the platform_device structure,
- * and compare it against the name of the driver. Return whether they match
- * or not.
- */
-static int platform_match(struct device *dev, struct device_driver *drv)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-	struct platform_driver *pdrv = to_platform_driver(drv);
-
-	/* When driver_override is set, only bind to the matching driver */
-	if (pdev->driver_override)
-		return !strcmp(pdev->driver_override, drv->name);
-
-	/* Attempt an OF style match first */
-	if (of_driver_match_device(dev, drv))
-		return 1;
-
-	/* Then try ACPI style match */
-	if (acpi_driver_match_device(dev, drv))
-		return 1;
-
-	/* Then try to match against the id table */
-	if (pdrv->id_table)
-		return platform_match_id(pdrv->id_table, pdev) != NULL;
-
-	/* fall-back to driver name match */
-	return (strcmp(pdev->name, drv->name) == 0);
-}
-
 #ifdef CONFIG_PM_SLEEP
 
 static int platform_legacy_suspend(struct device *dev, pm_message_t mesg)
@@ -1336,6 +1175,168 @@ int platform_pm_restore(struct device *dev)
 
 #endif /* CONFIG_HIBERNATE_CALLBACKS */
 
+/* modalias support enables more hands-off userspace setup:
+ * (a) environment variable lets new-style hotplug events work once system is
+ *     fully running:  "modprobe $MODALIAS"
+ * (b) sysfs attribute lets new-style coldplug recover from hotplug events
+ *     mishandled before system is fully running:  "modprobe $(cat modalias)"
+ */
+static ssize_t modalias_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	int len;
+
+	len = of_device_modalias(dev, buf, PAGE_SIZE);
+	if (len != -ENODEV)
+		return len;
+
+	len = acpi_device_modalias(dev, buf, PAGE_SIZE - 1);
+	if (len != -ENODEV)
+		return len;
+
+	return sysfs_emit(buf, "platform:%s\n", pdev->name);
+}
+static DEVICE_ATTR_RO(modalias);
+
+static ssize_t numa_node_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", dev_to_node(dev));
+}
+static DEVICE_ATTR_RO(numa_node);
+
+static ssize_t driver_override_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	ssize_t len;
+
+	device_lock(dev);
+	len = sysfs_emit(buf, "%s\n", pdev->driver_override);
+	device_unlock(dev);
+
+	return len;
+}
+
+static ssize_t driver_override_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	char *driver_override, *old, *cp;
+
+	/* We need to keep extra room for a newline */
+	if (count >= (PAGE_SIZE - 1))
+		return -EINVAL;
+
+	driver_override = kstrndup(buf, count, GFP_KERNEL);
+	if (!driver_override)
+		return -ENOMEM;
+
+	cp = strchr(driver_override, '\n');
+	if (cp)
+		*cp = '\0';
+
+	device_lock(dev);
+	old = pdev->driver_override;
+	if (strlen(driver_override)) {
+		pdev->driver_override = driver_override;
+	} else {
+		kfree(driver_override);
+		pdev->driver_override = NULL;
+	}
+	device_unlock(dev);
+
+	kfree(old);
+
+	return count;
+}
+static DEVICE_ATTR_RW(driver_override);
+
+static struct attribute *platform_dev_attrs[] = {
+	&dev_attr_modalias.attr,
+	&dev_attr_numa_node.attr,
+	&dev_attr_driver_override.attr,
+	NULL,
+};
+
+static umode_t platform_dev_attrs_visible(struct kobject *kobj, struct attribute *a,
+		int n)
+{
+	struct device *dev = container_of(kobj, typeof(*dev), kobj);
+
+	if (a == &dev_attr_numa_node.attr &&
+			dev_to_node(dev) == NUMA_NO_NODE)
+		return 0;
+
+	return a->mode;
+}
+
+static struct attribute_group platform_dev_group = {
+	.attrs = platform_dev_attrs,
+	.is_visible = platform_dev_attrs_visible,
+};
+__ATTRIBUTE_GROUPS(platform_dev);
+
+
+/**
+ * platform_match - bind platform device to platform driver.
+ * @dev: device.
+ * @drv: driver.
+ *
+ * Platform device IDs are assumed to be encoded like this:
+ * "<name><instance>", where <name> is a short description of the type of
+ * device, like "pci" or "floppy", and <instance> is the enumerated
+ * instance of the device, like '0' or '42'.  Driver IDs are simply
+ * "<name>".  So, extract the <name> from the platform_device structure,
+ * and compare it against the name of the driver. Return whether they match
+ * or not.
+ */
+static int platform_match(struct device *dev, struct device_driver *drv)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct platform_driver *pdrv = to_platform_driver(drv);
+
+	/* When driver_override is set, only bind to the matching driver */
+	if (pdev->driver_override)
+		return !strcmp(pdev->driver_override, drv->name);
+
+	/* Attempt an OF style match first */
+	if (of_driver_match_device(dev, drv))
+		return 1;
+
+	/* Then try ACPI style match */
+	if (acpi_driver_match_device(dev, drv))
+		return 1;
+
+	/* Then try to match against the id table */
+	if (pdrv->id_table)
+		return platform_match_id(pdrv->id_table, pdev) != NULL;
+
+	/* fall-back to driver name match */
+	return (strcmp(pdev->name, drv->name) == 0);
+}
+
+static int platform_uevent(struct device *dev, struct kobj_uevent_env *env)
+{
+	struct platform_device	*pdev = to_platform_device(dev);
+	int rc;
+
+	/* Some devices have extra OF data and an OF-style MODALIAS */
+	rc = of_device_uevent_modalias(dev, env);
+	if (rc != -ENODEV)
+		return rc;
+
+	rc = acpi_device_uevent_modalias(dev, env);
+	if (rc != -ENODEV)
+		return rc;
+
+	add_uevent_var(env, "MODALIAS=%s%s", PLATFORM_MODULE_PREFIX,
+			pdev->name);
+	return 0;
+}
+
 int platform_dma_configure(struct device *dev)
 {
 	enum dev_dma_attr attr;

base-commit: 09162bc32c880a791c6c0668ce0745cf7958f576
-- 
2.28.0

