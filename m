Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C60B2A1545
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 11:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgJaKdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 06:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbgJaKdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 06:33:19 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B059C0613D5
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 03:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fSXmY2Ss+l9g5L0iEkoM73p34L1tYPcYKQlrcN3O+uE=; b=fHvd2F1HGg7M1aKb7QJABolAl
        VT+lC8juhxkL3YA66tx6m69hl/C5vcQAScUVAG9p6a4kaNxZxhDj1lYLPH/DmSjaOdh7aFgUmA8Hc
        dYCRAm2CGpGzIdJ8CcuRc+j/CmR7To5GqDTuG1NdcBRwj1Wh8ELiN+ypwrf+MESTAPyD4KJbQK+ej
        P6VArMxszoA+z3IYme+UfqmTHAnmmpDHzzX4aMQ6fOTMwxsyi2tmfIAtQMKsf+7+VqAHS138GuEgT
        dWbL6J1UYmP1ddetBtrnn+s82OLxzBDPzGyZyaV0cx0BFU08EXHOdq3zLbvLeA7UKudjiaXUAZu67
        iGj6JGjxQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53274)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kYoC9-00074m-HL; Sat, 31 Oct 2020 10:33:13 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kYoC8-00087d-EK; Sat, 31 Oct 2020 10:33:12 +0000
Date:   Sat, 31 Oct 2020 10:33:12 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-xtensa@linux-xtensa.org, Ard Biesheuvel <ardb@kernel.org>,
        Chris Zankel <chris@zankel.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM, xtensa: highmem: avoid clobbering non-page aligned
 memory reservations
Message-ID: <20201031103312.GI1551@shell.armlinux.org.uk>
References: <20201031094345.6984-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031094345.6984-1-rppt@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 31, 2020 at 11:43:45AM +0200, Mike Rapoport wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> free_highpages() iterates over the free memblock regions in high
> memory, and marks each page as available for the memory management
> system.
> 
> Until commit cddb5ddf2b76 ("arm, xtensa: simplify initialization of
> high memory pages") it rounded beginning of each region upwards and end of
> each region downwards.
> 
> However, after that commit free_highmem() rounds the beginning and end of
> each region downwards, and we may end up freeing a page that is
> memblock_reserve()d, resulting in memory corruption.
> 
> Restore the original rounding of the region boundaries to avoid freeing
> reserved pages.
> 
> Fixes: cddb5ddf2b76 ("arm, xtensa: simplify initialization of high memory pages")
> Link: https://lore.kernel.org/r/20201029110334.4118-1-ardb@kernel.org/
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> Co-developed-by:  Mike Rapoport <rppt@linux.ibm.com>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
> 
> Max, Russell,
> 
> Please let me know how do you prefer to take it upstream.
> If needed this can go via memblock tree.
> 
> v2: fix words order in the commit message

I really don't understand what is going on here; there seems to be a
total disconnect of communication between yourself and Ard. Ard has
already submitted a different patch for this to the patch system
already, sent yesterday.

https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=9021/1

Please discuss between yourselves how you want to solve the problem,
and then submit an agreed and tested patch to those of us upstream;
please don't make it for those upstream to pick one of your patches
as you are at present.

Thanks.

> 
>  arch/arm/mm/init.c    | 4 ++--
>  arch/xtensa/mm/init.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index d57112a276f5..c23dbf8bebee 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -354,8 +354,8 @@ static void __init free_highpages(void)
>  	/* set highmem page free */
>  	for_each_free_mem_range(i, NUMA_NO_NODE, MEMBLOCK_NONE,
>  				&range_start, &range_end, NULL) {
> -		unsigned long start = PHYS_PFN(range_start);
> -		unsigned long end = PHYS_PFN(range_end);
> +		unsigned long start = PFN_UP(range_start);
> +		unsigned long end = PFN_DOWN(range_end);
>  
>  		/* Ignore complete lowmem entries */
>  		if (end <= max_low)
> diff --git a/arch/xtensa/mm/init.c b/arch/xtensa/mm/init.c
> index c6fc83efee0c..8731b7ad9308 100644
> --- a/arch/xtensa/mm/init.c
> +++ b/arch/xtensa/mm/init.c
> @@ -89,8 +89,8 @@ static void __init free_highpages(void)
>  	/* set highmem page free */
>  	for_each_free_mem_range(i, NUMA_NO_NODE, MEMBLOCK_NONE,
>  				&range_start, &range_end, NULL) {
> -		unsigned long start = PHYS_PFN(range_start);
> -		unsigned long end = PHYS_PFN(range_end);
> +		unsigned long start = PFN_UP(range_start);
> +		unsigned long end = PFN_DOWN(range_end);
>  
>  		/* Ignore complete lowmem entries */
>  		if (end <= max_low)
> -- 
> 2.28.0
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
