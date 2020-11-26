Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9B712C5414
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 13:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388805AbgKZMlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 07:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731421AbgKZMlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 07:41:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613E1C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 04:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=p0O18K0NodQGhP9nF2NIBoqyFyxWCXdlWgRp9cTuHDI=; b=TNqsk2kfryt3Cc20TJ2X7HA10y
        DPzb8qPVEfnsDd3FvIWJZk9lZKR6jYRrRtGxTXSdjXCwooXFrLeD4v4j9HCKPkXsVQKUCGH5cwFhx
        rWS1+YW5VKO8/aBxu0QCn/TGPauuE5mjrLV/VyrkulsiR1LA5VT+LrGAi3MUE/PuPAkUoM8YnCqeP
        wVmdOQhjyCYLiv3qKtcpEwiVVQuSpbYzhYj9waGiFhVxEyXOoDK2lnphCC1jT+7S5ZpSb2mW+TjUB
        ocl/PbiFTiGz9K71YYpjVfZuF0M37qKdn5To97thpn1z7hnxwZR+mFa8JwNZp/bvgv4f1rffs0HQX
        inlJAe+w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kiGZI-0002Gl-Vs; Thu, 26 Nov 2020 12:40:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 395293059DE;
        Thu, 26 Nov 2020 13:40:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 22F66201E6BBD; Thu, 26 Nov 2020 13:40:11 +0100 (CET)
Date:   Thu, 26 Nov 2020 13:40:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        Paul Turner <pjt@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Patrick Bellasi <derkling@google.com>,
        Jiang Biao <benbjiang@tencent.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        OWeisse@umich.edu, Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>, jsbarnes@google.com,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Ben Segall <bsegall@google.com>, Josh Don <joshdon@google.com>,
        Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH -tip 02/32] sched: Introduce sched_class::pick_task()
Message-ID: <20201126124011.GL3040@hirez.programming.kicks-ass.net>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-3-joel@joelfernandes.org>
 <CAKfTPtDSnr85X90gpPvgOf94Adh_mvH2CGhkXXx4FHn6EkCErg@mail.gmail.com>
 <20201126090710.GF2414@hirez.programming.kicks-ass.net>
 <CAKfTPtCPESw89KLs2HQGtxSM68yqSGoJoaU8FDRKrr00ZHWPWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCPESw89KLs2HQGtxSM68yqSGoJoaU8FDRKrr00ZHWPWQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 11:17:48AM +0100, Vincent Guittot wrote:

> > Something like so then?
> 
> yes. it seems ok
> 
> >
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c

> > @@ -6982,20 +6982,29 @@ static void check_preempt_wakeup(struct
> >  #ifdef CONFIG_SMP
> >  static struct task_struct *pick_task_fair(struct rq *rq)
> >  {
> >         struct sched_entity *se;
> > +       struct cfs_rq *cfs_rq;
> > +
> > +again:
> > +       cfs_rq = &rq->cfs;
> >         if (!cfs_rq->nr_running)
> >                 return NULL;
> >
> >         do {
> >                 struct sched_entity *curr = cfs_rq->curr;
> >
> > +               /* When we pick for a remote RQ, we'll not have done put_prev_entity() */
> > +               if (curr) {
> > +                       if (curr->on_rq)
> > +                               update_curr(cfs_rq);
> > +                       else
> > +                               curr = NULL;
> >
> > +                       if (unlikely(check_cfs_rq_runtime(cfs_rq)))
> > +                               goto again;

Head-ache though; pick_task() was supposed to be stateless, but now
we're modifying a remote runqueue... I suppose it still works, because
irrespective of which task we end up picking (even idle), we'll schedule
the remote CPU, which would've resulted in the same (and possibly
triggered a reschedule if we'd not done it here).

There's a wrinkle through, other than in schedule(), where we dequeue()
and keep running with the current task while we release rq->lock, this
has preemption enabled as well.

This means that if we do this, the remote CPU could preempt, but the
task is then no longer on the runqueue.

I _think_ it all still works, but yuck!

> > +               }
> >
> > +               se = pick_next_entity(cfs_rq, curr);
> >                 cfs_rq = group_cfs_rq(se);
> >         } while (cfs_rq);
> >
