Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C26F2E00DE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 20:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgLUTVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 14:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgLUTVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 14:21:19 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D27C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 11:20:38 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id a12so26330586lfl.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 11:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vUnUklljz54AklJ/4EYyGGDSEKEpQNWIZ2ClZ96iVF4=;
        b=d1K2ld8SA6F/za4a6CZm0iTta7Dp706o9UHjEsvzJYHNeT9VXuoH+dWLNfm7MB8S2a
         Q/SIVL8bJtZTpimpbTyhsEQT11FnAqTZuAuNR0y6CCyP7Vg6esvDJMcvz+EZdwyk5NAB
         4ttGSZuBDYPJmBUSv0vOh1uzULKDGV8/TT5LU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vUnUklljz54AklJ/4EYyGGDSEKEpQNWIZ2ClZ96iVF4=;
        b=clYHdkKvEjW2hgs8hcy30bJ3bpkGJNIa54j6IMJLjl4dU1E+3kF2hsgvvYyelsvlD3
         vkYhzJiprCCZ0OmMIQLfIGuy006iIUexdkjUP6Hnl/12IPdRz03xK0wUtwuUaPt36a/7
         J8QTp5NmNt5aqs9fp//zs8meILPfBx0En8H8e+Y0sScTFeLfJjwucp17hmiErBg4pnRD
         K1qNhhHYeRvQV4HTQ8051c0nHAwaB0K2ns1id696IE9jk2McV5JR4lPW6b7FaIiRQduZ
         9FTpKUnXJjKCJjN+3kDJJyB3oWANMOGMoUnJXEdo0fBNKw9z5cjlUVrc2405mUeynNoc
         DKYw==
X-Gm-Message-State: AOAM5331COx8ryNSPXpDskLSVA0+As+pfiNzx+1gVTNuMnMDNs3rMj/e
        vmWdzABIeobt36JzxAq7cILMXHanJkVoWQV7Z5OA/daS2p+7W9w8
X-Google-Smtp-Source: ABdhPJzqa7NO56hNQ/VQuBNjQXKjNoRtYGbC1iIsUZiW++x/B/Fr0mahPbfbElKMX4ZIrropW1FBP2BGkUKY6suQAyA=
X-Received: by 2002:a2e:b8c4:: with SMTP id s4mr5369682ljp.269.1608578437281;
 Mon, 21 Dec 2020 11:20:37 -0800 (PST)
MIME-Version: 1.0
References: <18669bd607ae9efbf4e00e36532c7aa167d0fa12.camel@gmx.de>
 <20201220002228.38697-1-vitaly.wool@konsulko.com> <X+DaMSJE22nUC0tl@google.com>
In-Reply-To: <X+DaMSJE22nUC0tl@google.com>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Mon, 21 Dec 2020 20:20:26 +0100
Message-ID: <CAM4kBBKnW6K-mbPno4SpvhUBiykP4zeFm_CNzssDkReURbuU7w@mail.gmail.com>
Subject: Re: [PATCH] zsmalloc: do not use bit_spin_lock
To:     Minchan Kim <minchan@kernel.org>
Cc:     Mike Galbraith <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        NitinGupta <ngupta@vflare.org>,
        sergey.senozhatsky.work@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>, shakeelb@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 6:24 PM Minchan Kim <minchan@kernel.org> wrote:
>
> On Sun, Dec 20, 2020 at 02:22:28AM +0200, Vitaly Wool wrote:
> > zsmalloc takes bit spinlock in its _map() callback and releases it
> > only in unmap() which is unsafe and leads to zswap complaining
> > about scheduling in atomic context.
> >
> > To fix that and to improve RT properties of zsmalloc, remove that
> > bit spinlock completely and use a bit flag instead.
>
> I don't want to use such open code for the lock.
>
> I see from Mike's patch, recent zswap change introduced the lockdep
> splat bug and you want to improve zsmalloc to fix the zswap bug and
> introduce this patch with allowing preemption enabling.

This understanding is upside down. The code in zswap you are referring
to is not buggy.  You may claim that it is suboptimal but there is
nothing wrong in taking a mutex.

> https://lore.kernel.org/linux-mm/fae85e4440a8ef6f13192476bd33a4826416fc58.camel@gmx.de/
>
> zs_[un/map]_object is designed to be used in fast path(i.e.,
> zs_map_object/4K page copy/zs_unmap_object) so the spinlock is
> perfectly fine for API point of view. However, zswap introduced
> using the API with mutex_lock/crypto_wait_req where allowing
> preemption, which was wrong.

Taking a spinlock in one callback and releasing it in another is
unsafe and error prone. What if unmap was called on completion of a
DMA-like transfer from another context, like a threaded IRQ handler?
In that case this spinlock might never be released.

Anyway I can come up with a zswap patch explicitly stating that
zsmalloc is not fully compliant with zswap / zpool API to avoid
confusion for the time being. Would that be ok with you?

Best regards,
   Vitaly

> Furthermore, the zs_map_object already has a few more places where
> disablepreemptions(migrate_read_lock, get_cpu_var and kmap_atomic).
>
> Without making those locks preemptible all at once, zswap will still
> see the lockdep warning.
>
> >
> > Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.com>
> > ---
> >  mm/zsmalloc.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> > index 7289f502ffac..ff26546a7fed 100644
> > --- a/mm/zsmalloc.c
> > +++ b/mm/zsmalloc.c
> > @@ -876,22 +876,25 @@ static unsigned long obj_to_head(struct page *page, void *obj)
> >
> >  static inline int testpin_tag(unsigned long handle)
> >  {
> > -     return bit_spin_is_locked(HANDLE_PIN_BIT, (unsigned long *)handle);
> > +     return test_bit(HANDLE_PIN_BIT, (unsigned long *)handle);
> >  }
> >
> >  static inline int trypin_tag(unsigned long handle)
> >  {
> > -     return bit_spin_trylock(HANDLE_PIN_BIT, (unsigned long *)handle);
> > +     return !test_and_set_bit(HANDLE_PIN_BIT, (unsigned long *)handle);
> >  }
> >
> > -static void pin_tag(unsigned long handle) __acquires(bitlock)
> > +static void pin_tag(unsigned long handle)
> >  {
> > -     bit_spin_lock(HANDLE_PIN_BIT, (unsigned long *)handle);
> > +     preempt_disable();
> > +     while(test_and_set_bit(HANDLE_PIN_BIT, (unsigned long *)handle))
> > +             cpu_relax();
> > +     preempt_enable();
> >  }
> >
> >  static void unpin_tag(unsigned long handle) __releases(bitlock)
> >  {
> > -     bit_spin_unlock(HANDLE_PIN_BIT, (unsigned long *)handle);
> > +     clear_bit(HANDLE_PIN_BIT, (unsigned long *)handle);
> >  }
> >
> >  static void reset_page(struct page *page)
> > --
> > 2.20.1
> >
