Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2180F1CD906
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 13:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbgEKLy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 07:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726068AbgEKLy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:54:56 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9866FC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 04:54:56 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jY70w-0004ZX-Cc; Mon, 11 May 2020 13:54:30 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id AB288FFBF8; Mon, 11 May 2020 13:54:29 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
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
Subject: Re: [patch V4 part 5 02/31] x86/entry: Provide helpers for execute on irqstack
In-Reply-To: <7477e59e-50d9-3446-dce7-3aa07e74cf5f@oracle.com>
References: <20200505135341.730586321@linutronix.de> <20200505135828.316937774@linutronix.de> <7477e59e-50d9-3446-dce7-3aa07e74cf5f@oracle.com>
Date:   Mon, 11 May 2020 13:54:29 +0200
Message-ID: <871rnq7klm.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexandre Chartre <alexandre.chartre@oracle.com> writes:
> On 5/5/20 3:53 PM, Thomas Gleixner wrote:
>> +	__this_cpu_add(irq_count, 1);					\
>> +	asm volatile(							\
>> +		"pushq  %%rbp					\n"	\
>> +		"movq   %%rsp, %%rbp				\n"	\
>> +		"movq	%%rsp, (%[ts])				\n"	\
>> +		"movq	%[ts], %%rsp				\n"	\
>> +		"1:						\n"	\
>> +		"	.pushsection .discard.instr_begin	\n"	\
>> +		"	.long 1b - .				\n"	\
>> +		"	.popsection				\n"	\
>> +		"call	" __ASM_FORM(func) "			\n"	\
>> +		"2:						\n"	\
>> +		"	.pushsection .discard.instr_end		\n"	\
>> +		"	.long 2b - .				\n"	\
>> +		"	.popsection				\n"	\
>> +		"popq	%%rsp					\n"	\
>> +		"leaveq						\n"	\
>> +		:							\
>> +		: [ts] "r" (tos)					\
>> +		: "memory"						\
>> +		);							\
>> +	__this_cpu_sub(irq_count, 1);					\
>> +}
>
> The pushsection/popsection discard.instr_begin/end sequences are used several
> times in asm() statement at different places, so I wonder if it might be worth
> having a macro.

As discussed elsewhere this is going to move to ASM partially and the
various variants are not longer necessary.

Thanks,

        tglx
