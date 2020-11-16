Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 126FA2B441B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 13:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbgKPM6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 07:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgKPM6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 07:58:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93214C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 04:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KRXNkO+KFPcAC0XnVHoUN3XHV3TWuEbfhoxAq87wtMM=; b=B0L09+U2QoRTqaM6/qgdzSi31Z
        bGUGOs6oWWZnqTOoTxyZIZUnEMInKNBuvfo18awjmqlzUWIG+mxGVdV/UOq1OzLef7ci0IGhTTTpq
        FTSD4AfBVZw3rKQDWR2VRIocxQ8iD+W6SFE3Auu4I2czF679Lk5fbBoo8EdIFLL6eRO8y7oyEAYP8
        O4ZbTiRnhgFdVBHipz59jj5NyAJofb+qw2KpVFlbaMuRPXZLzTZaWHOW08+KUow39Lj+GqH/WyiXS
        rjE+IQMCFzr1nISH7lqOrbJkGAhentDuPBCikT2rJy0CS31ZIwxS7rTxgUlzNvVVWLYdIV9doG1QK
        NZVM1KDg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kee55-0004fe-Ri; Mon, 16 Nov 2020 12:58:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 79A623060AE;
        Mon, 16 Nov 2020 13:58:03 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 65CAB202647A8; Mon, 16 Nov 2020 13:58:03 +0100 (CET)
Date:   Mon, 16 Nov 2020 13:58:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Will Deacon <will@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Loadavg accounting error on arm64
Message-ID: <20201116125803.GB3121429@hirez.programming.kicks-ass.net>
References: <20201116091054.GL3371@techsingularity.net>
 <20201116114938.GN3371@techsingularity.net>
 <20201116125355.GB3121392@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116125355.GB3121392@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 01:53:55PM +0100, Peter Zijlstra wrote:
> On Mon, Nov 16, 2020 at 11:49:38AM +0000, Mel Gorman wrote:
> > On Mon, Nov 16, 2020 at 09:10:54AM +0000, Mel Gorman wrote:
> > > I'll be looking again today to see can I find a mistake in the ordering for
> > > how sched_contributes_to_load is handled but again, the lack of knowledge
> > > on the arm64 memory model means I'm a bit stuck and a second set of eyes
> > > would be nice :(
> > > 
> > 
> > This morning, it's not particularly clear what orders the visibility of
> > sched_contributes_to_load exactly like other task fields in the schedule
> > vs try_to_wake_up paths. I thought the rq lock would have ordered them but
> > something is clearly off or loadavg would not be getting screwed. It could
> > be done with an rmb and wmb (testing and hasn't blown up so far) but that's
> > far too heavy.  smp_load_acquire/smp_store_release might be sufficient
> > on it although less clear if the arm64 gives the necessary guarantees.
> > 
> > (This is still at the chucking out ideas as I haven't context switched
> > back in all the memory barrier rules).
> 
> IIRC it should be so ordered by ->on_cpu.
> 
> We have:
> 
> 	schedule()
> 		prev->sched_contributes_to_load = X;
> 		smp_store_release(prev->on_cpu, 0);
> 
> 
> on the one hand, and:

Ah, my bad, ttwu() itself will of course wait for !p->on_cpu before we
even get here.

> 	sched_ttwu_pending()
> 		if (WARN_ON_ONCE(p->on_cpu))
> 			smp_cond_load_acquire(&p->on_cpu)
> 
> 		ttwu_do_activate()
> 			if (p->sched_contributes_to_load)
> 				...
> 
> on the other (for the remote case, which is the only 'interesting' one).

Also see the "Notes on Program-Order guarantees on SMP systems."
comment.
