Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4FEC28CB7B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 12:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387796AbgJMKTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 06:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727214AbgJMKTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 06:19:48 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFB9C0613D2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 03:19:46 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id de3so9733662qvb.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 03:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eLBA98YamJiHv2ItZgwdd6EeIaxH30JNvO65ryREESE=;
        b=WSw76JAUovFabX8dYsf+iktBPU/lQ0Ff5YMxUA/ZXHf+hdEt/pD6hnwlA7pU7ePcpx
         43rjDkH2RiFN/diiSCDQOAn3SzMQPZ9mn5wHo0weQWTBtvx9exBs0qPkPI+Mi2twpPAB
         a9pjAs6HogAw+OSpAUp8RYQY3TVH61KWMxLtfJmMPbONobpYnPLHcsYSdaE08leVZGHG
         EFCkUmrv/N/PIs44Mes33tr6MEOMuGpJIaG75Cj1ER6oiQtaMtPpzQnHDb9a+Gg9UN5J
         6HPMnsD1tx9npv0fop7ZlBQgtMYj2Fg1SJhCHKowR4AMjfy+PMD866J6Tr2wLKPoMWOX
         /n/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eLBA98YamJiHv2ItZgwdd6EeIaxH30JNvO65ryREESE=;
        b=nqUlKVqKHlrcAiklOl3vyEeJ+u8Y9Koz47J45UEjcYpBt6osczQXSwUV5IGzd2RrVu
         XaMh1xWnYaK+bg73nG24JepQXYaId1bO5FkYqvTIfeacTJwPYT1LwW0vzf6cwkdw8Lag
         32UkjgxC2miqyPyMyvDDEO4X4SR0b+FgHTbNRmeOBuWSI3X7s2sYvGMACRM4DS6tqd+q
         br0XcsphtDj2UiqV+1UkDzNlZpdNBGDZLyb+gbtD0rMgyutee9RsdXDrTFcSONsR622d
         0QAJasSzNZRxHrJraTD9RybS46inYoV7KAl8edRoUpZTYzq7oZ2vSkZ1xT7kbQlsMpjC
         CjWg==
X-Gm-Message-State: AOAM531BA6LJaaqa4eQdCKFsZ494VZ95g67vXYnumUONThLAmaUT4nLQ
        VIPSBlOgFTlwCoo5XMe4vb3p+j4PoRzz6gyB4ceOew==
X-Google-Smtp-Source: ABdhPJz+GJkK44IC0ES1iXdpYyPMZn0GudOemNwH3b1+jXOQeyonIu1Hm330dQZyWmyPwUXbR040pcZDI7eA/aQlqvs=
X-Received: by 2002:a05:6214:222:: with SMTP id j2mr30342069qvt.32.1602584385008;
 Tue, 13 Oct 2020 03:19:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134904.663914713@linutronix.de> <158991831479.17951.17390452716048622271.tip-bot2@tip-bot2>
 <CACT4Y+bTZFkuZd7+bPArowOv-7Die+WZpfOWnEO_Wgs3U59+oA@mail.gmail.com> <202010121329.1DEA8CD@keescook>
In-Reply-To: <202010121329.1DEA8CD@keescook>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 13 Oct 2020 12:19:33 +0200
Message-ID: <CACT4Y+ZuV2keDjiQppJoozc2O_+noki1SrdzBhP-sAQjBDK-hg@mail.gmail.com>
Subject: Re: [tip: x86/entry] x86/entry: Convert Divide Error to IDTENTRY
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        syzkaller <syzkaller@googlegroups.com>,
        linux-tip-commits <linux-tip-commits@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 10:30 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Sun, Oct 11, 2020 at 05:25:22PM +0200, Dmitry Vyukov wrote:
> > On Tue, May 19, 2020 at 9:59 PM tip-bot2 for Thomas Gleixner
> > <tip-bot2@linutronix.de> wrote:
> > >
> > > The following commit has been merged into the x86/entry branch of tip:
> > >
> > > -DO_ERROR(X86_TRAP_DE,     SIGFPE,  FPE_INTDIV,   IP, "divide error",        divide_error)
> > >
> > > +DEFINE_IDTENTRY(exc_divide_error)
> > > +{
> > > +       do_error_trap(regs, 0, "divide_error", X86_TRAP_DE, SIGFPE,
> > > +                     FPE_INTDIV, error_get_trap_addr(regs));
> > > +}
> >
> > I suppose this is a copy-paste typo and was supposed to be "divide
> > error", right?
> > Otherwise it changes how kernel oopses look like and breaks syzkaller
> > crash parsing, and probably of every other kernel testing system that
> > looks for kernel crashes.
> >
> > syzkaller now says just the following for divide errors, without
> > attribution to function/file/maintainers:
> >
> > kernel panic: Fatal exception (3)
> > FS:  0000000000000000(0000) GS:ffff8880ae500000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00000000004c9428 CR3: 0000000009e8d000 CR4: 00000000001506e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Kernel panic - not syncing: Fatal exception in interrupt
> > Kernel Offset: disabled
> > Rebooting in 86400 seconds..
> >
> > I will fix it up in syzkaller. It is now required anyway since this
> > new crash mode is in git history, so needed for bisection and testing
> > of older releases.
> >
> > It is not the first time kernel crash output changes
> > intentionally/unintentionally breaking kernel testing.
> > But I wonder if LKDTM can be turned into actual executable tests that
> > produce pass/fail and fix crash output for different oopses?
> > Marco, you implemented some "output tests" for KCSAN. Can that be
> > extended to other crash types? With some KUnit help? However, I am not
> > sure about hard panics, they may not play well with unit-testing...
>
> A lot of the behavioral tests in LKDTM end up triggering arch-specific
> logging. I decided to avoid trying to consolidate it in favor of
> actually getting the test coverage. :)

What do you mean? Some of these tests would need to be arch-specific,
yes. But I think this is mostly orthogonal to making them PASS/FAIL
tests that can be used during testing.

FTR, syzkaller fix for crash format:
https://github.com/google/syzkaller/commit/c9f222e7b410a336e436f094e24f6465d1cfdc13
