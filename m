Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E0B1FA0D1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 21:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730467AbgFOTzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 15:55:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:40644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728771AbgFOTzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 15:55:22 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FB102071A;
        Mon, 15 Jun 2020 19:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592250922;
        bh=WWy1InKmp9Nqlca/VmtETPJ/GzqTmZFUh28dBVZElqM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WZnuWA/O6SHyYoAYt23oW7Uargxc7tkQFP6bqBtrpjscMAku8tY8kzKD42R6oXf78
         Rkceuv+pv3ZsdLlRohI+I+alkxG0fNqgjxXQyryMewcdwyMFTCCy+VdFDiJUQa9uQ7
         4iehDUPh0IW88TPZ3mtztl6eyq3oHzz1qPHPvBgk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3929435218F0; Mon, 15 Jun 2020 12:55:22 -0700 (PDT)
Date:   Mon, 15 Jun 2020 12:55:22 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, frederic@kernel.org
Subject: Re: [PATCH 0/6] sched: TTWU, IPI, and assorted stuff
Message-ID: <20200615195522.GL2723@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200615125654.678940605@infradead.org>
 <20200615162330.GF2723@paulmck-ThinkPad-P72>
 <20200615164048.GC2531@hirez.programming.kicks-ass.net>
 <20200615172149.GJ2723@paulmck-ThinkPad-P72>
 <20200615191158.GK2531@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615191158.GK2531@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 09:11:58PM +0200, Peter Zijlstra wrote:
> On Mon, Jun 15, 2020 at 10:21:49AM -0700, Paul E. McKenney wrote:
> > On Mon, Jun 15, 2020 at 06:40:48PM +0200, Peter Zijlstra wrote:
> 
> > > Thanks! I've got 16*TREE03 running since this morning, so far so nothing :/
> > > (FWIW that's 16/9 times overcommit, idle time fluctuates around 10%).
> > 
> > My large system as large remote memory latencies, as in the better part
> > of a microsecond.  My small system is old (Haswell).  So, just to grasp
> > at the obvious straw, do you have access to a multisocket Haswell system?
> 
> I've been running this on a 4 socket haswell ex.

OK, I officially have no idea, then!

							Thanx, Paul
