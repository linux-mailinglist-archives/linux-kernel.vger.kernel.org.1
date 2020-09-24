Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C4D276CC2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 11:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbgIXJGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 05:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbgIXJGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 05:06:05 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF07C0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 02:06:05 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id e11so6324642wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 02:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IDKcA2BAjp1cv5ImIcxHJNRswmh8BMjfNYKf7YgqGYY=;
        b=rRcYHF4MdPNFBeCC+Al4jvl3qM+6DXOuhDHI3ftP3qaKWG8c8KrgotHBFb45kbTDas
         vnZCRkBA6KJq+PPZmEczSGwasPGHkHX2gOWI5bzYQNXm5MkGEgP8BL7veCe6i2HSAq+t
         yW4niuoqUyrA9LU/mGx4+uFih6cVQMCtq9ICFmHjVnLKylAqvmF+6ohNpFUeGAbepOmZ
         s8SjeduZd88GMj0NHAldHtT9Xq4gZKwiAvkmTRNR1AdXp0m8wcGQzgZSq5YufZoac6eZ
         8f6bny+YC2uRkKjaYNI+RIHKizWILSwncjmUktUQuNVwrUtnYAkk/vSxevRD58Dzgj8C
         rOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IDKcA2BAjp1cv5ImIcxHJNRswmh8BMjfNYKf7YgqGYY=;
        b=DjXN16PgHQUmcnqWNB4V3ZK+erFtE5jSVJbl7vkmtbUqwhaIXZbhkh/tUEu3oInW6H
         +xHpEPf2jFq18awlhTYqJFADUgt1nwEmgkvCdnHPn8XHAa8jMQQvQJxPOZe6Ie6aCQaX
         KLpH9rMG5WG6AGxfTKv9AXbT7K7JrrrSb8V2HuzZ2QHhH336Ovhe4T/CIdh4C6E4s9/3
         HBr6hKHcGaN7tHmCFqMCVK/5nyawA9vP6wF2vyYWJgI1yFZsOMo36zxY4BCLVO7KMVe6
         OKDbeUaZwC0A0BoHNLunWESgmE5TjYoW5OgTpUx/5bwbT7CQZvy5SxmWFUE2d2plOcqP
         Dy7w==
X-Gm-Message-State: AOAM533/GfeK4cWrRGLGbMsPlkGkLJi0wkckAhRH0GmBndZN22eTr9D5
        gu3prT6w29daLvAQbaFFVL+2vQ==
X-Google-Smtp-Source: ABdhPJw0SKxX/QORrZ1czUNSx27bihzWuTUJPw7nsbPl6rU1CJY55foJBtrN7LPlE4mxcNKFI2p8Qw==
X-Received: by 2002:a1c:7405:: with SMTP id p5mr3648612wmc.35.1600938363943;
        Thu, 24 Sep 2020 02:06:03 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:11e1:db8b:493b:54f4])
        by smtp.gmail.com with ESMTPSA id h2sm2861461wrp.69.2020.09.24.02.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 02:06:03 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org (open list:CLOCKSOURCE, CLOCKEVENT DRIVERS)
Subject: [PATCH 05/10] clocksource/drivers/sp804: Delete the leading "__" of some functions
Date:   Thu, 24 Sep 2020 11:05:29 +0200
Message-Id: <20200924090534.2004630-5-daniel.lezcano@linaro.org>
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

Delete the leading "__" of __sp804_clocksource_and_sched_clock_init() and
__sp804_clockevents_init(), make it looks a little more comfortable.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200918132237.3552-4-thunder.leizhen@huawei.com
---
 drivers/clocksource/timer-sp804.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index 97b41a493253..097f5a83163c 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -65,10 +65,10 @@ static u64 notrace sp804_read(void)
 	return ~readl_relaxed(sched_clock_base + TIMER_VALUE);
 }
 
-int  __init __sp804_clocksource_and_sched_clock_init(void __iomem *base,
-						     const char *name,
-						     struct clk *clk,
-						     int use_sched_clock)
+int __init sp804_clocksource_and_sched_clock_init(void __iomem *base,
+						  const char *name,
+						  struct clk *clk,
+						  int use_sched_clock)
 {
 	long rate;
 
@@ -159,7 +159,8 @@ static struct clock_event_device sp804_clockevent = {
 	.rating			= 300,
 };
 
-int __init __sp804_clockevents_init(void __iomem *base, unsigned int irq, struct clk *clk, const char *name)
+int __init sp804_clockevents_init(void __iomem *base, unsigned int irq,
+				  struct clk *clk, const char *name)
 {
 	struct clock_event_device *evt = &sp804_clockevent;
 	long rate;
@@ -228,21 +229,22 @@ static int __init sp804_of_init(struct device_node *np)
 	of_property_read_u32(np, "arm,sp804-has-irq", &irq_num);
 	if (irq_num == 2) {
 
-		ret = __sp804_clockevents_init(base + TIMER_2_BASE, irq, clk2, name);
+		ret = sp804_clockevents_init(base + TIMER_2_BASE, irq, clk2, name);
 		if (ret)
 			goto err;
 
-		ret = __sp804_clocksource_and_sched_clock_init(base, name, clk1, 1);
+		ret = sp804_clocksource_and_sched_clock_init(base,
+							     name, clk1, 1);
 		if (ret)
 			goto err;
 	} else {
 
-		ret = __sp804_clockevents_init(base, irq, clk1 , name);
+		ret = sp804_clockevents_init(base, irq, clk1, name);
 		if (ret)
 			goto err;
 
-		ret =__sp804_clocksource_and_sched_clock_init(base + TIMER_2_BASE,
-							      name, clk2, 1);
+		ret = sp804_clocksource_and_sched_clock_init(base + TIMER_2_BASE,
+							     name, clk2, 1);
 		if (ret)
 			goto err;
 	}
@@ -282,7 +284,8 @@ static int __init integrator_cp_of_init(struct device_node *np)
 		goto err;
 
 	if (!init_count) {
-		ret = __sp804_clocksource_and_sched_clock_init(base, name, clk, 0);
+		ret = sp804_clocksource_and_sched_clock_init(base,
+							     name, clk, 0);
 		if (ret)
 			goto err;
 	} else {
@@ -290,7 +293,7 @@ static int __init integrator_cp_of_init(struct device_node *np)
 		if (irq <= 0)
 			goto err;
 
-		ret = __sp804_clockevents_init(base, irq, clk, name);
+		ret = sp804_clockevents_init(base, irq, clk, name);
 		if (ret)
 			goto err;
 	}
-- 
2.25.1

