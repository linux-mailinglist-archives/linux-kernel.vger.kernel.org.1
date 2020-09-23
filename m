Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0B3275582
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 12:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgIWKWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 06:22:05 -0400
Received: from foss.arm.com ([217.140.110.172]:42592 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbgIWKWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 06:22:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35BC0D6E;
        Wed, 23 Sep 2020 03:22:04 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3780E3F718;
        Wed, 23 Sep 2020 03:22:02 -0700 (PDT)
Subject: Re: [PATCH -next] sched: Remove unused inline function
 uclamp_bucket_base_value()
To:     YueHaibing <yuehaibing@huawei.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org
References: <20200922132410.48440-1-yuehaibing@huawei.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <db50f472-eb61-2f45-191a-94e8f53e7dd4@arm.com>
Date:   Wed, 23 Sep 2020 12:21:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200922132410.48440-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/2020 15:24, YueHaibing wrote:
> There is no caller in tree, so can remove it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  kernel/sched/core.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 2d95dc3f4644..1b06b952dbbe 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -940,11 +940,6 @@ static inline unsigned int uclamp_bucket_id(unsigned int clamp_value)
>  	return clamp_value / UCLAMP_BUCKET_DELTA;
>  }
>  
> -static inline unsigned int uclamp_bucket_base_value(unsigned int clamp_value)
> -{
> -	return UCLAMP_BUCKET_DELTA * uclamp_bucket_id(clamp_value);
> -}
> -
>  static inline unsigned int uclamp_none(enum uclamp_id clamp_id)
>  {
>  	if (clamp_id == UCLAMP_MIN)
> 

LGTM.

It got introduced in commit 60daf9c194106 ("sched/uclamp: Add bucket
local max tracking") but was never used.

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
