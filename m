Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B765129FB85
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 03:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725841AbgJ3Cmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 22:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgJ3Cmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 22:42:42 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9900C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:42:40 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id c11so5241004iln.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yIt6f0Gqp2APVc0CnjdajlwFirKpKzNrhzjPk7NUqxQ=;
        b=EcGmpoVR5TR1/E877Qm8AlwHKKh3ntlOrhX8mAZVoc4SJYKL5Pq9/akRK5tu25b1uj
         PD+1TAf2QXC8b7cJjT6SmnoE5v7GwuXBLr+8Mtmsl69kMcJ7byE/VMLlod1Vgc7pxZCy
         /hisoA82dWzWaoKE8pAwJDjuLAOQ5hqAh7c2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yIt6f0Gqp2APVc0CnjdajlwFirKpKzNrhzjPk7NUqxQ=;
        b=Tl/zwE27IzBZf2xNTieQsiul7bjOknJj9a/XwcfHDjasGhfPEPZKf183cPK7d614aC
         EgmjeOWS5H9Xz8H4lmtGReFcEreJquDveTDQWC+jnvbNnC12kyjSahE2/GX97RYIQbCS
         Pld/kFNcmbolbYr1oDNgCgfEhCwPju1x4kdPCNVpPyXYykOikVzslwmTlrdDbWp4YQnT
         z6tIxnt00cFyL7Vr1OMkVv79O5P1EP07GfIWQnfpimxx4/W5h0YBRyFsx33pEujhRCWG
         EGYJtJDt2ziNaQYJjboQKtttOulnlmAvWzdkKE3B7TyDwE4Q5RgvEDgLeBWoXheAyfY6
         tEjw==
X-Gm-Message-State: AOAM5332BSX2MFbOLny9o+xKxdCQaNglSmTiawN7e7FqgGZ8krSdkW74
        XTQ5Wg2aKBc3TrU/yQ6QyKopYV5U22TZ5QDi3evWSA==
X-Google-Smtp-Source: ABdhPJxSHWF0JynyIEPbrtCks2nOnJJX/rxNtRdqIZhFHS7S7o146eNeOMMpamACN5bpuFw0kKquwZSlaLlwrhQEdfo=
X-Received: by 2002:a92:8906:: with SMTP id n6mr370227ild.13.1604025760061;
 Thu, 29 Oct 2020 19:42:40 -0700 (PDT)
MIME-Version: 1.0
References: <20201020014336.2076526-1-joel@joelfernandes.org>
 <20201020014336.2076526-9-joel@joelfernandes.org> <20201026124724.GT2611@hirez.programming.kicks-ass.net>
 <20201029182429.GA1844482@google.com> <20201029185933.GG2611@hirez.programming.kicks-ass.net>
 <CAEXW_YRtrhhL4Gc8W8_-2CR1CCw6_hhtnwSdQ-dMLYCJ+fP+RA@mail.gmail.com>
In-Reply-To: <CAEXW_YRtrhhL4Gc8W8_-2CR1CCw6_hhtnwSdQ-dMLYCJ+fP+RA@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 29 Oct 2020 22:42:29 -0400
Message-ID: <CAEXW_YTnJWANAZNeR9b=5xUeHu1CAPq9vgYaH8WSHgApJZ21Rw@mail.gmail.com>
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

On Thu, Oct 29, 2020 at 10:36 PM Joel Fernandes <joel@joelfernandes.org> wrote:

> > > > +bool cfs_prio_less(struct task_struct *a, struct task_struct *b)
> > > > +{
> > > > +   struct rq *rq = task_rq(a);
> > > > +   struct sched_entity *sea = &a->se;
> > > > +   struct sched_entity *seb = &b->se;
> > > > +   struct cfs_rq *cfs_rqa;
> > > > +   struct cfs_rq *cfs_rqb;
> > > > +   s64 delta;
> > > > +
> > > > +   SCHED_WARN_ON(task_rq(b)->core != rq->core);
> > > > +
> > > > +   while (sea->cfs_rq->tg != seb->cfs_rq->tg) {
> > > > +           int sea_depth = sea->depth;
> > > > +           int seb_depth = seb->depth;
> > > > +
> > > > +           if (sea_depth >= seb_depth)
> > > > +                   sea = parent_entity(sea);
> > > > +           if (sea_depth <= seb_depth)
> > > > +                   seb = parent_entity(seb);
> > > > +   }
> > > > +
> > > > +   if (rq->core->core_forceidle) {
> > > > +           se_fi_update(sea, rq->core->core_forceidle_seq, true);
> > > > +           se_fi_update(seb, rq->core->core_forceidle_seq, true);
> > > > +   }
> > >
> > > As we chatted on IRC you mentioned the reason for the sync here is:
> > >
> > >  say we have 2 cgroups (a,b) under root, and we go force-idle in a, then we
> > >  update a and root. Then we pick and end up in b, but b hasn't been updated
> > >  yet.
> > >
> > > One thing I was wondering about that was, if the pick of 'b' happens much
> > > later than 'a', then the snapshot might be happening too late right?
> >
> > No, since this is the first pick in b since fi, it cannot have advanced.
> > So by updating to fi_seq before picking, we guarantee it is unchanged
> > since we went fi.
>
> Makes complete sense.
>
> I got it to a point where the latencies are much lower, but still not
> at a point where it's as good as the initial patch I posted.
>
> There could be more bugs. At the moment, the only one I corrected in
> your patch is making the truth table do !(!fib && fi). But there is
> still something else going on.

Forgot to ask, do you also need to do the task_vruntime_update() for
the unconstrained pick?

That's in line with what you mentioned: That you still need to do the
update if fi_before == false and fi_now == false.

So something like this?
@@ -4209,6 +4209,10 @@ pick_next_task(struct rq *rq, struct
task_struct *prev, struct rq_flags *rf)
                                next = p;
                                trace_printk("unconstrained pick: %s/%d %lx\n",
                                             next->comm, next->pid,
next->core_cookie);
+
+                               WARN_ON_ONCE(fi_before);
+                               task_vruntime_update(rq_i, p);
+
                                goto done;
                        }

Quoting the truth table:

> >         fib     fi      X
> >
> >         0       0       1
> >         0       1       0
> >         1       0       1
> >         1       1       1
> >

thanks,

 - Joel
