Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3FF4296959
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 07:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370658AbgJWFZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 01:25:51 -0400
Received: from mga12.intel.com ([192.55.52.136]:7364 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S370648AbgJWFZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 01:25:50 -0400
IronPort-SDR: jBnNP6s1A1cIFIBNzUSjRgYOI1fQ4kxSIdZdbUj/vfvLCOyEGaCVVg4Y9e/9Oi9RaBK/XFJlmy
 sfb3kjfrUZ0w==
X-IronPort-AV: E=McAfee;i="6000,8403,9782"; a="146922566"
X-IronPort-AV: E=Sophos;i="5.77,407,1596524400"; 
   d="scan'208";a="146922566"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 22:25:49 -0700
IronPort-SDR: TypCs3Y627uoQc98vprVBz/mnPBZXoSzEpM6LWc9Tvowcgg1TvTeZi9yiMnG9pN12UelhGu5Zb
 QjYJNnQ+xkuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,407,1596524400"; 
   d="scan'208";a="360118965"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.135]) ([10.239.161.135])
  by orsmga007.jf.intel.com with ESMTP; 22 Oct 2020 22:25:39 -0700
Subject: Re: [PATCH v8 -tip 02/26] sched: Introduce sched_class::pick_task()
To:     Joel Fernandes <joel@joelfernandes.org>
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
        =?UTF-8?B?YmVuYmppYW5nKOiSi+W9qik=?= <benbjiang@tencent.com>,
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
References: <20201020014336.2076526-1-joel@joelfernandes.org>
 <20201020014336.2076526-3-joel@joelfernandes.org>
 <8ea1aa61-4a1c-2687-9f15-1062d37606c7@linux.intel.com>
 <CAEXW_YT-pKJiA-APEtJv9QuyoYB0wNrH3EbAyc=3dwMfav+F6Q@mail.gmail.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <a2b66294-6a66-b5c1-7706-29bc92f416f5@linux.intel.com>
Date:   Fri, 23 Oct 2020 13:25:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAEXW_YT-pKJiA-APEtJv9QuyoYB0wNrH3EbAyc=3dwMfav+F6Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/10/22 23:25, Joel Fernandes wrote:
> On Thu, Oct 22, 2020 at 12:59 AM Li, Aubrey <aubrey.li@linux.intel.com> wrote:
>>
>> On 2020/10/20 9:43, Joel Fernandes (Google) wrote:
>>> From: Peter Zijlstra <peterz@infradead.org>
>>>
>>> Because sched_class::pick_next_task() also implies
>>> sched_class::set_next_task() (and possibly put_prev_task() and
>>> newidle_balance) it is not state invariant. This makes it unsuitable
>>> for remote task selection.
>>>
>>> Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
>>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>> Signed-off-by: Vineeth Remanan Pillai <vpillai@digitalocean.com>
>>> Signed-off-by: Julien Desfossez <jdesfossez@digitalocean.com>
>>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>>> ---
>>>  kernel/sched/deadline.c  | 16 ++++++++++++++--
>>>  kernel/sched/fair.c      | 32 +++++++++++++++++++++++++++++++-
>>>  kernel/sched/idle.c      |  8 ++++++++
>>>  kernel/sched/rt.c        | 14 ++++++++++++--
>>>  kernel/sched/sched.h     |  3 +++
>>>  kernel/sched/stop_task.c | 13 +++++++++++--
>>>  6 files changed, 79 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
>>> index 814ec49502b1..0271a7848ab3 100644
>>> --- a/kernel/sched/deadline.c
>>> +++ b/kernel/sched/deadline.c
>>> @@ -1848,7 +1848,7 @@ static struct sched_dl_entity *pick_next_dl_entity(struct rq *rq,
>>>       return rb_entry(left, struct sched_dl_entity, rb_node);
>>>  }
>>>
>>> -static struct task_struct *pick_next_task_dl(struct rq *rq)
>>> +static struct task_struct *pick_task_dl(struct rq *rq)
>>>  {
>>>       struct sched_dl_entity *dl_se;
>>>       struct dl_rq *dl_rq = &rq->dl;
>>> @@ -1860,7 +1860,18 @@ static struct task_struct *pick_next_task_dl(struct rq *rq)
>>>       dl_se = pick_next_dl_entity(rq, dl_rq);
>>>       BUG_ON(!dl_se);
>>>       p = dl_task_of(dl_se);
>>> -     set_next_task_dl(rq, p, true);
>>> +
>>> +     return p;
>>> +}
>>> +
>>> +static struct task_struct *pick_next_task_dl(struct rq *rq)
>>> +{
>>> +     struct task_struct *p;
>>> +
>>> +     p = pick_task_dl(rq);
>>> +     if (p)
>>> +             set_next_task_dl(rq, p, true);
>>> +
>>>       return p;
>>>  }
>>>
>>> @@ -2517,6 +2528,7 @@ const struct sched_class dl_sched_class
>>>
>>>  #ifdef CONFIG_SMP
>>>       .balance                = balance_dl,
>>> +     .pick_task              = pick_task_dl,
>>>       .select_task_rq         = select_task_rq_dl,
>>>       .migrate_task_rq        = migrate_task_rq_dl,
>>>       .set_cpus_allowed       = set_cpus_allowed_dl,
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index dbd9368a959d..bd6aed63f5e3 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -4450,7 +4450,7 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
>>>        * Avoid running the skip buddy, if running something else can
>>>        * be done without getting too unfair.
>>>        */
>>> -     if (cfs_rq->skip == se) {
>>> +     if (cfs_rq->skip && cfs_rq->skip == se) {
>>>               struct sched_entity *second;
>>>
>>>               if (se == curr) {
>>> @@ -6976,6 +6976,35 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
>>>               set_last_buddy(se);
>>>  }
>>>
>>> +#ifdef CONFIG_SMP
>>> +static struct task_struct *pick_task_fair(struct rq *rq)
>>> +{
>>> +     struct cfs_rq *cfs_rq = &rq->cfs;
>>> +     struct sched_entity *se;
>>> +
>>> +     if (!cfs_rq->nr_running)
>>> +             return NULL;
>>> +
>>> +     do {
>>> +             struct sched_entity *curr = cfs_rq->curr;
>>> +
>>> +             se = pick_next_entity(cfs_rq, NULL);
>>> +
>>> +             if (curr) {
>>> +                     if (se && curr->on_rq)
>>> +                             update_curr(cfs_rq);
>>> +
>>> +                     if (!se || entity_before(curr, se))
>>> +                             se = curr;
>>> +             }
>>> +
>>> +             cfs_rq = group_cfs_rq(se);
>>> +     } while (cfs_rq);
>>> ++
>>> +     return task_of(se);
>>> +}
>>> +#endif
>>
>> One of my machines hangs when I run uperf with only one message:
>> [  719.034962] BUG: kernel NULL pointer dereference, address: 0000000000000050
>>
>> Then I replicated the problem on my another machine(no serial console),
>> here is the stack by manual copy.
>>
>> Call Trace:
>>  pick_next_entity+0xb0/0x160
>>  pick_task_fair+0x4b/0x90
>>  __schedule+0x59b/0x12f0
>>  schedule_idle+0x1e/0x40
>>  do_idle+0x193/0x2d0
>>  cpu_startup_entry+0x19/0x20
>>  start_secondary+0x110/0x150
>>  secondary_startup_64_no_verify+0xa6/0xab
> 
> Interesting. Wondering if we screwed something up in the rebase.
> 
> Questions:
> 1. Does the issue happen if you just apply only up until this patch,
> or the entire series?

I applied the entire series and just find a related patch to report the
issue.

> 2. Do you see the issue in v7? Not much if at all has changed in this
> part of the code from v7 -> v8 but could be something in the newer
> kernel.
> 

IIRC, I can run uperf successfully on v7.
I'm on tip/master 2d3e8c9424c9 (origin/master) "Merge branch 'linus'."
Please let me know if this is a problem, or you have a repo I can pull
for testing.

> We tested this series after rebase heavily so it is indeed strange to
> see this so late.
Cc Hongyu - Maybe we can run the test cases in our hand before next release.

Thanks,
-Aubrey
