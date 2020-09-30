Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C039627F41E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 23:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730290AbgI3VVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 17:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3VVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 17:21:30 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D6CC0613D0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 14:21:29 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e18so1974996pgd.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 14:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lv/VYS6WVyLfsnzAOnjQJDHCItBTdggrCJvPM6RfMKw=;
        b=QL/8qtqD7TX6f+oI3k3pCSaenm7hpXhiJpS4nzuX8VywkpDdYkfvOqg4PD9ycAR8Ev
         rPaaYLRxcRrmugxIUbCZeftZ4UbLcYoi9ruaSYnn8Ngr3fbnc100I+htwT4EGuv009Xu
         jynYchzrT73iTHN2C6ClR8RO9m1+sNdO7EQeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lv/VYS6WVyLfsnzAOnjQJDHCItBTdggrCJvPM6RfMKw=;
        b=n1AiGeg3MEAzZN67SB2zMMznwSEjc0k73xca6o+WmnphXPYYwRvpJBzdQbIidHNaUi
         SJiwDO3JdNBC6C/QPfkyWwQQRpBGvVHvklJ+CjfgZAzVl5/25twgtQxj7p5NJmLHF9gQ
         NwmjrFCGmYn5TBHmRpaZ8CR6t6bUrSb4LuzRehTUClksFfMdid7XIFb7SNnB3WEvb51M
         0odAmy24NglfjsNB4KE3ooXrRBREuHbMMX8ut5KH1IDpwu1VGSkqTSltVHIS3RUBjtsF
         6g19fMWXIqZZD+2lWDoBx8Q5CJKientrOKdmQnTT+bFaLivUPilv2CZhgx5jl9jJqt/J
         ZA2w==
X-Gm-Message-State: AOAM531PiQL0BwlSPECnKRYetYWBO+ka5QHV+o/eOped798MYfi60H1W
        orsUgLDQYp+xMxwG5gFXkuTRtA==
X-Google-Smtp-Source: ABdhPJyz5PkXKzzAFCYMVHQjc9sSnYWzqxDm1d9ol9v+cbqCMKYnjx9sn1stgq5ZDlNEJB0VqXgksg==
X-Received: by 2002:a17:902:b186:b029:d1:cc21:9a7d with SMTP id s6-20020a170902b186b02900d1cc219a7dmr4250435plr.8.1601500889449;
        Wed, 30 Sep 2020 14:21:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j6sm3440223pfi.129.2020.09.30.14.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 14:21:28 -0700 (PDT)
Date:   Wed, 30 Sep 2020 14:21:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     containers@lists.linux-foundation.org,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Subject: Re: [PATCH v3 seccomp 1/5] x86: Enable seccomp architecture tracking
Message-ID: <202009301418.20BA0CE33@keescook>
References: <cover.1601478774.git.yifeifz2@illinois.edu>
 <484392624b475cc25d90a787525ede70df9f7d51.1601478774.git.yifeifz2@illinois.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <484392624b475cc25d90a787525ede70df9f7d51.1601478774.git.yifeifz2@illinois.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 10:19:12AM -0500, YiFei Zhu wrote:
> From: Kees Cook <keescook@chromium.org>
> 
> Provide seccomp internals with the details to calculate which syscall
> table the running kernel is expecting to deal with. This allows for
> efficient architecture pinning and paves the way for constant-action
> bitmaps.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> [YiFei: Removed x32, added macro for nr_syscalls]
> Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
> ---
>  arch/x86/include/asm/seccomp.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/x86/include/asm/seccomp.h b/arch/x86/include/asm/seccomp.h
> index 2bd1338de236..7b3a58271656 100644
> --- a/arch/x86/include/asm/seccomp.h
> +++ b/arch/x86/include/asm/seccomp.h
> @@ -16,6 +16,18 @@
>  #define __NR_seccomp_sigreturn_32	__NR_ia32_sigreturn
>  #endif
>  
> +#ifdef CONFIG_X86_64
> +# define SECCOMP_ARCH_DEFAULT			AUDIT_ARCH_X86_64
> +# define SECCOMP_ARCH_DEFAULT_NR		NR_syscalls

bikeshedding: let's call these SECCOMP_ARCH_NATIVE* -- I think it's more
descriptive.

> +# ifdef CONFIG_COMPAT
> +#  define SECCOMP_ARCH_COMPAT			AUDIT_ARCH_I386
> +#  define SECCOMP_ARCH_COMPAT_NR		IA32_NR_syscalls
> +# endif
> +#else /* !CONFIG_X86_64 */
> +# define SECCOMP_ARCH_DEFAULT		AUDIT_ARCH_I386
> +# define SECCOMP_ARCH_DEFAULT_NR	NR_syscalls
> +#endif
> +
>  #include <asm-generic/seccomp.h>
>  
>  #endif /* _ASM_X86_SECCOMP_H */
> -- 
> 2.28.0
> 

But otherwise, yes, looks good to me. For this patch, I think the S-o-b chain is probably more
accurately captured as:

Signed-off-by: Kees Cook <keescook@chromium.org>
Co-developed-by: YiFei Zhu <yifeifz2@illinois.edu>
Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>


-- 
Kees Cook
