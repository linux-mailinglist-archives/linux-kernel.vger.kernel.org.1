Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 295372A172F
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 13:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgJaML2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 08:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbgJaML1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 08:11:27 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87080C0613D5
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 05:11:27 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k10so7914933wrw.13
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 05:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lFSMOl//9O1ug5uYOCnBIrhhC0lHZ07PjA6WBVaJOMw=;
        b=sAv+GKURU7xrzA4Wvi4nL3/ehs2+9ukBcxMq9752y9LMO+nHlb74XrM+lNvvKC8TrK
         v+wB7B+OdYxolysBeQSatsrfdOM7iCyiV1sq5qBMSKJy37KcAgxnbgud8Imh7w+RrnTV
         95Gh5oH1wLEDzRMCxwoKSpVLzlcQi99HevePHQSPdTAGx03PIb2sq7+X2sBxUdE4zm1D
         jGGyOrEHOTAGAEi1O8CQ6ivjPv6T2I1BpTMJ42S7hfw5/zVZQYfMecj/TBwU82ORdalx
         aSCkRYU1oNxSuH1hNIWAU1nLFRKC/A4AtXDHkybyO6vpv9gSpT/I9uEnfjjHiUx1c2mk
         tQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lFSMOl//9O1ug5uYOCnBIrhhC0lHZ07PjA6WBVaJOMw=;
        b=opnpl0W5S6skLAcxzN+zONn2j93kyIqCvNf7zqMaHyEnLLFz2xc64BX8PpA8gi2hUe
         L2BKmxX/BTOMCj7pX7LDQ4HQcXEsFEzWqWGcL+DX6ki+FAwS6Gmh6+DeBXj5HnlJ4Fyj
         H0fC5AG0U3lFEbq5lK/Kbp5mbDTSkCm5SyIGKnG2Lkwxxx0S07tbIlbvFvAfzfqdv3Mq
         S2HjkBh13GzJuKO17zxTon7vh4tp7h5wjD2x7ArR/uWpbon6aOpGaLxjThaiFHU+7Yol
         +E9paP44xrPurU1SplLn8Ns0wrt83MJTT349bp9Qfl0hWuW1XuG0eM/aJdKLbng9Pfdp
         8bKQ==
X-Gm-Message-State: AOAM532/jQANururQVEz14H1u0mipLJDn1FfC6Wki6ypByYcml9GRVo4
        9hODPe3JjQNyXabQbUJ1Z4YeAw==
X-Google-Smtp-Source: ABdhPJyxntsDqtw1fLOzDbqIuJ2U1f6KoN7U8gp3rPg31FisI0mTcXgKaUA/ly4y+tg9H7XrTTJCiA==
X-Received: by 2002:a5d:6591:: with SMTP id q17mr9027131wru.173.1604146284060;
        Sat, 31 Oct 2020 05:11:24 -0700 (PDT)
Received: from localhost.localdomain (dh207-97-136.xnet.hr. [88.207.97.136])
        by smtp.googlemail.com with ESMTPSA id s11sm14177004wrm.56.2020.10.31.05.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 05:11:23 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        wim@linux-watchdog.org, linux@roeck-us.net,
        linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>
Subject: [PATCH v4] watchdog: qcom_wdt: set WDOG_HW_RUNNING bit when appropriate
Date:   Sat, 31 Oct 2020 13:11:15 +0100
Message-Id: <20201031121115.542752-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the watchdog hardware is enabled/running during boot, e.g.
due to a boot loader configuring it, we must tell the
watchdog framework about this fact so that it can ping the
watchdog until userspace opens the device and takes over
control.

Do so using the WDOG_HW_RUNNING flag that exists for exactly
that use-case.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Cc: Luka Perkov <luka.perkov@sartura.hr>
---
Changes in v4:
* Use QCOM_WDT_ENABLE macro

Changes in v3:
* Drop call to stop as start already does it
* Update commit message

Changes in v2:
* Correct authorship

 drivers/watchdog/qcom-wdt.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
index ab7465d186fd..07d399c4edc4 100644
--- a/drivers/watchdog/qcom-wdt.c
+++ b/drivers/watchdog/qcom-wdt.c
@@ -152,6 +152,13 @@ static int qcom_wdt_restart(struct watchdog_device *wdd, unsigned long action,
 	return 0;
 }
 
+static int qcom_wdt_is_running(struct watchdog_device *wdd)
+{
+	struct qcom_wdt *wdt = to_qcom_wdt(wdd);
+
+	return (readl(wdt_addr(wdt, WDT_EN)) & QCOM_WDT_ENABLE);
+}
+
 static const struct watchdog_ops qcom_wdt_ops = {
 	.start		= qcom_wdt_start,
 	.stop		= qcom_wdt_stop,
@@ -294,6 +301,17 @@ static int qcom_wdt_probe(struct platform_device *pdev)
 	wdt->wdd.timeout = min(wdt->wdd.max_timeout, 30U);
 	watchdog_init_timeout(&wdt->wdd, 0, dev);
 
+	/*
+	 * If WDT is already running, call WDT start which
+	 * will stop the WDT, set timeouts as bootloader
+	 * might use different ones and set running bit
+	 * to inform the WDT subsystem to ping the WDT
+	 */
+	if (qcom_wdt_is_running(&wdt->wdd)) {
+		qcom_wdt_start(&wdt->wdd);
+		set_bit(WDOG_HW_RUNNING, &wdt->wdd.status);
+	}
+
 	ret = devm_watchdog_register_device(dev, &wdt->wdd);
 	if (ret)
 		return ret;
-- 
2.28.0

