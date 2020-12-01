Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4251A2CAB89
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 20:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731295AbgLATLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 14:11:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:46458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730070AbgLATLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 14:11:46 -0500
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DB2820639
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 19:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606849865;
        bh=JqwaoK4HBPCT+/h+D8qURvwc3oM0DqI5/EEkWIzSOGk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iqHTGKxFX8str4vKF7dqTHknZh4uChxGxcH981c5983+DfHyXmb6SeLnou4HZpqBD
         APnFX8IZ06nyHB3cIF9o3PvWokhbytT3fX4gmQ/P5VcO217SyltUv/oKdS4ccc0cl0
         IOkKjamdGTtpMvdwxkjMLkWEtH7PR6YdKSswYYro=
Received: by mail-wm1-f45.google.com with SMTP id d3so5935122wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 11:11:05 -0800 (PST)
X-Gm-Message-State: AOAM532+XhMZGc6MjE7NwkoXJQTfizAQd4JuQmmO8Vn6xapHU823uQ5Y
        Nx0ndz/PnoV4VJawOVHOQlU0PfuBE7pc1bpLMnioJg==
X-Google-Smtp-Source: ABdhPJzPgRcN7okq7ZrswstmNVAuq9cXLaY+iQkRDyjlkmRLK/ACJLAGhXQ7survHU0Dh8zFOr55l5ZBm43LDkan8wQ=
X-Received: by 2002:a1c:1d85:: with SMTP id d127mr4261484wmd.49.1606849862284;
 Tue, 01 Dec 2020 11:11:02 -0800 (PST)
MIME-Version: 1.0
References: <20201130223059.101286-1-brgerst@gmail.com> <CALCETrWZ5eH=0Rjd-vBFRtk-tFQ3tN8_rReaKdVbSm78PFQ7_g@mail.gmail.com>
 <CALCETrWbEvD4SO4GosJyeCmaT2BFwX8Xy+EF_D0x91np3k9OaA@mail.gmail.com> <20201201190051.GB2502@gaia>
In-Reply-To: <20201201190051.GB2502@gaia>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 1 Dec 2020 11:10:48 -0800
X-Gmail-Original-Message-ID: <CALCETrXfOxBRn4XrkAtOATT_Z6VVOHBNkmi9W127V-K+uEkzNA@mail.gmail.com>
Message-ID: <CALCETrXfOxBRn4XrkAtOATT_Z6VVOHBNkmi9W127V-K+uEkzNA@mail.gmail.com>
Subject: Re: [PATCH] fanotify: Fix sys_fanotify_mark() on native x86-32
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>, Jan Kara <jack@suse.cz>,
        =?UTF-8?Q?Pawe=C5=82_Jasiak?= <pawel@jasiak.xyz>,
        Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 11:00 AM Catalin Marinas <catalin.marinas@arm.com> w=
rote:
>
> On Tue, Dec 01, 2020 at 09:34:32AM -0800, Andy Lutomirski wrote:
> > On Tue, Dec 1, 2020 at 9:23 AM Andy Lutomirski <luto@kernel.org> wrote:
> > > On Mon, Nov 30, 2020 at 2:31 PM Brian Gerst <brgerst@gmail.com> wrote=
:
> > > > Commit 121b32a58a3a converted native x86-32 which take 64-bit argum=
ents to
> > > > use the compat handlers to allow conversion to passing args via pt_=
regs.
> > > > sys_fanotify_mark() was however missed, as it has a general compat =
handler.
> > > > Add a config option that will use the syscall wrapper that takes th=
e split
> > > > args for native 32-bit.
> > > >
> > > > Reported-by: Pawe=C5=82 Jasiak <pawel@jasiak.xyz>
> > > > Fixes: 121b32a58a3a ("x86/entry/32: Use IA32-specific wrappers for =
syscalls taking 64-bit arguments")
> > > > Signed-off-by: Brian Gerst <brgerst@gmail.com>
> > > > ---
> > > >  arch/Kconfig                       |  6 ++++++
> > > >  arch/x86/Kconfig                   |  1 +
> > > >  fs/notify/fanotify/fanotify_user.c | 17 +++++++----------
> > > >  include/linux/syscalls.h           | 24 ++++++++++++++++++++++++
> > > >  4 files changed, 38 insertions(+), 10 deletions(-)
> > > >
> > > > diff --git a/arch/Kconfig b/arch/Kconfig
> > > > index 090ef3566c56..452cc127c285 100644
> > > > --- a/arch/Kconfig
> > > > +++ b/arch/Kconfig
> > > > @@ -1045,6 +1045,12 @@ config HAVE_STATIC_CALL_INLINE
> > > >         bool
> > > >         depends on HAVE_STATIC_CALL
> > > >
> > > > +config ARCH_SPLIT_ARG64
> > > > +       bool
> > > > +       help
> > > > +          If a 32-bit architecture requires 64-bit arguments to be=
 split into
> > > > +          pairs of 32-bit arguemtns, select this option.
> > >
> > > You misspelled arguments.  You might also want to clarify that, for
> > > 64-bit arches, this means that compat syscalls split their arguments.
> >
> > No, that's backwards.  Maybe it should be depends !64BIT instead.
> >
> > But I'm really quite confused about something: what's special about
> > x86 here?  Are there really Linux arches (compat or 32-bit native)
> > that *don't* split arguments like this?  Sure, some arches probably
> > work the same way that x86 used to in which the compiler did the
> > splitting by magic for us, but that was always a bit of a kludge.
>
> On arm32 we rely on the compiler splitting a 64-bit argument in two
> consecutive registers. But I wouldn't say it's a kludge (well, mostly)
> as that's part of the arm procedure calling standard. Currently arm32
> doesn't pass the syscall arguments through a read from pt_regs, so all
> is handled transparently.
>
> On arm64 compat, we need to re-assemble the arguments with some
> wrappers explicitly (arch/arm64/kernel/sys32.c) or call the generic
> wrapper like in the compat_sys_fanotify_mark() case.
>
> > Could this change maybe be made unconditional?
>
> I think it's fine in this particular case.
>
> I don't think it's valid in general because of the arm (and maybe
> others) requirement that the first register of a 64-bit argument is an
> even number (IIRC, Russell should know better). If the u64 mask was an
> argument before or after the current position, the compiler would have
> introduced a pad register but not if the arg is split in two u32.
>

So I guess Brian's macro is more like "this is a 32-bit arch that
needs to split 64-bit syscall args but naively splitting them is
correct", which is true on x86_32 but not necessarily on arm.

Should we consider having a real program that runs as part of the
build generate the syscall wrappers?  The logic involved is pushing
the bounds of C macro magic and human comprehension.

--Andy
