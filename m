Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7AD29216F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 05:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731523AbgJSDYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 23:24:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:57052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729093AbgJSDYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 23:24:01 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E169B22260;
        Mon, 19 Oct 2020 03:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603077840;
        bh=cbSYRe2oeWcF6i0duGU2sAyb5RapUIjeF4Tekjx8eAo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=UUQ2jmkY2UcTlO60aaBZmsCJvWk3+51j0HAsgEwl6AchINRHa7t/iNtEIzzwfJ3AX
         tKN1bZnC671ieqIc9+kTG9gQQPu6AYPK0BS0SVjCKqBpxfKQNbHDtGipolqiVeC+bv
         MdarAxASp+j37k6kPPNtVZG+plSi8qvCFKocoOgE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 87CC13522A3A; Sun, 18 Oct 2020 20:24:00 -0700 (PDT)
Date:   Sun, 18 Oct 2020 20:24:00 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] RCU changes for v5.10
Message-ID: <20201019032400.GD3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201012141451.GA3425471@gmail.com>
 <CAHk-=whE1rajA5Kzqey802zwv-82yrK5qc=nR3xRo5f38t-K8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whE1rajA5Kzqey802zwv-82yrK5qc=nR3xRo5f38t-K8A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 18, 2020 at 02:39:56PM -0700, Linus Torvalds wrote:
> On Mon, Oct 12, 2020 at 7:14 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> > Please pull the latest core/rcu git tree from:
> >
> >    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-rcu-2020-10-12
> 
> I've pulled everything but that last merge and the PREEMPT_COUNT stuff
> that came with it.
> 
> When Paul asked whether it was ok for RCU to use preempt_count() and I
> answered in the affirmative, I didn't mean it in the sense of "RCU
> wants to force it on everybody else too".
> 
> I'm pretty convinced that the proper fix is to simply make sure that
> rcu_free() and friends aren't run under any raw spinlocks. So even if
> the cost of preempt-count isn't that noticeable, there just isn't a
> reason for RCU to say "screw everybody else, I want this" when there
> are other alternatives.

Thank you for pulling the other branches.

On CONFIG_PREEMPT_COUNT, got it.  It would be OK for RCU to use
preempt_count() for some debugging or specialty kernel, but not across
the board.  Thank you for bearing with me on this one.

There is more to it than just raw spinlocks, but regardless we will go
back to the drawing board and come up with a less intrusive fix for the
v5.11 merge window.

							Thanx, Paul
