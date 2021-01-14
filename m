Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3052F64AC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 16:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbhANPcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 10:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbhANPco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 10:32:44 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328CFC061574
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 07:32:04 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id g15so3995231pgu.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 07:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b1a4WcSAwlYzo0UVF2lRgmzbjdobg4wJJNHBjscc+aU=;
        b=Tkj04O8NIGP7QDG5QTP6bp8Db1EvdW4IPCh4lJItQRb5f79KL8pGxUw0gaJnz4QYr9
         A/mUAUJhro+oeSHfysLYmNo/wUWCKeg/NRlS7SYxV+C97fjHSwr0/IR/xBJ0DzYVV3k8
         mwdnEe6hoxje/KVyNShsUXEtt/C//jkQFvZSG+0Z7rz/aT/s106uCI+G6qp4yuXBEJfn
         e+Bbhc5pQLWmt0dJauY7eJWtsDVC5y1fRCPPw3FQ5gXsKSLUZz0efQ9Q8sfGta7UeR0z
         L+cLxO9D5jsYwYZDw8oprrz5C3K4xhNVy7K55IwDwnewfIbAz0LSD3V/uXz4tucEBClg
         VR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b1a4WcSAwlYzo0UVF2lRgmzbjdobg4wJJNHBjscc+aU=;
        b=eSW3VqWVFcezJYXRsl99p+OYjTz5gsqi+cjlZwPWhNbiSbo9/Ao1y3kGRrNOBrod3Y
         NvKJ4Hy0fi71/jXexdJcB335bQFfaWH8uqfeIdeymXjkdEFFxSdQIgaUkfrPu44wDeQh
         zAG4dYyAViudzuVOLPaQlp039FicezGtYkCi+y07zncXZ1ggS+V8+evi8XTlHb9TR2AY
         SqNoUziq5kFH8GSD/2pfbV/TdK+TUxBDl8sWOrPXj+gPqZP0wez2Ri3d/Mk1WFYCQatr
         fWA7VUIFracQPZ1OOEJQ2fSJ+el2nsRqjweTQ0cTrAwPJQmen3tUz7eKOfi3GdKNuD66
         enAw==
X-Gm-Message-State: AOAM533fIeAqzDcL41y/LuiVu8vFR0bvAGMnQWqomeULSJ2F2JWJQfn7
        pTcNb3FTRIMMooNpQM7ITDk/UOyPL8XGjNLlC4xMCg==
X-Google-Smtp-Source: ABdhPJy6G0GBGFULP7NhjdO3HD2T54WVV8L/v5iwDgvCd8Ty8DE+K8f7iPevGNXlqln2anKMgDYFsA8Za2uu3zNB0L8=
X-Received: by 2002:a63:4644:: with SMTP id v4mr8086639pgk.440.1610638323387;
 Thu, 14 Jan 2021 07:32:03 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610553773.git.andreyknvl@google.com> <7fbac00e4d155cf529517a165a48351dcf3c3156.1610553774.git.andreyknvl@google.com>
 <25aa25d6-080c-ccfa-9367-fc60f46ff10f@suse.cz>
In-Reply-To: <25aa25d6-080c-ccfa-9367-fc60f46ff10f@suse.cz>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 14 Jan 2021 16:31:52 +0100
Message-ID: <CAAeHK+xgdS+vSTN81uLzahB9BYf=+iJdckwS=v7AwRACAf0wfw@mail.gmail.com>
Subject: Re: [PATCH 1/2] kasan, mm: fix conflicts with init_on_alloc/free
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 6:25 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 1/13/21 5:03 PM, Andrey Konovalov wrote:
> > A few places where SLUB accesses object's data or metadata were missed in
> > a previous patch. This leads to false positives with hardware tag-based
> > KASAN when bulk allocations are used with init_on_alloc/free.
> >
> > Fix the false-positives by resetting pointer tags during these accesses.
> >
> > Link: https://linux-review.googlesource.com/id/I50dd32838a666e173fe06c3c5c766f2c36aae901
> > Fixes: aa1ef4d7b3f67 ("kasan, mm: reset tags when accessing metadata")
> > Reported-by: Dmitry Vyukov <dvyukov@google.com>
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>
> > ---
> >  mm/slub.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/slub.c b/mm/slub.c
> > index dc5b42e700b8..75fb097d990d 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -2791,7 +2791,8 @@ static __always_inline void maybe_wipe_obj_freeptr(struct kmem_cache *s,
> >                                                  void *obj)
> >  {
> >       if (unlikely(slab_want_init_on_free(s)) && obj)
> > -             memset((void *)((char *)obj + s->offset), 0, sizeof(void *));
> > +             memset((void *)((char *)kasan_reset_tag(obj) + s->offset),
> > +                     0, sizeof(void *));
> >  }
> >
> >  /*
> > @@ -2883,7 +2884,7 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
> >               stat(s, ALLOC_FASTPATH);
> >       }
> >
> > -     maybe_wipe_obj_freeptr(s, kasan_reset_tag(object));
> > +     maybe_wipe_obj_freeptr(s, object);
>
> And in that case the reset was unnecessary, right. (commit log only mentions
> adding missing resets).

The reset has been moved into maybe_wipe_obj_freeptr(). I'll mention
it in the changelog in v2.

Thanks!
