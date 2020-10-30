Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D79B329FBB4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 03:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgJ3CuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 22:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgJ3CuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 22:50:16 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8087C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:50:15 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id d24so5306391ljg.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=29/mvfnx5ijMJBRqUvdSEy/Y/vTbwUpvdNL7Ey86vSQ=;
        b=faQ03KFXKTqcZsL9fNFS449tMLuSCnxgJhFtKnocwN9b8EWh6TdCML+T98o4vgW7Bu
         XCQiDVChwaKfpII7QJ2X4N5GwQ1TPBeAjfsX/8MLjFClRaQq+OqOOfP+roZR/UGlXVbb
         4YgxL9/KNeIMCBpTL8YLMVECSbAzn3aDvGoLs04L1RJZGeLUvrTQRykq5sSoL1e+g9wg
         h7UL/N4Xs7ifr6BQXsfIqsuv9NA8kAuUtAe3XL1FrrBskNV6jNxlegPBEkzQoyGx4ZGK
         XDJ6FzSnZVFU10lqVIb2wCF7ByrUQ9rGD6xhdqwFvzrziUaCOySrO9CoTcPqUBJKDnBT
         MNUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=29/mvfnx5ijMJBRqUvdSEy/Y/vTbwUpvdNL7Ey86vSQ=;
        b=H0PVU/q59xd/xEgi+Nem2ii+Yugnw2dxBOsC+KnOW81vinYJKsz3UFvO2qKawFy6ky
         /0gywFHGFPV0BH0nfKGPfM78lj0vHNMcCNgYWWbBII4kFvewREtqfGlm0nbh1yY/cSlt
         ru5O4pLLVPDmUrvcboWKoExrQ2fQYsbt0WCR4HkUrOTRwN0HiLfHr4cUg9lru0nLCSh3
         U6hHh0qlGWl+V8CDRU6x/UIb67K6FpeEGp/8OBEZQoK/FuuwLZ+LZmW756jb4sskUK1A
         XNaqEA445+z0uptEpAA8/2HPPHnTDmGsrBRSSwKm1LwftSngdir3dlVFnFSYdCBMOhTQ
         yHsw==
X-Gm-Message-State: AOAM532eL43GsDcHBgm1MZXVBBs7REwHB1H7Fywqb1xpOTUJbKEw6czx
        p4owthYbixNcd/WEkU2654oDsgYTTLTtPI+D+WB+9w==
X-Google-Smtp-Source: ABdhPJy0sA1WwM3kiKvHJaFMz/TR3IbjqMOlo5/1P3W63q7nS9+CEqGgFqxqrIzS0II1dZBsMQzuyhJLO08x8Y27c1k=
X-Received: by 2002:a2e:9f13:: with SMTP id u19mr101336ljk.160.1604026214056;
 Thu, 29 Oct 2020 19:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <20201029131649.182037-1-elver@google.com> <20201029131649.182037-7-elver@google.com>
In-Reply-To: <20201029131649.182037-7-elver@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 30 Oct 2020 03:49:47 +0100
Message-ID: <CAG48ez0N5iKCmg-JEwZ2oKw3zUA=5EdsL0CMi6biwLbtqFXqCA@mail.gmail.com>
Subject: Re: [PATCH v6 6/9] kfence, kasan: make KFENCE compatible with KASAN
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
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, joern@purestorage.com,
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

On Thu, Oct 29, 2020 at 2:17 PM Marco Elver <elver@google.com> wrote:
> We make KFENCE compatible with KASAN for testing KFENCE itself. In
> particular, KASAN helps to catch any potential corruptions to KFENCE
> state, or other corruptions that may be a result of freepointer
> corruptions in the main allocators.
>
> To indicate that the combination of the two is generally discouraged,
> CONFIG_EXPERT=y should be set. It also gives us the nice property that
> KFENCE will be build-tested by allyesconfig builds.
>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> Co-developed-by: Marco Elver <elver@google.com>
> Signed-off-by: Marco Elver <elver@google.com>
> Signed-off-by: Alexander Potapenko <glider@google.com>

Reviewed-by: Jann Horn <jannh@google.com>

with one nit:

[...]
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
[...]
> @@ -141,6 +142,14 @@ void kasan_unpoison_shadow(const void *address, size_t size)
>          */
>         address = reset_tag(address);
>
> +       /*
> +        * We may be called from SL*B internals, such as ksize(): with a size
> +        * not a multiple of machine-word size, avoid poisoning the invalid
> +        * portion of the word for KFENCE memory.
> +        */
> +       if (is_kfence_address(address))
> +               return;

It might be helpful if you could add a comment that explains that
kasan_poison_object_data() does not need a similar guard because
kasan_poison_object_data() is always paired with
kasan_unpoison_object_data() - that threw me off a bit at first.
