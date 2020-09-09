Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEDA1262C82
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 11:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgIIJvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 05:51:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:51508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbgIIJvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 05:51:10 -0400
Received: from kernel.org (unknown [87.71.73.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2767F21D79;
        Wed,  9 Sep 2020 09:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599645069;
        bh=okLlfnZndyIXRHyblovBHyicZmqIOMpl1ZWcMU+jphA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ADpM8MVACvmSRCY12bb66UQvr3fd1O80KrzI5R468RQ3bgMghOJNJrg1CgP10P/nt
         dCB5TFQ+gg9Z6NQ15Cuekgnih04ofu32t3fo1e/iSLRkmdcT0kupcK1l8A1kzbeps1
         p+ZpM+ujmgsAzr9F8X0Utam3Y46KOY7ke3YBPslA=
Date:   Wed, 9 Sep 2020 12:51:00 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Yi Li <yili@winhong.com>
Cc:     akpm@linux-foundation.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, yilikernel@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, clin@suse.com,
        mark.rutland@arm.com, maz@kernel.org, anshuman.khandual@arm.com,
        ardb@kernel.org, geert@linux-m68k.org
Subject: Re: [PATCH] Remove duplicate include file
Message-ID: <20200909095100.GB2142832@kernel.org>
References: <20200909093632.1278408-1-yili@winhong.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909093632.1278408-1-yili@winhong.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 09, 2020 at 05:36:32PM +0800, Yi Li wrote:
> Remove duplicate include file
> 
> Signed-off-by: Yi Li <yili@winhong.com>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  arch/arm/mm/mmu.c | 1 -
>  mm/slab.h         | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index c36f977b2ccb..7bbcdb29413e 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -34,7 +34,6 @@
>  #include <asm/mach/arch.h>
>  #include <asm/mach/map.h>
>  #include <asm/mach/pci.h>
> -#include <asm/fixmap.h>
>  
>  #include "fault.h"
>  #include "mm.h"
> diff --git a/mm/slab.h b/mm/slab.h
> index 6cc323f1313a..95e5cc1bb2a3 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -46,7 +46,6 @@ struct kmem_cache {
>  #include <linux/kmemleak.h>
>  #include <linux/random.h>
>  #include <linux/sched/mm.h>
> -#include <linux/kmemleak.h>
>  
>  /*
>   * State of the slab allocator.
> -- 
> 2.25.3
> 
> 
> 
> 

-- 
Sincerely yours,
Mike.
