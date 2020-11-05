Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F292A7CA3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 12:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbgKELLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 06:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgKELLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 06:11:31 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B867DC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 03:11:31 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id w145so1255814oie.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 03:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p0c7rtJJXojaI2Rh6wYkHrsZ57LiUlQdb8npxhv/hGc=;
        b=UgAG4I4ReO+wn1wDSqRbyoCy/IJUjdK11POtyqZqUfpFft8GE5GL+OCgDZNIMC2ShI
         Ak0T5FghDwJA9fsgRUMCNqvCZ5ROdofuxkSrFoWhSKgehoYNxd8xAA0kUt+88ZgFMdBX
         xgsxR0H5vGTRnPChZLgASs3o9ItRAZ6/W6Y7TEIlhnSDqu8jPyq7LyRZbke4U7dM6iLN
         FxDmcUCC8Kcmtvm2sajgAxr+hcGGJFTTEjTiXHHgQS9xy5QRr9+mozw1suvBw1OUxCTE
         m5zOLb1SNNObTwE/7RoI99npnj5OJ7hGTDK75JI2+K70tGiaVWVeWGxAC90Z4pKny19h
         p+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p0c7rtJJXojaI2Rh6wYkHrsZ57LiUlQdb8npxhv/hGc=;
        b=WaL70P6ALQ0jbg9Elwn8gifdhiW40YztNtVfdyYiYzGrZC4zOo4ah4nPW6vjEncgED
         N6U+6vl5qJrCvHoGbRUtuYnUNWZBqjMwWoCgI7sJ4UPYRWD2+uS9dipaNhNzXP6mXS55
         Iu+XVV4hqt8VBzM0sgGxeBFAoVJbVw3u+N2/AIQx+QU5xWzSC4YoYUNbakBPfGpWb4Rn
         FrRiQoJsTz6KwywtxhhGZtDRUj/57bk6Sn1rg9mcU87Jnmi4NKV4V7Xh3jY1GJSSFUmT
         Pb7p71Mt/gDy2DEP10tZpI12pv2fBYsKLVyN46ZTT8cTkPx4XqmVkqg9DLovI5zCOMGl
         Cmag==
X-Gm-Message-State: AOAM5300jToZqzk5FekvreTecvKKkXMT+G9AR1Qnq+r8XA3jV/DbjBE/
        UfG0dN/sYlq2aDOVdHTPYpMJAQgcMkfiffLYme9oDg==
X-Google-Smtp-Source: ABdhPJw/bKjx3NB4HnHeMfp7dUNwz337/g01wK6iBNiTZauyMStIy5uzOAY0RMwaytsPEAZJM2mVackSG5B6M6pOREs=
X-Received: by 2002:aca:a988:: with SMTP id s130mr1214512oie.172.1604574690901;
 Thu, 05 Nov 2020 03:11:30 -0800 (PST)
MIME-Version: 1.0
References: <20201105092133.2075331-1-elver@google.com> <20201105105241.GC82102@C02TD0UTHF1T.local>
In-Reply-To: <20201105105241.GC82102@C02TD0UTHF1T.local>
From:   Marco Elver <elver@google.com>
Date:   Thu, 5 Nov 2020 12:11:19 +0100
Message-ID: <CANpmjNP+QOJrfJHC2P-9gFfB6wdnr9c9gPDgVFdgzbrCcG-nog@mail.gmail.com>
Subject: Re: [PATCH] kfence: Use pt_regs to generate stack trace on faults
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Nov 2020 at 11:52, Mark Rutland <mark.rutland@arm.com> wrote:
> On Thu, Nov 05, 2020 at 10:21:33AM +0100, Marco Elver wrote:
> > Instead of removing the fault handling portion of the stack trace based
> > on the fault handler's name, just use struct pt_regs directly.
> >
> > Change kfence_handle_page_fault() to take a struct pt_regs, and plumb it
> > through to kfence_report_error() for out-of-bounds, use-after-free, or
> > invalid access errors, where pt_regs is used to generate the stack
> > trace.
> >
> > If the kernel is a DEBUG_KERNEL, also show registers for more
> > information.
> >
> > Suggested-by: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Marco Elver <elver@google.com>
>
> Wow; I wasn't expecting this to be put together so quickly, thanks for
> doing this!
>
> From a scan, this looks good to me -- just one question below.
>
> > diff --git a/include/linux/kfence.h b/include/linux/kfence.h
> > index ed2d48acdafe..98a97f9d43cd 100644
> > --- a/include/linux/kfence.h
> > +++ b/include/linux/kfence.h
> > @@ -171,6 +171,7 @@ static __always_inline __must_check bool kfence_free(void *addr)
> >  /**
> >   * kfence_handle_page_fault() - perform page fault handling for KFENCE pages
> >   * @addr: faulting address
> > + * @regs: current struct pt_regs (can be NULL, but shows full stack trace)
> >   *
> >   * Return:
> >   * * false - address outside KFENCE pool,
>
> > @@ -44,8 +44,12 @@ static int get_stack_skipnr(const unsigned long stack_entries[], int num_entries
> >               case KFENCE_ERROR_UAF:
> >               case KFENCE_ERROR_OOB:
> >               case KFENCE_ERROR_INVALID:
> > -                     is_access_fault = true;
> > -                     break;
> > +                     /*
> > +                      * kfence_handle_page_fault() may be called with pt_regs
> > +                      * set to NULL; in that case we'll simply show the full
> > +                      * stack trace.
> > +                      */
> > +                     return 0;
>
> For both the above comments, when/where is kfence_handle_page_fault()
> called with regs set to NULL? I couldn't spot that in this patch, so
> unless I mised it I'm guessing that's somewhere outside of the patch
> context?

Right, currently it's not expected to happen, but I'd like to permit
this function being called not from fault handlers, for use-cases like
this:

 https://lkml.kernel.org/r/CANpmjNNxAvembOetv15FfZ=04mpj0Qwx+1tnn22tABaHHRRv=Q@mail.gmail.com

The revised recommendation when trying to get KFENCE to give us more
information about allocation/free stacks after refcount underflow
(like what Paul was trying to do) would be to call
kfence_handle_page_fault(addr, NULL).

> If this is a case we don't expect to happen, maybe add a WARN_ON_ONCE()?

While it's currently not expected, I don't see why we should make this
WARN and limit the potential uses of the API if it works just fine if
we pass regs set to NULL. Although arguably the name
kfence_handle_page_fault() might be confusing for such uses, for now,
until more widespread use is evident (if at all) I'd say let's keep
as-is, but simply not prevent such use-cases.

Thanks,
-- Marco
