Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85962EC13F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 17:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbhAFQeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 11:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbhAFQeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 11:34:11 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B53C06134C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 08:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=nf+hNl2NMSH3b9LLMC9AvfOsBSeVjk1Qwv01ubGkwK0=; b=ZxPJabdW7I6AwmjtvR8PBN+H00
        kLTGwTY70e7mjaRc2J+xN+e/yXSXvm/qRuVVAjHJOzq6gCLA/R6+KKnoSn6MT1rux8ck3XiS4PjYF
        gyEGFYAAXlj/OccD92V142AUviKgO/FvaZSLIRXqWXzi9fSnVhB79ESYTd0UdxWVAmes9n0hhYOcj
        IZnFRZAPLBy2R/8KskaF1MNAntkD97qt7kVVbG8ouiw4JPf2xAN+5VRyMrWCngVGKFFWPxmV8fLCk
        P8QqOWaWIjYwMF5eDSSKGlGp1Vw6Vvd8LQuVRhsekRWZvM6L3A/czIZ7hs35cfzUD5YGDjCUISRst
        Sv1LDVpQ==;
Received: from [2601:1c0:6280:3f0::79df]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kxBiz-002VcE-PY; Wed, 06 Jan 2021 16:32:32 +0000
Subject: Re: [PATCH] ARM: ixp4xx: Fix typos in Kconfig
To:     Masanari Iida <standby24x7@gmail.com>, linusw@kernel.org,
        kaloz@openwrt.org, khalasa@piap.pl, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210106105652.240472-1-standby24x7@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5581e105-3967-c9b4-cb2c-12640eb1a2c8@infradead.org>
Date:   Wed, 6 Jan 2021 08:31:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210106105652.240472-1-standby24x7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/21 2:56 AM, Masanari Iida wrote:
> This patch fixes some spelling typos in Kconfig.
> 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>
> ---
>  arch/arm/mach-ixp4xx/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-ixp4xx/Kconfig b/arch/arm/mach-ixp4xx/Kconfig
> index f7211b57b1e7..c4f719993190 100644
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
> +	  PrPMC1100 Processor Mezanine Module. For more information on

	                      Mezzanine

>  	  this platform, see <file:Documentation/arm/ixp4xx.rst>.
>  
>  config MACH_NAS100D
> 

otherwise it looks good. Thanks.

-- 
~Randy

