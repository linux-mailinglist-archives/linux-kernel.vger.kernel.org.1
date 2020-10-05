Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81C3A283D12
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 19:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgJERM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 13:12:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:41002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgJERM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 13:12:58 -0400
Received: from gaia (unknown [95.149.105.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A099B207EA;
        Mon,  5 Oct 2020 17:12:52 +0000 (UTC)
Date:   Mon, 5 Oct 2020 18:12:49 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     will@kernel.org, james.morse@arm.com, tglx@linutronix.de,
        mingo@redhat.com, dyoung@redhat.com, bhe@redhat.com,
        corbet@lwn.net, John.P.donnelly@oracle.com,
        prabhakar.pkin@gmail.com, bhsharma@redhat.com, horms@verge.net.au,
        robh+dt@kernel.org, arnd@arndb.de, nsaenzjulienne@suse.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        guohanjun@huawei.com, xiexiuqi@huawei.com, huawei.libin@huawei.com,
        wangkefeng.wang@huawei.com
Subject: Re: [PATCH v12 7/9] kdump: add threshold for the required memory
Message-ID: <20201005171248.GB14576@gaia>
References: <20200907134745.25732-1-chenzhou10@huawei.com>
 <20200907134745.25732-8-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907134745.25732-8-chenzhou10@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 09:47:43PM +0800, Chen Zhou wrote:
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 3f735cb37ace..d11d597a470d 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -378,6 +378,15 @@ int __init reserve_crashkernel_low(void)
>  }
>  
>  #if defined(CONFIG_X86) || defined(CONFIG_ARM64)
> +
> +/*
> + * Add a threshold for required memory size of crashkernel. If required memory
> + * size is greater than threshold, just go for high allocation directly. The
> + * value of threshold is set as half of the total low memory.
> + */
> +#define REQUIRED_MEMORY_THRESHOLD	(memblock_mem_size(CRASH_ADDR_LOW_MAX >> \
> +			PAGE_SHIFT) >> 1)
> +
>  #ifdef CONFIG_KEXEC_CORE
>  /*
>   * reserve_crashkernel() - reserves memory for crash kernel
> @@ -422,7 +431,7 @@ void __init reserve_crashkernel(void)
>  		 * So try low memory first and fall back to high memory
>  		 * unless "crashkernel=size[KMG],high" is specified.
>  		 */
> -		if (!high)
> +		if (!high && crash_size <= REQUIRED_MEMORY_THRESHOLD)
>  			crash_base = memblock_find_in_range(CRASH_ALIGN,
>  						CRASH_ADDR_LOW_MAX,
>  						crash_size, CRASH_ALIGN);

Since any change now is affecting the x86 semantics slightly, I'd
suggest you drop this patch. We can add it later if needed, once the
core changes are in.

Thinking about this, if one requires a crashkernel reservation that
allocates all of the ZONE_DMA, it would probably be noticed and explicit
,high/,low options can be used.

Note that we are also trying to make ZONE_DMA full 32-bit on non-RPi4
hardware.

-- 
Catalin
