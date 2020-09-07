Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 401E025FD43
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 17:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbgIGPiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 11:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730143AbgIGPfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 11:35:00 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528DBC061575
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 08:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TfuRDbRYW8TYNwANgZL+EbTXtIdzHJowKXdYA+i1hXw=; b=fhuYzsV/70PNv7x2BbqGWXddBI
        oilJKFSd0d1raGi62ooPs3mBJIv0A7Fe6781M/c+ZjccAR0ZHRWFyFRzIUyo2adx+YnFIv/aFA4sC
        xLYiHUmLitZw5wMHlZBHUQr28AhxzVt57xSOs3nOixcU4huTap9bAhYXdv9xhucZx/LAvhDZbstVE
        9UjC3Ffr5jOK+GHUKzzKlwYi4vqjDiP/g3zQJZiCCbEz6rZXO/QKXJR0Ane5szsTiSUNl/l+OOWGd
        9J9PuCUsvkCE3JZLLDlTn4XpEti0tJlI7dDNSuTzuXf8TZmSFTcKdJXmGdmZOyVLjhOkNA9kbdGH2
        7kfFkAXQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFJ9v-0002dS-VS; Mon, 07 Sep 2020 15:34:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 130A5300238;
        Mon,  7 Sep 2020 17:34:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EDA1F2C09D7F3; Mon,  7 Sep 2020 17:34:17 +0200 (CEST)
Date:   Mon, 7 Sep 2020 17:34:17 +0200
From:   peterz@infradead.org
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Requirements to control kernel isolation/nohz_full at runtime
Message-ID: <20200907153417.GL1362448@hirez.programming.kicks-ass.net>
References: <20200901104640.GA13814@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901104640.GA13814@lenoir>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


(your mailer broke and forgot to keep lines shorter than 78 chars)

On Tue, Sep 01, 2020 at 12:46:41PM +0200, Frederic Weisbecker wrote:

> == TIF_NOHZ ==
> 
> Need to get rid of that in order not to trigger syscall slowpath on
> CPUs that don't want nohz_full.  Also we don't want to iterate all
> threads and clear the flag when the last nohz_full CPU exits nohz_full
> mode. Prefer static keys to call context tracking on archs. x86 does
> that well.

Build on the common entry code I suppose. Then any arch that uses that
gets to have the new features.

> == Proper entry code ==
> 
> We must make sure that a given arch never calls exception_enter() /
> exception_exit().  This saves the previous state of context tracking
> and switch to kernel mode (from context tracking POV) temporarily.
> Since this state is saved on the stack, this prevents us from turning
> off context tracking entirely on a CPU: The tracking must be done on
> all CPUs and that takes some cycles.
> 
> This means that, considering early entry code (before the call to
> context tracking upon kernel entry, and after the call to context
> tracking upon kernel exit), we must take care of few things:
> 
> 1) Make sure early entry code can't trigger exceptions. Or if it does,
> the given exception can't schedule or use RCU (unless it calls
> rcu_nmi_enter()). Otherwise the exception must call
> exception_enter()/exception_exit() which we don't want.

I think this is true for x86. Early entry has interrupts disabled, any
exception that can still happen is NMI-like and will thus use
rcu_nmi_enter().

On x86 that now includes #DB (which is also excluded due to us refusing
to set execution breakpoints on entry code), #BP, NMI and MCE.

> 2) No call to schedule_user().

I'm not sure what that is supposed to do, but x86 doesn't appear to have
it, so all good :-)

> 3) Make sure early entry code is not interruptible or
> preempt_schedule_irq() would rely on
> exception_entry()/exception_exit()

This is so for x86.

> 4) Make sure early entry code can't be traced (no call to
> preempt_schedule_notrace()), or if it does it can't schedule

noinstr is your friend.

> I believe x86 does most of that well.

It does now.

