Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 428B61FBBBE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 18:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbgFPQbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 12:31:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:60392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729167AbgFPQbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 12:31:01 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E428E20679;
        Tue, 16 Jun 2020 16:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592325060;
        bh=W7Pho91Xm+elkwKelH3qLZlOsIt8PfgFxIc/P+UvK3c=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=2O0qAGA8Ilp58adA/TcAICjKIT9bf2cAlJwFNWeobF0GQvp2UTWV57Fhvtuec+bTa
         ONT2kmCDxsx5ZvUIAN9NSAtLHNna+MiB2MKgrEmHK5SX6vLN/yNFnSzyUqIboF6JVz
         a9dOhoiBTWb8PWpGmOzIz6fYxsX6ObO+4uwCvMvo=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C95843521103; Tue, 16 Jun 2020 09:31:00 -0700 (PDT)
Date:   Tue, 16 Jun 2020 09:31:00 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, frederic@kernel.org
Subject: Re: [PATCH 0/6] sched: TTWU, IPI, and assorted stuff
Message-ID: <20200616163100.GA5370@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200615125654.678940605@infradead.org>
 <20200615162330.GF2723@paulmck-ThinkPad-P72>
 <20200615164048.GC2531@hirez.programming.kicks-ass.net>
 <20200615172149.GJ2723@paulmck-ThinkPad-P72>
 <20200615191158.GK2531@hirez.programming.kicks-ass.net>
 <20200615195522.GL2723@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615195522.GL2723@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 12:55:22PM -0700, Paul E. McKenney wrote:
> On Mon, Jun 15, 2020 at 09:11:58PM +0200, Peter Zijlstra wrote:
> > On Mon, Jun 15, 2020 at 10:21:49AM -0700, Paul E. McKenney wrote:
> > > On Mon, Jun 15, 2020 at 06:40:48PM +0200, Peter Zijlstra wrote:
> > 
> > > > Thanks! I've got 16*TREE03 running since this morning, so far so nothing :/
> > > > (FWIW that's 16/9 times overcommit, idle time fluctuates around 10%).
> > > 
> > > My large system as large remote memory latencies, as in the better part
> > > of a microsecond.  My small system is old (Haswell).  So, just to grasp
> > > at the obvious straw, do you have access to a multisocket Haswell system?
> > 
> > I've been running this on a 4 socket haswell ex.
> 
> OK, I officially have no idea, then!

Ah, are you overcommitting?  None of my Haswell runs did any overcommit.

Also, any failures in the meantime?

Any debug/tracing/whatever that I could add to my runs?

							Thanx, Paul
