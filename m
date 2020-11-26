Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 989172C5C74
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 20:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405170AbgKZTHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 14:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731996AbgKZTHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 14:07:36 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8B6C0613D4;
        Thu, 26 Nov 2020 11:07:36 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id r9so2643667ioo.7;
        Thu, 26 Nov 2020 11:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=66PSSJ6RKeYPbuWgXpOxV9SLDjS0dT0f8aWOMJMYM0I=;
        b=ui1qeXKHZqK2ZE8ykAVlGKMTxobti2b7t+KAPNLP3W0UOU2ctMFFxo+nGzfjwgffOi
         CsFCSfCFxWmoC4FotuOXhJj0HmmH94AzgHkdWp4Wlf3ea098IzIuMBIHHRzEFo1RqLAt
         j76F2oltRS8J3gA6ITliKqaShd6XhUxSLcCTvYyE9UIeDqjpP0KirKrcvCR/xai6Pjca
         ONuYJtB9hv2mYZrsf4+y/iZbTCk63AJfmadXo/zSQR3yFmPIZ6lqzF3MLdSfm6BWptBT
         5YvuikSSRrOxZDR4OpOkWxGdxF35zEE6hzYoBPYLGM2tU9QENnXZjhiGjdBqOCZUOtC+
         Rd8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=66PSSJ6RKeYPbuWgXpOxV9SLDjS0dT0f8aWOMJMYM0I=;
        b=guqJcMer8F8KJ9jlxwbiotA2tCtAZxPKP7SbeyR2hkxjOc3RlV+f/BAubsEvyJwdnI
         1GVG4L5UNNbIS6RT3fJFl8PXYytxMDEDKpVOWiAKibIPYfSzafDh2oOQ4uwjq8XSDU+q
         S15VvyeGY5gDa2+2w08UAmL9MplVzUwYxsO2GRkSxyHFAOHNlLzk7/TqmujGswoWxrG8
         pYAd21hUST13f96Ovul86bEqzh6tdfLbNHDbSbnJymHTzZlUnodrABN5Gxsy869fMYGG
         2FsEWreRuAQGHK4uTXnbPmbiKNJOgcXEdqmbezy96PKuNO9pWNsE2SnsJkGY9BqeG4FG
         7qWg==
X-Gm-Message-State: AOAM533JXy6BMmjbeW70GAVjq00u2F+wqKjYNWg4b/WgwLwcGxR4XC8V
        JBzOJCYSyetVmHtNiOnuA+R739D0zRJYslAy+tw=
X-Google-Smtp-Source: ABdhPJwD2gHfjjt7VHrlU8w8fI1hP0H1kJ1p4DSZ2Jr8lOqSqqGIy28ZQ3H+2FpoHs2EwZUkzcDhHuKBDVYGJQERA0k=
X-Received: by 2002:a6b:8e4e:: with SMTP id q75mr3051640iod.183.1606417655907;
 Thu, 26 Nov 2020 11:07:35 -0800 (PST)
MIME-Version: 1.0
References: <20201126115459.28980-1-lukas.bulwahn@gmail.com> <947b02eb-536f-16a0-fbb1-87b62ab8c13e@citrix.com>
In-Reply-To: <947b02eb-536f-16a0-fbb1-87b62ab8c13e@citrix.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Thu, 26 Nov 2020 20:07:25 +0100
Message-ID: <CAKXUXMybmC=JE3uDnekAuHfRUZcrzSLJ04xB3nR=3BqHCsNVqA@mail.gmail.com>
Subject: Re: [PATCH] x86/cpu: correct values for GDT_ENTRY_INIT
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, Akinobu Mita <akinobu.mita@gmail.com>,
        Joerg Roedel <jroedel@suse.de>,
        "H . Peter Anvin" <hpa@zytor.com>, kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 6:16 PM Andrew Cooper <andrew.cooper3@citrix.com> wrote:
>
> On 26/11/2020 11:54, Lukas Bulwahn wrote:
> > Commit 1e5de18278e6 ("x86: Introduce GDT_ENTRY_INIT()") unintentionally
> > transformed a few 0xffff values to 0xfffff (note: five times "f" instead of
> > four) as part of the refactoring.
>
> The transformation in that change is correct.
>
> Segment bases are 20 bits wide in x86, but the top nibble is folded into
> the middle of the attributes, which is why the transformation also has
> xfxx => x0xx for the attributes field.
>
> >
> > A quick check with:
> >
> >   git show 1e5de18278e6 | grep "fffff"
> >
> > reveals all those 14 occurrences:
> >
> >     12 in ./arch/x86/kernel/cpu/common.c, and
> >     2  in ./arch/x86/include/asm/lguest.h.
> >
> > The two occurrences in ./arch/x86/include/asm/lguest.h were deleted with
> > commit ecda85e70277 ("x86/lguest: Remove lguest support").
> > Correct the remaining twelve occurrences in ./arch/x86/kernel/cpu/common.c
> > back to the original values in the source code before the refactoring.
> >
> > Commit 866b556efa12 ("x86/head/64: Install startup GDT") probably simply
> > copied the required startup gdt information from
> > ./arch/x86/kernel/cpu/common.c to ./arch/x86/kernel/head64.c.
> > So, correct those three occurrences in ./arch/x86/kernel/head64.c as well.
> >
> > As this value is truncated anyway, the object code has not changed when
> > introducing the mistake and is also not changed with this correction now.
> >
> > This was discovered with sparse, which warns with:
> >
> >   warning: cast truncates bits from constant value (fffff becomes ffff)
>
> Does:
>
> diff --git a/arch/x86/include/asm/desc_defs.h
> b/arch/x86/include/asm/desc_defs.h
> index f7e7099af595..9561f3c66e9e 100644
> --- a/arch/x86/include/asm/desc_defs.h
> +++ b/arch/x86/include/asm/desc_defs.h
> @@ -22,7 +22,7 @@ struct desc_struct {
>
>  #define GDT_ENTRY_INIT(flags, base, limit)                     \
>         {                                                       \
> -               .limit0         = (u16) (limit),                \
> +               .limit0         = (u16) (limit) & 0xFFFF,       \
>                 .limit1         = ((limit) >> 16) & 0x0F,       \
>                 .base0          = (u16) (base),                 \
>                 .base1          = ((base) >> 16) & 0xFF,        \
>
> fix the warning?
>

Thanks, I will try that out, and try compiling a 32-bit kernel as well.


> Changing the limit from 4G to 128M isn't going to be compatible with a
> 32bit kernel trying to boot :).
>
> ~Andrew
