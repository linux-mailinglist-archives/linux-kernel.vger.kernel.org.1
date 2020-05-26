Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E68E1CF923
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 17:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730623AbgELP2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 11:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730457AbgELP2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 11:28:07 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53ACCC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 08:28:07 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id z80so8455485qka.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 08:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VTYHiGRZeak1+WyqS6xW7NgB9EbujjGNo0rvwUWxcQ4=;
        b=QAXD0bZtkOdjlOb1PJu/i7RYbt9WYWPctvCLBdkulPtQH3wJBaPYW/7w0oEfl47K/w
         yRfY3GOGYldyK3wwLE1FZ3aFek0UZvt57iOdzsmyjkJwSIt6cGxaaN89gSQkiobMJlFa
         JIDWp52Q3/5fGYYA36Jjsm09dcApVGzzQ8PQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VTYHiGRZeak1+WyqS6xW7NgB9EbujjGNo0rvwUWxcQ4=;
        b=CaVmoQVt64qdvq7iS20DCmg400mJsqrAVRfBncIUjyCHSsIuF57DDxAc3Yd6zlv5r5
         YQQsZXHQiYx0WFpa8LmDtAF6faK+zRzX30keQVpIU8yqJdHBoNEQMbL9l1ek2+i49VPP
         0bI7aOPdb/VCDazlxi9c2mSC0tVOYhgkZp1DteR76GiCUQQV6I47PvGsyAAAwDBN7kOc
         siAKsiJiaVsEUHy2uRmehZj4SUKggbb82DHKa/1W4rlXeJkFSp0sr7Z0u5YLxoRulXsl
         e5zkF60vMUSSkn826ph6vf3dV6BjWaz0RQxNHP2wpcMlBB/kQCf58cVkQfxlmIrTohrY
         8ZQA==
X-Gm-Message-State: AGi0PuaCKsErlkHonn2kmDyIyyCGWjyAfU7bZfqFOHJ07X6Y9qalOCit
        wioRYNqW/VmMTOZrw7pUWcAl4NdAGfk=
X-Google-Smtp-Source: APiQypIm+2us2XNxg9dRpkHhWc3UasY4P3/TSvbgoNFNCrh4MMs3uAPFlH9Y0pX1UZM95uKOjG0MMg==
X-Received: by 2002:a37:6892:: with SMTP id d140mr17937560qkc.447.1589297286265;
        Tue, 12 May 2020 08:28:06 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id g20sm9859163qki.75.2020.05.12.08.28.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 08:28:05 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id i16so7163966ybq.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 08:28:03 -0700 (PDT)
X-Received: by 2002:ab0:45c7:: with SMTP id u65mr16628982uau.8.1589297282220;
 Tue, 12 May 2020 08:28:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200428211351.85055-1-dianders@chromium.org> <20200428141218.v3.5.I22067ad43e77ddfd4b64c2d49030628480f9e8d9@changeid>
 <20200511145908.GA22040@willie-the-truck> <CAD=FV=W1F-B7SUwxebhhH2HS+fN4sYv4RHvvKud5a+00J0T=SA@mail.gmail.com>
 <20200512073552.GA1538@willie-the-truck>
In-Reply-To: <20200512073552.GA1538@willie-the-truck>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 12 May 2020 08:27:50 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WuKS7c4WNiLKm+bjRF8Rd7wM1y7THWzJhVhUyExNiiVg@mail.gmail.com>
Message-ID: <CAD=FV=WuKS7c4WNiLKm+bjRF8Rd7wM1y7THWzJhVhUyExNiiVg@mail.gmail.com>
Subject: Re: [PATCH v3 05/11] arm64: Add call_break_hook() to early_brk64()
 for early kgdb
To:     Will Deacon <will@kernel.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-serial@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frank Rowand <frowand.list@gmail.com>, bp@alien8.de,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jiri Slaby <jslaby@suse.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Dave Martin <Dave.Martin@arm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        jinho lim <jordan.lim@samsung.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 12, 2020 at 12:36 AM Will Deacon <will@kernel.org> wrote:
>
> On Mon, May 11, 2020 at 03:45:02PM -0700, Doug Anderson wrote:
> > On Mon, May 11, 2020 at 7:59 AM Will Deacon <will@kernel.org> wrote:
> > > On Tue, Apr 28, 2020 at 02:13:45PM -0700, Douglas Anderson wrote:
> > > > diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
> > > > index 48222a4760c2..59c353dfc8e9 100644
> > > > --- a/arch/arm64/kernel/debug-monitors.c
> > > > +++ b/arch/arm64/kernel/debug-monitors.c
> > > > @@ -297,7 +297,7 @@ void unregister_kernel_break_hook(struct break_hook *hook)
> > > >       unregister_debug_hook(&hook->node);
> > > >  }
> > > >
> > > > -static int call_break_hook(struct pt_regs *regs, unsigned int esr)
> > > > +int call_break_hook(struct pt_regs *regs, unsigned int esr)
> > > >  {
> > > >       struct break_hook *hook;
> > > >       struct list_head *list;
> > > > diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> > > > index cf402be5c573..a8173f0c1774 100644
> > > > --- a/arch/arm64/kernel/traps.c
> > > > +++ b/arch/arm64/kernel/traps.c
> > > > @@ -1044,6 +1044,9 @@ int __init early_brk64(unsigned long addr, unsigned int esr,
> > > >       if ((comment & ~KASAN_BRK_MASK) == KASAN_BRK_IMM)
> > > >               return kasan_handler(regs, esr) != DBG_HOOK_HANDLED;
> > > >  #endif
> > > > +     if (call_break_hook(regs, esr) == DBG_HOOK_HANDLED)
> > > > +             return 0;
> > >
> > > I think this just means we're not running debug_traps_init() early enough,
> > > and actually the KASAN early handler is unnecessary too.
> > >
> > > If we call debug_traps_init() directly from setup_arch() and drop the
> > > arch_initcall(), can we then drop early_brk64 entirely?
> >
> > It seems to work in my testing.  ...but the worry I have is the
> > comment right before trap_init().  It says:
> >
> > /* This registration must happen early, before debug_traps_init(). */
>
> I /think/ the reason for this is because debug_traps_init() replaces the
> BRK vector, so if that runs before the break hooks have been registered
> for e.g. BUG() then BUG() won't work during that window. Hmm, so dropping
> early_brk64 is problematic after all. Damn.
>
> Is trap_init() early enough for you? If so, we could call debug_traps_init()
> from traps_init() after registering the break hooks.

"Early enough" is a subjective term, of course.  The earlier we can
init, the earlier we can drop into the debugger.  ...but, of course,
everyone thinks their feature is the most important and should be
first, so let's see...

Certainly if we waited until trap_init() it wouldn't be early enough
to set "ARCH_HAS_EARLY_DEBUG".  Setting that means that debugging is
ready when early params are parsed and those happen at the start of
setup_arch().  The call to trap_init() happens a bit later.

If we decide that we just don't care about getting
"ARCH_HAS_EARLY_DEBUG" to work then the earliest we'll be able to
break into the debugger (via kgdbwait) is dbg_late_init().  That
_does_ happen after trap_init() so your solution would work.

As a person who spends most of his time in driver land, it wouldn't be
the end of the world to wait for dbg_late_init().  That's still much
earlier than most code I'd ever debug.  ...and, bonus points is that
if we hit a crash any time after earlyparams we _will_ still drop into
the debugger.  It's only breakpoints that won't be available until
dbg_late_init().


tl;dr:

* If we care about "kgdbwait" and breakpoints working as early as
possible then we need my patch.

* If we are OK w/ a slightly later "kgdbwait" then I think we can move
debug_traps_init() to trap_init() and get rid of the early version.


Please let me know which way you'd like to proceed.

-Doug
