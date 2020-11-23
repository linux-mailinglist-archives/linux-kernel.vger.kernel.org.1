Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7FC2BFF02
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 05:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgKWEeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 23:34:36 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:42135 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbgKWEef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 23:34:35 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606106074; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=tuOVTBD2eO8CMw/YgqeuPXQm8QBPADRBdC4GfUc9v64=; b=KWlRMFvCqyZ7D04d0eH3Fj0+dbI3KkeRXfvUuI1ZT625gyi5dfc1XuRrbOeSZmy/1A1ejgmy
 kLjaW/KJ1LylCF1GB8ryy4YQ/VbmygSPhPeGk67McwoMigDZqtd2e08wujsXU/GBz4oRnhs8
 e+zMlxc4lnOEalPI/8kofmNeoTA=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5fbb3bd81dba509aae2138ea (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 23 Nov 2020 04:34:32
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 53A7EC433C6; Mon, 23 Nov 2020 04:34:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.0.101] (unknown [124.123.182.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 49079C433ED;
        Mon, 23 Nov 2020 04:34:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 49079C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=neeraju@codeaurora.org
Subject: Re: [PATCH RFC tip/core/rcu 4/5] srcu: Provide polling interfaces for
 Tiny SRCU grace periods
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
References: <20201117004017.GA7444@paulmck-ThinkPad-P72>
 <20201117004052.14758-4-paulmck@kernel.org>
 <f7a47e5f-095c-e4ba-ece0-83f2137fb381@codeaurora.org>
 <20201121001336.GN1437@paulmck-ThinkPad-P72>
 <a54bc494-30cf-4e4e-f895-4803c66040c2@codeaurora.org>
 <20201122180105.GA1437@paulmck-ThinkPad-P72>
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
Message-ID: <3e2dceb0-5128-28c0-454f-2a60bd5ea4e5@codeaurora.org>
Date:   Mon, 23 Nov 2020 10:04:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201122180105.GA1437@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/22/2020 11:31 PM, Paul E. McKenney wrote:
> On Sun, Nov 22, 2020 at 07:57:26PM +0530, Neeraj Upadhyay wrote:
>> On 11/21/2020 5:43 AM, Paul E. McKenney wrote:
>>> On Fri, Nov 20, 2020 at 05:28:32PM +0530, Neeraj Upadhyay wrote:
>>>> Hi Paul,
>>>>
>>>> On 11/17/2020 6:10 AM, paulmck@kernel.org wrote:
>>>>> From: "Paul E. McKenney" <paulmck@kernel.org>
>>>>>
>>>>> There is a need for a polling interface for SRCU grace
>>>>> periods, so this commit supplies get_state_synchronize_srcu(),
>>>>> start_poll_synchronize_srcu(), and poll_state_synchronize_srcu() for this
>>>>> purpose.  The first can be used if future grace periods are inevitable
>>>>> (perhaps due to a later call_srcu() invocation), the second if future
>>>>> grace periods might not otherwise happen, and the third to check if a
>>>>> grace period has elapsed since the corresponding call to either of the
>>>>> first two.
>>>>>
>>>>> As with get_state_synchronize_rcu() and cond_synchronize_rcu(),
>>>>> the return value from either get_state_synchronize_srcu() or
>>>>> start_poll_synchronize_srcu() must be passed in to a later call to
>>>>> poll_state_synchronize_srcu().
>>>>>
>>>>> Link: https://lore.kernel.org/rcu/20201112201547.GF3365678@moria.home.lan/
>>>>> Reported-by: Kent Overstreet <kent.overstreet@gmail.com>
>>>>> [ paulmck: Add EXPORT_SYMBOL_GPL() per kernel test robot feedback. ]
>>>>> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>>>>> ---
>>>>>     include/linux/rcupdate.h |  2 ++
>>>>>     include/linux/srcu.h     |  3 +++
>>>>>     include/linux/srcutiny.h |  1 +
>>>>>     kernel/rcu/srcutiny.c    | 52 ++++++++++++++++++++++++++++++++++++++++++++++--
>>>>>     4 files changed, 56 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
>>>>> index de08264..e09c0d8 100644
>>>>> --- a/include/linux/rcupdate.h
>>>>> +++ b/include/linux/rcupdate.h
>>>>> @@ -33,6 +33,8 @@
>>>>>     #define ULONG_CMP_GE(a, b)	(ULONG_MAX / 2 >= (a) - (b))
>>>>>     #define ULONG_CMP_LT(a, b)	(ULONG_MAX / 2 < (a) - (b))
>>>>>     #define ulong2long(a)		(*(long *)(&(a)))
>>>>> +#define USHORT_CMP_GE(a, b)	(USHRT_MAX / 2 >= (unsigned short)((a) - (b)))
>>>>> +#define USHORT_CMP_LT(a, b)	(USHRT_MAX / 2 < (unsigned short)((a) - (b)))
>>>>>     /* Exported common interfaces */
>>>>>     void call_rcu(struct rcu_head *head, rcu_callback_t func);
>>>>> diff --git a/include/linux/srcu.h b/include/linux/srcu.h
>>>>> index e432cc9..a0895bb 100644
>>>>> --- a/include/linux/srcu.h
>>>>> +++ b/include/linux/srcu.h
>>>>> @@ -60,6 +60,9 @@ void cleanup_srcu_struct(struct srcu_struct *ssp);
>>>>>     int __srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp);
>>>>>     void __srcu_read_unlock(struct srcu_struct *ssp, int idx) __releases(ssp);
>>>>>     void synchronize_srcu(struct srcu_struct *ssp);
>>>>> +unsigned long get_state_synchronize_srcu(struct srcu_struct *ssp);
>>>>> +unsigned long start_poll_synchronize_srcu(struct srcu_struct *ssp);
>>>>> +bool poll_state_synchronize_srcu(struct srcu_struct *ssp, unsigned long cookie);
>>>>>     #ifdef CONFIG_DEBUG_LOCK_ALLOC
>>>>> diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
>>>>> index fed4a2d..e9bd6fb 100644
>>>>> --- a/include/linux/srcutiny.h
>>>>> +++ b/include/linux/srcutiny.h
>>>>> @@ -16,6 +16,7 @@
>>>>>     struct srcu_struct {
>>>>>     	short srcu_lock_nesting[2];	/* srcu_read_lock() nesting depth. */
>>>>>     	unsigned short srcu_idx;	/* Current reader array element in bit 0x2. */
>>>>> +	unsigned short srcu_idx_max;	/* Furthest future srcu_idx request. */
>>>>>     	u8 srcu_gp_running;		/* GP workqueue running? */
>>>>>     	u8 srcu_gp_waiting;		/* GP waiting for readers? */
>>>>>     	struct swait_queue_head srcu_wq;
>>>>> diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
>>>>> index 3bac1db..b405811 100644
>>>>> --- a/kernel/rcu/srcutiny.c
>>>>> +++ b/kernel/rcu/srcutiny.c
>>>>> @@ -34,6 +34,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp)
>>>>>     	ssp->srcu_gp_running = false;
>>>>>     	ssp->srcu_gp_waiting = false;
>>>>>     	ssp->srcu_idx = 0;
>>>>> +	ssp->srcu_idx_max = 0;
>>>>>     	INIT_WORK(&ssp->srcu_work, srcu_drive_gp);
>>>>>     	INIT_LIST_HEAD(&ssp->srcu_work.entry);
>>>>>     	return 0;
>>>>> @@ -114,7 +115,7 @@ void srcu_drive_gp(struct work_struct *wp)
>>>>>     	struct srcu_struct *ssp;
>>>>>     	ssp = container_of(wp, struct srcu_struct, srcu_work);
>>>>> -	if (ssp->srcu_gp_running || !READ_ONCE(ssp->srcu_cb_head))
>>>>> +	if (ssp->srcu_gp_running || USHORT_CMP_GE(ssp->srcu_idx, READ_ONCE(ssp->srcu_idx_max)))
>>>>>     		return; /* Already running or nothing to do. */
>>>>>     	/* Remove recently arrived callbacks and wait for readers. */
>>>>> @@ -147,14 +148,19 @@ void srcu_drive_gp(struct work_struct *wp)
>>>>>     	 * straighten that out.
>>>>>     	 */
>>>>>     	WRITE_ONCE(ssp->srcu_gp_running, false);
>>>>> -	if (READ_ONCE(ssp->srcu_cb_head))
>>>>> +	if (USHORT_CMP_GE(ssp->srcu_idx, READ_ONCE(ssp->srcu_idx_max)))
>>>>
>>>> Should this be USHORT_CMP_LT ?
>>>
>>> I believe that you are correct.  As is, it works but does needless
>>> grace periods.
>>>
>>>>>     		schedule_work(&ssp->srcu_work);
>>>>>     }
>>>>>     EXPORT_SYMBOL_GPL(srcu_drive_gp);
>>>>>     static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
>>>>>     {
>>>>> +	unsigned short cookie;
>>>>> +
>>>>>     	if (!READ_ONCE(ssp->srcu_gp_running)) {
>>>>> +		cookie = get_state_synchronize_srcu(ssp);
>>>>> +		if (USHORT_CMP_LT(READ_ONCE(ssp->srcu_idx_max), cookie))
>>>>> +			WRITE_ONCE(ssp->srcu_idx_max, cookie);
>>>>
>>>> I was thinking of a case which might break with this.
>>>>
>>>> Consider a scenario, where GP is in progress and kworker is right
>>>> before below point, after executing callbacks:
>>>>
>>>> void srcu_drive_gp(struct work_struct *wp) {
>>>>     <snip>
>>>
>>> We updated ->srcu_idx up here, correct?  So it has bottom bit zero.
>>>
>>>>     while (lh) {
>>>>     <cb execution loop>
>>>>     }
>>>>     >>> CURRENT EXECUTION POINT
>>>
>>> Keeping in mind that Tiny SRCU always runs !PREEMPT, this must be
>>> due to an interrupt.
>>>
>> Looking more, issue can happen, even when kworker is waiting for GP
>> completion @
>>
>> swait_event_exclusive(ssp->srcu_wq,
>> !READ_ONCE(ssp->srcu_lock_nesting[idx]));
>>
>> Other process can call call_srcu() and skip srcu_idx_max update, as
>> ssp->srcu_gp_running is true.
> 
> Good point!  Does this mean that additional changes are required,
> or does the fix below cover this situation as well?
> 
> 							Thanx, Paul
> 

I think the current fix covers this. Just wanted to higlight that
the window is not small and a rcutorture test case might be able to 
uncover the issue?


Thanks
Neeraj

>> Thanks
>> Neeraj
>>
>>>>     WRITE_ONCE(ssp->srcu_gp_running, false);
>>>>
>>>>     if (USHORT_CMP_LT(ssp->srcu_idx, READ_ONCE(ssp->srcu_idx_max)))
>>>>       schedule_work(&ssp->srcu_work);
>>>> }
>>>>
>>>> Now, at this instance, srcu_gp_start_if_needed() runs and samples
>>>> srcu_gp_running and returns, without updating srcu_idx_max
>>>>
>>>> static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
>>>> {
>>>>     if (!READ_ONCE(ssp->srcu_gp_running)) returns true
>>>>     <snip>
>>>> }
>>>
>>> This could happen in an interrupt handler, so with you thus far.
>>>
>>>> kworker running srcu_drive_gp() resumes and returns without queueing a new
>>>> schedule_work(&ssp->srcu_work); for new GP?
>>>>
>>>> Prior to this patch, call_srcu() enqueues a cb before entering
>>>> srcu_gp_start_if_needed(), and srcu_drive_gp() observes this
>>>> queuing, and schedule a work for the new GP, for this scenario.
>>>>
>>>>
>>>>    	WRITE_ONCE(ssp->srcu_gp_running, false);
>>>> -	if (READ_ONCE(ssp->srcu_cb_head))
>>>> +	if (USHORT_CMP_GE(ssp->srcu_idx, READ_ONCE(ssp->srcu_idx_max)))
>>>>    		schedule_work(&ssp->srcu_work);
>>>>
>>>> So, should the "cookie" calculation and "srcu_idx_max" setting be moved
>>>> outside of ssp->srcu_gp_running check and maybe return the same cookie to
>>>> caller and use that as the returned cookie from
>>>> start_poll_synchronize_srcu() ?
>>>>
>>>> srcu_gp_start_if_needed()
>>>>     cookie = get_state_synchronize_srcu(ssp);
>>>>     if (USHORT_CMP_LT(READ_ONCE(ssp->srcu_idx_max), cookie))
>>>>        WRITE_ONCE(ssp->srcu_idx_max, cookie);
>>>>     if (!READ_ONCE(ssp->srcu_gp_running)) {
>>>>     <snip>
>>>> }
>>>
>>> I believe that you are quite correct, thank you!
>>>
>>> But rcutorture does have a call_srcu() (really a ->call, but same if SRCU)
>>> in a timer handler.  The race window is quite narrow, so testing it might
>>> be a challenge...
>>>
>>> This is what I end up with:
>>>
>>> 	static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
>>> 	{
>>> 		unsigned short cookie;
>>>
>>> 		cookie = get_state_synchronize_srcu(ssp);
>>> 		if (USHORT_CMP_LT(READ_ONCE(ssp->srcu_idx_max), cookie))
>>> 			WRITE_ONCE(ssp->srcu_idx_max, cookie);
>>> 		if (!READ_ONCE(ssp->srcu_gp_running)) {
>>> 			if (likely(srcu_init_done))
>>> 				schedule_work(&ssp->srcu_work);
>>> 			else if (list_empty(&ssp->srcu_work.entry))
>>> 				list_add(&ssp->srcu_work.entry, &srcu_boot_list);
>>> 		}
>>> 	}
>>>
>>> Does that look plausible?
>>
>> Looks good.
>>
>>>
>>> 							Thanx, Paul
>>>
>>
>> -- 
>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of
>> the Code Aurora Forum, hosted by The Linux Foundation

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of the Code Aurora Forum, hosted by The Linux Foundation
