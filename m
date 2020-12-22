Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF272E083C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 10:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgLVJpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 04:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgLVJpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 04:45:05 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F3EC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 01:44:24 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id o19so30568428lfo.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 01:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r18epwnRXAAeayNJqVatwdsRgeDOVYhFQb9Xlfe0Jcw=;
        b=OqmApOAo4JAUPhMDwOsf2TTVhUc2ozQSpwxJixURCslXdBDYUDflFO7isq3J3274FA
         NuFhqJBbxwL2xOS8VCoYQ3kQWveiXyNL+eSNTsTosRGPcLDDAd04CQs92r9J/6+Kc/uv
         ND4T3j2gGmDBV71u+zAP0nYjjhTmpco04/iCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r18epwnRXAAeayNJqVatwdsRgeDOVYhFQb9Xlfe0Jcw=;
        b=rmV+cR6W7HVM0bl1J6/jxyeTNIrcM4c+rNUso1mXx5kcZffh3H5e1dOV4lOlPBkIDg
         3DR+4SvhMZMm8wKy0RZRvFEcR62NSZiNZY7cylxsPl9yvACGDumT3zY4fMShRfSz3x7J
         t7IAVmpfMS9fPia3ZkN2aBC3DMyKr3BKKLlFGtkNlqADOV3uPgOK426qUAJsTzoNC9b5
         TzeDz20BwfR/sVXKdF8jgs/Yme6WZTrDPlGOVYZpya1LY5zD9KwvzJhVSgv2RxoZhcEd
         MpAC/iBmUjABD4uWkZIImaQNadnkwudd9P0eG0kgd+Z3XYr/pLULpSXbaoB+q4NpolIo
         q1hw==
X-Gm-Message-State: AOAM532J4sF4shpcgTZkvEU3bLdJJS9yoOmoxPi2Ldlh2sZOQu8PpFAJ
        eOknF9UUmiCCX9s7xbp+tp+3BKebJdQbfKMFImhz7g==
X-Google-Smtp-Source: ABdhPJxBj0pE0ztPrxO5n9jP5KWgTe312/IA644ZpoKFdBZy8LgZsWnVSg7wCCgAbGqXMWSFcqG+esVUtM487SJzZCw=
X-Received: by 2002:ac2:5edb:: with SMTP id d27mr8062026lfq.411.1608630263565;
 Tue, 22 Dec 2020 01:44:23 -0800 (PST)
MIME-Version: 1.0
References: <18669bd607ae9efbf4e00e36532c7aa167d0fa12.camel@gmx.de>
 <20201220002228.38697-1-vitaly.wool@konsulko.com> <X+DaMSJE22nUC0tl@google.com>
 <CAM4kBBKnW6K-mbPno4SpvhUBiykP4zeFm_CNzssDkReURbuU7w@mail.gmail.com>
 <CALvZod69OtXkdOJPzuY5XfXz_ro0V7OmqW4OY9B_emqwroxW4w@mail.gmail.com>
 <e5cd8a0a5df84081a11359ede6e746bc@hisilicon.com> <CALvZod7EZnEWb_65FjSNdx+-S_4pLHyS5rYiU-D3hFLRMXS6Lw@mail.gmail.com>
 <8cc0e01fd03245a4994f2e0f54b264fa@hisilicon.com> <CAM4kBB+xUa8zXSRSuB0z5FCdPNmUpDfcC4Vqu7wzAkf0b+RXqw@mail.gmail.com>
 <f0ca46a830e54f4482fb4f46df9675f5@hisilicon.com> <CAM4kBBKD6MAOaBvwC_Wedf_zmzmt-gm=TrAF1Lh7pVbNtcsFZg@mail.gmail.com>
 <4490cb6a7e2243fba374e40652979e46@hisilicon.com> <CAM4kBBK=5eBdCjWc5VJXcdr=Z4PV1=ZQ2n8fZmJ6ahJbpUyv2A@mail.gmail.com>
 <08cbef1e43634c4099709be8e99e5d27@hisilicon.com>
In-Reply-To: <08cbef1e43634c4099709be8e99e5d27@hisilicon.com>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Tue, 22 Dec 2020 10:44:12 +0100
Message-ID: <CAM4kBBJjCYX0DQZ8de9LsFV6L+eF4tZe-NN=jiAz9WLWYrsCsQ@mail.gmail.com>
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
        Andrew Morton <akpm@linux-foundation.org>,
        "tiantao (H)" <tiantao6@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Dec 2020, 03:11 Song Bao Hua (Barry Song),
<song.bao.hua@hisilicon.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Song Bao Hua (Barry Song)
> > Sent: Tuesday, December 22, 2020 3:03 PM
> > To: 'Vitaly Wool' <vitaly.wool@konsulko.com>
> > Cc: Shakeel Butt <shakeelb@google.com>; Minchan Kim <minchan@kernel.org>; Mike
> > Galbraith <efault@gmx.de>; LKML <linux-kernel@vger.kernel.org>; linux-mm
> > <linux-mm@kvack.org>; Sebastian Andrzej Siewior <bigeasy@linutronix.de>;
> > NitinGupta <ngupta@vflare.org>; Sergey Senozhatsky
> > <sergey.senozhatsky.work@gmail.com>; Andrew Morton
> > <akpm@linux-foundation.org>; tiantao (H) <tiantao6@hisilicon.com>
> > Subject: RE: [PATCH] zsmalloc: do not use bit_spin_lock
> >
> >
> > > I'm still not convinced. Will kmap what, src? At this point src might become
> > just a bogus pointer.
> >
> > As long as the memory is still there, we can kmap it by its page struct. But
> > if
> > it is not there anymore, we have no way.
> >
> > > Why couldn't the object have been moved somewhere else (due to the compaction
> > mechanism for instance)
> > > at the time DMA kicks in?
> >
> > So zs_map_object() will guarantee the src won't be moved by holding those
> > preemption-disabled lock?
> > If so, it seems we have to drop the MOVABLE gfp in zswap for zsmalloc case?
> >
>
> Or we can do get_page() to avoid the movement of the page.


I would like to discuss this more in zswap context than zsmalloc's.
Since zsmalloc does not implement reclaim callback, using it in zswap
is a corner case anyway.

zswap, on the other hand, may be dealing with some new backends in
future which have more chances to become mainstream. Imagine typical
NUMA-like cases, i. e. a zswap pool allocated in some kind SRAM, or in
unused video memory. In such a case if you try to use a pointer to an
invalidated zpool mapping, you are on the way to thrash the system.
So: no assumptions that the zswap pool is in regular linear RAM should
be made.

~Vitaly
>
>
> > >
> > > >
> > > > ~Vitaly
> > >
> >
> > Thanks
> > Barry
>
>
