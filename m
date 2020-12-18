Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03612DEA59
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 21:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387553AbgLRUn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 15:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbgLRUn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 15:43:58 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA7FC0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 12:43:18 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id e15so2085407vsa.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 12:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l62fXWBivGwlBoP6Q6yUTArybDInvE3dJbHgou5OuB4=;
        b=jxyfIMjeU+V/pldNXEBYpau02vKGdYbw6iFBxIoxftZL9QzHL6vHuSwolxtLvA2wqH
         KzmhXUUaparUZkE+NieyArCHqLxwTTG3DcPTCbkGn0Xy7KXgP8+Z7ZKFK+uueKL/WmX2
         2D+F0jghJGSD9gPb8trOo/kpwbzZdIZsDW4eyEuUVhje15U5w4VFGJiJhTZA0xQ0jF92
         vxd86+5kYbrt9ymOlGQyhOalBC6zquGtpxQS3Okio4VIFpUmpFOyR5F5Px7nojC+MeWm
         C9dBCCHYxwmBflovDELfN0Tm2lIyloWhpqAyy2RHuLBCbhzjS1cSDF2coxs6QkQRkGCN
         cJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l62fXWBivGwlBoP6Q6yUTArybDInvE3dJbHgou5OuB4=;
        b=uWVK4oXkCNjx++JZFmtEmWZQkNunUHjcYeKH4QRFXceAxLKkhehaUZGFiqknyhywWT
         ossLGVHb/cvSiCdDWp+Y7p2dWMkCf5Wo46Lhf7jr/F3k6r5rky64O62i0h/CYZS7wILv
         qu9jVBe1URv+tvpby7Ll6MzNULKL076sN52gi0wJAvpsRxbardlONk0svyTL9OPIvE1K
         caYuBmD0DSiws6ZwYG7Ct+2LT/3nBntq2Dtj2CtDYx3s3Qkqq157BVC8iet0JmSvK7ie
         3wiJEPzrdUJCi9/+Lk3poL17ffjIHAHU1Y3Rz0i0ZB5SocBt5GURDuOAOL9XS64O3ay9
         fQfw==
X-Gm-Message-State: AOAM531e7oBsQyY8gGq2oxBnZ6OqcVPjMfc/30d1+qnHe2zaaJWfaL0k
        s7BahThEsvfiy0L3EVFrOFqshIw7HCmRgv3Yl60=
X-Google-Smtp-Source: ABdhPJwgcv8pviA1ZBB44l0qFlV7DI5XKtkmGAn3tN+l3zsJKq3EPmg2ySD9zVDcZkEm3YOe5odgyqrfotBXkCTYbIc=
X-Received: by 2002:a67:8011:: with SMTP id b17mr6838074vsd.2.1608324197703;
 Fri, 18 Dec 2020 12:43:17 -0800 (PST)
MIME-Version: 1.0
References: <20201213183556.16976-1-ariel.marcovitch@gmail.com> <4716e80b-db6f-7669-684f-398971ed5f2e@csgroup.eu>
In-Reply-To: <4716e80b-db6f-7669-684f-398971ed5f2e@csgroup.eu>
From:   ariel marcovitch <arielmarcovitch@gmail.com>
Date:   Fri, 18 Dec 2020 22:43:06 +0200
Message-ID: <CAFGKuwoE=Mh3jEnzjfCGzMw3d+R_Z=i+HGEVR+6-PrMYL9oO1g@mail.gmail.com>
Subject: Re: [PATCH] powerpc: fix alignment bug whithin the init sections
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     mpe@ellerman.id.au, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 18, 2020 at 5:39 PM Christophe Leroy <
christophe.leroy@csgroup.eu> wrote:

> It can cause, or it causes ? Did you encounter the issue ?
>
Yes, in configs that result in the section layout I described, the crush is
consistent.

>
> > The init sections are ordered like this:
> >       .init.text
> >       .exit.text
> >       .init.data
> >
> > Currently, these sections aren't page aligned.
> >
> > Because the init code is mapped read-only at runtime and because the
> > .init.text section can potentially reside on the same physical page as
> > .init.data, the beginning of .init.data might be mapped read-only along
> > with .init.text.
>
> init code is mapped PAGE_KERNEL_TEXT.
>
> Whether PAGE_KERNEL_TEXT is read-only or not depends on the selected
> options.
>
You are right, of course. Should I change the commit message to 'might be
mapped' or something?

>
> > Then when the kernel tries to modify a variable in .init.data (like
> > kthreadd_done, used in kernel_init()) the kernel panics.
> >
> > To avoid this, I made these sections page aligned.
>
> Should write this unpersonal, something like "To avoid this, make these
> sections page aligned"
>
Noted, thanks.


>
> >
> > Fixes: 060ef9d89d18 ("powerpc32: PAGE_EXEC required for inittext")
> > Signed-off-by: Ariel Marcovitch <ariel.marcovitch@gmail.com>
> > ---
> >   arch/powerpc/kernel/vmlinux.lds.S | 7 +++++++
> >   1 file changed, 7 insertions(+)
> >
> > diff --git a/arch/powerpc/kernel/vmlinux.lds.S
> b/arch/powerpc/kernel/vmlinux.lds.S
> > index 326e113d2e45..e3a7c90c03f4 100644
> > --- a/arch/powerpc/kernel/vmlinux.lds.S
> > +++ b/arch/powerpc/kernel/vmlinux.lds.S
> > @@ -179,6 +179,11 @@ SECTIONS
> >   #endif
> >       } :text
> >
> > +     /* .init.text is made RO and .exit.text is not, so we must
> > +      * ensure these sections reside in separate physical pages.
> > +      */
> > +     . = ALIGN(PAGE_SIZE);
> > +
>
> In principle, as it is text, it should be made RO as well. But what
> happens at the begining doesn't
> really matter, anyway .exit.text should never be executed and is discarded
> together with init text.
> So, I think it is OK the live with it as is for the time being.


> Making it page aligned makes sense anyway.
>
> Should we make _einittext page aligned instead, just like _etext ?

Yes, this will probably be better (because when _einittext is not aligned,
the part of the page after _einittext is mapped RO implicitly, and it's
hard to notice from the code). I suppose you mean something like this:
                _sinittext = .;
                INIT_TEXT
+
+               . = ALIGN(.);
                _einittext = .;

>       /* .exit.text is discarded at runtime, not link time,
> >        * to deal with references from __bug_table
> >        */
> > @@ -186,6 +191,8 @@ SECTIONS
> >               EXIT_TEXT
> >       }
> >
> > +     . = ALIGN(PAGE_SIZE);
> > +
>
> Here for sure, as you explain in the coming log, this needs to be
> separated from init text. So
> making it aligned is a must.


> >       .init.data : AT(ADDR(.init.data) - LOAD_OFFSET) {
> >               INIT_DATA
> >       }
> >
> > base-commit: 1398820fee515873379809a6415930ad0764b2f6
> >
>
> Christophe
>
Thanks for your time,
        Ariel Marcovitch
