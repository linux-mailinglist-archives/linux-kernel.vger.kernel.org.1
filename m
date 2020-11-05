Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC462A84B2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 18:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731260AbgKERRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 12:17:05 -0500
Received: from foss.arm.com ([217.140.110.172]:37858 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbgKERRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 12:17:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62F27142F;
        Thu,  5 Nov 2020 09:17:04 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD75F3F719;
        Thu,  5 Nov 2020 09:17:02 -0800 (PST)
References: <20201105075021.1302386-1-juri.lelli@redhat.com> <jhja6vvztvk.mognet@arm.com> <20201105161236.GA5522@localhost.localdomain> <b279124a-d7f8-9801-8a8a-e2bced504e19@redhat.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>, peterz@infradead.org,
        mingo@redhat.com, glenn@aurora.tech, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, tglx@linutronix.de,
        luca.abeni@santannapisa.it, tommaso.cucinotta@santannapisa.it
Subject: Re: [PATCH] sched/deadline: Fix priority inheritance with multiple scheduling classes
In-reply-to: <b279124a-d7f8-9801-8a8a-e2bced504e19@redhat.com>
Date:   Thu, 05 Nov 2020 17:17:00 +0000
Message-ID: <jhj8sbfzptf.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05/11/20 16:33, Daniel Bristot de Oliveira wrote:
> On 11/5/20 5:12 PM, Juri Lelli wrote:
>> On 05/11/20 15:49, Valentin Schneider wrote:
>>> For my own sake, what affinity problems are you thinking of?
>>>
>>> With proxy exec we have this "funny" dance of shoving the entire blocked-on
>>> chain on a single runqueue to get the right selection out of
>>> pick_next_task(), and that needs to deal with affinity (i.e. move the task
>>> back to a sensible rq once it becomes runnable).
>>>
>>> With the current PI, the waiting tasks are blocked and enqueued in the
>>> pi_waiters tree, so as I see it affinity shouldn't matter; what am I
>>> missing / not seeing? Is that related to bandwidth handling?
>>
>> Think we might break admission control checks if donor and bosted are,
>> for example, on different exclusive sets of CPUs. Guess that is a
>> problem with proxy as well, though.

Right, that gives you different rd's...

>> As said in the comment above, this
>> is unfortunately not much more than a band-aid. Hoping we can buy us
>> some time and fix it properly with proxy.
>
> I agree with Juri that the current approach is known to be broken,
> and that the proxy execution seems to be the mechanisms to go to
> try to address these problems. However, this will take some time.
>
> Meanwhile, this patch that Juri proposes fixes problem
> in the current mechanism - using the same approach (and breaking
> in a known way :D).
>
> A proper way to handle the priority inversion with a disjoint
> set of CPUs is something that will also be an issue with proxy
> execution. But that is an even more complex topic :-(.
>
> So, IMHO, Juri's patch works well to avoid a crash,
> making the system to behave as we expected (even if
> we know that we cannot expect too much).
>

Aye, no disagreement here! I was mainly asking out of "personal interest",
given I too have an eye on proxy exec - and would actually like to get back
to it this month, if my inbox agrees.

>>> With this change, do we still need sched_dl_entity.dl_boosted? AIUI this
>>> could become
>>>
>>>   bool is_dl_boosted(struct sched_dl_entity *dl_se)
>>>   {
>>>           return pi_of(dl_se) != dl_se;
>>>   }
>>
>> Makes sense to me. I'll add this change as a separate patch if the rest
>> makes sense to people as well. :-)
>
> +1

FWIW nothing strikes me as too crazy, so with the above:

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

>
> -- Daniel
>
>>
>> Thanks for the quick review!
>>
>> Best,
>> Juri
>>
