Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D302BA94D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 12:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbgKTLg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 06:36:26 -0500
Received: from z5.mailgun.us ([104.130.96.5]:18504 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726123AbgKTLg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 06:36:26 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605872185; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=WN5oSJatZKvg9t0/CJOWr+ndW71BqBE1aHw3x3obRKA=; b=VXyEdkDXAdwAwkoixe3cXDig/TwOhzfNBviOtAQUkTGo6bbs/fFn5j1+WRMPmvWgM6pR7uSG
 81ryulAbGBMDo14/k1oiwpdchLNzF5vZxlb1YQac4krDaUQH1XSneDSBASBjwjl64xwoqTmz
 hDyNP/Le5DLQFP3tN7p6AzsD6d8=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5fb7aa371dba509aaead1a2c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 20 Nov 2020 11:36:23
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8ACE0C433C6; Fri, 20 Nov 2020 11:36:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.0.101] (unknown [124.123.182.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3CC94C433ED;
        Fri, 20 Nov 2020 11:36:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3CC94C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=neeraju@codeaurora.org
Subject: Re: [PATCH RFC tip/core/rcu 2/5] srcu: Provide internal interface to
 start a Tiny SRCU grace period
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, rcu@vger.kernel.org
References: <20201117004017.GA7444@paulmck-ThinkPad-P72>
 <20201117004052.14758-2-paulmck@kernel.org>
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
Message-ID: <b1e7949d-71ff-7a47-ea3b-04ef6579b9df@codeaurora.org>
Date:   Fri, 20 Nov 2020 17:06:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201117004052.14758-2-paulmck@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/17/2020 6:10 AM, paulmck@kernel.org wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> There is a need for a polling interface for SRCU grace periods.
> This polling needs to initiate an SRCU grace period without
> having to queue (and manage) a callback.  This commit therefore
> splits the Tiny SRCU call_srcu() function into callback-queuing and
> start-grace-period portions, with the latter in a new function named
> srcu_gp_start_if_needed().
> 
> Link: https://lore.kernel.org/rcu/20201112201547.GF3365678@moria.home.lan/
> Reported-by: Kent Overstreet <kent.overstreet@gmail.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---

Reviewed-by: Neeraj Upadhyay <neeraju@codeaurora.org>


Thanks
Neeraj

>   kernel/rcu/srcutiny.c | 17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> index 5598cf6..3bac1db 100644
> --- a/kernel/rcu/srcutiny.c
> +++ b/kernel/rcu/srcutiny.c
> @@ -152,6 +152,16 @@ void srcu_drive_gp(struct work_struct *wp)
>   }
>   EXPORT_SYMBOL_GPL(srcu_drive_gp);
>   
> +static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
> +{
> +	if (!READ_ONCE(ssp->srcu_gp_running)) {
> +		if (likely(srcu_init_done))
> +			schedule_work(&ssp->srcu_work);
> +		else if (list_empty(&ssp->srcu_work.entry))
> +			list_add(&ssp->srcu_work.entry, &srcu_boot_list);
> +	}
> +}
> +
>   /*
>    * Enqueue an SRCU callback on the specified srcu_struct structure,
>    * initiating grace-period processing if it is not already running.
> @@ -167,12 +177,7 @@ void call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
>   	*ssp->srcu_cb_tail = rhp;
>   	ssp->srcu_cb_tail = &rhp->next;
>   	local_irq_restore(flags);
> -	if (!READ_ONCE(ssp->srcu_gp_running)) {
> -		if (likely(srcu_init_done))
> -			schedule_work(&ssp->srcu_work);
> -		else if (list_empty(&ssp->srcu_work.entry))
> -			list_add(&ssp->srcu_work.entry, &srcu_boot_list);
> -	}
> +	srcu_gp_start_if_needed(ssp);
>   }
>   EXPORT_SYMBOL_GPL(call_srcu);
>   
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of the Code Aurora Forum, hosted by The Linux Foundation
