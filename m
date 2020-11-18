Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24342B74E3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 04:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbgKRDg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 22:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbgKRDgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 22:36:55 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1CDC0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 19:36:55 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id d17so248066plr.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 19:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ipuchja0k7RLXVGgFZ/wr7IGIMbQVzpz4h/X3eCukbY=;
        b=F1q7oWAVcSIn4KR7Ws3e/YISeeES31iNlxRC9a78c9t3gr5qUSf8JhozRkyoUEJwp9
         a+DxsTgRifmNZGpGnRzbriHhvGfFqvFlylPvKV6DFZIVb51a2/QF6GjsnBuPeCVyuUO0
         1m9i7VkteD7i8g/2GXGUKOgu5Ptdd839y0oOcldn1wP40ZLrTaPCBBsRKSShj16minAI
         eFyI+OSBSw3PINrFUVtmuCymIH7kVpXBIYhod285oRkKm7vAcPMqu5s8OUed8vZXS6Fv
         KY04DI4UpPocm1cmQhkGYVlYSb4F+XYy3CAujWVir5o/N7Xg8gzs5tGDiwXqsoJaAmby
         t6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ipuchja0k7RLXVGgFZ/wr7IGIMbQVzpz4h/X3eCukbY=;
        b=CpxSWo4o79ZEyc6gY8QVK3yZdrpnLIEBBxi5AhPZulHVbOPyeOG5vmzgh/N+9TxEfe
         dl3yioN4sOHpSHg6XlVrs9gd7ekPwjI456ZDSN0A4fDnssWYkRLSKVLCCNEecRVAQcCm
         jZS+ESgYU5HMdI85badN/ZdmNBkT5FLb3+g4acZlkRK2O0BTLA6pHiV3eWuVDU27ReoH
         71/3YUXLFJTJQFGCCodUm3WXmt/p5IQ4VuW55qkY8+5xqWCRcdevn2ONxqduOSpyAubp
         MTbmeEAQvBuWkD2PzQQ944T8JAgXUYN/uaStu3GlNVsWH4QepcMQmK4BSYQmQtekQmsh
         jXoA==
X-Gm-Message-State: AOAM533s2t1Ui8/e6B2j29u9ZhjAfrJaKR6lUhufgpWUMn3CSPls7OuJ
        5LUp8fv1Mo5HxwMvl6ipRU5BnvGGCQ==
X-Google-Smtp-Source: ABdhPJwebQoRnKVLi8sLlX7XT04dlPrjp9066W35IFdPHZ5tiy5S7GV9bOPFU3fbooL+c9BLEICZRg==
X-Received: by 2002:a17:90a:a393:: with SMTP id x19mr2186520pjp.68.1605670614866;
        Tue, 17 Nov 2020 19:36:54 -0800 (PST)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s21sm8915450pgm.65.2020.11.17.19.36.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Nov 2020 19:36:54 -0800 (PST)
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
Subject: [PATCH 3/3] kernel/watchdog: use soft lockup to detect irq flood
Date:   Wed, 18 Nov 2020 11:36:18 +0800
Message-Id: <1605670578-23681-4-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1605670578-23681-1-git-send-email-kernelfans@gmail.com>
References: <87tuueftou.fsf@nanos.tec.linutronix.de>
 <1605670578-23681-1-git-send-email-kernelfans@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When irq flood happens, interrupt handler occupies all of the cpu time.
This results in a situation where soft lockup can be observed, although it
is different from the design purpose of soft lockup.

In order to distinguish this situation, it is helpful to print out the
statistics of irq frequency when warning soft lockup to evaluate the
potential irq flood.

Thomas and Guilherme suggested patches to suppress the odd irq in different
situation. [1].[2]. But it seems to be an open question in a near future. For now,
it had better print some hints for users than nothing.

[1]: https://lore.kernel.org/lkml/87tuueftou.fsf@nanos.tec.linutronix.de/
[2]: https://lore.kernel.org/linux-pci/20181018183721.27467-1-gpiccoli@canonical.com/

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
 kernel/watchdog.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 1cc619a..a0ab2a8 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -23,6 +23,7 @@
 #include <linux/sched/debug.h>
 #include <linux/sched/isolation.h>
 #include <linux/stop_machine.h>
+#include <linux/kernel_stat.h>
 
 #include <asm/irq_regs.h>
 #include <linux/kvm_para.h>
@@ -175,6 +176,9 @@ static DEFINE_PER_CPU(bool, softlockup_touch_sync);
 static DEFINE_PER_CPU(bool, soft_watchdog_warn);
 static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts);
 static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts_saved);
+static DEFINE_PER_CPU(unsigned long, last_irq_sum);
+static DEFINE_PER_CPU(unsigned long, last_unused_irq_sum);
+
 static unsigned long soft_lockup_nmi_warn;
 
 static int __init nowatchdog_setup(char *str)
@@ -353,6 +357,8 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 
 	/* kick the softlockup detector */
 	if (completion_done(this_cpu_ptr(&softlockup_completion))) {
+		__this_cpu_write(last_irq_sum, kstat_this_cpu->irqs_sum);
+		__this_cpu_write(last_unused_irq_sum, kstat_this_cpu->unused_irqs_sum);
 		reinit_completion(this_cpu_ptr(&softlockup_completion));
 		stop_one_cpu_nowait(smp_processor_id(),
 				softlockup_fn, NULL,
@@ -386,6 +392,9 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 	 */
 	duration = is_softlockup(touch_ts);
 	if (unlikely(duration)) {
+		unsigned long irq_sum, unused_irq_sum;
+		unsigned int seconds;
+
 		/*
 		 * If a virtual machine is stopped by the host it can look to
 		 * the watchdog like a soft lockup, check to see if the host
@@ -409,9 +418,15 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 			}
 		}
 
+		irq_sum = kstat_this_cpu->irqs_sum - __this_cpu_read(last_irq_sum);
+		unused_irq_sum = kstat_this_cpu->unused_irqs_sum -
+			__this_cpu_read(last_unused_irq_sum);
+		seconds = (unsigned int)convert_seconds(duration);
 		pr_emerg("BUG: soft lockup - CPU#%d stuck for %us! [%s:%d]\n",
-			smp_processor_id(), (unsigned int)convert_seconds(duration),
+			smp_processor_id(), seconds,
 			current->comm, task_pid_nr(current));
+		pr_emerg("%lu irqs at rate: %lu / s, %lu unused irq at rate: %lu / s\n",
+			irq_sum, irq_sum/seconds, unused_irq_sum, unused_irq_sum/seconds);
 		print_modules();
 		print_irqtrace_events(current);
 		if (regs)
-- 
2.7.5

