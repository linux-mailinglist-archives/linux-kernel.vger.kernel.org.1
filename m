Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D63942A8F0C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 06:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgKFFyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 00:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgKFFyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 00:54:12 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A861C0613CF;
        Thu,  5 Nov 2020 21:54:12 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id q1so97354ilt.6;
        Thu, 05 Nov 2020 21:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uDN6j31v9Jw+Jc4wz8SuOy1OBlhE5DLRx4P5BkScGeE=;
        b=kMN/+i4HxRqtssG7OQTxjs1myQXLPHDEPjPnStBTSnwjWSQavWnT4k2phbKKAAXRus
         eL71cJlZ/4ELQuSLrfV7RX//SyaV8szYeHpvZR39CHXRzjeiS69nEe7yvcpuC7OU2/+G
         Q5OGYmMebO7j3zJNiGIE9gAxCxxitvOBynOFWTyQoJG7UAe9r63UU1n0cW9uQKwBM+GB
         +33JFClYjQ0Mib9ngtF9qOu6jnbNZBr+wmFHko8WHy0JmtZM4TxQsel4OVU4XK0BB0QO
         xn+h980fOCADb6utcR6DSfR6yl2o2hxqAZgKR8LF3gViQGWu97sHpxeQVCCxPHQyjhJJ
         JvrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uDN6j31v9Jw+Jc4wz8SuOy1OBlhE5DLRx4P5BkScGeE=;
        b=rnrBYteohM+K9V6xcbsIO5I2gMV7gb1XkxYHagM39ApFHv72G2/XSfmGYjTu+77jZs
         e0p9l2jHRDzTKboUHdwGB1OMO3NHZlRPuPuw+nNyGeoHfLyaUl5TJ+GqLg/NnI1iNPjx
         VImTWRpCCc8r7d5R9NKRGxfRjnKHMwyB8thgkoIx4AlHZdfPDatgtVbqfp/UMUPb/BWf
         oWZ9qmN78/tSQ+FDy9i9JTLFBuFJSceSV8vtxtmQnl9Q8V3rnOJ4mjiX7OpGrR0Ano2L
         at6KN/d7SoYHx/iXDMQq80Y2efLQIR+/WyghHX0gyL5qbSnXnLYUtuqxpK871VYcpUWU
         CGcw==
X-Gm-Message-State: AOAM533z8uhd579C1x9JUVOjKU44qBt9HQhi5yM4WNsJMS3QicEcQgR3
        76vKx+1DnicGRoBHydPb1lAHZvm9Ynd6Q52YdA==
X-Google-Smtp-Source: ABdhPJxoffljQaoi5UHKFkfBQXr6qCHtKuULm5vwnKk4L1fMENgXNj/slM9oecIgJp9jBR14r1eC+OdRcwzwtnKGdbk=
X-Received: by 2002:a92:d68a:: with SMTP id p10mr310494iln.34.1604642050883;
 Thu, 05 Nov 2020 21:54:10 -0800 (PST)
MIME-Version: 1.0
References: <1603346163-21645-1-git-send-email-kernelfans@gmail.com>
 <871rhq7j1h.fsf@nanos.tec.linutronix.de> <CAFgQCTvFwvvtPE0Eow4cebCEe5OD5OhgAQarckpbFc38Bphaag@mail.gmail.com>
 <CAHD1Q_x99XW1zDr5HpVR27F_ksHLkaxc2W83e-N6F_xLYKyGbQ@mail.gmail.com>
 <87y2js3ghv.fsf@nanos.tec.linutronix.de> <CAFgQCTtnKB+p5uhRu3JpmBvHbQ8Vhv0TrKek9_3CWbtbcyM1Kw@mail.gmail.com>
 <87tuueftou.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87tuueftou.fsf@nanos.tec.linutronix.de>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Fri, 6 Nov 2020 13:53:59 +0800
Message-ID: <CAFgQCTsbW3sBGgUj+8LJagpf_AMNPrB+PDvcZ+pLgeoFtNWv=w@mail.gmail.com>
Subject: Re: [PATCH 0/3] warn and suppress irqflood
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 7:58 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
[...]
> ---
>  include/linux/irqdesc.h |    4 ++
>  kernel/irq/manage.c     |    3 +
>  kernel/irq/spurious.c   |   74 +++++++++++++++++++++++++++++++++++-------------
>  3 files changed, 61 insertions(+), 20 deletions(-)
>
> --- a/include/linux/irqdesc.h
> +++ b/include/linux/irqdesc.h
> @@ -30,6 +30,8 @@ struct pt_regs;
>   * @tot_count:         stats field for non-percpu irqs
>   * @irq_count:         stats field to detect stalled irqs
>   * @last_unhandled:    aging timer for unhandled count
> + * @storm_count:       Counter for irq storm detection
> + * @storm_checked:     Timestamp for irq storm detection
>   * @irqs_unhandled:    stats field for spurious unhandled interrupts
>   * @threads_handled:   stats field for deferred spurious detection of threaded handlers
>   * @threads_handled_last: comparator field for deferred spurious detection of theraded handlers
> @@ -65,6 +67,8 @@ struct irq_desc {
>         unsigned int            tot_count;
>         unsigned int            irq_count;      /* For detecting broken IRQs */
>         unsigned long           last_unhandled; /* Aging timer for unhandled count */
> +       unsigned long           storm_count;
> +       unsigned long           storm_checked;
>         unsigned int            irqs_unhandled;
>         atomic_t                threads_handled;
>         int                     threads_handled_last;
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -1581,6 +1581,9 @@ static int
>         if (!shared) {
>                 init_waitqueue_head(&desc->wait_for_threads);
>
> +               /* Take a timestamp for interrupt storm detection */
> +               desc->storm_checked = jiffies;
> +
>                 /* Setup the type (level, edge polarity) if configured: */
>                 if (new->flags & IRQF_TRIGGER_MASK) {
>                         ret = __irq_set_trigger(desc,
> --- a/kernel/irq/spurious.c
> +++ b/kernel/irq/spurious.c
> @@ -21,6 +21,7 @@ static void poll_spurious_irqs(struct ti
>  static DEFINE_TIMER(poll_spurious_irq_timer, poll_spurious_irqs);
>  static int irq_poll_cpu;
>  static atomic_t irq_poll_active;
> +static unsigned long irqstorm_limit __ro_after_init;
>
>  /*
>   * We wait here for a poller to finish.
> @@ -189,18 +190,21 @@ static inline int bad_action_ret(irqretu
>   * (The other 100-of-100,000 interrupts may have been a correctly
>   *  functioning device sharing an IRQ with the failing one)
>   */
> -static void __report_bad_irq(struct irq_desc *desc, irqreturn_t action_ret)
> +static void __report_bad_irq(struct irq_desc *desc, irqreturn_t action_ret,
> +                            bool storm)
>  {
>         unsigned int irq = irq_desc_get_irq(desc);
>         struct irqaction *action;
>         unsigned long flags;
>
> -       if (bad_action_ret(action_ret)) {
> -               printk(KERN_ERR "irq event %d: bogus return value %x\n",
> -                               irq, action_ret);
> -       } else {
> -               printk(KERN_ERR "irq %d: nobody cared (try booting with "
> +       if (!storm) {
> +               if (bad_action_ret(action_ret)) {
> +                       pr_err("irq event %d: bogus return value %x\n",
> +                              irq, action_ret);
> +               } else {
> +                       pr_err("irq %d: nobody cared (try booting with "
>                                 "the \"irqpoll\" option)\n", irq);
> +               }
>         }
>         dump_stack();
>         printk(KERN_ERR "handlers:\n");
> @@ -228,7 +232,7 @@ static void report_bad_irq(struct irq_de
>
>         if (count > 0) {
>                 count--;
> -               __report_bad_irq(desc, action_ret);
> +               __report_bad_irq(desc, action_ret, false);
>         }
>  }
>
> @@ -267,6 +271,33 @@ try_misrouted_irq(unsigned int irq, stru
>         return action && (action->flags & IRQF_IRQPOLL);
>  }
>
> +static void disable_stuck_irq(struct irq_desc *desc, irqreturn_t action_ret,
> +                             const char *reason, bool storm)
> +{
> +       __report_bad_irq(desc, action_ret, storm);
> +       pr_emerg("Disabling %s IRQ #%d\n", reason, irq_desc_get_irq(desc));
> +       desc->istate |= IRQS_SPURIOUS_DISABLED;
> +       desc->depth++;
> +       irq_disable(desc);
> +}
> +
> +/* Interrupt storm detector for runaway interrupts (handled or not). */
> +static bool irqstorm_detected(struct irq_desc *desc)
> +{
> +       unsigned long now = jiffies;
> +
> +       if (++desc->storm_count < irqstorm_limit) {
> +               if (time_after(now, desc->storm_checked + HZ)) {
> +                       desc->storm_count = 0;
> +                       desc->storm_checked = now;
> +               }
> +               return false;
> +       }
> +
> +       disable_stuck_irq(desc, IRQ_NONE, "runaway", true);
> +       return true;
> +}
> +
>  #define SPURIOUS_DEFERRED      0x80000000
>
>  void note_interrupt(struct irq_desc *desc, irqreturn_t action_ret)
> @@ -403,24 +434,16 @@ void note_interrupt(struct irq_desc *des
>                         desc->irqs_unhandled -= ok;
>         }
>
> +       if (unlikely(irqstorm_limit && irqstorm_detected(desc)))
> +               return;
> +
>         desc->irq_count++;
>         if (likely(desc->irq_count < 100000))
>                 return;
>
>         desc->irq_count = 0;
>         if (unlikely(desc->irqs_unhandled > 99900)) {
> -               /*
> -                * The interrupt is stuck
> -                */
> -               __report_bad_irq(desc, action_ret);
> -               /*
> -                * Now kill the IRQ
> -                */
> -               printk(KERN_EMERG "Disabling IRQ #%d\n", irq);
> -               desc->istate |= IRQS_SPURIOUS_DISABLED;
> -               desc->depth++;
> -               irq_disable(desc);
> -
> +               disable_stuck_irq(desc, action_ret, "unhandled", false);
>                 mod_timer(&poll_spurious_irq_timer,
>                           jiffies + POLL_SPURIOUS_IRQ_INTERVAL);
>         }
> @@ -462,5 +485,16 @@ static int __init irqpoll_setup(char *st
>                                 "performance\n");
>         return 1;
>  }
> -
>  __setup("irqpoll", irqpoll_setup);
> +
> +static int __init irqstorm_setup(char *arg)
> +{
> +       int res = kstrtoul(arg, 0, &irqstorm_limit);
> +
> +       if (!res) {
> +               pr_info("Interrupt storm detector enabled. Limit=%lu / s\n",
> +                       irqstorm_limit);
> +       }
> +       return !!res;
> +}
> +__setup("irqstorm_limit", irqstorm_setup);
It should be
__setup("irqstorm_limit=", irqstorm_setup);

And I have tested this patch on the P9 machine, where I set the limit
to 70000. It works for kdump kernel.

Thanks,
Pingfan
