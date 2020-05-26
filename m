Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3B6F1D68C5
	for <lists+linux-kernel@lfdr.de>; Sun, 17 May 2020 18:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgEQQPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 May 2020 12:15:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728010AbgEQQPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 12:15:31 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 662CB20643;
        Sun, 17 May 2020 16:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589732131;
        bh=z8Iw2EC+hWk47H3+Gu60kXdJkbzskZsG8hE0DV8tELA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=jCS7rAMi2xLjJ0rvElPrDXgnAgS9Ns+nBT/X63KQiAtfs4w1qI5UudP8sdQHZacVt
         FOuK20in43lyVZ388KIZxzfB4aVBwJm40wBl8qWrUVsjPy79AUYadTQaLOwoqmjicq
         21oS7f4h7VSnXF+rcO5G2hpl0gX42tLGGPj1BPqY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 406E53520FBB; Sun, 17 May 2020 09:15:31 -0700 (PDT)
Date:   Sun, 17 May 2020 09:15:31 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>, frextrite@gmail.com,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        madhuparnabhowmik04@gmail.com,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        peterz@infradead.org, Petr Mladek <pmladek@suse.com>,
        rcu@vger.kernel.org, rostedt@goodmis.org, vpillai@digitalocean.com
Subject: Re: [PATCH v3 0/5] RCU dyntick nesting counter cleanups for rcu -dev
Message-ID: <20200517161531.GR2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200504120505.89351-1-joel@joelfernandes.org>
 <20200504171532.GR2869@paulmck-ThinkPad-P72>
 <20200504174413.GA8883@paulmck-ThinkPad-P72>
 <20200516171223.GC2639@paulmck-ThinkPad-P72>
 <87wo5adfh8.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wo5adfh8.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 17, 2020 at 12:26:43PM +0200, Thomas Gleixner wrote:
> Paul,
> 
> "Paul E. McKenney" <paulmck@kernel.org> writes:
> > And I have allegedly resolved the conflicts with Thomas's and Peter's
> > series, or at least the noinstr-rcu-nmi-2020-05-15 branch of that series.
> > At least one conflict was completely invisible to "git rebase" (but
> > fortunately blindingly obvious to the compiler).  This naturally makes
> > me suspect that additional adjustments might be needed.  Especially
> > given that misplaced instrumentation_begin() and instrumentation_end()
> > calls are invisible not only to the compiler, but also to rcutorture in
> > my setup.  (For example, tracing before instrumentation_begin() or after
> > instrumentation_end() is a bug.)
> 
> there is tooling to verify that. If you merge
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git entry-v7-full
> 
> into your dev branch (trivial conflict) and after building it, run:
> 
>  objtool check -fal $BUILDIR/vmlinux.o

The conflict was trivial, but for future reference, where should I be
getting the proper objtool from?

							Thanx, Paul
