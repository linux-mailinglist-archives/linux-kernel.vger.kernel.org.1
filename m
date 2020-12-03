Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E952CDF10
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 20:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389431AbgLCTex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 14:34:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389419AbgLCTex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 14:34:53 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAB7C061A56
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 11:33:33 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id 64so3046764wra.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 11:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SzGjKr69x3cbmbmHwPD8KFyOYIoKwbz8Lzre9kZtenc=;
        b=q+YQUDN5EsT5ijg6Gn4MTOJIa27h3A4V0Iuf0pwzn4zK/3DKs/Vr2JKsXa9IAI+Bfo
         ZaDuYt2OnQVKBaTnCJ9Lc3jNuEj7ft8EzkCug/dKMs+pZCidZSRd4r2M701ZdZ9KuozB
         fxw7UHsj4K3TlysuEHemgmqY9VcNG0ITK5DOuN9bLmur7a2J/ne3j9PHxgTcSdeQcEUo
         Sb6n8nIeLCcLEnatokbEI/SNlAzUySjB36LHBO7lp6XmeO/qa5bk7mhg98CAWJ0NcqSj
         pUC80+eXMy/55PvyjtSWejmLGsMh7p+4mYfGUGfKt1Lp0eO8NStkmtZRRSJmlwWNUW1V
         wQxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SzGjKr69x3cbmbmHwPD8KFyOYIoKwbz8Lzre9kZtenc=;
        b=qPqsruO8hJLYBW7V2SpHbiGxr1alWhRHdXlVSblQe2tFUcBOycXewwlQlgEzV0wrvD
         NkaEf6kxWR78fbdn93oML4VPyRJog2NGjsPrcPebtcrVpJhshnwYrZVS0AHOf0OBHDdv
         CBNYZiP6tw8g6pgkEXJSzyVW5kGF9FcHQ8A4qBLKigRl6Aak22VzV0U3ZTeQodBLFZzZ
         29IyWZfVKMaSUtNm9EA6N0sE7q8uHanFaX2LwUpXeNabepDC8nNLmh2QlOm2KUg8unwj
         rI6rXBkDjDoOJCf9uwmkhznpAVLth6sC7WHwhN2+vPPx6ooyVF3dhO/96FnHOhJDwR8C
         E12A==
X-Gm-Message-State: AOAM530osvnANjUOZk2ZAiyrHtEAclzQCURLgrFTO/35E5JZznZdDaiP
        E219czofJ1ZXkQTgZKHDGDW27A==
X-Google-Smtp-Source: ABdhPJzm1NDO3CD9d7wsv1Jupx0kfgpERHxkHu18osMimg4p7XSQCDI7o5LsfGwKfY7gewO4vdd/Og==
X-Received: by 2002:a5d:44c1:: with SMTP id z1mr774607wrr.375.1607024011776;
        Thu, 03 Dec 2020 11:33:31 -0800 (PST)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:9cff:9584:adb2:6288])
        by smtp.gmail.com with ESMTPSA id o83sm382441wme.21.2020.12.03.11.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 11:33:31 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 08/13] clocksource/drivers/orion: Add missing clk_disable_unprepare() on error path
Date:   Thu,  3 Dec 2020 20:32:56 +0100
Message-Id: <20201203193301.2405835-8-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201203193301.2405835-1-daniel.lezcano@linaro.org>
References: <028084fa-d29b-a1d5-7eab-17f77ef69863@linaro.org>
 <20201203193301.2405835-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yingliang <yangyingliang@huawei.com>

After calling clk_prepare_enable(), clk_disable_unprepare() need
be called on error path.

Fixes: fbe4b3566ddc ("clocksource/drivers/orion: Convert init function...")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201111064706.3397156-1-yangyingliang@huawei.com
---
 drivers/clocksource/timer-orion.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-orion.c b/drivers/clocksource/timer-orion.c
index d01ff4181867..5101e834d78f 100644
--- a/drivers/clocksource/timer-orion.c
+++ b/drivers/clocksource/timer-orion.c
@@ -143,7 +143,8 @@ static int __init orion_timer_init(struct device_node *np)
 	irq = irq_of_parse_and_map(np, 1);
 	if (irq <= 0) {
 		pr_err("%pOFn: unable to parse timer1 irq\n", np);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out_unprep_clk;
 	}
 
 	rate = clk_get_rate(clk);
@@ -160,7 +161,7 @@ static int __init orion_timer_init(struct device_node *np)
 				    clocksource_mmio_readl_down);
 	if (ret) {
 		pr_err("Failed to initialize mmio timer\n");
-		return ret;
+		goto out_unprep_clk;
 	}
 
 	sched_clock_register(orion_read_sched_clock, 32, rate);
@@ -170,7 +171,7 @@ static int __init orion_timer_init(struct device_node *np)
 			  "orion_event", NULL);
 	if (ret) {
 		pr_err("%pOFn: unable to setup irq\n", np);
-		return ret;
+		goto out_unprep_clk;
 	}
 
 	ticks_per_jiffy = (clk_get_rate(clk) + HZ/2) / HZ;
@@ -183,5 +184,9 @@ static int __init orion_timer_init(struct device_node *np)
 	orion_delay_timer_init(rate);
 
 	return 0;
+
+out_unprep_clk:
+	clk_disable_unprepare(clk);
+	return ret;
 }
 TIMER_OF_DECLARE(orion_timer, "marvell,orion-timer", orion_timer_init);
-- 
2.25.1

