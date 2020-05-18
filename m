Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396C31D87B2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 20:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbgERSyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 14:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729960AbgERSyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:54:46 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30BEC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 11:54:45 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jakta-0002EB-7p; Mon, 18 May 2020 20:53:50 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 749D9100606; Mon, 18 May 2020 20:53:49 +0200 (CEST)
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
Subject: Re: [patch V6 00/37] x86/entry: Rework leftovers and merge plan
In-Reply-To: <20200518160750.GA279861@hirez.programming.kicks-ass.net>
References: <20200515234547.710474468@linutronix.de> <20200518160750.GA279861@hirez.programming.kicks-ass.net>
Date:   Mon, 18 May 2020 20:53:49 +0200
Message-ID: <87h7wdvzuq.fsf@nanos.tec.linutronix.de>
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
> So on top of you entry-v8-full; I had to chase one of those
> instrumentation_end() escapes an (extended) basic block chase (again!).
>  
> +#ifdef CONFIG_DEBUG_ENTRY

Why this? We lose the kprobes runtime protection that way.

> +/* Section for code which can't be instrumented at all */
> +#define noinstr								\
> +	noinline notrace __attribute((__section__(".noinstr.text")))
> +
>  /* Begin/end of an instrumentation safe region */
> -#define instrumentation_begin() ({						\
> +#define instrumentation_begin() ({					\
>  	asm volatile("%c0:\n\t"						\
>  		     ".pushsection .discard.instr_begin\n\t"		\
>  		     ".long %c0b - .\n\t"				\
>  		     ".popsection\n\t" : : "i" (__COUNTER__));

Nifty.

Thanks,

        tglx
