Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0AA41D48D9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 10:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgEOIxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 04:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727116AbgEOIxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 04:53:01 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A864C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 01:53:01 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jZW4l-0002zr-RB; Fri, 15 May 2020 10:52:16 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 19CA8100606; Fri, 15 May 2020 10:52:15 +0200 (CEST)
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
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>
Subject: Re: [patch V5 24/38] x86/entry: Provide IDTENTRY_SYSVEC
In-Reply-To: <78bf7499-b810-4e71-46c0-3d86f6c6d3d7@oracle.com>
References: <20200512210059.056244513@linutronix.de> <20200512213811.844041484@linutronix.de> <78bf7499-b810-4e71-46c0-3d86f6c6d3d7@oracle.com>
Date:   Fri, 15 May 2020 10:52:15 +0200
Message-ID: <87a729y400.fsf@nanos.tec.linutronix.de>
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

> On 5/12/20 5:01 PM, Thomas Gleixner wrote:
>> +
>> +/**
>> + * DEFINE_IDTENTRY_SYSVEC - Emit code for system vector IDT entry points
>> + * @func:	Function name of the entry point
>> + *
>> + * idtentry_enter/exit() and irq_enter/exit_rcu() are invoked before the
>> + * function body. KVM L1D flush request is set.
>
>
> This is used for entry points for Xen and hyperV as well. Even though
> it's harmless at the moment, do we still want to set this flag for non-KVM?

Right, it's pointless for !KVM, but we have set this unconditionally
since the l1tf mess was introduced. I'm not sure whether it's worth to
optimize the single store out.

Thanks,

        tglx
