Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3086B1C84DA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 10:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgEGIar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 04:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725809AbgEGIaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 04:30:46 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6ED8C061A10
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 01:30:45 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jWbuw-0004Df-NG; Thu, 07 May 2020 10:30:06 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 91F24102652; Thu,  7 May 2020 10:30:05 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [patch V4 part 5 05/31] x86/entry: Switch XEN/PV hypercall entry to IDTENTRY
In-Reply-To: <5418e98e-b293-bff3-2c74-c7f932c09c55@oracle.com>
References: <20200505135341.730586321@linutronix.de> <20200505135828.592598658@linutronix.de> <5418e98e-b293-bff3-2c74-c7f932c09c55@oracle.com>
Date:   Thu, 07 May 2020 10:30:05 +0200
Message-ID: <874kssjgfm.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boris Ostrovsky <boris.ostrovsky@oracle.com> writes:
>> -	if (register_callback(CALLBACKTYPE_event, xen_hypervisor_callback) ||
>> +	if (register_callback(CALLBACKTYPE_event,
>> +			      asm_exc_xen_hypervisor_callback) ||
>
>
> This ...
>
>
>>  	    register_callback(CALLBACKTYPE_failsafe, xen_failsafe_callback))
>>  		BUG();
...
>> @@ -347,7 +348,7 @@ cpu_initialize_context(unsigned int cpu,
>>  	ctxt->gs_base_kernel = per_cpu_offset(cpu);
>>  #endif
>>  	ctxt->event_callback_eip    =
>> -		(unsigned long)xen_hypervisor_callback;
>> +		(unsigned long)asm_exc_xen_hypervisor_callback;
>
>
> ... and this should be xen_asm_exc_xen_hypervisor_callback (we need to
> pop %rcx and %r11).
>
>
> And then Xen PV guest boots.

Ooops. Thanks for tracking this down!

