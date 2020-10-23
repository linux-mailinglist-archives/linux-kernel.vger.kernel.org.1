Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD5E296C9A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 12:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462009AbgJWKQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 06:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461961AbgJWKQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 06:16:48 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961FEC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 03:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=u6Dt4eNB9uo93oxRYc8MfzJ3qNz/BQ4UPg0GgCDWsm0=; b=0r39HtvR8ZB+QTz2zzG67pEFd
        dFAPK/XpPLUpDvn3JFW1gqHAObbTmkOYOSlWOJHlgFnqP+pdyzzMJnSbr9aZ2s6A+Ukos/9KujyD/
        PnGRbPAJPY5gyQDZsCUSj10NZiao/46Ds9xMTZOg5CT9DoYqcfKK1dWIW1B2tixzzvJSQ5Gk8nMSH
        3h8kDACleJFEKadbOzI6JjqUkfk1TQyVARDGf+GzUt2Fw/YYTWcGJ1R6VaM97OdKUqa1weh/gAYOg
        L5E+nAHf6QR6j9c1bvRNJICXPsross/qxHCmiwz7Qpy/mJI01cYIczQTMkkMzwoFp0Eia2Hy1UTYM
        EbjZidWFg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49924)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kVu7m-0003Hh-PE; Fri, 23 Oct 2020 11:16:42 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kVu7k-0008MT-R3; Fri, 23 Oct 2020 11:16:40 +0100
Date:   Fri, 23 Oct 2020 11:16:40 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Minchan Kim <minchan@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        Will Deacon <will.deacon@arm.com>,
        Steve Capper <steve.capper@linaro.org>,
        Simon Horman <horms@verge.net.au>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v2 2/4] arm: mm: reordering memory type table
Message-ID: <20201023101640.GA1551@shell.armlinux.org.uk>
References: <20201023091437.8225-1-miles.chen@mediatek.com>
 <20201023091437.8225-3-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023091437.8225-3-miles.chen@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 05:14:35PM +0800, Miles Chen wrote:
> From: Minchan Kim <minchan@kernel.org>
> 
> To use bit 5 in page table as L_PTE_SPECIAL, we need a room for that.
> It seems we don't need 4 bits for the memory type with ARMv6+.
> If it's true, let's reorder bits to make bit 5 free.
> 
> We will use the bit for L_PTE_SPECIAL in next patch.
> 
> A note from Catalin in [1]:
> "
> > Anyway, on ARMv7 or ARMv6+LPAE, the non-shared device gets mapped to
> > shared device in hardware. Looking through the arm32 code, it seems that
> > MT_DEVICE_NONSHARED is used by arch/arm/mach-shmobile/setup-r8a7779.c
> > and IIUC that's a v7 platform (R-Car H1, Cortex-A9). I think the above
> > should be defined to L_PTE_MT_DEV_SHARED, unless I miss any place where
> > DEV_NONSHARED is relevant on ARMv6 (adding Simon to confirm on shmbile).
> "
> 
> [1] https://lore.kernel.org/patchwork/patch/986574/
> 
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Steve Capper <steve.capper@linaro.org>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> ---
>  arch/arm/include/asm/pgtable-2level.h | 21 +++++++++++++++++----
>  arch/arm/mm/proc-macros.S             |  4 ++--
>  2 files changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
> index 27a8635abea0..cdcd55cca37d 100644
> --- a/arch/arm/include/asm/pgtable-2level.h
> +++ b/arch/arm/include/asm/pgtable-2level.h
> @@ -161,14 +161,27 @@
>  #define L_PTE_MT_BUFFERABLE	(_AT(pteval_t, 0x01) << 2)	/* 0001 */
>  #define L_PTE_MT_WRITETHROUGH	(_AT(pteval_t, 0x02) << 2)	/* 0010 */
>  #define L_PTE_MT_WRITEBACK	(_AT(pteval_t, 0x03) << 2)	/* 0011 */
> +#define L_PTE_MT_DEV_SHARED	(_AT(pteval_t, 0x04) << 2)	/* 0100 */
> +#define L_PTE_MT_VECTORS	(_AT(pteval_t, 0x05) << 2)	/* 0101 */
>  #define L_PTE_MT_MINICACHE	(_AT(pteval_t, 0x06) << 2)	/* 0110 (sa1100, xscale) */
>  #define L_PTE_MT_WRITEALLOC	(_AT(pteval_t, 0x07) << 2)	/* 0111 */
> -#define L_PTE_MT_DEV_SHARED	(_AT(pteval_t, 0x04) << 2)	/* 0100 */
> -#define L_PTE_MT_DEV_NONSHARED	(_AT(pteval_t, 0x0c) << 2)	/* 1100 */

Sorry, no, this isn't going to work.

The lower two bits of this (bits 2 and 3) are explicitly designed to fit
the C and B bits used in older architectures. Changing L_PTE_MT_VECTORS
from having value '11' to '01' changes the functionality on older CPUs.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
