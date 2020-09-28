Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C7B27AC58
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 12:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgI1K7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 06:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgI1K7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 06:59:22 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1857CC061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 03:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rrw0zck23342w5P+XMdB4cKid9Yi0SSQDUVkOFfAunI=; b=I50m48RbxfHPnSptbyXbtZ5+RM
        W3G3bUQqsYX/b1guLvcdyy8uMOGun/fpx72Rr2I5SmvS+z0JLFUuiauDZ5Et3j4Da/inVkLWR3tGy
        GZJqxwm0Rfi6M5xkyxPylRtKb7Fwm+j1WjAburHRKeLv9VUt0v7VOJYDP85kJv+6RsAOjXQDSwRz3
        mp1aYh7jU5ShR0/be3y+YC7vjUFahxTcTGoAp+e4OiCxnENY8xUvLuovvveyJq0WHF1ngMYM/QXXc
        9Zk2PbxeYW4UVlQabHM2tkp27FiECqIVJa7nMimDysUgWruTXtb57lV6huZn2TUuyvfeDPz6+j/Zq
        rdZ0LOKw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kMqs3-0007x7-SY; Mon, 28 Sep 2020 10:59:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F2565300F7A;
        Mon, 28 Sep 2020 12:58:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CA3AC2B8C059B; Mon, 28 Sep 2020 12:58:59 +0200 (CEST)
Date:   Mon, 28 Sep 2020 12:58:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     quanyang.wang@windriver.com
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Leo Yan <leo.yan@linaro.org>, Will Deacon <will@kernel.org>,
        a.darwish@linutronix.de,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        ben.dooks@codethink.co.uk, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] time/sched_clock: mark sched_clock_read_begin as notrace
Message-ID: <20200928105859.GF2628@hirez.programming.kicks-ass.net>
References: <20200928104952.26892-1-quanyang.wang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928104952.26892-1-quanyang.wang@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 06:49:52PM +0800, quanyang.wang@windriver.com wrote:
> From: Quanyang Wang <quanyang.wang@windriver.com>
> 
> Since sched_clock_read_begin is called by notrace function sched_clock,
> it shouldn't be traceable either, or else __ftrace_graph_caller will
> run into a dead loop on the path (arm for instance):
> 
>   ftrace_graph_caller
>     prepare_ftrace_return
>       function_graph_enter
>         ftrace_push_return_trace
>           trace_clock_local
>             sched_clock
>               sched_clock_read_begin
> 
> Fixes: 1b86abc1c645 ("sched_clock: Expose struct clock_read_data")
> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
> ---
>  kernel/time/sched_clock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
> index 1c03eec6ca9b..58459e1359d7 100644
> --- a/kernel/time/sched_clock.c
> +++ b/kernel/time/sched_clock.c
> @@ -68,7 +68,7 @@ static inline u64 notrace cyc_to_ns(u64 cyc, u32 mult, u32 shift)
>  	return (cyc * mult) >> shift;
>  }
>  
> -struct clock_read_data *sched_clock_read_begin(unsigned int *seq)
> +notrace struct clock_read_data *sched_clock_read_begin(unsigned int *seq)
>  {
>  	*seq = raw_read_seqcount_latch(&cd.seq);
>  	return cd.read_data + (*seq & 1);

At the very least sched_clock_read_retry() should also be marked such.

But Steve, how come x86 works? Our sched_clock() doesn't have notrace on
at all.
