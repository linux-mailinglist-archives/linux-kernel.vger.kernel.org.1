Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6239D26AE29
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 21:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgIOTxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 15:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbgIOTwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 15:52:25 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5EAC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 12:52:00 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id m15so1893099pls.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 12:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TI2xLec+fHn8OciSaj91CFEPuyI3CYj5LnJd/mX8Q9c=;
        b=CSaEWUa8LALEjbgWipzCz97uFtgtyhT3hXJSCT31PyfocmLJFaso6qNrkfOjRrWVeq
         KZqwnYR6fH0mtweTbAb6DldweWs3wtZTzfU0+OxFajMgAsK2p/u/ZUuI3kpz5VFMhGZR
         +SxUnsj75UMcYx77YumZz52dOIeKGtU9Rj+/ppDjfxBteqbiy/oSGtSQbKQeKDW4Kr9k
         D3nitebGoAGkNoAud3IY1sZNSW+HSQ4xF/th2dGpb9YGwYsMCLWVW+v/ZVbxkC6I2jOL
         9d2tnZAIvdKy2PRBzIV8Hh5rsJs+a9ekkfApDSMjYROTLpFJCoEccYbpeKjWemqRvqGa
         mrJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TI2xLec+fHn8OciSaj91CFEPuyI3CYj5LnJd/mX8Q9c=;
        b=lMFvkM4u0IxVwC6+fCJfnRMmCG5ShqgYTsWjRFyFQiZX31Fcqqlyc9xXC8TdNKxP99
         +oMaypMd5BabDQIfBQ4iu6pbqxNTKpmIIM32i1aQfuaEYuBT3jVaVjDDSMClrOmzpGLs
         6+0AGql5WtxjBVNKqzKbBV3mBTXJTENOt0AziRUb0rk+CBWfTy2yN4aYdpTt7+2QFa56
         RO0vMrlYMGMJmPMNJYir3lrhgSqYTYSv+MewzT9ctdtib65IVorA/xQaB/fAUFTqTbH5
         EST8RS2bHx+M9Mg20lyO6M/3KwoJ+5IDy8laK2ROdGkkPXAmSIn6li04He3Ap7BQjpwR
         +7Mg==
X-Gm-Message-State: AOAM531ltMSwhxKFcFqS/bomAUYz4n3MIGJnoM+x0n/ZqnhM8hnN3od/
        PjPV62ojAoolwd0KTJpC5CpF1oEVt8+byVwMOkRoOw==
X-Google-Smtp-Source: ABdhPJwfkIrGn0JOmTLbg7jGpiqZH9I7JEnSZAE9TuQEuAAV+13NJLuBvlt5+L2Qa0akcupsVX5eMn8WStg7f9QmNbQ=
X-Received: by 2002:a17:90b:698:: with SMTP id m24mr883485pjz.32.1600199519432;
 Tue, 15 Sep 2020 12:51:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200915172658.1432732-1-rkir@google.com> <20200915174643.GT14436@zn.tnic>
 <CAKwvOdm9bQmL=gZypkosH0MG=S28=jJ6wZiTMCNP6=Z+NfN1AA@mail.gmail.com> <20200915182530.GV14436@zn.tnic>
In-Reply-To: <20200915182530.GV14436@zn.tnic>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 15 Sep 2020 12:51:47 -0700
Message-ID: <CAKwvOdkKk1KuAFDoWNLnMUi3_JnV7atDFnvS7CdkgNXnNg0p1g@mail.gmail.com>
Subject: Re: [PATCH] arch: x86: power: cpu: init %gs before
 __restore_processor_state (clang)
To:     Borislav Petkov <bp@alien8.de>
Cc:     Roman Kiryanov <rkir@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-pm@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Alistair Delva <adelva@google.com>,
        Haitao Shan <hshan@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        =?UTF-8?Q?Martin_Li=C5=A1ka?= <mliska@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 11:25 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Sep 15, 2020 at 11:00:30AM -0700, Nick Desaulniers wrote:
> > This is exactly the same code from __restore_processor_state.
>
> No, this patch is adding
>
> #ifdef __clang__
>
> and I don't like the sprinkling around of those compiler-specific
> workarounds which we have to carry forward forever or at least until
> that compiler version is deprecated. We already carry fixes for broken
> hardware, broken BIOSes, broken peripherals,... can you follow the
> progression? :)

I agree; I also would not have sent the patch though.  Until LTO has
landed upstream, this is definitely somewhat self inflicted.  This was
only debugged last week; even with a compiler fix in hand today, it
still takes time to ship that compiler and qualify it; for other folks
on tighter timelines, I can understand why the patch was sent, and do
genuinely appreciate the effort to participate more upstream which I'm
trying to encourage more of throughout the company (we're in a lot of
technical debt kernel-wise; and I'm not referring to Android...a story
over beers perhaps, or ask Greg).  It's just that this isn't really
appropriate since it works around a bug in a non-upstream feature, and
will go away once we fix the toolchain.

>
> So your argument about testing unreleased compilers in the other thread
> makes a lot of sense so that stuff like that can be fixed in time, and
> in the compiler, where it belongs (that is, *if* it belongs there).

It would be much nicer if we had the flexibility to disable stack
protectors per function, rather than per translation unit.  I'm going
to encourage you to encourage your favorite compile vendor ("write to
your senator") to support the function attribute
__attribute__((no_stack_protector)) so that one day, we can use that
to stop shipping crap like a9a3ed1eff360 ("x86: Fix early boot crash
on gcc-10, third try").  Having had that, we could have used a nicer
workaround until the toolchain was fixed (and one day revert
a9a3ed1eff360, and d0a8d9378d16, and probably more hacks in the
kernel).  And the case that's causing the compiler bug in question is
something all compiler vendors will need to consider in their
implementations.
-- 
Thanks,
~Nick Desaulniers
