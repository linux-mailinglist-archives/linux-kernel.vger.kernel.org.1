Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0310B2860FF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 16:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgJGOPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 10:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbgJGOPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 10:15:04 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE184C061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 07:15:02 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id x1so2367714eds.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 07:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MIy1jMlxCOJ0Y5mtMw96kWf8MP2ZqHwIF09OmCxHd/s=;
        b=WCPWazuYKodAut6Dvw8x3qNRztwfkOsar0G2liazhPuQzvDvjg7Jukxi9uz54DhGNr
         Sf7OZr+4DI1+Tkas8S2Bif5F8O4CRhY4MehqWbqnsq3bOrD4HTjd/kb1acw5Tqguoqtv
         Rllh5USbqhULrd8U2UrO1YzU9hBKuL+LRjrkNln91SE0GleTS8gS/v2OlBk2x+kARzLU
         wB8a+PXnZkS5+d9nkv6+TUW5EH+GjQb1mCBjM/+WA55NTw6KPCP5yQvlsnCQ5UlPIr30
         jZl7ZGzHonK7hTlTbseBMPmmbTE23a89djvc1Z00KXGwgfUCf7c3uztATm1ENiA0CjV1
         m8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MIy1jMlxCOJ0Y5mtMw96kWf8MP2ZqHwIF09OmCxHd/s=;
        b=BAUEK8ODklESM3NOXcZTDidJwnO05mdsgOIpKuCyh9nvJAa4cDOlsFYx2u6nJKVuGP
         moGxuwZipWCwWCCWiUp1ScMrTeLa45mfFqjbCNRkWjLGAtRCCU6bp0+6AJXtlCNu7mPD
         rDT7LfH+1Mzgd1kDgeGxpB+CROH4XV5Moav8VsNjX0PSDQgQRA1zSpCr/D0j2BzIhx02
         utYsnDxD86mHjtlMKI0JxEGnHYl/NsrJFX3QHBJc9MeQNnJAeKjy3wJv2FDFqN6eWrrm
         kT5Lku2G9h2CZvrilZQZLaM3Xah+DMdAW9R1k0GA7OS8WU5JBa663yv7ahPfSYlaB00R
         p8cw==
X-Gm-Message-State: AOAM5333Ns9jtrvwnMGm+fIJOQLWyFz4g7r35+/MKPRa1qupdG9T4mJU
        /g4NZJj57GXAP5yh0+VFPCtG/SzRgntl2tLz4xaTYQ==
X-Google-Smtp-Source: ABdhPJwR/EYROZuqARz6G7n4XpMFS+ALLZjqv14b7utyykG9ti0A+TvzrhTUupRkmJLlxrAGOJoyhi7AI4L2KuqW7xA=
X-Received: by 2002:a05:6402:b0e:: with SMTP id bm14mr3934250edb.259.1602080101068;
 Wed, 07 Oct 2020 07:15:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200929133814.2834621-1-elver@google.com> <20200929133814.2834621-3-elver@google.com>
 <CAG48ez3OKj5Y8BURmqU9BAYWFJH8E8B5Dj9c0=UHutqf7r3hhg@mail.gmail.com> <CANpmjNP6mukCZ931_aW9dDqbkOyv=a2zbS7MuEMkE+unb7nYeg@mail.gmail.com>
In-Reply-To: <CANpmjNP6mukCZ931_aW9dDqbkOyv=a2zbS7MuEMkE+unb7nYeg@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 7 Oct 2020 16:14:34 +0200
Message-ID: <CAG48ez0sYZof_PDdNrqPUnNOCz1wcauma+zWJbF+VdUuO6x31w@mail.gmail.com>
Subject: Re: [PATCH v4 02/11] x86, kfence: enable KFENCE for x86
To:     Marco Elver <elver@google.com>
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

On Wed, Oct 7, 2020 at 3:09 PM Marco Elver <elver@google.com> wrote:
> On Fri, 2 Oct 2020 at 07:45, Jann Horn <jannh@google.com> wrote:
> > On Tue, Sep 29, 2020 at 3:38 PM Marco Elver <elver@google.com> wrote:
> > > Add architecture specific implementation details for KFENCE and enable
> > > KFENCE for the x86 architecture. In particular, this implements the
> > > required interface in <asm/kfence.h> for setting up the pool and
> > > providing helper functions for protecting and unprotecting pages.
> > >
> > > For x86, we need to ensure that the pool uses 4K pages, which is done
> > > using the set_memory_4k() helper function.
> > [...]
> > > diff --git a/arch/x86/include/asm/kfence.h b/arch/x86/include/asm/kfence.h
> > [...]
> > > +/* Protect the given page and flush TLBs. */
> > > +static inline bool kfence_protect_page(unsigned long addr, bool protect)
> > > +{
> > > +       unsigned int level;
> > > +       pte_t *pte = lookup_address(addr, &level);
> > > +
> > > +       if (!pte || level != PG_LEVEL_4K)
> >
> > Do we actually expect this to happen, or is this just a "robustness"
> > check? If we don't expect this to happen, there should be a WARN_ON()
> > around the condition.
>
> It's not obvious here, but we already have this covered with a WARN:
> the core.c code has a KFENCE_WARN_ON, which disables KFENCE on a
> warning.

So for this specific branch: Can it ever happen? If not, please either
remove it or add WARN_ON(). That serves two functions: It ensures that
if something unexpected happens, we see a warning, and it hints to
people reading the code "this isn't actually expected to happen, you
don't have to wrack your brain trying to figure out for which scenario
this branch is intended".

> > > +               return false;
> > > +
> > > +       if (protect)
> > > +               set_pte(pte, __pte(pte_val(*pte) & ~_PAGE_PRESENT));
> > > +       else
> > > +               set_pte(pte, __pte(pte_val(*pte) | _PAGE_PRESENT));
> >
> > Hmm... do we have this helper (instead of using the existing helpers
> > for modifying memory permissions) to work around the allocation out of
> > the data section?
>
> I just played around with using the set_memory.c functions, to remind
> myself why this didn't work. I experimented with using
> set_memory_{np,p}() functions; set_memory_p() isn't implemented, but
> is easily added (which I did for below experiment). However, this
> didn't quite work:
[...]
> For one, smp_call_function_many_cond() doesn't want to be called with
> interrupts disabled, and we may very well get a KFENCE allocation or
> page fault with interrupts disabled / within interrupts.
>
> Therefore, to be safe, we should avoid IPIs.

set_direct_map_invalid_noflush() does that, too, I think? And that's
already implemented for both arm64 and x86.

> It follows that setting
> the page attribute is best-effort, and we can tolerate some
> inaccuracy. Lazy fault handling should take care of faults after we
> set the page as PRESENT.
[...]
> > Shouldn't kfence_handle_page_fault() happen after prefetch handling,
> > at least? Maybe directly above the "oops" label?
>
> Good question. AFAIK it doesn't matter, as is_kfence_address() should
> never apply for any of those that follow, right? In any case, it
> shouldn't hurt to move it down.

is_prefetch() ignores any #PF not caused by instruction fetch if it
comes from kernel mode and the faulting instruction is one of the
PREFETCH* instructions. (Which is not supposed to happen - the
processor should just be ignoring the fault for PREFETCH instead of
generating an exception AFAIK. But the comments say that this is about
CPU bugs and stuff.) While this is probably not a big deal anymore
partly because the kernel doesn't use software prefetching in many
places anymore, it seems to me like, in principle, this could also
cause page faults that should be ignored in KFENCE regions if someone
tries to do PREFETCH on an out-of-bounds array element or a dangling
pointer or something.
