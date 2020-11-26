Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6A62C51E9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 11:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387669AbgKZKSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 05:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgKZKSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 05:18:01 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B561C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 02:18:01 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id s9so1710901ljo.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 02:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F3gSDfUsKRUY3FZX1HOALC3kUdm90Fc5VLcRsSCj8q8=;
        b=nnymFjQm/mN5O96fAZhiLaPH+OGvEJvz1VHlRqbEinYSBTvXnZkVwKrixyYtBJpFlS
         kqTM3h+dkgoBwHFIoAqXypp1t9SjuJS7cZrowMZ9RzzbPHDMSIqvL0QvOTbXxkXLdYRx
         WOMwGRDYQx8ch+Zwj/SumPp7/nFz/aYjcvh4uKNhPuGxOC9EViOruQJfd70HCrfOXxqI
         fSkFtkVJ867xiNKI8etNYZDRpTvOiwjj2A75SFoB8ZzYVhPN3L65P+X6OshhNBP20+1J
         H5GUmHDhoQV6Es7Eh2ydxN5qSEumiK9WrYEV6DRMPC2kJSRquJdlZnqNjKjtdlLI3Nq2
         o04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F3gSDfUsKRUY3FZX1HOALC3kUdm90Fc5VLcRsSCj8q8=;
        b=c2TrZAD+WQq1Msqe/5jN/D8BNsF+rVJTm2K7ARlqQJAHEsGyYdcCTVOReU7DhKKuLJ
         3pV7UzA7WW7wqPKiUCb7fFl6Tt/jlyknooaqKG8e2DmdxqpraQgnK42xn0zv9XLdloh1
         IePTkMDSYl2W2lGEcMbdKJnsx4qaJht6FT9KVX13fw4nL9ZgBtS4AZSSmsc4PzzrueIc
         zc81PHlifACFcZC+buGNdj8WBsvNrKSZssqV6HBLDE904iMBn8ycf3FeiaNdNGUpBVsE
         MaswArVDV1bznCEKFx+QNy0rdnsMXUCAKmiRzh6hFZYaHIV6/bsZzsMzMGm0cBo0TIq+
         pa2A==
X-Gm-Message-State: AOAM533XoiUkNngAG0yLgD63jP+6ZyggqYvomS37fCk68vRB/5iBbI0q
        G/CLKy+/WtmhL1Paks+ycCmDBg5WJ49tQIjlxS8Xpw==
X-Google-Smtp-Source: ABdhPJy0r2Z5FCyd6we23GNdP82wO1uZf80pvaDk+2eQ4HsDD04AokZ/BjTZ9xPYNyvXA6xtmN9JOXxCDznoBLYUKz0=
X-Received: by 2002:a2e:8050:: with SMTP id p16mr1024017ljg.69.1606385879690;
 Thu, 26 Nov 2020 02:17:59 -0800 (PST)
MIME-Version: 1.0
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-3-joel@joelfernandes.org> <CAKfTPtDSnr85X90gpPvgOf94Adh_mvH2CGhkXXx4FHn6EkCErg@mail.gmail.com>
 <20201126090710.GF2414@hirez.programming.kicks-ass.net>
In-Reply-To: <20201126090710.GF2414@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 26 Nov 2020 11:17:48 +0100
Message-ID: <CAKfTPtCPESw89KLs2HQGtxSM68yqSGoJoaU8FDRKrr00ZHWPWQ@mail.gmail.com>
Subject: Re: [PATCH -tip 02/32] sched: Introduce sched_class::pick_task()
To:     Peter Zijlstra <peterz@infradead.org>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Nov 2020 at 10:07, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Nov 25, 2020 at 05:28:36PM +0100, Vincent Guittot wrote:
> > On Wed, 18 Nov 2020 at 00:20, Joel Fernandes (Google)
>
> > > +#ifdef CONFIG_SMP
> > > +static struct task_struct *pick_task_fair(struct rq *rq)
> > > +{
> > > +       struct cfs_rq *cfs_rq = &rq->cfs;
> > > +       struct sched_entity *se;
> > > +
> > > +       if (!cfs_rq->nr_running)
> > > +               return NULL;
> > > +
> > > +       do {
> > > +               struct sched_entity *curr = cfs_rq->curr;
> > > +
> > > +               se = pick_next_entity(cfs_rq, NULL);
> >
> > Calling pick_next_entity clears buddies. This is fine without
> > coresched because the se will be the next one. But calling
> > pick_task_fair doesn't mean that the se will be used
>
> Urgh, nice one :/
>
> > > +
> > > +               if (curr) {
> > > +                       if (se && curr->on_rq)
> > > +                               update_curr(cfs_rq);
> > > +
> >
> > Shouldn't you check if cfs_rq is throttled ?
>
> Hmm,... I suppose we do.
>
> > > +                       if (!se || entity_before(curr, se))
> > > +                               se = curr;
> > > +               }
> > > +
> > > +               cfs_rq = group_cfs_rq(se);
> > > +       } while (cfs_rq);
> > > +
> > > +       return task_of(se);
> > > +}
> > > +#endif
>
> Something like so then?

yes. it seems ok

>
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4354,6 +4354,8 @@ check_preempt_tick(struct cfs_rq *cfs_rq
>  static void
>  set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  {
> +       clear_buddies(cfs_rq, se);
> +
>         /* 'current' is not kept within the tree. */
>         if (se->on_rq) {
>                 /*
> @@ -4440,8 +4442,6 @@ pick_next_entity(struct cfs_rq *cfs_rq,
>                 se = cfs_rq->last;
>         }
>
> -       clear_buddies(cfs_rq, se);
> -
>         return se;
>  }
>
> @@ -6982,20 +6982,29 @@ static void check_preempt_wakeup(struct
>  #ifdef CONFIG_SMP
>  static struct task_struct *pick_task_fair(struct rq *rq)
>  {
> -       struct cfs_rq *cfs_rq = &rq->cfs;
>         struct sched_entity *se;
> -
> +       struct cfs_rq *cfs_rq;
> +
> +again:
> +       cfs_rq = &rq->cfs;
>         if (!cfs_rq->nr_running)
>                 return NULL;
>
>         do {
>                 struct sched_entity *curr = cfs_rq->curr;
>
> -               if (curr && curr->on_rq)
> -                       update_curr(cfs_rq);
> +               /* When we pick for a remote RQ, we'll not have done put_prev_entity() */
> +               if (curr) {
> +                       if (curr->on_rq)
> +                               update_curr(cfs_rq);
> +                       else
> +                               curr = NULL;
>
> -               se = pick_next_entity(cfs_rq, curr);
> +                       if (unlikely(check_cfs_rq_runtime(cfs_rq)))
> +                               goto again;
> +               }
>
> +               se = pick_next_entity(cfs_rq, curr);
>                 cfs_rq = group_cfs_rq(se);
>         } while (cfs_rq);
>
