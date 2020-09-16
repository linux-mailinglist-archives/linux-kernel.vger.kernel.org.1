Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3900026BEE2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 10:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgIPIM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 04:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgIPIMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 04:12:46 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1699CC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 01:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8wPpk2m1xqSm+HjJd05kDMtl7UoPIi25s1Mdrmo0nu4=; b=3QWLESToOrMzlAIh+XFJoQjKnU
        UmaWN6PVLarQoervt9C9otjeyfOMmYUlT3tT16/k3dFqNAMNxTadcn7pODjLYxWD0jw633c1jad2N
        9WkmW/gLiMmfVmOek450lMV9iNw+SQoC8SowaPaW4lDEeaedqaXvovV1SCed2CigqY9abGIMM4lL6
        CCC1X+PtT+3buwIAN3Sqm08XRynCmD0wsIAPLf30TNEgHfztiu7QCz09A0cpb8+ga9HsQd8Mx5ETM
        UFw/HROpSs1xQ5JM1wy2vYQaOHRb05Dtri4nmUYQQGp2SpA4WNeRsj/cq9mr2+iaOWekhfoSNtgva
        jCnj1jJg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kISYG-000655-9m; Wed, 16 Sep 2020 08:12:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 35A543012C3;
        Wed, 16 Sep 2020 10:12:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EFC6B2C27E219; Wed, 16 Sep 2020 10:12:25 +0200 (CEST)
Date:   Wed, 16 Sep 2020 10:12:25 +0200
From:   peterz@infradead.org
To:     Xu Wang <vulab@iscas.ac.cn>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] stats: Replace seq_printf with seq_puts
Message-ID: <20200916081225.GJ2674@hirez.programming.kicks-ass.net>
References: <20200916034415.25645-1-vulab@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916034415.25645-1-vulab@iscas.ac.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 03:44:15AM +0000, Xu Wang wrote:
> seq_puts is a lot cheaper than seq_printf, so use that to print
> literal strings.

performance is not a consideration here.

> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
> ---
>  kernel/sched/stats.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
> index 750fb3c67eed..0818fe03407a 100644
> --- a/kernel/sched/stats.c
> +++ b/kernel/sched/stats.c
> @@ -37,7 +37,7 @@ static int show_schedstat(struct seq_file *seq, void *v)
>  		    rq->rq_cpu_time,
>  		    rq->rq_sched_info.run_delay, rq->rq_sched_info.pcount);
>  
> -		seq_printf(seq, "\n");
> +		seq_putc(seq, '\n');

And yet, the changelog says seq_put*s*().

>  
>  #ifdef CONFIG_SMP
>  		/* domain-specific stats */
> -- 
> 2.17.1
> 
