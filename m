Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D186B2F9947
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 06:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730836AbhARF3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 00:29:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:34738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbhARF3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 00:29:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64FA3224B0;
        Mon, 18 Jan 2021 05:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610947712;
        bh=QgTMGxJAe9tdBp0x6ptsNNJxv9UF/dz02YHMLIgPMH8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Sa2G+kKqlulYKSgkLYc2GqYTmD7NY77qpQwoaPgkg+Kag8IpH6a99cItfmCN5eJ1k
         G4xE1/NPd0SkWPPNJO9phPAzSAaVIPrcOSyb7gzBc2lKXiiivtS4FU9CvZ45URue9i
         GHBS0P2wvOM49+5xN2FKEo026RUvcp/ftYgAAhqcyIqObrSQ0SGIziupFzs5VyEge8
         V1EOEgWN+MPyeQUhNI8j8bWu2lD+WVfoYSYYvArlOQmzLteQ9jyXtX0TGGTt670/c5
         xLJSyAhYEnoCwNQMioSXLwUi/+oVUe+pfXkxqXoTr3XHJrAr++M6AVw49SPjW+DX4K
         B5mdRebPbULTw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 24BD435231E2; Sun, 17 Jan 2021 21:28:32 -0800 (PST)
Date:   Sun, 17 Jan 2021 21:28:32 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        jiangshanlai@gmail.com, valentin.schneider@arm.com, cai@redhat.com,
        vincent.donnefort@arm.com, decui@microsoft.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org, tj@kernel.org
Subject: Re: [PATCH 0/8] sched: Fix hot-unplug regressions
Message-ID: <20210118052832.GA13850@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210116113033.608340773@infradead.org>
 <20210116154859.GR2743@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210116154859.GR2743@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 16, 2021 at 07:48:59AM -0800, Paul E. McKenney wrote:
> On Sat, Jan 16, 2021 at 12:30:33PM +0100, Peter Zijlstra wrote:
> > Hi,
> > 
> > These patches (no longer 4), seems to fix all the hotplug regressions as per
> > nearly a 100 18*SRCU-P runs over-night.
> 
> Nice!!!
> 
> > I did clean up the patches, so possibly I wrecked it again. I've started new
> > runs and will again leave them running over-night.
> > 
> > Paul, if you could please also throw your monster machine at it.
> 
> Will do as soon as the tests I started yesterday complete, which should
> be this afternoon, Pacific Time.
> 
> My thought is to do the full set of scenarios overnight, then try
> hammering either SRCU-P and/or whatever else shows up in the overnight
> test.  Seem reasonable?

And the SRCU-P runs did fine.  I got some task hangs on TREE03 and (to
a lesser extent) TREE04.  These might well be my fault, so I will try
bisecting tomorrow, Pacific Time.

							Thanx, Paul
