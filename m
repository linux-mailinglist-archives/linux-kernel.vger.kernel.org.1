Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D712F55BB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 02:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbhANBKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 20:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbhANBCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 20:02:12 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6330C061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 17:01:02 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id c12so2345366pfo.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 17:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rkU8cpUyETgfO5WMc4v+Gsp/I2v/7OeHSZUBCHGZTM4=;
        b=pYYLVmtrRKrw0Sz7zJwkFgpLuueGkdjJdPR49gFLawu1W/LuiS1re03rIKdAt3gayl
         W3z4dFiuWO5X+N7IbvaH06K7QQL5myAWXO32/Br9JnJUvHm2ULUxwOoykOfqUE6bDwaL
         TYuIzJaiaofHvYrQCZDBDEolMqhVmECoMfnepJbXCY8Y8i6GTyXT4FpL2v8Lh4W/QfDv
         27AHqPbaWhf1ucgrY6/9nkFXReBrW7HOeuty7SeByk7OU7+G0/eQJ3i7xY18v+pVWqHO
         MpmCF4y7W+waEQ+KliMRAvAbGPqf48VOXTvvOdVrH2+i9RAtWcXimnA38ZESXUZUQQFI
         3Pww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rkU8cpUyETgfO5WMc4v+Gsp/I2v/7OeHSZUBCHGZTM4=;
        b=igBuaNaRDy8Vin5QTfxndc/6JrcaNd/cGYrBkTzPUBaR1OO8GNQ2JydGUULbUYofl1
         Tyeg1kKKvMowvoOIhxfT8pNfuBsK4JH09b8XS6D6XOHDhoDXxKz2QHOCme5+rnUOd3DB
         7CRT3lWPHEhJgPtezS0ZmCQvi7li2YI5UxUWMfwmVlQwzhS7UzrElCJ/pl8KoCWfQVsO
         wItSwqBBkT/Hlqbqw0PIDNmMuJpTOECpv1FwaMOUuDZ1fKuxEOEDpLQZi6i0OwvQnlIi
         5qx995Yd2JLg8vIE866RkRfCZ6ljKo1vPXrgO9h7W90CdXgl+gwEhK0+m36qg6+ms3gu
         53Mw==
X-Gm-Message-State: AOAM532cfe+pl+j1xqbDa4Rls/C3Eim/zAiLqXnSr9TFpPGZ1u/eGn+X
        D2rqLGfYFVKANnVcvAfu/97BfCRuraMRs/qqMhvaO1vZzYk=
X-Google-Smtp-Source: ABdhPJwdJ/r0Qv64J2ze8GYRu72lvzIpVi0UlL7kvL27k4LYfT/evnLPC8ifiN57FYuWnq1MBXyLShKKt1Yh7jnqccI=
X-Received: by 2002:a63:1142:: with SMTP id 2mr4735755pgr.263.1610586062110;
 Wed, 13 Jan 2021 17:01:02 -0800 (PST)
MIME-Version: 1.0
References: <20210114004059.2129921-1-natechancellor@gmail.com>
In-Reply-To: <20210114004059.2129921-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 13 Jan 2021 17:00:50 -0800
Message-ID: <CAKwvOdnda=eMds-krhHAwtvvOXhdezVWcfp_MQrtbfmO=UPzzg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add a couple more files to the Clang/LLVM section
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 4:41 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> The K: entry should ensure that Nick and I always get CC'd on patches
> that touch these files but it is better to be explicit rather than
> implicit.
>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cc1e6a5ee6e6..9127456b7eb1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4313,7 +4313,9 @@ W:        https://clangbuiltlinux.github.io/
>  B:     https://github.com/ClangBuiltLinux/linux/issues
>  C:     irc://chat.freenode.net/clangbuiltlinux
>  F:     Documentation/kbuild/llvm.rst
> +F:     include/linux/compiler-clang.h
>  F:     scripts/clang-tools/
> +F:     scripts/clang-version.sh
>  F:     scripts/lld-version.sh
>  K:     \b(?i:clang|llvm)\b
>
>
> base-commit: 7c53f6b671f4aba70ff15e1b05148b10d58c2837
> --
> 2.30.0
>


-- 
Thanks,
~Nick Desaulniers
