Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12ACF297218
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 17:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S465688AbgJWPQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 11:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S465681AbgJWPQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 11:16:19 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728E6C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 08:16:19 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id w21so1566000pfc.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 08:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pez1QoCZuFu+D/06A/8PmRLGPUSFi/3FyToNKrfrqe4=;
        b=GGM7j1tVoOALPpvbyOH4c4+dTOLx+3Ef/LsFkWirLqOEXjeveHAXYChNvsod4riUKL
         +r008X6MjheTTjXLNwu0j6WwnZOsQllhx0sWf7PKShwpf+0wAB7dwtJ0w1lzkZyoW5my
         VldSRNBJCrVrwGgLnJ/edpr8uimN/elKfWyXN+PPhDZuN0gwBLXQwSg9AuBbrvZ2qVsW
         YTaRfdYjuzZ5bhe6gikZuHLZWkeN6Kwr+sZ0E7lGiVmkhYH0ATd75uw/k2kI39sblZJM
         ddeI+XVYHM2v/cKjAoQUO4cuNN7ldRsIWVFFGxFKpc89Vfa/e9Ms2Hd6LoLcJsnVJ/NJ
         GJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pez1QoCZuFu+D/06A/8PmRLGPUSFi/3FyToNKrfrqe4=;
        b=k9XkFch/0LO7uVAnjOhrh8DoiFiUFwYpTSv8gArwGOZ9b2JqHZ7p9L2ce2pABsudi2
         NsGYM9zCW7v4VwLQV3ebwdTZoFycWXYIowyTxlwcShBggqjsROIzVfYaqrrGXn0ZJSuP
         Rk+Er7o43JN8QpUBKYqjuD2k4m8xcwIhNGw1W0fyruNKdppRvtmgYKKgQrJ04D3Xcd5S
         KLuZMXfc3SJH89cN2iuJJ96g+DZzcebqLX7/EbhYy0MOf9brhr6SZZ5oKiEWg5Gj4Yvu
         7UfMGbuq84yVRV3TEPgzXS2zulTAsbBXyedRSoZY9nfYMyk/CjI/5FgeNUCj79hCRxzM
         4NuA==
X-Gm-Message-State: AOAM530me9r3r4kmySw5ZhE3TaPkOFL9jouCnw4ymZD+8wy0vLC7/CGC
        CDVnlkscZ2uHKpJ6Oyg24S4=
X-Google-Smtp-Source: ABdhPJwf+N00naIqMQSVCEh5VoO89yE+IEfDU//wXtlUqgyltKvCQvZwlfPejEZOv5NOVh9dCGobyg==
X-Received: by 2002:a17:90b:698:: with SMTP id m24mr3214056pjz.154.1603466178850;
        Fri, 23 Oct 2020 08:16:18 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.137])
        by smtp.googlemail.com with ESMTPSA id f5sm2248076pgi.86.2020.10.23.08.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 08:16:17 -0700 (PDT)
From:   zhanggyb@gmail.com
To:     wim@linux-watchdog.org, linux@roeck-us.net,
        linux-kernel@vger.kernel.org
Cc:     -linux-pc@lenovo.com, Freeman Zhang <zhanggyb@gmail.com>
Subject: [PATCH] watchdog: Add Nuvoton NCT668x watchdog driver
Date:   Fri, 23 Oct 2020 23:15:50 +0800
Message-Id: <20201023151550.15264-1-zhanggyb@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Freeman Zhang <zhanggyb@gmail.com>

Add the watchdog driver for Nuvoton NCT668x series. So far this driver only
supports NCT6688DL and customized chip used in Lenovo ThinkCentre M90n Nano.

Signed-off-by: Freeman Zhang <zhanggyb@gmail.com>
---
 drivers/watchdog/Kconfig       |  11 +
 drivers/watchdog/Makefile      |   1 +
 drivers/watchdog/nct668x_wdt.c | 504 +++++++++++++++++++++++++++++++++
 3 files changed, 516 insertions(+)
 create mode 100644 drivers/watchdog/nct668x_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 21865e27499a..be66e2f6e1a6 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1640,6 +1640,17 @@ config NIC7018_WDT
 	  To compile this driver as a module, choose M here: the module will be
 	  called nic7018_wdt.
 
+config NUVOTON_NCT668X_WDT
+	tristate "Nuvoton NCT668x watchdog"
+	depends on X86
+	select WATCHDOG_CORE
+	help
+	  Support for the watchdog the Nuvoton’s NCT6686DL eSIO device. When the
+	  watchdog triggers the system will be reset.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called nct668x-wdt.
+
 # M68K Architecture
 
 config M54xx_WATCHDOG
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 071a2e50be98..89b0f03aeb11 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -146,6 +146,7 @@ obj-$(CONFIG_INTEL_MEI_WDT) += mei_wdt.o
 obj-$(CONFIG_NI903X_WDT) += ni903x_wdt.o
 obj-$(CONFIG_NIC7018_WDT) += nic7018_wdt.o
 obj-$(CONFIG_MLX_WDT) += mlx_wdt.o
+obj-$(CONFIG_NUVOTON_NCT668X_WDT) += nct668x_wdt.o
 
 # M68K Architecture
 obj-$(CONFIG_M54xx_WATCHDOG) += m54xx_wdt.o
diff --git a/drivers/watchdog/nct668x_wdt.c b/drivers/watchdog/nct668x_wdt.c
new file mode 100644
index 000000000000..e513a0b33341
--- /dev/null
+++ b/drivers/watchdog/nct668x_wdt.c
@@ -0,0 +1,504 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * nct668x_wdt.c - Customized Nuvoton NCT668x WDT driver.
+ *
+ * (c) Copyright 2020 Sheng-Yuan Huang <syhuang3@nuvoton.com> (Nuvoton)
+ *
+ *   1. Modified it for customized nct668x WDT only. (lenovo nano)
+ *
+ * (c) Copyright 2018 Sheng-Yuan Huang (Nuvoton) 
+ *
+ *   1. Add support to NCT6796 and NCT6116.
+ *   2. Modify code for convenient testing. 
+ *   3. Fix some potential problems.
+ *   4. Change file name for telling the differece between this one and the
+ *      built-in driver.
+ *
+ * (c) Copyright 2013 Guenter Roeck
+ *
+ *   converted to watchdog infrastructure
+ *
+ * (c) Copyright 2007 Vlad Drukker <vlad@storewiz.com>
+ *
+ *   added support for W83627THF.
+ *
+ * (c) Copyright 2003,2007 Pádraig Brady <P@draigBrady.com>
+ *
+ *   Based on advantechwdt.c which is based on wdt.c.
+ *
+ * Original copyright messages:
+ *
+ * (c) Copyright 2000-2001 Marek Michalkiewicz <marekm@linux.org.pl>
+ * (c) Copyright 1996 Alan Cox <alan@lxorguk.ukuu.org.uk>, All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License as published by the Free Software
+ * Foundation; either version 2 of the License, or (at your option) any later
+ * version.
+ *
+ * Neither Alan Cox nor CymruNet Ltd. admit liability nor provide warranty for
+ * any of this software. This material is provided "AS-IS" and at no charge.
+ *
+ * (c) Copyright 1995    Alan Cox <alan@lxorguk.ukuu.org.uk>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/types.h>
+#include <linux/watchdog.h>
+#include <linux/ioport.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/dmi.h>
+
+#include <linux/string.h>
+
+#define WATCHDOG_NAME "nct6686"
+#define ECSPACE_MUTEX "nct6686EC"
+#define WATCHDOG_TIMEOUT 60 /* 60 sec default timeout */
+#define WATCHDOG_WDT_SEL 1
+
+static int wdt_io;
+static int ec_base;					/* EC base address */
+static int wdt_cfg_enter = 0x87;	/* key to unlock configuration space */
+static int wdt_cfg_leave = 0xAA;	/* key to lock configuration space */
+static int is_lenovo = 0;			/* If this system is Lenovo's by checking DMI info */
+
+enum chips { nct6686dl, nct6686dl_nano };
+
+static int timeout; /* in seconds */
+module_param(timeout, int, 0);
+MODULE_PARM_DESC(timeout,
+		"Watchdog timeout in seconds. 1 <= timeout <= 255, default="
+				__MODULE_STRING(WATCHDOG_TIMEOUT) ".");
+
+static bool nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, bool, 0);
+MODULE_PARM_DESC(nowayout,
+		"Watchdog cannot be stopped once started (default="
+				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+static int early_disable = 0;
+module_param(early_disable, int, 0);
+MODULE_PARM_DESC(early_disable, "Disable watchdog at boot time (default=0)");
+
+#define QUIET 	0	/* Default */
+#define VERBOSE 1
+#define DEBUG 	2
+static int debug = 0;
+module_param(debug, int, 0);
+MODULE_PARM_DESC(debug, "Debug level: 0=Quiet, 1=Verbose, 2=Debug (default=0)");
+
+static int skip_chk_fwver = 0;
+module_param(skip_chk_fwver, int, 0);
+MODULE_PARM_DESC(skip_chk_fwver, "Skip checking firmware version (default=0)");
+
+/*
+ * Kernel methods.
+ */
+
+#define WDT_EFER (wdt_io + 0) /* Extended Function Enable Registers */
+#define WDT_EFIR (wdt_io + 0) /* Extended Function Index Register
+                                 (same as EFER) */
+#define WDT_EFDR (WDT_EFIR + 1) /* Extended Function Data Register */
+
+#define PAGE_REG_OFFSET 0
+#define ADDR_REG_OFFSET 1
+#define DATA_REG_OFFSET 2
+
+#define NCT6686_LD_ECSPACE 0x0B
+
+#define CHIPID_MASK 0xFFF0
+#define NCT6686DL_ID 0xD440
+
+#define NCT6686_CUS_WDT_CFG 0x828
+#define NCT6686_CUS_WDT_CNT 0x829
+#define NCT6686_CUS_WDT_STS 0x82A
+#define NCT6686_CUS_WDT_STS_EVT_POS (0)
+#define NCT6686_CUS_WDT_STS_EVT_MSK (0x3 << NCT6686_CUS_WDT_STS_EVT_POS)
+#define NCT6686_CUS_FWVER_BASE 0x618 //Page 6 18~1f
+
+#ifndef BIT
+#define BIT(nr) (1UL << (nr))
+#endif
+
+static void superio_outb(int reg, int val)
+{
+	outb(reg, WDT_EFER);
+	outb(val, WDT_EFDR);
+}
+
+static inline int superio_inb(int reg)
+{
+	outb(reg, WDT_EFER);
+	return inb(WDT_EFDR);
+}
+
+static int superio_enter(void)
+{
+	if (!request_muxed_region(wdt_io, 2, WATCHDOG_NAME)) {
+		pr_warn("nuv:request IO base fail(wdt_io=%X)\n", wdt_io);
+		return -EBUSY;
+	}
+	outb_p(wdt_cfg_enter, WDT_EFER); /* Enter extended function mode */
+	outb_p(wdt_cfg_enter, WDT_EFER); /* Again according to manual */
+
+	return 0;
+}
+
+static void superio_select(int ld)
+{
+	superio_outb(0x07, ld);
+}
+
+static void superio_exit(void)
+{
+	outb_p(wdt_cfg_leave, WDT_EFER); /* Leave extended function mode */
+	release_region(wdt_io, 2);
+}
+
+static inline void __nct6686_set_bank(int base_addr, u16 reg)
+{
+	outb_p(0xFF, base_addr + PAGE_REG_OFFSET);
+	outb_p(reg >> 8, base_addr + PAGE_REG_OFFSET);
+}
+
+/* Not strictly necessary, but play it safe for now */
+static inline void __nct6686_reset_bank(int base_addr, u16 reg)
+{
+	if (reg & 0xff00)
+		outb_p(0xFF, base_addr + PAGE_REG_OFFSET);
+}
+
+static u8 nct6686_read_value(int base_addr, u16 fullreg)
+{
+	u8 volatile res;
+
+	if (!request_muxed_region(base_addr, 3, ECSPACE_MUTEX)) {
+		pr_warn("nuv:request ECSpace fail(base_addr=%X)\n", base_addr);
+		return -EBUSY;
+	}
+
+	__nct6686_set_bank(base_addr, fullreg);
+	outb_p(fullreg & 0xff, base_addr + ADDR_REG_OFFSET);
+	res = inb_p(base_addr + DATA_REG_OFFSET);
+
+	__nct6686_reset_bank(base_addr, fullreg);
+
+	release_region(base_addr, 3);
+
+	return res;
+}
+
+static int nct6686_write_value(int base_addr, u16 fullreg, u8 value)
+{
+	if (!request_muxed_region(base_addr, 3, ECSPACE_MUTEX)) {
+		pr_warn("nuv:request ECSpace fail(base_addr=%X)\n", base_addr);
+		return -EBUSY;
+	}
+
+	__nct6686_set_bank(base_addr, fullreg);
+	outb_p(fullreg & 0xff, base_addr + ADDR_REG_OFFSET);
+
+	outb_p(value & 0xff, base_addr + DATA_REG_OFFSET);
+	__nct6686_reset_bank(base_addr, fullreg);
+
+	release_region(base_addr, 3);
+	return 0;
+}
+
+static int nct6686_init(struct watchdog_device *wdog, enum chips chip)
+{
+	volatile unsigned char t, cfg, reg;
+
+	t = nct6686_read_value(ec_base, NCT6686_CUS_WDT_CNT);
+	cfg = nct6686_read_value(ec_base, NCT6686_CUS_WDT_CFG);
+
+	if (cfg & BIT(0)) {
+		if (early_disable) {
+			pr_warn("Stopping previously enabled watchdog until userland kicks in\n");
+
+			// Disable WDT:
+			nct6686_write_value(ec_base, NCT6686_CUS_WDT_CFG,
+					    cfg & (~BIT(0)));
+
+			// Clear CNT:
+			nct6686_write_value(ec_base, NCT6686_CUS_WDT_CNT, 0);
+		} else {
+			pr_info("Watchdog already running. Resetting timeout to %d sec\n",
+				wdog->timeout);
+
+			nct6686_write_value(ec_base, NCT6686_CUS_WDT_CNT,
+					    wdog->timeout);
+		}
+	}
+
+	/* reset trigger status */
+	reg = nct6686_read_value(ec_base, NCT6686_CUS_WDT_STS);
+	nct6686_write_value(ec_base, NCT6686_CUS_WDT_STS,
+			    reg & ~NCT6686_CUS_WDT_STS_EVT_MSK);
+
+	return 0;
+}
+
+static int wdt_enable(bool en)
+{
+	unsigned char volatile reg;
+
+	reg = nct6686_read_value(ec_base, NCT6686_CUS_WDT_CFG);
+
+	if (en)
+		nct6686_write_value(ec_base, NCT6686_CUS_WDT_CFG, reg | 0x3);
+	else
+		nct6686_write_value(ec_base, NCT6686_CUS_WDT_CFG,
+				    reg & ~BIT(0));
+
+	return 0;
+}
+
+static int wdt_set_time(unsigned int timeout)
+{
+	if (debug >= DEBUG)
+		pr_debug("nuv:wdt_set_time(0x%x)\n", timeout);
+
+	nct6686_write_value(ec_base, NCT6686_CUS_WDT_CNT, timeout);
+
+	if (timeout != 0)
+		wdt_enable(true);
+	else
+		wdt_enable(false);
+
+	return 0;
+}
+
+static int wdt_start(struct watchdog_device *wdog)
+{
+	unsigned char reg;
+
+	if (debug >= DEBUG)
+		pr_debug("nuv:wdt_start()\n");
+
+	wdt_set_time(wdog->timeout);
+
+	/* reset trigger status */
+	reg = nct6686_read_value(ec_base, NCT6686_CUS_WDT_STS);
+	nct6686_write_value(ec_base, NCT6686_CUS_WDT_STS,
+			    reg & ~NCT6686_CUS_WDT_STS_EVT_MSK);
+
+	return 0;
+}
+
+static int wdt_stop(struct watchdog_device *wdog)
+{
+	if (debug >= DEBUG)
+		pr_debug("nuv:wdt_stop()\n");
+
+	return wdt_set_time(0);
+}
+
+static int wdt_set_timeout(struct watchdog_device *wdog, unsigned int timeout)
+{
+	if (debug >= DEBUG)
+		pr_debug("nuv:wdt_set_timeout()\n");
+
+	wdog->timeout = timeout;
+
+	return 0;
+}
+
+static unsigned int wdt_get_time(struct watchdog_device *wdog)
+{
+	unsigned int timeleft;
+
+	if (debug >= DEBUG)
+		pr_debug("nuv:wdt_get_time()\n");
+
+	timeleft = nct6686_read_value(ec_base, NCT6686_CUS_WDT_CNT);
+
+	return timeleft;
+}
+
+/*
+ * Kernel Interfaces
+ */
+
+static const struct watchdog_info wdt_info = {
+	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
+	.identity = "NUVOTON Watchdog",
+};
+
+static const struct watchdog_ops wdt_ops = {
+	.owner = THIS_MODULE,
+	.start = wdt_start,
+	.stop = wdt_stop,
+	.set_timeout = wdt_set_timeout,
+	.get_timeleft = wdt_get_time,
+};
+
+static struct watchdog_device wdt_dev = {
+	.info = &wdt_info,
+	.ops = &wdt_ops,
+	.timeout = WATCHDOG_TIMEOUT,
+	.min_timeout = 1,
+	.max_timeout = 255,
+};
+
+/*
+ * The WDT needs to learn about soft shutdowns in order to turn the timebomb
+ * registers off.
+ */
+static int wdt_find(int addr)
+{
+	u16 val;
+	int ret;
+	int i;
+	u8 fw_ver[9] = { 0 }; //[8] is for end of string('\0')
+
+	ret = superio_enter();
+	if (ret)
+		return ret;
+
+	if (debug >= DEBUG)
+		pr_debug("Search port %X... ", wdt_io);
+
+	val = superio_inb(0x20);
+	val = ((val << 8) | (superio_inb(0x21) & 0xFF)) & CHIPID_MASK;
+
+	switch (val) {
+	case NCT6686DL_ID:
+		ret = nct6686dl;
+		if (debug >= VERBOSE)
+			pr_info("Chip found: ChipID=%X (with ID mask)\n", val);
+		break;
+	default:
+		ret = -ENODEV;
+		if (debug >= VERBOSE)
+			pr_info("Unsupported chip ID: 0x%X\n", val);
+		superio_exit();
+		return ret;
+	}
+
+	superio_select(NCT6686_LD_ECSPACE);
+	ec_base = superio_inb(0x60) & 0xFF;
+	ec_base = (ec_base << 8) | (superio_inb(0x61) & 0xFF);
+	if ((ec_base == 0xFFFF) || (ec_base == 0)) {
+		pr_err("Wrong address for EC Space: CR60/61=0x%X\n", ec_base);
+		ret = -ENODEV;
+	}
+
+	superio_exit();
+
+	//Check FW Ver (default)
+	if (skip_chk_fwver == 0) {
+		for (i = 0; i < 8; i++) {
+			fw_ver[i] = nct6686_read_value(
+				ec_base, NCT6686_CUS_FWVER_BASE + i);
+		}
+		fw_ver[8] = 0;
+
+		switch (ret) {
+		case nct6686dl:
+			//check for lenovo nano
+			if (strncmp(fw_ver, "M2ACT", 5) == 0) {
+				ret = nct6686dl_nano;
+			} else {
+				ret = -ENODEV;
+				pr_err("Unsupported FW Ver: 0x%s\n", fw_ver);
+			}
+			break;
+		default:
+			ret = -ENODEV;
+			pr_err("Unsupported FW Ver: 0x%s\n", fw_ver);
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static int __init wdt_check_platform(const struct dmi_system_id *d)
+{
+	is_lenovo = 1;
+	if (debug >= DEBUG)
+		pr_debug("Found Lenovo system!\n");
+	return 0;
+}
+
+static const struct dmi_system_id wdt_dmi_table[] __initconst = {
+	{
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			// DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "CTS"),
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "314D"),
+		},
+		.callback = wdt_check_platform,
+	},
+	{}
+};
+
+static int __init wdt_init(void)
+{
+	int ret;
+	int chip;
+	static const char *const chip_name[] = {
+		"NUC6686D_NANO",
+	};
+
+	if (debug >= DEBUG)
+		pr_debug("WDT driver init...\n");
+
+	dmi_check_system(wdt_dmi_table);
+
+	wdt_io = 0x4e;
+	chip = wdt_find(wdt_io);
+	if (chip < 0) {
+		wdt_io = 0x2e;
+		chip = wdt_find(wdt_io);
+		if (chip < 0)
+			return chip;
+	}
+
+	if (debug >= VERBOSE)
+		pr_info("WDT driver for %s(port:0x%X Super I/O chip initialising, ec_base=%X)\n",
+			chip_name[chip], wdt_io, ec_base);
+
+	if (0 == is_lenovo)
+		pr_info("Warning! This driver was only verified on Lenovo ThinkCentre Nano!\n");
+
+	watchdog_init_timeout(&wdt_dev, timeout, NULL);
+	watchdog_set_nowayout(&wdt_dev, nowayout);
+	watchdog_stop_on_reboot(&wdt_dev);
+
+	ret = nct6686_init(&wdt_dev, chip);
+	if (ret) {
+		pr_err("failed to initialize watchdog (err=%d)\n", ret);
+		return ret;
+	}
+
+	ret = watchdog_register_device(&wdt_dev);
+	if (ret)
+		return ret;
+
+	pr_info("initialized. timeout=%d sec (nowayout=%d)\n",
+		wdt_dev.timeout, nowayout);
+
+	return ret;
+}
+
+static void __exit wdt_exit(void)
+{
+	if (debug >= DEBUG)
+		pr_info("nuv:wdt_exit()\n");
+
+	watchdog_unregister_device(&wdt_dev);
+}
+
+module_init(wdt_init);
+module_exit(wdt_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Sheng-Yuan Huang<syhuang3@nuvoton.com>");
+MODULE_DESCRIPTION("nct668x WDT driver");
-- 
2.28.0

