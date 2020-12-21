Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 251D62E013D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 20:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgLUTvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 14:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgLUTvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 14:51:11 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFA4C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 11:50:30 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id h205so26513608lfd.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 11:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xqmRYxnikPCq9Gg2hYUnPNz7l0TnTiioQ91HmpF8cHA=;
        b=Lbdw5kBkygrGYB8qOV/e44EUiRWpjNlF0K8JCBtD6ySkL7I6G//EbNDFNDUtCcBXoi
         K+zWPcc+uyHkHNaNbR8G6Dcg0SBkp/HYRbrV40nT7q4MYjmpiWMlFFOTlImixUfGTUb6
         8AimKwng3RUWgDPVaqMZnmqhIhiU6RkNlqwyHL7eu12F4zaNgotyJLibOvX3hbgTu0Pj
         DesLPBAzm2RiT5BM5teRxFH/grBcEm4VCiOBSjGJQHr2GXJ5sXE8bm3XmqgtxnI5IIgY
         yEA13HmGRIO2VLpQmrySNWxiEEDYidT3ylSG+DvordKln3mkGma0h5ISMCrc0Q7ETCyI
         38HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xqmRYxnikPCq9Gg2hYUnPNz7l0TnTiioQ91HmpF8cHA=;
        b=Il5DHw9D48an+hjkoj3/THh9l6FGEhpdd5PFRmyNyZ1Oo/XX8ohO4IrlTltX4cdccj
         TSJZa3Vu0Wrf9HqZ71eyyillOsGKmXNsRjJCLJlVyM4TKIU+Y1Hw1Aj7AyGdVUWzKFtL
         gHpa3ZGIWgSkrYQ75R1NXQzuF4v6lBbj6lHOkbIQeps2z/xOLacX6KF4hCesZy7KegFW
         o/UXKrhk/l27RovakO/wT10h4CAkzlioGe+HNfjMvRnLGhaRWg/QDp0Y1TnKSeXF5QcX
         VsQ36JYw8ZWRslkUaLAUQrZ7DP1mczmIC7CbZoOcGo3JRFDaLQBH7Rs6hWch/pZ/vdmd
         XG0w==
X-Gm-Message-State: AOAM532PwsI8pKtUN0zvyQZ2FnkIksMdUdDoyPMlezIbBt4mJ55TN9Wp
        evRQUwiaghrN96wUchfLpbRpq/gjbVgHb+PIEGcGyA==
X-Google-Smtp-Source: ABdhPJxnHF3lgjv4wK6z/Y0RWoJLdh0bkRjwcQOK4yZ9LuRUu9O/PpGzE3gf+Aib+VErHRK2pcCflmqzHK+vd9aR21I=
X-Received: by 2002:a2e:850f:: with SMTP id j15mr7797655lji.34.1608580229003;
 Mon, 21 Dec 2020 11:50:29 -0800 (PST)
MIME-Version: 1.0
References: <18669bd607ae9efbf4e00e36532c7aa167d0fa12.camel@gmx.de>
 <20201220002228.38697-1-vitaly.wool@konsulko.com> <X+DaMSJE22nUC0tl@google.com>
 <CAM4kBBKnW6K-mbPno4SpvhUBiykP4zeFm_CNzssDkReURbuU7w@mail.gmail.com>
In-Reply-To: <CAM4kBBKnW6K-mbPno4SpvhUBiykP4zeFm_CNzssDkReURbuU7w@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 21 Dec 2020 11:50:17 -0800
Message-ID: <CALvZod69OtXkdOJPzuY5XfXz_ro0V7OmqW4OY9B_emqwroxW4w@mail.gmail.com>
Subject: Re: [PATCH] zsmalloc: do not use bit_spin_lock
To:     Vitaly Wool <vitaly.wool@konsulko.com>
Cc:     Minchan Kim <minchan@kernel.org>, Mike Galbraith <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        NitinGupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 11:20 AM Vitaly Wool <vitaly.wool@konsulko.com> wrote:
>
> On Mon, Dec 21, 2020 at 6:24 PM Minchan Kim <minchan@kernel.org> wrote:
> >
> > On Sun, Dec 20, 2020 at 02:22:28AM +0200, Vitaly Wool wrote:
> > > zsmalloc takes bit spinlock in its _map() callback and releases it
> > > only in unmap() which is unsafe and leads to zswap complaining
> > > about scheduling in atomic context.
> > >
> > > To fix that and to improve RT properties of zsmalloc, remove that
> > > bit spinlock completely and use a bit flag instead.
> >
> > I don't want to use such open code for the lock.
> >
> > I see from Mike's patch, recent zswap change introduced the lockdep
> > splat bug and you want to improve zsmalloc to fix the zswap bug and
> > introduce this patch with allowing preemption enabling.
>
> This understanding is upside down. The code in zswap you are referring
> to is not buggy.  You may claim that it is suboptimal but there is
> nothing wrong in taking a mutex.
>

Is this suboptimal for all or just the hardware accelerators? Sorry, I
am not very familiar with the crypto API. If I select lzo or lz4 as a
zswap compressor will the [de]compression be async or sync?

> > https://lore.kernel.org/linux-mm/fae85e4440a8ef6f13192476bd33a4826416fc58.camel@gmx.de/
> >
> > zs_[un/map]_object is designed to be used in fast path(i.e.,
> > zs_map_object/4K page copy/zs_unmap_object) so the spinlock is
> > perfectly fine for API point of view. However, zswap introduced
> > using the API with mutex_lock/crypto_wait_req where allowing
> > preemption, which was wrong.
>
> Taking a spinlock in one callback and releasing it in another is
> unsafe and error prone. What if unmap was called on completion of a
> DMA-like transfer from another context, like a threaded IRQ handler?
> In that case this spinlock might never be released.
>
> Anyway I can come up with a zswap patch explicitly stating that
> zsmalloc is not fully compliant with zswap / zpool API

The documentation of zpool_map_handle() clearly states "This may hold
locks, disable interrupts, and/or preemption, ...", so how come
zsmalloc is not fully compliant?

> to avoid
> confusion for the time being. Would that be ok with you?
>
> Best regards,
>    Vitaly
>
