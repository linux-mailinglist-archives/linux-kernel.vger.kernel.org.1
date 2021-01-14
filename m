Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 941812F66FD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbhANRJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbhANRJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:09:18 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEE9C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:08:37 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id by1so2872408ejc.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yp77GXqTzeUihsms8VE1mAgC49XpIOstR8gxSHm4ZPw=;
        b=trTDoGzfiBFVtEms+ACV8Xymwir98OGsR2oihPNj+o/6N/QGkexDLLcFMugpRiVir3
         1wiiYIXhc/2f/vbx3Midr5JfqaBaj/J7IkgHztBxSoZp+dclZboJ7hq6j+dzgqSggo/W
         eSfmwlpzcTivW5xPcyv4kwXkN3tD6AbzFv0v8wK4EPExA6hJ+JAtn8J13f6hvE4o9hIv
         blXPanWAK3nRo8LcJOipTxKCWTZNX8T51JiHhQlUHl2iQ/5/xWaos89vOcQ9pZ1+CbSP
         3wdTuRxvpnSZ5EQXnxmYpPU7nPFnhHwVRsF2x3itpsOrYTWmw4Z9I6SyzxrioCIO/wqT
         Q5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yp77GXqTzeUihsms8VE1mAgC49XpIOstR8gxSHm4ZPw=;
        b=YkTuFmdtpROexN85OtzFroS1A0C9gvPCW0NxsYDb4NcYjwSZTysYjY+SnmrMRW/fvC
         Q4gqltxQpds07jYNzTHy87O5CNOnPJPqYiY6CtwcZwNuU8MMe5dIizuBAxYQnNnkYZ10
         KEZMbZDikkKtr+wZxUMD5OADXoXpf2JaF06M8mVznJpd4BYDtpBqV/rf0EWUIwsuTJrM
         l5054FIYsCmiWdC9zac51n/GfnQPlwFcJY+fgrPg8zQGIeD4FqpPTc64apz0P9VTg7yz
         fyQ2TyMD1+lBU1jXC6Bfw3+xxrEVPUdNuatTjER8OvOvL+OF2elcnbzS7tTRdnxg2mBu
         mCXg==
X-Gm-Message-State: AOAM531tck79Qo1FhTN5UsFWd3tfMKweu3tdJqwy/GQTaZlWCPPj1FNY
        2BghBcjw5+TjGjzNoe/X38E=
X-Google-Smtp-Source: ABdhPJyBpVSVn82CG0/nX6t/RJ+CId7JoTwoq/XQkfnsVsk9hY3rj7dLrwC5xdWb9uY2ESFyOfKwAQ==
X-Received: by 2002:a17:906:b1c8:: with SMTP id bv8mr6096652ejb.208.1610644115844;
        Thu, 14 Jan 2021 09:08:35 -0800 (PST)
Received: from yoga-910.localhost (5-12-227-87.residential.rdsnet.ro. [5.12.227.87])
        by smtp.gmail.com with ESMTPSA id be6sm2397644edb.29.2021.01.14.09.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 09:08:35 -0800 (PST)
From:   Ioana Ciornei <ciorneiioana@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     laurentiu.tudor@nxp.com, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 3/5] bus: fsl-mc: add fsl-mc userspace support
Date:   Thu, 14 Jan 2021 19:07:50 +0200
Message-Id: <20210114170752.2927915-4-ciorneiioana@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210114170752.2927915-1-ciorneiioana@gmail.com>
References: <20210114170752.2927915-1-ciorneiioana@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ioana Ciornei <ioana.ciornei@nxp.com>

Adding userspace support for the MC (Management Complex) means exporting
an ioctl capable device file representing the root resource container.

This new functionality in the fsl-mc bus driver intends to provide
userspace applications an interface to interact with the MC firmware.

Commands that are composed in userspace are sent to the MC firmware
through the FSL_MC_SEND_MC_COMMAND ioctl.  By default the implicit MC
I/O portal is used for this operation, but if the implicit one is busy,
a dynamic portal is allocated and then freed upon execution.

The command received through the ioctl interface is checked against a
known whitelist of accepted MC commands. Commands that attempt a change
in hardware configuration will need CAP_NET_ADMIN, while commands used
in debugging do not need it.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 drivers/bus/fsl-mc/Kconfig                    |   7 +
 drivers/bus/fsl-mc/Makefile                   |   3 +
 drivers/bus/fsl-mc/dprc-driver.c              |  12 +
 drivers/bus/fsl-mc/fsl-mc-private.h           |  39 ++
 drivers/bus/fsl-mc/fsl-mc-uapi.c              | 547 ++++++++++++++++++
 include/uapi/linux/fsl_mc.h                   |   9 +
 7 files changed, 618 insertions(+)
 create mode 100644 drivers/bus/fsl-mc/fsl-mc-uapi.c

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index a4c75a28c839..19d730f9d136 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -180,6 +180,7 @@ Code  Seq#    Include File                                           Comments
 'R'   00-1F  linux/random.h                                          conflict!
 'R'   01     linux/rfkill.h                                          conflict!
 'R'   C0-DF  net/bluetooth/rfcomm.h
+'R'   E0     uapi/linux/fsl_mc.h
 'S'   all    linux/cdrom.h                                           conflict!
 'S'   80-81  scsi/scsi_ioctl.h                                       conflict!
 'S'   82-FF  scsi/scsi.h                                             conflict!
diff --git a/drivers/bus/fsl-mc/Kconfig b/drivers/bus/fsl-mc/Kconfig
index c23c77c9b705..b1fd55901c50 100644
--- a/drivers/bus/fsl-mc/Kconfig
+++ b/drivers/bus/fsl-mc/Kconfig
@@ -14,3 +14,10 @@ config FSL_MC_BUS
 	  architecture.  The fsl-mc bus driver handles discovery of
 	  DPAA2 objects (which are represented as Linux devices) and
 	  binding objects to drivers.
+
+config FSL_MC_UAPI_SUPPORT
+	bool "Management Complex (MC) userspace support"
+	depends on FSL_MC_BUS
+	help
+	  Provides userspace support for interrogating, creating, destroying or
+	  configuring DPAA2 objects exported by the Management Complex.
diff --git a/drivers/bus/fsl-mc/Makefile b/drivers/bus/fsl-mc/Makefile
index 3c518c7e8374..4ae292a30e53 100644
--- a/drivers/bus/fsl-mc/Makefile
+++ b/drivers/bus/fsl-mc/Makefile
@@ -16,3 +16,6 @@ mc-bus-driver-objs := fsl-mc-bus.o \
 		      fsl-mc-allocator.o \
 		      fsl-mc-msi.o \
 		      dpmcp.o
+
+# MC userspace support
+obj-$(CONFIG_FSL_MC_UAPI_SUPPORT) += fsl-mc-uapi.o
diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-driver.c
index 68488a7ad0d6..ccec375095f2 100644
--- a/drivers/bus/fsl-mc/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -603,6 +603,7 @@ int dprc_setup(struct fsl_mc_device *mc_dev)
 	struct irq_domain *mc_msi_domain;
 	bool mc_io_created = false;
 	bool msi_domain_set = false;
+	bool uapi_created = false;
 	u16 major_ver, minor_ver;
 	size_t region_size;
 	int error;
@@ -635,6 +636,11 @@ int dprc_setup(struct fsl_mc_device *mc_dev)
 			return error;
 
 		mc_io_created = true;
+	} else {
+		error = fsl_mc_uapi_create_device_file(mc_bus);
+		if (error < 0)
+			return -EPROBE_DEFER;
+		uapi_created = true;
 	}
 
 	mc_msi_domain = fsl_mc_find_msi_domain(&mc_dev->dev);
@@ -692,6 +698,9 @@ int dprc_setup(struct fsl_mc_device *mc_dev)
 		mc_dev->mc_io = NULL;
 	}
 
+	if (uapi_created)
+		fsl_mc_uapi_remove_device_file(mc_bus);
+
 	return error;
 }
 EXPORT_SYMBOL_GPL(dprc_setup);
@@ -763,6 +772,7 @@ static void dprc_teardown_irq(struct fsl_mc_device *mc_dev)
 
 int dprc_cleanup(struct fsl_mc_device *mc_dev)
 {
+	struct fsl_mc_bus *mc_bus = to_fsl_mc_bus(mc_dev);
 	int error;
 
 	/* this function should be called only for DPRCs, it
@@ -793,6 +803,8 @@ int dprc_cleanup(struct fsl_mc_device *mc_dev)
 	if (!fsl_mc_is_root_dprc(&mc_dev->dev)) {
 		fsl_destroy_mc_io(mc_dev->mc_io);
 		mc_dev->mc_io = NULL;
+	} else {
+		fsl_mc_uapi_remove_device_file(mc_bus);
 	}
 
 	return 0;
diff --git a/drivers/bus/fsl-mc/fsl-mc-private.h b/drivers/bus/fsl-mc/fsl-mc-private.h
index be686c363121..6293a24de456 100644
--- a/drivers/bus/fsl-mc/fsl-mc-private.h
+++ b/drivers/bus/fsl-mc/fsl-mc-private.h
@@ -10,6 +10,8 @@
 
 #include <linux/fsl/mc.h>
 #include <linux/mutex.h>
+#include <linux/ioctl.h>
+#include <linux/miscdevice.h>
 
 /*
  * Data Path Management Complex (DPMNG) General API
@@ -542,6 +544,22 @@ struct fsl_mc_resource_pool {
 	struct fsl_mc_bus *mc_bus;
 };
 
+/**
+ * struct fsl_mc_uapi - information associated with a device file
+ * @misc: struct miscdevice linked to the root dprc
+ * @device: newly created device in /dev
+ * @mutex: mutex lock to serialize the open/release operations
+ * @local_instance_in_use: local MC I/O instance in use or not
+ * @static_mc_io: pointer to the static MC I/O object
+ */
+struct fsl_mc_uapi {
+	struct miscdevice misc;
+	struct device *device;
+	struct mutex mutex; /* serialize open/release operations */
+	u32 local_instance_in_use;
+	struct fsl_mc_io *static_mc_io;
+};
+
 /**
  * struct fsl_mc_bus - logical bus that corresponds to a physical DPRC
  * @mc_dev: fsl-mc device for the bus device itself.
@@ -551,6 +569,7 @@ struct fsl_mc_resource_pool {
  * @irq_resources: Pointer to array of IRQ objects for the IRQ pool
  * @scan_mutex: Serializes bus scanning
  * @dprc_attr: DPRC attributes
+ * @uapi_misc: struct that abstracts the interaction with userspace
  */
 struct fsl_mc_bus {
 	struct fsl_mc_device mc_dev;
@@ -558,6 +577,7 @@ struct fsl_mc_bus {
 	struct fsl_mc_device_irq *irq_resources;
 	struct mutex scan_mutex;    /* serializes bus scanning */
 	struct dprc_attributes dprc_attr;
+	struct fsl_mc_uapi uapi_misc;
 };
 
 #define to_fsl_mc_bus(_mc_dev) \
@@ -614,4 +634,23 @@ struct fsl_mc_device *fsl_mc_device_lookup(struct fsl_mc_obj_desc *obj_desc,
 
 u16 mc_cmd_hdr_read_cmdid(struct fsl_mc_command *cmd);
 
+#ifdef CONFIG_FSL_MC_UAPI_SUPPORT
+
+int fsl_mc_uapi_create_device_file(struct fsl_mc_bus *mc_bus);
+
+void fsl_mc_uapi_remove_device_file(struct fsl_mc_bus *mc_bus);
+
+#else
+
+static inline int fsl_mc_uapi_create_device_file(struct fsl_mc_bus *mc_bus)
+{
+	return 0;
+}
+
+static inline void fsl_mc_uapi_remove_device_file(struct fsl_mc_bus *mc_bus)
+{
+}
+
+#endif
+
 #endif /* _FSL_MC_PRIVATE_H_ */
diff --git a/drivers/bus/fsl-mc/fsl-mc-uapi.c b/drivers/bus/fsl-mc/fsl-mc-uapi.c
new file mode 100644
index 000000000000..eeb988c9f4bb
--- /dev/null
+++ b/drivers/bus/fsl-mc/fsl-mc-uapi.c
@@ -0,0 +1,547 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Management Complex (MC) userspace support
+ *
+ * Copyright 2021 NXP
+ *
+ */
+
+#include <linux/slab.h>
+#include <linux/fs.h>
+#include <linux/uaccess.h>
+#include <linux/miscdevice.h>
+
+#include "fsl-mc-private.h"
+
+struct uapi_priv_data {
+	struct fsl_mc_uapi *uapi;
+	struct fsl_mc_io *mc_io;
+};
+
+struct fsl_mc_cmd_desc {
+	u16 cmdid_value;
+	u16 cmdid_mask;
+	int size;
+	bool token;
+	int flags;
+};
+
+#define FSL_MC_CHECK_MODULE_ID		BIT(0)
+#define FSL_MC_CAP_NET_ADMIN_NEEDED	BIT(1)
+
+enum fsl_mc_cmd_index {
+	DPDBG_DUMP = 0,
+	DPDBG_SET,
+	DPRC_GET_CONTAINER_ID,
+	DPRC_CREATE_CONT,
+	DPRC_DESTROY_CONT,
+	DPRC_ASSIGN,
+	DPRC_UNASSIGN,
+	DPRC_GET_OBJ_COUNT,
+	DPRC_GET_OBJ,
+	DPRC_GET_RES_COUNT,
+	DPRC_GET_RES_IDS,
+	DPRC_SET_OBJ_LABEL,
+	DPRC_SET_LOCKED,
+	DPRC_CONNECT,
+	DPRC_DISCONNECT,
+	DPRC_GET_POOL,
+	DPRC_GET_POOL_COUNT,
+	DPRC_GET_CONNECTION,
+	DPCI_GET_LINK_STATE,
+	DPCI_GET_PEER_ATTR,
+	DPAIOP_GET_SL_VERSION,
+	DPAIOP_GET_STATE,
+	DPMNG_GET_VERSION,
+	DPSECI_GET_TX_QUEUE,
+	DPMAC_GET_COUNTER,
+	DPMAC_GET_MAC_ADDR,
+	DPNI_SET_PRIM_MAC,
+	DPNI_GET_PRIM_MAC,
+	DPNI_GET_STATISTICS,
+	DPNI_GET_LINK_STATE,
+	GET_ATTR,
+	GET_IRQ_MASK,
+	GET_IRQ_STATUS,
+	CLOSE,
+	OPEN,
+	GET_API_VERSION,
+	DESTROY,
+	CREATE,
+};
+
+static struct fsl_mc_cmd_desc fsl_mc_accepted_cmds[] = {
+	[DPDBG_DUMP] = {
+		.cmdid_value = 0x1300,
+		.cmdid_mask = 0xFFF0,
+		.token = true,
+		.size = 28,
+	},
+	[DPDBG_SET] = {
+		.cmdid_value = 0x1400,
+		.cmdid_mask = 0xFFF0,
+		.token = true,
+		.size = 28,
+	},
+	[DPRC_GET_CONTAINER_ID] = {
+		.cmdid_value = 0x8300,
+		.cmdid_mask = 0xFFF0,
+		.token = false,
+		.size = 8,
+	},
+	[DPRC_CREATE_CONT] = {
+		.cmdid_value = 0x1510,
+		.cmdid_mask = 0xFFF0,
+		.token = true,
+		.size = 40,
+		.flags = FSL_MC_CAP_NET_ADMIN_NEEDED,
+	},
+	[DPRC_DESTROY_CONT] = {
+		.cmdid_value = 0x1520,
+		.cmdid_mask = 0xFFF0,
+		.token = true,
+		.size = 12,
+		.flags = FSL_MC_CAP_NET_ADMIN_NEEDED,
+	},
+	[DPRC_ASSIGN] = {
+		.cmdid_value = 0x1570,
+		.cmdid_mask = 0xFFF0,
+		.token = true,
+		.size = 40,
+		.flags = FSL_MC_CAP_NET_ADMIN_NEEDED,
+	},
+	[DPRC_UNASSIGN] = {
+		.cmdid_value = 0x1580,
+		.cmdid_mask = 0xFFF0,
+		.token = true,
+		.size = 40,
+		.flags = FSL_MC_CAP_NET_ADMIN_NEEDED,
+	},
+	[DPRC_GET_OBJ_COUNT] = {
+		.cmdid_value = 0x1590,
+		.cmdid_mask = 0xFFF0,
+		.token = true,
+		.size = 16,
+	},
+	[DPRC_GET_OBJ] = {
+		.cmdid_value = 0x15A0,
+		.cmdid_mask = 0xFFF0,
+		.token = true,
+		.size = 12,
+	},
+	[DPRC_GET_RES_COUNT] = {
+		.cmdid_value = 0x15B0,
+		.cmdid_mask = 0xFFF0,
+		.token = true,
+		.size = 32,
+	},
+	[DPRC_GET_RES_IDS] = {
+		.cmdid_value = 0x15C0,
+		.cmdid_mask = 0xFFF0,
+		.token = true,
+		.size = 40,
+	},
+	[DPRC_SET_OBJ_LABEL] = {
+		.cmdid_value = 0x1610,
+		.cmdid_mask = 0xFFF0,
+		.token = true,
+		.size = 48,
+		.flags = FSL_MC_CAP_NET_ADMIN_NEEDED,
+	},
+	[DPRC_SET_LOCKED] = {
+		.cmdid_value = 0x16B0,
+		.cmdid_mask = 0xFFF0,
+		.token = true,
+		.size = 16,
+		.flags = FSL_MC_CAP_NET_ADMIN_NEEDED,
+	},
+	[DPRC_CONNECT] = {
+		.cmdid_value = 0x1670,
+		.cmdid_mask = 0xFFF0,
+		.token = true,
+		.size = 56,
+		.flags = FSL_MC_CAP_NET_ADMIN_NEEDED,
+	},
+	[DPRC_DISCONNECT] = {
+		.cmdid_value = 0x1680,
+		.cmdid_mask = 0xFFF0,
+		.token = true,
+		.size = 32,
+		.flags = FSL_MC_CAP_NET_ADMIN_NEEDED,
+	},
+	[DPRC_GET_POOL] = {
+		.cmdid_value = 0x1690,
+		.cmdid_mask = 0xFFF0,
+		.token = true,
+		.size = 12,
+	},
+	[DPRC_GET_POOL_COUNT] = {
+		.cmdid_value = 0x16A0,
+		.cmdid_mask = 0xFFF0,
+		.token = true,
+		.size = 8,
+	},
+	[DPRC_GET_CONNECTION] = {
+		.cmdid_value = 0x16C0,
+		.cmdid_mask = 0xFFF0,
+		.token = true,
+		.size = 32,
+	},
+
+	[DPCI_GET_LINK_STATE] = {
+		.cmdid_value = 0x0E10,
+		.cmdid_mask = 0xFFF0,
+		.token = true,
+		.size = 8,
+	},
+	[DPCI_GET_PEER_ATTR] = {
+		.cmdid_value = 0x0E20,
+		.cmdid_mask = 0xFFF0,
+		.token = true,
+		.size = 8,
+	},
+	[DPAIOP_GET_SL_VERSION] = {
+		.cmdid_value = 0x2820,
+		.cmdid_mask = 0xFFF0,
+		.token = true,
+		.size = 8,
+	},
+	[DPAIOP_GET_STATE] = {
+		.cmdid_value = 0x2830,
+		.cmdid_mask = 0xFFF0,
+		.token = true,
+		.size = 8,
+	},
+	[DPMNG_GET_VERSION] = {
+		.cmdid_value = 0x8310,
+		.cmdid_mask = 0xFFF0,
+		.token = false,
+		.size = 8,
+	},
+	[DPSECI_GET_TX_QUEUE] = {
+		.cmdid_value = 0x1970,
+		.cmdid_mask = 0xFFF0,
+		.token = true,
+		.size = 14,
+	},
+	[DPMAC_GET_COUNTER] = {
+		.cmdid_value = 0x0c40,
+		.cmdid_mask = 0xFFF0,
+		.token = true,
+		.size = 9,
+	},
+	[DPMAC_GET_MAC_ADDR] = {
+		.cmdid_value = 0x0c50,
+		.cmdid_mask = 0xFFF0,
+		.token = true,
+		.size = 8,
+	},
+	[DPNI_SET_PRIM_MAC] = {
+		.cmdid_value = 0x2240,
+		.cmdid_mask = 0xFFF0,
+		.token = true,
+		.size = 16,
+		.flags = FSL_MC_CAP_NET_ADMIN_NEEDED,
+	},
+	[DPNI_GET_PRIM_MAC] = {
+		.cmdid_value = 0x2250,
+		.cmdid_mask = 0xFFF0,
+		.token = true,
+		.size = 8,
+	},
+	[DPNI_GET_STATISTICS] = {
+		.cmdid_value = 0x25D0,
+		.cmdid_mask = 0xFFF0,
+		.token = true,
+		.size = 10,
+	},
+	[DPNI_GET_LINK_STATE] = {
+		.cmdid_value = 0x2150,
+		.cmdid_mask = 0xFFF0,
+		.token = true,
+		.size = 8,
+	},
+	[GET_ATTR] = {
+		.cmdid_value = 0x0040,
+		.cmdid_mask = 0xFFF0,
+		.token = true,
+		.size = 8,
+	},
+	[GET_IRQ_MASK] = {
+		.cmdid_value = 0x0150,
+		.cmdid_mask = 0xFFF0,
+		.token = true,
+		.size = 13,
+	},
+	[GET_IRQ_STATUS] = {
+		.cmdid_value = 0x0160,
+		.cmdid_mask = 0xFFF0,
+		.token = true,
+		.size = 13,
+	},
+	[CLOSE] = {
+		.cmdid_value = 0x8000,
+		.cmdid_mask = 0xFFF0,
+		.token = true,
+		.size = 8,
+	},
+
+	/* Common commands amongst all types of objects. Must be checked last. */
+	[OPEN] = {
+		.cmdid_value = 0x8000,
+		.cmdid_mask = 0xFC00,
+		.token = false,
+		.size = 12,
+		.flags = FSL_MC_CHECK_MODULE_ID,
+	},
+	[GET_API_VERSION] = {
+		.cmdid_value = 0xA000,
+		.cmdid_mask = 0xFC00,
+		.token = false,
+		.size = 8,
+		.flags = FSL_MC_CHECK_MODULE_ID,
+	},
+	[DESTROY] = {
+		.cmdid_value = 0x9800,
+		.cmdid_mask = 0xFC00,
+		.token = true,
+		.size = 12,
+		.flags = FSL_MC_CHECK_MODULE_ID | FSL_MC_CAP_NET_ADMIN_NEEDED,
+	},
+	[CREATE] = {
+		.cmdid_value = 0x9000,
+		.cmdid_mask = 0xFC00,
+		.token = true,
+		.size = 64,
+		.flags = FSL_MC_CHECK_MODULE_ID | FSL_MC_CAP_NET_ADMIN_NEEDED,
+	},
+};
+
+#define FSL_MC_NUM_ACCEPTED_CMDS ARRAY_SIZE(fsl_mc_accepted_cmds)
+
+#define FSL_MC_MAX_MODULE_ID 0x10
+
+static int fsl_mc_command_check(struct fsl_mc_device *mc_dev,
+				struct fsl_mc_command *mc_cmd)
+{
+	struct fsl_mc_cmd_desc *desc = NULL;
+	int mc_cmd_max_size, i;
+	bool token_provided;
+	u16 cmdid, module_id;
+	char *mc_cmd_end;
+	char sum = 0;
+
+	/* Check if this is an accepted MC command */
+	cmdid = mc_cmd_hdr_read_cmdid(mc_cmd);
+	for (i = 0; i < FSL_MC_NUM_ACCEPTED_CMDS; i++) {
+		desc = &fsl_mc_accepted_cmds[i];
+		if ((cmdid & desc->cmdid_mask) == desc->cmdid_value)
+			break;
+	}
+	if (!desc) {
+		dev_err(&mc_dev->dev, "MC command 0x%04x: cmdid not accepted\n", cmdid);
+		return -EACCES;
+	}
+
+	/* Check if the size of the command is honored. Anything beyond the
+	 * last valid byte of the command should be zeroed.
+	 */
+	mc_cmd_max_size = sizeof(*mc_cmd);
+	mc_cmd_end = ((char *)mc_cmd) + desc->size;
+	for (i = desc->size; i < mc_cmd_max_size; i++)
+		sum |= *mc_cmd_end++;
+	if (sum) {
+		dev_err(&mc_dev->dev, "MC command 0x%04x: garbage beyond max size of %d bytes!\n",
+			cmdid, desc->size);
+		return -EACCES;
+	}
+
+	/* Some MC commands request a token to be passed so that object
+	 * identification is possible. Check if the token passed in the command
+	 * is as expected.
+	 */
+	token_provided = mc_cmd_hdr_read_token(mc_cmd) ? true : false;
+	if (token_provided != desc->token) {
+		dev_err(&mc_dev->dev, "MC command 0x%04x: token 0x%04x is invalid!\n",
+			cmdid, mc_cmd_hdr_read_token(mc_cmd));
+		return -EACCES;
+	}
+
+	/* If needed, check if the module ID passed is valid */
+	if (desc->flags & FSL_MC_CHECK_MODULE_ID) {
+		/* The module ID is represented by bits [4:9] from the cmdid */
+		module_id = (cmdid & GENMASK(9, 4)) >> 4;
+		if (module_id == 0 || module_id > FSL_MC_MAX_MODULE_ID) {
+			dev_err(&mc_dev->dev, "MC command 0x%04x: unknown module ID 0x%x\n",
+				cmdid, module_id);
+			return -EACCES;
+		}
+	}
+
+	/* Some commands alter how hardware resources are managed. For these
+	 * commands, check for CAP_NET_ADMIN.
+	 */
+	if (desc->flags & FSL_MC_CAP_NET_ADMIN_NEEDED) {
+		if (!capable(CAP_NET_ADMIN)) {
+			dev_err(&mc_dev->dev, "MC command 0x%04x: needs CAP_NET_ADMIN!\n",
+				cmdid);
+			return -EPERM;
+		}
+	}
+
+	return 0;
+}
+
+static int fsl_mc_uapi_send_command(struct fsl_mc_device *mc_dev, unsigned long arg,
+				    struct fsl_mc_io *mc_io)
+{
+	struct fsl_mc_command mc_cmd;
+	int error;
+
+	error = copy_from_user(&mc_cmd, (void __user *)arg, sizeof(mc_cmd));
+	if (error)
+		return -EFAULT;
+
+	error = fsl_mc_command_check(mc_dev, &mc_cmd);
+	if (error)
+		return error;
+
+	error = mc_send_command(mc_io, &mc_cmd);
+	if (error)
+		return error;
+
+	error = copy_to_user((void __user *)arg, &mc_cmd, sizeof(mc_cmd));
+	if (error)
+		return -EFAULT;
+
+	return 0;
+}
+
+static int fsl_mc_uapi_dev_open(struct inode *inode, struct file *filep)
+{
+	struct fsl_mc_device *root_mc_device;
+	struct uapi_priv_data *priv_data;
+	struct fsl_mc_io *dynamic_mc_io;
+	struct fsl_mc_uapi *mc_uapi;
+	struct fsl_mc_bus *mc_bus;
+	int error;
+
+	priv_data = kzalloc(sizeof(*priv_data), GFP_KERNEL);
+	if (!priv_data)
+		return -ENOMEM;
+
+	mc_uapi = container_of(filep->private_data, struct fsl_mc_uapi, misc);
+	mc_bus = container_of(mc_uapi, struct fsl_mc_bus, uapi_misc);
+	root_mc_device = &mc_bus->mc_dev;
+
+	mutex_lock(&mc_uapi->mutex);
+
+	if (!mc_uapi->local_instance_in_use) {
+		priv_data->mc_io = mc_uapi->static_mc_io;
+		mc_uapi->local_instance_in_use = 1;
+	} else {
+		error = fsl_mc_portal_allocate(root_mc_device, 0,
+					       &dynamic_mc_io);
+		if (error) {
+			dev_dbg(&root_mc_device->dev,
+				"Could not allocate MC portal\n");
+			goto error_portal_allocate;
+		}
+
+		priv_data->mc_io = dynamic_mc_io;
+	}
+	priv_data->uapi = mc_uapi;
+	filep->private_data = priv_data;
+
+	mutex_unlock(&mc_uapi->mutex);
+
+	return 0;
+
+error_portal_allocate:
+	mutex_unlock(&mc_uapi->mutex);
+	kfree(priv_data);
+
+	return error;
+}
+
+static int fsl_mc_uapi_dev_release(struct inode *inode, struct file *filep)
+{
+	struct uapi_priv_data *priv_data;
+	struct fsl_mc_uapi *mc_uapi;
+	struct fsl_mc_io *mc_io;
+
+	priv_data = filep->private_data;
+	mc_uapi = priv_data->uapi;
+	mc_io = priv_data->mc_io;
+
+	mutex_lock(&mc_uapi->mutex);
+
+	if (mc_io == mc_uapi->static_mc_io)
+		mc_uapi->local_instance_in_use = 0;
+	else
+		fsl_mc_portal_free(mc_io);
+
+	kfree(filep->private_data);
+	filep->private_data =  NULL;
+
+	mutex_unlock(&mc_uapi->mutex);
+
+	return 0;
+}
+
+static long fsl_mc_uapi_dev_ioctl(struct file *file,
+				  unsigned int cmd,
+				  unsigned long arg)
+{
+	struct uapi_priv_data *priv_data = file->private_data;
+	struct fsl_mc_device *root_mc_device;
+	struct fsl_mc_bus *mc_bus;
+	int error;
+
+	mc_bus = container_of(priv_data->uapi, struct fsl_mc_bus, uapi_misc);
+	root_mc_device = &mc_bus->mc_dev;
+
+	switch (cmd) {
+	case FSL_MC_SEND_MC_COMMAND:
+		error = fsl_mc_uapi_send_command(root_mc_device, arg, priv_data->mc_io);
+		break;
+	default:
+		dev_dbg(&root_mc_device->dev, "unexpected ioctl call number\n");
+		error = -EINVAL;
+	}
+
+	return error;
+}
+
+static const struct file_operations fsl_mc_uapi_dev_fops = {
+	.owner = THIS_MODULE,
+	.open = fsl_mc_uapi_dev_open,
+	.release = fsl_mc_uapi_dev_release,
+	.unlocked_ioctl = fsl_mc_uapi_dev_ioctl,
+};
+
+int fsl_mc_uapi_create_device_file(struct fsl_mc_bus *mc_bus)
+{
+	struct fsl_mc_device *mc_dev = &mc_bus->mc_dev;
+	struct fsl_mc_uapi *mc_uapi = &mc_bus->uapi_misc;
+	int error;
+
+	mc_uapi->misc.minor = MISC_DYNAMIC_MINOR;
+	mc_uapi->misc.name = dev_name(&mc_dev->dev);
+	mc_uapi->misc.fops = &fsl_mc_uapi_dev_fops;
+
+	error = misc_register(&mc_uapi->misc);
+	if (error)
+		return error;
+
+	mc_uapi->static_mc_io = mc_bus->mc_dev.mc_io;
+
+	mutex_init(&mc_uapi->mutex);
+
+	return 0;
+}
+
+void fsl_mc_uapi_remove_device_file(struct fsl_mc_bus *mc_bus)
+{
+	misc_deregister(&mc_bus->uapi_misc.misc);
+}
diff --git a/include/uapi/linux/fsl_mc.h b/include/uapi/linux/fsl_mc.h
index cf56d46f052e..e57451570033 100644
--- a/include/uapi/linux/fsl_mc.h
+++ b/include/uapi/linux/fsl_mc.h
@@ -16,10 +16,19 @@
  * struct fsl_mc_command - Management Complex (MC) command structure
  * @header: MC command header
  * @params: MC command parameters
+ *
+ * Used by FSL_MC_SEND_MC_COMMAND
  */
 struct fsl_mc_command {
 	__le64 header;
 	__le64 params[MC_CMD_NUM_OF_PARAMS];
 };
 
+#define FSL_MC_SEND_CMD_IOCTL_TYPE	'R'
+#define FSL_MC_SEND_CMD_IOCTL_SEQ	0xE0
+
+#define FSL_MC_SEND_MC_COMMAND \
+	_IOWR(FSL_MC_SEND_CMD_IOCTL_TYPE, FSL_MC_SEND_CMD_IOCTL_SEQ, \
+	struct fsl_mc_command)
+
 #endif /* _UAPI_FSL_MC_H_ */
-- 
2.29.2

