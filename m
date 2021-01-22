Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48F05300C96
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 20:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730516AbhAVT0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 14:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729786AbhAVTPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 14:15:17 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2B8C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 11:14:36 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id u16so755789qvo.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 11:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Py8MjXlde3K/2wSxCvgyBlWJLLtZnHs44qLUqstYM9o=;
        b=uvvAUCpgJr6i541gryy3vMZyO+jlZ+LopT45Sc9uLn5G87K0xoy8tWxefAJX5R8mOL
         Wi6QZkrEgXFcN4Rnfkfe7z5simMfkvWn0iB7bnRjLr4vD2wqnjVqrxg4QWZyJwha2egY
         GBz1fC9YD3plx0Jmna9PKmfXqGjfQT8HynTlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Py8MjXlde3K/2wSxCvgyBlWJLLtZnHs44qLUqstYM9o=;
        b=dFRdRJEuu88yqUTIP8jNq1lmjie16iHchvKjoBO7EWvdxAX8TR/oBEPCXXCA39Sc6t
         ZOvC/Lb+CuB8Xbr9soFkD4idbfF+j3LBfh91wFWuTP7eKwZSgpeRQinH8vT7uXgW0C3l
         7ZOvi90LQbQEagWosdYU4kO/Nb7Eq8xJ1wmjY3X+BjGCCVELcnGXTGWTFLtznRlDXrxS
         5O6nIhD7qENoZmymGuuSMGCD1CZBoJ0I0lHqA4yzm3BSFyO1MkELgNfPa5D6ickkWqn5
         pP8pQsztkOW5WVkWvE9zcC9EXpoSwROJp9ZO/y7CtVOfofljWOo3U+EdZy1fkAemv+dr
         ol5g==
X-Gm-Message-State: AOAM533mLR9C05wsDAVBfpJ0vjuhpHjNWmHavPpCpraSHFfrZ0z0zCe+
        UPCbbWKZBODovVn8ZcRRdhHAQ499+3478w==
X-Google-Smtp-Source: ABdhPJwKFB6sGJHsRsYbOmB8ZPfxj2x8s82RxXPxwuXmMAECp5yrCkvKilB9zycn7tLTJTUrQAc0eg==
X-Received: by 2002:ad4:4f4a:: with SMTP id eu10mr5976653qvb.17.1611342876108;
        Fri, 22 Jan 2021 11:14:36 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id m6sm843344qkm.25.2021.01.22.11.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 11:14:35 -0800 (PST)
Date:   Fri, 22 Jan 2021 14:14:35 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Dietmar Eggeman <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] sched/fair: Rate limit calls to
 update_blocked_averages() for NOHZ
Message-ID: <YAskGxlUnd6SkbYt@google.com>
References: <20210122154600.1722680-1-joel@joelfernandes.org>
 <CAKfTPtAnzhDKXayicDdymWpK1UswfkTaO8vL-WHxVaoj7DaCFw@mail.gmail.com>
 <20210122183927.ivqyapttzd6lflwk@e107158-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122183927.ivqyapttzd6lflwk@e107158-lin>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 06:39:27PM +0000, Qais Yousef wrote:
> On 01/22/21 17:56, Vincent Guittot wrote:
> > > ---
> > >  kernel/sched/fair.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 04a3ce20da67..fe2dc0024db5 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -8381,7 +8381,7 @@ static bool update_nohz_stats(struct rq *rq, bool force)
> > >         if (!cpumask_test_cpu(cpu, nohz.idle_cpus_mask))
> > >                 return false;
> > >
> > > -       if (!force && !time_after(jiffies, rq->last_blocked_load_update_tick))
> > > +       if (!force && !time_after(jiffies, rq->last_blocked_load_update_tick + (HZ/20)))
> > 
> > This condition is there to make sure to update blocked load at most
> > once a tick in order to filter newly idle case otherwise the rate
> > limit is already done by load balance interval
> > This hard coded (HZ/20) looks really like an ugly hack
> 
> This was meant as an RFC patch to discuss the problem really.

Agreed, sorry.

> Joel is seeing update_blocked_averages() taking ~100us. Half of it seems in
> processing __update_blocked_fair() and the other half in sugov_update_shared().
> So roughly 50us each. Note that each function is calling an iterator in
> return. Correct me if my numbers are wrong Joel.

Correct, and I see update_nohz_stats() itself called around 8 times during a
load balance which multiplies the overhead.

Dietmar found out also that the reason for update_nohz_stacks() being called
8 times is because in our setup, there is only 1 MC sched domain with all 8
CPUs, versus say 2 MC domains with 4 CPUs each.

> Running on a little core on low frequency these numbers don't look too odd.
> So I'm not seeing how we can speed these functions up.

Agreed.

> But since update_sg_lb_stats() will end up with multiple calls to
> update_blocked_averages() in one go, this latency adds up quickly.

True!

> One noticeable factor in Joel's system is the presence of a lot of cgroups.
> Which is essentially what makes __update_blocked_fair() expensive, and it seems
> to always return something has decayed so we end up with a call to
> sugov_update_shared() in every call.

Correct.

thanks,

 - Joel

[..]
