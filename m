Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105952EBBF3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 10:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbhAFJx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 04:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbhAFJx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 04:53:28 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17278C06134D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 01:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DVzL9L3/lzax/x2Pd3kTYJGUJQOk2k7Ej5ck80OWA1E=; b=0GOxVGj9g9vTZQpmChyHFzsW1+
        nzbWD0vU9emv8ePOls6Iqg68LXee75oQVJqp3mcxW86XkLoyLzE6BSQMk9UTSHdOlEy5TFckdiqxp
        GjtKPd4ddIHjqhI0bmsB+/LkXWtohQJ63Jn5+s65d9udecJ7gyQLx2lvvGIIglV7HuyKX0L6DcZRd
        ij6IGxP58nZgfvdgjSV+o+F9G10zuozBu2EXQFKAYRh006t7rektAQv71zFu08WTcypzXW+XjnMeI
        sWITzgO2kh2grSt+2V2d0z3YOyXEFtYjHWB4BggyOmo4jkonTS2zEWwjRqg4Senr/9IzrUqQkf0k/
        R9N4pQqA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kx5UJ-0003mR-1l; Wed, 06 Jan 2021 09:52:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A57EC30015A;
        Wed,  6 Jan 2021 10:52:14 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7706F2029F4C3; Wed,  6 Jan 2021 10:52:14 +0100 (CET)
Date:   Wed, 6 Jan 2021 10:52:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com, bristot@redhat.com, frederic@kernel.org
Subject: Re: lockdep splat in v5.11-rc1 involving console_sem and rq locks
Message-ID: <X/WITr5JuNvuMH+p@hirez.programming.kicks-ass.net>
References: <20210105220115.GA27357@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105220115.GA27357@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 02:01:15PM -0800, Paul E. McKenney wrote:
> Hello!
> 
> The RUDE01 rcutorture scenario (and less often, the TASKS01 scenario)
> results in occasional lockdep splats on v5.11-rc1 on x86.  This failure
> is probabalistic, sometimes happening as much as 30% of the time, but
> sometimes happening quite a bit less frequently.  (And yes, this did
> result in a false bisection.  Why do you ask?)  The problem seems to
> happen more frequently shortly after boot, so for fastest reproduction
> run lots of 10-minute RUDE01 runs, which did eventually result in a
> good bisection.  (Yes, I did hammer the last good commit for awhile.)
> 
> The first bad commit is 1cf12e08bc4d ("sched/hotplug: Consolidate task
> migration on CPU unplug").  An example splat is shown below.
> 
> Thoughts?

The splat is because you hit a WARN, we're working on that.

  https://lkml.kernel.org/r/20201226025117.2770-1-jiangshanlai@gmail.com
