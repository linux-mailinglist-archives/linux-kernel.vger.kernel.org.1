Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35F62AF93A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 20:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbgKKTmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 14:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbgKKTmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 14:42:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEE9C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 11:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=aZgebiza2g9kndB893/KQodwkXDqhS3Yr8KEC5RKrRA=; b=b+Qtlfml7qVSGZy+ZM2pg4ZJvj
        x1+iJjcWwL8lerU4NoA9VDwYJIqmbYDqrc6FcUtnGfYlWLLZHsUeUPViPEjP3P5fgVVUA/UGull9y
        4SBVrmhX5X3WevUaSsb5Q2H0XCJ+jgRLIxtLGtTsWQrC2/oCRcQJLvSCCjv7sSk3qdQsVt69PA+4S
        eAGwXfWbJWP8knV5TVdEeGywdzR/ICUWlNf4NTWrKGedV3yDIY9qjyNz1Zp4wjEwi1fEOGzBbcNEs
        /Lv923oJih2V/kUsxe42tcwQuo/yMwRJTHJg3UO1PkJuz3v/qNww3kmlsUArd/gUB+RjEQV9Z05o0
        6Re9b8YA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcw0O-0004fm-2p; Wed, 11 Nov 2020 19:42:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1A4C9301E02;
        Wed, 11 Nov 2020 20:42:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0D1D82BCE933F; Wed, 11 Nov 2020 20:42:07 +0100 (CET)
Date:   Wed, 11 Nov 2020 20:42:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>, jgross@suse.com,
        x86@kernel.org
Subject: Re: WARNING: can't access registers at asm_common_interrupt
Message-ID: <20201111194206.GK2628@hirez.programming.kicks-ass.net>
References: <20201106060414.edtcb7nrbzm4a32t@shindev.dhcp.fujisawa.hgst.com>
 <20201111170536.arx2zbn4ngvjoov7@treble>
 <20201111174736.GH2628@hirez.programming.kicks-ass.net>
 <20201111181328.mbxcz2uap2vnqpxq@treble>
 <33843b7f-ed8a-8fcb-19bc-c76cf00f453d@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33843b7f-ed8a-8fcb-19bc-c76cf00f453d@citrix.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 06:46:37PM +0000, Andrew Cooper wrote:

> Well...
> 
> static_calls are a newer, and more generic, form of pvops.  Most of the
> magic is to do with inlining small fragments, but static calls can do
> that now too, IIRC?

If you're referring to this glorious hack:

  https://lkml.kernel.org/r/20201110101307.GO2651@hirez.programming.kicks-ass.net

that only 'works' because it's a single instruction. That is,
static_call can only poke single instructions. They cannot replace a
call with "PUSHF; POP" / "PUSH; POPF" for example. They also cannot do
NOP padding for 'short' sequences.

Paravirt, like alternatives, are special in that they only happen once,
before SMP bringup.

> >> Something really disguisting we could do is recognise the indirect call
> >> offset and emit an extra ORC entry for RIP+1. So the cases are:
> >>
> >> 	CALL *pv_ops.save_fl	-- 7 bytes IIRC
> >> 	CALL $imm;		-- 5 bytes
> >> 	PUSHF; POP %[RE]AX	-- 2 bytes
> >>
> >> so the RIP+1 (the POP insn) will only ever exist in this case. The
> >> indirect and direct call cases would never land on that IP.
> > I had a similar idea, and a bit of deja vu - we may have talked about
> > this before.  At least I know we talked about doing something similar
> > for alternatives which muck with the stack.

Vague memories... luckily we managed to get alternatives to a state
where they match, which is much saner.

> The main complexity with pvops is that the
> 
>     CALL *pv_ops.save_fl
> 
> form needs to be usable from extremely early in the day (pre general
> patching), hence the use of function pointers and some non-standard ABIs.

The performance rasins mentioned below are a large part of the
non-standard ABI (eg CALLEE_SAVE)

> For performance reasons, the end result of this pvop wants to be `pushf;
> pop %[re]ax` in then native case, and `call xen_pv_save_fl` in the Xen
> case, but this doesn't mean that the compiled instruction needs to be a
> function pointer to begin with.

Not sure emitting the native code would be feasible.. also
cpu_usergs_sysret64 is 6 bytes.

> Would objtool have an easier time coping if this were implemented in
> terms of a static call?

I doubt it, the big problem is that there is no visibility into the
actual alternative text. Runtime patching fragments into static call
would have the exact same problem.

Something that _might_ maybe work is trying to morph the immediate
fragments into an alternative. That is, instead of this:

static inline notrace unsigned long arch_local_save_flags(void)
{
	return PVOP_CALLEE0(unsigned long, irq.save_fl);
}

Write it something like:

static inline notrace unsigned long arch_local_save_flags(void)
{
	PVOP_CALL_ARGS;
	PVOP_TEST_NULL(irq.save_fl);
	asm_inline volatile(ALTERNATIVE(paravirt_alt(PARAVIRT_CALL),
					"PUSHF; POP _ASM_AX",
					X86_FEATURE_NATIVE)
			    : CLBR_RET_REG, ASM_CALL_CONSTRAINT
			    : paravirt_type(irq.save_fl.func),
			      paravirt_clobber(PVOP_CALLEE_CLOBBERS)
			    : "memory", "cc");
	return __eax;
}

And then we have to teach objtool how to deal with conflicting
alternatives...

That would remove most (all, if we can figure out a form that deals with
the spinlock fragments) of paravirt_patch.c

Hmm?
