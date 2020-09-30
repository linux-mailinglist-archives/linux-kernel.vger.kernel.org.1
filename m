Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487D127E942
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 15:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbgI3NMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 09:12:54 -0400
Received: from foss.arm.com ([217.140.110.172]:36022 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725771AbgI3NMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:12:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29AFA30E;
        Wed, 30 Sep 2020 06:12:53 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 926E13F6CF;
        Wed, 30 Sep 2020 06:12:52 -0700 (PDT)
Subject: Re: [PATCH 1/1] sched/uclamp: release per-task uclamp control if user
 set to default value
To:     Yun Hsiang <hsiang023167@gmail.com>, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org
References: <20200928082643.133257-1-hsiang023167@gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <8272de8d-9868-d419-e2bb-d5e2c0614b63@arm.com>
Date:   Wed, 30 Sep 2020 15:12:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200928082643.133257-1-hsiang023167@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yun,

On 28/09/2020 10:26, Yun Hsiang wrote:
> If the user wants to release the util clamp and let cgroup to control it,
> we need a method to reset.
> 
> So if the user set the task uclamp to the default value (0 for UCLAMP_MIN
> and 1024 for UCLAMP_MAX), reset the user_defined flag to release control.
> 
> Signed-off-by: Yun Hsiang <hsiang023167@gmail.com>

could you explain with a little bit more detail why you would need this
feature?

Currently we assume that once the per-task uclamp (user-defined) values
are set, you could only change the effective uclamp values of this task
by (1) moving it into another taskgroup or (2) changing the system
default uclamp values.

> ---
>  kernel/sched/core.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 9a2fbf98fd6f..fa63d70d783a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1187,6 +1187,7 @@ static void __setscheduler_uclamp(struct task_struct *p,
>  				  const struct sched_attr *attr)
>  {
>  	enum uclamp_id clamp_id;
> +	bool user_defined;
>  
>  	/*
>  	 * On scheduling class change, reset to default clamps for tasks
> @@ -1210,14 +1211,16 @@ static void __setscheduler_uclamp(struct task_struct *p,
>  	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
>  		return;
>  
> +	user_defined = attr->sched_util_min == 0 ? false : true;
>  	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
>  		uclamp_se_set(&p->uclamp_req[UCLAMP_MIN],
> -			      attr->sched_util_min, true);
> +			      attr->sched_util_min, user_defined);
>  	}
>  
> +	user_defined = attr->sched_util_max == 1024 ? false : true;
>  	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
>  		uclamp_se_set(&p->uclamp_req[UCLAMP_MAX],
> -			      attr->sched_util_max, true);
> +			      attr->sched_util_max, user_defined);
>  	}
>  }
