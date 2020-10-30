Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E7629FBAE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 03:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgJ3Ct4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 22:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgJ3Ctz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 22:49:55 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED4BC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:49:54 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id t13so5293703ljk.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U5VSV5EOvuuPrA9xNEsowWeAohxv+a7+9KVx3Owvda8=;
        b=hvIenZ/1jqtu8F4Mb0B2dqX3Djjzd9dPzPPm8fbk2Mwd/NiwUcIzSfqkEPHxiORqR4
         +aIvclP1ZbKKnv1jUCg3tzYc1GiM+hF5IUs+OyqfQTZGlXr41lEV7y2wJ1kdGO2BiXSB
         CKLDb8KGnWVabTZglW8tiyCFheuiAIuURPJ3/ELAuGlWcjQkQcVSyidXoFP60SqKgX3z
         tH+yqOICZSjxMeDIYwrUjgqaMnrV0SnB8jWmiQrNeNpYXJtm9WinMf3SuKfo3NvBCNlv
         9Mnu1Jv1KkGDPn/5sd9AUaPRKa0PB7F2Oy/sF9S4C1kUCxmLNOD4HhVn5Xig2k+O/kSY
         LxOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U5VSV5EOvuuPrA9xNEsowWeAohxv+a7+9KVx3Owvda8=;
        b=DLPhEV/fU3D/MJeExb4mnTV6M4qWuI/G9kFI0IuY/vxxB0RZas79p+yDEXKAbumoSO
         L0PEZhoJJ+QHhiVv1sNU2qDU2Q2NLvnehnDJnxcx5xzVQXjH+uIjfbT90Rix4lPRVxVx
         chQDIwtIs5Wha8ujlnC/pyfjrSpdxuxX9mr92Zu/Wem33bYrUySTZgkInA9ByOG/kI/b
         VBfKt+0LrUxyLijUlSz3G675u/H1JPX/u24OlS0yGIhkzPcchf5X9Jnvmrb+VV2dzR4Q
         ukl+PaPOKg7gJHNKx02JWVPHna+dm4v3qDXMMA7l5WtYBrAM0NEoDx6e6OCSfDSzXj6W
         b6zg==
X-Gm-Message-State: AOAM530CnlP1SOrL6qBA0bJnJNGpGP5aPx+Ts8YRqJfrAa6n0MZztN0J
        nY8Hb6DV3cZtFQSd3pQVl+tPLTBI2clJ6r2ZoXTeCg==
X-Google-Smtp-Source: ABdhPJy5BCp9b2onPlMEzZvXxzY2+7KT6JF4Piv/BGIOWQ/jH5h8osPXMpnQh5s0vTKqhfe/Bc0g9m3Dzk03z8KGets=
X-Received: by 2002:a2e:8816:: with SMTP id x22mr82450ljh.377.1604026192956;
 Thu, 29 Oct 2020 19:49:52 -0700 (PDT)
MIME-Version: 1.0
References: <20201029131649.182037-1-elver@google.com> <20201029131649.182037-4-elver@google.com>
In-Reply-To: <20201029131649.182037-4-elver@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 30 Oct 2020 03:49:26 +0100
Message-ID: <CAG48ez11T4gXHkhgnM7eWc1EJQ5u7NQup4ADy75c1uUVPeWGSg@mail.gmail.com>
Subject: Re: [PATCH v6 3/9] arm64, kfence: enable KFENCE for ARM64
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
> Add architecture specific implementation details for KFENCE and enable
> KFENCE for the arm64 architecture. In particular, this implements the
> required interface in <asm/kfence.h>.
>
> KFENCE requires that attributes for pages from its memory pool can
> individually be set. Therefore, force the entire linear map to be mapped
> at page granularity. Doing so may result in extra memory allocated for
> page tables in case rodata=full is not set; however, currently
> CONFIG_RODATA_FULL_DEFAULT_ENABLED=y is the default, and the common case
> is therefore not affected by this change.
[...]
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
[...]
> +       select HAVE_ARCH_KFENCE if (!ARM64_16K_PAGES && !ARM64_64K_PAGES)

"if ARM64_4K_PAGES"?

[...]
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
[...]
> @@ -312,6 +313,9 @@ static void __do_kernel_fault(unsigned long addr, unsigned int esr,
>             "Ignoring spurious kernel translation fault at virtual address %016lx\n", addr))
>                 return;
>
> +       if (kfence_handle_page_fault(addr))
> +               return;

As in the X86 case, we may want to ensure that this doesn't run for
permission faults, only for non-present pages. Maybe move this down
into the third branch of the "if" block below (neither permission
fault nor NULL deref)?



> +
>         if (is_el1_permission_fault(addr, esr, regs)) {
>                 if (esr & ESR_ELx_WNR)
>                         msg = "write to read-only memory";
