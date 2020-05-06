Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD7A1C776C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 19:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730343AbgEFRGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 13:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729414AbgEFRGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 13:06:16 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F11C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 10:06:16 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jWNUK-00008S-Rr; Wed, 06 May 2020 19:05:41 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id ECF241001F5; Wed,  6 May 2020 18:57:38 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [patch V4 part 1 20/36] vmlinux.lds.h: Create section for protection against instrumentation
In-Reply-To: <20200506162848.GI5298@hirez.programming.kicks-ass.net>
References: <20200505131602.633487962@linutronix.de> <20200505134100.075416272@linutronix.de> <20200506160831.GB3329@linux.intel.com> <20200506162848.GI5298@hirez.programming.kicks-ass.net>
Date:   Wed, 06 May 2020 18:57:38 +0200
Message-ID: <871rnxknlp.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:
> On Wed, May 06, 2020 at 09:08:31AM -0700, Sean Christopherson wrote:
>> On Tue, May 05, 2020 at 03:16:22PM +0200, Thomas Gleixner wrote:
>> > Provide also a set of markers: instr_begin()/end()
>> > 
>> > These are used to mark code inside a noinstr function which calls
>> > into regular instrumentable text section as safe.
>> 
>> ...
>> 
>> > --- a/include/linux/compiler.h
>> > +++ b/include/linux/compiler.h
>> > @@ -120,10 +120,27 @@ void ftrace_likely_update(struct ftrace_
>> >  /* Annotate a C jump table to allow objtool to follow the code flow */
>> >  #define __annotate_jump_table __section(.rodata..c_jump_table)
>> >  
>> > +/* Begin/end of an instrumentation safe region */
>> > +#define instr_begin() ({						\
>> > +	asm volatile("%c0:\n\t"						\
>> > +		     ".pushsection .discard.instr_begin\n\t"		\
>> > +		     ".long %c0b - .\n\t"				\
>> > +		     ".popsection\n\t" : : "i" (__COUNTER__));		\
>> > +})
>> > +
>> > +#define instr_end() ({							\
>> > +	asm volatile("%c0:\n\t"						\
>> > +		     ".pushsection .discard.instr_end\n\t"		\
>> > +		     ".long %c0b - .\n\t"				\
>> > +		     ".popsection\n\t" : : "i" (__COUNTER__));		\
>> > +})
>> 
>> Any chance we could spell these out, i.e. instrumentation_begin/end()?  I
>> can't help but read these as "instruction_begin/end".  At a glance, the
>> long names shouldn't cause any wrap/indentation issues.
>
> The kernel naming convention is insn for instruction, not instr. That
> said, you're not the first to be confused by this.

I'm happy to spell it out. Was just lazy I guess.
