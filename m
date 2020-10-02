Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7878280E49
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 09:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgJBHyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 03:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgJBHyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 03:54:03 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FEEC0613E2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 00:54:03 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id k14so721451edo.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 00:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e6vV2mQW9X/bc3rvl043TXcmZeVV1Y9QdMUbU/DoAeE=;
        b=ZImYzlgjXsFUc2CCMT9j97ZUOzil+3t99KxFvX4NmLd7QCKth6NtxJkTizVZrbxLJl
         XuvPQrG5tlvHtzGj+IlQKy5HBgv5uBemIZU053zhGAVXxs2OXDmzcmv7i1ITAS9v7aax
         HfJzfaD+0Uz9InQ58lwv3LPQblvNPk0i+iIhujWGXNEhWqaDtFuS8Zpc+hkUOCx7E9xi
         WF0YlRjZrwO+Y/k728n8WDQqJ3TnLJJISWx8k2HM9urYCqKo0eZ02BDG/XfaH2eIEA6W
         nQPGal9DyIq+497MJY0Pfaf3Rge5lwVUdXx+8GDCqnhvOg82rS7CxbgH7Tg5SWvEyt3R
         iT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e6vV2mQW9X/bc3rvl043TXcmZeVV1Y9QdMUbU/DoAeE=;
        b=N0RA7v8lAA3bbZZcVKKbZ+Pama4GjstaS0ce9B6iHdziyXpMrSI845G/Kx7y3xRC1R
         hGiJMLnvasF1UUXDmWLkxiwH5X0oZdblu4CLT6bKdqJ7JwonArfZb0KY+aG74iH9FZnj
         sWZniHPwsRJaJ/an0mOY5zQVN1Gk0oYHH7FTlpdyfR8QDy227bXPLiWyFtOxrkXrkpc1
         JwYXX9ahcOmzk1spxRCrPn0IBfsJAgEYRKd0yNiApdIOaEh28ClCxhwHfS9iotD+4TwB
         9NvZouCty7Ye6/CRyRa2VMQeWMVlQJgKOlEmETbx0xLtNDSm15xAGREahKfntQ9iJ9FJ
         eWCg==
X-Gm-Message-State: AOAM5337kB9ogVgT8K6b0nnZrCs+lunEevVwNMDI6khPFwKQsnMC6nDo
        90t+cfrsaWU1Vo0sfUwDMnEvB4ZZ0zgOgEgfy8Nc/A==
X-Google-Smtp-Source: ABdhPJw8JCv+/xESYG7KtHUsTPSjS1wwtCM31dmLgZK5YLiFsgcQliR929HzUjpB/jwncke9ycuFEY9U+TB0Bt5y718=
X-Received: by 2002:a05:6402:b0e:: with SMTP id bm14mr1055829edb.259.1601625241408;
 Fri, 02 Oct 2020 00:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200929133814.2834621-1-elver@google.com> <20200929133814.2834621-2-elver@google.com>
 <CAG48ez3+_K6YXoXgKBkB8AMeSQj++Mxi5u2OT--B+mJgE7Cyfg@mail.gmail.com>
In-Reply-To: <CAG48ez3+_K6YXoXgKBkB8AMeSQj++Mxi5u2OT--B+mJgE7Cyfg@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 2 Oct 2020 09:53:34 +0200
Message-ID: <CAG48ez1MQks2na23g_q4=ADrjMYjRjiw+9k_Wp9hwGovFzZ01A@mail.gmail.com>
Subject: Re: [PATCH v4 01/11] mm: add Kernel Electric-Fence infrastructure
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
        Ingo Molnar <mingo@redhat.com>, Jonathan.Cameron@huawei.com,
        Jonathan Corbet <corbet@lwn.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, sjpark@amazon.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-doc@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>, SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 2, 2020 at 8:33 AM Jann Horn <jannh@google.com> wrote:
> On Tue, Sep 29, 2020 at 3:38 PM Marco Elver <elver@google.com> wrote:
> > This adds the Kernel Electric-Fence (KFENCE) infrastructure. KFENCE is a
> > low-overhead sampling-based memory safety error detector of heap
> > use-after-free, invalid-free, and out-of-bounds access errors.
> >
> > KFENCE is designed to be enabled in production kernels, and has near
> > zero performance overhead. Compared to KASAN, KFENCE trades performance
> > for precision. The main motivation behind KFENCE's design, is that with
> > enough total uptime KFENCE will detect bugs in code paths not typically
> > exercised by non-production test workloads. One way to quickly achieve a
> > large enough total uptime is when the tool is deployed across a large
> > fleet of machines.
[...]
> > +/*
> > + * The pool of pages used for guard pages and objects. If supported, allocated
> > + * statically, so that is_kfence_address() avoids a pointer load, and simply
> > + * compares against a constant address. Assume that if KFENCE is compiled into
> > + * the kernel, it is usually enabled, and the space is to be allocated one way
> > + * or another.
> > + */
>
> If this actually brings a performance win, the proper way to do this
> would probably be to implement this as generic kernel infrastructure
> that makes the compiler emit large-offset relocations (either through
> compiler support or using inline asm statements that move an immediate
> into a register output and register the location in a special section,
> kinda like how e.g. static keys work) and patches them at boot time,
> or something like that - there are other places in the kernel where
> very hot code uses global pointers that are only ever written once
> during boot, e.g. the dentry cache of the VFS and the futex hash
> table. Those are probably far hotter than the kfence code.
>
> While I understand that that goes beyond the scope of this project, it
> might be something to work on going forward - this kind of
> special-case logic that turns the kernel data section into heap memory
> would not be needed if we had that kind of infrastructure.

After thinking about it a bit more, I'm not even convinced that this
is a net positive in terms of overall performance - while it allows
you to avoid one level of indirection in some parts of kfence, that
kfence code by design only runs pretty infrequently. And to enable
this indirection avoidance, your x86 arch_kfence_initialize_pool() is
shattering potentially unrelated hugepages in the kernel data section,
which might increase the TLB pressure (and therefore the number of
memory loads that have to fall back to slow page walks) in code that
is much hotter than yours.

And if this indirection is a real performance problem, that problem
would be many times worse in the VFS and the futex subsystem, so
developing a more generic framework for doing this cleanly would be
far more important than designing special-case code to allow kfence to
do this.

And from what I've seen, a non-trivial chunk of the code in this
series, especially the arch/ parts, is only necessary to enable this
microoptimization.

Do you have performance numbers or a description of why you believe
that this part of kfence is exceptionally performance-sensitive? If
not, it might be a good idea to remove this optimization, at least for
the initial version of this code. (And even if the optimization is
worthwhile, it might be a better idea to go for the generic version
immediately.)
