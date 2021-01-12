Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C66E2F3CC5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437216AbhALVeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 16:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436608AbhALUF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 15:05:26 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4474CC061794
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 12:04:46 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id b5so2401275pjl.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 12:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hLTG8Xi/M9/KLF1jIe2hcQQ+UFUOXooQujW3N5lnPGo=;
        b=Cs+4su4TJkM8QcOSmf0OcuHbESzt6w52kRbeUZamzlyoFwYvoll9zEhkOZveAYuCM+
         Eu4sCnw4sn8/zHQxtY9yGVm1ndHlBVJ+/wsmnusUu0SvtVkGlIaOo8AHfduaWZao5NOw
         C2tq0o4CVrk60JxPesRFOB7f3uMf4a2Kk018t70tas3/41eADOJiuVyckst7tIkX05RJ
         qYtJW/L6l6mHyYAG0ds7lphmJbHYhQAtvUgy0RjYIX8XPh/psWdZdPHKWnPH1ajqUjUC
         wy+D5JV2GlFUC2NcGOq0Grm/S1ejHC7clYhKUFUceykGabKD9o4Tzy4VRGHs1Eh9IShM
         nyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hLTG8Xi/M9/KLF1jIe2hcQQ+UFUOXooQujW3N5lnPGo=;
        b=qOBW4W+DU19XszAHR/S9dWox4gCV4heQhurPsjICE/+RyRqN7J3MN7K+v3agFsTset
         ILmvtRSBBBfHeiqMTbVUd6hk5Q6eMXRJNkUaFQ2vEdd3j3yArE5E51vYxl65eThYdX5i
         WbefSjD5axIiU93lDiSG+8L54Xh4LPtVYAWMm/zUgXFQaDN/7UsHr79uL1f73PcrT4Tn
         XG4QZ36l2ZRwF9rkOBT10suV2c1Cbz4OQ3D/jBW+27mAg60IWt6ZeuO5MysM8DO/e/qg
         r3Oc0h5r4s5cRZHfNwfc2Z/1EG9W0rfUZ/wXNPLZa0EbQSHHybCS/gBvswpwzrUp20fK
         jS6Q==
X-Gm-Message-State: AOAM530zK6Q4XtGmVel3b0QBKDjfaZ87ANXyRZR6mB1aQWFRclD7/9Hq
        DCt/Fs/vSKXLL0TImjnKVibPf28sS0o2/0rymNRXyg==
X-Google-Smtp-Source: ABdhPJxkdxK1pakMNPh5u9Y88KHsc9X/m/5rZ5VmLzgq01yUHKx7e6nwWFvKQONa6Zc+hCGiVVA4jFpgf8nnPAUv7oc=
X-Received: by 2002:a17:902:c144:b029:dc:292e:a8a1 with SMTP id
 4-20020a170902c144b02900dc292ea8a1mr826431plj.13.1610481885659; Tue, 12 Jan
 2021 12:04:45 -0800 (PST)
MIME-Version: 1.0
References: <cover.1609871239.git.andreyknvl@google.com> <9a4f47fe8717b4b249591b307cdd1f26c46dcb82.1609871239.git.andreyknvl@google.com>
 <CAG_fn=X0YY8+FUWWyLqGUu5Z6-eEaSAOVGYj9PKzhzqyA1BvsA@mail.gmail.com>
In-Reply-To: <CAG_fn=X0YY8+FUWWyLqGUu5Z6-eEaSAOVGYj9PKzhzqyA1BvsA@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 12 Jan 2021 21:04:34 +0100
Message-ID: <CAAeHK+wv4bZxSx4c+mjttRmhPFb2s0LM3Cey_GxfkVhxmgdsGQ@mail.gmail.com>
Subject: Re: [PATCH 08/11] kasan: adopt kmalloc_uaf2 test to HW_TAGS mode
To:     Alexander Potapenko <glider@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
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

On Tue, Jan 12, 2021 at 9:26 AM Alexander Potapenko <glider@google.com> wrote:
>
> Nit: s/adopt/adapt in the title.
>
>
> > +again:
> >         ptr1 = kmalloc(size, GFP_KERNEL);
> >         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr1);
> >
> > @@ -384,6 +386,13 @@ static void kmalloc_uaf2(struct kunit *test)
> >         ptr2 = kmalloc(size, GFP_KERNEL);
> >         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr2);
> >
> > +       /*
> > +        * For tag-based KASAN ptr1 and ptr2 tags might happen to be the same.
> > +        * Allow up to 4 attempts at generating different tags.
> > +        */
> > +       if (!IS_ENABLED(CONFIG_KASAN_GENERIC) && ptr1 == ptr2 && counter++ < 4)
> > +               goto again;
> > +
>
> Looks like we are leaking memory allocated for ptr2 here?

Will fix in v2, thanks!
