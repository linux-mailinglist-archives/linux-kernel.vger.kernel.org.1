Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAAB2B138B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 01:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgKMAx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 19:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbgKMAx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 19:53:26 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B77EC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 16:53:26 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id 10so6158181pfp.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 16:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kpvnKSrVoabXQhGOD0rhoXlbZEbSnpbz56+dy5+JM3c=;
        b=CCoUOKAEuP3dgQeDYy5FUfj2zEbtK8AtB9vlZlMHZ3QyqTAvhQOLQ6DTjHAbwciNKm
         b8KAhm0DIozDlTZ1ph4G9pklcyTMZOIDQBlz+cUogtjeetIlz5UoNRJiTEHqrmS+uDVh
         Cv5PjEmZmR4PjA/vyFg4r2zYvt9lJqDBD2GhuunxqgIGS/ZyzQkEYlZUZAZ6ihH2zVS8
         1BBn0/VKet6kSgLWrPYwfaRTa1hlr5LsDiI5es005tOYGmPE7jrBhrY4Ge5R/5FFzV8F
         4SNy6Xlv7Qdhg6qtQCDvdR7zhcSe12BiW4X+7sPYF/LqEem4bCoEROdRYJyP5Y1BAHc7
         tRHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kpvnKSrVoabXQhGOD0rhoXlbZEbSnpbz56+dy5+JM3c=;
        b=pC/PPBe+lkljSsA2bOZmsR5ory/HrYPLM6B/iVNtYGQCujdhC/G79Qtdr9QEGWEsZT
         Dcdz0GyLNZdnnflYxm/kLkw/1t7zS0QMPYunuLMPTEU8kuCbdLTFRVumysvgfQVodyBV
         IleoceqUpGlWPVNuyTfPN00BKEdUehq+jxtoU9Qbop58bhfmU/Tok9JcsJTu36hGG07L
         Ijy/KmGbA451yYnEs30x0Rsy50kDmN2vgX8Y8vWOmHnHiUwSRrOUIlxHDNxpuDylvpOp
         +PAUZ/8VmGxRt/hSXEsKfembGLtT7V5JuuOwi1YOaT8cE1m96Egazl1L9XvzA4T+f7V2
         LstA==
X-Gm-Message-State: AOAM532DitQwULr0Pt5EX5rf9Nd7sTcmE1aQoFpoM9f+g3n6G0TqP7TS
        88HdIxhtp04R2Zox3suVa24UgN7JR0tvuvs9PukI/Q==
X-Google-Smtp-Source: ABdhPJxTBlrZxQlw0dn4qABCTcVsaWoJtRrne8IIUHKppzrewlebxbyEvHPJcP8m5PzSvUKZ8s8PbXlR3tasMKpvzvQ=
X-Received: by 2002:a17:90b:110b:: with SMTP id gi11mr491437pjb.25.1605228805456;
 Thu, 12 Nov 2020 16:53:25 -0800 (PST)
MIME-Version: 1.0
References: <20201108203737.94270-1-natechancellor@gmail.com>
In-Reply-To: <20201108203737.94270-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 12 Nov 2020 16:53:14 -0800
Message-ID: <CAKwvOd=P2yFxkAXh9TUpJ=D5=jNnxnx7O5Nr3iTDeqV40UA19A@mail.gmail.com>
Subject: Re: [PATCH] riscv: Explicitly specify the build id style in vDSO
 Makefile again
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        linux-riscv@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Bill Wendling <morbo@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 8, 2020 at 12:37 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Commit a96843372331 ("kbuild: explicitly specify the build id style")
> explicitly set the build ID style to SHA1. Commit c2c81bb2f691 ("RISC-V:
> Fix the VDSO symbol generaton for binutils-2.35+") undid this change,
> likely unintentionally.
>
> Restore it so that the build ID style stays consistent across the tree
> regardless of linker.
>
> Fixes: c2c81bb2f691 ("RISC-V: Fix the VDSO symbol generaton for binutils-2.35+")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Thanks for the fixup!

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

(I'm curious what --build-id linker flag does, and what kind of spooky
bugs that led to a96843372331?)

> ---
>  arch/riscv/kernel/vdso/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
> index cb8f9e4cfcbf..0cfd6da784f8 100644
> --- a/arch/riscv/kernel/vdso/Makefile
> +++ b/arch/riscv/kernel/vdso/Makefile
> @@ -44,7 +44,7 @@ SYSCFLAGS_vdso.so.dbg = $(c_flags)
>  $(obj)/vdso.so.dbg: $(src)/vdso.lds $(obj-vdso) FORCE
>         $(call if_changed,vdsold)
>  SYSCFLAGS_vdso.so.dbg = -shared -s -Wl,-soname=linux-vdso.so.1 \
> -       -Wl,--build-id -Wl,--hash-style=both
> +       -Wl,--build-id=sha1 -Wl,--hash-style=both
>
>  # We also create a special relocatable object that should mirror the symbol
>  # table and layout of the linked DSO. With ld --just-symbols we can then
>
> base-commit: c2c81bb2f69138f902e1a58d3bef6ad97fb8a92c
> --
> 2.29.2
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20201108203737.94270-1-natechancellor%40gmail.com.



-- 
Thanks,
~Nick Desaulniers
