Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1719B2C4B51
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 00:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729592AbgKYXFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 18:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729156AbgKYXFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 18:05:23 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37A6C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 15:05:23 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id e8so3780503pfh.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 15:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oaJWr2YGXviCe89v0RSfWFZYaQdQ0/Bq2xZyRaBFk2E=;
        b=B0xC15rNitSDcQjIVpWzgdx70TE744eHe0l/IPV70amVx7E5qPVTOuHnx+sFXSI8Vn
         WruuN5coCeb3qV7w3tHCOyfr9+Nf3wLIqmm2vdAPi0SqzLtmK8X6wlMPejLDzvn+hDEo
         HY3Au9xke9kDpBPGCs8QFPSami97mnD/qZn/xFZ7Rf1y7tX4XRdq4co6Cvhs3pcosGxl
         G0k6UObRwaYC3KtFYs4o0H6sGzi/1aMsH6infav6/2JkJ0D+dqd+b2T9VU1g99jzChFj
         SGLIOS9sQR8a+Pof3NFVVLfpn+ur0VWud6fzjZMSfSwJ6amtURBGQjEbG52TJoPISn7y
         IjLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oaJWr2YGXviCe89v0RSfWFZYaQdQ0/Bq2xZyRaBFk2E=;
        b=emGCeUHZyEAv82UgAtQcdkXq7nXp8vR3S5DZZ1lE6+t6N595pJkqszMg6UDmp8b6VA
         JXxMmCM+te1hHr+zkbNtAhl7M7SxEp8arJCULrBR3N7oxN7NKK2xsoA+aF+1R53et1UW
         SK7FJ/LPebopwfmTAdbJqKiLCIlKhIv2vH3VxiKo3F85lwaOapjjGs7JtPXKTKOdyHQu
         F60qccVLAuTq6e1CkMWLGmwOWhjibA5BB4w8m89Bq8PrZAZq9LlyOpMuPyMYK5vX4wNG
         m2Y45vEGZ3GcyW0kyd92L4w61UYC8ipDGKEQEeKRped7WuDHXfNvPA8/SpTJ2MGeurFS
         KPMw==
X-Gm-Message-State: AOAM533eYdva5paVjVJ0pS7lf1gFjPNB7NRWD0yNJ7XCaYjdqo310tpM
        BAvo+Xs+r5962VSWAJJiqy8=
X-Google-Smtp-Source: ABdhPJw6rG5pyTHpPF8MQ9foRYJRh5AqxW5Kfun2yMBx4tjl94e4B7caBMWVquZMeKZ7r1Qtx7CXyA==
X-Received: by 2002:a65:6a13:: with SMTP id m19mr156714pgu.260.1606345523065;
        Wed, 25 Nov 2020 15:05:23 -0800 (PST)
Received: from localhost (61-68-227-232.tpgi.com.au. [61.68.227.232])
        by smtp.gmail.com with ESMTPSA id y3sm4268206pjb.18.2020.11.25.15.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 15:05:21 -0800 (PST)
Date:   Thu, 26 Nov 2020 10:05:19 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        pjt@google.com, rostedt@goodmis.org, derkling@google.com,
        benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>, jsbarnes@google.com,
        chris.hyser@oracle.com, Ben Segall <bsegall@google.com>,
        Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH -tip 10/32] sched: Fix priority inversion of cookied task
 with sibling
Message-ID: <20201125230519.GC163610@balbir-desktop>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-11-joel@joelfernandes.org>
 <20201122224123.GE110669@balbir-desktop>
 <20201124183038.GG1021337@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124183038.GG1021337@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 01:30:38PM -0500, Joel Fernandes wrote:
> On Mon, Nov 23, 2020 at 09:41:23AM +1100, Balbir Singh wrote:
> > On Tue, Nov 17, 2020 at 06:19:40PM -0500, Joel Fernandes (Google) wrote:
> > > From: Peter Zijlstra <peterz@infradead.org>
> > > 
> > > The rationale is as follows. In the core-wide pick logic, even if
> > > need_sync == false, we need to go look at other CPUs (non-local CPUs) to
> > > see if they could be running RT.
> > > 
> > > Say the RQs in a particular core look like this:
> > > Let CFS1 and CFS2 be 2 tagged CFS tags. Let RT1 be an untagged RT task.
> > > 
> > > rq0            rq1
> > > CFS1 (tagged)  RT1 (not tag)
> > > CFS2 (tagged)
> > > 
> > > Say schedule() runs on rq0. Now, it will enter the above loop and
> > > pick_task(RT) will return NULL for 'p'. It will enter the above if() block
> > > and see that need_sync == false and will skip RT entirely.
> > > 
> > > The end result of the selection will be (say prio(CFS1) > prio(CFS2)):
> > > rq0             rq1
> > > CFS1            IDLE
> > > 
> > > When it should have selected:
> > > rq0             r1
> > > IDLE            RT
> > > 
> > > Joel saw this issue on real-world usecases in ChromeOS where an RT task
> > > gets constantly force-idled and breaks RT. Lets cure it.
> > > 
> > > NOTE: This problem will be fixed differently in a later patch. It just
> > >       kept here for reference purposes about this issue, and to make
> > >       applying later patches easier.
> > >
> > 
> > The changelog is hard to read, it refers to above if(), whereas there
> > is no code snippet in the changelog.
> 
> Yeah sorry, it comes from this email where I described the issue:
> http://lore.kernel.org/r/20201023175724.GA3563800@google.com
> 
> I corrected the changelog and appended the patch below. Also pushed it to:
> https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/log/?h=coresched
> 
> > Also, from what I can see following
> > the series, p->core_cookie is not yet set anywhere (unless I missed it),
> > so fixing it in here did not make sense just reading the series.
> 
> The interface patches for core_cookie are added later, that's how it is. The
> infrastructure comes first here. It would also not make sense to add
> interface first as well so I think the current ordering is fine.
>

Some comments below to help make the code easier to understand

> ---8<-----------------------
> 
> From: Peter Zijlstra <peterz@infradead.org>
> Subject: [PATCH] sched: Fix priority inversion of cookied task with sibling
> 
> The rationale is as follows. In the core-wide pick logic, even if
> need_sync == false, we need to go look at other CPUs (non-local CPUs) to
> see if they could be running RT.
> 
> Say the RQs in a particular core look like this:
> Let CFS1 and CFS2 be 2 tagged CFS tags. Let RT1 be an untagged RT task.
> 
> rq0            rq1
> CFS1 (tagged)  RT1 (not tag)
> CFS2 (tagged)
> 
> The end result of the selection will be (say prio(CFS1) > prio(CFS2)):
> rq0             rq1
> CFS1            IDLE
> 
> When it should have selected:
> rq0             r1
> IDLE            RT
> 
> Fix this issue by forcing need_sync and restarting the search if a
> cookied task was discovered. This will avoid this optimization from
> making incorrect picks.
> 
> Joel saw this issue on real-world usecases in ChromeOS where an RT task
> gets constantly force-idled and breaks RT. Lets cure it.
> 
> NOTE: This problem will be fixed differently in a later patch. It just
>       kept here for reference purposes about this issue, and to make
>       applying later patches easier.
> 
> Reported-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/sched/core.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 4ee4902c2cf5..53af817740c0 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5195,6 +5195,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  	need_sync = !!rq->core->core_cookie;
>  
>  	/* reset state */
> +reset:
>  	rq->core->core_cookie = 0UL;
>  	if (rq->core->core_forceidle) {
>  		need_sync = true;
> @@ -5242,14 +5243,8 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  				/*
>  				 * If there weren't no cookies; we don't need to
>  				 * bother with the other siblings.
> -				 * If the rest of the core is not running a tagged
> -				 * task, i.e.  need_sync == 0, and the current CPU
> -				 * which called into the schedule() loop does not
> -				 * have any tasks for this class, skip selecting for
> -				 * other siblings since there's no point. We don't skip
> -				 * for RT/DL because that could make CFS force-idle RT.
>  				 */
> -				if (i == cpu && !need_sync && class == &fair_sched_class)
> +				if (i == cpu && !need_sync)
>  					goto next_class;
>  
>  				continue;
> @@ -5259,7 +5254,20 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  			 * Optimize the 'normal' case where there aren't any
>  			 * cookies and we don't need to sync up.
>  			 */
> -			if (i == cpu && !need_sync && !p->core_cookie) {
> +			if (i == cpu && !need_sync) {
> +				if (p->core_cookie) {
> +					/*
> +					 * This optimization is only valid as
> +					 * long as there are no cookies

This is not entirely true, need_sync is a function of core cookies, so I
think this needs more clarification, it sounds like we enter this when
the core has no cookies, but the task has a core_cookie? The term cookie
is quite overloaded when used in the context of core vs task.

Effectively from what I understand this means that p wants to be
coscheduled, but the core itself is not coscheduling anything at the
moment, so we need to see if we should do a sync and that sync might
cause p to get kicked out and a higher priority class to come in?

Balbir Singh.
