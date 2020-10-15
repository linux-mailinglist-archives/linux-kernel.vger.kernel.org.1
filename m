Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A90228F873
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 20:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgJOSZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 14:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgJOSZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 14:25:18 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED3FC061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 11:25:17 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id j18so2546209pfa.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 11:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/RIqn6irkqKDAEEWrlzQtXEDsj4m2zjqp4+RABIoG1Y=;
        b=q7Gy3AiIP8tpjKySqh2jkBTHCO4bBXRCAl2e9B9yP9ygmxLfu3woG5/3GWx4pczdez
         evqKQrknYNpvGxM3i0bRqZfAk8vxH1/sAOindvOXUvRPbBO+W387Q3w2ExfW6N4RoWCR
         ahSM78Q0k22aC9DFV3rF2rCRCr+BvC5h3k8thewJfGY/CBwuJd2OT8CeVIKptRHHjRmP
         o3i2xs4vCz/scFBi8keH3Q9GZWhSPAqwKFcG98CIzN4CnxEwy1pXRzeUel5QAkxgEbLT
         2ZbWFRVZBfacKfgtK0Z5S4Td2tD9lZIRHeiZYEa3hdNqR6/iUigESA/V/WGeCOmUKhN9
         td9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/RIqn6irkqKDAEEWrlzQtXEDsj4m2zjqp4+RABIoG1Y=;
        b=Cx4wSnjqwzeLFmpKKAEG5Ofl4C+lYDukdO/u3jNH27+sKK93L1kWEBdRNHuqpn7aXx
         o65IzPm7wXuRRA4ooTOMlk907VDREbUi7LmqC5njZw1NJ3b5pxDWxIeBDxzmGTgbeo3s
         8ZKIGEo8Vrdna5PoegIdRFRJ1/Leq1pknN7J5fOSXNUfisqtjI1eteTH7yhRNfN1p9Nr
         CcovwhgUjgMbNMhCBABiZk6MVVfSIAYdhzCuFBMhH09g+JIha5LrdALIooJzSHCkYASL
         hwft+lekewMQlF4vcNDetsOfn3fvsiBLACMeocpiVUf+6r2CY2K+29WAf/rsUEAGgVJl
         mZRw==
X-Gm-Message-State: AOAM532Wd2IN30gfNqBg43QvYBCxLcClwOl40aZJxLGO/IbKKkApP2Ck
        CxXzOSjK+32ee9mIdtiip0JRn0by0sTsTSzYp2xnGA==
X-Google-Smtp-Source: ABdhPJxWnPRbwt3E1pCAQwD7pYH7Gyelsc4G0il2Hvng24uQ9bgykSOe2apeWF/aOnMIhD2k0Dgc7tFjhDrF58/bZqc=
X-Received: by 2002:a65:6858:: with SMTP id q24mr143307pgt.10.1602786316973;
 Thu, 15 Oct 2020 11:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdkLvxeYeBh7Kx0gw7JPktPH8A4DomJTidUqA0jRQTR0FA@mail.gmail.com>
 <20201015181340.653004-1-nivedita@alum.mit.edu>
In-Reply-To: <20201015181340.653004-1-nivedita@alum.mit.edu>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 15 Oct 2020 11:25:05 -0700
Message-ID: <CAKwvOdk_Zvqb_h7Dksu=x2QvxhLpr0rvaMSdshKKTV7NBrv9HA@mail.gmail.com>
Subject: Re: [PATCH] compiler.h: Clarify comment about the need for barrier_data()
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        David Laight <David.Laight@aculab.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 11:13 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> Be clear about @ptr vs the variable that @ptr points to, and add some
> more details as to why the special barrier_data() macro is required.
>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

Thanks for this distinct cleanup.
Acked-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  include/linux/compiler.h | 33 ++++++++++++++++++++++-----------
>  1 file changed, 22 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 93035d7fee0d..d8cee7c8968d 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -86,17 +86,28 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>
>  #ifndef barrier_data
>  /*
> - * This version is i.e. to prevent dead stores elimination on @ptr
> - * where gcc and llvm may behave differently when otherwise using
> - * normal barrier(): while gcc behavior gets along with a normal
> - * barrier(), llvm needs an explicit input variable to be assumed
> - * clobbered. The issue is as follows: while the inline asm might
> - * access any memory it wants, the compiler could have fit all of
> - * @ptr into memory registers instead, and since @ptr never escaped
> - * from that, it proved that the inline asm wasn't touching any of
> - * it. This version works well with both compilers, i.e. we're telling
> - * the compiler that the inline asm absolutely may see the contents
> - * of @ptr. See also: https://llvm.org/bugs/show_bug.cgi?id=15495
> + * This version is to prevent dead stores elimination on @ptr where gcc and
> + * llvm may behave differently when otherwise using normal barrier(): while gcc
> + * behavior gets along with a normal barrier(), llvm needs an explicit input
> + * variable to be assumed clobbered.
> + *
> + * Its primary use is in implementing memzero_explicit(), which is used for
> + * clearing temporary data that may contain secrets.
> + *
> + * The issue is as follows: while the inline asm might access any memory it
> + * wants, the compiler could have fit all of the variable that @ptr points to
> + * into registers instead, and if @ptr never escaped from the function, it
> + * proved that the inline asm wasn't touching any of it. gcc only eliminates
> + * dead stores if the variable was actually allocated in registers, but llvm
> + * reasons that the variable _could_ have been in registers, so the inline asm
> + * can't reliably access it anyway, and eliminates dead stores even if the
> + * variable is actually in memory.
> + *
> + * This version works well with both compilers, i.e. we're telling the compiler
> + * that the inline asm absolutely may see the contents of the variable pointed
> + * to by @ptr.
> + *
> + * See also: https://llvm.org/bugs/show_bug.cgi?id=15495#c5
>   */
>  # define barrier_data(ptr) __asm__ __volatile__("": :"r"(ptr) :"memory")
>  #endif
> --
> 2.26.2
>


-- 
Thanks,
~Nick Desaulniers
