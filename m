Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798A71AE3E6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 19:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbgDQRjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 13:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728421AbgDQRjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 13:39:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51F4C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 10:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=LBjygYyC944CKlPD3XS2R4n/n0JfZwjSTHNfNJ0y7Zg=; b=WZaabqWmMoH65WOVHe9ERur26P
        R1zgqFtkWETNmQ3aNjbpQfcQ/JGtumJqJklq+OZU5vJzEP5wQQNy97YnDh1BrIbJDxDhQyrVfrvYA
        M43cVmGeTPWLLQ/ltsKs5UCTyoFBCLAizrOtvkyue1SS/J8tUxWZjFOuuuZe7aG3bufdDhSIkZOko
        CUdTgm1zBbjMp8h5mhSmXHGmqBQ9KJwtE8xmHNfwSdUdA6l4vo1LdOTt7ucqRtrTmDj7YpsyTGLG2
        uYhQLJtIZ+/nNevMMgYHdsr+j4FUD9CeFABIAwOdPN2f8SdoATvwE9vReArCgU2HttHEvDMju2zYx
        FaOs5k0g==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPUxl-0002jG-Sf; Fri, 17 Apr 2020 17:39:37 +0000
Subject: Re: [PATCH] drivers: uio: new driver uio_fsl_85xx_cache_sram
To:     Wang Wenhu <wenhu.wang@vivo.com>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     christophe.leroy@c-s.fr, oss@buserror.net, kernel@vivo.com,
        robh@kernel.org, Michael Ellerman <mpe@ellerman.id.au>
References: <20200417172130.14287-1-wenhu.wang@vivo.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9263f8fb-74e0-4c74-6c72-bdf0dfafbf1b@infradead.org>
Date:   Fri, 17 Apr 2020 10:39:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200417172130.14287-1-wenhu.wang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/17/20 10:21 AM, Wang Wenhu wrote:
> diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
> index 202ee81cfc2b..f6e6ec0089c0 100644
> --- a/drivers/uio/Kconfig
> +++ b/drivers/uio/Kconfig
> @@ -105,6 +105,14 @@ config UIO_NETX
>  	  To compile this driver as a module, choose M here; the module
>  	  will be called uio_netx.
>  
> +config UIO_FSL_85XX_CACHE_SRAM
> +	tristate "Freescale MPC85xx Cache-Sram driver"
> +	depends on FSL_SOC_BOOKE && PPC32 && !FSL_85XX_CACHE_SRAM
> +	help
> +	  Generic driver for accessing the Cache-Sram form user level. This

	                                              from

and SRAM would be better than Sram IMO. (2 places)

> +	  is extremely helpful for some user-space applications that require
> +	  high performance memory accesses.
> +
>  config UIO_FSL_ELBC_GPCM
>  	tristate "eLBC/GPCM driver"
>  	depends on FSL_LBC

thanks.
-- 
~Randy

