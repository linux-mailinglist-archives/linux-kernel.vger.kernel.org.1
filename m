Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D48295822
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 07:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508096AbgJVF4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 01:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2508003AbgJVF4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 01:56:37 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69F0C0613CE;
        Wed, 21 Oct 2020 22:56:35 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id f19so449863pfj.11;
        Wed, 21 Oct 2020 22:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wThrM8h2ApOjEkr7FfmhsHm+L4zSycsLz0aEaPWJl3E=;
        b=QTedpY4QHm+1tpu1rup0tKENC0oPbFjuMsk867jWfnkQ/S/n6ugBtlG/zEQXvIRuk2
         3V4d2FULoO3JR7nNEbeKDgOVt5D7bKbt0KuCKTox3xA/He4B9F8y1fXmw5Ep9ncm3zvi
         UjjT0/Cju4YSB+9hJVeN6dAU1CZGbMtHTG+2BEBhrJ6gFhpFF4fPgM237c+JkRX8od7U
         1nmzW3EXcM7vR6GG/+jdNeY4I9K0q74uhnlbwwWU+v/1aNMx2y+Ya2bsVnCYRKh0mgcR
         Jc5o2JYh0rwUDEEUD0uWwG7CaTlAVqIEKDVrIEyf3rnrSl4+F3fWgcO0NvF05MFLwapU
         0TPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wThrM8h2ApOjEkr7FfmhsHm+L4zSycsLz0aEaPWJl3E=;
        b=pg4zFShjTam00oItmS0YyOcQwrWeXIP6lfNVBwON58fug/4AtO1f36MUVOiJ8cqt1S
         6Gn1PZ0cncegdTJ6YXGbUUOQ72cCyuuW/IDQ364Mj5zIdccO86SN+mQjYFvmSjOBTWMh
         nvhwiHLY4Q8S75TETkB2KTkKE+lTh/ecSd8qf3MTnWwZkTnpkl5Ima5wcHY5D92ZxPyL
         d/rD35jObj4xkVSU8HsBW+fHBuYpfU/mS+RCdH3EgcPuv+Ww0SwSdL/bbyuBAWFy2I92
         7v+8sGM3cnX+92gUpRklsVdRnO9qCHq3nqht7qLDUk3YDd1X0mXhx55GNLdNXW1v0YiR
         uK0Q==
X-Gm-Message-State: AOAM5322z/epwMgHXikyMYeUkFChehyt/qpH4yFUyZjoBj/8GXHBLOPm
        yaUVME8be0b/xmva2C/3W3leakU0qQ==
X-Google-Smtp-Source: ABdhPJwXWu7ajBd8ki19OwcgrjJbXgs7+9gTwJjC7LMOsE33l/guyDiFC4lPzEeV8A/XoKaPsubEXw==
X-Received: by 2002:a63:cb51:: with SMTP id m17mr926687pgi.337.1603346195346;
        Wed, 21 Oct 2020 22:56:35 -0700 (PDT)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c12sm830995pgi.14.2020.10.21.22.56.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Oct 2020 22:56:34 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Petr Mladek <pmladek@suse.com>, Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        afzal mohammed <afzal.mohd.ma@gmail.com>,
        Lina Iyer <ilina@codeaurora.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Maulik Shah <mkshah@codeaurora.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Oliver Neukum <oneukum@suse.com>, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org
Subject: [PATCH 1/3] kernel/watchdog: show irq percentage if irq floods
Date:   Thu, 22 Oct 2020 13:56:01 +0800
Message-Id: <1603346163-21645-2-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1603346163-21645-1-git-send-email-kernelfans@gmail.com>
References: <1603346163-21645-1-git-send-email-kernelfans@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In kdump case, the capture kernel has no chance to shutdown devices, and
leave the devices in unstable state. Irq flood is one of the consequence.

When irq floods, the kernel is totally occupies by irq.  Currently, there
may be nothing or just soft lockup warning showed in console. It is better
to warn users with irq flood info.

Soft lockup watchdog is a good foundation to implement the detector. A irq
flood is reported if the following two conditions are met:
  -1. the irq occupies too much (98%) of the past interval.
  -2. no tasks has been scheduled in the past interval. This is implemented
      by check_hint.
      A note: is_softlockup() implies the 2nd condition, but unfortunately, irq
      flood can come from anywhere. If irq_enter_rcu()->tick_irq_enter(), then
      touch_softlockup_watchdog_sched() will reset watchdog, and softlockup is
      never detected.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: afzal mohammed <afzal.mohd.ma@gmail.com>
Cc: Lina Iyer <ilina@codeaurora.org>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Maulik Shah <mkshah@codeaurora.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Oliver Neukum <oneukum@suse.com>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: kexec@lists.infradead.org
---
 kernel/watchdog.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 5abb5b2..230ac38 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -23,6 +23,7 @@
 #include <linux/sched/debug.h>
 #include <linux/sched/isolation.h>
 #include <linux/stop_machine.h>
+#include <linux/kernel_stat.h>
 
 #include <asm/irq_regs.h>
 #include <linux/kvm_para.h>
@@ -175,6 +176,13 @@ static DEFINE_PER_CPU(bool, softlockup_touch_sync);
 static DEFINE_PER_CPU(bool, soft_watchdog_warn);
 static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts);
 static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts_saved);
+
+#ifdef CONFIG_IRQ_TIME_ACCOUNTING
+static DEFINE_PER_CPU(long, check_hint) = {-1};
+static DEFINE_PER_CPU(unsigned long, last_irq_ts);
+static DEFINE_PER_CPU(unsigned long, last_total_ts);
+#endif
+
 static unsigned long soft_lockup_nmi_warn;
 
 static int __init nowatchdog_setup(char *str)
@@ -331,12 +339,43 @@ static DEFINE_PER_CPU(struct cpu_stop_work, softlockup_stop_work);
  */
 static int softlockup_fn(void *data)
 {
+#ifdef CONFIG_IRQ_TIME_ACCOUNTING
+	__this_cpu_write(check_hint, -1);
+#endif
 	__touch_watchdog();
 	complete(this_cpu_ptr(&softlockup_completion));
 
 	return 0;
 }
 
+#ifdef CONFIG_IRQ_TIME_ACCOUNTING
+static void check_irq_flood(void)
+{
+	unsigned long irqts, totalts, percent, cnt;
+	u64 *cpustat = kcpustat_this_cpu->cpustat;
+
+	totalts = running_clock();
+	irqts = cpustat[CPUTIME_IRQ] + cpustat[CPUTIME_SOFTIRQ];
+	cnt = __this_cpu_inc_return(check_hint);
+
+	if (cnt >= 5) {
+		totalts = totalts - __this_cpu_read(last_total_ts);
+		irqts = irqts - __this_cpu_read(last_irq_ts);
+		percent = irqts * 100 / totalts;
+		percent =  percent < 100 ? percent : 100;
+		__this_cpu_write(check_hint, -1);
+		if (percent >= 98)
+			pr_info("Irq flood occupies more than %lu%% of the past %lu seconds\n",
+				percent, totalts >> 30);
+	} else if (cnt == 0) {
+		__this_cpu_write(last_total_ts, totalts);
+		__this_cpu_write(last_irq_ts, irqts);
+	}
+}
+#else
+static void check_irq_flood(void){}
+#endif
+
 /* watchdog kicker functions */
 static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 {
@@ -348,6 +387,8 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 	if (!watchdog_enabled)
 		return HRTIMER_NORESTART;
 
+	/* When irq floods, watchdog may be still touched. Hence it can not be done inside lockup */
+	check_irq_flood();
 	/* kick the hardlockup detector */
 	watchdog_interrupt_count();
 
-- 
2.7.5

