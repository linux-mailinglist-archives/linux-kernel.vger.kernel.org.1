Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3B172AB1B9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 08:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbgKIHZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 02:25:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:40428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729647AbgKIHZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 02:25:31 -0500
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 586182067D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 07:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604906730;
        bh=BN8laGPNBUdynnn8PQDUyO9yqDX2cOMcoepWo6rftdU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CyRhaQ76TP7PPRG4SvLHm8hOHH5bIURlmH/5p/Zs9iSRFB8gwJ8M6wQKAFN8sd9gv
         s9S6LgIWplFBOC9DT74kYW54iH5zKnJL2NU+7lrdH21LYCjN5tydFqxndI1RFJyxVZ
         e2zifoYU9/1b5hpU44Q5bliDVPGVlWHMfWBXwVpg=
Received: by mail-oi1-f177.google.com with SMTP id u127so9284767oib.6
        for <linux-kernel@vger.kernel.org>; Sun, 08 Nov 2020 23:25:30 -0800 (PST)
X-Gm-Message-State: AOAM530UXcySRME9U0pU/pYxrNGtQIIhrvsAoyxgrbiaMFVOmhyQF/YG
        ZrYIBcqJHPxGmvdM7pX/QMcTWxcoJlIO5pYS62w=
X-Google-Smtp-Source: ABdhPJxPtjleGyojA77SXKmQ9BoqiHtUb/RRL2PPv1aE6A40r2ZWKKzjj+RZVT+pdYJR7eE0OlpfIcDIeYP6joG4M7s=
X-Received: by 2002:aca:d583:: with SMTP id m125mr7761372oig.47.1604906729611;
 Sun, 08 Nov 2020 23:25:29 -0800 (PST)
MIME-Version: 1.0
References: <202010211637.7CFD8435@keescook> <773fbdb0-5fc4-ab39-e72d-89845faa4c6d@gmail.com>
 <202010212028.32E8A5EF9B@keescook> <CAMj1kXHXN56xmuwVG3P93Jjwd+NxXTYHtfibPWg5TUADucOdWg@mail.gmail.com>
 <1d2e2b5d-3035-238c-d2ca-14c0c209a6a1@gmail.com> <CAMj1kXERX_Bv1MdfafOVmdmDXPio6Uj897ZZZ7qRERbCXYw_iQ@mail.gmail.com>
 <20201022161118.GP1551@shell.armlinux.org.uk> <CAMj1kXGExnUrTuosMpX2NN3=j0HF-8_s1SzLaTyBvq4_LQNT-w@mail.gmail.com>
 <20201022162334.GQ1551@shell.armlinux.org.uk> <CAMj1kXF+2kJrUaDyA-Xw4rz2bsuEipX3P4JyPrY1bim76LQvoA@mail.gmail.com>
 <20201022174826.GS1551@shell.armlinux.org.uk> <CAMj1kXHpPbwS8zjsr8S65EMj9XOwPxWiQ5WN_ok8ZAFZg9kSAg@mail.gmail.com>
 <CAMj1kXGok50R+2FZ=LqRAx5N3otC3AvC26=+NUqNC6kSvY2-Lg@mail.gmail.com>
 <CAMj1kXF6EdrJWASQQp57L=3gni6R_pLvZfCaFxCoH=rMRzK_6A@mail.gmail.com>
 <CAMj1kXFMiTSakUGnopb8eWRHTM9-0XM0kDaJvTXWDhRPJ3Vsow@mail.gmail.com> <f4b4f5ca-2c0c-c1f0-9329-a95967b99bd0@gmail.com>
In-Reply-To: <f4b4f5ca-2c0c-c1f0-9329-a95967b99bd0@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 9 Nov 2020 08:25:17 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEJL31KOMs7h_XzxFKXgqi2jOXCmLaxfKwW=wgo2so_RA@mail.gmail.com>
Message-ID: <CAMj1kXEJL31KOMs7h_XzxFKXgqi2jOXCmLaxfKwW=wgo2so_RA@mail.gmail.com>
Subject: Re: [PATCH v1] ARM: vfp: Use long jump to fix THUMB2 kernel
 compilation error
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Nov 2020 at 09:43, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 03.11.2020 10:24, Ard Biesheuvel =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > Still broken today
> >
> > https://kernelci.org/build/id/5fa0c1a74bdb1ea4063fe7e4/
> >

Still broken today

https://kernelci.org/build/id/5fa898baa00b5f3167db8857/

> > So the options are
> >
> > a) merge my patch that adds 2 bytes of opcode to the Thumb2 build
> > b) merge Dmitry's patch that adds an unconditional literal load to all =
builds
> > c) remove kernel mode handling from vfp_support_entry() [my other patch=
]
> > d) move sections around so that vfp_kmode_exception is guaranteed to
> > be in range.
> > e) do nothing
> >
> > Given the lack of reports about this issue, it is pretty clear that
> > few people use the Thumb2 build (which I find odd, tbh, since it
> > really is much smaller).
>
> I waited for about a month, hoping that somebody will fix this problem
> before bothering with bisection, which took quite some time and effort
> because intermediate commits were broken, and then with creating and
> sending a patch :)
>
> Thumb2 usually is untested by CI farms and in a case of personal use
> it's easier to wait for a fix. Hence no much reports, I suppose.
>
> > However, that means that a) is a reasonable
> > fix, since nobody will notice the potential performance hit either,
> > and it can easily be backported to wherever the breakage was
> > introduced. (Note that eff8728fe698, which created the problem is
> > marked cc:stable itself).
>
> The performance argument is questionable to me, to be honest. In
> practice the performance difference should be absolutely negligible for
> either of the proposed options, it should stay in a noise even if
> somebody thoroughly counting cycles, IMO.
>
> I'm still thinking that the best option will be to apply a).
>

Can we take that as an acked-by?

> > Going forward, I can refine d) so that we can get rid of the kernel
> > mode path entirely.
>
> And then improve it using d).
