Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5100E1D62F8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 May 2020 19:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgEPRSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 May 2020 13:18:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:47070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbgEPRSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 13:18:45 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3935420756;
        Sat, 16 May 2020 17:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589649525;
        bh=v5RTKfeEuKcR+4A+XVmS+Cjs2eERqYGhf+P7cScDTJw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=lu0EM76LMrB5odn6AHwGAZiW+tcwmem1e78pPMvBOqE8lBBotijxC12faoK4n/rnn
         AuFRxlNz3ZwSvOkB42zDn6hpBzfiziHaQD0mUOXWlh3ewqm6aRzgDphdE4X6Krd/dz
         vWhXW4HASoYYgbHkTMf0XA6o+YU+Sem1G2+aY8Z0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1F5723522CED; Sat, 16 May 2020 10:18:45 -0700 (PDT)
Date:   Sat, 16 May 2020 10:18:45 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [patch V6 00/37] x86/entry: Rework leftovers and merge plan
Message-ID: <20200516171845.GM2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200515234547.710474468@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515234547.710474468@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 16, 2020 at 01:45:47AM +0200, Thomas Gleixner wrote:

[ . . . ]

>   - noinstr-rcu-nmi-2020-05-15
> 
>     Based on the core/rcu branch in the tip tree. It has merged in
>     noinstr-lds-2020-05-15 and contains the nmi_enter/exit() changes along
>     with the noinstr section changes on top.
> 
>     This tag is intended to be pulled by Paul into his rcu/next branch so
>     he can sort the conflicts and base further work on top.

And this sorting process is now allegedly complete and available on the
-rcu tree's "dev" branch.  As you might have guessed, the major source
of conflicts were with Joel's patches, including one conflict that was
invisible to "git rebase":

1b2530e7d0c3 ("Revert b8c17e6664c4 ("rcu: Maintain special bits at bottom of ->dynticks counter")
03f31532d0ce ("rcu/tree: Add better tracing for dyntick-idle")
a309d5ce2335 ("rcu/tree: Clean up dynticks counter usage")
5c6e734fbaeb ("rcu/tree: Remove dynticks_nmi_nesting counter")

This passes modest rcutorture testing.  So far, so good!  ;-)

							Thanx, Paul
