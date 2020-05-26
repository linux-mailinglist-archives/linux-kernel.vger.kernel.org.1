Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682D71DD701
	for <lists+linux-kernel@lfdr.de>; Thu, 21 May 2020 21:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbgEUTSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 May 2020 15:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730371AbgEUTSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 15:18:13 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80ADC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 12:18:12 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id 205so3621747qkh.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 12:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vZuJ+DR8JRthj2gGtF5M5rU4DW1OcEXJwK2O6f5EqAk=;
        b=SAnS8cxhi+lmediVHurXl4aIyC/awQXhfMFJmOgfATXnGFYPxEdm7TqXYYpg4c1iCi
         i+MITKxEK7qyK36N8HhFUVQeNzpbLquRtdWvSYH9cqtbadRqBhoRy+aEG+z8lZfqm9/C
         B+ILQ0iVB82sKisFNwRBTjbu3sEgSFKbETRazFjokduZWJVuJscbus0A+cMoWpgl/KSL
         8wk+aNGyTjkxwVqpmuZ6J4yscixA2iiYLKLyxb9q9pFF1stcpt4b/g6ufhLqqvTt3c1Q
         kuCQxhNy5/6vU9tnJyeaaO/3UD0CEkVNn/LbhEKBIoiLz/6jwi0BylwMdbrLKqLpWM7o
         lkzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vZuJ+DR8JRthj2gGtF5M5rU4DW1OcEXJwK2O6f5EqAk=;
        b=jwIerbyMZDN7xHEplJD8IHI+R4u238Oc7np7mjfflx96k2RnrovvTuYwoWEkqS0Tty
         DFJPNi45vPfM2Gm6dixx4VGATyPScETqWGl6NJ5WQayzsKTXM1nw9O1+d4Zn7jq1siS4
         RcMJPqTJOwZKSRwZOMfbE9M0Z4mxCz5NK+F88E3ZFVOdeSIEIFGW4VZWRbZ/VD4NM+gu
         jCulLxKgR5RBAkcXO/bFMAFVGnKteAxqKfstrOGKAiEYUAznsqKyk9LqKACxl61xiD+m
         yOR0f6JiyGF843ibUoyh3/l8UCOqAbQLR3m4SnPzIFyS2/P+h8IVezkON0a1GzhOST+m
         F8fw==
X-Gm-Message-State: AOAM531CWjhPwswKeuaJpnap8juPUChb/3ZLx43Ft66+5TqzP0Hl9WQQ
        2ge3CUN2lnJlp0g1jJzdxwdxB4L7UJIJpAs=
X-Google-Smtp-Source: ABdhPJzCA/OKG1DZAc1RRmyLrix0NBYSsM6ZA/gEXNcHEcQyb3/IogON6LJ4ABV1ixtiZZuluma3PJ/yVZQMFv0=
X-Received: by 2002:ad4:4b26:: with SMTP id s6mr271838qvw.146.1590088691976;
 Thu, 21 May 2020 12:18:11 -0700 (PDT)
Date:   Thu, 21 May 2020 12:17:58 -0700
In-Reply-To: <20200521191800.136035-1-saravanak@google.com>
Message-Id: <20200521191800.136035-2-saravanak@google.com>
Mime-Version: 1.0
References: <20200521191800.136035-1-saravanak@google.com>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH v3 1/3] driver core: Expose device link details in sysfs
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        linux-kernel@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's helpful to be able to look at device link details from sysfs. So,
expose it in sysfs.

Say device-A is supplier of device-B. These are the additional files
this patch would create:

/sys/class/devlink/device-A:device-B/
	auto_remove_on
	consumer/ -> .../device-B/
	runtime_pm
	status
	supplier/ -> .../device-A/
	sync_state_only

/sys/devices/.../device-A/
	consumer:device-B/ -> /sys/class/devlink/device-A:device-B/

/sys/devices/.../device-B/
	supplier:device-A/ -> /sys/class/devlink/device-A:device-B/

That way:
To get a list of all the device link in the system:
ls /sys/class/devlink/

To get the consumer names and links of a device:
ls -d /sys/devices/.../device-X/consumer:*

To get the supplier names and links of a device:
ls -d /sys/devices/.../device-X/supplier:*

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 Documentation/ABI/testing/sysfs-class-devlink | 126 +++++++++++
 .../ABI/testing/sysfs-devices-consumer        |   8 +
 .../ABI/testing/sysfs-devices-supplier        |   8 +
 drivers/base/core.c                           | 211 +++++++++++++++++-
 include/linux/device.h                        |  58 ++---
 5 files changed, 375 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-devlink
 create mode 100644 Documentation/ABI/testing/sysfs-devices-consumer
 create mode 100644 Documentation/ABI/testing/sysfs-devices-supplier

diff --git a/Documentation/ABI/testing/sysfs-class-devlink b/Documentation/ABI/testing/sysfs-class-devlink
new file mode 100644
index 000000000000..3a24973abb83
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-devlink
@@ -0,0 +1,126 @@
+What:		/sys/class/devlink/.../
+Date:		May 2020
+Contact:	Saravana Kannan <saravanak@google.com>
+Description:
+		Provide a place in sysfs for the device link objects in the
+		kernel at any given time.  The name of a device link directory,
+		denoted as ... above, is of the form <supplier>:<consumer>
+		where <supplier> is the supplier device name and <consumer> is
+		the consumer device name.
+
+What:		/sys/class/devlink/.../auto_remove_on
+Date:		May 2020
+Contact:	Saravana Kannan <saravanak@google.com>
+Description:
+		This file indicates if the device link will ever be
+		automatically removed by the driver core when the consumer and
+		supplier devices themselves are still present.
+
+		This will be one of the following strings:
+
+		'consumer unbind'
+		'supplier unbind'
+		'never'
+
+		'consumer unbind' means the device link will be removed when
+		the consumer's driver is unbound from the consumer device.
+
+		'supplier unbind' means the device link will be removed when
+		the supplier's driver is unbound from the supplier device.
+
+		'never' means the device link will not be automatically removed
+		when as long as the supplier and consumer devices themselves
+		are still present.
+
+What:		/sys/class/devlink/.../consumer
+Date:		May 2020
+Contact:	Saravana Kannan <saravanak@google.com>
+Description:
+		This file is a symlink to the consumer device's sysfs directory.
+
+What:		/sys/class/devlink/.../runtime_pm
+Date:		May 2020
+Contact:	Saravana Kannan <saravanak@google.com>
+Description:
+		This file indicates if the device link has any impact on the
+		runtime power management behavior of the consumer and supplier
+		devices. For example: Making sure the supplier doesn't enter
+		runtime suspend while the consumer is active.
+
+		This will be one of the following strings:
+
+		'0' - Does not affect runtime power management
+		'1' - Affects runtime power management
+
+What:		/sys/class/devlink/.../status
+Date:		May 2020
+Contact:	Saravana Kannan <saravanak@google.com>
+Description:
+		This file indicates the status of the device link. The status
+		of a device link is affected by whether the supplier and
+		consumer devices have been bound to their corresponding
+		drivers. The status of a device link also affects the binding
+		and unbinding of the supplier and consumer devices with their
+		drivers and also affects whether the software state of the
+		supplier device is synced with the hardware state of the
+		supplier device after boot up.
+		See also: sysfs-devices-state_synced.
+
+		This will be one of the following strings:
+
+		'not tracked'
+		'dormant'
+		'available'
+		'consumer probing'
+		'active'
+		'supplier unbinding'
+		'unknown'
+
+		'not tracked' means this device link does not track the status
+		and has no impact on the binding, unbinding and syncing the
+		hardware and software device state.
+
+		'dormant' means the supplier and the consumer devices have not
+		bound to their driver.
+
+		'available' means the supplier has bound to its driver and is
+		available to supply resources to the consumer device.
+
+		'consumer probing' means the consumer device is currently
+		trying to bind to its driver.
+
+		'active' means the supplier and consumer devices have both
+		bound successfully to their drivers.
+
+		'supplier unbinding' means the supplier devices is currently in
+		the process of unbinding from its driver.
+
+		'unknown' means the state of the device link is not any of the
+		above. If this is ever the value, there's a bug in the kernel.
+
+What:		/sys/class/devlink/.../supplier
+Date:		May 2020
+Contact:	Saravana Kannan <saravanak@google.com>
+Description:
+		This file is a symlink to the supplier device's sysfs directory.
+
+What:		/sys/class/devlink/.../sync_state_only
+Date:		May 2020
+Contact:	Saravana Kannan <saravanak@google.com>
+Description:
+		This file indicates if the device link is limited to only
+		affecting the syncing of the hardware and software state of the
+		supplier device.
+
+		This will be one of the following strings:
+
+		'0'
+		'1' - Affects runtime power management
+
+		'0' means the device link can affect other device behaviors
+		like binding/unbinding, suspend/resume, runtime power
+		management, etc.
+
+		'1' means the device link will only affect the syncing of
+		hardware and software state of the supplier device after boot
+		up and doesn't not affect other behaviors of the devices.
diff --git a/Documentation/ABI/testing/sysfs-devices-consumer b/Documentation/ABI/testing/sysfs-devices-consumer
new file mode 100644
index 000000000000..1f06d74d1c3c
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-consumer
@@ -0,0 +1,8 @@
+What:		/sys/devices/.../consumer:<consumer>
+Date:		May 2020
+Contact:	Saravana Kannan <saravanak@google.com>
+Description:
+		The /sys/devices/.../consumer:<consumer> are symlinks to device
+		links where this device is the supplier. <consumer> denotes the
+		name of the consumer in that device link. There can be zero or
+		more of these symlinks for a given device.
diff --git a/Documentation/ABI/testing/sysfs-devices-supplier b/Documentation/ABI/testing/sysfs-devices-supplier
new file mode 100644
index 000000000000..a919e0db5e90
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-supplier
@@ -0,0 +1,8 @@
+What:		/sys/devices/.../supplier:<supplier>
+Date:		May 2020
+Contact:	Saravana Kannan <saravanak@google.com>
+Description:
+		The /sys/devices/.../supplier:<supplier> are symlinks to device
+		links where this device is the consumer. <supplier> denotes the
+		name of the supplier in that device link. There can be zero or
+		more of these symlinks for a given device.
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 791b7530599f..81c8ef088d3a 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -235,6 +235,186 @@ void device_pm_move_to_tail(struct device *dev)
 	device_links_read_unlock(idx);
 }
 
+#define to_devlink(dev)	container_of((dev), struct device_link, link_dev)
+
+static ssize_t status_show(struct device *dev,
+			  struct device_attribute *attr, char *buf)
+{
+	char *status;
+
+	switch (to_devlink(dev)->status) {
+	case DL_STATE_NONE:
+		status = "not tracked"; break;
+	case DL_STATE_DORMANT:
+		status = "dormant"; break;
+	case DL_STATE_AVAILABLE:
+		status = "available"; break;
+	case DL_STATE_CONSUMER_PROBE:
+		status = "consumer probing"; break;
+	case DL_STATE_ACTIVE:
+		status = "active"; break;
+	case DL_STATE_SUPPLIER_UNBIND:
+		status = "supplier unbinding"; break;
+	default:
+		status = "unknown"; break;
+	}
+	return sprintf(buf, "%s\n", status);
+}
+static DEVICE_ATTR_RO(status);
+
+static ssize_t auto_remove_on_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct device_link *link = to_devlink(dev);
+	char *str;
+
+	if (link->flags & DL_FLAG_AUTOREMOVE_SUPPLIER)
+		str = "supplier unbind";
+	else if (link->flags & DL_FLAG_AUTOREMOVE_CONSUMER)
+		str = "consumer unbind";
+	else
+		str = "never";
+
+	return sprintf(buf, "%s\n", str);
+}
+static DEVICE_ATTR_RO(auto_remove_on);
+
+static ssize_t runtime_pm_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct device_link *link = to_devlink(dev);
+
+	return sprintf(buf, "%d\n", !!(link->flags & DL_FLAG_PM_RUNTIME));
+}
+static DEVICE_ATTR_RO(runtime_pm);
+
+static ssize_t sync_state_only_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct device_link *link = to_devlink(dev);
+
+	return sprintf(buf, "%d\n", !!(link->flags & DL_FLAG_SYNC_STATE_ONLY));
+}
+static DEVICE_ATTR_RO(sync_state_only);
+
+static struct attribute *devlink_attrs[] = {
+	&dev_attr_status.attr,
+	&dev_attr_auto_remove_on.attr,
+	&dev_attr_runtime_pm.attr,
+	&dev_attr_sync_state_only.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(devlink);
+
+static void devlink_dev_release(struct device *dev)
+{
+	kfree(to_devlink(dev));
+}
+
+static struct class devlink_class = {
+	.name = "devlink",
+	.owner = THIS_MODULE,
+	.dev_groups = devlink_groups,
+	.dev_release = devlink_dev_release,
+};
+
+static int devlink_add_symlinks(struct device *dev,
+				struct class_interface *class_intf)
+{
+	int ret;
+	size_t len;
+	struct device_link *link = to_devlink(dev);
+	struct device *sup = link->supplier;
+	struct device *con = link->consumer;
+	char *buf;
+
+	len = max(strlen(dev_name(sup)), strlen(dev_name(con)));
+	len += strlen("supplier:") + 1;
+	buf = kzalloc(len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = sysfs_create_link(&link->link_dev.kobj, &sup->kobj, "supplier");
+	if (ret)
+		goto out;
+
+	ret = sysfs_create_link(&link->link_dev.kobj, &con->kobj, "consumer");
+	if (ret)
+		goto err_con;
+
+	snprintf(buf, len, "consumer:%s", dev_name(con));
+	ret = sysfs_create_link(&sup->kobj, &link->link_dev.kobj, buf);
+	if (ret)
+		goto err_con_dev;
+
+	snprintf(buf, len, "supplier:%s", dev_name(sup));
+	ret = sysfs_create_link(&con->kobj, &link->link_dev.kobj, buf);
+	if (ret)
+		goto err_sup_dev;
+
+	goto out;
+
+err_sup_dev:
+	snprintf(buf, len, "consumer:%s", dev_name(con));
+	sysfs_remove_link(&sup->kobj, buf);
+err_con_dev:
+	sysfs_remove_link(&link->link_dev.kobj, "consumer");
+err_con:
+	sysfs_remove_link(&link->link_dev.kobj, "supplier");
+out:
+	kfree(buf);
+	return ret;
+}
+
+static void devlink_remove_symlinks(struct device *dev,
+				   struct class_interface *class_intf)
+{
+	struct device_link *link = to_devlink(dev);
+	size_t len;
+	struct device *sup = link->supplier;
+	struct device *con = link->consumer;
+	char *buf;
+
+	sysfs_remove_link(&link->link_dev.kobj, "consumer");
+	sysfs_remove_link(&link->link_dev.kobj, "supplier");
+
+	len = max(strlen(dev_name(sup)), strlen(dev_name(con)));
+	len += strlen("supplier:") + 1;
+	buf = kzalloc(len, GFP_KERNEL);
+	if (!buf) {
+		WARN(1, "Unable to properly free device link symlinks!\n");
+		return;
+	}
+
+	snprintf(buf, len, "supplier:%s", dev_name(sup));
+	sysfs_remove_link(&con->kobj, buf);
+	snprintf(buf, len, "consumer:%s", dev_name(con));
+	sysfs_remove_link(&sup->kobj, buf);
+	kfree(buf);
+}
+
+static struct class_interface devlink_class_intf = {
+	.class = &devlink_class,
+	.add_dev = devlink_add_symlinks,
+	.remove_dev = devlink_remove_symlinks,
+};
+
+static int __init devlink_class_init(void)
+{
+	int ret;
+
+	ret = class_register(&devlink_class);
+	if (ret)
+		return ret;
+
+	ret = class_interface_register(&devlink_class_intf);
+	if (ret)
+		class_unregister(&devlink_class);
+
+	return ret;
+}
+postcore_initcall(devlink_class_init);
+
 #define DL_MANAGED_LINK_FLAGS (DL_FLAG_AUTOREMOVE_CONSUMER | \
 			       DL_FLAG_AUTOREMOVE_SUPPLIER | \
 			       DL_FLAG_AUTOPROBE_CONSUMER  | \
@@ -407,13 +587,6 @@ struct device_link *device_link_add(struct device *consumer,
 
 	refcount_set(&link->rpm_active, 1);
 
-	if (flags & DL_FLAG_PM_RUNTIME) {
-		if (flags & DL_FLAG_RPM_ACTIVE)
-			refcount_inc(&link->rpm_active);
-
-		pm_runtime_new_link(consumer);
-	}
-
 	get_device(supplier);
 	link->supplier = supplier;
 	INIT_LIST_HEAD(&link->s_node);
@@ -423,6 +596,25 @@ struct device_link *device_link_add(struct device *consumer,
 	link->flags = flags;
 	kref_init(&link->kref);
 
+	link->link_dev.class = &devlink_class;
+	device_set_pm_not_required(&link->link_dev);
+	dev_set_name(&link->link_dev, "%s:%s",
+		     dev_name(supplier), dev_name(consumer));
+	if (device_register(&link->link_dev)) {
+		put_device(consumer);
+		put_device(supplier);
+		kfree(link);
+		link = NULL;
+		goto out;
+	}
+
+	if (flags & DL_FLAG_PM_RUNTIME) {
+		if (flags & DL_FLAG_RPM_ACTIVE)
+			refcount_inc(&link->rpm_active);
+
+		pm_runtime_new_link(consumer);
+	}
+
 	/* Determine the initial link state. */
 	if (flags & DL_FLAG_STATELESS)
 		link->status = DL_STATE_NONE;
@@ -545,7 +737,7 @@ static void device_link_free(struct device_link *link)
 
 	put_device(link->consumer);
 	put_device(link->supplier);
-	kfree(link);
+	device_unregister(&link->link_dev);
 }
 
 #ifdef CONFIG_SRCU
@@ -1141,6 +1333,9 @@ static void device_links_purge(struct device *dev)
 {
 	struct device_link *link, *ln;
 
+	if (dev->class == &devlink_class)
+		return;
+
 	mutex_lock(&wfs_lock);
 	list_del(&dev->links.needs_suppliers);
 	mutex_unlock(&wfs_lock);
diff --git a/include/linux/device.h b/include/linux/device.h
index ac8e37cd716a..4c10afed9cd6 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -386,34 +386,6 @@ enum device_link_state {
 #define DL_FLAG_MANAGED			BIT(6)
 #define DL_FLAG_SYNC_STATE_ONLY		BIT(7)
 
-/**
- * struct device_link - Device link representation.
- * @supplier: The device on the supplier end of the link.
- * @s_node: Hook to the supplier device's list of links to consumers.
- * @consumer: The device on the consumer end of the link.
- * @c_node: Hook to the consumer device's list of links to suppliers.
- * @status: The state of the link (with respect to the presence of drivers).
- * @flags: Link flags.
- * @rpm_active: Whether or not the consumer device is runtime-PM-active.
- * @kref: Count repeated addition of the same link.
- * @rcu_head: An RCU head to use for deferred execution of SRCU callbacks.
- * @supplier_preactivated: Supplier has been made active before consumer probe.
- */
-struct device_link {
-	struct device *supplier;
-	struct list_head s_node;
-	struct device *consumer;
-	struct list_head c_node;
-	enum device_link_state status;
-	u32 flags;
-	refcount_t rpm_active;
-	struct kref kref;
-#ifdef CONFIG_SRCU
-	struct rcu_head rcu_head;
-#endif
-	bool supplier_preactivated; /* Owned by consumer probe. */
-};
-
 /**
  * enum dl_dev_state - Device driver presence tracking information.
  * @DL_DEV_NO_DRIVER: There is no driver attached to the device.
@@ -624,6 +596,36 @@ struct device {
 #endif
 };
 
+/**
+ * struct device_link - Device link representation.
+ * @supplier: The device on the supplier end of the link.
+ * @s_node: Hook to the supplier device's list of links to consumers.
+ * @consumer: The device on the consumer end of the link.
+ * @c_node: Hook to the consumer device's list of links to suppliers.
+ * @link_dev: device used to expose link details in sysfs
+ * @status: The state of the link (with respect to the presence of drivers).
+ * @flags: Link flags.
+ * @rpm_active: Whether or not the consumer device is runtime-PM-active.
+ * @kref: Count repeated addition of the same link.
+ * @rcu_head: An RCU head to use for deferred execution of SRCU callbacks.
+ * @supplier_preactivated: Supplier has been made active before consumer probe.
+ */
+struct device_link {
+	struct device *supplier;
+	struct list_head s_node;
+	struct device *consumer;
+	struct list_head c_node;
+	struct device link_dev;
+	enum device_link_state status;
+	u32 flags;
+	refcount_t rpm_active;
+	struct kref kref;
+#ifdef CONFIG_SRCU
+	struct rcu_head rcu_head;
+#endif
+	bool supplier_preactivated; /* Owned by consumer probe. */
+};
+
 static inline struct device *kobj_to_dev(struct kobject *kobj)
 {
 	return container_of(kobj, struct device, kobj);
-- 
2.27.0.rc0.183.gde8f92d652-goog

