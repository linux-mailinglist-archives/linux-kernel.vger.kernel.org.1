Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 962052F3FF3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391923AbhALXHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 18:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388864AbhALXHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 18:07:21 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC213C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 15:06:40 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id w18so334419iot.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 15:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YaAZECbdA3slTbiSWayTFRmmhclS7xtPrtvRPKQb2ZA=;
        b=QoExkiTyI0PU/oaQzWOwntPo/ouSQzfufTt3xEBWkZLTE7cwWmf2KF/b3XgOrQewVt
         /wvXNXGiDHKVuolh0064ChHbROBMdViIngyUbFeGlA2wz3eeQ7Qv1ylNmYV0+2fDQfxX
         E0K65wBPnGEJiiTtDx0FNOc49Ecf0yKHY/0npFvVb1k6wSq/8kfp6A5yeRcFfupT55WU
         vCZWgCAr1e4L/u7hRdU7J6Cm2DgF+2xgjXljkV9VGXLbOF69PUHm3aWRVrC7pxdE3B+2
         Q5ucSwLjEWyUhVXPrGIS4ek+/sUQnE9HIJBErDpDh9/z8c0T3dBO6KbCqGtZIhe81Rj9
         prfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YaAZECbdA3slTbiSWayTFRmmhclS7xtPrtvRPKQb2ZA=;
        b=AIZyXIn7OlOD4aH66/A7c2g2Sdsb5G5TJ82sC7rWk5cS/7303g4zkoNafniK0qyi6t
         BmZ5EoH6KmzNmd+MMKpJUqrqpl03cK90ZBzbKShp7HI+YLunuUyvmViT+OLkiikmr14a
         ckoZtLnx1A0jCtTcCtKsw1rb7GSaZUP/SVooEteO9ne42gtI3JixEoFm1Yy4E67l5PD5
         XNeaUEA1hgBx2iAhubt1DvrsjDCKCHPaYpT2xMSzSu3twM1IAwWj2RbgUkNb6gxvGy0b
         Pi2qlgiSZyQN4+h95Gkh0vvfy9/9UELjynYRzJi3apTAGvQhRIv/wzYxW1xK62EsEbVy
         /qbQ==
X-Gm-Message-State: AOAM530wdCapf/YNGBq2f6+oYCeBd6G3N1Yehl/NGJzzPls90RHpb6Wo
        GZxd1QtNaTb17POod93PVKMVYEFAsN5ocw==
X-Google-Smtp-Source: ABdhPJy2CWVar6TOXSsk52Epu98So0QjpbK36Iw+aoHVz1oKhSw5hbalroCZ8k6fCSgRD1Bxde+ghA==
X-Received: by 2002:a05:6638:1247:: with SMTP id o7mr1690891jas.31.1610492800244;
        Tue, 12 Jan 2021 15:06:40 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id r12sm162360ile.59.2021.01.12.15.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 15:06:39 -0800 (PST)
Date:   Tue, 12 Jan 2021 16:06:37 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Florian Weimer <fweimer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH] compiler.h: Raise minimum version of GCC to 5.1 for arm64
Message-ID: <20210112230637.GA1480157@ubuntu-m3-large-x86>
References: <20210112224832.10980-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112224832.10980-1-will@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 10:48:32PM +0000, Will Deacon wrote:
> GCC versions >= 4.9 and < 5.1 have been shown to emit memory references
> beyond the stack pointer, resulting in memory corruption if an interrupt
> is taken after the stack pointer has been adjusted but before the
> reference has been executed. This leads to subtle, infrequent data
> corruption such as the EXT4 problems reported by Russell King at the
> link below.
> 
> Life is too short for buggy compilers, so raise the minimum GCC version
> required by arm64 to 5.1.
> 
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Florian Weimer <fweimer@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Reported-by: Russell King <linux@armlinux.org.uk>
> Suggested-by: Arnd Bergmann <arnd@kernel.org>
> Link: https://lore.kernel.org/r/20210105154726.GD1551@shell.armlinux.org.uk
> Signed-off-by: Will Deacon <will@kernel.org>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  include/linux/compiler-gcc.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index 74c6c0486eed..555ab0fddbef 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -13,6 +13,12 @@
>  /* https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145 */
>  #if GCC_VERSION < 40900
>  # error Sorry, your version of GCC is too old - please use 4.9 or newer.
> +#elif defined(CONFIG_ARM64) && GCC_VERSION < 50100
> +/*
> + * https://gcc.gnu.org/bugzilla/show_bug.cgi?id=63293
> + * https://lore.kernel.org/r/20210107111841.GN1551@shell.armlinux.org.uk
> + */
> +# error Sorry, your version of GCC is too old - please use 5.1 or newer.
>  #endif
>  
>  /*
> -- 
> 2.30.0.284.gd98b1dd5eaa7-goog
> 
