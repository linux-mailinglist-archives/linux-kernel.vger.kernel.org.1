Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 802712C9E2B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 10:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387869AbgLAJk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 04:40:57 -0500
Received: from mga03.intel.com ([134.134.136.65]:4011 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387547AbgLAJk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 04:40:56 -0500
IronPort-SDR: At2STJKwUnMyLT4pIlD853ZWrKyPq3hQS3s7e4vHNCEWkBk6YiJ4j0d6K91sw8i2V1N71mv+Ed
 NilPnyOfBNkQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="172898016"
X-IronPort-AV: E=Sophos;i="5.78,384,1599548400"; 
   d="scan'208";a="172898016"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 01:40:14 -0800
IronPort-SDR: NMDTyjqrNfBx/riifklDBimOGPUEC4snXlxHeIZnYHHSukRPdnSdISPXki3SfAA/RfRQ8x4PQo
 SOag9w7qUPHQ==
X-IronPort-AV: E=Sophos;i="5.78,384,1599548400"; 
   d="scan'208";a="329907842"
Received: from shsi6026.sh.intel.com (HELO localhost) ([10.239.147.88])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 01:40:10 -0800
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
Subject: [PATCH v6 05/18] virt: acrn: Introduce ACRN HSM basic driver
Date:   Tue,  1 Dec 2020 17:38:40 +0800
Message-Id: <20201201093853.12070-6-shuo.a.liu@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201201093853.12070-1-shuo.a.liu@intel.com>
References: <20201201093853.12070-1-shuo.a.liu@intel.com>
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
index e6e5bd9ce117..46eb29ed9c4f 100644
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
index 80c5f9c16ec1..8061e8ef449f 100644
--- a/drivers/virt/Kconfig
+++ b/drivers/virt/Kconfig
@@ -34,4 +34,6 @@ config FSL_HV_MANAGER
 source "drivers/virt/vboxguest/Kconfig"
 
 source "drivers/virt/nitro_enclaves/Kconfig"
+
+source "drivers/virt/acrn/Kconfig"
 endif
diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
index f28425ce4b39..3e272ea60cd9 100644
--- a/drivers/virt/Makefile
+++ b/drivers/virt/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_FSL_HV_MANAGER)	+= fsl_hypervisor.o
 obj-y				+= vboxguest/
 
 obj-$(CONFIG_NITRO_ENCLAVES)	+= nitro_enclaves/
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
index 000000000000..a8dcb250649d
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
+	if (!(cpuid_eax(ACRN_CPUID_FEATURES) & ACRN_FEATURE_PRIVILEGED_VM))
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

