Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B43729060B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 15:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406071AbgJPNK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 09:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408294AbgJPNKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 09:10:55 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3836BC061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 06:10:55 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id b19so1273409pld.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 06:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Zj+cS5AehZpH9Xc1DCK1Rq5tdmQbPSdPgRnV6iCKcI=;
        b=uEOyU0JwIRBRZ/kuhKTxlvRg4140bWr0tjMB6QN7KGcB9hfQBsWR1qr2pUztElTKSB
         Yf1uVkX1/1mIg+xuUSYp18t7D3e8rbX5cciR9ka0daIkOzFQ/r1+CfFFAYNRbMXHpLnH
         doSYeSuYU37EZ71hFYUSdpWyAeCQhddebkgsryt7FGrLdoKExvJO0GExVlLRJH3Ht0YX
         wzE3New3tYUX2x3Xfn5sVRPBSQRUpQn1XmP+/7+G4HmUYDYBjYBtA/db5zRzCce9tqIo
         uFZvfjXJ1Fj5uT8OX803/X35vOsuRoA26T7wxLTd10meL9b3HvBDOw86nIgpprlbAsDk
         OgiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Zj+cS5AehZpH9Xc1DCK1Rq5tdmQbPSdPgRnV6iCKcI=;
        b=aYEre+AZewu0w09RyaKygwyXkNFOZy+gwQM9P4MJTGDFR+IZzrmHlm7UcyQoq+idse
         8Bucaes7S8MXUDjnWw1O8WWpN4x66E3qFbFQPm62n6rdafIqOa5MblZ0ADFDDIhi193H
         5OYZaAWMavMXp0ON/XdU6/WVB69ZZFPuwmGbk+dOpeq4iRkE+eWJflSqEFodZXXf973B
         EGp6affoo0SMcnE7uB1/C7wsxNCnk9qdeBxwGESdDsfnLj0Z/rirmQRSeeII6BGL5PNz
         1B5c98pTrp6oZOV2A2WNRuMHbgBxg3dLYAPd/Mof4k5cnekQ8IiFHlfBDOt/2MwylfVu
         E23A==
X-Gm-Message-State: AOAM5330bukHM53fkmcTteUKBJungsm6WMdUrF4M5AirwCpzk3rI0Ypm
        nIBHUhA1FGtqIYcV/m12VH2E88Qf5J8obBAqCbdVew==
X-Google-Smtp-Source: ABdhPJwilqTJKZSGx6Vzmrus5fwjcD9cmsf5Z+c9+7vBoKEdfScTdwbyL3XJboeZ4q/SxcyjKeerM9nN35RrCThxb7g=
X-Received: by 2002:a17:90b:807:: with SMTP id bk7mr3787953pjb.166.1602853854621;
 Fri, 16 Oct 2020 06:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602708025.git.andreyknvl@google.com> <c44b27703fb2fa11029ecd92522a66988295dfb6.1602708025.git.andreyknvl@google.com>
 <CANpmjNMkZc6X+Z=Bw-hOXO3n9fzq4F3mOnHgieyifkoZM=_Mdw@mail.gmail.com>
In-Reply-To: <CANpmjNMkZc6X+Z=Bw-hOXO3n9fzq4F3mOnHgieyifkoZM=_Mdw@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 16 Oct 2020 15:10:43 +0200
Message-ID: <CAAeHK+yQ+hYZSAhyGDYeVYLC-WEL35Qe=xMRtDG52G9Fu6xgXQ@mail.gmail.com>
Subject: Re: [PATCH RFC 8/8] kasan: add and integrate kasan_mode boot param
To:     Marco Elver <elver@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
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

On Thu, Oct 15, 2020 at 3:56 PM Marco Elver <elver@google.com> wrote:
>
> On Wed, 14 Oct 2020 at 22:45, Andrey Konovalov <andreyknvl@google.com> wrote:
> >

[...]

> > @@ -180,6 +182,7 @@ size_t kasan_metadata_size(struct kmem_cache *cache)
> >  struct kasan_alloc_meta *kasan_get_alloc_meta(struct kmem_cache *cache,
> >                                               const void *object)
> >  {
> > +       WARN_ON(!static_branch_unlikely(&kasan_debug));
>
> The WARN_ON condition itself should be unlikely, so that would imply
> that the static branch here should be likely since you're negating it.

Here I was thinking that we should optimize for the production use
case, which shouldn't have kasan_debug enabled, hence the unlikely.
But technically this function shouldn't be called in production
anyway, so likely will do fine too.

> And AFAIK, this function should only be called if kasan_debug is true.

Yes, this WARN_ON is to make sure this doesn't happen.

[...]

> > +/* Whether to use syncronous or asynchronous tag checking. */
> > +static bool kasan_sync __ro_after_init;
>
> s/syncronous/synchronous/

Ack.

>
> > +static int __init early_kasan_mode(char *arg)
> > +{
> > +       if (!arg)
> > +               return -EINVAL;
> > +
> > +       if (strcmp(arg, "on") == 0)
> > +               kasan_mode = KASAN_MODE_ON;
> > +       else if (strcmp(arg, "debug") == 0)
>
> s/strcmp(..) == 0/!strcmp(..)/  ?

Sounds good.

[...]

> > @@ -60,6 +111,7 @@ void kasan_set_free_info(struct kmem_cache *cache,
> >  {
> >         struct kasan_alloc_meta *alloc_meta;
> >
> > +       WARN_ON(!static_branch_unlikely(&kasan_debug));
>
> What actually happens if any of these are called with !kasan_debug and
> the warning triggers? Is it still valid to execute the below, or
> should it bail out? Or possibly even disable KASAN entirely?

It shouldn't happen, but if it happens maybe it indeed makes sense to
disable KASAN here is a failsafe. It might be tricky to disable MTE
though, but I'll see what we can do here.

Thank you!
