Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 984B02B25E6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 21:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgKMUwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 15:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbgKMUwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 15:52:42 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211DBC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 12:52:41 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id z28so4638752pfr.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 12:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=2Y9AwRUZv2sQvKVp60fuIvGKPyOmjJnM85nuQ0M3k7Y=;
        b=DgozC3vic5vJ2OX30u3wXtCs9qj6jAKZjaSk5UICKtfVGW3UpgoBdBgx333I/6yZW5
         UNsOYYuH4MXjz4B4rY7b8tuA3gESoMTd+6HnqL3uCJEOUGqbtGlX7HZvAcQ/SDtW3P+R
         BqR3VPvoPDdoEjbJPlMSIEUhvOGJ8YQM6QHtezO8Cg6McAUEiZ/00CwapU1KAGjyzWcF
         F/So7NKJcnxXUTpIrVFmqZqzF4Il0gls/PKXFOpbd3UPAnzCFlk24QLSlQyQ0GYTagyd
         ouQUvZoW9HZVLPJDHUWdaV1lxZN/meWy2/ZORsqNOYmCK7mOdnX0O0gmvE4KBsmxvQok
         Gm8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=2Y9AwRUZv2sQvKVp60fuIvGKPyOmjJnM85nuQ0M3k7Y=;
        b=pCjxELr7/C2z7fNeWpuaY2VVrf6JAWIis6G5JRwB3e2CoKTmaQFvA5UGkI0wwX2HEi
         2a6T3p3X8JgDYfJQRP7CNRlK3UKIFO3+dtrvF1yGksVuTgEsAfIU5HxlALyLBg3zox+L
         teAR5uwVMvMPbC6irSq2lLTjGq+TADLufyAOBu7cVIa3k8HaSYaWsNY75eJNuRWtzYuk
         By4sULHqvuFkAYLZUdzBKM3YeSDgcrDt6LvrkVMO11n4qozUaWjIOe+efz6OGoBZ40wt
         NZAo9EZOLynHX6yhvW7Kxj3tDSeCFWdMqa9We3iGsVwDPbyuYEl5xZWNMfNhWag7RQWC
         zOdg==
X-Gm-Message-State: AOAM532kiJTbtwHXcNv4FY4ImD5hxcxsLtHWref2x8TWAgGB3XrcisZD
        d9l7eZidsWgbMC041q87BXFP/e2M
X-Google-Smtp-Source: ABdhPJyDXio0thm/7u0hM25Y8eRSuPoDZnBepJ/MCf0jtPlWNjL2EFh0Na4ZMlL8SoEE4vjzqy1oVTRO
Sender: "rkir via sendgmr" <rkir@rkir.kir.corp.google.com>
X-Received: from rkir.kir.corp.google.com ([2620:15c:29:200:3e52:82ff:fe5f:f95])
 (user=rkir job=sendgmr) by 2002:aa7:9ac7:0:b029:18b:36d2:784b with SMTP id
 x7-20020aa79ac70000b029018b36d2784bmr3740772pfp.20.1605300760388; Fri, 13 Nov
 2020 12:52:40 -0800 (PST)
Date:   Fri, 13 Nov 2020 12:52:33 -0800
Message-Id: <20201113205233.827493-1-rkir@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH] drivers: rtc: retire RTC_DRV_GOLDFISH
From:   rkir@google.com
To:     paul.walmsley@sifive.com, miodrag.dinic@mips.com
Cc:     linux-kernel@vger.kernel.org, lfy@google.com,
        Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Kiryanov <rkir@google.com>

The only user of RTC_DRV_GOLDFISH is
the MIPS flavor of Android Studio Emulator
(goldfish) which should be also retired.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 arch/riscv/Kconfig.socs    |   1 -
 drivers/rtc/Kconfig        |  10 --
 drivers/rtc/Makefile       |   1 -
 drivers/rtc/rtc-goldfish.c | 216 -------------------------------------
 4 files changed, 228 deletions(-)
 delete mode 100644 drivers/rtc/rtc-goldfish.c

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 8a55f6156661..9c4c2abb2011 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -17,7 +17,6 @@ config SOC_VIRT
 	select POWER_RESET_SYSCON
 	select POWER_RESET_SYSCON_POWEROFF
 	select GOLDFISH
-	select RTC_DRV_GOLDFISH if RTC_CLASS
 	select SIFIVE_PLIC
 	help
 	  This enables support for QEMU Virt Machine.
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 65ad9d0b47ab..e574f24f3b08 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1932,16 +1932,6 @@ config RTC_DRV_HID_SENSOR_TIME
 	  If this driver is compiled as a module, it will be named
 	  rtc-hid-sensor-time.
 
-config RTC_DRV_GOLDFISH
-	tristate "Goldfish Real Time Clock"
-	depends on OF && HAS_IOMEM
-	depends on GOLDFISH || COMPILE_TEST
-	help
-	  Say yes to enable RTC driver for the Goldfish based virtual platform.
-
-	  Goldfish is a code name for the virtual platform developed by Google
-	  for Android emulation.
-
 config RTC_DRV_WILCO_EC
 	tristate "Wilco EC RTC"
 	depends on WILCO_EC
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index bfb57464118d..1730d0676096 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -71,7 +71,6 @@ obj-$(CONFIG_RTC_DRV_FM3130)	+= rtc-fm3130.o
 obj-$(CONFIG_RTC_DRV_FSL_FTM_ALARM)	+= rtc-fsl-ftm-alarm.o
 obj-$(CONFIG_RTC_DRV_FTRTC010)	+= rtc-ftrtc010.o
 obj-$(CONFIG_RTC_DRV_GENERIC)	+= rtc-generic.o
-obj-$(CONFIG_RTC_DRV_GOLDFISH)	+= rtc-goldfish.o
 obj-$(CONFIG_RTC_DRV_HID_SENSOR_TIME) += rtc-hid-sensor-time.o
 obj-$(CONFIG_RTC_DRV_HYM8563)	+= rtc-hym8563.o
 obj-$(CONFIG_RTC_DRV_IMXDI)	+= rtc-imxdi.o
diff --git a/drivers/rtc/rtc-goldfish.c b/drivers/rtc/rtc-goldfish.c
deleted file mode 100644
index 6349d2cd3680..000000000000
--- a/drivers/rtc/rtc-goldfish.c
+++ /dev/null
@@ -1,216 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* drivers/rtc/rtc-goldfish.c
- *
- * Copyright (C) 2007 Google, Inc.
- * Copyright (C) 2017 Imagination Technologies Ltd.
- */
-
-#include <linux/io.h>
-#include <linux/module.h>
-#include <linux/of.h>
-#include <linux/platform_device.h>
-#include <linux/rtc.h>
-
-#define TIMER_TIME_LOW		0x00	/* get low bits of current time  */
-					/*   and update TIMER_TIME_HIGH  */
-#define TIMER_TIME_HIGH	0x04	/* get high bits of time at last */
-					/*   TIMER_TIME_LOW read         */
-#define TIMER_ALARM_LOW	0x08	/* set low bits of alarm and     */
-					/*   activate it                 */
-#define TIMER_ALARM_HIGH	0x0c	/* set high bits of next alarm   */
-#define TIMER_IRQ_ENABLED	0x10
-#define TIMER_CLEAR_ALARM	0x14
-#define TIMER_ALARM_STATUS	0x18
-#define TIMER_CLEAR_INTERRUPT	0x1c
-
-struct goldfish_rtc {
-	void __iomem *base;
-	int irq;
-	struct rtc_device *rtc;
-};
-
-static int goldfish_rtc_read_alarm(struct device *dev,
-				   struct rtc_wkalrm *alrm)
-{
-	u64 rtc_alarm;
-	u64 rtc_alarm_low;
-	u64 rtc_alarm_high;
-	void __iomem *base;
-	struct goldfish_rtc *rtcdrv;
-
-	rtcdrv = dev_get_drvdata(dev);
-	base = rtcdrv->base;
-
-	rtc_alarm_low = readl(base + TIMER_ALARM_LOW);
-	rtc_alarm_high = readl(base + TIMER_ALARM_HIGH);
-	rtc_alarm = (rtc_alarm_high << 32) | rtc_alarm_low;
-
-	do_div(rtc_alarm, NSEC_PER_SEC);
-	memset(alrm, 0, sizeof(struct rtc_wkalrm));
-
-	rtc_time64_to_tm(rtc_alarm, &alrm->time);
-
-	if (readl(base + TIMER_ALARM_STATUS))
-		alrm->enabled = 1;
-	else
-		alrm->enabled = 0;
-
-	return 0;
-}
-
-static int goldfish_rtc_set_alarm(struct device *dev,
-				  struct rtc_wkalrm *alrm)
-{
-	struct goldfish_rtc *rtcdrv;
-	u64 rtc_alarm64;
-	u64 rtc_status_reg;
-	void __iomem *base;
-
-	rtcdrv = dev_get_drvdata(dev);
-	base = rtcdrv->base;
-
-	if (alrm->enabled) {
-		rtc_alarm64 = rtc_tm_to_time64(&alrm->time) * NSEC_PER_SEC;
-		writel((rtc_alarm64 >> 32), base + TIMER_ALARM_HIGH);
-		writel(rtc_alarm64, base + TIMER_ALARM_LOW);
-		writel(1, base + TIMER_IRQ_ENABLED);
-	} else {
-		/*
-		 * if this function was called with enabled=0
-		 * then it could mean that the application is
-		 * trying to cancel an ongoing alarm
-		 */
-		rtc_status_reg = readl(base + TIMER_ALARM_STATUS);
-		if (rtc_status_reg)
-			writel(1, base + TIMER_CLEAR_ALARM);
-	}
-
-	return 0;
-}
-
-static int goldfish_rtc_alarm_irq_enable(struct device *dev,
-					 unsigned int enabled)
-{
-	void __iomem *base;
-	struct goldfish_rtc *rtcdrv;
-
-	rtcdrv = dev_get_drvdata(dev);
-	base = rtcdrv->base;
-
-	if (enabled)
-		writel(1, base + TIMER_IRQ_ENABLED);
-	else
-		writel(0, base + TIMER_IRQ_ENABLED);
-
-	return 0;
-}
-
-static irqreturn_t goldfish_rtc_interrupt(int irq, void *dev_id)
-{
-	struct goldfish_rtc *rtcdrv = dev_id;
-	void __iomem *base = rtcdrv->base;
-
-	writel(1, base + TIMER_CLEAR_INTERRUPT);
-
-	rtc_update_irq(rtcdrv->rtc, 1, RTC_IRQF | RTC_AF);
-
-	return IRQ_HANDLED;
-}
-
-static int goldfish_rtc_read_time(struct device *dev, struct rtc_time *tm)
-{
-	struct goldfish_rtc *rtcdrv;
-	void __iomem *base;
-	u64 time_high;
-	u64 time_low;
-	u64 time;
-
-	rtcdrv = dev_get_drvdata(dev);
-	base = rtcdrv->base;
-
-	time_low = readl(base + TIMER_TIME_LOW);
-	time_high = readl(base + TIMER_TIME_HIGH);
-	time = (time_high << 32) | time_low;
-
-	do_div(time, NSEC_PER_SEC);
-
-	rtc_time64_to_tm(time, tm);
-
-	return 0;
-}
-
-static int goldfish_rtc_set_time(struct device *dev, struct rtc_time *tm)
-{
-	struct goldfish_rtc *rtcdrv;
-	void __iomem *base;
-	u64 now64;
-
-	rtcdrv = dev_get_drvdata(dev);
-	base = rtcdrv->base;
-
-	now64 = rtc_tm_to_time64(tm) * NSEC_PER_SEC;
-	writel((now64 >> 32), base + TIMER_TIME_HIGH);
-	writel(now64, base + TIMER_TIME_LOW);
-
-	return 0;
-}
-
-static const struct rtc_class_ops goldfish_rtc_ops = {
-	.read_time	= goldfish_rtc_read_time,
-	.set_time	= goldfish_rtc_set_time,
-	.read_alarm	= goldfish_rtc_read_alarm,
-	.set_alarm	= goldfish_rtc_set_alarm,
-	.alarm_irq_enable = goldfish_rtc_alarm_irq_enable
-};
-
-static int goldfish_rtc_probe(struct platform_device *pdev)
-{
-	struct goldfish_rtc *rtcdrv;
-	int err;
-
-	rtcdrv = devm_kzalloc(&pdev->dev, sizeof(*rtcdrv), GFP_KERNEL);
-	if (!rtcdrv)
-		return -ENOMEM;
-
-	platform_set_drvdata(pdev, rtcdrv);
-	rtcdrv->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(rtcdrv->base))
-		return PTR_ERR(rtcdrv->base);
-
-	rtcdrv->irq = platform_get_irq(pdev, 0);
-	if (rtcdrv->irq < 0)
-		return -ENODEV;
-
-	rtcdrv->rtc = devm_rtc_allocate_device(&pdev->dev);
-	if (IS_ERR(rtcdrv->rtc))
-		return PTR_ERR(rtcdrv->rtc);
-
-	rtcdrv->rtc->ops = &goldfish_rtc_ops;
-	rtcdrv->rtc->range_max = U64_MAX / NSEC_PER_SEC;
-
-	err = devm_request_irq(&pdev->dev, rtcdrv->irq,
-			       goldfish_rtc_interrupt,
-			       0, pdev->name, rtcdrv);
-	if (err)
-		return err;
-
-	return rtc_register_device(rtcdrv->rtc);
-}
-
-static const struct of_device_id goldfish_rtc_of_match[] = {
-	{ .compatible = "google,goldfish-rtc", },
-	{},
-};
-MODULE_DEVICE_TABLE(of, goldfish_rtc_of_match);
-
-static struct platform_driver goldfish_rtc = {
-	.probe = goldfish_rtc_probe,
-	.driver = {
-		.name = "goldfish_rtc",
-		.of_match_table = goldfish_rtc_of_match,
-	}
-};
-
-module_platform_driver(goldfish_rtc);
-
-MODULE_LICENSE("GPL v2");
-- 
2.29.2.299.gdc1121823c-goog

