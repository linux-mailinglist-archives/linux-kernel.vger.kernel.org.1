Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 547BE2BFF12
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 05:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgKWEnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 23:43:25 -0500
Received: from z5.mailgun.us ([104.130.96.5]:46785 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbgKWEnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 23:43:24 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606106603; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=d80h68fjG7KlrZpIJkHBljd8Ur1J7qPPJac5Ux9o5rU=; b=dQaM8XH4Hyff3JuUGZjRvy5ZYuy5wlwsdPrqGja2j1E1GwT92CCVOibtY6CWl1D/Da+B0kUo
 y370G36By145boDWhqcC6lRW5cNx6JP75YYjF7AxzbASTMR9Y1qLmvIs2lD2PV/ehabivDlI
 EmfbDPBNNsgAwWPe8wKDTM+cIHc=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5fbb3deb7f0cfa6a16ef8b7a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 23 Nov 2020 04:43:22
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 33A2CC43465; Mon, 23 Nov 2020 04:43:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.0.101] (unknown [124.123.182.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DB993C43460;
        Mon, 23 Nov 2020 04:43:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DB993C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=neeraju@codeaurora.org
Subject: Re: [PATCH v2 tip/core/rcu 4/6] srcu: Provide polling interfaces for
 Tiny SRCU grace periods
To:     paulmck@kernel.org, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, kent.overstreet@gmail.com
References: <@@@> <20201121005919.17152-4-paulmck@kernel.org>
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
Message-ID: <2d210fa7-3484-9cee-862b-a8f15fee8c8e@codeaurora.org>
Date:   Mon, 23 Nov 2020 10:13:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201121005919.17152-4-paulmck@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/21/2020 6:29 AM, paulmck@kernel.org wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> There is a need for a polling interface for SRCU grace
> periods, so this commit supplies get_state_synchronize_srcu(),
> start_poll_synchronize_srcu(), and poll_state_synchronize_srcu() for this
> purpose.  The first can be used if future grace periods are inevitable
> (perhaps due to a later call_srcu() invocation), the second if future
> grace periods might not otherwise happen, and the third to check if a
> grace period has elapsed since the corresponding call to either of the
> first two.
> 
> As with get_state_synchronize_rcu() and cond_synchronize_rcu(),
> the return value from either get_state_synchronize_srcu() or
> start_poll_synchronize_srcu() must be passed in to a later call to
> poll_state_synchronize_srcu().
> 
> Link: https://lore.kernel.org/rcu/20201112201547.GF3365678@moria.home.lan/
> Reported-by: Kent Overstreet <kent.overstreet@gmail.com>
> [ paulmck: Add EXPORT_SYMBOL_GPL() per kernel test robot feedback. ]
> [ paulmck: Apply feedback from Neeraj Upadhyay. ]
> Link: https://lore.kernel.org/lkml/20201117004017.GA7444@paulmck-ThinkPad-P72/
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>   include/linux/rcupdate.h |  2 ++
>   include/linux/srcu.h     |  3 +++
>   include/linux/srcutiny.h |  1 +
>   kernel/rcu/srcutiny.c    | 52 ++++++++++++++++++++++++++++++++++++++++++++++--
>   4 files changed, 56 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index de08264..e09c0d8 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -33,6 +33,8 @@
>   #define ULONG_CMP_GE(a, b)	(ULONG_MAX / 2 >= (a) - (b))
>   #define ULONG_CMP_LT(a, b)	(ULONG_MAX / 2 < (a) - (b))
>   #define ulong2long(a)		(*(long *)(&(a)))
> +#define USHORT_CMP_GE(a, b)	(USHRT_MAX / 2 >= (unsigned short)((a) - (b)))
> +#define USHORT_CMP_LT(a, b)	(USHRT_MAX / 2 < (unsigned short)((a) - (b)))
>   
>   /* Exported common interfaces */
>   void call_rcu(struct rcu_head *head, rcu_callback_t func);
> diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> index e432cc9..a0895bb 100644
> --- a/include/linux/srcu.h
> +++ b/include/linux/srcu.h
> @@ -60,6 +60,9 @@ void cleanup_srcu_struct(struct srcu_struct *ssp);
>   int __srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp);
>   void __srcu_read_unlock(struct srcu_struct *ssp, int idx) __releases(ssp);
>   void synchronize_srcu(struct srcu_struct *ssp);
> +unsigned long get_state_synchronize_srcu(struct srcu_struct *ssp);
> +unsigned long start_poll_synchronize_srcu(struct srcu_struct *ssp);
> +bool poll_state_synchronize_srcu(struct srcu_struct *ssp, unsigned long cookie);
>   
>   #ifdef CONFIG_DEBUG_LOCK_ALLOC
>   
> diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
> index d9edb67..c7f0c1f 100644
> --- a/include/linux/srcutiny.h
> +++ b/include/linux/srcutiny.h
> @@ -16,6 +16,7 @@
>   struct srcu_struct {
>   	short srcu_lock_nesting[2];	/* srcu_read_lock() nesting depth. */
>   	unsigned short srcu_idx;	/* Current reader array element in bit 0x2. */
> +	unsigned short srcu_idx_max;	/* Furthest future srcu_idx request. */
>   	u8 srcu_gp_running;		/* GP workqueue running? */
>   	u8 srcu_gp_waiting;		/* GP waiting for readers? */
>   	struct swait_queue_head srcu_wq;
> diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> index 3bac1db..b073175 100644
> --- a/kernel/rcu/srcutiny.c
> +++ b/kernel/rcu/srcutiny.c
> @@ -34,6 +34,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp)
>   	ssp->srcu_gp_running = false;
>   	ssp->srcu_gp_waiting = false;
>   	ssp->srcu_idx = 0;
> +	ssp->srcu_idx_max = 0;
>   	INIT_WORK(&ssp->srcu_work, srcu_drive_gp);
>   	INIT_LIST_HEAD(&ssp->srcu_work.entry);
>   	return 0;

Minor: cleanup_srcu_struct() can probably have 2 new sanity checks?

WARN_ON(ssp->srcu_idx != ssp->srcu_idx_max);
WARN_ON(ssp->srcu_idx & 1);

Thanks
Neeraj

> @@ -114,7 +115,7 @@ void srcu_drive_gp(struct work_struct *wp)
>   	struct srcu_struct *ssp;
>   
>   	ssp = container_of(wp, struct srcu_struct, srcu_work);
> -	if (ssp->srcu_gp_running || !READ_ONCE(ssp->srcu_cb_head))
> +	if (ssp->srcu_gp_running || USHORT_CMP_GE(ssp->srcu_idx, READ_ONCE(ssp->srcu_idx_max)))
>   		return; /* Already running or nothing to do. */
>   
>   	/* Remove recently arrived callbacks and wait for readers. */
> @@ -147,13 +148,18 @@ void srcu_drive_gp(struct work_struct *wp)
>   	 * straighten that out.
>   	 */
>   	WRITE_ONCE(ssp->srcu_gp_running, false);
> -	if (READ_ONCE(ssp->srcu_cb_head))
> +	if (USHORT_CMP_GE(ssp->srcu_idx, READ_ONCE(ssp->srcu_idx_max)))
>   		schedule_work(&ssp->srcu_work);
>   }
>   EXPORT_SYMBOL_GPL(srcu_drive_gp);
>   
>   static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
>   {
> +	unsigned short cookie;
> +
> +	cookie = get_state_synchronize_srcu(ssp);
> +	if (USHORT_CMP_LT(READ_ONCE(ssp->srcu_idx_max), cookie))
> +		WRITE_ONCE(ssp->srcu_idx_max, cookie);

Minor: Maybe we can return in the else part of USHORT_CMP_LT check, to 
avoid scheduling work?

Thanks
Neeraj

>   	if (!READ_ONCE(ssp->srcu_gp_running)) {
>   		if (likely(srcu_init_done))
>   			schedule_work(&ssp->srcu_work);
> @@ -196,6 +202,48 @@ void synchronize_srcu(struct srcu_struct *ssp)
>   }
>   EXPORT_SYMBOL_GPL(synchronize_srcu);
>   
> +/*
> + * get_state_synchronize_srcu - Provide an end-of-grace-period cookie
> + */
> +unsigned long get_state_synchronize_srcu(struct srcu_struct *ssp)
> +{
> +	unsigned long ret;
> +
> +	barrier();
> +	ret = (READ_ONCE(ssp->srcu_idx) + 3) & ~0x1;
> +	barrier();
> +	return ret & USHRT_MAX;
> +}
> +EXPORT_SYMBOL_GPL(get_state_synchronize_srcu);
> +
> +/*
> + * start_poll_synchronize_srcu - Provide cookie and start grace period
> + *
> + * The difference between this and get_state_synchronize_srcu() is that
> + * this function ensures that the poll_state_synchronize_srcu() will
> + * eventually return the value true.
> + */
> +unsigned long start_poll_synchronize_srcu(struct srcu_struct *ssp)
> +{
> +	unsigned long ret = get_state_synchronize_srcu(ssp);
> +
> +	srcu_gp_start_if_needed(ssp);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(start_poll_synchronize_srcu);
> +
> +/*
> + * poll_state_synchronize_srcu - Has cookie's grace period ended?
> + */
> +bool poll_state_synchronize_srcu(struct srcu_struct *ssp, unsigned long cookie)
> +{
> +	bool ret = USHORT_CMP_GE(READ_ONCE(ssp->srcu_idx), cookie);
> +
> +	barrier();
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(poll_state_synchronize_srcu);
> +
>   /* Lockdep diagnostics.  */
>   void __init rcu_scheduler_starting(void)
>   {
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of the Code Aurora Forum, hosted by The Linux Foundation
