Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D175275B4A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 17:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgIWPQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 11:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgIWPP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 11:15:56 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737C5C0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 08:15:56 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id g4so211466edk.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 08:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NLwbmPsSRSxX4yEwCfDu+CPVaTLAXTg2BqCi+vMpMt4=;
        b=O70V1yi0Y7iA6BlPWb2gGRrD+hZzje4WgDddHObDH+azyVRFfB7i2t3rhO0W9ZIc4H
         y/NSi1jKXYNGgM2y87upKJSGyW+Z+tgq/NozccvSvuZXM0gbecQD3CJOXu0jg13tVc+1
         u7QrnzJrmIs6y3AKaTwpaAOgyseeC2AWQB6dfSckAZtXOI2PG377zoj73m9Ih94ccVcv
         ac9QSCW6T7t0e9CzHBfJYc5C1LUB4TAJHK6W9Fy5MGNIVyIRXCbixmxyBk28W8paNVz1
         wW/VptJw/lyXMbnFJJnk/baoq3sD+k9oQwG/6kEN2AgI2vjUe4D9HSiNDnNcEXZy9wgT
         Yb3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NLwbmPsSRSxX4yEwCfDu+CPVaTLAXTg2BqCi+vMpMt4=;
        b=Z0PrRdhg5d7CwazarEMipg8+CbSP2C9g268jRJDZ+xWHvQ1ZLjp5WfUbOoXAYyAfrv
         zt9a1qRJK4eixz8d9DhL4KORUrbmW4mO3Ka6Nv7VYElZ/J14eGJMty1zEi5KWDKdlUIJ
         SfXnCCrHpPQgdpjJxIGWc62YM0RuDwg5pVPMW6Ycty45AgJ5C87pmSyt/S3jF7LC75Mr
         jGQBo5PWpCfy6CK85qpEP4bvY2ClOe2Ua3OVcMygPnpvshN3htIzqionTULntDYZ+EtQ
         vCaTaCBDtZ8kBDOrfpl/XW/MSGiGlEFjm/kMWykI4tcmWf82uWOB7OJZzJZsFN/bDOcK
         JByQ==
X-Gm-Message-State: AOAM533mHPHG4iOk8y12paJyFKTUcbAYTk7t/DxrGgB/4GBBJxO0FhlK
        lCqSFnxjDRPYnAjbYvRCeN5jn05J/J0=
X-Google-Smtp-Source: ABdhPJz0suAKJ0P1Zf5Gii8WICRnUiYQyR/O0sIaRg+2Qa1tWrzFWiBU9GAscO1ZukkhYbiBSa4a5A==
X-Received: by 2002:aa7:dcc6:: with SMTP id w6mr10333475edu.10.1600874154353;
        Wed, 23 Sep 2020 08:15:54 -0700 (PDT)
Received: from xws.fritz.box (pd9e5a9df.dip0.t-ipconnect.de. [217.229.169.223])
        by smtp.gmail.com with ESMTPSA id ch29sm160707edb.74.2020.09.23.08.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 08:15:53 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Bla=C5=BE=20Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>
Subject: [RFC PATCH 8/9] surface_aggregator: Add DebugFS interface
Date:   Wed, 23 Sep 2020 17:15:10 +0200
Message-Id: <20200923151511.3842150-9-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200923151511.3842150-1-luzmaximilian@gmail.com>
References: <20200923151511.3842150-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a DebugFS device-file providing user-space access to the Surface
Aggregator EC, intended for debugging, testing, and reverse-engineering.
Specifically, this interface gives user-space applications the ability
to send requests to the EC and receive the corresponding responses.

The device-file is managed by a pseudo platform-device and corresponding
driver to avoid dependence on the dedicated bus, allowing it to be
loaded in a minimal configuration.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 .../surface_aggregator/clients/dbgdev.rst     | 130 ++++++++
 .../surface_aggregator/clients/index.rst      |  12 +-
 drivers/misc/surface_aggregator/Kconfig       |   2 +
 drivers/misc/surface_aggregator/Makefile      |   1 +
 .../misc/surface_aggregator/clients/Kconfig   |  18 ++
 .../misc/surface_aggregator/clients/Makefile  |   3 +
 .../clients/surface_aggregator_debugfs.c      | 281 ++++++++++++++++++
 7 files changed, 446 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/driver-api/surface_aggregator/clients/dbgdev.rst
 create mode 100644 drivers/misc/surface_aggregator/clients/Kconfig
 create mode 100644 drivers/misc/surface_aggregator/clients/Makefile
 create mode 100644 drivers/misc/surface_aggregator/clients/surface_aggregator_debugfs.c

diff --git a/Documentation/driver-api/surface_aggregator/clients/dbgdev.rst b/Documentation/driver-api/surface_aggregator/clients/dbgdev.rst
new file mode 100644
index 000000000000..e45d7e7fd13f
--- /dev/null
+++ b/Documentation/driver-api/surface_aggregator/clients/dbgdev.rst
@@ -0,0 +1,130 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. |u8| replace:: :c:type:`u8 <u8>`
+.. |u16| replace:: :c:type:`u16 <u16>`
+.. |ssam_dbg_request| replace:: :c:type:`struct ssam_dbg_request <ssam_dbg_request>`
+.. |ssam_request_flags| replace:: :c:type:`enum ssam_request_flags <ssam_request_flags>`
+
+=======================================
+SSAM Debug Device and DebugFS Interface
+=======================================
+
+The ``surface_aggregator_debugfs`` module provides a DebugFS interface for
+the SSAM controller to allow for a (more or less) direct connection from
+userspace to the SAM EC. It is intended to be used for development and
+debugging, and therefore should not be used or relied upon in any other way.
+Note that this module is not loaded automatically, but instead must be
+loaded manually.
+
+The provided interface is accessible through the
+``surface_aggregator/controller`` device-file in debugfs, so, if the
+conventional mount path is being used,
+``/sys/kernel/debug/surface_aggregator/controller``. All functionality of
+this interface is provided via IOCTLs.
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
+     - ``0``
+     - ``R``
+     - ``GETVERSION``
+     - Get DebugFS controller interface version.
+
+   * - ``0xA5``
+     - ``1``
+     - ``WR``
+     - ``REQUEST``
+     - Perform synchronous SAM request.
+
+
+``GETVERSION``
+--------------
+
+Defined as ``_IOR(0xA5, 0, __u32)``.
+
+Gets the current interface version. This should be used to check for changes
+in the interface and determine if certain functionality is available. While
+the interface should under normal circumstances kept backward compatible, as
+this is a debug interface, backwards compatibility is not guaranteed.
+
+The version number follows the semantic versioning scheme, roughly meaning
+that an increment in the highest non-zero version number signals a breaking
+change. It can be decomposed as follows:
+
+.. flat-table:: Version Number Format
+   :widths: 2 1 3
+   :header-rows: 1
+
+   * - Offset (bytes)
+     - Type
+     - Description
+
+   * - ``0``
+     - |u8|
+     - Major
+
+   * - ``1``
+     - |u8|
+     - Minor
+
+   * - ``2``
+     - |u16|
+     - Patch
+
+The interface version is currently ``0.1.0``, i.e. ``0x00010000``.
+
+
+``REQUEST``
+-----------
+
+Defined as ``_IOWR(0xA5, 1, struct ssam_dbg_request)``.
+
+Executes a synchronous SAM request. The request specification is passed in
+as argument of type |ssam_dbg_request|, which is then written to/modified
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
+.. kernel-doc:: drivers/misc/surface_aggregator/clients/surface_aggregator_debugfs.c
+   :functions: ssam_dbg_request
diff --git a/Documentation/driver-api/surface_aggregator/clients/index.rst b/Documentation/driver-api/surface_aggregator/clients/index.rst
index 680fa621dc9f..e47b752f298c 100644
--- a/Documentation/driver-api/surface_aggregator/clients/index.rst
+++ b/Documentation/driver-api/surface_aggregator/clients/index.rst
@@ -7,4 +7,14 @@ Client Driver Documentation
 This is the documentation for client drivers themselves. Refer to
 :doc:`../client` for documentation on how to write client drivers.
 
-.. Place documentation for individual client drivers here.
+.. toctree::
+   :maxdepth: 1
+
+   dbgdev
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/drivers/misc/surface_aggregator/Kconfig b/drivers/misc/surface_aggregator/Kconfig
index 4d6fc3cd18aa..e0a9bb37d178 100644
--- a/drivers/misc/surface_aggregator/Kconfig
+++ b/drivers/misc/surface_aggregator/Kconfig
@@ -61,3 +61,5 @@ config SURFACE_AGGREGATOR_ERROR_INJECTION
 	  transport and communication problems, such as invalid data sent to or
 	  received from the EC, dropped data, and communication timeouts.
 	  Intended for development and debugging.
+
+source "drivers/misc/surface_aggregator/clients/Kconfig"
diff --git a/drivers/misc/surface_aggregator/Makefile b/drivers/misc/surface_aggregator/Makefile
index 59041511c04b..acf42597e6bb 100644
--- a/drivers/misc/surface_aggregator/Makefile
+++ b/drivers/misc/surface_aggregator/Makefile
@@ -4,6 +4,7 @@
 CFLAGS_core.o = -I$(src)
 
 obj-$(CONFIG_SURFACE_AGGREGATOR) += surface_aggregator.o
+obj-$(CONFIG_SURFACE_AGGREGATOR) += clients/
 
 surface_aggregator-objs := core.o
 surface_aggregator-objs += ssh_parser.o
diff --git a/drivers/misc/surface_aggregator/clients/Kconfig b/drivers/misc/surface_aggregator/clients/Kconfig
new file mode 100644
index 000000000000..dcaa0706074e
--- /dev/null
+++ b/drivers/misc/surface_aggregator/clients/Kconfig
@@ -0,0 +1,18 @@
+config SURFACE_AGGREGATOR_DEBUGFS
+	tristate "Surface System Aggregator Module DebugFS interface"
+	depends on SURFACE_AGGREGATOR
+	depends on DEBUG_FS
+	default n
+	help
+	  Provides a DebugFS interface to the Surface System Aggregator Module
+	  (SSAM) controller.
+
+	  This option provides a module (called surface_aggregator_debugfs),
+	  that, when loaded, will add a client device (and its respective
+	  driver) to the SSAM controller. Said client device manages a DebugFS
+	  interface (/sys/kernel/debug/surface_aggregator/controller), which can
+	  be used by user-space tools to directly communicate with the SSAM EC
+	  by sending requests and receiving the correspondign responses.
+
+	  The provided interface is intended for debugging and development only,
+	  and should not be used otherwise.
diff --git a/drivers/misc/surface_aggregator/clients/Makefile b/drivers/misc/surface_aggregator/clients/Makefile
new file mode 100644
index 000000000000..c49b2a183d3d
--- /dev/null
+++ b/drivers/misc/surface_aggregator/clients/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+obj-$(CONFIG_SURFACE_AGGREGATOR_DEBUGFS)	+= surface_aggregator_debugfs.o
diff --git a/drivers/misc/surface_aggregator/clients/surface_aggregator_debugfs.c b/drivers/misc/surface_aggregator/clients/surface_aggregator_debugfs.c
new file mode 100644
index 000000000000..b96ecb7c153a
--- /dev/null
+++ b/drivers/misc/surface_aggregator/clients/surface_aggregator_debugfs.c
@@ -0,0 +1,281 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * DebugFS interface for Surface System Aggregator Module (SSAM) controller
+ * access from user-space. Intended for debugging and development.
+ */
+
+#include <linux/debugfs.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+
+#include <linux/surface_aggregator/controller.h>
+
+#define SSAM_DBG_DEVICE_NAME		"surface_aggregator_dbg"
+#define SSAM_DBG_IF_VERSION		0x010000
+
+/**
+ * struct ssam_debug_request - Controller request IOCTL argument.
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
+struct ssam_dbg_request {
+	__u8 target_category;
+	__u8 target_id;
+	__u8 command_id;
+	__u8 instance_id;
+	__u16 flags;
+	__s16 status;
+
+	struct {
+		const __u8 __user *data;
+		__u16 length;
+		__u8 __pad[6];
+	} payload;
+
+	struct {
+		__u8 __user *data;
+		__u16 length;
+		__u8 __pad[6];
+	} response;
+};
+
+#define SSAM_DBG_IOCTL_GETVERSION  _IOR(0xA5, 0, __u32)
+#define SSAM_DBG_IOCTL_REQUEST     _IOWR(0xA5, 1, struct ssam_dbg_request)
+
+struct ssam_dbg_data {
+	struct ssam_controller *ctrl;
+	struct dentry *dentry_dir;
+	struct dentry *dentry_dev;
+};
+
+static int ssam_dbg_device_open(struct inode *inode, struct file *filp)
+{
+	filp->private_data = inode->i_private;
+	return nonseekable_open(inode, filp);
+}
+
+static long ssam_dbg_if_request(struct file *file, unsigned long arg)
+{
+	struct ssam_dbg_data *data = file->private_data;
+	struct ssam_dbg_request __user *r;
+	struct ssam_dbg_request rqst;
+	struct ssam_request spec;
+	struct ssam_response rsp;
+	int status = 0, ret = 0, tmp;
+
+	r = (struct ssam_dbg_request __user *)arg;
+	ret = copy_struct_from_user(&rqst, sizeof(rqst), r, sizeof(*r));
+	if (ret)
+		goto out;
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
+		if (!rqst.payload.data) {
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
+		if (copy_from_user((void *)spec.payload, rqst.payload.data,
+				   spec.length)) {
+			ret = -EFAULT;
+			goto out;
+		}
+	}
+
+	// allocate response buffer
+	if (rsp.capacity) {
+		if (!rqst.response.data) {
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
+	status = ssam_request_sync(data->ctrl, &spec, &rsp);
+	if (status)
+		goto out;
+
+	// copy response to user-space
+	if (rsp.length) {
+		if (copy_to_user(rqst.response.data, rsp.pointer, rsp.length)) {
+			ret = -EFAULT;
+			goto out;
+		}
+	}
+
+out:
+	// always try to set response-length and status
+	tmp = put_user(rsp.length, &r->response.length);
+	if (!ret)
+		ret = tmp;
+
+	tmp = put_user(status, &r->status);
+	if (!ret)
+		ret = tmp;
+
+	// cleanup
+	kfree(spec.payload);
+	kfree(rsp.pointer);
+
+	return ret;
+}
+
+static long ssam_dbg_if_getversion(struct file *file, unsigned long arg)
+{
+	put_user(SSAM_DBG_IF_VERSION, (u32 __user *)arg);
+	return 0;
+}
+
+static long ssam_dbg_device_ioctl(struct file *file, unsigned int cmd,
+				    unsigned long arg)
+{
+	switch (cmd) {
+	case SSAM_DBG_IOCTL_GETVERSION:
+		return ssam_dbg_if_getversion(file, arg);
+
+	case SSAM_DBG_IOCTL_REQUEST:
+		return ssam_dbg_if_request(file, arg);
+
+	default:
+		return -ENOIOCTLCMD;
+	}
+}
+
+const struct file_operations ssam_dbg_device_fops = {
+	.owner          = THIS_MODULE,
+	.open           = ssam_dbg_device_open,
+	.unlocked_ioctl = ssam_dbg_device_ioctl,
+	.compat_ioctl   = ssam_dbg_device_ioctl,
+	.llseek         = noop_llseek,
+};
+
+static int ssam_dbg_device_probe(struct platform_device *pdev)
+{
+	struct ssam_dbg_data *data;
+	struct ssam_controller *ctrl;
+	int status;
+
+	status = ssam_client_bind(&pdev->dev, &ctrl);
+	if (status)
+		return status == -ENXIO ? -EPROBE_DEFER : status;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->ctrl = ctrl;
+
+	data->dentry_dir = debugfs_create_dir("surface_aggregator", NULL);
+	if (IS_ERR(data->dentry_dir))
+		return PTR_ERR(data->dentry_dir);
+
+	data->dentry_dev = debugfs_create_file("controller", 0600,
+					       data->dentry_dir, data,
+					       &ssam_dbg_device_fops);
+	if (IS_ERR(data->dentry_dev)) {
+		debugfs_remove(data->dentry_dir);
+		return PTR_ERR(data->dentry_dev);
+	}
+
+	platform_set_drvdata(pdev, data);
+	return 0;
+}
+
+static int ssam_dbg_device_remove(struct platform_device *pdev)
+{
+	struct ssam_dbg_data *data = platform_get_drvdata(pdev);
+
+	debugfs_remove(data->dentry_dev);
+	debugfs_remove(data->dentry_dir);
+
+	return 0;
+}
+
+static void ssam_dbg_device_release(struct device *dev)
+{
+	// nothing to do
+}
+
+static struct platform_device ssam_dbg_device = {
+	.name = SSAM_DBG_DEVICE_NAME,
+	.id = PLATFORM_DEVID_NONE,
+	.dev.release = ssam_dbg_device_release,
+};
+
+static struct platform_driver ssam_dbg_driver = {
+	.probe = ssam_dbg_device_probe,
+	.remove = ssam_dbg_device_remove,
+	.driver = {
+		.name = SSAM_DBG_DEVICE_NAME,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+};
+
+static int __init ssam_debug_init(void)
+{
+	int status;
+
+	status = platform_device_register(&ssam_dbg_device);
+	if (status)
+		return status;
+
+	status = platform_driver_register(&ssam_dbg_driver);
+	if (status)
+		platform_device_unregister(&ssam_dbg_device);
+
+	return status;
+}
+module_init(ssam_debug_init);
+
+static void __exit ssam_debug_exit(void)
+{
+	platform_driver_unregister(&ssam_dbg_driver);
+	platform_device_unregister(&ssam_dbg_device);
+}
+module_exit(ssam_debug_exit);
+
+MODULE_AUTHOR("Maximilian Luz <luzmaximilian@gmail.com>");
+MODULE_DESCRIPTION("DebugFS interface for Surface System Aggregator Module");
+MODULE_LICENSE("GPL");
-- 
2.28.0

