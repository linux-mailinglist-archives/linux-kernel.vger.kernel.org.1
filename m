Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8322B74E2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 04:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbgKRDgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 22:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbgKRDgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 22:36:50 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9A7C0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 19:36:50 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id 18so229186pli.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 19:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e9Ihw2Y+18TzSgtmb4OigPm+7MU3ujpbKP16lGjOfj8=;
        b=OhY4HjIOZ+0lTiFOatEbWyzN+3hQo+8XRSkU9MfUqJXie9mhDQVnUe+NuzmVwn2UV2
         +IwoEflE28VZx2lSwsNtvFar4eHNheGRp58rAl8LZioo6mtVsE1YER68qK58WgYSmxWO
         Ra9CVB0z5A0o3gogZuiyAfOIpnPXCoYsBWtmfAJr4XZc43DWR/4Vaaww5khyVzrtQFdU
         vA3lmszaquZnMjv3cZLcvO8SCfJbV1bji+Rr4/0P46u4WFve0N7nuzoJE/5lia4tiygf
         24/HhQbqKdggfuE4fXB2QCDHXmtURaqCuHZPrO8oNK4tI2nkRY2QP+dgiiGfii67ZWfr
         x56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e9Ihw2Y+18TzSgtmb4OigPm+7MU3ujpbKP16lGjOfj8=;
        b=KAaC1dlzJi/VoaRt/GCXmky081yB4g/thrkfw4avQ5aOoxVNXi0tonltQiS1jv1yrn
         L/uGbfUNfOMGjLOz3ENCOoBiF0pLnUDL41L1MbrRYvA9OX4kBBTWbTl1uXufdKFpUS99
         23tqUZZoPXC4p/gQDouV13T7BZdlLaZr6ifOnu/PV6utlwAcSwslXO3tKvz6vmlwkpMb
         QrpgXWmejBbKcy/G+q9OaOSWVrsVcp1F0JlGivmARk41vFrU9DfL55XGG6lCfdQmJfDU
         dIcPT+WIYvhV9RzAdWyJZLgawVAkW8KYbbaRVd0JxAM7uxzermO/t0KkiAh/FKRc99Zn
         rF+g==
X-Gm-Message-State: AOAM532YFTWC1KQyANIzLvaXWdCLbpwArERwYlFwOhhXXP3TX5q/2uzz
        M4fK+RwNd1uUxLKB9/BPxTDG1WxcDg==
X-Google-Smtp-Source: ABdhPJymDMEi5GYeLqbLmW7LlSMQERi8xY2hau+mlS5vC+sfpAYnpiGOFtR9uhbQXJ1FDbgR/cYIbA==
X-Received: by 2002:a17:90a:df93:: with SMTP id p19mr2310006pjv.170.1605670610183;
        Tue, 17 Nov 2020 19:36:50 -0800 (PST)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s21sm8915450pgm.65.2020.11.17.19.36.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Nov 2020 19:36:49 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Petr Mladek <pmladek@suse.com>, kexec@lists.infradead.org
Subject: [PATCH 2/3] kernel/watchdog: make watchdog_touch_ts more accurate by using nanosecond
Date:   Wed, 18 Nov 2020 11:36:17 +0800
Message-Id: <1605670578-23681-3-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1605670578-23681-1-git-send-email-kernelfans@gmail.com>
References: <87tuueftou.fsf@nanos.tec.linutronix.de>
 <1605670578-23681-1-git-send-email-kernelfans@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The incoming statistics of irq average number will base on the delta of
watchdog_touch_ts. Improving the accuracy of watchdog_touch_ts from second
to nanosecond can help improve the accuracy of the statistics.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: kexec@lists.infradead.org
To: linux-kernel@vger.kernel.org
---
 kernel/watchdog.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 5abb5b2..1cc619a 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -207,7 +207,7 @@ static void __lockup_detector_cleanup(void);
  * the thresholds with a factor: we make the soft threshold twice the amount of
  * time the hard threshold is.
  */
-static int get_softlockup_thresh(void)
+static unsigned int get_softlockup_thresh(void)
 {
 	return watchdog_thresh * 2;
 }
@@ -217,9 +217,9 @@ static int get_softlockup_thresh(void)
  * resolution, and we don't need to waste time with a big divide when
  * 2^30ns == 1.074s.
  */
-static unsigned long get_timestamp(void)
+static unsigned long convert_seconds(unsigned long ns)
 {
-	return running_clock() >> 30LL;  /* 2^30 ~= 10^9 */
+	return ns >> 30LL;  /* 2^30 ~= 10^9 */
 }
 
 static void set_sample_period(void)
@@ -238,7 +238,7 @@ static void set_sample_period(void)
 /* Commands for resetting the watchdog */
 static void __touch_watchdog(void)
 {
-	__this_cpu_write(watchdog_touch_ts, get_timestamp());
+	__this_cpu_write(watchdog_touch_ts, running_clock());
 }
 
 /**
@@ -289,14 +289,15 @@ void touch_softlockup_watchdog_sync(void)
 	__this_cpu_write(watchdog_touch_ts, SOFTLOCKUP_RESET);
 }
 
-static int is_softlockup(unsigned long touch_ts)
+static unsigned long is_softlockup(unsigned long touch_ts)
 {
-	unsigned long now = get_timestamp();
+	unsigned long span, now = running_clock();
 
+	span = now - touch_ts;
 	if ((watchdog_enabled & SOFT_WATCHDOG_ENABLED) && watchdog_thresh){
 		/* Warn about unreasonable delays. */
-		if (time_after(now, touch_ts + get_softlockup_thresh()))
-			return now - touch_ts;
+		if (time_after(convert_seconds(span), (unsigned long)get_softlockup_thresh()))
+			return span;
 	}
 	return 0;
 }
@@ -340,9 +341,8 @@ static int softlockup_fn(void *data)
 /* watchdog kicker functions */
 static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 {
-	unsigned long touch_ts = __this_cpu_read(watchdog_touch_ts);
+	unsigned long duration, touch_ts = __this_cpu_read(watchdog_touch_ts);
 	struct pt_regs *regs = get_irq_regs();
-	int duration;
 	int softlockup_all_cpu_backtrace = sysctl_softlockup_all_cpu_backtrace;
 
 	if (!watchdog_enabled)
@@ -410,7 +410,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 		}
 
 		pr_emerg("BUG: soft lockup - CPU#%d stuck for %us! [%s:%d]\n",
-			smp_processor_id(), duration,
+			smp_processor_id(), (unsigned int)convert_seconds(duration),
 			current->comm, task_pid_nr(current));
 		print_modules();
 		print_irqtrace_events(current);
-- 
2.7.5

