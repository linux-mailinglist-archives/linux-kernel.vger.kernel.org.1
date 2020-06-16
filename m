Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB711FB27C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 15:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbgFPNuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 09:50:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:55256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726306AbgFPNub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 09:50:31 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E024620739;
        Tue, 16 Jun 2020 13:50:29 +0000 (UTC)
Date:   Tue, 16 Jun 2020 09:50:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Lichao Liu <liulichao@loongson.cn>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/rt: Don't active rt throtting when no running cfs
 task
Message-ID: <20200616095027.1a2048d0@oasis.local.home>
In-Reply-To: <20200616123729.153430-1-liulichao@loongson.cn>
References: <20200616123729.153430-1-liulichao@loongson.cn>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jun 2020 20:37:29 +0800
Lichao Liu <liulichao@loongson.cn> wrote:

> Active rt throtting will dequeue rt_rq from rq at least 50ms,
> When there is no running cfs task, do we still active it?
> 

This is something I would like to have.

Peter, what's your thought on this?

-- Steve

> Signed-off-by: Lichao Liu <liulichao@loongson.cn>
> ---
>  kernel/sched/rt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index df11d88c9895..d6524347cea0 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -961,12 +961,13 @@ static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq)
>  
>  	if (rt_rq->rt_time > runtime) {
>  		struct rt_bandwidth *rt_b = sched_rt_bandwidth(rt_rq);
> +		struct rq *rq = rq_of_rt_rq(rt_rq);
>  
>  		/*
>  		 * Don't actually throttle groups that have no runtime assigned
>  		 * but accrue some time due to boosting.
>  		 */
> -		if (likely(rt_b->rt_runtime)) {
> +		if (likely(rt_b->rt_runtime) && rq->cfs.nr_running > 0) {
>  			rt_rq->rt_throttled = 1;
>  			printk_deferred_once("sched: RT throttling activated\n");
>  		} else {

