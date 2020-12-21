Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2302DFCE8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 15:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgLUOhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 09:37:03 -0500
Received: from foss.arm.com ([217.140.110.172]:51082 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726499AbgLUOhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 09:37:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 349F61FB;
        Mon, 21 Dec 2020 06:36:17 -0800 (PST)
Received: from [10.37.8.22] (unknown [10.37.8.22])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D20C63F6CF;
        Mon, 21 Dec 2020 06:36:15 -0800 (PST)
Subject: Re: [PATCH] arm64: do not descend to vdso directories twice
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org
References: <20201218024540.1102650-1-masahiroy@kernel.org>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <55dc2724-cdfe-28ad-395d-707fe9bae2db@arm.com>
Date:   Mon, 21 Dec 2020 14:39:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201218024540.1102650-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On 12/18/20 2:45 AM, Masahiro Yamada wrote:
> arm64 descends into each vdso directory twice; first in vdso_prepare,
> second during the ordinary build process.
> 
> PPC mimicked it and uncovered a problem [1]. In the first descend,
> Kbuild directly visits the vdso directories, therefore it does not
> inherit subdir-ccflags-y from upper directories.
> 
> This means the command line parameters may differ between the two.
> If it happens, the offset values in the generated headers might be
> different from real offsets of vdso.so in the kernel.
> 
> This potential danger should be avoided. The vdso directories are
> built in the vdso_prepare stage, so the second descend is unneeded.
> 
> [1]: https://lore.kernel.org/linux-kbuild/CAK7LNARAkJ3_-4gX0VA2UkapbOftuzfSTVMBbgbw=HD8n7N+7w@mail.gmail.com/T/#ma10dcb961fda13f36d42d58fa6cb2da988b7e73a
> 

I could not reproduce the problem you are reporting on arm64. Could you please
provide some steps?

In my case the vDSO library is not rebuilt as a result of the procedure reported
in the email you linked at [1].

> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  arch/arm64/Makefile                                | 10 ++++++----
>  arch/arm64/kernel/Makefile                         |  5 +++--
>  arch/arm64/kernel/{vdso/vdso.S => vdso-wrap.S}     |  0
>  arch/arm64/kernel/vdso/Makefile                    |  1 -
>  arch/arm64/kernel/{vdso32/vdso.S => vdso32-wrap.S} |  0
>  arch/arm64/kernel/vdso32/Makefile                  |  1 -
>  6 files changed, 9 insertions(+), 8 deletions(-)
>  rename arch/arm64/kernel/{vdso/vdso.S => vdso-wrap.S} (100%)
>  rename arch/arm64/kernel/{vdso32/vdso.S => vdso32-wrap.S} (100%)
> 
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 6a87d592bd00..f18d20a68170 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -179,10 +179,12 @@ ifeq ($(KBUILD_EXTMOD),)
>  # this hack.
>  prepare: vdso_prepare
>  vdso_prepare: prepare0
> -	$(Q)$(MAKE) $(build)=arch/arm64/kernel/vdso include/generated/vdso-offsets.h
> -	$(if $(CONFIG_COMPAT_VDSO),$(Q)$(MAKE) \
> -		$(build)=arch/arm64/kernel/vdso32  \
> -		include/generated/vdso32-offsets.h)
> +	$(Q)$(MAKE) $(build)=arch/arm64/kernel/vdso \
> +	include/generated/vdso-offsets.h arch/arm64/kernel/vdso/vdso.so
> +ifdef CONFIG_COMPAT_VDSO
> +	$(Q)$(MAKE) $(build)=arch/arm64/kernel/vdso32 \
> +	include/generated/vdso32-offsets.h arch/arm64/kernel/vdso32/vdso.so
> +endif
>  endif

The reason why it is currently done in two phases (a bit hacky as per comment)
is because vdso-offsets.h is required to be generated before compiling kernel/.
Please refer to the comment in arch/arm64/Makefile.

Could you explain how your change satisfies the dependency?

>  
>  define archhelp
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index 86364ab6f13f..42f6ad2c7eac 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -59,9 +59,10 @@ obj-$(CONFIG_CRASH_CORE)		+= crash_core.o
>  obj-$(CONFIG_ARM_SDE_INTERFACE)		+= sdei.o
>  obj-$(CONFIG_ARM64_PTR_AUTH)		+= pointer_auth.o
>  obj-$(CONFIG_ARM64_MTE)			+= mte.o
> +obj-y					+= vdso-wrap.o
> +obj-$(CONFIG_COMPAT_VDSO)		+= vdso32-wrap.o
>  
> -obj-y					+= vdso/ probes/
> -obj-$(CONFIG_COMPAT_VDSO)		+= vdso32/
> +obj-y					+= probes/
>  head-y					:= head.o
>  extra-y					+= $(head-y) vmlinux.lds
>  
> diff --git a/arch/arm64/kernel/vdso/vdso.S b/arch/arm64/kernel/vdso-wrap.S
> similarity index 100%
> rename from arch/arm64/kernel/vdso/vdso.S
> rename to arch/arm64/kernel/vdso-wrap.S
> diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
> index a8f8e409e2bf..85222f64f394 100644
> --- a/arch/arm64/kernel/vdso/Makefile
> +++ b/arch/arm64/kernel/vdso/Makefile
> @@ -45,7 +45,6 @@ endif
>  # Disable gcov profiling for VDSO code
>  GCOV_PROFILE := n
>  
> -obj-y += vdso.o
>  targets += vdso.lds
>  CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
>  
> diff --git a/arch/arm64/kernel/vdso32/vdso.S b/arch/arm64/kernel/vdso32-wrap.S
> similarity index 100%
> rename from arch/arm64/kernel/vdso32/vdso.S
> rename to arch/arm64/kernel/vdso32-wrap.S
> diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
> index a1e0f91e6cea..789ad420f16b 100644
> --- a/arch/arm64/kernel/vdso32/Makefile
> +++ b/arch/arm64/kernel/vdso32/Makefile
> @@ -155,7 +155,6 @@ c-obj-vdso-gettimeofday := $(addprefix $(obj)/, $(c-obj-vdso-gettimeofday))
>  asm-obj-vdso := $(addprefix $(obj)/, $(asm-obj-vdso))
>  obj-vdso := $(c-obj-vdso) $(c-obj-vdso-gettimeofday) $(asm-obj-vdso)
>  
> -obj-y += vdso.o
>  targets += vdso.lds
>  CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
>  
> 

-- 
Regards,
Vincenzo
