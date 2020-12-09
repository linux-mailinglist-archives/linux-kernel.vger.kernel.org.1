Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1852D49C2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 20:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387553AbgLITGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 14:06:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:53664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387441AbgLITGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 14:06:15 -0500
X-Gm-Message-State: AOAM532fMm5ZfeB54y7LwOzUFaQyhBGHMxp/fjmcM3NDV+rYCu/JlPh4
        fnPvRh/LdxuzlHC8l8WxXNAZML8bt4uIEymVmyWPBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607540734;
        bh=Ys5/DqnR+LXYOYEbV+Atqgi0hTcMkX4Hw87vBT5H5LY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DEAHk5N3hBsfXtbbl+ysa/6KNoLISlnpsalD0yMGonZv0kVQTg+eWNhKHTTBTz+FM
         pgqZ7NPBDTFCNzLQjb8TiJNqddFwSNl1n55ul3M6ArZM2k5Togq4JU91oboVlP2CVV
         anXx2Z18FnoO8AVobyANZmgnmExDfdHYPMBVzZ2ErEzVcmxq0Uj/hV5iuAJ4AnjmzJ
         XUIRhTFeA+kINq5TDDT8V4iSYRehH9yxRbx6+7kigK3scMxGYcBk/3VTfYYFZAn52I
         KShpO8OWKadpTuSqC8jFayWU8DPROWXk1IXd7q3mJsnbpIvJvgtJn5HW5YEgYPL75Q
         J8kJwy1rRWREw==
X-Google-Smtp-Source: ABdhPJwp523cHnPDJx7e2r/2rqIUMWCTaX5ttizRK5T+aoQipz0p8IYTh9Xjo9y32m0IFjnBm8tEZnUEXy7BRu67AOM=
X-Received: by 2002:a5d:4e87:: with SMTP id e7mr4447345wru.70.1607540732726;
 Wed, 09 Dec 2020 11:05:32 -0800 (PST)
MIME-Version: 1.0
References: <20201209183337.1912-1-mark.rutland@arm.com>
In-Reply-To: <20201209183337.1912-1-mark.rutland@arm.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 9 Dec 2020 11:05:21 -0800
X-Gmail-Original-Message-ID: <CALCETrVRiSQn9z7CG2CWHhOeQb=UJSrtPod4-8qBSFLsdYP=iQ@mail.gmail.com>
Message-ID: <CALCETrVRiSQn9z7CG2CWHhOeQb=UJSrtPod4-8qBSFLsdYP=iQ@mail.gmail.com>
Subject: Re: [PATCH] lockdep: report broken irq restoration
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 9, 2020 at 10:33 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> We generally expect local_irq_save() and local_irq_restore() to be
> paired and sanely nested, and so local_irq_restore() expects to be
> called with irqs disabled. Thus, within local_irq_restore() we only
> trace irq flag changes when unmasking irqs.
>
> This means that a seuence such as:
>
> | local_irq_disable();
> | local_irq_save(flags);
> | local_irq_enable();
> | local_irq_restore(flags);
>
> ... is liable to break things, as the local_irq_restore() would mask
> IRQs without tracing this change.
>
> We don't consider such sequences to be a good idea, so let's define
> those as forbidden, and add tooling to detect such broken cases.
>
> This patch adds debug code to WARN() when local_irq_restore() is called
> with irqs enabled. As local_irq_restore() is expected to pair with
> local_irq_save(), it should never be called with interrupts enabled.
>
> To avoid the possibility of circular header dependencies beteen
> irqflags.h and bug.h, the warning is handled in a separate C file.
>
> The new code is all conditional on a new CONFIG_DEBUG_IRQFLAGS symbol
> which is independent of CONFIG_TRACE_IRQFLAGS. As noted above such cases
> will confuse lockdep, so CONFIG_DEBUG_LOCKDEP now selects
> CONFIG_DEBUG_IRQFLAGS.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  include/linux/irqflags.h       | 18 +++++++++++++++++-
>  kernel/locking/Makefile        |  1 +
>  kernel/locking/irqflag-debug.c | 12 ++++++++++++
>  lib/Kconfig.debug              |  7 +++++++
>  4 files changed, 37 insertions(+), 1 deletion(-)
>  create mode 100644 kernel/locking/irqflag-debug.c
>
> Note: as things stand this'll blow up at boot-time on x86 within the io-apic
> timer_irq_works() boot-time test. I've proposed a fix for that:
>
> https://lore.kernel.org/lkml/20201209181514.GA14235@C02TD0UTHF1T.local/
>
> ... which was sufficient for booting under QEMU without splats. I'm giving this
> a soak under Syzkaller on arm64 as that booted cleanly to begin with.
>
> Mark.
>
> diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
> index 3ed4e8771b64..bca3c6fa8270 100644
> --- a/include/linux/irqflags.h
> +++ b/include/linux/irqflags.h
> @@ -220,10 +220,26 @@ do {                                              \
>
>  #else /* !CONFIG_TRACE_IRQFLAGS */
>
> +#ifdef CONFIG_DEBUG_IRQFLAGS
> +extern void warn_bogus_irq_restore(bool *warned);
> +#define check_bogus_irq_restore()                              \
> +       do {                                                    \
> +               static bool __section(".data.once") __warned;   \
> +               if (unlikely(!raw_irqs_disabled()))             \
> +                       warn_bogus_irq_restore(&__warned);      \
> +       } while (0)

What's the benefit of having a per-caller __warned instead of just
having a single global one in warn_bogus_irq_restore()?
