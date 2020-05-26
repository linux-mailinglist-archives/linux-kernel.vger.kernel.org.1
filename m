Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05FE1D2536
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 04:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgENCv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 22:51:56 -0400
Received: from mail.efficios.com ([167.114.26.124]:48868 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgENCvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 22:51:55 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 2F0EB2A1935;
        Wed, 13 May 2020 22:51:54 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id yAUOqIp6SuWL; Wed, 13 May 2020 22:51:53 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id C75892A16C4;
        Wed, 13 May 2020 22:51:53 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com C75892A16C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1589424713;
        bh=RluM+yQK+xOpY5YHus0NtCagZdVL/MNnexkXbC1Zk10=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=BrKd6shGetVN8DFqTRaTV0b0y01VZ5+jyi98ZmwqkUhQzvrhVd568wRKKjZSH7j9/
         AvT9ItTj5xV3WSSStHJd1QqoSA6dodY/jRt4rNSA8S855utitf0acbzEQ8odXNr8aJ
         OMXbmcgPx/BXFsrCOG4pSqISj5MYdPsckWcXba/RlpJXoggiRJXlVutgMfRvvcidaq
         2VEvN4rA2qliKooc4AG3BjD1mq9MWtgYNVk3f9Kc/51bZxHnsv9bqidV97auYxV/MY
         2pAYvBL/Sf0Ly/sydKn3LhJ1uPcxzdEA7cBuVtmS9KXFa4x20rrST80r5XCcRgAMKi
         QJUX4RuC3Gdvw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nVsOAfApGQzI; Wed, 13 May 2020 22:51:53 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id B29C12A1737;
        Wed, 13 May 2020 22:51:53 -0400 (EDT)
Date:   Wed, 13 May 2020 22:51:53 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, paulmck <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Message-ID: <1779765540.20682.1589424713646.JavaMail.zimbra@efficios.com>
In-Reply-To: <87v9kzz862.fsf@nanos.tec.linutronix.de>
References: <20200505131602.633487962@linutronix.de> <20200505134058.560059744@linutronix.de> <1970736614.19996.1589403401588.JavaMail.zimbra@efficios.com> <20200513171047.04c2c10e@gandalf.local.home> <87v9kzz862.fsf@nanos.tec.linutronix.de>
Subject: Re: [patch V4 part 1 05/36] x86/entry: Flip _TIF_SIGPENDING and
 _TIF_NOTIFY_RESUME handling
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3928 (ZimbraWebClient - FF76 (Linux)/8.8.15_GA_3928)
Thread-Topic: x86/entry: Flip _TIF_SIGPENDING and _TIF_NOTIFY_RESUME handling
Thread-Index: 2EQzd3LgZ/4HR7uFV7jb8D0jmAXxWw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On May 13, 2020, at 8:12 PM, Thomas Gleixner tglx@linutronix.de wrote:
[...]
> 
>>> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>>> Also, color me confused: is "do_signal()" actually running any user-space,
>>> or just setting up the user-space stack for eventual return to signal
>>> handler ?
> 
> I'm surprised that you can't answer that question yourself. How did you
> ever make rseq work and how did rseq_signal_deliver() end up in
> setup_rt_frame()?
> 
> Hint: Tracing might answer that question
> 
> And to cut it short:
> 
>    Exit to user space happnes only through ONE channel, i.e. leaving
>    prepare_exit_to usermode().
> 

[...]

Yes, I'm very well aware of this. But the patch commit message states:

"Make sure task_work runs before any kind of userspace -- very much
including signals -- is invoked."

which seems to imply that "userspace" can be "invoked" before the task_work
runs. Which makes no sense whatsoever. Hence my confused state.

>>> Also, it might be OK, but we're changing the order of two things which
>>> have effects on each other: restartable sequences abort fixup for preemption
>>> and do_signal(), which also have effects on rseq abort.
>>> 
>>> Because those two will cause the abort to trigger, I suspect changing
>>> the order might be OK, but we really need to think this through.
> 
> That's a purely academic problem. The order is completely
> irrelevant. You have to handle any order anyway:

Yes indeed, whether either a signal handler frame fixup or return IP
fixup fires first (clearing the rseq_cs pointer in the process) is
irrelevant, because they will have the effect on the user-space program's
flow. And as you say, given it is run in a loop and can be preempted,
any order can happen here, so we have to be prepared for it. This loop
has caused me tons of headaches when stress-testing on NUMA machines by
the way.

> That said, even for the case Andy and Peter were looking at (MCE) the
> ordering is completely irrelevant.

Not sure about that, see Andy's follow up.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
