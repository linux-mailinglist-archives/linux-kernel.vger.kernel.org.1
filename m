Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BADFA27BE60
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 09:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbgI2Htn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 03:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgI2Htm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 03:49:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CCEC061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 00:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gM/zK9NAOqR6anGF6fXh3/aZy4WYVl5Lpf8fMySk7uc=; b=OiQk1+V2qTT/uHo1w9qxpju93O
        LW5vSki4KTocaIPGyRAgqsPBLwHDLCzw/C/xahzCemASKBIN4TPHiqKq2TahaL6DNPbKZCW6an5Ck
        XHiafCxqy88H/VDHbejhyNghBqxQGUyT0r5pmsKy0JxlXe8oO5PWH7tBCyZozX/T5Q+x/1DxR+kzI
        XouFhWthqKkFdrhSe5jT9Kpj+O/CYlGp21CnctFF756xblz/FJz5H+ordPME4Qyf8zWQ3HWJyoeK7
        4MKxbdAo3TBTS26yxcpTwaV180rhM0tu0i2aMfYKzMhQfFPBpwHX6fX9PxLKW6UZ7CS4Jq0YBkTdj
        zL9rSQOw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNAOB-0008AE-Nr; Tue, 29 Sep 2020 07:49:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9C975300F7A;
        Tue, 29 Sep 2020 09:49:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 43A06200D4C43; Tue, 29 Sep 2020 09:49:30 +0200 (CEST)
Date:   Tue, 29 Sep 2020 09:49:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     quanyang.wang@windriver.com
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Leo Yan <leo.yan@linaro.org>, Will Deacon <will@kernel.org>,
        a.darwish@linutronix.de,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Randy Dunlap <rdunlap@infradead.org>, ben.dooks@codethink.co.uk
Subject: Re: [PATCH V2] time/sched_clock: mark sched_clock_read_begin/retry
 as notrace
Message-ID: <20200929074930.GG2611@hirez.programming.kicks-ass.net>
References: <20200929015051.4097-1-quanyang.wang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929015051.4097-1-quanyang.wang@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 09:50:51AM +0800, quanyang.wang@windriver.com wrote:
> From: Quanyang Wang <quanyang.wang@windriver.com>
> 
> Since sched_clock_read_begin and sched_clock_read_retry are called
> by notrace function sched_clock, they shouldn't be traceable either,
> or else ftrace_graph_caller will run into a dead loop on the path
> as below (arm for instance):
> 
>   ftrace_graph_caller
>     prepare_ftrace_return
>       function_graph_enter
>         ftrace_push_return_trace
>           trace_clock_local
>             sched_clock
>               sched_clock_read_begin/retry
> 
> Fixes: 1b86abc1c645 ("sched_clock: Expose struct clock_read_data")
> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
> ---
> Changes:
> V2: Add notrace to sched_clock_read_retry according to Peter's suggestion.
> 
>  kernel/time/sched_clock.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
> index 1c03eec6ca9b..f629e3f5afbe 100644
> --- a/kernel/time/sched_clock.c
> +++ b/kernel/time/sched_clock.c
> @@ -68,13 +68,13 @@ static inline u64 notrace cyc_to_ns(u64 cyc, u32 mult, u32 shift)
>  	return (cyc * mult) >> shift;
>  }
>  
> -struct clock_read_data *sched_clock_read_begin(unsigned int *seq)
> +notrace struct clock_read_data *sched_clock_read_begin(unsigned int *seq)
>  {
>  	*seq = raw_read_seqcount_latch(&cd.seq);
>  	return cd.read_data + (*seq & 1);
>  }
>  
> -int sched_clock_read_retry(unsigned int seq)
> +int notrace sched_clock_read_retry(unsigned int seq)
>  {
>  	return read_seqcount_retry(&cd.seq, seq);
>  }

You're inconsistent in the placement of notrace, I prefer the first, the
second read like notrace is the return type instead of a qualifier.

In any case,

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
