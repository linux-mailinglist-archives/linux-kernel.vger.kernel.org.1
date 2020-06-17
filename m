Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9721FD8F1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 00:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgFQWgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 18:36:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbgFQWgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 18:36:31 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A21020810;
        Wed, 17 Jun 2020 22:36:30 +0000 (UTC)
Date:   Wed, 17 Jun 2020 18:36:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jann Horn <jannh@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Oscar Carter <oscar.carter@gmx.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] tracing: Use linker magic instead of recasting
 ftrace_ops_list_func()
Message-ID: <20200617183628.3594271d@oasis.local.home>
In-Reply-To: <CAG48ez2pOns4vF9M_4ubMJ+p9YFY29udMaH0wm8UuCwGQ4ZZAQ@mail.gmail.com>
References: <20200617165616.52241bde@oasis.local.home>
        <CAG48ez2pOns4vF9M_4ubMJ+p9YFY29udMaH0wm8UuCwGQ4ZZAQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jun 2020 23:30:07 +0200
Jann Horn <jannh@google.com> wrote:
> [...]
> > +/* Defined by vmlinux.lds.h see the commment above arch_ftrace_ops_list_func for details */
> > +void ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
> > +                         struct ftrace_ops *op, struct pt_regs *regs);  
> [...]
> > +void arch_ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip)
> >  {  
> 
> Well, it's not like the function cast itself is the part that's
> problematic for CFI; the problematic part is when you actually make a
> C function call (in particular an indirect one) where the destination
> is compiled with a prototype that is different from the prototype used
> at the call site. Doing this linker hackery isn't really any better
> than shutting up the compiler warning by piling on enough casts or
> whatever. (There should be some combination of casts that'll shut up
> this warning, right?)

It's not called by C, it's called by assembly.

> 
> IIUC the real issue here is that ftrace_func_t is defined as a fixed
> type, but actually has different types depending on the architecture?
> If so, it might be cleaner to define ftrace_func_t differently
> depending on architecture, or something like that?

There's functions that use this type.

When you register a function to be used by the function tracer (that
will have 4 parameters). If the arch supports it, it will call it
directly from the trampoline in assembly, but if it does not, then the
C code will only let assembly call the two parameter version, that will
call the 4 parameter function (adding NULLs to the extra two arguments). 

> 
> And if that's not feasible, I think it would be better to at least
> replace this linker trickery with straightforward
> shut-up-the-compiler-casts - it'd be much easier to understand what's
> actually going on that way.

OK, what's the way to shut up the compiler for it, and we can have that
instead.

-- Steve
