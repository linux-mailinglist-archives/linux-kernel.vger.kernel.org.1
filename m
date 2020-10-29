Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA5F29E48C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730549AbgJ2Hks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbgJ2HYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:24:52 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF152C05BD14;
        Wed, 28 Oct 2020 23:26:19 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x13so1488076pfa.9;
        Wed, 28 Oct 2020 23:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N3XX0uSvnfZ3G2nWpfjOMRu++gpGLVSi+ubPYjUwWYM=;
        b=oUly++naKV0LQYVh+Amd3XknEENV8SGuUrv/eNBs2fzjayE/725qcLB6fNESQyOG7T
         8MSr1XfRtnCl+GJukHyDkm1s0Mx5MbzFcXSPuRRunofVdJhSFGXfME5+3U4nGu/Q4p75
         lCIzmj4sRoZa1zLxcsIKuvAALyr1e73mZ0JMI4oHv1nnd5tgs6Bg7V5qrwgD/hTXMuSD
         2dA5Y0T15s7JEC0MwwhIlWbrQQQx6dFExARveXWK0JELa+bJLkdrn6Z1Ptdjv1cn2999
         IjxlNE2sPUx9prAUY7xZxCrj2OnSRyC7kh6inrSzpEFpq2o7/wcFCAmpulLS0pHPpP5J
         v4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N3XX0uSvnfZ3G2nWpfjOMRu++gpGLVSi+ubPYjUwWYM=;
        b=p/Hj7vau4q2l+e1qOJRti+LJrQXRkGLwvKvf+84Y+ZAlkDiYWk/NC/jszsgTCdMS+N
         pWnl5e/NmX4RFvUiwWhck1DSj4FMZaYtbvwWr1UNCVEqCIuHbW76kC22qQAL4blsDnKR
         kwkQEkoUPDk0gXGdJIcbBd9vhQQPrr66j5btmRf1Bk8M4KOpg5KBtvRfAH99DPOGOY1G
         NwlUIs2gsaXqLCKC7VIA5tU3G/p+1mzGwF/lC4AU42JA2U4komoByYcmMyEM/j0onwUi
         xvEgBwwFu4In69KL/tRPWiYGarYSDar+uHAwI52rClsss4QrpSOeFun/bbVXB8oL6KTY
         vwxA==
X-Gm-Message-State: AOAM533fvKhNu7uFll24PBV2mO24kaFy624xPoHeiy4SK0/1YwhE+BvA
        1kUVoL9Dq4/BUI9uWzP6fA==
X-Google-Smtp-Source: ABdhPJxlhBd/gb7H+y95w78BSUar9DtgF2a0JmSRzY4uddMUBsat1zay9WPDGHVjeve3MHWaIiEefQ==
X-Received: by 2002:a62:4e0f:0:b029:156:13e0:efa7 with SMTP id c15-20020a624e0f0000b029015613e0efa7mr2652788pfb.73.1603952779448;
        Wed, 28 Oct 2020 23:26:19 -0700 (PDT)
Received: from x1pad ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id v125sm1568409pfv.75.2020.10.28.23.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 23:26:18 -0700 (PDT)
Date:   Thu, 29 Oct 2020 14:26:00 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
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
Message-ID: <20201029062600.GA71783@x1pad>
References: <1603346163-21645-1-git-send-email-kernelfans@gmail.com>
 <871rhq7j1h.fsf@nanos.tec.linutronix.de>
 <CAFgQCTvFwvvtPE0Eow4cebCEe5OD5OhgAQarckpbFc38Bphaag@mail.gmail.com>
 <CAHD1Q_x99XW1zDr5HpVR27F_ksHLkaxc2W83e-N6F_xLYKyGbQ@mail.gmail.com>
 <87y2js3ghv.fsf@nanos.tec.linutronix.de>
 <CAFgQCTtnKB+p5uhRu3JpmBvHbQ8Vhv0TrKek9_3CWbtbcyM1Kw@mail.gmail.com>
 <87tuueftou.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tuueftou.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 12:58:41PM +0100, Thomas Gleixner wrote:
> On Wed, Oct 28 2020 at 14:02, Pingfan Liu wrote:
> > On Tue, Oct 27, 2020 at 3:59 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >> Also Liu's patch only works if:
> >>
> >>   1) CONFIG_IRQ_TIME_ACCOUNTING is enabled
> >
> > I wonder whether it can not be a default option or not by the following method:
> >   DEFINE_STATIC_KEY_FALSE(irqtime_account), and enable it according to
> > a boot param.
> 
> How so?
> 
> 	config IRQ_TIME_ACCOUNTING
> 		depends on HAVE_IRQ_TIME_ACCOUNTING && !VIRT_CPU_ACCOUNTING_NATIVE
> 
Look closely at the two config value:
-1. HAVE_IRQ_TIME_ACCOUNTING, it is selected by most of the popular arches, and
can be further relaxed.
   It implies sched_clock() is fast enough for sampling. With current code, the
variable sched_clock_irqtime=0 can be used to turn off irqtime accounting on
some arches with slow sched_clock(). And it can be even better by using
DEFINE_STATIC_KEY_FALSE(sched_clock_irqtime)
   So the pre-requirement can be relaxed as "depends on !VIRT_CPU_ACCOUNTING_NATIVE"
In case that I can not express clearly, could you have a look at the demo patch?

   That patch _assumes_ that irqtime accounting costs much and is not turned on by
default. If turned on, it will cost an extra jmp than current implement.
And I think it is critical to my [1/3] whether this assumption is reasonable.

-2. For VIRT_CPU_ACCOUNTING_NATIVE, it can only be selected by powerpc and ia64

In fact, I have a seperate patch for powerpc with
CONFIG_VIRT_CPU_ACCOUNTING_NATIVE to utilize my [1/3].

---
diff --git a/init/Kconfig b/init/Kconfig
index c944691..16d168b 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -490,7 +490,7 @@ endchoice
 
 config IRQ_TIME_ACCOUNTING
 	bool "Fine granularity task level IRQ time accounting"
-	depends on HAVE_IRQ_TIME_ACCOUNTING && !VIRT_CPU_ACCOUNTING_NATIVE
+	depends on !VIRT_CPU_ACCOUNTING_NATIVE
 	help
 	  Select this option to enable fine granularity task irq time
 	  accounting. This is done by reading a timestamp on each
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 5a55d23..3ab7e1d 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -19,7 +19,7 @@
  */
 DEFINE_PER_CPU(struct irqtime, cpu_irqtime);
 
-static int sched_clock_irqtime;
+DEFINE_STATIC_KEY_FALSE(sched_clock_irqtime);
 
 void enable_sched_clock_irqtime(void)
 {
@@ -49,13 +49,14 @@ static void irqtime_account_delta(struct irqtime *irqtime, u64 delta,
  */
 void irqtime_account_irq(struct task_struct *curr)
 {
-	struct irqtime *irqtime = this_cpu_ptr(&cpu_irqtime);
+	struct irqtime *irqtime;
 	s64 delta;
 	int cpu;
 
-	if (!sched_clock_irqtime)
+	if (static_branch_unlikely(&sched_clock_irqtime))
 		return;
 
+	irqtime = this_cpu_ptr(&cpu_irqtime);
 	cpu = smp_processor_id();
 	delta = sched_clock_cpu(cpu) - irqtime->irq_start_time;
 	irqtime->irq_start_time += delta;
@@ -84,16 +85,7 @@ static u64 irqtime_tick_accounted(u64 maxtime)
 	return delta;
 }
 
-#else /* CONFIG_IRQ_TIME_ACCOUNTING */
-
-#define sched_clock_irqtime	(0)
-
-static u64 irqtime_tick_accounted(u64 dummy)
-{
-	return 0;
-}
-
-#endif /* !CONFIG_IRQ_TIME_ACCOUNTING */
+#endif
 
 static inline void task_group_account_field(struct task_struct *p, int index,
 					    u64 tmp)
@@ -475,7 +467,7 @@ void account_process_tick(struct task_struct *p, int user_tick)
 	if (vtime_accounting_enabled_this_cpu())
 		return;
 
-	if (sched_clock_irqtime) {
+	if (static_branch_unlikely(&sched_clock_irqtime))
 		irqtime_account_process_tick(p, user_tick, 1);
 		return;
 	}
@@ -504,7 +496,7 @@ void account_idle_ticks(unsigned long ticks)
 {
 	u64 cputime, steal;
 
-	if (sched_clock_irqtime) {
+	if (static_branch_unlikely(&sched_clock_irqtime))
 		irqtime_account_idle_ticks(ticks);
 		return;
 	}
-- 
2.7.5

[...]
> +
> +static int __init irqstorm_setup(char *arg)
> +{
> +	int res = kstrtoul(arg, 0, &irqstorm_limit);
> +
> +	if (!res) {
> +		pr_info("Interrupt storm detector enabled. Limit=%lu / s\n",
> +			irqstorm_limit);
> +	}
> +	return !!res;
> +}
> +__setup("irqstorm_limit", irqstorm_setup);

This configuration independent method looks appealing. And I am glad to have a try.

But irqstorm_limit may be a hard choice. Maybe by formula:
instruction-percpu-per-second / insn num of irq failed path ?  It is hard to
estimate "instruction-percpu-per-second".

Thanks,
Pingfan
