Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7A232F37CA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 18:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391997AbhALR6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 12:58:14 -0500
Received: from foss.arm.com ([217.140.110.172]:50534 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727622AbhALR6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 12:58:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0CBD1063;
        Tue, 12 Jan 2021 09:57:27 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B9623F66E;
        Tue, 12 Jan 2021 09:57:25 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
        cai@redhat.com, vincent.donnefort@arm.com, decui@microsoft.com,
        paulmck@kernel.org, vincent.guittot@linaro.org,
        rostedt@goodmis.org, tj@kernel.org, peterz@infradead.org
Subject: Re: [PATCH 3/4] workqueue: Tag bound workers with KTHREAD_IS_PER_CPU
In-Reply-To: <20210112144843.849135905@infradead.org>
References: <20210112144344.850850975@infradead.org> <20210112144843.849135905@infradead.org>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Tue, 12 Jan 2021 17:57:23 +0000
Message-ID: <jhjy2gyyr5o.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/21 15:43, Peter Zijlstra wrote:
> @@ -4919,8 +4922,10 @@ static void unbind_workers(int cpu)
>
>               raw_spin_unlock_irq(&pool->lock);
>
> -		for_each_pool_worker(worker, pool)
> +		for_each_pool_worker(worker, pool) {
> +			kthread_set_per_cpu(worker->task, false);
>                       WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
> +		}

Doesn't this supersede patch 1? With patch 4 on top, the BALANCE_PUSH
stuff should start resetting the affinity of the kworkers for which we
are removing the IS_PER_CPU flag.

It's the only nit I have, the rest looks good to me so:

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

I'll go frob that sched_cpu_dying() warning.
