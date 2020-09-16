Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2640C26CFAE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 01:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgIPXee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 19:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgIPXec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 19:34:32 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2ECC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 16:34:30 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id 77so112173uaj.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 16:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oAxt7tGjPsSP/i9NumZB44TI87Eu2C4o0JiIlcf0j3w=;
        b=L8Zov3lPD5usKoAj8++Yb2FGHzxOeeAQVMTum1D8Rw5LouUMDdLYO+mxgJMk9yUNaf
         fyQONwoBZhlMb0tTiDal+CU5Pfsks9L8KzY3DPChp5hq4YTFmYl+qM/AHhvwzwdG9zBZ
         a/9JCD8xpPvt7VTFGVScVYtyqGFjWyj2emKEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oAxt7tGjPsSP/i9NumZB44TI87Eu2C4o0JiIlcf0j3w=;
        b=rLCubQsIYhgrNzJsPlTqugLYRp37Jp0LwWilqchb6687oTQ+mflDcgPPDVMoQq9vFI
         3RUwrhDecQYr7IDlJE1+CiUoRDKEmq08e5YHXXqx9nBwblsv2FW1sAa5ovSNagsRykBN
         H+Bpo4E1b75lFAN7ChnsjSFF7gONQOpAqWFKprsRvYgJtG8vBwYzP7Im/eoEdltOb71A
         r+XkEhhNOqaTpgQ3jE0SIQQxhR0yxzcHl3RFXX0tQbe9Hv48Rf/Cr93H8AAyR2HbVoiV
         VVwINLqca9Yp6NEXL/IIWgX2Mz1Pl2GrH8eBNNsZeomtOW4BTsuuLINUzHpzN0E48SBw
         bmnA==
X-Gm-Message-State: AOAM531/T34uSmyhoBUIYua1jBp+EVhprtzY4+hCHFOLASnPaNnHmV5g
        q/xlYGX6OYVf3HxSA0K+YYh3FCs+jp0f9g==
X-Google-Smtp-Source: ABdhPJw1+yyy2Vl3hnamnPrdYStJrfHfGneCJbhoJYuSGBBYVzNtiMWfqpOd15QxE8+D1OXfzDyEWA==
X-Received: by 2002:ab0:702a:: with SMTP id u10mr14315587ual.59.1600299268899;
        Wed, 16 Sep 2020 16:34:28 -0700 (PDT)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id h27sm3120540vko.38.2020.09.16.16.34.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2020 16:34:27 -0700 (PDT)
Received: by mail-vk1-f180.google.com with SMTP id q13so11412vkd.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 16:34:27 -0700 (PDT)
X-Received: by 2002:ac5:cced:: with SMTP id k13mr15504944vkn.7.1600299267130;
 Wed, 16 Sep 2020 16:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200914130143.1322802-1-daniel.thompson@linaro.org>
 <20200914130143.1322802-4-daniel.thompson@linaro.org> <CAD=FV=VUPXdHoPaQg=Pp=bH-iORicO+1LjBZ0PNu0=SumC5tYw@mail.gmail.com>
 <20200915134520.jgbxallmksifrg2x@holly.lan>
In-Reply-To: <20200915134520.jgbxallmksifrg2x@holly.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 16 Sep 2020 16:34:14 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UTH4B4Ysu+duDhQjMx1vFL1tE0qkzFh78BkrwLj7iB=Q@mail.gmail.com>
Message-ID: <CAD=FV=UTH4B4Ysu+duDhQjMx1vFL1tE0qkzFh78BkrwLj7iB=Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] kernel: debug: Centralize dbg_[de]activate_sw_breakpoints
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Will Deacon <will@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        Patch Tracking <patches@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 15, 2020 at 6:45 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Mon, Sep 14, 2020 at 05:13:28PM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Mon, Sep 14, 2020 at 6:02 AM Daniel Thompson
> > <daniel.thompson@linaro.org> wrote:
> > >
> > > During debug trap execution we expect dbg_deactivate_sw_breakpoints()
> > > to be paired with an dbg_activate_sw_breakpoint(). Currently although
> > > the calls are paired correctly they are needlessly smeared across three
> > > different functions. Worse this also results in code to drive polled I/O
> > > being called with breakpoints activated which, in turn, needlessly
> > > increases the set of functions that will recursively trap if breakpointed.
> > >
> > > Fix this by moving the activation of breakpoints into the debug core.
> > >
> > > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> > > ---
> > >  kernel/debug/debug_core.c       | 2 ++
> > >  kernel/debug/gdbstub.c          | 1 -
> > >  kernel/debug/kdb/kdb_debugger.c | 2 --
> > >  3 files changed, 2 insertions(+), 3 deletions(-)
> >
> > I like the idea, but previously the kgdb_arch_handle_exception() was
> > always called after the SW breakpoints were activated.  Are you sure
> > it's OK to swap those two orders across all architectures?
>
> Pretty sure, yes.
>
> However, given the poor attention to detail I demonstrated in patch 2/3,
> I figure I'd better write out the full chain of reasoning if I want
> you to trust me ;-) .
>
> kgdb_arch_handle_exception() is already called frequently with
> breakpoints disabled since it is basically a fallback that is called
> whenever the architecture neutral parts of the gdb packet processing
> cannot cope.
>
> So your question becomes more specific: is it OK to swap orders when the
> architecture code is handling a (c)ontinue or (s)tep packet[1]?
>
> The reason the architecture neutral part cannot cope is because it
> because *if* gdb has been instructed that the PC must be changed before
> resuming then the architecture neutral code does not know how to effect
> this. In other words the call to kgdb_arch_handle_exception() will
> boil down to doing whatever the architecture equivalent of writing to
> linux_regs->pc actually is (or return an error).
>
> Updating the PC is safe whether or not breakpoints are deactivated
> and activating the breakpoints if the architecture code actually
> censors the resume is a bug (which we just fixed).

OK, fair enough.  Without digging into all the arch code, I was
assuming that some arch somewhere could be playing tricks on us.
After all, the arch code is told about all the breakpoints
(kgdb_arch_set_breakpoint) so, in theory, it could be doing something
funky (not applying the breakpoint until it sees the "continue" or
something?).

I guess the one thing that seems the most plausible that an
architecture might be doing is doing something special if it is told
to "continue" or "single step" an address that had a breakpoint on it.
I guess I could imagine that on some architectures this might require
special handling (could it be somehow illegal to run the CPU in step
mode over a breakpoint instruction?).  ...or maybe if it was using
hardware breakpoints those don't trigger properly if you're continuing
to the address of the breakpoint?  I'm making stuff up here and
presumably none of this is true, but it's what I was worried about.

From a quick glance, I don't _think_ anyone is doing this.  Presumably
today they'd either need a) a funky implementation for
kgdb_arch_set_breakpoint() or they'd need b) code somewhere which read
memory and looked for "gdb_bpt_instr".

a) Looking at kgdb_arch_set_breakpoint(), I don't see anything too
funky.  They all look like nearly the same code of writing the
breakpoint to memory, perhaps taking into account locked .text space
by using a special patch routine.

b) Looking at users of "gdb_bpt_instr" I do see some funkiness in
"h8300" and "microblaze", but nothing that looks like it fits the bill
of what we're looking for.

In any case, even if someone was doing something funky, it would be
possible to adapt the code to the new way of the world.  You'd just
check the PC when applying breakpoints rather than checking the
breakpoints when continuing.  So I'm going to go ahead and say:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

...and I guess if it really truly causes problems for someone we'll
figure it out.


Feel free to ignore the below.  I wrote it up but realized it probably
wasn't useful but couldn't bear to delete it.  :-P

One somewhat plausible example (I don't think this happens, so feel
free to let your eyes glaze over and ignore).  Assume that the kernel
has a mix of ARM and Thumb code.  When told to set a breakpoint at an
address the kernel wouldn't know whether the address refers to ARM or
Thumb code.  In the past I've solved this type of problem by using an
instruction as a breakpoint that is an illegal instruction when
interpreted any which way (the instruction is illegal as an ARM
instruction and both halves illegal as a Thumb instruction).  Right
when we're about to continue, though, we actually have extra
information about the PC we're going to continue to.  If we know we're
about to continue in Thumb mode and the address we're going to
continue on is the 2nd half of a breakpoint instruction we suddenly
know that the breakpoint should have been a Thumb-mode instruction and
we could fix it up.

AKA:

1. kernel is asked to set a breakpoint at 0x12340000.  We don't know
if this is arm or thumb so we set a 32-bit (ARM) breakpoint at
0x12340000

2. We're told to continue in thumb mode at address 0x12340002

3. We suddenly know that the breakpoint at 0x12340000 should have been
a 16-bit (Thumb) breakpoint, not a 32-bit (ARM) breakpoint, so we
could fix it up before continuing.

OK, that probably was just confusing, and, like I said, I don't think
kdb in Linux does that.  ;-)

-Doug
