Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84CF4303E19
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 14:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391921AbhAZNHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 08:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391989AbhAZMtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 07:49:01 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAE5C035433
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:46:09 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c127so2615976wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zJtSQGuxz964dfYUWXRLdwlnPP2R/QEORl17NxQy5d4=;
        b=GDA6VuYgWblPv9tnaRfwdw/YrjYKrCWwOqW7HYExURDfcqlHtm9ulxub2JS85ZsYPD
         TiANdGatfnUgdRGLQh7GoQ22HKgKxvCct1Ju90J2tVyc7HfZDqAHGqZNNl1yx6AEAW/y
         oAvSsIi7xZKfpE/BhunIxIwoXuZ7U4EJpXkuXQ1Jq+lpDL2EelHHGqMLY6o2zYSOBDH6
         ErvsgoNL+63u/tVu4mOPYe+0LqurL6A68GprJpVLYDhioCUiu7qlV8ODNe3IMqzG8OLQ
         mu8hIIf0sukV9EY1KqWw7EYHnVbnE5GoJFc0Pf7LM7GfQBDGR/osUddtpChhCk/83U7q
         6VFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zJtSQGuxz964dfYUWXRLdwlnPP2R/QEORl17NxQy5d4=;
        b=KMKSJZc0q514bGnDFFMnhSpIs9gue+nclaAUSvW6nfyVWtFmkUJn3W3Wkcm7bqZehT
         6F5HNcrvDJIvXIsZNmvi+TnPef6pJuTPXJ72dgHaZyJkvU8RJBlMQRSBir9gq+0af0le
         FhgTYEgNTBxPNE73Umsmgc79IZOgTLXM/adfa/pBVkW093Wg70ztiTRG+aqd6n5QUGEr
         R8Xr0saLOFNOIohOdwdHMOJU2l9Ou2pZ431a/QfcC6bmqLK3EJ+b8G/h6vR34PS6ZiEH
         xVQtaQNiwssITlqGA0bMABxmVjpgG+bvV/0PsNll6+merBtaQKZh4FfZUZVTxjUmc9yS
         0EVQ==
X-Gm-Message-State: AOAM531oqWU3E1ADjec6JVNUG2R8xBAsinB9udRdF5Xt2ovSOC6ndgiV
        umuna0Y2usnglWw0xckWmW8Vcw==
X-Google-Smtp-Source: ABdhPJz6MIZQG2LgzYeGqTVMQgNd8pCBhDKPFxbM5Le6UPbMFQS8g+QNOT/b/djSPdsv18wh7s/uXQ==
X-Received: by 2002:a7b:ce11:: with SMTP id m17mr4492622wmc.158.1611665168230;
        Tue, 26 Jan 2021 04:46:08 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id i131sm3263073wmi.25.2021.01.26.04.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 04:46:07 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 20/21] clk: imx: Move 'imx6sl_set_wait_clk()'s prototype out to accessible header
Date:   Tue, 26 Jan 2021 12:45:39 +0000
Message-Id: <20210126124540.3320214-21-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126124540.3320214-1-lee.jones@linaro.org>
References: <20210126124540.3320214-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/clk/imx/clk-imx6sl.c:156:6: warning: no previous prototype for ‘imx6sl_set_wait_clk’ [-Wmissing-prototypes]

Cc: Russell King <linux@armlinux.org.uk>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-imx/common.h         |  1 -
 arch/arm/mach-imx/cpuidle-imx6sl.c |  1 +
 arch/arm/mach-imx/pm-imx6.c        |  1 +
 drivers/clk/imx/clk-imx6sl.c       |  1 +
 include/linux/clk/imx.h            | 15 +++++++++++++++
 5 files changed, 18 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/clk/imx.h

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 2d76e2c6c99e3..2b004cc4f95e5 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -85,7 +85,6 @@ void imx_anatop_pre_suspend(void);
 void imx_anatop_post_resume(void);
 int imx6_set_lpm(enum mxc_cpu_pwr_mode mode);
 void imx6_set_int_mem_clk_lpm(bool enable);
-void imx6sl_set_wait_clk(bool enter);
 int imx_mmdc_get_ddr_type(void);
 int imx7ulp_set_lpm(enum ulp_cpu_pwr_mode mode);
 
diff --git a/arch/arm/mach-imx/cpuidle-imx6sl.c b/arch/arm/mach-imx/cpuidle-imx6sl.c
index 4521e5352bf64..b86ffbeb28e42 100644
--- a/arch/arm/mach-imx/cpuidle-imx6sl.c
+++ b/arch/arm/mach-imx/cpuidle-imx6sl.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2014 Freescale Semiconductor, Inc.
  */
 
+#include <linux/clk/imx.h>
 #include <linux/cpuidle.h>
 #include <linux/module.h>
 #include <asm/cpuidle.h>
diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
index 40c74b4c4d730..9244437cb1b9b 100644
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -4,6 +4,7 @@
  * Copyright 2011 Linaro Ltd.
  */
 
+#include <linux/clk/imx.h>
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/io.h>
diff --git a/drivers/clk/imx/clk-imx6sl.c b/drivers/clk/imx/clk-imx6sl.c
index 2f9361946a0e1..29eab05c90689 100644
--- a/drivers/clk/imx/clk-imx6sl.c
+++ b/drivers/clk/imx/clk-imx6sl.c
@@ -6,6 +6,7 @@
 #include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/clkdev.h>
+#include <linux/clk/imx.h>
 #include <linux/err.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
diff --git a/include/linux/clk/imx.h b/include/linux/clk/imx.h
new file mode 100644
index 0000000000000..75a0d96965528
--- /dev/null
+++ b/include/linux/clk/imx.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2020 Freescale Semiconductor, Inc.
+ *
+ * Author: Lee Jones <lee.jones@linaro.org>
+ */
+
+#ifndef __LINUX_CLK_IMX_H
+#define __LINUX_CLK_IMX_H
+
+#include <linux/types.h>
+
+void imx6sl_set_wait_clk(bool enter);
+
+#endif
-- 
2.25.1

