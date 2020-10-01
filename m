Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D6427F68F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 02:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731690AbgJAAQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 20:16:04 -0400
Received: from gate.crashing.org ([63.228.1.57]:48298 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729980AbgJAAQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 20:16:03 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 09108Yfg011750;
        Wed, 30 Sep 2020 19:08:34 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 09108XYC011749;
        Wed, 30 Sep 2020 19:08:33 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 30 Sep 2020 19:08:32 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        shuo.a.liu@intel.com, LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Yakui Zhao <yakui.zhao@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fengwei Yin <fengwei.yin@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH v4 04/17] x86/acrn: Introduce hypercall interfaces
Message-ID: <20201001000832.GE28786@gate.crashing.org>
References: <20200922114311.38804-1-shuo.a.liu@intel.com> <20200922114311.38804-5-shuo.a.liu@intel.com> <20200927105152.GG88650@kroah.com> <6f9a2b83-6904-2290-6c4f-526672390beb@intel.com> <20200930111612.GZ2628@hirez.programming.kicks-ass.net> <20200930161036.GY28786@gate.crashing.org> <20200930171346.GC2628@hirez.programming.kicks-ass.net> <CAKwvOdnpU=w4uStcP+UUr9wfoE5U-hW0cMt1bizcX4zQ4=-gOg@mail.gmail.com> <20200930195915.GA3180913@rani.riverdale.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930195915.GA3180913@rani.riverdale.lan>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 03:59:15PM -0400, Arvind Sankar wrote:
> On Wed, Sep 30, 2020 at 12:14:03PM -0700, Nick Desaulniers wrote:
> > On Wed, Sep 30, 2020 at 10:13 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Wed, Sep 30, 2020 at 11:10:36AM -0500, Segher Boessenkool wrote:
> > >
> > > > Since this variable is a local register asm, on entry to the asm the
> > > > compiler guarantees that the value lives in the assigned register (the
> > > > "r8" hardware register in this case).  This all works completely fine.
> > > > This is the only guaranteed behaviour for local register asm (well,
> > > > together with analogous behaviour for outputs).
> 
> How strict is the guarantee? This is an inline function -- could the
> compiler decide to reorder some other code in between the r8 assignment
> and the asm statement when it gets inlined?

Nope.  It will be in r8 on entry to the asm.  A guarantee is a
guarantee; it is not a "yeah maybe, we'll see".

> > Do we need register local storage here?
> > 
> > static inline long bar(unsigned long hcall_id)
> > {
> >   long result;
> >   asm volatile("movl %1, %%r8d\n\t"
> >   "vmcall\n\t"
> >     : "=a" (result)
> >     : "ir" (hcall_id)
> >     : );
> >   return result;
> > }
> 
> This seems more robust, though you probably need an r8 clobber in there?

Oh, x86 has the operand order inverted, so this should work in fact.


Segher
