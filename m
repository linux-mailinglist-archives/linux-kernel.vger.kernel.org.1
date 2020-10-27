Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3594429A772
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 10:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895469AbgJ0JMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 05:12:03 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:47452 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2895460AbgJ0JMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TMkLt/rNxFdEdQi472ZNTOiyxBW2w+d4MoB+yvd1Sv8=; b=ypPh/8sH8HxnftbwLqnSudRB9
        hbcn0SoKDBZxB9veMP/HJXTXjOmqiG9zF8HL4xUjBQHFAEkOGKz8Bzpkgg9haW5afxHU8DrfFYKIf
        yzl5YmrqIOS5bQ1vwvFTUV2AgoMswpxJIibdn+HGIQ29qIpenHzLjHMizJ8sf6+ImKe3A52LKlBjb
        Zb/5pE6vAE8nPynFK3zBCQj40+aThX2+zH+2VaF//B6pXgKUU5bX2fRiEvbv6RYG60WxyhapQQTm/
        K/Pp8dzz9TGwxk+WsfLo2MCJ8EkbCvMPeIu8dTxBX1cWyzEpvhEyzPmOw+w4wNcpZj8jbkT4sicWf
        3CTT2a2Bw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51558)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kXL1G-0000eI-Q1; Tue, 27 Oct 2020 09:11:54 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kXL1D-0003tx-Af; Tue, 27 Oct 2020 09:11:51 +0000
Date:   Tue, 27 Oct 2020 09:11:51 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Minchan Kim <minchan@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        Will Deacon <will.deacon@arm.com>,
        Steve Capper <steve.capper@linaro.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v2 3/4] arm: mm: introduce L_PTE_SPECIAL
Message-ID: <20201027091151.GK1551@shell.armlinux.org.uk>
References: <20201023091437.8225-1-miles.chen@mediatek.com>
 <20201023091437.8225-4-miles.chen@mediatek.com>
 <20201023100810.GY1551@shell.armlinux.org.uk>
 <1603784712.12492.5.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603784712.12492.5.camel@mtkswgap22>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 03:45:12PM +0800, Miles Chen wrote:
> On Fri, 2020-10-23 at 11:08 +0100, Russell King - ARM Linux admin wrote:
> > On Fri, Oct 23, 2020 at 05:14:36PM +0800, Miles Chen wrote:
> > > From: Minchan Kim <minchan@kernel.org>
> > > 
> > > This patch introduces L_PTE_SPECIAL and pte functions for supporting
> > > get_user_pages_fast.
> > > 
> > > Cc: Russell King <linux@armlinux.org.uk>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Will Deacon <will.deacon@arm.com>
> > > Cc: Steve Capper <steve.capper@linaro.org>
> > > Cc: Minchan Kim <minchan@kernel.org>
> > > Cc: Suren Baghdasaryan <surenb@google.com>
> > > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > > Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> > > ---
> > >  arch/arm/Kconfig                      |  4 ++--
> > >  arch/arm/include/asm/pgtable-2level.h |  1 +
> > >  arch/arm/include/asm/pgtable-3level.h |  6 ------
> > >  arch/arm/include/asm/pgtable.h        | 13 +++++++++++++
> > >  4 files changed, 16 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > > index c18fa9d382b7..1f75864b7c7a 100644
> > > --- a/arch/arm/Kconfig
> > > +++ b/arch/arm/Kconfig
> > > @@ -13,7 +13,7 @@ config ARM
> > >  	select ARCH_HAS_KCOV
> > >  	select ARCH_HAS_MEMBARRIER_SYNC_CORE
> > >  	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
> > > -	select ARCH_HAS_PTE_SPECIAL if ARM_LPAE
> > > +	select ARCH_HAS_PTE_SPECIAL if (ARM_LPAE || CPU_V7 || CPU_V6 || CPUV6K)
> > >  	select ARCH_HAS_PHYS_TO_DMA
> > >  	select ARCH_HAS_SETUP_DMA_OPS
> > >  	select ARCH_HAS_SET_MEMORY
> > > @@ -82,7 +82,7 @@ config ARM
> > >  	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
> > >  	select HAVE_EFFICIENT_UNALIGNED_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7) && MMU
> > >  	select HAVE_EXIT_THREAD
> > > -	select HAVE_FAST_GUP if ARM_LPAE
> > > +	select HAVE_FAST_GUP if (ARM_LPAE || CPU_V7 || CPU_V6 || CPUV6K)
> > >  	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
> > >  	select HAVE_FUNCTION_GRAPH_TRACER if !THUMB2_KERNEL && !CC_IS_CLANG
> > >  	select HAVE_FUNCTION_TRACER if !XIP_KERNEL
> > > diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
> > > index cdcd55cca37d..385e7a32394e 100644
> > > --- a/arch/arm/include/asm/pgtable-2level.h
> > > +++ b/arch/arm/include/asm/pgtable-2level.h
> > > @@ -117,6 +117,7 @@
> > >  #define L_PTE_VALID		(_AT(pteval_t, 1) << 0)		/* Valid */
> > >  #define L_PTE_PRESENT		(_AT(pteval_t, 1) << 0)
> > >  #define L_PTE_YOUNG		(_AT(pteval_t, 1) << 1)
> > > +#define L_PTE_SPECIAL		(_AT(pteval_t, 1) << 5)
> > 
> > How does this work?  Bits 2 through 5 are already in use for the memory
> > type.
> > 
> > Repurposing this bit means that L_PTE_MT_DEV_NONSHARED,
> > L_PTE_MT_DEV_WC, L_PTE_MT_DEV_CACHED and L_PTE_MT_VECTORS clash with
> > it.
> 
> Thanks for the comment.
> The idea is to re-order the memory type table in [1] (patch v2/4) and
> use bit 5 for L_PTE_SPECIAL.

Thanks, I know what you are trying to achieve. I don't think it's
possible without breaking the kernel on some CPUs and configurations.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
