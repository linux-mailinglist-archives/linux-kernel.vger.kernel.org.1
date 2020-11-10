Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2712AD09C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 08:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbgKJHpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 02:45:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:48644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728478AbgKJHpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 02:45:43 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8B3B2080A
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 07:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604994342;
        bh=V5seme1Dc/72WBLamjIKlKO0QKIx50V3ebIunpvCVQU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rHy97eW38Z307C23x5Y7jUZmd52+ejdw/IUkAraq+5VjwJXxzMMnAw7e3l/ghaH2C
         IVMBWRp04J2zPQfbXfJPj7akqwoO6n0ZkXWjjD7Yk7ZjHB9+Sge/79N9ZIUWxzsGx3
         fiNKzwkA2BVQUdCRlPdBEBtIsU7J/fWHrVN+1SiY=
Received: by mail-oi1-f181.google.com with SMTP id w188so7767451oib.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 23:45:42 -0800 (PST)
X-Gm-Message-State: AOAM530pAQ3NFusKHt0IxJw/5K6owI5yDxPS31WdNPRgqNxTk7DI0lM1
        T5hBtZyOfGeH65RXoqFeTAhhcNb0HNflHvQFYEc=
X-Google-Smtp-Source: ABdhPJzYx3n703PuIcGq3u41GROj2BCAhY5Xzd+yYsYj2RS0msD9GYnhwvLnd36uN9mqAOh8rAybFHzrkc1h1Dlcj2E=
X-Received: by 2002:aca:d583:: with SMTP id m125mr1848352oig.47.1604994341968;
 Mon, 09 Nov 2020 23:45:41 -0800 (PST)
MIME-Version: 1.0
References: <202010211637.7CFD8435@keescook> <773fbdb0-5fc4-ab39-e72d-89845faa4c6d@gmail.com>
 <202010212028.32E8A5EF9B@keescook> <CAMj1kXHXN56xmuwVG3P93Jjwd+NxXTYHtfibPWg5TUADucOdWg@mail.gmail.com>
 <1d2e2b5d-3035-238c-d2ca-14c0c209a6a1@gmail.com> <CAMj1kXERX_Bv1MdfafOVmdmDXPio6Uj897ZZZ7qRERbCXYw_iQ@mail.gmail.com>
 <20201022161118.GP1551@shell.armlinux.org.uk> <CAMj1kXGExnUrTuosMpX2NN3=j0HF-8_s1SzLaTyBvq4_LQNT-w@mail.gmail.com>
 <20201022162334.GQ1551@shell.armlinux.org.uk> <CAMj1kXF+2kJrUaDyA-Xw4rz2bsuEipX3P4JyPrY1bim76LQvoA@mail.gmail.com>
 <20201022174826.GS1551@shell.armlinux.org.uk> <CAMj1kXHpPbwS8zjsr8S65EMj9XOwPxWiQ5WN_ok8ZAFZg9kSAg@mail.gmail.com>
 <CAMj1kXGok50R+2FZ=LqRAx5N3otC3AvC26=+NUqNC6kSvY2-Lg@mail.gmail.com>
 <CAMj1kXF6EdrJWASQQp57L=3gni6R_pLvZfCaFxCoH=rMRzK_6A@mail.gmail.com>
 <CAMj1kXFMiTSakUGnopb8eWRHTM9-0XM0kDaJvTXWDhRPJ3Vsow@mail.gmail.com>
 <f4b4f5ca-2c0c-c1f0-9329-a95967b99bd0@gmail.com> <CAMj1kXEJL31KOMs7h_XzxFKXgqi2jOXCmLaxfKwW=wgo2so_RA@mail.gmail.com>
 <a438f99d-26a4-a1b5-9fc3-5abd2e76edb3@gmail.com>
In-Reply-To: <a438f99d-26a4-a1b5-9fc3-5abd2e76edb3@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 10 Nov 2020 08:45:30 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG53RH0vJZnWJWi8KSQ6aA0uxi_uhYnffeO5+85ZTYZnA@mail.gmail.com>
Message-ID: <CAMj1kXG53RH0vJZnWJWi8KSQ6aA0uxi_uhYnffeO5+85ZTYZnA@mail.gmail.com>
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

On Tue, 10 Nov 2020 at 08:44, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 09.11.2020 10:25, Ard Biesheuvel =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> ...
> >>> So the options are
> >>>
> >>> a) merge my patch that adds 2 bytes of opcode to the Thumb2 build
> >>> b) merge Dmitry's patch that adds an unconditional literal load to al=
l builds
> >>> c) remove kernel mode handling from vfp_support_entry() [my other pat=
ch]
> >>> d) move sections around so that vfp_kmode_exception is guaranteed to
> >>> be in range.
> >>> e) do nothing
> ...
> >> The performance argument is questionable to me, to be honest. In
> >> practice the performance difference should be absolutely negligible fo=
r
> >> either of the proposed options, it should stay in a noise even if
> >> somebody thoroughly counting cycles, IMO.
> >>
> >> I'm still thinking that the best option will be to apply a).
> >>
> >
> > Can we take that as an acked-by?
>
> Are you asking me for the ack?

Yes.

> I think this is a more appropriate
> question to Russel. I'm not arm/ maintainer, but could give r-b and t-b.
>

R-b and acked-by are basically the same thing.

> If you're going to follow approach that I'm suggesting with a) + d),
> then could you please resend the two patches in a single series? The
> first one-line patch-fix should contain the fixes tag.

Ok
