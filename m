Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE152FF7AD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 23:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbhAUWAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 17:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbhAUV7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 16:59:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1A0C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 13:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UewABybWMZqLBq93chuTLCPLENADQxY/dhFoXvYm8EU=; b=aV9NF7icJO1jxKknKZ9wyVSF4p
        HBUUuo38yX77faBby3LOMDWBz58KAfk2YPZEwvPu/WjGVQ+fJiLOgxAl+KmUny/mXOOsdHv5tVrcB
        mYXsFREkHnK14UdJWyHOSLUNojApXM+QHXoEKyUAxkvjW146+ROfhna7/HeY1DNAJhH/0QNL5zbQD
        FmoA+QE5w+DCvVaa6LY3RIbc+8HQGckVRMBvRUrtyPq8kfrtJLesMlgl9U+JMyViu6LFf6GMic0Ad
        forRXRuEBDUnQEZoARHUYCewkE9uGHV3sfvSx5gco7wfm+L91pkw7HG/2fhf3G165VuhAppCVrJG+
        VHPU39qQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l2hyG-00HZzg-Gy; Thu, 21 Jan 2021 21:58:33 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id A16129841F6; Thu, 21 Jan 2021 22:58:26 +0100 (CET)
Date:   Thu, 21 Jan 2021 22:58:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH 6/8] preempt/dynamic: Provide
 preempt_schedule[_notrace]() static calls
Message-ID: <20210121215826.GB16371@worktop.programming.kicks-ass.net>
References: <20210118141223.123667-1-frederic@kernel.org>
 <20210118141223.123667-7-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118141223.123667-7-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 03:12:21PM +0100, Frederic Weisbecker wrote:
> diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
> index 69485ca13665..3db9cb8b1a25 100644
> --- a/arch/x86/include/asm/preempt.h
> +++ b/arch/x86/include/asm/preempt.h
> @@ -5,6 +5,7 @@
>  #include <asm/rmwcc.h>
>  #include <asm/percpu.h>
>  #include <linux/thread_info.h>
> +#include <linux/static_call_types.h>
>  
>  DECLARE_PER_CPU(int, __preempt_count);
>  
> @@ -103,16 +104,33 @@ static __always_inline bool should_resched(int preempt_offset)
>  }
>  
>  #ifdef CONFIG_PREEMPTION
> -  extern asmlinkage void preempt_schedule_thunk(void);
> -# define __preempt_schedule() \
> -	asm volatile ("call preempt_schedule_thunk" : ASM_CALL_CONSTRAINT)
>  
> -  extern asmlinkage void preempt_schedule(void);
> -  extern asmlinkage void preempt_schedule_notrace_thunk(void);
> -# define __preempt_schedule_notrace() \
> -	asm volatile ("call preempt_schedule_notrace_thunk" : ASM_CALL_CONSTRAINT)
> +extern asmlinkage void preempt_schedule(void);
> +extern asmlinkage void preempt_schedule_thunk(void);
> +
> +#define __preempt_schedule_func() preempt_schedule_thunk
> +
> +DECLARE_STATIC_CALL(preempt_schedule, __preempt_schedule_func());
> +
> +#define __preempt_schedule() \
> +do { \
> +	__ADDRESSABLE(STATIC_CALL_KEY(preempt_schedule)); \
> +	asm volatile ("call " STATIC_CALL_TRAMP_STR(preempt_schedule) : ASM_CALL_CONSTRAINT); \
> +} while (0)
> +
> +extern asmlinkage void preempt_schedule_notrace(void);
> +extern asmlinkage void preempt_schedule_notrace_thunk(void);
> +
> +#define __preempt_schedule_notrace_func() preempt_schedule_notrace_thunk
> +
> +DECLARE_STATIC_CALL(preempt_schedule_notrace, __preempt_schedule_notrace_func());
> +
> +#define __preempt_schedule_notrace() \
> +do { \
> +	__ADDRESSABLE(STATIC_CALL_KEY(preempt_schedule_notrace)); \
> +	asm volatile ("call " STATIC_CALL_TRAMP_STR(preempt_schedule_notrace) : ASM_CALL_CONSTRAINT); \
> +} while (0)
>  
> -  extern asmlinkage void preempt_schedule_notrace(void);
>  #endif

I'm thinking the above doesn't build for !PREEMPT_DYNAMIC, given it
relies on the STATIC_CALL unconditionally, but we only define it for
PREEMPT_DYNAMIC:

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index d6de12b4eef2..faff4b546c5f 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5251,6 +5251,12 @@ asmlinkage __visible void __sched notrace preempt_schedule(void)
>  NOKPROBE_SYMBOL(preempt_schedule);
>  EXPORT_SYMBOL(preempt_schedule);
>  
> +#ifdef CONFIG_PREEMPT_DYNAMIC
> +DEFINE_STATIC_CALL(preempt_schedule, __preempt_schedule_func());
> +EXPORT_STATIC_CALL(preempt_schedule);
> +#endif
> +
> +
>  /**
>   * preempt_schedule_notrace - preempt_schedule called by tracing
>   *
> @@ -5303,6 +5309,12 @@ asmlinkage __visible void __sched notrace preempt_schedule_notrace(void)
>  }
>  EXPORT_SYMBOL_GPL(preempt_schedule_notrace);
>  
> +#ifdef CONFIG_PREEMPT_DYNAMIC
> +DEFINE_STATIC_CALL(preempt_schedule_notrace, __preempt_schedule_notrace_func());
> +EXPORT_STATIC_CALL(preempt_schedule_notrace);
> +#endif
> +
> +
>  #endif /* CONFIG_PREEMPTION */
>  
>  /*
> -- 
> 2.25.1
> 
