Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949D12C13EC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 20:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731704AbgKWSy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 13:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729298AbgKWSy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 13:54:58 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6255C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 10:54:58 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id v21so15119775pgi.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 10:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X9Zd5o6/t2zXpVPXOIa1lwnDSa6wxu3aYly3YlPdS4M=;
        b=SB0bFKQC1IahCohNpOijmMkJPynNzlupWkgYlnLXxcr1pTiUhBsBmDKsCkJijTP+0A
         tdRtIxaG3SuFiTFT4s3E/6hx9tnQ+UVq32qpqFB7b85j0YbiUUFP1Q1Af5TVjct+HItH
         RLGzHX1F3tnBZUK6zshlTKwBtS/W6Bj+qMeW7JgCu9pne9+B8+OyrbjpR/w7jpXrYUtN
         kjx6aiGbbemuqgBRBHASeQCol3l4zIQ1w5dzq3mBjpkyWYZS/lFMOnrAupR5trFkFu74
         88Hj617phBFazTycmAluIs6Dj1i+08wPJtX41RYXI4C+pVzQwRJACFSDjyUa9ENMU62i
         eqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X9Zd5o6/t2zXpVPXOIa1lwnDSa6wxu3aYly3YlPdS4M=;
        b=PffKhbE/WR5QSjTxUl+RJkYtlrnDj1gNdADOEpL8TkIy57h5/BFHJ7s4hOh83Uqv89
         X+5hAfbIAOc8IzCyDz63iTPxeaopfWTacm0C98ilRTMnUhNnxVKHY6VpP7f8EeHSqvX7
         C+mKFKNZcv1KmQTpYqQaXZjPvcikJwwIxAljLFqBTF/dOANTfdFyfYDrC4bYiwubKQVZ
         J+Gu0mFpbwmvR2SevnEH5TU0qogzbn78+7x7rFYzTadaK4sZIo7kuSsYbsr1ECvDZrWE
         3k6NmXNMwFS9EeOf1OKlymJu/qJ0DBrIw9AGwQYUWhJo3LYOPQMllHcWfWb+FKXzSFpD
         M/1Q==
X-Gm-Message-State: AOAM531MO6v10EvCJyXXElGY/eSGhv9YXuLmJtgwac6hzAAPLHYrwMMg
        YKFQCmoi4K43rP7W7jH2gpP1+be2L4rCu9LgKGrBww==
X-Google-Smtp-Source: ABdhPJymZ/rshm1MiuUEQ3q4JslwDegl9w0SF//t9LfI0JHeGkrk3A98AM8zb1bTarX85jHf4Zjwpw1sPFOYHR54sxk=
X-Received: by 2002:a17:90a:4215:: with SMTP id o21mr326674pjg.166.1606157698246;
 Mon, 23 Nov 2020 10:54:58 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605305978.git.andreyknvl@google.com> <52518837b34d607abbf30855b3ac4cb1a9486946.1605305978.git.andreyknvl@google.com>
 <CACT4Y+ZaRgqpgPRe5k5fVrhd_He5_6N55715YzwWcQyvxYUNRQ@mail.gmail.com>
In-Reply-To: <CACT4Y+ZaRgqpgPRe5k5fVrhd_He5_6N55715YzwWcQyvxYUNRQ@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 23 Nov 2020 19:54:47 +0100
Message-ID: <CAAeHK+xv2UQyD1MtAiu8d=cRbJDNXQaaA-Qh+Eut3gRnLbJEMA@mail.gmail.com>
Subject: Re: [PATCH mm v3 17/19] kasan: clean up metadata allocation and usage
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 2:12 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> >  void __kasan_poison_slab(struct page *page)
> >  {
> > @@ -272,11 +305,9 @@ void * __must_check __kasan_init_slab_obj(struct kmem_cache *cache,
> >         struct kasan_alloc_meta *alloc_meta;
> >
> >         if (kasan_stack_collection_enabled()) {
> > -               if (!(cache->flags & SLAB_KASAN))
> > -                       return (void *)object;
>
> Is it a subtle change in behavior?
> Previously we had an early return and also did not set tag, now we
> only skip memset but set tag... was it a bug before?...

This is a change in behavior, see the patch description. We now always
sanitize an object's contents, but only store/update the metadata when
it fits. I'll update the patch title, as it might sound confusing, as
it kind of implies we're not changing the behavior.

> > @@ -135,7 +135,12 @@ static void qlink_free(struct qlist_node *qlink, struct kmem_cache *cache)
> >         if (IS_ENABLED(CONFIG_SLAB))
> >                 local_irq_save(flags);
> >
> > +       /*
> > +        * As the object now gets freed from the quaratine, assume that its
> > +        * free track is now longer valid.
>
> typo: _no_ longer valid

Will fix!

>
> > +        */
> >         *(u8 *)kasan_mem_to_shadow(object) = KASAN_KMALLOC_FREE;
> > +
> >         ___cache_free(cache, object, _THIS_IP_);
> >
> >         if (IS_ENABLED(CONFIG_SLAB))
> > @@ -168,6 +173,9 @@ void quarantine_put(struct kmem_cache *cache, void *object)
> >         struct qlist_head temp = QLIST_INIT;
> >         struct kasan_free_meta *meta = kasan_get_free_meta(cache, object);
> >
> > +       if (!meta)
> > +               return;
>
> Humm... is this possible? If yes, we would be leaking the object here...
> Perhaps BUG_ON with a comment instead.

No, this isn't possible. Will turn this into a warning and add a comment.

Thanks!
