Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8881BB1F4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 01:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgD0XVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 19:21:11 -0400
Received: from mga14.intel.com ([192.55.52.115]:55740 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbgD0XVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 19:21:10 -0400
IronPort-SDR: 9JY6oygYZumsvb30Nh4dQUuN/mg6VOPnyUmyrk91ky5mFUdAp4+6Agf+Wak8QDya6CGDvWoxws
 AQSm9RxzA9mg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 16:21:10 -0700
IronPort-SDR: I+okaA9dYREm86TfUOCtChXRqj0UojSvPRTf/Ki8hDbIw7eg9d6ftKAid/kzepCLI5JbgBBjFd
 q5qkcdychBuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,325,1583222400"; 
   d="scan'208";a="293691481"
Received: from coffy.sc.intel.com ([10.3.79.166])
  by orsmga008.jf.intel.com with ESMTP; 27 Apr 2020 16:21:09 -0700
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     dvhart@infradead.org, andy@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        maurice.ma@intel.com, ravi.p.rangarajan@intel.com,
        sean.v.kelley@intel.com, kuo-lang.tseng@intel.com,
        Jithu Joseph <jithu.joseph@intel.com>
Subject: [PATCH v3 1/1] platform/x86: Add Slim Bootloader firmware update signaling driver
Date:   Mon, 27 Apr 2020 16:15:14 -0700
Message-Id: <20200427231514.24777-2-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200427231514.24777-1-jithu.joseph@intel.com>
References: <20200427231514.24777-1-jithu.joseph@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Slim Bootloader(SBL) is a small open-source boot firmware,
designed for running on certain Intel platforms. SBL can be
thought-of as fulfilling the role of a minimal BIOS
implementation, i.e initializing the hardware and booting
Operating System.

Since SBL is not UEFI compliant, firmware update cannot be triggered
using standard UEFI runtime services. Further considering performance
impact, SBL doesn't look for a firmware update image on every reset
and does so only when firmware update signal is asserted.

SBL exposes an ACPI-WMI device which comes up in sysfs as
/sys/bus/wmi/44FADEB1xxx and this driver adds a
"firmware_update_request" device attribute. This attribute normally
has a value of 0 and userspace can signal SBL to update firmware,
on next reboot, by writing a value of 1 like:

echo 1 > /sys/bus/wmi/devices/44FADEB1xxx/firmware_update_request

This driver only implements a signaling mechanism, the actual firmware
update process and various details like firmware update image format,
firmware image location etc are defined by SBL and are not in the
scope of this driver.

DocLink: https://slimbootloader.github.io/security/firmware-update.html

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
---
 .../sysfs-platform-intel-wmi-sbl-fw-update    |  12 ++
 MAINTAINERS                                   |   7 +
 drivers/platform/x86/Kconfig                  |  10 ++
 drivers/platform/x86/Makefile                 |   1 +
 .../platform/x86/intel-wmi-sbl-fw-update.c    | 145 ++++++++++++++++++
 5 files changed, 175 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-intel-wmi-sbl-fw-update
 create mode 100644 drivers/platform/x86/intel-wmi-sbl-fw-update.c

diff --git a/Documentation/ABI/testing/sysfs-platform-intel-wmi-sbl-fw-update b/Documentation/ABI/testing/sysfs-platform-intel-wmi-sbl-fw-update
new file mode 100644
index 000000000000..5aa618987cad
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-intel-wmi-sbl-fw-update
@@ -0,0 +1,12 @@
+What:		/sys/bus/wmi/devices/44FADEB1-B204-40F2-8581-394BBDC1B651/firmware_update_request
+Date:		April 2020
+KernelVersion:	5.7
+Contact:	"Jithu Joseph" <jithu.joseph@intel.com>
+Description:
+		Allow user space entities to trigger update of Slim
+		Bootloader (SBL). This attribute normally has a value
+		of 0 and userspace can signal SBL to update firmware,
+		on next reboot, by writing a value of 1.
+		There are two available states:
+		    * 0 -> Skip firmware update while rebooting
+		    * 1 -> Attempt firmware update on next reboot
diff --git a/MAINTAINERS b/MAINTAINERS
index b816a453b10e..7f1355cb406b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8826,6 +8826,13 @@ F:	Documentation/admin-guide/wimax/i2400m.rst
 F:	drivers/net/wimax/i2400m/
 F:	include/uapi/linux/wimax/i2400m.h
 
+INTEL WMI SLIM BOOTLOADER (SBL) FIRMWARE UPDATE DRIVER
+M:	Jithu Joseph <jithu.joseph@intel.com>
+R:	Maurice Ma <maurice.ma@intel.com>
+S:	Maintained
+W:	https://slimbootloader.github.io/security/firmware-update.html
+F:	drivers/platform/x86/intel-wmi-sbl-fw-update.c
+
 INTEL WMI THUNDERBOLT FORCE POWER DRIVER
 M:	Mario Limonciello <mario.limonciello@dell.com>
 S:	Maintained
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 0ad7ad8cf8e1..68851f47b84a 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -78,6 +78,16 @@ config HUAWEI_WMI
 	  To compile this driver as a module, choose M here: the module
 	  will be called huawei-wmi.
 
+config INTEL_WMI_SBL_FW_UPDATE
+	tristate "Intel WMI Slim Bootloader firmware update signaling driver"
+	depends on ACPI_WMI
+	help
+	  Say Y here if you want to be able to use the WMI interface to signal
+	  Slim Bootloader to trigger update on next reboot.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called intel-wmi-sbl-fw-update.
+
 config INTEL_WMI_THUNDERBOLT
 	tristate "Intel WMI thunderbolt force power driver"
 	depends on ACPI_WMI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 53408d965874..1fa47d5cbed5 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_WMI_BMOF)		+= wmi-bmof.o
 # WMI drivers
 obj-$(CONFIG_ALIENWARE_WMI)		+= alienware-wmi.o
 obj-$(CONFIG_HUAWEI_WMI)		+= huawei-wmi.o
+obj-$(CONFIG_INTEL_WMI_SBL_FW_UPDATE)	+= intel-wmi-sbl-fw-update.o
 obj-$(CONFIG_INTEL_WMI_THUNDERBOLT)	+= intel-wmi-thunderbolt.o
 obj-$(CONFIG_MXM_WMI)			+= mxm-wmi.o
 obj-$(CONFIG_PEAQ_WMI)			+= peaq-wmi.o
diff --git a/drivers/platform/x86/intel-wmi-sbl-fw-update.c b/drivers/platform/x86/intel-wmi-sbl-fw-update.c
new file mode 100644
index 000000000000..ea87fa0786e8
--- /dev/null
+++ b/drivers/platform/x86/intel-wmi-sbl-fw-update.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Slim Bootloader(SBL) firmware update signaling driver
+ *
+ * Slim Bootloader is a small, open-source, non UEFI compliant, boot firmware
+ * optimized for running on certain Intel platforms.
+ *
+ * SBL exposes an ACPI-WMI device via /sys/bus/wmi/devices/<INTEL_WMI_SBL_GUID>.
+ * This driver further adds "firmware_update_request" device attribute.
+ * This attribute normally has a value of 0 and userspace can signal SBL
+ * to update firmware, on next reboot, by writing a value of 1.
+ *
+ * More details of SBL firmware update process is available at:
+ * https://slimbootloader.github.io/security/firmware-update.html
+ */
+
+#include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include <linux/wmi.h>
+
+#define INTEL_WMI_SBL_GUID  "44FADEB1-B204-40F2-8581-394BBDC1B651"
+
+static int get_fwu_request(struct device *dev, u32 *out)
+{
+	struct acpi_buffer result = {ACPI_ALLOCATE_BUFFER, NULL};
+	union acpi_object *obj;
+	acpi_status status;
+
+	status = wmi_query_block(INTEL_WMI_SBL_GUID, 0, &result);
+	if (ACPI_FAILURE(status)) {
+		dev_err(dev, "wmi_query_block failed\n");
+		return -ENODEV;
+	}
+
+	obj = (union acpi_object *)result.pointer;
+	if (!obj || obj->type != ACPI_TYPE_INTEGER) {
+		dev_warn(dev, "wmi_query_block returned invalid value\n");
+		kfree(obj);
+		return -EINVAL;
+	}
+
+	*out = obj->integer.value;
+	kfree(obj);
+
+	return 0;
+}
+
+static int set_fwu_request(struct device *dev, u32 in)
+{
+	struct acpi_buffer input;
+	acpi_status status;
+	u32 value;
+
+	value = in;
+	input.length = sizeof(u32);
+	input.pointer = &value;
+
+	status = wmi_set_block(INTEL_WMI_SBL_GUID, 0, &input);
+	if (ACPI_FAILURE(status)) {
+		dev_err(dev, "wmi_set_block failed\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static ssize_t firmware_update_request_show(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
+{
+	u32 val;
+	int ret;
+
+	ret = get_fwu_request(dev, &val);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%d\n", val);
+}
+
+static ssize_t firmware_update_request_store(struct device *dev,
+					     struct device_attribute *attr,
+					     const char *buf, size_t count)
+{
+	unsigned int val;
+	int ret;
+
+	ret = kstrtouint(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	/* May later be extended to support values other than 0 and 1 */
+	if (val > 1)
+		return -ERANGE;
+
+	ret = set_fwu_request(dev, val);
+	if (ret)
+		return ret;
+
+	return count;
+}
+static DEVICE_ATTR_RW(firmware_update_request);
+
+static struct attribute *firmware_update_attrs[] = {
+	&dev_attr_firmware_update_request.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(firmware_update);
+
+static int intel_wmi_sbl_fw_update_probe(struct wmi_device *wdev,
+					 const void *context)
+{
+	dev_info(&wdev->dev, "Slim Bootloader signaling driver attached\n");
+	return 0;
+}
+
+static int intel_wmi_sbl_fw_update_remove(struct wmi_device *wdev)
+{
+	dev_info(&wdev->dev, "Slim Bootloader signaling driver removed\n");
+	return 0;
+}
+
+static const struct wmi_device_id intel_wmi_sbl_id_table[] = {
+	{ .guid_string = INTEL_WMI_SBL_GUID },
+	{}
+};
+MODULE_DEVICE_TABLE(wmi, intel_wmi_sbl_id_table);
+
+static struct wmi_driver intel_wmi_sbl_fw_update_driver = {
+	.driver = {
+		.name = "intel-wmi-sbl-fw-update",
+		.dev_groups = firmware_update_groups,
+	},
+	.probe = intel_wmi_sbl_fw_update_probe,
+	.remove = intel_wmi_sbl_fw_update_remove,
+	.id_table = intel_wmi_sbl_id_table,
+};
+module_wmi_driver(intel_wmi_sbl_fw_update_driver);
+
+MODULE_AUTHOR("Jithu Joseph <jithu.joseph@intel.com>");
+MODULE_DESCRIPTION("Slim Bootloader firmware update signaling driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

