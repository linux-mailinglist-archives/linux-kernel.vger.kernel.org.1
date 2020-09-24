Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D23327711F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 14:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbgIXMfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 08:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727693AbgIXMfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 08:35:44 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18612C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DpcuMYD4jEoG38THcp6XiV+7QX2UnXwBqNOJDQFItmI=; b=Y7YWXSZ++ciF/dmXsdZ/qsGvVO
        JWbaBi3li8dDMPkdbLSP9TzwW7EsnVSicFq/enlNCylxrsxzYcsdYe30BxQqvhMYSklCZnWYeBq+l
        pTXJ/3u8arfzhXlTMWRNX3NUkODsfhI7z78SlawE2h3hPIc70vHuKBjoA6xYEXclAHDV6oY0L9mCE
        u4ktOmqy0h37D1wE1yTQms7TEbm8QinWAzwCxCne/rjmx0iYRHJgmtO10sxawCQNOmH8nNfKprGvR
        ie8qQq5dMX6+1tByBpSJXkwW46xquaJc7kP7QJZocgX684seQUMd4wvWcKHXdLMDqoHF050x7u4CI
        zN3Bo6zA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kLQTB-0002oJ-0M; Thu, 24 Sep 2020 12:35:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9BB473007CD;
        Thu, 24 Sep 2020 14:35:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8712F20315103; Thu, 24 Sep 2020 14:35:27 +0200 (CEST)
Date:   Thu, 24 Sep 2020 14:35:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com
Subject: Re: [PATCH 7/9] sched: Add migrate_disable()
Message-ID: <20200924123527.GJ2628@hirez.programming.kicks-ass.net>
References: <20200921163557.234036895@infradead.org>
 <20200921163845.769861942@infradead.org>
 <jhj5z83mlvu.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhj5z83mlvu.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 12:53:25PM +0100, Valentin Schneider wrote:
> > @@ -1830,8 +1892,19 @@ static int migration_cpu_stop(void *data
> >   */
> >  void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_mask, u32 flags)
> >  {
> > -	cpumask_copy(&p->cpus_mask, new_mask);
> > -	p->nr_cpus_allowed = cpumask_weight(new_mask);
> > +	if (flags & SCA_MIGRATE_DISABLE) {
> > +		p->cpus_ptr = new_mask;
> > +		p->nr_cpus_allowed = 1;
> > +		return;
> > +	}
> > +
> > +	if (flags & SCA_MIGRATE_ENABLE)
> > +		p->cpus_ptr = &p->cpus_mask;
> 
> There's that check in __set_cpus_allowed_ptr() that new_mask *must* be
> p->cpus_mask when SCA_MIGRATE_ENABLE; that means we could mayhaps shuffle
> that to:
> 
> ---
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 7cb13df48366..e0e4e42c5e32 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1892,18 +1892,14 @@ static int migration_cpu_stop(void *data)
>   */
>  void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_mask, u32 flags)
>  {
> +	if (flags & (SCA_MIGRATE_DISABLE | SCA_MIGRATE_ENABLE))
>                 p->cpus_ptr = new_mask;
>         else
>                 cpumask_copy(&p->cpus_mask, new_mask);
> 
> +	if (flags & SCA_MIGRATE_DISABLE)
> +		p->nr_cpus_allowed = 1;
> +	else if (p->cpus_ptr == &p->cpus_mask)
>                 p->nr_cpus_allowed = cpumask_weight(p->cpus_ptr);
>  }

I'm thinking we should let nr_cpus_allowed reflect ->cpus_mask
unconditionally. See these emails:

  https://lkml.kernel.org/r/20200923170809.GY1362448@hirez.programming.kicks-ass.net
  https://lkml.kernel.org/r/20200924082717.GA1362448@hirez.programming.kicks-ass.net

Basically we want to keep migrate_disable() tasks elegible for
migration/PULL.

But yes, I think that function can be simplified.
