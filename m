Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586682CB047
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 23:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbgLAWiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 17:38:21 -0500
Received: from mga18.intel.com ([134.134.136.126]:58210 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727477AbgLAWiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 17:38:18 -0500
IronPort-SDR: msHLRsqhu9sLNEoWO6hnCsssjX1VVZsY2e0BeemF44W2XvciyiRBYdPBcyMiJ/hFWGRJWbuB6K
 /y5jbvyQ9/Cw==
X-IronPort-AV: E=McAfee;i="6000,8403,9822"; a="160688762"
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="160688762"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 14:35:17 -0800
IronPort-SDR: TpfC+SrceAVXvGP2hMMlZhJum6BIJ/EYdgVPGx4A1J5xfXiZhXSrOZ2IqPbw6iw9QnXxratOBw
 1qw0ClezWU5Q==
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="364993436"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 14:35:16 -0800
Received: from mtg-dev (mtg-dev.jf.intel.com [10.54.74.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.ostc.intel.com (Postfix) with ESMTPS id 1FF47636D;
        Tue,  1 Dec 2020 14:35:16 -0800 (PST)
Received: from mgross by mtg-dev with local (Exim 4.90_1)
        (envelope-from <mgross@linux.intel.com>)
        id 1kkEEt-000H5G-VY; Tue, 01 Dec 2020 14:35:15 -0800
From:   mgross@linux.intel.com
To:     markgross@kernel.org, mgross@linux.intel.com, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        leonard.crestez@nxp.com, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, peng.fan@nxp.com, robh+dt@kernel.org,
        shawnguo@kernel.org
Cc:     linux-kernel@vger.kernel.org, Seamus Kelly <seamus.kelly@intel.com>
Subject: [PATCH 21/22] xlink-core: add async channel and events
Date:   Tue,  1 Dec 2020 14:35:10 -0800
Message-Id: <20201201223511.65542-22-mgross@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201201223511.65542-1-mgross@linux.intel.com>
References: <20201201223511.65542-1-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Seamus Kelly <seamus.kelly@intel.com>

Enable asynchronous channel and event communication.

    Add APIs:
            data ready callback:
			The xLink Data Ready Callback function is used to
			register a callback function that is invoked when data
			is ready to be read from a channel
            data consumed callback:
			The xLink Data Consumed Callback function is used to
			register a callback function that is invoked when data
			is consumed by the peer node on a channel
    Add event notification handling including APIs:
            register device event:
			The xLink Register Device Event function is used to
			register a callback for notification of certain system
			events. Currently XLink supports 4 such events [0-3]
			whose meaning is system dependent.  Registering for an
			event means that the callback will be called when the
			event occurs with 2 parameters the sw_device_id of the
			device that triggered the event and the event number [0-3]
            unregister device event
			The xLink Unregister Device Event function is used to
			unregister events that have previously been registered
			by register device event API

Reviewed-by: Mark Gross <mgross@linux.intel.com>
Signed-off-by: Seamus Kelly <seamus.kelly@intel.com>
---
 drivers/misc/xlink-core/xlink-core.c        | 422 +++++++++++++++++++-
 drivers/misc/xlink-core/xlink-defs.h        |   4 +
 drivers/misc/xlink-core/xlink-dispatcher.c  |  53 ++-
 drivers/misc/xlink-core/xlink-multiplexer.c | 176 +++++---
 drivers/misc/xlink-core/xlink-platform.c    |  27 ++
 include/linux/xlink.h                       |  15 +-
 6 files changed, 609 insertions(+), 88 deletions(-)

diff --git a/drivers/misc/xlink-core/xlink-core.c b/drivers/misc/xlink-core/xlink-core.c
index a600068840d3..63f65def8aa9 100644
--- a/drivers/misc/xlink-core/xlink-core.c
+++ b/drivers/misc/xlink-core/xlink-core.c
@@ -62,6 +62,16 @@ static enum xlink_error xlink_write_volatile_user(struct xlink_handle *handle,
 static enum xlink_error do_xlink_write_volatile(struct xlink_handle *handle,
 						u16 chan, u8 const *message,
 						u32 size, u32 user_flag);
+static enum xlink_error xlink_register_device_event_user(struct xlink_handle *handle,
+							 u32 *event_list,
+							 u32 num_events,
+							 xlink_device_event_cb event_notif_fn);
+static enum xlink_error do_xlink_register_device_event(struct xlink_handle *handle,
+						       u32 *event_list,
+						       u32 num_events,
+						       xlink_device_event_cb event_notif_fn,
+						       u32 user_flag);
+static struct mutex dev_event_lock;
 
 static const struct file_operations fops = {
 		.owner		= THIS_MODULE,
@@ -74,14 +84,81 @@ struct xlink_link {
 	struct kref refcount;
 };
 
+struct xlink_attr {
+	unsigned long value;
+	u32 sw_dev_id;
+};
+
 struct keembay_xlink_dev {
 	struct platform_device *pdev;
 	struct xlink_link links[XLINK_MAX_CONNECTIONS];
 	u32 nmb_connected_links;
 	struct mutex lock;  // protect access to xlink_dev
+	struct xlink_attr eventx[4];
+};
+
+struct event_info {
+	struct list_head list;
+	u32 sw_device_id;
+	u32 event_type;
+	u32 user_flag;
+	xlink_device_event_cb event_notif_fn;
 };
 
 static u8 volbuf[XLINK_MAX_BUF_SIZE]; // buffer for volatile transactions
+#define NUM_REG_EVENTS 4
+
+// sysfs attribute functions
+
+static ssize_t event0_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct keembay_xlink_dev *xlink_dev = dev_get_drvdata(dev);
+	struct xlink_attr *a = &xlink_dev->eventx[0];
+
+	return scnprintf(buf, PAGE_SIZE, "0x%x 0x%lx\n", a->sw_dev_id, a->value);
+}
+
+static ssize_t event1_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct keembay_xlink_dev *xlink_dev = dev_get_drvdata(dev);
+	struct xlink_attr *a = &xlink_dev->eventx[1];
+
+	return scnprintf(buf, PAGE_SIZE, "0x%x 0x%lx\n", a->sw_dev_id, a->value);
+}
+
+static ssize_t event2_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct keembay_xlink_dev *xlink_dev = dev_get_drvdata(dev);
+	struct xlink_attr *a = &xlink_dev->eventx[2];
+
+	return scnprintf(buf, PAGE_SIZE, "0x%x 0x%lx\n", a->sw_dev_id, a->value);
+}
+
+static ssize_t event3_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct keembay_xlink_dev *xlink_dev = dev_get_drvdata(dev);
+	struct xlink_attr *a = &xlink_dev->eventx[3];
+
+	return scnprintf(buf, PAGE_SIZE, "0x%x 0x%lx\n", a->sw_dev_id, a->value);
+}
+
+static DEVICE_ATTR_RO(event0);
+static DEVICE_ATTR_RO(event1);
+static DEVICE_ATTR_RO(event2);
+static DEVICE_ATTR_RO(event3);
+static struct attribute *xlink_sysfs_entries[] = {
+	&dev_attr_event0.attr,
+	&dev_attr_event1.attr,
+	&dev_attr_event2.attr,
+	&dev_attr_event3.attr,
+	NULL,
+};
+
+static const struct attribute_group xlink_sysfs_group = {
+	.attrs = xlink_sysfs_entries,
+};
+
+static struct event_info ev_info;
 
 /*
  * global variable pointing to our xlink device.
@@ -215,7 +292,14 @@ static int kmb_xlink_probe(struct platform_device *pdev)
 		dev_info(&pdev->dev, "Cannot add the device to the system\n");
 		goto r_class;
 	}
+	INIT_LIST_HEAD(&ev_info.list);
 
+	rc = devm_device_add_group(&pdev->dev, &xlink_sysfs_group);
+	if (rc) {
+		dev_err(&pdev->dev, "failed to create sysfs entries: %d\n", rc);
+		return rc;
+	}
+	mutex_init(&dev_event_lock);
 	return 0;
 
 r_device:
@@ -239,7 +323,6 @@ static int kmb_xlink_remove(struct platform_device *pdev)
 	rc = xlink_multiplexer_destroy();
 	if (rc != X_LINK_SUCCESS)
 		pr_err("Multiplexer destroy failed\n");
-	// stop dispatchers and destroy
 	rc = xlink_dispatcher_destroy();
 	if (rc != X_LINK_SUCCESS)
 		pr_err("Dispatcher destroy failed\n");
@@ -270,19 +353,23 @@ static long xlink_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	struct xlinkconnect		con	= {0};
 	struct xlinkrelease		rel	= {0};
 	struct xlinkstartvpu		startvpu = {0};
+	struct xlinkcallback		cb	= {0};
 	struct xlinkgetdevicename	devn	= {0};
 	struct xlinkgetdevicelist	devl	= {0};
 	struct xlinkgetdevicestatus	devs	= {0};
 	struct xlinkbootdevice		boot	= {0};
 	struct xlinkresetdevice		res	= {0};
 	struct xlinkdevmode		devm	= {0};
+	struct xlinkregdevevent		regdevevent = {0};
 	u32 sw_device_id_list[XLINK_MAX_DEVICE_LIST_SIZE];
 	char name[XLINK_MAX_DEVICE_NAME_SIZE];
 	int interface = NULL_INTERFACE;
 	u32 device_status = 0;
 	u32 num_devices = 0;
 	u32 device_mode = 0;
+	u32 num_events = 0;
 	char filename[64];
+	u32 *ev_list;
 	u8 reladdr;
 	u8 *rdaddr;
 	u32 size;
@@ -318,6 +405,30 @@ static long xlink_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		if (copy_to_user((void __user *)op.return_code, (void *)&rc, sizeof(rc)))
 			return -EFAULT;
 		break;
+	case XL_DATA_READY_CALLBACK:
+		if (copy_from_user(&cb, (void __user *)arg,
+				   sizeof(struct xlinkcallback)))
+			return -EFAULT;
+		if (copy_from_user(&devh, (void __user *)cb.handle,
+				   sizeof(struct xlink_handle)))
+			return -EFAULT;
+		CHANNEL_SET_USER_BIT(cb.chan); // set MSbit for user space call
+		rc = xlink_data_available_event(&devh, cb.chan, cb.callback);
+		if (copy_to_user((void __user *)cb.return_code, (void *)&rc, sizeof(rc)))
+			return -EFAULT;
+		break;
+	case XL_DATA_CONSUMED_CALLBACK:
+		if (copy_from_user(&cb, (void __user *)arg,
+				   sizeof(struct xlinkcallback)))
+			return -EFAULT;
+		if (copy_from_user(&devh, (void __user *)cb.handle,
+				   sizeof(struct xlink_handle)))
+			return -EFAULT;
+		CHANNEL_SET_USER_BIT(cb.chan); // set MSbit for user space call
+		rc = xlink_data_consumed_event(&devh, cb.chan, cb.callback);
+		if (copy_to_user((void __user *)cb.return_code, (void *)&rc, sizeof(rc)))
+			return -EFAULT;
+		break;
 	case XL_READ_DATA:
 		if (copy_from_user(&rd, (void __user *)arg,
 				   sizeof(struct xlinkreaddata)))
@@ -598,6 +709,61 @@ static long xlink_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		if (copy_to_user((void __user *)devm.return_code, (void *)&rc, sizeof(rc)))
 			return -EFAULT;
 		break;
+	case XL_REGISTER_DEV_EVENT:
+		if (copy_from_user(&regdevevent, (void __user *)arg,
+				   sizeof(struct xlinkregdevevent)))
+			return -EFAULT;
+		if (copy_from_user(&devh, (void __user *)regdevevent.handle,
+				   sizeof(struct xlink_handle)))
+			return -EFAULT;
+		num_events = regdevevent.num_events;
+		if (num_events > 0 && num_events <= NUM_REG_EVENTS) {
+			ev_list = kzalloc((num_events * sizeof(u32)), GFP_KERNEL);
+			if (ev_list) {
+				if (copy_from_user(ev_list,
+						   (void __user *)regdevevent.event_list,
+						   (num_events * sizeof(u32)))) {
+					kfree(ev_list);
+					return -EFAULT;
+				}
+				rc = xlink_register_device_event_user(&devh,
+								      ev_list,
+								      num_events,
+								      NULL);
+				kfree(ev_list);
+			} else {
+				rc = X_LINK_ERROR;
+			}
+		} else {
+			rc = X_LINK_ERROR;
+		}
+		if (copy_to_user((void __user *)regdevevent.return_code, (void *)&rc, sizeof(rc)))
+			return -EFAULT;
+		break;
+	case XL_UNREGISTER_DEV_EVENT:
+		if (copy_from_user(&regdevevent, (void __user *)arg,
+				   sizeof(struct xlinkregdevevent)))
+			return -EFAULT;
+		if (copy_from_user(&devh, (void __user *)regdevevent.handle,
+				   sizeof(struct xlink_handle)))
+			return -EFAULT;
+		num_events = regdevevent.num_events;
+		if (num_events <= NUM_REG_EVENTS) {
+			ev_list = kzalloc((num_events * sizeof(u32)), GFP_KERNEL);
+			if (copy_from_user(ev_list,
+					   (void __user *)regdevevent.event_list,
+					   (num_events * sizeof(u32)))) {
+				kfree(ev_list);
+				return -EFAULT;
+			}
+			rc = xlink_unregister_device_event(&devh, ev_list, num_events);
+			kfree(ev_list);
+		} else {
+			rc = X_LINK_ERROR;
+		}
+		if (copy_to_user((void __user *)regdevevent.return_code, (void *)&rc, sizeof(rc)))
+			return -EFAULT;
+		break;
 	}
 	if (rc)
 		return -EIO;
@@ -671,14 +837,12 @@ enum xlink_error xlink_connect(struct xlink_handle *handle)
 		xlink->nmb_connected_links++;
 		kref_init(&link->refcount);
 		if (interface != IPC_INTERFACE) {
-			// start dispatcher
 			rc = xlink_dispatcher_start(link->id, &link->handle);
 			if (rc) {
 				pr_err("dispatcher start failed\n");
 				goto r_cleanup;
 			}
 		}
-		// initialize multiplexer connection
 		rc = xlink_multiplexer_connect(link->id);
 		if (rc) {
 			pr_err("multiplexer connect failed\n");
@@ -689,7 +853,6 @@ enum xlink_error xlink_connect(struct xlink_handle *handle)
 			link->handle.dev_type,
 			xlink->nmb_connected_links);
 	} else {
-		// already connected
 		pr_info("dev 0x%x ALREADY connected - dev_type %d\n",
 			link->handle.sw_device_id,
 			link->handle.dev_type);
@@ -697,7 +860,6 @@ enum xlink_error xlink_connect(struct xlink_handle *handle)
 		*handle = link->handle;
 	}
 	mutex_unlock(&xlink->lock);
-	// TODO: implement ping
 	return X_LINK_SUCCESS;
 
 r_cleanup:
@@ -707,6 +869,78 @@ enum xlink_error xlink_connect(struct xlink_handle *handle)
 }
 EXPORT_SYMBOL(xlink_connect);
 
+enum xlink_error xlink_data_available_event(struct xlink_handle *handle,
+					    u16 chan,
+					    xlink_event data_available_event)
+{
+	struct xlink_event *event;
+	struct xlink_link *link;
+	enum xlink_error rc;
+	int event_queued = 0;
+	char origin = 'K';
+
+	if (!xlink || !handle)
+		return X_LINK_ERROR;
+
+	if (CHANNEL_USER_BIT_IS_SET(chan))
+		origin  = 'U';     // function called from user space
+	CHANNEL_CLEAR_USER_BIT(chan);  // restore proper channel value
+
+	link = get_link_by_sw_device_id(handle->sw_device_id);
+	if (!link)
+		return X_LINK_ERROR;
+	event = xlink_create_event(link->id, XLINK_DATA_READY_CALLBACK_REQ,
+				   &link->handle, chan, 0, 0);
+	if (!event)
+		return X_LINK_ERROR;
+	event->data = data_available_event;
+	event->callback_origin = origin;
+	if (!data_available_event)
+		event->calling_pid = NULL; // disable callbacks on this channel
+	else
+		event->calling_pid = current;
+	rc = xlink_multiplexer_tx(event, &event_queued);
+	if (!event_queued)
+		xlink_destroy_event(event);
+	return rc;
+}
+EXPORT_SYMBOL(xlink_data_available_event);
+enum xlink_error xlink_data_consumed_event(struct xlink_handle *handle,
+					   u16 chan,
+					   xlink_event data_consumed_event)
+{
+	struct xlink_event *event;
+	struct xlink_link *link;
+	enum xlink_error rc;
+	int event_queued = 0;
+	char origin = 'K';
+
+	if (!xlink || !handle)
+		return X_LINK_ERROR;
+
+	if (CHANNEL_USER_BIT_IS_SET(chan))
+		origin  = 'U';     // function called from user space
+	CHANNEL_CLEAR_USER_BIT(chan);  // restore proper channel value
+
+	link = get_link_by_sw_device_id(handle->sw_device_id);
+	if (!link)
+		return X_LINK_ERROR;
+	event = xlink_create_event(link->id, XLINK_DATA_CONSUMED_CALLBACK_REQ,
+				   &link->handle, chan, 0, 0);
+	if (!event)
+		return X_LINK_ERROR;
+	event->data = data_consumed_event;
+	event->callback_origin = origin;
+	if (!data_consumed_event)
+		event->calling_pid = NULL; // disable callbacks on this channel
+	else
+		event->calling_pid = current;
+	rc = xlink_multiplexer_tx(event, &event_queued);
+	if (!event_queued)
+		xlink_destroy_event(event);
+	return rc;
+}
+EXPORT_SYMBOL(xlink_data_consumed_event);
 enum xlink_error xlink_open_channel(struct xlink_handle *handle,
 				    u16 chan, enum xlink_opmode mode,
 				    u32 data_size, u32 timeout)
@@ -1051,8 +1285,8 @@ EXPORT_SYMBOL(xlink_release_data);
 enum xlink_error xlink_disconnect(struct xlink_handle *handle)
 {
 	struct xlink_link *link;
-	int interface = NULL_INTERFACE;
-	enum xlink_error rc = X_LINK_ERROR;
+	int interface;
+	enum xlink_error rc = 0;
 
 	if (!xlink || !handle)
 		return X_LINK_ERROR;
@@ -1061,7 +1295,6 @@ enum xlink_error xlink_disconnect(struct xlink_handle *handle)
 	if (!link)
 		return X_LINK_ERROR;
 
-	// decrement refcount, if count is 0 lock mutex and disconnect
 	if (kref_put_mutex(&link->refcount, release_after_kref_put,
 			   &xlink->lock)) {
 		// stop dispatcher
@@ -1240,6 +1473,179 @@ enum xlink_error xlink_get_device_mode(struct xlink_handle *handle,
 	return rc;
 }
 EXPORT_SYMBOL(xlink_get_device_mode);
+
+static int xlink_device_event_handler(u32 sw_device_id, u32 event_type)
+{
+	struct event_info *events = NULL;
+	xlink_device_event_cb event_cb;
+	bool found = false;
+	char event_attr[7];
+
+	mutex_lock(&dev_event_lock);
+	// find sw_device_id, event_type in list
+	list_for_each_entry(events, &ev_info.list, list) {
+		if (events) {
+			if (events->sw_device_id == sw_device_id &&
+			    events->event_type == event_type) {
+				event_cb = events->event_notif_fn;
+				found = true;
+				break;
+			}
+		}
+	}
+	if (found) {
+		if (events->user_flag) {
+			xlink->eventx[events->event_type].value = events->event_type;
+			xlink->eventx[events->event_type].sw_dev_id = sw_device_id;
+			sprintf(event_attr, "event%d", events->event_type);
+			sysfs_notify(&xlink->pdev->dev.kobj, NULL, event_attr);
+		} else {
+			if (event_cb) {
+				event_cb(sw_device_id, event_type);
+			} else {
+				pr_info("No callback found for sw_device_id : 0x%x event type %d\n",
+					sw_device_id, event_type);
+				mutex_unlock(&dev_event_lock);
+				return X_LINK_ERROR;
+			}
+		}
+		pr_info("sysfs_notify event %d swdev_id %xs\n",
+			events->event_type, sw_device_id);
+	}
+	mutex_unlock(&dev_event_lock);
+return X_LINK_SUCCESS;
+}
+
+static bool event_registered(u32 sw_dev_id, u32 event)
+{
+	struct event_info *events = NULL;
+
+	list_for_each_entry(events, &ev_info.list, list) {
+		if (events) {
+			if (events->sw_device_id == sw_dev_id &&
+			    events->event_type == event) {
+				return true;
+			}
+		}
+	}
+return false;
+}
+
+static enum xlink_error xlink_register_device_event_user(struct xlink_handle *handle,
+							 u32 *event_list, u32 num_events,
+							 xlink_device_event_cb event_notif_fn)
+{
+	enum xlink_error rc;
+
+	rc = do_xlink_register_device_event(handle, event_list, num_events,
+					    event_notif_fn, 1);
+	return rc;
+}
+
+enum xlink_error xlink_register_device_event(struct xlink_handle *handle,
+					     u32 *event_list, u32 num_events,
+					     xlink_device_event_cb event_notif_fn)
+{
+	enum xlink_error rc;
+
+	rc = do_xlink_register_device_event(handle, event_list, num_events,
+					    event_notif_fn, 0);
+	return rc;
+}
+EXPORT_SYMBOL(xlink_register_device_event);
+
+static enum xlink_error do_xlink_register_device_event(struct xlink_handle *handle,
+						       u32 *event_list,
+						       u32 num_events,
+						       xlink_device_event_cb event_notif_fn,
+						       u32 user_flag)
+{
+	struct event_info *events;
+	u32 interface;
+	u32 event;
+	int i;
+
+	if (num_events < 0 || num_events >= NUM_REG_EVENTS)
+		return X_LINK_ERROR;
+	for (i = 0; i < num_events; i++) {
+		events = kzalloc(sizeof(*events), GFP_KERNEL);
+		if (!events)
+			return X_LINK_ERROR;
+		event = *event_list;
+		events->sw_device_id = handle->sw_device_id;
+		events->event_notif_fn = event_notif_fn;
+		events->event_type = *event_list++;
+		events->user_flag = user_flag;
+		if (user_flag) {
+			/* only add to list once if userspace */
+			/* xlink userspace handles multi process callbacks */
+			if (event_registered(handle->sw_device_id, event)) {
+				pr_info("xlink-core: Event 0x%x - %d already registered\n",
+					handle->sw_device_id, event);
+				kfree(events);
+				continue;
+			}
+		}
+		pr_info("xlink-core:Events: sw_device_id 0x%x event %d fn %p user_flag %d\n",
+			events->sw_device_id, events->event_type,
+			events->event_notif_fn, events->user_flag);
+		list_add_tail(&events->list, &ev_info.list);
+	}
+	interface = get_interface_from_sw_device_id(handle->sw_device_id);
+	if (interface == NULL_INTERFACE)
+		return X_LINK_ERROR;
+	xlink_platform_register_for_events(interface, handle->sw_device_id,
+					   xlink_device_event_handler);
+	return X_LINK_SUCCESS;
+}
+
+enum xlink_error xlink_unregister_device_event(struct xlink_handle *handle,
+					       u32 *event_list,
+					       u32 num_events)
+{
+	struct event_info *events = NULL;
+	u32 interface;
+	int found = 0;
+	int count = 0;
+	int i;
+
+	if (num_events < 0 || num_events >= NUM_REG_EVENTS)
+		return X_LINK_ERROR;
+	for (i = 0; i < num_events; i++) {
+		list_for_each_entry(events, &ev_info.list, list) {
+			if (events->sw_device_id == handle->sw_device_id &&
+			    events->event_type == event_list[i]) {
+				found = 1;
+				break;
+			}
+		}
+		if (!events || !found)
+			return X_LINK_ERROR;
+		pr_info("removing event %d for sw_device_id 0x%x\n",
+			events->event_type, events->sw_device_id);
+		list_del(&events->list);
+		kfree(events);
+	}
+	// check if any events left for this sw_device_id
+	// are still registered ( in list )
+	list_for_each_entry(events, &ev_info.list, list) {
+		if (events) {
+			if (events->sw_device_id == handle->sw_device_id) {
+				count++;
+				break;
+			}
+		}
+	}
+	if (count == 0) {
+		interface = get_interface_from_sw_device_id(handle->sw_device_id);
+		if (interface == NULL_INTERFACE)
+			return X_LINK_ERROR;
+		xlink_platform_unregister_for_events(interface, handle->sw_device_id);
+	}
+	return X_LINK_SUCCESS;
+}
+EXPORT_SYMBOL(xlink_unregister_device_event);
+
 /* Device tree driver match. */
 static const struct of_device_id kmb_xlink_of_match[] = {
 	{
diff --git a/drivers/misc/xlink-core/xlink-defs.h b/drivers/misc/xlink-core/xlink-defs.h
index 8985f6631175..df686e5185c5 100644
--- a/drivers/misc/xlink-core/xlink-defs.h
+++ b/drivers/misc/xlink-core/xlink-defs.h
@@ -102,6 +102,8 @@ enum xlink_event_type {
 	XLINK_CLOSE_CHANNEL_REQ,
 	XLINK_PING_REQ,
 	XLINK_WRITE_CONTROL_REQ,
+	XLINK_DATA_READY_CALLBACK_REQ,
+	XLINK_DATA_CONSUMED_CALLBACK_REQ,
 	XLINK_REQ_LAST,
 	// response events
 	XLINK_WRITE_RESP = 0x10,
@@ -113,6 +115,8 @@ enum xlink_event_type {
 	XLINK_CLOSE_CHANNEL_RESP,
 	XLINK_PING_RESP,
 	XLINK_WRITE_CONTROL_RESP,
+	XLINK_DATA_READY_CALLBACK_RESP,
+	XLINK_DATA_CONSUMED_CALLBACK_RESP,
 	XLINK_RESP_LAST,
 };
 
diff --git a/drivers/misc/xlink-core/xlink-dispatcher.c b/drivers/misc/xlink-core/xlink-dispatcher.c
index 11ef8e4110ca..bc2f184488ac 100644
--- a/drivers/misc/xlink-core/xlink-dispatcher.c
+++ b/drivers/misc/xlink-core/xlink-dispatcher.c
@@ -5,18 +5,18 @@
  * Copyright (C) 2018-2019 Intel Corporation
  *
  */
-#include <linux/init.h>
-#include <linux/module.h>
+#include <linux/completion.h>
 #include <linux/device.h>
+#include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/slab.h>
 #include <linux/kthread.h>
 #include <linux/list.h>
-#include <linux/semaphore.h>
+#include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/completion.h>
-#include <linux/sched/signal.h>
 #include <linux/platform_device.h>
+#include <linux/sched/signal.h>
+#include <linux/semaphore.h>
+#include <linux/slab.h>
 
 #include "xlink-dispatcher.h"
 #include "xlink-multiplexer.h"
@@ -34,18 +34,18 @@ enum dispatcher_state {
 
 /* queue for dispatcher tx thread event handling */
 struct event_queue {
+	struct list_head head;	/* head of event linked list */
 	u32 count;		/* number of events in the queue */
 	u32 capacity;		/* capacity of events in the queue */
-	struct list_head head;	/* head of event linked list */
 	struct mutex lock;	/* locks queue while accessing */
 };
 
 /* dispatcher servicing a single link to a device */
 struct dispatcher {
 	u32 link_id;			/* id of link being serviced */
+	int interface;			/* underlying interface of link */
 	enum dispatcher_state state;	/* state of the dispatcher */
 	struct xlink_handle *handle;	/* xlink device handle */
-	int interface;			/* underlying interface of link */
 	struct task_struct *rxthread;	/* kthread servicing rx */
 	struct task_struct *txthread;	/* kthread servicing tx */
 	struct event_queue queue;	/* xlink event queue */
@@ -82,7 +82,7 @@ static struct dispatcher *get_dispatcher_by_id(u32 id)
 
 static u32 event_generate_id(void)
 {
-	static u32 id = 0xa; // TODO: temporary solution
+	static u32 id = 0xa;
 
 	return id++;
 }
@@ -142,9 +142,6 @@ static int dispatcher_event_send(struct xlink_event *event)
 	size_t event_header_size = sizeof(event->header);
 	int rc;
 
-	// write event header
-	// printk(KERN_DEBUG "Sending event: type = 0x%x, id = 0x%x\n",
-			// event->header.type, event->header.id);
 	rc = xlink_platform_write(event->interface,
 				  event->handle->sw_device_id, &event->header,
 				  &event_header_size, event->header.timeout, NULL);
@@ -159,8 +156,10 @@ static int dispatcher_event_send(struct xlink_event *event)
 					  event->handle->sw_device_id, event->data,
 					  &event->header.size, event->header.timeout,
 					  NULL);
-		if (rc)
+		if (rc) {
 			pr_err("Write data failed %d\n", rc);
+			return rc;
+		}
 		if (event->user_data == 1) {
 			if (event->paddr != 0) {
 				xlink_platform_deallocate(xlinkd->dev,
@@ -187,7 +186,6 @@ static int xlink_dispatcher_rxthread(void *context)
 	size_t size;
 	int rc;
 
-	// printk(KERN_DEBUG "dispatcher rxthread started\n");
 	event = xlink_create_event(disp->link_id, 0, disp->handle, 0, 0, 0);
 	if (!event)
 		return -1;
@@ -214,7 +212,6 @@ static int xlink_dispatcher_rxthread(void *context)
 			}
 		}
 	}
-	// printk(KERN_INFO "dispatcher rxthread stopped\n");
 	complete(&disp->rx_done);
 	do_exit(0);
 	return 0;
@@ -225,7 +222,6 @@ static int xlink_dispatcher_txthread(void *context)
 	struct dispatcher *disp = (struct dispatcher *)context;
 	struct xlink_event *event;
 
-	// printk(KERN_DEBUG "dispatcher txthread started\n");
 	allow_signal(SIGTERM); // allow thread termination while waiting on sem
 	complete(&disp->tx_done);
 	while (!kthread_should_stop()) {
@@ -236,7 +232,6 @@ static int xlink_dispatcher_txthread(void *context)
 		dispatcher_event_send(event);
 		xlink_destroy_event(event); // free handled event
 	}
-	// printk(KERN_INFO "dispatcher txthread stopped\n");
 	complete(&disp->tx_done);
 	do_exit(0);
 	return 0;
@@ -250,6 +245,7 @@ static int xlink_dispatcher_txthread(void *context)
 enum xlink_error xlink_dispatcher_init(void *dev)
 {
 	struct platform_device *plat_dev = (struct platform_device *)dev;
+	struct dispatcher *dsp;
 	int i;
 
 	xlinkd = kzalloc(sizeof(*xlinkd), GFP_KERNEL);
@@ -258,16 +254,16 @@ enum xlink_error xlink_dispatcher_init(void *dev)
 
 	xlinkd->dev = &plat_dev->dev;
 	for (i = 0; i < XLINK_MAX_CONNECTIONS; i++) {
-		xlinkd->dispatchers[i].link_id = i;
-		sema_init(&xlinkd->dispatchers[i].event_sem, 0);
-		init_completion(&xlinkd->dispatchers[i].rx_done);
-		init_completion(&xlinkd->dispatchers[i].tx_done);
-		INIT_LIST_HEAD(&xlinkd->dispatchers[i].queue.head);
-		mutex_init(&xlinkd->dispatchers[i].queue.lock);
-		xlinkd->dispatchers[i].queue.count = 0;
-		xlinkd->dispatchers[i].queue.capacity =
-				XLINK_EVENT_QUEUE_CAPACITY;
-		xlinkd->dispatchers[i].state = XLINK_DISPATCHER_INIT;
+		dsp = &xlinkd->dispatchers[i];
+		dsp->link_id = i;
+		sema_init(&dsp->event_sem, 0);
+		init_completion(&dsp->rx_done);
+		init_completion(&dsp->tx_done);
+		INIT_LIST_HEAD(&dsp->queue.head);
+		mutex_init(&dsp->queue.lock);
+		dsp->queue.count = 0;
+		dsp->queue.capacity = XLINK_EVENT_QUEUE_CAPACITY;
+		dsp->state = XLINK_DISPATCHER_INIT;
 	}
 	mutex_init(&xlinkd->lock);
 
@@ -329,7 +325,7 @@ enum xlink_error xlink_dispatcher_event_add(enum xlink_event_origin origin,
 	struct dispatcher *disp;
 	int rc;
 
-	// get dispatcher by handle
+	// get dispatcher by link id
 	disp = get_dispatcher_by_id(event->link_id);
 	if (!disp)
 		return X_LINK_ERROR;
@@ -433,7 +429,6 @@ enum xlink_error xlink_dispatcher_destroy(void)
 			}
 			xlink_destroy_event(event);
 		}
-		// destroy dispatcher
 		mutex_destroy(&disp->queue.lock);
 	}
 	mutex_destroy(&xlinkd->lock);
diff --git a/drivers/misc/xlink-core/xlink-multiplexer.c b/drivers/misc/xlink-core/xlink-multiplexer.c
index 48451dc30712..e09458b62c45 100644
--- a/drivers/misc/xlink-core/xlink-multiplexer.c
+++ b/drivers/misc/xlink-core/xlink-multiplexer.c
@@ -115,6 +115,38 @@ static struct xlink_multiplexer *xmux;
  *
  */
 
+static enum xlink_error run_callback(struct open_channel *opchan,
+				     void *callback, struct task_struct *pid)
+{
+	enum xlink_error rc = X_LINK_SUCCESS;
+	struct kernel_siginfo info;
+	void (*func)(int chan);
+	int ret;
+
+	if (opchan->callback_origin == 'U') { // user-space origin
+		if (pid) {
+			memset(&info, 0, sizeof(struct kernel_siginfo));
+			info.si_signo = SIGXLNK;
+			info.si_code = SI_QUEUE;
+			info.si_errno = opchan->id;
+			info.si_ptr = (void __user *)callback;
+			ret = send_sig_info(SIGXLNK, &info, pid);
+			if (ret < 0) {
+				pr_err("Unable to send signal %d\n", ret);
+				rc = X_LINK_ERROR;
+			}
+		} else {
+			pr_err("CHAN 0x%x -- calling_pid == NULL\n",
+			       opchan->id);
+			rc = X_LINK_ERROR;
+		}
+	} else { // kernel origin
+		func = callback;
+		func(opchan->id);
+	}
+	return rc;
+}
+
 static inline int chan_is_non_blocking_read(struct open_channel *opchan)
 {
 	if (opchan->chan->mode == RXN_TXN || opchan->chan->mode == RXN_TXB)
@@ -151,7 +183,7 @@ static int is_channel_for_device(u16 chan, u32 sw_device_id,
 				 enum xlink_dev_type dev_type)
 {
 	struct xlink_channel_type const *chan_type = get_channel_type(chan);
-	int interface = NULL_INTERFACE;
+	int interface;
 
 	if (chan_type) {
 		interface = get_interface_from_sw_device_id(sw_device_id);
@@ -181,13 +213,9 @@ static int is_enough_space_in_channel(struct open_channel *opchan,
 		}
 	}
 	if (opchan->tx_up_limit == 1) {
-		if ((opchan->tx_fill_level + size)
-				< ((opchan->chan->size / 100) * THR_LWR)) {
-			opchan->tx_up_limit = 0;
-			return 1;
-		} else {
+		if ((opchan->tx_fill_level + size) >=
+		   ((opchan->chan->size / 100) * THR_LWR))
 			return 0;
-		}
 	}
 	return 1;
 }
@@ -231,6 +259,8 @@ static int add_packet_to_channel(struct open_channel *opchan,
 		list_add_tail(&pkt->list, &queue->head);
 		queue->count++;
 		opchan->rx_fill_level += pkt->length;
+	} else {
+		return X_LINK_ERROR;
 	}
 	return X_LINK_SUCCESS;
 }
@@ -262,9 +292,11 @@ static int release_packet_from_channel(struct open_channel *opchan,
 	} else {
 		// find packet in channel rx queue
 		list_for_each_entry(pkt, &queue->head, list) {
-			if (pkt->data == addr) {
-				packet_found = 1;
-				break;
+			if (pkt) {
+				if (pkt->data == addr) {
+					packet_found = 1;
+					break;
+				}
 			}
 		}
 	}
@@ -629,16 +661,46 @@ enum xlink_error xlink_multiplexer_tx(struct xlink_event *event,
 			}
 		} else if (xmux->channels[link_id][chan].status == CHAN_OPEN_PEER) {
 			/* channel already open */
-			xmux->channels[link_id][chan].status = CHAN_OPEN; // opened locally
-			xmux->channels[link_id][chan].size = event->header.size;
-			xmux->channels[link_id][chan].timeout = event->header.timeout;
-			xmux->channels[link_id][chan].mode = (uintptr_t)event->data;
 			rc = multiplexer_open_channel(link_id, chan);
+			if (rc == X_LINK_SUCCESS) {
+				struct channel *xchan = &xmux->channels[link_id][chan];
+
+				xchan->status	= CHAN_OPEN; // opened locally
+				xchan->size	= event->header.size;
+				xchan->timeout	= event->header.timeout;
+				xchan->mode	= (uintptr_t)event->data;
+			}
 		} else {
 			/* channel already open */
 			rc = X_LINK_ALREADY_OPEN;
 		}
 		break;
+	case XLINK_DATA_READY_CALLBACK_REQ:
+		opchan = get_channel(link_id, chan);
+		if (!opchan) {
+			rc = X_LINK_COMMUNICATION_FAIL;
+		} else {
+			opchan->ready_callback = event->data;
+			opchan->ready_calling_pid = event->calling_pid;
+			opchan->callback_origin = event->callback_origin;
+			pr_info("xlink ready callback process registered - %lx chan %d\n",
+				(uintptr_t)event->calling_pid, chan);
+			release_channel(opchan);
+		}
+		break;
+	case XLINK_DATA_CONSUMED_CALLBACK_REQ:
+		opchan = get_channel(link_id, chan);
+		if (!opchan) {
+			rc = X_LINK_COMMUNICATION_FAIL;
+		} else {
+			opchan->consumed_callback = event->data;
+			opchan->consumed_calling_pid = event->calling_pid;
+			opchan->callback_origin = event->callback_origin;
+			pr_info("xlink consumed callback process registered - %lx chan %d\n",
+				(uintptr_t)event->calling_pid, chan);
+			release_channel(opchan);
+		}
+		break;
 	case XLINK_CLOSE_CHANNEL_REQ:
 		if (xmux->channels[link_id][chan].status == CHAN_OPEN) {
 			opchan = get_channel(link_id, chan);
@@ -709,7 +771,8 @@ enum xlink_error xlink_multiplexer_rx(struct xlink_event *event)
 							  XLINK_PACKET_ALIGNMENT,
 							  XLINK_NORMAL_MEMORY);
 			} else {
-				pr_err("Fatal error: can't allocate memory in line:%d func:%s\n", __LINE__, __func__);
+				pr_err("Fatal error: can't allocate memory in line:%d func:%s\n",
+				       __LINE__, __func__);
 			}
 			rc = X_LINK_COMMUNICATION_FAIL;
 		} else {
@@ -754,6 +817,14 @@ enum xlink_error xlink_multiplexer_rx(struct xlink_event *event)
 				xlink_dispatcher_event_add(EVENT_RX, event);
 				//complete regardless of mode/timeout
 				complete(&opchan->pkt_available);
+				// run callback
+				if (xmux->channels[link_id][chan].status == CHAN_OPEN &&
+				    chan_is_non_blocking_read(opchan) &&
+				    opchan->ready_callback) {
+					rc = run_callback(opchan, opchan->ready_callback,
+							  opchan->ready_calling_pid);
+					break;
+				}
 			} else {
 				// failed to allocate buffer
 				rc = X_LINK_ERROR;
@@ -813,6 +884,13 @@ enum xlink_error xlink_multiplexer_rx(struct xlink_event *event)
 		xlink_dispatcher_event_add(EVENT_RX, event);
 		//complete regardless of mode/timeout
 		complete(&opchan->pkt_consumed);
+		// run callback
+		if (xmux->channels[link_id][chan].status == CHAN_OPEN &&
+		    chan_is_non_blocking_write(opchan) &&
+		    opchan->consumed_callback) {
+			rc = run_callback(opchan, opchan->consumed_callback,
+					  opchan->consumed_calling_pid);
+		}
 		release_channel(opchan);
 		break;
 	case XLINK_RELEASE_REQ:
@@ -838,47 +916,47 @@ enum xlink_error xlink_multiplexer_rx(struct xlink_event *event)
 			rc = multiplexer_open_channel(link_id, chan);
 			if (rc) {
 				rc = X_LINK_ERROR;
-			} else {
-				opchan = get_channel(link_id, chan);
-				if (!opchan) {
-					rc = X_LINK_COMMUNICATION_FAIL;
-				} else {
-					xmux->channels[link_id][chan].status = CHAN_OPEN_PEER;
-					complete(&opchan->opened);
-					passthru_event = xlink_create_event(link_id,
-									    XLINK_OPEN_CHANNEL_RESP,
-									    event->handle,
-									    chan,
-									    0,
-									    opchan->chan->timeout);
-					if (!passthru_event) {
-						rc = X_LINK_ERROR;
-						release_channel(opchan);
-						break;
-					}
-					xlink_dispatcher_event_add(EVENT_RX,
-								   passthru_event);
-				}
+				break;
+			}
+			opchan = get_channel(link_id, chan);
+			if (!opchan) {
+				rc = X_LINK_COMMUNICATION_FAIL;
+				break;
+			}
+			xmux->channels[link_id][chan].status = CHAN_OPEN_PEER;
+			complete(&opchan->opened);
+			passthru_event = xlink_create_event(link_id,
+							    XLINK_OPEN_CHANNEL_RESP,
+							    event->handle,
+							    chan,
+							    0,
+							    opchan->chan->timeout);
+			if (!passthru_event) {
+				rc = X_LINK_ERROR;
 				release_channel(opchan);
+				break;
 			}
+			xlink_dispatcher_event_add(EVENT_RX,
+						   passthru_event);
+			release_channel(opchan);
 		} else {
 			/* channel already open */
 			opchan = get_channel(link_id, chan);
 			if (!opchan) {
 				rc = X_LINK_COMMUNICATION_FAIL;
-			} else {
-				passthru_event = xlink_create_event(link_id,
-								    XLINK_OPEN_CHANNEL_RESP,
-								    event->handle,
-								    chan, 0, 0);
-				if (!passthru_event) {
-					release_channel(opchan);
-					rc = X_LINK_ERROR;
-					break;
-				}
-				xlink_dispatcher_event_add(EVENT_RX,
-							   passthru_event);
+				break;
+			}
+			passthru_event = xlink_create_event(link_id,
+							    XLINK_OPEN_CHANNEL_RESP,
+							    event->handle,
+							    chan, 0, 0);
+			if (!passthru_event) {
+				release_channel(opchan);
+				rc = X_LINK_ERROR;
+				break;
 			}
+			xlink_dispatcher_event_add(EVENT_RX,
+						   passthru_event);
 			release_channel(opchan);
 		}
 		rc = xlink_passthrough(event);
@@ -930,7 +1008,7 @@ enum xlink_error xlink_passthrough(struct xlink_event *event)
 #ifdef CONFIG_XLINK_LOCAL_HOST
 	struct xlink_ipc_context ipc = {0};
 	phys_addr_t physaddr = 0;
-	dma_addr_t vpuaddr = 0;
+	static dma_addr_t vpuaddr;
 	u32 timeout = 0;
 	u32 link_id;
 	u16 chan;
diff --git a/drivers/misc/xlink-core/xlink-platform.c b/drivers/misc/xlink-core/xlink-platform.c
index 56eb8da28a5f..b0076cb3671d 100644
--- a/drivers/misc/xlink-core/xlink-platform.c
+++ b/drivers/misc/xlink-core/xlink-platform.c
@@ -56,6 +56,11 @@ static inline int xlink_ipc_close_channel(u32 sw_device_id,
 					  u32 channel)
 { return -1; }
 
+static inline int xlink_ipc_register_for_events(u32 sw_device_id,
+						int (*callback)(u32 sw_device_id, u32 event))
+{ return -1; }
+static inline int xlink_ipc_unregister_for_events(u32 sw_device_id)
+{ return -1; }
 #endif /* CONFIG_XLINK_LOCAL_HOST */
 
 /*
@@ -95,6 +100,13 @@ static int (*open_chan_fcts[NMB_OF_INTERFACES])(u32, u32) = {
 
 static int (*close_chan_fcts[NMB_OF_INTERFACES])(u32, u32) = {
 		xlink_ipc_close_channel, NULL, NULL, NULL};
+static int (*register_for_events_fcts[NMB_OF_INTERFACES])(u32,
+						   int (*callback)(u32 sw_device_id, u32 event)) = {
+								   xlink_ipc_register_for_events,
+								   xlink_pcie_register_device_event,
+								   NULL, NULL};
+static int (*unregister_for_events_fcts[NMB_OF_INTERFACES])(u32) = {
+		xlink_ipc_unregister_for_events, xlink_pcie_unregister_device_event, NULL, NULL};
 
 /*
  * xlink low-level driver interface
@@ -207,6 +219,21 @@ int xlink_platform_close_channel(u32 interface, u32 sw_device_id,
 	return close_chan_fcts[interface](sw_device_id, channel);
 }
 
+int xlink_platform_register_for_events(u32 interface, u32 sw_device_id,
+				       xlink_device_event_cb event_notif_fn)
+{
+	if (interface >= NMB_OF_INTERFACES || !register_for_events_fcts[interface])
+		return -1;
+	return register_for_events_fcts[interface](sw_device_id, event_notif_fn);
+}
+
+int xlink_platform_unregister_for_events(u32 interface, u32 sw_device_id)
+{
+	if (interface >= NMB_OF_INTERFACES || !unregister_for_events_fcts[interface])
+		return -1;
+	return unregister_for_events_fcts[interface](sw_device_id);
+}
+
 void *xlink_platform_allocate(struct device *dev, dma_addr_t *handle,
 			      u32 size, u32 alignment,
 			      enum xlink_memory_region region)
diff --git a/include/linux/xlink.h b/include/linux/xlink.h
index b00dbc719530..ac196ff85469 100644
--- a/include/linux/xlink.h
+++ b/include/linux/xlink.h
@@ -70,6 +70,12 @@ enum xlink_error xlink_open_channel(struct xlink_handle *handle,
 				    u16 chan, enum xlink_opmode mode,
 				    u32 data_size, u32 timeout);
 
+enum xlink_error xlink_data_available_event(struct xlink_handle *handle,
+					    u16 chan,
+					    xlink_event data_available_event);
+enum xlink_error xlink_data_consumed_event(struct xlink_handle *handle,
+					   u16 chan,
+					   xlink_event data_consumed_event);
 enum xlink_error xlink_close_channel(struct xlink_handle *handle, u16 chan);
 
 enum xlink_error xlink_write_data(struct xlink_handle *handle,
@@ -113,9 +119,14 @@ enum xlink_error xlink_set_device_mode(struct xlink_handle *handle,
 enum xlink_error xlink_get_device_mode(struct xlink_handle *handle,
 				       enum xlink_device_power_mode *power_mode);
 
-enum xlink_error xlink_start_vpu(char *filename); /* depreciated */
+enum xlink_error xlink_register_device_event(struct xlink_handle *handle,
+					     u32 *event_list, u32 num_events,
+					     xlink_device_event_cb event_notif_fn);
+enum xlink_error xlink_unregister_device_event(struct xlink_handle *handle,
+					       u32 *event_list, u32 num_events);
+enum xlink_error xlink_start_vpu(char *filename); /* deprecated */
 
-enum xlink_error xlink_stop_vpu(void); /* depreciated */
+enum xlink_error xlink_stop_vpu(void); /* deprecated */
 
 /* API functions to be implemented
  *
-- 
2.17.1

