Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB532FEC8E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 15:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730769AbhAUOCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 09:02:15 -0500
Received: from foss.arm.com ([217.140.110.172]:37366 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbhAUOBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 09:01:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A3CD11D4;
        Thu, 21 Jan 2021 06:00:53 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD3E63F68F;
        Thu, 21 Jan 2021 06:00:51 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
        cai@redhat.com, vincent.donnefort@arm.com, decui@microsoft.com,
        paulmck@kernel.org, vincent.guittot@linaro.org,
        rostedt@goodmis.org, tj@kernel.org, peterz@infradead.org
Subject: Re: [PATCH -v3 3/9] sched: Dont run cpu-online with balance_push() enabled
In-Reply-To: <20210121103506.415606087@infradead.org>
References: <20210121101702.402798862@infradead.org> <20210121103506.415606087@infradead.org>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Thu, 21 Jan 2021 14:00:45 +0000
Message-ID: <jhjft2umlte.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/21 11:17, Peter Zijlstra wrote:
> @@ -7608,6 +7614,12 @@ int sched_cpu_dying(unsigned int cpu)
>       }
>       rq_unlock_irqrestore(rq, &rf);
>
> +	/*
> +	 * Should really be after we clear cpu_online(), but we're in
> +	 * stop_machine(), so it all works.
> +	 */

I believe you noted yourself in some earlier version that this *is* running
with cpu_online(cpu) == false, __cpu_disable() being invoked before the
_DYING .teardown callbacks are run.

> +	balance_push_set(cpu, false);
> +
>       calc_load_migrate(rq);
>       update_max_interval();
>       nohz_balance_exit_idle(rq);
