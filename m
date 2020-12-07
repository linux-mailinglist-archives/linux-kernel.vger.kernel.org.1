Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E1A2D1C8A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 22:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbgLGV6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 16:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbgLGV6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 16:58:50 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB3CC061793
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 13:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=veOf+01MBlQBPE69nvGu5M4F4VHbf0u+DtmSctPbaqc=; b=NlpvIDeBmYynJdihFjDPZ+ZcVL
        ci2p/roynTXJlMgF5AxXW0NAf4lPN/XoDyvWTtsHY9CGkRcM4M3RoMwd+3dRyB/mKcrDH4K7XF/Mk
        Go3zcdNsFyXAwiVJJ8LG4b5HPUT3Fr+Vh2Klv1cDDRQN+R3/L/ki/RaYXO8IbTbo9pUI58uE0Hsi5
        bonIP+K/uzyyoKTGIJteuSddpFDhNZ+toRoEB07dIQyV5IDimACbKf1iuK0v/v4VcLxu/PSDxjcfC
        7cxCwICzhVEDuom1bO7xWFHUeBdrHyvY7WIKUoR1r7dj9YVJ0v7X+f3A5QZPneevBk81zUJ6mbbP9
        nsj0bl8g==;
Received: from [2601:1c0:6280:3f0::1494]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmOW7-0000ow-9A; Mon, 07 Dec 2020 21:57:59 +0000
Subject: Re: [PATCH] arch: x86: make video init optional (expert)
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com
References: <20201207212033.2736-1-info@metux.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0d4f7c6a-0f66-9031-556b-1e5d51e52edb@infradead.org>
Date:   Mon, 7 Dec 2020 13:57:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201207212033.2736-1-info@metux.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/20 1:20 PM, Enrico Weigelt, metux IT consult wrote:
> As x86 is becoming more widespread in embedded devices, that don't have
> any video adapter at all, make it possible to opt out from video init on
> bootup (expert option). Also useful for minimized paravirtualized kernels.
> 
> Most users wanna leave this enabled and shouldn't touch it, thus defaulting

             want to

> to y and hiding behind CONFIG_EXPERT.
> 
> Signed-off-by: Enrico Weigelt <info@metux.net>
> ---
>  arch/x86/Kconfig       |  7 +++++++
>  arch/x86/boot/Makefile | 10 +++++-----
>  arch/x86/boot/main.c   |  2 ++
>  3 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index fbf26e0f7a6a..43b4b2cca2b0 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -913,6 +913,13 @@ config DMI
>  	  affected by entries in the DMI blacklist. Required by PNP
>  	  BIOS code.
>  
> +config X86_BOOT_VIDEO
> +	default y
> +	bool "Setup video on boot" if EXPERT
> +	help
> +	  Enable setting video mode on boot. Say Y here unless your machine
> +	  doesn't have any video adapter. (eg. embedded systems or VMs)

	                                  (e.g., embedded systems or VMs)

> +
>  config GART_IOMMU
>  	bool "Old AMD GART IOMMU support"
>  	select DMA_OPS


-- 
~Randy

