Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 186702C9231
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731185AbgK3XKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:10:13 -0500
Received: from mga03.intel.com ([134.134.136.65]:13823 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731165AbgK3XKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:10:11 -0500
IronPort-SDR: 4mFmnmIXK3ihRDvuaZrzHqIkUZbT2Cb0MIrkWP173iR+MtPxUUQdJTdtcHI/gP2txStl4/Msd5
 q/jWCZNy8VTg==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="172826360"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="172826360"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 15:07:12 -0800
IronPort-SDR: aZyJYyUcj+cOr0mD165aFVBoLiOcixv/pGj8Ps+OEj5XUrFlSklKxtY49NXG5pkUqYQZe2+2mg
 DWil62B0nOZA==
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="538781115"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 15:07:12 -0800
Received: from mtg-dev (mtg-dev.jf.intel.com [10.54.74.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.ostc.intel.com (Postfix) with ESMTPS id 8DA996363;
        Mon, 30 Nov 2020 15:07:11 -0800 (PST)
Received: from mgross by mtg-dev with local (Exim 4.90_1)
        (envelope-from <mgross@linux.intel.com>)
        id 1kjsGF-000C5l-Dn; Mon, 30 Nov 2020 15:07:11 -0800
From:   mgross@linux.intel.com
To:     linux-kernel@vger.kernel.org
Cc:     markgross@kernel.org, mgross@linux.intel.com,
        adam.r.gretzinger@intel.com, Seamus Kelly <seamus.kelly@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 22/22] xlink-core: factorize xlink_ioctl function by creating sub-functions for each ioctl command
Date:   Mon, 30 Nov 2020 15:07:07 -0800
Message-Id: <20201130230707.46351-23-mgross@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201130230707.46351-1-mgross@linux.intel.com>
References: <20201130230707.46351-1-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Seamus Kelly <seamus.kelly@intel.com>

Refactor the too large IOCTL function to call helper functions.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Mark Gross <mgross@linux.intel.com>
Signed-off-by: Seamus Kelly <seamus.kelly@intel.com>
---
 drivers/misc/xlink-core/Makefile      |   2 +-
 drivers/misc/xlink-core/xlink-core.c  | 625 ++++++--------------------
 drivers/misc/xlink-core/xlink-core.h  |  24 +
 drivers/misc/xlink-core/xlink-defs.h  |   2 +-
 drivers/misc/xlink-core/xlink-ioctl.c | 584 ++++++++++++++++++++++++
 drivers/misc/xlink-core/xlink-ioctl.h |  36 ++
 6 files changed, 773 insertions(+), 500 deletions(-)
 create mode 100644 drivers/misc/xlink-core/xlink-core.h
 create mode 100644 drivers/misc/xlink-core/xlink-ioctl.c
 create mode 100644 drivers/misc/xlink-core/xlink-ioctl.h

diff --git a/drivers/misc/xlink-core/Makefile b/drivers/misc/xlink-core/Makefile
index 6e604c0b8962..2f64703301d6 100644
--- a/drivers/misc/xlink-core/Makefile
+++ b/drivers/misc/xlink-core/Makefile
@@ -2,4 +2,4 @@
 # Makefile for KeemBay xlink Linux driver
 #
 obj-$(CONFIG_XLINK_CORE) += xlink.o
-xlink-objs += xlink-core.o xlink-multiplexer.o xlink-dispatcher.o xlink-platform.o
+xlink-objs += xlink-core.o xlink-multiplexer.o xlink-dispatcher.o xlink-platform.o xlink-ioctl.o
diff --git a/drivers/misc/xlink-core/xlink-core.c b/drivers/misc/xlink-core/xlink-core.c
index 63f65def8aa9..ed2b37085851 100644
--- a/drivers/misc/xlink-core/xlink-core.c
+++ b/drivers/misc/xlink-core/xlink-core.c
@@ -20,9 +20,11 @@
 #endif
 
 #include "xlink-defs.h"
+#include "xlink-core.h"
 #include "xlink-dispatcher.h"
 #include "xlink-multiplexer.h"
 #include "xlink-platform.h"
+#include "xlink-ioctl.h"
 
 // xlink version number
 #define XLINK_VERSION_MAJOR		0
@@ -52,25 +54,7 @@ static struct class *dev_class;
 static struct cdev xlink_cdev;
 
 static long xlink_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
-static enum xlink_error xlink_write_data_user(struct xlink_handle *handle,
-					      u16 chan, u8 const *pmessage,
-					      u32 size);
 
-static enum xlink_error xlink_write_volatile_user(struct xlink_handle *handle,
-						  u16 chan, u8 const *message,
-						  u32 size);
-static enum xlink_error do_xlink_write_volatile(struct xlink_handle *handle,
-						u16 chan, u8 const *message,
-						u32 size, u32 user_flag);
-static enum xlink_error xlink_register_device_event_user(struct xlink_handle *handle,
-							 u32 *event_list,
-							 u32 num_events,
-							 xlink_device_event_cb event_notif_fn);
-static enum xlink_error do_xlink_register_device_event(struct xlink_handle *handle,
-						       u32 *event_list,
-						       u32 num_events,
-						       xlink_device_event_cb event_notif_fn,
-						       u32 user_flag);
 static struct mutex dev_event_lock;
 
 static const struct file_operations fops = {
@@ -105,9 +89,6 @@ struct event_info {
 	xlink_device_event_cb event_notif_fn;
 };
 
-static u8 volbuf[XLINK_MAX_BUF_SIZE]; // buffer for volatile transactions
-#define NUM_REG_EVENTS 4
-
 // sysfs attribute functions
 
 static ssize_t event0_show(struct device *dev, struct device_attribute *attr, char *buf)
@@ -342,427 +323,84 @@ static int kmb_xlink_remove(struct platform_device *pdev)
  * IOCTL function for User Space access to xlink kernel functions
  *
  */
+int ioctl_connect(unsigned long arg);
 
 static long xlink_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
-	struct xlink_handle		devh	= {0};
-	struct xlinkopenchannel		op	= {0};
-	struct xlinkwritedata		wr	= {0};
-	struct xlinkreaddata		rd	= {0};
-	struct xlinkreadtobuffer	rdtobuf = {0};
-	struct xlinkconnect		con	= {0};
-	struct xlinkrelease		rel	= {0};
-	struct xlinkstartvpu		startvpu = {0};
-	struct xlinkcallback		cb	= {0};
-	struct xlinkgetdevicename	devn	= {0};
-	struct xlinkgetdevicelist	devl	= {0};
-	struct xlinkgetdevicestatus	devs	= {0};
-	struct xlinkbootdevice		boot	= {0};
-	struct xlinkresetdevice		res	= {0};
-	struct xlinkdevmode		devm	= {0};
-	struct xlinkregdevevent		regdevevent = {0};
-	u32 sw_device_id_list[XLINK_MAX_DEVICE_LIST_SIZE];
-	char name[XLINK_MAX_DEVICE_NAME_SIZE];
-	int interface = NULL_INTERFACE;
-	u32 device_status = 0;
-	u32 num_devices = 0;
-	u32 device_mode = 0;
-	u32 num_events = 0;
-	char filename[64];
-	u32 *ev_list;
-	u8 reladdr;
-	u8 *rdaddr;
-	u32 size;
 	int rc;
 
 	switch (cmd) {
 	case XL_CONNECT:
-		if (copy_from_user(&con, (void __user *)arg,
-				   sizeof(struct xlinkconnect)))
-			return -EFAULT;
-		if (copy_from_user(&devh, (void __user *)con.handle,
-				   sizeof(struct xlink_handle)))
-			return -EFAULT;
-		rc = xlink_connect(&devh);
-		if (rc == X_LINK_SUCCESS) {
-			if (copy_to_user((void __user *)con.handle,
-					 &devh, sizeof(struct xlink_handle)))
-				return -EFAULT;
-		}
-		if (copy_to_user((void __user *)con.return_code, (void *)&rc,
-				 sizeof(rc)))
-			return -EFAULT;
+		rc = ioctl_connect(arg);
 		break;
 	case XL_OPEN_CHANNEL:
-		if (copy_from_user(&op, (void __user *)arg,
-				   sizeof(struct xlinkopenchannel)))
-			return -EFAULT;
-		if (copy_from_user(&devh, (void __user *)op.handle,
-				   sizeof(struct xlink_handle)))
-			return -EFAULT;
-		rc = xlink_open_channel(&devh, op.chan, op.mode, op.data_size,
-					op.timeout);
-		if (copy_to_user((void __user *)op.return_code, (void *)&rc, sizeof(rc)))
-			return -EFAULT;
+		rc = ioctl_open_channel(arg);
 		break;
 	case XL_DATA_READY_CALLBACK:
-		if (copy_from_user(&cb, (void __user *)arg,
-				   sizeof(struct xlinkcallback)))
-			return -EFAULT;
-		if (copy_from_user(&devh, (void __user *)cb.handle,
-				   sizeof(struct xlink_handle)))
-			return -EFAULT;
-		CHANNEL_SET_USER_BIT(cb.chan); // set MSbit for user space call
-		rc = xlink_data_available_event(&devh, cb.chan, cb.callback);
-		if (copy_to_user((void __user *)cb.return_code, (void *)&rc, sizeof(rc)))
-			return -EFAULT;
+		rc = ioctl_data_ready_callback(arg);
 		break;
 	case XL_DATA_CONSUMED_CALLBACK:
-		if (copy_from_user(&cb, (void __user *)arg,
-				   sizeof(struct xlinkcallback)))
-			return -EFAULT;
-		if (copy_from_user(&devh, (void __user *)cb.handle,
-				   sizeof(struct xlink_handle)))
-			return -EFAULT;
-		CHANNEL_SET_USER_BIT(cb.chan); // set MSbit for user space call
-		rc = xlink_data_consumed_event(&devh, cb.chan, cb.callback);
-		if (copy_to_user((void __user *)cb.return_code, (void *)&rc, sizeof(rc)))
-			return -EFAULT;
+		rc = ioctl_data_consumed_callback(arg);
 		break;
 	case XL_READ_DATA:
-		if (copy_from_user(&rd, (void __user *)arg,
-				   sizeof(struct xlinkreaddata)))
-			return -EFAULT;
-		if (copy_from_user(&devh, (void __user *)rd.handle,
-				   sizeof(struct xlink_handle)))
-			return -EFAULT;
-		rc = xlink_read_data(&devh, rd.chan, &rdaddr, &size);
-		if (!rc) {
-			interface = get_interface_from_sw_device_id(devh.sw_device_id);
-			if (interface == IPC_INTERFACE) {
-				if (copy_to_user((void __user *)rd.pmessage, (void *)&rdaddr,
-						 sizeof(u32)))
-					return -EFAULT;
-			} else {
-				if (copy_to_user((void __user *)rd.pmessage, (void *)rdaddr,
-						 size))
-					return -EFAULT;
-			}
-			if (copy_to_user((void __user *)rd.size, (void *)&size, sizeof(size)))
-				return -EFAULT;
-		}
-		if (copy_to_user((void __user *)rd.return_code, (void *)&rc, sizeof(rc)))
-			return -EFAULT;
+		rc = ioctl_read_data(arg);
 		break;
 	case XL_READ_TO_BUFFER:
-		if (copy_from_user(&rdtobuf, (void __user *)arg,
-				   sizeof(struct xlinkreadtobuffer)))
-			return -EFAULT;
-		if (copy_from_user(&devh, (void __user *)rdtobuf.handle,
-				   sizeof(struct xlink_handle)))
-			return -EFAULT;
-		rc = xlink_read_data_to_buffer(&devh, rdtobuf.chan,
-					       (u8 *)volbuf, &size);
-		if (!rc) {
-			if (copy_to_user((void __user *)rdtobuf.pmessage, (void *)volbuf,
-					 size))
-				return -EFAULT;
-			if (copy_to_user((void __user *)rdtobuf.size, (void *)&size,
-					 sizeof(size)))
-				return -EFAULT;
-		}
-		if (copy_to_user((void __user *)rdtobuf.return_code, (void *)&rc, sizeof(rc)))
-			return -EFAULT;
+		rc = ioctl_read_to_buffer(arg);
 		break;
 	case XL_WRITE_DATA:
-		if (copy_from_user(&wr, (void __user *)arg,
-				   sizeof(struct xlinkwritedata)))
-			return -EFAULT;
-		if (copy_from_user(&devh, (void __user *)wr.handle,
-				   sizeof(struct xlink_handle)))
-			return -EFAULT;
-		if (wr.size <= XLINK_MAX_DATA_SIZE) {
-			rc = xlink_write_data_user(&devh, wr.chan, wr.pmessage,
-						   wr.size);
-			if (copy_to_user((void __user *)wr.return_code, (void *)&rc,
-					 sizeof(rc)))
-				return -EFAULT;
-		} else {
-			return -EFAULT;
-		}
+		rc = ioctl_write_data(arg);
 		break;
 	case XL_WRITE_VOLATILE:
-		if (copy_from_user(&wr, (void __user *)arg,
-				   sizeof(struct xlinkwritedata)))
-			return -EFAULT;
-		if (copy_from_user(&devh, (void __user *)wr.handle,
-				   sizeof(struct xlink_handle)))
-			return -EFAULT;
-		if (wr.size <= XLINK_MAX_BUF_SIZE) {
-			if (copy_from_user(volbuf, (void __user *)wr.pmessage,
-					   wr.size))
-				return -EFAULT;
-			rc = xlink_write_volatile_user(&devh, wr.chan, volbuf,
-						       wr.size);
-			if (copy_to_user((void __user *)wr.return_code, (void *)&rc,
-					 sizeof(rc)))
-				return -EFAULT;
-		} else {
-			return -EFAULT;
-		}
+		rc = ioctl_write_volatile_data(arg);
 		break;
 	case XL_WRITE_CONTROL_DATA:
-		if (copy_from_user(&wr, (void __user *)arg,
-				   sizeof(struct xlinkwritedata)))
-			return -EFAULT;
-		if (copy_from_user(&devh, (void __user *)wr.handle,
-				   sizeof(struct xlink_handle)))
-			return -EFAULT;
-		if (wr.size <= XLINK_MAX_CONTROL_DATA_SIZE) {
-			if (copy_from_user(volbuf, (void __user *)wr.pmessage,
-					   wr.size))
-				return -EFAULT;
-			rc = xlink_write_control_data(&devh, wr.chan, volbuf,
-						      wr.size);
-			if (copy_to_user((void __user *)wr.return_code,
-					 (void *)&rc, sizeof(rc)))
-				return -EFAULT;
-		} else {
-			return -EFAULT;
-		}
+		rc = ioctl_write_control_data(arg);
 		break;
 	case XL_RELEASE_DATA:
-		if (copy_from_user(&rel, (void __user *)arg,
-				   sizeof(struct xlinkrelease)))
-			return -EFAULT;
-		if (copy_from_user(&devh, (void __user *)rel.handle,
-				   sizeof(struct xlink_handle)))
-			return -EFAULT;
-		if (rel.addr) {
-			if (get_user(reladdr, (u32 __user *const)rel.addr))
-				return -EFAULT;
-			rc = xlink_release_data(&devh, rel.chan,
-						(u8 *)&reladdr);
-		} else {
-			rc = xlink_release_data(&devh, rel.chan, NULL);
-		}
-		if (copy_to_user((void __user *)rel.return_code, (void *)&rc, sizeof(rc)))
-			return -EFAULT;
+		rc = ioctl_release_data(arg);
 		break;
 	case XL_CLOSE_CHANNEL:
-		if (copy_from_user(&op, (void __user *)arg,
-				   sizeof(struct xlinkopenchannel)))
-			return -EFAULT;
-		if (copy_from_user(&devh, (void __user *)op.handle,
-				   sizeof(struct xlink_handle)))
-			return -EFAULT;
-		rc = xlink_close_channel(&devh, op.chan);
-		if (copy_to_user((void __user *)op.return_code, (void *)&rc, sizeof(rc)))
-			return -EFAULT;
+		rc = ioctl_close_channel(arg);
 		break;
 	case XL_START_VPU:
-		if (copy_from_user(&startvpu, (void __user *)arg,
-				   sizeof(struct xlinkstartvpu)))
-			return -EFAULT;
-		if (startvpu.namesize > sizeof(filename))
-			return -EINVAL;
-		memset(filename, 0, sizeof(filename));
-		if (copy_from_user(filename, (void __user *)startvpu.filename,
-				   startvpu.namesize))
-			return -EFAULT;
-		rc = xlink_start_vpu(filename);
-		if (copy_to_user((void __user *)startvpu.return_code, (void *)&rc, sizeof(rc)))
-			return -EFAULT;
+		rc = ioctl_start_vpu(arg);
 		break;
 	case XL_STOP_VPU:
-		rc = xlink_stop_vpu();
+		rc = ioctl_stop_vpu();
 		break;
 	case XL_RESET_VPU:
-		rc = xlink_stop_vpu();
+		rc = ioctl_stop_vpu();
 		break;
 	case XL_DISCONNECT:
-		if (copy_from_user(&con, (void __user *)arg,
-				   sizeof(struct xlinkconnect)))
-			return -EFAULT;
-		if (copy_from_user(&devh, (void __user *)con.handle,
-				   sizeof(struct xlink_handle)))
-			return -EFAULT;
-		rc = xlink_disconnect(&devh);
-		if (copy_to_user((void __user *)con.return_code, (void *)&rc, sizeof(rc)))
-			return -EFAULT;
+		rc = ioctl_disconnect(arg);
 		break;
 	case XL_GET_DEVICE_NAME:
-		if (copy_from_user(&devn, (void __user *)arg,
-				   sizeof(struct xlinkgetdevicename)))
-			return -EFAULT;
-		if (copy_from_user(&devh, (void __user *)devn.handle,
-				   sizeof(struct xlink_handle)))
-			return -EFAULT;
-		if (devn.name_size <= XLINK_MAX_DEVICE_NAME_SIZE) {
-			rc = xlink_get_device_name(&devh, name, devn.name_size);
-			if (!rc) {
-				if (copy_to_user((void __user *)devn.name, (void *)name,
-						 devn.name_size))
-					return -EFAULT;
-			}
-		} else {
-			rc = X_LINK_ERROR;
-		}
-		if (copy_to_user((void __user *)devn.return_code, (void *)&rc, sizeof(rc)))
-			return -EFAULT;
+		rc = ioctl_get_device_name(arg);
 		break;
 	case XL_GET_DEVICE_LIST:
-		if (copy_from_user(&devl, (void __user *)arg,
-				   sizeof(struct xlinkgetdevicelist)))
-			return -EFAULT;
-		rc = xlink_get_device_list(sw_device_id_list, &num_devices);
-		if (!rc && num_devices <= XLINK_MAX_DEVICE_LIST_SIZE) {
-			/* TODO: this next copy is dangerous! we have no idea
-			 * how large the devl.sw_device_id_list buffer is
-			 * provided by the user. if num_devices is too large,
-			 * the copy will overflow the buffer.
-			 */
-			if (copy_to_user((void __user *)devl.sw_device_id_list,
-					 (void *)sw_device_id_list,
-					 (sizeof(*sw_device_id_list)
-					 * num_devices)))
-				return -EFAULT;
-			if (copy_to_user((void __user *)devl.num_devices, (void *)&num_devices,
-					 (sizeof(num_devices))))
-				return -EFAULT;
-		}
-		if (copy_to_user((void __user *)devl.return_code, (void *)&rc, sizeof(rc)))
-			return -EFAULT;
+		rc = ioctl_get_device_list(arg);
 		break;
 	case XL_GET_DEVICE_STATUS:
-		if (copy_from_user(&devs, (void __user *)arg,
-				   sizeof(struct xlinkgetdevicestatus)))
-			return -EFAULT;
-		if (copy_from_user(&devh, (void __user *)devs.handle,
-				   sizeof(struct xlink_handle)))
-			return -EFAULT;
-		rc = xlink_get_device_status(&devh, &device_status);
-		if (!rc) {
-			if (copy_to_user((void __user *)devs.device_status,
-					 (void *)&device_status,
-					 sizeof(device_status)))
-				return -EFAULT;
-		}
-		if (copy_to_user((void __user *)devs.return_code, (void *)&rc, sizeof(rc)))
-			return -EFAULT;
+		rc = ioctl_get_device_status(arg);
 		break;
 	case XL_BOOT_DEVICE:
-		if (copy_from_user(&boot, (void __user *)arg,
-				   sizeof(struct xlinkbootdevice)))
-			return -EFAULT;
-		if (copy_from_user(&devh, (void __user *)boot.handle,
-				   sizeof(struct xlink_handle)))
-			return -EFAULT;
-		if (boot.binary_name_size > sizeof(filename))
-			return -EINVAL;
-		memset(filename, 0, sizeof(filename));
-		if (copy_from_user(filename, (void __user *)boot.binary_name,
-				   boot.binary_name_size))
-			return -EFAULT;
-		rc = xlink_boot_device(&devh, filename);
-		if (copy_to_user((void __user *)boot.return_code, (void *)&rc, sizeof(rc)))
-			return -EFAULT;
+		rc = ioctl_boot_device(arg);
 		break;
 	case XL_RESET_DEVICE:
-		if (copy_from_user(&res, (void __user *)arg,
-				   sizeof(struct xlinkresetdevice)))
-			return -EFAULT;
-		if (copy_from_user(&devh, (void __user *)res.handle,
-				   sizeof(struct xlink_handle)))
-			return -EFAULT;
-		rc = xlink_reset_device(&devh);
-		if (copy_to_user((void __user *)res.return_code, (void *)&rc, sizeof(rc)))
-			return -EFAULT;
+		rc = ioctl_reset_device(arg);
 		break;
 	case XL_GET_DEVICE_MODE:
-		if (copy_from_user(&devm, (void __user *)arg,
-				   sizeof(struct xlinkdevmode)))
-			return -EFAULT;
-		if (copy_from_user(&devh, (void __user *)devm.handle,
-				   sizeof(struct xlink_handle)))
-			return -EFAULT;
-		rc = xlink_get_device_mode(&devh, &device_mode);
-		if (!rc) {
-			if (copy_to_user((void __user *)devm.device_mode, (void *)&device_mode,
-					 sizeof(device_mode)))
-				return -EFAULT;
-		}
-		if (copy_to_user((void __user *)devm.return_code, (void *)&rc, sizeof(rc)))
-			return -EFAULT;
+		rc = ioctl_get_device_mode(arg);
 		break;
 	case XL_SET_DEVICE_MODE:
-		if (copy_from_user(&devm, (void __user *)arg,
-				   sizeof(struct xlinkdevmode)))
-			return -EFAULT;
-		if (copy_from_user(&devh, (void __user *)devm.handle,
-				   sizeof(struct xlink_handle)))
-			return -EFAULT;
-		if (copy_from_user(&device_mode, (void __user *)devm.device_mode,
-				   sizeof(device_mode)))
-			return -EFAULT;
-		rc = xlink_set_device_mode(&devh, device_mode);
-		if (copy_to_user((void __user *)devm.return_code, (void *)&rc, sizeof(rc)))
-			return -EFAULT;
+		rc = ioctl_set_device_mode(arg);
 		break;
 	case XL_REGISTER_DEV_EVENT:
-		if (copy_from_user(&regdevevent, (void __user *)arg,
-				   sizeof(struct xlinkregdevevent)))
-			return -EFAULT;
-		if (copy_from_user(&devh, (void __user *)regdevevent.handle,
-				   sizeof(struct xlink_handle)))
-			return -EFAULT;
-		num_events = regdevevent.num_events;
-		if (num_events > 0 && num_events <= NUM_REG_EVENTS) {
-			ev_list = kzalloc((num_events * sizeof(u32)), GFP_KERNEL);
-			if (ev_list) {
-				if (copy_from_user(ev_list,
-						   (void __user *)regdevevent.event_list,
-						   (num_events * sizeof(u32)))) {
-					kfree(ev_list);
-					return -EFAULT;
-				}
-				rc = xlink_register_device_event_user(&devh,
-								      ev_list,
-								      num_events,
-								      NULL);
-				kfree(ev_list);
-			} else {
-				rc = X_LINK_ERROR;
-			}
-		} else {
-			rc = X_LINK_ERROR;
-		}
-		if (copy_to_user((void __user *)regdevevent.return_code, (void *)&rc, sizeof(rc)))
-			return -EFAULT;
+		rc = ioctl_register_device_event(arg);
 		break;
 	case XL_UNREGISTER_DEV_EVENT:
-		if (copy_from_user(&regdevevent, (void __user *)arg,
-				   sizeof(struct xlinkregdevevent)))
-			return -EFAULT;
-		if (copy_from_user(&devh, (void __user *)regdevevent.handle,
-				   sizeof(struct xlink_handle)))
-			return -EFAULT;
-		num_events = regdevevent.num_events;
-		if (num_events <= NUM_REG_EVENTS) {
-			ev_list = kzalloc((num_events * sizeof(u32)), GFP_KERNEL);
-			if (copy_from_user(ev_list,
-					   (void __user *)regdevevent.event_list,
-					   (num_events * sizeof(u32)))) {
-				kfree(ev_list);
-				return -EFAULT;
-			}
-			rc = xlink_unregister_device_event(&devh, ev_list, num_events);
-			kfree(ev_list);
-		} else {
-			rc = X_LINK_ERROR;
-		}
-		if (copy_to_user((void __user *)regdevevent.return_code, (void *)&rc, sizeof(rc)))
-			return -EFAULT;
+		rc = ioctl_unregister_device_event(arg);
 		break;
 	}
 	if (rc)
@@ -997,13 +635,16 @@ enum xlink_error xlink_close_channel(struct xlink_handle *handle,
 }
 EXPORT_SYMBOL(xlink_close_channel);
 
-enum xlink_error xlink_write_data(struct xlink_handle *handle,
-				  u16 chan, u8 const *pmessage, u32 size)
+static enum xlink_error do_xlink_write_data(struct xlink_handle *handle,
+					    u16 chan, u8 const *pmessage,
+					    u32 size, u32 user_flag)
 {
 	struct xlink_event *event;
 	struct xlink_link *link;
 	enum xlink_error rc;
 	int event_queued = 0;
+	dma_addr_t paddr = 0;
+	u32 addr;
 
 	if (!xlink || !handle)
 		return X_LINK_ERROR;
@@ -1019,88 +660,75 @@ enum xlink_error xlink_write_data(struct xlink_handle *handle,
 				   chan, size, 0);
 	if (!event)
 		return X_LINK_ERROR;
+	event->user_data = user_flag;
 
 	if (chan < XLINK_IPC_MAX_CHANNELS &&
 	    event->interface == IPC_INTERFACE) {
 		/* only passing message address across IPC interface */
-		event->data = &pmessage;
+		if (user_flag) {
+			if (get_user(addr, (u32 __user *)pmessage)) {
+				xlink_destroy_event(event);
+				return X_LINK_ERROR;
+			}
+			event->data = &addr;
+		} else {
+			event->data = &pmessage;
+		}
 		rc = xlink_multiplexer_tx(event, &event_queued);
 		xlink_destroy_event(event);
 	} else {
-		event->data = (u8 *)pmessage;
-		event->paddr = 0;
+		if (user_flag) {
+			event->data = xlink_platform_allocate(&xlink->pdev->dev, &paddr,
+							      size,
+							      XLINK_PACKET_ALIGNMENT,
+							      XLINK_NORMAL_MEMORY);
+			if (!event->data) {
+				xlink_destroy_event(event);
+				return X_LINK_ERROR;
+			}
+			if (copy_from_user(event->data, (void __user *)pmessage, size)) {
+				xlink_platform_deallocate(&xlink->pdev->dev,
+							  event->data, paddr, size,
+							  XLINK_PACKET_ALIGNMENT,
+							  XLINK_NORMAL_MEMORY);
+				xlink_destroy_event(event);
+				return X_LINK_ERROR;
+			}
+			event->paddr = paddr;
+		} else {
+			event->data = (u8 *)pmessage;
+			event->paddr = 0;
+		}
 		rc = xlink_multiplexer_tx(event, &event_queued);
-		if (!event_queued)
+		if (!event_queued) {
+			if (user_flag) {
+				xlink_platform_deallocate(&xlink->pdev->dev,
+							  event->data, paddr, size,
+							  XLINK_PACKET_ALIGNMENT,
+							  XLINK_NORMAL_MEMORY);
+			}
 			xlink_destroy_event(event);
+		}
 	}
 	return rc;
 }
-EXPORT_SYMBOL(xlink_write_data);
 
-static enum xlink_error xlink_write_data_user(struct xlink_handle *handle,
-					      u16 chan, u8 const *pmessage,
-					      u32 size)
+enum xlink_error xlink_write_data(struct xlink_handle *handle,
+				  u16 chan, u8 const *pmessage, u32 size)
 {
-	struct xlink_event *event;
-	struct xlink_link *link;
-	enum xlink_error rc;
-	int event_queued = 0;
-	dma_addr_t paddr = 0;
-	u32 addr;
-
-	if (!xlink || !handle)
-		return X_LINK_ERROR;
-
-	if (size > XLINK_MAX_DATA_SIZE)
-		return X_LINK_ERROR;
+	enum xlink_error rc = 0;
 
-	link = get_link_by_sw_device_id(handle->sw_device_id);
-	if (!link)
-		return X_LINK_ERROR;
+	rc = do_xlink_write_data(handle, chan, pmessage, size, 0);
+	return rc;
+}
+EXPORT_SYMBOL(xlink_write_data);
 
-	event = xlink_create_event(link->id, XLINK_WRITE_REQ, &link->handle,
-				   chan, size, 0);
-	if (!event)
-		return X_LINK_ERROR;
-	event->user_data = 1;
+enum xlink_error xlink_write_data_user(struct xlink_handle *handle,
+				       u16 chan, u8 const *pmessage, u32 size)
+{
+	enum xlink_error rc = 0;
 
-	if (chan < XLINK_IPC_MAX_CHANNELS &&
-	    event->interface == IPC_INTERFACE) {
-		/* only passing message address across IPC interface */
-		if (get_user(addr, (u32 __user *)pmessage)) {
-			xlink_destroy_event(event);
-			return X_LINK_ERROR;
-		}
-		event->data = &addr;
-		rc = xlink_multiplexer_tx(event, &event_queued);
-		xlink_destroy_event(event);
-	} else {
-		event->data = xlink_platform_allocate(&xlink->pdev->dev, &paddr,
-						      size,
-						      XLINK_PACKET_ALIGNMENT,
-						      XLINK_NORMAL_MEMORY);
-		if (!event->data) {
-			xlink_destroy_event(event);
-			return X_LINK_ERROR;
-		}
-		if (copy_from_user(event->data, (void __user *)pmessage, size)) {
-			xlink_platform_deallocate(&xlink->pdev->dev,
-						  event->data, paddr, size,
-						  XLINK_PACKET_ALIGNMENT,
-						  XLINK_NORMAL_MEMORY);
-			xlink_destroy_event(event);
-			return X_LINK_ERROR;
-		}
-		event->paddr = paddr;
-		rc = xlink_multiplexer_tx(event, &event_queued);
-		if (!event_queued) {
-			xlink_platform_deallocate(&xlink->pdev->dev,
-						  event->data, paddr, size,
-						  XLINK_PACKET_ALIGNMENT,
-						  XLINK_NORMAL_MEMORY);
-			xlink_destroy_event(event);
-		}
-	}
+	rc = do_xlink_write_data(handle, chan, pmessage, size, 1);
 	return rc;
 }
 
@@ -1131,25 +759,6 @@ enum xlink_error xlink_write_control_data(struct xlink_handle *handle,
 	return rc;
 }
 EXPORT_SYMBOL(xlink_write_control_data);
-static enum xlink_error xlink_write_volatile_user(struct xlink_handle *handle,
-						  u16 chan, u8 const *message,
-						  u32 size)
-{
-	enum xlink_error rc = 0;
-
-	rc = do_xlink_write_volatile(handle, chan, message, size, 1);
-	return rc;
-}
-
-enum xlink_error xlink_write_volatile(struct xlink_handle *handle,
-				      u16 chan, u8 const *message, u32 size)
-{
-	enum xlink_error rc = 0;
-
-	rc = do_xlink_write_volatile(handle, chan, message, size, 0);
-	return rc;
-}
-EXPORT_SYMBOL(xlink_write_volatile);
 
 static enum xlink_error do_xlink_write_volatile(struct xlink_handle *handle,
 						u16 chan, u8 const *message,
@@ -1196,6 +805,26 @@ static enum xlink_error do_xlink_write_volatile(struct xlink_handle *handle,
 	return rc;
 }
 
+enum xlink_error xlink_write_volatile_user(struct xlink_handle *handle,
+					   u16 chan, u8 const *message,
+					   u32 size)
+{
+	enum xlink_error rc = 0;
+
+	rc = do_xlink_write_volatile(handle, chan, message, size, 1);
+	return rc;
+}
+
+enum xlink_error xlink_write_volatile(struct xlink_handle *handle,
+				      u16 chan, u8 const *message, u32 size)
+{
+	enum xlink_error rc = 0;
+
+	rc = do_xlink_write_volatile(handle, chan, message, size, 0);
+	return rc;
+}
+EXPORT_SYMBOL(xlink_write_volatile);
+
 enum xlink_error xlink_read_data(struct xlink_handle *handle,
 				 u16 chan, u8 **pmessage, u32 *size)
 {
@@ -1531,29 +1160,6 @@ static bool event_registered(u32 sw_dev_id, u32 event)
 return false;
 }
 
-static enum xlink_error xlink_register_device_event_user(struct xlink_handle *handle,
-							 u32 *event_list, u32 num_events,
-							 xlink_device_event_cb event_notif_fn)
-{
-	enum xlink_error rc;
-
-	rc = do_xlink_register_device_event(handle, event_list, num_events,
-					    event_notif_fn, 1);
-	return rc;
-}
-
-enum xlink_error xlink_register_device_event(struct xlink_handle *handle,
-					     u32 *event_list, u32 num_events,
-					     xlink_device_event_cb event_notif_fn)
-{
-	enum xlink_error rc;
-
-	rc = do_xlink_register_device_event(handle, event_list, num_events,
-					    event_notif_fn, 0);
-	return rc;
-}
-EXPORT_SYMBOL(xlink_register_device_event);
-
 static enum xlink_error do_xlink_register_device_event(struct xlink_handle *handle,
 						       u32 *event_list,
 						       u32 num_events,
@@ -1599,6 +1205,29 @@ static enum xlink_error do_xlink_register_device_event(struct xlink_handle *hand
 	return X_LINK_SUCCESS;
 }
 
+enum xlink_error xlink_register_device_event_user(struct xlink_handle *handle,
+						  u32 *event_list, u32 num_events,
+						  xlink_device_event_cb event_notif_fn)
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
 enum xlink_error xlink_unregister_device_event(struct xlink_handle *handle,
 					       u32 *event_list,
 					       u32 num_events)
diff --git a/drivers/misc/xlink-core/xlink-core.h b/drivers/misc/xlink-core/xlink-core.h
new file mode 100644
index 000000000000..c3d100a75c44
--- /dev/null
+++ b/drivers/misc/xlink-core/xlink-core.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * xlink core header file.
+ *
+ * Copyright (C) 2018-2019 Intel Corporation
+ *
+ */
+
+#ifndef XLINK_CORE_H_
+#define XLINK_CORE_H_
+#include "xlink-defs.h"
+
+#define NUM_REG_EVENTS 4
+
+enum xlink_error xlink_write_data_user(struct xlink_handle *handle,
+				       u16 chan, u8 const *pmessage,
+				       u32 size);
+enum xlink_error xlink_register_device_event_user(struct xlink_handle *handle,
+						  u32 *event_list, u32 num_events,
+						  xlink_device_event_cb event_notif_fn);
+enum xlink_error xlink_write_volatile_user(struct xlink_handle *handle,
+					   u16 chan, u8 const *message,
+					   u32 size);
+#endif /* XLINK_CORE_H_ */
diff --git a/drivers/misc/xlink-core/xlink-defs.h b/drivers/misc/xlink-core/xlink-defs.h
index df686e5185c5..81aa3bfffcd3 100644
--- a/drivers/misc/xlink-core/xlink-defs.h
+++ b/drivers/misc/xlink-core/xlink-defs.h
@@ -35,7 +35,7 @@
 #define CONTROL_CHANNEL_TIMEOUT_MS	0U	// wait indefinitely
 #define SIGXLNK				44	// signal XLink uses for callback signalling
 
-#define UNUSED(x) (void)(x)
+#define UNUSED(x) ((void)(x))
 
 // the end of the IPC channel range (starting at zero)
 #define XLINK_IPC_MAX_CHANNELS	1024
diff --git a/drivers/misc/xlink-core/xlink-ioctl.c b/drivers/misc/xlink-core/xlink-ioctl.c
new file mode 100644
index 000000000000..9c1a8c896945
--- /dev/null
+++ b/drivers/misc/xlink-core/xlink-ioctl.c
@@ -0,0 +1,584 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * xlink Core Driver.
+ *
+ * Copyright (C) 2018-2019 Intel Corporation
+ *
+ */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/cdev.h>
+#include <linux/platform_device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/uaccess.h>
+#include <linux/slab.h>
+#include <linux/kref.h>
+
+#include "xlink-defs.h"
+#include "xlink-core.h"
+#include "xlink-ioctl.h"
+
+#define CHANNEL_SET_USER_BIT(chan) ((chan) |= (1 << 15))
+
+int ioctl_connect(unsigned long arg)
+{
+	struct xlink_handle		devh	= {0};
+	struct xlinkconnect		con	= {0};
+	int rc = 0;
+
+	if (copy_from_user(&con, (void __user *)arg,
+			   sizeof(struct xlinkconnect)))
+		return -EFAULT;
+	if (copy_from_user(&devh, (void __user *)con.handle,
+			   sizeof(struct xlink_handle)))
+		return -EFAULT;
+	rc = xlink_connect(&devh);
+	if (rc == X_LINK_SUCCESS) {
+		if (copy_to_user((void __user *)con.handle,
+				 &devh, sizeof(struct xlink_handle)))
+			return -EFAULT;
+	}
+	if (copy_to_user((void __user *)con.return_code, (void *)&rc,
+			 sizeof(rc)))
+		return -EFAULT;
+	return rc;
+}
+
+int ioctl_open_channel(unsigned long arg)
+{
+	struct xlink_handle	devh	= {0};
+	struct xlinkopenchannel	op	= {0};
+	int rc = 0;
+
+	if (copy_from_user(&op, (void __user *)arg,
+			   sizeof(struct xlinkopenchannel)))
+		return -EFAULT;
+	if (copy_from_user(&devh, (void __user *)op.handle,
+			   sizeof(struct xlink_handle)))
+		return -EFAULT;
+	rc = xlink_open_channel(&devh, op.chan, op.mode, op.data_size,
+				op.timeout);
+	if (copy_to_user((void __user *)op.return_code, (void *)&rc, sizeof(rc)))
+		return -EFAULT;
+	return rc;
+}
+
+int ioctl_read_data(unsigned long arg)
+{
+	struct xlink_handle	devh	= {0};
+	struct xlinkreaddata	rd	= {0};
+	int rc = 0;
+	u8 *rdaddr;
+	u32 size;
+	int interface;
+
+	if (copy_from_user(&rd, (void __user *)arg,
+			   sizeof(struct xlinkreaddata)))
+		return -EFAULT;
+	if (copy_from_user(&devh, (void __user *)rd.handle,
+			   sizeof(struct xlink_handle)))
+		return -EFAULT;
+	rc = xlink_read_data(&devh, rd.chan, &rdaddr, &size);
+	if (!rc) {
+		interface = get_interface_from_sw_device_id(devh.sw_device_id);
+		if (interface == IPC_INTERFACE) {
+			if (copy_to_user((void __user *)rd.pmessage, (void *)&rdaddr,
+					 sizeof(u32)))
+				return -EFAULT;
+		} else {
+			if (copy_to_user((void __user *)rd.pmessage, (void *)rdaddr,
+					 size))
+				return -EFAULT;
+		}
+		if (copy_to_user((void __user *)rd.size, (void *)&size, sizeof(size)))
+			return -EFAULT;
+	}
+	if (copy_to_user((void __user *)rd.return_code, (void *)&rc, sizeof(rc)))
+		return -EFAULT;
+	return rc;
+}
+
+int ioctl_read_to_buffer(unsigned long arg)
+{
+	struct xlink_handle		devh	= {0};
+	struct xlinkreadtobuffer	rdtobuf = {0};
+	int rc = 0;
+	u32 size;
+	u8 volbuf[XLINK_MAX_BUF_SIZE]; // buffer for volatile transactions
+
+	if (copy_from_user(&rdtobuf, (void __user *)arg,
+			   sizeof(struct xlinkreadtobuffer)))
+		return -EFAULT;
+	if (copy_from_user(&devh, (void __user *)rdtobuf.handle,
+			   sizeof(struct xlink_handle)))
+		return -EFAULT;
+	rc = xlink_read_data_to_buffer(&devh, rdtobuf.chan,
+				       (u8 *)volbuf, &size);
+	if (!rc) {
+		if (copy_to_user((void __user *)rdtobuf.pmessage, (void *)volbuf,
+				 size))
+			return -EFAULT;
+		if (copy_to_user((void __user *)rdtobuf.size, (void *)&size,
+				 sizeof(size)))
+			return -EFAULT;
+	}
+	if (copy_to_user((void __user *)rdtobuf.return_code, (void *)&rc, sizeof(rc)))
+		return -EFAULT;
+	return rc;
+}
+
+int ioctl_write_data(unsigned long arg)
+{
+	struct xlink_handle	devh	= {0};
+	struct xlinkwritedata		wr	= {0};
+	int rc = 0;
+
+	if (copy_from_user(&wr, (void __user *)arg,
+			   sizeof(struct xlinkwritedata)))
+		return -EFAULT;
+	if (copy_from_user(&devh, (void __user *)wr.handle,
+			   sizeof(struct xlink_handle)))
+		return -EFAULT;
+	if (wr.size <= XLINK_MAX_DATA_SIZE) {
+		rc = xlink_write_data_user(&devh, wr.chan, wr.pmessage,
+					   wr.size);
+		if (copy_to_user((void __user *)wr.return_code, (void *)&rc,
+				 sizeof(rc)))
+			return -EFAULT;
+	} else {
+		return -EFAULT;
+	}
+	return rc;
+}
+
+int ioctl_write_control_data(unsigned long arg)
+{
+	struct xlink_handle	devh	= {0};
+	struct xlinkwritedata		wr	= {0};
+	u8 volbuf[XLINK_MAX_BUF_SIZE];
+	int rc = 0;
+
+	if (copy_from_user(&wr, (void __user *)arg,
+			   sizeof(struct xlinkwritedata)))
+		return -EFAULT;
+	if (copy_from_user(&devh, (void __user *)wr.handle,
+			   sizeof(struct xlink_handle)))
+		return -EFAULT;
+	if (wr.size <= XLINK_MAX_CONTROL_DATA_SIZE) {
+		if (copy_from_user(volbuf, (void __user *)wr.pmessage,
+				   wr.size))
+			return -EFAULT;
+		rc = xlink_write_control_data(&devh, wr.chan, volbuf,
+					      wr.size);
+		if (copy_to_user((void __user *)wr.return_code,
+				 (void *)&rc, sizeof(rc)))
+			return -EFAULT;
+	} else {
+		return -EFAULT;
+	}
+	return rc;
+}
+
+int ioctl_write_volatile_data(unsigned long arg)
+{
+	struct xlink_handle	devh	= {0};
+	struct xlinkwritedata	wr	= {0};
+	int rc = 0;
+	u8 volbuf[XLINK_MAX_BUF_SIZE]; // buffer for volatile transactions
+
+	if (copy_from_user(&wr, (void __user *)arg,
+			   sizeof(struct xlinkwritedata)))
+		return -EFAULT;
+	if (copy_from_user(&devh, (void __user *)wr.handle,
+			   sizeof(struct xlink_handle)))
+		return -EFAULT;
+	if (wr.size <= XLINK_MAX_BUF_SIZE) {
+		if (copy_from_user(volbuf, (void __user *)wr.pmessage,
+				   wr.size))
+			return -EFAULT;
+		rc = xlink_write_volatile_user(&devh, wr.chan, volbuf,
+					       wr.size);
+		if (copy_to_user((void __user *)wr.return_code, (void *)&rc,
+				 sizeof(rc)))
+			return -EFAULT;
+	} else {
+		return -EFAULT;
+	}
+	return rc;
+}
+
+int ioctl_release_data(unsigned long arg)
+{
+	struct xlink_handle	devh	= {0};
+	struct xlinkrelease	rel	= {0};
+	int rc = 0;
+	u8 reladdr;
+
+	if (copy_from_user(&rel, (void __user *)arg,
+			   sizeof(struct xlinkrelease)))
+		return -EFAULT;
+	if (copy_from_user(&devh, (void __user *)rel.handle,
+			   sizeof(struct xlink_handle)))
+		return -EFAULT;
+	if (rel.addr) {
+		if (get_user(reladdr, (u32 __user *const)rel.addr))
+			return -EFAULT;
+		rc = xlink_release_data(&devh, rel.chan,
+					(u8 *)&reladdr);
+	} else {
+		rc = xlink_release_data(&devh, rel.chan, NULL);
+	}
+	if (copy_to_user((void __user *)rel.return_code, (void *)&rc, sizeof(rc)))
+		return -EFAULT;
+	return rc;
+}
+
+int ioctl_close_channel(unsigned long arg)
+{
+	struct xlink_handle	devh	= {0};
+	struct xlinkopenchannel		op	= {0};
+	int rc = 0;
+
+	if (copy_from_user(&op, (void __user *)arg,
+			   sizeof(struct xlinkopenchannel)))
+		return -EFAULT;
+	if (copy_from_user(&devh, (void __user *)op.handle,
+			   sizeof(struct xlink_handle)))
+		return -EFAULT;
+	rc = xlink_close_channel(&devh, op.chan);
+	if (copy_to_user((void __user *)op.return_code, (void *)&rc, sizeof(rc)))
+		return -EFAULT;
+	return rc;
+}
+
+int ioctl_start_vpu(unsigned long arg)
+{
+	struct xlinkstartvpu		startvpu = {0};
+	char filename[64];
+	int rc = 0;
+
+	if (copy_from_user(&startvpu, (void __user *)arg,
+			   sizeof(struct xlinkstartvpu)))
+		return -EFAULT;
+	if (startvpu.namesize > sizeof(filename))
+		return -EINVAL;
+	memset(filename, 0, sizeof(filename));
+	if (copy_from_user(filename, (void __user *)startvpu.filename,
+			   startvpu.namesize))
+		return -EFAULT;
+	rc = xlink_start_vpu(filename);
+	if (copy_to_user((void __user *)startvpu.return_code, (void *)&rc, sizeof(rc)))
+		return -EFAULT;
+	return rc;
+}
+
+int ioctl_stop_vpu(void)
+{
+	int rc = 0;
+
+	rc = xlink_stop_vpu();
+	return rc;
+}
+
+int ioctl_disconnect(unsigned long arg)
+{
+	struct xlink_handle		devh	= {0};
+	struct xlinkconnect		con	= {0};
+	int rc = 0;
+
+	if (copy_from_user(&con, (void __user *)arg,
+			   sizeof(struct xlinkconnect)))
+		return -EFAULT;
+	if (copy_from_user(&devh, (void __user *)con.handle,
+			   sizeof(struct xlink_handle)))
+		return -EFAULT;
+	rc = xlink_disconnect(&devh);
+	if (copy_to_user((void __user *)con.return_code, (void *)&rc, sizeof(rc)))
+		return -EFAULT;
+	return rc;
+}
+
+int ioctl_get_device_name(unsigned long arg)
+{
+	struct xlink_handle		devh	= {0};
+	struct xlinkgetdevicename	devn	= {0};
+	char name[XLINK_MAX_DEVICE_NAME_SIZE];
+	int rc = 0;
+
+	if (copy_from_user(&devn, (void __user *)arg,
+			   sizeof(struct xlinkgetdevicename)))
+		return -EFAULT;
+	if (copy_from_user(&devh, (void __user *)devn.handle,
+			   sizeof(struct xlink_handle)))
+		return -EFAULT;
+	if (devn.name_size <= XLINK_MAX_DEVICE_NAME_SIZE) {
+		rc = xlink_get_device_name(&devh, name, devn.name_size);
+		if (!rc) {
+			if (copy_to_user((void __user *)devn.name, (void *)name,
+					 devn.name_size))
+				return -EFAULT;
+		}
+	} else {
+		rc = X_LINK_ERROR;
+	}
+	if (copy_to_user((void __user *)devn.return_code, (void *)&rc, sizeof(rc)))
+		return -EFAULT;
+	return rc;
+}
+
+int ioctl_get_device_list(unsigned long arg)
+{
+	struct xlinkgetdevicelist	devl	= {0};
+	u32 sw_device_id_list[XLINK_MAX_DEVICE_LIST_SIZE];
+	u32 num_devices = 0;
+	int rc = 0;
+
+	if (copy_from_user(&devl, (void __user *)arg,
+			   sizeof(struct xlinkgetdevicelist)))
+		return -EFAULT;
+	rc = xlink_get_device_list(sw_device_id_list, &num_devices);
+	if (!rc && num_devices <= XLINK_MAX_DEVICE_LIST_SIZE) {
+		/* TODO: this next copy is dangerous! we have no idea
+		 * how large the devl.sw_device_id_list buffer is
+		 * provided by the user. if num_devices is too large,
+		 * the copy will overflow the buffer.
+		 */
+		if (copy_to_user((void __user *)devl.sw_device_id_list,
+				 (void *)sw_device_id_list,
+				 (sizeof(*sw_device_id_list)
+				 * num_devices)))
+			return -EFAULT;
+		if (copy_to_user((void __user *)devl.num_devices, (void *)&num_devices,
+				 (sizeof(num_devices))))
+			return -EFAULT;
+	}
+	if (copy_to_user((void __user *)devl.return_code, (void *)&rc, sizeof(rc)))
+		return -EFAULT;
+	return rc;
+}
+
+int ioctl_get_device_status(unsigned long arg)
+{
+	struct xlink_handle		devh	= {0};
+	struct xlinkgetdevicestatus	devs	= {0};
+	u32 device_status = 0;
+	int rc = 0;
+
+	if (copy_from_user(&devs, (void __user *)arg,
+			   sizeof(struct xlinkgetdevicestatus)))
+		return -EFAULT;
+	if (copy_from_user(&devh, (void __user *)devs.handle,
+			   sizeof(struct xlink_handle)))
+		return -EFAULT;
+	rc = xlink_get_device_status(&devh, &device_status);
+	if (!rc) {
+		if (copy_to_user((void __user *)devs.device_status,
+				 (void *)&device_status,
+				 sizeof(device_status)))
+			return -EFAULT;
+	}
+	if (copy_to_user((void __user *)devs.return_code, (void *)&rc, sizeof(rc)))
+		return -EFAULT;
+	return rc;
+}
+
+int ioctl_boot_device(unsigned long arg)
+{
+	struct xlink_handle		devh	= {0};
+	struct xlinkbootdevice		boot	= {0};
+	char filename[64];
+	int rc = 0;
+
+	if (copy_from_user(&boot, (void __user *)arg,
+			   sizeof(struct xlinkbootdevice)))
+		return -EFAULT;
+	if (copy_from_user(&devh, (void __user *)boot.handle,
+			   sizeof(struct xlink_handle)))
+		return -EFAULT;
+	if (boot.binary_name_size > sizeof(filename))
+		return -EINVAL;
+	memset(filename, 0, sizeof(filename));
+	if (copy_from_user(filename, (void __user *)boot.binary_name,
+			   boot.binary_name_size))
+		return -EFAULT;
+	rc = xlink_boot_device(&devh, filename);
+	if (copy_to_user((void __user *)boot.return_code, (void *)&rc, sizeof(rc)))
+		return -EFAULT;
+	return rc;
+}
+
+int ioctl_reset_device(unsigned long arg)
+{
+	struct xlink_handle		devh	= {0};
+	struct xlinkresetdevice		res	= {0};
+	int rc = 0;
+
+	if (copy_from_user(&res, (void __user *)arg,
+			   sizeof(struct xlinkresetdevice)))
+		return -EFAULT;
+	if (copy_from_user(&devh, (void __user *)res.handle,
+			   sizeof(struct xlink_handle)))
+		return -EFAULT;
+	rc = xlink_reset_device(&devh);
+	if (copy_to_user((void __user *)res.return_code, (void *)&rc, sizeof(rc)))
+		return -EFAULT;
+	return rc;
+}
+
+int ioctl_get_device_mode(unsigned long arg)
+{
+	struct xlink_handle	devh	= {0};
+	struct xlinkdevmode	devm	= {0};
+	u32 device_mode = 0;
+	int rc = 0;
+
+	if (copy_from_user(&devm, (void __user *)arg,
+			   sizeof(struct xlinkdevmode)))
+		return -EFAULT;
+	if (copy_from_user(&devh, (void __user *)devm.handle,
+			   sizeof(struct xlink_handle)))
+		return -EFAULT;
+	rc = xlink_get_device_mode(&devh, &device_mode);
+	if (!rc) {
+		if (copy_to_user((void __user *)devm.device_mode, (void *)&device_mode,
+				 sizeof(device_mode)))
+			return -EFAULT;
+	}
+	if (copy_to_user((void __user *)devm.return_code, (void *)&rc, sizeof(rc)))
+		return -EFAULT;
+	return rc;
+}
+
+int ioctl_set_device_mode(unsigned long arg)
+{
+	struct xlink_handle	devh	= {0};
+	struct xlinkdevmode	devm	= {0};
+	u32 device_mode = 0;
+	int rc = 0;
+
+	if (copy_from_user(&devm, (void __user *)arg,
+			   sizeof(struct xlinkdevmode)))
+		return -EFAULT;
+	if (copy_from_user(&devh, (void __user *)devm.handle,
+			   sizeof(struct xlink_handle)))
+		return -EFAULT;
+	if (copy_from_user(&device_mode, (void __user *)devm.device_mode,
+			   sizeof(device_mode)))
+		return -EFAULT;
+	rc = xlink_set_device_mode(&devh, device_mode);
+	if (copy_to_user((void __user *)devm.return_code, (void *)&rc, sizeof(rc)))
+		return -EFAULT;
+	return rc;
+}
+
+int ioctl_register_device_event(unsigned long arg)
+{
+	struct xlink_handle	devh	= {0};
+	struct xlinkregdevevent	regdevevent = {0};
+	u32 num_events = 0;
+	u32 *ev_list;
+	int rc = 0;
+
+	if (copy_from_user(&regdevevent, (void __user *)arg,
+			   sizeof(struct xlinkregdevevent)))
+		return -EFAULT;
+	if (copy_from_user(&devh, (void __user *)regdevevent.handle,
+			   sizeof(struct xlink_handle)))
+		return -EFAULT;
+	num_events = regdevevent.num_events;
+	if (num_events > 0 && num_events <= NUM_REG_EVENTS) {
+		ev_list = kzalloc((num_events * sizeof(u32)), GFP_KERNEL);
+		if (ev_list) {
+			if (copy_from_user(ev_list,
+					   (void __user *)regdevevent.event_list,
+					   (num_events * sizeof(u32)))) {
+				kfree(ev_list);
+				return -EFAULT;
+			}
+			rc = xlink_register_device_event_user(&devh,
+							      ev_list,
+							      num_events,
+							      NULL);
+			kfree(ev_list);
+		} else {
+			rc = X_LINK_ERROR;
+		}
+	} else {
+		rc = X_LINK_ERROR;
+	}
+	if (copy_to_user((void __user *)regdevevent.return_code, (void *)&rc, sizeof(rc)))
+		return -EFAULT;
+	return rc;
+}
+
+int ioctl_unregister_device_event(unsigned long arg)
+{
+	struct xlink_handle	devh	= {0};
+	struct xlinkregdevevent	regdevevent = {0};
+	u32 num_events = 0;
+	u32 *ev_list;
+	int rc = 0;
+
+	if (copy_from_user(&regdevevent, (void __user *)arg,
+			   sizeof(struct xlinkregdevevent)))
+		return -EFAULT;
+	if (copy_from_user(&devh, (void __user *)regdevevent.handle,
+			   sizeof(struct xlink_handle)))
+		return -EFAULT;
+	num_events = regdevevent.num_events;
+	if (num_events <= NUM_REG_EVENTS) {
+		ev_list = kzalloc((num_events * sizeof(u32)), GFP_KERNEL);
+		if (copy_from_user(ev_list,
+				   (void __user *)regdevevent.event_list,
+				   (num_events * sizeof(u32)))) {
+			kfree(ev_list);
+			return -EFAULT;
+		}
+		rc = xlink_unregister_device_event(&devh, ev_list, num_events);
+		kfree(ev_list);
+	} else {
+		rc = X_LINK_ERROR;
+	}
+	if (copy_to_user((void __user *)regdevevent.return_code, (void *)&rc, sizeof(rc)))
+		return -EFAULT;
+	return rc;
+}
+
+int ioctl_data_ready_callback(unsigned long arg)
+{
+	struct xlink_handle	devh	= {0};
+	struct xlinkcallback	cb	= {0};
+	int rc = 0;
+
+	if (copy_from_user(&cb, (void __user *)arg,
+			   sizeof(struct xlinkcallback)))
+		return -EFAULT;
+	if (copy_from_user(&devh, (void __user *)cb.handle,
+			   sizeof(struct xlink_handle)))
+		return -EFAULT;
+	CHANNEL_SET_USER_BIT(cb.chan); // set MSbit for user space call
+	rc = xlink_data_available_event(&devh, cb.chan, cb.callback);
+	if (copy_to_user((void __user *)cb.return_code, (void *)&rc, sizeof(rc)))
+		return -EFAULT;
+	return rc;
+}
+
+int ioctl_data_consumed_callback(unsigned long arg)
+{
+	struct xlink_handle	devh	= {0};
+	struct xlinkcallback	cb	= {0};
+	int rc = 0;
+
+	if (copy_from_user(&cb, (void __user *)arg,
+			   sizeof(struct xlinkcallback)))
+		return -EFAULT;
+	if (copy_from_user(&devh, (void __user *)cb.handle,
+			   sizeof(struct xlink_handle)))
+		return -EFAULT;
+	CHANNEL_SET_USER_BIT(cb.chan); // set MSbit for user space call
+	rc = xlink_data_consumed_event(&devh, cb.chan, cb.callback);
+	if (copy_to_user((void __user *)cb.return_code, (void *)&rc, sizeof(rc)))
+		return -EFAULT;
+	return rc;
+}
diff --git a/drivers/misc/xlink-core/xlink-ioctl.h b/drivers/misc/xlink-core/xlink-ioctl.h
new file mode 100644
index 000000000000..7818b676d488
--- /dev/null
+++ b/drivers/misc/xlink-core/xlink-ioctl.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * xlink ioctl header files.
+ *
+ * Copyright (C) 2018-2019 Intel Corporation
+ *
+ */
+
+#ifndef XLINK_IOCTL_H_
+#define XLINK_IOCTL_H_
+
+int ioctl_connect(unsigned long arg);
+int ioctl_open_channel(unsigned long arg);
+int ioctl_read_data(unsigned long arg);
+int ioctl_read_to_buffer(unsigned long arg);
+int ioctl_write_data(unsigned long arg);
+int ioctl_write_control_data(unsigned long arg);
+int ioctl_write_volatile_data(unsigned long arg);
+int ioctl_release_data(unsigned long arg);
+int ioctl_close_channel(unsigned long arg);
+int ioctl_start_vpu(unsigned long arg);
+int ioctl_stop_vpu(void);
+int ioctl_disconnect(unsigned long arg);
+int ioctl_get_device_name(unsigned long arg);
+int ioctl_get_device_list(unsigned long arg);
+int ioctl_get_device_status(unsigned long arg);
+int ioctl_boot_device(unsigned long arg);
+int ioctl_reset_device(unsigned long arg);
+int ioctl_get_device_mode(unsigned long arg);
+int ioctl_set_device_mode(unsigned long arg);
+int ioctl_register_device_event(unsigned long arg);
+int ioctl_unregister_device_event(unsigned long arg);
+int ioctl_data_ready_callback(unsigned long arg);
+int ioctl_data_consumed_callback(unsigned long arg);
+
+#endif /* XLINK_IOCTL_H_ */
-- 
2.17.1

