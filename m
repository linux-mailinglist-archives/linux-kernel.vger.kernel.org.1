Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE40429B058
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 15:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2901092AbgJ0OS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 10:18:27 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44610 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755699AbgJ0OPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 10:15:02 -0400
Received: by mail-qk1-f196.google.com with SMTP id s14so1233398qkg.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 07:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ykXi2g6uJbJA/qiSGsDHFlM7mN9y+u5WVs1nXQ3xu8g=;
        b=bE21aN+eAnzXRmHKMmMxsFJ3xfnOvdPPKVaV5LTOHd0Oz+1QNGWKha0fH1XCPD1gxU
         YWMGhphDrxMSFFjVg+G0R7ROFT14G5sB2uEvmrqV5mMC/B85QkpfUII5ToKZwt+Ro0a6
         FMpd2dADntULV7B3NQ4ISJFuxOYJTy6xV8VRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ykXi2g6uJbJA/qiSGsDHFlM7mN9y+u5WVs1nXQ3xu8g=;
        b=MrHBJ1oZ4T5HnZT5Np6TNphqCJObMBi9BpNrsy7ygS9RVmu6I3LrRH+lQbWQCAC2Mk
         Pvdw0R6O5QpkFT6qW4Dy7ZgK29Gc510HmtCXQzizPNzUgMon3xg5GJjhUyDPG3QELgc+
         thJZdcOXVIg70UIjg8sdUc+9EO50Gi+/25t2KR/xok0ybATypeoM1Wu9XHZkbymLMnxO
         Fhdw71PTf9dad/isMj++GqeG8UBLg5BmJWElodJdYhoPMeN5ssyVsOub+KbVnIK1eHmM
         Cyg+7FDR+qenPLT+Qc63coqVuC3mde9XZm9KW4LHghgjEU7oPZ8FCSlabIKTYAzhQq9V
         WiJg==
X-Gm-Message-State: AOAM533T9+mnaiD3tb1XyZg3kja12ZsMEFW8OrmAKqxGOu83kFQ5eh4J
        /gcZD6+9yXauAa6yBWP8ogd8wQ==
X-Google-Smtp-Source: ABdhPJzkhLH2hIt3dOe+NZnredyW5aCEyAJ++0HC4EdSUSro8g0RcZMYApy70H4T9EhDIdeMfiehwQ==
X-Received: by 2002:a37:9d4c:: with SMTP id g73mr2289576qke.391.1603808100838;
        Tue, 27 Oct 2020 07:15:00 -0700 (PDT)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id b12sm849357qtj.12.2020.10.27.07.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 07:15:00 -0700 (PDT)
Date:   Tue, 27 Oct 2020 10:14:59 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Vineeth Pillai <viremana@linux.microsoft.com>
Cc:     "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20201027141459.GB771372@google.com>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
 <20201020014336.2076526-3-joel@joelfernandes.org>
 <8ea1aa61-4a1c-2687-9f15-1062d37606c7@linux.intel.com>
 <CAEXW_YT-pKJiA-APEtJv9QuyoYB0wNrH3EbAyc=3dwMfav+F6Q@mail.gmail.com>
 <a2b66294-6a66-b5c1-7706-29bc92f416f5@linux.intel.com>
 <20201023214702.GA3603399@google.com>
 <d9a70e58-f424-3957-9957-b89071480005@linux.intel.com>
 <4241e5ac-ecdf-8634-fa0d-dd6759e477e1@linux.microsoft.com>
 <8230ada7-839f-2335-9a55-b09f6a813e91@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8230ada7-839f-2335-9a55-b09f6a813e91@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 24, 2020 at 08:27:16AM -0400, Vineeth Pillai wrote:
> 
> 
> On 10/24/20 7:10 AM, Vineeth Pillai wrote:
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 93a3b874077d..4cae5ac48b60 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4428,12 +4428,14 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct
> > sched_entity *curr)
> >                         se = second;
> >         }
> > 
> > -       if (cfs_rq->next && wakeup_preempt_entity(cfs_rq->next, left) <
> > 1) {
> > +       if (left && cfs_rq->next &&
> > +                       wakeup_preempt_entity(cfs_rq->next, left) < 1) {
> >                 /*
> >                  * Someone really wants this to run. If it's not unfair,
> > run it.
> >                  */
> >                 se = cfs_rq->next;
> > -       } else if (cfs_rq->last && wakeup_preempt_entity(cfs_rq->last,
> > left) < 1) {
> > +       } else if (left && cfs_rq->last &&
> > +                       wakeup_preempt_entity(cfs_rq->last, left) < 1) {
> >                 /*
> >                  * Prefer last buddy, try to return the CPU to a
> > preempted task.
> > 
> > 
> > There reason for left being NULL needs to be investigated. This was
> > there from v1 and we did not yet get to it. I shall try to debug later
> > this week.
> 
> Thinking more about it and looking at the crash, I think that
> 'left == NULL' can happen in pick_next_entity for core scheduling.
> If a cfs_rq has only one task that is running, then it will be
> dequeued and 'left = __pick_first_entity()' will be NULL as the
> cfs_rq will be empty. This would not happen outside of coresched
> because we never call pick_tack() before put_prev_task() which
> will enqueue the task back.
> 
> With core scheduling, a cpu can call pick_task() for its sibling while
> the sibling is still running the active task and put_prev_task has yet
> not been called. This can result in 'left == NULL'. So I think the
> above fix is appropriate when core scheduling is active. It could be
> cleaned up a bit though.

Thanks a lot Vineeth!
Just add, the pick_next_entity() returning NULL still causes pick_task_fair()
to behave correctly. Because pick_task_fair() will return 'curr' to the
core-wide picking code, not NULL. The problem is CFS pick_next_entity() is
not able to handle it though and crash,  as Vineeth found the below hunk got
lost in the rebase:

@@ -4464,13 +4464,13 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 	/*
 	 * Prefer last buddy, try to return the CPU to a preempted task.
 	 */
-	if (cfs_rq->last && wakeup_preempt_entity(cfs_rq->last, left) < 1)
+	if (left && cfs_rq->last && wakeup_preempt_entity(cfs_rq->last, left) < 1)
 		se = cfs_rq->last;

 	/*
 	 * Someone really wants this to run. If it's not unfair, run it.
 	 */
-	if (cfs_rq->next && wakeup_preempt_entity(cfs_rq->next, left) < 1)
+	if (left && cfs_rq->next && wakeup_preempt_entity(cfs_rq->next, left) < 1)
 		se = cfs_rq->next;

 	clear_buddies(cfs_rq, se);

Peter's fix in the other email looks good and I will include that for testing
before the next posting.

thanks,

 - Joel

