Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DACD2233D7C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 04:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731213AbgGaCvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 22:51:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:41270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731124AbgGaCvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 22:51:09 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BCFF20829;
        Fri, 31 Jul 2020 02:51:07 +0000 (UTC)
Date:   Thu, 30 Jul 2020 22:51:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linmiaohe <linmiaohe@huawei.com>
Cc:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <bsegall@google.com>,
        <mgorman@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: remove duplicated tick_nohz_full_enabled() check
Message-ID: <20200730225106.241f0f36@oasis.local.home>
In-Reply-To: <1595935075-14223-1-git-send-email-linmiaohe@huawei.com>
References: <1595935075-14223-1-git-send-email-linmiaohe@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jul 2020 19:17:55 +0800
linmiaohe <linmiaohe@huawei.com> wrote:

> From: Miaohe Lin <linmiaohe@huawei.com>
> 
> The func tick_nohz_full_enabled() is also called by tick_nohz_full_cpu().
> So this one is duplicated and should be removed.

Seems reasonable.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  kernel/sched/sched.h | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 877fb08eb1b0..02028f785f87 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1930,12 +1930,7 @@ extern int __init sched_tick_offload_init(void);
>   */
>  static inline void sched_update_tick_dependency(struct rq *rq)
>  {
> -	int cpu;
> -
> -	if (!tick_nohz_full_enabled())
> -		return;
> -
> -	cpu = cpu_of(rq);
> +	int cpu = cpu_of(rq);
>  
>  	if (!tick_nohz_full_cpu(cpu))
>  		return;

