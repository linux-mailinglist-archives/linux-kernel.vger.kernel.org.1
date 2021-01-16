Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08DF2F8DF0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 18:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbhAPRM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 12:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728466AbhAPRKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 12:10:51 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C75DC06138F
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 07:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RTMQNl0unrITTldn3H9PARK21DDhwC58XQdGr2cUlB4=; b=Ti+gEP+wESPgtYLu8eYdnp8bVn
        0bwdhfLzKcPpeSw9S3ipjwCk4hPsqpsoll6Lixua3Zt3T96aUT9N1g6SZvX/AW333O3uU3r7zZ550
        ehPi9oG6QqcIzv0oYa7/8eNZcKHhWm4aGdGXDLBwHmBSxsE0YWEkkC62njEqySdO3xn4Vowd3xtfl
        H7+TglSX2B5J8ze9pBNcggUwABrIHEfNzxfhrPW1JNtUTyKgp08/VtiOPcpU67BI/clvGgigyYOIR
        9D8Z2atcAYjGwqm6l9D72I8rNsDk8gIlSioSpKEhlDMGJMS8jcQsn41oBmW8FQIAfs7q2jrgkrdGI
        0Xkw3ylA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l0nMc-0005iT-6y; Sat, 16 Jan 2021 15:19:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 06B0F30015A;
        Sat, 16 Jan 2021 16:19:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E32F3202A3F5A; Sat, 16 Jan 2021 16:19:39 +0100 (CET)
Date:   Sat, 16 Jan 2021 16:19:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 8/8] sched: Relax the set_cpus_allowed_ptr() semantics
Message-ID: <YAMECwEi93cWZ1W2@hirez.programming.kicks-ass.net>
References: <20210116113033.608340773@infradead.org>
 <20210116113920.187137770@infradead.org>
 <CAJhGHyB7fNvxyKwnMgWicvZN7oTnGYLBNH8cUjLg2EcKQ4YMMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyB7fNvxyKwnMgWicvZN7oTnGYLBNH8cUjLg2EcKQ4YMMg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 16, 2021 at 10:39:03PM +0800, Lai Jiangshan wrote:
> On Sat, Jan 16, 2021 at 7:43 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Now that we have KTHREAD_IS_PER_CPU to denote the critical per-cpu
> > tasks to retain during CPU offline, we can relax the warning in
> > set_cpus_allowed_ptr(). Any spurious kthread that wants to get on at
> > the last minute will get pushed off before it can run.
> >
> > While during CPU online there is no harm, and actual benefit, to
> > allowing kthreads back on early, it simplifies hotplug code.
> >
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Thanks!
> 
> Relaxing set_cpus_allowed_ptr() was also one of the choices I listed,
> which can really simplify hotplug code in the workqueue and may be
> other hotplug code.

Indeed you did. Having that KTHREAD_IS_PER_CPU for the offline side of
things made it possible to relax (as per the Changelog above).

> Reviewed-by: Lai jiangshan <jiangshanlai@gmail.com>

Thanks!
