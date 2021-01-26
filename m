Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65280304004
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 15:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405798AbhAZOSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 09:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405679AbhAZOSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 09:18:17 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABC3C0611C2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 06:17:37 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id e67so16827243ybc.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 06:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AS/PqSCLXPUX5/0cv/D32Ab1nbbd5GInwJYzei8iock=;
        b=HGnNuROYaN8L9CsOXEklj4GmusrUZy6n73qQEoZo2Sjy2TFTiAvJmIExJ0APhd9MYX
         yGaoOrlz0ow32/0hUv4+6PfdcmJRqVbactaa2ErQ8QOr5RGgoKJiDldaSyJeBrhCFdq2
         SrzM1lK1c/gdOVScVkBHIqD2u2iuJmUQMGGRHuuUIglDfb0TjdG+rFDsiVcgkBAbMdyg
         2z8edNrPGdqGmuC0SXgBfV2mAK3D7NbSg2DEYn05/MeVsd6WPRC31KfxGZC2Kps/gAik
         i4eD8yHR7/ztWDbd68YXNld8737gL6+mhdQrAy3y7pec0b75b7IwV2BkriDFmSlCxAbV
         lnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AS/PqSCLXPUX5/0cv/D32Ab1nbbd5GInwJYzei8iock=;
        b=ITcInCmoyWOdCZWbCPTU3W4ZxpYq/uhKn6sD22T2/6ovbk6w724iiiM1AMg6lyejnr
         2gABcVqszdxfJkVm4E5CWPmpUTokiKZpy4GGTz1pk0YYrQ3OKMAcYQ4PuBLBqTR5i1a9
         N9WXNEI6wPbCfHp/upqLdU8+m+ihYrycoTmOrmuh0v1bLDEArRMYKlUBQj+CalgwPfAW
         xJnh7odjNptYnDI6lV0u+Mvq64z7fqzFe0lomPuz0ZmfRdcKnzA7t3Cyhs78uY/W8YzA
         eNobe5qDphw421Kk/2UikZbRM4dx946XEnxH3p5nhZYLl3osVEduGUrRYnfSDOfxJIRc
         AVIA==
X-Gm-Message-State: AOAM531zNKX/hmR1NYcB6xpIoOGsquaaqPYbUgsVd35gKoYti3ynTCiz
        qiKY6x4YPFF8Sn4bY1+WzI38YRZvAsYY7/yWHhk=
X-Google-Smtp-Source: ABdhPJwa4WaRWJZ2FL9jNUSCsccppk1hf32g/uV+OeB6mucj3lPd8nqW407fBdUXGu16INj7DAX/rk8+FX6WwEC4QRk=
X-Received: by 2002:a25:2a56:: with SMTP id q83mr8430303ybq.144.1611670656827;
 Tue, 26 Jan 2021 06:17:36 -0800 (PST)
MIME-Version: 1.0
References: <20210125085622.2322-1-candlesea@gmail.com> <CAKwvOd=b+ku7cd24KTYpNecYAUHxR5aBmrC1q+BL67+1YBHjzA@mail.gmail.com>
In-Reply-To: <CAKwvOd=b+ku7cd24KTYpNecYAUHxR5aBmrC1q+BL67+1YBHjzA@mail.gmail.com>
From:   Candle Sun <candlesea@gmail.com>
Date:   Tue, 26 Jan 2021 22:17:25 +0800
Message-ID: <CAPnx3XOMpHV96aF=A3978LAapV1dXU3YvFrqU=F-Oet8xpQYpA@mail.gmail.com>
Subject: Re: [PATCH] lkdtm: fix memory copy size for WRITE_KERN
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Candle Sun <candle.sun@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 5:16 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, Jan 25, 2021 at 12:56 AM Candle Sun <candlesea@gmail.com> wrote:
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
> >         return;
> >  }
> >
> >  /* Must immediately follow do_nothing for size calculuations to work out. */
> > -static void do_overwritten(void)
> > +static noinline void do_overwritten(void)
> >  {
> >         pr_info("do_overwritten wasn't overwritten!\n");
> >         return;
> > @@ -110,15 +110,14 @@ void lkdtm_WRITE_RO_AFTER_INIT(void)
> >
> >  void lkdtm_WRITE_KERN(void)
> >  {
> > -       size_t size;
> > -       volatile unsigned char *ptr;
> > +       unsigned long value_dow = (unsigned long)do_overwritten;
> > +       unsigned long value_do =  (unsigned long)do_nothing;
> > +       size_t size = (size_t)(value_dow > value_do ?
> > +                       value_dow - value_do : value_do - value_dow);
> >
> > -       size = (unsigned long)do_overwritten - (unsigned long)do_nothing;
>
> Thanks for the patch! Might it be simpler to do:
>
> size = abs((uintptr_t)do_overwritten - (uintptr_t)do_nothing));
>
> Then I don't think much of this function needs to be changed.
>

Thanks Nick.

abs() is better, I will check the patch.

Regards,
Candle


> > -       ptr = (unsigned char *)do_overwritten;
> > -
> > -       pr_info("attempting bad %zu byte write at %px\n", size, ptr);
> > -       memcpy((void *)ptr, (unsigned char *)do_nothing, size);
> > -       flush_icache_range((unsigned long)ptr, (unsigned long)(ptr + size));
> > +       pr_info("attempting bad %zu byte write at %px\n", size, do_overwritten);
> > +       memcpy((void *)value_dow, (void *)value_do, size);
> > +       flush_icache_range(value_dow, value_dow + (unsigned long)size);
> >         pr_err("FAIL: survived bad write\n");
> >
> >         do_overwritten();
> > --
> > 2.17.0
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers
