Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACD8F26E35F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 20:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgIQSRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 14:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbgIQSQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 14:16:11 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B80AC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 11:16:06 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id c3so1566164plz.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 11:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pJlz1lyl7aTxHeTmVzs1SzNTrj8gWqaynH0CCR1cE3c=;
        b=vxxCO7JrsXxxBjFE/gc/+7PK3qsqBFAMeta0e7CTjimDTcb1Qd6WbNIYHDg5tV0eeU
         Ue++GYwhiiLr06kUcYpJtnF7Xgrqn3mHlXiuS7oaTHnj5VKII/k4PVq/jkklkDfaStMb
         spncaSTprr6YQXgjDnnajTILY3yiUgr25FtfZyusBZjSiJHt5jeoh5BLVTO2CHcbTcl6
         VC77ItAMwt3nkoHprfkBzIpYpO7Ah7Pp/NpmFJwrnWTR3v1v+n9QvD20910Up2zYdFD/
         Xkf4dV6c6jwBGqffyqt8VvYFfWV0LkfnWpVxHk3TUHl7SPaGUVGkGR34wpvSln8+tcXI
         TrUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pJlz1lyl7aTxHeTmVzs1SzNTrj8gWqaynH0CCR1cE3c=;
        b=Ti3EeD+M/ARwzc1YyHC87RX4s1iHM3imJfrO6VfP7+s87qsP9GTE4vSdQAUxaIAEE3
         rwqeJQWHpgvWCIV98wx/TT7ZPkYOUTSmNKoUOfAI8mJzSqL6/IjEaEdFq80ZiAqNKvO5
         vGNuPnNGTOlnnzkCrpOQXWtUE0P7vKVWS3Wn0fhrLv2GOt3qVhXOlVexCI1vN8fGQSec
         8PxtRUJd6J2Jr1REithmsjiBdV3blojzrK8nybuPb94bsclZiXVK+VvQzZPsCQP+s8AT
         TCDvHw1yzsSGRacvOQcEUcwWkqjjqay9MJ9/uLjH06QXLCvm51Wv0KgSR+/paxPh5rC0
         EsCw==
X-Gm-Message-State: AOAM532LWvapXnyOJKIQmFB/otirnGTjRjLkNxlZcEAWwuqZUVv4vR9K
        i+GVYzfOas81bdKR+BR9gXTx1p37/xL9rdDypfFdZQ==
X-Google-Smtp-Source: ABdhPJxcTRnK5qbGL+LLYsXLyTrliHDhdsAmk7frRjtsswoGcGc9VKXMaiUtpJzzG99uq/5XY02hv7Jk640SCs6cl4w=
X-Received: by 2002:a17:90a:e517:: with SMTP id t23mr9138243pjy.25.1600366565663;
 Thu, 17 Sep 2020 11:16:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200917084905.1647262-1-ilie.halip@gmail.com>
In-Reply-To: <20200917084905.1647262-1-ilie.halip@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 17 Sep 2020 11:15:54 -0700
Message-ID: <CAKwvOdkBPrdekTsMnhvN2OH-vk1eLU+ZC-1MJ5jgA2FDq7Ja3A@mail.gmail.com>
Subject: Re: [PATCH] objtool: ignore unreachable trap after call to noreturn functions
To:     Ilie Halip <ilie.halip@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Rong Chen <rong.a.chen@intel.com>,
        Marco Elver <elver@google.com>,
        Philip Li <philip.li@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 1:49 AM Ilie Halip <ilie.halip@gmail.com> wrote:
>
> With CONFIG_UBSAN_TRAP enabled, the compiler may insert a trap instruction
> after a call to a noreturn function. In this case, objtool warns that the
> ud2 instruction is unreachable.
>
> objtool silences similar warnings (trap after dead end instructions), so
> expand that check to include dead end functions.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Reported-by: kbuild test robot <lkp@intel.com>

Thanks for the patch, Ilie!  With this, a
defconfig+CONFIG_UBSAN+CONFIG_UBSAN_TRAP goes from 82 unreachable
instruction warnings from objtool to 0.

$ make LLVM=1 -j71 defconfig
$ make LLVM=1 -j71 menuconfig
<enable UBSAN and UBSAN_TRAP>
$ make LLVM=1 -j71 2> log.txt
$ grep warning: log.txt | cut -d ' ' -f 2- | sort | uniq -c | wc -l
82
$ b4 am https://lore.kernel.org/lkml/20200917084905.1647262-1-ilie.halip@gmail.com/
-o - | git am
$ make LLVM=1 -j71 clean
$ make LLVM=1 -j71 2> log.txt
$ grep warning: log.txt | cut -d ' ' -f 2- | sort | uniq -c | wc -l
0

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
> Signed-off-by: Ilie Halip <ilie.halip@gmail.com>
> ---
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


-- 
Thanks,
~Nick Desaulniers
