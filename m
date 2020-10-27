Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA1A29A315
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 04:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504516AbgJ0DRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 23:17:15 -0400
Received: from mga07.intel.com ([134.134.136.100]:45687 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2442515AbgJ0DRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 23:17:15 -0400
IronPort-SDR: xZxNBoxQEC9cVmxyt2e22kdUlrErOq/ZCiX+oIGe5IbVAauibxHcmle0u1aoBW0Zv8xEofi4/V
 JfZ87dsx0cUw==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="232208385"
X-IronPort-AV: E=Sophos;i="5.77,422,1596524400"; 
   d="scan'208";a="232208385"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 20:17:13 -0700
IronPort-SDR: UmTG3wTrOWapmJw0go0yrBJY7ZFiP2bFASJRNgqwUXoOL59MoDTzftmnvQCCFBb01ADME4nDVd
 SHgs6zZ+Oj7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,422,1596524400"; 
   d="scan'208";a="361226808"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.135]) ([10.239.161.135])
  by orsmga007.jf.intel.com with ESMTP; 26 Oct 2020 20:17:04 -0700
Subject: Re: [PATCH v8 -tip 02/26] sched: Introduce sched_class::pick_task()
To:     Peter Zijlstra <peterz@infradead.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
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
 <8230ada7-839f-2335-9a55-b09f6a813e91@linux.microsoft.com>
 <20201026090131.GE2628@hirez.programming.kicks-ass.net>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <3c6e2d04-ca47-299c-1131-31f003909875@linux.intel.com>
Date:   Tue, 27 Oct 2020 11:17:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20201026090131.GE2628@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/10/26 17:01, Peter Zijlstra wrote:
> On Sat, Oct 24, 2020 at 08:27:16AM -0400, Vineeth Pillai wrote:
>>
>>
>> On 10/24/20 7:10 AM, Vineeth Pillai wrote:
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index 93a3b874077d..4cae5ac48b60 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -4428,12 +4428,14 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct
>>> sched_entity *curr)
>>>                         se = second;
>>>         }
>>>
>>> -       if (cfs_rq->next && wakeup_preempt_entity(cfs_rq->next, left) <
>>> 1) {
>>> +       if (left && cfs_rq->next &&
>>> +                       wakeup_preempt_entity(cfs_rq->next, left) < 1) {
>>>                 /*
>>>                  * Someone really wants this to run. If it's not unfair,
>>> run it.
>>>                  */
>>>                 se = cfs_rq->next;
>>> -       } else if (cfs_rq->last && wakeup_preempt_entity(cfs_rq->last,
>>> left) < 1) {
>>> +       } else if (left && cfs_rq->last &&
>>> +                       wakeup_preempt_entity(cfs_rq->last, left) < 1) {
>>>                 /*
>>>                  * Prefer last buddy, try to return the CPU to a
>>> preempted task.
>>>
>>>
>>> There reason for left being NULL needs to be investigated. This was
>>> there from v1 and we did not yet get to it. I shall try to debug later
>>> this week.
>>
>> Thinking more about it and looking at the crash, I think that
>> 'left == NULL' can happen in pick_next_entity for core scheduling.
>> If a cfs_rq has only one task that is running, then it will be
>> dequeued and 'left = __pick_first_entity()' will be NULL as the
>> cfs_rq will be empty. This would not happen outside of coresched
>> because we never call pick_tack() before put_prev_task() which
>> will enqueue the task back.
>>
>> With core scheduling, a cpu can call pick_task() for its sibling while
>> the sibling is still running the active task and put_prev_task has yet
>> not been called. This can result in 'left == NULL'.
> 
> Quite correct. Hurmph.. the reason we do this is because... we do the
> update_curr() the wrong way around. And I can't seem to remember why we
> do that (it was in my original patches).
> 
> Something like so seems the obvious thing to do, but I can't seem to
> remember why we're not doing it :-(
> 
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
> 

This patch works too for my benchmark, thanks Peter!
