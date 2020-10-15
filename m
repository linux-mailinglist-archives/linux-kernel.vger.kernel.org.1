Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E0128F7B6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 19:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731306AbgJORjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 13:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731233AbgJORjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 13:39:36 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59439C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 10:39:36 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id x13so2344560pgp.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 10:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KtfuI7EmqU/w7shjq+GdWDQYgGINxwQeMULph0gZRsc=;
        b=aXzsuv9HJKu+PWl45xif8NGdEmMubHRZDhZ6s+Vxc8VTc3IIdLsn/P/9ZvdIT4LVbh
         oCqGl4ZRl2JvCycUpbrvUXFja7PBYlE+Ennz1QqXackeenZ4I0fcxknwe8FAGK22WxqY
         5Ob8ZEkp4ZXsqqlphaWqC31vPTCe/jbLJYTZBUuKTr/rYYWYu4vAGGCkHMPn4TOLhkfA
         jIqauBwK3a7b+5D4FAP9zWylpErbsagwYyXMSXt49EvOWkBipN5nk4mQRZ7I8hsRDGWl
         zZ9dE6z6jRGer2Geyiy0iwGlxC2FHMUKt843VtqOrq71f2CuHNFdlWX7F3UzvuoFqeW1
         5EOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KtfuI7EmqU/w7shjq+GdWDQYgGINxwQeMULph0gZRsc=;
        b=h+Q3N0Kex79nePorZ1Ru8si8HMsj4I5wuKbZeApczn4xayAN4LjOEjmxFN4ZXuglOb
         IJQdXx8vc3uVNeJJSaSNA6H6BtqSrAptHyxJXI1GjIM4esFAK9jQXrZP77GQUsy5w+8r
         6Hlpu11t5TikLAjlNCnQbjgPgAaIAsGWWWM75q2VgqRa37bBTtDzrsUxRWEkX37TB6vY
         +RhYM8s04ijWN2V3i9W92aMUW69rKo1EPstcoZ9J83VV8Vs7JIZBBKXRcV1ok4PcTMbO
         QOtVu3fl92a1LaCBIQ/N6BdUhPYImE+U5+cBxu3qJarDMJygHHxODgE1EOoficfzge2L
         tl5w==
X-Gm-Message-State: AOAM533CqqBxTL1V6ERvTUFdG5xXWSksdShpTS3ZjerdLreO25qgdbK+
        7sMwHtDmCXMjcUDDRaMl4zmcVW8HlKkzq2+APVyzFA==
X-Google-Smtp-Source: ABdhPJy6D1OCRa5iaUMZJGvYJKOUQ5Vc9mMjTR9sWkQZRdsW4hdg5l4btHoMopmlKpvXCzNMJRvCK61TZX8FzXctGys=
X-Received: by 2002:a63:f74a:: with SMTP id f10mr4361736pgk.263.1602783575287;
 Thu, 15 Oct 2020 10:39:35 -0700 (PDT)
MIME-Version: 1.0
References: <20201014212631.207844-1-nivedita@alum.mit.edu>
 <1653ace9164c4a3a8be50b3d2c9ff816@AcuMS.aculab.com> <20201015144515.GA572410@rani.riverdale.lan>
 <4a8c47b5eeb44b789abbb617f0a95993@AcuMS.aculab.com> <20201015153901.GA593731@rani.riverdale.lan>
In-Reply-To: <20201015153901.GA593731@rani.riverdale.lan>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 15 Oct 2020 10:39:23 -0700
Message-ID: <CAKwvOdkLvxeYeBh7Kx0gw7JPktPH8A4DomJTidUqA0jRQTR0FA@mail.gmail.com>
Subject: Re: [PATCH] compiler.h: Fix barrier_data() on clang
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     David Laight <David.Laight@aculab.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 8:39 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Thu, Oct 15, 2020 at 03:24:09PM +0000, David Laight wrote:
> > > I think the comment is unclear now that you bring it up, but the problem
> > > it actually addresses is not that the data is held in registers: in the
> > > sha256_transform() case mentioned in the commit message, for example,
> > > the data is in fact in memory even before this change (it's a 256-byte
> > > array), and that together with the memory clobber is enough for gcc to
> > > assume that the asm might use it. But with clang, if the address of that
> > > data has never escaped -- in this case the data is a local variable
> > > whose address was never passed out of the function -- the compiler
> > > assumes that the asm cannot possibly depend on that memory, because it
> > > has no way of getting its address.
> >
> > Ok, slightly different from what i thought.
> > But the current comment is just wrong.
>
> Should I fix up the comment in the same commit, or do a second one after
> moving the macro?

I would prefer undoing the mistake from 815f0ddb346c and getting that
backported to stable, then rewriting comments or the trick to retain
the memset separately.

>
> > > i.e. something like:
> > >     static inline void barrier_data(void *ptr, size_t size)
> > >     {
> > >             asm volatile("" : "+m"(*(char (*)[size])ptr));
> >
> > I think it has to be a struct with an array member?
>
> I don't think so, this is actually an example in gcc's documentation:
>
>   An x86 example where the string memory argument is of unknown length.
>
>         asm("repne scasb"
>         : "=c" (count), "+D" (p)
>         : "m" (*(const char (*)[]) p), "0" (-1), "a" (0));
>
>   If you know the above will only be reading a ten byte array then you
>   could instead use a memory input like: "m" (*(const char (*)[10]) p).
>
> >
> > >     }
> > > plus some magic to disable the VLA warning, otherwise it causes a build
> > > error.
> >
> > It shouldn't if the size is a compile time constant.
> > And given this is an instruction to the compiler it better be.
>
> Ah right. I saw the warning when playing with something else where size
> could be constant or variable depending on the call.
>
> > >
> > > With a memory clobber, the compiler has to keep x and y at different
> > > addresses, since the first barrier_data() might have saved the address
> > > of x.
> >
> > Maybe "+m"(*ptr) : "r"(ptr) would work.
>
> Nothing that can only modify what ptr points to could avoid this, since
> that storage is dead after the barrier.
>
> > OTOH a "memory" clobber at the bottom of a function isn't going to
> > cause bloat.
> >
> > The explicit ranged memory access (without "memory") probably has its
> > uses - but only if the full "memory" clobber causes grief.
> >
> >       David
> >
> > -
> > Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> > Registration No: 1397386 (Wales)



-- 
Thanks,
~Nick Desaulniers
