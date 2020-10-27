Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B520629A758
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 10:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895375AbgJ0JJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 05:09:07 -0400
Received: from casper.infradead.org ([90.155.50.34]:35278 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408760AbgJ0JJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:09:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XQcCXngkhvG5SpWi+kmrjq+Hhq+RSDL5FOHryXsDGRM=; b=BtzrIzj6HwyZBDTEHNbg3zdDyU
        JLC06krkKQ4LJZtobhd+/TZUhariuccXrET0dFg4VKRG9V6A1Z00tSI5eyzzwXVWn3PSfwI64V9JI
        VU4YLYTS9bxwhpD7pTTZJbj6vTphMoY8Six3XpFxxs50egZeQWlF5xBlsBEnxhW6wjWW6I8Nd3O17
        xTtHn0ZtnKKzqAIAa2WHaQGrtSLJcx1KEQX5f1jFAYNcTUKFOvsm14QtEgzX6e+81MNRD6jDpOl4Z
        MZs95OTghCbeHh+cANiPjHMXAjMyAteOzf1kmhsX/RftV8uDKOJLuRt1AmUMCJ/eeKOHrdUMfcKSw
        E/pcTLAw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXKxo-0004Zb-SK; Tue, 27 Oct 2020 09:08:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B2B6D301179;
        Tue, 27 Oct 2020 10:08:14 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A58692141F77E; Tue, 27 Oct 2020 10:08:14 +0100 (CET)
Date:   Tue, 27 Oct 2020 10:08:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Kyle Huey <me@kylehuey.com>,
        open list <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Robert O'Callahan <rocallahan@gmail.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [REGRESSION] x86/debug: After PTRACE_SINGLESTEP DR_STEP is no
 longer reported in dr6
Message-ID: <20201027090814.GJ2628@hirez.programming.kicks-ass.net>
References: <CAP045Ar5CtqknH66i5ti6xOvo9cC9ib5v-5+3fFKcp_DW91hYw@mail.gmail.com>
 <20201026155521.GQ2594@hirez.programming.kicks-ass.net>
 <20201026160513.GC2651@hirez.programming.kicks-ass.net>
 <CAP045ApB_9h5Pp=a0L+taA6qFURrR6Se+W77Vb7A_VOWJNKfng@mail.gmail.com>
 <20201026163100.GR2594@hirez.programming.kicks-ass.net>
 <20201026165519.GD2651@hirez.programming.kicks-ass.net>
 <CALCETrVwzcpk88jWeNb+iCGBFsyzgbZ0E9_x330A2P-CMzSr4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVwzcpk88jWeNb+iCGBFsyzgbZ0E9_x330A2P-CMzSr4g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 04:30:32PM -0700, Andy Lutomirski wrote:
> Is there any compelling reason not to just drop the condition and do:
> 
> current->thread.virtual_dr6 |= (dr6 & DR_STEP);
> 
> unconditionally?

Because why should it?

> This DR6 cause, along with ICEBP, have the
> regrettable distinctions of being the only causes that a user program
> can trigger all on its own without informing the kernel first.  This
> means that we can't fully separate the concept of "user mode is
> single-stepping itself" from "ptrace or something else is causing the
> kernel to single step a program."

TIF_SINGLESTEP does that. If the kernel is single-stepping userspace it
has TIF_SINGLESTEP (and possibly TIF_FORCED_TF) to distinguish these
cases.

> I bet that, without making this tweak, the virtual_dr6 change will
> regress some horrific Wine use case.

Then we should make sure the Wine people are aware and test this. Do you
know who to poke?

If there are regressions, we'll fix them, but I'd prefer to not create a
mess just because. This whole #DB thing was a giant trainwreck, we'll
obviously have to be bug compatible, but only when people actually
notice.
