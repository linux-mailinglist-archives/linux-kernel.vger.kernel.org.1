Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED2362C9232
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731194AbgK3XKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:10:14 -0500
Received: from mga06.intel.com ([134.134.136.31]:42873 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731152AbgK3XKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:10:11 -0500
IronPort-SDR: GRalcXGBpmjfj+tviMtP+NsMCcqOKQAC5c1jF7Bq9k0+qN0ZxgimxRnQEGL252Sv3VK1oVTGfR
 xqaY5ny7/3mw==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="234331878"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="234331878"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 15:07:10 -0800
IronPort-SDR: LQfKNXXoD/hPwUs3Lf+GQWpn5EiAIevF57BS0+UL7O8ILwZo/LW95Bupf2I9tJFjgFRPSRgnIx
 9zfl3Zda+wWg==
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="434447358"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 15:07:10 -0800
Received: from mtg-dev (mtg-dev.jf.intel.com [10.54.74.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.ostc.intel.com (Postfix) with ESMTPS id ECEDE636B;
        Mon, 30 Nov 2020 15:07:09 -0800 (PST)
Received: from mgross by mtg-dev with local (Exim 4.90_1)
        (envelope-from <mgross@linux.intel.com>)
        id 1kjsGD-000C4w-Qb; Mon, 30 Nov 2020 15:07:09 -0800
From:   mgross@linux.intel.com
To:     linux-kernel@vger.kernel.org
Cc:     markgross@kernel.org, mgross@linux.intel.com,
        adam.r.gretzinger@intel.com, Paul Murphy <paul.j.murphy@intel.com>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>
Subject: [PATCH 05/22] keembay-vpu-ipc: Add Keem Bay VPU IPC module
Date:   Mon, 30 Nov 2020 15:06:50 -0800
Message-Id: <20201130230707.46351-6-mgross@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201130230707.46351-1-mgross@linux.intel.com>
References: <20201130230707.46351-1-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Murphy <paul.j.murphy@intel.com>

Intel Keem Bay SoC contains a Vision Processing Unit (VPU) to enable
machine vision and other applications.

Enable Linux to control the VPU processor and provides an interface to
the Keem Bay IPC for communicating with the VPU firmware.

Specifically the driver provides the following functionality to other
kernel components:
- Starting (including loading the VPU firmware) / Stopping / Rebooting
  the   VPU.
- Getting notifications of VPU events (e.g., WDT events).
- Communicating with the VPU via the Keem Bay IPC mechanism.

In addition to the above, the driver also exposes SoC information (like
stepping, device ID, etc.) to user-space via sysfs. Specifically, the
following sysfs files are provided:
- /sys/firmware/keembay-vpu-ipc/device_id
- /sys/firmware/keembay-vpu-ipc/feature_exclusion
- /sys/firmware/keembay-vpu-ipc/hardware_id
- /sys/firmware/keembay-vpu-ipc/sku
- /sys/firmware/keembay-vpu-ipc/stepping

Reviewed-by: Mark Gross <mgross@linux.intel.com>
Signed-off-by: Paul Murphy <paul.j.murphy@intel.com>
Co-developed-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
Signed-off-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
Signed-off-by: Mark Gross <mgross@linux.intel.com>
---
 MAINTAINERS                               |    9 +
 drivers/soc/intel/Kconfig                 |   15 +
 drivers/soc/intel/Makefile                |    3 +-
 drivers/soc/intel/keembay-vpu-ipc.c       | 2036 +++++++++++++++++++++
 include/linux/soc/intel/keembay-vpu-ipc.h |   62 +
 5 files changed, 2124 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soc/intel/keembay-vpu-ipc.c
 create mode 100644 include/linux/soc/intel/keembay-vpu-ipc.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 64475ba4ea9d..f95cef927d19 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8963,6 +8963,15 @@ F:	Documentation/devicetree/bindings/soc/intel/intel,keembay-ipc.yaml
 F:	drivers/soc/intel/keembay-ipc.c
 F:	include/linux/soc/intel/keembay-ipc.h
 
+INTEL KEEM BAY VPU IPC DRIVER
+M:	Paul J Murphy <paul.j.murphy@intel.com>
+M:	Daniele Alessandrelli <daniele.alessandrelli@intel.com>
+M:	Mark Gross <mgross@linux.intel.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/soc/intel/intel,keembay-vpu-ipc.yaml
+F:	drivers/soc/intel/keembay-vpu-ipc.c
+F:	include/linux/soc/intel/keembay-vpu-ipc.h
+
 INTEL MANAGEMENT ENGINE (mei)
 M:	Tomas Winkler <tomas.winkler@intel.com>
 L:	linux-kernel@vger.kernel.org
diff --git a/drivers/soc/intel/Kconfig b/drivers/soc/intel/Kconfig
index 1f5c05b97649..83ce8c4a7851 100644
--- a/drivers/soc/intel/Kconfig
+++ b/drivers/soc/intel/Kconfig
@@ -14,4 +14,19 @@ config KEEMBAY_IPC
 
 	  Select this if you are compiling the Kernel for an Intel SoC that
 	  includes the Intel Vision Processing Unit (VPU) such as Keem Bay.
+
+config KEEMBAY_VPU_IPC
+	tristate "Intel Keem Bay VPU IPC Driver"
+	depends on KEEMBAY_IPC
+	depends on HAVE_ARM_SMCCC
+	help
+	  This option enables support for loading and communicating with
+	  the firmware on the Vision Processing Unit (VPU) of the Keem Bay
+	  SoC. The driver depends on the Keem Bay IPC driver to do
+	  communication, and it depends on secure world monitor software to
+	  do the control of the VPU state.
+
+	  Select this if you are compiling the Kernel for an Intel SoC that
+	  includes the Intel Vision Processing Unit (VPU) such as Keem Bay.
+
 endmenu
diff --git a/drivers/soc/intel/Makefile b/drivers/soc/intel/Makefile
index ecf0246e7822..363a81848843 100644
--- a/drivers/soc/intel/Makefile
+++ b/drivers/soc/intel/Makefile
@@ -1,4 +1,5 @@
 #
 # Makefile for Keem Bay IPC Linux driver
 #
-obj-$(CONFIG_KEEMBAY_IPC) += keembay-ipc.o
+obj-$(CONFIG_KEEMBAY_IPC)	+= keembay-ipc.o
+obj-$(CONFIG_KEEMBAY_VPU_IPC)	+= keembay-vpu-ipc.o
diff --git a/drivers/soc/intel/keembay-vpu-ipc.c b/drivers/soc/intel/keembay-vpu-ipc.c
new file mode 100644
index 000000000000..bcf9bb4a225a
--- /dev/null
+++ b/drivers/soc/intel/keembay-vpu-ipc.c
@@ -0,0 +1,2036 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Keem Bay VPU IPC Driver.
+ *
+ * Copyright (c) 2018-2020 Intel Corporation.
+ *
+ * The purpose of this driver is to facilitate booting, control and
+ * communication with the VPU IP on the Keem Bay SoC.
+ *
+ * Specifically the driver provides the following functionality to other kernel
+ * components:
+ * - Loading the VPU firmware into DDR for the VPU to execute.
+ * - Starting / Stopping / Rebooting the VPU.
+ * - Getting notifications of VPU events (e.g., WDT events).
+ * - Communicating with the VPU using the Keem Bay IPC mechanism.
+ *
+ * In addition to the above, the driver also exposes SoC information (like
+ * stepping, device ID, etc.) to user-space via sysfs.
+ *
+ *
+ * VPU Firmware loading
+ * --------------------
+ *
+ * The VPU Firmware consists of both the RTOS and the application code meant to
+ * be run by the VPU.
+ *
+ * The VPU Firmware is loaded into DDR using the Linux Firmware API. The
+ * firmware is loaded into a specific reserved memory region in DDR and
+ * executed by the VPU directly from there.
+ *
+ * The VPU Firmware binary is expected to have the following format:
+ *
+ * +------------------+ 0x0
+ * | Header           |
+ * +------------------+ 0x1000
+ * | FW Version Area  |
+ * +------------------+ 0x2000
+ * | FW Image         |
+ * +------------------+ 0x2000 + FW image size
+ * | x509 Certificate |
+ * +------------------+
+ *
+ * Note: the x509 Certificate is ignored for now.
+ *
+ * As part of the firmware loading process, the driver performs the following
+ * operations:
+ * - It parses the VPU firmware binary.
+ * - It loads the FW version area to the DDR location expected by the VPU
+ *   firmware and specified in the FW header.
+ * - It loads the FW image to the location specified in the FW header.
+ * - It prepares the boot parameters to be passed to the VPU firmware and loads
+ *   them at the location specified in the FW header.
+ *
+ * VPU Start / Stop / Reboot
+ * -------------------------
+ *
+ * The VPU is started / stopped by the SoC firmware, not by this driver
+ * directly. This driver just calls the VPU_BOOT and VPU_STOP SMC SiP services
+ * provided by the SoC firmware.
+ *
+ * Reboot is performed by stopping and re-starting the VPU, including
+ * re-loading the VPU firmware (this is because the VPU firmware .data and .bss
+ * sections need to be re-initialized).
+ *
+ * Sysfs interface
+ * ---------------
+ *
+ * This module exposes SoC information via sysfs. The following sysfs files are
+ * created by this module:
+ * - /sys/firmware/keembay-vpu-ipc/device_id
+ * - /sys/firmware/keembay-vpu-ipc/feature_exclusion
+ * - /sys/firmware/keembay-vpu-ipc/hardware_id
+ * - /sys/firmware/keembay-vpu-ipc/sku
+ * - /sys/firmware/keembay-vpu-ipc/stepping
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/clk.h>
+#include <linux/dma-direct.h>
+#include <linux/dma-mapping.h>
+#include <linux/firmware.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/kthread.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include <linux/soc/intel/keembay-ipc.h>
+#include <linux/soc/intel/keembay-vpu-ipc.h>
+
+/* Function ID for the SiP SMC to boot the VPU */
+#define KMB_SIP_SVC_VPU_BOOT		0xFF10
+
+/* Function ID for the SiP SMC to stop the VPU */
+#define KMB_SIP_SVC_VPU_STOP		0xFF16
+
+/* Device tree "memory-region" for VPU firmware area */
+#define VPU_IPC_FW_AREA_IDX		0
+
+/* Device tree region for VPU driver to store X509 region */
+#define VPU_IPC_X509_AREA_IDX		1
+
+/* Device tree "memory-region" for MSS IPC header area */
+#define MSS_IPC_AREA_IDX		2
+
+/*
+ * These are the parameters of the ready message to be received
+ * from the VPU when it is booted correctly.
+ */
+#define READY_MESSAGE_IPC_CHANNEL	0xA
+
+/* Ready message timeout, in ms */
+#define READY_MESSAGE_TIMEOUT_MS	2000
+
+/* Ready message 'physical data address', which is actually a command. */
+#define READY_MESSAGE_EXPECTED_PADDR	0x424f4f54
+
+/* Ready message size */
+#define READY_MESSAGE_EXPECTED_SIZE	0
+
+/* Size of version information in the header */
+#define VPU_VERSION_SIZE		32
+
+/* Version of header that this driver supports. */
+#define HEADER_VERSION_SUPPORTED	0x1
+
+/* Maximum size allowed for firmware version region */
+#define MAX_FIRMWARE_VERSION_SIZE	0x1000
+
+/* Size allowed for header region */
+#define MAX_HEADER_SIZE			0x1000
+
+/* VPU reset vector must be aligned to 4kB. */
+#define VPU_RESET_VECTOR_ALIGNMENT	0x1000
+
+/* Watchdog timer reset trigger */
+#define TIM_WATCHDOG			0x0
+
+/* Watchdog counter enable register */
+#define TIM_WDOG_EN			0x8
+
+/* Write access to protected registers */
+#define TIM_SAFE			0xC
+
+/* Watchdog timer count value */
+#define TIM_WATCHDOG_RESET_VALUE	0xFFFFFFFF
+
+/* Watchdog timer safe value */
+#define TIM_SAFE_ENABLE			0xf1d0dead
+
+/* Watchdog timeout interrupt clear bit */
+#define TIM_GEN_CONFIG_WDOG_TO_INT_CLR	BIT(9)
+
+/* Magic number for the boot parameters. */
+#define BOOT_PARAMS_MAGIC_NUMBER	0x00010000
+
+/* Maximum size of string of form "pll_i_out_j" */
+#define PLL_STRING_SIZE			128
+
+/* Number of PLLs */
+#define NUM_PLLS			3
+
+/* Every PLL has this many outputs. */
+#define NUM_PLL_OUTPUTS			4
+
+/* SoC SKU length, in bytes. */
+#define SOC_INFO_SKU_BYTES		6
+
+/* SoC stepping length, in bytes. */
+#define SOC_INFO_STEPPING_BYTES		2
+
+/**
+ * struct boot_parameters - Boot parameters passed to the VPU.
+ * @magic_number:		Magic number to indicate structure populated
+ * @vpu_id:			ID to be passed to the VPU firmware.
+ * @reserved_0:			Reserved memory for other 'header' information
+ * @cpu_frequency_hz:		Frequency that the CPU is running at
+ * @pll0_out:			Frequency of each of the outputs of PLL 0
+ * @pll1_out:			Frequency of each of the outputs of PLL 1
+ * @pll2_out:			Frequency of each of the outputs of PLL 2
+ * @reserved_1:			Reserved memory for other clock frequencies
+ * @mss_ipc_header_address:	Base address of MSS IPC header region
+ * @mss_ipc_header_area_size:	Size of MSS IPC header region
+ * @mmio_address:		MMIO region for VPU communication
+ * @mmio_area_size:		Size of MMIO region for VPU communication
+ * @reserved_2:			Reserved memory for other memory regions
+ * @mss_wdt_to_irq_a53_redir:	MSS redirects WDT TO IRQ to this ARM IRQ number
+ * @nce_wdt_to_irq_a53_redir:	NCE redirects WDT TO IRQ to this ARM IRQ number
+ * @vpu_to_host_irq:		VPU to host notification IRQ
+ * @reserved_3:			Reserved memory for other configurations
+ * @a53ss_version_id:		SoC A53SS_VERSION_ID register value
+ * @si_stepping:		Silicon stepping, 2 characters
+ * @device_id:			64 bits of device ID info from fuses
+ * @feature_exclusion:		64 bits of feature exclusion info from fuses
+ * @sku:			64-bit SKU identifier.
+ * @reserved_4:			Reserved memory for other information
+ * @reserved_5:			Unused/reserved memory
+ */
+struct boot_parameters {
+	/* Header: 0x0 - 0x1F */
+	u32 magic_number;
+	u32 vpu_id;
+	u32 reserved_0[6];
+	/* Clock frequencies: 0x20 - 0xFF */
+	u32 cpu_frequency_hz;
+	u32 pll0_out[NUM_PLL_OUTPUTS];
+	u32 pll1_out[NUM_PLL_OUTPUTS];
+	u32 pll2_out[NUM_PLL_OUTPUTS];
+	u32 reserved_1[43];
+	/* Memory regions: 0x100 - 0x1FF */
+	u64 mss_ipc_header_address;
+	u32 mss_ipc_header_area_size;
+	u64 mmio_address;
+	u32 mmio_area_size;
+	u32 reserved_2[58];
+	/* IRQ re-direct numbers: 0x200 - 0x2FF */
+	u32 mss_wdt_to_irq_a53_redir;
+	u32 nce_wdt_to_irq_a53_redir;
+	u32 vpu_to_host_irq;
+	u32 reserved_3[61];
+	/* Silicon information: 0x300 - 0x3FF */
+	u32 a53ss_version_id;
+	u32 si_stepping;
+	u64 device_id;
+	u64 feature_exclusion;
+	u64 sku;
+	u32 reserved_4[56];
+	/* Unused/reserved: 0x400 - 0xFFF */
+	u32 reserved_5[0x300];
+} __packed;
+
+/**
+ * struct firmware_header - Firmware header information
+ * @header_ver:	This header version dictates content structure of
+ *			remainder of firmware image, including the header
+ *			itself.
+ * @image_format:	Image format defines how the loader will handle the
+ *			'firmware image'.
+ * @image_load_addr:	VPU address where the firmware image must be loaded to.
+ * @image_size:		Size of the image.
+ * @entry_point:	Entry point for the VPU firmware (this is a VPU
+ *			address).
+ * @vpu_ver:		Version of the VPU firmware.
+ * @compression_type:	Type of compression used for the VPU firmware.
+ * @fw_ver_load_addr: VPU address where to load the data in the FW version
+ *			area of the binary.
+ * @fw_ver_size:	Size of the FW version.
+ * @config_load_addr:	VPU IPC driver will populate the 4kB of configuration
+ *			data to this address.
+ */
+struct firmware_header {
+	u32 header_ver;
+	u32 image_format;
+	u64 image_load_addr;
+	u32 image_size;
+	u64 entry_point;
+	u8  vpu_ver[VPU_VERSION_SIZE];
+	u32 compression_type;
+	u64 fw_ver_load_addr;
+	u32 fw_ver_size;
+	u64 config_load_addr;
+} __packed;
+
+/**
+ * struct vpu_mem - Information about reserved memory shared with VPU.
+ * @vaddr:	The virtual address of the memory region.
+ * @paddr:	The (CPU) physical address of the memory region.
+ * @vpu_addr:	The VPU address of the memory region.
+ * @size:	The size of the memory region.
+ */
+struct vpu_mem {
+	void *vaddr;
+	phys_addr_t paddr;
+	dma_addr_t vpu_addr;
+	size_t size;
+};
+
+/**
+ * struct vpu_mem - Information about reserved memory shared with ATF.
+ * @vaddr:	The virtual address of the memory region.
+ * @paddr:	The physical address of the memory region.
+ * @size:	The size of the memory region.
+ */
+struct atf_mem {
+	void __iomem *vaddr;
+	phys_addr_t paddr;
+	size_t size;
+};
+
+/**
+ * struct vpu_ipc_dev - The VPU IPC device structure.
+ * @pdev:		Platform device associated with this VPU IPC device.
+ * @state:		The current state of the device's finite state machine.
+ * @reserved_mem:	VPU firmware reserved memory region. The VPU firmware,
+ *			VPU firmware version and the boot parameters are loaded
+ *			inside this region.
+ * @x509_mem:		x509 reserved memory region.
+ * @mss_ipc_mem:	The reserved memory from which the VPU is expected to
+ *			allocate its own IPC buffers.
+ * @boot_vec_paddr:	The VPU entry point (as specified in the VPU FW binary).
+ * @boot_params:	Pointer to the VPU boot parameters.
+ * @fw_res:		The memory region where the VPU FW was loaded.
+ * @ready_message_task: The ktrhead instantiated to handle the reception of the
+ *			VPU ready message.
+ * @lock:		Spinlock protecting @state.
+ * @cpu_clock:		The main clock powering the VPU IP.
+ * @pll:		Array of PLL clocks.
+ * @nce_irq:		IRQ number of the A53 re-direct IRQ used for receiving
+ *			the NCE WDT timeout interrupt.
+ * @mss_irq:		IRQ number of the A53 re-direct IRQ which will be used
+ *			for receiving the MSS WDT timeout interrupt.
+ * @nce_wdt_redirect:   Re-direct IRQ for NCE ICB.
+ * @mss_wdt_redirect:	Re-direct IRQ for MSS ICB.
+ * @imr:		Isolated Memory Region (IMR) to be used to protect the
+ *			loaded VPU firmware.
+ * @vpu_id:		The ID of the VPU associated with this device.
+ * @nce_wdt_reg:	NCE WDT registers.
+ * @nce_tim_cfg_reg:	NCE TIM registers.
+ * @mss_wdt_reg:	MSS WDT registers.
+ * @mss_tim_cfg_reg:	MSS TIM registers.
+ * @nce_wdt_count:	Number of NCE WDT timeout event occurred since device
+ *			probing.
+ * @mss_wdt_count:	Number of MSS WDT timeout event occurred since device
+ *			probing.
+ * @ready_queue:	Wait queue for waiting on VPU to be ready.
+ * @ipc_dev:		The IPC device to use for IPC communication.
+ * @firmware_name:	The name of the firmware binary to be loaded.
+ * @callback:		The callback executed when CONNECT / DISCONNECT events
+ *			happen.
+ */
+struct vpu_ipc_dev {
+	struct platform_device *pdev;
+	enum intel_keembay_vpu_state state;
+	struct vpu_mem reserved_mem;
+	struct atf_mem x509_mem;
+	struct vpu_mem mss_ipc_mem;
+	u64 boot_vec_paddr;
+	struct boot_parameters *boot_params;
+	struct resource fw_res;
+	struct task_struct *ready_message_task;
+	spinlock_t lock; /* Protects the 'state' field above. */
+	struct clk *cpu_clock;
+	struct clk *pll[NUM_PLLS][NUM_PLL_OUTPUTS];
+	int nce_irq;
+	int mss_irq;
+	u32 nce_wdt_redirect;
+	u32 mss_wdt_redirect;
+	u32 imr;
+	u32 vpu_id;
+	void __iomem *nce_wdt_reg;
+	void __iomem *nce_tim_cfg_reg;
+	void __iomem *mss_wdt_reg;
+	void __iomem *mss_tim_cfg_reg;
+	unsigned int nce_wdt_count;
+	unsigned int mss_wdt_count;
+	wait_queue_head_t ready_queue;
+	struct device *ipc_dev;
+	char *firmware_name;
+	void (*callback)(struct device *dev, enum intel_keembay_vpu_event);
+};
+
+/**
+ * struct vpu_ipc_soc_info - VPU SKU information.
+ * @device_id:		Value of device ID e-fuse.
+ * @feature_exclusion:	Value of feature exclusion e-fuse.
+ * @hardware_id:	Hardware identifier.
+ * @stepping:		Silicon stepping.
+ * @sku:		SKU identifier.
+ *
+ * SoC information read from the device-tree and exported via sysfs.
+ */
+struct vpu_ipc_soc_info {
+	u64 device_id;
+	u64 feature_exclusion;
+	u32 hardware_id;
+	u8 stepping[SOC_INFO_STEPPING_BYTES];
+	u8 sku[SOC_INFO_SKU_BYTES];
+};
+
+/**
+ * enum keembay_vpu_event - Internal events handled by the driver state machine.
+ * @KEEMBAY_VPU_EVENT_BOOT:		VPU booted.
+ * @KEEMBAY_VPU_EVENT_BOOT_FAILED:	VPU boot failed.
+ * @KEEMBAY_VPU_EVENT_STOP:		VPU stop initiated.
+ * @KEEMBAY_VPU_EVENT_STOP_COMPLETE:	VPU stop completed.
+ * @KEEMBAY_VPU_EVENT_NCE_WDT_TIMEOUT:	NCE watchdog triggered.
+ * @KEEMBAY_VPU_EVENT_MSS_WDT_TIMEOUT:	MSS watchdog triggered.
+ * @KEEMBAY_VPU_EVENT_MSS_READY_OK:	VPU ready message successfully received.
+ * @KEEMBAY_VPU_EVENT_MSS_READY_FAIL:	Failed to receive VPU ready message.
+ */
+enum keembay_vpu_event {
+	KEEMBAY_VPU_EVENT_BOOT = 0,
+	KEEMBAY_VPU_EVENT_BOOT_FAILED,
+	KEEMBAY_VPU_EVENT_STOP,
+	KEEMBAY_VPU_EVENT_STOP_COMPLETE,
+	KEEMBAY_VPU_EVENT_NCE_WDT_TIMEOUT,
+	KEEMBAY_VPU_EVENT_MSS_WDT_TIMEOUT,
+	KEEMBAY_VPU_EVENT_MSS_READY_OK,
+	KEEMBAY_VPU_EVENT_MSS_READY_FAIL
+};
+
+static struct vpu_ipc_dev *to_vpu_dev(struct device *dev);
+
+/* Variable containing SoC information. */
+static struct vpu_ipc_soc_info *vpu_ipc_soc_info;
+
+/**
+ * vpu_ipc_notify_event() - Trigger callback
+ * @vpu_dev:		Private data
+ * @event:		Event to notify
+ *
+ * This function is called when an event has occurred. If a callback has
+ * been registered it is called with the device and event as arguments.
+ *
+ * This function can be called from interrupt context.
+ */
+static void vpu_ipc_notify_event(struct vpu_ipc_dev *vpu_dev,
+				 enum intel_keembay_vpu_event event)
+{
+	struct device *dev = &vpu_dev->pdev->dev;
+
+	if (vpu_dev->callback)
+		vpu_dev->callback(dev, event);
+}
+
+/**
+ * vpu_ipc_handle_event() - Handle events and optionally update state
+ *
+ * @vpu_dev:		Private data
+ * @event:		Event that has occurred
+ *
+ * This function is called in the case that an event has occurred. This
+ * function tells the calling code if the event is valid for the current state
+ * and also updates the internal state accordingly to the event.
+ *
+ * This function can be called from interrupt context.
+ *
+ * Returns: 0 for success otherwise negative error value
+ */
+static int vpu_ipc_handle_event(struct vpu_ipc_dev *vpu_dev,
+				enum keembay_vpu_event event)
+{
+	struct device *dev = &vpu_dev->pdev->dev;
+	unsigned long flags;
+	int rc = -EINVAL;
+
+	/*
+	 * Atomic update of state.
+	 * Note: this function is called by the WDT IRQ handlers; therefore
+	 * we must use the spin_lock_irqsave().
+	 */
+	spin_lock_irqsave(&vpu_dev->lock, flags);
+
+	switch (vpu_dev->state) {
+	case KEEMBAY_VPU_OFF:
+		if (event == KEEMBAY_VPU_EVENT_BOOT) {
+			vpu_dev->state = KEEMBAY_VPU_BUSY;
+			rc = 0;
+		}
+		break;
+	case KEEMBAY_VPU_BUSY:
+		if (event == KEEMBAY_VPU_EVENT_MSS_READY_OK) {
+			vpu_dev->state = KEEMBAY_VPU_READY;
+			vpu_ipc_notify_event(vpu_dev,
+					     KEEMBAY_VPU_NOTIFY_CONNECT);
+			rc = 0;
+			break;
+		}
+		if (event == KEEMBAY_VPU_EVENT_MSS_READY_FAIL ||
+		    event == KEEMBAY_VPU_EVENT_BOOT_FAILED) {
+			vpu_dev->state = KEEMBAY_VPU_ERROR;
+			rc = 0;
+		}
+		break;
+	case KEEMBAY_VPU_READY:
+		if (event != KEEMBAY_VPU_EVENT_MSS_READY_OK)
+			vpu_ipc_notify_event(vpu_dev,
+					     KEEMBAY_VPU_NOTIFY_DISCONNECT);
+
+		if (event == KEEMBAY_VPU_EVENT_MSS_READY_FAIL ||
+		    event == KEEMBAY_VPU_EVENT_BOOT_FAILED) {
+			vpu_dev->state = KEEMBAY_VPU_ERROR;
+			rc = 0;
+			break;
+		}
+		if (event == KEEMBAY_VPU_EVENT_NCE_WDT_TIMEOUT ||
+		    event == KEEMBAY_VPU_EVENT_MSS_WDT_TIMEOUT) {
+			vpu_dev->state = KEEMBAY_VPU_ERROR;
+			rc = 0;
+			break;
+		}
+		fallthrough;
+	case KEEMBAY_VPU_ERROR:
+		if (event == KEEMBAY_VPU_EVENT_BOOT) {
+			vpu_dev->state = KEEMBAY_VPU_BUSY;
+			rc = 0;
+			break;
+		}
+		if (event == KEEMBAY_VPU_EVENT_STOP) {
+			vpu_dev->state = KEEMBAY_VPU_STOPPING;
+			rc = 0;
+		}
+		break;
+	case KEEMBAY_VPU_STOPPING:
+		if (event == KEEMBAY_VPU_EVENT_STOP_COMPLETE) {
+			vpu_dev->state = KEEMBAY_VPU_OFF;
+			rc = 0;
+		}
+		break;
+	default:
+		break;
+	}
+
+	spin_unlock_irqrestore(&vpu_dev->lock, flags);
+
+	if (rc)
+		dev_err(dev, "Can't handle event %d in state %d\n",
+			event, vpu_dev->state);
+
+	return rc;
+}
+
+/**
+ * clear_and_disable_vpu_wdt() - Clear and disable VPU WDT.
+ * @wdt_base:		Base address of the WDT register.
+ * @tim_cfg_base:	Base address of the associated TIM configuration
+ *			register.
+ */
+static void clear_and_disable_vpu_wdt(u8 __iomem *wdt_base,
+				      u8 __iomem *tim_cfg_base)
+{
+	u32 tim_gen_config;
+
+	/* Enable writing and set non-zero WDT value */
+	iowrite32(TIM_SAFE_ENABLE, wdt_base + TIM_SAFE);
+	iowrite32(TIM_WATCHDOG_RESET_VALUE, wdt_base + TIM_WATCHDOG);
+
+	/* Enable writing and disable watchdog timer */
+	iowrite32(TIM_SAFE_ENABLE, wdt_base + TIM_SAFE);
+	iowrite32(0, wdt_base + TIM_WDOG_EN);
+
+	/* Now clear the timeout interrupt */
+	tim_gen_config = ioread32(tim_cfg_base);
+	tim_gen_config &= ~(TIM_GEN_CONFIG_WDOG_TO_INT_CLR);
+	iowrite32(tim_gen_config, tim_cfg_base);
+}
+
+static irqreturn_t nce_wdt_irq_handler(int irq, void *ptr)
+{
+	struct vpu_ipc_dev *vpu_dev = ptr;
+	struct device *dev = &vpu_dev->pdev->dev;
+	int rc;
+
+	vpu_ipc_notify_event(vpu_dev, KEEMBAY_VPU_NOTIFY_NCE_WDT);
+	dev_dbg_ratelimited(dev, "NCE WDT IRQ occurred.\n");
+
+	clear_and_disable_vpu_wdt(vpu_dev->nce_wdt_reg,
+				  vpu_dev->nce_tim_cfg_reg);
+	/* Update driver state machine. */
+	rc = vpu_ipc_handle_event(vpu_dev, KEEMBAY_VPU_EVENT_NCE_WDT_TIMEOUT);
+	if (rc < 0)
+		dev_warn_ratelimited(dev, "Unexpected NCE WDT event.\n");
+
+	vpu_dev->nce_wdt_count++;
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t mss_wdt_irq_handler(int irq, void *ptr)
+{
+	struct vpu_ipc_dev *vpu_dev = ptr;
+	struct device *dev = &vpu_dev->pdev->dev;
+	int rc;
+
+	vpu_ipc_notify_event(vpu_dev, KEEMBAY_VPU_NOTIFY_MSS_WDT);
+	dev_dbg_ratelimited(dev, "MSS WDT IRQ occurred.\n");
+
+	clear_and_disable_vpu_wdt(vpu_dev->mss_wdt_reg,
+				  vpu_dev->mss_tim_cfg_reg);
+	/* Update driver state machine. */
+	rc = vpu_ipc_handle_event(vpu_dev, KEEMBAY_VPU_EVENT_MSS_WDT_TIMEOUT);
+	if (rc < 0)
+		dev_warn_ratelimited(dev, "Unexpected MSS WDT event.\n");
+
+	vpu_dev->mss_wdt_count++;
+
+	return IRQ_HANDLED;
+}
+
+static resource_size_t get_reserved_mem_size(struct device *dev,
+					     unsigned int idx)
+{
+	struct resource mem;
+	struct device_node *np;
+	int rc;
+
+	np = of_parse_phandle(dev->of_node, "memory-region", idx);
+	if (!np) {
+		pr_err("Couldn't find memory-region %d\n", idx);
+		return 0;
+	}
+
+	rc = of_address_to_resource(np, 0, &mem);
+	if (rc) {
+		pr_err("Couldn't map address to resource\n");
+		return 0;
+	}
+
+	return resource_size(&mem);
+}
+
+static int setup_vpu_fw_region(struct vpu_ipc_dev *vpu_dev)
+{
+	struct device *dev = &vpu_dev->pdev->dev;
+	struct vpu_mem *rsvd_mem = &vpu_dev->reserved_mem;
+	int rc;
+
+	rc = of_reserved_mem_device_init(dev);
+	if (rc) {
+		dev_err(dev, "Failed to initialise device reserved memory.\n");
+		return rc;
+	}
+
+	rsvd_mem->size = get_reserved_mem_size(dev, VPU_IPC_FW_AREA_IDX);
+	if (rsvd_mem->size == 0) {
+		dev_err(dev, "Couldn't get size of reserved memory region.\n");
+		rc = -ENODEV;
+		goto setup_vpu_fw_fail;
+	}
+
+	rsvd_mem->vaddr = dmam_alloc_coherent(dev, rsvd_mem->size,
+					      &rsvd_mem->vpu_addr, GFP_KERNEL);
+	/* Get the physical address of the reserved memory region. */
+	rsvd_mem->paddr = dma_to_phys(dev, vpu_dev->reserved_mem.vpu_addr);
+
+	if (!rsvd_mem->vaddr) {
+		dev_err(dev, "Failed to allocate memory for firmware.\n");
+		rc = -ENOMEM;
+		goto setup_vpu_fw_fail;
+	}
+
+	return 0;
+
+setup_vpu_fw_fail:
+	of_reserved_mem_device_release(dev);
+
+	return rc;
+}
+
+static int setup_x509_region(struct vpu_ipc_dev *vpu_dev)
+{
+	struct device *dev = &vpu_dev->pdev->dev;
+	struct device_node *node;
+	struct resource res;
+	int rc;
+
+	node = of_parse_phandle(dev->of_node, "memory-region",
+				VPU_IPC_X509_AREA_IDX);
+	if (!node) {
+		dev_err(dev, "Couldn't find X509 region.\n");
+		return -EINVAL;
+	}
+
+	rc = of_address_to_resource(node, 0, &res);
+
+	/* Release node first as we will not use it anymore */
+	of_node_put(node);
+
+	if (rc) {
+		dev_err(dev, "Couldn't resolve X509 region.\n");
+		return rc;
+	}
+
+	vpu_dev->x509_mem.vaddr =
+		devm_ioremap(dev, res.start, resource_size(&res));
+	if (!vpu_dev->x509_mem.vaddr) {
+		dev_err(dev, "Couldn't ioremap x509 region.\n");
+		return -EADDRNOTAVAIL;
+	}
+
+	vpu_dev->x509_mem.paddr = res.start;
+	vpu_dev->x509_mem.size = resource_size(&res);
+
+	return 0;
+}
+
+static int setup_mss_ipc_region(struct vpu_ipc_dev *vpu_dev)
+{
+	struct device *dev = &vpu_dev->pdev->dev;
+	struct device_node *node;
+	struct resource res;
+	int rc;
+
+	node = of_parse_phandle(dev->of_node, "memory-region",
+				MSS_IPC_AREA_IDX);
+	if (!node) {
+		dev_err(dev, "Didn't find MSS IPC region.\n");
+		return -EINVAL;
+	}
+
+	rc = of_address_to_resource(node, 0, &res);
+	if (rc) {
+		dev_err(dev, "Couldn't resolve MSS IPC region.\n");
+		return rc;
+	}
+	of_node_put(node);
+
+	vpu_dev->mss_ipc_mem.paddr = res.start;
+	vpu_dev->mss_ipc_mem.vpu_addr = phys_to_dma(dev, res.start);
+	vpu_dev->mss_ipc_mem.size = resource_size(&res);
+
+	return 0;
+}
+
+static int setup_reserved_memory(struct vpu_ipc_dev *vpu_dev)
+{
+	struct device *dev = &vpu_dev->pdev->dev;
+	int rc;
+
+	/*
+	 * Find the VPU firmware area described in the device tree,
+	 * and allocate it for our usage.
+	 */
+	rc = setup_vpu_fw_region(vpu_dev);
+	if (rc) {
+		dev_err(dev, "Failed to init FW memory.\n");
+		return rc;
+	}
+
+	/*
+	 * Find the X509 area described in the device tree,
+	 * and allocate it for our usage.
+	 */
+	rc = setup_x509_region(vpu_dev);
+	if (rc) {
+		dev_err(dev, "Failed to setup X509 region.\n");
+		goto res_mem_setup_fail;
+	}
+
+	/*
+	 * Find the MSS IPC area in the device tree and get the location and
+	 * size information
+	 */
+	rc = setup_mss_ipc_region(vpu_dev);
+	if (rc) {
+		dev_err(dev, "Couldn't setup MSS IPC region.\n");
+		goto res_mem_setup_fail;
+	}
+
+	return 0;
+
+res_mem_setup_fail:
+	of_reserved_mem_device_release(dev);
+
+	return rc;
+}
+
+static void ipc_device_put(struct vpu_ipc_dev *vpu_dev)
+{
+	put_device(vpu_dev->ipc_dev);
+}
+
+static int ipc_device_get(struct vpu_ipc_dev *vpu_dev)
+{
+	struct device *dev = &vpu_dev->pdev->dev;
+	struct platform_device *pdev;
+	struct device_node *np;
+
+	np = of_parse_phandle(dev->of_node, "intel,keembay-ipc", 0);
+	if (!np) {
+		dev_err(dev, "Cannot find phandle to IPC device\n");
+		return -ENODEV;
+	}
+
+	pdev = of_find_device_by_node(np);
+	if (!pdev) {
+		dev_info(dev, "IPC device not probed\n");
+		of_node_put(np);
+		return -EPROBE_DEFER;
+	}
+
+	vpu_dev->ipc_dev = get_device(&pdev->dev);
+	of_node_put(np);
+
+	return 0;
+}
+
+static int retrieve_clocks(struct vpu_ipc_dev *vpu_dev)
+{
+	struct device *dev = &vpu_dev->pdev->dev;
+	char pll_string[PLL_STRING_SIZE];
+	struct clk *clk;
+	int pll;
+	int out;
+
+	clk = devm_clk_get(dev, "cpu_clock");
+	if (IS_ERR(clk)) {
+		dev_err(dev, "cpu_clock not found.\n");
+		return PTR_ERR(clk);
+	}
+	vpu_dev->cpu_clock = clk;
+
+	for (pll = 0; pll < NUM_PLLS; pll++) {
+		for (out = 0; out < NUM_PLL_OUTPUTS; out++) {
+			sprintf(pll_string, "pll_%d_out_%d", pll, out);
+			clk = devm_clk_get(dev, pll_string);
+			if (IS_ERR(clk)) {
+				dev_err(dev, "%s not found.\n", pll_string);
+				return PTR_ERR(clk);
+			}
+			vpu_dev->pll[pll][out] = clk;
+		}
+	}
+
+	return 0;
+}
+
+/* Get register resource from device tree and re-map as I/O memory. */
+static int get_pdev_res_and_ioremap(struct platform_device *pdev,
+				    const char *reg_name,
+				    void __iomem **target_reg)
+{
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	void __iomem *reg;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, reg_name);
+	if (!res) {
+		dev_err(dev, "Couldn't get resource for %s\n", reg_name);
+		return -EINVAL;
+	}
+
+	reg = devm_ioremap_resource(dev, res);
+	if (IS_ERR(reg)) {
+		dev_err(dev, "Couldn't ioremap resource for %s\n", reg_name);
+		return PTR_ERR(reg);
+	}
+
+	*target_reg = reg;
+
+	return 0;
+}
+
+static int setup_watchdog_resources(struct vpu_ipc_dev *vpu_dev)
+{
+	struct platform_device *pdev = vpu_dev->pdev;
+	struct device *dev = &vpu_dev->pdev->dev;
+	int rc;
+
+	/* Get registers */
+	rc = get_pdev_res_and_ioremap(pdev, "nce_wdt", &vpu_dev->nce_wdt_reg);
+	if (rc) {
+		dev_err(dev, "Failed to get NCE WDT registers\n");
+		return rc;
+	}
+	rc = get_pdev_res_and_ioremap(pdev, "nce_tim_cfg",
+				      &vpu_dev->nce_tim_cfg_reg);
+	if (rc) {
+		dev_err(dev, "Failed to get NCE TIM_GEN_CONFIG register\n");
+		return rc;
+	}
+	rc = get_pdev_res_and_ioremap(pdev, "mss_wdt", &vpu_dev->mss_wdt_reg);
+	if (rc) {
+		dev_err(dev, "Failed to get MSS WDT registers\n");
+		return rc;
+	}
+	rc = get_pdev_res_and_ioremap(pdev, "mss_tim_cfg",
+				      &vpu_dev->mss_tim_cfg_reg);
+	if (rc) {
+		dev_err(dev, "Failed to get MSS TIM_GEN_CONFIG register\n");
+		return rc;
+	}
+
+	/* Request interrupts */
+	vpu_dev->nce_irq = platform_get_irq_byname(pdev, "nce_wdt");
+	if (vpu_dev->nce_irq < 0)
+		return vpu_dev->nce_irq;
+	vpu_dev->mss_irq = platform_get_irq_byname(pdev, "mss_wdt");
+	if (vpu_dev->mss_irq < 0)
+		return vpu_dev->mss_irq;
+	rc = devm_request_irq(dev, vpu_dev->nce_irq, nce_wdt_irq_handler, 0,
+			      "keembay-vpu-ipc", vpu_dev);
+	if (rc) {
+		dev_err(dev, "failed to request NCE IRQ.\n");
+		return rc;
+	}
+	rc = devm_request_irq(dev, vpu_dev->mss_irq, mss_wdt_irq_handler, 0,
+			      "keembay-vpu-ipc", vpu_dev);
+	if (rc) {
+		dev_err(dev, "failed to request MSS IRQ.\n");
+		return rc;
+	}
+
+	/* Request interrupt re-direct numbers */
+	rc = of_property_read_u32(dev->of_node,
+				  "intel,keembay-vpu-ipc-nce-wdt-redirect",
+				  &vpu_dev->nce_wdt_redirect);
+	if (rc) {
+		dev_err(dev, "failed to get NCE WDT redirect number.\n");
+		return rc;
+	}
+	rc = of_property_read_u32(dev->of_node,
+				  "intel,keembay-vpu-ipc-mss-wdt-redirect",
+				  &vpu_dev->mss_wdt_redirect);
+	if (rc) {
+		dev_err(dev, "failed to get MSS WDT redirect number.\n");
+		return rc;
+	}
+
+	return 0;
+}
+
+/* Populate the boot parameters to be passed to the VPU. */
+static int setup_boot_parameters(struct vpu_ipc_dev *vpu_dev)
+{
+	int i;
+
+	/* Set all values to zero. This will disable most clocks/devices */
+	memset(vpu_dev->boot_params, 0, sizeof(*vpu_dev->boot_params));
+
+	/*
+	 * Set magic number, so VPU knows that the parameters are
+	 * populated correctly
+	 */
+	vpu_dev->boot_params->magic_number = BOOT_PARAMS_MAGIC_NUMBER;
+
+	/* Set VPU ID. */
+	vpu_dev->boot_params->vpu_id = vpu_dev->vpu_id;
+
+	/* Inform VPU of clock frequencies */
+	vpu_dev->boot_params->cpu_frequency_hz =
+		clk_get_rate(vpu_dev->cpu_clock);
+	for (i = 0; i < NUM_PLL_OUTPUTS; i++) {
+		vpu_dev->boot_params->pll0_out[i] =
+			clk_get_rate(vpu_dev->pll[0][i]);
+		vpu_dev->boot_params->pll1_out[i] =
+			clk_get_rate(vpu_dev->pll[1][i]);
+		vpu_dev->boot_params->pll2_out[i] =
+			clk_get_rate(vpu_dev->pll[2][i]);
+	}
+
+	/*
+	 * Fill in IPC buffer information: the VPU needs to know where it
+	 * should allocate IPC buffer from.
+	 */
+	vpu_dev->boot_params->mss_ipc_header_address =
+		vpu_dev->mss_ipc_mem.vpu_addr;
+	vpu_dev->boot_params->mss_ipc_header_area_size =
+		vpu_dev->mss_ipc_mem.size;
+
+	/* Fill in IRQ re-direct request information */
+	vpu_dev->boot_params->mss_wdt_to_irq_a53_redir =
+		vpu_dev->mss_wdt_redirect;
+	vpu_dev->boot_params->nce_wdt_to_irq_a53_redir =
+		vpu_dev->nce_wdt_redirect;
+
+	/* Setup A53SS_VERSION_ID */
+	vpu_dev->boot_params->a53ss_version_id = vpu_ipc_soc_info->hardware_id;
+
+	/* Setup Silicon stepping */
+	vpu_dev->boot_params->si_stepping = vpu_ipc_soc_info->stepping[0] |
+					    vpu_ipc_soc_info->stepping[1] << 8;
+
+	/* Set feature exclude and device id information. */
+	vpu_dev->boot_params->device_id = vpu_ipc_soc_info->device_id;
+	vpu_dev->boot_params->feature_exclusion =
+					vpu_ipc_soc_info->feature_exclusion;
+
+	/* Set SKU information */
+	vpu_dev->boot_params->sku = (u64)vpu_ipc_soc_info->sku[0] |
+				    (u64)vpu_ipc_soc_info->sku[1] << 8 |
+				    (u64)vpu_ipc_soc_info->sku[2] << 16 |
+				    (u64)vpu_ipc_soc_info->sku[3] << 24 |
+				    (u64)vpu_ipc_soc_info->sku[4] << 32 |
+				    (u64)vpu_ipc_soc_info->sku[5] << 40;
+	return 0;
+}
+
+/* Request SoC firmware to boot the VPU. */
+static int request_vpu_boot(struct vpu_ipc_dev *vpu_dev)
+{
+	u64 function_id;
+	struct arm_smccc_res res;
+	u16 function_number = KMB_SIP_SVC_VPU_BOOT;
+
+	function_id = ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_32,
+					 ARM_SMCCC_OWNER_SIP, function_number);
+
+	/*
+	 * Arguments are as follows:
+	 * 1. Reserved
+	 * 2. Reserved region size
+	 * 3. Firmware image physical base address
+	 * 4. Firmware image size
+	 * 5. Entry point for VPU
+	 * 6. X509 certificate location
+	 * 7. IMR driver number
+	 */
+	arm_smccc_smc(function_id, 0,
+		      vpu_dev->reserved_mem.size, vpu_dev->fw_res.start,
+		      resource_size(&vpu_dev->fw_res), vpu_dev->boot_vec_paddr,
+		      vpu_dev->x509_mem.paddr, vpu_dev->imr, &res);
+
+	if (res.a0) {
+		dev_info(&vpu_dev->pdev->dev, "Boot failed: 0x%lx.\n", res.a0);
+		return -EIO;
+	}
+
+	dev_info(&vpu_dev->pdev->dev,
+		 "VPU Boot successfully requested to secure monitor.\n");
+
+	return 0;
+}
+
+/* Request SoC firmware to stop the VPU. */
+static int request_vpu_stop(struct vpu_ipc_dev *vpu_dev)
+{
+	u64 function_id;
+	struct arm_smccc_res res;
+	u16 function_number = KMB_SIP_SVC_VPU_STOP;
+
+	function_id = ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_32,
+					 ARM_SMCCC_OWNER_SIP, function_number);
+
+	arm_smccc_smc(function_id, 0, 0, 0, 0, 0, 0, 0, &res);
+
+	if (res.a0) {
+		dev_info(&vpu_dev->pdev->dev, "Stop failed: 0x%lx.\n", res.a0);
+		return -EIO;
+	}
+
+	dev_info(&vpu_dev->pdev->dev,
+		 "VPU Stop successfully requested to secure monitor.\n");
+
+	return 0;
+}
+
+/*
+ * Get kernel virtual address of resource inside the VPU reserved memory
+ * region.
+ */
+static void *get_vpu_dev_vaddr(struct vpu_ipc_dev *vpu_dev,
+			       struct resource *res)
+{
+	unsigned long offset;
+
+	/* Given the calculation below, this must not be true. */
+	if (res->start < vpu_dev->reserved_mem.vpu_addr)
+		return NULL;
+
+	offset = res->start - vpu_dev->reserved_mem.vpu_addr;
+
+	/* Cast to (u8 *) since void pointer arithmetic is undefined. */
+	return (u8 *)vpu_dev->reserved_mem.vaddr + offset;
+}
+
+static int parse_fw_header(struct vpu_ipc_dev *vpu_dev,
+			   const struct firmware *fw)
+{
+	struct resource config_res, version_res, total_reserved_res;
+	struct device *dev = &vpu_dev->pdev->dev;
+	struct firmware_header *fw_header;
+	void *version_region;
+	void *config_region;
+	void *fw_region;
+
+	/* Is the fw size big enough to read the header? */
+	if (fw->size < sizeof(struct firmware_header)) {
+		dev_err(dev, "Firmware was too small for header.\n");
+		return -EINVAL;
+	}
+
+	fw_header = (struct firmware_header *)fw->data;
+
+	/* Check header version */
+	if (fw_header->header_ver != HEADER_VERSION_SUPPORTED) {
+		dev_err(dev, "Header version check expected 0x%x, got 0x%x\n",
+			HEADER_VERSION_SUPPORTED, fw_header->header_ver);
+		return -EINVAL;
+	}
+
+	/* Check firmware version size is allowed */
+	if (fw_header->fw_ver_size > MAX_FIRMWARE_VERSION_SIZE) {
+		dev_err(dev, "Firmware version area larger than allowed: %d\n",
+			fw_header->fw_ver_size);
+		return -EINVAL;
+	}
+
+	/*
+	 * Check the firmware binary is at least large enough for the
+	 * firmware image size described in the header.
+	 */
+	if (fw->size < (MAX_HEADER_SIZE + MAX_FIRMWARE_VERSION_SIZE +
+			fw_header->image_size)) {
+		dev_err(dev, "Real firmware size is not large enough.\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Make sure that the final address is aligned correctly. If not, the
+	 * boot will never work.
+	 */
+	if (!IS_ALIGNED(fw_header->entry_point, VPU_RESET_VECTOR_ALIGNMENT)) {
+		dev_err(dev,
+			"Entry point for firmware (0x%llX) is not correctly aligned.\n",
+			fw_header->entry_point);
+		return -EINVAL;
+	}
+
+	/*
+	 * Generate the resource describing the region containing the actual
+	 * firmware data.
+	 */
+	vpu_dev->fw_res.start = fw_header->image_load_addr;
+	vpu_dev->fw_res.end = fw_header->image_size +
+			      fw_header->image_load_addr - 1;
+	vpu_dev->fw_res.flags = IORESOURCE_MEM;
+
+	/*
+	 * Generate the resource describing the region containing the
+	 * configuration data for the VPU.
+	 */
+	config_res.start = fw_header->config_load_addr;
+	config_res.end = sizeof(struct boot_parameters) +
+			 fw_header->config_load_addr - 1;
+	config_res.flags = IORESOURCE_MEM;
+
+	/*
+	 * Generate the resource describing the region containing the
+	 * version information for the VPU.
+	 */
+	version_res.start = fw_header->fw_ver_load_addr;
+	version_res.end = fw_header->fw_ver_size +
+			  fw_header->fw_ver_load_addr - 1;
+	version_res.flags = IORESOURCE_MEM;
+
+	/*
+	 * Generate the resource describing the region of memory
+	 * completely dedicated to the VPU.
+	 */
+	total_reserved_res.start = vpu_dev->reserved_mem.vpu_addr;
+	total_reserved_res.end = vpu_dev->reserved_mem.vpu_addr +
+		vpu_dev->reserved_mem.size - 1;
+	total_reserved_res.flags = IORESOURCE_MEM;
+
+	/*
+	 * Check all pieces to be copied reside completely in the reserved
+	 * region
+	 */
+	if (!resource_contains(&total_reserved_res, &vpu_dev->fw_res)) {
+		dev_err(dev, "Can't fit firmware in reserved region.\n");
+		return -EINVAL;
+	}
+	if (!resource_contains(&total_reserved_res, &version_res)) {
+		dev_err(dev,
+			"Can't fit firmware version data in reserved region.\n");
+		return -EINVAL;
+	}
+	if (!resource_contains(&total_reserved_res, &config_res)) {
+		dev_err(dev,
+			"Can't fit configuration information in reserved region.\n");
+		return -EINVAL;
+	}
+
+	/* Check for overlapping regions */
+	if (resource_overlaps(&vpu_dev->fw_res, &version_res)) {
+		dev_err(dev, "FW and version regions overlap.\n");
+		return -EINVAL;
+	}
+	if (resource_overlaps(&vpu_dev->fw_res, &config_res)) {
+		dev_err(dev, "FW and config regions overlap.\n");
+		return -EINVAL;
+	}
+	if (resource_overlaps(&config_res, &version_res)) {
+		dev_err(dev, "Version and config regions overlap.\n");
+		return -EINVAL;
+	}
+
+	/* Setup boot parameter region */
+	config_region = get_vpu_dev_vaddr(vpu_dev, &config_res);
+	if (!config_region) {
+		dev_err(dev,
+			"Couldn't map boot configuration area to CPU virtual address.\n");
+		return -EINVAL;
+	}
+	version_region = get_vpu_dev_vaddr(vpu_dev, &version_res);
+	if (!version_region) {
+		dev_err(dev,
+			"Couldn't map version area to CPU virtual address.\n");
+		return -EINVAL;
+	}
+	fw_region = get_vpu_dev_vaddr(vpu_dev, &vpu_dev->fw_res);
+	if (!fw_region) {
+		dev_err(dev,
+			"Couldn't map firmware area to CPU virtual address.\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Copy version region: the region is located in the file @ offset of
+	 * MAX_HEADER_SIZE, size was specified in the header and has been
+	 * checked to not be larger than that allowed.
+	 */
+	memcpy(version_region, &fw->data[MAX_HEADER_SIZE],
+	       fw_header->fw_ver_size);
+
+	/*
+	 * Copy firmware region: the region is located in the file @ offset of
+	 * MAX_HEADER_SIZE + MAX_FIRMWARE_VERSION_SIZE, size was specified in
+	 * the header and has been checked to not be larger than that allowed.
+	 */
+	memcpy(fw_region,
+	       &fw->data[MAX_HEADER_SIZE + MAX_FIRMWARE_VERSION_SIZE],
+	       fw_header->image_size);
+
+	/* Save off boot parameters region vaddr */
+	vpu_dev->boot_params = config_region;
+
+	/* Save off boot vector physical address */
+	vpu_dev->boot_vec_paddr = fw_header->entry_point;
+
+	return 0;
+}
+
+static int ready_message_wait_thread(void *arg)
+{
+	struct vpu_ipc_dev *vpu_dev = arg;
+	struct device *dev = &vpu_dev->pdev->dev;
+	size_t size = 0;
+	u32 paddr = 0;
+	int close_rc;
+	int rc;
+
+	/*
+	 * We will wait a few seconds for the message. We will complete earlier
+	 * if the message is received earlier.
+	 * NOTE: this is not a busy wait, we sleep until message is received.
+	 */
+	rc = intel_keembay_ipc_recv(vpu_dev->ipc_dev, KMB_IPC_NODE_LEON_MSS,
+				    READY_MESSAGE_IPC_CHANNEL, &paddr, &size,
+				    READY_MESSAGE_TIMEOUT_MS);
+	/*
+	 * IPC channel must be closed regardless of 'rc' value, so close the
+	 * channel now and then process 'rc' value.
+	 */
+	close_rc = intel_keembay_ipc_close_channel(vpu_dev->ipc_dev,
+						   KMB_IPC_NODE_LEON_MSS,
+						   READY_MESSAGE_IPC_CHANNEL);
+	if (close_rc < 0) {
+		dev_warn(dev, "Couldn't close IPC channel.\n");
+		/* Continue, as this is not a critical issue. */
+	}
+
+	/* Now process recv() return code. */
+	if (rc < 0) {
+		dev_err(dev,
+			"Failed to receive ready message within %d ms: %d.\n",
+			READY_MESSAGE_TIMEOUT_MS, rc);
+		goto ready_message_thread_failure;
+	}
+
+	if (paddr != READY_MESSAGE_EXPECTED_PADDR ||
+	    size != READY_MESSAGE_EXPECTED_SIZE) {
+		dev_err(dev, "Bad ready message: (paddr, size) = (0x%x, %zu)\n",
+			paddr, size);
+		goto ready_message_thread_failure;
+	}
+
+	dev_info(dev, "VPU ready message received successfully!\n");
+
+	rc = vpu_ipc_handle_event(vpu_dev, KEEMBAY_VPU_EVENT_MSS_READY_OK);
+	if (rc < 0)
+		dev_err(dev, "Fatal error: failed to set state (ready ok).\n");
+
+	/* Wake up anyone waiting for READY. */
+	wake_up_all(&vpu_dev->ready_queue);
+
+	return 0;
+
+ready_message_thread_failure:
+	rc = vpu_ipc_handle_event(vpu_dev, KEEMBAY_VPU_EVENT_MSS_READY_FAIL);
+	if (rc < 0)
+		dev_err(dev,
+			"Fatal error: failed to set state (ready timeout).\n");
+
+	return 0;
+}
+
+static int create_ready_message_thread(struct vpu_ipc_dev *vpu_dev)
+{
+	struct device *dev = &vpu_dev->pdev->dev;
+	struct task_struct *task;
+
+	task = kthread_run(&ready_message_wait_thread, (void *)vpu_dev,
+			   "keembay-vpu-ipc-ready");
+	if (IS_ERR(task)) {
+		dev_err(dev, "Couldn't start thread to receive message.\n");
+		return -EIO;
+	}
+
+	vpu_dev->ready_message_task = task;
+
+	return 0;
+}
+
+static int kickoff_vpu_sequence(struct vpu_ipc_dev *vpu_dev,
+				int (*boot_fn)(struct vpu_ipc_dev *))
+{
+	struct device *dev = &vpu_dev->pdev->dev;
+	int err_rc;
+	int rc;
+
+	/*
+	 * Open the IPC channel. If we don't do it before booting
+	 * the VPU, we may miss the message, as the IPC driver will
+	 * discard messages for unopened channels.
+	 */
+	rc = intel_keembay_ipc_open_channel(vpu_dev->ipc_dev,
+					    KMB_IPC_NODE_LEON_MSS,
+					    READY_MESSAGE_IPC_CHANNEL);
+	if (rc < 0) {
+		dev_err(dev,
+			"Couldn't open IPC channel to receive ready message.\n");
+		goto kickoff_failed;
+	}
+
+	/* Request boot */
+	rc = boot_fn(vpu_dev);
+	if (rc < 0) {
+		dev_err(dev, "Failed to do request to boot.\n");
+		goto close_and_kickoff_failed;
+	}
+
+	/*
+	 * Start thread waiting for message, and update state
+	 * if the request was successful.
+	 */
+	rc = create_ready_message_thread(vpu_dev);
+	if (rc < 0) {
+		dev_err(dev,
+			"Failed to create thread to wait for ready message.\n");
+		goto close_and_kickoff_failed;
+	}
+
+	return 0;
+
+close_and_kickoff_failed:
+	/* Close the channel. */
+	err_rc = intel_keembay_ipc_close_channel(vpu_dev->ipc_dev,
+						 KMB_IPC_NODE_LEON_MSS,
+						 READY_MESSAGE_IPC_CHANNEL);
+	if (err_rc < 0) {
+		dev_err(dev, "Couldn't close IPC channel: %d\n", err_rc);
+		/*
+		 * We have had a more serious failure - don't update the
+		 * original 'rc' and continue.
+		 */
+	}
+
+kickoff_failed:
+	return rc;
+}
+
+/*
+ * Try to boot the VPU using the firmware name stored in
+ * vpu_dev->firmware_name (which when this function is called is expected to be
+ * not NULL).
+ */
+static int do_boot_sequence(struct vpu_ipc_dev *vpu_dev)
+{
+	struct device *dev = &vpu_dev->pdev->dev;
+	const struct firmware *fw;
+	int event_rc;
+	int rc;
+
+	/* Update state machine. */
+	rc = vpu_ipc_handle_event(vpu_dev, KEEMBAY_VPU_EVENT_BOOT);
+	if (rc < 0) {
+		dev_err(dev, "Can't start in this state.\n");
+		return rc;
+	}
+
+	/* Stop the VPU running */
+	rc = request_vpu_stop(vpu_dev);
+	if (rc < 0)
+		dev_err(dev, "Failed stop - continue sequence anyway.\n");
+
+	dev_info(dev, "Keem Bay VPU IPC start with %s.\n",
+		 vpu_dev->firmware_name);
+
+	/* Request firmware and wait for it. */
+	rc = request_firmware(&fw, vpu_dev->firmware_name, &vpu_dev->pdev->dev);
+	if (rc < 0) {
+		dev_err(dev, "Couldn't find firmware: %d\n", rc);
+		goto boot_failed_no_fw;
+	}
+
+	/* Do checks on the firmware header. */
+	rc = parse_fw_header(vpu_dev, fw);
+	if (rc < 0) {
+		dev_err(dev, "Firmware checks failed.\n");
+		goto boot_failed;
+	}
+
+	/* Write configuration data. */
+	rc = setup_boot_parameters(vpu_dev);
+	if (rc < 0) {
+		dev_err(dev, "Failed to set up boot parameters.\n");
+		goto boot_failed;
+	}
+
+	/* Try 'boot' sequence */
+	rc = kickoff_vpu_sequence(vpu_dev, request_vpu_boot);
+	if (rc < 0) {
+		dev_err(dev, "Failed to boot VPU.\n");
+		goto boot_failed;
+	}
+
+	release_firmware(fw);
+	return 0;
+
+boot_failed:
+	release_firmware(fw);
+
+boot_failed_no_fw:
+	/* Update state machine after failure. */
+	event_rc = vpu_ipc_handle_event(vpu_dev,
+					KEEMBAY_VPU_EVENT_BOOT_FAILED);
+	if (event_rc < 0) {
+		dev_err(dev,
+			"Unexpected error: failed to handle fail event: %d.\n",
+			event_rc);
+		/* Continue: prefer original 'rc' to 'event_rc'. */
+	}
+
+	return rc;
+}
+
+/**
+ * intel_keembay_vpu_ipc_open_channel() - Open an IPC channel.
+ * @dev:	The VPU IPC device to use.
+ * @node_id:	The node ID of the remote node (used to identify the link the
+ *		channel must be added to). KMB_IPC_NODE_LEON_MSS is the only
+ *		allowed value for now.
+ * @chan_id:	The ID of the channel to be opened.
+ *
+ * Return:	0 on success, negative error code otherwise.
+ */
+int intel_keembay_vpu_ipc_open_channel(struct device *dev, u8 node_id,
+				       u16 chan_id)
+{
+	struct vpu_ipc_dev *vpu_dev = to_vpu_dev(dev);
+
+	if (IS_ERR(vpu_dev))
+		return -EINVAL;
+
+	return intel_keembay_ipc_open_channel(vpu_dev->ipc_dev, node_id,
+					      chan_id);
+}
+EXPORT_SYMBOL(intel_keembay_vpu_ipc_open_channel);
+
+/**
+ * intel_keembay_vpu_ipc_close_channel() - Close an IPC channel.
+ * @dev:	The VPU IPC device to use.
+ * @node_id:	The node ID of the remote node (used to identify the link the
+ *		channel must be added to). KMB_IPC_NODE_LEON_MSS is the only
+ *		allowed value for now.
+ * @chan_id:	The ID of the channel to be closed.
+ *
+ * Return:	0 on success, negative error code otherwise.
+ */
+
+int intel_keembay_vpu_ipc_close_channel(struct device *dev, u8 node_id,
+					u16 chan_id)
+{
+	struct vpu_ipc_dev *vpu_dev = to_vpu_dev(dev);
+
+	if (IS_ERR(vpu_dev))
+		return -EINVAL;
+
+	return intel_keembay_ipc_close_channel(vpu_dev->ipc_dev,
+					       node_id, chan_id);
+}
+EXPORT_SYMBOL(intel_keembay_vpu_ipc_close_channel);
+
+/**
+ * intel_keembay_vpu_ipc_send() - Send data via IPC.
+ * @dev:	The VPU IPC device to use.
+ * @node_id:	The node ID of the remote node (used to identify the link the
+ *		channel must be added to). KMB_IPC_NODE_LEON_MSS is the only
+ *		allowed value for now.
+ * @chan_id:	The IPC channel to be used to send the message.
+ * @vpu_addr:	The VPU address of the data to be transferred.
+ * @size:	The size of the data to be transferred.
+ *
+ * Return:	0 on success, negative error code otherwise.
+ */
+int intel_keembay_vpu_ipc_send(struct device *dev, u8 node_id, u16 chan_id,
+			       u32 vpu_addr, size_t size)
+{
+	struct vpu_ipc_dev *vpu_dev = to_vpu_dev(dev);
+
+	if (IS_ERR(vpu_dev))
+		return -EINVAL;
+
+	return intel_keembay_ipc_send(vpu_dev->ipc_dev, node_id, chan_id,
+				      vpu_addr, size);
+}
+EXPORT_SYMBOL(intel_keembay_vpu_ipc_send);
+
+/**
+ * intel_keembay_vpu_ipc_recv() - Read data via IPC
+ * @dev:	The VPU IPC device to use.
+ * @node_id:	The node ID of the remote node (used to identify the link the
+ *		channel must be added to). KMB_IPC_NODE_LEON_MSS is the only
+ *		allowed value for now.
+ * @chan_id:	The IPC channel to read from.
+ * @vpu_addr:	[out] The VPU address of the received data.
+ * @size:	[out] Where to store the size of the received data.
+ * @timeout:	How long (in ms) the function will block waiting for an IPC
+ *		message; if UINT32_MAX it will block indefinitely; if 0 it
+ *		will not block.
+ *
+ * Return:	0 on success, negative error code otherwise
+ */
+int intel_keembay_vpu_ipc_recv(struct device *dev, u8 node_id, u16 chan_id,
+			       u32 *vpu_addr, size_t *size, u32 timeout)
+{
+	struct vpu_ipc_dev *vpu_dev = to_vpu_dev(dev);
+
+	if (IS_ERR(vpu_dev))
+		return -EINVAL;
+
+	return intel_keembay_ipc_recv(vpu_dev->ipc_dev, node_id, chan_id,
+				      vpu_addr, size, timeout);
+}
+EXPORT_SYMBOL(intel_keembay_vpu_ipc_recv);
+
+/**
+ * intel_keembay_vpu_startup() - Boot the VPU
+ * @dev:	   The VPU device to boot.
+ * @firmware_name: Name of firmware file
+ *
+ * This API is only valid while the VPU is OFF.
+ *
+ * The firmware called "firmware_name" will be searched for using the
+ * kernel firmware API. The firmware header will then be parsed. This driver
+ * will load requested information to the reserved memory region, including
+ * initialisation data. Lastly, we will request the secure world to do the
+ * boot sequence. If the boot sequence is successful, the
+ * VPU state will become BUSY. The caller should then wait for the status to
+ * become READY before starting to communicate with the VPU. If the boot
+ * sequence failed, this function will fail and the caller may try again,
+ * the VPU status will still be OFF.
+ *
+ * If we fail to get to READY, because the VPU did not send us the 'ready'
+ * message, the VPU state will go to ERROR.
+ *
+ * Return: 0 on success, negative error code otherwise
+ */
+int intel_keembay_vpu_startup(struct device *dev, const char *firmware_name)
+{
+	struct vpu_ipc_dev *vpu_dev = to_vpu_dev(dev);
+
+	if (IS_ERR(vpu_dev))
+		return PTR_ERR(vpu_dev);
+
+	if (!firmware_name)
+		return -EINVAL;
+
+	/* Free old vpu_dev->firmware_name value (if any). */
+	kfree(vpu_dev->firmware_name);
+
+	/* Set new value. */
+	vpu_dev->firmware_name = kstrdup(firmware_name, GFP_KERNEL);
+
+	return do_boot_sequence(vpu_dev);
+}
+EXPORT_SYMBOL(intel_keembay_vpu_startup);
+
+/**
+ * intel_keembay_vpu_reset() - Reset the VPU
+ * @dev:	The VPU device to reset.
+ *
+ * Resets the VPU. Only valid when the VPU is in the READY or ERROR state.
+ * The state of the VPU will become BUSY.
+ *
+ * Return: 0 on success, negative error code otherwise
+ */
+int intel_keembay_vpu_reset(struct device *dev)
+{
+	struct vpu_ipc_dev *vpu_dev = to_vpu_dev(dev);
+
+	if (IS_ERR(vpu_dev))
+		return PTR_ERR(vpu_dev);
+
+	/*
+	 * If vpu_dev->firmware_name == NULL then the VPU is not running
+	 * (either it was never booted or vpu_stop() was called). So, calling
+	 * reset is not allowed.
+	 */
+	if (!vpu_dev->firmware_name)
+		return -EINVAL;
+
+	return do_boot_sequence(vpu_dev);
+}
+EXPORT_SYMBOL(intel_keembay_vpu_reset);
+
+/**
+ * intel_keembay_vpu_stop() - Stop the VPU
+ * @dev:	The VPU device to stop.
+ *
+ * Stops the VPU and restores to the OFF state. Only valid when the VPU is in
+ * the READY or ERROR state.
+ *
+ * Return: 0 on success, negative error code otherwise
+ */
+int intel_keembay_vpu_stop(struct device *dev)
+{
+	struct vpu_ipc_dev *vpu_dev = to_vpu_dev(dev);
+	int event_rc;
+	int rc;
+
+	if (IS_ERR(vpu_dev))
+		return -EINVAL;
+
+	rc = vpu_ipc_handle_event(vpu_dev, KEEMBAY_VPU_EVENT_STOP);
+	if (rc < 0) {
+		dev_err(dev, "Can't stop in this state.\n");
+		return rc;
+	}
+
+	dev_info(dev, "Keem Bay VPU IPC stop.\n");
+
+	/* Request stop */
+	rc = request_vpu_stop(vpu_dev);
+	if (rc < 0) {
+		dev_err(dev,
+			"Failed to do request to stop - resetting state to OFF anyway.\n");
+	}
+
+	/* Remove any saved-off name */
+	kfree(vpu_dev->firmware_name);
+	vpu_dev->firmware_name = NULL;
+
+	event_rc = vpu_ipc_handle_event(vpu_dev,
+					KEEMBAY_VPU_EVENT_STOP_COMPLETE);
+	if (event_rc < 0) {
+		dev_err(dev,
+			"Failed to handle 'stop complete' event, probably fatal.\n");
+		return event_rc;
+	}
+
+	return rc;
+}
+EXPORT_SYMBOL(intel_keembay_vpu_stop);
+
+/**
+ * intel_keembay_vpu_status() - Get the VPU state.
+ * @dev:	The VPU device to retrieve the status for.
+ *
+ * Returns the state of the VPU as tracked by this driver.
+ *
+ * Return: Relevant value of enum intel_keembay_vpu_state
+ */
+enum intel_keembay_vpu_state intel_keembay_vpu_status(struct device *dev)
+{
+	struct vpu_ipc_dev *vpu_dev = to_vpu_dev(dev);
+
+	if (IS_ERR(vpu_dev))
+		return -EINVAL;
+
+	return vpu_dev->state;
+}
+EXPORT_SYMBOL(intel_keembay_vpu_status);
+
+/**
+ * intel_keembay_vpu_get_wdt_count() - Get the WDT count
+ * @dev:	The VPU device to get the WDT count for.
+ * @id:		ID of WDT events we wish to get
+ *
+ * Returns: Number of WDT timeout occurrences for given ID, or negative
+ *	    error value for invalid ID.
+ */
+int intel_keembay_vpu_get_wdt_count(struct device *dev,
+				    enum intel_keembay_wdt_cpu_id id)
+{
+	struct vpu_ipc_dev *vpu_dev = to_vpu_dev(dev);
+	int rc = -EINVAL;
+
+	if (IS_ERR(vpu_dev))
+		return -EINVAL;
+
+	switch (id) {
+	case KEEMBAY_VPU_NCE:
+		rc = vpu_dev->nce_wdt_count;
+		break;
+	case KEEMBAY_VPU_MSS:
+		rc = vpu_dev->mss_wdt_count;
+		break;
+	default:
+		break;
+	}
+	return rc;
+}
+EXPORT_SYMBOL(intel_keembay_vpu_get_wdt_count);
+
+/**
+ * intel_keembay_vpu_wait_for_ready() - Sleep until VPU is READY
+ * @dev:	The VPU device for which we are waiting the ready message.
+ * @timeout:	How long (in ms) the function will block waiting for the VPU
+ *		to become ready.
+ *
+ * The caller may ask the VPU IPC driver to notify it when the VPU
+ * is READY. The driver performs no checks on the current state, so it
+ * is up to the caller to confirm that the state is correct before starting
+ * the wait.
+ *
+ * Returns: 0 on success negative error code otherwise
+ */
+int intel_keembay_vpu_wait_for_ready(struct device *dev, u32 timeout)
+{
+	struct vpu_ipc_dev *vpu_dev = to_vpu_dev(dev);
+	int rc;
+
+	if (IS_ERR(vpu_dev))
+		return -EINVAL;
+
+	/*
+	 * If we are in ERROR state, we will not get to READY
+	 * state without some other transitions, so return
+	 * error immediately for caller to handle.
+	 */
+	if (vpu_dev->state == KEEMBAY_VPU_ERROR)
+		return -EIO;
+
+	rc = wait_event_interruptible_timeout(vpu_dev->ready_queue,
+					      vpu_dev->state == KEEMBAY_VPU_READY,
+					      msecs_to_jiffies(timeout));
+
+	/* Condition was false after timeout elapsed */
+	if (!rc)
+		rc = -ETIME;
+
+	/* Condition was true, so rc == 1 */
+	if (rc > 0)
+		rc = 0;
+
+	return rc;
+}
+EXPORT_SYMBOL(intel_keembay_vpu_wait_for_ready);
+
+/**
+ * intel_keembay_vpu_register_for_events() - Register callback for event notification
+ * @dev:	The VPU device.
+ * @callback: Callback function pointer
+ *
+ * Only a single callback can be registered at a time.
+ *
+ * Callback can be triggered from any context, so needs to be able to be run
+ * from IRQ context.
+ *
+ * Return: 0 on success, negative error code otherwise
+ */
+int intel_keembay_vpu_register_for_events(struct device *dev,
+					  void (*callback)(struct device *dev,
+							   enum intel_keembay_vpu_event))
+{
+	struct vpu_ipc_dev *vpu_dev = to_vpu_dev(dev);
+
+	if (IS_ERR(vpu_dev))
+		return PTR_ERR(vpu_dev);
+
+	if (vpu_dev->callback)
+		return -EEXIST;
+
+	vpu_dev->callback = callback;
+
+	return 0;
+}
+EXPORT_SYMBOL(intel_keembay_vpu_register_for_events);
+
+/**
+ * intel_keembay_vpu_unregister_for_events() - Unregister callback for event notification
+ * @dev:	The VPU device.
+ *
+ * Return: 0 on success, negative error code otherwise
+ */
+int intel_keembay_vpu_unregister_for_events(struct device *dev)
+{
+	struct vpu_ipc_dev *vpu_dev = to_vpu_dev(dev);
+
+	if (IS_ERR(vpu_dev))
+		return PTR_ERR(vpu_dev);
+
+	vpu_dev->callback = NULL;
+
+	return 0;
+}
+EXPORT_SYMBOL(intel_keembay_vpu_unregister_for_events);
+
+/* Probe() function for the VPU IPC platform driver. */
+static int keembay_vpu_ipc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct vpu_ipc_dev *vpu_dev;
+	int rc;
+
+	vpu_dev = devm_kzalloc(dev, sizeof(*vpu_dev), GFP_KERNEL);
+	if (!vpu_dev)
+		return -ENOMEM;
+
+	vpu_dev->pdev = pdev;
+	vpu_dev->state = KEEMBAY_VPU_OFF;
+	vpu_dev->ready_message_task = NULL;
+	vpu_dev->firmware_name = NULL;
+	vpu_dev->nce_wdt_count = 0;
+	vpu_dev->mss_wdt_count = 0;
+	spin_lock_init(&vpu_dev->lock);
+	init_waitqueue_head(&vpu_dev->ready_queue);
+
+	/* Retrieve clocks */
+	rc = retrieve_clocks(vpu_dev);
+	if (rc) {
+		dev_err(dev, "Failed to retrieve clocks %d\n", rc);
+		return rc;
+	}
+
+	/* Retrieve memory regions, allocate memory */
+	rc = setup_reserved_memory(vpu_dev);
+	if (rc) {
+		dev_err(dev,
+			"Failed to set up reserved memory regions: %d\n", rc);
+		return rc;
+	}
+
+	/* Request watchdog timer resources */
+	rc = setup_watchdog_resources(vpu_dev);
+	if (rc) {
+		dev_err(dev, "Failed to setup watchdog resources %d\n", rc);
+		goto probe_fail_post_resmem_setup;
+	}
+
+	/* Request the IMR number to be used */
+	rc = of_property_read_u32(dev->of_node, "intel,keembay-vpu-ipc-imr",
+				  &vpu_dev->imr);
+	if (rc) {
+		dev_err(dev, "failed to get IMR number.\n");
+		goto probe_fail_post_resmem_setup;
+	}
+
+	/* Get VPU ID. */
+	rc = of_property_read_u32(dev->of_node, "intel,keembay-vpu-ipc-id",
+				  &vpu_dev->vpu_id);
+	if (rc) {
+		/* Only warn for now; we will enforce this in the future. */
+		dev_err(dev, "VPU ID not defined in Device Tree\n");
+		goto probe_fail_post_resmem_setup;
+	}
+
+	/* Get IPC device to be used for IPC communication. */
+	rc = ipc_device_get(vpu_dev);
+	if (rc) {
+		dev_err(dev, "Failed to get IPC device\n");
+		goto probe_fail_post_resmem_setup;
+	}
+
+	/* Set platform data reference. */
+	platform_set_drvdata(pdev, vpu_dev);
+
+	return rc;
+
+probe_fail_post_resmem_setup:
+	of_reserved_mem_device_release(dev);
+
+	return rc;
+}
+
+/* Remove() function for the VPU IPC platform driver. */
+static int keembay_vpu_ipc_remove(struct platform_device *pdev)
+{
+	struct vpu_ipc_dev *vpu_dev = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+
+	if (vpu_dev->ready_message_task) {
+		kthread_stop(vpu_dev->ready_message_task);
+		vpu_dev->ready_message_task = NULL;
+	}
+
+	of_reserved_mem_device_release(dev);
+
+	ipc_device_put(vpu_dev);
+
+	return 0;
+}
+
+/* Compatible string for the VPU/IPC driver. */
+static const struct of_device_id keembay_vpu_ipc_of_match[] = {
+	{
+		.compatible = "intel,keembay-vpu-ipc",
+	},
+	{}
+};
+
+/* The VPU IPC platform driver. */
+static struct platform_driver keem_bay_vpu_ipc_driver = {
+	.driver = {
+			.name = "keembay-vpu-ipc",
+			.of_match_table = keembay_vpu_ipc_of_match,
+		},
+	.probe = keembay_vpu_ipc_probe,
+	.remove = keembay_vpu_ipc_remove,
+};
+
+/* Helper function to get a vpu_dev struct from a generic device pointer. */
+static struct vpu_ipc_dev *to_vpu_dev(struct device *dev)
+{
+	struct platform_device *pdev;
+
+	if (!dev || dev->driver != &keem_bay_vpu_ipc_driver.driver)
+		return ERR_PTR(-EINVAL);
+	pdev = to_platform_device(dev);
+
+	return platform_get_drvdata(pdev);
+}
+
+/*
+ * Retrieve SoC information from the '/soc/version-info' device tree node and
+ * store it into 'vpu_ipc_soc_info' global variable.
+ */
+static int retrieve_dt_soc_information(void)
+{
+	struct device_node *soc_info_dn;
+	int ret;
+
+	soc_info_dn = of_find_node_by_path("/soc/version-info");
+	if (!soc_info_dn)
+		return -ENOENT;
+
+	ret = of_property_read_u64(soc_info_dn, "feature-exclusion",
+				   &vpu_ipc_soc_info->feature_exclusion);
+	if (ret) {
+		pr_err("Property 'feature-exclusion' can't be read.\n");
+		return ret;
+	}
+	ret = of_property_read_u64(soc_info_dn, "device-id",
+				   &vpu_ipc_soc_info->device_id);
+	if (ret) {
+		pr_err("Property 'device-id' can't be read.\n");
+		return ret;
+	}
+	ret = of_property_read_u32(soc_info_dn, "hardware-id",
+				   &vpu_ipc_soc_info->hardware_id);
+	if (ret) {
+		pr_err("Property 'hardware-id' can't be read.\n");
+		return ret;
+	}
+	/*
+	 * Note: the SKU and stepping information from the device tree is
+	 * not a string, but an array of u8/chars. Therefore, we cannot
+	 * parse it as a string.
+	 */
+	ret = of_property_read_u8_array(soc_info_dn, "sku",
+					vpu_ipc_soc_info->sku,
+					sizeof(vpu_ipc_soc_info->sku));
+	if (ret) {
+		pr_err("Property 'sku' can't be read.\n");
+		return ret;
+	}
+	ret = of_property_read_u8_array(soc_info_dn, "stepping",
+					vpu_ipc_soc_info->stepping,
+					sizeof(vpu_ipc_soc_info->stepping));
+	if (ret) {
+		pr_err("Property 'stepping' can't be read.\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+/*
+ * Init VPU IPC module:
+ * - Retrieve SoC information from device tree.
+ * - Register the VPU IPC platform driver.
+ */
+static int __init vpu_ipc_init(void)
+{
+	int rc;
+
+	vpu_ipc_soc_info = kzalloc(sizeof(*vpu_ipc_soc_info), GFP_KERNEL);
+	if (!vpu_ipc_soc_info)
+		return -ENOMEM;
+
+	rc = retrieve_dt_soc_information();
+	if (rc < 0)
+		pr_warn("VPU IPC failed to find SoC info, using defaults.\n");
+
+	rc = platform_driver_register(&keem_bay_vpu_ipc_driver);
+	if (rc < 0) {
+		pr_err("Failed to register platform driver for VPU IPC.\n");
+		goto cleanup_soc_info;
+	}
+
+	return 0;
+
+cleanup_soc_info:
+	kfree(vpu_ipc_soc_info);
+
+	return rc;
+}
+
+/*
+ * Remove VPU IPC module.
+ * - Un-register the VPU IPC platform driver.
+ * - Remove sysfs exposing SoC information.
+ * - Free allocated memory.
+ */
+static void __exit vpu_ipc_exit(void)
+{
+	platform_driver_unregister(&keem_bay_vpu_ipc_driver);
+	kfree(vpu_ipc_soc_info);
+}
+
+module_init(vpu_ipc_init);
+module_exit(vpu_ipc_exit);
+
+MODULE_DESCRIPTION("Keem Bay VPU IPC Driver");
+MODULE_AUTHOR("Paul Murphy <paul.j.murphy@intel.com>");
+MODULE_AUTHOR("Daniele Alessandrelli <daniele.alessandrelli@intel.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/soc/intel/keembay-vpu-ipc.h b/include/linux/soc/intel/keembay-vpu-ipc.h
new file mode 100644
index 000000000000..81d132186482
--- /dev/null
+++ b/include/linux/soc/intel/keembay-vpu-ipc.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Keem Bay VPU IPC Linux Kernel API
+ *
+ * Copyright (c) 2018-2020 Intel Corporation.
+ */
+
+#ifndef __KEEMBAY_VPU_IPC_H
+#define __KEEMBAY_VPU_IPC_H
+
+#include "linux/types.h"
+
+/* The possible node IDs. */
+enum {
+	KMB_VPU_IPC_NODE_ARM_CSS = 0,
+	KMB_VPU_IPC_NODE_LEON_MSS,
+};
+
+/* Possible states of VPU. */
+enum intel_keembay_vpu_state {
+	KEEMBAY_VPU_OFF = 0,
+	KEEMBAY_VPU_BUSY,
+	KEEMBAY_VPU_READY,
+	KEEMBAY_VPU_ERROR,
+	KEEMBAY_VPU_STOPPING
+};
+
+/* Possible CPU IDs for which we receive WDT timeout events. */
+enum intel_keembay_wdt_cpu_id {
+	KEEMBAY_VPU_MSS = 0,
+	KEEMBAY_VPU_NCE
+};
+
+/* Events that can be notified via callback, when registered. */
+enum intel_keembay_vpu_event {
+	KEEMBAY_VPU_NOTIFY_DISCONNECT = 0,
+	KEEMBAY_VPU_NOTIFY_CONNECT,
+	KEEMBAY_VPU_NOTIFY_MSS_WDT,
+	KEEMBAY_VPU_NOTIFY_NCE_WDT,
+};
+
+int intel_keembay_vpu_ipc_open_channel(struct device *dev, u8 node_id,
+				       u16 chan_id);
+int intel_keembay_vpu_ipc_close_channel(struct device *dev, u8 node_id,
+					u16 chan_id);
+int intel_keembay_vpu_ipc_send(struct device *dev, u8 node_id, u16 chan_id,
+			       u32 paddr, size_t size);
+int intel_keembay_vpu_ipc_recv(struct device *dev, u8 node_id, u16 chan_id,
+			       u32 *paddr, size_t *size, u32 timeout);
+int intel_keembay_vpu_startup(struct device *dev, const char *firmware_name);
+int intel_keembay_vpu_reset(struct device *dev);
+int intel_keembay_vpu_stop(struct device *dev);
+enum intel_keembay_vpu_state intel_keembay_vpu_status(struct device *dev);
+int intel_keembay_vpu_get_wdt_count(struct device *dev,
+				    enum intel_keembay_wdt_cpu_id id);
+int intel_keembay_vpu_wait_for_ready(struct device *dev, u32 timeout);
+int intel_keembay_vpu_register_for_events(struct device *dev,
+					  void (*callback)(struct device *dev,
+							   enum intel_keembay_vpu_event event));
+int intel_keembay_vpu_unregister_for_events(struct device *dev);
+
+#endif /* __KEEMBAY_VPU_IPC_H */
-- 
2.17.1

