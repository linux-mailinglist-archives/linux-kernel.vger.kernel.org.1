Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37E4C1DBFEC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 22:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgETUKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 16:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgETUKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 16:10:12 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA151C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 13:10:11 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jbV27-0002It-7H; Wed, 20 May 2020 22:09:46 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id A629E100C99; Wed, 20 May 2020 22:09:42 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
        Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [patch V6 04/37] x86: Make hardware latency tracing explicit
In-Reply-To: <20200518080814.GJ2940@hirez.programming.kicks-ass.net>
References: <20200515234547.710474468@linutronix.de> <20200515235124.783722942@linutronix.de> <20200518080133.GI2940@hirez.programming.kicks-ass.net> <874ksdzmzf.fsf@nanos.tec.linutronix.de> <20200518080814.GJ2940@hirez.programming.kicks-ass.net>
Date:   Wed, 20 May 2020 22:09:42 +0200
Message-ID: <87imgqv055.fsf@nanos.tec.linutronix.de>
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
> On Mon, May 18, 2020 at 10:05:56AM +0200, Thomas Gleixner wrote:
>> Peter Zijlstra <peterz@infradead.org> writes:
>> > On Sat, May 16, 2020 at 01:45:51AM +0200, Thomas Gleixner wrote:
>> >> --- a/arch/x86/kernel/nmi.c
>> >> +++ b/arch/x86/kernel/nmi.c
>> >> @@ -334,6 +334,7 @@ static noinstr void default_do_nmi(struc
>> >>  	__this_cpu_write(last_nmi_rip, regs->ip);
>> >>  
>> >>  	instrumentation_begin();
>> >> +	ftrace_nmi_handler_enter();
>> >>  
>> >>  	handled = nmi_handle(NMI_LOCAL, regs);
>> >>  	__this_cpu_add(nmi_stats.normal, handled);
>> >> @@ -420,6 +421,7 @@ static noinstr void default_do_nmi(struc
>> >>  		unknown_nmi_error(reason, regs);
>> >>  
>> >>  out:
>> >> +	ftrace_nmi_handler_exit();
>> >>  	instrumentation_end();
>> >>  }
>> >
>> > Yeah, so I'm confused about this and the previous patch too. Why not
>> > do just this? Remove that ftrace_nmi_handler.* crud from
>> > nmi_{enter,exit}() and stick it here? Why do we needs the
>> > nmi_{enter,exit}_notrace() thing?
>> 
>> Because you then have to fixup _all_ architectures which use
>> nmi_enter/exit().
>
> We probably have to anyway. But I can do that later I suppose.

Second thoughts. For #DB and #INT3 we can just keep nmi_enter(), needs
just annotation in nmi_enter() around that trace muck.

For #NMI and #MCE I rather avoid the early trace call and do it once we
have reached "stable" state, i.e. avoid it in the whole nested NMI mess.

Thanks,

        tglx
