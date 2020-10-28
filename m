Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61DCB29D8AC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388262AbgJ1Wfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:35:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57618 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732560AbgJ1We2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:34:28 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603886321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gw4bPdg7UIOF5tNu1YmicaVB3DTvzo6EZfXK3Th8+c4=;
        b=MX4TukT1xfBkkrDuCYiqJwBBwTEdBuYeGp0aqmBiJx3tCI7IaWX44lUiRI+dQQTcZvt0IB
        AJiKk4F+rCczmw5D1FZQrQ+P9f3GLgwLwTzvzUKt/1pV5KXCZO02Hy/8iM3bgmTl+Bh4OG
        BjGVc0+FxB5aueTktxjp+0u89qtHbX9HhdTWK/Pz2mD8Ifn/NhsMxScTuhePEV1MgsUszr
        Ezrk4At6VJXF+nJNtd9+UnUbKl7Se/VjPvArl3R7JZlp/gSenZ5mxlCHU4HR72XsvHl5y6
        h/iAgzm8gZovAYkyghdVQYQPk+88K9XtTGhHi8/Ni5WmPa9TdjBsviFtX+qYgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603886321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gw4bPdg7UIOF5tNu1YmicaVB3DTvzo6EZfXK3Th8+c4=;
        b=Lr35cQttKvFG91m77VZgOyBgsMALCGkOZuui8Hc/E4FnPTx5SjHW8CAsvfrhwrCO5ZzZQP
        7eIcfAheP6b200Cw==
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     Guilherme Piccoli <gpiccoli@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Kexec Mailing List <kexec@lists.infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 0/3] warn and suppress irqflood
In-Reply-To: <CAFgQCTtnKB+p5uhRu3JpmBvHbQ8Vhv0TrKek9_3CWbtbcyM1Kw@mail.gmail.com>
References: <1603346163-21645-1-git-send-email-kernelfans@gmail.com> <871rhq7j1h.fsf@nanos.tec.linutronix.de> <CAFgQCTvFwvvtPE0Eow4cebCEe5OD5OhgAQarckpbFc38Bphaag@mail.gmail.com> <CAHD1Q_x99XW1zDr5HpVR27F_ksHLkaxc2W83e-N6F_xLYKyGbQ@mail.gmail.com> <87y2js3ghv.fsf@nanos.tec.linutronix.de> <CAFgQCTtnKB+p5uhRu3JpmBvHbQ8Vhv0TrKek9_3CWbtbcyM1Kw@mail.gmail.com>
Date:   Wed, 28 Oct 2020 12:58:41 +0100
Message-ID: <87tuueftou.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28 2020 at 14:02, Pingfan Liu wrote:
> On Tue, Oct 27, 2020 at 3:59 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>> Also Liu's patch only works if:
>>
>>   1) CONFIG_IRQ_TIME_ACCOUNTING is enabled
>
> I wonder whether it can not be a default option or not by the following method:
>   DEFINE_STATIC_KEY_FALSE(irqtime_account), and enable it according to
> a boot param.

How so?

	config IRQ_TIME_ACCOUNTING
		depends on HAVE_IRQ_TIME_ACCOUNTING && !VIRT_CPU_ACCOUNTING_NATIVE

> This will have no impact on performance with the disabled branch.
> Meanwhile users can easily turn on the option to detect an irq flood
> without  recompiling the kernel.
>
> If it is doable, I will rework only on [1/2].

See above :)

>>   2) the runaway interrupt has been requested by the relevant driver in
>>      the dump kernel.
>
> Yes, it raises a big challenge to my method. Kdump kernel miss the
> whole picture of the first kernel's irq routing.

Correct. If there is anything stale then you get what Guilherme
observed. But the irq core can do nothing about that.

Something like the completly untested below should work independent of
config options.

Thanks,

        tglx
---
 include/linux/irqdesc.h |    4 ++
 kernel/irq/manage.c     |    3 +
 kernel/irq/spurious.c   |   74 +++++++++++++++++++++++++++++++++++-------------
 3 files changed, 61 insertions(+), 20 deletions(-)

--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -30,6 +30,8 @@ struct pt_regs;
  * @tot_count:		stats field for non-percpu irqs
  * @irq_count:		stats field to detect stalled irqs
  * @last_unhandled:	aging timer for unhandled count
+ * @storm_count:	Counter for irq storm detection
+ * @storm_checked:	Timestamp for irq storm detection
  * @irqs_unhandled:	stats field for spurious unhandled interrupts
  * @threads_handled:	stats field for deferred spurious detection of threaded handlers
  * @threads_handled_last: comparator field for deferred spurious detection of theraded handlers
@@ -65,6 +67,8 @@ struct irq_desc {
 	unsigned int		tot_count;
 	unsigned int		irq_count;	/* For detecting broken IRQs */
 	unsigned long		last_unhandled;	/* Aging timer for unhandled count */
+	unsigned long		storm_count;
+	unsigned long		storm_checked;
 	unsigned int		irqs_unhandled;
 	atomic_t		threads_handled;
 	int			threads_handled_last;
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1581,6 +1581,9 @@ static int
 	if (!shared) {
 		init_waitqueue_head(&desc->wait_for_threads);
 
+		/* Take a timestamp for interrupt storm detection */
+		desc->storm_checked = jiffies;
+
 		/* Setup the type (level, edge polarity) if configured: */
 		if (new->flags & IRQF_TRIGGER_MASK) {
 			ret = __irq_set_trigger(desc,
--- a/kernel/irq/spurious.c
+++ b/kernel/irq/spurious.c
@@ -21,6 +21,7 @@ static void poll_spurious_irqs(struct ti
 static DEFINE_TIMER(poll_spurious_irq_timer, poll_spurious_irqs);
 static int irq_poll_cpu;
 static atomic_t irq_poll_active;
+static unsigned long irqstorm_limit __ro_after_init;
 
 /*
  * We wait here for a poller to finish.
@@ -189,18 +190,21 @@ static inline int bad_action_ret(irqretu
  * (The other 100-of-100,000 interrupts may have been a correctly
  *  functioning device sharing an IRQ with the failing one)
  */
-static void __report_bad_irq(struct irq_desc *desc, irqreturn_t action_ret)
+static void __report_bad_irq(struct irq_desc *desc, irqreturn_t action_ret,
+			     bool storm)
 {
 	unsigned int irq = irq_desc_get_irq(desc);
 	struct irqaction *action;
 	unsigned long flags;
 
-	if (bad_action_ret(action_ret)) {
-		printk(KERN_ERR "irq event %d: bogus return value %x\n",
-				irq, action_ret);
-	} else {
-		printk(KERN_ERR "irq %d: nobody cared (try booting with "
+	if (!storm) {
+		if (bad_action_ret(action_ret)) {
+			pr_err("irq event %d: bogus return value %x\n",
+			       irq, action_ret);
+		} else {
+			pr_err("irq %d: nobody cared (try booting with "
 				"the \"irqpoll\" option)\n", irq);
+		}
 	}
 	dump_stack();
 	printk(KERN_ERR "handlers:\n");
@@ -228,7 +232,7 @@ static void report_bad_irq(struct irq_de
 
 	if (count > 0) {
 		count--;
-		__report_bad_irq(desc, action_ret);
+		__report_bad_irq(desc, action_ret, false);
 	}
 }
 
@@ -267,6 +271,33 @@ try_misrouted_irq(unsigned int irq, stru
 	return action && (action->flags & IRQF_IRQPOLL);
 }
 
+static void disable_stuck_irq(struct irq_desc *desc, irqreturn_t action_ret,
+			      const char *reason, bool storm)
+{
+	__report_bad_irq(desc, action_ret, storm);
+	pr_emerg("Disabling %s IRQ #%d\n", reason, irq_desc_get_irq(desc));
+	desc->istate |= IRQS_SPURIOUS_DISABLED;
+	desc->depth++;
+	irq_disable(desc);
+}
+
+/* Interrupt storm detector for runaway interrupts (handled or not). */
+static bool irqstorm_detected(struct irq_desc *desc)
+{
+	unsigned long now = jiffies;
+
+	if (++desc->storm_count < irqstorm_limit) {
+		if (time_after(now, desc->storm_checked + HZ)) {
+			desc->storm_count = 0;
+			desc->storm_checked = now;
+		}
+		return false;
+	}
+
+	disable_stuck_irq(desc, IRQ_NONE, "runaway", true);
+	return true;
+}
+
 #define SPURIOUS_DEFERRED	0x80000000
 
 void note_interrupt(struct irq_desc *desc, irqreturn_t action_ret)
@@ -403,24 +434,16 @@ void note_interrupt(struct irq_desc *des
 			desc->irqs_unhandled -= ok;
 	}
 
+	if (unlikely(irqstorm_limit && irqstorm_detected(desc)))
+		return;
+
 	desc->irq_count++;
 	if (likely(desc->irq_count < 100000))
 		return;
 
 	desc->irq_count = 0;
 	if (unlikely(desc->irqs_unhandled > 99900)) {
-		/*
-		 * The interrupt is stuck
-		 */
-		__report_bad_irq(desc, action_ret);
-		/*
-		 * Now kill the IRQ
-		 */
-		printk(KERN_EMERG "Disabling IRQ #%d\n", irq);
-		desc->istate |= IRQS_SPURIOUS_DISABLED;
-		desc->depth++;
-		irq_disable(desc);
-
+		disable_stuck_irq(desc, action_ret, "unhandled", false);
 		mod_timer(&poll_spurious_irq_timer,
 			  jiffies + POLL_SPURIOUS_IRQ_INTERVAL);
 	}
@@ -462,5 +485,16 @@ static int __init irqpoll_setup(char *st
 				"performance\n");
 	return 1;
 }
-
 __setup("irqpoll", irqpoll_setup);
+
+static int __init irqstorm_setup(char *arg)
+{
+	int res = kstrtoul(arg, 0, &irqstorm_limit);
+
+	if (!res) {
+		pr_info("Interrupt storm detector enabled. Limit=%lu / s\n",
+			irqstorm_limit);
+	}
+	return !!res;
+}
+__setup("irqstorm_limit", irqstorm_setup);



