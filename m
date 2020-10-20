Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4451D2935E2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 09:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbgJTHhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 03:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbgJTHhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 03:37:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74356C061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 00:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PobQ6/OralND/PItgqeZ+vTJb9YCELFFt9/y8aSEzvE=; b=SoiRekgrQfRMXnz6GdKxEVNY2Q
        7muAggzNTEW5n5qOBsj8ekbOp/hjObkNJ3c/4o03cyU4cCDMQrU4K7tN/IQl7tc0DqyAOc6XjPv7O
        dZ/KlaE5f5XVKAB6h5ttCNHZVHt/KkN7mHrXW9JVeVLeKwWXpJFEiY7wj6XR5+7bAD0Ke+TG5kqMX
        rPrImr9mwukAAdBIXjba6bFidk3KEGocM2SIr+IkqX/mHwsrCRqd0RpWma318LW+PRK9/3chrh9xg
        tfucMElqIMNnClVwk00w4BSSu76BZPn0LqCMtjlQ+m0FSK6n0TNMc7HtwXk+YEwkCDEyvfTawz0+S
        4+FkldHw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kUmCl-0003vd-4u; Tue, 20 Oct 2020 07:37:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 60FF53012C3;
        Tue, 20 Oct 2020 09:37:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 29F7C2B785030; Tue, 20 Oct 2020 09:37:10 +0200 (CEST)
Date:   Tue, 20 Oct 2020 09:37:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/2] sched/cpupri: Add CPUPRI_HIGHER
Message-ID: <20201020073710.GZ2611@hirez.programming.kicks-ass.net>
References: <20200922083934.19275-1-dietmar.eggemann@arm.com>
 <20201014195437.GD2974@worktop.programming.kicks-ass.net>
 <17c8a9b5-b63a-1a1a-f11b-5e00c2a6ad34@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17c8a9b5-b63a-1a1a-f11b-5e00c2a6ad34@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 04:15:01PM +0200, Dietmar Eggemann wrote:
> On 14/10/2020 21:54, Peter Zijlstra wrote:
> > 
> > Add CPUPRI_HIGHER above the RT99 priority to denote the CPU is in use
> > by higher priority tasks (specifically deadline).
> 
> sugov:X already triggers this now on our !fast-switching devices running
> schedutil.

Right, that would also be a nice test-case for:

> > XXX: we should probably drive PUSH-PULL from cpupri, that would
> > automagically result in an RT-PUSH when DL sets cpupri to CPUPRI_HIGHER.

This, once we get there..

> > @@ -54,6 +56,10 @@ static int convert_prio(int prio)
> 
> The BUG_ON could be tightened:
> 
> -       BUG_ON(prio >= MAX_PRIO);
> +       BUG_ON(prio > MAX_RT_PRIO);
> 

Maybe I've not had enough wake-up juice, but I can't seem to locate
this.

> >  	case MAX_RT_PRIO-1:
> >  		cpupri = CPUPRI_NORMAL;		/*  0 */
> >  		break;
> > +
> > +	case MAX_RT_PRIO:
> > +		cpupri = CPUPRI_HIGHER;		/* 100 */
> > +		break;
> >  	}
> > 
> >  	return cpupri;
> 
> Just saw that the comment for cpupri_set() needs changing:
> 
> @@ -205,7 +208,7 @@ int cpupri_find_fitness(struct cpupri *cp, struct
> task_struct *p,
>   * cpupri_set - update the CPU priority setting
>   * @cp: The cpupri context
>   * @cpu: The target CPU
> - * @newpri: The priority (INVALID-RT99) to assign to this CPU
> + * @newpri: The priority (INVALID-RT1-RT99-NORMAL-HIGHER) to assign to
> this CPU

I made that:

+ * @newpri: The priority (INVALID,NORMAL,RT1-RT99,HIGHER) to assign to this CPU

> 
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Thanks!
