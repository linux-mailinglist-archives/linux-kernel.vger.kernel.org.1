Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B441C2DA95C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 09:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbgLOIlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 03:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgLOIlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 03:41:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956C3C06179C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 00:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pKkxRKPZ5Ym65N46yhOHcdU5XJ7ab7RK4Bg2dcVYPcQ=; b=cvMeJioe0kMSv0rP3cTukFisdW
        SfTkpQ0/r0H+Dps1RyeLPosrgDFr3Iy7OU1SBU9jN+hRjrpd6LYDAvk9FoeEOpLctDQrTF5ta0B+p
        prINoCDf/aXuz8c98ST3nC731ByAu2h82VgyWRnO02OmgzQK9zG3obXOffRaEK+tmzIlR0TYTQGa8
        2KR4iPYpmnhA8Txsf3TMLrd/oj0xmY9WA7hfapgscBA/nusggbiC7CTG+n0ZDAMDbj8bRiCDKsELH
        Ag91Rfu8s5zHg6B6jn1sNh17+k6/RMC5BQ1JyUbwt8ZPnl0f4ga6J9jxwl4305bLVz845QIaQO8DD
        EuMXuyNQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kp5sc-0003tw-45; Tue, 15 Dec 2020 08:40:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 924C7304D28;
        Tue, 15 Dec 2020 09:40:21 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 559FC2CB641BA; Tue, 15 Dec 2020 09:40:21 +0100 (CET)
Date:   Tue, 15 Dec 2020 09:40:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 02/10] workqueue: use cpu_possible_mask instead of
 cpu_active_mask to break affinity
Message-ID: <20201215084021.GQ3092@hirez.programming.kicks-ass.net>
References: <20201214155457.3430-1-jiangshanlai@gmail.com>
 <20201214155457.3430-3-jiangshanlai@gmail.com>
 <X9egDheiQPLdR0IS@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X9egDheiQPLdR0IS@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 06:25:34PM +0100, Peter Zijlstra wrote:
> On Mon, Dec 14, 2020 at 11:54:49PM +0800, Lai Jiangshan wrote:
> > From: Lai Jiangshan <laijs@linux.alibaba.com>
> > 
> > There might be other CPU online. The workers losing binding on its CPU
> > should have chance to work on those later onlined CPUs.
> > 
> > Fixes: 06249738a41a ("workqueue: Manually break affinity on hotplug")
> > Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> > ---
> >  kernel/workqueue.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> > index aba71ab359dd..1f5b8385c0cf 100644
> > --- a/kernel/workqueue.c
> > +++ b/kernel/workqueue.c
> > @@ -4909,8 +4909,9 @@ static void unbind_workers(int cpu)
> >  
> >  		raw_spin_unlock_irq(&pool->lock);
> >  
> > +		/* don't rely on the scheduler to force break affinity for us. */
> >  		for_each_pool_worker(worker, pool)
> > -			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_active_mask) < 0);
> > +			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
> 
> Please explain this one.. it's not making sense. Also the Changelog
> doesn't seem remotely related to the actual change.
> 
> Afaict this is actively wrong.

I think I was too tired, I see what you're doing now and it should work
fine, I still think the changelog could use help though.
