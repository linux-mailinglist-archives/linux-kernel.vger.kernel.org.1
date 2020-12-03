Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336C02CDF09
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 20:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387674AbgLCTeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 14:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgLCTeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 14:34:09 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92825C061A53
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 11:33:29 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id l1so3052670wrb.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 11:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lHnjwprsrYHaogt+qYhv4aSYTPbIEUqLYfmEtZhpQII=;
        b=iB5T4CEkgQ19ixp3IMnzEW53ZTSmTWeiFcIalR2rZCpVuLfGugj8G8SHwrBgfRoQbk
         WTI/pkCoe7x2330WN1Qg//1kqCwzjgkuc7a63JN2YvjpP1yqFR5dbZoyWospZboydjwx
         f+vBHWbKS72ucuOe8WzwBCEYzrMq4ig+zP2pvCOFqiqk27+tANS0zzk4ssjbCiV02YYw
         IVfdJtdPmHGcIu7wTjQ3GeWx4WXo9Kq20WNOPbYMeuR8m9+EIGI5cCDv2hibPP66b3vH
         LReldXig+R5iCQDqo7MomacKcj476aq5P7fEqWAc0Cx3wetRcz4DfTlsaFk64wBqOIZy
         rZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lHnjwprsrYHaogt+qYhv4aSYTPbIEUqLYfmEtZhpQII=;
        b=D25tMvfZA48OJXr8SB+xo1xqP7o5fYx3J2QQRJoJJ36AlBgYsRdRVoPPXilvXuxOMm
         8gFf4NIgR7iNeA1rAc6444a7xVVMrh/PdGKQ+hRUYTlmxHaDMUB8bdi2u18AMmrm+EH9
         VdyiVdV5tPUO145FMzMijk1tS2V56vyJ3R7hQ618Wlq/s8ISVnwFHd5SyzbODLYM98Pc
         2+DLpYR/0wcewH7hP/hnOkaZv8JUlTUl9YXuLlYzY70uD4yz5bPOg0f0efV/NjPrIXkS
         5MeYrNtVBjlWPNUOR+b0QLosSQU3P623Sc1UU+Edlo/O0XWMpmGLX4jZZUk9jNZBMw2K
         sBIg==
X-Gm-Message-State: AOAM530gPK1nO355MQ1HHYYYnkNDViEiyGBSUl7eUBmh0UXaWoEjxV6u
        26x8aprocl3p1Z4BKFhOLPTGFg==
X-Google-Smtp-Source: ABdhPJw+n9DmBJn1Fdxg9o1JlJiOxybylCPPtzzgQV7cJImYmcW1ApLpeSP3NmAh3l3XNmBTaDjFig==
X-Received: by 2002:adf:9787:: with SMTP id s7mr855221wrb.286.1607024008199;
        Thu, 03 Dec 2020 11:33:28 -0800 (PST)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:9cff:9584:adb2:6288])
        by smtp.gmail.com with ESMTPSA id o83sm382441wme.21.2020.12.03.11.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 11:33:27 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 05/13] clocksource/drivers/sp804: Use pr_fmt
Date:   Thu,  3 Dec 2020 20:32:53 +0100
Message-Id: <20201203193301.2405835-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201203193301.2405835-1-daniel.lezcano@linaro.org>
References: <028084fa-d29b-a1d5-7eab-17f77ef69863@linaro.org>
 <20201203193301.2405835-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kefeng Wang <wangkefeng.wang@huawei.com>

Add pr_fmt to prefix pr_<level> output.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201029123317.90286-5-wangkefeng.wang@huawei.com
---
 drivers/clocksource/timer-sp804.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index fcce839670cb..401d592e85f5 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -5,6 +5,9 @@
  *  Copyright (C) 1999 - 2003 ARM Limited
  *  Copyright (C) 2000 Deep Blue Solutions Ltd
  */
+
+#define pr_fmt(fmt)    KBUILD_MODNAME ": " fmt
+
 #include <linux/clk.h>
 #include <linux/clocksource.h>
 #include <linux/clockchips.h>
@@ -63,13 +66,13 @@ static long __init sp804_get_clock_rate(struct clk *clk, const char *name)
 	if (!clk)
 		clk = clk_get_sys("sp804", name);
 	if (IS_ERR(clk)) {
-		pr_err("sp804: %s clock not found: %ld\n", name, PTR_ERR(clk));
+		pr_err("%s clock not found: %ld\n", name, PTR_ERR(clk));
 		return PTR_ERR(clk);
 	}
 
 	err = clk_prepare_enable(clk);
 	if (err) {
-		pr_err("sp804: clock failed to enable: %d\n", err);
+		pr_err("clock failed to enable: %d\n", err);
 		clk_put(clk);
 		return err;
 	}
@@ -218,7 +221,7 @@ static int __init sp804_clockevents_init(void __iomem *base, unsigned int irq,
 
 	if (request_irq(irq, sp804_timer_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
 			"timer", &sp804_clockevent))
-		pr_err("%s: request_irq() failed\n", "timer");
+		pr_err("request_irq() failed\n");
 	clockevents_config_and_register(evt, rate, 0xf, 0xffffffff);
 
 	return 0;
@@ -280,7 +283,7 @@ static int __init sp804_of_init(struct device_node *np, struct sp804_timer *time
 	if (of_clk_get_parent_count(np) == 3) {
 		clk2 = of_clk_get(np, 1);
 		if (IS_ERR(clk2)) {
-			pr_err("sp804: %pOFn clock not found: %d\n", np,
+			pr_err("%pOFn clock not found: %d\n", np,
 				(int)PTR_ERR(clk2));
 			clk2 = NULL;
 		}
-- 
2.25.1

