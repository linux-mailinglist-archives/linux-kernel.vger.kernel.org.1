Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84673287B9A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 20:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgJHSWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 14:22:02 -0400
Received: from mga05.intel.com ([192.55.52.43]:32109 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbgJHSWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 14:22:01 -0400
IronPort-SDR: 4bjOiYMRj/abtgJMAGNOEdu4NXoBlh4jyC71DG+QTh8hne+TMvEO3Ipy60VkOZH8JbYSnHk2l8
 nWd8tbF7MI4Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9768"; a="250078388"
X-IronPort-AV: E=Sophos;i="5.77,351,1596524400"; 
   d="scan'208";a="250078388"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2020 11:22:01 -0700
IronPort-SDR: t8c24oTZ4xxPnrr4TlH5ygvnILrdLs5QQ7QaR32zFL6nxc58zqF2l+dOA4zB1DFZ8bbhxnRN71
 7yqmrSZPd11A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,351,1596524400"; 
   d="scan'208";a="349572534"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.114])
  by fmsmga002.fm.intel.com with ESMTP; 08 Oct 2020 11:21:56 -0700
From:   muhammad.husaini.zulkifli@intel.com
To:     adrian.hunter@intel.com, michal.simek@xilinx.com,
        andriy.shevchenko@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     lakshmi.bai.raja.subramanian@intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com,
        muhammad.husaini.zulkifli@intel.com, arnd@arndb.de
Subject: [PATCH v5 1/4] firmware: keembay: Add support for Trusted Firmware Service call
Date:   Fri,  9 Oct 2020 02:18:41 +0800
Message-Id: <20201008181844.27947-2-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201008181844.27947-1-muhammad.husaini.zulkifli@intel.com>
References: <20201008181844.27947-1-muhammad.husaini.zulkifli@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>

Add header file to handle API function for device driver to
communicate with Trusted Firmware - A profile(TF-A)
or Trusted Firmware - M profile (TF-M).

Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Acked-by: Michal Simek <michal.simek@xilinx.com>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
---
 include/linux/firmware/intel/keembay.h | 47 ++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 include/linux/firmware/intel/keembay.h

diff --git a/include/linux/firmware/intel/keembay.h b/include/linux/firmware/intel/keembay.h
new file mode 100644
index 000000000000..363e6bf2c27a
--- /dev/null
+++ b/include/linux/firmware/intel/keembay.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Intel Keembay SOC Firmware API Layer
+ *
+ *  Copyright (C) 2020, Intel Corporation
+ *
+ *  Author: Muhammad Husaini Zulkifli <Muhammad.Husaini.Zulkifli@intel.com>
+ */
+
+#ifndef __FIRMWARE_KEEMBAY_SMC_H__
+#define __FIRMWARE_KEEMBAY_SMC_H__
+
+#include <linux/arm-smccc.h>
+
+/*
+ * This file defines an API function that can be called by a device driver in order to
+ * communicate with Trusted Firmware - A profile(TF-A) or Trusted Firmware - M profile (TF-M).
+ */
+
+/* Setting for Keem Bay IO Pad Line Voltage Selection */
+#define ARM_SMCCC_SIP_KEEMBAY_SET_SD_VOLTAGE		\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,		\
+			   ARM_SMCCC_SMC_32,		\
+			   ARM_SMCCC_OWNER_SIP,		\
+			   0xFF26)
+
+#define KEEMBAY_SET_1V8_VOLT	1
+#define KEEMBAY_SET_3V3_VOLT	0
+
+#if IS_ENABLED(CONFIG_HAVE_ARM_SMCCC_DISCOVERY)
+static inline int keembay_sd_voltage_selection(int volt)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_invoke(ARM_SMCCC_SIP_KEEMBAY_SET_SD_VOLTAGE, volt, &res);
+	if ((int)res.a0 < 0)
+		return -EINVAL;
+
+	return 0;
+}
+#else
+static inline int keembay_sd_voltage_selection(int volt)
+{
+	return -ENODEV;
+}
+#endif
+#endif /* __FIRMWARE_KEEMBAY_SMC_H__ */
-- 
2.17.1

