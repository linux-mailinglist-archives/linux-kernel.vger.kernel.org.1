Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 754D6269762
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 23:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgINVFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 17:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbgINVFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 17:05:18 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD72C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 14:05:17 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id fa1so562727pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 14:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E0F8AkfKQCaaK7RpO105WDYCBVLdgClr8aQ6v9XdgcE=;
        b=sulaPXBL4qLc5uHAvrju2/esv+SzgXVyrb/idGYZs8e+XPAu5dVlGcX39v4gWnq6Yx
         6DionPNXUXnoCqwz0bn1c9PguYfmioKn1mwdNtzEl5Ltj7OwpaPYBfwzy7VVx3K7d2s7
         4rRmLoqBEoQyJ+QAYdV3qCPeYReHJttm/pXCQkoq9QRaCV1Qyqz93NLFK5gYxwjjWW2c
         hB2mqEaifjYUCYlgg6YFL4gso5o2jspKeOBLepuyvCz3yW/4mq65YZx1XA7+FVnjSfyQ
         FmA1Jk095e04Ml6QceKq+gaisgDT1Ayz8cd+rLANTD+bhxdv19xD+m5hL8QqrW7IVaxe
         zQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E0F8AkfKQCaaK7RpO105WDYCBVLdgClr8aQ6v9XdgcE=;
        b=q1uK6y8M0QoAbF4hj34svSbW+fP0zKhJmtgP/D5itlBgm9+j5pK8Rmh30HDo3l2jYZ
         ZuxrcyHzonCQGgO7cG9oKo2thoYOl4FtrBiJnAN7tAj+Y1AaQpQX5nAcI7EPsQFYpdKj
         9koOASjtL379oEnVEdpMoPqQmzI6+U72LK2H82NY3EnkAqs6yz8+QBsNv/FVSILKTQyP
         LPynRODiTBiplxCBiYrHHXUSowqAAyVc5MHWASYjuEM18XO74ndODYDoZIl3+BQ04Mhq
         jWzWu8bPfrl+PMbXNAgsftIerW7yIJk8jwk5E6SAWsoHaXVNzC9ol/yQcOUcvrhHCnzT
         VDpA==
X-Gm-Message-State: AOAM531uBztMr/FuodnGV8p5hpHMjDlCbJMfciz3mwUeH7HBxZOB91P9
        XwMBQJru8Qs5P6FHg3P+fRhA1Ftkbiib8Ryvh8pBgQ==
X-Google-Smtp-Source: ABdhPJwX3PmHnk3aBrcEgrSXd+/nbZXSlMCdao5antzJ75d2bymDEzFZ/K19JxIfcADHXmp+rl7GG88WXmlaGvToHLY=
X-Received: by 2002:a17:90a:e517:: with SMTP id t23mr1054592pjy.25.1600117516539;
 Mon, 14 Sep 2020 14:05:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200903011054.2282115-1-morbo@google.com> <20200903073435.GU1362448@hirez.programming.kicks-ass.net>
 <CAGG=3QX4wKcoPWw+5=tOqz3Y7g8ELGZuav3kdWjXRQae=ue9Mg@mail.gmail.com> <CALCETrW7B3HkF5iY=qgt0KeN1fXZLVaPZcELYGRm9bOgbirbww@mail.gmail.com>
In-Reply-To: <CALCETrW7B3HkF5iY=qgt0KeN1fXZLVaPZcELYGRm9bOgbirbww@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 14 Sep 2020 14:05:04 -0700
Message-ID: <CAKwvOdkKqkP1qT0002xQnDrByXr_ygvqCmnzZ50vJLDsg6XWXg@mail.gmail.com>
Subject: Re: [PATCH] x86: use clang builtins to read and write eflags
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Bill Wendling <morbo@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Greg Thelen <gthelen@google.com>,
        John Sperbeck <jsperbeck@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Bill, please use `./scripts/get_maintainer.pl <patchfile>` to get the
appropriate list of folks and mailing lists to CC)

On Thu, Sep 3, 2020 at 8:06 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> So with my selftests hat on, the inline asm utterly sucks.  Trying to
> use pushfq / popfq violates the redzone and requires a gross hack to
> work around.  It also messes up the DWARF annotations.  The kernel
> gets a free pass on both of these because we don't use a redzone and
> we don't use DWARF.

Sorry, I don't fully understand:
1. What's the redzone?
2. How does pushfq/popfq violate it?
3. What is the "gross hack"/"workaround?" (So that we might consider
removing it if these builtins help).
4. The kernel does use DWARF, based on configs, right?

>
> Now GCC and clang's builtins are also ugly.  But perhaps we could have
> a little wrapper that is less ugly?
>
> static __always_inline unsigned long __read_eflags(void)
> {
> #ifdef CONFIG_X86_64
>     return __builtin_ia32_readeflags_u64();
> #else
>     return __builtin_ia32_readeflags_u32();
> }

It looks like __builtin_ia32_readeflags_u32,
__builtin_ia32_readeflags_u64, __builtin_ia32_writeeflags_u64, and
__builtin_ia32_writeeflags_u32 were first available in GCC 4.9; they
weren't in GCC 4.8 or older, so we can make use of them
unconditionally.  I think it would be nice to use the above.  Could
even be:

#ifdef CONFIG_X86_64
#define __read_eflags __builtin_ia32_readeflags_u64
#define __write_eflags __builtin_i32_writeeflags_u64
#else
#define __read_eflags __builtin_ia32_readeflags_u32
#define __write_eflags __builtin_i32_writeeflags_u32
#endif

Which would be concise.  For smap_save() we can use clac() and stac()
which might be nicer than `asm goto` (kudos for using `asm goto`, but
plz no more).  :^P Also, we can probably cleanup the note about GCC <
4.9 now. :)

>
> >
> > > Why can't clang use the inline asm version?
> >
> > Clang chooses the most general constraint when multiple constraints
> > are specified. So it will use the stack when retrieving the flags.
>
> I haven't looked at clang's generated code to see if it's sensible
> from an optimization perspective, but surely the kernel code right now
> is genuinely wrong.  GCC is free to omit the frame pointer and
> generate a stack-relative access for the pop, in which case it will
> malfunction.

Sorry, this is another case I don't precisely follow, would you mind
explaining it further to me please?

Bill, it looks like Clang is forcibly emitting a frame pointer for
these: https://godbolt.org/z/GPMeKc, is that right/needed?  I thought
-O2 implied -fomit-frame-pointer, in fact I think I fixed that in
Clang for x86 most recently...

>
> IOW, we appear to have an actual bug, and clang just happens to be
> triggering it, no?

We've seen bugs in the past where "m" constraints were used with
inline asm that modified the stack pointer (commit 428b8f1d9f92 "KVM:
VMX: don't allow memory operands for inline asm that modifies SP"),
though I thought only leaving the stack imbalanced (not restoring it
to its previous value before the end of the inline asm) was
problematic.  Though commit d0a8d9378d16 ("x86/paravirt: Make
native_save_fl() extern inline") is what I'm reminded of with this
patch.  (Stack protectors continue to wind up in places that cause
trouble.  GCC folks have patches to disable them on a per function
basis via function attribute like Clang does, though they've been
sitting in code review for a long time.  Recently, they've caused some
headaches with LTO as well.  Once we have those, I plan on adding that
to compiler_attributes.h.)  I would sleep better at night if I
undid/reverted d0a8d9378d16.

-- 
Thanks,
~Nick Desaulniers
