Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F1429226A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 08:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgJSGSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 02:18:53 -0400
Received: from mga17.intel.com ([192.55.52.151]:53114 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbgJSGSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 02:18:51 -0400
IronPort-SDR: 1WjarLczogGeOrZS3+A8cX7HLefytGl54uhDNpF0efNd3tkGr0PIjuu+5zGkh/AQgvS8EmVUqt
 mVhNYmnfKJyw==
X-IronPort-AV: E=McAfee;i="6000,8403,9778"; a="146835908"
X-IronPort-AV: E=Sophos;i="5.77,393,1596524400"; 
   d="scan'208";a="146835908"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2020 23:18:51 -0700
IronPort-SDR: 1Lf5B+W2sU+Xev1N061wLMVcXY4ra76AbitQiDKm/sOT+J/T06E5q1aLADfsDO3AhieCuJgq+D
 Idu17nlG3w6w==
X-IronPort-AV: E=Sophos;i="5.77,393,1596524400"; 
   d="scan'208";a="315568555"
Received: from shsi6026.sh.intel.com (HELO localhost) ([10.239.147.88])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2020 23:18:46 -0700
From:   shuo.a.liu@intel.com
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuo Liu <shuo.a.liu@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: [PATCH v5 05/17] virt: acrn: Introduce ACRN HSM basic driver
Date:   Mon, 19 Oct 2020 14:17:51 +0800
Message-Id: <20201019061803.13298-6-shuo.a.liu@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201019061803.13298-1-shuo.a.liu@intel.com>
References: <20201019061803.13298-1-shuo.a.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuo Liu <shuo.a.liu@intel.com>

ACRN Hypervisor Service Module (HSM) is a kernel module in Service VM
which communicates with ACRN userspace through ioctls and talks to ACRN
Hypervisor through hypercalls.

Add a basic HSM driver which allows Service VM userspace to communicate
with ACRN. The following patches will add more ioctls, guest VM memory
mapping caching, I/O request processing, ioeventfd and irqfd into this
module. HSM exports a char device interface (/dev/acrn_hsm) to userspace.

Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Zhi Wang <zhi.a.wang@intel.com>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Yu Wang <yu1.wang@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 MAINTAINERS                  |  1 +
 drivers/virt/Kconfig         |  2 +
 drivers/virt/Makefile        |  1 +
 drivers/virt/acrn/Kconfig    | 14 ++++++
 drivers/virt/acrn/Makefile   |  3 ++
 drivers/virt/acrn/acrn_drv.h | 18 ++++++++
 drivers/virt/acrn/hsm.c      | 87 ++++++++++++++++++++++++++++++++++++
 7 files changed, 126 insertions(+)
 create mode 100644 drivers/virt/acrn/Kconfig
 create mode 100644 drivers/virt/acrn/Makefile
 create mode 100644 drivers/virt/acrn/acrn_drv.h
 create mode 100644 drivers/virt/acrn/hsm.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e0fea5e464b4..3030d0e93d02 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -442,6 +442,7 @@ L:	acrn-dev@lists.projectacrn.org
 S:	Supported
 W:	https://projectacrn.org
 F:	Documentation/virt/acrn/
+F:	drivers/virt/acrn/
 
 AD1889 ALSA SOUND DRIVER
 L:	linux-parisc@vger.kernel.org
diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
index cbc1f25c79ab..d9484a2e9b46 100644
--- a/drivers/virt/Kconfig
+++ b/drivers/virt/Kconfig
@@ -32,4 +32,6 @@ config FSL_HV_MANAGER
 	     partition shuts down.
 
 source "drivers/virt/vboxguest/Kconfig"
+
+source "drivers/virt/acrn/Kconfig"
 endif
diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
index fd331247c27a..f0491bbf0d4d 100644
--- a/drivers/virt/Makefile
+++ b/drivers/virt/Makefile
@@ -5,3 +5,4 @@
 
 obj-$(CONFIG_FSL_HV_MANAGER)	+= fsl_hypervisor.o
 obj-y				+= vboxguest/
+obj-$(CONFIG_ACRN_HSM)		+= acrn/
diff --git a/drivers/virt/acrn/Kconfig b/drivers/virt/acrn/Kconfig
new file mode 100644
index 000000000000..36c80378c30c
--- /dev/null
+++ b/drivers/virt/acrn/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0
+config ACRN_HSM
+	tristate "ACRN Hypervisor Service Module"
+	depends on ACRN_GUEST
+	help
+	  ACRN Hypervisor Service Module (HSM) is a kernel module which
+	  communicates with ACRN userspace through ioctls and talks to
+	  the ACRN Hypervisor through hypercalls. HSM will only run in
+	  a privileged management VM, called Service VM, to manage User
+	  VMs and do I/O emulation. Not required for simply running
+	  under ACRN as a User VM.
+
+	  To compile as a module, choose M, the module will be called
+	  acrn. If unsure, say N.
diff --git a/drivers/virt/acrn/Makefile b/drivers/virt/acrn/Makefile
new file mode 100644
index 000000000000..6920ed798aaf
--- /dev/null
+++ b/drivers/virt/acrn/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_ACRN_HSM)	:= acrn.o
+acrn-y := hsm.o
diff --git a/drivers/virt/acrn/acrn_drv.h b/drivers/virt/acrn/acrn_drv.h
new file mode 100644
index 000000000000..29eedd696327
--- /dev/null
+++ b/drivers/virt/acrn/acrn_drv.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ACRN_HSM_DRV_H
+#define __ACRN_HSM_DRV_H
+
+#include <linux/types.h>
+
+#define ACRN_INVALID_VMID (0xffffU)
+
+/**
+ * struct acrn_vm - Properties of ACRN User VM.
+ * @vmid:	User VM ID
+ */
+struct acrn_vm {
+	u16	vmid;
+};
+
+#endif /* __ACRN_HSM_DRV_H */
diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c
new file mode 100644
index 000000000000..28a3052ffa55
--- /dev/null
+++ b/drivers/virt/acrn/hsm.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ACRN Hypervisor Service Module (HSM)
+ *
+ * Copyright (C) 2020 Intel Corporation. All rights reserved.
+ *
+ * Authors:
+ *	Fengwei Yin <fengwei.yin@intel.com>
+ *	Yakui Zhao <yakui.zhao@intel.com>
+ */
+
+#include <linux/miscdevice.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+
+#include <asm/acrn.h>
+#include <asm/hypervisor.h>
+
+#include "acrn_drv.h"
+
+/*
+ * When /dev/acrn_hsm is opened, a 'struct acrn_vm' object is created to
+ * represent a VM instance and continues to be associated with the opened file
+ * descriptor. All ioctl operations on this file descriptor will be targeted to
+ * the VM instance. Release of this file descriptor will destroy the object.
+ */
+static int acrn_dev_open(struct inode *inode, struct file *filp)
+{
+	struct acrn_vm *vm;
+
+	vm = kzalloc(sizeof(*vm), GFP_KERNEL);
+	if (!vm)
+		return -ENOMEM;
+
+	vm->vmid = ACRN_INVALID_VMID;
+	filp->private_data = vm;
+	return 0;
+}
+
+static int acrn_dev_release(struct inode *inode, struct file *filp)
+{
+	struct acrn_vm *vm = filp->private_data;
+
+	kfree(vm);
+	return 0;
+}
+
+static const struct file_operations acrn_fops = {
+	.owner		= THIS_MODULE,
+	.open		= acrn_dev_open,
+	.release	= acrn_dev_release,
+};
+
+static struct miscdevice acrn_dev = {
+	.minor	= MISC_DYNAMIC_MINOR,
+	.name	= "acrn_hsm",
+	.fops	= &acrn_fops,
+};
+
+static int __init hsm_init(void)
+{
+	int ret;
+
+	if (x86_hyper_type != X86_HYPER_ACRN)
+		return -ENODEV;
+
+	if (!acrn_is_privileged_vm())
+		return -EPERM;
+
+	ret = misc_register(&acrn_dev);
+	if (ret)
+		pr_err("Create misc dev failed!\n");
+
+	return ret;
+}
+
+static void __exit hsm_exit(void)
+{
+	misc_deregister(&acrn_dev);
+}
+module_init(hsm_init);
+module_exit(hsm_exit);
+
+MODULE_AUTHOR("Intel Corporation");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("ACRN Hypervisor Service Module (HSM)");
-- 
2.28.0

