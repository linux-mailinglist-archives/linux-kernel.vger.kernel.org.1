Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4BD304F0D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 02:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390401AbhA0BkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 20:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393783AbhAZSkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 13:40:39 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76098C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 10:39:59 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id 11so10952484pfu.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 10:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pq+s6dEQUgSYdxEfo0/WglB3ePAr5IXU1Ijx0MlkxVQ=;
        b=CEt7mCeiTbSEV76xRwh+XLXr8BvjppZVSyXjIAEi8+lOxlSjJYP7lBTJE1Lw4cI4I7
         t1D6QRe961C7jrtM1UqBA26rVCjFOTCl1vxfdImI+ZiVqs539OxpYRlCy4JC8MtOV73K
         MeWO2Zr4XYFwhGzLP4JiUiEltyvdQN9gSAfEA7f+xB5/0RcEPPVKkpCKfm2TOBmtPAf8
         rj7y75CFVbfGvkexLiRkmF79fCNHzisk+WV6+Mb6/jhHQtTMqx5MugRTMtUQ7AY7TZgU
         KWy6OYra9o8RBPPmgEgCIMRMo+gKvVx+SB0eMy2QRquN/NieCr1XFeRqixuvh13TKYB6
         sX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pq+s6dEQUgSYdxEfo0/WglB3ePAr5IXU1Ijx0MlkxVQ=;
        b=f04lQB8J62Y/49mrFe6yzL/q3ZtAnmmCBaupTw/R4Nh9h40+2jnrh9H0zXZ5y41zsk
         D6LbJk1Xnb9vy7H5+hXjka7NvHPBzRZYT+YSSjNHzM/41bvEWswC4tCCeJeeZzS1Wnmz
         ZsWnIBCjwW/R/2B8GdENz5E/90ynw5/Yrkvs+gDk/XVNe+2tNFkT7wztkQmN0LCza0Ic
         izittlMrLvnLeCHbQDSY4Vkd1lv/4DH/TyzAYObaecMVY9DZonoz3aJygfBlO8I9zsu9
         KBJehoKZauzFDMNK623Vk1u+N61qmEHQehvzhKJJodMWVUIA4ClUa+yOfn74U9d6h5O4
         1kCg==
X-Gm-Message-State: AOAM530I7iM+S5km3+hS+GiWIiiJ3WAGOu04YQaPOpPmJVY8wkI3apPd
        JCcJn4zEREKL0Iw1/Lt7n6o2f+w+j/4Lhpa7Oi6sSQ==
X-Google-Smtp-Source: ABdhPJykU2fm1x2oukHalETm0lGdeyaBGRPvodf+yfrbfEgPvlJAgrHmrUrKSqPZRCr3Y6+WmbL81BYDmJXycdIDmSk=
X-Received: by 2002:a63:7e10:: with SMTP id z16mr6980839pgc.263.1611686398650;
 Tue, 26 Jan 2021 10:39:58 -0800 (PST)
MIME-Version: 1.0
References: <20210125085622.2322-1-candlesea@gmail.com> <97d1f36a3b534b7fbd3790a0277ccaf5@AcuMS.aculab.com>
 <CAPnx3XPRnpPQyW7UO_TTmQrHwitDw+_i3ESVkaGq+JyiY9Pu0w@mail.gmail.com>
In-Reply-To: <CAPnx3XPRnpPQyW7UO_TTmQrHwitDw+_i3ESVkaGq+JyiY9Pu0w@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 26 Jan 2021 10:39:47 -0800
Message-ID: <CAKwvOdnH8kXt+jAutjqsL_5H5PzswLGEZOieaGru2SDn13pj+w@mail.gmail.com>
Subject: Re: [PATCH] lkdtm: fix memory copy size for WRITE_KERN
To:     Candle Sun <candlesea@gmail.com>
Cc:     David Laight <David.Laight@aculab.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "natechancellor@gmail.com" <natechancellor@gmail.com>,
        "candle.sun@unisoc.com" <candle.sun@unisoc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 6:13 AM Candle Sun <candlesea@gmail.com> wrote:
>
> On Mon, Jan 25, 2021 at 6:37 PM David Laight <David.Laight@aculab.com> wrote:
> >
> > From: Candle Sun
> > > Sent: 25 January 2021 08:56
> > >
> > > From: Candle Sun <candle.sun@unisoc.com>
> > >
> > > Though do_overwritten() follows do_nothing() in source code, the final
> > > memory address order is determined by compiler. We can't always assume
> > > address of do_overwritten() is bigger than do_nothing(). At least the
> > > Clang we are using places do_overwritten() before do_nothing() in the
> > > object. This causes the copy size in lkdtm_WRITE_KERN() is *really*
> > > big and WRITE_KERN test on ARM32 arch will fail.
> > >
> > > Compare the address order before doing the subtraction.
> >
> > It isn't clear that helps.
> > Compile with -ffunction-sections and/or do LTO an there
> > is no reason at all why the functions should be together.
> >
> > Even without that lkdtm_WRITE_KERN() could easily be between them.
> >
> > You need to get the size of the 'empty function' from the
> > symbol table.
> >
> >         David
>
> Thanks David.
>
> I think using abs() by Nick's advice would be better. But could you
> point out which kernel function can get function size?

The Elf symbol table should contain this info, IIUC.

Given a string literal of a symbol (such as a function identifier),
kallsyms_lookup_name() can be used to return its address.

From there we'd want to fetch the Elf_Sym for the address which should
contain a st_size field which I think corresponds to the size in bytes
of the function.  (At least, from playing with `llvm-readelf -s`)
Probably would want to validate it's an STT_FUNC symbol type, too.  We
basically want something like kexec_purgatory_find_symbol(), but that
knows about the entire kernel image, and not the purgatory image used
during kexec.  I don't see any such function currently in the
kernel...but it's a large codebase to search through.

>
> Regards,
> Candle
>
>
> >
> > >
> > > Signed-off-by: Candle Sun <candle.sun@unisoc.com>
> > > ---
> > >  drivers/misc/lkdtm/perms.c | 19 +++++++++----------
> > >  1 file changed, 9 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
> > > index 2dede2ef658f..fbfbdf89d668 100644
> > > --- a/drivers/misc/lkdtm/perms.c
> > > +++ b/drivers/misc/lkdtm/perms.c
> > > @@ -31,13 +31,13 @@ static unsigned long ro_after_init __ro_after_init = 0x55AA5500;
> > >   * This just returns to the caller. It is designed to be copied into
> > >   * non-executable memory regions.
> > >   */
> > > -static void do_nothing(void)
> > > +static noinline void do_nothing(void)
> > >  {
> > >       return;
> > >  }
> > >
> > >  /* Must immediately follow do_nothing for size calculuations to work out. */
> > > -static void do_overwritten(void)
> > > +static noinline void do_overwritten(void)
> > >  {
> > >       pr_info("do_overwritten wasn't overwritten!\n");
> > >       return;
> > > @@ -110,15 +110,14 @@ void lkdtm_WRITE_RO_AFTER_INIT(void)
> > >
> > >  void lkdtm_WRITE_KERN(void)
> > >  {
> > > -     size_t size;
> > > -     volatile unsigned char *ptr;
> > > +     unsigned long value_dow = (unsigned long)do_overwritten;
> > > +     unsigned long value_do =  (unsigned long)do_nothing;
> > > +     size_t size = (size_t)(value_dow > value_do ?
> > > +                     value_dow - value_do : value_do - value_dow);
> > >
> > > -     size = (unsigned long)do_overwritten - (unsigned long)do_nothing;
> > > -     ptr = (unsigned char *)do_overwritten;
> > > -
> > > -     pr_info("attempting bad %zu byte write at %px\n", size, ptr);
> > > -     memcpy((void *)ptr, (unsigned char *)do_nothing, size);
> > > -     flush_icache_range((unsigned long)ptr, (unsigned long)(ptr + size));
> > > +     pr_info("attempting bad %zu byte write at %px\n", size, do_overwritten);
> > > +     memcpy((void *)value_dow, (void *)value_do, size);
> > > +     flush_icache_range(value_dow, value_dow + (unsigned long)size);
> > >       pr_err("FAIL: survived bad write\n");
> > >
> > >       do_overwritten();
> > > --
> > > 2.17.0
> >
> > -
> > Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> > Registration No: 1397386 (Wales)
> >



-- 
Thanks,
~Nick Desaulniers
