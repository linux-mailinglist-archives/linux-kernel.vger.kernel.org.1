Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 126C62A0347
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 11:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgJ3Kuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 06:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgJ3Kuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 06:50:46 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDD4C0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 03:50:45 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id d9so225899oib.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 03:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hvuWYo7Yuy4+Xoosva2YfT/B6vDa7o+k5TcZrFjzw2I=;
        b=mCyFqjN1bQQC8Hvkpi7xW/3dnxa3ThGOZg+0wqlUrAHvvhX8m/ncxpq7Pyp/dRRs3g
         4WEWXc3YTkQEmBo4hMY8pxvX5o+Gv/Ie9TXg7vKqqMwjs5D7KvUPpTYMZtWdx8246Vkw
         J6HR1GHDIFM02CVcqc8Kk+Y6oFzxFgYqMnr0GfrzLUtvoripkAXvu1boXzKL84jaqzZ0
         JLMFVm206/J5PjBOhMmilJ6+hEiScGTLGEKl7zMM1R9M2vfhOCCinAqTix2sr1UDctvr
         8/O6shRzAPdYkLPxVflRgSxCAY0CYhUvm76k9hSxcnPW4WCKFajDZSAKGSGrz5NSjsJN
         Ywlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hvuWYo7Yuy4+Xoosva2YfT/B6vDa7o+k5TcZrFjzw2I=;
        b=iodq8p4jt7QUgOghu0a3DWxtvHwrbVYDGUbuYrNEjl4yVP7+VeZaELq2BegvMx+GpL
         er+nZBjJlyzbAjgZAoX/wOpn1QV877oHOG2xm8gSIH8Xo3B48UXbmP8Pt/zoW/u+3bNa
         DxsPtKjtMWXFtPGakJ7Re8Nu8PXcAM/FUyXX5qnjx+05gm0qGJ7BU64pJoyqZTHrUxj1
         TiU+LoBaXH3rQTmL3aQgh6rc4hC95tpJ7aBZ1z2ZEj+mqNurCek5BUfnNhR7TsGw9Nld
         YRO6eGTCaXl1smyi6CV7xfDBv4BExCewKWm6nbqXooP2GUipbuA9Td9o1rD5lyrs2Ma2
         m/AQ==
X-Gm-Message-State: AOAM530zh9Ujr3xsdTluQyDGjpgjFE7b2Fpq2PlUKjwv2coxdOady6Pk
        +sLdfGPNLdp0tlU6TguHtlFgVMSA2E0zN4QHqFt0mg==
X-Google-Smtp-Source: ABdhPJw9y4ECaTHMdQAHz0FiGUzAKJL50sOGurP0au+ieUbVtdZIpyIHjQtwwPIJDX0B/6q9TBKmmH52j9NmaIeqdOQ=
X-Received: by 2002:aca:4f55:: with SMTP id d82mr1138528oib.172.1604055045058;
 Fri, 30 Oct 2020 03:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <20201029131649.182037-1-elver@google.com> <20201029131649.182037-9-elver@google.com>
 <CAG48ez071wf5kvBwpmRk9QiSDzDDN7zh17zEcZjPDWKUjbqosA@mail.gmail.com>
In-Reply-To: <CAG48ez071wf5kvBwpmRk9QiSDzDDN7zh17zEcZjPDWKUjbqosA@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 30 Oct 2020 11:50:32 +0100
Message-ID: <CANpmjNPDksUk1BLS9BuYrx4E3Lf+m2jWXn0yn7zO43c9PboAmw@mail.gmail.com>
Subject: Re: [PATCH v6 8/9] kfence: add test suite
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
> > Add KFENCE test suite, testing various error detection scenarios. Makes
> > use of KUnit for test organization. Since KFENCE's interface to obtain
> > error reports is via the console, the test verifies that KFENCE outputs
> > expected reports to the console.
> [...]
> > diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
> [...]
> > +static void *test_alloc(struct kunit *test, size_t size, gfp_t gfp, enum allocation_policy policy)
> > +{
> > +       void *alloc;
> > +       unsigned long timeout, resched_after;
> [...]
> > +       /*
> > +        * 100x the sample interval should be more than enough to ensure we get
> > +        * a KFENCE allocation eventually.
> > +        */
> > +       timeout = jiffies + msecs_to_jiffies(100 * CONFIG_KFENCE_SAMPLE_INTERVAL);
> > +       /*
> > +        * Especially for non-preemption kernels, ensure the allocation-gate
> > +        * timer has time to catch up.
> > +        */
> > +       resched_after = jiffies + msecs_to_jiffies(CONFIG_KFENCE_SAMPLE_INTERVAL);
> > +       do {
> [...]
> > +               if (time_after(jiffies, resched_after))
> > +                       cond_resched();
>
> You probably meant to recalculate resched_after after the call to
> cond_resched()?

This is intentional. After @resched_after is reached, every failed
allocation attempt will result in a cond_resched(), because we know
the sample interval has elapsed and KFENCE should have kicked in. So
we just want to ensure the delayed work gets to run as soon as
possible, and just keep yielding.

Added a clarifying comment.

> > +       } while (time_before(jiffies, timeout));
> > +
> > +       KUNIT_ASSERT_TRUE_MSG(test, false, "failed to allocate from KFENCE");
> > +       return NULL; /* Unreachable. */
> > +}
> [...]
> > +/*
> > + * KFENCE is unable to detect an OOB if the allocation's alignment requirements
> > + * leave a gap between the object and the guard page. Specifically, an
> > + * allocation of e.g. 73 bytes is aligned on 8 and 128 bytes for SLUB or SLAB
> > + * respectively. Therefore it is impossible for the allocated object to adhere
> > + * to either of the page boundaries.
>
> Should this be "to the left page boundary" instead of "to either of
> the page boundaries"?

Thanks for spotting. I think it's "Therefore it is impossible for the
allocated object to contiguously line up with the right guard page."

> > + * However, we test that an access to memory beyond the gap result in KFENCE
>
> *results
>
>
>
> > + * detecting an OOB access.
> > + */
> > +static void test_kmalloc_aligned_oob_read(struct kunit *test)

Thanks, will address these for v7.
