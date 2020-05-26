Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04BBF1ABB3F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 10:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502084AbgDPIbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 04:31:02 -0400
Received: from mga01.intel.com ([192.55.52.88]:39615 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440760AbgDPIQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 04:16:38 -0400
IronPort-SDR: uxBGVk7i8Bn2ClmDQzGn/OHWbc9V6pFWnUC3b7fXRpF+V8gpeNCb6Ou2F3aVR/ldzLmqbNR+ag
 DdECoLUEphVw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 01:15:57 -0700
IronPort-SDR: k8FeKh1oQrhyAv50jgVWKVrpqnjJuOr6mQtwi7fi7GBpkNgLAm1fSugWlFFnFRUNtBhcuC+Dtv
 LgYLopBCt7Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,390,1580803200"; 
   d="scan'208";a="242576452"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 16 Apr 2020 01:15:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 1A9DC17F; Thu, 16 Apr 2020 11:15:53 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 01/20] platform/x86: intel_scu_ipc: Split out SCU IPC functionality from the SCU driver
Date:   Thu, 16 Apr 2020 11:15:33 +0300
Message-Id: <20200416081552.68083-2-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200416081552.68083-1-mika.westerberg@linux.intel.com>
References: <20200416081552.68083-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SCU IPC functionality is usable outside of Intel MID devices. For
example modern Intel CPUs include the same thing but now it is called
PMC (Power Management Controller) instead of SCU. To make the IPC
available for those split the driver into core part (intel_scu_ipc.c)
and the SCU PCI driver part (intel_scu_pcidrv.c) which then calls the
former before it goes and creates rest of the SCU devices. The SCU IPC
will also register a new class that gets assigned to the device that is
created under the parent PCI device.

We also split the Kconfig symbols so that INTEL_SCU_IPC enables the SCU
IPC library and INTEL_SCU_PCI the SCU driver and convert the users
accordingly. While there remove default y from the INTEL_SCU_PCI symbol
as it is already selected by X86_INTEL_MID.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 arch/x86/Kconfig                        |   2 +-
 arch/x86/include/asm/intel_scu_ipc.h    |  18 +++
 drivers/mfd/Kconfig                     |   4 +-
 drivers/platform/x86/Kconfig            |  24 ++--
 drivers/platform/x86/Makefile           |   1 +
 drivers/platform/x86/intel_scu_ipc.c    | 172 ++++++++++++++++--------
 drivers/platform/x86/intel_scu_pcidrv.c |  55 ++++++++
 7 files changed, 208 insertions(+), 68 deletions(-)
 create mode 100644 drivers/platform/x86/intel_scu_pcidrv.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1d6104ea8af0..5947c7a16d78 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -595,7 +595,7 @@ config X86_INTEL_MID
 	select I2C
 	select DW_APB_TIMER
 	select APB_TIMER
-	select INTEL_SCU_IPC
+	select INTEL_SCU_PCI
 	select MFD_INTEL_MSIC
 	---help---
 	  Select to build a kernel capable of supporting Intel MID (Mobile
diff --git a/arch/x86/include/asm/intel_scu_ipc.h b/arch/x86/include/asm/intel_scu_ipc.h
index 2a1442ba6e78..c53d18f9440b 100644
--- a/arch/x86/include/asm/intel_scu_ipc.h
+++ b/arch/x86/include/asm/intel_scu_ipc.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_X86_INTEL_SCU_IPC_H_
 #define  _ASM_X86_INTEL_SCU_IPC_H_
 
+#include <linux/ioport.h>
 #include <linux/notifier.h>
 
 #define IPCMSG_INDIRECT_READ	0x02
@@ -19,6 +20,23 @@
 	#define IPC_CMD_VRTC_SETTIME      1 /* Set time */
 	#define IPC_CMD_VRTC_SETALARM     2 /* Set alarm */
 
+struct device;
+struct intel_scu_ipc_dev;
+
+/**
+ * struct intel_scu_ipc_data - Data used to configure SCU IPC
+ * @mem: Base address of SCU IPC MMIO registers
+ * @irq: The IRQ number used for SCU (optional)
+ */
+struct intel_scu_ipc_data {
+	struct resource mem;
+	int irq;
+};
+
+struct intel_scu_ipc_dev *
+intel_scu_ipc_register(struct device *parent,
+		       const struct intel_scu_ipc_data *scu_data);
+
 /* Read single register */
 int intel_scu_ipc_ioread8(u16 addr, u8 *data);
 
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 0a59249198d3..5e21a78b6923 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -593,7 +593,7 @@ config INTEL_SOC_PMIC_MRFLD
 	tristate "Support for Intel Merrifield Basin Cove PMIC"
 	depends on GPIOLIB
 	depends on ACPI
-	depends on INTEL_SCU_IPC
+	depends on INTEL_SCU
 	select MFD_CORE
 	select REGMAP_IRQ
 	help
@@ -625,7 +625,7 @@ config MFD_INTEL_LPSS_PCI
 
 config MFD_INTEL_MSIC
 	bool "Intel MSIC"
-	depends on INTEL_SCU_IPC
+	depends on INTEL_SCU
 	select MFD_CORE
 	help
 	  Select this option to enable access to Intel MSIC (Avatele
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 0ad7ad8cf8e1..d1e4d49c35e2 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1295,7 +1295,7 @@ config INTEL_MFLD_THERMAL
 
 config INTEL_MID_POWER_BUTTON
 	tristate "power button driver for Intel MID platforms"
-	depends on INTEL_SCU_IPC && INPUT
+	depends on INTEL_SCU && INPUT
 	help
 	  This driver handles the power button on the Intel MID platforms.
 
@@ -1342,17 +1342,25 @@ config INTEL_PUNIT_IPC
 	  which is used to bridge the communications between kernel and P-Unit.
 
 config INTEL_SCU_IPC
-	bool "Intel SCU IPC Support"
+	bool
+
+config INTEL_SCU
+	bool
+	select INTEL_SCU_IPC
+
+config INTEL_SCU_PCI
+	bool "Intel SCU PCI driver"
 	depends on X86_INTEL_MID
-	default y
-	---help---
-	  IPC is used to bridge the communications between kernel and SCU on
-	  some embedded Intel x86 platforms. This is not needed for PC-type
-	  machines.
+	select INTEL_SCU
+	help
+	  This driver is used to bridge the communications between kernel
+	  and SCU on some embedded Intel x86 platforms. It also creates
+	  devices that are connected to the SoC through the SCU. This is
+	  not needed for PC-type machines.
 
 config INTEL_SCU_IPC_UTIL
 	tristate "Intel SCU IPC utility driver"
-	depends on INTEL_SCU_IPC
+	depends on INTEL_SCU
 	---help---
 	  The IPC Util driver provides an interface with the SCU enabling
 	  low level access for debug work and updating the firmware. Say
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 53408d965874..ef995a0f04f0 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -141,6 +141,7 @@ obj-$(CONFIG_INTEL_PMC_CORE)		+= intel_pmc_core.o intel_pmc_core_pltdrv.o
 obj-$(CONFIG_INTEL_PMC_IPC)		+= intel_pmc_ipc.o
 obj-$(CONFIG_INTEL_PUNIT_IPC)		+= intel_punit_ipc.o
 obj-$(CONFIG_INTEL_SCU_IPC)		+= intel_scu_ipc.o
+obj-$(CONFIG_INTEL_SCU_PCI)		+= intel_scu_pcidrv.o
 obj-$(CONFIG_INTEL_SCU_IPC_UTIL)	+= intel_scu_ipcutil.o
 obj-$(CONFIG_INTEL_TELEMETRY)		+= intel_telemetry_core.o \
 					   intel_telemetry_pltdrv.o \
diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
index 3d7da5266136..584e33c37708 100644
--- a/drivers/platform/x86/intel_scu_ipc.c
+++ b/drivers/platform/x86/intel_scu_ipc.c
@@ -18,11 +18,10 @@
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
-#include <linux/pci.h>
-#include <linux/pm.h>
-#include <linux/sfi.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/slab.h>
 
-#include <asm/intel-mid.h>
 #include <asm/intel_scu_ipc.h>
 
 /* IPC defines the following message types */
@@ -55,14 +54,13 @@
 #define IPC_IOC	          0x100		/* IPC command register IOC bit */
 
 struct intel_scu_ipc_dev {
-	struct device *dev;
+	struct device dev;
+	struct resource mem;
+	int irq;
 	void __iomem *ipc_base;
 	struct completion cmd_complete;
-	u8 irq_mode;
 };
 
-static struct intel_scu_ipc_dev  ipcdev; /* Only one for now */
-
 #define IPC_STATUS		0x04
 #define IPC_STATUS_IRQ		BIT(2)
 #define IPC_STATUS_ERR		BIT(1)
@@ -78,8 +76,14 @@ static struct intel_scu_ipc_dev  ipcdev; /* Only one for now */
 /* Timeout in jiffies */
 #define IPC_TIMEOUT		(3 * HZ)
 
+static struct intel_scu_ipc_dev *ipcdev; /* Only one for now */
 static DEFINE_MUTEX(ipclock); /* lock used to prevent multiple call to SCU */
 
+static struct class intel_scu_ipc_class = {
+	.name = "intel_scu_ipc",
+	.owner = THIS_MODULE,
+};
+
 /*
  * Send ipc command
  * Command Register (Write Only):
@@ -143,7 +147,7 @@ static inline int busy_loop(struct intel_scu_ipc_dev *scu)
 		usleep_range(50, 100);
 	} while (time_before(jiffies, end));
 
-	dev_err(scu->dev, "IPC timed out");
+	dev_err(&scu->dev, "IPC timed out");
 	return -ETIMEDOUT;
 }
 
@@ -153,7 +157,7 @@ static inline int ipc_wait_for_interrupt(struct intel_scu_ipc_dev *scu)
 	int status;
 
 	if (!wait_for_completion_timeout(&scu->cmd_complete, IPC_TIMEOUT)) {
-		dev_err(scu->dev, "IPC timed out\n");
+		dev_err(&scu->dev, "IPC timed out\n");
 		return -ETIMEDOUT;
 	}
 
@@ -166,13 +170,13 @@ static inline int ipc_wait_for_interrupt(struct intel_scu_ipc_dev *scu)
 
 static int intel_scu_ipc_check_status(struct intel_scu_ipc_dev *scu)
 {
-	return scu->irq_mode ? ipc_wait_for_interrupt(scu) : busy_loop(scu);
+	return scu->irq > 0 ? ipc_wait_for_interrupt(scu) : busy_loop(scu);
 }
 
 /* Read/Write power control(PMIC in Langwell, MSIC in PenWell) registers */
 static int pwr_reg_rdwr(u16 *addr, u8 *data, u32 count, u32 op, u32 id)
 {
-	struct intel_scu_ipc_dev *scu = &ipcdev;
+	struct intel_scu_ipc_dev *scu;
 	int nc;
 	u32 offset = 0;
 	int err;
@@ -182,11 +186,11 @@ static int pwr_reg_rdwr(u16 *addr, u8 *data, u32 count, u32 op, u32 id)
 	memset(cbuf, 0, sizeof(cbuf));
 
 	mutex_lock(&ipclock);
-
-	if (scu->dev == NULL) {
+	if (!ipcdev) {
 		mutex_unlock(&ipclock);
 		return -ENODEV;
 	}
+	scu = ipcdev;
 
 	for (nc = 0; nc < count; nc++, offset += 2) {
 		cbuf[offset] = addr[nc];
@@ -326,14 +330,15 @@ EXPORT_SYMBOL(intel_scu_ipc_update_register);
  */
 int intel_scu_ipc_simple_command(int cmd, int sub)
 {
-	struct intel_scu_ipc_dev *scu = &ipcdev;
+	struct intel_scu_ipc_dev *scu;
 	int err;
 
 	mutex_lock(&ipclock);
-	if (scu->dev == NULL) {
+	if (!ipcdev) {
 		mutex_unlock(&ipclock);
 		return -ENODEV;
 	}
+	scu = ipcdev;
 	ipc_command(scu, sub << 12 | cmd);
 	err = intel_scu_ipc_check_status(scu);
 	mutex_unlock(&ipclock);
@@ -356,14 +361,15 @@ EXPORT_SYMBOL(intel_scu_ipc_simple_command);
 int intel_scu_ipc_command(int cmd, int sub, u32 *in, int inlen,
 			  u32 *out, int outlen)
 {
-	struct intel_scu_ipc_dev *scu = &ipcdev;
+	struct intel_scu_ipc_dev *scu;
 	int i, err;
 
 	mutex_lock(&ipclock);
-	if (scu->dev == NULL) {
+	if (!ipcdev) {
 		mutex_unlock(&ipclock);
 		return -ENODEV;
 	}
+	scu = ipcdev;
 
 	for (i = 0; i < inlen; i++)
 		ipc_data_writel(scu, *in++, 4 * i);
@@ -399,61 +405,113 @@ static irqreturn_t ioc(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static void intel_scu_ipc_release(struct device *dev)
+{
+	struct intel_scu_ipc_dev *scu;
+
+	scu = container_of(dev, struct intel_scu_ipc_dev, dev);
+	if (scu->irq > 0)
+		free_irq(scu->irq, scu);
+	iounmap(scu->ipc_base);
+	release_mem_region(scu->mem.start, resource_size(&scu->mem));
+	kfree(scu);
+}
+
 /**
- *	ipc_probe	-	probe an Intel SCU IPC
- *	@pdev: the PCI device matching
- *	@id: entry in the match table
+ * intel_scu_ipc_register() - Register SCU IPC device
+ * @parent: Parent device
+ * @scu_data: Data used to configure SCU IPC
  *
- *	Enable and install an intel SCU IPC. This appears in the PCI space
- *	but uses some hard coded addresses as well.
+ * Call this function to register SCU IPC mechanism under @parent.
+ * Returns pointer to the new SCU IPC device or ERR_PTR() in case of
+ * failure.
  */
-static int ipc_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+struct intel_scu_ipc_dev *
+intel_scu_ipc_register(struct device *parent,
+		       const struct intel_scu_ipc_data *scu_data)
 {
 	int err;
-	struct intel_scu_ipc_dev *scu = &ipcdev;
+	struct intel_scu_ipc_dev *scu;
+	void __iomem *ipc_base;
 
-	if (scu->dev)		/* We support only one SCU */
-		return -EBUSY;
+	mutex_lock(&ipclock);
+	/* We support only one IPC */
+	if (ipcdev) {
+		err = -EBUSY;
+		goto err_unlock;
+	}
 
-	err = pcim_enable_device(pdev);
-	if (err)
-		return err;
+	scu = kzalloc(sizeof(*scu), GFP_KERNEL);
+	if (!scu) {
+		err = -ENOMEM;
+		goto err_unlock;
+	}
 
-	err = pcim_iomap_regions(pdev, 1 << 0, pci_name(pdev));
-	if (err)
-		return err;
+	scu->dev.parent = parent;
+	scu->dev.class = &intel_scu_ipc_class;
+	scu->dev.release = intel_scu_ipc_release;
+	dev_set_name(&scu->dev, "intel_scu_ipc");
 
+	if (!request_mem_region(scu_data->mem.start, resource_size(&scu_data->mem),
+				"intel_scu_ipc")) {
+		err = -EBUSY;
+		goto err_free;
+	}
+
+	ipc_base = ioremap(scu_data->mem.start, resource_size(&scu_data->mem));
+	if (!ipc_base) {
+		err = -ENOMEM;
+		goto err_release;
+	}
+
+	scu->ipc_base = ipc_base;
+	scu->mem = scu_data->mem;
+	scu->irq = scu_data->irq;
 	init_completion(&scu->cmd_complete);
 
-	scu->ipc_base = pcim_iomap_table(pdev)[0];
+	if (scu->irq > 0) {
+		err = request_irq(scu->irq, ioc, 0, "intel_scu_ipc", scu);
+		if (err)
+			goto err_unmap;
+	}
 
-	err = devm_request_irq(&pdev->dev, pdev->irq, ioc, 0, "intel_scu_ipc",
-			       scu);
-	if (err)
-		return err;
+	/*
+	 * After this point intel_scu_ipc_release() takes care of
+	 * releasing the SCU IPC resources once refcount drops to zero.
+	 */
+	err = device_register(&scu->dev);
+	if (err) {
+		put_device(&scu->dev);
+		goto err_unlock;
+	}
 
 	/* Assign device at last */
-	scu->dev = &pdev->dev;
+	ipcdev = scu;
+	mutex_unlock(&ipclock);
 
-	intel_scu_devices_create();
+	return scu;
 
-	pci_set_drvdata(pdev, scu);
-	return 0;
+err_unmap:
+	iounmap(ipc_base);
+err_release:
+	release_mem_region(scu_data->mem.start, resource_size(&scu_data->mem));
+err_free:
+	kfree(scu);
+err_unlock:
+	mutex_unlock(&ipclock);
+
+	return ERR_PTR(err);
 }
+EXPORT_SYMBOL_GPL(intel_scu_ipc_register);
 
-static const struct pci_device_id pci_ids[] = {
-	{ PCI_VDEVICE(INTEL, 0x080e) },
-	{ PCI_VDEVICE(INTEL, 0x08ea) },
-	{ PCI_VDEVICE(INTEL, 0x11a0) },
-	{}
-};
+static int __init intel_scu_ipc_init(void)
+{
+	return class_register(&intel_scu_ipc_class);
+}
+subsys_initcall(intel_scu_ipc_init);
 
-static struct pci_driver ipc_driver = {
-	.driver = {
-		.suppress_bind_attrs = true,
-	},
-	.name = "intel_scu_ipc",
-	.id_table = pci_ids,
-	.probe = ipc_probe,
-};
-builtin_pci_driver(ipc_driver);
+static void __exit intel_scu_ipc_exit(void)
+{
+	class_unregister(&intel_scu_ipc_class);
+}
+module_exit(intel_scu_ipc_exit);
diff --git a/drivers/platform/x86/intel_scu_pcidrv.c b/drivers/platform/x86/intel_scu_pcidrv.c
new file mode 100644
index 000000000000..b869ec2eda0e
--- /dev/null
+++ b/drivers/platform/x86/intel_scu_pcidrv.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCI driver for the Intel SCU.
+ *
+ * Copyright (C) 2008-2010, 2015, 2020 Intel Corporation
+ * Authors: Sreedhara DS (sreedhara.ds@intel.com)
+ *	    Mika Westerberg <mika.westerberg@linux.intel.com>
+ */
+
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+
+#include <asm/intel-mid.h>
+#include <asm/intel_scu_ipc.h>
+
+static int intel_scu_pci_probe(struct pci_dev *pdev,
+			       const struct pci_device_id *id)
+{
+	struct intel_scu_ipc_data scu_data = {};
+	struct intel_scu_ipc_dev *scu;
+	int ret;
+
+	ret = pcim_enable_device(pdev);
+	if (ret)
+		return ret;
+
+	scu_data.mem = pdev->resource[0];
+	scu_data.irq = pdev->irq;
+
+	scu = intel_scu_ipc_register(&pdev->dev, &scu_data);
+	if (IS_ERR(scu))
+		return PTR_ERR(scu);
+
+	intel_scu_devices_create();
+	return 0;
+}
+
+static const struct pci_device_id pci_ids[] = {
+	{ PCI_VDEVICE(INTEL, 0x080e) },
+	{ PCI_VDEVICE(INTEL, 0x08ea) },
+	{ PCI_VDEVICE(INTEL, 0x11a0) },
+	{}
+};
+
+static struct pci_driver intel_scu_pci_driver = {
+	.driver = {
+		.suppress_bind_attrs = true,
+	},
+	.name = "intel_scu",
+	.id_table = pci_ids,
+	.probe = intel_scu_pci_probe,
+};
+
+builtin_pci_driver(intel_scu_pci_driver);
-- 
2.25.1

