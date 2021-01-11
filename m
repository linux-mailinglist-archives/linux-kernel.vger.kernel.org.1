Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4122F1ADA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 17:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388927AbhAKQXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 11:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388738AbhAKQXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 11:23:36 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFBAC06179F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 08:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=NnO3PC1v7OwNsjtz/MTvoZ0RdBl+kSXA9v7RRRFb/oc=; b=SMzUVJwYOHPRZZfvEMBXgQptqc
        KhApDI1xH8KpDV1NSj8qRDZWBzPjgadJ6hbozmTCaNrcUDaeRW+cr2m6skDOvccp9GGQuHfhTypkh
        Gq/fVpuvJcHmX1B2qW8BJgIX1+I2LXpToolcfMGDP+YIF8G90FvJvTesYfCXBgWbAj2GnHGINCETD
        ionjj0BY1TCWDt99LNkDzpHxwtuDOvmytj0gf+84dalYI+aiw2b4eKAFDfQFeRa8bFrjcwbtLZ0kt
        gbInAkqSpk+6UVbPXCh9xphTtN//PTOd/WwcIqkuTFbtOH17RbbZmOIBC0eVKT+T1n64YuEAb1No/
        bUu9sMxQ==;
Received: from [2601:1c0:6280:3f0::79df]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kyzxu-0007e6-Nm; Mon, 11 Jan 2021 16:22:47 +0000
Subject: Re: [PATCH/v2] ARM: ixp4xx: Fix typos in Kconfig
To:     Masanari Iida <standby24x7@gmail.com>,
        linux-kernel@vger.kernel.org, kaloz@openwrt.org,
        linux-arm-kernel@lists.infradead.org, linusw@kernel.org,
        khalasa@piap.pl, linux@armlinux.org.uk
References: <5581e105-3967-c9b4-cb2c-12640eb1a2c8@infradead.org>
 <20210111144141.387064-1-standby24x7@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a7fcbed0-4bd7-1a8c-137c-3e872fb7dce9@infradead.org>
Date:   Mon, 11 Jan 2021 08:22:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210111144141.387064-1-standby24x7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/21 6:41 AM, Masanari Iida wrote:
> This patch fixes some spelling typos in Kconfig.
> 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  arch/arm/mach-ixp4xx/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-ixp4xx/Kconfig b/arch/arm/mach-ixp4xx/Kconfig
> index f7211b57b1e7..affee2e0ff55 100644
> --- a/arch/arm/mach-ixp4xx/Kconfig
> +++ b/arch/arm/mach-ixp4xx/Kconfig
> @@ -7,7 +7,7 @@ comment "IXP4xx Platforms"
>  
>  config MACH_IXP4XX_OF
>  	bool
> -	prompt "Devce Tree IXP4xx boards"
> +	prompt "Device Tree IXP4xx boards"
>  	default y
>  	select ARM_APPENDED_DTB # Old Redboot bootloaders deployed
>  	select I2C
> @@ -115,7 +115,7 @@ config ARCH_PRPMC1100
>  	bool "PrPMC1100"
>  	help
>  	  Say 'Y' here if you want your kernel to support the Motorola
> -	  PrPCM1100 Processor Mezanine Module. For more information on
> +	  PrPMC1100 Processor Mezzanine Module. For more information on
>  	  this platform, see <file:Documentation/arm/ixp4xx.rst>.
>  
>  config MACH_NAS100D
> 


-- 
~Randy

