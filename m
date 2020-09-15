Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A53CA26A4BD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 14:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgIOMLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 08:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbgIOMHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 08:07:52 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95CFC06178A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 04:57:23 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id m7so3568612oie.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 04:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XWJcALMulkY2scgiLx1eh1BlMZ8zvKkVNyyrMlEuxkA=;
        b=KqvAiv1OzpV7sIoXOraYlTo84JT1sXNCqx/un0KU7q+L7AvkVj/kuENrVmW7X3pt7C
         +5LsooTQxzTOMJH8/K3tp6yiVkdY7o361SvFjc74pznANlP6J1hfdjXfkIkc8dDV4Op5
         8ubN/RAYwVwPtQj3erfkD9b/r4t6+LujAYNz4zaVB2X0LFEGiSW0Y6tmq2A4V1PFCHFq
         QuRWXVPpRw9dXR0lBm0b+NhfnYAK/1K9wui72CYdnu+WoShqFNf0hK+zQ87VC0Zxu0/I
         9ZLMzJWtSka5lhgChOwocLaE7AisFSWXLt7O+X+C+YKsvtxdjBHm7pWfLLy1omtbgakL
         000Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XWJcALMulkY2scgiLx1eh1BlMZ8zvKkVNyyrMlEuxkA=;
        b=Fx0iEFfMkez5XSbVBnJEvfimGw8M4hK73IIQyICoK39SfaDlzt9Ph0OWP6+hsluWFJ
         5Vv2lGq5HecQxcxmckYX1p7zRMfhe5e2/L08wyBwJNTvcboD5wBOcf1dJkJmJjtpXkf7
         vOXNDPutev1/1eeISLfjXoMuGBpq/uZ4BV0ivc6eXrZBQPTRR92TSczre1XXSAUUiW7f
         iqubuXfHhLBmTZYcHcBBkax8lQK/l2WyJ2De4uzKmUA6G8wzwZ/tdhrrqGpBSN+8soQK
         aw2QJRJG3lJ5Zu+TIjGRKhqwrAKByc36SwunqhXTwT2AIu5lvGcpPETU5lAxq5JF19XX
         LhMA==
X-Gm-Message-State: AOAM533cxf/3hWXoljCBdN/JJ1/mxSiZMtn4fdQxbpvumOe7pZQFfG5D
        7LzfIQryl/vSxf35Wi8hyS8=
X-Google-Smtp-Source: ABdhPJyg7EJWQF6N5wqWeJ2DpYACbeRocGMQwkcdmpJe02BNkc/WxRAMMRpCPMWKLyW8kNCvMpwGfQ==
X-Received: by 2002:a05:6808:98f:: with SMTP id a15mr3217366oic.58.1600171043185;
        Tue, 15 Sep 2020 04:57:23 -0700 (PDT)
Received: from localhost.localdomain ([111.205.198.3])
        by smtp.gmail.com with ESMTPSA id y17sm5373055otq.68.2020.09.15.04.57.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 04:57:22 -0700 (PDT)
From:   qianjun.kernel@gmail.com
To:     tglx@linutronix.de, peterz@infradead.org, will@kernel.org,
        luto@kernel.org, linux-kernel@vger.kernel.org
Cc:     laoar.shao@gmail.com, qais.yousef@arm.com, urezki@gmail.com,
        jun qian <qianjun.kernel@gmail.com>
Subject: [PATCH V7 2/4] softirq: Factor loop termination condition
Date:   Tue, 15 Sep 2020 19:56:07 +0800
Message-Id: <20200915115609.85106-3-qianjun.kernel@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20200915115609.85106-1-qianjun.kernel@gmail.com>
References: <20200915115609.85106-1-qianjun.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: jun qian <qianjun.kernel@gmail.com>

Add a function interface to end softirq process

Signed-off-by: jun qian <qianjun.kernel@gmail.com>
---
 kernel/softirq.c | 44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 0db77ab..5a627cd 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -198,22 +198,6 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 }
 EXPORT_SYMBOL(__local_bh_enable_ip);
 
-/*
- * We restart softirq processing for at most MAX_SOFTIRQ_RESTART times,
- * but break the loop if need_resched() is set or after 2 ms.
- * The MAX_SOFTIRQ_TIME provides a nice upper bound in most cases, but in
- * certain cases, such as stop_machine(), jiffies may cease to
- * increment and so we need the MAX_SOFTIRQ_RESTART limit as
- * well to make sure we eventually return from this method.
- *
- * These limits have been established via experimentation.
- * The two things to balance is latency against fairness -
- * we want to handle softirqs as soon as possible, but they
- * should not be able to lock up the box.
- */
-#define MAX_SOFTIRQ_TIME	(2 * NSEC_PER_MSEC)
-#define MAX_SOFTIRQ_RESTART 10
-
 #ifdef CONFIG_TRACE_IRQFLAGS
 /*
  * When we run softirqs from irq_exit() and thus on the hardirq stack we need
@@ -247,11 +231,34 @@ static inline void lockdep_softirq_end(bool in_hardirq)
 static inline void lockdep_softirq_end(bool in_hardirq) { }
 #endif
 
+/*
+ * We restart softirq processing but break the loop if need_resched() is
+ * set or after 2 ms. The MAX_SOFTIRQ_RESTART guarantees a loop termination
+ * if sched_clock() were ever to stall.
+ *
+ * These limits have been established via experimentation.  The two things
+ * to balance is latency against fairness - we want to handle softirqs as
+ * soon as possible, but they should not be able to lock up the box.
+ */
+#define MAX_SOFTIRQ_TIME	(2 * NSEC_PER_MSEC)
+#define MAX_SOFTIRQ_RESTART    10
+
+static inline bool __softirq_needs_break(u64 start)
+{
+	if (need_resched())
+		return true;
+
+	if (sched_clock() - start >= MAX_SOFTIRQ_TIME)
+		return true;
+
+	return false;
+}
+
 asmlinkage __visible void __softirq_entry __do_softirq(void)
 {
 	u64 start = sched_clock();
 	unsigned long old_flags = current->flags;
-	int max_restart = MAX_SOFTIRQ_RESTART;
+	unsigned int max_restart = MAX_SOFTIRQ_RESTART;
 	struct softirq_action *h;
 	bool in_hardirq;
 	__u32 pending;
@@ -308,8 +315,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 
 	pending = local_softirq_pending();
 	if (pending) {
-		if (sched_clock() - start < MAX_SOFTIRQ_TIME && !need_resched() &&
-		    --max_restart)
+		if (!__softirq_needs_break(start) && --max_restart)
 			goto restart;
 
 		wakeup_softirqd();
-- 
1.8.3.1

