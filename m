Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764D92DAF5E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 15:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730029AbgLOOtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 09:49:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:51320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729956AbgLOOsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 09:48:41 -0500
Date:   Tue, 15 Dec 2020 15:47:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608043680;
        bh=3serOWbyduZ2yrQbYJh0/hEbtH+9UG4Dr9BcYAGBeqA=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=hZDbF8Cp0tEi+xQnWRVpV2gn1IsachLysLi0EIJzxG8jZlb9h1ovM6KFaNQRSAg6o
         22xVSm3cfy90+ASODJZiO3Ncxn9AJLR1swvS/W981PG5YHEc6cBoAcPUfe2iLFFvMY
         QVUykC9x7/wxjs9UcBB61d68YmVgY4ELJwdqf5N8f2Fl8v/v/OxPr8EHITvsvh81os
         EBO7dkVjNlKRmJoUKrUXBgyGDLzWSLknnFC7eyGcU5m6YV9H/V8cRY4xs9ZKAz18m1
         pR36JbXG/nWBOVR8feySxf4n5u69WfpGwSRyxQpqKFKRHqpiuZ3gr5C1944GU/7CP/
         pwFyY8CXW9nEQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
Subject: Re: [PATCH] tick/nohz: Make the idle_exittime update correctly
Message-ID: <20201215144757.GA9391@lothringen>
References: <2e194669-c074-069c-4fda-ad5bc313a611@huawei.com>
 <bc6f830d-21da-b334-9dfd-54dcf2d4f7a0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc6f830d-21da-b334-9dfd-54dcf2d4f7a0@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 08:06:34PM +0800, Yunfeng Ye wrote:
> The idle_exittime field of tick_sched is used to record the time when
> the idle state was left. but currently the idle_exittime is updated in
> the function tick_nohz_restart_sched_tick(), which is not always in idle
> state when nohz_full is configured.
> 
>   tick_irq_exit
>     tick_nohz_irq_exit
>       tick_nohz_full_update_tick
>         tick_nohz_restart_sched_tick
>           ts->idle_exittime = now;
> 
> So move to tick_nohz_stop_idle() to make the idle_exittime update
> correctly.
> 
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> ---
>  kernel/time/tick-sched.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 749ec2a583de..be2e5d772d50 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -591,6 +591,7 @@ static void tick_nohz_stop_idle(struct tick_sched *ts, ktime_t now)
>  {
>  	update_ts_time_stats(smp_processor_id(), ts, now, NULL);
>  	ts->idle_active = 0;
> +	ts->idle_exittime = now;

This changes a bit the meaning of idle_exittime then since this is also called
from idle interrupt entry.

__tick_nohz_idle_restart_tick() would be a better place.

Thanks.

> 
>  	sched_clock_idle_wakeup_event();
>  }
> @@ -901,7 +902,6 @@ static void tick_nohz_restart_sched_tick(struct tick_sched *ts, ktime_t now)
>  	 * Cancel the scheduled timer and restore the tick
>  	 */
>  	ts->tick_stopped  = 0;
> -	ts->idle_exittime = now;
> 
>  	tick_nohz_restart(ts, now);
>  }
> -- 
> 2.18.4
> 
