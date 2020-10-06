Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 053FD284E44
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 16:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgJFOsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 10:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgJFOsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 10:48:42 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB73FC061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 07:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jvhKVBKVIe7z+Sca0xM4NQq1rBIpnHhLLPH1G4GBru0=; b=HgKH9ZwwVua6z2Z3TAI9RF3q0N
        cr+Q8EmMnG5UJ/FA6UvWC5xaQk+RGn8xd5CfBQnmGG/B5KUqxqbTuL3RHPqYID9APboMkc5QWdPqG
        m+TQnSyrneyaMmDETIAlP8aFG3kuw4TQ9Hyo0n9qotRoznmOCixIYj1UNX6YhgPgoNl8UmhKaRCdR
        bm+FPFlIhy4jM1Vl8IKAIdrl1rpgp6Mj8tztnj/qi+6aBH55KvRoVd8qYl4qG3eV890vQoLM61bGP
        qKMWflBBdKEeF3ZWLBwrkkzAGqG/pPtniufMUHUTBZhghUMm79AiVnwKDL14mvv6es4hfFAbkqh/0
        0YzPKPag==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPoGI-0000MJ-Gv; Tue, 06 Oct 2020 14:48:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 904AF3011C6;
        Tue,  6 Oct 2020 16:48:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7750328527D77; Tue,  6 Oct 2020 16:48:16 +0200 (CEST)
Date:   Tue, 6 Oct 2020 16:48:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, tj@kernel.org
Subject: Re: [PATCH -v2 15/17] sched: Fix migrate_disable() vs rt/dl balancing
Message-ID: <20201006144816.GZ2628@hirez.programming.kicks-ass.net>
References: <20201005145717.346020688@infradead.org>
 <20201005150922.458081448@infradead.org>
 <jhjv9fnmwhg.mognet@arm.com>
 <20201006134850.GV2628@hirez.programming.kicks-ass.net>
 <20201006143704.GJ4352@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006143704.GJ4352@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 04:37:04PM +0200, Juri Lelli wrote:
> On 06/10/20 15:48, Peter Zijlstra wrote:
> > On Tue, Oct 06, 2020 at 12:20:43PM +0100, Valentin Schneider wrote:
> > > 
> > > On 05/10/20 15:57, Peter Zijlstra wrote:
> > > > In order to minimize the interference of migrate_disable() on lower
> > > > priority tasks, which can be deprived of runtime due to being stuck
> > > > below a higher priority task. Teach the RT/DL balancers to push away
> > > > these higher priority tasks when a lower priority task gets selected
> > > > to run on a freshly demoted CPU (pull).
> 
> Still digesting the whole lot, but can't we "simply" force push the
> higest prio (that we preempt to make space for the migrate_disabled
> lower prio) directly to the cpu that would accept the lower prio that
> cannot move?
> 
> Asking because AFAIU we are calling find_lock_rq from push_cpu_stop and
> that selects the best cpu for the high prio. I'm basically wondering if
> we could avoid moving, potentially multiple, high prio tasks around to
> make space for a lower prio task.

The intention was to do as you describe in the first paragraph, and
isn't pull also using find_lock_rq() to select the 'lowest' priority
runqueue to move the task to?

That is, both actions should end up at the same 'lowest' prio CPU.
