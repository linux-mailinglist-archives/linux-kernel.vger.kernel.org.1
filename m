Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEA12698A9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 00:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgINWNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 18:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgINWNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 18:13:17 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7E7C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 15:13:16 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id r19so231771pls.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 15:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XKHeWnZTmr+44PA1uk+tmIoZZMZNVyaEbUZsmkorfxM=;
        b=FLfu5qkpDm7o5/xP0ilZmNxVe+jdmcJEkTL/4DGLQ5xUBs9smNtW0pRVX074Wodffb
         QUGa2sH5fudwFrwS49G9uXA9hzulhM+YqeS3JvomF2XSTDvvz161Ko8MHkn/a5Vkn26o
         2wUHbRjJ9JT+dslYXV4aBJuwNU5aQBs5Tz/Pg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XKHeWnZTmr+44PA1uk+tmIoZZMZNVyaEbUZsmkorfxM=;
        b=mh1vGBr5VEmuCt1qDxWtdQNa+lpZH4faX10yUKj+QiI08OUfd5miOsNmSXNPu/cwFy
         WONQixvQC4CQLKgJ798kphzI5dSGgxT1k9Uxq0MHtX4gHZTEG3gK+eYJSsQ8wkIGZj6A
         joy2Vn73AMWNwL2/dycA0WaQKFgQnKykEEskzStXQIdMakBUPHdLd9f7V9XqhAt2HeUm
         gtO/k5vC0bxtmIKZpVad4H/w8Yhqo2XZbO5yn97NOTiCai+r2KLwEVy+PL1Z/OZ5ACwU
         qMw58KqSU36a4eOd/Ad0mKhOvUT1P7MvRzUCPbPKFlYqVvRLpcef01zRlaEplKhN98lz
         KgOw==
X-Gm-Message-State: AOAM533JdqQ/R/RuxDvbM47aZ8XRqHqan+hYxoFEGDutov2b+cV7hVPC
        St128ReqgW+VQv7IYR8chUOf7Q==
X-Google-Smtp-Source: ABdhPJyn8NpGqIRjrEpOsVjRNLYYQTqkknDqHNXZZiqb/DFr4jKhXnJkQxxoYZIMjCxQkiwbcgTD4Q==
X-Received: by 2002:a17:90b:3505:: with SMTP id ls5mr1284670pjb.105.1600121596214;
        Mon, 14 Sep 2020 15:13:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i187sm9130990pgd.82.2020.09.14.15.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 15:13:15 -0700 (PDT)
Date:   Mon, 14 Sep 2020 15:13:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     George-Aurelian Popescu <georgepope@google.com>
Cc:     maz@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        masahiroy@kernel.org, michal.lkml@markovi.net,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        clang-built-linux@googlegroups.com, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        natechancellor@gmail.com, ndesaulniers@google.com,
        dbrazdil@google.com, broonie@kernel.org, maskray@google.com,
        ascull@google.com, akpm@linux-foundation.org, dvyukov@google.com,
        elver@google.com, tglx@linutronix.de, arnd@arndb.de
Subject: Re: [PATCH 06/14] Fix CFLAGS for UBSAN_BOUNDS on Clang
Message-ID: <202009141509.CDDC8C8@keescook>
References: <20200914172750.852684-1-georgepope@google.com>
 <20200914172750.852684-7-georgepope@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914172750.852684-7-georgepope@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 05:27:42PM +0000, George-Aurelian Popescu wrote:
> From: George Popescu <georgepope@google.com>
> 
> When the kernel is compiled with Clang, UBSAN_BOUNDS inserts a brk after
> the handler call, preventing it from printing any information processed
> inside the buffer.
> For Clang -fsanitize=bounds expands to -fsanitize=array-bounds and
> -fsanitize=local-bounds, and the latter adds a brk after the handler
> call

That sounds like a compiler bug?

> Signed-off-by: George Popescu <georgepope@google.com>
> ---
>  scripts/Makefile.ubsan | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/Makefile.ubsan b/scripts/Makefile.ubsan
> index 27348029b2b8..3d15ac346c97 100644
> --- a/scripts/Makefile.ubsan
> +++ b/scripts/Makefile.ubsan
> @@ -4,7 +4,14 @@ ifdef CONFIG_UBSAN_ALIGNMENT
>  endif
>  
>  ifdef CONFIG_UBSAN_BOUNDS
> -      CFLAGS_UBSAN += $(call cc-option, -fsanitize=bounds)
> +      # For Clang -fsanitize=bounds translates to -fsanitize=array-bounds and
> +      # -fsanitize=local-bounds; the latter adds a brk right after the
> +      # handler is called.
> +      ifdef CONFIG_CC_IS_CLANG
> +            CFLAGS_UBSAN += $(call cc-option, -fsanitize=array-bounds)

This would mean losing the local-bounds coverage? Isn't that for locally
defined arrays on the stack?

> +      else
> +            CFLAGS_UBSAN += $(call cc-option, -fsanitize=bounds)
> +      endif
>  endif
>  
>  ifdef CONFIG_UBSAN_MISC
> -- 
> 2.28.0.618.gf4bc123cb7-goog
> 

-- 
Kees Cook
