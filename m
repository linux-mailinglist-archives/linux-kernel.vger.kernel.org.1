Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E12651C7385
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 17:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbgEFPDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 11:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbgEFPDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:03:51 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19061C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 08:03:51 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jWLZu-0005Ek-IM; Wed, 06 May 2020 17:03:18 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id CC1A81001F5; Wed,  6 May 2020 17:03:17 +0200 (CEST)
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
        Will Deacon <will@kernel.org>,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>
Subject: Re: [patch V4 part 1 03/36] sched: Clean up scheduler_ipi()
In-Reply-To: <f969427d-a151-2c69-a779-a2b602e39d9e@oracle.com>
References: <20200505131602.633487962@linutronix.de> <20200505134058.361859938@linutronix.de> <f969427d-a151-2c69-a779-a2b602e39d9e@oracle.com>
Date:   Wed, 06 May 2020 17:03:17 +0200
Message-ID: <874kstkswa.fsf@nanos.tec.linutronix.de>
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
> On 5/5/20 3:16 PM, Thomas Gleixner wrote:
>> @@ -10009,12 +10009,11 @@ static void kick_ilb(unsigned int flags)
>>   		return;
>>   
>>   	/*
>> -	 * Use smp_send_reschedule() instead of resched_cpu().
>> -	 * This way we generate a sched IPI on the target CPU which
>> +	 * This way we generate an IPI on the target CPU which
>>   	 * is idle. And the softirq performing nohz idle load balance
>>   	 * will be run before returning from the IPI.
>>   	 */
>> -	smp_send_reschedule(ilb_cpu);
>> +	smp_call_function_single_async(ilb_cpu, &cpu_rq(ilb_cpu)->wake_csd);
>
> This should be nohz_csd instead of wake_csd, no? I.e.:
>
>         smp_call_function_single_async(ilb_cpu, &cpu_rq(ilb_cpu)->nohz_csd);

Good catch!
