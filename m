Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E405327EEBE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 18:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730851AbgI3QR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 12:17:27 -0400
Received: from gate.crashing.org ([63.228.1.57]:33318 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbgI3QR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 12:17:27 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 08UGAeCG020072;
        Wed, 30 Sep 2020 11:10:40 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 08UGAaFE020059;
        Wed, 30 Sep 2020 11:10:36 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 30 Sep 2020 11:10:36 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        shuo.a.liu@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
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
        Zhenyu Wang <zhenyuw@linux.intel.com>, ndesaulniers@google.com
Subject: Re: [PATCH v4 04/17] x86/acrn: Introduce hypercall interfaces
Message-ID: <20200930161036.GY28786@gate.crashing.org>
References: <20200922114311.38804-1-shuo.a.liu@intel.com> <20200922114311.38804-5-shuo.a.liu@intel.com> <20200927105152.GG88650@kroah.com> <6f9a2b83-6904-2290-6c4f-526672390beb@intel.com> <20200930111612.GZ2628@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930111612.GZ2628@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Wed, Sep 30, 2020 at 01:16:12PM +0200, Peter Zijlstra wrote:
> On Sun, Sep 27, 2020 at 08:38:03AM -0700, Dave Hansen wrote:
> > On 9/27/20 3:51 AM, Greg Kroah-Hartman wrote:
> > >> +static inline long acrn_hypercall0(unsigned long hcall_id)
> > >> +{
> > >> +	register long r8 asm("r8");
> > >> +	long result;
> > >> +
> > >> +	/* Nothing can come between the r8 assignment and the asm: */
> > >> +	r8 = hcall_id;
> > >> +	asm volatile("vmcall\n\t"
> > >> +		     : "=a" (result)
> > >> +		     : "r" (r8)
> > >> +		     : );
> > > What keeps an interrupt from happening between the r8 assignment and the
> > > asm: ?
> > 
> > It's probably better phrased something like: "No other C code can come
> > between this r8 assignment and the inline asm".  An interrupt would
> > actually be fine in there because interrupts save and restore all
> > register state, including r8.
> > 
> > The problem (mentioned in the changelog) is that gcc does not let you
> > place data directly into r8.  But, it does allow you to declare a
> > register variable that you can assign to use r8.  There might be a
> > problem if a function calls was in between and clobber the register,
> > thus the "nothing can come between" comment.
> > 
> > The comment is really intended to scare away anyone from adding printk()'s.
> > 
> > More information about these register variables is here:
> > 
> > > https://gcc.gnu.org/onlinedocs/gcc/Local-Register-Variables.html#Local-Register-Variables
> > 
> > Any better ideas for comments would be greatly appreciated.  It has 4 or
> > 5 copies so I wanted it to be succinct.
> 
> This is disguisting.. Segher, does this actually work? Nick, does clang
> also support this?

The C variable "r8" is just a variable like any other; it can live in
memory, or in any register, and different in all places, too.  It can be
moved around too; where "the assignment to it" happens is a
philosophical question more than anything (the assignment there  can be
optimised away completely, for example; it is just a C variable, there
is no magic).

Since this variable is a local register asm, on entry to the asm the
compiler guarantees that the value lives in the assigned register (the
"r8" hardware register in this case).  This all works completely fine.
This is the only guaranteed behaviour for local register asm (well,
together with analogous behaviour for outputs).

If you want to *always* have it live in the hardware reg "r8", you have
to use a global register asm, and almost certainly do that for all
translation units, and use -ffixed-r8 as well.  This of course is
extremely costly.


Segher
