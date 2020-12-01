Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4764E2CAA21
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 18:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731061AbgLARuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 12:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729578AbgLARuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 12:50:21 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427FEC0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 09:49:35 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id f15so1741111qto.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 09:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c4Mq9J2FUB6duTDiwvhuyQXSdHkEXOW9JI4GDS/id1k=;
        b=yAFJyOBtgfVFTchnyZknXnxssubkMeKTfU2YFG/pmDPsROqnElUPg8wQHUk9F9kpup
         AbBCOoKUPdBeqetwCN83a9PaEk2PZXB2FDUphZtmCkt0sciv1YRVSOebxj3nLZlUpryh
         Y/jCnkrc7mU8QvNKgAFQPdfaoIEl5091OT8h0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c4Mq9J2FUB6duTDiwvhuyQXSdHkEXOW9JI4GDS/id1k=;
        b=grSW/oqEqxX8d7ek+aEKYy2qlqv/eFPi5UkLSXdhGi50XaMBogCVvfy0CaxKk7U3Kr
         SKVSRZLwfauB6O1Rt/o5oY7GXX30dERl9wjAKv11IxqR8QsjuHWqFETzCteWtm1Dr8zB
         jfWxnmioTh88MbDBRJignvLX9y/sKZjn5rj4CLiwlhr48gFWitr2gMYVwc+YKgDH6NFm
         tRlt9u+yeYScSJprRQ1ZIHlgw/jW4jXxVrTiBmXwW+9iXIKd78QfX76K3ZU9cPqsiDL0
         P6521fcDV3+K3uf5QSqfRr0qNUommrdzYn2tZQbJIVfuaYQXj65FBOD51FVXCsmW22ZD
         5YBA==
X-Gm-Message-State: AOAM533tJzNexpc5sBg7TH8S/K4FHCYeu/CJL/hh2DFvcYx+9N6Pt+ZW
        OivpTqKor13EPoQ0mQWzkf3m5Q==
X-Google-Smtp-Source: ABdhPJx0l0v5LXoVlZcK0YI2vALuPvXDLsfDaR0dt8Ha2oJGvMhrxCupejMqitdZPFkSfRjdqD0s1A==
X-Received: by 2002:ac8:6c28:: with SMTP id k8mr4036252qtu.316.1606844974133;
        Tue, 01 Dec 2020 09:49:34 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id o16sm352836qkg.27.2020.12.01.09.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 09:49:33 -0800 (PST)
Date:   Tue, 1 Dec 2020 12:49:32 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Balbir Singh <bsingharora@gmail.com>
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
Message-ID: <20201201174932.GA201514@google.com>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-11-joel@joelfernandes.org>
 <20201122224123.GE110669@balbir-desktop>
 <20201124183038.GG1021337@google.com>
 <20201125230519.GC163610@balbir-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125230519.GC163610@balbir-desktop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 10:05:19AM +1100, Balbir Singh wrote:
> On Tue, Nov 24, 2020 at 01:30:38PM -0500, Joel Fernandes wrote:
> > On Mon, Nov 23, 2020 at 09:41:23AM +1100, Balbir Singh wrote:
> > > On Tue, Nov 17, 2020 at 06:19:40PM -0500, Joel Fernandes (Google) wrote:
> > > > From: Peter Zijlstra <peterz@infradead.org>
> > > > 
> > > > The rationale is as follows. In the core-wide pick logic, even if
> > > > need_sync == false, we need to go look at other CPUs (non-local CPUs) to
> > > > see if they could be running RT.
> > > > 
> > > > Say the RQs in a particular core look like this:
> > > > Let CFS1 and CFS2 be 2 tagged CFS tags. Let RT1 be an untagged RT task.
> > > > 
> > > > rq0            rq1
> > > > CFS1 (tagged)  RT1 (not tag)
> > > > CFS2 (tagged)
> > > > 
> > > > Say schedule() runs on rq0. Now, it will enter the above loop and
> > > > pick_task(RT) will return NULL for 'p'. It will enter the above if() block
> > > > and see that need_sync == false and will skip RT entirely.
> > > > 
> > > > The end result of the selection will be (say prio(CFS1) > prio(CFS2)):
> > > > rq0             rq1
> > > > CFS1            IDLE
> > > > 
> > > > When it should have selected:
> > > > rq0             r1
> > > > IDLE            RT
> > > > 
> > > > Joel saw this issue on real-world usecases in ChromeOS where an RT task
> > > > gets constantly force-idled and breaks RT. Lets cure it.
> > > > 
> > > > NOTE: This problem will be fixed differently in a later patch. It just
> > > >       kept here for reference purposes about this issue, and to make
> > > >       applying later patches easier.
> > > >
> > > 
> > > The changelog is hard to read, it refers to above if(), whereas there
> > > is no code snippet in the changelog.
> > 
> > Yeah sorry, it comes from this email where I described the issue:
> > http://lore.kernel.org/r/20201023175724.GA3563800@google.com
> > 
> > I corrected the changelog and appended the patch below. Also pushed it to:
> > https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/log/?h=coresched
> > 
> > > Also, from what I can see following
> > > the series, p->core_cookie is not yet set anywhere (unless I missed it),
> > > so fixing it in here did not make sense just reading the series.
> > 
> > The interface patches for core_cookie are added later, that's how it is. The
> > infrastructure comes first here. It would also not make sense to add
> > interface first as well so I think the current ordering is fine.
> >
> 
> Some comments below to help make the code easier to understand
> 
> > ---8<-----------------------
> > 
> > From: Peter Zijlstra <peterz@infradead.org>
> > Subject: [PATCH] sched: Fix priority inversion of cookied task with sibling
> > 
> > The rationale is as follows. In the core-wide pick logic, even if
> > need_sync == false, we need to go look at other CPUs (non-local CPUs) to
> > see if they could be running RT.
> > 
> > Say the RQs in a particular core look like this:
> > Let CFS1 and CFS2 be 2 tagged CFS tags. Let RT1 be an untagged RT task.
> > 
> > rq0            rq1
> > CFS1 (tagged)  RT1 (not tag)
> > CFS2 (tagged)
> > 
> > The end result of the selection will be (say prio(CFS1) > prio(CFS2)):
> > rq0             rq1
> > CFS1            IDLE
> > 
> > When it should have selected:
> > rq0             r1
> > IDLE            RT
> > 
> > Fix this issue by forcing need_sync and restarting the search if a
> > cookied task was discovered. This will avoid this optimization from
> > making incorrect picks.
> > 
> > Joel saw this issue on real-world usecases in ChromeOS where an RT task
> > gets constantly force-idled and breaks RT. Lets cure it.
> > 
> > NOTE: This problem will be fixed differently in a later patch. It just
> >       kept here for reference purposes about this issue, and to make
> >       applying later patches easier.
> > 
> > Reported-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Signed-off-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  kernel/sched/core.c | 25 ++++++++++++++++---------
> >  1 file changed, 16 insertions(+), 9 deletions(-)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 4ee4902c2cf5..53af817740c0 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -5195,6 +5195,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> >  	need_sync = !!rq->core->core_cookie;
> >  
> >  	/* reset state */
> > +reset:
> >  	rq->core->core_cookie = 0UL;
> >  	if (rq->core->core_forceidle) {
> >  		need_sync = true;
> > @@ -5242,14 +5243,8 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> >  				/*
> >  				 * If there weren't no cookies; we don't need to
> >  				 * bother with the other siblings.
> > -				 * If the rest of the core is not running a tagged
> > -				 * task, i.e.  need_sync == 0, and the current CPU
> > -				 * which called into the schedule() loop does not
> > -				 * have any tasks for this class, skip selecting for
> > -				 * other siblings since there's no point. We don't skip
> > -				 * for RT/DL because that could make CFS force-idle RT.
> >  				 */
> > -				if (i == cpu && !need_sync && class == &fair_sched_class)
> > +				if (i == cpu && !need_sync)
> >  					goto next_class;
> >  
> >  				continue;
> > @@ -5259,7 +5254,20 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> >  			 * Optimize the 'normal' case where there aren't any
> >  			 * cookies and we don't need to sync up.
> >  			 */
> > -			if (i == cpu && !need_sync && !p->core_cookie) {
> > +			if (i == cpu && !need_sync) {
> > +				if (p->core_cookie) {
> > +					/*
> > +					 * This optimization is only valid as
> > +					 * long as there are no cookies
> 
> This is not entirely true, need_sync is a function of core cookies, so I
> think this needs more clarification, it sounds like we enter this when
> the core has no cookies, but the task has a core_cookie? The term cookie
> is quite overloaded when used in the context of core vs task.
> 
> Effectively from what I understand this means that p wants to be
> coscheduled, but the core itself is not coscheduling anything at the
> moment, so we need to see if we should do a sync and that sync might
> cause p to get kicked out and a higher priority class to come in?

Yeah so about need_sync, it is basically a flag that says if the HT running
the schedule() loop needs to bother with siblings.

need_sync is true only in following conditions:
- A cookied task is running on any HT on the core.
- Any HT in the core is force idled.

The above code comment you referred to is now reworked. That was for the case
where we discovered during local selection that we found a task with a
cookie so now we have to do a core-wide scan (need_sync = false before but
now it becomes true and we start over). This optimization is done sligtly
differently now, we run ->pick_task() on every class of the local CPU until
we find something, if we find something with a cookie then we do core-wide
selection.

The latest version of this code is now in Peter's branch:
https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/tree/kernel/sched/core.c?id=6288c0a49631ce6b53eeab7021a43e49c4c4d436

- Joel

