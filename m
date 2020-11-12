Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E142B00A4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 08:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgKLH60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 02:58:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:43998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbgKLH6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 02:58:24 -0500
Received: from kernel.org (unknown [77.125.7.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8D8620709;
        Thu, 12 Nov 2020 07:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605167903;
        bh=geex83WHWE8HBNVfk7Eod1F5QhIUgKE/LhhHyh/o4i8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i2EJa2G8SqC1E/irAV/jdjoRlBIoPjZ3rCQmrGZhmndxjS6XM5xe7wslTrO4UeTRw
         322RVDuVg03A/JiZBtEOeJDNSdM9/gz0+CP9MERsl9TMatk1dzCG8N3aqtKhB3KIqy
         ItglbMK3ggzGHAbF7WoSZJns7Vh/JODHcZL+o8p0=
Date:   Thu, 12 Nov 2020 09:58:10 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dyoung@redhat.com,
        bhe@redhat.com, catalin.marinas@arm.com, will@kernel.org,
        corbet@lwn.net, John.P.donnelly@oracle.com, bhsharma@redhat.com,
        prabhakar.pkin@gmail.com, horms@verge.net.au, robh+dt@kernel.org,
        arnd@arndb.de, nsaenzjulienne@suse.de, james.morse@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        xiexiuqi@huawei.com, guohanjun@huawei.com, huawei.libin@huawei.com,
        wangkefeng.wang@huawei.com
Subject: Re: [PATCH v13 1/8] x86: kdump: replace the hard-coded alignment
 with macro CRASH_ALIGN
Message-ID: <20201112075810.GJ4758@kernel.org>
References: <20201031074437.168008-1-chenzhou10@huawei.com>
 <20201031074437.168008-2-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031074437.168008-2-chenzhou10@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Oct 31, 2020 at 03:44:30PM +0800, Chen Zhou wrote:
> Move CRASH_ALIGN to header asm/kexec.h and replace the hard-coded
> alignment with macro CRASH_ALIGN in function reserve_crashkernel().
> 
> Suggested-by: Dave Young <dyoung@redhat.com>
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> Tested-by: John Donnelly <John.p.donnelly@oracle.com>
> ---
>  arch/x86/include/asm/kexec.h | 3 +++
>  arch/x86/kernel/setup.c      | 5 +----
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
> index 6802c59e8252..8cf9d3fd31c7 100644
> --- a/arch/x86/include/asm/kexec.h
> +++ b/arch/x86/include/asm/kexec.h
> @@ -18,6 +18,9 @@
>  
>  # define KEXEC_CONTROL_CODE_MAX_SIZE	2048
>  
> +/* 2M alignment for crash kernel regions */
> +#define CRASH_ALIGN		SZ_16M

Please update the comment to match the code.

> +
>  #ifndef __ASSEMBLY__
>  
>  #include <linux/string.h>
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 84f581c91db4..bf373422dc8a 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -395,9 +395,6 @@ static void __init memblock_x86_reserve_range_setup_data(void)
>  
>  #ifdef CONFIG_KEXEC_CORE
>  
> -/* 16M alignment for crash kernel regions */
> -#define CRASH_ALIGN		SZ_16M
> -
>  /*
>   * Keep the crash kernel below this limit.
>   *
> @@ -515,7 +512,7 @@ static void __init reserve_crashkernel(void)
>  	} else {
>  		unsigned long long start;
>  
> -		start = memblock_phys_alloc_range(crash_size, SZ_1M, crash_base,
> +		start = memblock_phys_alloc_range(crash_size, CRASH_ALIGN, crash_base,
>  						  crash_base + crash_size);
>  		if (start != crash_base) {
>  			pr_info("crashkernel reservation failed - memory is in use.\n");
> -- 
> 2.20.1
> 

-- 
Sincerely yours,
Mike.
