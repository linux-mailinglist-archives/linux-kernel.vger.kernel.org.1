Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 152D91AB15F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 21:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441721AbgDOTOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 15:14:36 -0400
Received: from baldur.buserror.net ([165.227.176.147]:35596 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1416885AbgDOS4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 14:56:04 -0400
Received: from [2601:449:8480:af0:12bf:48ff:fe84:c9a0]
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1jOnAT-0006xw-Sc; Wed, 15 Apr 2020 13:53:50 -0500
Message-ID: <36961f9d8c533d8b576043a2c6fc4859accfd9f1.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     Wang Wenhu <wenhu.wang@vivo.com>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, christophe.leroy@c-s.fr,
        linuxppc-dev@lists.ozlabs.org
Cc:     kernel@vivo.com, Michael Ellerman <mpe@ellerman.id.au>
Date:   Wed, 15 Apr 2020 13:53:48 -0500
In-Reply-To: <20200415152442.122873-2-wenhu.wang@vivo.com>
References: <20200415124929.GA3265842@kroah.com>
         <20200415152442.122873-1-wenhu.wang@vivo.com>
         <20200415152442.122873-2-wenhu.wang@vivo.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8480:af0:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: wenhu.wang@vivo.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, christophe.leroy@c-s.fr, linuxppc-dev@lists.ozlabs.org, kernel@vivo.com, mpe@ellerman.id.au
X-SA-Exim-Mail-From: oss@buserror.net
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on baldur.localdomain
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  -15 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        * -1.5 GREYLIST_ISWHITE The incoming server has been whitelisted for
        *      this recipient and sender
Subject: Re: [PATCH v2,1/5] powerpc: 85xx: make FSL_85XX_CACHE_SRAM
 configurable
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-04-15 at 08:24 -0700, Wang Wenhu wrote:
> Enable FSL_85XX_CACHE_SRAM selection. On e500 platforms, the cache
> could be configured and used as a piece of SRAM which is hignly
> friendly for some user level application performances.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> Cc: Scott Wood <oss@buserror.net>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
> ---
> Changes since v1:
>  * None
> ---
>  arch/powerpc/platforms/85xx/Kconfig    | 2 +-
>  arch/powerpc/platforms/Kconfig.cputype | 5 +++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/85xx/Kconfig
> b/arch/powerpc/platforms/85xx/Kconfig
> index fa3d29dcb57e..6debb4f1b9cc 100644
> --- a/arch/powerpc/platforms/85xx/Kconfig
> +++ b/arch/powerpc/platforms/85xx/Kconfig
> @@ -17,7 +17,7 @@ if FSL_SOC_BOOKE
>  if PPC32
>  
>  config FSL_85XX_CACHE_SRAM
> -	bool
> +	bool "Freescale 85xx Cache-Sram"
>  	select PPC_LIB_RHEAP
>  	help
>  	  When selected, this option enables cache-sram support

NACK

As discussed before, the driver that uses this API should "select" this
symbol.

-Scott


