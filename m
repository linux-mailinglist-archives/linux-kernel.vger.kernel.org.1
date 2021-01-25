Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D1A302D77
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 22:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732573AbhAYVTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 16:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732046AbhAYVRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 16:17:02 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E27FC061573
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 13:16:12 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id p18so9784296pgm.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 13:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wm74RJgccV4nt5I3HNRsP32/z8JQEsiUVo0q4ED9Zx0=;
        b=F2BeYSYIgvRe3E/9fPWjBitEnA46rdQTqtsXSoHvy0+VDE7TQ9lOMNJDykbR0i4zmn
         pkOQfAhMzbhscXrv8j/rWkbVVux4G+0LWmXi1B2xZrEYNgt8UmXfdEtAm8Xzwpwqgj7o
         GuFgqdEIV7G/rNcqlls2D8YQR/21lXHXhpXn4HkoPaQbt1afaXLdgr5kmTV3SjOE0IiD
         4qXiFJYeOn5MXBS577tfe1uPcj4OWId9xdMHJjwKhsqwtlEp8oKdJ1eKtzS+wc7GZeU4
         Csr0DvTxt5hr+/l+qj2g/tfhZmmS1wbsO5DdAn2dpmmF5WEkHZRe2djJqHu7J/8KQ0l1
         ME8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wm74RJgccV4nt5I3HNRsP32/z8JQEsiUVo0q4ED9Zx0=;
        b=rHl8EOKs9F40xkGO8jo/P4FJ87gANK0rbib5cNvQxFKR0XR11a93U8YLnht4YgBZDc
         1D8QZoLgkz//gud5J1xr65N/D0g2ENi5j0f0N7vAmBQOl0+8NuLSGqZC+ZMAMRwmlenB
         2/KVvPoNtjCV5+p5/r5kmFqfp7FPJu5jdX9X8Vo8/HisDBbz3olXxHpERr6INE+GKdmg
         0BDaBQLvwTAtpooHvpTjv1QrJK8Pp3ImKO/c0Nunzgqheb52b2MJGWMHbifu7GRehWNP
         rGCpifwX8VTpX2Ln5/YIfKlKfip55tW9IhZS02vpr7vQNo+ToTvh9SlVRzuwfw74ZyYA
         kmoA==
X-Gm-Message-State: AOAM533i2x7/LVVzNEFr0Gre2vsWv+6nu9VLllUdDGPt5+5aBJqEsc7e
        1TdjhIY+R6KrlT27W/XWA3uuXjcIIO/83cUrHy15og==
X-Google-Smtp-Source: ABdhPJzz2ZRuAlCclJYeQoHFwLT4Lea+GLNR+8pXIJM8T49NNuidxr1qFmaBZYtC7eyhc4eTi3U0QUb1kp50iSumYYc=
X-Received: by 2002:a63:7e10:: with SMTP id z16mr2423055pgc.263.1611609371873;
 Mon, 25 Jan 2021 13:16:11 -0800 (PST)
MIME-Version: 1.0
References: <20210125085622.2322-1-candlesea@gmail.com>
In-Reply-To: <20210125085622.2322-1-candlesea@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 25 Jan 2021 13:16:01 -0800
Message-ID: <CAKwvOd=b+ku7cd24KTYpNecYAUHxR5aBmrC1q+BL67+1YBHjzA@mail.gmail.com>
Subject: Re: [PATCH] lkdtm: fix memory copy size for WRITE_KERN
To:     Candle Sun <candlesea@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        candle.sun@unisoc.com, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 12:56 AM Candle Sun <candlesea@gmail.com> wrote:
>
> From: Candle Sun <candle.sun@unisoc.com>
>
> Though do_overwritten() follows do_nothing() in source code, the final
> memory address order is determined by compiler. We can't always assume
> address of do_overwritten() is bigger than do_nothing(). At least the
> Clang we are using places do_overwritten() before do_nothing() in the
> object. This causes the copy size in lkdtm_WRITE_KERN() is *really*
> big and WRITE_KERN test on ARM32 arch will fail.
>
> Compare the address order before doing the subtraction.
>
> Signed-off-by: Candle Sun <candle.sun@unisoc.com>
> ---
>  drivers/misc/lkdtm/perms.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
> index 2dede2ef658f..fbfbdf89d668 100644
> --- a/drivers/misc/lkdtm/perms.c
> +++ b/drivers/misc/lkdtm/perms.c
> @@ -31,13 +31,13 @@ static unsigned long ro_after_init __ro_after_init = 0x55AA5500;
>   * This just returns to the caller. It is designed to be copied into
>   * non-executable memory regions.
>   */
> -static void do_nothing(void)
> +static noinline void do_nothing(void)
>  {
>         return;
>  }
>
>  /* Must immediately follow do_nothing for size calculuations to work out. */
> -static void do_overwritten(void)
> +static noinline void do_overwritten(void)
>  {
>         pr_info("do_overwritten wasn't overwritten!\n");
>         return;
> @@ -110,15 +110,14 @@ void lkdtm_WRITE_RO_AFTER_INIT(void)
>
>  void lkdtm_WRITE_KERN(void)
>  {
> -       size_t size;
> -       volatile unsigned char *ptr;
> +       unsigned long value_dow = (unsigned long)do_overwritten;
> +       unsigned long value_do =  (unsigned long)do_nothing;
> +       size_t size = (size_t)(value_dow > value_do ?
> +                       value_dow - value_do : value_do - value_dow);
>
> -       size = (unsigned long)do_overwritten - (unsigned long)do_nothing;

Thanks for the patch! Might it be simpler to do:

size = abs((uintptr_t)do_overwritten - (uintptr_t)do_nothing));

Then I don't think much of this function needs to be changed.

> -       ptr = (unsigned char *)do_overwritten;
> -
> -       pr_info("attempting bad %zu byte write at %px\n", size, ptr);
> -       memcpy((void *)ptr, (unsigned char *)do_nothing, size);
> -       flush_icache_range((unsigned long)ptr, (unsigned long)(ptr + size));
> +       pr_info("attempting bad %zu byte write at %px\n", size, do_overwritten);
> +       memcpy((void *)value_dow, (void *)value_do, size);
> +       flush_icache_range(value_dow, value_dow + (unsigned long)size);
>         pr_err("FAIL: survived bad write\n");
>
>         do_overwritten();
> --
> 2.17.0
>


-- 
Thanks,
~Nick Desaulniers
