Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 216ED1B72F1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 13:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgDXLVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 07:21:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:57458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbgDXLVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 07:21:22 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BA5F206D4;
        Fri, 24 Apr 2020 11:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587727281;
        bh=9j66fxXI2jcsWYFYcG/USAvpeLheI4USds77+Y4mP1c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y/dWUU1q4sC+WdKi/8sEc/Rgu2id2EVdo9H7mjZK1I7FNZDUkWmXdv7bwDYDS3ilK
         gyXfL6Zt+o29RLdzyk2xUpxQ67SHoiceUd1MKcOwgXYYwgp2jZIhj3PzN1/zM9abnU
         JSv0jddj1P9Xq7tPBDOLvHb6Pwq+4+ySiruoNKYs=
Date:   Fri, 24 Apr 2020 12:21:14 +0100
From:   Will Deacon <will@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 01/12] add support for Clang's Shadow Call Stack (SCS)
Message-ID: <20200424112113.GC21141@willie-the-truck>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20200416161245.148813-1-samitolvanen@google.com>
 <20200416161245.148813-2-samitolvanen@google.com>
 <20200420171727.GB24386@willie-the-truck>
 <20200420211830.GA5081@google.com>
 <20200422173938.GA3069@willie-the-truck>
 <20200422235134.GA211149@google.com>
 <202004231121.A13FDA100@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202004231121.A13FDA100@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 11:28:40AM -0700, Kees Cook wrote:
> On Wed, Apr 22, 2020 at 04:51:34PM -0700, Sami Tolvanen wrote:
> > On Wed, Apr 22, 2020 at 06:39:47PM +0100, Will Deacon wrote:
> > > On Mon, Apr 20, 2020 at 02:18:30PM -0700, Sami Tolvanen wrote:
> > > > On Mon, Apr 20, 2020 at 06:17:28PM +0100, Will Deacon wrote:
> > > > > > +	 * The shadow call stack is aligned to SCS_SIZE, and grows
> > > > > > +	 * upwards, so we can mask out the low bits to extract the base
> > > > > > +	 * when the task is not running.
> > > > > > +	 */
> > > > > > +	return (void *)((unsigned long)task_scs(tsk) & ~(SCS_SIZE - 1));
> > > > > 
> > > > > Could we avoid forcing this alignment it we stored the SCS pointer as a
> > > > > (base,offset) pair instead? That might be friendlier on the allocations
> > > > > later on.
> > > > 
> > > > The idea is to avoid storing the current task's shadow stack address in
> > > > memory, which is why I would rather not store the base address either.
> > > 
> > > What I mean is that, instead of storing the current shadow stack pointer,
> > > we instead store a base and an offset. We can still clear the base, as you
> > > do with the pointer today, and I don't see that the offset is useful to
> > > an attacker on its own.
> > 
> > I see what you mean. However, even if we store the base address +
> > the offset, we still need aligned allocation if we want to clear
> > the address. This would basically just move __scs_base() logic to
> > cpu_switch_to() / scs_save().
> 
> Okay, so, I feel like this has gotten off into the weeds, or I'm really
> dense (or both). :) Going back to the original comment:
> 
> > > > > Could we avoid forcing this alignment it we stored the SCS
> > > > > pointer as a (base,offset) pair instead? That might be friendlier
> > > > > on the allocations later on.
> 
> I think there was some confusion about mixing the "we want to be able to
> wipe the value" combined with the masking in __scs_base(). These are
> unrelated, as was correctly observed with "We can still clear the base".

Having just tried to implement this, it turns out they *are* related
and we can't still clear the base, I was wrong about that :( See below.

> What I don't understand here is the suggestion to store two values:
> 
> Why is two better than storing one? With one, we only need a single access.
> 
> Why would storing the base be "friendlier on the allocations later on"?
> This is coming out of a single kmem cache, in 1K chunks. They will be
> naturally aligned to 1K (unless redzoing has been turned on for some
> slab debugging reason). The base masking is a way to avoid needing to
> store two values, and only happens at task death.

Fair enough about the kmem_cache, although I'm still worried about these
things getting bigger in future and the alignment having to increase at
the same time. We also have a bunch of static/percpu allocations that don't
use this cache.

Also, since you mentioned the lack of redzoning, isn't it a bit dodgy
allocating blindly out of the kmem_cache? It means we don't have a redzone
or a guard page, so if you can trigger something like a recursion bug then
could you scribble past the SCS before the main stack overflows? Would this
clobber somebody else's SCS? The vmap version that I asked Sami to drop
is at least better in this regard, although the guard page is at the wrong
end of the stack and we just hope that the allocation below us didn't pass
VM_NO_GUARD. Looks like the same story for vmap stack :/

> Storing two values eats memory for all tasks for seemingly no meaningful
> common benefit. What am I missing here?

I would like to remove the alignment requirements for the static and percpu
allocations. AFAICT, the only reason the alignment is needed is because you
want to convert an SCS pointer into the base pointer. The only reason *that*
is needed is because of the questionable wiping of the pointer in the
thread_info, but I really don't see the benefit of this. Unlike a crypto
secret (which was your analogy), the SCS pointer is stored in memory in
at least the following situations:

  * The task isn't running
  * The task is running in userspace
  * The task is running a vCPU in KVM
  * We're calling into EFI
  * On exception entry from EL1, as part of stacking x18
  * During CPU suspend

If we split the pointer in two (base, offset) then we could leave the
base live in the thread_info, not require alignment of the stacks (which
may allow for unconditional redzoning?) and then just update the offset
value on context switch, which could be trivially checked as part of the
existing stack overflow checking on kernel entry.

The base and offset can live in the same cacheline and be loaded with ldp,
so I don't see there being an access cost compared to a single variable.

Am I missing something (modulo us not agreeing on the utility of wiping
the pointer)?

Will
