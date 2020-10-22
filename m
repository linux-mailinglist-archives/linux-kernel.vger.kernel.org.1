Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83DE2295824
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 07:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508106AbgJVF4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 01:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2508098AbgJVF4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 01:56:45 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0E9C0613CE;
        Wed, 21 Oct 2020 22:56:43 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a17so421589pju.1;
        Wed, 21 Oct 2020 22:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ONnPqbEGpsHiC+7+xAJ566Uy7tk/a7WVPjlnbMKceyI=;
        b=iounUrnoUrJZ/ErJbP/e7FMedE451AQknxPCSd6Kkk0QPcLgBtLBrckOmJPMOTl+E1
         9JIbxrT/Cpw2dcmL8hULU/xBm72TaBolOMdCqlRwOxqC1r/JwoWDxYwp9Cxom6eGCKRa
         ujZUCCR17ib4G7JDNUU6VwcZ20qHie25+HbEHJfZkLikVblDY4IbgK3L1nqIflhm7mcp
         W6ZPOKroZKFUjGEoBqv+5jqhswg/U69FLGgs/yGY3OkX9KHHC5FdUa70QF15IogyJbQo
         sLmM2B8ME/cGw1Es3VeByfQsFDMUMtjngoNKfHMs9g2UiL+6SRerGR0m7WOJI+efc3kL
         SLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ONnPqbEGpsHiC+7+xAJ566Uy7tk/a7WVPjlnbMKceyI=;
        b=EEH7R8+eCymoi1EL27N/9LyIFM3kCl4KHbOk4ZWD3aDcPrZAuaky0H+eA+Wi+f496D
         aDjMlXf+EKwwxPzG3DFJ87VYC3k/zYAawulnKlxHMu+ZImkNgHuWhEF3Ek4/IxK3nw7x
         UUfuXF0WSKQLRGNmAfmdVMGWgPcAtCrRNaYk+lUopcdi6hvg0aynCHgz82oMXI6iKgdB
         NfhAt9iWdMdoflote9hV7K7flXSFyN1yOfKr5bU/O5LD1+wNsr3uwys3/6k9bGXim06z
         TJgn5retbuB8Vzi2b7SQD7SUOJYldAZgHQr0FmohYLmOnUMq+SIrqadpe2PR4bdPQZl0
         /GiA==
X-Gm-Message-State: AOAM530mx8r1V3Lp4f9XBlkDOPCawivuoQFPZhDkUSyns/FrvoALv4h4
        ixKeBD8jJnUgcppPtt5rNHx26bMKDQ==
X-Google-Smtp-Source: ABdhPJz/SRIaiTAz6Qjp3F3Y1C3ZIFiiMOAEZvfQr9sC+fWhw4V36jOOtxF9xYaIqrcVLRPepBj5BA==
X-Received: by 2002:a17:90a:ca90:: with SMTP id y16mr21279pjt.113.1603346203179;
        Wed, 21 Oct 2020 22:56:43 -0700 (PDT)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c12sm830995pgi.14.2020.10.21.22.56.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Oct 2020 22:56:42 -0700 (PDT)
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
Subject: [PATCH 2/3] kernel/watchdog: suppress max irq when irq floods
Date:   Thu, 22 Oct 2020 13:56:02 +0800
Message-Id: <1603346163-21645-3-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1603346163-21645-1-git-send-email-kernelfans@gmail.com>
References: <1603346163-21645-1-git-send-email-kernelfans@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The capture kernel should try its best to save the crash info. Normally,
irq flood is caused by some trivial devices, which has no impact on saving
vmcore.

Introducing a parameter "irqflood_suppress" to enable suppress irq flood.

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
 include/linux/irq.h   |  2 ++
 kernel/irq/spurious.c | 32 ++++++++++++++++++++++++++++++++
 kernel/watchdog.c     |  9 ++++++++-
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 1b7f4df..140cb61 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -684,6 +684,8 @@ extern void note_interrupt(struct irq_desc *desc, irqreturn_t action_ret);
 /* Enable/disable irq debugging output: */
 extern int noirqdebug_setup(char *str);
 
+void suppress_max_irq(void);
+
 /* Checks whether the interrupt can be requested by request_irq(): */
 extern int can_request_irq(unsigned int irq, unsigned long irqflags);
 
diff --git a/kernel/irq/spurious.c b/kernel/irq/spurious.c
index f865e5f..d3d94d6 100644
--- a/kernel/irq/spurious.c
+++ b/kernel/irq/spurious.c
@@ -464,3 +464,35 @@ static int __init irqpoll_setup(char *str)
 }
 
 __setup("irqpoll", irqpoll_setup);
+
+#ifdef CONFIG_IRQ_TIME_ACCOUNTING
+
+static bool irqflood_suppress;
+
+static int __init irqflood_suppress_setup(char *str)
+{
+	irqflood_suppress = true;
+	pr_info("enable auto suppress irqflood\n");
+	return 1;
+}
+__setup("irqflood_suppress", irqflood_suppress_setup);
+
+void suppress_max_irq(void)
+{
+	unsigned int tmp, maxirq = 0, max = 0;
+	int irq;
+
+	if (!irqflood_suppress)
+		return;
+	for_each_active_irq(irq) {
+		tmp = kstat_irqs_cpu(irq, smp_processor_id());
+		if (max < tmp) {
+			maxirq = irq;
+			max = tmp;
+		}
+	}
+	pr_warn("Suppress irq:%u, which is triggered %u times\n",
+		maxirq, max);
+	disable_irq_nosync(maxirq);
+}
+#endif
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 230ac38..28a74e5 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -24,6 +24,7 @@
 #include <linux/sched/isolation.h>
 #include <linux/stop_machine.h>
 #include <linux/kernel_stat.h>
+#include <linux/irq.h>
 
 #include <asm/irq_regs.h>
 #include <linux/kvm_para.h>
@@ -364,9 +365,15 @@ static void check_irq_flood(void)
 		percent = irqts * 100 / totalts;
 		percent =  percent < 100 ? percent : 100;
 		__this_cpu_write(check_hint, -1);
-		if (percent >= 98)
+		if (percent >= 98) {
 			pr_info("Irq flood occupies more than %lu%% of the past %lu seconds\n",
 				percent, totalts >> 30);
+			/*
+			 * Suppress top irq when scheduler does not work for long time and irq
+			 * occupies too much time.
+			 */
+			suppress_max_irq();
+		}
 	} else if (cnt == 0) {
 		__this_cpu_write(last_total_ts, totalts);
 		__this_cpu_write(last_irq_ts, irqts);
-- 
2.7.5

