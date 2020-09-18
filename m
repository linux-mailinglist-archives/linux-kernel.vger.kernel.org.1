Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4450326FACF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 12:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgIRKnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 06:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgIRKnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 06:43:06 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D4EC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 03:43:05 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mm21so2948702pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 03:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S9SAa/84nB2osuzsORgaf8qh3oxqH7rlg5G0FU1VaYc=;
        b=bOdZjXxZzVq4s0SnOu+DbuuuURLjZvDMVtq68Kdysi/LsqJT5ZqeV/O6fxQ1Qua4Q/
         0kTy/EkFE6ZfQf4ix6rjGEI72DFpD78mLP9D3T38+vMHRqqj9xkAR479LnB9B2438GCD
         8+zTgr7mtdCyy/yEu/1AS4VFNQcko2XvnSvgL+ArDr49S/zLPxkm3rqiFACZeVuqsbk/
         7iEtinsw93RoKVrkPs0hshAjmdxc5Zt+TRfm8w6hl2EK9U40DrMGJe9+eXJyAw+ukxfH
         BhslAbOsKnUueXu7CHGG6kDwz2AlwjNC5SfvuJsxYFaMCGAJMDpZxuVDkquwgNCPRDRk
         WhRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S9SAa/84nB2osuzsORgaf8qh3oxqH7rlg5G0FU1VaYc=;
        b=fGuUO6q+Q0EMqbPJLbYCGWDuv4JuEa7r8hq2Qj+mN7cH2ImVqVDKQMXPpP5hDHc9hv
         RGkZevNBlLd2k8X/D4Fj8vRvpEYGcAvL0gJA5EeQ2gBgmn3THdexkj+kie/w8k20os20
         nXOzqYThRDwLhXuMAJHWLngN/NMo39Kr8dvZ0RORzDQ/IGM4+3sOlAq+IDVErX5Dyzak
         uIgTx7eipNnuRLHg9nNEXHAfRAQWoGkyuxg2LTIDWEpwgtz2j4I+r35hWTxy9BmKQWJQ
         SUBLd2rN6o3WunhSFMyVnp4YCOZtInaEf+oe2EODHy4OpRDh8++maaVDkZaUB9srVv7k
         4Jfw==
X-Gm-Message-State: AOAM533oqI9D3eKt1zzeCdbEtS8js2NUOfwfKHrK02Jh9qKpElP67BxS
        py8/WeQVLxQCIERe3GlP4e91wCdZ52Keh1240bI42w==
X-Google-Smtp-Source: ABdhPJxnrOgYw6qA2+D5NTJzUs1S3dk64U3zd0IVWXcN8DbrU/MiRk37vG/5/VNgFairvaplpO+hAqFfw8eBXXDL2JM=
X-Received: by 2002:a17:902:b117:b029:d1:e5e7:bdf5 with SMTP id
 q23-20020a170902b117b02900d1e5e7bdf5mr14202673plr.85.1600425785327; Fri, 18
 Sep 2020 03:43:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600204505.git.andreyknvl@google.com> <0d1862fec200eec644bbf0e2d5969fb94d2e923e.1600204505.git.andreyknvl@google.com>
 <CAG_fn=X8uQoZUXM0cU8NwF41znWiFQS1GjSNtrh5-xM02-nnJw@mail.gmail.com>
In-Reply-To: <CAG_fn=X8uQoZUXM0cU8NwF41znWiFQS1GjSNtrh5-xM02-nnJw@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 18 Sep 2020 12:42:54 +0200
Message-ID: <CAAeHK+y__nEtGeS2iQ5Uj+tUB6AwFDg3u3FdF7kcTgmq73OGpA@mail.gmail.com>
Subject: Re: [PATCH v2 05/37] kasan: rename KASAN_SHADOW_* to KASAN_GRANULE_*
To:     Alexander Potapenko <glider@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 10:04 AM 'Alexander Potapenko' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> On Tue, Sep 15, 2020 at 11:16 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> > This is a preparatory commit for the upcoming addition of a new hardware
> > tag-based (MTE-based) KASAN mode.
> >
> > The new mode won't be using shadow memory, but will still use the concept
> > of memory granules.
>
> KASAN documentation doesn't seem to explain this concept anywhere (I
> also checked the "kasan: add documentation for hardware tag-based
> mode" patch), looks like it's only mentioned in MTE documentation.
> Could you please elaborate on what we consider a granule in each of KASAN modes?

Sure, will do in v3, thanks!
