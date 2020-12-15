Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9194A2DB1FD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 17:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbgLOQ4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 11:56:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:56408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbgLOQ4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 11:56:36 -0500
X-Gm-Message-State: AOAM531i1/LeiuoBth6koZs1SH+rGoPeVe0BNip3I2wFgD1SXznAL7J8
        ODfx/T+3xWjiRjgM2r6tUvUcorDrHmYNu/dIhNkPTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608051356;
        bh=4uuMed2I/qLEnHbSv6wWUwOGnvHF0OxMKguizkS23yI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bVoqSrDelDWBPDHOv9+fs6gCoEYXVVbFGBH2eskeTEJmi1q7p0dqcZdgheLK6ptXR
         eEKa9wambtfj5vhwTrBzGPojwCQVAA1vHiucFfkK5PI71UNodJ2flVteeMIAy3R+YP
         znIitRM4bRbMieYFJK6RPgUD0axy5GxENfdBIqegjqPbaeB5gA13J9QQQhJEuku933
         C0kwh0FhRWjN06IMNedXXssRn1ddYIDpt74aGAw648DpmYOTVFMPA0n/uBebcjr/QJ
         +uD1/XH/CtEYs4d+UpM26lVunJ9uaH5BwTRHnAw+utufKbuzvbKqBdpAn/mAxkQUh+
         c5uDhSOaZSx7g==
X-Google-Smtp-Source: ABdhPJy3uLVnrgt5O145ZtQDwnWF8UfntgkXUoP2och4htd4pb1jC4baZYahNKi6pDB0ebzd8HyoXw3tnxyh3qN8LcA=
X-Received: by 2002:a1c:7e87:: with SMTP id z129mr2512517wmc.176.1608051354310;
 Tue, 15 Dec 2020 08:55:54 -0800 (PST)
MIME-Version: 1.0
References: <20201215160314.18773-1-info@metux.net> <41ef1cd1-017d-a0d4-91d3-a1183bd2ab01@infradead.org>
 <CALCETrXhZxyPUcrBaO=mzvANC72uXNBrivo7hGmdkV2bgdFxjw@mail.gmail.com> <1297989c-6a9e-0804-82a5-d55cc7502b77@infradead.org>
In-Reply-To: <1297989c-6a9e-0804-82a5-d55cc7502b77@infradead.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 15 Dec 2020 08:55:42 -0800
X-Gmail-Original-Message-ID: <CALCETrUgbz8LWraKyVFcVJik=d5zOJTeXHvm6oM9T4ym=66LcA@mail.gmail.com>
Message-ID: <CALCETrUgbz8LWraKyVFcVJik=d5zOJTeXHvm6oM9T4ym=66LcA@mail.gmail.com>
Subject: Re: [PATCH] arch: x86: entry: vdso: fix type conversion on printf() call
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 8:42 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 12/15/20 8:39 AM, Andy Lutomirski wrote:
> > On Tue, Dec 15, 2020 at 8:32 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> >>
> >> On 12/15/20 8:03 AM, Enrico Weigelt, metux IT consult wrote:
> >>> Fixing the following compiler warning by explicit conversion to long:
> >>>
> >>> In file included from /home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/arch/x86/entry/vdso/vdso2c.c:162:0:
> >>> /home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/arch/x86/entry/vdso/vdso2c.h: In function 'extract64':
> >>> /home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/arch/x86/entry/vdso/vdso2c.h:38:52: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t {aka unsigned int}' [-Wformat=]
> >>>   fprintf(outfile, "static const unsigned char %s[%lu] = {", name, len);
> >>>                                                     ^
> >>>   CC      mm/filemap.o
> >>> In file included from /home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/arch/x86/entry/vdso/vdso2c.c:166:0:
> >>> /home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/arch/x86/entry/vdso/vdso2c.h: In function 'extract32':
> >>> /home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/arch/x86/entry/vdso/vdso2c.h:38:52: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t {aka unsigned int}' [-Wformat=]
> >>>   fprintf(outfile, "static const unsigned char %s[%lu] = {", name, len);
> >>>
> >>> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> >>> ---
> >>>  arch/x86/entry/vdso/vdso2c.h | 3 ++-
> >>>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> Hi,
> >>
> >> size_t is normally printed with %zu.
> >> Is there some reason that isn't being used here?
> >
> > No.  Want to send a patch?
> >
>
> I was hoping that Enrico would fix this and maybe address your other comment,
> although I'm not so sure that I agree with it.

Using %zu would get rid of the line break entirely.  Enrico?

>
> --
> ~Randy
>
