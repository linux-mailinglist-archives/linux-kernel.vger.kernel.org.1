Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F57D2ADCDB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 18:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbgKJR0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 12:26:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:45206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbgKJR0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 12:26:42 -0500
Received: from trantor (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3BA4206B2;
        Tue, 10 Nov 2020 17:26:40 +0000 (UTC)
Date:   Tue, 10 Nov 2020 17:26:38 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     YiFei Zhu <yifeifz2@illinois.edu>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: Enable seccomp architecture tracking
Message-ID: <X6rNTgw8z4kreVD9@trantor>
References: <20201028002000.2666043-1-keescook@chromium.org>
 <20201028002000.2666043-2-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028002000.2666043-2-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 05:19:59PM -0700, Kees Cook wrote:
> To enable seccomp constant action bitmaps, we need to have a static
> mapping to the audit architecture and system call table size. Add these
> for arm64.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/arm64/include/asm/seccomp.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/seccomp.h b/arch/arm64/include/asm/seccomp.h
> index c36387170936..40f325e7a404 100644
> --- a/arch/arm64/include/asm/seccomp.h
> +++ b/arch/arm64/include/asm/seccomp.h
> @@ -19,4 +19,19 @@
>  
>  #include <asm-generic/seccomp.h>
>  
> +#ifdef CONFIG_ARM64
> +# define SECCOMP_ARCH_NATIVE		AUDIT_ARCH_AARCH64
> +# define SECCOMP_ARCH_NATIVE_NR		NR_syscalls
> +# define SECCOMP_ARCH_NATIVE_NAME	"arm64"

"aarch64"? (to match ELF_PLATFORM; not sure what this is used for as
SECCOMP_ARCH_NATIVE_NAME is not defined in 5.10-rc3)

> +# ifdef CONFIG_COMPAT
> +#  define SECCOMP_ARCH_COMPAT		AUDIT_ARCH_ARM
> +#  define SECCOMP_ARCH_COMPAT_NR	__NR_compat_syscalls
> +#  define SECCOMP_ARCH_COMPAT_NAME	"arm"
> +# endif
> +#else /* !CONFIG_ARM64 */
> +# define SECCOMP_ARCH_NATIVE		AUDIT_ARCH_ARM
> +# define SECCOMP_ARCH_NATIVE_NR		NR_syscalls
> +# define SECCOMP_ARCH_NATIVE_NAME	"arm"
> +#endif

Why do we need a !CONFIG_ARM64 in an arm64 header file?

-- 
Catalin
