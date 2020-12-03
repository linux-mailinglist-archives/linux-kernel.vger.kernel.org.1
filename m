Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70982CDF06
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 20:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbgLCTeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 14:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgLCTeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 14:34:04 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B01C061A4E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 11:33:24 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id c198so3790924wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 11:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6BjPT+XF2MMgDkTYn3QI7OrUlD484akxJ/zP5GMe5Qs=;
        b=mp/TyUNXM5f2s31pVneAXWSUSUHgGZWiRy1UOBZQoc+2McNmJzc/2ijgIEmaHoR63W
         p7cRWbkdHjvN0L3vGxF8iMARfTyAQAoH7R7v7FO3VhAd/meFGZ0CtP+W+a23YDZkfG08
         RfWV4HcbHFWYjvHkDayi+HnKID5O7sgZXf2ofDPITWpb36VwE4cU8MItSduKjKRkjiO1
         5aecV3Cpxd33ShLslCXgzQhixRgV8xZNKEIAgK1RFHdPk3XuCN+QLTMEUousD37Tr+BV
         sUqOdRdGuut5HbBZCpefiKVh9Mygdr9IV/m6YuzxsNxf80VnXlWEJR2qlpoMwAbFs69g
         cLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6BjPT+XF2MMgDkTYn3QI7OrUlD484akxJ/zP5GMe5Qs=;
        b=GDz0W8LUCR5zga8GjTrQ6zmty44QWfIag5nG87RHcVroww08wTxN55lNoSfGddqwKK
         m+d3c3hZEqT/NRzIqnz9Xzgs5wIA45oK9uCuKERu/+nMdltKMAkHp96pYQYOUs1DFylI
         8f4i1lBsMFbdD6bM3m0lVMy1xHAgt6ae847WKzetJbsXFQrZ3PevkIcHi35MPXFQdbdK
         cAVx9NQcUfaZlDTCU0uzG9xRY/+3FcnV6TTH8ABkDYEJEo9wmu8pYhqcTNr8WEg6cHXI
         h1flxYLL6kcPyfLv4Kh9sF11ys9UOSFYVJgzauHU+T+dsa1Pe4uKK1xUEX/w0qeC2R+0
         gSew==
X-Gm-Message-State: AOAM5301KJ54LUIm74+Tlsu3WWQkjaWOcNP4CPJlVuZS9I//hZQqE3/c
        2JWn+EMOyOMv9GYI2i6pg9L5QBqczQVN4Q==
X-Google-Smtp-Source: ABdhPJxZr7SpFUzB5c8ztxXjLTxMAifREwL7bKfQU7RqaI6GzKEzD+DuvO29TSs04xof2yVA+msfSg==
X-Received: by 2002:a1c:98c7:: with SMTP id a190mr395284wme.184.1607024003066;
        Thu, 03 Dec 2020 11:33:23 -0800 (PST)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:9cff:9584:adb2:6288])
        by smtp.gmail.com with ESMTPSA id o83sm382441wme.21.2020.12.03.11.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 11:33:22 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 01/13] clocksource/drivers/sp804: Add static for functions such as sp804_clockevents_init()
Date:   Thu,  3 Dec 2020 20:32:49 +0100
Message-Id: <20201203193301.2405835-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <028084fa-d29b-a1d5-7eab-17f77ef69863@linaro.org>
References: <028084fa-d29b-a1d5-7eab-17f77ef69863@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

Add static for sp804_clocksource_and_sched_clock_init() and
sp804_clockevents_init(), they are only used in timer-sp804.c now.
Otherwise, the following warning will be reported:

drivers/clocksource/timer-sp804.c:68:12: warning: no previous prototype \
for 'sp804_clocksource_and_sched_clock_init' [-Wmissing-prototypes]
drivers/clocksource/timer-sp804.c:162:12: warning: no previous prototype \
for 'sp804_clockevents_init' [-Wmissing-prototypes]

Fixes: 975434f8b24a ("clocksource/drivers/sp804: Delete the leading "__" of some functions")
Fixes: 65f4d7ddc7b6 ("clocksource/drivers/sp804: Remove unused sp804_timer_disable() and timer-sp804.h")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201021012259.2067-2-thunder.leizhen@huawei.com
---
 drivers/clocksource/timer-sp804.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index 6e8ad4a4ea3c..db5330cc49bc 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -117,10 +117,10 @@ static u64 notrace sp804_read(void)
 	return ~readl_relaxed(sched_clkevt->value);
 }
 
-int __init sp804_clocksource_and_sched_clock_init(void __iomem *base,
-						  const char *name,
-						  struct clk *clk,
-						  int use_sched_clock)
+static int __init sp804_clocksource_and_sched_clock_init(void __iomem *base,
+							 const char *name,
+							 struct clk *clk,
+							 int use_sched_clock)
 {
 	long rate;
 	struct sp804_clkevt *clkevt;
@@ -216,8 +216,8 @@ static struct clock_event_device sp804_clockevent = {
 	.rating			= 300,
 };
 
-int __init sp804_clockevents_init(void __iomem *base, unsigned int irq,
-				  struct clk *clk, const char *name)
+static int __init sp804_clockevents_init(void __iomem *base, unsigned int irq,
+					 struct clk *clk, const char *name)
 {
 	struct clock_event_device *evt = &sp804_clockevent;
 	long rate;
-- 
2.25.1

