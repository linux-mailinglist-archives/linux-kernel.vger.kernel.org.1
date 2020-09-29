Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4644427DCD9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 01:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729101AbgI2Xoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 19:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbgI2Xo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 19:44:29 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFC7C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 16:44:27 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x22so6385922pfo.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 16:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LHFC3pSp/lOd7ky65H/yobNgw+7t15stg1Jz7JjkFbI=;
        b=P1rBseIRvL73O9KEgzsraANxelNynazHAaHgBcUNJGXW1FAVi9U/kndAv1g4k6feHa
         W/vIsM7esd7daIbIDh9a+hsvBhPZE0n4RkImb3UMkAxUJ7sBgcRf+bKd/KwaAIzmQZwB
         AyHBB/I9asrY7CY7byhP5KYw7oJIvw9EFm5rU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LHFC3pSp/lOd7ky65H/yobNgw+7t15stg1Jz7JjkFbI=;
        b=RiclnbGNMSEY7Bzdsps9A0HdMhpT3xKDwcm9WPJKKBSi6UTf+DPD1KO8p805Zyj5bb
         E8arbglQDYNHMDzD8PrzxKUOAq8QvA3IkfWV9BXebM8CmBMUS/g5ABVjtSUwfHp00/u8
         VUH2CJTubYroUMIL88ykQUYqKV4SNwhHo+zbDGG8cMLdS53gpv/xzmcDiXL7/emQyF1y
         2wKOV71/ifWdOCabPPFSjf/iakUPAF0WwdwYAJk28aD2CXtqyNTdtig7NW9wBjsu0ihL
         bWe/7GIlgAkoTMUKe02K98oZfR9VY5C7ZrdyPBfk1qgC1T4UoJSYDm/+7cJP1JIgMD6l
         ujTg==
X-Gm-Message-State: AOAM533V2cnK57n2Hr3hQ9AIDU7tTasWvucQyidgHgFuXw1qBk5e9OEQ
        23QIAT24C/5yU9uStIdVzS23YQ==
X-Google-Smtp-Source: ABdhPJzK27mqhIAIOMv4JKdped6VDZu8Z2NdH+yhFdHUeMoABZic7pYbwPY06S/z8NGx/GXbSpNkWA==
X-Received: by 2002:a65:4342:: with SMTP id k2mr4984144pgq.343.1601423066988;
        Tue, 29 Sep 2020 16:44:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p11sm20964pjz.44.2020.09.29.16.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 16:44:26 -0700 (PDT)
Date:   Tue, 29 Sep 2020 16:44:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kbuild test robot <lkp@intel.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthias Maennich <maennich@google.com>,
        Jessica Yu <jeyu@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] export.h: fix section name for CONFIG_TRIM_UNUSED_KSYMS
 for Clang
Message-ID: <202009291643.97AA3D46@keescook>
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

Reviewed-by: Kees Cook <keescook@chromium.org>

Do these other cases need fixing too?

arch/arm64/mm/mmu.c:u64 __section(".mmuoff.data.write") vabits_actual;
include/linux/srcutree.h:               __section("___srcu_struct_ptrs") = &name

-Kees

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

-- 
Kees Cook
