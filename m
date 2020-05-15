Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B22B61D501D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 16:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgEOOMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 10:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726144AbgEOOME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 10:12:04 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B2CC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 07:12:04 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jZb3P-0001eg-Nd; Fri, 15 May 2020 16:11:12 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 96BF2100606; Fri, 15 May 2020 16:11:10 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
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
        Will Deacon <will@kernel.org>
Subject: Re: [patch V4 part 3 29/29] x86/entry/32: Convert IRET exception to IDTENTRY_SW
In-Reply-To: <CALCETrXNt4A8Gp-24Awgg+PFL2qwa20JKhFiYWbbnV1RefST4Q@mail.gmail.com>
Date:   Fri, 15 May 2020 16:11:10 +0200
Message-ID: <87imgxe1a9.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@kernel.org> writes:

> On Tue, May 5, 2020 at 7:15 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> From: Thomas Gleixner <tglx@linutronix.de>
>>
>> Convert the IRET exception handler to IDTENTRY_SW. This is slightly
>> different than the conversions of hardware exceptions as the IRET exception
>> is invoked via an exception table when IRET faults. So it just uses the
>> IDTENTRY_SW mechanism for consistency. It does not emit ASM code as it does
>> not fit the other idtentry exceptions.
>
> Blech.  I should redo the 32-bit code to handle this the way the
> 64-bit code does and this can all be deleted.  But, for now:
>
> Acked-by: Andy Lutomirski <luto@kernel.org>
>
> However, maybe rename asm_exc_iret_error to avoid confusion?  It's not
> really an exception entry.

True. Removed the 'exc_' from all instances.
