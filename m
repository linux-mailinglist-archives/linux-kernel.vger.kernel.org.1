Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C1C26BE96
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 09:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgIPH5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 03:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgIPH5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 03:57:21 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96238C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 00:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=V5rgsQunze34f1mmmC20sIsp6ihTbAxSCHeNxKtByAc=; b=mmC9utrUhOjHLiFGW9Q3HCNuU
        MoynIKsEG78l2Qz6VhH8eDfVPozrQ2Wbf4gZ/aQ3Es4hq6LnHXmkJr2orbsvgLSramqolMN8OsZMg
        IRwFafQO7t8qi1tr1vmhJ9RmU6tQBHOuYIhsDCwNa1iCb4MC8WvZreWapoFIcGZ0ZBEekqtTsaJZN
        cko9ZKSkAo/ThxxTOK95oCGm940KZOAVVNAY+heIBHZ3Bw7S6TjiD/W5GBqRGBLJhYBnI5+oz0ZUB
        fHC72bOV/zAnD+JWlVg2o2Jz6WpXg8LBLXqauKRhWqwWLsxaWeS4jIo4bZDibkmmL7Zol2a7fCnYq
        5W3X73dvQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34302)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kISJT-00049O-QM; Wed, 16 Sep 2020 08:57:11 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kISJP-0004Y8-3t; Wed, 16 Sep 2020 08:57:07 +0100
Date:   Wed, 16 Sep 2020 08:57:07 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
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
Message-ID: <20200916075706.GQ1551@shell.armlinux.org.uk>
References: <20200915131615.3138-1-thunder.leizhen@huawei.com>
 <20200915131615.3138-3-thunder.leizhen@huawei.com>
 <20200915190143.GP1551@shell.armlinux.org.uk>
 <2d12f7da-aef4-85dc-0ba6-a06fb5eab59c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d12f7da-aef4-85dc-0ba6-a06fb5eab59c@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 09:57:15AM +0800, Leizhen (ThunderTown) wrote:
> On 2020/9/16 3:01, Russell King - ARM Linux admin wrote:
> > On Tue, Sep 15, 2020 at 09:16:15PM +0800, Zhen Lei wrote:
> >> Currently, only support the kernels where the base of physical memory is
> >> at a 16MiB boundary. Because the add/sub instructions only contains 8bits
> >> unrotated value. But we can use one more "add/sub" instructions to handle
> >> bits 23-16. The performance will be slightly affected.
> >>
> >> Since most boards meet 16 MiB alignment, so add a new configuration
> >> option ARM_PATCH_PHYS_VIRT_RADICAL (default n) to control it. Say Y if
> >> anyone really needs it.
> >>
> >> All r0-r7 (r1 = machine no, r2 = atags or dtb, in the start-up phase) are
> >> used in __fixup_a_pv_table() now, but the callee saved r11 is not used in
> >> the whole head.S file. So choose it.
> >>
> >> Because the calculation of "y = x + __pv_offset[63:24]" have been done,
> >> so we only need to calculate "y = y + __pv_offset[23:16]", that's why
> >> the parameters "to" and "from" of __pv_stub() and __pv_add_carry_stub()
> >> in the scope of CONFIG_ARM_PATCH_PHYS_VIRT_RADICAL are all passed "t"
> >> (above y).
> >>
> >> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >> ---
> >>  arch/arm/Kconfig              | 18 +++++++++++++++++-
> >>  arch/arm/include/asm/memory.h | 16 +++++++++++++---
> >>  arch/arm/kernel/head.S        | 25 +++++++++++++++++++------
> >>  3 files changed, 49 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> >> index e00d94b16658765..19fc2c746e2ce29 100644
> >> --- a/arch/arm/Kconfig
> >> +++ b/arch/arm/Kconfig
> >> @@ -240,12 +240,28 @@ config ARM_PATCH_PHYS_VIRT
> >>  	  kernel in system memory.
> >>  
> >>  	  This can only be used with non-XIP MMU kernels where the base
> >> -	  of physical memory is at a 16MB boundary.
> >> +	  of physical memory is at a 16MiB boundary.
> >>  
> >>  	  Only disable this option if you know that you do not require
> >>  	  this feature (eg, building a kernel for a single machine) and
> >>  	  you need to shrink the kernel to the minimal size.
> >>  
> >> +config ARM_PATCH_PHYS_VIRT_RADICAL
> >> +	bool "Support PHYS_OFFSET minimum aligned at 64KiB boundary"
> >> +	default n
> > 
> > Please drop the "default n" - this is the default anyway.
> 
> OK, I will remove it.
> 
> > 
> >> @@ -236,6 +243,9 @@ static inline unsigned long __phys_to_virt(phys_addr_t x)
> >>  	 * in place where 'r' 32 bit operand is expected.
> >>  	 */
> >>  	__pv_stub((unsigned long) x, t, "sub", __PV_BITS_31_24);
> >> +#ifdef CONFIG_ARM_PATCH_PHYS_VIRT_RADICAL
> >> +	__pv_stub((unsigned long) t, t, "sub", __PV_BITS_23_16);
> > 
> > t is already unsigned long, so this cast is not necessary.
> 
> Oh, yes, yes, I copied from the above statement, but forgot to remove it.
> 
> > 
> > I've been debating whether it would be better to use "movw" for this
> > for ARMv7.  In other words:
> > 
> > 	movw	tmp, #16-bit
> > 	adds	%Q0, %1, tmp, lsl #16
> > 	adc	%R0, %R0, #0
> > 
> > It would certainly be less instructions, but at the cost of an
> > additional register - and we'd have to change the fixup code to
> > know about movw.
> 
> It's one less instruction for 64KiB boundary && (sizeof(phys_addr_t) == 8),
> and no increase or decrease for 64KiB boundary && (sizeof(phys_addr_t) == 4),
> but one more instruction for 16MiB boundary.
> 
> And maybe: 16MiB is widely used, but 64KiB is rarely used.
> 
> So I'm inclined to the current revision.

Multiplatform kernels (which will be what distros build) will have to
enable this option if they wish to support this platform. So, in that
case it doesn't just impacting a single platform, but all platforms.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
