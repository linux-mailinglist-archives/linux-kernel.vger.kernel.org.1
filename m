Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1563329533C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 22:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443613AbgJUUEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 16:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410567AbgJUUEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 16:04:39 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26338C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 13:04:38 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id e10so2152783pfj.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 13:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MyV1gJcxFAQQ3ezKzLWjL48pP/r6NIsOLeLTCnNX+6g=;
        b=gd9gv83uo3riBYpEs8PF3ugJNfzSNB4r5uzG6neNC4ucEYQ70ZAQ7SkiViN2BDIWTa
         5FHnXZOzUUXdLzYnMhbsr4d8rz7li3H7J2bDv1CYRYR7wKMufb2lQRs+5RTT7gbMjECa
         QVv/pSQcNG3DxcpZ6JCFwhdlQlG2CHDdUMhOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MyV1gJcxFAQQ3ezKzLWjL48pP/r6NIsOLeLTCnNX+6g=;
        b=FFXTGUxEoQFUNN9eE0U5L602Lb8BFF6OcE3mkMRjYglmLy1Ey2gT47Xj2A9tV2rYj+
         ztBXNKVMNNXWgVL/wXYoo0ZBWfuVScd5hvRn/8MdlBsuIrC5DVEF0ZXmD3t5ZtCnLCI4
         d2tqFTQAbImTytzcqPR7GQXpMfz+5taj6MwAt+WWpTatAwXNqQJBWgsN6K/QrtrOdR+5
         AKfYwXy0MvRC3+P6Gk9xvD0Avjpa1HNH87+qphESdnLpExQWIrzu9Z6jsV8ZWjm3FlwR
         rPxrnHXLMQPbhqncbQ1CWljzNKJ/9D1AR4Dga76MwUPdUaKmG18ZP+QLO4n2+ZAdCpRy
         8C9g==
X-Gm-Message-State: AOAM531fgipmnRtu1JYC1lGGon27/tQZStoG3v1k5ShyUWuBACFdHnE6
        84ihaPVS8Rmg13UmkECFXb1qHg==
X-Google-Smtp-Source: ABdhPJzQMDT4NjgzXCNMb4qxA0JuGTDiQqwPA10cT3Kb6VfbouwfalZpaZSnZbTuOeHKzIiS/h2y5Q==
X-Received: by 2002:a65:664a:: with SMTP id z10mr4742041pgv.171.1603310677590;
        Wed, 21 Oct 2020 13:04:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n18sm3102678pff.129.2020.10.21.13.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 13:04:36 -0700 (PDT)
Date:   Wed, 21 Oct 2020 13:04:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>, x86@kernel.org
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vmlinux.lds.h: Keep .ctors.* with .ctors
Message-ID: <202010211303.4F8386F2@keescook>
References: <20201005025720.2599682-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005025720.2599682-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[thread ping: x86 maintainers, can someone please take this?]

On Sun, Oct 04, 2020 at 07:57:20PM -0700, Kees Cook wrote:
> Under some circumstances, the compiler generates .ctors.* sections. This
> is seen doing a cross compile of x86_64 from a powerpc64el host:
> 
> x86_64-linux-gnu-ld: warning: orphan section `.ctors.65435' from `kernel/trace/trace_clock.o' being
> placed in section `.ctors.65435'
> x86_64-linux-gnu-ld: warning: orphan section `.ctors.65435' from `kernel/trace/ftrace.o' being
> placed in section `.ctors.65435'
> x86_64-linux-gnu-ld: warning: orphan section `.ctors.65435' from `kernel/trace/ring_buffer.o' being
> placed in section `.ctors.65435'
> 
> Include these orphans along with the regular .ctors section.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Tested-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Fixes: 83109d5d5fba ("x86/build: Warn on orphan section placement")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v2: brown paper bag version: fix whitespace for proper backslash alignment
> ---
>  include/asm-generic/vmlinux.lds.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 5430febd34be..b83c00c63997 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -684,6 +684,7 @@
>  #ifdef CONFIG_CONSTRUCTORS
>  #define KERNEL_CTORS()	. = ALIGN(8);			   \
>  			__ctors_start = .;		   \
> +			KEEP(*(SORT(.ctors.*)))		   \
>  			KEEP(*(.ctors))			   \
>  			KEEP(*(SORT(.init_array.*)))	   \
>  			KEEP(*(.init_array))		   \
> -- 
> 2.25.1
> 

-- 
Kees Cook
