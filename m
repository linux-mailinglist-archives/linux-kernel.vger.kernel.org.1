Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46B6127A1C5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 18:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgI0QLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 12:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgI0QLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 12:11:40 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05170C0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 09:11:40 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id u4so2059065plr.4
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 09:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yM+OQab/yJ05IjsUHpR4WMWoBOc4/cnEjX08SDyT8vo=;
        b=ap9Jjjryy11+sqGBdGyGML1N/Y6IOGt78QbA9sXHNP7OQx7rWHAcSCz/zpbXUJw2A0
         FDKJ7SLzW6VUp6Pm4n+az0AY5YTIl0BWhLh0wVrzHYiGxtakNQaWWGYjeqxUf/BY6hgi
         3jQgRuaTxPL10F4OdFfUAe7EovB1OBsXj5OkXfQlFJLUUXdQRKPQ8x2KeBLb2RWoWCYS
         2jVqw7/rD56HoO9A8tTRZ2rFqC5R+Ruz1gcHsnxLigKE2nFRd2UEPzuB7YlW4GzhDAL/
         qvKA6w7YZBIjrfiSiuk9bfqOWufFYXLeX6EWSfsSu92hbVxgu2TYCjOM8Xu1rMqUuSQ9
         clQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yM+OQab/yJ05IjsUHpR4WMWoBOc4/cnEjX08SDyT8vo=;
        b=DMlexx1+7IcSNg7jVry1Ncj9oVY+DGMENR4kfyaI87mMjIY0cIebNk2A641zqRILYX
         5ZmE0vNvFXALY76ePGJaM9hwkwSWGtZeTGiiZcqP5JlwRo0k8xrhWILZNzO2RXkcZUiS
         AE0RvWfUmH+qG4jwRcDzNLZvwSyyoaSKQODWXUjyiEW7QP0FPn9ll8CbY7MtRpdmEm1T
         Iq/ybuogo4o/y9g7crV8wQoACGWfbSkdAzxVCvJyOFhYcJFKGO25Op0jjFKM/ySsvgTo
         iAL90HI0GoSfVsSOBHGk5ewTa36C4AIv2aqHMEhJS5xq3zxQU4vwbWtXyByeJ7z2LMqA
         XmVg==
X-Gm-Message-State: AOAM531emPsAjAZbtggFHYxA45ejh3hIgdU0OlVNT/cx0Jz8I/yz6jv5
        hy9CdWbYlB+9Cwk8qqqllLILrdcFxc4LFQ==
X-Google-Smtp-Source: ABdhPJxvXg/AB2l1cBRyg5BXFpDHbTGrxiHCZDJEZYHw2I3I1v7MVbnk9Cj2X0dGQ1RxcfF5VMtmIw==
X-Received: by 2002:a17:90a:3d0e:: with SMTP id h14mr5997738pjc.34.1601223099403;
        Sun, 27 Sep 2020 09:11:39 -0700 (PDT)
Received: from localhost.localdomain ([103.136.220.70])
        by smtp.gmail.com with ESMTPSA id l141sm8784844pfd.47.2020.09.27.09.11.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Sep 2020 09:11:38 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     linux-kernel@vger.kernel.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de
Cc:     zhouchengming@bytedance.com, songmuchun@bytedance.com
Subject: [PATCH 1/2] printk: Add printk_deferred_{enter, exit}
Date:   Mon, 28 Sep 2020 00:11:29 +0800
Message-Id: <20200927161130.33172-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We use printk_deferred in scheduler code when rq lock held because calling
printk can cause deadlock. It's a nice solution but a little hard to use
when we want to mark the printk_deferred danger areas.
Currently, the use of WARN_ON or WARN_ON_ONCE in scheduler with rq lock
held can cause deadlock when warn condition met. If we can mark the
printk_deferred area when rq lock held using pintk_deferred_{enter, exit},
all console output in that area will be deferred.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: MuChun Song <songmuchun@bytedance.com>
---
 include/linux/printk.h      |  8 ++++++++
 kernel/printk/internal.h    |  3 ++-
 kernel/printk/printk_safe.c | 18 ++++++++++++++++++
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 34c1a7be3e01..96ab252f529a 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -147,6 +147,14 @@ static inline __printf(1, 2) __cold
 void early_printk(const char *s, ...) { }
 #endif
 
+#ifdef CONFIG_PRINTK
+extern void printk_deferred_enter(void);
+extern void printk_deferred_exit(void);
+#else
+static inline void printk_deferred_enter(void) { }
+static inline void printk_deferred_exit(void) { }
+#endif
+
 #ifdef CONFIG_PRINTK_NMI
 extern void printk_nmi_enter(void);
 extern void printk_nmi_exit(void);
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 660f9a6bf73a..b2ede46b7460 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -6,7 +6,8 @@
 
 #ifdef CONFIG_PRINTK
 
-#define PRINTK_SAFE_CONTEXT_MASK	0x007ffffff
+#define PRINTK_SAFE_CONTEXT_MASK	0x003ffffff
+#define PRINTK_DEFERRED_CONTEXT_MASK	0x004000000
 #define PRINTK_NMI_DIRECT_CONTEXT_MASK	0x008000000
 #define PRINTK_NMI_CONTEXT_MASK		0xff0000000
 
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index 50aeae770434..f77c6880f59f 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -335,6 +335,16 @@ static __printf(1, 0) int vprintk_nmi(const char *fmt, va_list args)
 
 #endif /* CONFIG_PRINTK_NMI */
 
+void printk_deferred_enter(void)
+{
+	__this_cpu_or(printk_context, PRINTK_DEFERRED_CONTEXT_MASK);
+}
+
+void printk_deferred_exit(void)
+{
+	__this_cpu_and(printk_context, ~PRINTK_DEFERRED_CONTEXT_MASK);
+}
+
 /*
  * Lock-less printk(), to avoid deadlocks should the printk() recurse
  * into itself. It uses a per-CPU buffer to store the message, just like
@@ -385,6 +395,14 @@ __printf(1, 0) int vprintk_func(const char *fmt, va_list args)
 	if (this_cpu_read(printk_context) & PRINTK_NMI_CONTEXT_MASK)
 		return vprintk_nmi(fmt, args);
 
+	if (this_cpu_read(printk_context) & PRINTK_DEFERRED_CONTEXT_MASK) {
+		int len;
+
+		len = vprintk_emit(0, LOGLEVEL_SCHED, NULL, 0, fmt, args);
+		defer_console_output();
+		return len;
+	}
+
 	/* Use extra buffer to prevent a recursion deadlock in safe mode. */
 	if (this_cpu_read(printk_context) & PRINTK_SAFE_CONTEXT_MASK)
 		return vprintk_safe(fmt, args);
-- 
2.11.0

