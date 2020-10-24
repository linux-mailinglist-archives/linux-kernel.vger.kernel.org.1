Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920FF297C09
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 13:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761037AbgJXLLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 07:11:06 -0400
Received: from linux.microsoft.com ([13.77.154.182]:41094 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759511AbgJXLKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 07:10:33 -0400
Received: from [192.168.86.179] (c-73-38-52-84.hsd1.vt.comcast.net [73.38.52.84])
        by linux.microsoft.com (Postfix) with ESMTPSA id 751AD20B4905;
        Sat, 24 Oct 2020 04:10:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 751AD20B4905
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1603537832;
        bh=YshX4IZjFRFJAbMvhPuFYrsQnTBTJ7RfpH7w79K038k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fPvb9idMoYeK/5RgEwnQwga2GqzNqXJTqHGWBHV+lQw+FszzF1kWqrEKmDB2XbIAy
         LcNOzvCsstUfzvwfysS8a8+FboV7d32fLqYwjTrUg4aYjZcw2n/dguTokx8ivdDndq
         MroJBRBasbElWDMIgXOvqCsfMD4nQtmhpliJdVIM=
Subject: Re: [PATCH v8 -tip 02/26] sched: Introduce sched_class::pick_task()
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
From:   Vineeth Pillai <viremana@linux.microsoft.com>
Message-ID: <4241e5ac-ecdf-8634-fa0d-dd6759e477e1@linux.microsoft.com>
Date:   Sat, 24 Oct 2020 07:10:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <d9a70e58-f424-3957-9957-b89071480005@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aubrey,


On 10/23/20 10:48 PM, Li, Aubrey wrote:
>
>>>> 2. Do you see the issue in v7? Not much if at all has changed in this
>>>> part of the code from v7 -> v8 but could be something in the newer
>>>> kernel.
>>>>
>>> IIRC, I can run uperf successfully on v7.
>>> I'm on tip/master 2d3e8c9424c9 (origin/master) "Merge branch 'linus'."
>>> Please let me know if this is a problem, or you have a repo I can pull
>>> for testing.
>> Here is a repo with v8 series on top of v5.9 release:
>> https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/log/?h=coresched-v5.9
> I didn't see NULL pointer dereference BUG of this repo, will post performance
> data later.
There has been a change in tip in pick_next_entity which caused
removal of a coresched related change to fix the crash. Could
you please try this patch on top of the posted v8 and see if this
works?

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 93a3b874077d..4cae5ac48b60 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4428,12 +4428,14 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
                         se = second;
         }

-       if (cfs_rq->next && wakeup_preempt_entity(cfs_rq->next, left) < 1) {
+       if (left && cfs_rq->next &&
+                       wakeup_preempt_entity(cfs_rq->next, left) < 1) {
                 /*
                  * Someone really wants this to run. If it's not unfair, run it.
                  */
                 se = cfs_rq->next;
-       } else if (cfs_rq->last && wakeup_preempt_entity(cfs_rq->last, left) < 1) {
+       } else if (left && cfs_rq->last &&
+                       wakeup_preempt_entity(cfs_rq->last, left) < 1) {
                 /*
                  * Prefer last buddy, try to return the CPU to a preempted task.


There reason for left being NULL needs to be investigated. This was
there from v1 and we did not yet get to it. I shall try to debug later
this week.

Kindly test this patch and let us know if it fixes the crash.

Thanks,
Vineeth
