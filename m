Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B0E25A1F6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 01:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgIAXjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 19:39:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:44486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbgIAXjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 19:39:02 -0400
Received: from localhost (lfbn-ncy-1-588-162.w81-51.abo.wanadoo.fr [81.51.203.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3E20206F0;
        Tue,  1 Sep 2020 23:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599003542;
        bh=FquFQqDON31cZiaxNfLhdjuEP7sGYEuyPDSuCBJjx6g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zOqfDLzF2E0PwAf+BB1IYiPp+58hhZF0spJwDaZWqHpyKcwNd+bdn8pzUzGl9eplz
         wbRhm6fTgyqeY8GA5C2h//t0JJohM3V7Cjwv7ux/42TyQNGncFrmvYZGfdr+FvI1UK
         m6SAefEShl4u1gwRTcnzUiXVZquk7q6vU8wZtVhk=
Date:   Wed, 2 Sep 2020 01:38:59 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [patch 1/2] nohz: try to avoid IPI when configuring per-CPU
 posix timer
Message-ID: <20200901233858.GA9322@lenoir>
References: <20200825184147.948670309@fuller.cnet>
 <20200825184414.442457749@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825184414.442457749@fuller.cnet>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 03:41:48PM -0300, Marcelo Tosatti wrote:
> When enabling per-CPU posix timers, an IPI to nohz_full CPUs might be
> performed (to re-read the dependencies and possibly not re-enter
> nohz_full on a given CPU).
> 
> A common case is for applications that run on nohz_full= CPUs 
> to not use POSIX timers (eg DPDK). This patch skips the IPI 
> in case the task allowed mask does not intersect with nohz_full= CPU mask,
> when going through tick_nohz_dep_set_signal.
> 
> This reduces interruptions to nohz_full= CPUs.
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
[...]
>  /*
> + * Set bit on nohz full dependency, kicking all cpus
> + * only if task can run on nohz full CPUs.
> + */
> +static void tick_nohz_dep_set_all_cond(struct task_struct *tsk,
> +				       atomic_t *dep,
> +				       enum tick_dep_bits bit)
> +{
> +	int prev;
> +	unsigned long flags;
> +
> +	prev = atomic_fetch_or(BIT(bit), dep);
> +	if (prev)
> +		return;
> +
> +	raw_spin_lock_irqsave(&tsk->pi_lock, flags);
> +	if (cpumask_intersects(&tsk->cpus_mask, tick_nohz_full_mask))
> +		tick_nohz_full_kick_all();

So that's for one task but what about the other threads in that
process? We are setting the tick dependency on all tasks sharing that
struct signal.

Thanks.

> +	raw_spin_unlock_irqrestore(&tsk->pi_lock, flags);
> +}
> +
