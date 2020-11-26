Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE792C5C8B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 20:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731736AbgKZTQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 14:16:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:49602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728350AbgKZTQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 14:16:10 -0500
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77D6D22201
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 19:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606418169;
        bh=80SYW/Ksm+D7JImc2dZhXrdWZvFfnhNRp97nMA8r/g0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1dcAXvO2yLehUFUA1Hh55mafuH/r5JatZ4DmsjrNpi/h0gvn5YM/BX/KCQdOI9Hml
         47psl2zt3frI+RbB1rL+mL9S41rtYx9Aq39FirWMaqHhrcV4BbDWccz4mcEcMm7/+J
         Yd4KDNW/FI0vzCjYm70wSZfewrc146mzT+mZh6W8=
Received: by mail-wm1-f46.google.com with SMTP id 3so636038wmj.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 11:16:09 -0800 (PST)
X-Gm-Message-State: AOAM530y+Vga9zb8TG0VdbfEJRKQUubKkTJtHntbBCa65dve1yKINTGU
        9qs7bGeObYrcT/M1KmrQT62F46LbZE77i1BU3SDOyQ==
X-Google-Smtp-Source: ABdhPJwZE48K+MCIIGGRZaiDXB+jWcWm5aHzGvXz9xpXp4euqhm2YaRZV/6Vg/6qMwjH6J7nW220IOCsDhbsamBvL+M=
X-Received: by 2002:a7b:c397:: with SMTP id s23mr5172459wmj.36.1606418167804;
 Thu, 26 Nov 2020 11:16:07 -0800 (PST)
MIME-Version: 1.0
References: <20201126115459.28980-1-lukas.bulwahn@gmail.com>
 <947b02eb-536f-16a0-fbb1-87b62ab8c13e@citrix.com> <CAKXUXMybmC=JE3uDnekAuHfRUZcrzSLJ04xB3nR=3BqHCsNVqA@mail.gmail.com>
In-Reply-To: <CAKXUXMybmC=JE3uDnekAuHfRUZcrzSLJ04xB3nR=3BqHCsNVqA@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 26 Nov 2020 11:15:54 -0800
X-Gmail-Original-Message-ID: <CALCETrUyoaJyJ8mGpq9bdanKKfHgjg_1B=N0rtmuHCmCP9Q9=g@mail.gmail.com>
Message-ID: <CALCETrUyoaJyJ8mGpq9bdanKKfHgjg_1B=N0rtmuHCmCP9Q9=g@mail.gmail.com>
Subject: Re: [PATCH] x86/cpu: correct values for GDT_ENTRY_INIT
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, Akinobu Mita <akinobu.mita@gmail.com>,
        Joerg Roedel <jroedel@suse.de>,
        "H . Peter Anvin" <hpa@zytor.com>, kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 11:07 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> On Thu, Nov 26, 2020 at 6:16 PM Andrew Cooper <andrew.cooper3@citrix.com> wrote:
> >
> > On 26/11/2020 11:54, Lukas Bulwahn wrote:
> > > Commit 1e5de18278e6 ("x86: Introduce GDT_ENTRY_INIT()") unintentionally
> > > transformed a few 0xffff values to 0xfffff (note: five times "f" instead of
> > > four) as part of the refactoring.
> >
> > The transformation in that change is correct.
> >
> > Segment bases are 20 bits wide in x86, but the top nibble is folded into
> > the middle of the attributes, which is why the transformation also has
> > xfxx => x0xx for the attributes field.
> >
> > >
> > > A quick check with:
> > >
> > >   git show 1e5de18278e6 | grep "fffff"
> > >
> > > reveals all those 14 occurrences:
> > >
> > >     12 in ./arch/x86/kernel/cpu/common.c, and
> > >     2  in ./arch/x86/include/asm/lguest.h.
> > >
> > > The two occurrences in ./arch/x86/include/asm/lguest.h were deleted with
> > > commit ecda85e70277 ("x86/lguest: Remove lguest support").
> > > Correct the remaining twelve occurrences in ./arch/x86/kernel/cpu/common.c
> > > back to the original values in the source code before the refactoring.
> > >
> > > Commit 866b556efa12 ("x86/head/64: Install startup GDT") probably simply
> > > copied the required startup gdt information from
> > > ./arch/x86/kernel/cpu/common.c to ./arch/x86/kernel/head64.c.
> > > So, correct those three occurrences in ./arch/x86/kernel/head64.c as well.
> > >
> > > As this value is truncated anyway, the object code has not changed when
> > > introducing the mistake and is also not changed with this correction now.
> > >
> > > This was discovered with sparse, which warns with:
> > >
> > >   warning: cast truncates bits from constant value (fffff becomes ffff)
> >
> > Does:
> >
> > diff --git a/arch/x86/include/asm/desc_defs.h
> > b/arch/x86/include/asm/desc_defs.h
> > index f7e7099af595..9561f3c66e9e 100644
> > --- a/arch/x86/include/asm/desc_defs.h
> > +++ b/arch/x86/include/asm/desc_defs.h
> > @@ -22,7 +22,7 @@ struct desc_struct {
> >
> >  #define GDT_ENTRY_INIT(flags, base, limit)                     \
> >         {                                                       \
> > -               .limit0         = (u16) (limit),                \
> > +               .limit0         = (u16) (limit) & 0xFFFF,       \
> >                 .limit1         = ((limit) >> 16) & 0x0F,       \
> >                 .base0          = (u16) (base),                 \
> >                 .base1          = ((base) >> 16) & 0xFF,        \
> >
> > fix the warning?
> >
>
> Thanks, I will try that out, and try compiling a 32-bit kernel as well.

You should also try comparing the objdump output before and after your
patch.  objdump -D will produce bizarre output but should work.
