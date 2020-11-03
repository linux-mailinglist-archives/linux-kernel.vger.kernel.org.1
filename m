Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55D582A4F71
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 19:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbgKCSy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 13:54:28 -0500
Received: from gate.crashing.org ([63.228.1.57]:48218 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbgKCSy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 13:54:28 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 0A3IlenB030027;
        Tue, 3 Nov 2020 12:47:40 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 0A3Ildp9030025;
        Tue, 3 Nov 2020 12:47:39 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 3 Nov 2020 12:47:39 -0600
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
Message-ID: <20201103184739.GL2672@gate.crashing.org>
References: <20201019061803.13298-5-shuo.a.liu@intel.com> <20201102145657.GD15392@zn.tnic> <20201102160901.GU2672@gate.crashing.org> <20201102171950.GF15392@zn.tnic> <20201102181000.GX2672@gate.crashing.org> <20201102183430.GG15392@zn.tnic> <20201102200113.GY2672@gate.crashing.org> <20201102225439.GI15392@zn.tnic> <20201102231809.GC2672@gate.crashing.org> <20201103164435.GB4111@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103164435.GB4111@zn.tnic>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 05:44:35PM +0100, Borislav Petkov wrote:
> On Mon, Nov 02, 2020 at 05:18:09PM -0600, Segher Boessenkool wrote:
> > That is invalid actually: local register asm as input to an inline asm
> > should use *that* register!
> > 
> > This is all correct until LRA ("reload").  Not that "movl %xmm0,$eax"
> > works, but at least it screams its head off, as it should.
> 
> Screams how?

$ cat xmm1.s
        movl %xmm0,%eax

$ x86_64-linux-as xmm1.s -o xmm1.o
xmm1.s: Assembler messages:
xmm1.s:1: Error: unsupported instruction `mov'

(This isn't an existing insn IIUC.)

> It builds fine without a single peep with -Wall here.
> 
> Btw, that's a MOVD - not a MOVL. MOVD can do xmm -> gpr moves. And
> singlestepping it with gdb does, well, something, which is clearly
> wrong but nothing complains:
> 
> => 0x555555555131 <main+12>:    movd   %xmm0,%eax
> 
> and %xmm0 has:
> 
> (gdb) p $xmm0
> $2 = {v4_float = {0.99000001, 0, 0, 0}, v2_double = {5.2627153433055495e-315, 0}, v16_int8 = {-92, 112, 125, 63, 
> 		  ^^^^^^^^^^
> 
> so that is correct.

The original code had movl.  And movl is needed for GPRs.

> and that same value goes into %r8d:
> 
> mov    %eax,%r8d

Which violates what is required by register asm :-(

> > Yes.  But GCC doing what you should have said instead of doing what you
> > said, is not good.
> 
> Oh well, should I open a low prio bug, would that help?

Sure, thanks!

> I probably should test with the latest gcc first, though...

Yeah...  FWIW, I tested with
x86_64-linux-gcc (GCC) 11.0.0 20201015 (experimental)
so I doubt current ToT will have it fixed, but who knows.

Thanks,


Segher
