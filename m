Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03BF62E10B8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 01:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgLWAML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 19:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgLWAMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 19:12:10 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3401EC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 16:11:30 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id s26so36001976lfc.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 16:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2LLo3hmxVXUaUgVEfTkvoDCRls0Ztd6U6q/1VD4QX9g=;
        b=klH8+HLOGzBPUwTCJxWtqi0h2C/4vhia6SFlwZb32VLCd0FmLHrEetndB2ePjTWskm
         9frB7Qb75WoEHvCxmu3f+Z8gjQC62EhURROPKK4QRh3rxXf2+qWwy5RdX05ipE57wKKK
         KAywsx1V8exG1Hl11YbqLKErPDImpLXr8BqWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2LLo3hmxVXUaUgVEfTkvoDCRls0Ztd6U6q/1VD4QX9g=;
        b=p73OHObhTWNxRjjL2yuWTVKf169AgcqY5vMDEL51hckMIwCJYwi9kuT9hLxO/rjFwf
         5rLIaqjLQVp6NimddbGPHolI7+3DQugMQanWtTzKm9+0N96AjCc+7pXhnhf2JRed3Ctp
         47cMhR6ETRlp+ililWnGuEIHLAKxsXL+VF02Gl3ncSNYnyhk0RPBDYzVs7z38DMECb4R
         qt4OF3UfHr+0ojpJe9MVVHzejrEbwVHeFY60WhIw28nRzMLWlHdWLb/aBv4j0zdQUH9U
         /84f21DP69DNAViRyCaG8Pvgh80OEwK3j0qs92+RAVpy3SI15DuT3TPlfSsWNy4+zCI8
         4KXA==
X-Gm-Message-State: AOAM532hZgHRTNOOZKyUI6bFD9L7OLgCAzswvMMvi5lQl6w0HRC4+pCl
        vfTuUT7hKsE1xucoDhtDHA4iPlPWsC27LVKxd52cwQ==
X-Google-Smtp-Source: ABdhPJyxT+xMisXBx5G2vhMJlTM2OBO9kGepIFvEhZ7mIgqIzu6UdC0onCmYPOLwlEb9rQ6UhZmrX7Z2oSo4DTWrr8c=
X-Received: by 2002:a2e:b8c4:: with SMTP id s4mr8285957ljp.269.1608682288581;
 Tue, 22 Dec 2020 16:11:28 -0800 (PST)
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
 <1d0d4a3576e74d128d7849342a7e9faf@hisilicon.com>
In-Reply-To: <1d0d4a3576e74d128d7849342a7e9faf@hisilicon.com>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Wed, 23 Dec 2020 01:11:17 +0100
Message-ID: <CAM4kBB+uRrnpta908Gf93VfH90NVpmqv4jNY2kxrrGSdWApz_w@mail.gmail.com>
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

On Tue, 22 Dec 2020, 22:06 Song Bao Hua (Barry Song),
<song.bao.hua@hisilicon.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Vitaly Wool [mailto:vitaly.wool@konsulko.com]
> > Sent: Tuesday, December 22, 2020 10:44 PM
> > To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> > Cc: Shakeel Butt <shakeelb@google.com>; Minchan Kim <minchan@kernel.org>; Mike
> > Galbraith <efault@gmx.de>; LKML <linux-kernel@vger.kernel.org>; linux-mm
> > <linux-mm@kvack.org>; Sebastian Andrzej Siewior <bigeasy@linutronix.de>;
> > NitinGupta <ngupta@vflare.org>; Sergey Senozhatsky
> > <sergey.senozhatsky.work@gmail.com>; Andrew Morton
> > <akpm@linux-foundation.org>; tiantao (H) <tiantao6@hisilicon.com>
> > Subject: Re: [PATCH] zsmalloc: do not use bit_spin_lock
> >
> > On Tue, 22 Dec 2020, 03:11 Song Bao Hua (Barry Song),
> > <song.bao.hua@hisilicon.com> wrote:
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Song Bao Hua (Barry Song)
> > > > Sent: Tuesday, December 22, 2020 3:03 PM
> > > > To: 'Vitaly Wool' <vitaly.wool@konsulko.com>
> > > > Cc: Shakeel Butt <shakeelb@google.com>; Minchan Kim <minchan@kernel.org>;
> > Mike
> > > > Galbraith <efault@gmx.de>; LKML <linux-kernel@vger.kernel.org>; linux-mm
> > > > <linux-mm@kvack.org>; Sebastian Andrzej Siewior <bigeasy@linutronix.de>;
> > > > NitinGupta <ngupta@vflare.org>; Sergey Senozhatsky
> > > > <sergey.senozhatsky.work@gmail.com>; Andrew Morton
> > > > <akpm@linux-foundation.org>; tiantao (H) <tiantao6@hisilicon.com>
> > > > Subject: RE: [PATCH] zsmalloc: do not use bit_spin_lock
> > > >
> > > >
> > > > > I'm still not convinced. Will kmap what, src? At this point src might
> > become
> > > > just a bogus pointer.
> > > >
> > > > As long as the memory is still there, we can kmap it by its page struct.
> > But
> > > > if
> > > > it is not there anymore, we have no way.
> > > >
> > > > > Why couldn't the object have been moved somewhere else (due to the compaction
> > > > mechanism for instance)
> > > > > at the time DMA kicks in?
> > > >
> > > > So zs_map_object() will guarantee the src won't be moved by holding those
> > > > preemption-disabled lock?
> > > > If so, it seems we have to drop the MOVABLE gfp in zswap for zsmalloc case?
> > > >
> > >
> > > Or we can do get_page() to avoid the movement of the page.
> >
> >
> > I would like to discuss this more in zswap context than zsmalloc's.
> > Since zsmalloc does not implement reclaim callback, using it in zswap
> > is a corner case anyway.
>
> I see. But it seems we still need a solution for the compatibility
> of zsmalloc and zswap? this will require change in either zsmalloc
> or zswap.
> or do you want to make zswap depend on !ZSMALLOC?

No, I really don't think we should go that far. What if we add a flag
to zpool, named like "can_sleep_mapped", and have it set for
zbud/z3fold?
Then zswap could go the current path if the flag is set; and if it's
not set, and mutex_trylock fails, copy data from src to a temporary
buffer, then unmap the handle, take the mutex, process the buffer
instead of src. Not the nicest thing to do but at least it won't break
anything.

~Vitaly

> > zswap, on the other hand, may be dealing with some new backends in
> > future which have more chances to become mainstream. Imagine typical
> > NUMA-like cases, i. e. a zswap pool allocated in some kind SRAM, or in
> > unused video memory. In such a case if you try to use a pointer to an
> > invalidated zpool mapping, you are on the way to thrash the system.
> > So: no assumptions that the zswap pool is in regular linear RAM should
> > be made.
> >
> > ~Vitaly
>
> Thanks
> Barry
