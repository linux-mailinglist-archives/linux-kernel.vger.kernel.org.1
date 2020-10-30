Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCCB29FBAC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 03:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgJ3Ctu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 22:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgJ3Ctt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 22:49:49 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6DEC0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:49:48 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id i6so6004678lfd.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iyTdtZ1FYlfsFiUutt0GVS7r1yGxXmwfsMwCFfiA6Mo=;
        b=SUW+4c/GNE2jYgqJQV5kCIdiJARuhagFhX6ggUAoYxWGbqSqx02k4o9Tbnm3CNpKFs
         FF3l0+3VB4TT6FMDYhi8KoTZnmVhyAbOsiYPc2Bzhqu3IkAa+nt2nmOuGJNcaOoeFFmH
         eImGHLnDZLkLEAwPK9vvuFXDgePNGK/8A91nKOP3jpox4HFLofcCdk+6+QhiVVmuN0nV
         MZ6YymaPmdL9ktRdNMeFZfQ9UpwoeXvweWZv24EzEw5oxsjbIJrrzW8NPseQLz2KIB0S
         kvTPc+Ur9VsGUKlMApEFPWvIkmBYzIGWhA62E8vNbVv/qjnouitKYK9OQtDpL3SCfgQc
         wFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iyTdtZ1FYlfsFiUutt0GVS7r1yGxXmwfsMwCFfiA6Mo=;
        b=srbJ7dCNs274KtMwOo8iWJYLWEKzcrI75Q8Y19AE2fW9eOrvmlzrRqfIv0GBEnKGK9
         b+g6tJouiCIUA9KIVh8X+MYDgB+p/AyUoZXsh/bElypmMGlumjUquX7CpZVnjP/i48Pk
         zgZrE7reGHvIKFw60itY4RI7SNdklVZnUgfgFJE8QLGA05jKwBDFYK1hLUclaK4GqBhh
         s1mklz2H/x5X1n+WOkh2Y+5iz023jJIgMHJ5HtXuiuuAdH0A+50UqT3EhtA/7tOZ9J4u
         +viRrN04ozkHm2banHgpHrVUQMYgNfbPdhqRkoOAXAdvHXnj101U6miTXmTY8gkokrxb
         weKg==
X-Gm-Message-State: AOAM531MtOaSSUr1KYjYGwcu++Xk/h7Xyzvv1A6NunwJMxhxp/W2vflN
        qhdXJLyl1+SB0i1Dc5mVje6OZFWOYu7leZGDe/U2Pw==
X-Google-Smtp-Source: ABdhPJz0jmO93efSvKGBuuwFlhC4NS3zSciN4aPqYzgeBthjdtsZqkNkjTWffgFn28Gq3ZSltgk0QyJUydfGIqk06xw=
X-Received: by 2002:a19:ef07:: with SMTP id n7mr22380lfh.482.1604026186911;
 Thu, 29 Oct 2020 19:49:46 -0700 (PDT)
MIME-Version: 1.0
References: <20201029131649.182037-1-elver@google.com> <20201029131649.182037-3-elver@google.com>
In-Reply-To: <20201029131649.182037-3-elver@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 30 Oct 2020 03:49:19 +0100
Message-ID: <CAG48ez1n7FrRA8Djq5685KcUJp1YgW0qijtBYNm2c9ZqQ1M4rw@mail.gmail.com>
Subject: Re: [PATCH v6 2/9] x86, kfence: enable KFENCE for x86
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
> KFENCE for the x86 architecture. In particular, this implements the
> required interface in <asm/kfence.h> for setting up the pool and
> providing helper functions for protecting and unprotecting pages.
>
> For x86, we need to ensure that the pool uses 4K pages, which is done
> using the set_memory_4k() helper function.
>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> Co-developed-by: Marco Elver <elver@google.com>
> Signed-off-by: Marco Elver <elver@google.com>
> Signed-off-by: Alexander Potapenko <glider@google.com>
[...]
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
[...]
> @@ -725,6 +726,9 @@ no_context(struct pt_regs *regs, unsigned long error_code,
>         if (IS_ENABLED(CONFIG_EFI))
>                 efi_recover_from_page_fault(address);
>
> +       if (kfence_handle_page_fault(address))
> +               return;

We can also get to this point due to an attempt to execute a data
page. That's very unlikely (given that the same thing would also crash
if you tried to do it with normal heap memory, and KFENCE allocations
are extremely rare); but we might want to try to avoid handling such
faults as KFENCE faults, since KFENCE will assume that it has resolved
the fault and retry execution of the faulting instruction. Once kernel
protection keys are introduced, those might cause the same kind of
trouble.

So we might want to gate this on a check like "if ((error_code &
X86_PF_PROT) == 0)" (meaning "only handle the fault if the fault was
caused by no page being present", see enum x86_pf_error_code).


Unrelated sidenote: Since we're hooking after exception fixup
handling, the debug-only KFENCE_STRESS_TEST_FAULTS can probably still
cause some behavioral differences through spurious faults in places
like copy_user_enhanced_fast_string (where the exception table entries
are used even if the *kernel* pointer, not the user pointer, causes a
fault). But since KFENCE_STRESS_TEST_FAULTS is exclusively for KFENCE
development, the difference might not matter. And ordering them the
other way around definitely isn't possible, because the kernel relies
on being able to fixup OOB reads. So there probably isn't really
anything we can do better here; it's just something to keep in mind.
Maybe you can add a little warning to the help text for that Kconfig
entry that warns people about this?



> +
>  oops:
>         /*
>          * Oops. The kernel tried to access some bad page. We'll have to
> --
> 2.29.1.341.ge80a0c044ae-goog
>
