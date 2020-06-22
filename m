Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE1B62033BB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 11:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgFVJm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 05:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbgFVJmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 05:42:16 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2939CC061794
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 02:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=F2oizOLIzSDPEGzqrIYZ4xws8WaXyX/j/TUJhooTcyU=; b=zg32g+4AN9irglsjqr2hDOmjNh
        ENyc16HWc6CRdoarG5nw6uF10AUmuhdcLcwJuk8bUxT/psueyIFzHXDxQZ+8Ha/CVncCLFZTuevuE
        Lpv1Nd1TAf94UDPDqgLypqaw2KqTI/Oq4JNngF1Hgqat85mcnq+T/Fv91SrVPYdVFqxRmq4lml7sc
        bIY0K/qZltFHzUzXsbyYQ+wHH/zgAMuEMpdGQEEQGe5pKtQf+B825159zHJKgI59X2bq+sbbmPmmc
        tu2NY/Tg/O4ebhxXUi+iahXgGtpWKohYG2QY4D2v4s42hUvo3L/qJujXa3iuf8uFRPK2BIwoD2X/x
        lq4cMH3Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jnIxE-0007gr-Md; Mon, 22 Jun 2020 09:41:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 21CD430018A;
        Mon, 22 Jun 2020 11:41:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1304129BA14A3; Mon, 22 Jun 2020 11:41:26 +0200 (CEST)
Date:   Mon, 22 Jun 2020 11:41:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@suse.de>
Cc:     mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        paulmck@kernel.org, frederic@kernel.org
Subject: Re: [PATCH 1/6] sched: Fix ttwu_queue_cond()
Message-ID: <20200622094126.GN576888@hirez.programming.kicks-ass.net>
References: <20200615125654.678940605@infradead.org>
 <20200615131143.130326165@infradead.org>
 <20200622091122.GG3129@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622091122.GG3129@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 10:11:22AM +0100, Mel Gorman wrote:
> On Mon, Jun 15, 2020 at 02:56:55PM +0200, Peter Zijlstra wrote:
> > Where the condition:
> > 
> >   !cpus_share_cache(smp_processor_id(), cpu)
> > 
> > already implies 'cpu != smp_processor_id()', because a CPU always
> > shares cache with itself, the secondary condition added in commit:
> > 
> >   2ebb17717550 ("sched/core: Offload wakee task activation if it the wakee is descheduling")
> > 
> > voids that implication, resulting in attempting to do local wake-ups
> > through the queue mechanism.
> > 
> > Fixes: 2ebb17717550 ("sched/core: Offload wakee task activation if it the wakee is descheduling")
> > Reported-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Tested-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Yep, I mistakenly though this would be covered by the self-wakeup check
> early in try_to_wake_up() but it is not

It is, one should not be able to observe 'p->on_cpu && task_cpu(cpu) ==
smp_processor_id()); I've since found the actual problem, find here:

  https://lkml.kernel.org/r/20200620184622.GA19696@paulmck-ThinkPad-P72

I'm currently polishing the changelog a little, and will shortly post a
new version of that.
