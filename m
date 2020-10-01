Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A2F27FE4D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 13:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731964AbgJALZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 07:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731134AbgJALZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 07:25:03 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2721FC0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 04:25:02 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id t10so5258393wrv.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 04:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rIrqsNB2CCkv+5Up492E6RUjeUyfI0426YjKqnUmMhw=;
        b=QCZTFGmpea3i9RVr/67JK8ZN36dSLFeJjSgI6yS88Ca8rxeTc7ji8wthxQWMpuy6L5
         u38dUNAPrZ77ARjpb1ujurLSC6fur8w2OAkwLL02Za5S8+J4n9uwpZdfMlMOgj5kIS/x
         YH8nDHFCe4v3IU0+qrJygKqAgr+frNx0suL3E6RPhxO+uEp8EGRu3tKOOHOJAVwvjSnJ
         1khf7ghrPbRMUyZOLWNxZ8J2oV4KE7oaZDCSSE5t6aEdfcrbfOkDVUWOjiVSKQnB0cay
         kTucVLYQhI+hSkAC7BzKpjTg8tSYzuviz1LuY68gXQYPam7gwzl/XpH8Ue9QmTxNm6jZ
         BV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rIrqsNB2CCkv+5Up492E6RUjeUyfI0426YjKqnUmMhw=;
        b=uY1gXoTSJYvCHXm4KRQLIoR0usoBa+GW8/D2SioZJ9e5a73/ZegnDFxsUEUDKv4f3b
         EFPafajxaEaA5fjJi6NdLeSuWRIX39T54W2dgBS9QVLtOD0mXpKLb6iY066hablAk2Gr
         mpChrK9RqUblH+Ar31lcrDAEEfP7TbtLIxhCHBi2++4mMgQgAp3UvSS1Ej8hBgOm2qwA
         vxN8KeL0S2CNMsx7gpaRBWZpU7T4PUvH+wvyXVcMToVo8dwKlBijt0T6XfymQutOMIJT
         O6cnjC7DSk7ZCJn6TpAPeIHNh7rLLsESjc8d//38zuvkpYmn3hpXQcmI7TLW5SzTvLji
         Lc2Q==
X-Gm-Message-State: AOAM533N3CEfetvq7Ln+igin9adg/TM9S6nqqBEdJnZvDeOYB46dolQ/
        iljBVqrz8647Erb6qcO630Tz0qQ+e8rLit/rz4PWbQ==
X-Google-Smtp-Source: ABdhPJzGuN41NKZ9z4kTko7jROyZG/OJ7AHb1nE6sC1xk6wR5ZdnjF4TzEwMBHuBpFfZC3poYstIgrbkwtRyeClLy/A=
X-Received: by 2002:adf:f101:: with SMTP id r1mr8370892wro.314.1601551500540;
 Thu, 01 Oct 2020 04:25:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200921132611.1700350-1-elver@google.com> <20200921132611.1700350-4-elver@google.com>
 <20200921143059.GO2139@willie-the-truck> <CAG_fn=WXknUnNmyniy_UE7daivSNmy0Da2KzNmX4wcmXC2Z_Mg@mail.gmail.com>
 <20200929140226.GB53442@C02TD0UTHF1T.local>
In-Reply-To: <20200929140226.GB53442@C02TD0UTHF1T.local>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 1 Oct 2020 13:24:49 +0200
Message-ID: <CAG_fn=VOR-3LgmLY-T2Fy6K_VYFgCHK0Hv+Y-atrvrVZ4mQE=Q@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] arm64, kfence: enable KFENCE for ARM64
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will@kernel.org>, Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        SeongJae Park <sjpark@amazon.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark,

> If you need virt_to_page() to work, the address has to be part of the
> linear/direct map.
>
> If you need to find the struct page for something that's part of the
> kernel image you can use virt_to_page(lm_alias(x)).
>
> > Looks like filling page table entries (similarly to what's being done
> > in arch/arm64/mm/kasan_init.c) is not enough.
> > I thought maybe vmemmap_populate() would do the job, but it didn't
> > (virt_to_pfn() still returns invalid PFNs).
>
> As above, I think lm_alias() will solve the problem here. Please see
> that and CONFIG_DEBUG_VIRTUAL.

The approach you suggest works to some extent, but there are some caveats.

To reiterate, we are trying to allocate the pool (2Mb by default, but
users may want a bigger one, up to, say, 64 Mb) in a way that:
(1) The underlying page tables support 4K granularity.
(2) is_kfence_address() (checks that __kfence_pool <= addr <=
__kfence_pool + KFENCE_POOL_SIZE) does not reference memory
(3) For addresses belonging to that pool virt_addr_valid() is true
(SLAB/SLUB rely on that)

On x86 we achieve (2) by making our pool a .bss array, so that its
address is known statically. Aligning that array on 4K and calling
set_memory_4k() ensures that (1) is also fulfilled. (3) seems to just
happen automagically without any address translations.

Now, what we are seeing on arm64 is different.
My understanding (please correct me if I'm wrong) is that on arm64
only the memory range at 0xffff000000000000 has valid struct pages,
and the size of that range depends on the amount of memory on the
system.
This probably means we cannot just pick a fixed address for our pool
in that range, unless it is very close to 0xffff000000000000.

If we allocate the pool statically in the way x86 does (assuming we
somehow resolve (1)), we can apply lm_alias() to addresses returned by
the KFENCE allocator, making kmalloc() always return addresses from
the linear map and satisfying (3).
But in that case is_kfence_address() will also need to be updated to
compare the addresses to lm_alias(__kfence_pool), and this becomes
more heavyweight than just reading the address from memory.

So looks like it's still more preferable to allocate the pool
dynamically on ARM64, unless there's a clever trick to allocate a
fixed address in the linear map (DTS maybe?)

Thanks,
Alex
