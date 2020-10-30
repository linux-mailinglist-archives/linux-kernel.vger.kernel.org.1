Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6E029FB69
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 03:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgJ3Cgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 22:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgJ3Cgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 22:36:54 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89ACEC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:36:54 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id b15so5992464iod.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wEryDwBE76HQn4v5pHS7QvH6dswuzYzelfA9oum51xI=;
        b=W96YkktdxE0/DL4nIzHf0oiy6n5syHw5gnEbajqNKZixEAQpLiBeLbjNnWGeW+qXwK
         bxf5Rop5i2Ru704EKtgg9U4sVEO74WjGcbxwQtWGOJAwKKE6Kv0EM6B2Xfer6BjLscXc
         meDcLgMEMH08b63+rID4XvcUlPBpt9czQmfKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wEryDwBE76HQn4v5pHS7QvH6dswuzYzelfA9oum51xI=;
        b=PMoxH8dVKcHntboApthR3weN5aUR737AdO90QAFKI2F6Ld52u1tn3QiXVfgHj4vadD
         Mp8Vhc4aDzakINIpp3EAHp2iQ4FjCv/Li8Zfgjbx867SqqHoArc3B0buud05yIcgr0Du
         vDn30rYHuri/5tz51/+dWrApH06qlITl7NPsOViFYOVRibq6Kupp7FbCDin9igvwpHOu
         fGa7iB/u99+jopzOtxaJrQHAYR86GibKH/BeCtxtMiXyPLFo+EheqWEsbzF2WDh4fqR3
         PcVHruJghtdwK1WlOy0JVQB7l3BBZ9oImQhvLz3kGtAP5qyPDx0gJlpVMpKWHTiSk4j1
         DXCA==
X-Gm-Message-State: AOAM530o6tPUfd/uqw5rpTOi/NwotpIDNtxCOQd5SYEgIFx4oFtqzgIh
        UVfNH92m7G77B90cUgw1wlNauHjnFdXDuSo5PC4uIQ==
X-Google-Smtp-Source: ABdhPJyOYXeLXWDvZ9BMa8amZU7v83lmCA2SBbb8jBcKQcDo8NtRGJwqFnHDaJOUYNXov9C04WgecX+pUHck2650B30=
X-Received: by 2002:a05:6602:22cf:: with SMTP id e15mr265842ioe.1.1604025413811;
 Thu, 29 Oct 2020 19:36:53 -0700 (PDT)
MIME-Version: 1.0
References: <20201020014336.2076526-1-joel@joelfernandes.org>
 <20201020014336.2076526-9-joel@joelfernandes.org> <20201026124724.GT2611@hirez.programming.kicks-ass.net>
 <20201029182429.GA1844482@google.com> <20201029185933.GG2611@hirez.programming.kicks-ass.net>
In-Reply-To: <20201029185933.GG2611@hirez.programming.kicks-ass.net>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 29 Oct 2020 22:36:42 -0400
Message-ID: <CAEXW_YRtrhhL4Gc8W8_-2CR1CCw6_hhtnwSdQ-dMLYCJ+fP+RA@mail.gmail.com>
Subject: Re: [PATCH v8 -tip 08/26] sched/fair: Snapshot the min_vruntime of
 CPUs on force idle
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Thomas Glexiner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
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
        graf@amazon.com, konrad.wilk@oracle.com,
        Dario Faggioli <dfaggioli@suse.com>,
        Paul Turner <pjt@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Patrick Bellasi <derkling@google.com>,
        =?UTF-8?B?YmVuYmppYW5nKOiSi+W9qik=?= <benbjiang@tencent.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Tim Chen <tim.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 2:59 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Oct 29, 2020 at 02:24:29PM -0400, Joel Fernandes wrote:
>
> > > @@ -4823,10 +4822,8 @@ pick_next_task(struct rq *rq, struct tas
> > >             if (!rq_i->core_pick)
> > >                     continue;
> > >
> > > -           if (is_task_rq_idle(rq_i->core_pick) && rq_i->nr_running &&
> > > -               !rq_i->core->core_forceidle) {
> > > -                   rq_i->core->core_forceidle = true;
> > > -           }
> > > +           if (!(fi_before && rq->core->core_forceidle))
> > > +                   task_vruntime_update(rq_i, rq_i->core_pick);
> >
> > Shouldn't this be:
> >
> >       if (!fi_before && rq->core->core_forceidle)
> >                       task_vruntime_update(rq_i, rq_i->core_pick);
> >
> > ?
>
> *groan*, I should've written a comment there :/
>
> When we're not fi, we need to update.
> when we're fi and we were not fi, we must update
> When we're fi and we were already fi, we must not update
>
> Which gives:
>
>         fib     fi      X
>
>         0       0       1
>         0       1       0
>         1       0       1
>         1       1       1
>
> which is: !(!fib && fi) or something.
>

Got it! This is what my initial patch intended to do as well, but
yours is better.

> > > +bool cfs_prio_less(struct task_struct *a, struct task_struct *b)
> > > +{
> > > +   struct rq *rq = task_rq(a);
> > > +   struct sched_entity *sea = &a->se;
> > > +   struct sched_entity *seb = &b->se;
> > > +   struct cfs_rq *cfs_rqa;
> > > +   struct cfs_rq *cfs_rqb;
> > > +   s64 delta;
> > > +
> > > +   SCHED_WARN_ON(task_rq(b)->core != rq->core);
> > > +
> > > +   while (sea->cfs_rq->tg != seb->cfs_rq->tg) {
> > > +           int sea_depth = sea->depth;
> > > +           int seb_depth = seb->depth;
> > > +
> > > +           if (sea_depth >= seb_depth)
> > > +                   sea = parent_entity(sea);
> > > +           if (sea_depth <= seb_depth)
> > > +                   seb = parent_entity(seb);
> > > +   }
> > > +
> > > +   if (rq->core->core_forceidle) {
> > > +           se_fi_update(sea, rq->core->core_forceidle_seq, true);
> > > +           se_fi_update(seb, rq->core->core_forceidle_seq, true);
> > > +   }
> >
> > As we chatted on IRC you mentioned the reason for the sync here is:
> >
> >  say we have 2 cgroups (a,b) under root, and we go force-idle in a, then we
> >  update a and root. Then we pick and end up in b, but b hasn't been updated
> >  yet.
> >
> > One thing I was wondering about that was, if the pick of 'b' happens much
> > later than 'a', then the snapshot might be happening too late right?
>
> No, since this is the first pick in b since fi, it cannot have advanced.
> So by updating to fi_seq before picking, we guarantee it is unchanged
> since we went fi.

Makes complete sense.

I got it to a point where the latencies are much lower, but still not
at a point where it's as good as the initial patch I posted.

There could be more bugs. At the moment, the only one I corrected in
your patch is making the truth table do !(!fib && fi). But there is
still something else going on.

Thanks!

- Joel
