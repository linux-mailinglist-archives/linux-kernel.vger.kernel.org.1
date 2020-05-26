Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEDE1ABB4B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 10:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502389AbgDPIcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 04:32:10 -0400
Received: from mga09.intel.com ([134.134.136.24]:23582 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2501894AbgDPIQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 04:16:37 -0400
IronPort-SDR: JuLI0jUv0YHLuG0ChTiKVjByglaSF3v9Tj11Tb/a9/BhLqGIzeAGqt/CddzNwA8+xJFAEe90zG
 XkPuK9lKvgsA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 01:16:02 -0700
IronPort-SDR: je9uSHfTopI8zKPeIXd1ecXGtRDKbQquyoREJ6tz9j1tSUcJg+vvVZEguASJsbioSU6d6NCCFy
 LT9U1Yy1zKVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,390,1580803200"; 
   d="scan'208";a="257138854"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 16 Apr 2020 01:15:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 90B11E8C; Thu, 16 Apr 2020 11:15:53 +0300 (EEST)
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
Subject: [PATCH v9 11/20] mfd: intel_soc_pmic_bxtwc: Convert to use new SCU IPC API
Date:   Thu, 16 Apr 2020 11:15:43 +0300
Message-Id: <20200416081552.68083-12-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200416081552.68083-1-mika.westerberg@linux.intel.com>
References: <20200416081552.68083-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Intel Broxton Whiskey Cover PMIC driver to use the new SCU
IPC API. This allows us to get rid of the PMC IPC implementation which
is now covered in SCU IPC driver. We drop the error log if the IPC
command fails because intel_scu_ipc_dev_command() does that already.

Also move PMIC specific IPC message constants to the PMIC driver from
the intel_pmc_ipc.h header.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 arch/x86/include/asm/intel_pmc_ipc.h |  3 ---
 drivers/mfd/intel_soc_pmic_bxtwc.c   | 34 ++++++++++++++--------------
 2 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/intel_pmc_ipc.h b/arch/x86/include/asm/intel_pmc_ipc.h
index e6da1ce26256..b438a488f613 100644
--- a/arch/x86/include/asm/intel_pmc_ipc.h
+++ b/arch/x86/include/asm/intel_pmc_ipc.h
@@ -3,9 +3,6 @@
 #define  _ASM_X86_INTEL_PMC_IPC_H_
 
 /* Commands */
-#define PMC_IPC_PMIC_ACCESS		0xFF
-#define		PMC_IPC_PMIC_ACCESS_READ	0x0
-#define		PMC_IPC_PMIC_ACCESS_WRITE	0x1
 #define PMC_IPC_USB_PWR_CTRL		0xF0
 #define PMC_IPC_PMIC_BLACKLIST_SEL	0xEF
 #define PMC_IPC_PHY_CONFIG		0xEE
diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index 739cfb5b69fe..eba89780dbe7 100644
--- a/drivers/mfd/intel_soc_pmic_bxtwc.c
+++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
@@ -15,7 +15,7 @@
 #include <linux/mfd/intel_soc_pmic_bxtwc.h>
 #include <linux/module.h>
 
-#include <asm/intel_pmc_ipc.h>
+#include <asm/intel_scu_ipc.h>
 
 /* PMIC device registers */
 #define REG_ADDR_MASK		0xFF00
@@ -58,6 +58,10 @@
 /* Whiskey Cove PMIC share same ACPI ID between different platforms */
 #define BROXTON_PMIC_WC_HRV	4
 
+#define PMC_PMIC_ACCESS		0xFF
+#define PMC_PMIC_READ		0x0
+#define PMC_PMIC_WRITE		0x1
+
 enum bxtwc_irqs {
 	BXTWC_PWRBTN_LVL1_IRQ = 0,
 	BXTWC_TMU_LVL1_IRQ,
@@ -288,13 +292,12 @@ static int regmap_ipc_byte_reg_read(void *context, unsigned int reg,
 
 	ipc_in[0] = reg;
 	ipc_in[1] = i2c_addr;
-	ret = intel_pmc_ipc_command(PMC_IPC_PMIC_ACCESS,
-			PMC_IPC_PMIC_ACCESS_READ,
-			ipc_in, sizeof(ipc_in), (u32 *)ipc_out, 1);
-	if (ret) {
-		dev_err(pmic->dev, "Failed to read from PMIC\n");
+	ret = intel_scu_ipc_dev_command(pmic->scu, PMC_PMIC_ACCESS,
+					PMC_PMIC_READ, ipc_in, sizeof(ipc_in),
+					ipc_out, sizeof(ipc_out));
+	if (ret)
 		return ret;
-	}
+
 	*val = ipc_out[0];
 
 	return 0;
@@ -303,7 +306,6 @@ static int regmap_ipc_byte_reg_read(void *context, unsigned int reg,
 static int regmap_ipc_byte_reg_write(void *context, unsigned int reg,
 				       unsigned int val)
 {
-	int ret;
 	int i2c_addr;
 	u8 ipc_in[3];
 	struct intel_soc_pmic *pmic = context;
@@ -321,15 +323,9 @@ static int regmap_ipc_byte_reg_write(void *context, unsigned int reg,
 	ipc_in[0] = reg;
 	ipc_in[1] = i2c_addr;
 	ipc_in[2] = val;
-	ret = intel_pmc_ipc_command(PMC_IPC_PMIC_ACCESS,
-			PMC_IPC_PMIC_ACCESS_WRITE,
-			ipc_in, sizeof(ipc_in), NULL, 0);
-	if (ret) {
-		dev_err(pmic->dev, "Failed to write to PMIC\n");
-		return ret;
-	}
-
-	return 0;
+	return intel_scu_ipc_dev_command(pmic->scu, PMC_PMIC_ACCESS,
+					 PMC_PMIC_WRITE, ipc_in, sizeof(ipc_in),
+					 NULL, 0);
 }
 
 /* sysfs interfaces to r/w PMIC registers, required by initial script */
@@ -457,6 +453,10 @@ static int bxtwc_probe(struct platform_device *pdev)
 	dev_set_drvdata(&pdev->dev, pmic);
 	pmic->dev = &pdev->dev;
 
+	pmic->scu = devm_intel_scu_ipc_dev_get(&pdev->dev);
+	if (!pmic->scu)
+		return -EPROBE_DEFER;
+
 	pmic->regmap = devm_regmap_init(&pdev->dev, NULL, pmic,
 					&bxtwc_regmap_config);
 	if (IS_ERR(pmic->regmap)) {
-- 
2.25.1

