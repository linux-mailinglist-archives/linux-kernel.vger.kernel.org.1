Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8056928DD5C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 11:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbgJNJYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 05:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731179AbgJNJWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:22:40 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FF5C05BD2D
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 15:56:21 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id g16so328294pjv.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 15:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rDMoJN83Dku18zH5wHCbvoU/fSD4X5asBCZjJeZXhT0=;
        b=mdpis0srH5G+EIp7Bro5R+LFWreMp2jYpgCNRmbE/3f8GTo1jYIO8bGRkYcapmcwZI
         wOIIQVCZcVxvzgkuGqGmcfVtORvY6LgWk7C4wIIHQZDHFfo7Jes4sipFZXAOcNMAaZaB
         mr0rZWVVoKOrw9gnak1JdmJmuD8ZlGBrxDn3S2hkC+7VyOXEQEzPP8BKR2pIxOvCthED
         LlLwb56VU03BeOzbGPm8jlzjnxaXGX+jJP+0kP3lLpOgf+2DMEspY66Mpvx2vK/Uzj1q
         ZpooD+73ijUMXCURYqDhh+94TjZwWDwocpZPB3hWM6m1GKPkuupA5FsRR2XOVUemlijG
         5c1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rDMoJN83Dku18zH5wHCbvoU/fSD4X5asBCZjJeZXhT0=;
        b=PXsA9tGmIjUrbIowfl0l+MGzX6GczKDoMWQHqAPLPEyaL2e1qD5XKVWgOa27N6X5C0
         yp6BC3CWPQtGQow6m6blGtxBB5jZComxPu51fB49g1i/xp+ttR/mJxai5u49rVuprabe
         qo1i/QUPKd35VlP+V5OJRbeCeRcBr5w8TJb+8YMpLMfkrtHGvXZx9ot/dunRUmAjdQuA
         j9SYTHUWv3JjMUXpjRrrT7wW2NVCes99trH5C2/dfBFsJqyzdnRolV3CY/xZixtzdABC
         xJ15XYxZT9YLwIX+ogNSdhg2yremW+zJ8v3um3Ef6n3DNr5pMOE975fTMCitvowbeihk
         FZ2w==
X-Gm-Message-State: AOAM532rnxrtvR2yww2GJcQN8XQKbc5UkGNujBYfOrNKvH3LRfC/DKXO
        YfyUe65Qrmvwuhi94pnG1U1s5aN5I3AJvlaBNRqWDA==
X-Google-Smtp-Source: ABdhPJydCBiVHdgbwTGbV7u0sa/UTXEIcWpXMQgP11WtR/YqjczAeBchA3yZp053Qp+1JStupnwTBQybRAuTiDWjCxM=
X-Received: by 2002:a17:90a:3b48:: with SMTP id t8mr615136pjf.32.1602629780628;
 Tue, 13 Oct 2020 15:56:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200928224854.3224862-1-natechancellor@gmail.com>
 <CAKwvOd=+98r6F4JjrPEoWX88WQ=B-KMRP2eWojabLk6it3i5KA@mail.gmail.com>
 <CAFP8O3J_Yn8SVD8RR=P5qv=NjdLT0s6JQQM8gWFU-2n0=b1uZg@mail.gmail.com>
 <202010121426.A5FA5E59@keescook> <20201013032607.GA2091780@ubuntu-m3-large-x86>
In-Reply-To: <20201013032607.GA2091780@ubuntu-m3-large-x86>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 13 Oct 2020 15:56:08 -0700
Message-ID: <CAKwvOdnM4UHFy1jrnfoKPG_S6CQpWMTCpuxTkbN+_AGe2Ov0SQ@mail.gmail.com>
Subject: Re: [PATCH] arm/build: Always handle .ARM.exidx and .ARM.extab sections
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 8:26 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Mon, Oct 12, 2020 at 02:26:52PM -0700, Kees Cook wrote:
> > On Mon, Oct 12, 2020 at 02:22:03PM -0700, F=C4=81ng-ru=C3=AC S=C3=B2ng =
wrote:
> > > On Mon, Oct 12, 2020 at 2:11 PM 'Nick Desaulniers' via Clang Built
> > > Linux <clang-built-linux@googlegroups.com> wrote:
> > > >
> > > > Please submit to:
> > > > https://www.arm.linux.org.uk/developer/patches/add.php
>
> This should go through the tip tree (hence sending it straight to Ingo)
> since the patch that this fixes was there. I guess it does not
> necessarily matter now that the breakage is in mainline but basing a
> set of patches on a non -rc tag is a little taboo I thought so not sure
> it is appropriate to go through Russell for now. It is up to the
> maintainers though, I will submit it wherever it needs to go.

Ah got it, yeah I don't really care which tree this goes up in.

>
> > > > >
> > > > > Fixes: 5a17850e251a ("arm/build: Warn on orphan section placement=
")
> > > > > Link: https://github.com/ClangBuiltLinux/linux/issues/1152
> > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > > > ---
> > > > >  arch/arm/kernel/vmlinux.lds.S | 4 ++++
> > > > >  1 file changed, 4 insertions(+)
> > > > >
> > > > > diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmli=
nux.lds.S
> > > > > index 5f4922e858d0..a2c0d96b0580 100644
> > > > > --- a/arch/arm/kernel/vmlinux.lds.S
> > > > > +++ b/arch/arm/kernel/vmlinux.lds.S
> > > > > @@ -40,6 +40,10 @@ SECTIONS
> > > > >                 ARM_DISCARD
> > > > >  #ifndef CONFIG_SMP_ON_UP
> > > > >                 *(.alt.smp.init)
> > > > > +#endif
> > > > > +#ifndef CONFIG_ARM_UNWIND
> > > > > +               *(.ARM.exidx*)
> > > >
> > > > I don't think we need the wildcard, as without this line, I see:
> > > >
> > > > ld.lld: warning: <internal>:(.ARM.exidx) is being placed in '.ARM.e=
xidx'
> > >
> > > We may need the wildcard if there are -ffunction-sections builds.
> > > In clang, .ARM.exidx* cannot be removed even with -fno-unwind-tables
> > > -fno-exceptions.
> >
> > Does it need to be:
> >
> >       *(.ARM.exidx) *(.ARM.exidx.*)
> >       *(.ARM.extab) *(.ARM.extab.*)
> >
> > ?
>
> I tested the patch and saw no warnings with what I sent. I can change it
> to that if it is more proper though!

We don't have LTO working on 32b ARM yet, so I'm not worried about
-ffunction-sections for this (yet).  The ld.bfd linker scripts didn't
seem to use the non-wildcard and wildcard suggestion; just the
wildcarded.  (Maybe they have the same "bug?")  I'm happy to revisit
though if we plan to get LTO up and running on 32b ARM.
--=20
Thanks,
~Nick Desaulniers
