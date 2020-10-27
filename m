Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4397129A893
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 11:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896593AbgJ0J6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 05:58:31 -0400
Received: from foss.arm.com ([217.140.110.172]:37030 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410433AbgJ0J6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:58:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5AFD30E;
        Tue, 27 Oct 2020 02:57:59 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C35C13F66E;
        Tue, 27 Oct 2020 02:57:57 -0700 (PDT)
Subject: Re: [PATCH v2] sched: sched_domain fix highest_flag_domain function
To:     Xuewen Yan <xuewen.yan94@gmail.com>, xuewen.yan@unisoc.com,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
References: <1603769572-8193-1-git-send-email-xuewen.yan94@gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <69257e98-2d93-673a-5dac-e11b6d5610be@arm.com>
Date:   Tue, 27 Oct 2020 10:57:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1603769572-8193-1-git-send-email-xuewen.yan94@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/2020 04:32, Xuewen Yan wrote:
> the highest_flag_domain is to search the highest sched_domain
> containing flag, but if the lower sched_domain didn't contain
> the flag, but the higher sched_domain contains the flag, the
> function will return NULL instead of the higher sched_domain.
> 
> For example:
> In MC domain : no SD_ASYM_CPUCAPACITY flag;
> In DIE domain : containing SD_ASYM_CPUCAPACITY flag;
> the "highest_flag_domain(cpu, SD_ASYM_CPUCAPACITY)" will return NULL.
> 
> Signed-off-by: Xuewen Yan <xuewen.yan94@gmail.com>
> ---
>  kernel/sched/sched.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 28709f6..2c7c566 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1427,7 +1427,7 @@ static inline struct sched_domain *highest_flag_domain(int cpu, int flag)
>  
>  	for_each_domain(cpu, sd) {
>  		if (!(sd->flags & flag))
> -			break;
> +			continue;
>  		hsd = sd;
>  	}

We distinguish between SDF_SHARED_PARENT and SDF_SHARED_CHILD SD flags.

1 SD_FLAG(*SD_ASYM_CPUCAPACITY*, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
2 SD_FLAG(SD_SERIALIZE, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
3 SD_FLAG(SD_OVERLAP, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
4 SD_FLAG(SD_NUMA, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)

1 SD_FLAG(SD_BALANCE_NEWIDLE, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
2 SD_FLAG(SD_BALANCE_EXEC, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
3 SD_FLAG(SD_BALANCE_FORK, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
4 SD_FLAG(SD_BALANCE_WAKE, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
5 82 SD_FLAG(SD_WAKE_AFFINE, SDF_SHARED_CHILD)
6 SD_FLAG(SD_SHARE_CPUCAPACITY, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
7 SD_FLAG(SD_SHARE_PKG_RESOURCES, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
8 SD_FLAG(SD_ASYM_PACKING, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)

We call lowest_flag_domain() on SDF_SHARED_PARENT and
highest_flag_domain() on SDF_SHARED_CHILD SD flags.

1 sd = lowest_flag_domain(cpu, SD_NUMA);
2 sd = lowest_flag_domain(cpu, *SD_ASYM_CPUCAPACITY*);

1 sd = highest_flag_domain(cpu, SD_SHARE_PKG_RESOURCES);
2 sd = highest_flag_domain(cpu, SD_ASYM_PACKING);
