Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96473297C4F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 14:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761378AbgJXM1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 08:27:25 -0400
Received: from linux.microsoft.com ([13.77.154.182]:50258 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761371AbgJXM1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 08:27:24 -0400
Received: from [192.168.86.211] (c-73-38-52-84.hsd1.vt.comcast.net [73.38.52.84])
        by linux.microsoft.com (Postfix) with ESMTPSA id 426CD20B4905;
        Sat, 24 Oct 2020 05:27:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 426CD20B4905
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1603542443;
        bh=qUKEiaaGFJQ56Nx5gaWkWp7EAEbVcuu2OEIi8+ZL+Rw=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=CzpV6K3/ewCfh+99KHsZHKW7FFWPT8iHnnH9UgMNx+0IWV5W51O2JK9qQofq7xdu4
         PEDYC5lDpjnX1x3WgaYTvUnpt5xavQcjGHjuSb+nUZoUc9ctIldbXFwq1S1IooTsKV
         TyrwQ1gQ6j/tqUlSRsaZ03rbiZ+oa/YLHJd7dUPg=
Subject: Re: [PATCH v8 -tip 02/26] sched: Introduce sched_class::pick_task()
From:   Vineeth Pillai <viremana@linux.microsoft.com>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
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
        =?UTF-8?B?YmVuYmppYW5nKOiSi+W9qik=?= <benbjiang@tencent.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>,
        "Ning, Hongyu" <hongyu.ning@linux.intel.com>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
 <20201020014336.2076526-3-joel@joelfernandes.org>
 <8ea1aa61-4a1c-2687-9f15-1062d37606c7@linux.intel.com>
 <CAEXW_YT-pKJiA-APEtJv9QuyoYB0wNrH3EbAyc=3dwMfav+F6Q@mail.gmail.com>
 <a2b66294-6a66-b5c1-7706-29bc92f416f5@linux.intel.com>
 <20201023214702.GA3603399@google.com>
 <d9a70e58-f424-3957-9957-b89071480005@linux.intel.com>
 <4241e5ac-ecdf-8634-fa0d-dd6759e477e1@linux.microsoft.com>
Message-ID: <8230ada7-839f-2335-9a55-b09f6a813e91@linux.microsoft.com>
Date:   Sat, 24 Oct 2020 08:27:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <4241e5ac-ecdf-8634-fa0d-dd6759e477e1@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/24/20 7:10 AM, Vineeth Pillai wrote:
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 93a3b874077d..4cae5ac48b60 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4428,12 +4428,14 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct 
> sched_entity *curr)
>                         se = second;
>         }
>
> -       if (cfs_rq->next && wakeup_preempt_entity(cfs_rq->next, left) 
> < 1) {
> +       if (left && cfs_rq->next &&
> +                       wakeup_preempt_entity(cfs_rq->next, left) < 1) {
>                 /*
>                  * Someone really wants this to run. If it's not 
> unfair, run it.
>                  */
>                 se = cfs_rq->next;
> -       } else if (cfs_rq->last && wakeup_preempt_entity(cfs_rq->last, 
> left) < 1) {
> +       } else if (left && cfs_rq->last &&
> +                       wakeup_preempt_entity(cfs_rq->last, left) < 1) {
>                 /*
>                  * Prefer last buddy, try to return the CPU to a 
> preempted task.
>
>
> There reason for left being NULL needs to be investigated. This was
> there from v1 and we did not yet get to it. I shall try to debug later
> this week.

Thinking more about it and looking at the crash, I think that
'left == NULL' can happen in pick_next_entity for core scheduling.
If a cfs_rq has only one task that is running, then it will be
dequeued and 'left = __pick_first_entity()' will be NULL as the
cfs_rq will be empty. This would not happen outside of coresched
because we never call pick_tack() before put_prev_task() which
will enqueue the task back.

With core scheduling, a cpu can call pick_task() for its sibling while
the sibling is still running the active task and put_prev_task has yet
not been called. This can result in 'left == NULL'. So I think the
above fix is appropriate when core scheduling is active. It could be
cleaned up a bit though.

Thanks,
Vineeth

