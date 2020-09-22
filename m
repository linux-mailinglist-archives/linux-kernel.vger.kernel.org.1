Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7B1274116
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 13:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgIVLmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 07:42:14 -0400
Received: from mail-dm6nam12on2040.outbound.protection.outlook.com ([40.107.243.40]:17665
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726593AbgIVLlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 07:41:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBPX+XkgP/p8KkX0TjzPETDw1JPy9YZVf8DQhLxQKRzSYBq5EYGL5nAez/myetRKdDNzfdJ1Iftl/S5VgtiplSPs8rDsGgzMBWqi+vR9xrjDAEVFQkePn4fgb8LzBvIbTZ0Mgb5gqF0W/5P+WXPwleqKnL7E5JJEnXJXqKQgoCDrtf0xSt0GQVk7nYIWtdj4IchPR4QB3zzxU7ICJbpujW9v4VBbmCTf2J8lhq3OJco8IqJxZvOlFF3UUFaPNdPXsSbjCF0YcecUsoTZPG8CTKWJcFVpNXEPPhrYcgrp6V8nftAS4kMQcyEV8LhE1kzt3hUMTvSgUgjxHL+rU9zzTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHFmUf4zdPp9E9fiTXTgxVAXR2Mnh3CKT04WosMCyMY=;
 b=arsq+yUCAxRtVwMxTsWmBkSyiXb5Fj6WZsxI9JYrctKKZDEzW1Wj3+tMVQYaX6LXPWWHFFojjeUP0jxEE2bU9XB64uLLIUpMOre+ICkL+1kset57EBdiOT2AAjHEh3PN3401bsML0Tk4DkIff4LsEQfU3Kn3UYMvHxbBjkNFpgO7Ea/TzaFbQA4ZYspa1WYR1B2HNfRlojvXEu7d8D63ry2O1zAA32grTp8g8vKDYxMUuTFaIbLUCygkKS4lyIpmJ+L86wDF3YyvSnLvv8o1ukfGtoIIsCL2+AtvrAoVeBLBglAzytHmx2oOfbFlFZ5Sa1vvgRclXxrXr2rgo8kIaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHFmUf4zdPp9E9fiTXTgxVAXR2Mnh3CKT04WosMCyMY=;
 b=zi6ffPgdU6OM3oQCbbokmwmdNGrBWX4pZU5msEQjfw+Ic704OBcfWqBjmTfW1Z93YQoOo0uYCPcOmnmUZSgXhxyIjx8NZxL7Pde8XGIKhKRq4R8HxrkRAcyfTufE9USbh2G6yY37tQOP9rablO87C4daCld3UqobMyHnwSKAGXc=
Authentication-Results: linux-watchdog.org; dkim=none (message not signed)
 header.d=none;linux-watchdog.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3551.namprd12.prod.outlook.com (2603:10b6:208:104::30)
 by MN2PR12MB3054.namprd12.prod.outlook.com (2603:10b6:208:d1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Tue, 22 Sep
 2020 11:40:50 +0000
Received: from MN2PR12MB3551.namprd12.prod.outlook.com
 ([fe80::31f1:383c:745:3f18]) by MN2PR12MB3551.namprd12.prod.outlook.com
 ([fe80::31f1:383c:745:3f18%4]) with mapi id 15.20.3391.027; Tue, 22 Sep 2020
 11:40:50 +0000
From:   Sanjay R Mehta <sanju.mehta@amd.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     mchehab+huawei@kernel.org, davem@davemloft.net, robh@kernel.org,
        linux-kernel@vger.kernel.org, Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH] watchdog: amd-wdt: Add AMD FCH hw watchdog driver support
Date:   Tue, 22 Sep 2020 06:40:22 -0500
Message-Id: <1600774822-19890-1-git-send-email-sanju.mehta@amd.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: MA1PR0101CA0045.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::31) To MN2PR12MB3551.namprd12.prod.outlook.com
 (2603:10b6:208:104::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sanjuamdntb2.amd.com (165.204.156.251) by MA1PR0101CA0045.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3391.11 via Frontend Transport; Tue, 22 Sep 2020 11:40:47 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a76bd9e2-bd96-41ba-d825-08d85eec5a86
X-MS-TrafficTypeDiagnostic: MN2PR12MB3054:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3054ABD3C55DAB91A50EAC64E53B0@MN2PR12MB3054.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SaCJr3dhRagDgg/hwKKupqG3VRJ6RXNGmitN3m4fXdq6ufoTgg+xP5wEBzKL+KwovxZPW6LT6i/jUYNWTpcas/Zo3wJteP3rc7Rw1jZRJ1qFJffOzh7sNWkO0WqwniqCGtNtNV6CXn3DNwEz7DlJLGh51pfnqcjrAltcp8URMzXAJvW9dSltUK+MCOF+8APmxPpb4qEHkcPciJHI0Kyf0OLvOm7gld/fGA8Y15K59oWAkz+hfh7T/Wm60ttBd9vD6wpzpSLUh6F/g4eYpnxRATQ6LjD8EoTX8uPydwHV+M7/uTImB0zZycj/qsNnpTUudt791tHWDMfSTaRZpuCsbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3551.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(66946007)(86362001)(186003)(8936002)(66476007)(2906002)(6666004)(8676002)(5660300002)(26005)(30864003)(4326008)(66556008)(16526019)(478600001)(6486002)(52116002)(956004)(7696005)(316002)(36756003)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: XOrTgo5yTTJZ3S+ObL3ydRJT70KWU3cixdUJGI4zbOnCd+SV7kBtgtVBbKC2EwuiSWBZ7zRsnW52/L7vbsVSHKtPRtEdtBBoRw4XviS7EebqSxsd4MvX/GgFFllMl6+dV2c7VUZ6NQ5z79TSs5AvW8ny+xunYakdXUGl26CHFflYdlWth+G+gYzbAM3F/9BvpGEQZXRpY6tNt+sII1zmQ6UmFdRoj9is+qWqaXH0UdqJmnrES7kGEtlDJA95o6NiHcf/9v6PbuJ7Z9nbvT1bS0sh+USalcFAO7d7eVOq4mfvGwZl5d//YNFIuNQxl14+d8rYPRDSgcu1DWEsk3wQFK03JymyiA6CAtwsvfU8LdOdRR+WPd4aZ/WwbbnbpkCOYgnKql+r6y/xEz285q/NpaR4mvIAZrVbCpuEN8ZxR6tdcT7HUpptjaK2W2OPuLO8R0oBZe3LpBdnvELnEKepByOfeXENTNfJsoxzMPk1RXs2oT4ACqPYfZz5uUqAy9q1xhhXkrrmdHebImjCOj2fVdeCfiywsooqMMINMSizC4xlsrXLNcXTOXTNQzraIdt0w8UUKBCDgfuNhTjw2Uba42FxH0MVkhJ8qKuRb6KT11LpGHIobe1EpEvcFE4y6kdp0Zix1amAhtCLPhJw7blrTA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a76bd9e2-bd96-41ba-d825-08d85eec5a86
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3551.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2020 11:40:50.4740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2D/IROlZwF+rRloY2WzcrRbc2qxAthrTFl7g3mzFrZ8NfjO/6NUZ0vAr/6bP7ghrGCyo32dVx+VHtvbU+URzLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3054
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver supports hardware watchdog for AMD SoCs.

Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
---
 MAINTAINERS                |   5 +
 drivers/watchdog/Kconfig   |  14 ++
 drivers/watchdog/Makefile  |   1 +
 drivers/watchdog/amd_wdt.c | 361 +++++++++++++++++++++++++++++++++++++
 4 files changed, 381 insertions(+)
 create mode 100644 drivers/watchdog/amd_wdt.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0d0862b19ce5..22058d19cbbc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -909,6 +909,11 @@ F:	drivers/gpu/drm/amd/include/v9_structs.h
 F:	drivers/gpu/drm/amd/include/vi_structs.h
 F:	include/uapi/linux/kfd_ioctl.h
 
+AMD FCH WDT DRIVER
+M:	Sanjay R Mehta <sanju.mehta@amd.com>
+S:	Maintained
+F:	drivers/watchdog/amd_wdt.c
+
 AMD SPI DRIVER
 M:	Sanjay R Mehta <sanju.mehta@amd.com>
 S:	Maintained
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index ab7aad5a1e69..8c4827cbed67 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1226,6 +1226,20 @@ config INTEL_MID_WATCHDOG
 
 	  To compile this driver as a module, choose M here.
 
+config AMD_FCH_WATCHDOG
+	tristate "AMD FCH Watchdog timer"
+	depends on X86 && PCI
+	select WATCHDOG_CORE
+	help
+	  Hardware watchdog driver for the AMD SoC. It is a watchdog
+	  timer that will reboot/shutdown the machine after its expiration.
+	  The expiration time can be configured with the "heartbeat" parameter
+	  and the action on expiration can be configured to reboot/shutdown
+	  using "action" parameter.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called amd_wdt.
+
 config ITCO_WDT
 	tristate "Intel TCO Timer/Watchdog"
 	depends on (X86 || IA64) && PCI
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 97bed1d3d97c..3bddcdad0815 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -225,3 +225,4 @@ obj-$(CONFIG_MENF21BMC_WATCHDOG) += menf21bmc_wdt.o
 obj-$(CONFIG_MENZ069_WATCHDOG) += menz69_wdt.o
 obj-$(CONFIG_RAVE_SP_WATCHDOG) += rave-sp-wdt.o
 obj-$(CONFIG_STPMIC1_WATCHDOG) += stpmic1_wdt.o
+obj-$(CONFIG_AMD_FCH_WATCHDOG) += amd_wdt.o
diff --git a/drivers/watchdog/amd_wdt.c b/drivers/watchdog/amd_wdt.c
new file mode 100644
index 000000000000..a37cd8a71d7b
--- /dev/null
+++ b/drivers/watchdog/amd_wdt.c
@@ -0,0 +1,361 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+//
+// AMD Watchdog controller driver
+//
+// Copyright (c) 2020, Advanced Micro Devices, Inc.
+//
+// Author: Sanjay R Mehta <sanju.mehta@amd.com>
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/types.h>
+#include <linux/watchdog.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/ioport.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/acpi.h>
+
+#define AMD_WDT_CONTROL(base)		((base) + 0x00) /* Watchdog Control */
+#define AMD_WDT_START_STOP_BIT		BIT(0)
+#define AMD_WDT_FIRED_BIT		BIT(1)
+#define AMD_WDT_ACTION_RESET_BIT	BIT(2)
+/* 6:4 bits Reserved */
+#define AMD_WDT_TRIGGER_BIT		BIT(7)
+#define AMD_WDT_COUNT(base)		((base) + 0x04) /* Watchdog Count */
+#define AMD_WDT_COUNT_MASK		0xFFFF
+
+#define AMD_PM_WATCHDOG_EN_REG		0x00
+#define AMD_PM_WATCHDOG_TIMER_EN	(0x01 << 7)
+
+#define AMD_PM_WATCHDOG_CONFIG_REG	0x03
+#define AMD_PM_WATCHDOG_32USEC_RES	0x0
+#define AMD_PM_WATCHDOG_10MSEC_RES	0x1
+#define AMD_PM_WATCHDOG_100MSEC_RES	0x2
+#define AMD_PM_WATCHDOG_1SEC_RES	0x3
+#define AMD_PM_WATCHDOG_CONFIG_MASK	0x3
+
+/* IO port address for indirect access using ACPI PM registers */
+#define AMD_IO_PM_INDEX_REG		0xCD6
+#define AMD_IO_PM_DATA_REG		0xCD7
+
+/* Module and version information */
+#define WDT_MODULE_NAME "AMD watchdog timer"
+#define WDT_DRIVER_NAME	WDT_MODULE_NAME ", v" WDT_VERSION
+
+#define AMD_WDT_DEFAULT_TIMEOUT		60 /* 60 units default heartbeat. */
+#define AMD_WDT_MIN_TIMEOUT		0x0001	/* minimum timeout value */
+#define AMD_WDT_MAX_TIMEOUT		0xFFFF	/* maximum timeout value */
+#define MAX_LENGTH	(8 + 1) /* shutdown has 8 character + NULL character */
+
+/* internal variables */
+static void __iomem *wdtbase;
+static DEFINE_SPINLOCK(wdt_lock);
+
+/* module parameters */
+static int heartbeat = AMD_WDT_DEFAULT_TIMEOUT;
+module_param(heartbeat, int, 0);
+MODULE_PARM_DESC(heartbeat, "WDT timeout in frequency units. (default="
+				 __MODULE_STRING(WATCHDOG_HEARTBEAT) ")");
+
+static char frequency[MAX_LENGTH] = "1s";
+module_param_string(frequency, frequency, MAX_LENGTH, 0);
+MODULE_PARM_DESC(frequency,
+		 "WDT frequency units(32us, 10ms, 100ms, 1s). (default=1s)");
+
+static bool nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, bool, 0);
+MODULE_PARM_DESC(nowayout, "WDT cannot be stopped once started (default="
+				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+static char action[MAX_LENGTH] = "reboot";
+module_param_string(action, action, MAX_LENGTH, 0);
+MODULE_PARM_DESC(action, "WDT action (reboot/shutdown).(default=reboot)");
+
+/*
+ * Watchdog specific functions
+ */
+static int amd_wdt_set_timeout(struct watchdog_device *wdt_dev, unsigned int t)
+{
+	unsigned long flags;
+
+	/*
+	 * In ideal cases the limits will be checked by Watchdog core itself,
+	 * but there might be cases when we call this function directly from
+	 * somewhere else. So check the limits here.
+	 */
+	if (t < AMD_WDT_MIN_TIMEOUT)
+		heartbeat = AMD_WDT_MIN_TIMEOUT;
+	else if (t > AMD_WDT_MAX_TIMEOUT)
+		heartbeat = AMD_WDT_MAX_TIMEOUT;
+
+	t = heartbeat;
+	/* Write new timeout value to watchdog */
+	spin_lock_irqsave(&wdt_lock, flags);
+	writel(t, AMD_WDT_COUNT(wdtbase));
+	spin_unlock_irqrestore(&wdt_lock, flags);
+
+	wdt_dev->timeout = t;
+
+	return 0;
+}
+
+static int amd_wdt_ping(struct watchdog_device *wdt_dev)
+{
+	u32 val;
+	unsigned long flags;
+
+	/* Trigger watchdog */
+	spin_lock_irqsave(&wdt_lock, flags);
+
+	val = readl(AMD_WDT_CONTROL(wdtbase));
+	val |= AMD_WDT_TRIGGER_BIT;
+	writel(val, AMD_WDT_CONTROL(wdtbase));
+
+	spin_unlock_irqrestore(&wdt_lock, flags);
+
+	return 0;
+}
+
+static int amd_wdt_start(struct watchdog_device *wdt_dev)
+{
+	u32 val;
+	unsigned long flags;
+
+	/* Enable the watchdog timer */
+	spin_lock_irqsave(&wdt_lock, flags);
+
+	val = readl(AMD_WDT_CONTROL(wdtbase));
+	val |= AMD_WDT_START_STOP_BIT;
+	writel(val, AMD_WDT_CONTROL(wdtbase));
+
+	spin_unlock_irqrestore(&wdt_lock, flags);
+
+	/* Trigger the watchdog timer */
+	amd_wdt_ping(wdt_dev);
+
+	return 0;
+}
+
+static int amd_wdt_stop(struct watchdog_device *wdt_dev)
+{
+	u32 val;
+	unsigned long flags;
+
+	/* Disable the watchdog timer */
+	spin_lock_irqsave(&wdt_lock, flags);
+
+	val = readl(AMD_WDT_CONTROL(wdtbase));
+	val &= ~AMD_WDT_START_STOP_BIT;
+	writel(val, AMD_WDT_CONTROL(wdtbase));
+
+	spin_unlock_irqrestore(&wdt_lock, flags);
+
+	return 0;
+}
+
+static unsigned int amd_wdt_get_timeleft(struct watchdog_device *wdt_dev)
+{
+	u32 val;
+	unsigned long flags;
+
+	spin_lock_irqsave(&wdt_lock, flags);
+	val = readl(AMD_WDT_COUNT(wdtbase));
+	spin_unlock_irqrestore(&wdt_lock, flags);
+
+	/* Mask out the upper 16-bits and return */
+	return val & AMD_WDT_COUNT_MASK;
+}
+
+static unsigned int amd_wdt_status(struct watchdog_device *wdt_dev)
+{
+	return wdt_dev->status;
+}
+
+static struct watchdog_ops amd_wdt_ops = {
+	.owner		= THIS_MODULE,
+	.start		= amd_wdt_start,
+	.stop		= amd_wdt_stop,
+	.ping		= amd_wdt_ping,
+	.status		= amd_wdt_status,
+	.set_timeout	= amd_wdt_set_timeout,
+	.get_timeleft	= amd_wdt_get_timeleft,
+};
+
+static struct watchdog_info amd_wdt_info = {
+	.options		= WDIOF_SETTIMEOUT |
+				  WDIOF_MAGICCLOSE |
+				  WDIOF_KEEPALIVEPING,
+	.firmware_version	= 0,
+	.identity		= WDT_MODULE_NAME,
+};
+
+static struct watchdog_device amd_wdt_dev = {
+	.info		= &amd_wdt_info,
+	.ops		= &amd_wdt_ops,
+};
+
+static unsigned char amd_wdt_setupdevice(struct platform_device *pdev)
+{
+	struct resource *res;
+	int err = 0;
+	u32 val;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	wdtbase = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(wdtbase)) {
+		err = PTR_ERR(wdtbase);
+		dev_err(&pdev->dev, "error %d ioremap of WDT registers failed\n", err);
+		return 0;
+	}
+	dev_dbg(&pdev->dev, "io_remap_address: %p\n", wdtbase);
+
+	/* Enable watchdog timer and decode bit */
+	outb(AMD_PM_WATCHDOG_EN_REG, AMD_IO_PM_INDEX_REG);
+	val = inb(AMD_IO_PM_DATA_REG);
+	val |= AMD_PM_WATCHDOG_TIMER_EN;
+	outb(val, AMD_IO_PM_DATA_REG);
+
+	/* Set the watchdog timer resolution */
+	outb(AMD_PM_WATCHDOG_CONFIG_REG, AMD_IO_PM_INDEX_REG);
+	val = inb(AMD_IO_PM_DATA_REG);
+	/* Clear the previous frequency setting, if any */
+	val &= ~AMD_PM_WATCHDOG_CONFIG_MASK;
+
+	/*
+	 * Now set the frequency depending on the module load parameter.
+	 * In case the user passes an invalid argument, we consider the
+	 * frequency to be of 1 second resolution.
+	 */
+	if (strncmp(frequency, "32us", 4) == 0) {
+		val |= AMD_PM_WATCHDOG_32USEC_RES;
+	} else if (strncmp(frequency, "10ms", 4) == 0) {
+		val |= AMD_PM_WATCHDOG_10MSEC_RES;
+	} else if (strncmp(frequency, "100ms", 5) == 0) {
+		val |= AMD_PM_WATCHDOG_100MSEC_RES;
+	} else {
+		val |= AMD_PM_WATCHDOG_1SEC_RES;
+		if (strncmp(frequency, "1s", 2) != 0)
+			strncpy(frequency, "1s", 2);
+	}
+
+	outb(val, AMD_IO_PM_DATA_REG);
+
+	/* Set the watchdog action depending on module load parameter. */
+	val = readl(AMD_WDT_CONTROL(wdtbase));
+
+	/*
+	 * If action is specified anything other than reboot or shutdown,
+	 * we default it to reboot.
+	 */
+	if (strncmp(action, "shutdown", 8) == 0) {
+		val |= AMD_WDT_ACTION_RESET_BIT;
+	} else {
+		val &= ~AMD_WDT_ACTION_RESET_BIT;
+		/*
+		 * The statement below is required for when the action
+		 * is set anything other than reboot.
+		 */
+		if (strncmp(action, "reboot", 6) != 0)
+			strncpy(action, "reboot", 6);
+	}
+
+	/*
+	 * Since the watchdog fired bit gets cleared if written to, we
+	 * need to mask it before writing into the Watchdog Control
+	 * register, to avoid inadvertent side-effect.
+	 */
+	val &= ~AMD_WDT_FIRED_BIT;
+	writel(val, AMD_WDT_CONTROL(wdtbase));
+
+	return 1;
+}
+
+static int amd_wdt_probe(struct platform_device *pdev)
+{
+	int ret;
+	u32 val;
+
+	/* Identify our device and initialize watchdog hardware */
+	if (!amd_wdt_setupdevice(pdev))
+		return -ENODEV;
+
+	/* Check to see if last reboot was due to watchdog timeout */
+	val = readl(AMD_WDT_CONTROL(wdtbase));
+	if (val & AMD_WDT_FIRED_BIT)
+		amd_wdt_dev.bootstatus |= WDIOF_CARDRESET;
+	else
+		amd_wdt_dev.bootstatus &= ~WDIOF_CARDRESET;
+
+	pr_info("Watchdog reboot/shutdown %sdetected\n",
+		(val & AMD_WDT_FIRED_BIT) ? "" : "not ");
+
+	/* Clear out the old status */
+	val |= AMD_WDT_FIRED_BIT;
+	writel(val, AMD_WDT_CONTROL(wdtbase));
+
+	amd_wdt_dev.timeout = heartbeat;
+	amd_wdt_dev.min_timeout = AMD_WDT_MIN_TIMEOUT;
+	amd_wdt_dev.max_timeout = AMD_WDT_MAX_TIMEOUT;
+	watchdog_set_nowayout(&amd_wdt_dev, nowayout);
+
+	/* Make sure watchdog is not running */
+	amd_wdt_stop(&amd_wdt_dev);
+
+	/* Set Watchdog timeout */
+	amd_wdt_set_timeout(&amd_wdt_dev, heartbeat);
+
+	ret = watchdog_register_device(&amd_wdt_dev);
+	if (ret != 0) {
+		pr_err("watchdog: cannot register wdt device (err=%d)\n", ret);
+		return ret;
+	}
+
+	pr_info("timeout=%d units, frequency=%s, nowayout=%d, action=%s\n",
+		heartbeat, frequency, nowayout, action);
+
+	return 0;
+}
+
+static int amd_wdt_remove(struct platform_device *dev)
+{
+	if (!wdtbase)
+		return 0;
+
+	/* Stop the timer before we leave */
+	if (!nowayout)
+		amd_wdt_stop(NULL);
+
+	watchdog_unregister_device(&amd_wdt_dev);
+
+	return 0;
+}
+
+static void amd_wdt_shutdown(struct platform_device *dev)
+{
+	amd_wdt_stop(NULL);
+}
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id wdt_acpi_match[] = {
+	{ "AMDI0090", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, wdt_acpi_match);
+#endif
+
+static struct platform_driver amd_wdt_driver = {
+	.driver = {
+		.name = "amd_wdt",
+		.acpi_match_table = ACPI_PTR(wdt_acpi_match),
+	},
+	.probe		= amd_wdt_probe,
+	.remove		= amd_wdt_remove,
+	.shutdown	= amd_wdt_shutdown,
+};
+module_platform_driver(amd_wdt_driver);
+
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_AUTHOR("Sanjay Mehta <sanju.mehta@amd.com>");
+MODULE_DESCRIPTION("Watchdog timer driver for AMD chipsets");
-- 
2.17.1

