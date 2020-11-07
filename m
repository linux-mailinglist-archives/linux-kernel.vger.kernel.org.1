Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A632AA471
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 11:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727155AbgKGKl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 05:41:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:51388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbgKGKl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 05:41:26 -0500
Received: from kernel.org (unknown [77.125.7.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6378E20704;
        Sat,  7 Nov 2020 10:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604745686;
        bh=OnnTM95JBBI8S/NLYvcIbx3BYDjZg8YDP/QB0dNoGpo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RaAqW88MfnBrtEdJVddDX+Ck15SXEvHnoQ5ApgQ4uQzN6APnreS1F13TPZWnSSlEp
         s7/qZVTStadrv01yRCBksEDHpc7IqsUFADrcLCAIfhaJXJkv+dq0FRDzeDg9wzs8XH
         XviWjJbebXrcL6fWeEj+wOzySi9grMTGxjayscXU=
Date:   Sat, 7 Nov 2020 12:41:19 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Wang Qing <wangqing@vivo.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        Tian Tao <tiantao6@hisilicon.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: mm: remove duplicate include
Message-ID: <20201107104119.GB301837@kernel.org>
References: <1604740552-25539-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604740552-25539-1-git-send-email-wangqing@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 07, 2020 at 05:15:50PM +0800, Wang Qing wrote:
> Remove duplicate header which is included twice.
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  arch/arm/mm/mmu.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index ab69250..4963e1c
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -33,7 +33,6 @@
>  #include <asm/mach/arch.h>
>  #include <asm/mach/map.h>
>  #include <asm/mach/pci.h>
> -#include <asm/fixmap.h>
>  
>  #include "fault.h"
>  #include "mm.h"
> -- 
> 2.7.4
> 

-- 
Sincerely yours,
Mike.
