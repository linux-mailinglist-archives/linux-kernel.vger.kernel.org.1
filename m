Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9939F2E9327
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 11:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbhADKO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 05:14:58 -0500
Received: from foss.arm.com ([217.140.110.172]:57920 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbhADKO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 05:14:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B06A3101E;
        Mon,  4 Jan 2021 02:14:11 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.37.95])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27C023F70D;
        Mon,  4 Jan 2021 02:14:09 -0800 (PST)
Date:   Mon, 4 Jan 2021 10:14:02 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] lockdep: report broken irq restoration
Message-ID: <20210104101402.GA1482@C02TD0UTHF1T.local>
References: <20201209183337.1912-1-mark.rutland@arm.com>
 <20201217143640.GZ3040@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217143640.GZ3040@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 03:36:40PM +0100, Peter Zijlstra wrote:
> On Wed, Dec 09, 2020 at 06:33:37PM +0000, Mark Rutland wrote:
> > This means that a seuence such as:
> 
> +q
> 
> > diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
> > index 3ed4e8771b64..bca3c6fa8270 100644
> > --- a/include/linux/irqflags.h
> > +++ b/include/linux/irqflags.h
> > @@ -220,10 +220,26 @@ do {						\
> >  
> >  #else /* !CONFIG_TRACE_IRQFLAGS */
> >  
> > +#ifdef CONFIG_DEBUG_IRQFLAGS
> > +extern void warn_bogus_irq_restore(bool *warned);
> > +#define check_bogus_irq_restore()				\
> > +	do {							\
> > +		static bool __section(".data.once") __warned;	\
> > +		if (unlikely(!raw_irqs_disabled()))		\
> > +			warn_bogus_irq_restore(&__warned);	\
> > +	} while (0)
> > +#else
> > +#define check_bogus_irq_restore() do { } while (0)
> > +#endif
> > +
> >  #define local_irq_enable()	do { raw_local_irq_enable(); } while (0)
> >  #define local_irq_disable()	do { raw_local_irq_disable(); } while (0)
> >  #define local_irq_save(flags)	do { raw_local_irq_save(flags); } while (0)
> > -#define local_irq_restore(flags) do { raw_local_irq_restore(flags); } while (0)
> > +#define local_irq_restore(flags)		\
> > +	do {					\
> > +		check_bogus_irq_restore();	\
> > +		raw_local_irq_restore(flags);	\
> > +	} while (0)
> 
> Shouldn't that be in raw_local_irq_restore() ?

Yup, that'd be preferable. Note that will require a refactoring here if
we want the warning to be available regardless of CONFIG_TRACE_IRQFLAGS.

I'd intended to rejig that for v2, but I didn't get the chance before
finishing work for the year, and had only done some basic rework in my
WIP (e.g. removing the per-instance bool as per Andy's comments):

https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?h=fuzzing/5.10-rc7&id=61336e25d1415a4ac3aaf8cf75105c2ec2eb95e7

I'll try to respin that in the next few days if I get the chance.

Thanks,
Mark.

> 
> >  #define safe_halt()		do { raw_safe_halt(); } while (0)
> >  
> >  #endif /* CONFIG_TRACE_IRQFLAGS */
> 
> --- a/include/linux/irqflags.h
> +++ b/include/linux/irqflags.h
> @@ -162,6 +162,7 @@ do {						\
>  #define raw_local_irq_restore(flags)			\
>  	do {						\
>  		typecheck(unsigned long, flags);	\
> +		check_bogus_irq_restore();		\
>  		arch_local_irq_restore(flags);		\
>  	} while (0)
>  #define raw_local_save_flags(flags)			\
> @@ -235,11 +236,7 @@ extern void warn_bogus_irq_restore(bool
>  #define local_irq_enable()	do { raw_local_irq_enable(); } while (0)
>  #define local_irq_disable()	do { raw_local_irq_disable(); } while (0)
>  #define local_irq_save(flags)	do { raw_local_irq_save(flags); } while (0)
> -#define local_irq_restore(flags)		\
> -	do {					\
> -		check_bogus_irq_restore();	\
> -		raw_local_irq_restore(flags);	\
> -	} while (0)
> +#define local_irq_restore(flags) do { raw_local_irq_restore(flags); } while (0)
>  #define safe_halt()		do { raw_safe_halt(); } while (0)
>  
>  #endif /* CONFIG_TRACE_IRQFLAGS */
