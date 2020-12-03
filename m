Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB952CDF08
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 20:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgLCTeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 14:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgLCTeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 14:34:08 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647B8C061A52
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 11:33:28 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id 64so3046556wra.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 11:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VOKE+KVJIeSgN4flWLaC/VFJKVXLEy1PnDfPtaFP67o=;
        b=yemBHukJZGu8iPekh9NkpfGSKK8WJ0ryi9ifqz9SJFuUvWEm0cN8rIXN/8UzRoBhnf
         IiEVVSXN1sKZAt2U3c5TLs4uNvnT7SIdwmhL/L6/XPM2lQfIhcakciftwp9vOHRnj3EE
         QyifwCFrhy4XES7HjnjJ6BS0/hYZpoqPvafof9gOQPP0QS5bCmPU0a/ZklHScLliC9Iz
         y1M9Nk6zcznUJ85HP2vOtPXcHqdUXadl2Rp3nQEkVHRXoomZ+1Pz/yPuvBAxpU8JrKuq
         Ef1FbfLrln5koruK+rJU68AsvijWLe0ozBAzhvFji4uoZ8yWzWko2aw9CJVGbcMrXn17
         oeZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VOKE+KVJIeSgN4flWLaC/VFJKVXLEy1PnDfPtaFP67o=;
        b=oCqAOctv+2czqACvSNKRIrDC0BZOcl3uBCR1wH6Cu2KjzyDcTZYdPxkO1Df2rZihe6
         OCw2yEtd7BAv7+OTMz5y9uAzleLaMANNUYdeMTcJNjWztqvapqYOGh3j9huVZr3n0GYJ
         0nmhGpc3tz4aFL3BGVW9xmxy/B9+ki4khFuVCB2myw8GS2Vu759Y0b2aNRnb+VeFO7lJ
         Qz1GuWvcTMgjeh6LiJ41xOwJ9ufQ1glhyd3X/FiCfLJDB/OWyQGp1D5RW3Xl0AMgjP4q
         9QkctVBJPVr43ucRvHA06gOXxQNRp23Pb4DcwCiPL1V1e7bBAmoDb+irlIhggv0UcbAz
         5G/g==
X-Gm-Message-State: AOAM531pxdM08rjSvIGAERAeDgtsagxfCm9pyKKDX9uSUXvDSrLZEGiE
        A4eKK6U17L34XcS+kE/AZepxQl4gohfw1w==
X-Google-Smtp-Source: ABdhPJxNvPe4zeFdAes/bgXJABlCeu4dtByJAzuPFwfi08oyPqODjszOE+/yArjzA1/CXAWm5jN9HA==
X-Received: by 2002:adf:e6cf:: with SMTP id y15mr789339wrm.403.1607024006544;
        Thu, 03 Dec 2020 11:33:26 -0800 (PST)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:9cff:9584:adb2:6288])
        by smtp.gmail.com with ESMTPSA id o83sm382441wme.21.2020.12.03.11.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 11:33:25 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 04/13] clocksource/drivers/sp804: Correct clk_get_rate handle
Date:   Thu,  3 Dec 2020 20:32:52 +0100
Message-Id: <20201203193301.2405835-4-daniel.lezcano@linaro.org>
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

clk_get_rate won't return negative value, correct clk_get_rate handle.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201029123317.90286-4-wangkefeng.wang@huawei.com
---
 drivers/clocksource/timer-sp804.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index d74788b47802..fcce839670cb 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -58,7 +58,6 @@ static struct sp804_clkevt sp804_clkevt[NR_TIMERS];
 
 static long __init sp804_get_clock_rate(struct clk *clk, const char *name)
 {
-	long rate;
 	int err;
 
 	if (!clk)
@@ -75,14 +74,7 @@ static long __init sp804_get_clock_rate(struct clk *clk, const char *name)
 		return err;
 	}
 
-	rate = clk_get_rate(clk);
-	if (rate < 0) {
-		pr_err("sp804: clock failed to get rate: %ld\n", rate);
-		clk_disable_unprepare(clk);
-		clk_put(clk);
-	}
-
-	return rate;
+	return clk_get_rate(clk);
 }
 
 static struct sp804_clkevt * __init sp804_clkevt_get(void __iomem *base)
-- 
2.25.1

