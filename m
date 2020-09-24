Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD0B276CC6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 11:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbgIXJG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 05:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbgIXJGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 05:06:08 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4DDC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 02:06:07 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id x23so2708640wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 02:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kp+/new4Ce7AIJeXoLlkg51YW/JnrxKhmM21Dy40ofs=;
        b=hwSLvDq7mRdMYrC8cE2M1HctRLeP0gDuBxMQNuBQxSEyHhtekyFTT5ybQ+Qcl2nepC
         053m2ON0z24TSgdQW1bOLuYgDWw1VH/IdbRUymAKaZJiTp4I4p4jHRTQ+iby1L/twZBW
         v1uQih5NwxjTpr0SNi3WWYmgr4slRMKJr9qwQHrBBSTjLspamc+QjwdC9HOan+QR96Ru
         A0pP5RJE15uvSfX5fsvP9bp20OsFnWjnuFMiOrZO4F53iuB0GzFN5BrrnAmNWvlhsGIN
         TyB+1PUeGHGsMONy/51v5dHjyXNUijaATPaPZM2/vddR6zXNmztiCMMmM/oeRHkn/k95
         OqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kp+/new4Ce7AIJeXoLlkg51YW/JnrxKhmM21Dy40ofs=;
        b=IXfd9wShIdgPB5Zvk7PQ8Qz8a2wkrBmSjp1MkUugn5Xvy9ABhtcavo06yb+og2EjFu
         ETOI/raUbIdu96uvtmkKTkkFPZwDelB9avZrgzW8NJvQ1jxnTQZFEH08mdyq/LlYc9FP
         P84/UwNTvNYivQYM91+Lrhexx0n8OK4z3CZoLtnTMkpvNPKO7VTX/uhpSe5UKCEOhQo9
         uB+Ltr0z5RU+r/rWPrQgRdRZVG3fqgkAk36BsQa3RdsPyFdPRzvFYwHQUeDfTF77ieVA
         QfhEWNpk1SYOn1OBJ1cCMowyWtNuG/EBXt0bslUKqsgOEOK47XDxMUVnTvFLuhIpX6/a
         9MtA==
X-Gm-Message-State: AOAM530jl1Ev1YY4HaeUPFKm9MH4Kz2omdzWpYVkJzMIQ8nv9S5aZTJz
        VbM6jDtoz1K8xm5Xdvw356by0A==
X-Google-Smtp-Source: ABdhPJwZhRdzdRaYHXYGc2k7Ld7+Q2OycECYlSHupF73PIyfdtGvGR+WvB4k+N1vJXIUR+7lJBNH0A==
X-Received: by 2002:a1c:480a:: with SMTP id v10mr3481891wma.141.1600938366400;
        Thu, 24 Sep 2020 02:06:06 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:11e1:db8b:493b:54f4])
        by smtp.gmail.com with ESMTPSA id h2sm2861461wrp.69.2020.09.24.02.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 02:06:05 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org (open list:CLOCKSOURCE, CLOCKEVENT DRIVERS)
Subject: [PATCH 07/10] clocksource/drivers/sp804: Prepare for support non-standard register offset
Date:   Thu, 24 Sep 2020 11:05:31 +0200
Message-Id: <20200924090534.2004630-7-daniel.lezcano@linaro.org>
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

Add two local variables: timer1_base and timer2_base in sp804_of_init(),
to avoid repeatedly calculate the base address of timer2, and make it
easier to recognize timer1. Hope to make the next patch looks more clear.

No functional change.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200918132237.3552-6-thunder.leizhen@huawei.com
---
 drivers/clocksource/timer-sp804.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index a443f392a8e7..471c5c6aaf51 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -188,6 +188,8 @@ static int __init sp804_of_init(struct device_node *np)
 {
 	static bool initialized = false;
 	void __iomem *base;
+	void __iomem *timer1_base;
+	void __iomem *timer2_base;
 	int irq, ret = -EINVAL;
 	u32 irq_num = 0;
 	struct clk *clk1, *clk2;
@@ -197,9 +199,12 @@ static int __init sp804_of_init(struct device_node *np)
 	if (!base)
 		return -ENXIO;
 
+	timer1_base = base;
+	timer2_base = base + TIMER_2_BASE;
+
 	/* Ensure timers are disabled */
-	writel(0, base + TIMER_CTRL);
-	writel(0, base + TIMER_2_BASE + TIMER_CTRL);
+	writel(0, timer1_base + TIMER_CTRL);
+	writel(0, timer2_base + TIMER_CTRL);
 
 	if (initialized || !of_device_is_available(np)) {
 		ret = -EINVAL;
@@ -228,21 +233,21 @@ static int __init sp804_of_init(struct device_node *np)
 	of_property_read_u32(np, "arm,sp804-has-irq", &irq_num);
 	if (irq_num == 2) {
 
-		ret = sp804_clockevents_init(base + TIMER_2_BASE, irq, clk2, name);
+		ret = sp804_clockevents_init(timer2_base, irq, clk2, name);
 		if (ret)
 			goto err;
 
-		ret = sp804_clocksource_and_sched_clock_init(base,
+		ret = sp804_clocksource_and_sched_clock_init(timer1_base,
 							     name, clk1, 1);
 		if (ret)
 			goto err;
 	} else {
 
-		ret = sp804_clockevents_init(base, irq, clk1, name);
+		ret = sp804_clockevents_init(timer1_base, irq, clk1, name);
 		if (ret)
 			goto err;
 
-		ret = sp804_clocksource_and_sched_clock_init(base + TIMER_2_BASE,
+		ret = sp804_clocksource_and_sched_clock_init(timer2_base,
 							     name, clk2, 1);
 		if (ret)
 			goto err;
-- 
2.25.1

