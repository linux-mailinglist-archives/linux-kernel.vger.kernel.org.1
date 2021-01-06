Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39E842EB9E2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 07:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbhAFGLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 01:11:55 -0500
Received: from foss.arm.com ([217.140.110.172]:35978 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbhAFGLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 01:11:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8C4E31B;
        Tue,  5 Jan 2021 22:11:08 -0800 (PST)
Received: from [10.163.87.111] (unknown [10.163.87.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 614FE3F70D;
        Tue,  5 Jan 2021 22:11:07 -0800 (PST)
Subject: Re: [PATCH 1/1] arm64: make section size configurable for memory
 hotplug
To:     Sudarshan Rajagopalan <sudaraja@codeaurora.org>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1609895500.git.sudaraja@codeaurora.org>
 <66f79b0c06602c22df4da8ff4a5c2b97c9275250.1609895500.git.sudaraja@codeaurora.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <055b0aca-af60-12ad-cd68-e15440ade64b@arm.com>
Date:   Wed, 6 Jan 2021 11:41:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <66f79b0c06602c22df4da8ff4a5c2b97c9275250.1609895500.git.sudaraja@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudershan,

This patch (and the cover letter) does not copy LAKML even though the
entire change here is arm64 specific. Please do copy all applicable
mailing lists for a given patch.

On 1/6/21 6:58 AM, Sudarshan Rajagopalan wrote:
> Currently on arm64, memory section size is hard-coded to 1GB.
> Make this configurable if memory-hotplug is enabled, to support
> more finer granularity for hotplug-able memory.

Section size has always been decided by the platform. It cannot be a
configurable option because the user would not know the constraints
for memory representation on the platform and besides it also cannot
be trusted.

> 
> Signed-off-by: Sudarshan Rajagopalan <sudaraja@codeaurora.org>
> ---
>  arch/arm64/Kconfig                 | 11 +++++++++++
>  arch/arm64/include/asm/sparsemem.h |  4 ++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 6d232837cbee..34124eee65da 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -294,6 +294,17 @@ config ARCH_ENABLE_MEMORY_HOTREMOVE
>  config SMP
>  	def_bool y
>  
> +config HOTPLUG_SIZE_BITS
> +	int "Memory hotplug block size(29 => 512MB 30 => 1GB)"
> +	depends on SPARSEMEM
> +	depends on MEMORY_HOTPLUG
> +	range 28 30

28 would not work for 64K pages.

> +	default 30
> +	help
> +	 Selects granularity of hotplug memory. Block size for
> +	 memory hotplug is represent as a power of 2.
> +	 If unsure, stick with default value.
> +
>  config KERNEL_MODE_NEON
>  	def_bool y
>  
> diff --git a/arch/arm64/include/asm/sparsemem.h b/arch/arm64/include/asm/sparsemem.h
> index 1f43fcc79738..3d5310f3aad5 100644
> --- a/arch/arm64/include/asm/sparsemem.h
> +++ b/arch/arm64/include/asm/sparsemem.h
> @@ -7,7 +7,11 @@
>  
>  #ifdef CONFIG_SPARSEMEM
>  #define MAX_PHYSMEM_BITS	CONFIG_ARM64_PA_BITS
> +#ifndef CONFIG_MEMORY_HOTPLUG
>  #define SECTION_SIZE_BITS	30
> +#else
> +#define SECTION_SIZE_BITS	CONFIG_HOTPLUG_SIZE_BITS
> +#endif
>  #endif
>  
>  #endif
> 

There was an inconclusive discussion regarding this last month.

https://lore.kernel.org/linux-arm-kernel/20201204014443.43329-1-liwei213@huawei.com/

I have been wondering if this would solve the problem for 4K page size
config which requires PMD mapping for the vmemmap mapping while making
section size bits dependent on max order. But this has not been tested
properly.

diff --git a/arch/arm64/include/asm/sparsemem.h b/arch/arm64/include/asm/sparsemem.h
index 1f43fcc79738..fe4353cb1dce 100644
--- a/arch/arm64/include/asm/sparsemem.h
+++ b/arch/arm64/include/asm/sparsemem.h
@@ -7,7 +7,18 @@
 
 #ifdef CONFIG_SPARSEMEM
 #define MAX_PHYSMEM_BITS       CONFIG_ARM64_PA_BITS
-#define SECTION_SIZE_BITS      30
-#endif
+
+#ifdef CONFIG_ARM64_4K_PAGES
+#define SECTION_SIZE_BITS 27
+#else
+#ifdef CONFIG_FORCE_MAX_ZONEORDER
+#define SECTION_SIZE_BITS (CONFIG_FORCE_MAX_ZONEORDER - 1 + PAGE_SHIFT)
+#else
+#define SECTION_SIZE_BITS 30
+#endif /* CONFIG_FORCE_MAX_ZONEORDER */
+
+#endif /* CONFIG_ARM64_4K_PAGES */
+
+#endif /* CONFIG_SPARSEMEM*/
 
 #endif
