Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF71D2CB055
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 23:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbgLAWjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 17:39:36 -0500
Received: from mga06.intel.com ([134.134.136.31]:7601 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728439AbgLAWjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 17:39:33 -0500
IronPort-SDR: f9twDxuSHj9KVoET2jTWOk0NMRlXxzHekf6YEMHTUsevrrFIhbSHRWQozzXRWOX4rB+wTAymO7
 W4smCH6tZvHg==
X-IronPort-AV: E=McAfee;i="6000,8403,9822"; a="234524395"
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="234524395"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 14:35:16 -0800
IronPort-SDR: 7Z5lelMds+uBUqPzU4YptIp86uLLYOYJSuWWq/7YmXE1NPANYpqEjxsKH1T8EnGKZUy8xK9StK
 e3ndaPiyOGbw==
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="405290687"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 14:35:16 -0800
Received: from mtg-dev (mtg-dev.jf.intel.com [10.54.74.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.ostc.intel.com (Postfix) with ESMTPS id 09DD2636D;
        Tue,  1 Dec 2020 14:35:16 -0800 (PST)
Received: from mgross by mtg-dev with local (Exim 4.90_1)
        (envelope-from <mgross@linux.intel.com>)
        id 1kkEEt-000H5D-SY; Tue, 01 Dec 2020 14:35:15 -0800
From:   mgross@linux.intel.com
To:     markgross@kernel.org, mgross@linux.intel.com, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        leonard.crestez@nxp.com, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, peng.fan@nxp.com, robh+dt@kernel.org,
        shawnguo@kernel.org
Cc:     linux-kernel@vger.kernel.org, Seamus Kelly <seamus.kelly@intel.com>
Subject: [PATCH 20/22] xlink-core: Enable VPU IP management and runtime control
Date:   Tue,  1 Dec 2020 14:35:09 -0800
Message-Id: <20201201223511.65542-21-mgross@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201201223511.65542-1-mgross@linux.intel.com>
References: <20201201223511.65542-1-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Seamus Kelly <seamus.kelly@intel.com>

Enable VPU management including, enumeration, boot and runtime control.

Add APIs:
	write control data:
		used to transmit small, local data
	start vpu:
			calls boot_device API ( soon to be deprecated )
	stop vpu
			calls reset_device API ( soon to be deprecated )
	reset vpu
			calls reset_device API ( soon to be deprecated )
	get device name:
		Returns the device name for the input device id
		This could be a char device path, for example "/dev/ttyUSB0"
		for a serial device; or it could be a device string
		description, for example, for PCIE "00:00.0 Host bridge: Intel
		Corporation 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 01)"
	get device list:
		Returns the list of software device IDs for all connected
		physical devices
	get device status:
		returns the current state of the input device
			OFF - The device is off (D3cold/Slot power removed).
			BUSY - device is busy and not available (device is booting)
			READY - device is available for use
			ERROR - device HW failure is detected
			RECOVERY - device is in recovery mode, waiting for recovery operations
	boot device:
		When used on the remote host - starts the SOC device by calling
		corresponding function from VPU Driver.
		Takes firmware's 'binary_name' as input.
		For Linux, the firmware image is expected to be located in
		'/lib/firmware' folder or its subfolders.
		For Linux, 'binary_name' is not a path but an image name that
		will be searched in the default Linux search paths ('/lib/firmware').
		When used on the local host - triggers the booting of VPUIP device.
	reset device:
		When used on the remote host - resets the device by calling
		corresponding VPU Driver function.
		When used on the local host - resets the VPUIP device
	get device mode:
		query and returns the current device power mode
	set device mode:
		used for device throttling or entering various power modes

Reviewed-by: Mark Gross <mgross@linux.intel.com>
Signed-off-by: Seamus Kelly <seamus.kelly@intel.com>
---
 drivers/misc/xlink-core/xlink-core.c        | 408 +++++++++++++++++++-
 drivers/misc/xlink-core/xlink-defs.h        |   2 +
 drivers/misc/xlink-core/xlink-multiplexer.c |  56 +++
 drivers/misc/xlink-core/xlink-platform.c    |  86 +++++
 include/linux/xlink.h                       |  27 ++
 5 files changed, 573 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/xlink-core/xlink-core.c b/drivers/misc/xlink-core/xlink-core.c
index e7d5f68a5ba1..a600068840d3 100644
--- a/drivers/misc/xlink-core/xlink-core.c
+++ b/drivers/misc/xlink-core/xlink-core.c
@@ -81,6 +81,8 @@ struct keembay_xlink_dev {
 	struct mutex lock;  // protect access to xlink_dev
 };
 
+static u8 volbuf[XLINK_MAX_BUF_SIZE]; // buffer for volatile transactions
+
 /*
  * global variable pointing to our xlink device.
  *
@@ -260,14 +262,27 @@ static int kmb_xlink_remove(struct platform_device *pdev)
 
 static long xlink_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
-	int interface = NULL_INTERFACE;
 	struct xlink_handle		devh	= {0};
 	struct xlinkopenchannel		op	= {0};
 	struct xlinkwritedata		wr	= {0};
 	struct xlinkreaddata		rd	= {0};
+	struct xlinkreadtobuffer	rdtobuf = {0};
 	struct xlinkconnect		con	= {0};
 	struct xlinkrelease		rel	= {0};
-	u8 volbuf[XLINK_MAX_BUF_SIZE];
+	struct xlinkstartvpu		startvpu = {0};
+	struct xlinkgetdevicename	devn	= {0};
+	struct xlinkgetdevicelist	devl	= {0};
+	struct xlinkgetdevicestatus	devs	= {0};
+	struct xlinkbootdevice		boot	= {0};
+	struct xlinkresetdevice		res	= {0};
+	struct xlinkdevmode		devm	= {0};
+	u32 sw_device_id_list[XLINK_MAX_DEVICE_LIST_SIZE];
+	char name[XLINK_MAX_DEVICE_NAME_SIZE];
+	int interface = NULL_INTERFACE;
+	u32 device_status = 0;
+	u32 num_devices = 0;
+	u32 device_mode = 0;
+	char filename[64];
 	u8 reladdr;
 	u8 *rdaddr;
 	u32 size;
@@ -328,6 +343,26 @@ static long xlink_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		if (copy_to_user((void __user *)rd.return_code, (void *)&rc, sizeof(rc)))
 			return -EFAULT;
 		break;
+	case XL_READ_TO_BUFFER:
+		if (copy_from_user(&rdtobuf, (void __user *)arg,
+				   sizeof(struct xlinkreadtobuffer)))
+			return -EFAULT;
+		if (copy_from_user(&devh, (void __user *)rdtobuf.handle,
+				   sizeof(struct xlink_handle)))
+			return -EFAULT;
+		rc = xlink_read_data_to_buffer(&devh, rdtobuf.chan,
+					       (u8 *)volbuf, &size);
+		if (!rc) {
+			if (copy_to_user((void __user *)rdtobuf.pmessage, (void *)volbuf,
+					 size))
+				return -EFAULT;
+			if (copy_to_user((void __user *)rdtobuf.size, (void *)&size,
+					 sizeof(size)))
+				return -EFAULT;
+		}
+		if (copy_to_user((void __user *)rdtobuf.return_code, (void *)&rc, sizeof(rc)))
+			return -EFAULT;
+		break;
 	case XL_WRITE_DATA:
 		if (copy_from_user(&wr, (void __user *)arg,
 				   sizeof(struct xlinkwritedata)))
@@ -346,16 +381,40 @@ static long xlink_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		}
 		break;
 	case XL_WRITE_VOLATILE:
-		if (copy_from_user(&wr,  (void __user *)arg, sizeof(struct xlinkwritedata)))
+		if (copy_from_user(&wr, (void __user *)arg,
+				   sizeof(struct xlinkwritedata)))
 			return -EFAULT;
 		if (copy_from_user(&devh, (void __user *)wr.handle,
 				   sizeof(struct xlink_handle)))
 			return -EFAULT;
 		if (wr.size <= XLINK_MAX_BUF_SIZE) {
-			if (copy_from_user(volbuf, (void __user *)wr.pmessage, wr.size))
+			if (copy_from_user(volbuf, (void __user *)wr.pmessage,
+					   wr.size))
 				return -EFAULT;
-			rc = xlink_write_volatile_user(&devh, wr.chan, volbuf, wr.size);
-			if (copy_to_user((void __user *)wr.return_code, (void *)&rc, sizeof(rc)))
+			rc = xlink_write_volatile_user(&devh, wr.chan, volbuf,
+						       wr.size);
+			if (copy_to_user((void __user *)wr.return_code, (void *)&rc,
+					 sizeof(rc)))
+				return -EFAULT;
+		} else {
+			return -EFAULT;
+		}
+		break;
+	case XL_WRITE_CONTROL_DATA:
+		if (copy_from_user(&wr, (void __user *)arg,
+				   sizeof(struct xlinkwritedata)))
+			return -EFAULT;
+		if (copy_from_user(&devh, (void __user *)wr.handle,
+				   sizeof(struct xlink_handle)))
+			return -EFAULT;
+		if (wr.size <= XLINK_MAX_CONTROL_DATA_SIZE) {
+			if (copy_from_user(volbuf, (void __user *)wr.pmessage,
+					   wr.size))
+				return -EFAULT;
+			rc = xlink_write_control_data(&devh, wr.chan, volbuf,
+						      wr.size);
+			if (copy_to_user((void __user *)wr.return_code,
+					 (void *)&rc, sizeof(rc)))
 				return -EFAULT;
 		} else {
 			return -EFAULT;
@@ -390,6 +449,26 @@ static long xlink_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		if (copy_to_user((void __user *)op.return_code, (void *)&rc, sizeof(rc)))
 			return -EFAULT;
 		break;
+	case XL_START_VPU:
+		if (copy_from_user(&startvpu, (void __user *)arg,
+				   sizeof(struct xlinkstartvpu)))
+			return -EFAULT;
+		if (startvpu.namesize > sizeof(filename))
+			return -EINVAL;
+		memset(filename, 0, sizeof(filename));
+		if (copy_from_user(filename, (void __user *)startvpu.filename,
+				   startvpu.namesize))
+			return -EFAULT;
+		rc = xlink_start_vpu(filename);
+		if (copy_to_user((void __user *)startvpu.return_code, (void *)&rc, sizeof(rc)))
+			return -EFAULT;
+		break;
+	case XL_STOP_VPU:
+		rc = xlink_stop_vpu();
+		break;
+	case XL_RESET_VPU:
+		rc = xlink_stop_vpu();
+		break;
 	case XL_DISCONNECT:
 		if (copy_from_user(&con, (void __user *)arg,
 				   sizeof(struct xlinkconnect)))
@@ -401,6 +480,124 @@ static long xlink_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		if (copy_to_user((void __user *)con.return_code, (void *)&rc, sizeof(rc)))
 			return -EFAULT;
 		break;
+	case XL_GET_DEVICE_NAME:
+		if (copy_from_user(&devn, (void __user *)arg,
+				   sizeof(struct xlinkgetdevicename)))
+			return -EFAULT;
+		if (copy_from_user(&devh, (void __user *)devn.handle,
+				   sizeof(struct xlink_handle)))
+			return -EFAULT;
+		if (devn.name_size <= XLINK_MAX_DEVICE_NAME_SIZE) {
+			rc = xlink_get_device_name(&devh, name, devn.name_size);
+			if (!rc) {
+				if (copy_to_user((void __user *)devn.name, (void *)name,
+						 devn.name_size))
+					return -EFAULT;
+			}
+		} else {
+			rc = X_LINK_ERROR;
+		}
+		if (copy_to_user((void __user *)devn.return_code, (void *)&rc, sizeof(rc)))
+			return -EFAULT;
+		break;
+	case XL_GET_DEVICE_LIST:
+		if (copy_from_user(&devl, (void __user *)arg,
+				   sizeof(struct xlinkgetdevicelist)))
+			return -EFAULT;
+		rc = xlink_get_device_list(sw_device_id_list, &num_devices);
+		if (!rc && num_devices <= XLINK_MAX_DEVICE_LIST_SIZE) {
+			/* TODO: this next copy is dangerous! we have no idea
+			 * how large the devl.sw_device_id_list buffer is
+			 * provided by the user. if num_devices is too large,
+			 * the copy will overflow the buffer.
+			 */
+			if (copy_to_user((void __user *)devl.sw_device_id_list,
+					 (void *)sw_device_id_list,
+					 (sizeof(*sw_device_id_list)
+					 * num_devices)))
+				return -EFAULT;
+			if (copy_to_user((void __user *)devl.num_devices, (void *)&num_devices,
+					 (sizeof(num_devices))))
+				return -EFAULT;
+		}
+		if (copy_to_user((void __user *)devl.return_code, (void *)&rc, sizeof(rc)))
+			return -EFAULT;
+		break;
+	case XL_GET_DEVICE_STATUS:
+		if (copy_from_user(&devs, (void __user *)arg,
+				   sizeof(struct xlinkgetdevicestatus)))
+			return -EFAULT;
+		if (copy_from_user(&devh, (void __user *)devs.handle,
+				   sizeof(struct xlink_handle)))
+			return -EFAULT;
+		rc = xlink_get_device_status(&devh, &device_status);
+		if (!rc) {
+			if (copy_to_user((void __user *)devs.device_status,
+					 (void *)&device_status,
+					 sizeof(device_status)))
+				return -EFAULT;
+		}
+		if (copy_to_user((void __user *)devs.return_code, (void *)&rc, sizeof(rc)))
+			return -EFAULT;
+		break;
+	case XL_BOOT_DEVICE:
+		if (copy_from_user(&boot, (void __user *)arg,
+				   sizeof(struct xlinkbootdevice)))
+			return -EFAULT;
+		if (copy_from_user(&devh, (void __user *)boot.handle,
+				   sizeof(struct xlink_handle)))
+			return -EFAULT;
+		if (boot.binary_name_size > sizeof(filename))
+			return -EINVAL;
+		memset(filename, 0, sizeof(filename));
+		if (copy_from_user(filename, (void __user *)boot.binary_name,
+				   boot.binary_name_size))
+			return -EFAULT;
+		rc = xlink_boot_device(&devh, filename);
+		if (copy_to_user((void __user *)boot.return_code, (void *)&rc, sizeof(rc)))
+			return -EFAULT;
+		break;
+	case XL_RESET_DEVICE:
+		if (copy_from_user(&res, (void __user *)arg,
+				   sizeof(struct xlinkresetdevice)))
+			return -EFAULT;
+		if (copy_from_user(&devh, (void __user *)res.handle,
+				   sizeof(struct xlink_handle)))
+			return -EFAULT;
+		rc = xlink_reset_device(&devh);
+		if (copy_to_user((void __user *)res.return_code, (void *)&rc, sizeof(rc)))
+			return -EFAULT;
+		break;
+	case XL_GET_DEVICE_MODE:
+		if (copy_from_user(&devm, (void __user *)arg,
+				   sizeof(struct xlinkdevmode)))
+			return -EFAULT;
+		if (copy_from_user(&devh, (void __user *)devm.handle,
+				   sizeof(struct xlink_handle)))
+			return -EFAULT;
+		rc = xlink_get_device_mode(&devh, &device_mode);
+		if (!rc) {
+			if (copy_to_user((void __user *)devm.device_mode, (void *)&device_mode,
+					 sizeof(device_mode)))
+				return -EFAULT;
+		}
+		if (copy_to_user((void __user *)devm.return_code, (void *)&rc, sizeof(rc)))
+			return -EFAULT;
+		break;
+	case XL_SET_DEVICE_MODE:
+		if (copy_from_user(&devm, (void __user *)arg,
+				   sizeof(struct xlinkdevmode)))
+			return -EFAULT;
+		if (copy_from_user(&devh, (void __user *)devm.handle,
+				   sizeof(struct xlink_handle)))
+			return -EFAULT;
+		if (copy_from_user(&device_mode, (void __user *)devm.device_mode,
+				   sizeof(device_mode)))
+			return -EFAULT;
+		rc = xlink_set_device_mode(&devh, device_mode);
+		if (copy_to_user((void __user *)devm.return_code, (void *)&rc, sizeof(rc)))
+			return -EFAULT;
+		break;
 	}
 	if (rc)
 		return -EIO;
@@ -411,6 +608,30 @@ static long xlink_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 /*
  * xlink Kernel API.
  */
+enum xlink_error xlink_stop_vpu(void)
+{
+#ifdef CONFIG_XLINK_LOCAL_HOST
+	int rc;
+
+	rc = xlink_ipc_reset_device(0x0); // stop vpu slice 0
+	if (rc)
+		return X_LINK_ERROR;
+#endif
+	return X_LINK_SUCCESS;
+}
+EXPORT_SYMBOL(xlink_stop_vpu);
+enum xlink_error xlink_start_vpu(char *filename)
+{
+#ifdef CONFIG_XLINK_LOCAL_HOST
+	int rc;
+
+	rc = xlink_ipc_boot_device(0x0, filename); // start vpu slice 0
+	if (rc)
+		return X_LINK_ERROR;
+#endif
+	return X_LINK_SUCCESS;
+}
+EXPORT_SYMBOL(xlink_start_vpu);
 
 enum xlink_error xlink_initialize(void)
 {
@@ -649,6 +870,33 @@ static enum xlink_error xlink_write_data_user(struct xlink_handle *handle,
 	return rc;
 }
 
+enum xlink_error xlink_write_control_data(struct xlink_handle *handle,
+					  u16 chan, u8 const *pmessage,
+					  u32 size)
+{
+	struct xlink_event *event;
+	struct xlink_link *link;
+	int event_queued = 0;
+	enum xlink_error rc;
+
+	if (!xlink || !handle)
+		return X_LINK_ERROR;
+	if (size > XLINK_MAX_CONTROL_DATA_SIZE)
+		return X_LINK_ERROR; // TODO: XLink Parameter Error
+	link = get_link_by_sw_device_id(handle->sw_device_id);
+	if (!link)
+		return X_LINK_ERROR;
+	event = xlink_create_event(link->id, XLINK_WRITE_CONTROL_REQ,
+				   &link->handle, chan, size, 0);
+	if (!event)
+		return X_LINK_ERROR;
+	memcpy(event->header.control_data, pmessage, size);
+	rc = xlink_multiplexer_tx(event, &event_queued);
+	if (!event_queued)
+		xlink_destroy_event(event);
+	return rc;
+}
+EXPORT_SYMBOL(xlink_write_control_data);
 static enum xlink_error xlink_write_volatile_user(struct xlink_handle *handle,
 						  u16 chan, u8 const *message,
 						  u32 size)
@@ -844,6 +1092,154 @@ enum xlink_error xlink_disconnect(struct xlink_handle *handle)
 }
 EXPORT_SYMBOL(xlink_disconnect);
 
+enum xlink_error xlink_get_device_list(u32 *sw_device_id_list,
+				       u32 *num_devices)
+{
+	u32 interface_nmb_devices = 0;
+	enum xlink_error rc;
+	int i;
+
+	if (!xlink)
+		return X_LINK_ERROR;
+	if (!sw_device_id_list || !num_devices)
+		return X_LINK_ERROR;
+	/* loop through each interface and combine the lists */
+	for (i = 0; i < NMB_OF_INTERFACES; i++) {
+		rc = xlink_platform_get_device_list(i, sw_device_id_list,
+						    &interface_nmb_devices);
+		if (!rc) {
+			*num_devices += interface_nmb_devices;
+			sw_device_id_list += interface_nmb_devices;
+		}
+		interface_nmb_devices = 0;
+	}
+	return X_LINK_SUCCESS;
+}
+EXPORT_SYMBOL(xlink_get_device_list);
+enum xlink_error xlink_get_device_name(struct xlink_handle *handle, char *name,
+				       size_t name_size)
+{
+	enum xlink_error rc;
+	int interface;
+
+	if (!xlink || !handle)
+		return X_LINK_ERROR;
+	if (!name || !name_size)
+		return X_LINK_ERROR;
+	interface = get_interface_from_sw_device_id(handle->sw_device_id);
+	if (interface == NULL_INTERFACE)
+		return X_LINK_ERROR;
+	rc = xlink_platform_get_device_name(interface, handle->sw_device_id,
+					    name, name_size);
+	if (rc)
+		rc = X_LINK_ERROR;
+	else
+		rc = X_LINK_SUCCESS;
+	return rc;
+}
+EXPORT_SYMBOL(xlink_get_device_name);
+enum xlink_error xlink_get_device_status(struct xlink_handle *handle,
+					 u32 *device_status)
+{
+	enum xlink_error rc;
+	u32 interface;
+
+	if (!xlink)
+		return X_LINK_ERROR;
+	if (!device_status)
+		return X_LINK_ERROR;
+	interface = get_interface_from_sw_device_id(handle->sw_device_id);
+	if (interface == NULL_INTERFACE)
+		return X_LINK_ERROR;
+	rc = xlink_platform_get_device_status(interface, handle->sw_device_id,
+					      device_status);
+	if (rc)
+		rc = X_LINK_ERROR;
+	else
+		rc = X_LINK_SUCCESS;
+	return rc;
+}
+EXPORT_SYMBOL(xlink_get_device_status);
+enum xlink_error xlink_boot_device(struct xlink_handle *handle,
+				   const char *binary_name)
+{
+	enum xlink_error rc;
+	u32 interface;
+
+	if (!xlink || !handle)
+		return X_LINK_ERROR;
+	if (!binary_name)
+		return X_LINK_ERROR;
+	interface = get_interface_from_sw_device_id(handle->sw_device_id);
+	if (interface == NULL_INTERFACE)
+		return X_LINK_ERROR;
+	rc = xlink_platform_boot_device(interface, handle->sw_device_id,
+					binary_name);
+	if (rc)
+		rc = X_LINK_ERROR;
+	else
+		rc = X_LINK_SUCCESS;
+	return rc;
+}
+EXPORT_SYMBOL(xlink_boot_device);
+enum xlink_error xlink_reset_device(struct xlink_handle *handle)
+{
+	enum xlink_error rc;
+	u32 interface;
+
+	if (!xlink || !handle)
+		return X_LINK_ERROR;
+	interface = get_interface_from_sw_device_id(handle->sw_device_id);
+	if (interface == NULL_INTERFACE)
+		return X_LINK_ERROR;
+	rc = xlink_platform_reset_device(interface, handle->sw_device_id);
+	if (rc)
+		rc = X_LINK_ERROR;
+	else
+		rc = X_LINK_SUCCESS;
+	return rc;
+}
+EXPORT_SYMBOL(xlink_reset_device);
+enum xlink_error xlink_set_device_mode(struct xlink_handle *handle,
+				       enum xlink_device_power_mode power_mode)
+{
+	enum xlink_error rc;
+	u32 interface;
+
+	if (!xlink || !handle)
+		return X_LINK_ERROR;
+	interface = get_interface_from_sw_device_id(handle->sw_device_id);
+	if (interface == NULL_INTERFACE)
+		return X_LINK_ERROR;
+	rc = xlink_platform_set_device_mode(interface, handle->sw_device_id,
+					    power_mode);
+	if (rc)
+		rc = X_LINK_ERROR;
+	else
+		rc = X_LINK_SUCCESS;
+	return rc;
+}
+EXPORT_SYMBOL(xlink_set_device_mode);
+enum xlink_error xlink_get_device_mode(struct xlink_handle *handle,
+				       enum xlink_device_power_mode *power_mode)
+{
+	enum xlink_error rc;
+	u32 interface;
+
+	if (!xlink || !handle)
+		return X_LINK_ERROR;
+	interface = get_interface_from_sw_device_id(handle->sw_device_id);
+	if (interface == NULL_INTERFACE)
+		return X_LINK_ERROR;
+	rc = xlink_platform_get_device_mode(interface, handle->sw_device_id,
+					    power_mode);
+	if (rc)
+		rc = X_LINK_ERROR;
+	else
+		rc = X_LINK_SUCCESS;
+	return rc;
+}
+EXPORT_SYMBOL(xlink_get_device_mode);
 /* Device tree driver match. */
 static const struct of_device_id kmb_xlink_of_match[] = {
 	{
diff --git a/drivers/misc/xlink-core/xlink-defs.h b/drivers/misc/xlink-core/xlink-defs.h
index 09aee36d5542..8985f6631175 100644
--- a/drivers/misc/xlink-core/xlink-defs.h
+++ b/drivers/misc/xlink-core/xlink-defs.h
@@ -101,6 +101,7 @@ enum xlink_event_type {
 	XLINK_OPEN_CHANNEL_REQ,
 	XLINK_CLOSE_CHANNEL_REQ,
 	XLINK_PING_REQ,
+	XLINK_WRITE_CONTROL_REQ,
 	XLINK_REQ_LAST,
 	// response events
 	XLINK_WRITE_RESP = 0x10,
@@ -111,6 +112,7 @@ enum xlink_event_type {
 	XLINK_OPEN_CHANNEL_RESP,
 	XLINK_CLOSE_CHANNEL_RESP,
 	XLINK_PING_RESP,
+	XLINK_WRITE_CONTROL_RESP,
 	XLINK_RESP_LAST,
 };
 
diff --git a/drivers/misc/xlink-core/xlink-multiplexer.c b/drivers/misc/xlink-core/xlink-multiplexer.c
index 339734826f3e..48451dc30712 100644
--- a/drivers/misc/xlink-core/xlink-multiplexer.c
+++ b/drivers/misc/xlink-core/xlink-multiplexer.c
@@ -491,6 +491,7 @@ enum xlink_error xlink_multiplexer_tx(struct xlink_event *event,
 	switch (event->header.type) {
 	case XLINK_WRITE_REQ:
 	case XLINK_WRITE_VOLATILE_REQ:
+	case XLINK_WRITE_CONTROL_REQ:
 		opchan = get_channel(link_id, chan);
 		if (!opchan || opchan->chan->status != CHAN_OPEN) {
 			rc = X_LINK_COMMUNICATION_FAIL;
@@ -657,6 +658,7 @@ enum xlink_error xlink_multiplexer_tx(struct xlink_event *event,
 		break;
 	case XLINK_WRITE_RESP:
 	case XLINK_WRITE_VOLATILE_RESP:
+	case XLINK_WRITE_CONTROL_RESP:
 	case XLINK_READ_RESP:
 	case XLINK_READ_TO_BUFFER_RESP:
 	case XLINK_RELEASE_RESP:
@@ -759,6 +761,46 @@ enum xlink_error xlink_multiplexer_rx(struct xlink_event *event)
 		}
 		release_channel(opchan);
 		break;
+	case XLINK_WRITE_CONTROL_REQ:
+		opchan = get_channel(link_id, chan);
+		if (!opchan) {
+			rc = X_LINK_COMMUNICATION_FAIL;
+		} else {
+			event->header.timeout = opchan->chan->timeout;
+			buffer = xlink_platform_allocate(xmux->dev, &paddr,
+							 event->header.size,
+							 XLINK_PACKET_ALIGNMENT,
+							 XLINK_NORMAL_MEMORY);
+			if (buffer) {
+				size = event->header.size;
+				memcpy(buffer, event->header.control_data, size);
+				event->paddr = paddr;
+				event->data = buffer;
+				if (add_packet_to_channel(opchan,
+							  &opchan->rx_queue,
+							  event->data,
+							  event->header.size,
+							  paddr)) {
+					xlink_platform_deallocate(xmux->dev,
+								  buffer, paddr,
+								  event->header.size,
+								  XLINK_PACKET_ALIGNMENT,
+								  XLINK_NORMAL_MEMORY);
+					rc = X_LINK_ERROR;
+					release_channel(opchan);
+					break;
+				}
+				event->header.type = XLINK_WRITE_CONTROL_RESP;
+				xlink_dispatcher_event_add(EVENT_RX, event);
+				// channel blocking, notify waiting threads of available packet
+				complete(&opchan->pkt_available);
+			} else {
+				// failed to allocate buffer
+				rc = X_LINK_ERROR;
+			}
+		}
+		release_channel(opchan);
+		break;
 	case XLINK_READ_REQ:
 	case XLINK_READ_TO_BUFFER_REQ:
 		opchan = get_channel(link_id, chan);
@@ -848,6 +890,7 @@ enum xlink_error xlink_multiplexer_rx(struct xlink_event *event)
 		break;
 	case XLINK_WRITE_RESP:
 	case XLINK_WRITE_VOLATILE_RESP:
+	case XLINK_WRITE_CONTROL_RESP:
 		opchan = get_channel(link_id, chan);
 		if (!opchan)
 			rc = X_LINK_COMMUNICATION_FAIL;
@@ -929,6 +972,18 @@ enum xlink_error xlink_passthrough(struct xlink_event *event)
 			rc = X_LINK_ERROR;
 		}
 		break;
+	case XLINK_WRITE_CONTROL_REQ:
+		if (xmux->channels[link_id][chan].ipc_status == CHAN_OPEN) {
+			ipc.is_volatile = 1;
+			rc = xlink_platform_write(IPC_INTERFACE,
+						  event->handle->sw_device_id,
+						  event->header.control_data,
+						  &event->header.size, 0, &ipc);
+		} else {
+			/* channel not open */
+			rc = X_LINK_ERROR;
+		}
+		break;
 	case XLINK_READ_REQ:
 		if (xmux->channels[link_id][chan].ipc_status == CHAN_OPEN) {
 			/* if channel has receive blocking set,
@@ -1013,6 +1068,7 @@ enum xlink_error xlink_passthrough(struct xlink_event *event)
 	case XLINK_PING_REQ:
 	case XLINK_WRITE_RESP:
 	case XLINK_WRITE_VOLATILE_RESP:
+	case XLINK_WRITE_CONTROL_RESP:
 	case XLINK_READ_RESP:
 	case XLINK_READ_TO_BUFFER_RESP:
 	case XLINK_RELEASE_RESP:
diff --git a/drivers/misc/xlink-core/xlink-platform.c b/drivers/misc/xlink-core/xlink-platform.c
index c34b69ee206b..56eb8da28a5f 100644
--- a/drivers/misc/xlink-core/xlink-platform.c
+++ b/drivers/misc/xlink-core/xlink-platform.c
@@ -34,6 +34,20 @@ static inline int xlink_ipc_read(u32 sw_device_id, void *data,
 				 size_t * const size, u32 timeout, void *context)
 { return -1; }
 
+static inline int xlink_ipc_get_device_list(u32 *sw_device_id_list,
+					    u32 *num_devices)
+{ return -1; }
+static inline int xlink_ipc_get_device_name(u32 sw_device_id,
+					    char *device_name, size_t name_size)
+{ return -1; }
+static inline int xlink_ipc_get_device_status(u32 sw_device_id,
+					      u32 *device_status)
+{ return -1; }
+static inline int xlink_ipc_boot_device(u32 sw_device_id,
+					const char *binary_path)
+{ return -1; }
+static inline int xlink_ipc_reset_device(u32 sw_device_id)
+{ return -1; }
 static inline int xlink_ipc_open_channel(u32 sw_device_id,
 					 u32 channel)
 { return -1; }
@@ -59,6 +73,23 @@ static int (*write_fcts[NMB_OF_INTERFACES])(u32, void *, size_t * const, u32) =
 static int (*read_fcts[NMB_OF_INTERFACES])(u32, void *, size_t * const, u32) = {
 		NULL, xlink_pcie_read, NULL, NULL};
 
+static int (*reset_fcts[NMB_OF_INTERFACES])(u32) = {
+		xlink_ipc_reset_device, xlink_pcie_reset_device, NULL, NULL};
+static int (*boot_fcts[NMB_OF_INTERFACES])(u32, const char *) = {
+		xlink_ipc_boot_device, xlink_pcie_boot_device, NULL, NULL};
+static int (*dev_name_fcts[NMB_OF_INTERFACES])(u32, char *, size_t) = {
+		xlink_ipc_get_device_name, xlink_pcie_get_device_name,
+		NULL, NULL};
+static int (*dev_list_fcts[NMB_OF_INTERFACES])(u32 *, u32 *) = {
+		xlink_ipc_get_device_list, xlink_pcie_get_device_list,
+		NULL, NULL};
+static int (*dev_status_fcts[NMB_OF_INTERFACES])(u32, u32 *) = {
+		xlink_ipc_get_device_status, xlink_pcie_get_device_status,
+		NULL, NULL};
+static int (*dev_set_mode_fcts[NMB_OF_INTERFACES])(u32, u32) = {
+		NULL, NULL, NULL, NULL};
+static int (*dev_get_mode_fcts[NMB_OF_INTERFACES])(u32, u32 *) = {
+		NULL, NULL, NULL, NULL};
 static int (*open_chan_fcts[NMB_OF_INTERFACES])(u32, u32) = {
 		xlink_ipc_open_channel, NULL, NULL, NULL};
 
@@ -103,6 +134,61 @@ int xlink_platform_read(u32 interface, u32 sw_device_id, void *data,
 	return read_fcts[interface](sw_device_id, data, size, timeout);
 }
 
+int xlink_platform_reset_device(u32 interface, u32 sw_device_id)
+{
+	if (interface >= NMB_OF_INTERFACES || !reset_fcts[interface])
+		return -1;
+	return reset_fcts[interface](sw_device_id);
+}
+
+int xlink_platform_boot_device(u32 interface, u32 sw_device_id,
+			       const char *binary_name)
+{
+	if (interface >= NMB_OF_INTERFACES || !boot_fcts[interface])
+		return -1;
+	return boot_fcts[interface](sw_device_id, binary_name);
+}
+
+int xlink_platform_get_device_name(u32 interface, u32 sw_device_id,
+				   char *device_name, size_t name_size)
+{
+	if (interface >= NMB_OF_INTERFACES || !dev_name_fcts[interface])
+		return -1;
+	return dev_name_fcts[interface](sw_device_id, device_name, name_size);
+}
+
+int xlink_platform_get_device_list(u32 interface,
+				   u32 *sw_device_id_list, u32 *num_devices)
+{
+	if (interface >= NMB_OF_INTERFACES || !dev_list_fcts[interface])
+		return -1;
+	return dev_list_fcts[interface](sw_device_id_list, num_devices);
+}
+
+int xlink_platform_get_device_status(u32 interface, u32 sw_device_id,
+				     u32 *device_status)
+{
+	if (interface >= NMB_OF_INTERFACES || !dev_status_fcts[interface])
+		return -1;
+	return dev_status_fcts[interface](sw_device_id, device_status);
+}
+
+int xlink_platform_set_device_mode(u32 interface, u32 sw_device_id,
+				   u32 power_mode)
+{
+	if (interface >= NMB_OF_INTERFACES || !dev_set_mode_fcts[interface])
+		return -1;
+	return dev_set_mode_fcts[interface](sw_device_id, power_mode);
+}
+
+int xlink_platform_get_device_mode(u32 interface, u32 sw_device_id,
+				   u32 *power_mode)
+{
+	if (interface >= NMB_OF_INTERFACES || !dev_get_mode_fcts[interface])
+		return -1;
+	return dev_get_mode_fcts[interface](sw_device_id, power_mode);
+}
+
 int xlink_platform_open_channel(u32 interface, u32 sw_device_id,
 				u32 channel)
 {
diff --git a/include/linux/xlink.h b/include/linux/xlink.h
index c22439d5aade..b00dbc719530 100644
--- a/include/linux/xlink.h
+++ b/include/linux/xlink.h
@@ -78,6 +78,10 @@ enum xlink_error xlink_write_data(struct xlink_handle *handle,
 enum xlink_error xlink_write_volatile(struct xlink_handle *handle,
 				      u16 chan, u8 const *message, u32 size);
 
+enum xlink_error xlink_write_control_data(struct xlink_handle *handle,
+					  u16 chan, u8 const *message,
+					  u32 size);
+
 enum xlink_error xlink_read_data(struct xlink_handle *handle,
 				 u16 chan, u8 **message, u32 *size);
 
@@ -90,6 +94,29 @@ enum xlink_error xlink_release_data(struct xlink_handle *handle,
 
 enum xlink_error xlink_disconnect(struct xlink_handle *handle);
 
+enum xlink_error xlink_get_device_list(u32 *sw_device_id_list, u32 *num_devices);
+
+enum xlink_error xlink_get_device_name(struct xlink_handle *handle, char *name,
+				       size_t name_size);
+
+enum xlink_error xlink_get_device_status(struct xlink_handle *handle,
+					 u32 *device_status);
+
+enum xlink_error xlink_boot_device(struct xlink_handle *handle,
+				   const char *binary_name);
+
+enum xlink_error xlink_reset_device(struct xlink_handle *handle);
+
+enum xlink_error xlink_set_device_mode(struct xlink_handle *handle,
+				       enum xlink_device_power_mode power_mode);
+
+enum xlink_error xlink_get_device_mode(struct xlink_handle *handle,
+				       enum xlink_device_power_mode *power_mode);
+
+enum xlink_error xlink_start_vpu(char *filename); /* depreciated */
+
+enum xlink_error xlink_stop_vpu(void); /* depreciated */
+
 /* API functions to be implemented
  *
  * enum xlink_error xlink_write_crc_data(struct xlink_handle *handle,
-- 
2.17.1

