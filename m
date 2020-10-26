Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1E682991D4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1784942AbgJZQFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:05:44 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49544 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1784922AbgJZQFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:05:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wouLraCsk5WUOx6sCuOh3P0hXwYz4x0ZoUyeO6b2lOY=; b=pJUIz6XaqGbMZKTesoOe8jSwUo
        LhAym+0KgpOlzMfYAGE5a5WNIyp59uN9TDgH+coub2u0j5lZEUTF31eThKm5R+HpVDT6+Iza4zWQE
        oWFbQ2vrLdjpCmYU6Guzo2BflJj3uNyOsln1kI0SNnaf2JorYwhhgupKQV43PTc8YXJM2JlX20ORR
        XkvsbCbyBHr5n63y2EE8i3Zmwzm9QzrOPwUMhzyFRUzXBVPs9/mtq8i8bAgLE6DE/20bMMhVIiqJ4
        Yav3ihtkkuByQvc4P/IEinhe/CB6b8cCSZSh3p4zlxYb9aiyiUOYgscSrdIphEXzUYgg/fnxLvwQt
        6gqQbbYg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kX4zk-0003bf-3E; Mon, 26 Oct 2020 16:05:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 93012305DD1;
        Mon, 26 Oct 2020 17:05:13 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7D6592B6C3D59; Mon, 26 Oct 2020 17:05:13 +0100 (CET)
Date:   Mon, 26 Oct 2020 17:05:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kyle Huey <me@kylehuey.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
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
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [REGRESSION] x86/debug: After PTRACE_SINGLESTEP DR_STEP is no
 longer reported in dr6
Message-ID: <20201026160513.GC2651@hirez.programming.kicks-ass.net>
References: <CAP045Ar5CtqknH66i5ti6xOvo9cC9ib5v-5+3fFKcp_DW91hYw@mail.gmail.com>
 <20201026155521.GQ2594@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026155521.GQ2594@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 04:55:21PM +0100, Peter Zijlstra wrote:
> On Mon, Oct 26, 2020 at 07:33:08AM -0700, Kyle Huey wrote:
> > After resuming a ptracee with PTRACE_SINGLESTEP, in the following
> > ptrace stop retrieving the dr6 value for the tracee gets a value that
> > does not include DR_STEP (it is in fact always DR6_RESERVED). I
> > bisected this to the 13cb73490f475f8e7669f9288be0bcfa85399b1f merge. I
> > did not bisect further.
> > 
> > I don't see any handling to ever set DR_STEP in virtual_dr6, so I
> > think this code is just broken.
> > 
> > Sorry for not testing this when I was CCd on the original patch series :)
> 
> Urgh, now I have to try and remember how all that worked again ...
> 
> I suspect it's either one (or both) of the last two:
> 
>   f4956cf83ed1 ("x86/debug: Support negative polarity DR6 bits")
>   d53d9bc0cf78 ("x86/debug: Change thread.debugreg6 to thread.virtual_dr6")
> 
> 
> Just to clarify, the sequence is something like:
> 
>  - tracer: ptrace(PTRACE_SINGLESTEP)
>  - tracee: #DB, DR6 contains DR_STEP
>  - tracer: ptrace_get_debugreg(6)
> 
> ?
> 
> You're right that that would be broken, let me try and figure out what
> the best way would be 'fix' that.
> 
> Also, can you confirm that pthread_set_debugreg(6) should not do
> anything useful?


Does something like this make sense?


diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 3c70fb34028b..0e7641ac19a8 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -799,6 +799,13 @@ static __always_inline unsigned long debug_read_clear_dr6(void)
 	 */
 	current->thread.virtual_dr6 = 0;
 
+	/*
+	 * If PTRACE requested SINGLE(BLOCK)STEP, make sure to reflect that in
+	 * the ptrace visible DR6 copy.
+	 */
+	if (test_thread_flag(TIF_BLOCKSTEP) || test_thread_flag(TIF_SINGLESTEP))
+		current->thread.virtual_dr6 |= dr6 & DR_STEP;
+
 	/*
 	 * The SDM says "The processor clears the BTF flag when it
 	 * generates a debug exception."  Clear TIF_BLOCKSTEP to keep
