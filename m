Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A61F2ED761
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 20:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbhAGTTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 14:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbhAGTTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 14:19:05 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4903C0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 11:18:24 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2so4459633pfq.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 11:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M9UAwRqMYaSLZr+L6zDMPRW6RQbwfEgXAtxlUxRXH2c=;
        b=SRNzU1EEw8hHkNQKH0P9AW8tYytPCMAjYGPQIhGputBzqR281mo+fNkATigsB6y+Q9
         UBwfp16eFGHAyDVO/AwrB/FgdpGAkO+cczADAVNFb4YhloGz+VoOfOXYULD7BR5r+r/A
         dkB7kN81O/5T8rk6dj2yCEQNJ8Hfmwm2fjvPmwxSYP7xbO2A+IJ3M+bmSS/EnD1wTEvm
         5ZrjPlpQEGcodGDj6gQRipnRB+ffq/1Gc1kZH/oZg3DsNwZ2hUMzHK3MRtsoVtALoRmQ
         EQtQjSoGW8Wq1JGRAkCOhwNv45NoNdylvxwfuUS74IMjxC5ukYTrMlpfcIPYfXli11W9
         zTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M9UAwRqMYaSLZr+L6zDMPRW6RQbwfEgXAtxlUxRXH2c=;
        b=ckJ/JOUcn559c1L5E7YfI7hVDvBAPbpc7gcY2wFGtMsTGC9Ulb0QobTvb58NUwfB77
         EYeshIBcHkJcy0BMrfnCR7Em4YaIwrs78ReHwbKArFgTfzvBg/Us95eieb7eFRMFEHXL
         Nmr3pa2Z8V/ZCV+XgCHcrQHeOTSmkk/FITsdA4gYe/5wo9qsQFO86K8z4NSth8o6z2ej
         m2USLwwYWLySCMKJcyj8/SYx4mAC3jUGcULevTfDQmnkhAnF5ul22IY8uY/99MYBoc3O
         FbGo8xYxpJWKgly1ZwhQ/p0ESbf+VzzgecwGhh1e2fyzYOXcMbYPAmGslLbOPPwQ5ROv
         sxKw==
X-Gm-Message-State: AOAM532kLQsPpHtQHJj9WUN3iwPkPkBj+B0HNxXhckDTQ3OWoSyK8HVb
        csX8W0TxlQQtB0oCusqEfxMWMPpdx7nTNgTF4DS/lg==
X-Google-Smtp-Source: ABdhPJwKG15RBA0z9hOer6saZZBOW0bfzfSaa8Mew2oO8gDGRQQcBi6DimR4a00rnGdabYsFx9stzMmuZpGuh/VcoqU=
X-Received: by 2002:a62:2585:0:b029:1ab:7fb7:b965 with SMTP id
 l127-20020a6225850000b02901ab7fb7b965mr278226pfl.2.1610047104294; Thu, 07 Jan
 2021 11:18:24 -0800 (PST)
MIME-Version: 1.0
References: <20210106115519.32222-1-vincenzo.frascino@arm.com>
 <20210106115519.32222-3-vincenzo.frascino@arm.com> <CAAeHK+xuGRzkLdrfGZVo-RVfkH31qUrNdBaPd4k5ffMKHWGfTQ@mail.gmail.com>
 <c4f04127-a682-d809-1dad-5ee1f51d3e0a@arm.com>
In-Reply-To: <c4f04127-a682-d809-1dad-5ee1f51d3e0a@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 7 Jan 2021 20:18:13 +0100
Message-ID: <CAAeHK+xBrCX1Ly0RU-=ySEU8SsyyRkMdOYrN52ONc4DeRJA5eg@mail.gmail.com>
Subject: Re: [PATCH 2/4] arm64: mte: Add asynchronous mode support
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 7, 2021 at 6:25 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> Hi Andrey,
>
> On 1/7/21 4:29 PM, Andrey Konovalov wrote:
> > On Wed, Jan 6, 2021 at 12:56 PM Vincenzo Frascino
> > <vincenzo.frascino@arm.com> wrote:
> >>
> >> MTE provides an asynchronous mode for detecting tag exceptions. In
> >> particular instead of triggering a fault the arm64 core updates a
> >> register which is checked by the kernel at the first entry after the tag
> >> exception has occurred.
> >>
> >> Add support for MTE asynchronous mode.
> >>
> >> The exception handling mechanism will be added with a future patch.
> >>
> >> Note: KASAN HW activates async mode via kasan.mode kernel parameter.
> >> The default mode is set to synchronous.
> >>
> >> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >> Cc: Will Deacon <will.deacon@arm.com>
> >> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> >> ---
> >>  arch/arm64/kernel/mte.c | 31 +++++++++++++++++++++++++++++--
> >>  1 file changed, 29 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> >> index 24a273d47df1..5d992e16b420 100644
> >> --- a/arch/arm64/kernel/mte.c
> >> +++ b/arch/arm64/kernel/mte.c
> >> @@ -153,8 +153,35 @@ void mte_init_tags(u64 max_tag)
> >>
> >>  void mte_enable_kernel(enum kasan_arg_mode mode)
> >>  {
> >> -       /* Enable MTE Sync Mode for EL1. */
> >> -       sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, SCTLR_ELx_TCF_SYNC);
> >> +       const char *m;
> >> +
> >> +       /* Preset parameter values based on the mode. */
> >> +       switch (mode) {
> >> +       case KASAN_ARG_MODE_OFF:
> >> +               return;
> >> +       case KASAN_ARG_MODE_LIGHT:
> >> +               /* Enable MTE Async Mode for EL1. */
> >> +               sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, SCTLR_ELx_TCF_ASYNC);
> >> +               m = "asynchronous";
> >> +               break;
> >> +       case KASAN_ARG_MODE_DEFAULT:
> >> +       case KASAN_ARG_MODE_PROD:
> >> +       case KASAN_ARG_MODE_FULL:
> >> +               /* Enable MTE Sync Mode for EL1. */
> >> +               sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, SCTLR_ELx_TCF_SYNC);
> >> +               m = "synchronous";
> >> +               break;
> >> +       default:
> >> +               /*
> >> +                * kasan mode should be always set hence we should
> >> +                * not reach this condition.
> >> +                */
> >> +               WARN_ON_ONCE(1);
> >> +               return;
> >> +       }
> >> +
> >> +       pr_info_once("MTE: enabled in %s mode at EL1\n", m);
> >> +
> >>         isb();
> >>  }
> >>
> >> --
> >> 2.29.2
> >>
> >
> > Hi Vincenzo,
> >
> > It would be cleaner to pass a bool to mte_enable_kernel() and have it
> > indicate sync/async mode. This way you don't have to pull all these
> > KASAN constants into the arm64 code.
> >
>
> Boolean arguments are generally bad for legibility, hence I tend to avoid them.
> In this case exposing the constants does not seem a big issue especially because
> the only user of this code is "KASAN_HW_TAGS" and definitely improves its
> legibility hence I would prefer to keep it as is.

I don't like that this spills KASAN internals to the arm64 code. Let's
add another enum with two values and pass it as an argument then.
Something like:

enum mte_mode {
  ARM_MTE_SYNC,
  ARM_MTE_ASYNC
}
