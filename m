Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6051929C510
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 19:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1824150AbgJ0SDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 14:03:36 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33063 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757394AbgJ0OTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 10:19:14 -0400
Received: by mail-qt1-f195.google.com with SMTP id j62so1075858qtd.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 07:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bxh1Do9gB2L1qAcESsHXkjxOIjeM0Npe6oBM5FfnnCY=;
        b=bsIQ5abhxIx4Kuz1KfVERGK1ug+bmNb8gWArGIWJRq4uLEOGl8+9v8dKOJO+LXEpbi
         nnpSu/+OiU5GZqcVoUkt4PVykOBtgfvYoS4lounvL/Dtz2FHPnHA3gYZAZDketrQcyjR
         F8j9bWg7MZJ1RhEGhuw6A+LRKyYIoI0XBjSn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bxh1Do9gB2L1qAcESsHXkjxOIjeM0Npe6oBM5FfnnCY=;
        b=eX819eD2P1FfOctvOyP+x+Rr7KO9SIF6/bLHLJQGcXIpwHCkvwEhXoS4kbop+gvD8d
         +v3IBNc+ao9mR6ZCO6KXYyUVEZ0Y7X7soW55ztERXd6+/O8+MiJ65YzDnrJuUkxaULnS
         QQVa7g2GeQdV0ZpIKxXHgJX6H2AJe+1Vd8rqfZKWnMupXnracffD1cxMlJaFzOnswcUz
         Crw1WEfZ1BebIgxBdswik/sgtwM8tgR7QWx6oPWiot64oQoDs2KOOCRS+EkZgdQFaZR0
         tM3jtez3n6E7db7HmZfI9yafSwbR2+UTznqZ5Y6ac8gwQiALXTDKZl2dKbVbs/WoDfJe
         4tpA==
X-Gm-Message-State: AOAM5323plPaje5AUNNtP5yYWhY1gssueN5weXITNti/e41ZAWQYwBtu
        An6nHf+8RrZmGhqO4O+YMR+GsQ==
X-Google-Smtp-Source: ABdhPJya1MYpLPelnzTrpfjK5t/oGZBp8gdcvGnyABV2WaYubYYFygCM3HswoL6/iwzEyRm4xj67ag==
X-Received: by 2002:ac8:6f53:: with SMTP id n19mr2321027qtv.282.1603808352539;
        Tue, 27 Oct 2020 07:19:12 -0700 (PDT)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id q16sm871284qtw.9.2020.10.27.07.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 07:19:11 -0700 (PDT)
Date:   Tue, 27 Oct 2020 10:19:11 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vineeth Pillai <viremana@linux.microsoft.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Thomas Glexiner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
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
        graf@amazon.com, konrad.wilk@oracle.com,
        Dario Faggioli <dfaggioli@suse.com>,
        Paul Turner <pjt@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Patrick Bellasi <derkling@google.com>,
        =?utf-8?B?YmVuYmppYW5nKOiSi+W9qik=?= <benbjiang@tencent.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>,
        "Ning, Hongyu" <hongyu.ning@linux.intel.com>
Subject: Re: [PATCH v8 -tip 02/26] sched: Introduce sched_class::pick_task()
Message-ID: <20201027141911.GC771372@google.com>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
 <20201020014336.2076526-3-joel@joelfernandes.org>
 <8ea1aa61-4a1c-2687-9f15-1062d37606c7@linux.intel.com>
 <CAEXW_YT-pKJiA-APEtJv9QuyoYB0wNrH3EbAyc=3dwMfav+F6Q@mail.gmail.com>
 <a2b66294-6a66-b5c1-7706-29bc92f416f5@linux.intel.com>
 <20201023214702.GA3603399@google.com>
 <d9a70e58-f424-3957-9957-b89071480005@linux.intel.com>
 <4241e5ac-ecdf-8634-fa0d-dd6759e477e1@linux.microsoft.com>
 <8230ada7-839f-2335-9a55-b09f6a813e91@linux.microsoft.com>
 <20201026090131.GE2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201026090131.GE2628@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 10:01:31AM +0100, Peter Zijlstra wrote:
> On Sat, Oct 24, 2020 at 08:27:16AM -0400, Vineeth Pillai wrote:
> > 
> > 
> > On 10/24/20 7:10 AM, Vineeth Pillai wrote:
> > > 
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 93a3b874077d..4cae5ac48b60 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -4428,12 +4428,14 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct
> > > sched_entity *curr)
> > >                         se = second;
> > >         }
> > > 
> > > -       if (cfs_rq->next && wakeup_preempt_entity(cfs_rq->next, left) <
> > > 1) {
> > > +       if (left && cfs_rq->next &&
> > > +                       wakeup_preempt_entity(cfs_rq->next, left) < 1) {
> > >                 /*
> > >                  * Someone really wants this to run. If it's not unfair,
> > > run it.
> > >                  */
> > >                 se = cfs_rq->next;
> > > -       } else if (cfs_rq->last && wakeup_preempt_entity(cfs_rq->last,
> > > left) < 1) {
> > > +       } else if (left && cfs_rq->last &&
> > > +                       wakeup_preempt_entity(cfs_rq->last, left) < 1) {
> > >                 /*
> > >                  * Prefer last buddy, try to return the CPU to a
> > > preempted task.
> > > 
> > > 
> > > There reason for left being NULL needs to be investigated. This was
> > > there from v1 and we did not yet get to it. I shall try to debug later
> > > this week.
> > 
> > Thinking more about it and looking at the crash, I think that
> > 'left == NULL' can happen in pick_next_entity for core scheduling.
> > If a cfs_rq has only one task that is running, then it will be
> > dequeued and 'left = __pick_first_entity()' will be NULL as the
> > cfs_rq will be empty. This would not happen outside of coresched
> > because we never call pick_tack() before put_prev_task() which
> > will enqueue the task back.
> > 
> > With core scheduling, a cpu can call pick_task() for its sibling while
> > the sibling is still running the active task and put_prev_task has yet
> > not been called. This can result in 'left == NULL'.
> 
> Quite correct. Hurmph.. the reason we do this is because... we do the
> update_curr() the wrong way around. And I can't seem to remember why we
> do that (it was in my original patches).
> 
> Something like so seems the obvious thing to do, but I can't seem to
> remember why we're not doing it :-(

The code below is just a refactor and not a functional change though, right?

i.e. pick_next_entity() is already returning se = curr, if se == NULL.

But the advantage of your refactor is it doesn't crash the kernel.

So your change appears safe to me unless I missed something.

thanks,

 - Joel


> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6950,15 +6950,10 @@ static struct task_struct *pick_task_fai
>  	do {
>  		struct sched_entity *curr = cfs_rq->curr;
>  
> -		se = pick_next_entity(cfs_rq, NULL);
> +		if (curr && curr->on_rq)
> +			update_curr(cfs_rq);
>  
> -		if (curr) {
> -			if (se && curr->on_rq)
> -				update_curr(cfs_rq);
> -
> -			if (!se || entity_before(curr, se))
> -				se = curr;
> -		}
> +		se = pick_next_entity(cfs_rq, curr);
>  
>  		cfs_rq = group_cfs_rq(se);
>  	} while (cfs_rq);
