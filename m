Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D841ABB2B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 10:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441425AbgDPI3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 04:29:12 -0400
Received: from mga06.intel.com ([134.134.136.31]:51574 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441254AbgDPIQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 04:16:38 -0400
IronPort-SDR: XUUd6+MMMRB666lIqYtc7glJFncsaODCjSVhjvzp1MXfs6Ph6Qc9Kmq46bLNu09whzeamv6fo3
 SET0sMKsHsPg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 01:16:02 -0700
IronPort-SDR: Uw8qFRPCwDGYcvsJ1ITrvF05TAAQ57X0aZJoBWMwTZcd+iztBnbixcvT7UCLxRvcaJjO/5fpui
 aa5keC1lh1nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,390,1580803200"; 
   d="scan'208";a="363914387"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 16 Apr 2020 01:15:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 5920B812; Thu, 16 Apr 2020 11:15:53 +0300 (EEST)
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
Subject: [PATCH v9 06/20] watchdog: intel-mid_wdt: Convert to use new SCU IPC API
Date:   Thu, 16 Apr 2020 11:15:38 +0300
Message-Id: <20200416081552.68083-7-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200416081552.68083-1-mika.westerberg@linux.intel.com>
References: <20200416081552.68083-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the Intel MID watchdog driver over the new SCU IPC API
where the SCU IPC instance is passed to the functions.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/watchdog/intel-mid_wdt.c | 53 ++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 16 deletions(-)

diff --git a/drivers/watchdog/intel-mid_wdt.c b/drivers/watchdog/intel-mid_wdt.c
index 470213abfd3d..1ae03b64ef8b 100644
--- a/drivers/watchdog/intel-mid_wdt.c
+++ b/drivers/watchdog/intel-mid_wdt.c
@@ -33,14 +33,24 @@ enum {
 	SCU_WATCHDOG_KEEPALIVE,
 };
 
-static inline int wdt_command(int sub, u32 *in, int inlen)
+struct mid_wdt {
+	struct watchdog_device wd;
+	struct device *dev;
+	struct intel_scu_ipc_dev *scu;
+};
+
+static inline int
+wdt_command(struct mid_wdt *mid, int sub, const void *in, size_t inlen, size_t size)
 {
-	return intel_scu_ipc_command(IPC_WATCHDOG, sub, in, inlen, NULL, 0);
+	struct intel_scu_ipc_dev *scu = mid->scu;
+
+	return intel_scu_ipc_dev_command_with_size(scu, IPC_WATCHDOG, sub, in,
+						   inlen, size, NULL, 0);
 }
 
 static int wdt_start(struct watchdog_device *wd)
 {
-	struct device *dev = watchdog_get_drvdata(wd);
+	struct mid_wdt *mid = watchdog_get_drvdata(wd);
 	int ret, in_size;
 	int timeout = wd->timeout;
 	struct ipc_wd_start {
@@ -49,38 +59,41 @@ static int wdt_start(struct watchdog_device *wd)
 	} ipc_wd_start = { timeout - MID_WDT_PRETIMEOUT, timeout };
 
 	/*
-	 * SCU expects the input size for watchdog IPC to
-	 * be based on 4 bytes
+	 * SCU expects the input size for watchdog IPC to be 2 which is the
+	 * size of the structure in dwords. SCU IPC normally takes bytes
+	 * but this is a special case where we specify size to be different
+	 * than inlen.
 	 */
 	in_size = DIV_ROUND_UP(sizeof(ipc_wd_start), 4);
 
-	ret = wdt_command(SCU_WATCHDOG_START, (u32 *)&ipc_wd_start, in_size);
+	ret = wdt_command(mid, SCU_WATCHDOG_START, &ipc_wd_start,
+			  sizeof(ipc_wd_start), in_size);
 	if (ret)
-		dev_crit(dev, "error starting watchdog: %d\n", ret);
+		dev_crit(mid->dev, "error starting watchdog: %d\n", ret);
 
 	return ret;
 }
 
 static int wdt_ping(struct watchdog_device *wd)
 {
-	struct device *dev = watchdog_get_drvdata(wd);
+	struct mid_wdt *mid = watchdog_get_drvdata(wd);
 	int ret;
 
-	ret = wdt_command(SCU_WATCHDOG_KEEPALIVE, NULL, 0);
+	ret = wdt_command(mid, SCU_WATCHDOG_KEEPALIVE, NULL, 0, 0);
 	if (ret)
-		dev_crit(dev, "Error executing keepalive: %d\n", ret);
+		dev_crit(mid->dev, "Error executing keepalive: %d\n", ret);
 
 	return ret;
 }
 
 static int wdt_stop(struct watchdog_device *wd)
 {
-	struct device *dev = watchdog_get_drvdata(wd);
+	struct mid_wdt *mid = watchdog_get_drvdata(wd);
 	int ret;
 
-	ret = wdt_command(SCU_WATCHDOG_STOP, NULL, 0);
+	ret = wdt_command(mid, SCU_WATCHDOG_STOP, NULL, 0, 0);
 	if (ret)
-		dev_crit(dev, "Error stopping watchdog: %d\n", ret);
+		dev_crit(mid->dev, "Error stopping watchdog: %d\n", ret);
 
 	return ret;
 }
@@ -110,6 +123,7 @@ static int mid_wdt_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct watchdog_device *wdt_dev;
 	struct intel_mid_wdt_pdata *pdata = dev->platform_data;
+	struct mid_wdt *mid;
 	int ret;
 
 	if (!pdata) {
@@ -123,10 +137,13 @@ static int mid_wdt_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	wdt_dev = devm_kzalloc(dev, sizeof(*wdt_dev), GFP_KERNEL);
-	if (!wdt_dev)
+	mid = devm_kzalloc(dev, sizeof(*mid), GFP_KERNEL);
+	if (!mid)
 		return -ENOMEM;
 
+	mid->dev = dev;
+	wdt_dev = &mid->wd;
+
 	wdt_dev->info = &mid_wdt_info;
 	wdt_dev->ops = &mid_wdt_ops;
 	wdt_dev->min_timeout = MID_WDT_TIMEOUT_MIN;
@@ -135,7 +152,7 @@ static int mid_wdt_probe(struct platform_device *pdev)
 	wdt_dev->parent = dev;
 
 	watchdog_set_nowayout(wdt_dev, WATCHDOG_NOWAYOUT);
-	watchdog_set_drvdata(wdt_dev, dev);
+	watchdog_set_drvdata(wdt_dev, mid);
 
 	ret = devm_request_irq(dev, pdata->irq, mid_wdt_irq,
 			       IRQF_SHARED | IRQF_NO_SUSPEND, "watchdog",
@@ -145,6 +162,10 @@ static int mid_wdt_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	mid->scu = devm_intel_scu_ipc_dev_get(dev);
+	if (!mid->scu)
+		return -EPROBE_DEFER;
+
 	/*
 	 * The firmware followed by U-Boot leaves the watchdog running
 	 * with the default threshold which may vary. When we get here
-- 
2.25.1

