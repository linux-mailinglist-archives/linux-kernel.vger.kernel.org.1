Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E165297908
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 23:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756848AbgJWVrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 17:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756841AbgJWVrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 17:47:04 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825BAC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 14:47:04 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id s17so1548841qvr.11
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 14:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J/t5tWSdOrwNBWByXoZ9Yq6S/MfgMJAqu5KglZSB+kM=;
        b=ZG1XonjV5SZSee8y8WUsmFfyF4HvY/nEKBVcC/h+fB5wOUWjh3HEtvrlp/eGNJwIQN
         73QsO/yesViEx1JD+j3l/2LPmYCjGM4rRK3PBAPv5SOnOpxs/aEoDadOqQGyvCXAWtiT
         DJ8OZto+5MyOf18VoEbig+/WxFGIGVSCKp0zA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J/t5tWSdOrwNBWByXoZ9Yq6S/MfgMJAqu5KglZSB+kM=;
        b=mjrvoNEA3DGAqyUcLaWkuyhS3m5nBtXIoWdUCdOlBriTQMFO5B621SzRGIPb106wig
         5qTMOTtjKXLJhfGn/bg8fZRA31CdK9F4em2DBuM6Rlbf5WSzVUvYR670U44Tzc74eWTF
         WkVch1Bm2UT/z6K7wsAzswJNkGgJOL0rSCEpLzrTmpq3Vkz5M6vNGnNMFQErYBbbJYLs
         qb1Z3IsBVnK3kNtDQbqEpp1NiUeR3yunT+t8JpN0VEJrs/w3RA0HsZXyali5TUCW5zx6
         Gb4G+DDL52OUWy5BljlgKe3d8hdReSVp8E5oNrl6gdBvVff9GijLOkonnXS49mABBm1b
         s64w==
X-Gm-Message-State: AOAM530S709xqlP7nK7Kd/aarKL4Pj4hE+OStwhRUdqJdXEIjUng+KLB
        kvXBwZ+is5kgezEZGRkwtiko6g==
X-Google-Smtp-Source: ABdhPJx7RW54pLrZeOG6Dqzkay+2sC4WFUIrueHo9xwUDkxxgg+g4mI4YjDZr9OC9N4SpSFP5xe22g==
X-Received: by 2002:ad4:45a5:: with SMTP id y5mr1030695qvu.40.1603489623683;
        Fri, 23 Oct 2020 14:47:03 -0700 (PDT)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id d142sm1707689qke.125.2020.10.23.14.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 14:47:03 -0700 (PDT)
Date:   Fri, 23 Oct 2020 17:47:02 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
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
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>,
        "Ning, Hongyu" <hongyu.ning@linux.intel.com>
Subject: Re: [PATCH v8 -tip 02/26] sched: Introduce sched_class::pick_task()
Message-ID: <20201023214702.GA3603399@google.com>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
 <20201020014336.2076526-3-joel@joelfernandes.org>
 <8ea1aa61-4a1c-2687-9f15-1062d37606c7@linux.intel.com>
 <CAEXW_YT-pKJiA-APEtJv9QuyoYB0wNrH3EbAyc=3dwMfav+F6Q@mail.gmail.com>
 <a2b66294-6a66-b5c1-7706-29bc92f416f5@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2b66294-6a66-b5c1-7706-29bc92f416f5@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 01:25:38PM +0800, Li, Aubrey wrote:
> >>> @@ -2517,6 +2528,7 @@ const struct sched_class dl_sched_class
> >>>
> >>>  #ifdef CONFIG_SMP
> >>>       .balance                = balance_dl,
> >>> +     .pick_task              = pick_task_dl,
> >>>       .select_task_rq         = select_task_rq_dl,
> >>>       .migrate_task_rq        = migrate_task_rq_dl,
> >>>       .set_cpus_allowed       = set_cpus_allowed_dl,
> >>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >>> index dbd9368a959d..bd6aed63f5e3 100644
> >>> --- a/kernel/sched/fair.c
> >>> +++ b/kernel/sched/fair.c
> >>> @@ -4450,7 +4450,7 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
> >>>        * Avoid running the skip buddy, if running something else can
> >>>        * be done without getting too unfair.
> >>>        */
> >>> -     if (cfs_rq->skip == se) {
> >>> +     if (cfs_rq->skip && cfs_rq->skip == se) {
> >>>               struct sched_entity *second;
> >>>
> >>>               if (se == curr) {
> >>> @@ -6976,6 +6976,35 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
> >>>               set_last_buddy(se);
> >>>  }
> >>>
> >>> +#ifdef CONFIG_SMP
> >>> +static struct task_struct *pick_task_fair(struct rq *rq)
> >>> +{
> >>> +     struct cfs_rq *cfs_rq = &rq->cfs;
> >>> +     struct sched_entity *se;
> >>> +
> >>> +     if (!cfs_rq->nr_running)
> >>> +             return NULL;
> >>> +
> >>> +     do {
> >>> +             struct sched_entity *curr = cfs_rq->curr;
> >>> +
> >>> +             se = pick_next_entity(cfs_rq, NULL);
> >>> +
> >>> +             if (curr) {
> >>> +                     if (se && curr->on_rq)
> >>> +                             update_curr(cfs_rq);
> >>> +
> >>> +                     if (!se || entity_before(curr, se))
> >>> +                             se = curr;
> >>> +             }
> >>> +
> >>> +             cfs_rq = group_cfs_rq(se);
> >>> +     } while (cfs_rq);
> >>> ++
> >>> +     return task_of(se);
> >>> +}
> >>> +#endif
> >>
> >> One of my machines hangs when I run uperf with only one message:
> >> [  719.034962] BUG: kernel NULL pointer dereference, address: 0000000000000050
> >>
> >> Then I replicated the problem on my another machine(no serial console),
> >> here is the stack by manual copy.
> >>
> >> Call Trace:
> >>  pick_next_entity+0xb0/0x160
> >>  pick_task_fair+0x4b/0x90
> >>  __schedule+0x59b/0x12f0
> >>  schedule_idle+0x1e/0x40
> >>  do_idle+0x193/0x2d0
> >>  cpu_startup_entry+0x19/0x20
> >>  start_secondary+0x110/0x150
> >>  secondary_startup_64_no_verify+0xa6/0xab
> > 
> > Interesting. Wondering if we screwed something up in the rebase.
> > 
> > Questions:
> > 1. Does the issue happen if you just apply only up until this patch,
> > or the entire series?
> 
> I applied the entire series and just find a related patch to report the
> issue.

Ok.

> > 2. Do you see the issue in v7? Not much if at all has changed in this
> > part of the code from v7 -> v8 but could be something in the newer
> > kernel.
> > 
> 
> IIRC, I can run uperf successfully on v7.
> I'm on tip/master 2d3e8c9424c9 (origin/master) "Merge branch 'linus'."
> Please let me know if this is a problem, or you have a repo I can pull
> for testing.

Here is a repo with v8 series on top of v5.9 release:
https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/log/?h=coresched-v5.9

thanks,

 - Joel

