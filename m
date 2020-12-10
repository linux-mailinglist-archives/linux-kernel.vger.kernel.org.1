Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7462D6B90
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 00:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732873AbgLJXJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 18:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730455AbgLJXIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 18:08:48 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828E7C061794
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 15:08:06 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id c79so5625690pfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 15:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NP1eu7QDXdN/1YqCh4O4EOd9zppr5PbDxmIdIe+pjSA=;
        b=M/rjtOioeYVZzIK8FwCBKkHp+QeF8hYz1G+VlryRD4DXSoqGqzINxzNRERmZ2zKjkN
         G4XKbt6rByKu1z3AagYCYrpfhUZE9dFaTGczwhxQaydu5hEkpI8H6hRF6DNYIEK6KC8K
         V1YvnEiyAfMzzOb7qp41HUk1EUeOYSiLXGhD0QNdqEKsK/RvpHLm8djQit+4qgDyM9sF
         p0xa3z0WxKXbIsLg5rKpzYt1dCZg7ijMW49l4IyAEokVCJFEnw2JtaQytJWSy7AGS+mn
         oiYw4+idWG7OXPXfX6vSSWL2Bk87ztUHGPcH4ksCEPKeHzVGa9L1FZi7fBdokel4uf4T
         tp5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NP1eu7QDXdN/1YqCh4O4EOd9zppr5PbDxmIdIe+pjSA=;
        b=lWYkKCpttnvj37kW80fl9F9NXfoE5WZqO1VTF/tPuAf/T/elba4AVe3owYL5zPEM2O
         lerOu4D8lnw1MnE8ESo5reV6Sf8gBnNYgFA7hln9iNxsFvo1dEI3XeiTLBSJ+hGSJMct
         R1wWd0QxSy0x1ER1/ZXSiZ9UkSWwm3YxcyZUbvJy+G0n6LdKJiW/oo0yH/3PldPQd6ke
         zH4fCRiOU50F4G3TEJNbmsvb+/NqvdxoV9sjDr9m9BBsQgCQJSjB2Ud0/LG9CqSIBJgx
         FBVSyxoX8bx5qTiNsU8lF+4itXdN4Qb0z77woSGvW3+kirWDFTPfYkqIpkpEokceweRX
         ltNw==
X-Gm-Message-State: AOAM532imbvL34wf4LRcQEmG1eNgYI3U4nAWe6MOxIE5pImumKPnkd6Z
        3C+/Q9m/5B/Hq2zXxRLWAx0pNrNCQkpMeftuUOmp2A==
X-Google-Smtp-Source: ABdhPJyPpYuGxS3UNNVMvIrUoOvYY0B9PyWYyBcfUUS6dyzMKocWIdKN/OXVIdGaZmMGNTMRO95SG0kFYXggpwyYwDw=
X-Received: by 2002:a17:90b:1b05:: with SMTP id nu5mr9949695pjb.101.1607641685861;
 Thu, 10 Dec 2020 15:08:05 -0800 (PST)
MIME-Version: 1.0
References: <20201203221005.2813159-1-adelg@google.com>
In-Reply-To: <20201203221005.2813159-1-adelg@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 10 Dec 2020 15:07:53 -0800
Message-ID: <CAKwvOdk6=TgL+f2-WvE7tsK0rN1XQ+NdXmeJfDkLsa8xPmgipA@mail.gmail.com>
Subject: Re: [PATCH] selftests: propagate CC to selftest submakes
To:     Andrew Delgadillo <adelg@google.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 3, 2020 at 2:10 PM Andrew Delgadillo <adelg@google.com> wrote:
>
> lib.mk defaults to gcc when CC is not set. When building selftests
> as part of a kernel compilation, MAKEFLAGS is cleared to allow implicit
> build rules to be used. This has the side-effect of clearing the CC
> variable, which will cause selftests to be built with gcc regardless of
> if we are using gcc or clang. To remedy this, propagate the CC variable
> when clearing makeflags to ensure the correct compiler is used.
>
> Signed-off-by: Andrew Delgadillo <adelg@google.com>

Hi Andrew, thanks for the patch. Can you walk me through how to build
the selftests?

Documentation/dev-tools/kselftest.rst says:
$ make -C tools/testing/selftests

And if I do:
$ make CC=clang defconfig
$ make CC=clang -C tools/testing/selftests -j

I observe a spew of errors.  If I apply your patch and rerun the
above, I see what looks like the same spew of errors.  Am I "holding
it wrong" or could the docs use a refresh?

> ---
>  tools/testing/selftests/Makefile | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index d9c283503159..a4dd6d7e8276 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -90,10 +90,12 @@ FORCE_TARGETS ?=
>
>  # Clear LDFLAGS and MAKEFLAGS when implicit rules are missing.  This provides
>  # implicit rules to sub-test Makefiles which avoids build failures in test
> -# Makefile that don't have explicit build rules.
> +# Makefile that don't have explicit build rules. Since lib.mk defaults to
> +# using gcc for compilation when the CC variable is not set, we propagate the
> +# CC variable so if clang is being used, selftests will build with clang.
>  ifeq (,$(LINK.c))
>  override LDFLAGS =
> -override MAKEFLAGS =
> +override MAKEFLAGS = CC=$(CC)
>  endif
>
>  # Append kselftest to KBUILD_OUTPUT and O to avoid cluttering
> --
> 2.29.2.576.ga3fc446d84-goog
>


-- 
Thanks,
~Nick Desaulniers
