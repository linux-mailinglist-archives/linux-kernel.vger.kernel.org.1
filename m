Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68B692A3721
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 00:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbgKBXYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 18:24:43 -0500
Received: from gate.crashing.org ([63.228.1.57]:45052 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727122AbgKBXYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 18:24:42 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 0A2NICji019700;
        Mon, 2 Nov 2020 17:18:12 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 0A2NI9MI019691;
        Mon, 2 Nov 2020 17:18:09 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 2 Nov 2020 17:18:09 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     shuo.a.liu@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Yakui Zhao <yakui.zhao@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fengwei Yin <fengwei.yin@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v5 04/17] x86/acrn: Introduce hypercall interfaces
Message-ID: <20201102231809.GC2672@gate.crashing.org>
References: <20201019061803.13298-1-shuo.a.liu@intel.com> <20201019061803.13298-5-shuo.a.liu@intel.com> <20201102145657.GD15392@zn.tnic> <20201102160901.GU2672@gate.crashing.org> <20201102171950.GF15392@zn.tnic> <20201102181000.GX2672@gate.crashing.org> <20201102183430.GG15392@zn.tnic> <20201102200113.GY2672@gate.crashing.org> <20201102225439.GI15392@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102225439.GI15392@zn.tnic>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 11:54:39PM +0100, Borislav Petkov wrote:
> On Mon, Nov 02, 2020 at 02:01:13PM -0600, Segher Boessenkool wrote:
> > It just asks the general_operand function, which (for registers) accepts
> > the hard registers that are accessible.  This does include the float and
> > vector etc. registers, normally.
> > 
> > But you usually have a pseudo-register there (which is always allowed
> > here), unless you used some register asm variable.
> 
> You mean like this:
> 
> ---
> int main(void)
> {
> 	register float foo asm ("xmm0") = 0.99f;
> 
>         asm volatile("movl %0, %%r8d\n\t"
>                       "vmcall\n\t"
>                       :: "g" (foo));
> 
>         return 0;
> }
> ---
> 
> That works ok AFAICT:
> 
> ---
> 
> 0000000000000000 <main>:
>    0:   55                      push   %rbp
>    1:   48 89 e5                mov    %rsp,%rbp
>    4:   f3 0f 10 05 00 00 00    movss  0x0(%rip),%xmm0        # c <main+0xc>
>    b:   00 
>    c:   66 0f 7e c0             movd   %xmm0,%eax
>   10:   41 89 c0                mov    %eax,%r8d
>   13:   0f 01 c1                vmcall 
>   16:   b8 00 00 00 00          mov    $0x0,%eax
>   1b:   5d                      pop    %rbp
>   1c:   c3                      retq
> 
> ---

That is invalid actually: local register asm as input to an inline asm
should use *that* register!

This is all correct until LRA ("reload").  Not that "movl %xmm0,$eax"
works, but at least it screams its head off, as it should.  And then LRA
puts it in %eax, a different register than asked for.

> gcc smartypants shuffles it through a GPR before sticking it into %r8.
> 
> It works too If I use a float immediate:
> 
> ---
> int main(void)
> {
>         asm volatile("movl %0, %%r8d\n\t"
>                       "vmcall\n\t"
>                       :: "g" (0.99f));
>                       
>         return 0;     
> }
> ---
> 
> ---
> 0000000000000000 <main>:
>    0:   55                      push   %rbp
>    1:   48 89 e5                mov    %rsp,%rbp
>    4:   41 b8 a4 70 7d 3f       mov    $0x3f7d70a4,%r8d
>    a:   0f 01 c1                vmcall 
>    d:   b8 00 00 00 00          mov    $0x0,%eax
>   12:   5d                      pop    %rbp
>   13:   c3                      retq
> ---

(this one is correct code)

> or maybe I'm missing some freaky way to specify the input operand so
> that I can make it take a float register. But even if I could, it would
> error out when generating the asm, I presume, due to invalid insn or
> whatnot.

Yes.  But GCC doing what you should have said instead of doing what you
said, is not good.

> > And pseudos usually are allocated a simple integer register during
> > register allocation, in an asm that is.
> 
> Interesting.
> 
> > > Might even make people copying from bad examples
> > > to go look at the docs first...
> > 
> > Optimism is cool :-)
> 
> In my experience so far, documenting stuff better might not always bring
> the expected results but sometimes it does move people in the most
> unexpected way and miracles happen.
> 
> :-)))

Now if only we had time to document what we wrote!  We *do* write docs
to go with new code (maybe not enough always), but no one spends a lot
of time on documenting the existing compiler, or with a larger view than
just a single aspect of the compiler.  Alas.


Segher
