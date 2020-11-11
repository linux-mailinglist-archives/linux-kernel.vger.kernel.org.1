Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B92C2AF3AD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 15:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgKKOfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 09:35:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbgKKOfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 09:35:04 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A875C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 06:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gKQW8wrBXMx4h7DmNhEbvtfru823Knh6YHZ3Q+i7p28=; b=RiDKkC+BxVALA5cEN2HG/KMiCd
        AREIC9okILYpOjcqICa5ew22sfJAzMBQAkM+5YRGGWDdPZJrN3a9lJDzfRJ47U04atUJBvxTjOX04
        SAsjH3PBFByF82ibDI98cOphB451yBvtHqoDXzA8LknqDwGvHIdXHk9YFp/+gaddzULgYxJ3o5obW
        PtNSRO1dNN/WinLebdqgIyGfKC43iBiXPyaOJRfJh4kwziM+379fik7vnk5eKgSjjstrE+TrM5Rif
        BXPD3OOjkH/k4TfHVc9iubPgXmNSallN9P01MafEvJQVx8pqYM3V69+uAtVw2/Lw7OnD49Qt8xj+R
        yIOnF2fA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcrD9-0007ca-95; Wed, 11 Nov 2020 14:34:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1FD47301E02;
        Wed, 11 Nov 2020 15:34:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0B1462BDF96A8; Wed, 11 Nov 2020 15:34:58 +0100 (CET)
Date:   Wed, 11 Nov 2020 15:34:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 4/5] context_tracking: Only define schedule_user() on
 !HAVE_CONTEXT_TRACKING_OFFSTACK archs
Message-ID: <20201111143458.GV2611@hirez.programming.kicks-ass.net>
References: <20201027150827.148821-1-frederic@kernel.org>
 <20201027150827.148821-5-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027150827.148821-5-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 04:08:26PM +0100, Frederic Weisbecker wrote:
> schedule_user() was traditionally used by the entry code's tail to
> preempt userspace after the call to user_enter(). Indeed the call to
> user_enter() used to be performed upon syscall exit slow path which was
> right before the last opportunity to schedule() while resuming to
> userspace. The context tracking state had to be saved on the task stack
> and set back to CONTEXT_KERNEL temporarily in order to safely switch to
> another task.
> 
> Only a few archs use it now and those implementing
> HAVE_CONTEXT_TRACKING_OFFSTACK definetly can't rely on it.

powerpc64 and sparc64 only, right?

> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Marcelo Tosatti <mtosatti@redhat.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Phil Auld <pauld@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/sched/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index c23d7cb5aee3..44426e5acde2 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4631,7 +4631,7 @@ void __sched schedule_idle(void)
>  	} while (need_resched());
>  }
>  
> -#ifdef CONFIG_CONTEXT_TRACKING
> +#if defined(CONFIG_CONTEXT_TRACKING) && !defined(CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK)
>  asmlinkage __visible void __sched schedule_user(void)
>  {
>  	/*
> -- 
> 2.25.1
> 
