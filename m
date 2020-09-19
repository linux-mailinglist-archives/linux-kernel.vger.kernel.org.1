Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B4B270D62
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 13:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgISLC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 07:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbgISLC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 07:02:57 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF59FC0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 04:02:56 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id y5so7881912otg.5
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 04:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=3h23YiWPGuupu0L7W8TUBUUA4TL4R9nY/LN+gBcZbe0=;
        b=MCIFkzn4MVwkC7lK5JqvB6LsRuewsFdYEI6G0E1fQzQaPoKo7gq6xsQQNnGPGn2qT8
         hc8Yalvft5Re54XCvvPxM8qQYjotlLv75V1z6B7ssjHhDCtEI5maKPnwgS+Hcwt0QV82
         mo1nWmVYz62vZDI1ZbYQQ/Y3SU9lvNN5f24bB5CeSeoQW8QjdWFcBvm6tpwjp3NuJ+Ai
         m6PBRzqlFbh08mbRH0vusIbOC8LjknoYLaxpqg4R1sX9T/FRQVtVcX5iUEl/Sv7ArH82
         GVrj3oX/ZjNf5zeYkx8nMkvkbPicRXCJrkicsNPhsuecvJor84peXyD9Qkf8fFduoG7v
         e6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=3h23YiWPGuupu0L7W8TUBUUA4TL4R9nY/LN+gBcZbe0=;
        b=LwpqqctJvU/Cm2TMSRP1JqnK+f/MO7jSDYmvUPvnXtIyqShAvu6rKM0EBRURwPN+BY
         rhzCk7IltQcoCL8XwNEU3/d5um/ebtZOgugfXowrjPuU0OS2Opsbq0vZBvrGYMRc+ex4
         pt1/EjsAzZeQd87qzf/NZKcrkWFHkcQ9qiau5Azo6Nh5dCMCDmIdfljnjjL/3lEy7zMl
         pmwEQrLbcwO3/ob8VLHywy0JdHojQ+lCtFGYDq2yH4FrU/2TJcy0R0upTV8fVrj3BG0/
         5/2uNqYKF8nd47lL/zfMkJyNAXhIb5UJ2qDSdRz2NWZUiQ+4zmhWLv7i7LdOdLB0Ol02
         T3kA==
X-Gm-Message-State: AOAM532fOa3RJzhbn2wF4k00+AqshbiQzUKXlKmcENa7h7jZydV4IER6
        6EN2Qc7F4LzrS4o2HhcSxSj5kgMKDaqzBCDqsw4=
X-Google-Smtp-Source: ABdhPJxyOuu0xX9TgXMOqSH6xcMgfyjXbb4l8EYCqDKojvQicLcY/h8v7sJGaO0UmTy+E3s1bwr8yMTRu+x/Rv8mN3E=
X-Received: by 2002:a05:6830:110b:: with SMTP id w11mr24254895otq.109.1600513376087;
 Sat, 19 Sep 2020 04:02:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200918154840.h3xbspb5jq7zw755@treble> <20200919064118.1899325-1-ilie.halip@gmail.com>
In-Reply-To: <20200919064118.1899325-1-ilie.halip@gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 19 Sep 2020 13:02:44 +0200
Message-ID: <CA+icZUVxsXXocAkiLM_Avv3vmFn=Gzm6B3s6aRrE+ycQB2Bxng@mail.gmail.com>
Subject: Re: [PATCH v2] objtool: ignore unreachable trap after call to
 noreturn functions
To:     Ilie Halip <ilie.halip@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rong Chen <rong.a.chen@intel.com>,
        Marco Elver <elver@google.com>,
        Philip Li <philip.li@intel.com>,
        Borislav Petkov <bp@alien8.de>, kasan-dev@googlegroups.com,
        x86@kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        kbuild test robot <lkp@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 19, 2020 at 8:41 AM Ilie Halip <ilie.halip@gmail.com> wrote:
>
> With CONFIG_UBSAN_TRAP enabled, the compiler may insert a trap instruction
> after a call to a noreturn function. In this case, objtool warns that the
> ud2 instruction is unreachable.
>
> This is a behavior seen with clang, from the oldest version capable of
> building the mainline x64_64 kernel (9.0), to the latest experimental
> version (12.0).
>
> objtool silences similar warnings (trap after dead end instructions), so
> so expand that check to include dead end functions.
>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Rong Chen <rong.a.chen@intel.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Philip Li <philip.li@intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: kasan-dev@googlegroups.com
> Cc: x86@kernel.org
> Cc: clang-built-linux@googlegroups.com
> BugLink: https://github.com/ClangBuiltLinux/linux/issues/1148
> Link: https://lore.kernel.org/lkml/CAKwvOdmptEpi8fiOyWUo=AiZJiX+Z+VHJOM2buLPrWsMTwLnyw@mail.gmail.com
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Ilie Halip <ilie.halip@gmail.com>
> ---

Tested-by: Sedat Dilek <sedat.dilek@gmail.com>

- Sedat -

>
> Changed in v2:
>  - added a mention that this is a clang issue across all versions
>  - added Nick's Reviewed-by, Tested-by
>  - added Reported-by
>
>  tools/objtool/check.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index e034a8f24f46..eddf8bf16b05 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -2612,9 +2612,10 @@ static bool is_ubsan_insn(struct instruction *insn)
>                         "__ubsan_handle_builtin_unreachable"));
>  }
>
> -static bool ignore_unreachable_insn(struct instruction *insn)
> +static bool ignore_unreachable_insn(struct objtool_file *file, struct instruction *insn)
>  {
>         int i;
> +       struct instruction *prev_insn;
>
>         if (insn->ignore || insn->type == INSN_NOP)
>                 return true;
> @@ -2639,8 +2640,11 @@ static bool ignore_unreachable_insn(struct instruction *insn)
>          * __builtin_unreachable().  The BUG() macro has an unreachable() after
>          * the UD2, which causes GCC's undefined trap logic to emit another UD2
>          * (or occasionally a JMP to UD2).
> +        * CONFIG_UBSAN_TRAP may also insert a UD2 after calling a __noreturn
> +        * function.
>          */
> -       if (list_prev_entry(insn, list)->dead_end &&
> +       prev_insn = list_prev_entry(insn, list);
> +       if ((prev_insn->dead_end || dead_end_function(file, prev_insn->call_dest)) &&
>             (insn->type == INSN_BUG ||
>              (insn->type == INSN_JUMP_UNCONDITIONAL &&
>               insn->jump_dest && insn->jump_dest->type == INSN_BUG)))
> @@ -2767,7 +2771,7 @@ static int validate_reachable_instructions(struct objtool_file *file)
>                 return 0;
>
>         for_each_insn(file, insn) {
> -               if (insn->visited || ignore_unreachable_insn(insn))
> +               if (insn->visited || ignore_unreachable_insn(file, insn))
>                         continue;
>
>                 WARN_FUNC("unreachable instruction", insn->sec, insn->offset);
> --
> 2.25.1
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200919064118.1899325-1-ilie.halip%40gmail.com.
