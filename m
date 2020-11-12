Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA972B0FA7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 21:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbgKLUzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 15:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgKLUzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 15:55:03 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C824C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 12:54:50 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id g7so5686807pfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 12:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kiz7admIpkh5f8na25jRX8719oxnjpCDxUfGo3ANCBE=;
        b=Ctgie1D8MC2g1hh3J3AczqEEFg61iZjZlh/Atgs1FXSuN1BBfr3ABTuFUMCX1A3CN5
         MFvwljUQCJCrKtFGCOLQy6M8uxXt5L9hfKGDMd0GkNUqzv8iYyZRsHMN+stmXgL006yT
         VUSf+UXiq1qxuZmcR6nKhiOrOrqy/z70tiTQ8bVW7oMHjwpPKMNDHDuvWUsM4k/Lb3dr
         nK+HTBu78MxN9EqObzoctChp0htmgXuCoB8UnsY5VyXfUrPXZ/LB8/J9TDXhlyW5z0Gt
         yr+YchGQhT4cSML2uIyFoJWEe690nfsQoeFE4WsrKWyzex01bvfFivVCvpdoW/aaeiKf
         Qo8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kiz7admIpkh5f8na25jRX8719oxnjpCDxUfGo3ANCBE=;
        b=ayDDqFe3DHtI2d0Kxsj1wixOLS12l9uLGoXKNLZE8ZowZxn3k9Sh1YHgMnKzqQAuvr
         GGehhzR0xm8NldFXFfsmLvQ8VGe1lCRXNUwJ1coKM0KpoeERCS/2jYuNg4alvSZAfsYL
         SwQiUAKcyULn0V+zzwFNOxoQ0aPhvYam81RsmZwS3XbMpjZF5QIN9ZQUEvIW+I/HcuFP
         yUDr0e2owtgBqwOzSIwJpCmxU3bo2vc8b5bZTBfNAS4vy7ZIuxY5r+wxyJvqjCst/iPh
         DLq7bmu+mscQgQAijhoxSEFaPsX3WDgrp5C7bhjOhBItCxu1Rcqrnkjoh7tkEsbLAQly
         I0ew==
X-Gm-Message-State: AOAM5315oMV5MDmNvZMNEyiR4EJWaLNckOteagd/KG+qL3knoTxBNVKM
        NUcaxIHFfL9csuccEjOhsDxXXKN+PnCRZEJBb6AsRg==
X-Google-Smtp-Source: ABdhPJyeoHD62habj4+F4sFfzR5XHQJ3anER514HDgPtrc23ULhbOrZ5H5Va0VHS+mFcpWlU8KxFd+9ZnBpTU6JeHKk=
X-Received: by 2002:a05:6a00:16c4:b029:162:bf9f:6458 with SMTP id
 l4-20020a056a0016c4b0290162bf9f6458mr1139365pfc.55.1605214489773; Thu, 12 Nov
 2020 12:54:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046662.git.andreyknvl@google.com> <0a9b63bff116734ab63d99ebd09c244332d71958.1605046662.git.andreyknvl@google.com>
 <20201111174902.GK517454@elver.google.com> <CAAeHK+wvvkYko=tM=NHODkKas13h5Jvsswvg05jhv9LqE0jSjQ@mail.gmail.com>
 <CANpmjNOboPh97HdMGAESSEYdeyd9+9MVy6E3QsvVAYuWVReRew@mail.gmail.com>
In-Reply-To: <CANpmjNOboPh97HdMGAESSEYdeyd9+9MVy6E3QsvVAYuWVReRew@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 12 Nov 2020 21:54:38 +0100
Message-ID: <CAAeHK+xhjUQAtJThUHcaGmd3muBZHiJPfTqj59CMxo44hbDniw@mail.gmail.com>
Subject: Re: [PATCH v2 10/20] kasan: inline and rename kasan_unpoison_memory
To:     Marco Elver <elver@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 8:52 PM Marco Elver <elver@google.com> wrote:
>
> On Thu, 12 Nov 2020 at 20:45, Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> > On Wed, Nov 11, 2020 at 6:49 PM Marco Elver <elver@google.com> wrote:
> > >
> > > On Tue, Nov 10, 2020 at 11:20PM +0100, Andrey Konovalov wrote:
> > > > Currently kasan_unpoison_memory() is used as both an external annotation
> > > > and as an internal memory poisoning helper. Rename external annotation to
> > > > kasan_unpoison_data() and inline the internal helper for hardware
> > > > tag-based mode to avoid undeeded function calls.
> > >
> > > I don't understand why this needs to be renamed again. The users of
> > > kasan_unpoison_memory() outweigh those of kasan_unpoison_slab(), of
> > > which there seems to be only 1!
> >
> > The idea is to make kasan_(un)poison_memory() functions inlinable for
> > internal use. It doesn't have anything to do with the number of times
> > they are used.
> >
> > Perhaps we can drop the kasan_ prefix for the internal implementations
> > though, and keep using kasan_unpoison_memory() externally.
>
> Whatever avoids changing the external interface, because it seems
> really pointless. I can see why it's done, but it's a side-effect of
> the various wrappers being added.

It looks like unposion_memory() is already taken. Any suggestions for
internal KASAN poisoning function names?
