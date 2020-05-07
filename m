Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C761C8DFC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 16:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgEGOK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 10:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbgEGOKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 10:10:54 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C459C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 07:10:54 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jWhEC-0002Nn-3H; Thu, 07 May 2020 16:10:20 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 566BB102652; Thu,  7 May 2020 16:10:19 +0200 (CEST)
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
Subject: Re: [patch V4 part 2 05/18] x86/entry: Move irq tracing on syscall entry to C-code
In-Reply-To: <207acd23-4acb-3fd1-7c92-9f48c79fa059@oracle.com>
References: <20200505134112.272268764@linutronix.de> <20200505134340.611961721@linutronix.de> <207acd23-4acb-3fd1-7c92-9f48c79fa059@oracle.com>
Date:   Thu, 07 May 2020 16:10:19 +0200
Message-ID: <87sggbj0ok.fsf@nanos.tec.linutronix.de>
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
> On 5/5/20 3:41 PM, Thomas Gleixner wrote:
>> -	/*
>> -	 * User mode is traced as though IRQs are on, and the interrupt
>> -	 * gate turned them off.
>> -	 */
>> -	TRACE_IRQS_OFF
>> -
>>   	movq	%rsp, %rdi
>>   	call	do_int80_syscall_32
>>   .Lsyscall_32_done:
>> 
>
> enter_from_user_mode() is also called with the CALL_enter_from_user_mode macro,
> which is used in interrupt_entry() and identry. Don't you need to also remove
> the TRACE_IRQS_OFF there now?

Hrm. right. OTOH, it's just redundant and should be no harm, but let me have a
look at that again.

Thanks,

        tglx
