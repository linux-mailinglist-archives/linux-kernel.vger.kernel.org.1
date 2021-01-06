Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1BA12EC030
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 16:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbhAFPMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 10:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbhAFPMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 10:12:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A99C061357
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 07:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uPchyfz0vGTehwlQ5FJoJgmvWuNaFk36qEcIJqQkrpk=; b=WNrzZfqY7aXN+HSMk1jrgUeNni
        W5FraVNVujXxWtP0oUJTOenAs+HMY2XfCRI/QFxzbiFCZtNCAz2UcEY8Qt1HkugTr2YIn1uPDh6AB
        20NgjHxFAXXH3p/u/fabK6sJxZ6whFxXIZeFmonPgX7Dc+rzqPcX1Zrh5keD9YfbGiTLI1nCMrsxX
        o7EqVk4mutcESOlhOLEQaLq6+etAJhGJHvffeAzEStlYade7woPJV1wKtbOwmFHS2W0J71zcFBFQf
        MUe7P5Wc59RV9/FGth82Sonu4IDbLYeCiBcnjYII3j/02sBLdiuGqmukU0Mx9gCfjQokW5jG9HvNU
        XlcW6FJg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kxAP2-002RhU-Ao; Wed, 06 Jan 2021 15:07:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E2D423013E5;
        Wed,  6 Jan 2021 16:07:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CB41E202A3CED; Wed,  6 Jan 2021 16:07:11 +0100 (CET)
Date:   Wed, 6 Jan 2021 16:07:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] sched/fair: don't set LBF_ALL_PINNED unnecessarily
Message-ID: <X/XSH7Qv58pSpi95@hirez.programming.kicks-ass.net>
References: <20210106133419.2971-1-vincent.guittot@linaro.org>
 <20210106133419.2971-3-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106133419.2971-3-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 02:34:18PM +0100, Vincent Guittot wrote:
> Setting LBF_ALL_PINNED during active load balance is only valid when there
> is only 1 running task on the rq otherwise this ends up increasing the
> balance interval whereas other tasks could migrate after the next interval
> once they become cache-cold as an example.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 5428b8723e61..69a455113b10 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9759,7 +9759,8 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>  			if (!cpumask_test_cpu(this_cpu, busiest->curr->cpus_ptr)) {
>  				raw_spin_unlock_irqrestore(&busiest->lock,
>  							    flags);
> -				env.flags |= LBF_ALL_PINNED;
> +				if (busiest->nr_running == 1)
> +					env.flags |= LBF_ALL_PINNED;
>  				goto out_one_pinned;
>  			}

Hmm.. that wasn't the intention. It's entirely possible to have multiple
tasks pinned.

ISTR we set all-pinned and then clear it in can_migrate_task() when we
actually find a task that can be moved to the destination CPU. That's a
construct that works perfectly fine with multiple tasks.


