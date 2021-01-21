Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887FE2FED38
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 15:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731971AbhAUOoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 09:44:12 -0500
Received: from foss.arm.com ([217.140.110.172]:38428 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732107AbhAUOng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 09:43:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FF5411D4;
        Thu, 21 Jan 2021 06:31:24 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C40733F68F;
        Thu, 21 Jan 2021 06:31:22 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
        cai@redhat.com, vincent.donnefort@arm.com, decui@microsoft.com,
        paulmck@kernel.org, vincent.guittot@linaro.org,
        rostedt@goodmis.org, tj@kernel.org, peterz@infradead.org
Subject: Re: [PATCH -v3 5/9] workqueue: Tag bound workers with KTHREAD_IS_PER_CPU
In-Reply-To: <20210121103506.693465814@infradead.org>
References: <20210121101702.402798862@infradead.org> <20210121103506.693465814@infradead.org>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Thu, 21 Jan 2021 14:31:20 +0000
Message-ID: <jhja6t2mkef.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/21 11:17, Peter Zijlstra wrote:
> @@ -4972,9 +4977,11 @@ static void rebind_workers(struct worker
>  	 * of all workers first and then clear UNBOUND.  As we're called
>  	 * from CPU_ONLINE, the following shouldn't fail.
>  	 */
> -	for_each_pool_worker(worker, pool)
> +	for_each_pool_worker(worker, pool) {
> +		kthread_set_per_cpu(worker->task, pool->cpu);
>  		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task,
>  						  pool->attrs->cpumask) < 0);

At the end of this series, is_cpu_allowed() allows kthreads with
KTHREAD_IS_PER_CPU on any online CPU, even if it isn't the designated
kthread->cpu.

I thought there might be a race here, given this gives us a window where a
pcpu kworker has the flag but is still affined to cpus_possible_mask. Now,
given cpus_write_lock(), we can't have a CPU going up while another goes
down. So I think it's actually fine, and I've been chasing ghosts yet again.

> +	}
>  
>  	raw_spin_lock_irq(&pool->lock);
>  
