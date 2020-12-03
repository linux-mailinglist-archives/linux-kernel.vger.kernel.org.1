Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A69AA2CDF13
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 20:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389457AbgLCTe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 14:34:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389442AbgLCTez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 14:34:55 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB79C08E85F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 11:33:36 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id e25so5082158wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 11:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CXqV0SjTyUP4R5IJlq5r/mXQ9BBHRmx1IHhNCQ/CFAU=;
        b=hBEym01BFqVO+YkZ+qIizPVR5ib8ccGXx1jmlun63bbqAo4uJddgjqdVj7ZTwaYDJ0
         81prHVRSLpgBij8T/mTth8LRATLm3lWsFoFMokhsnJQz5qft90ACzOgm8S9O6x729vGw
         gzXtAHgIYPQntZ3fx4oqMIRAxusIbxnglbw2SaHQ1ML4GzElJNZuAIUZtISmc/R1sveC
         zUXAkrNMn+T7zCXmsDs0fQiWjOvjMZjYo1brq5rcoa/JiHNncgr6rOpyFcsltIHtCk5M
         QmOICmN2lY9mKmzcRD5Un6ceeGRO1WYyckch793EZYP2tP+4JiBMU0yNixv9S3OfcjkP
         nPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CXqV0SjTyUP4R5IJlq5r/mXQ9BBHRmx1IHhNCQ/CFAU=;
        b=TQLQ06SYw5mqfamOo/cGaeFNOZ8CgoQwKFFPLhzo1t0ICh2SGBc9aXsNvJ7G7dc7ro
         8/4MI91evlBfYcuOfnLGFNE0D6OEivvTIynMmcJirhPKP7PqwQT5E4/5X1LfmCTo4wPY
         gPDm2xdw/6aBIar0Cjk9UnptoBHe7wXHvNEWv2LDZ/NvPLeTDYD/Fsb7DmnGvqCsVy0W
         d2rrY6rLUvamghGPrQ+YpdciQwLAr9OehxdpFpeH9qq5V21gqTglOH+PQLqYZzLBbI0J
         7cAuwzLY2hmOIyyBkZwcuMca8ftKBhJ6zeX70n/HDqs4HTyygA9kBKJIPHAkp6eb/krT
         Z0vQ==
X-Gm-Message-State: AOAM530wU4hl3/dUSZ7GU9z9so+wlgrXSYfr1Ail4Y73C2ugEL4beATS
        KOeSOdQtE57EgUwF1buw4E8e7mqxlKD9PA==
X-Google-Smtp-Source: ABdhPJw5Uza+qmZnCP8wEyGmexcPXwakKiLMllltRlmQ1M/AQ2UwWuiLPKX3VT6UluTyOxCMrSkqvg==
X-Received: by 2002:a1c:7201:: with SMTP id n1mr356982wmc.139.1607024015465;
        Thu, 03 Dec 2020 11:33:35 -0800 (PST)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:9cff:9584:adb2:6288])
        by smtp.gmail.com with ESMTPSA id o83sm382441wme.21.2020.12.03.11.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 11:33:34 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 11/13] clocksource/drivers/cadence_ttc: Fix memory leak in ttc_setup_clockevent()
Date:   Thu,  3 Dec 2020 20:32:59 +0100
Message-Id: <20201203193301.2405835-11-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201203193301.2405835-1-daniel.lezcano@linaro.org>
References: <028084fa-d29b-a1d5-7eab-17f77ef69863@linaro.org>
 <20201203193301.2405835-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

If clk_notifier_register() failed, ttc_setup_clockevent() will return
without freeing 'ttcce', which will leak memory.

Fixes: 70504f311d4b ("clocksource/drivers/cadence_ttc: Convert init function to return error")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201116135123.2164033-1-yukuai3@huawei.com
---
 drivers/clocksource/timer-cadence-ttc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/clocksource/timer-cadence-ttc.c b/drivers/clocksource/timer-cadence-ttc.c
index 80e960602030..4efd0cf3b602 100644
--- a/drivers/clocksource/timer-cadence-ttc.c
+++ b/drivers/clocksource/timer-cadence-ttc.c
@@ -413,10 +413,8 @@ static int __init ttc_setup_clockevent(struct clk *clk,
 	ttcce->ttc.clk = clk;
 
 	err = clk_prepare_enable(ttcce->ttc.clk);
-	if (err) {
-		kfree(ttcce);
-		return err;
-	}
+	if (err)
+		goto out_kfree;
 
 	ttcce->ttc.clk_rate_change_nb.notifier_call =
 		ttc_rate_change_clockevent_cb;
@@ -426,7 +424,7 @@ static int __init ttc_setup_clockevent(struct clk *clk,
 				    &ttcce->ttc.clk_rate_change_nb);
 	if (err) {
 		pr_warn("Unable to register clock notifier.\n");
-		return err;
+		goto out_kfree;
 	}
 
 	ttcce->ttc.freq = clk_get_rate(ttcce->ttc.clk);
@@ -455,15 +453,17 @@ static int __init ttc_setup_clockevent(struct clk *clk,
 
 	err = request_irq(irq, ttc_clock_event_interrupt,
 			  IRQF_TIMER, ttcce->ce.name, ttcce);
-	if (err) {
-		kfree(ttcce);
-		return err;
-	}
+	if (err)
+		goto out_kfree;
 
 	clockevents_config_and_register(&ttcce->ce,
 			ttcce->ttc.freq / PRESCALE, 1, 0xfffe);
 
 	return 0;
+
+out_kfree:
+	kfree(ttcce);
+	return err;
 }
 
 static int __init ttc_timer_probe(struct platform_device *pdev)
-- 
2.25.1

