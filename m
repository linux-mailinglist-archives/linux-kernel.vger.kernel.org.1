Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E81E29E5D7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 09:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgJ2IHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 04:07:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:34852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726714AbgJ2IHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 04:07:40 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AC522071A;
        Thu, 29 Oct 2020 08:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603958860;
        bh=kpWNJPWGD4JFwLM+mHUyzzxC6LBl3TEm0/BDqlS76+w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p5j/vgBuQezI6kR9EU1fwI5RM0bNnX6e2eSjaPejpXXKukozYtdR1oYABLFUxNbtI
         CZnvYEO7FvMZi0KhP7nnKClDG+0QQ5CqIC90UWrM7jnRJVgtMBVNz77OV3proh2Kwo
         5y/F5YAlACNAemiizQ//E4r1aRGnkNYM2XQLFMhE=
Date:   Thu, 29 Oct 2020 17:07:36 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RFC][PATCH 1/2 v2] ftrace/x86: Allow for arguments to be
 passed in to REGS by default
Message-Id: <20201029170736.938ded569b436c858ebc2555@kernel.org>
In-Reply-To: <20201028112916.50bcbc69@oasis.local.home>
References: <20201028131542.963014814@goodmis.org>
        <20201028131909.738751907@goodmis.org>
        <20201028102502.28095c95@oasis.local.home>
        <20201028112916.50bcbc69@oasis.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Oct 2020 11:29:16 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Hi Masami,
> 
> Talking with Peter and Thomas on IRC, where they really don't like
> passing a partial pt_regs around, got me thinking of redoing the REGS
> parameter of ftrace. Kprobes is the only user that requires the full
> registers being saved, and that's only because some kprobe user might
> want them.

Yes, kprobes can be used for debugging use case. I think we can skip
coller-saved registers (because ftrace is embedded by compiler and it
may save such registers correctly), but we still need a pt_regs on memory
to access it.

> 
> On Wed, 28 Oct 2020 10:25:02 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> >  typedef void (*ftrace_func_t)(unsigned long ip, unsigned long parent_ip,
> >  			      struct ftrace_ops *op, struct pt_regs *regs);
> >  
> 
> 
> Most registers of pt_regs at a start of a function is rather useless.
> What if we got rid of FL_SAVE_REGS all together and had a "ftrace_regs"
> structure passed in that would have only access to all the argument
> registers, the stack pointer and the instruction pointer?

Yeah, that's OK to me. If someone wants to investigate suspicious compiler
bug, they should not put a kprobe on the fentry call site. (in most cases
symbol+5 will put a breakpoint right after fentry nop)

> Then kprobes could just create its own pt_regs, fill in all the data
> from ftrace_regs and then fill the rest with zeros or possibly whatever
> the values currently are (does it really matter what those registers
> are?), including flags.

That sounds good to me.

> 
> Not only would this simplify the code, it would probably allow moving
> more of the kprobe code from the arch specific to the generic code, and
> remove a lot of duplication.

Ah, right.

> 
> This would also help speed up the processing of live kernel patching.
> 
> And best of all, it would give everything access to the arguments of a
> function and a stack pointer with out (ab)using pt_regs.
> 
> Do you think this would be feasible?

Yes, I agreed.

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu <mhiramat@kernel.org>
