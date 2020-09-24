Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903B3276CC1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 11:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgIXJGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 05:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbgIXJGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 05:06:04 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFF8C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 02:06:04 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id b79so2766017wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 02:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W2fDy8x0xdXtyH7rgIuIrQsXyNztz4f/Ycod8x2wqtE=;
        b=sBshn0KArChJEd5qdryBZJNJln9rvwB/sQGvPEGyiq6hkfQy8z5gYCl9piuNDDva4n
         8OhHS6Dz0xDFCwTLkHBuK0V/wBPrEriijY5TIcvIa1DRy+c6wghxGeEI565HQvJAdAKJ
         9zLoct/iw5Wf3tFaAiVI0NnDr/CDwxK3UVMtF84kxCTzEL7qKqsL7VTMBCI2PTuBisjB
         QqteUjf8LnlTRhdR1rGi7EvESUJuf3SKbItzB5AC+CZ6GVcNeFmXkNay13ooLicwkLFi
         mNMBCfOMz6lL5CZsnlhfnvWPo9+h9KU8hcwg8tkTn9RvAx5yUOPzprBcqyfAFBGoABGb
         j7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W2fDy8x0xdXtyH7rgIuIrQsXyNztz4f/Ycod8x2wqtE=;
        b=ZTraqMB4/nD9kBcJHRNWcLVcaY6bT+piY7XXaiU3xIsRJ5MlE4SulCDCKXZEirrR7u
         4OYNLSYUErW7Vg+/+Rqz0Jm0Ym9/sMGFX6s2VcdwZtcqrKz2YOyqG7mI/30OVDq+9yjs
         j3pM0A9mT3JvoKeg587Nn9zUAl/7a8WTTERniSZfpRDXl3xQoBWIQC6cCnQq5e3L7Dqd
         RFCvUTzhUJJaT7Bl0FS9CShvsKDJMi9TI8QA7TJETXW4MZ6mHoR1Id38PYTEfgooNmfZ
         NGJAWmBn0n26MpwtK/PB77w7ivnB5Z3eWfjfJgAqyIMhgu7ElOqDHCm+G7C4NRMInStf
         J1mw==
X-Gm-Message-State: AOAM532vAcENeMDZmRMjVq7lux09OKIW4XHEWpz/Lb1r8Ii6G+uFFCuT
        jJ3uVPeOe2HsPdtACCx1GmT6sQ==
X-Google-Smtp-Source: ABdhPJxxOdv1+IDqQUd2FKdytyNhM++WwX4UuiTSRq+VNyLAvUD71Xn23b7edfU6SznYReWdEcaOsw==
X-Received: by 2002:a05:600c:2257:: with SMTP id a23mr3843450wmm.102.1600938362651;
        Thu, 24 Sep 2020 02:06:02 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:11e1:db8b:493b:54f4])
        by smtp.gmail.com with ESMTPSA id h2sm2861461wrp.69.2020.09.24.02.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 02:06:02 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 04/10] clocksource/drivers/sp804: Remove unused sp804_timer_disable() and timer-sp804.h
Date:   Thu, 24 Sep 2020 11:05:28 +0200
Message-Id: <20200924090534.2004630-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200924090534.2004630-1-daniel.lezcano@linaro.org>
References: <1f4f3f8f-2472-44af-0536-6bc76741d276@linaro.org>
 <20200924090534.2004630-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

Since commit 7484c727b636 ("ARM: realview: delete the RealView board
files") and commit 16956fed35fe ("ARM: versatile: switch to DT only
booting and remove legacy code"), there's no one to use the functions
defined or declared in include/clocksource/timer-sp804.h. Delete it.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200918132237.3552-3-thunder.leizhen@huawei.com
---
 drivers/clocksource/timer-sp804.c |  7 -------
 include/clocksource/timer-sp804.h | 29 -----------------------------
 2 files changed, 36 deletions(-)
 delete mode 100644 include/clocksource/timer-sp804.h

diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index bec2d372e0df..97b41a493253 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -18,8 +18,6 @@
 #include <linux/of_irq.h>
 #include <linux/sched_clock.h>
 
-#include <clocksource/timer-sp804.h>
-
 #include "timer-sp.h"
 
 static long __init sp804_get_clock_rate(struct clk *clk, const char *name)
@@ -67,11 +65,6 @@ static u64 notrace sp804_read(void)
 	return ~readl_relaxed(sched_clock_base + TIMER_VALUE);
 }
 
-void __init sp804_timer_disable(void __iomem *base)
-{
-	writel(0, base + TIMER_CTRL);
-}
-
 int  __init __sp804_clocksource_and_sched_clock_init(void __iomem *base,
 						     const char *name,
 						     struct clk *clk,
diff --git a/include/clocksource/timer-sp804.h b/include/clocksource/timer-sp804.h
deleted file mode 100644
index a5b41f31a1c2..000000000000
--- a/include/clocksource/timer-sp804.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __CLKSOURCE_TIMER_SP804_H
-#define __CLKSOURCE_TIMER_SP804_H
-
-struct clk;
-
-int __sp804_clocksource_and_sched_clock_init(void __iomem *,
-					     const char *, struct clk *, int);
-int __sp804_clockevents_init(void __iomem *, unsigned int,
-			     struct clk *, const char *);
-void sp804_timer_disable(void __iomem *);
-
-static inline void sp804_clocksource_init(void __iomem *base, const char *name)
-{
-	__sp804_clocksource_and_sched_clock_init(base, name, NULL, 0);
-}
-
-static inline void sp804_clocksource_and_sched_clock_init(void __iomem *base,
-							  const char *name)
-{
-	__sp804_clocksource_and_sched_clock_init(base, name, NULL, 1);
-}
-
-static inline void sp804_clockevents_init(void __iomem *base, unsigned int irq, const char *name)
-{
-	__sp804_clockevents_init(base, irq, NULL, name);
-
-}
-#endif
-- 
2.25.1

