Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC8F2EF74C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 19:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbhAHS0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 13:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbhAHS0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 13:26:20 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FE8C061380
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 10:25:40 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id x18so6089530pln.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 10:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TvvXV7bEAAhRZbN5Xzp/cblWdK/NVPGWOn4od85Z6/w=;
        b=d+L+HGQnJ8GkivLJcq4DSA2uJmUEaepv00NVO6HXnXJPKMFc+PtcXC1FqGYoEuOMyT
         s0pXM7/rVZSEDTRSIpT0t7Rd5Ha5ua5EkBbHlDLbrV82y4x5LFvv9+DKrxf2mNewLhOA
         oGwdlDMpLGuBuvDgbAgAeHZWF4BmA3bl/h5vs5xK9x43q3QakNcdeCuV+Edzegzk8S3f
         XLZDkOrFMrItw47dJOMCaGb0qkDDVq8mYsC6UXU0Z9t0t09FLfNAqWiikYHfXz6MSSBq
         4GKoC01+QiIWSjcxFl8QSUjD9ZlV+xv8AnZlaqcp4j+Jdg9qGFXMYI3dAmqV8mLxDtVQ
         z4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TvvXV7bEAAhRZbN5Xzp/cblWdK/NVPGWOn4od85Z6/w=;
        b=N2k/gN7qbfQct4S8jiKvC490dVE8fu46bv4wMMR4gp/bOo4AcjUbdvDKfPhsx+bDcW
         L9SnE69SZXlYR59kUvAkZAdePqLS2Ye563wf73/N4FgR7pipXbLmeJVJtxqA/9VIXLFq
         Ohk+NBo2oKd+Iy77sEJT7/atUA3H1ZZq8Ann4mK07fUU5X+3TlHs9ZTz5qG2jYiqlext
         ZUttbBMTfxJQyp9HE7tCaZ6G7oayENTyyXPGezo/7XdGfPO1IqsjMNrdHt3H/kfOV22k
         LOxLf5SJPIWVsGeWskv4lj0oZRUDRJB/vCoBlDcA6ODYIFFtr9nIk9gHf1JXzEBHFaOh
         yY2w==
X-Gm-Message-State: AOAM533Xekv6HMDtrQiHWVZ0zU8+6k/utTdAziVRCk9VVe3/087a+4Bd
        Qj49XweOKj4MP5VRFvjUNiDcxcGbFaJPfwIGnSeg3g==
X-Google-Smtp-Source: ABdhPJyeJJzO6h/di2HJL1UmMv07+bcKcaBYuL/EVRKkCR5n8bUJwaYA/emooOx9egKITTXFLdGAXEu23w8IL5O6hTg=
X-Received: by 2002:a17:902:9009:b029:dc:52a6:575 with SMTP id
 a9-20020a1709029009b02900dc52a60575mr4902482plp.57.1610130339630; Fri, 08 Jan
 2021 10:25:39 -0800 (PST)
MIME-Version: 1.0
References: <20210103063847.5963-1-lecopzer@gmail.com>
In-Reply-To: <20210103063847.5963-1-lecopzer@gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 8 Jan 2021 19:25:28 +0100
Message-ID: <CAAeHK+z_+sgoJbi8ULJYKdcNoB9WET8pRbkD7MvK+yp6k5sk4A@mail.gmail.com>
Subject: Re: [PATCH] kasan: fix incorrect arguments passing in kasan_add_zero_shadow
To:     Lecopzer Chen <lecopzer@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mediatek@lists.infradead.org, yj.chiang@mediatek.com,
        Lecopzer Chen <lecopzer.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 3, 2021 at 7:39 AM Lecopzer Chen <lecopzer@gmail.com> wrote:
>
> kasan_remove_zero_shadow() shall use original virtual address, start
> and size, instead of shadow address.
>
> Fixes: 0207df4fa1a86 ("kernel/memremap, kasan: make ZONE_DEVICE with work with KASAN")
> Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> ---
>  mm/kasan/init.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/mm/kasan/init.c b/mm/kasan/init.c
> index bc0ad208b3a7..67051cfae41c 100644
> --- a/mm/kasan/init.c
> +++ b/mm/kasan/init.c
> @@ -481,7 +481,6 @@ int kasan_add_zero_shadow(void *start, unsigned long size)
>
>         ret = kasan_populate_early_shadow(shadow_start, shadow_end);
>         if (ret)
> -               kasan_remove_zero_shadow(shadow_start,
> -                                       size >> KASAN_SHADOW_SCALE_SHIFT);
> +               kasan_remove_zero_shadow(start, size);
>         return ret;
>  }
> --
> 2.25.1

Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
