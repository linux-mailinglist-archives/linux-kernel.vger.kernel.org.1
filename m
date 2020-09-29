Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8B327D126
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 16:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730295AbgI2Obr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 10:31:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:41846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgI2Obr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 10:31:47 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A14132074F;
        Tue, 29 Sep 2020 14:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601389906;
        bh=7ATkGkZOohwM99zBUUvfgxp84QmWybFcpRKLQq/lozI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=mzPULUn5FOQLQbWxm9kr1fu6EoWHNtEa0K4Y/ARJlUX1T2yL4H1hW2V/PbTyxdEGk
         25xduIKN3AWIoJBhOCe/GLzVb7+c7JKt7JJhfgqcJNHK/p20ipoCOFFKXSpNvIQ1YE
         pPAufI6rtaLfNBm9KqmxxJ9gDbbK4MftBRge7/7Y=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 38A563522A42; Tue, 29 Sep 2020 07:31:46 -0700 (PDT)
Date:   Tue, 29 Sep 2020 07:31:46 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, kim.phillips@amd.com
Subject: Re: [PATCH] rcu,ftrace: Fix ftrace recursion
Message-ID: <20200929143146.GT29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200929113340.GN2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929113340.GN2628@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 01:33:40PM +0200, Peter Zijlstra wrote:
> 
> Kim reported that perf-ftrace made his box unhappy. It turns out that
> commit:
> 
>   ff5c4f5cad33 ("rcu/tree: Mark the idle relevant functions noinstr")
> 
> removed one too many notrace. Probably due to there not being a helpful
> comment.
> 
> Reinstate the notrace and add a comment to avoid loosing it again.

s/loosing/losing/, but otherwise:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

But please let me know if you would prefer that I take it via -rcu.

						Thanx, Paul

> Fixes: ff5c4f5cad33 ("rcu/tree: Mark the idle relevant functions noinstr")
> Reported-by: Kim Phillips <kim.phillips@amd.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/rcu/tree.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index ee5e595501e8..33020d84ec6b 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1098,8 +1098,11 @@ noinstr bool __rcu_is_watching(void)
>   * CPU can safely enter RCU read-side critical sections.  In other words,
>   * if the current CPU is not in its idle loop or is in an interrupt or
>   * NMI handler, return true.
> + *
> + * Must be notrace because __ftrace_ops_list_func() / ftrace_ops_assist_func()
> + * will call this (for every function) outside of recursion protection.
>   */
> -bool rcu_is_watching(void)
> +notrace bool rcu_is_watching(void)
>  {
>  	bool ret;
>  
