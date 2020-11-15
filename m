Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B802B3897
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 20:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgKOTW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 14:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbgKOTWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 14:22:15 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3542DC0613D1;
        Sun, 15 Nov 2020 11:22:15 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id p8so16482514wrx.5;
        Sun, 15 Nov 2020 11:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Icljk0DNQg7ZYQ+BtpbRe8QfR3T/2x0+pREekKhrGyQ=;
        b=tLSvDZInUu3nXeye4WzRIWfBV7lxNfg8hdJsmjZQgozjgVQ2LmAK9ArWkEnMrrRK7M
         AkFppRi64EH13FT4BKgcMq2LvHokewIJmG08tt+wLwMV9YtDj0ZoTbRqwHCswa6XziJY
         CvjInxNVkhszawmMeGSLD2MNvJPI8zMkIEKC2/qj2vFaU/rHIMbKPxLCJgNDE0v+A2sO
         MNvCxHvYRjhifaVKiKp9syEqNL1Ty4y0EVTcT/cjF7oeQbh0MxtI7T6WwiVaILb0cCGK
         2R1LPy67Hlw9WX5FD0Zt4VJRWdkIA7MrOH8s7rBN9yszZUX4IM7ZNdz3cCis2wvMFub7
         zKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Icljk0DNQg7ZYQ+BtpbRe8QfR3T/2x0+pREekKhrGyQ=;
        b=r/e8fxD5TWarzb4HYd6xn/aicZXxEZr2rBwvm61uhlb6plPZ6wVSI+UTOWMyrsZQZY
         h3+cd6wTgewcplpFCVJ1u3udxJUUvcorTkJ2BAQjnQAOvvkxbi1ogj/Y3VHDwB2nZfyH
         6aVbysnKpkiAl/YuaiyStVF6kVj89ZHHYhZt8K+j2tJ6/rmt9AvMhlQU2nOeIJ8bvkhq
         Qby5V4woTKg3KDv7h8db3W2eOmCKd5y77WHSAuMVHbreV3tQsnidrvVhe3FyNyVciFfT
         HiTOe6L444u5ae9tn7jLVUaU/jeNusTMFZHJXolDHNxdT15hBUCp5J7St+9fhntnrRgd
         pJbA==
X-Gm-Message-State: AOAM530SLAjH08LMjCuh33Q3tohr5fd/NkuNv50HCZfKdtL1GxOL4jNU
        pVag6IW+0yKgdxxCHvUda2vlZaehuoA=
X-Google-Smtp-Source: ABdhPJz81vHQK0ApT/7Mb6YuriG9OKpGb3jZo2wGz8kIJvhmW9TbjhvpkUCeuJCfMiQASBgKwtLkUQ==
X-Received: by 2002:a5d:62ca:: with SMTP id o10mr15176751wrv.422.1605468133219;
        Sun, 15 Nov 2020 11:22:13 -0800 (PST)
Received: from xws.fritz.box (p5487b28b.dip0.t-ipconnect.de. [84.135.178.139])
        by smtp.gmail.com with ESMTPSA id u8sm17106600wmg.6.2020.11.15.11.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 11:22:12 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?Bla=C5=BE=20Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH 8/9] platform/surface: Add Surface Aggregator user-space interface
Date:   Sun, 15 Nov 2020 20:21:42 +0100
Message-Id: <20201115192143.21571-9-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201115192143.21571-1-luzmaximilian@gmail.com>
References: <20201115192143.21571-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a misc-device providing user-space access to the Surface Aggregator
EC, mainly intended for debugging, testing, and reverse-engineering.
This interface gives user-space applications the ability to send
requests to the EC and receive the corresponding responses.

The device-file is managed by a pseudo platform-device and corresponding
driver to avoid dependence on the dedicated bus, allowing it to be
loaded in a minimal configuration.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---

Changes from RFC:
 - add copyright lines
 - change SPDX identifier to GPL-2.0+ (was GPL-2.0-or-later)
 - move from debugfs to proper misc-device
 - move interface definitions to uapi header
 - remove versioning
 - allocate platform device dynamically
 - prioritize EFAULT error in IOCTL return
 - use ENOTTY error for unknown IOCTLs
 - fix IOCTL compatibility for 32-bit user-space on 64-bit kernels
 - mark request struct as __attribute__((__packed__))
 - address issues when driver is unbound while file still open 

---
 .../surface_aggregator/clients/cdev.rst       |  85 +++++
 .../surface_aggregator/clients/index.rst      |  12 +-
 MAINTAINERS                                   |   2 +
 drivers/platform/surface/Kconfig              |  17 +
 drivers/platform/surface/Makefile             |   1 +
 .../surface/surface_aggregator_cdev.c         | 299 ++++++++++++++++++
 include/uapi/linux/surface_aggregator/cdev.h  |  58 ++++
 7 files changed, 473 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/driver-api/surface_aggregator/clients/cdev.rst
 create mode 100644 drivers/platform/surface/surface_aggregator_cdev.c
 create mode 100644 include/uapi/linux/surface_aggregator/cdev.h

diff --git a/Documentation/driver-api/surface_aggregator/clients/cdev.rst b/Documentation/driver-api/surface_aggregator/clients/cdev.rst
new file mode 100644
index 000000000000..720c9c03aa0e
--- /dev/null
+++ b/Documentation/driver-api/surface_aggregator/clients/cdev.rst
@@ -0,0 +1,85 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+.. |u8| replace:: :c:type:`u8 <u8>`
+.. |u16| replace:: :c:type:`u16 <u16>`
+.. |ssam_cdev_request| replace:: :c:type:`struct ssam_cdev_request <ssam_cdev_request>`
+.. |ssam_request_flags| replace:: :c:type:`enum ssam_request_flags <ssam_request_flags>`
+
+==============================
+User-Space EC Interface (cdev)
+==============================
+
+The ``surface_aggregator_cdev`` module provides a misc-device for the SSAM
+controller to allow for a (more or less) direct connection from user-space to
+the SAM EC. It is intended to be used for development and debugging, and
+therefore should not be used or relied upon in any other way. Note that this
+module is not loaded automatically, but instead must be loaded manually.
+
+The provided interface is accessible through the ``/dev/surface/aggregator``
+device-file. All functionality of this interface is provided via IOCTLs.
+These IOCTLs and their respective input/output parameter structs are defined in
+``include/uapi/linux/surface_aggregator/cdev.h``.
+
+
+Controller IOCTLs
+=================
+
+The following IOCTLs are provided:
+
+.. flat-table:: Controller IOCTLs
+   :widths: 1 1 1 1 4
+   :header-rows: 1
+
+   * - Type
+     - Number
+     - Direction
+     - Name
+     - Description
+
+   * - ``0xA5``
+     - ``1``
+     - ``WR``
+     - ``REQUEST``
+     - Perform synchronous SAM request.
+
+
+``REQUEST``
+-----------
+
+Defined as ``_IOWR(0xA5, 1, struct ssam_cdev_request)``.
+
+Executes a synchronous SAM request. The request specification is passed in
+as argument of type |ssam_cdev_request|, which is then written to/modified
+by the IOCTL to return status and result of the request.
+
+Request payload data must be allocated separately and is passed in via the
+``payload.data`` and ``payload.length`` members. If a response is required,
+the response buffer must be allocated by the caller and passed in via the
+``response.data`` member. The ``response.length`` member must be set to the
+capacity of this buffer, or if no response is required, zero. Upon
+completion of the request, the call will write the response to the response
+buffer (if its capacity allows it) and overwrite the length field with the
+actual size of the response, in bytes.
+
+Additionally, if the request has a response, this should be indicated via
+the request flags, as is done with in-kernel requests. Request flags can be
+set via the ``flags`` member and the values correspond to the values found
+in |ssam_request_flags|.
+
+Finally, the status of the request itself is returned in the ``status``
+member (a negative value indicating failure). Note that failure indication
+of the IOCTL is separated from failure indication of the request: The IOCTL
+returns a negative status code if anything failed during setup of the
+request (``-EFAULT``) or if the provided argument or any of its fields are
+invalid (``-EINVAL``). In this case, the status value of the request
+argument may be set, providing more detail on what went wrong (e.g.
+``-ENOMEM`` for out-of-memory), but this value may also be zero. The IOCTL
+will return with a zero status code in case the request has been set up,
+submitted, and completed (i.e. handed back to user-space) successfully from
+inside the IOCTL, but the request ``status`` member may still be negative in
+case the actual execution of the request failed after it has been submitted.
+
+A full definition of the argument struct is provided below:
+
+.. kernel-doc:: include/uapi/linux/surface_aggregator/cdev.h
+   :functions: ssam_cdev_request
diff --git a/Documentation/driver-api/surface_aggregator/clients/index.rst b/Documentation/driver-api/surface_aggregator/clients/index.rst
index 31e026d96102..ab260ec82cfb 100644
--- a/Documentation/driver-api/surface_aggregator/clients/index.rst
+++ b/Documentation/driver-api/surface_aggregator/clients/index.rst
@@ -7,4 +7,14 @@ Client Driver Documentation
 This is the documentation for client drivers themselves. Refer to
 :doc:`../client` for documentation on how to write client drivers.
 
-.. Place documentation for individual client drivers here.
+.. toctree::
+   :maxdepth: 1
+
+   cdev
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/MAINTAINERS b/MAINTAINERS
index f0d23c113f3e..c776343a49c6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11699,7 +11699,9 @@ W:	https://github.com/linux-surface/surface-aggregator-module
 C:	irc://chat.freenode.net/##linux-surface
 F:	Documentation/driver-api/surface_aggregator/
 F:	drivers/platform/surface/aggregator/
+F:	drivers/platform/surface/surface_aggregator_cdev.c
 F:	include/linux/surface_aggregator/
+F:	include/uapi/linux/surface_aggregator/
 
 MICROTEK X6 SCANNER
 M:	Oliver Neukum <oliver@neukum.org>
diff --git a/drivers/platform/surface/Kconfig b/drivers/platform/surface/Kconfig
index 5af22f5141ff..cecad7a0cb7b 100644
--- a/drivers/platform/surface/Kconfig
+++ b/drivers/platform/surface/Kconfig
@@ -40,6 +40,23 @@ config SURFACE_3_POWER_OPREGION
 	  This driver provides support for ACPI operation
 	  region of the Surface 3 battery platform driver.
 
+config SURFACE_AGGREGATOR_CDEV
+	tristate "Surface System Aggregator Module User-Space Interface"
+	depends on SURFACE_AGGREGATOR
+	help
+	  Provides a misc-device interface to the Surface System Aggregator
+	  Module (SSAM) controller.
+
+	  This option provides a module (called surface_aggregator_cdev), that,
+	  when loaded, will add a client device (and its respective driver) to
+	  the SSAM controller. Said client device manages a misc-device
+	  interface (/dev/surface/aggregator), which can be used by user-space
+	  tools to directly communicate with the SSAM EC by sending requests and
+	  receiving the corresponding responses.
+
+	  The provided interface is intended for debugging and development only,
+	  and should not be used otherwise.
+
 config SURFACE_GPE
 	tristate "Surface GPE/Lid Support Driver"
 	depends on ACPI
diff --git a/drivers/platform/surface/Makefile b/drivers/platform/surface/Makefile
index 034134fe0264..161f0ad05795 100644
--- a/drivers/platform/surface/Makefile
+++ b/drivers/platform/surface/Makefile
@@ -8,5 +8,6 @@ obj-$(CONFIG_SURFACE3_WMI)		+= surface3-wmi.o
 obj-$(CONFIG_SURFACE_3_BUTTON)		+= surface3_button.o
 obj-$(CONFIG_SURFACE_3_POWER_OPREGION)	+= surface3_power.o
 obj-$(CONFIG_SURFACE_AGGREGATOR)	+= aggregator/
+obj-$(CONFIG_SURFACE_AGGREGATOR_CDEV)	+= surface_aggregator_cdev.o
 obj-$(CONFIG_SURFACE_GPE)		+= surface_gpe.o
 obj-$(CONFIG_SURFACE_PRO3_BUTTON)	+= surfacepro3_button.o
diff --git a/drivers/platform/surface/surface_aggregator_cdev.c b/drivers/platform/surface/surface_aggregator_cdev.c
new file mode 100644
index 000000000000..f5e81cd67357
--- /dev/null
+++ b/drivers/platform/surface/surface_aggregator_cdev.c
@@ -0,0 +1,299 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Provides user-space access to the SSAM EC via the /dev/surface/aggregator
+ * misc device. Intended for debugging and development.
+ *
+ * Copyright (C) 2020 Maximilian Luz <luzmaximilian@gmail.com>
+ */
+
+#include <linux/fs.h>
+#include <linux/kernel.h>
+#include <linux/kref.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/rwsem.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+
+#include <linux/surface_aggregator/cdev.h>
+#include <linux/surface_aggregator/controller.h>
+
+#define SSAM_CDEV_DEVICE_NAME	"surface_aggregator_cdev"
+
+struct ssam_cdev {
+	struct kref kref;
+	struct rw_semaphore lock;
+	struct ssam_controller *ctrl;
+	struct miscdevice mdev;
+};
+
+static void __ssam_cdev_release(struct kref *kref)
+{
+	kfree(container_of(kref, struct ssam_cdev, kref));
+}
+
+static struct ssam_cdev *ssam_cdev_get(struct ssam_cdev *cdev)
+{
+	if (cdev)
+		kref_get(&cdev->kref);
+
+	return cdev;
+}
+
+static void ssam_cdev_put(struct ssam_cdev *cdev)
+{
+	if (cdev)
+		kref_put(&cdev->kref, __ssam_cdev_release);
+}
+
+static int ssam_cdev_device_open(struct inode *inode, struct file *filp)
+{
+	struct miscdevice *mdev = filp->private_data;
+	struct ssam_cdev *cdev = container_of(mdev, struct ssam_cdev, mdev);
+
+	filp->private_data = ssam_cdev_get(cdev);
+	return stream_open(inode, filp);
+}
+
+static int ssam_cdev_device_release(struct inode *inode, struct file *filp)
+{
+	ssam_cdev_put(filp->private_data);
+	return 0;
+}
+
+static long ssam_cdev_request(struct ssam_cdev *cdev, unsigned long arg)
+{
+	struct ssam_cdev_request __user *r;
+	struct ssam_cdev_request rqst;
+	struct ssam_request spec;
+	struct ssam_response rsp;
+	const void __user *plddata;
+	void __user *rspdata;
+	int status = 0, ret = 0, tmp;
+
+	r = (struct ssam_cdev_request __user *)arg;
+	ret = copy_struct_from_user(&rqst, sizeof(rqst), r, sizeof(*r));
+	if (ret)
+		goto out;
+
+	plddata = u64_to_user_ptr(rqst.payload.data);
+	rspdata = u64_to_user_ptr(rqst.response.data);
+
+	// setup basic request fields
+	spec.target_category = rqst.target_category;
+	spec.target_id = rqst.target_id;
+	spec.command_id = rqst.command_id;
+	spec.instance_id = rqst.instance_id;
+	spec.flags = rqst.flags;
+	spec.length = rqst.payload.length;
+	spec.payload = NULL;
+
+	rsp.capacity = rqst.response.length;
+	rsp.length = 0;
+	rsp.pointer = NULL;
+
+	// get request payload from user-space
+	if (spec.length) {
+		if (!plddata) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		spec.payload = kzalloc(spec.length, GFP_KERNEL);
+		if (!spec.payload) {
+			status = -ENOMEM;
+			ret = -EFAULT;
+			goto out;
+		}
+
+		if (copy_from_user((void *)spec.payload, plddata, spec.length)) {
+			ret = -EFAULT;
+			goto out;
+		}
+	}
+
+	// allocate response buffer
+	if (rsp.capacity) {
+		if (!rspdata) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		rsp.pointer = kzalloc(rsp.capacity, GFP_KERNEL);
+		if (!rsp.pointer) {
+			status = -ENOMEM;
+			ret = -EFAULT;
+			goto out;
+		}
+	}
+
+	// perform request
+	status = ssam_request_sync(cdev->ctrl, &spec, &rsp);
+	if (status)
+		goto out;
+
+	// copy response to user-space
+	if (rsp.length && copy_to_user(rspdata, rsp.pointer, rsp.length))
+		ret = -EFAULT;
+
+out:
+	// always try to set response-length and status
+	tmp = put_user(rsp.length, &r->response.length);
+	if (tmp)
+		ret = tmp;
+
+	tmp = put_user(status, &r->status);
+	if (tmp)
+		ret = tmp;
+
+	// cleanup
+	kfree(spec.payload);
+	kfree(rsp.pointer);
+
+	return ret;
+}
+
+static long __ssam_cdev_device_ioctl(struct ssam_cdev *cdev, unsigned int cmd,
+				     unsigned long arg)
+{
+	switch (cmd) {
+	case SSAM_CDEV_REQUEST:
+		return ssam_cdev_request(cdev, arg);
+
+	default:
+		return -ENOTTY;
+	}
+}
+
+static long ssam_cdev_device_ioctl(struct file *file, unsigned int cmd,
+				   unsigned long arg)
+{
+	struct ssam_cdev *cdev = file->private_data;
+	long status;
+
+	// ensure that controller is valid for as long as we need it
+	if (down_read_killable(&cdev->lock))
+		return -ERESTARTSYS;
+
+	if (!cdev->ctrl) {
+		up_read(&cdev->lock);
+		return -ENODEV;
+	}
+
+	status = __ssam_cdev_device_ioctl(cdev, cmd, arg);
+
+	up_read(&cdev->lock);
+	return status;
+}
+
+static const struct file_operations ssam_controller_fops = {
+	.owner          = THIS_MODULE,
+	.open           = ssam_cdev_device_open,
+	.release        = ssam_cdev_device_release,
+	.unlocked_ioctl = ssam_cdev_device_ioctl,
+	.compat_ioctl   = ssam_cdev_device_ioctl,
+	.llseek         = noop_llseek,
+};
+
+static int ssam_dbg_device_probe(struct platform_device *pdev)
+{
+	struct ssam_controller *ctrl;
+	struct ssam_cdev *cdev;
+	int status;
+
+	status = ssam_client_bind(&pdev->dev, &ctrl);
+	if (status)
+		return status == -ENXIO ? -EPROBE_DEFER : status;
+
+	cdev = kzalloc(sizeof(*cdev), GFP_KERNEL);
+	if (!cdev)
+		return -ENOMEM;
+
+	kref_init(&cdev->kref);
+	init_rwsem(&cdev->lock);
+	cdev->ctrl = ctrl;
+
+	cdev->mdev.parent   = &pdev->dev;
+	cdev->mdev.minor    = MISC_DYNAMIC_MINOR;
+	cdev->mdev.name     = "surface_aggregator";
+	cdev->mdev.nodename = "surface/aggregator";
+	cdev->mdev.fops     = &ssam_controller_fops;
+
+	status = misc_register(&cdev->mdev);
+	if (status) {
+		kfree(cdev);
+		return status;
+	}
+
+	platform_set_drvdata(pdev, cdev);
+	return 0;
+}
+
+static int ssam_dbg_device_remove(struct platform_device *pdev)
+{
+	struct ssam_cdev *cdev = platform_get_drvdata(pdev);
+
+	misc_deregister(&cdev->mdev);
+
+	/*
+	 * The controller is only guaranteed to be valid for as long as the
+	 * driver is bound. Remove controller so that any lingering open files
+	 * cannot access it any more after we're gone.
+	 */
+	down_write(&cdev->lock);
+	cdev->ctrl = NULL;
+	up_write(&cdev->lock);
+
+	ssam_cdev_put(cdev);
+	return 0;
+}
+
+static struct platform_device *ssam_cdev_device;
+
+static struct platform_driver ssam_cdev_driver = {
+	.probe = ssam_dbg_device_probe,
+	.remove = ssam_dbg_device_remove,
+	.driver = {
+		.name = SSAM_CDEV_DEVICE_NAME,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+};
+
+static int __init ssam_debug_init(void)
+{
+	int status;
+
+	ssam_cdev_device = platform_device_alloc(SSAM_CDEV_DEVICE_NAME,
+						 PLATFORM_DEVID_NONE);
+	if (!ssam_cdev_device)
+		return -ENOMEM;
+
+	status = platform_device_add(ssam_cdev_device);
+	if (status)
+		goto err_device;
+
+	status = platform_driver_register(&ssam_cdev_driver);
+	if (status)
+		goto err_driver;
+
+	return 0;
+
+err_driver:
+	platform_device_del(ssam_cdev_device);
+err_device:
+	platform_device_put(ssam_cdev_device);
+	return status;
+}
+module_init(ssam_debug_init);
+
+static void __exit ssam_debug_exit(void)
+{
+	platform_driver_unregister(&ssam_cdev_driver);
+	platform_device_unregister(ssam_cdev_device);
+}
+module_exit(ssam_debug_exit);
+
+MODULE_AUTHOR("Maximilian Luz <luzmaximilian@gmail.com>");
+MODULE_DESCRIPTION("User-space interface for Surface System Aggregator Module");
+MODULE_LICENSE("GPL");
diff --git a/include/uapi/linux/surface_aggregator/cdev.h b/include/uapi/linux/surface_aggregator/cdev.h
new file mode 100644
index 000000000000..1a8bc0249f8e
--- /dev/null
+++ b/include/uapi/linux/surface_aggregator/cdev.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+/*
+ * Surface System Aggregator Module (SSAM) user-space EC interface.
+ *
+ * Definitions, structs, and IOCTLs for the /dev/surface/aggregator misc
+ * device. This device provides direct user-space access to the SSAM EC.
+ * Intended for debugging and development.
+ *
+ * Copyright (C) 2020 Maximilian Luz <luzmaximilian@gmail.com>
+ */
+
+#ifndef _UAPI_LINUX_SURFACE_AGGREGATOR_CDEV_H
+#define _UAPI_LINUX_SURFACE_AGGREGATOR_CDEV_H
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+/**
+ * struct ssam_cdev_request - Controller request IOCTL argument.
+ * @target_category: Target category of the SAM request.
+ * @target_id:       Target ID of the SAM request.
+ * @command_id:      Command ID of the SAM request.
+ * @instance_id:     Instance ID of the SAM request.
+ * @flags:           SAM Request flags.
+ * @status:          Request status (output).
+ * @payload:         Request payload (input data).
+ * @payload.data:    Pointer to request payload data.
+ * @payload.length:  Length of request payload data (in bytes).
+ * @response:        Request response (output data).
+ * @response.data:   Pointer to response buffer.
+ * @response.length: On input: Capacity of response buffer (in bytes).
+ *                   On output: Length of request response (number of bytes
+ *                   in the buffer that are actually used).
+ */
+struct ssam_cdev_request {
+	__u8 target_category;
+	__u8 target_id;
+	__u8 command_id;
+	__u8 instance_id;
+	__u16 flags;
+	__s16 status;
+
+	struct {
+		__u64 data;
+		__u16 length;
+		__u8 __pad[6];
+	} payload;
+
+	struct {
+		__u64 data;
+		__u16 length;
+		__u8 __pad[6];
+	} response;
+} __attribute__((__packed__));
+
+#define SSAM_CDEV_REQUEST	_IOWR(0xA5, 1, struct ssam_cdev_request)
+
+#endif /* _UAPI_LINUX_SURFACE_AGGREGATOR_CDEV_H */
-- 
2.29.2

