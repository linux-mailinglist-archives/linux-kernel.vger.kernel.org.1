Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1712A34E3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 21:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgKBUI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 15:08:28 -0500
Received: from gate.crashing.org ([63.228.1.57]:51576 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727051AbgKBUHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 15:07:39 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 0A2K1FvU009280;
        Mon, 2 Nov 2020 14:01:15 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 0A2K1DjO009277;
        Mon, 2 Nov 2020 14:01:13 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 2 Nov 2020 14:01:13 -0600
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
Message-ID: <20201102200113.GY2672@gate.crashing.org>
References: <20201019061803.13298-1-shuo.a.liu@intel.com> <20201019061803.13298-5-shuo.a.liu@intel.com> <20201102145657.GD15392@zn.tnic> <20201102160901.GU2672@gate.crashing.org> <20201102171950.GF15392@zn.tnic> <20201102181000.GX2672@gate.crashing.org> <20201102183430.GG15392@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102183430.GG15392@zn.tnic>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 07:34:30PM +0100, Borislav Petkov wrote:
> On Mon, Nov 02, 2020 at 12:10:00PM -0600, Segher Boessenkool wrote:
> > (It does not allow *all* memory and *all* constants, btw...  And the
> > condition for registers is not really "general register", whatever that
> > means...
> 
> I think that means general purpose registers. I.e., it won't use, say
> FPU, XMM or whatever special regs.
> 
> What does the asm() parsing code in gcc do for "g"? There should be
> some logic which constraints what register is valid...

It just asks the general_operand function, which (for registers) accepts
the hard registers that are accessible.  This does include the float and
vector etc. registers, normally.

But you usually have a pseudo-register there (which is always allowed
here), unless you used some register asm variable.  And pseudos usually
are allocated a simple integer register during register allocation, in
an asm that is.

> > I hope no one ever told you our documentation does not have white
> > lies!)
> 
> I have convinced myself of this a couple of times already so I either go
> ask our gcc friends or go look straight at gcc source. It is useful to
> know folks which hack on it so that I can ask them stupid questions and
> not go off into the weeds, trying to figure out what the documentation
> says.
> 
> But hey, if that gets the documentation improved, that's a win-win
> situation right there.

Yes :-)

> Might even make people copying from bad examples
> to go look at the docs first...

Optimism is cool :-)


Segher
