Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F0427EF1D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 18:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731136AbgI3Q0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 12:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3Q0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 12:26:43 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18F2C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 09:26:41 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id l18so69910pjz.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 09:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=euGAurZX4qBq2rTxk1sS9112OK7Jtn1PkFhBEzUnB4Y=;
        b=b7dWSB7FHzi7QaRxseb09AYqUEyPVmCkDruEpj5BI+/bnG8giBUanSBl3wZc8+42+E
         Dn40nnXID4Nx96rAG73ixszMCIyIcOg0YMHau1jYAbVB/3JeDFphDGsU6XS+xbwFi2Wc
         Gu2s6p1KuB8j0oDe6pAX6JYTes1xcCeA3IXwovjRwyiFbU24BpQxnAQY5mVE/pkUSrMf
         tqwwn/0D+oiL5wO7VBQ9cFiCyc3A4/U7aatfdXZmLGxJA0lGYtr2/2h5tZkasrcBNsE3
         CalaxdGQTsDQxNmGHWzyGpvkNGwm863iHUUJPRFwLuFvPpM4ekxwmUd1AWN+5pleDxtf
         iRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=euGAurZX4qBq2rTxk1sS9112OK7Jtn1PkFhBEzUnB4Y=;
        b=bpBhWLMqWrk48wAxKQaWmtiIpA32QyO/gQDhwjZfUiX9SswmpgXtmO5aeglAFThVGV
         gBO2oxFQynOMYb83oD2XIayeDhXddLN3hkn7vM5/JPHd63JH/Y+AdyNnWmk2ik1JSfI/
         QedN57OkZtI9gMf5V5YONXVVxEtXdgRV2B5w4KAnmZ/zDzpbZO/sszd+ZlFIzkAbNXuS
         H2ywUrKZOFqcIVrvn011oRpoW57ebKO74AessOpIgEcCroBdzhhTiWEuGfz0o5V7dwMl
         8tFITtF3+Xf1q4FDm/Tei8I0OK491fEBeh1fwB0L6glRJhvLHeauMIv6LuQRDFJYpku4
         XD0w==
X-Gm-Message-State: AOAM531L2KM29a9YOEBnc97HZW1JGbRKagDfWrsSjCoK/jPwxrIC1Ql0
        OTcFey7NIsi0c4Y+Pcr0wVvW95mCVwk=
X-Google-Smtp-Source: ABdhPJxPZnrwznwaY0Rtsi3SxCo9SPuvHbrkdlKMntv1lvsPJqHNxLiAKKE8SRU3We8+cIW8Ct/fHw==
X-Received: by 2002:a17:902:778f:b029:d2:839f:9198 with SMTP id o15-20020a170902778fb02900d2839f9198mr394206pll.6.1601483201385;
        Wed, 30 Sep 2020 09:26:41 -0700 (PDT)
Received: from ubuntu-m3-large-x86 ([2604:1380:45e1:2200::1])
        by smtp.gmail.com with ESMTPSA id f9sm2754947pjq.26.2020.09.30.09.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 09:26:40 -0700 (PDT)
Date:   Wed, 30 Sep 2020 09:26:38 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kbuild test robot <lkp@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthias Maennich <maennich@google.com>,
        Jessica Yu <jeyu@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] export.h: fix section name for CONFIG_TRIM_UNUSED_KSYMS
 for Clang
Message-ID: <20200930162638.GB236767@ubuntu-m3-large-x86>
References: <20200929190701.398762-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929190701.398762-1-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 12:07:00PM -0700, Nick Desaulniers wrote:
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

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

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
>  #define __ksym_marker(sym)	\
> -	static int __ksym_marker_##sym[0] __section(".discard.ksym") __used
> +	static int __ksym_marker_##sym[0] __section(.discard.ksym) __used
>  
>  #define __EXPORT_SYMBOL(sym, sec, ns)					\
>  	__ksym_marker(sym);						\
> -- 
> 2.28.0.709.gb0816b6eb0-goog
> 
