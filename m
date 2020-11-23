Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B2D2BFF00
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 05:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgKWEbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 23:31:24 -0500
Received: from z5.mailgun.us ([104.130.96.5]:64850 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727056AbgKWEbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 23:31:24 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606105884; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=wRtysrG/vg9CRZN6VmVb9Fe3QiwYLJ11RuUPsob/uaA=; b=v0Ced/V4zcniel6scSYyGCK3JYKpps10ssFmhg/zYSesUD9vB7dDn+qZ6nWnbYvWNq2ebZui
 Vktok9s251VM9Kk+jN8u3uknM8Lh9HzJ51F57RoUZYf2oKFzKxZg0y8DOC3H45EyUuR7hyXx
 xRgtrXwQ16t+69N0Y1v6aLBj6qo=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5fbb3b1bb9b39088ed8fc77e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 23 Nov 2020 04:31:23
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 55E1DC433ED; Mon, 23 Nov 2020 04:31:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.0.101] (unknown [124.123.182.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A3A03C433C6;
        Mon, 23 Nov 2020 04:31:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A3A03C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=neeraju@codeaurora.org
Subject: Re: [PATCH v2 tip/core/rcu 1/6] srcu: Make Tiny SRCU use multi-bit
 grace-period counter
To:     paulmck@kernel.org, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, kent.overstreet@gmail.com
References: <@@@> <20201121005919.17152-1-paulmck@kernel.org>
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
Message-ID: <f70d1032-8e0f-37bf-9ab0-33e85bc8643c@codeaurora.org>
Date:   Mon, 23 Nov 2020 10:01:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201121005919.17152-1-paulmck@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/21/2020 6:29 AM, paulmck@kernel.org wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> There is a need for a polling interface for SRCU grace periods.  This
> polling needs to distinguish between an SRCU instance being idle on the
> one hand or in the middle of a grace period on the other.  This commit
> therefore converts the Tiny SRCU srcu_struct structure's srcu_idx from
> a defacto boolean to a free-running counter, using the bottom bit to
> indicate that a grace period is in progress.  The second-from-bottom
> bit is thus used as the index returned by srcu_read_lock().
> 
> Link: https://lore.kernel.org/rcu/20201112201547.GF3365678@moria.home.lan/
> Reported-by: Kent Overstreet <kent.overstreet@gmail.com>
> [ paulmck: Fix __srcu_read_lock() idx computation Neeraj per Upadhyay. ]
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>   include/linux/srcutiny.h | 4 ++--
>   kernel/rcu/srcutiny.c    | 5 +++--
>   2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
> index 5a5a194..d9edb67 100644
> --- a/include/linux/srcutiny.h
> +++ b/include/linux/srcutiny.h
> @@ -15,7 +15,7 @@
>   
>   struct srcu_struct {
>   	short srcu_lock_nesting[2];	/* srcu_read_lock() nesting depth. */
> -	short srcu_idx;			/* Current reader array element. */
> +	unsigned short srcu_idx;	/* Current reader array element in bit 0x2. */
>   	u8 srcu_gp_running;		/* GP workqueue running? */
>   	u8 srcu_gp_waiting;		/* GP waiting for readers? */
>   	struct swait_queue_head srcu_wq;
> @@ -59,7 +59,7 @@ static inline int __srcu_read_lock(struct srcu_struct *ssp)
>   {
>   	int idx;
>   
> -	idx = READ_ONCE(ssp->srcu_idx);
> +	idx = ((READ_ONCE(ssp->srcu_idx) + 1) & 0x2) >> 1;
>   	WRITE_ONCE(ssp->srcu_lock_nesting[idx], ssp->srcu_lock_nesting[idx] + 1);
>   	return idx;
>   }

Need change in idx calcultion in srcu_torture_stats_print() ?

static inline void srcu_torture_stats_print(struct srcu_struct *ssp,
   idx = READ_ONCE(ssp->srcu_idx) & 0x1;

Thanks
Neeraj

> diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> index 6208c1d..5598cf6 100644
> --- a/kernel/rcu/srcutiny.c
> +++ b/kernel/rcu/srcutiny.c
> @@ -124,11 +124,12 @@ void srcu_drive_gp(struct work_struct *wp)
>   	ssp->srcu_cb_head = NULL;
>   	ssp->srcu_cb_tail = &ssp->srcu_cb_head;
>   	local_irq_enable();
> -	idx = ssp->srcu_idx;
> -	WRITE_ONCE(ssp->srcu_idx, !ssp->srcu_idx);
> +	idx = (ssp->srcu_idx & 0x2) / 2;
> +	WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1);
>   	WRITE_ONCE(ssp->srcu_gp_waiting, true);  /* srcu_read_unlock() wakes! */
>   	swait_event_exclusive(ssp->srcu_wq, !READ_ONCE(ssp->srcu_lock_nesting[idx]));
>   	WRITE_ONCE(ssp->srcu_gp_waiting, false); /* srcu_read_unlock() cheap. */
> +	WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1);
>   
>   	/* Invoke the callbacks we removed above. */
>   	while (lh) {
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of the Code Aurora Forum, hosted by The Linux Foundation
