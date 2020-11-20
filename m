Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C812BA708
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 11:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgKTKGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 05:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbgKTKGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 05:06:42 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A91C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 02:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kpcLQ0wmEah9mjg/fNkxJpWXmr9w5FwmiLVGgKluZmo=; b=N4pumsTrG/j67qvEkLdcj5JQc/
        OU87HFBrpe61aUZGHs76hJhEYEANnsiTfmQUABwk4sa08VSW/ttt+XCXfoEOONFb23feKls49hX1V
        +gLmbnZKug33SFQQHhA0zWLYNNgm5Mi5evGUink12uw5dLSU0oWzOsjGO/hC5LdWmPVSpSgyvUww2
        QMeQQn+ROAPKimxaXDgI3BBuQeXPt1St9/+O01Ob8YwzdOwQ9e3TPG/eNuxjR349fhhRQyflrpCwP
        AhV3yR325zzGW0LQDoF6n2ohhEI0Edx+66oCd8+BFMIJng3toOXtnBEjxJKjr4JTQOQ3hZ/wV582+
        BtH+YrhQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kg3JE-0003MC-J8; Fri, 20 Nov 2020 10:06:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E0227305C16;
        Fri, 20 Nov 2020 11:06:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D03C9200E6202; Fri, 20 Nov 2020 11:06:25 +0100 (CET)
Date:   Fri, 20 Nov 2020 11:06:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anton Vorontsov <anton.vorontsov@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kernel/cpu: add arch override for
 clear_tasks_mm_cpumask() mm handling
Message-ID: <20201120100625.GB3021@hirez.programming.kicks-ass.net>
References: <20201120025757.325930-1-npiggin@gmail.com>
 <20201120025757.325930-2-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120025757.325930-2-npiggin@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 12:57:56PM +1000, Nicholas Piggin wrote:
> powerpc keeps a counter in the mm which counts bits set in mm_cpumask as
> well as other things. This means it can't use generic code to clear bits
> out of the mask and doesn't adjust the arch specific counter.
> 
> Add an arch override allowing powerpc to use clear_tasks_mm_cpumask().
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Seems reasonable enough..

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  kernel/cpu.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 6ff2578ecf17..2b8d7a5db383 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -815,6 +815,10 @@ void __init cpuhp_threads_init(void)
>  }
>  
>  #ifdef CONFIG_HOTPLUG_CPU
> +#ifndef arch_clear_mm_cpumask_cpu
> +#define arch_clear_mm_cpumask_cpu(cpu, mm) cpumask_clear_cpu(cpu, mm_cpumask(mm))
> +#endif
> +
>  /**
>   * clear_tasks_mm_cpumask - Safely clear tasks' mm_cpumask for a CPU
>   * @cpu: a CPU id
> @@ -850,7 +854,7 @@ void clear_tasks_mm_cpumask(int cpu)
>  		t = find_lock_task_mm(p);
>  		if (!t)
>  			continue;
> -		cpumask_clear_cpu(cpu, mm_cpumask(t->mm));
> +		arch_clear_mm_cpumask_cpu(cpu, t->mm);
>  		task_unlock(t);
>  	}
>  	rcu_read_unlock();
> -- 
> 2.23.0
> 
