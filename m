Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C952F3D46
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393281AbhALVfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 16:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437133AbhALVQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 16:16:41 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4119C061786
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 13:15:54 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2so2166563pfq.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 13:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XpRF98H6QxDvYHR2YECMLpFGbIbXZ63ebl8zScm/1pg=;
        b=s9ReiTEzcZGXMZbagV8knRZSxCcfNVCjwtbeMAoWw0oEcRx0WpKzSWgGwGluIx57DX
         Eg2kT+voymHTzoqSMUkg0WjqjdoWzBCeO+5LjqJon1nIoGnaJD8sLXQymj8U6tXI3yRT
         BTqoIe3shIxBg5NTcW6AYlqdJaRy61qvC1jA1WgkniemFkU6kHqmu43WscGQFB+91xws
         v6xe9x1eRl/ypiiJfncTKke2kN+qQPFEFANaPElaaNgmbUO4wK6Jn2nNTzmyrvM2zFmM
         0jQkBZ1VXkc0FPR9buNshD8x3j95Cxoq0aB1qCNIMyj/aX6ohjMC0WtykCM91Rolulr9
         Lu5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XpRF98H6QxDvYHR2YECMLpFGbIbXZ63ebl8zScm/1pg=;
        b=JmiYj6plQEV4P3pJr067A4aM0LCxWUXzx6Fmvh2x4iZ5ddHW5L3Uy7KqXN6YTNqjAV
         +ompKdGGdV3NYCgkqOBPCQV4e5D6IUwG2rIqe9CXZlfjqvmuHbtFBHaAO5hO2Aa/qvKJ
         bJdXzBsui6z+qAKPl7GKASX1eLwT/xZ/pFaaQjY2MW+Dfcwurvh6eMEKYYz2dLRond9W
         4iHP+7+GAmbz3u9OmzNO5eYBt7MVDd7siCe8meM1RbvGuCBd2EiTCHjc7C8YgzOQ5+XF
         C2HAl6bsjWrxBEq3KEiv9pubNdxVYXlHF2lfQg7VMZ6LB64QVHPtRK+wJyKCNE7HB+g0
         6mIw==
X-Gm-Message-State: AOAM531QqZj/5hqx8Lfyss6r7j2VIIBt7AEBdk6+oWuEL5Gfzp/znvx/
        Aww0OCaY0Qb/v1LfXCribsSHdcfuc9NdIoKFaR2lsQ==
X-Google-Smtp-Source: ABdhPJyoKIjWQHjeNIzJ/sPzrWr2Hsy1ImwWE37J/ufhMQ1HeRGDjJYBRxjMLpEeLeQQ/qX6FAYsAj4DRBYxeyIB5Xs=
X-Received: by 2002:a63:1f47:: with SMTP id q7mr1015387pgm.10.1610486154136;
 Tue, 12 Jan 2021 13:15:54 -0800 (PST)
MIME-Version: 1.0
References: <20210112205542.1375847-1-natechancellor@gmail.com>
In-Reply-To: <20210112205542.1375847-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 12 Jan 2021 13:15:42 -0800
Message-ID: <CAKwvOd=yrVKBn9TN2cP8SiB7A8=c2g41PyodKGJu+xEQwAmnDA@mail.gmail.com>
Subject: Re: [PATCH] ubsan: Implement __ubsan_handle_alignment_assumption
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 12:55 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> When building ARCH=mips 32r2el_defconfig with CONFIG_UBSAN_ALIGNMENT:
>
> ld.lld: error: undefined symbol: __ubsan_handle_alignment_assumption
> >>> referenced by slab.h:557 (include/linux/slab.h:557)
> >>>               main.o:(do_initcalls) in archive init/built-in.a
> >>> referenced by slab.h:448 (include/linux/slab.h:448)
> >>>               do_mounts_rd.o:(rd_load_image) in archive init/built-in.a
> >>> referenced by slab.h:448 (include/linux/slab.h:448)
> >>>               do_mounts_rd.o:(identify_ramdisk_image) in archive init/built-in.a
> >>> referenced 1579 more times
>
> Implement this for the kernel based on LLVM's
> handleAlignmentAssumptionImpl because the kernel is not linked against
> the compiler runtime.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1245
> Link: https://github.com/llvm/llvm-project/blob/llvmorg-11.0.1/compiler-rt/lib/ubsan/ubsan_handlers.cpp#L151-L190
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  lib/ubsan.c | 28 ++++++++++++++++++++++++++++
>  lib/ubsan.h |  6 ++++++
>  2 files changed, 34 insertions(+)
>
> diff --git a/lib/ubsan.c b/lib/ubsan.c
> index 3e3352f3d0da..a1e6cc9993f8 100644
> --- a/lib/ubsan.c
> +++ b/lib/ubsan.c
> @@ -427,3 +427,31 @@ void __ubsan_handle_load_invalid_value(void *_data, void *val)
>         ubsan_epilogue();
>  }
>  EXPORT_SYMBOL(__ubsan_handle_load_invalid_value);
> +
> +void __ubsan_handle_alignment_assumption(void *_data, unsigned long ptr,
> +                                        unsigned long align,
> +                                        unsigned long offset)
> +{
> +       struct alignment_assumption_data *data = _data;
> +       unsigned long real_ptr;
> +
> +       if (suppress_report(&data->location))
> +               return;
> +
> +       ubsan_prologue(&data->location, "alignment-assumption");
> +
> +       if (offset)
> +               pr_err("assumption of %lu byte alignment (with offset of %lu byte) for pointer of type %s failed",
> +                      align, offset, data->type->type_name);
> +       else
> +               pr_err("assumption of %lu byte alignment for pointer of type %s failed",
> +                      align, data->type->type_name);
> +
> +       real_ptr = ptr - offset;
> +       pr_err("%saddress is %lu aligned, misalignment offset is %lu bytes",
> +              offset ? "offset " : "", BIT(ffs(real_ptr)),

if real_ptr is an unsigned long, do we want to use `__ffs(real_ptr) +
1` here rather than ffs which takes an int?  It seems the kernel is
missing a definition of ffsl. :(

Otherwise code LGTM.

> +              real_ptr & (align - 1));
> +
> +       ubsan_epilogue();
> +}
> +EXPORT_SYMBOL(__ubsan_handle_alignment_assumption);
> diff --git a/lib/ubsan.h b/lib/ubsan.h
> index 7b56c09473a9..9a0b71c5ff9f 100644
> --- a/lib/ubsan.h
> +++ b/lib/ubsan.h
> @@ -78,6 +78,12 @@ struct invalid_value_data {
>         struct type_descriptor *type;
>  };
>
> +struct alignment_assumption_data {
> +       struct source_location location;
> +       struct source_location assumption_location;
> +       struct type_descriptor *type;
> +};
> +
>  #if defined(CONFIG_ARCH_SUPPORTS_INT128)
>  typedef __int128 s_max;
>  typedef unsigned __int128 u_max;
>
> base-commit: 7c53f6b671f4aba70ff15e1b05148b10d58c2837
> --
> 2.30.0
>


-- 
Thanks,
~Nick Desaulniers
