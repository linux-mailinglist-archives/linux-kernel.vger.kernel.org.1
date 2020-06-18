Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90CBC1FFC6B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 22:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgFRUW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 16:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbgFRUW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:22:58 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65137C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 13:22:58 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id b7so3701694pju.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 13:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xnQxnEGFqJBRLt94YNylhgWnHetVl/qVFrV3Ml9hdCk=;
        b=aTn9yjeKEwTKKCUcFeRW7sUrGP5djzWcTw5h3fP1Mg6Q8g4FLlgPY5CfyRIpnT9vFS
         3rLp9irVfn3I11WLJfhn0BDFSL0uNtO4GNOlumgqVilbB/8bpMjCiBEu1++cNbLFuZxX
         ao6NczHahM/Kd1mJZshskFBOcJTTpYHdy4+5WifflqL26LEbpFm66yif3CxvK1rlgPYn
         bxMg3IWiJnXi7E5APpb+4LXlAOEuKB5aOtn5ThG6vs68KOy3qK/iSmd5AsoR/dWj6rhb
         UxR8fkpyMry1ZCaMZNUKzQqTIxukD8UowwVWIjsoX1K8RcbvpdM/FN969eVJ1g2xJIcH
         +18w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xnQxnEGFqJBRLt94YNylhgWnHetVl/qVFrV3Ml9hdCk=;
        b=T7SsxN6AoGZDMHkkv5FsR+7jpEyxRlgeHswQJxiKOQRHXNqCM6+Z6QwQjxS6IuECX0
         MQOwLq3jx1uXNdGpD6TDLGY5FqhbgRem/FwEvC/H3T6sEYv/5wdS/1eL6cYY4KQdNlUT
         xzbMKPp0IcFHjNUXL1Lm0w6gjQL1h3dxyl11rP1IH8zKlUfH5NFm18jkq+e3VxffZuTZ
         FRvs32Fgoo2zWQAxLzhrvMGHv+xzEvv0KpdHHwaZMTmBe0v6IIg36fhH/5TKihnELiT0
         5C3Las2K5AgQuY9LhybrG8+Wu1HXFPdFSjoQ98dVvDDk9Xu5uwSg2qGGhNkJ1IOUkNHY
         qTbw==
X-Gm-Message-State: AOAM533aEVEJVlpMuRwgGuTWzVEcaDGVRO0WdinGGo+pxMOABMnmt0pK
        G/dvGaxyJ240vlYV600nCFrBfVsOsQB/LsmdM1USsQ==
X-Google-Smtp-Source: ABdhPJy/UXwIWIhlQcPJp1WubSNRKDgXh69omjFbSaH3IHqaE2QCr1yIVnet/GeuPk2izXLGvRcEW6tgQLCPhaqXQX8=
X-Received: by 2002:a17:902:b698:: with SMTP id c24mr5053874pls.223.1592511777575;
 Thu, 18 Jun 2020 13:22:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200616223633.73971-1-nhuck@google.com>
In-Reply-To: <20200616223633.73971-1-nhuck@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 18 Jun 2020 13:22:45 -0700
Message-ID: <CAKwvOdkibnsr+z8-pXG1RjOEcrGQ6HQ0=PM-B9p-i85_BKS0cQ@mail.gmail.com>
Subject: Re: [PATCH] Fix unwind_frame for clang-built kernels
To:     Nathan Huckleberry <nhuck@google.com>,
        =?UTF-8?B?TWlsZXMgQ2hlbiAo6Zmz5rCR5qi6KQ==?= 
        <miles.chen@mediatek.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kristof Beyls <Kristof.Beyls@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 3:36 PM 'Nathan Huckleberry' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> Since clang does not push pc and sp in function prologues, the current
> implementation of unwind_frame does not work. By using the previous
> frame's lr/fp instead of saved pc/sp we get valid unwinds on clang-built
> kernels.
>
> The bounds check on next frame pointer must be changed as well since
> there are 8 less bytes between frames.
>
> This fixes /proc/<pid>/stack.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/912
> Signed-off-by: Nathan Huckleberry <nhuck@google.com>

Thanks for the patch, Nathan!  When I looked into this, I found the
latest ARM AAPCS [0] specifically says (with `it` referring to `a
platform`: "It may permit the frame pointer register to be used as a
general-purpose callee-saved register, but provide a platform-specific
mechanism for external agents to reliably locate the chain of frame
records."   While it's good that's acknowledged in the documentation,
the current wording is relaxed in order to not force current
implementations to converge.  This has the unfortunate side effect of
making finding the frame pointer toolchain dependendent, hence this
patch and your previous commit 6dc5fd93b2f1 ("ARM: 8900/1:
UNWINDER_FRAME_POINTER implementation for Clang").  Being more
specific in the documentation would force at least one implementation
to change, and I think that would also imply an ABI break.  So I can
see it both ways, though I still would prefer that the language pin
this down, even if we had to change LLVM.  Just providing additional
context for folks on the thread.

This should also have a reported by tag from Miles, in v2.

Reported-by: Miles Chen <Miles.Chen@mediatek.com>

Miles mentioned to me that he tested it, but maybe Miles can confirm
that publicly on-list via an explicit Tested-by: tag?

This would be useful for us to have in stable; otherwise we'll have to
carry out of tree in Android and CrOS, which I'd rather not do.  Via
Documentation/process/stable-kernel-rules.rst, if you add this tag to
V2, that will greatly simplify submitting this to stable:
Cc: stable@vger.kernel.org

Miles also showed me the behavior of this patch for different kernel
versions, which varies anywhere from empty or single entry traces to
panics, so this is pretty important that this works for Clang builds.

[0] https://static.docs.arm.com/ihi0042/i/aapcs32.pdf

> ---
>  arch/arm/kernel/stacktrace.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
> index cc726afea023..76ea4178a55c 100644
> --- a/arch/arm/kernel/stacktrace.c
> +++ b/arch/arm/kernel/stacktrace.c
> @@ -22,6 +22,19 @@
>   * A simple function epilogue looks like this:
>   *     ldm     sp, {fp, sp, pc}
>   *
> + * When compiled with clang, pc and sp are not pushed. A simple function
> + * prologue looks like this when built with clang:
> + *
> + *     stmdb   {..., fp, lr}
> + *     add     fp, sp, #x
> + *     sub     sp, sp, #y
> + *
> + * A simple function epilogue looks like this when built with clang:
> + *
> + *     sub     sp, fp, #x
> + *     ldm     {..., fp, pc}
> + *
> + *
>   * Note that with framepointer enabled, even the leaf functions have the same
>   * prologue and epilogue, therefore we can ignore the LR value in this case.
>   */
> @@ -34,6 +47,16 @@ int notrace unwind_frame(struct stackframe *frame)
>         low = frame->sp;
>         high = ALIGN(low, THREAD_SIZE);
>
> +#ifdef CONFIG_CC_IS_CLANG
> +       /* check current frame pointer is within bounds */
> +       if (fp < low + 4 || fp > high - 4)

The patch LGTM; maybe Russell or Catalin could triple check this
bounds check?  Assuming there's no issue, you can include on a v2 my
reviewed by:

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

I'd probably wait the remainder of a week before sending a v2 to
collect additional feedback.  Thank you again.

> +               return -EINVAL;
> +
> +       frame->sp = frame->fp;
> +       frame->fp = *(unsigned long *)(fp);
> +       frame->pc = frame->lr;
> +       frame->lr = *(unsigned long *)(fp + 4);
> +#else
>         /* check current frame pointer is within bounds */
>         if (fp < low + 12 || fp > high - 4)
>                 return -EINVAL;
> @@ -42,6 +65,7 @@ int notrace unwind_frame(struct stackframe *frame)
>         frame->fp = *(unsigned long *)(fp - 12);
>         frame->sp = *(unsigned long *)(fp - 8);
>         frame->pc = *(unsigned long *)(fp - 4);
> +#endif
>
>         return 0;
>  }
> --
> 2.27.0.290.gba653c62da-goog
>
> --

-- 
Thanks,
~Nick Desaulniers
