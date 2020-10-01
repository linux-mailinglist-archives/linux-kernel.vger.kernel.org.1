Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0880127F693
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 02:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731790AbgJAARl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 20:17:41 -0400
Received: from gate.crashing.org ([63.228.1.57]:48309 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729980AbgJAARl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 20:17:41 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 0910BNYp011876;
        Wed, 30 Sep 2020 19:11:24 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 0910BNmv011875;
        Wed, 30 Sep 2020 19:11:23 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 30 Sep 2020 19:11:22 -0500
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
Message-ID: <20201001001122.GF28786@gate.crashing.org>
References: <20200922114311.38804-1-shuo.a.liu@intel.com> <20200922114311.38804-5-shuo.a.liu@intel.com> <20200927105152.GG88650@kroah.com> <6f9a2b83-6904-2290-6c4f-526672390beb@intel.com> <20200930111612.GZ2628@hirez.programming.kicks-ass.net> <20200930161036.GY28786@gate.crashing.org> <20200930171346.GC2628@hirez.programming.kicks-ass.net> <CAKwvOdnpU=w4uStcP+UUr9wfoE5U-hW0cMt1bizcX4zQ4=-gOg@mail.gmail.com> <20200930232559.GC28786@gate.crashing.org> <20200930233815.GA3372783@rani.riverdale.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930233815.GA3372783@rani.riverdale.lan>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 07:38:15PM -0400, Arvind Sankar wrote:
> On Wed, Sep 30, 2020 at 06:25:59PM -0500, Segher Boessenkool wrote:
> > On Wed, Sep 30, 2020 at 12:14:03PM -0700, Nick Desaulniers wrote:
> > > Do we need register local storage here?
> > 
> > Depends what you want.  It looks like you do:
> > 
> > > static inline long bar(unsigned long hcall_id)
> > > {
> > >   long result;
> > >   asm volatile("movl %1, %%r8d\n\t"
> > >   "vmcall\n\t"
> > >     : "=a" (result)
> > >     : "ir" (hcall_id)
> > >     : );
> > >   return result;
> > > }
> > 
> > "result" as output from the asm is in %rax, and the compiler will
> > shuffle that to wherever it needs it as the function return value.  That
> > part will work fine.
> > 
> > But how you are accessing %r8d is not correct, that needs to be a local
> > register asm (or r8 be made a fixed reg, probably not what you want ;-) )
> 
> Doesn't it just need an "r8" clobber to allow using r8d?

Yes, x86 asm is hard to read, what can I say :-)  Sorry about that.


Segher
