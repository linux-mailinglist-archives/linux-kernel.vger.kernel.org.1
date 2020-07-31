Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAB2233D89
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 04:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731274AbgGaC6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 22:58:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:43092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731244AbgGaC57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 22:57:59 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5868C21775;
        Fri, 31 Jul 2020 02:57:58 +0000 (UTC)
Date:   Thu, 30 Jul 2020 22:57:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>,
        "Mel Gorman" <mgorman@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] sched/uclamp: kill unnecessary mutex_init()
Message-ID: <20200730225756.11283799@oasis.local.home>
In-Reply-To: <20200725085629.98292-1-miaoqinglang@huawei.com>
References: <20200725085629.98292-1-miaoqinglang@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jul 2020 16:56:29 +0800
Qinglang Miao <miaoqinglang@huawei.com> wrote:

> The mutex uclamp_mutex is initialized statically. It is
> unnecessary to initialize by mutex_init().
> 

Seems reasonable.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
>  kernel/sched/core.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 29d557c1f..9a8b7ed3a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1331,8 +1331,6 @@ static void __init init_uclamp(void)
>  	enum uclamp_id clamp_id;
>  	int cpu;
>  
> -	mutex_init(&uclamp_mutex);
> -
>  	for_each_possible_cpu(cpu)
>  		init_uclamp_rq(cpu_rq(cpu));
>  

