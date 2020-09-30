Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C131527EF7F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 18:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730627AbgI3Qnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 12:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3Qnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 12:43:45 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AC5C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 09:43:45 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id 26so2397897ois.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 09:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=yQL+wkm7CHaYGUVs9aNlVsVy8ybAButOFBFiXoH6zwM=;
        b=ZiS94qcWQm+yO3ri3CB8h0+l+4NyBgjt0abPuqOkpsoRbKSyRYYbtZX/femlYOT8fx
         U0UKCblipV+39mZ8wrlge55E88mc/rlKSleB7SfCfnQ3uFHRbVhnrWbnOd+8aX0zrKyT
         CGtZ1bpDfgHCjfLT33vludC6rJJP6EMwf3SMQGKWX7Sei1UlVjnfv/eztaPpKyE1VLDx
         dpVf3Sk1nDFQiuIyablPyI7cK6ie6dArcSluM/9OKVDLLvwG8Q+wUIGlFdahZkqeJM4P
         9jyEdXNpqye6TYNDWLrRaj1Kaffv+wwc8+ZsGVC00TxS0VdJtB0ZXP1s11KNQW9AbZFJ
         +JRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=yQL+wkm7CHaYGUVs9aNlVsVy8ybAButOFBFiXoH6zwM=;
        b=Tj5NQIm5GvoXPlqs0CKSeu4JFaBlVouuETD7kwUjY34gDcuPWgZ0f47MPfH7/9bp14
         kIQRMwWf9kpPadO6p2fGVUrWuqANV6QM7cFzfjUIFcp3LzfinyMKMFQcn6gnWH3o5pXf
         lXn+iCIv77ignw6aMaq0+UHXoMRVwPji5pp1a6DcZcHUx+FZtedZydxqvIllcY/+V94v
         pIDfYUTpedCzlPP/cbEjL0MCnHbShST8pgxBC5V6KUy1gH3fjKvSPaPuM1fh3TwgdCxq
         WQwmejc4/LTmXWwPstmG3otq8bgsM6ewSrVu289hpA5oEDOyZmxyHAcE5yfWlqo3eMZC
         2XGw==
X-Gm-Message-State: AOAM531lXGg8Fout8WbQ3YhMkeQ0EFS30qaQJ+h5Qp3eDa4nd8vHY4fe
        siJb6o5COhkLej5dDmOKWQ2q+A0XU60xA8r3Cx8=
X-Google-Smtp-Source: ABdhPJy4fIbuX9BDCfZ6U3lVKZF26pmzU6PIeGWFmJSdlUg0o/V0tIdh8/YA8n1FpCOP9N2KHQRZofqNmRgMhK6obug=
X-Received: by 2002:aca:ec50:: with SMTP id k77mr1866572oih.35.1601484224417;
 Wed, 30 Sep 2020 09:43:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200929190701.398762-1-ndesaulniers@google.com>
In-Reply-To: <20200929190701.398762-1-ndesaulniers@google.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 30 Sep 2020 18:43:32 +0200
Message-ID: <CA+icZUUU80TTJ6RuM-vTHPj4kSZr0ZehRA2q31=jFCxNKSiaTQ@mail.gmail.com>
Subject: Re: [PATCH] export.h: fix section name for CONFIG_TRIM_UNUSED_KSYMS
 for Clang
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kbuild test robot <lkp@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthias Maennich <maennich@google.com>,
        Jessica Yu <jeyu@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 9:07 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> When enabling CONFIG_TRIM_UNUSED_KSYMS, the linker will warn about the
> orphan sections:
> (".discard.ksym") is being placed in '".discard.ksym"'
> repeatedly when linking vmlinux. This is because the stringification
> operator, `#`, in the preprocessor escapes strings.  GCC and Clang
> differ in how they treat section names that contain \".
>
> The portable solution is to not use a string literal with the
> preprocessor stringification operator.
>
> Link: https://bugs.llvm.org/show_bug.cgi?id=42950
> Link: https://github.com/ClangBuiltLinux/linux/issues/1166
> Fixes: commit bbda5ec671d3 ("kbuild: simplify dependency generation for CONFIG_TRIM_UNUSED_KSYMS")
> Reported-by: kbuild test robot <lkp@intel.com>
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

"The return of escaped section names" - soon in your cinema?

Thanks Nick for catching this.

Reviewed-by: Sedat Dilek <sedat.dilek@gmail.com>

- Sedat -

> ---
>  include/linux/export.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/export.h b/include/linux/export.h
> index fceb5e855717..8933ff6ad23a 100644
> --- a/include/linux/export.h
> +++ b/include/linux/export.h
> @@ -130,7 +130,7 @@ struct kernel_symbol {
>   * discarded in the final link stage.
>   */
>  #define __ksym_marker(sym)     \
> -       static int __ksym_marker_##sym[0] __section(".discard.ksym") __used
> +       static int __ksym_marker_##sym[0] __section(.discard.ksym) __used
>
>  #define __EXPORT_SYMBOL(sym, sec, ns)                                  \
>         __ksym_marker(sym);                                             \
> --
> 2.28.0.709.gb0816b6eb0-goog
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200929190701.398762-1-ndesaulniers%40google.com.
