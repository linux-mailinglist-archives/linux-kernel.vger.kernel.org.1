Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D0F278007
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 07:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgIYFtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 01:49:08 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:49604 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbgIYFtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 01:49:07 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601012947; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=yaFni00gAx1AGPeqT5ylrZn2luK1UE/VMDtAh34DsZU=; b=Vkv2CAbk8pqy3BwFuSHYjPWFVhqTNHCzVE1HXT5MRNX12CnGAbVmCJpWLDIukfZRbNOe5g38
 2phnTBICuUXzQwIxp8ydxu2ePGGCCg1Wh6mIfgTyR3sgCX3Puo3L6AueiUwJBJerj6kkMkEY
 9kGkWyOiZfIrw9CBJyy8/DYqCNg=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f6d84601dcd99b9f2630c25 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 25 Sep 2020 05:47:12
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B2F0DC433FF; Fri, 25 Sep 2020 05:47:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.0.103] (unknown [124.123.174.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0836AC433C8;
        Fri, 25 Sep 2020 05:47:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0836AC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=neeraju@codeaurora.org
Subject: Re: [PATCH] rcu: Clarify nocb kthreads naming in RCU_NOCB_CPU config
To:     paulmck@kernel.org
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1600929250-20344-1-git-send-email-neeraju@codeaurora.org>
 <20200924225959.GY29330@paulmck-ThinkPad-P72>
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
Message-ID: <e5406694-0382-fafe-d22a-ad8913ccc4c2@codeaurora.org>
Date:   Fri, 25 Sep 2020 11:17:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200924225959.GY29330@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 9/25/2020 4:29 AM, Paul E. McKenney wrote:
> On Thu, Sep 24, 2020 at 12:04:10PM +0530, Neeraj Upadhyay wrote:
>> Clarify the "x" in rcuox/N naming in RCU_NOCB_CPU config
>> description.
>>
>> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> 
> Applied with a few additional updates as shown below.  As always, please
> let me know if I messed anything up.
> 

Looks good! thanks!


Thanks
Neeraj

> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 8d1d776b4998896a6f8f4608edb0b258bd37ec9f
> Author: Neeraj Upadhyay <neeraju@codeaurora.org>
> Date:   Thu Sep 24 12:04:10 2020 +0530
> 
>      rcu: Clarify nocb kthreads naming in RCU_NOCB_CPU config
>      
>      This commit clarifies that the "p" and the "s" in the in the RCU_NOCB_CPU
>      config-option description refer to the "x" in the "rcuox/N" kthread name.
>      
>      Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
>      [ paulmck: While in the area, update description and advice. ]
>      Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> index b71e21f..cdc57b4 100644
> --- a/kernel/rcu/Kconfig
> +++ b/kernel/rcu/Kconfig
> @@ -221,19 +221,23 @@ config RCU_NOCB_CPU
>   	  Use this option to reduce OS jitter for aggressive HPC or
>   	  real-time workloads.	It can also be used to offload RCU
>   	  callback invocation to energy-efficient CPUs in battery-powered
> -	  asymmetric multiprocessors.
> +	  asymmetric multiprocessors.  The price of this reduced jitter
> +	  is that the overhead of call_rcu() increases and that some
> +	  workloads will incur significant increases in context-switch
> +	  rates.
>   
>   	  This option offloads callback invocation from the set of CPUs
>   	  specified at boot time by the rcu_nocbs parameter.  For each
>   	  such CPU, a kthread ("rcuox/N") will be created to invoke
>   	  callbacks, where the "N" is the CPU being offloaded, and where
> -	  the "p" for RCU-preempt (PREEMPTION kernels) and "s" for RCU-sched
> -	  (!PREEMPTION kernels).  Nothing prevents this kthread from running
> -	  on the specified CPUs, but (1) the kthreads may be preempted
> -	  between each callback, and (2) affinity or cgroups can be used
> -	  to force the kthreads to run on whatever set of CPUs is desired.
> -
> -	  Say Y here if you want to help to debug reduced OS jitter.
> +	  the "x" is "p" for RCU-preempt (PREEMPTION kernels) and "s" for
> +	  RCU-sched (!PREEMPTION kernels).  Nothing prevents this kthread
> +	  from running on the specified CPUs, but (1) the kthreads may be
> +	  preempted between each callback, and (2) affinity or cgroups can
> +	  be used to force the kthreads to run on whatever set of CPUs is
> +	  desired.
> +
> +	  Say Y here if you need reduced OS jitter, despite added overhead.
>   	  Say N here if you are unsure.
>   
>   config TASKS_TRACE_RCU_READ_MB
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of the Code Aurora Forum, hosted by The Linux Foundation
