Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0662E039E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 02:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgLVBAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 20:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgLVBAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 20:00:43 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F47EC0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 17:00:03 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id m25so27992405lfc.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 17:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=unwUyXsIQFBGADwzup4YbErIrYsTO70qoKOp/mP9m7g=;
        b=kXMHYGhmBLXfy8WA818C/uCk+zQn58dRt9ezQbXbhwXOSn1neYEU2FsRJq+PcjZ+7G
         Mms0OaBI0P2fBY+L8QdFHspM8/y+ngvzSAnU3uGzdZ2LDEV7kW2d1XNB2KLxJcbGjZG8
         Rd7emn0wX94USg2kZgY8Uj4KhtWguc5vvX99U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=unwUyXsIQFBGADwzup4YbErIrYsTO70qoKOp/mP9m7g=;
        b=JjaP1b+IOvHEoMfa7Vs5cw/C+cydcWLOC97HzM0shORrMup2bPI1H0/T+Z9TjTUGkN
         w7/4hQ3n0/ADXZF/ijTgQ0XBoY7mspeefDVbnQQW52TbPFX2Do13PKGRXpwJ4IwlT5Oc
         oCK7NezRyUFGPvrLL4FNEI50CQ1E5c3s+/bBqhs+LyQoeO9E0eKKsKr2CavTYgxOALkM
         MzTtuIjf+YvzORXPubL56SRfY2eAewkxtzlJrVURxUEHMRFZ1r60tdpx7Yi2Z1PyhuzM
         EInWb7CJYid/YapexAn5d6mIF42Be4wNJg9CJmkFEr2omYv2CmASLLPWo3YPj8zTxNEW
         KHPg==
X-Gm-Message-State: AOAM532xMUrSvEnDcdperOlqMA6Y67dS99t3eiI3/bGvi81RihzNsDSf
        kvw47lJjnhmtUM8PA2aoethLM4c8B/rkMSQGmPQ6JA==
X-Google-Smtp-Source: ABdhPJyPNP8N6flp0lbEJVi3fEBAmkWtCyZJU32+Ia7rLGoNKKxkJWxPUTaUN0dRt7fmBUSguG511qx91AVMQkMSY9Q=
X-Received: by 2002:a05:6512:6cd:: with SMTP id u13mr7563309lff.288.1608598801791;
 Mon, 21 Dec 2020 17:00:01 -0800 (PST)
MIME-Version: 1.0
References: <18669bd607ae9efbf4e00e36532c7aa167d0fa12.camel@gmx.de>
 <20201220002228.38697-1-vitaly.wool@konsulko.com> <X+DaMSJE22nUC0tl@google.com>
 <CAM4kBBKnW6K-mbPno4SpvhUBiykP4zeFm_CNzssDkReURbuU7w@mail.gmail.com>
 <CALvZod69OtXkdOJPzuY5XfXz_ro0V7OmqW4OY9B_emqwroxW4w@mail.gmail.com>
 <e5cd8a0a5df84081a11359ede6e746bc@hisilicon.com> <CALvZod7EZnEWb_65FjSNdx+-S_4pLHyS5rYiU-D3hFLRMXS6Lw@mail.gmail.com>
 <8cc0e01fd03245a4994f2e0f54b264fa@hisilicon.com> <CAM4kBB+xUa8zXSRSuB0z5FCdPNmUpDfcC4Vqu7wzAkf0b+RXqw@mail.gmail.com>
 <f0ca46a830e54f4482fb4f46df9675f5@hisilicon.com>
In-Reply-To: <f0ca46a830e54f4482fb4f46df9675f5@hisilicon.com>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Tue, 22 Dec 2020 01:59:51 +0100
Message-ID: <CAM4kBBKD6MAOaBvwC_Wedf_zmzmt-gm=TrAF1Lh7pVbNtcsFZg@mail.gmail.com>
Subject: Re: [PATCH] zsmalloc: do not use bit_spin_lock
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Galbraith <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        NitinGupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 12:37 AM Song Bao Hua (Barry Song)
<song.bao.hua@hisilicon.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Song Bao Hua (Barry Song)
> > Sent: Tuesday, December 22, 2020 11:38 AM
> > To: 'Vitaly Wool' <vitaly.wool@konsulko.com>
> > Cc: Shakeel Butt <shakeelb@google.com>; Minchan Kim <minchan@kernel.org>; Mike
> > Galbraith <efault@gmx.de>; LKML <linux-kernel@vger.kernel.org>; linux-mm
> > <linux-mm@kvack.org>; Sebastian Andrzej Siewior <bigeasy@linutronix.de>;
> > NitinGupta <ngupta@vflare.org>; Sergey Senozhatsky
> > <sergey.senozhatsky.work@gmail.com>; Andrew Morton
> > <akpm@linux-foundation.org>
> > Subject: RE: [PATCH] zsmalloc: do not use bit_spin_lock
> >
> >
> >
> > > -----Original Message-----
> > > From: Vitaly Wool [mailto:vitaly.wool@konsulko.com]
> > > Sent: Tuesday, December 22, 2020 11:12 AM
> > > To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> > > Cc: Shakeel Butt <shakeelb@google.com>; Minchan Kim <minchan@kernel.org>;
> > Mike
> > > Galbraith <efault@gmx.de>; LKML <linux-kernel@vger.kernel.org>; linux-mm
> > > <linux-mm@kvack.org>; Sebastian Andrzej Siewior <bigeasy@linutronix.de>;
> > > NitinGupta <ngupta@vflare.org>; Sergey Senozhatsky
> > > <sergey.senozhatsky.work@gmail.com>; Andrew Morton
> > > <akpm@linux-foundation.org>
> > > Subject: Re: [PATCH] zsmalloc: do not use bit_spin_lock
> > >
> > > On Mon, Dec 21, 2020 at 10:30 PM Song Bao Hua (Barry Song)
> > > <song.bao.hua@hisilicon.com> wrote:
> > > >
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Shakeel Butt [mailto:shakeelb@google.com]
> > > > > Sent: Tuesday, December 22, 2020 10:03 AM
> > > > > To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> > > > > Cc: Vitaly Wool <vitaly.wool@konsulko.com>; Minchan Kim
> > > <minchan@kernel.org>;
> > > > > Mike Galbraith <efault@gmx.de>; LKML <linux-kernel@vger.kernel.org>;
> > > linux-mm
> > > > > <linux-mm@kvack.org>; Sebastian Andrzej Siewior <bigeasy@linutronix.de>;
> > > > > NitinGupta <ngupta@vflare.org>; Sergey Senozhatsky
> > > > > <sergey.senozhatsky.work@gmail.com>; Andrew Morton
> > > > > <akpm@linux-foundation.org>
> > > > > Subject: Re: [PATCH] zsmalloc: do not use bit_spin_lock
> > > > >
> > > > > On Mon, Dec 21, 2020 at 12:06 PM Song Bao Hua (Barry Song)
> > > > > <song.bao.hua@hisilicon.com> wrote:
> > > > > >
> > > > > >
> > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: Shakeel Butt [mailto:shakeelb@google.com]
> > > > > > > Sent: Tuesday, December 22, 2020 8:50 AM
> > > > > > > To: Vitaly Wool <vitaly.wool@konsulko.com>
> > > > > > > Cc: Minchan Kim <minchan@kernel.org>; Mike Galbraith <efault@gmx.de>;
> > > LKML
> > > > > > > <linux-kernel@vger.kernel.org>; linux-mm <linux-mm@kvack.org>; Song
> > > Bao
> > > > > Hua
> > > > > > > (Barry Song) <song.bao.hua@hisilicon.com>; Sebastian Andrzej Siewior
> > > > > > > <bigeasy@linutronix.de>; NitinGupta <ngupta@vflare.org>; Sergey
> > > > > Senozhatsky
> > > > > > > <sergey.senozhatsky.work@gmail.com>; Andrew Morton
> > > > > > > <akpm@linux-foundation.org>
> > > > > > > Subject: Re: [PATCH] zsmalloc: do not use bit_spin_lock
> > > > > > >
> > > > > > > On Mon, Dec 21, 2020 at 11:20 AM Vitaly Wool <vitaly.wool@konsulko.com>
> > > > > wrote:
> > > > > > > >
> > > > > > > > On Mon, Dec 21, 2020 at 6:24 PM Minchan Kim <minchan@kernel.org>
> > wrote:
> > > > > > > > >
> > > > > > > > > On Sun, Dec 20, 2020 at 02:22:28AM +0200, Vitaly Wool wrote:
> > > > > > > > > > zsmalloc takes bit spinlock in its _map() callback and releases
> > > it
> > > > > > > > > > only in unmap() which is unsafe and leads to zswap complaining
> > > > > > > > > > about scheduling in atomic context.
> > > > > > > > > >
> > > > > > > > > > To fix that and to improve RT properties of zsmalloc, remove
> > that
> > > > > > > > > > bit spinlock completely and use a bit flag instead.
> > > > > > > > >
> > > > > > > > > I don't want to use such open code for the lock.
> > > > > > > > >
> > > > > > > > > I see from Mike's patch, recent zswap change introduced the lockdep
> > > > > > > > > splat bug and you want to improve zsmalloc to fix the zswap bug
> > > and
> > > > > > > > > introduce this patch with allowing preemption enabling.
> > > > > > > >
> > > > > > > > This understanding is upside down. The code in zswap you are referring
> > > > > > > > to is not buggy.  You may claim that it is suboptimal but there is
> > > > > > > > nothing wrong in taking a mutex.
> > > > > > > >
> > > > > > >
> > > > > > > Is this suboptimal for all or just the hardware accelerators? Sorry,
> > > I
> > > > > > > am not very familiar with the crypto API. If I select lzo or lz4 as
> > > a
> > > > > > > zswap compressor will the [de]compression be async or sync?
> > > > > >
> > > > > > Right now, in crypto subsystem, new drivers are required to write based
> > > on
> > > > > > async APIs. The old sync API can't work in new accelerator drivers as
> > > they
> > > > > > are not supported at all.
> > > > > >
> > > > > > Old drivers are used to sync, but they've got async wrappers to support
> > > async
> > > > > > APIs. Eg.
> > > > > > crypto: acomp - add support for lz4 via scomp
> > > > > >
> > > > >
> > >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/
> > > > > crypto/lz4.c?id=8cd9330e0a615c931037d4def98b5ce0d540f08d
> > > > > >
> > > > > > crypto: acomp - add support for lzo via scomp
> > > > > >
> > > > >
> > >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/
> > > > > crypto/lzo.c?id=ac9d2c4b39e022d2c61486bfc33b730cfd02898e
> > > > > >
> > > > > > so they are supporting async APIs but they are still working in sync
> > mode
> > > > > as
> > > > > > those old drivers don't sleep.
> > > > > >
> > > > >
> > > > > Good to know that those are sync because I want them to be sync.
> > > > > Please note that zswap is a cache in front of a real swap and the load
> > > > > operation is latency sensitive as it comes in the page fault path and
> > > > > directly impacts the applications. I doubt decompressing synchronously
> > > > > a 4k page on a cpu will be costlier than asynchronously decompressing
> > > > > the same page from hardware accelerators.
> > > >
> > > > If you read the old paper:
> > > >
> > >
> > https://www.ibm.com/support/pages/new-linux-zswap-compression-functionalit
> > > y
> > > > Because the hardware accelerator speeds up compression, looking at the zswap
> > > > metrics we observed that there were more store and load requests in a given
> > > > amount of time, which filled up the zswap pool faster than a software
> > > > compression run. Because of this behavior, we set the max_pool_percent
> > > > parameter to 30 for the hardware compression runs - this means that zswap
> > > > can use up to 30% of the 10GB of total memory.
> > > >
> > > > So using hardware accelerators, we get a chance to speed up compression
> > > > while decreasing cpu utilization.
> > > >
> > > > BTW, If it is not easy to change zsmalloc, one quick workaround we might
> > do
> > > > in zswap is adding the below after applying Mike's original patch:
> > > >
> > > > if(in_atomic()) /* for zsmalloc */
> > > >         while(!try_wait_for_completion(&req->done);
> > > > else /* for zbud, z3fold */
> > > >         crypto_wait_req(....);
> > >
> > > I don't think I'm going to ack this, sorry.
> > >
> >
> > Fair enough. And I am also thinking if we can move zpool_unmap_handle()
> > quite after zpool_map_handle() as below:
> >
> >       dlen = PAGE_SIZE;
> >       src = zpool_map_handle(entry->pool->zpool, entry->handle, ZPOOL_MM_RO);
> >       if (zpool_evictable(entry->pool->zpool))
> >               src += sizeof(struct zswap_header);
> > +     zpool_unmap_handle(entry->pool->zpool, entry->handle);
> >
> >       acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
> >       mutex_lock(acomp_ctx->mutex);
> >       sg_init_one(&input, src, entry->length);
> >       sg_init_table(&output, 1);
> >       sg_set_page(&output, page, PAGE_SIZE, 0);
> >       acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length,
> > dlen);
> >       ret = crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req),
> > &acomp_ctx->wait);
> >       mutex_unlock(acomp_ctx->mutex);
> >
> > -     zpool_unmap_handle(entry->pool->zpool, entry->handle);
> >
> > Since src is always low memory and we only need its virtual address
> > to get the page of src in sg_init_one(). We don't actually read it
> > by CPU anywhere.
>
> The below code might be better:
>
>         dlen = PAGE_SIZE;
>         src = zpool_map_handle(entry->pool->zpool, entry->handle, ZPOOL_MM_RO);
>         if (zpool_evictable(entry->pool->zpool))
>                 src += sizeof(struct zswap_header);
>
>         acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
>
> +       zpool_unmap_handle(entry->pool->zpool, entry->handle);
>
>         mutex_lock(acomp_ctx->mutex);
>         sg_init_one(&input, src, entry->length);
>         sg_init_table(&output, 1);
>         sg_set_page(&output, page, PAGE_SIZE, 0);
>         acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length, dlen);
>         ret = crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait);
>         mutex_unlock(acomp_ctx->mutex);
>
> -       zpool_unmap_handle(entry->pool->zpool, entry->handle);

I don't see how this is going to work since we can't guarantee src
will be a valid pointer after the zpool_unmap_handle() call, can we?
Could you please elaborate?

~Vitaly

> >
> > > Best regards,
> > >    Vitaly
> > >
> > > > crypto_wait_req() is actually doing wait_for_completion():
> > > > static inline int crypto_wait_req(int err, struct crypto_wait *wait)
> > > > {
> > > >         switch (err) {
> > > >         case -EINPROGRESS:
> > > >         case -EBUSY:
> > > >                 wait_for_completion(&wait->completion);
> > > >                 reinit_completion(&wait->completion);
> > > >                 err = wait->err;
> > > >                 break;
> > > >         }
> > > >
> > > >         return err;
> > > > }
>
> Thanks
> Barry
