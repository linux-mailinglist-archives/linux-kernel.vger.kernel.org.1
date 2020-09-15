Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D3B26ACFF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 21:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgIOTHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 15:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbgIOTCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 15:02:08 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2915EC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 12:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ymmqREas2LZJIgQhq9lsWOfXEb7yQiOblzgzUXrW0zM=; b=UPjsyl8sYOkuRo7V/icxtflz7
        YSjurEUPYpKBYagt8EVd1JUCFsLfYKOSdysJ1a6Ald5dc8tT3MEPXDQJLYaTNxZbj2ZR/UN5mphuV
        HQcPhb6qj2nImRy8M5GUFVKtTjNim/cNZ7xADOmDwpfjZFN2JuPUUD17rP6ILWWCuQKCmIMBsEw42
        fwMoZ19EMiB+FCS4cz5tXZR+TBzGcNiwhF3WsTpxS8qdqd9zHZoj8mhRZmS8Obq087gJrpdvGcq+n
        KFFp16EikoGh0OZRkkdcWFgZ5A8n+Sf1d2GwjqYLM8QrPqDo8kI/DZNfGQ0zVjt9LE3YlJDPuLyxL
        NB83Df8Aw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34076)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kIGD4-0003Q9-IK; Tue, 15 Sep 2020 20:01:46 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kIGD1-0003vm-Re; Tue, 15 Sep 2020 20:01:43 +0100
Date:   Tue, 15 Sep 2020 20:01:43 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        patches-armlinux <patches@armlinux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jianguo Chen <chenjianguo3@huawei.com>
Subject: Re: [PATCH v2 2/2] ARM: support PHYS_OFFSET minimum aligned at 64KiB
 boundary
Message-ID: <20200915190143.GP1551@shell.armlinux.org.uk>
References: <20200915131615.3138-1-thunder.leizhen@huawei.com>
 <20200915131615.3138-3-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915131615.3138-3-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 09:16:15PM +0800, Zhen Lei wrote:
> Currently, only support the kernels where the base of physical memory is
> at a 16MiB boundary. Because the add/sub instructions only contains 8bits
> unrotated value. But we can use one more "add/sub" instructions to handle
> bits 23-16. The performance will be slightly affected.
> 
> Since most boards meet 16 MiB alignment, so add a new configuration
> option ARM_PATCH_PHYS_VIRT_RADICAL (default n) to control it. Say Y if
> anyone really needs it.
> 
> All r0-r7 (r1 = machine no, r2 = atags or dtb, in the start-up phase) are
> used in __fixup_a_pv_table() now, but the callee saved r11 is not used in
> the whole head.S file. So choose it.
> 
> Because the calculation of "y = x + __pv_offset[63:24]" have been done,
> so we only need to calculate "y = y + __pv_offset[23:16]", that's why
> the parameters "to" and "from" of __pv_stub() and __pv_add_carry_stub()
> in the scope of CONFIG_ARM_PATCH_PHYS_VIRT_RADICAL are all passed "t"
> (above y).
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  arch/arm/Kconfig              | 18 +++++++++++++++++-
>  arch/arm/include/asm/memory.h | 16 +++++++++++++---
>  arch/arm/kernel/head.S        | 25 +++++++++++++++++++------
>  3 files changed, 49 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index e00d94b16658765..19fc2c746e2ce29 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -240,12 +240,28 @@ config ARM_PATCH_PHYS_VIRT
>  	  kernel in system memory.
>  
>  	  This can only be used with non-XIP MMU kernels where the base
> -	  of physical memory is at a 16MB boundary.
> +	  of physical memory is at a 16MiB boundary.
>  
>  	  Only disable this option if you know that you do not require
>  	  this feature (eg, building a kernel for a single machine) and
>  	  you need to shrink the kernel to the minimal size.
>  
> +config ARM_PATCH_PHYS_VIRT_RADICAL
> +	bool "Support PHYS_OFFSET minimum aligned at 64KiB boundary"
> +	default n

Please drop the "default n" - this is the default anyway.

> @@ -236,6 +243,9 @@ static inline unsigned long __phys_to_virt(phys_addr_t x)
>  	 * in place where 'r' 32 bit operand is expected.
>  	 */
>  	__pv_stub((unsigned long) x, t, "sub", __PV_BITS_31_24);
> +#ifdef CONFIG_ARM_PATCH_PHYS_VIRT_RADICAL
> +	__pv_stub((unsigned long) t, t, "sub", __PV_BITS_23_16);

t is already unsigned long, so this cast is not necessary.

I've been debating whether it would be better to use "movw" for this
for ARMv7.  In other words:

	movw	tmp, #16-bit
	adds	%Q0, %1, tmp, lsl #16
	adc	%R0, %R0, #0

It would certainly be less instructions, but at the cost of an
additional register - and we'd have to change the fixup code to
know about movw.

Thoughts?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
