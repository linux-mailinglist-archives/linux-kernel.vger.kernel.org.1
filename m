Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB992E210B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 20:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbgLWTud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 14:50:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:35650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbgLWTud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 14:50:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2503B223E4;
        Wed, 23 Dec 2020 19:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608752992;
        bh=woprWZFTS6K4LJCyz89cuszr5XvTqwSkumbI3YKeqrc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TRfWrRCvKL3EwxvsXI3iP8/Bhi9gdkuSZW5Xh6Ru1gYVZUgb22yv1iaUmKsUUKOZB
         CjmGQF5754EoTtIBd5wvSnWcTzZqfFot1DX+epOnPE0h/9W3UNopWg5nTu8MfnuRPS
         wqXVnRKl8kM6IyKX8Hni66vvYdwLkP9Ep6WqRmM53ifmdZh4BtdnbMCxqMYSqDAjkv
         o2Q365+JhpSevQRk1++pXWEiasIMbkcd9ho82LCp6WJthTZ02oOVUMvra0JDq8ZUSr
         WMlj0BqPd+1HIapox3+EHV0Wrsl2TYPsJqb5DR1nZuKKoPqPOximkdgjHWefR0X1zm
         ZLbn1zC6I1EuA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id DBB3D3522E72; Wed, 23 Dec 2020 11:49:51 -0800 (PST)
Date:   Wed, 23 Dec 2020 11:49:51 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Hillf Danton <hdanton@sina.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH -tip V2 00/10] workqueue: break affinity initiatively
Message-ID: <20201223194951.GA10044@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201218170919.2950-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201218170919.2950-1-jiangshanlai@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 19, 2020 at 01:09:09AM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> 06249738a41a ("workqueue: Manually break affinity on hotplug")
> said that scheduler will not force break affinity for us.
> 
> But workqueue highly depends on the old behavior. Many parts of the codes
> relies on it, 06249738a41a ("workqueue: Manually break affinity on hotplug")
> is not enough to change it, and the commit has flaws in itself too.
> 
> It doesn't handle for worker detachment.
> It doesn't handle for worker attachement, mainly worker creation
>   which is handled by Valentin Schneider's patch [1].
> It doesn't handle for unbound workers which might be possible
> per-cpu-kthread.
> 
> We need to thoroughly update the way workqueue handles affinity
> in cpu hot[un]plug, what is this patchset intends to do and
> replace the Valentin Schneider's patch [1].  The equivalent patch
> is patch 10.
> 
> Patch 1 fixes a flaw reported by Hillf Danton <hdanton@sina.com>.
> I have to include this fix because later patches depends on it.
> 
> The patchset is based on tip/master rather than workqueue tree,
> because the patchset is a complement for 06249738a41a ("workqueue:
> Manually break affinity on hotplug") which is only in tip/master by now.
> 
> And TJ acked to route the series through tip.
> 
> Changed from V1:
> 	Add TJ's acked-by for the whole patchset
> 
> 	Add more words to the comments and the changelog, mainly derived
> 	from discussion with Peter.
> 
> 	Update the comments as TJ suggested.
> 	
> 	Update a line of code as Valentin suggested.
> 
> 	Add Valentin's ack for patch 10 because "Seems alright to me." and
> 	add Valentin's comments to the changelog which is integral.
> 
> [1]: https://lore.kernel.org/r/ff62e3ee994efb3620177bf7b19fab16f4866845.camel@redhat.com
> [V1 patcheset]: https://lore.kernel.org/lkml/20201214155457.3430-1-jiangshanlai@gmail.com/
> 
> Cc: Hillf Danton <hdanton@sina.com>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Qian Cai <cai@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Vincent Donnefort <vincent.donnefort@arm.com>
> Cc: Tejun Heo <tj@kernel.org>

And rcutorture hits this, so thank you for the fix!

Tested-by: Paul E. McKenney <paulmck@kernel.org>

> Lai Jiangshan (10):
>   workqueue: restore unbound_workers' cpumask correctly
>   workqueue: use cpu_possible_mask instead of cpu_active_mask to break
>     affinity
>   workqueue: Manually break affinity on pool detachment
>   workqueue: don't set the worker's cpumask when kthread_bind_mask()
>   workqueue: introduce wq_online_cpumask
>   workqueue: use wq_online_cpumask in restore_unbound_workers_cpumask()
>   workqueue: Manually break affinity on hotplug for unbound pool
>   workqueue: reorganize workqueue_online_cpu()
>   workqueue: reorganize workqueue_offline_cpu() unbind_workers()
>   workqueue: Fix affinity of kworkers when attaching into pool
> 
>  kernel/workqueue.c | 214 ++++++++++++++++++++++++++++-----------------
>  1 file changed, 132 insertions(+), 82 deletions(-)
> 
> -- 
> 2.19.1.6.gb485710b
> 
