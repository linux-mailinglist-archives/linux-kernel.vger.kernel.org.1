Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84A52A2892
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 11:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbgKBK5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 05:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbgKBK5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 05:57:03 -0500
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B7DC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 02:57:03 -0800 (PST)
Received: by mail-oo1-xc42.google.com with SMTP id p73so3252495oop.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 02:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZpPBU3QM3/7qelIiuBLBizPgHkVin6kKZK0Z8ZdghC4=;
        b=c0hABj4YUTmfLgWLVwl+kg4Iwq5XcEo8JRKJyzK647r/RzUc5JTtqQ4MA71A46Qij8
         oO2ULOpQ75/pFkjH07OEUAeu/XvoJdJhuVKH4/veKatdzx1boVwJAhEaVRJoWPhZVBTN
         ky/COJ7kJFWF+IQCME4E1WGbVSM/RNG5VABGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZpPBU3QM3/7qelIiuBLBizPgHkVin6kKZK0Z8ZdghC4=;
        b=enBpT5ocpy0Uuan9IFXpxzv+YbK1pIPVEcJirmgHSsTWJf8/qZUXIgiqFX6W0ZpiTk
         Cn2xulHqz7fpNl+U0wdVeLG8Tpvgi/1sSW19UZIWYz9gPP7caxqps17SdmjDhnchsnh8
         zlWLyC3l9qnrFFPefiQBzxNOvsrWIADKp5kybjQHLx6yyVVn9h5q4blC79c2bxNt3EJ7
         KfegvvLg2XGvq4Fz2BouZbTHNGp7f3ivSginTmehHuCBSMWVe3AmfbETbtY2OZfglXfV
         i95AC+l/4fgETpTndjvV84TMcpH2CxOyRgUJNvZHWyQhJgqC94OF//18bYgl7YQq2Pn8
         qloQ==
X-Gm-Message-State: AOAM533oGj4ltiqpX196YJwBeF/6wq1LIELtI++VHwasnQCK7wKq2E74
        bX9i6IWDEl0fijE35nP7zKHfIuVTPAEWNF8LuvPz0w==
X-Google-Smtp-Source: ABdhPJzuWqQobkfk12bxO0YScYGHHffBlLOot4xLqfI3ygrAVAhO1WltLroxHgFNMa0u0wHQQ+InlzJyHaxjLHnTb54=
X-Received: by 2002:a4a:b503:: with SMTP id r3mr11468650ooo.28.1604314622422;
 Mon, 02 Nov 2020 02:57:02 -0800 (PST)
MIME-Version: 1.0
References: <20201030181822.570402-1-lee.jones@linaro.org>
In-Reply-To: <20201030181822.570402-1-lee.jones@linaro.org>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Mon, 2 Nov 2020 11:56:51 +0100
Message-ID: <CAKMK7uFN31B0WNoY5P0hizLCVxVkaFkcYjhgYVo1c2W+1d7jxA@mail.gmail.com>
Subject: Re: [PATCH 1/1] Fonts: font_acorn_8x8: Replace discarded const qualifier
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 7:18 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Commit 09e5b3fd5672 ("Fonts: Support FONT_EXTRA_WORDS macros for
> built-in fonts") introduced the following error when building
> rpc_defconfig (only this build appears to be affected):
>
>  `acorndata_8x8' referenced in section `.text' of arch/arm/boot/compressed/ll_char_wr.o:
>     defined in discarded section `.data' of arch/arm/boot/compressed/font.o
>  `acorndata_8x8' referenced in section `.data.rel.ro' of arch/arm/boot/compressed/font.o:
>     defined in discarded section `.data' of arch/arm/boot/compressed/font.o
>  make[3]: *** [/scratch/linux/arch/arm/boot/compressed/Makefile:191: arch/arm/boot/compressed/vmlinux] Error 1
>  make[2]: *** [/scratch/linux/arch/arm/boot/Makefile:61: arch/arm/boot/compressed/vmlinux] Error 2
>  make[1]: *** [/scratch/linux/arch/arm/Makefile:317: zImage] Error 2
>
> The .data section is discarded at link time.  Reinstating
> acorndata_8x8 as const ensures it is still available after linking.
>
> Cc: <stable@vger.kernel.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Shouldn't we add the const to all of them, for consistency?
-Daniel

> ---
>  lib/fonts/font_acorn_8x8.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/fonts/font_acorn_8x8.c b/lib/fonts/font_acorn_8x8.c
> index 069b3e80c4344..fb395f0d40317 100644
> --- a/lib/fonts/font_acorn_8x8.c
> +++ b/lib/fonts/font_acorn_8x8.c
> @@ -5,7 +5,7 @@
>
>  #define FONTDATAMAX 2048
>
> -static struct font_data acorndata_8x8 = {
> +static const struct font_data acorndata_8x8 = {
>  { 0, 0, FONTDATAMAX, 0 }, {
>  /* 00 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* ^@ */
>  /* 01 */  0x7e, 0x81, 0xa5, 0x81, 0xbd, 0x99, 0x81, 0x7e, /* ^A */
> --
> 2.25.1
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
