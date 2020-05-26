Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11CF81D5341
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 17:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgEOPJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 11:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726219AbgEOPJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 11:09:28 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8A8C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 08:09:28 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jZbxK-00036p-JR; Fri, 15 May 2020 17:08:58 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id F03C1100606; Fri, 15 May 2020 17:08:56 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
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
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>
Subject: Re: [patch V5 04/38] x86: Make hardware latency tracing explicit
In-Reply-To: <20200514214349.24642172@oasis.local.home>
References: <20200512210059.056244513@linutronix.de> <20200512213809.784331304@linutronix.de> <20200514214349.24642172@oasis.local.home>
Date:   Fri, 15 May 2020 17:08:56 +0200
Message-ID: <87a729dylz.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> writes:

> On Tue, 12 May 2020 23:01:03 +0200
> Thomas Gleixner <tglx@linutronix.de> wrote:
>
>> --- a/arch/x86/kernel/cpu/mce/core.c
>> +++ b/arch/x86/kernel/cpu/mce/core.c
>> @@ -1916,7 +1916,7 @@ static __always_inline void exc_machine_
>>  	    mce_check_crashing_cpu())
>>  		return;
>>  
>> -	nmi_enter();
>> +	nmi_enter_notrace();
>
> Now a machine check exception could happen and be a cause of latency
> (although there may be more issues if it does). The "nmi_enter trace"
> version does two things. One is for time measurements (if available),
> and the other is just letting the hardware latency know it happen (a
> simple increment).
>
> The only thing that is checked is "smp_processor_id()" (I just
> remembered it doesn't need per cpu, as it only runs on a single CPU at
> a time).
>
> Could the notrace version supply the increment, and leave the
> trace_clock() in the trace version?

Yes, I can split it up that way.
