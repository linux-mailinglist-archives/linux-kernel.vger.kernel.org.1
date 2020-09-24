Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31902276CBF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 11:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbgIXJGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 05:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbgIXJGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 05:06:02 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0980C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 02:06:01 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a9so2791764wmm.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 02:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qVLjcSbYHa9A2+7J7FxnHSSHy38VadZ8VbrC2KQOVqI=;
        b=kWH6W2KELq8AjBEuZuI6sJAAXxWxNJ2D2uqcdVRnfSL1kWnDpZkmTA/UjRRQqeBC33
         P5Nl/ytuZQGTBNYXOwQqRfm7XgcTKVjRVfoRppu1YbWWUKOWzvtP6EVpVJRmu2iusdLe
         Ith7/MTbBDg4cOlsM+pzqH0Chr2tsAGw0/+J2H/m86j1msXez91lF8IjAxh0UiGTl8AY
         MJEksmKhEAbB7WpVd1jszHlfi4Lxw9AlpIoJlCqGfKL5aiuZZUD/0jAla9/EHk2xPtPp
         E/EMnxFXnLhISVl8cyW1Yy6+s7WYBdSiiVMYOfoNWsV5Xi6nmEquwD0/us/kkObUYVSZ
         2oRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qVLjcSbYHa9A2+7J7FxnHSSHy38VadZ8VbrC2KQOVqI=;
        b=PQJQWNpDcMDTuuk/mqQaf5KVzyyFr/hKKf8wzRiMS259L+GiXsHEd70GL3xUvSKFcp
         NJZwIxsoPISeBpvt/yQLlsUtxE5lluJIuGKVhfqlFvv95VqNNrdhrvi10CSoJMEr3LOD
         FkPqEmME7L+0ttwwwxUboH0iRD/0NeC96eTTYOEjbutXupHyigTfjB+kaXULW8dU2/vn
         YYHUCNlYQamDD6N6NHwIDHtK13LefwJSxAmGDPpm5lCpxhPi5bQb6sd4hRDPQkFpsr/l
         bE9pi1NYBV9aelfO/RS/PoZ8KG4A/9Gq0x4BEW9HbME9/PCGuNVijsz5jOmS1U51uWyj
         fwCQ==
X-Gm-Message-State: AOAM533hxDxwaxAcq29fniySL/pvSQjJDkmute5iS0MtuXcZtzQtSfwN
        leWbjfqfdd2Y2sUnuVBQLJqa5Q==
X-Google-Smtp-Source: ABdhPJxd3iSXWuM8k+RsTbx2GxzspuPZ+PLVJoGELnWDY+dWv78FNqQeuEsDQoUftIaPY+w/5m7oNQ==
X-Received: by 2002:a7b:c84a:: with SMTP id c10mr3662769wml.139.1600938360117;
        Thu, 24 Sep 2020 02:06:00 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:11e1:db8b:493b:54f4])
        by smtp.gmail.com with ESMTPSA id h2sm2861461wrp.69.2020.09.24.02.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 02:05:59 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org (open list:CLOCKSOURCE, CLOCKEVENT DRIVERS)
Subject: [PATCH 03/10] clocksource/drivers/sp804: Cleanup clk_get_sys()
Date:   Thu, 24 Sep 2020 11:05:27 +0200
Message-Id: <20200924090534.2004630-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200924090534.2004630-1-daniel.lezcano@linaro.org>
References: <1f4f3f8f-2472-44af-0536-6bc76741d276@linaro.org>
 <20200924090534.2004630-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kefeng Wang <wangkefeng.wang@huawei.com>

Move the clk_get_sys() part into sp804_get_clock_rate(), cleanup the same
code.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200918132237.3552-2-thunder.leizhen@huawei.com
---
 drivers/clocksource/timer-sp804.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index 5cd0abf9b396..bec2d372e0df 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -22,11 +22,18 @@
 
 #include "timer-sp.h"
 
-static long __init sp804_get_clock_rate(struct clk *clk)
+static long __init sp804_get_clock_rate(struct clk *clk, const char *name)
 {
 	long rate;
 	int err;
 
+	if (!clk)
+		clk = clk_get_sys("sp804", name);
+	if (IS_ERR(clk)) {
+		pr_err("sp804: %s clock not found: %ld\n", name, PTR_ERR(clk));
+		return PTR_ERR(clk);
+	}
+
 	err = clk_prepare(clk);
 	if (err) {
 		pr_err("sp804: clock failed to prepare: %d\n", err);
@@ -72,16 +79,7 @@ int  __init __sp804_clocksource_and_sched_clock_init(void __iomem *base,
 {
 	long rate;
 
-	if (!clk) {
-		clk = clk_get_sys("sp804", name);
-		if (IS_ERR(clk)) {
-			pr_err("sp804: clock not found: %d\n",
-			       (int)PTR_ERR(clk));
-			return PTR_ERR(clk);
-		}
-	}
-
-	rate = sp804_get_clock_rate(clk);
+	rate = sp804_get_clock_rate(clk, name);
 	if (rate < 0)
 		return -EINVAL;
 
@@ -173,15 +171,7 @@ int __init __sp804_clockevents_init(void __iomem *base, unsigned int irq, struct
 	struct clock_event_device *evt = &sp804_clockevent;
 	long rate;
 
-	if (!clk)
-		clk = clk_get_sys("sp804", name);
-	if (IS_ERR(clk)) {
-		pr_err("sp804: %s clock not found: %d\n", name,
-			(int)PTR_ERR(clk));
-		return PTR_ERR(clk);
-	}
-
-	rate = sp804_get_clock_rate(clk);
+	rate = sp804_get_clock_rate(clk, name);
 	if (rate < 0)
 		return -EINVAL;
 
-- 
2.25.1

