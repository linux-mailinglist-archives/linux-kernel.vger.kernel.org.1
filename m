Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 888AD26AF89
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 23:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgIOV1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 17:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbgIOVYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 17:24:48 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655B2C061788
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:24:48 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x18so2018722pll.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PTgQ830HVBAbzepwTNVzvx5MvkLEAXf3QpQye9kHzO4=;
        b=Wrcnf0Rrw3c56F+yHM+X2OoEK/YWkl21IDWOT9PLCZg/RFZPpkA0b00urdKqEOMnaS
         FG4tUETlrtiVeGKeV1S09hJj0/uA/JNa3vAH+XLsrcWp2jjy1gVQe64K+VrdIrnd4Yp6
         WssdM2rnUQh3SeGZcn9uNVxRbfp+lB9YihGxyjmCMSbuEL2Mhlm4rWbmJZ+lZG6cid82
         P4eeRoTqtakkmTt2gtZbxJpIkmb7Vv+1rT7Bidk00BZ6YIy5sLakcxQcnocLzIkp8Co1
         KScLUc1W+w6RQiScaftIRI+3oWNRP/XedJIOM/nRxP9bNntvKoU5Vzoc7TXwZXkmw8Wa
         H2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PTgQ830HVBAbzepwTNVzvx5MvkLEAXf3QpQye9kHzO4=;
        b=lOR51fXT5VqqH72+mT35OHHDh/qcyMgApBwU1ZiGk6uvaW5urBpfKBAJmfhUHAVZwy
         EVgwDIuT/JjlkcVJCHvnCyM6RZOc2ehAhoohW9yqkUpRzQypEr2vaEL5qIWWbY5gLu8X
         B39Q4SsvPmKP5YUhAXvmTy7T5wPK+jeapoVtAt958u7r4JOL4A5ALHyovvQh2X1jHqb+
         sAY8qnER9nMi8GsB4yoWBtfFh5y6Be/8CQlznDkkyxLsWDqGZ3MbUMEOQ8VrJ5M3FS0Q
         s/T29aqxQa6cPkyRRmAH7WRgWW59a/VToB5NHTciBNQfnAUaaEBMgjsP8+TN1fXxRMHf
         DG6A==
X-Gm-Message-State: AOAM530pLk5YApnScyWHlZUZRwLazdQE87Onj7UDVvesfm1gs5XG+rr3
        mIGGasNPeW8XC3WVSrkREwZTHke15gV4pa73wcKIWg==
X-Google-Smtp-Source: ABdhPJxca9XtVQPYh5S/ZgR99g3XptMvihVyB92KqZN1nR05d3aUsx/I2xeo0ssMTeMuqOC1hHsLxO0bCx167JNiu+A=
X-Received: by 2002:a17:902:7295:b029:d1:e3bd:48cc with SMTP id
 d21-20020a1709027295b02900d1e3bd48ccmr4931075pll.10.1600205087532; Tue, 15
 Sep 2020 14:24:47 -0700 (PDT)
MIME-Version: 1.0
References: <9f513eef618b6e72a088cc8b2787496f190d1c2d.1600203307.git.luto@kernel.org>
In-Reply-To: <9f513eef618b6e72a088cc8b2787496f190d1c2d.1600203307.git.luto@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 15 Sep 2020 14:24:35 -0700
Message-ID: <CAKwvOdnjHbyamsW71FJ=Cd36YfVppp55ftcE_eSDO_z+KE9zeQ@mail.gmail.com>
Subject: Re: [PATCH] x86/smap: Fix the smap_save() asm
To:     Andy Lutomirski <luto@kernel.org>, Bill Wendling <morbo@google.com>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Thelen <gthelen@google.com>,
        John Sperbeck <jsperbeck@google.com>,
        "# 3.4.x" <stable@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 1:56 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> The old smap_save() code was:
>
>   pushf
>   pop %0
>
> with %0 defined by an "=rm" constraint.  This is fine if the
> compiler picked the register option, but it was incorrect with an
> %rsp-relative memory operand.

It is incorrect because ... (I think mentioning the point about the
red zone would be good, unless there were additional concerns?)

The patch should be fine, so

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

regardless of whether or not you choose to amend the commit message.
I suspect that the use of "r" exclusively without "m" could lead to
register exhaustion (though it's more likely the compiler will spill
some other variable to stack), which is why it's common to use it in
conjunction with "m."  As Bill's patch notes, getting the "m" version
is poor for performance of this pattern, or at least for
native_{save|restore}_fl.  Being able to use the compiler builtins is
another possibility here.

> With some intentional abuse, I can
> get both gcc and clang to generate code along these lines:
>
>   pushfq
>   popq 0x8(%rsp)
>   mov 0x8(%rsp),%rax
>
> which is incorrect and will not work as intended.
>
> Fix it by removing the memory option.  This issue is exacerbated by
> a clang optimization bug:
>
>   https://bugs.llvm.org/show_bug.cgi?id=47530

This is something we should fix.  Bill, James, and I are discussing
this internally.  Thank you for filing a bug; I owe you a beer just
for that.

>
> Fixes: e74deb11931f ("x86/uaccess: Introduce user_access_{save,restore}()")
> Cc: stable@vger.kernel.org
> Reported-by: Bill Wendling <morbo@google.com> # I think

LOL, yes, the comment can be dropped...though I guess someone else may
have reported the problem to Bill?

> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>  arch/x86/include/asm/smap.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/smap.h b/arch/x86/include/asm/smap.h
> index 8b58d6975d5d..be6d675ae3ac 100644
> --- a/arch/x86/include/asm/smap.h
> +++ b/arch/x86/include/asm/smap.h
> @@ -61,7 +61,7 @@ static __always_inline unsigned long smap_save(void)
>                       ALTERNATIVE("jmp 1f", "", X86_FEATURE_SMAP)
>                       "pushf; pop %0; " __ASM_CLAC "\n\t"
>                       "1:"
> -                     : "=rm" (flags) : : "memory", "cc");
> +                     : "=r" (flags) : : "memory", "cc");
>
>         return flags;
>  }
> --
> 2.26.2
>


-- 
Thanks,
~Nick Desaulniers
