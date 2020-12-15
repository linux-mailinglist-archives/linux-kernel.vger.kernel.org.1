Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E48A2DAFAD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 16:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729872AbgLOPEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 10:04:45 -0500
Received: from foss.arm.com ([217.140.110.172]:45676 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729739AbgLOPEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 10:04:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDA8E1FB;
        Tue, 15 Dec 2020 07:03:26 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9FBCB3F66B;
        Tue, 15 Dec 2020 07:03:25 -0800 (PST)
References: <20201214155457.3430-1-jiangshanlai@gmail.com> <20201214155457.3430-11-jiangshanlai@gmail.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Qian Cai <cai@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 10/10] workqueue: Fix affinity of kworkers when attaching into pool
In-reply-to: <20201214155457.3430-11-jiangshanlai@gmail.com>
Date:   Tue, 15 Dec 2020 15:03:20 +0000
Message-ID: <jhjczzbt8lj.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 14/12/20 15:54, Lai Jiangshan wrote:
> @@ -1848,11 +1848,11 @@ static void worker_attach_to_pool(struct worker *worker,
>  {
>       mutex_lock(&wq_pool_attach_mutex);
>
> -	/*
> -	 * set_cpus_allowed_ptr() will fail if the cpumask doesn't have any
> -	 * online CPUs.  It'll be re-applied when any of the CPUs come up.
> -	 */
> -	set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
> +	/* Is there any cpu in pool->attrs->cpumask online? */
> +	if (cpumask_any_and(pool->attrs->cpumask, wq_online_cpumask) < nr_cpu_ids)

  if (cpumask_intersects(pool->attrs->cpumask, wq_online_cpumask))

> +		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask) < 0);
> +	else
> +		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);

So for that late-spawned per-CPU kworker case: the outgoing CPU should have
already been cleared from wq_online_cpumask, so it gets its affinity reset
to the possible mask and the subsequent wakeup will ensure it's put on an
active CPU.

Seems alright to me.

>
>       /*
>        * The wq_pool_attach_mutex ensures %POOL_DISASSOCIATED remains
