Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B46D1D3053
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 14:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgENMwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 08:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725955AbgENMwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 08:52:06 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D08C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 05:52:06 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jZDKm-0006p3-P1; Thu, 14 May 2020 14:51:32 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 461091004CE; Thu, 14 May 2020 14:51:32 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
        Will Deacon <will@kernel.org>
Subject: Re: [patch V4 part 4 02/24] x86/int3: Avoid atomic instrumentation
In-Reply-To: <20200514093257.GT2978@hirez.programming.kicks-ass.net>
References: <20200505134926.578885807@linutronix.de> <20200505135313.517429268@linutronix.de> <CALCETrXVQsdPafvH56_nF+CKU94wgq-T71=EB6eSBnz70Cd0Rw@mail.gmail.com> <20200514093257.GT2978@hirez.programming.kicks-ass.net>
Date:   Thu, 14 May 2020 14:51:32 +0200
Message-ID: <87h7wiznl7.fsf@nanos.tec.linutronix.de>
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
> On Wed, May 13, 2020 at 09:57:52PM -0700, Andy Lutomirski wrote:
>> On Tue, May 5, 2020 at 7:15 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>> >
>> > From: Peter Zijlstra <peterz@infradead.org>
>> >
>> > Use arch_atomic_*() and READ_ONCE_NOCHECK() to ensure nothing untoward
>> > creeps in and ruins things.
>> >
>> > That is; this is the INT3 text poke handler, strictly limit the code
>> > that runs in it, lest it inadvertenly hits yet another INT3.
>> 
>> 
>> Acked-by: Andy Lutomirski <luto@kernel.org>
>> 
>> Does objtool catch this error?
>
> It does not. I'll put it on the (endless) todo list..

Well, at least it detects when that code calls out into something which
is not in the non-instrumentable section.

As long as instrumentation respects the rules that this section is taboo,
this should not happen. Emphasis on *should*.
