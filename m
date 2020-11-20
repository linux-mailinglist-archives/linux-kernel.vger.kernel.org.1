Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE542BB229
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 19:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729494AbgKTSLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 13:11:16 -0500
Received: from linux.microsoft.com ([13.77.154.182]:34522 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729508AbgKTSLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 13:11:13 -0500
Received: from [192.168.86.179] (c-73-38-52-84.hsd1.vt.comcast.net [73.38.52.84])
        by linux.microsoft.com (Postfix) with ESMTPSA id D301E20B717A;
        Fri, 20 Nov 2020 10:11:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D301E20B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1605895872;
        bh=o3HGfEV+KvcBH59b0ShX6ILxpiauc3u3nnu8jBOhqu8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mChXe2XyjeoACPf6tie7qgKERp54WJ9C483uVNUX2LsivEAa30sUYo41XFsixb0Za
         ceqjBlDYfyAHhLZNldwbHFYf+TO36eNNjsSHz44VvPSoVDNNo8C8/rQlXjIUQrZZV7
         jDol1/79uRl+bRC189L4xfbZwZnqppaUMjjG8gJo=
Subject: Re: [PATCH -tip 03/32] sched/fair: Fix pick_task_fair crashes due to
 empty rbtree
To:     "Singh, Balbir" <bsingharora@gmail.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        pjt@google.com, rostedt@goodmis.org, derkling@google.com,
        benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>, jsbarnes@google.com,
        chris.hyser@oracle.com, Ben Segall <bsegall@google.com>,
        Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-4-joel@joelfernandes.org>
 <cab6918c-7b52-923c-4274-f92e9f0a5cd2@gmail.com>
From:   Vineeth Pillai <viremana@linux.microsoft.com>
Message-ID: <caa77c3c-dc21-5c64-8236-d9e7d4c90995@linux.microsoft.com>
Date:   Fri, 20 Nov 2020 13:11:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <cab6918c-7b52-923c-4274-f92e9f0a5cd2@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Balbir,

On 11/20/20 5:15 AM, Singh, Balbir wrote:
> On 18/11/20 10:19 am, Joel Fernandes (Google) wrote:
>> From: Peter Zijlstra <peterz@infradead.org>
>>
>> pick_next_entity() is passed curr == NULL during core-scheduling. Due to
>> this, if the rbtree is empty, the 'left' variable is set to NULL within
>> the function. This can cause crashes within the function.
>>
>> This is not an issue if put_prev_task() is invoked on the currently
>> running task before calling pick_next_entity(). However, in core
>> scheduling, it is possible that a sibling CPU picks for another RQ in
>> the core, via pick_task_fair(). This remote sibling would not get any
>> opportunities to do a put_prev_task().
>>
>> Fix it by refactoring pick_task_fair() such that pick_next_entity() is
>> called with the cfs_rq->curr. This will prevent pick_next_entity() from
>> crashing if its rbtree is empty.
>>
>> Also this fixes another possible bug where update_curr() would not be
>> called on the cfs_rq hierarchy if the rbtree is empty. This could effect
>> cross-cpu comparison of vruntime.
>>
> It is not clear from the changelog as to what does put_prev_task() do to prevent
> the crash from occuring? Why did we pass NULL as curr in the first place to
> pick_next_entity?
A little more context on this crash in v8 is here:
https://lwn.net/ml/linux-kernel/8230ada7-839f-2335-9a55-b09f6a813e91@linux.microsoft.com/

The issue here arises from the fact that, we try to pick task for a
sibling while sibling is running a task. Running tasks are not in the
cfs_rq and pick_next_entity can return NULL if there is only one cfs
task in the cfs_rq. This would not happen normally because
put_prev_task is called before pick_task and put_prev_task adds the
task back to cfs_rq. But for coresched, pick_task is called on a
remote sibling's cfs_rq without calling put_prev_task and this can
lead to pick_next_entity returning NULL.

The initial logic of passing NULL would work fine as long as we call
put_prev_task before calling pick_task_fair. But for coresched, we
call pick_task_fair on siblings while the task is running and would
not be able to call put_prev_task. So this refactor of the code fixes
the crash by explicitly passing curr.

Hope this clarifies..

Thanks,
Vineeth

