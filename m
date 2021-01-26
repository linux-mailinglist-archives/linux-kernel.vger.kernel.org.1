Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671FD30401D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 15:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392681AbhAZOQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 09:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405829AbhAZOOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 09:14:17 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CDAC0611C2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 06:13:37 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id b11so16826032ybj.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 06:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kGoosFUL0iAtgjPJ/Qryecn6FpvdivveQoTTsE0iKR0=;
        b=TXO8fFxPvO8UIA9n/3U8U2WCnzEYDuF5L/VWb6aoupYrxKDGd99CKGrmT6c4E+kyVZ
         aSnHCHJPj+Tqb4zn8qacZHg1f0YkhC+Y8jXPgpL0N0UI2Bs+pylUii13IHEklmPMYnF0
         TkIpaUo0A/SeEXRgnNonviuM8R5H9qEJ/ZebL/ImZmv8quwBW6E8h6Le8kbfbLoljkHd
         QUSXYAKFIdrBC0O1lVxOiu2cdHpEHXrULqitPeS4RmCgKDxboKhJerfJecVkCmUuBmPW
         jdlX/+ZUd8lGmahUYcTNdzKe8pfoeKxFmQaJSdo42MoLbhNWMaNyUojb7Os9O0lezfbm
         owtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kGoosFUL0iAtgjPJ/Qryecn6FpvdivveQoTTsE0iKR0=;
        b=BMOn+g2pL153bK7ucxrcESpbe0FxtmIkHX0SdyEoFjSlRNf5B5ZhPqNcw+7aT4czlJ
         Nm+nlzBHG/Q+RYiHgMxGskKM8F4J9WhWA+4FFhdAhZfNz+va7OB0AiqF9OpMG2oV8Pxj
         RmDh/l+x9GwEMNYLSKN+2/WRyvzh2Ig7yxowzM+R7bS0Ic0Im7f/xjBEWPi5Aezd/R6R
         1hIraVrbZ0Bp5dA2fdDWlbuwGKnzlbGU2x54uJ+vcRed3e+Wjxx7JwfBi5nbWE790PdV
         uWsASNR1q7MeDykJoPSBv5qx3C//S03NxH4rmoW3E2XoDerPOFml4txht8HL/WuFrw9w
         sWyg==
X-Gm-Message-State: AOAM533l5j0VD/ov94veYMe0bBAq1T1f9+CHMMRrBOSbFNDAnIiNCdJ9
        VSQRlalOWjDzjJvR0uMc/E9EvLM4u5R3i610EXhyIPzY3gfS0w==
X-Google-Smtp-Source: ABdhPJzBMoROp11YJ8YGX48IbPjG63ZUYy+CS6PmXpGsqlSy8VGIa1H8WHk6izbZXM6/pJhdTbg9OC4SdhjI9VX0auI=
X-Received: by 2002:a25:4c8a:: with SMTP id z132mr8921794yba.350.1611670416383;
 Tue, 26 Jan 2021 06:13:36 -0800 (PST)
MIME-Version: 1.0
References: <20210125085622.2322-1-candlesea@gmail.com> <97d1f36a3b534b7fbd3790a0277ccaf5@AcuMS.aculab.com>
In-Reply-To: <97d1f36a3b534b7fbd3790a0277ccaf5@AcuMS.aculab.com>
From:   Candle Sun <candlesea@gmail.com>
Date:   Tue, 26 Jan 2021 22:13:25 +0800
Message-ID: <CAPnx3XPRnpPQyW7UO_TTmQrHwitDw+_i3ESVkaGq+JyiY9Pu0w@mail.gmail.com>
Subject: Re: [PATCH] lkdtm: fix memory copy size for WRITE_KERN
To:     David Laight <David.Laight@aculab.com>
Cc:     "keescook@chromium.org" <keescook@chromium.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "natechancellor@gmail.com" <natechancellor@gmail.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "candle.sun@unisoc.com" <candle.sun@unisoc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 6:37 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: Candle Sun
> > Sent: 25 January 2021 08:56
> >
> > From: Candle Sun <candle.sun@unisoc.com>
> >
> > Though do_overwritten() follows do_nothing() in source code, the final
> > memory address order is determined by compiler. We can't always assume
> > address of do_overwritten() is bigger than do_nothing(). At least the
> > Clang we are using places do_overwritten() before do_nothing() in the
> > object. This causes the copy size in lkdtm_WRITE_KERN() is *really*
> > big and WRITE_KERN test on ARM32 arch will fail.
> >
> > Compare the address order before doing the subtraction.
>
> It isn't clear that helps.
> Compile with -ffunction-sections and/or do LTO an there
> is no reason at all why the functions should be together.
>
> Even without that lkdtm_WRITE_KERN() could easily be between them.
>
> You need to get the size of the 'empty function' from the
> symbol table.
>
>         David

Thanks David.

I think using abs() by Nick's advice would be better. But could you
point out which kernel function can get function size?

Regards,
Candle


>
> >
> > Signed-off-by: Candle Sun <candle.sun@unisoc.com>
> > ---
> >  drivers/misc/lkdtm/perms.c | 19 +++++++++----------
> >  1 file changed, 9 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
> > index 2dede2ef658f..fbfbdf89d668 100644
> > --- a/drivers/misc/lkdtm/perms.c
> > +++ b/drivers/misc/lkdtm/perms.c
> > @@ -31,13 +31,13 @@ static unsigned long ro_after_init __ro_after_init = 0x55AA5500;
> >   * This just returns to the caller. It is designed to be copied into
> >   * non-executable memory regions.
> >   */
> > -static void do_nothing(void)
> > +static noinline void do_nothing(void)
> >  {
> >       return;
> >  }
> >
> >  /* Must immediately follow do_nothing for size calculuations to work out. */
> > -static void do_overwritten(void)
> > +static noinline void do_overwritten(void)
> >  {
> >       pr_info("do_overwritten wasn't overwritten!\n");
> >       return;
> > @@ -110,15 +110,14 @@ void lkdtm_WRITE_RO_AFTER_INIT(void)
> >
> >  void lkdtm_WRITE_KERN(void)
> >  {
> > -     size_t size;
> > -     volatile unsigned char *ptr;
> > +     unsigned long value_dow = (unsigned long)do_overwritten;
> > +     unsigned long value_do =  (unsigned long)do_nothing;
> > +     size_t size = (size_t)(value_dow > value_do ?
> > +                     value_dow - value_do : value_do - value_dow);
> >
> > -     size = (unsigned long)do_overwritten - (unsigned long)do_nothing;
> > -     ptr = (unsigned char *)do_overwritten;
> > -
> > -     pr_info("attempting bad %zu byte write at %px\n", size, ptr);
> > -     memcpy((void *)ptr, (unsigned char *)do_nothing, size);
> > -     flush_icache_range((unsigned long)ptr, (unsigned long)(ptr + size));
> > +     pr_info("attempting bad %zu byte write at %px\n", size, do_overwritten);
> > +     memcpy((void *)value_dow, (void *)value_do, size);
> > +     flush_icache_range(value_dow, value_dow + (unsigned long)size);
> >       pr_err("FAIL: survived bad write\n");
> >
> >       do_overwritten();
> > --
> > 2.17.0
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>
