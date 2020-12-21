Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9472D2E017C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 21:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgLUUWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 15:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgLUUWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 15:22:51 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D27FC0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 12:22:11 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id n7so6985509pgg.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 12:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2i5d/rF9ghqWdmLNxdkBGDo6QlVvN3s6AnXqOUeYid8=;
        b=cVaoECoIkuXobTWAf62XCYvhfwS4rQv+P+YxwX/xR33bAJOSj2faSEGhR4uq3JWGkh
         DyrrUGAxbF9oS7bFlko8TXBj5irWAmrnU2w8HbqDwzrS00Xn4nN4tgoOZuRPZ7rMkppJ
         MvHSnIj6J8wV/JdSMbCxqK7zGp9CBGb8JXuJXwVW4QoGCpZ6QDMyps2wp6DO9AI1lYYF
         W9fSCvGFaC2HVphlJsrCLmJ5/qrGl1V3EESvKklVvTlU1ymEgIfhMi0dtdakLLdy6NAf
         vzWvGDyj77TlYHv7TVANdT7wdzIHf8ChzzFIROC8wei22BEpS3Q11f40hsg9Bj1zPt+g
         ek8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=2i5d/rF9ghqWdmLNxdkBGDo6QlVvN3s6AnXqOUeYid8=;
        b=jgV52HMuXw8B3HjiZTk1ImZ9/owGkVGAVwf18siw1ZbQs1YgAl3R1AhU/VO+57ECMI
         UdX5UaFSkEtn9a8QXtsVDQCCng2afYwxA/ryA8BqAvYp712ZG2bMG9XDXv9/HRJ4RCeF
         ZYdAphBiqrfw6XHDopc2ItDNAFojv/260SlwSNMGy2DliU3cwit9+zx6hLqc6ZNyga8K
         JxANKNeDmdb5c4LhjWdb+wCXKfSbw1dAJczyxexrsKkniuVG8lbVkJGQ6f4AtpQku4VP
         i+LzMekVBk0uk2Z3ywNTkVNDm575FNFkhUMKyHtCE8QlJp4id+paQqSMM8Ioe3pEA8b/
         hvuA==
X-Gm-Message-State: AOAM533m1CqyjwWKX89LBQG4MhhSQ1sETtcoRYNVMQfuXoyPcD5n43s1
        mW08dcLqgmPYq5iy0fgMQFs=
X-Google-Smtp-Source: ABdhPJxCLY8So8MauqJ1pVZJ4ctDHxHp7f8JrxOKjZemM1g+2+d4lA2vlISI2tFMPDpEbIl7Hqu11g==
X-Received: by 2002:a05:6a00:796:b029:1ad:6394:432d with SMTP id g22-20020a056a000796b02901ad6394432dmr8828748pfu.36.1608582130907;
        Mon, 21 Dec 2020 12:22:10 -0800 (PST)
Received: from google.com ([2620:15c:211:201:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id w2sm17621933pfj.110.2020.12.21.12.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 12:22:09 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 21 Dec 2020 12:22:07 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Vitaly Wool <vitaly.wool@konsulko.com>
Cc:     Mike Galbraith <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        NitinGupta <ngupta@vflare.org>,
        sergey.senozhatsky.work@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>, shakeelb@google.com
Subject: Re: [PATCH] zsmalloc: do not use bit_spin_lock
Message-ID: <X+ED7yIn89WhbXsq@google.com>
References: <18669bd607ae9efbf4e00e36532c7aa167d0fa12.camel@gmx.de>
 <20201220002228.38697-1-vitaly.wool@konsulko.com>
 <X+DaMSJE22nUC0tl@google.com>
 <CAM4kBBKnW6K-mbPno4SpvhUBiykP4zeFm_CNzssDkReURbuU7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM4kBBKnW6K-mbPno4SpvhUBiykP4zeFm_CNzssDkReURbuU7w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 08:20:26PM +0100, Vitaly Wool wrote:
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

No, it's surely break from zswap since zpool/zsmalloc has worked like
this and now you are saying "nothing wrong" even though it breaks
the rule.

> 
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
> zsmalloc is not fully compliant with zswap / zpool API to avoid
> confusion for the time being. Would that be ok with you?

It's your call since you are maintainer of zswap now and you are
breaking the rule we have kept for a long time.


> 
> Best regards,
>    Vitaly
> 
> > Furthermore, the zs_map_object already has a few more places where
> > disablepreemptions(migrate_read_lock, get_cpu_var and kmap_atomic).
> >
> > Without making those locks preemptible all at once, zswap will still
> > see the lockdep warning.
> >
> > >
> > > Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.com>
> > > ---
> > >  mm/zsmalloc.c | 13 ++++++++-----
> > >  1 file changed, 8 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> > > index 7289f502ffac..ff26546a7fed 100644
> > > --- a/mm/zsmalloc.c
> > > +++ b/mm/zsmalloc.c
> > > @@ -876,22 +876,25 @@ static unsigned long obj_to_head(struct page *page, void *obj)
> > >
> > >  static inline int testpin_tag(unsigned long handle)
> > >  {
> > > -     return bit_spin_is_locked(HANDLE_PIN_BIT, (unsigned long *)handle);
> > > +     return test_bit(HANDLE_PIN_BIT, (unsigned long *)handle);
> > >  }
> > >
> > >  static inline int trypin_tag(unsigned long handle)
> > >  {
> > > -     return bit_spin_trylock(HANDLE_PIN_BIT, (unsigned long *)handle);
> > > +     return !test_and_set_bit(HANDLE_PIN_BIT, (unsigned long *)handle);
> > >  }
> > >
> > > -static void pin_tag(unsigned long handle) __acquires(bitlock)
> > > +static void pin_tag(unsigned long handle)
> > >  {
> > > -     bit_spin_lock(HANDLE_PIN_BIT, (unsigned long *)handle);
> > > +     preempt_disable();
> > > +     while(test_and_set_bit(HANDLE_PIN_BIT, (unsigned long *)handle))
> > > +             cpu_relax();
> > > +     preempt_enable();
> > >  }
> > >
> > >  static void unpin_tag(unsigned long handle) __releases(bitlock)
> > >  {
> > > -     bit_spin_unlock(HANDLE_PIN_BIT, (unsigned long *)handle);
> > > +     clear_bit(HANDLE_PIN_BIT, (unsigned long *)handle);
> > >  }
> > >
> > >  static void reset_page(struct page *page)
> > > --
> > > 2.20.1
> > >
