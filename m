Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B6826AC2E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 20:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgIOSir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 14:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbgIOSBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 14:01:25 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A87C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 11:00:42 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a9so195461pjg.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 11:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wZ7tyQ9/E068rLYJ+WthcD5+oEGjm8vJDzcqTloN5CI=;
        b=rt5RfIiAS+3CtwsVx8/uLkBetuBZdjn5+h9mdZXKHV8bjKFXgd5fs5e5K3K2MLoYJV
         R7I4aofOANTyB3SegR6vVwsbLoMMtroxYBAtxx05x/ApKXF3XAYGzl9QcR+H4E5o6rDS
         mDcYwGQ48X1SmHPN1iq0Tacwn7o/JCCVbLPktWm4mx3xNjudE5xUR7jq0I7yN6amq4m5
         5cjaqRqDrJ22dFnLSxMpbmDVIovqNQRnpnr9mnG2qnoP7/Xux0GHVaoOZh6gWTm9JCON
         JR4e9W/gkwrTEMSaaJ+sYGa8HUupx3gLZdl+XxGtzSi5RgVaOMAnBRaiM7mx7iV3DAFA
         9qgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wZ7tyQ9/E068rLYJ+WthcD5+oEGjm8vJDzcqTloN5CI=;
        b=nQLODa2iY+hTy1xIg/ROkMWFwlwmr7y/I4RJx9qYg/X/h0UA85TnH18iB/S1OPN2aK
         6ZSMxkC8/GaixD/hawYkrmUzTJT7cbDVOzEoAglQaAaTRGd59aFSYAavJDti8Z7chkuO
         prQuhc5tgj0D6rkmtnUP8e2YEKtJtu5aqiqzGhXAwb4a4fX43QjQQxBPECG9R9s5Rwwe
         176vKABv3YI+5Dyz1CV5Eaw3HqvYbVQccJ/S1GgPC5DtU+ivlqHboaq8SkF/Mk7T1pUT
         zPGmsjXLrUQUkoy3YIYt20Mpzo3BRnWlvMloivjqcW+y8uU9g4RCh4vOV7ldzdTFkj/j
         5FOg==
X-Gm-Message-State: AOAM533vzl0Uy30Qy4eHydTCyiVN3fEmmCI/8cuGM7v0FKW20PZ0AX9b
        XGHLUwwYrhS1G1+EPDjmt42CSvPuqhbWpjqPgkJ/7Q==
X-Google-Smtp-Source: ABdhPJzYU8XT3NZ8h/McxVIhbz85243BuqtY/sNNFxzpti4dzqfSv3YjL9MuxlrerW7ZTmCi7f7cO3jM56rDm+HLR3o=
X-Received: by 2002:a17:90b:889:: with SMTP id bj9mr497812pjb.101.1600192841937;
 Tue, 15 Sep 2020 11:00:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200915172658.1432732-1-rkir@google.com> <20200915174643.GT14436@zn.tnic>
In-Reply-To: <20200915174643.GT14436@zn.tnic>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 15 Sep 2020 11:00:30 -0700
Message-ID: <CAKwvOdm9bQmL=gZypkosH0MG=S28=jJ6wZiTMCNP6=Z+NfN1AA@mail.gmail.com>
Subject: Re: [PATCH] arch: x86: power: cpu: init %gs before
 __restore_processor_state (clang)
To:     Borislav Petkov <bp@alien8.de>, Roman Kiryanov <rkir@google.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-pm@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Alistair Delva <adelva@google.com>,
        Haitao Shan <hshan@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 10:46 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Sep 15, 2020 at 10:26:58AM -0700, rkir@google.com wrote:
> > From: Haitao Shan <hshan@google.com>
> >
> > This is a workaround which fixes triple fault
> > in __restore_processor_state on clang when
> > built with LTO.
> >
> > When load_TR_desc and load_mm_ldt are inlined into
> > fix_processor_context due to LTO, they cause
> > fix_processor_context (or in this case __restore_processor_state,
> > as fix_processor_context was inlined into __restore_processor_state)
> > to access the stack canary through %gs, but before
> > __restore_processor_state has restored the previous value
> > of %gs properly. LLVM appears to be inlining functions with stack
> > protectors into functions compiled with -fno-stack-protector,
> > which is likely a bug in LLVM's inliner that needs to be fixed.
> >
> > The LLVM bug is here: https://bugs.llvm.org/show_bug.cgi?id=47479
> >
> > Signed-off-by: Haitao Shan <hshan@google.com>
> > Signed-off-by: Roman Kiryanov <rkir@google.com>
>
> Ok, google guys, pls make sure you Cc LKML too as this is where *all*
> patches and discussions are archived. Adding it now to Cc.

Roman, please use ./scripts/get_maintainer.pl (in the kernel tree) for that.

>
> > ---
> >  arch/x86/power/cpu.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
> > index db1378c6ff26..e5677adb2d28 100644
> > --- a/arch/x86/power/cpu.c
> > +++ b/arch/x86/power/cpu.c
> > @@ -274,6 +274,16 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
> >  /* Needed by apm.c */
> >  void notrace restore_processor_state(void)
> >  {
> > +#ifdef __clang__

Should be CONFIG_CC_IS_CLANG; is more canonical throughout the tree.
Or if this is only a bug when doing builds with LTO, and LTO is not
yet upstream, then maybe Sami should carry this in his series, at
least until I can fix the bug in Clang.  Or guard this with the
CONFIG_LTO_CLANG config (not upstream yet; see Sami's series).

> > +     // The following code snippet is copied from __restore_processor_state.
> > +     // Its purpose is to prepare GS segment before the function is called.
> > +#ifdef CONFIG_X86_64
> > +     wrmsrl(MSR_GS_BASE, saved_context.kernelmode_gs_base);
> > +#else
> > +     loadsegment(fs, __KERNEL_PERCPU);
> > +     loadsegment(gs, __KERNEL_STACK_CANARY);
> > +#endif
> > +#endif
>
> Ok, so why is the kernel supposed to take yet another ugly workaround
> because there's a bug in the compiler?

This is exactly the same code from __restore_processor_state.  If it's
ugly, talk to the author of 7ee18d677989e. ;)  All this patch is doing
is moving this up a call frame (though now this is effectively being
run twice).

> If it is too late to fix it there, then maybe disable LTO builds for the
> buggy version only.

We could do that, too.  (We can disable LTO on a per translation unit
basis in KBuild).  Note the author of the bug report linked above. :^P
"Revenge of the stack protector"

>
> We had a similar discussion this week and we already have one buggy
> compiler to deal with and this second one is not making it any easier...
-- 
Thanks,
~Nick Desaulniers
