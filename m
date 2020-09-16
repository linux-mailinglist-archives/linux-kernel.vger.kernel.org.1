Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA0826CC9F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbgIPUrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbgIPRBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:01:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FAEC004591
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 07:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gy8OjHTlSCL3cbO8yUWFtbYxpmvhKnaDb7ay+ZtErVw=; b=ASDwQtp8Kku0abOd6bPIZvsrLo
        vwIaVPQdHjgGzshUwMacmzdnFJoZK1FW88YjCrJzMaNZiwK3KbtyRgpcqNuJUM6TT4yGTmN6d6Bf7
        2f+aU/xPgfAhLpOHIOtZ4M23yAy5rMWq4aJk/XUqSizFFXOUR8K7H+Q/8R70YEP0Qw1CEJn3BHySx
        rHad2ulKnPRFtnfM6MV2UFuKpWKM3rXzMcNFWjMPBqwpo7AgGpYKVRWYVMy8dWP49+4N9nGhuiqUV
        IXFoglw/BfRu9WsscgOFniFglac79RMYn0VrVRRGgkXsRyirOew5lFI8xxenIE3TU/oFPlTaQJEVV
        Bax09urw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIY5s-0002HM-6J; Wed, 16 Sep 2020 14:07:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 24DED3006D0;
        Wed, 16 Sep 2020 16:07:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DFC042BB75B4D; Wed, 16 Sep 2020 16:07:30 +0200 (CEST)
Date:   Wed, 16 Sep 2020 16:07:30 +0200
From:   peterz@infradead.org
To:     Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bristot@redhat.com, swood@redhat.com,
        valentin.schneider@arm.com
Subject: Re: [PATCH 2/2] sched/hotplug: Ensure only per-cpu kthreads run
 during hotplug
Message-ID: <20200916140730.GB1362448@hirez.programming.kicks-ass.net>
References: <20200911081745.214686199@infradead.org>
 <20200911082536.528661716@infradead.org>
 <20200916101845.5ikjhfk27bgvs3pe@flow>
 <20200916121020.GP2674@hirez.programming.kicks-ass.net>
 <20200916135817.3djsqmziqvzo6hmq@flow>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916135817.3djsqmziqvzo6hmq@flow>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 03:58:17PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-09-16 14:10:20 [+0200], peterz@infradead.org wrote:
> 
> squeeze that in please:
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index a4fe22b8b8418..bed3cd28af578 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6866,7 +6866,7 @@ static int __balance_push_cpu_stop(void *arg)
>  	raw_spin_lock_irq(&p->pi_lock);
>  	rq_lock(rq, &rf);
>  
> -	update_rq_clock();
> +	update_rq_clock(rq);
>  
>  	if (task_rq(p) == rq && task_on_rq_queued(p)) {
>  		cpu = select_fallback_rq(rq->cpu, p);
> 
> 
> and count me in :)

Duh... /me goes in search of the brown paper bag -- again!
