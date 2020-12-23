Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFD9F2E2065
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 19:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgLWSZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 13:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbgLWSZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 13:25:55 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BC7C061794
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 10:25:14 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 23so42111260lfg.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 10:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rj6/Dlwh7nWS85N+l88/kl+tTMzJUe3ne4CIKIL+xj4=;
        b=qwajSBPNsTsASZaI6zvSSvcAN8Bu6eFYc6eqKZSMuj+MVWZGvpbcYnTaKwNj+P+zfK
         HzZODnV+GayVqTTnUoagFyQaVaMY1nqnwMLM6isamOWPcV0xkeOUtyt9TimaqRdZs4ov
         FKl50F8UcDnpdOkcDIYrbD/ukUva0/v7rnKlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rj6/Dlwh7nWS85N+l88/kl+tTMzJUe3ne4CIKIL+xj4=;
        b=uoXYT6Xa4xpxyqPOf0tlDjZz2voN3r7JnRqNeuQQztAqDys5xIkj0fCrB1wfNL2EKL
         NPPv7ziet94dzsjFmElnviMe2DAMWGQ+bzkitOQl59v0EyWibki8PYDEHUIuF61CTQkv
         Bhyvu7eBjXCZHU7pPAYgU7/GuDQvzqk7U87esJMKXF4CFGNe51vurdRPXN2LT/8T8nic
         BYmRuVGwkZi5u9sRgI5ZKxom/7RgUYtlBT6Rnwm9QtXrQ6wXMlAbas4T9uLM1v29uf85
         0Fjnr2X0ghag9Sv5lzyT1dZOxNVeeqwwuStZxKlkusE0sUU1hTQBk66Ts1I59CvNsyuQ
         cDKA==
X-Gm-Message-State: AOAM532iSxFdptjkXSIOnYyRWabpbn4kBP+Tsj4N8mkl5N0nClT7FYph
        HzICQ6W/R+urC+YyUs6gkmrL7bWoc45+5O2iMo+kRNVCujNNa3Av
X-Google-Smtp-Source: ABdhPJwZximS6HauH4Eb9O9KQxyRmZIgw2mG+klPIOLa3GdHK0PrzQxMb2Z5ra+PhqBqAuM9Lv8gFJ7kZoJBrbpETY0=
X-Received: by 2002:a2e:b8c4:: with SMTP id s4mr10032001ljp.269.1608747913090;
 Wed, 23 Dec 2020 10:25:13 -0800 (PST)
MIME-Version: 1.0
References: <18669bd607ae9efbf4e00e36532c7aa167d0fa12.camel@gmx.de>
 <20201220002228.38697-1-vitaly.wool@konsulko.com> <X+DaMSJE22nUC0tl@google.com>
 <CAM4kBBKnW6K-mbPno4SpvhUBiykP4zeFm_CNzssDkReURbuU7w@mail.gmail.com>
 <CALvZod69OtXkdOJPzuY5XfXz_ro0V7OmqW4OY9B_emqwroxW4w@mail.gmail.com>
 <e5cd8a0a5df84081a11359ede6e746bc@hisilicon.com> <CALvZod7EZnEWb_65FjSNdx+-S_4pLHyS5rYiU-D3hFLRMXS6Lw@mail.gmail.com>
 <8cc0e01fd03245a4994f2e0f54b264fa@hisilicon.com> <CAM4kBB+xUa8zXSRSuB0z5FCdPNmUpDfcC4Vqu7wzAkf0b+RXqw@mail.gmail.com>
 <f0ca46a830e54f4482fb4f46df9675f5@hisilicon.com> <CAM4kBBKD6MAOaBvwC_Wedf_zmzmt-gm=TrAF1Lh7pVbNtcsFZg@mail.gmail.com>
 <4490cb6a7e2243fba374e40652979e46@hisilicon.com> <CAM4kBBK=5eBdCjWc5VJXcdr=Z4PV1=ZQ2n8fZmJ6ahJbpUyv2A@mail.gmail.com>
 <08cbef1e43634c4099709be8e99e5d27@hisilicon.com> <CAM4kBBJjCYX0DQZ8de9LsFV6L+eF4tZe-NN=jiAz9WLWYrsCsQ@mail.gmail.com>
 <1d0d4a3576e74d128d7849342a7e9faf@hisilicon.com> <CAM4kBB+uRrnpta908Gf93VfH90NVpmqv4jNY2kxrrGSdWApz_w@mail.gmail.com>
 <4e686c73-b453-e714-021a-1fcd0a565984@huawei.com>
In-Reply-To: <4e686c73-b453-e714-021a-1fcd0a565984@huawei.com>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Wed, 23 Dec 2020 19:25:02 +0100
Message-ID: <CAM4kBB+jtJd5mqBby7j+ou-AxvPgCU777pX4cnwneLi8P4U+7g@mail.gmail.com>
Subject: Re: [PATCH] zsmalloc: do not use bit_spin_lock
To:     "tiantao (H)" <tiantao6@huawei.com>
Cc:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Shakeel Butt <shakeelb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Galbraith <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        NitinGupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "tiantao (H)" <tiantao6@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 1:44 PM tiantao (H) <tiantao6@huawei.com> wrote:
>
>
> =E5=9C=A8 2020/12/23 8:11, Vitaly Wool =E5=86=99=E9=81=93:
> > On Tue, 22 Dec 2020, 22:06 Song Bao Hua (Barry Song),
> > <song.bao.hua@hisilicon.com> wrote:
> >>
> >>
> >>> -----Original Message-----
> >>> From: Vitaly Wool [mailto:vitaly.wool@konsulko.com]
> >>> Sent: Tuesday, December 22, 2020 10:44 PM
> >>> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> >>> Cc: Shakeel Butt <shakeelb@google.com>; Minchan Kim <minchan@kernel.o=
rg>; Mike
> >>> Galbraith <efault@gmx.de>; LKML <linux-kernel@vger.kernel.org>; linux=
-mm
> >>> <linux-mm@kvack.org>; Sebastian Andrzej Siewior <bigeasy@linutronix.d=
e>;
> >>> NitinGupta <ngupta@vflare.org>; Sergey Senozhatsky
> >>> <sergey.senozhatsky.work@gmail.com>; Andrew Morton
> >>> <akpm@linux-foundation.org>; tiantao (H) <tiantao6@hisilicon.com>
> >>> Subject: Re: [PATCH] zsmalloc: do not use bit_spin_lock
> >>>
> >>> On Tue, 22 Dec 2020, 03:11 Song Bao Hua (Barry Song),
> >>> <song.bao.hua@hisilicon.com> wrote:
> >>>>
> >>>>
> >>>>> -----Original Message-----
> >>>>> From: Song Bao Hua (Barry Song)
> >>>>> Sent: Tuesday, December 22, 2020 3:03 PM
> >>>>> To: 'Vitaly Wool' <vitaly.wool@konsulko.com>
> >>>>> Cc: Shakeel Butt <shakeelb@google.com>; Minchan Kim <minchan@kernel=
.org>;
> >>> Mike
> >>>>> Galbraith <efault@gmx.de>; LKML <linux-kernel@vger.kernel.org>; lin=
ux-mm
> >>>>> <linux-mm@kvack.org>; Sebastian Andrzej Siewior <bigeasy@linutronix=
.de>;
> >>>>> NitinGupta <ngupta@vflare.org>; Sergey Senozhatsky
> >>>>> <sergey.senozhatsky.work@gmail.com>; Andrew Morton
> >>>>> <akpm@linux-foundation.org>; tiantao (H) <tiantao6@hisilicon.com>
> >>>>> Subject: RE: [PATCH] zsmalloc: do not use bit_spin_lock
> >>>>>
> >>>>>
> >>>>>> I'm still not convinced. Will kmap what, src? At this point src mi=
ght
> >>> become
> >>>>> just a bogus pointer.
> >>>>>
> >>>>> As long as the memory is still there, we can kmap it by its page st=
ruct.
> >>> But
> >>>>> if
> >>>>> it is not there anymore, we have no way.
> >>>>>
> >>>>>> Why couldn't the object have been moved somewhere else (due to the=
 compaction
> >>>>> mechanism for instance)
> >>>>>> at the time DMA kicks in?
> >>>>> So zs_map_object() will guarantee the src won't be moved by holding=
 those
> >>>>> preemption-disabled lock?
> >>>>> If so, it seems we have to drop the MOVABLE gfp in zswap for zsmall=
oc case?
> >>>>>
> >>>> Or we can do get_page() to avoid the movement of the page.
> >>>
> >>> I would like to discuss this more in zswap context than zsmalloc's.
> >>> Since zsmalloc does not implement reclaim callback, using it in zswap
> >>> is a corner case anyway.
> >> I see. But it seems we still need a solution for the compatibility
> >> of zsmalloc and zswap? this will require change in either zsmalloc
> >> or zswap.
> >> or do you want to make zswap depend on !ZSMALLOC?
> > No, I really don't think we should go that far. What if we add a flag
> > to zpool, named like "can_sleep_mapped", and have it set for
> > zbud/z3fold?
> > Then zswap could go the current path if the flag is set; and if it's
> > not set, and mutex_trylock fails, copy data from src to a temporary
> > buffer, then unmap the handle, take the mutex, process the buffer
> > instead of src. Not the nicest thing to do but at least it won't break
> > anything.
>
> write the following patch according to your idea, what do you think ?

Yep, that is basically what I was thinking of. Some nitpicks below:

> --- a/mm/zswap.c
>
> +++ b/mm/zswap.c
> @@ -1235,7 +1235,7 @@ static int zswap_frontswap_load(unsigned type,
> pgoff_t offset,
>          struct zswap_entry *entry;
>          struct scatterlist input, output;
>          struct crypto_acomp_ctx *acomp_ctx;
> -       u8 *src, *dst;
> +       u8 *src, *dst, *tmp;
>          unsigned int dlen;
>          int ret;
>
> @@ -1262,16 +1262,26 @@ static int zswap_frontswap_load(unsigned type,
> pgoff_t offset,
>          if (zpool_evictable(entry->pool->zpool))
>                  src +=3D sizeof(struct zswap_header);
>
> +       if (!zpool_can_sleep_mapped(entry->pool->zpool) &&
> !mutex_trylock(acomp_ctx->mutex)) {
> +               tmp =3D kmemdup(src, entry->length, GFP_ATOMIC);

kmemdump? just use memcpy :)

> +               zpool_unmap_handle(entry->pool->zpool, entry->handle); ??=
?
> +               if (!tmp)
> +                       goto freeentry;

Jumping to freentry results in returning success which isn't
appropriate here. You should return -ENOMEM in this case.

> +       }
>          acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
>          mutex_lock(acomp_ctx->mutex);
> -       sg_init_one(&input, src, entry->length);
> +       sg_init_one(&input, zpool_can_sleep_mapped(entry->pool->zpool) ?
> src : tmp, entry->length);

This is kind of hard to read, I would rather assign src to tmp after
memcpy and then no condition check would be needed here.

>          sg_init_table(&output, 1);
>          sg_set_page(&output, page, PAGE_SIZE, 0);
>          acomp_request_set_params(acomp_ctx->req, &input, &output,
> entry->length, dlen);
>          ret =3D crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req),
> &acomp_ctx->wait);
>          mutex_unlock(acomp_ctx->mutex);
>
> -       zpool_unmap_handle(entry->pool->zpool, entry->handle);
> +       if (zpool_can_sleep_mapped(entry->pool->zpool))
> +               zpool_unmap_handle(entry->pool->zpool, entry->handle);
> +       else
> +               kfree(tmp);
> +
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -440,6 +440,7 @@ static u64 zs_zpool_total_size(void *pool)
>
>   static struct zpool_driver zs_zpool_driver =3D {
>          .type =3D                   "zsmalloc",
> +       .sleep_mapped =3D           false,
>          .owner =3D                  THIS_MODULE,
>          .create =3D                 zs_zpool_create,
>          .destroy =3D                zs_zpool_destroy,

Best regards,
   Vitaly

> >
> > ~Vitaly
> >
> >>> zswap, on the other hand, may be dealing with some new backends in
> >>> future which have more chances to become mainstream. Imagine typical
> >>> NUMA-like cases, i. e. a zswap pool allocated in some kind SRAM, or i=
n
> >>> unused video memory. In such a case if you try to use a pointer to an
> >>> invalidated zpool mapping, you are on the way to thrash the system.
> >>> So: no assumptions that the zswap pool is in regular linear RAM shoul=
d
> >>> be made.
> >>>
> >>> ~Vitaly
> >> Thanks
> >> Barry
>
