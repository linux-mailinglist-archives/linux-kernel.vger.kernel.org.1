Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1091A33A9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 14:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgDIMCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 08:02:19 -0400
Received: from foss.arm.com ([217.140.110.172]:49302 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbgDIMCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 08:02:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60CEA30E;
        Thu,  9 Apr 2020 05:02:19 -0700 (PDT)
Received: from [192.168.1.172] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 36FCD3F73D;
        Thu,  9 Apr 2020 05:02:18 -0700 (PDT)
Subject: Re: [PATCH v2 3/6] arm64/vdso: Add time napespace page
To:     Andrei Vagin <avagin@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>
References: <20200225073731.465270-1-avagin@gmail.com>
 <20200225073731.465270-4-avagin@gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <608367b8-7de6-cd3a-8915-8006becdca4c@arm.com>
Date:   Thu, 9 Apr 2020 13:03:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200225073731.465270-4-avagin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/20 7:37 AM, Andrei Vagin wrote:
> Allocate the time namespace page among VVAR pages.  Provide
> __arch_get_timens_vdso_data() helper for VDSO code to get the
> code-relative position of VVARs on that special page.
> 
> If a task belongs to a time namespace then the VVAR page which contains
> the system wide VDSO data is replaced with a namespace specific page
> which has the same layout as the VVAR page. That page has vdso_data->seq
> set to 1 to enforce the slow path and vdso_data->clock_mode set to
> VCLOCK_TIMENS to enforce the time namespace handling path.
> 
> The extra check in the case that vdso_data->seq is odd, e.g. a concurrent
> update of the VDSO data is in progress, is not really affecting regular
> tasks which are not part of a time namespace as the task is spin waiting
> for the update to finish and vdso_data->seq to become even again.
> 
> If a time namespace task hits that code path, it invokes the corresponding
> time getter function which retrieves the real VVAR page, reads host time
> and then adds the offset for the requested clock which is stored in the
> special VVAR page.
> 
> Signed-off-by: Andrei Vagin <avagin@gmail.com>

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> ---
>  arch/arm64/include/asm/vdso.h                 |  6 ++++++
>  .../include/asm/vdso/compat_gettimeofday.h    | 11 ++++++++++
>  arch/arm64/include/asm/vdso/gettimeofday.h    |  8 ++++++++
>  arch/arm64/kernel/vdso.c                      | 20 ++++++++++++++++---
>  arch/arm64/kernel/vdso/vdso.lds.S             |  5 ++++-
>  arch/arm64/kernel/vdso32/vdso.lds.S           |  5 ++++-
>  include/vdso/datapage.h                       |  1 +
>  7 files changed, 51 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/vdso.h b/arch/arm64/include/asm/vdso.h
> index 07468428fd29..351c145d3808 100644
> --- a/arch/arm64/include/asm/vdso.h
> +++ b/arch/arm64/include/asm/vdso.h
> @@ -12,6 +12,12 @@
>   */
>  #define VDSO_LBASE	0x0
>  
> +#ifdef CONFIG_TIME_NS
> +#define __VVAR_PAGES    2
> +#else
> +#define __VVAR_PAGES    1
> +#endif
> +
>  #ifndef __ASSEMBLY__
>  
>  #include <generated/vdso-offsets.h>
> diff --git a/arch/arm64/include/asm/vdso/compat_gettimeofday.h b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
> index 81b0c394f1d8..042814339a63 100644
> --- a/arch/arm64/include/asm/vdso/compat_gettimeofday.h
> +++ b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
> @@ -160,6 +160,17 @@ static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
>  	return ret;
>  }
>  
> +#ifdef CONFIG_TIME_NS
> +static __always_inline const struct vdso_data *__arch_get_timens_vdso_data(void)
> +{
> +	const struct vdso_data *ret;
> +
> +	asm volatile("mov %0, %1" : "=r"(ret) : "r"(_timens_data));
> +
> +	return ret;
> +}
> +#endif
> +
>  #endif /* !__ASSEMBLY__ */
>  
>  #endif /* __ASM_VDSO_GETTIMEOFDAY_H */
> diff --git a/arch/arm64/include/asm/vdso/gettimeofday.h b/arch/arm64/include/asm/vdso/gettimeofday.h
> index 5a534432aa5d..553bdc19a91f 100644
> --- a/arch/arm64/include/asm/vdso/gettimeofday.h
> +++ b/arch/arm64/include/asm/vdso/gettimeofday.h
> @@ -97,6 +97,14 @@ const struct vdso_data *__arch_get_vdso_data(void)
>  	return _vdso_data;
>  }
>  
> +#ifdef CONFIG_TIME_NS
> +static __always_inline
> +const struct vdso_data *__arch_get_timens_vdso_data(void)
> +{
> +	return _timens_data;
> +}
> +#endif
> +
>  #endif /* !__ASSEMBLY__ */
>  
>  #endif /* __ASM_VDSO_GETTIMEOFDAY_H */
> diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
> index 6ac9cdeac5be..b3e7ce24e59b 100644
> --- a/arch/arm64/kernel/vdso.c
> +++ b/arch/arm64/kernel/vdso.c
> @@ -46,6 +46,14 @@ enum arch_vdso_type {
>  #define VDSO_TYPES		(ARM64_VDSO + 1)
>  #endif /* CONFIG_COMPAT_VDSO */
>  
> +enum vvar_pages {
> +	VVAR_DATA_PAGE_OFFSET = 0,
> +#ifdef CONFIG_TIME_NS
> +	VVAR_TIMENS_PAGE_OFFSET = 1,
> +#endif /* CONFIG_TIME_NS */
> +	VVAR_NR_PAGES = __VVAR_PAGES,
> +};
> +
>  struct __vdso_abi {
>  	const char *name;
>  	const char *vdso_code_start;
> @@ -81,6 +89,12 @@ static union {
>  } vdso_data_store __page_aligned_data;
>  struct vdso_data *vdso_data = vdso_data_store.data;
>  
> +
> +struct vdso_data *arch_get_vdso_data(void *vvar_page)
> +{
> +	return (struct vdso_data *)(vvar_page);
> +}
> +
>  static int __vdso_remap(enum arch_vdso_type arch_index,
>  			const struct vm_special_mapping *sm,
>  			struct vm_area_struct *new_vma)
> @@ -182,7 +196,7 @@ static int __setup_additional_pages(enum arch_vdso_type arch_index,
>  
>  	vdso_text_len = vdso_lookup[arch_index].vdso_pages << PAGE_SHIFT;
>  	/* Be sure to map the data page */
> -	vdso_mapping_len = vdso_text_len + PAGE_SIZE;
> +	vdso_mapping_len = vdso_text_len + VVAR_NR_PAGES * PAGE_SIZE;
>  
>  	vdso_base = get_unmapped_area(NULL, 0, vdso_mapping_len, 0, 0);
>  	if (IS_ERR_VALUE(vdso_base)) {
> @@ -190,13 +204,13 @@ static int __setup_additional_pages(enum arch_vdso_type arch_index,
>  		goto up_fail;
>  	}
>  
> -	ret = _install_special_mapping(mm, vdso_base, PAGE_SIZE,
> +	ret = _install_special_mapping(mm, vdso_base, VVAR_NR_PAGES * PAGE_SIZE,
>  				       VM_READ|VM_MAYREAD|VM_PFNMAP,
>  				       vdso_lookup[arch_index].dm);
>  	if (IS_ERR(ret))
>  		goto up_fail;
>  
> -	vdso_base += PAGE_SIZE;
> +	vdso_base += VVAR_NR_PAGES * PAGE_SIZE;
>  	mm->context.vdso = (void *)vdso_base;
>  	ret = _install_special_mapping(mm, vdso_base, vdso_text_len,
>  				       VM_READ|VM_EXEC|
> diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.lds.S
> index 7ad2d3a0cd48..d808ad31e01f 100644
> --- a/arch/arm64/kernel/vdso/vdso.lds.S
> +++ b/arch/arm64/kernel/vdso/vdso.lds.S
> @@ -17,7 +17,10 @@ OUTPUT_ARCH(aarch64)
>  
>  SECTIONS
>  {
> -	PROVIDE(_vdso_data = . - PAGE_SIZE);
> +	PROVIDE(_vdso_data = . - __VVAR_PAGES * PAGE_SIZE);
> +#ifdef CONFIG_TIME_NS
> +	PROVIDE(_timens_data = _vdso_data + PAGE_SIZE);
> +#endif
>  	. = VDSO_LBASE + SIZEOF_HEADERS;
>  
>  	.hash		: { *(.hash) }			:text
> diff --git a/arch/arm64/kernel/vdso32/vdso.lds.S b/arch/arm64/kernel/vdso32/vdso.lds.S
> index a3944927eaeb..06cc60a9630f 100644
> --- a/arch/arm64/kernel/vdso32/vdso.lds.S
> +++ b/arch/arm64/kernel/vdso32/vdso.lds.S
> @@ -17,7 +17,10 @@ OUTPUT_ARCH(arm)
>  
>  SECTIONS
>  {
> -	PROVIDE_HIDDEN(_vdso_data = . - PAGE_SIZE);
> +	PROVIDE_HIDDEN(_vdso_data = . - __VVAR_PAGES * PAGE_SIZE);
> +#ifdef CONFIG_TIME_NS
> +	PROVIDE_HIDDEN(_timens_data = _vdso_data + PAGE_SIZE);
> +#endif
>  	. = VDSO_LBASE + SIZEOF_HEADERS;
>  
>  	.hash		: { *(.hash) }			:text
> diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
> index 30c4cb0428d1..3494b5536b63 100644
> --- a/include/vdso/datapage.h
> +++ b/include/vdso/datapage.h
> @@ -98,6 +98,7 @@ struct vdso_data {
>   * relocation, and this is what we need.
>   */
>  extern struct vdso_data _vdso_data[CS_BASES] __attribute__((visibility("hidden")));
> +extern struct vdso_data _timens_data[CS_BASES] __attribute__((visibility("hidden")));
>  
>  #endif /* !__ASSEMBLY__ */
>  
> 

-- 
Regards,
Vincenzo
