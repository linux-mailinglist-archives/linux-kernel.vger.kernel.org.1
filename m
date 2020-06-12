Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C041F7F7B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jun 2020 01:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgFLXPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jun 2020 19:15:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49058 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726310AbgFLXPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 19:15:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592003742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lwW5//Ms4E7Fyn4j9oJf7GLsDQ1aST8AjVuss6myfXA=;
        b=f0onVB3wxxniMN+aU/eocpI4XJtrODYPycVoyU3O45NpCPORhAkFHViI1Sw9cvjMNYWiTE
        BYLa7scqcT59alhrU3ZKM61+utDvbseI3yFxjaLqHtWO+Rop1oStUGSZxVHFfMH89NHoJS
        xIKcMy/rRa671PWZ9SBAOVcY7I0VLpA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-iM37GBLwOau9wqAmYNfa7Q-1; Fri, 12 Jun 2020 19:15:40 -0400
X-MC-Unique: iM37GBLwOau9wqAmYNfa7Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8EA9BA0BD7;
        Fri, 12 Jun 2020 23:15:39 +0000 (UTC)
Received: from cantor.redhat.com (ovpn-112-134.phx2.redhat.com [10.3.112.134])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 16E4B5D9C5;
        Fri, 12 Jun 2020 23:15:39 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     Joerg Roedel <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/2] iommu/vt-d: Move Kconfig and Makefile bits down into intel directory
Date:   Fri, 12 Jun 2020 16:10:59 -0700
Message-Id: <20200612231100.293734-2-jsnitsel@redhat.com>
In-Reply-To: <20200612231100.293734-1-jsnitsel@redhat.com>
References: <20200612231100.293734-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move Intel Kconfig and Makefile bits down into intel directory
with the rest of the Intel specific files.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/iommu/Kconfig        | 86 +-----------------------------------
 drivers/iommu/Makefile       |  8 +---
 drivers/iommu/intel/Kconfig  | 86 ++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/Makefile |  7 +++
 4 files changed, 96 insertions(+), 91 deletions(-)
 create mode 100644 drivers/iommu/intel/Kconfig
 create mode 100644 drivers/iommu/intel/Makefile

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index aca76383f201..b12d4ec124f6 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -176,91 +176,7 @@ config AMD_IOMMU_DEBUGFS
 	  This option is -NOT- intended for production environments, and should
 	  not generally be enabled.
 
-# Intel IOMMU support
-config DMAR_TABLE
-	bool
-
-config INTEL_IOMMU
-	bool "Support for Intel IOMMU using DMA Remapping Devices"
-	depends on PCI_MSI && ACPI && (X86 || IA64)
-	select IOMMU_API
-	select IOMMU_IOVA
-	select NEED_DMA_MAP_STATE
-	select DMAR_TABLE
-	select SWIOTLB
-	select IOASID
-	help
-	  DMA remapping (DMAR) devices support enables independent address
-	  translations for Direct Memory Access (DMA) from devices.
-	  These DMA remapping devices are reported via ACPI tables
-	  and include PCI device scope covered by these DMA
-	  remapping devices.
-
-config INTEL_IOMMU_DEBUGFS
-	bool "Export Intel IOMMU internals in Debugfs"
-	depends on INTEL_IOMMU && IOMMU_DEBUGFS
-	help
-	  !!!WARNING!!!
-
-	  DO NOT ENABLE THIS OPTION UNLESS YOU REALLY KNOW WHAT YOU ARE DOING!!!
-
-	  Expose Intel IOMMU internals in Debugfs.
-
-	  This option is -NOT- intended for production environments, and should
-	  only be enabled for debugging Intel IOMMU.
-
-config INTEL_IOMMU_SVM
-	bool "Support for Shared Virtual Memory with Intel IOMMU"
-	depends on INTEL_IOMMU && X86
-	select PCI_PASID
-	select PCI_PRI
-	select MMU_NOTIFIER
-	select IOASID
-	help
-	  Shared Virtual Memory (SVM) provides a facility for devices
-	  to access DMA resources through process address space by
-	  means of a Process Address Space ID (PASID).
-
-config INTEL_IOMMU_DEFAULT_ON
-	def_bool y
-	prompt "Enable Intel DMA Remapping Devices by default"
-	depends on INTEL_IOMMU
-	help
-	  Selecting this option will enable a DMAR device at boot time if
-	  one is found. If this option is not selected, DMAR support can
-	  be enabled by passing intel_iommu=on to the kernel.
-
-config INTEL_IOMMU_BROKEN_GFX_WA
-	bool "Workaround broken graphics drivers (going away soon)"
-	depends on INTEL_IOMMU && BROKEN && X86
-	---help---
-	  Current Graphics drivers tend to use physical address
-	  for DMA and avoid using DMA APIs. Setting this config
-	  option permits the IOMMU driver to set a unity map for
-	  all the OS-visible memory. Hence the driver can continue
-	  to use physical addresses for DMA, at least until this
-	  option is removed in the 2.6.32 kernel.
-
-config INTEL_IOMMU_FLOPPY_WA
-	def_bool y
-	depends on INTEL_IOMMU && X86
-	---help---
-	  Floppy disk drivers are known to bypass DMA API calls
-	  thereby failing to work when IOMMU is enabled. This
-	  workaround will setup a 1:1 mapping for the first
-	  16MiB to make floppy (an ISA device) work.
-
-config INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
-	bool "Enable Intel IOMMU scalable mode by default"
-	depends on INTEL_IOMMU
-	help
-	  Selecting this option will enable by default the scalable mode if
-	  hardware presents the capability. The scalable mode is defined in
-	  VT-d 3.0. The scalable mode capability could be checked by reading
-	  /sys/devices/virtual/iommu/dmar*/intel-iommu/ecap. If this option
-	  is not selected, scalable mode support could also be enabled by
-	  passing intel_iommu=sm_on to the kernel. If not sure, please use
-	  the default value.
+source "drivers/iommu/intel/Kconfig"
 
 config IRQ_REMAP
 	bool "Support for Interrupt Remapping"
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 342190196dfb..71dd2f382e78 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+obj-y += intel/
 obj-$(CONFIG_IOMMU_API) += iommu.o
 obj-$(CONFIG_IOMMU_API) += iommu-traces.o
 obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
@@ -17,13 +18,8 @@ obj-$(CONFIG_AMD_IOMMU_V2) += amd/iommu_v2.o
 obj-$(CONFIG_ARM_SMMU) += arm_smmu.o
 arm_smmu-objs += arm-smmu.o arm-smmu-impl.o arm-smmu-qcom.o
 obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
-obj-$(CONFIG_DMAR_TABLE) += intel/dmar.o
-obj-$(CONFIG_INTEL_IOMMU) += intel/iommu.o intel/pasid.o
-obj-$(CONFIG_INTEL_IOMMU) += intel/trace.o
-obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) += intel/debugfs.o
-obj-$(CONFIG_INTEL_IOMMU_SVM) += intel/svm.o
 obj-$(CONFIG_IPMMU_VMSA) += ipmmu-vmsa.o
-obj-$(CONFIG_IRQ_REMAP) += intel/irq_remapping.o irq_remapping.o
+obj-$(CONFIG_IRQ_REMAP) += irq_remapping.o
 obj-$(CONFIG_MTK_IOMMU) += mtk_iommu.o
 obj-$(CONFIG_MTK_IOMMU_V1) += mtk_iommu_v1.o
 obj-$(CONFIG_OMAP_IOMMU) += omap-iommu.o
diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
new file mode 100644
index 000000000000..ef5c4a7a9399
--- /dev/null
+++ b/drivers/iommu/intel/Kconfig
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Intel IOMMU support
+config DMAR_TABLE
+	bool
+
+config INTEL_IOMMU
+	bool "Support for Intel IOMMU using DMA Remapping Devices"
+	depends on PCI_MSI && ACPI && (X86 || IA64)
+	select IOMMU_API
+	select IOMMU_IOVA
+	select NEED_DMA_MAP_STATE
+	select DMAR_TABLE
+	select SWIOTLB
+	select IOASID
+	help
+	  DMA remapping (DMAR) devices support enables independent address
+	  translations for Direct Memory Access (DMA) from devices.
+	  These DMA remapping devices are reported via ACPI tables
+	  and include PCI device scope covered by these DMA
+	  remapping devices.
+
+config INTEL_IOMMU_DEBUGFS
+	bool "Export Intel IOMMU internals in Debugfs"
+	depends on INTEL_IOMMU && IOMMU_DEBUGFS
+	help
+	  !!!WARNING!!!
+
+	  DO NOT ENABLE THIS OPTION UNLESS YOU REALLY KNOW WHAT YOU ARE DOING!!!
+
+	  Expose Intel IOMMU internals in Debugfs.
+
+	  This option is -NOT- intended for production environments, and should
+	  only be enabled for debugging Intel IOMMU.
+
+config INTEL_IOMMU_SVM
+	bool "Support for Shared Virtual Memory with Intel IOMMU"
+	depends on INTEL_IOMMU && X86
+	select PCI_PASID
+	select PCI_PRI
+	select MMU_NOTIFIER
+	select IOASID
+	help
+	  Shared Virtual Memory (SVM) provides a facility for devices
+	  to access DMA resources through process address space by
+	  means of a Process Address Space ID (PASID).
+
+config INTEL_IOMMU_DEFAULT_ON
+	def_bool y
+	prompt "Enable Intel DMA Remapping Devices by default"
+	depends on INTEL_IOMMU
+	help
+	  Selecting this option will enable a DMAR device at boot time if
+	  one is found. If this option is not selected, DMAR support can
+	  be enabled by passing intel_iommu=on to the kernel.
+
+config INTEL_IOMMU_BROKEN_GFX_WA
+	bool "Workaround broken graphics drivers (going away soon)"
+	depends on INTEL_IOMMU && BROKEN && X86
+	help
+	  Current Graphics drivers tend to use physical address
+	  for DMA and avoid using DMA APIs. Setting this config
+	  option permits the IOMMU driver to set a unity map for
+	  all the OS-visible memory. Hence the driver can continue
+	  to use physical addresses for DMA, at least until this
+	  option is removed in the 2.6.32 kernel.
+
+config INTEL_IOMMU_FLOPPY_WA
+	def_bool y
+	depends on INTEL_IOMMU && X86
+	help
+	  Floppy disk drivers are known to bypass DMA API calls
+	  thereby failing to work when IOMMU is enabled. This
+	  workaround will setup a 1:1 mapping for the first
+	  16MiB to make floppy (an ISA device) work.
+
+config INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
+	bool "Enable Intel IOMMU scalable mode by default"
+	depends on INTEL_IOMMU
+	help
+	  Selecting this option will enable by default the scalable mode if
+	  hardware presents the capability. The scalable mode is defined in
+	  VT-d 3.0. The scalable mode capability could be checked by reading
+	  /sys/devices/virtual/iommu/dmar*/intel-iommu/ecap. If this option
+	  is not selected, scalable mode support could also be enabled by
+	  passing intel_iommu=sm_on to the kernel. If not sure, please use
+	  the default value.
diff --git a/drivers/iommu/intel/Makefile b/drivers/iommu/intel/Makefile
new file mode 100644
index 000000000000..fb8e1e8c8029
--- /dev/null
+++ b/drivers/iommu/intel/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_DMAR_TABLE) += dmar.o
+obj-$(CONFIG_INTEL_IOMMU) += iommu.o pasid.o
+obj-$(CONFIG_INTEL_IOMMU) += trace.o
+obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) += debugfs.o
+obj-$(CONFIG_INTEL_IOMMU_SVM) += svm.o
+obj-$(CONFIG_IRQ_REMAP) += irq_remapping.o
-- 
2.27.0

