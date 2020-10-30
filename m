Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D387C2A06B6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 14:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgJ3NrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 09:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgJ3NrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:47:00 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6B1C0613D4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 06:46:53 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id x1so6647665oic.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 06:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L9KsQ649Ydk+F62S7OnKir8xMXm76fswU9q4GRYaxwA=;
        b=ADogkMyeqzMi65mLW89eeqxIGlmWBYfTZ3bx3nTmGY2wkQ6ew8sNjqD3uCULVKqUBx
         onwBT2ZjgdJeC+Ep0EzvoTvRnAW+7Iiyz/5yg7sD3QireG2CCRHS4HyyFb0a9sVm4Gkx
         oK82pyK24ABm86duxNdYoH4hRNUNuqmxLkaaFdx57gQBJ1bVnIgROlYmlYkkJWUifom+
         jVyfyKxvVyc1QRuPHf7ZI42FxPpsi/MDAFg5vR+O2aNlLtDCXRhTiwTAI53bIKW7tEOt
         sxaK6rXBYliu3y15wi8dcdrb3eape6+JDJFEJWvX3eZs2nbse3syqEqt/L1LVuSMUunF
         HVTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L9KsQ649Ydk+F62S7OnKir8xMXm76fswU9q4GRYaxwA=;
        b=jP6XzFtRBwTOpjnugWfDJDCCL0uxtAUzCTmjhBgaKFLcv7PQ0192jvSoigy6KFLqLp
         C+UYrjidQYsb3wHfYYCFfjSBp0+z8nOMuwmn/31mcE6MG2drKMdlLoVw3W/mf4a/CmAd
         B6zJ+Xc3jSTFUK9iTyDT4DXwjjt0K1BsZ7wcDG2sGW8v9y/1hr92T6Gg54jveZUUWDG2
         gYqRhZKCWRPrcjTFcwCTCzLYngGoVlJsYYIwgy5yTi0ECrws8RBgSDm/AqaqRw8oBb2l
         Wkip2Hee9mC4YdIsFi4ORNN8oOw5wpWA4cAi/5yP7GChBwVlvHBDquGdI4Jd7Ai2DTjQ
         c3dw==
X-Gm-Message-State: AOAM531VkhuqEplxmaEA/GS7PynXc+ZxjjsFICDqthOxUAkXRNz+/f2d
        x0n2EWk4aa3n3npJWZNxyDeSxGCLKUjdNBhmvaZP0g==
X-Google-Smtp-Source: ABdhPJxtllrD/ti+v3NOGXiV4JmOCXFOuYxncPEQf23c9uErySYb6wPEvDGJEVT3VNX7Kda0gfhJ/kKTgntzgs7XD78=
X-Received: by 2002:a54:4812:: with SMTP id j18mr1740133oij.70.1604065612340;
 Fri, 30 Oct 2020 06:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <20201029131649.182037-1-elver@google.com> <20201029131649.182037-7-elver@google.com>
 <CAG48ez0N5iKCmg-JEwZ2oKw3zUA=5EdsL0CMi6biwLbtqFXqCA@mail.gmail.com>
In-Reply-To: <CAG48ez0N5iKCmg-JEwZ2oKw3zUA=5EdsL0CMi6biwLbtqFXqCA@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 30 Oct 2020 14:46:40 +0100
Message-ID: <CANpmjNONPovgW6d4srQNQ-S-tiYCSxot7fmh=HDOdcRwO32z6A@mail.gmail.com>
Subject: Re: [PATCH v6 6/9] kfence, kasan: make KFENCE compatible with KASAN
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        =?UTF-8?Q?J=C3=B6rn_Engel?= <joern@purestorage.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        SeongJae Park <sjpark@amazon.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Oct 2020 at 03:50, Jann Horn <jannh@google.com> wrote:
>
> On Thu, Oct 29, 2020 at 2:17 PM Marco Elver <elver@google.com> wrote:
> > We make KFENCE compatible with KASAN for testing KFENCE itself. In
> > particular, KASAN helps to catch any potential corruptions to KFENCE
> > state, or other corruptions that may be a result of freepointer
> > corruptions in the main allocators.
> >
> > To indicate that the combination of the two is generally discouraged,
> > CONFIG_EXPERT=y should be set. It also gives us the nice property that
> > KFENCE will be build-tested by allyesconfig builds.
> >
> > Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> > Co-developed-by: Marco Elver <elver@google.com>
> > Signed-off-by: Marco Elver <elver@google.com>
> > Signed-off-by: Alexander Potapenko <glider@google.com>
>
> Reviewed-by: Jann Horn <jannh@google.com>

Thanks!

> with one nit:
>
> [...]
> > diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> [...]
> > @@ -141,6 +142,14 @@ void kasan_unpoison_shadow(const void *address, size_t size)
> >          */
> >         address = reset_tag(address);
> >
> > +       /*
> > +        * We may be called from SL*B internals, such as ksize(): with a size
> > +        * not a multiple of machine-word size, avoid poisoning the invalid
> > +        * portion of the word for KFENCE memory.
> > +        */
> > +       if (is_kfence_address(address))
> > +               return;
>
> It might be helpful if you could add a comment that explains that
> kasan_poison_object_data() does not need a similar guard because
> kasan_poison_object_data() is always paired with
> kasan_unpoison_object_data() - that threw me off a bit at first.

Well, KFENCE objects should never be poisoned/unpoisoned because the
kasan_alloc and free hooks have a kfence guard, and none of the code
in sl*b.c that does kasan_{poison,unpoison}_object_data() should be
executed for KFENCE objects.

But I just noticed that kernel/scs.c seems to kasan_poison and
unpoison objects, and keeps them poisoned for most of the object
lifetime. I think we better add a kfence guard to
kasan_poison_shadow() as well.

Thanks,
-- Marco
