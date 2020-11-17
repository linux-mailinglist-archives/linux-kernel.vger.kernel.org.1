Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0EB12B6258
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 14:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731047AbgKQN1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 08:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731738AbgKQN1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 08:27:34 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD61C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 05:27:33 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id m65so15470433qte.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 05:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rm4APUToOIfygYhEOvJkSoAG2E8GzKBKMf6ZHBmKcsc=;
        b=ZJJ5+s5qN0ujEsOF3+4bu+lufZWanMYs1P6zadjBcMXyRvrgvOu0pVs/uoOy0Vw204
         6d1TfDyNgBPb5yiyiV0rLVV759WnvcfzPwDyGlpkf7/G4r+jpDkA40HhWEeGro0Xoh0F
         MxIbsu1YuzQieZDXe0GQQKxiQxyYFwuxjY0L6IhfR8xDqBXbU2ycmsd6i9df34DMKync
         KBZEd0T3xDXcz/W6P6oYwF00R4FOWD9VGvTxYn/KyCCnmTKJ90xPDMmrL0XEGh0Qt72A
         QSwsdtkJMnaK3Nz8EMnz6fGRk+oHOdzU5jkyqrg1VyywOTMl5SFzviEWasHWjwAGWw06
         FR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rm4APUToOIfygYhEOvJkSoAG2E8GzKBKMf6ZHBmKcsc=;
        b=Wqls60xaukGu/41YFe/RTeHleurUjMeBumYChjQBOH2Hh3fyezY6ayY1W5tUUVjVU4
         IFnJ4+E/LdKFEvYOgmZnvsIxujKnoGu6TnhoMMv/3TgYE3OqEtIYZjScay8O/jOAbgyk
         tnRo2DviBi7NPP9Slab0b0fUsvJC6oJGw9RZYIVYUOxau8MS5JF4Ai2zsR+y97rkFz/9
         sdmlXGhE1YxYnp9JGdOOLRywlNTuQt7XS48+/VmYRiLDSfBdOCnBAwuv1ukAkzFX+xhp
         jVQpbjap2x0Kaic34hSJIGDf47CaiQh48FlrXp2Qj1Leho+R3BMfb4q+wXNY3zgwwA7e
         38NQ==
X-Gm-Message-State: AOAM530FeQ7WOkfZXzCEmUUR/WwRYgFxJ13KjbCWQyAhS+/qbBhDhuC9
        7wsb6W7H12rNyG2EYLrLNivaK0dL6bWBSwfnMoYakA==
X-Google-Smtp-Source: ABdhPJzQ+4pShJ4NbuQHV4/uK/kOWEjlTGe13lNKPNMSSmikIEerUWrXEKvVSvlXJJxtw8fUxaDzmCSSbx56frbUhAY=
X-Received: by 2002:aed:2b47:: with SMTP id p65mr18425153qtd.337.1605619651889;
 Tue, 17 Nov 2020 05:27:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605305978.git.andreyknvl@google.com> <52518837b34d607abbf30855b3ac4cb1a9486946.1605305978.git.andreyknvl@google.com>
 <CACT4Y+ZaRgqpgPRe5k5fVrhd_He5_6N55715YzwWcQyvxYUNRQ@mail.gmail.com> <CANpmjNN6=5Vy5puLbhOQxSNUNptFA9jKKqnU4RXRcLb4JT=hJg@mail.gmail.com>
In-Reply-To: <CANpmjNN6=5Vy5puLbhOQxSNUNptFA9jKKqnU4RXRcLb4JT=hJg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 17 Nov 2020 14:27:20 +0100
Message-ID: <CACT4Y+b7NxEJmnYdoEcN68-t0ns2Px4JWbTrFFkCQVMmdXXKmQ@mail.gmail.com>
Subject: Re: [PATCH mm v3 17/19] kasan: clean up metadata allocation and usage
To:     Marco Elver <elver@google.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
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

On Tue, Nov 17, 2020 at 2:18 PM Marco Elver <elver@google.com> wrote:
>
> On Tue, 17 Nov 2020 at 14:12, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> > > +        */
> > >         *(u8 *)kasan_mem_to_shadow(object) = KASAN_KMALLOC_FREE;
> > > +
> > >         ___cache_free(cache, object, _THIS_IP_);
> > >
> > >         if (IS_ENABLED(CONFIG_SLAB))
> > > @@ -168,6 +173,9 @@ void quarantine_put(struct kmem_cache *cache, void *object)
> > >         struct qlist_head temp = QLIST_INIT;
> > >         struct kasan_free_meta *meta = kasan_get_free_meta(cache, object);
> > >
> > > +       if (!meta)
> > > +               return;
> >
> > Humm... is this possible? If yes, we would be leaking the object here...
> > Perhaps BUG_ON with a comment instead.
>
> If this is possible in prod-mode KASAN, a WARN_ON() that returns would be safer.

We only compile quarantine.c for CONFIG_KASAN_GENERIC.
