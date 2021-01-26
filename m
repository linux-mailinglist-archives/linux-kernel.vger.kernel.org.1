Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC77303E23
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 14:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391886AbhAZNIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 08:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391691AbhAZMs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 07:48:58 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55119C035431
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:46:08 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id y187so2635173wmd.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VUPD/cY/LxhsyGz5jHztNy8YoBG2hAYfm7OqDgw4v6U=;
        b=FAKKvRzUpV5MunUaX3y3M0fVr0O0QjwYBT91T6fALGVpWDMVrP5aQT40HU3JSycRAE
         VkDgwCNzC0hH+sllDZ8T04ETOnXBWzWOUMuu3HSV2R7tB98d4jTiTKh+tjhbKv20jKCo
         YrsgE74qauxuN2zfXJa50Wq5qbd2iMgMLIqFIcpk0UOmgQkUNoBVyiwXyzbnCrPRVYUU
         ZdmlfIUGK2DdYXj5phDiTToHiksYJcmgPaNYsQGJZP7jFG492ugjPOD6p8Jpgxd4YqFy
         9CpIBbASUxkCTSLjhQr33AvPkSK3BCKuoqCCBTkyan5ugwIoCIpFf59EcIWWABAUBMMD
         G/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VUPD/cY/LxhsyGz5jHztNy8YoBG2hAYfm7OqDgw4v6U=;
        b=bRMqf9llykF0lluZi+zY0VpopCIlm1ODmbQXQu5EofaztajPjUKJkPB/LpU+7sllsG
         6H8ZJLxsx6ZloeAPI5f7fZ9fLzBDzG86vzez19O26YQPwTDTX5wGIYfiAegbhgrE2c35
         zH0SYB6/nN1wojngEKIijth+FqUNTvD0mVkGfMS378AccEzQMfnrC5QW3BxDQQHoFdFh
         Fl65ab+fF3NChav8H1UOZFLIJzMKUqExrqdWI7P2N04q3q+o1MBovHL95DO7Cm9xthzq
         1BhVyuMLduGQrNJHDSNNyEDAxTX+PWcgE1lz2tp2QIe1KAp/sAVB/ZuE0y6lg2i8yHLH
         kapg==
X-Gm-Message-State: AOAM5330kJ5sXtVnC0d5/t2wqxJhxW99CZdqD70Y4Tzsiv6oYz2nMeLD
        /VKxDV2H6fUT+5CAWP6QsD2KTw==
X-Google-Smtp-Source: ABdhPJzDfZrmi2kd5wjC1UYrN12+BpCm+J6hNVRU+Vg0taR5ItIW4r04IRJtEUstdKlRYXEEAID4Cw==
X-Received: by 2002:a1c:9648:: with SMTP id y69mr4464374wmd.40.1611665167134;
        Tue, 26 Jan 2021 04:46:07 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id i131sm3263073wmi.25.2021.01.26.04.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 04:46:06 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Rajeev Kumar <rajeev-dlh.kumar@st.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 19/21] clk: spear: Move prototype to accessible header
Date:   Tue, 26 Jan 2021 12:45:38 +0000
Message-Id: <20210126124540.3320214-20-lee.jones@linaro.org>
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

 drivers/clk/spear/spear1310_clock.c:385:13: warning: no previous prototype for ‘spear1310_clk_init’ [-Wmissing-prototypes]
 drivers/clk/spear/spear1340_clock.c:442:13: warning: no previous prototype for ‘spear1340_clk_init’ [-Wmissing-prototypes]

Cc: Viresh Kumar <vireshk@kernel.org>
Cc: Shiraz Hashim <shiraz.linux.kernel@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-spear/generic.h       | 12 ------------
 arch/arm/mach-spear/spear13xx.c     |  1 +
 drivers/clk/spear/spear1310_clock.c |  1 +
 drivers/clk/spear/spear1340_clock.c |  1 +
 include/linux/clk/spear.h           | 23 +++++++++++++++++++++++
 5 files changed, 26 insertions(+), 12 deletions(-)
 create mode 100644 include/linux/clk/spear.h

diff --git a/arch/arm/mach-spear/generic.h b/arch/arm/mach-spear/generic.h
index 25b4c5e66e396..8ec2b92dca192 100644
--- a/arch/arm/mach-spear/generic.h
+++ b/arch/arm/mach-spear/generic.h
@@ -43,16 +43,4 @@ void spear13xx_cpu_die(unsigned int cpu);
 
 extern const struct smp_operations spear13xx_smp_ops;
 
-#ifdef CONFIG_MACH_SPEAR1310
-void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base);
-#else
-static inline void spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base) {}
-#endif
-
-#ifdef CONFIG_MACH_SPEAR1340
-void __init spear1340_clk_init(void __iomem *misc_base);
-#else
-static inline void spear1340_clk_init(void __iomem *misc_base) {}
-#endif
-
 #endif /* __MACH_GENERIC_H */
diff --git a/arch/arm/mach-spear/spear13xx.c b/arch/arm/mach-spear/spear13xx.c
index 31c43cabf3623..74d1ca2a529a7 100644
--- a/arch/arm/mach-spear/spear13xx.c
+++ b/arch/arm/mach-spear/spear13xx.c
@@ -15,6 +15,7 @@
 
 #include <linux/amba/pl022.h>
 #include <linux/clk.h>
+#include <linux/clk/spear.h>
 #include <linux/clocksource.h>
 #include <linux/err.h>
 #include <linux/of.h>
diff --git a/drivers/clk/spear/spear1310_clock.c b/drivers/clk/spear/spear1310_clock.c
index 591248c9a88e7..8c89748667899 100644
--- a/drivers/clk/spear/spear1310_clock.c
+++ b/drivers/clk/spear/spear1310_clock.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/clkdev.h>
+#include <linux/clk/spear.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/of_platform.h>
diff --git a/drivers/clk/spear/spear1340_clock.c b/drivers/clk/spear/spear1340_clock.c
index 9163bbb464112..c0dc94355c873 100644
--- a/drivers/clk/spear/spear1340_clock.c
+++ b/drivers/clk/spear/spear1340_clock.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/clkdev.h>
+#include <linux/clk/spear.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/of_platform.h>
diff --git a/include/linux/clk/spear.h b/include/linux/clk/spear.h
new file mode 100644
index 0000000000000..a64d034ceddd2
--- /dev/null
+++ b/include/linux/clk/spear.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2020 STMicroelectronics - All Rights Reserved
+ *
+ * Author: Lee Jones <lee.jones@linaro.org>
+ */
+
+#ifndef __LINUX_CLK_SPEAR_H
+#define __LINUX_CLK_SPEAR_H
+
+#ifdef CONFIG_MACH_SPEAR1310
+void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base);
+#else
+static inline void spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base) {}
+#endif
+
+#ifdef CONFIG_MACH_SPEAR1340
+void __init spear1340_clk_init(void __iomem *misc_base);
+#else
+static inline void spear1340_clk_init(void __iomem *misc_base) {}
+#endif
+
+#endif
-- 
2.25.1

