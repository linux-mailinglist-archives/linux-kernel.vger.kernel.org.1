Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B84276CC0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 11:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgIXJGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 05:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbgIXJGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 05:06:07 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1B0C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 02:06:06 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d4so2706142wmd.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 02:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=85pUMdWyxZBIFXsl3NCVxvvvXNOrbrrYiFazGtLAo3I=;
        b=CukcpWSKfzy2p5QngTf2BQhMAW+mjx5h2nbAtud08hYzz7+EQycJV0cwBqGiSPFDID
         rSU11oiiJXMSfFeb4sRXt5j57h7DnK5RkXmIuthLBAGELIdOrpoE0p+Bqlxihcc0x+di
         xIO0JdcfKeGabqBUXdQ3dzn5HGhKvyKKuSHR11eNuIxJNvjDjIH/QI4Uobep/rP66ISI
         X9idJ8ym0NMJ+cTdtOQERTZHfFg0GC11LvS6A+Gik9tac8VJ9moBikWUyyzWKpAVr+3N
         kagXOZE/p0Fb6Fz6x/MtwsZbv+Iz1f5XC8FvcRPd6zZ/vuFFLe6umCk0BZRO6aPlH/2n
         2CGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=85pUMdWyxZBIFXsl3NCVxvvvXNOrbrrYiFazGtLAo3I=;
        b=kogFQDy4eOxF5KXd/abLfpNzQIVmo4gpb6AvcL+W//oeymTDwuJvPbTAO4/iDrzs9U
         p2CBYyM1IUJWYozjARm3A2cNr0BQeioOFWUHH56oXQql5d1+IEt2LRedxFdVo/nqKLj5
         TY+EEZMmPZrtuAKkTZE46fW+XOyXvD3WLKaRHDcqXYhVICEqdWSjaa75A+oYooYW4GeV
         XmfKWNyeRo3QuL7hpV3BQ9ETI4jnWgFpnb2IeAEjsuM1b7DJql4aNsXX+LX3oacE3DWF
         1vn4N2Pl5vmi+bLmFN3fZYtpS/a3FdV8mxWQyybhL7XftNvq/5G2VoTfuNDf9G/s/BC2
         3bwA==
X-Gm-Message-State: AOAM530H6qptiT6fb9zu4N4tNzSmhhqyE0ibUKoVQcGVkoEEoZM+9tkV
        EsuqaSTiCaEla4MF3bB/QNcr8Q==
X-Google-Smtp-Source: ABdhPJxmnRINuAwOar1gO2Zkk9uFAzesWauYyvPMy0pk69Mu+2Zkwz4SX2N9zKVpZ7gGQQfpxQCn1Q==
X-Received: by 2002:a1c:e108:: with SMTP id y8mr3600173wmg.179.1600938365218;
        Thu, 24 Sep 2020 02:06:05 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:11e1:db8b:493b:54f4])
        by smtp.gmail.com with ESMTPSA id h2sm2861461wrp.69.2020.09.24.02.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 02:06:04 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org (open list:CLOCKSOURCE, CLOCKEVENT DRIVERS)
Subject: [PATCH 06/10] clocksource/drivers/sp804: Remove a mismatched comment
Date:   Thu, 24 Sep 2020 11:05:30 +0200
Message-Id: <20200924090534.2004630-6-daniel.lezcano@linaro.org>
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

writel(0, base + TIMER_CTRL);
... ...
writel(xxx | TIMER_CTRL_PERIODIC, base + TIMER_CTRL);

The timer is just temporarily disabled, and it will be set to periodic
mode later.

The description of the field TimerMode of the register TimerXControl
as shown below:
0 = Timer module is in free-running mode (default)
1 = Timer module is in periodic mode.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200918132237.3552-5-thunder.leizhen@huawei.com
---
 drivers/clocksource/timer-sp804.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index 097f5a83163c..a443f392a8e7 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -76,7 +76,6 @@ int __init sp804_clocksource_and_sched_clock_init(void __iomem *base,
 	if (rate < 0)
 		return -EINVAL;
 
-	/* setup timer 0 as free-running clocksource */
 	writel(0, base + TIMER_CTRL);
 	writel(0xffffffff, base + TIMER_LOAD);
 	writel(0xffffffff, base + TIMER_VALUE);
-- 
2.25.1

