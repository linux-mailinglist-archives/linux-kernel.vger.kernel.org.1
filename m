Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44B112B8980
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 02:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbgKSBZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 20:25:44 -0500
Received: from mga04.intel.com ([192.55.52.120]:47676 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727271AbgKSBZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 20:25:43 -0500
IronPort-SDR: WeR1AMjy/qoZccpORpKpktG2WZweakC+tDMeba7/BzDiq1y5SB6pZJF6lZFQUdc/qx6pghHDFk
 xZdI6t68WpnQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="168642112"
X-IronPort-AV: E=Sophos;i="5.77,489,1596524400"; 
   d="scan'208";a="168642112"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 17:25:43 -0800
IronPort-SDR: CMt02MWC419uB6qBJhcyquZUdE1qINdwOM4xojFzmXshRBPtUb/R4UOWzwiceFSmUmLikh2mm4
 QUKEmMRZCT+A==
X-IronPort-AV: E=Sophos;i="5.77,489,1596524400"; 
   d="scan'208";a="532968596"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.212.246.14])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 17:25:42 -0800
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v6 1/6] mfd: intel-m10-bmc: support for MAX10 BMC Secure Updates
Date:   Wed, 18 Nov 2020 17:25:27 -0800
Message-Id: <20201119012532.138517-2-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201119012532.138517-1-russell.h.weight@intel.com>
References: <20201119012532.138517-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add macros and definitions required by the MAX10 BMC
Secure Update driver.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
v6:
  - No change
v5:
  - Renamed USER_FLASH_COUNT to STAGING_FLASH_COUNT
v4:
  - No change
v3:
  - Changed "MAX10 BMC Secure Engine driver" to "MAX10 BMC Secure
    Update driver"
  - Removed wrapper functions (m10bmc_raw_*, m10bmc_sys_*). The
    underlying functions will be called directly.
v2:
  - These functions and macros were previously distributed among
    the patches that needed them. They are now grouped together
    in a single patch containing changes to the Intel MAX10 BMC
    driver.
  - Added DRBL_ prefix to some definitions
  - Some address definitions were moved here from the .c files that
    use them.
---
 include/linux/mfd/intel-m10-bmc.h | 85 +++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
index c8ef2f1654a4..ab8d78b92df9 100644
--- a/include/linux/mfd/intel-m10-bmc.h
+++ b/include/linux/mfd/intel-m10-bmc.h
@@ -13,6 +13,9 @@
 #define M10BMC_SYS_BASE			0x300800
 #define M10BMC_MEM_END			0x200000fc
 
+#define M10BMC_STAGING_BASE		0x18000000
+#define M10BMC_STAGING_SIZE		0x3800000
+
 /* Register offset of system registers */
 #define NIOS2_FW_VERSION		0x0
 #define M10BMC_TEST_REG			0x3c
@@ -21,6 +24,88 @@
 #define M10BMC_VER_PCB_INFO_MSK		GENMASK(31, 24)
 #define M10BMC_VER_LEGACY_INVALID	0xffffffff
 
+/* Secure update doorbell register, in system register region */
+#define M10BMC_DOORBELL			0x400
+
+/* Authorization Result register, in system register region */
+#define M10BMC_AUTH_RESULT		0x404
+
+/* Doorbell register fields */
+#define DRBL_RSU_REQUEST		BIT(0)
+#define DRBL_RSU_PROGRESS		GENMASK(7, 4)
+#define DRBL_HOST_STATUS		GENMASK(11, 8)
+#define DRBL_RSU_STATUS			GENMASK(23, 16)
+#define DRBL_PKVL_EEPROM_LOAD_SEC	BIT(24)
+#define DRBL_PKVL1_POLL_EN		BIT(25)
+#define DRBL_PKVL2_POLL_EN		BIT(26)
+#define DRBL_CONFIG_SEL			BIT(28)
+#define DRBL_REBOOT_REQ			BIT(29)
+#define DRBL_REBOOT_DISABLED		BIT(30)
+
+/* Progress states */
+#define RSU_PROG_IDLE			0x0
+#define RSU_PROG_PREPARE		0x1
+#define RSU_PROG_READY			0x3
+#define RSU_PROG_AUTHENTICATING		0x4
+#define RSU_PROG_COPYING		0x5
+#define RSU_PROG_UPDATE_CANCEL		0x6
+#define RSU_PROG_PROGRAM_KEY_HASH	0x7
+#define RSU_PROG_RSU_DONE		0x8
+#define RSU_PROG_PKVL_PROM_DONE		0x9
+
+/* Device and error states */
+#define RSU_STAT_NORMAL			0x0
+#define RSU_STAT_TIMEOUT		0x1
+#define RSU_STAT_AUTH_FAIL		0x2
+#define RSU_STAT_COPY_FAIL		0x3
+#define RSU_STAT_FATAL			0x4
+#define RSU_STAT_PKVL_REJECT		0x5
+#define RSU_STAT_NON_INC		0x6
+#define RSU_STAT_ERASE_FAIL		0x7
+#define RSU_STAT_WEAROUT		0x8
+#define RSU_STAT_NIOS_OK		0x80
+#define RSU_STAT_USER_OK		0x81
+#define RSU_STAT_FACTORY_OK		0x82
+#define RSU_STAT_USER_FAIL		0x83
+#define RSU_STAT_FACTORY_FAIL		0x84
+#define RSU_STAT_NIOS_FLASH_ERR		0x85
+#define RSU_STAT_FPGA_FLASH_ERR		0x86
+
+#define HOST_STATUS_IDLE		0x0
+#define HOST_STATUS_WRITE_DONE		0x1
+#define HOST_STATUS_ABORT_RSU		0x2
+
+#define rsu_prog(doorbell)	FIELD_GET(DRBL_RSU_PROGRESS, doorbell)
+#define rsu_stat(doorbell)	FIELD_GET(DRBL_RSU_STATUS, doorbell)
+
+/* interval 100ms and timeout 5s */
+#define NIOS_HANDSHAKE_INTERVAL_US	(100 * 1000)
+#define NIOS_HANDSHAKE_TIMEOUT_US	(5 * 1000 * 1000)
+
+/* RSU PREP Timeout (2 minutes) to erase flash staging area */
+#define RSU_PREP_INTERVAL_MS		100
+#define RSU_PREP_TIMEOUT_MS		(2 * 60 * 1000)
+
+/* RSU Complete Timeout (40 minutes) for full flash update */
+#define RSU_COMPLETE_INTERVAL_MS	1000
+#define RSU_COMPLETE_TIMEOUT_MS		(40 * 60 * 1000)
+
+/* Addresses for security related data in FLASH */
+#define BMC_REH_ADDR	0x17ffc004
+#define BMC_PROG_ADDR	0x17ffc000
+#define BMC_PROG_MAGIC	0x5746
+
+#define SR_REH_ADDR	0x17ffd004
+#define SR_PROG_ADDR	0x17ffd000
+#define SR_PROG_MAGIC	0x5253
+
+#define PR_REH_ADDR	0x17ffe004
+#define PR_PROG_ADDR	0x17ffe000
+#define PR_PROG_MAGIC	0x5250
+
+/* Address of 4KB inverted bit vector containing staging area FLASH count */
+#define STAGING_FLASH_COUNT	0x17ffb000
+
 /**
  * struct intel_m10bmc - Intel MAX 10 BMC parent driver data structure
  * @dev: this device
-- 
2.25.1

