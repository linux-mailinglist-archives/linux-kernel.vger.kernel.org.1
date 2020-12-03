Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0B12CE0B5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 22:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389375AbgLCV2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 16:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728620AbgLCV2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 16:28:24 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8FFC08E85E;
        Thu,  3 Dec 2020 13:27:15 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id r5so3641340eda.12;
        Thu, 03 Dec 2020 13:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=10GI+aiiTV3t0eUPgTJ/ppJ8mprRdXu/OHD4oe5tDb4=;
        b=vSrP2G6D0amfG5kszQAL8UwcnBho4fTlevr2KFXdB7l7gpTSINHCjUmjXwm1ydAEZY
         M6fU9hzpHq7oXsPH6oOKhuUx3/wZQIHNs1aE/Ksz9WHFAMN+KRupn2XlOBjcQmhU2zf4
         +pDRFvScypqkYjqvgcRqEP/iJKzBI//26XnoUCuUoludn5JOCvBqlCDxQABWinP2R+5C
         jjcQEqDoOyfooKZIjMmIEHkc6fIhExK3UnC7ye7jdnD3gf/ufgBqGFXfIR2N2pLEArHN
         /gCHamCc/wWLm4bZXuCn/vjadven0ZUAgHWmsOtwkfvBaSyHgOh2EYWSpT0IXvTsmClA
         K7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=10GI+aiiTV3t0eUPgTJ/ppJ8mprRdXu/OHD4oe5tDb4=;
        b=ONMQJnj63xhWlFjeYqkrt/rQOXIbQcFnnp2rPJ9GrXZbm4kK/IwlJ9SdG6l7B+9AH2
         EUHDALn20dRursmNPSkOjTBA+2lgb8VJ6wiRgMbD3Cx9ZdYpz0FHJcQLcN9GetbQhc+h
         PhxPxFHuScdSoXj9b19cTskLMR4hNYI8a8d1S/NOsbaguVaxJNMz7mQotfgIvLirTNIr
         rzO2cB2zgoKjN7Xd1GcU3LK5CjsTsRhTwGoLLLhD+A1B0g3y9SueRZENDurQgAxVGg8e
         Nps1DKOyiZUcTc+iQ9xXcHtNBYSK4UeWwSuOHcSQvYUKnCBanwzLDPqsQUjMygV93v2q
         s+cw==
X-Gm-Message-State: AOAM533EJfl3Up5Hb6DvxIqRLdXpUb6WmpV0kuhOgj14B0TXNeIH/Avu
        C0CvHAjmV0U/yM8k3g8r1/JrzsqI/mY=
X-Google-Smtp-Source: ABdhPJxCj/ZnG5toLj+q4saLic2Hm6Sw42NR28VlUQO6s2ExkgEx7M2xdoT5cBiQWbJ2FCvY4sgZGA==
X-Received: by 2002:a50:e786:: with SMTP id b6mr4560553edn.242.1607030832894;
        Thu, 03 Dec 2020 13:27:12 -0800 (PST)
Received: from xws.fritz.box (pd9e5a6ef.dip0.t-ipconnect.de. [217.229.166.239])
        by smtp.gmail.com with ESMTPSA id e3sm1656169ejq.96.2020.12.03.13.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 13:27:12 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?q?Barnab=C3=A1s=20P=C5=91cze?= <pobrn@protonmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?Bla=C5=BE=20Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>,
        platform-driver-x86@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v2 8/9] platform/surface: Add Surface Aggregator user-space interface
Date:   Thu,  3 Dec 2020 22:26:39 +0100
Message-Id: <20201203212640.663931-9-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201203212640.663931-1-luzmaximilian@gmail.com>
References: <20201203212640.663931-1-luzmaximilian@gmail.com>
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

Changes in v1 (from RFC):
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

Changes in v2:
 - add ioctl-number.rst entry
 - improve documentation
 - spell check comments and strings, fix typos
 - unify comment style
 - run checkpatch --strict, fix warnings and style issues

---
 .../surface_aggregator/clients/cdev.rst       |  85 +++++
 .../surface_aggregator/clients/index.rst      |  12 +-
 .../userspace-api/ioctl/ioctl-number.rst      |   2 +
 MAINTAINERS                                   |   2 +
 drivers/platform/surface/Kconfig              |  17 +
 drivers/platform/surface/Makefile             |   1 +
 .../surface/surface_aggregator_cdev.c         | 299 ++++++++++++++++++
 include/uapi/linux/surface_aggregator/cdev.h  |  58 ++++
 8 files changed, 475 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/driver-api/surface_aggregator/clients/cdev.rst
 create mode 100644 drivers/platform/surface/surface_aggregator_cdev.c
 create mode 100644 include/uapi/linux/surface_aggregator/cdev.h

diff --git a/Documentation/driver-api/surface_aggregator/clients/cdev.rst b/Documentation/driver-api/surface_aggregator/clients/cdev.rst
new file mode 100644
index 000000000000..f30e77def838
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
+Additionally, if the request has a response, this must be indicated via the
+request flags, as is done with in-kernel requests. Request flags can be set
+via the ``flags`` member and the values correspond to the values found in
+|ssam_request_flags|.
+
+Finally, the status of the request itself is returned in the ``status``
+member (a negative errno value indicating failure). Note that failure
+indication of the IOCTL is separated from failure indication of the request:
+The IOCTL returns a negative status code if anything failed during setup of
+the request (``-EFAULT``) or if the provided argument or any of its fields
+are invalid (``-EINVAL``). In this case, the status value of the request
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
diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 55a2d9b2ce33..a98895da62b3 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -323,6 +323,8 @@ Code  Seq#    Include File                                           Comments
                                                                      <mailto:tlewis@mindspring.com>
 0xA3  90-9F  linux/dtlk.h
 0xA4  00-1F  uapi/linux/tee.h                                        Generic TEE subsystem
+0xA5  01     linux/surface_aggregator/cdev.h                         Microsoft Surface Platform System Aggregator
+                                                                     <mailto:luzmaximilian@gmail.com>
 0xAA  00-3F  linux/uapi/linux/userfaultfd.h
 0xAB  00-1F  linux/nbd.h
 0xAC  00-1F  linux/raw.h
diff --git a/MAINTAINERS b/MAINTAINERS
index ff5d60875cec..f5a788f445a4 100644
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
index 000000000000..40c30627f33a
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
+	/* Setup basic request fields. */
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
+	/* Get request payload from user-space. */
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
+	/* Allocate response buffer. */
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
+	/* Perform request. */
+	status = ssam_request_sync(cdev->ctrl, &spec, &rsp);
+	if (status)
+		goto out;
+
+	/* Copy response to user-space. */
+	if (rsp.length && copy_to_user(rspdata, rsp.pointer, rsp.length))
+		ret = -EFAULT;
+
+out:
+	/* Always try to set response-length and status. */
+	tmp = put_user(rsp.length, &r->response.length);
+	if (tmp)
+		ret = tmp;
+
+	tmp = put_user(status, &r->status);
+	if (tmp)
+		ret = tmp;
+
+	/* Cleanup. */
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
+	/* Ensure that controller is valid for as long as we need it. */
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
+	ctrl = ssam_client_bind(&pdev->dev);
+	if (IS_ERR(ctrl))
+		return PTR_ERR(ctrl) == -ENODEV ? -EPROBE_DEFER : PTR_ERR(ctrl);
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

