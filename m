Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5297F26A4E9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 14:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgIOMSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 08:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgIOMHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 08:07:52 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECF7C061788
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 04:57:17 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id 185so3482733oie.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 04:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=23eBwkikbUdFI1VwBzcQWw7s0HgJQ31gftfd5FbE1mY=;
        b=iNQIoNnKEoXn+rmps+MpJko2fm2R+Gfq1CQxxIF7Y9fc6zHbvxkb9lPdWa1/DjWpUi
         Puk+o6VlK/AHBNBfEAMkg8Ok13oAjXf0YzFUeGsyYdkmcbCcdX5SeVY4SPNH0ajUHgpu
         X/1uIzLx+Vi+m+TXmogBlcGsE0wc0pntBjHPQ716vH8HpvKATK8J1Pt4FgXRV4kyn3Gk
         XvW0w+olHq2Vkt9AtB/cBYrqRL50IxyBUQgxekmhVaClWCJT5ouIxmqWgJAnJQx+9bAQ
         ofctiibzVKD+i5ItT3yBt0h1qfPXS76Fs9svTAS1lmfjMF05zhZdeQmWDXwt3gOJbRc/
         X2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=23eBwkikbUdFI1VwBzcQWw7s0HgJQ31gftfd5FbE1mY=;
        b=tTrcxRhsQqxcSzuDZfAxR4nJfCSwXjv3scZshTITykyrUj0ETT12sVdzieJWuitL7J
         ryacm4hMgPca4KtEauSYkRMmKRYW4Yxc7jE3VOOQrj4Bt+y+oOumnH62VmqSzJpOPuxm
         lQGdF1xBtDhQxyWGrXYv8cj49R+LlI2nmjfPsHAl5lJyB8V78DYRodLzknzgLvzYIxMs
         0WwP5zJc8ePs+i+hjBgOLK9/DFT6WRAsvw3KHf66JLlK7PivnrChmPjL0Tc/FQEt2yvj
         C1kEyI26MgE0ydIFrm9uG5VU8Uq3s9nyerrB+wSGuFZNhxhk2SXI4X42Cgi2YIysR7M7
         z99g==
X-Gm-Message-State: AOAM531I++7iYWiBkdEIoBbjfklhuEG6WmhpMJ4mbpQUDwrsKDSF6YX9
        DHkcr2fttXV8mMGeuk9G+d0=
X-Google-Smtp-Source: ABdhPJyr47554yiUF4kCGTgUdSKvJMH/nWXBoJ5WtAURSx0/mM6U9PpGXX5Za2DBQvcdb2Y1OeWi6g==
X-Received: by 2002:aca:f40a:: with SMTP id s10mr3114125oih.126.1600171036734;
        Tue, 15 Sep 2020 04:57:16 -0700 (PDT)
Received: from localhost.localdomain ([111.205.198.3])
        by smtp.gmail.com with ESMTPSA id y17sm5373055otq.68.2020.09.15.04.57.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 04:57:16 -0700 (PDT)
From:   qianjun.kernel@gmail.com
To:     tglx@linutronix.de, peterz@infradead.org, will@kernel.org,
        luto@kernel.org, linux-kernel@vger.kernel.org
Cc:     laoar.shao@gmail.com, qais.yousef@arm.com, urezki@gmail.com,
        jun qian <qianjun.kernel@gmail.com>
Subject: [PATCH V7 1/4] softirq: Use sched_clock() based timeout
Date:   Tue, 15 Sep 2020 19:56:06 +0800
Message-Id: <20200915115609.85106-2-qianjun.kernel@gmail.com>
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

Replace the jiffies based timeout with a sched_clock() based one.

Signed-off-by: jun qian <qianjun.kernel@gmail.com>
---
 kernel/softirq.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index c4201b7f..0db77ab 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -25,6 +25,7 @@
 #include <linux/smpboot.h>
 #include <linux/tick.h>
 #include <linux/irq.h>
+#include <linux/sched/clock.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/irq.h>
@@ -210,7 +211,7 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
  * we want to handle softirqs as soon as possible, but they
  * should not be able to lock up the box.
  */
-#define MAX_SOFTIRQ_TIME  msecs_to_jiffies(2)
+#define MAX_SOFTIRQ_TIME	(2 * NSEC_PER_MSEC)
 #define MAX_SOFTIRQ_RESTART 10
 
 #ifdef CONFIG_TRACE_IRQFLAGS
@@ -248,7 +249,7 @@ static inline void lockdep_softirq_end(bool in_hardirq) { }
 
 asmlinkage __visible void __softirq_entry __do_softirq(void)
 {
-	unsigned long end = jiffies + MAX_SOFTIRQ_TIME;
+	u64 start = sched_clock();
 	unsigned long old_flags = current->flags;
 	int max_restart = MAX_SOFTIRQ_RESTART;
 	struct softirq_action *h;
@@ -307,7 +308,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 
 	pending = local_softirq_pending();
 	if (pending) {
-		if (time_before(jiffies, end) && !need_resched() &&
+		if (sched_clock() - start < MAX_SOFTIRQ_TIME && !need_resched() &&
 		    --max_restart)
 			goto restart;
 
-- 
1.8.3.1

