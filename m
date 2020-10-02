Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431B6280D9F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 08:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgJBGs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 02:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgJBGs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 02:48:26 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45F4C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 23:48:25 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id q13so420752ejo.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 23:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J8AL8yHl5XUf+oARcqfxDLAGYCbuXqngBj+IQF3uLUQ=;
        b=GFZ4SnExAGpSUQcgEHltpw6VH2jvAIP1cM2337vQDxAVdtfAMn8c2mdZs7tq+274Gz
         3FtXj+EBj8JQwf6wy5lgJk0wUL0L0pQC0hHrZT8rDQp7JA7Bban1UWzpQmF0/tDcV71G
         OLGK2UD/RvehqDFkicq1AwY8jRZtPYDdXs2AQm/+x59ZXZ0m5jCe85J4LFD3CE2oDm1E
         HL+4eVuK4K76XQre+NGZAWWYGAg1pVHLvL7ZL+QJtpKRxQ52EXgiyp0Ytdt+ekDCLVUn
         1+Xf1SeqFAcmchY7wiOOOZT5do/DFkXASv/ezxxDLz8P+sfiTclHqih61mA7dC8y8QBv
         I8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J8AL8yHl5XUf+oARcqfxDLAGYCbuXqngBj+IQF3uLUQ=;
        b=cV7caQJjngBO3zCmgjngRaSr5PzcRF33brQNesb2n5O64QvCM0C7yXcNfa/1PEdXYm
         Rc+FOsNhGFckye5SFxFSU3O9WSJIb/HH2bmdmjVsHhWmPIINACVPUWmj3x1QvOYFtxxC
         aSXc4nPGcaupYferRR3SgBes/chW3jkFiEaCJOj2EYCTL3d7038YdcpPFs96oXxAr/NZ
         tLNlcl2YN8M09ovHkhXsOMTiGz8cg8etWp/CQyPcgutH0reRiM3gXT2QF30Cf3Zl2RCA
         TULD343esUhhJYaoDGRwJhZjVaqPGJmZVbziAn8fJ2xalEDtSAwDxFq7RWi2xbVJVceO
         3WBA==
X-Gm-Message-State: AOAM532cq5lE7x+G0q6UmYSht7Hi1a5PRWYvXvbEjMKz5z8Z095/kl2K
        pRdPj9uxaLwE/cElfMbg6Tu31HT41/29WJXmITr68Q==
X-Google-Smtp-Source: ABdhPJxMt5h3RYfoh7eIHfS603Dkxz7PzSINoCdxrX06/E0dZ7fbZ9ZYE70Z7vhsf1e4Sw5q9/98Rkz/TDBAYxVHVPw=
X-Received: by 2002:a17:906:394:: with SMTP id b20mr727889eja.513.1601621304442;
 Thu, 01 Oct 2020 23:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200929133814.2834621-1-elver@google.com> <20200929133814.2834621-4-elver@google.com>
In-Reply-To: <20200929133814.2834621-4-elver@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 2 Oct 2020 08:47:57 +0200
Message-ID: <CAG48ez1VNQo2HZSDDxUqtM4w63MmQsDc4SH0xLw92E6vXaPWrg@mail.gmail.com>
Subject: Re: [PATCH v4 03/11] arm64, kfence: enable KFENCE for ARM64
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
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 3:38 PM Marco Elver <elver@google.com> wrote:
> Add architecture specific implementation details for KFENCE and enable
> KFENCE for the arm64 architecture. In particular, this implements the
> required interface in <asm/kfence.h>. Currently, the arm64 version does
> not yet use a statically allocated memory pool, at the cost of a pointer
> load for each is_kfence_address().
[...]
> diff --git a/arch/arm64/include/asm/kfence.h b/arch/arm64/include/asm/kfence.h
[...]
> +static inline bool arch_kfence_initialize_pool(void)
> +{
> +       const unsigned int num_pages = ilog2(roundup_pow_of_two(KFENCE_POOL_SIZE / PAGE_SIZE));
> +       struct page *pages = alloc_pages(GFP_KERNEL, num_pages);
> +
> +       if (!pages)
> +               return false;
> +
> +       __kfence_pool = page_address(pages);
> +       return true;
> +}

If you're going to do "virt_to_page(meta->addr)->slab_cache = cache;"
on these pages in kfence_guarded_alloc(), and pass them into kfree(),
you'd better mark these pages as non-compound - something like
alloc_pages_exact() or split_page() may help. Otherwise, I think when
SLUB's kfree() does virt_to_head_page() right at the start, that will
return a pointer to the first page of the entire __kfence_pool, and
then when it loads page->slab_cache, it gets some random cache and
stuff blows up. Kinda surprising that you haven't run into that during
your testing, maybe I'm missing something...

Also, this kinda feels like it should be the "generic" version of
arch_kfence_initialize_pool() and live in mm/kfence/core.c ?
