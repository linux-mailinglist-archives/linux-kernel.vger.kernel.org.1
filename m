Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D7C1BE75D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 21:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgD2T2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 15:28:52 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:51498 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgD2T2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 15:28:51 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 8AF0C804D0;
        Wed, 29 Apr 2020 21:28:46 +0200 (CEST)
Date:   Wed, 29 Apr 2020 21:28:40 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        kbuild test robot <lkp@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] video: fbdev: controlfb: fix build for COMPILE_TEST=y
 && PPC_PMAC=y && PPC32=n
Message-ID: <20200429192840.GA1022@ravnborg.org>
References: <CGME20200429104825eucas1p16bf37b71a3ab3a768d1eff6c48eb61dd@eucas1p1.samsung.com>
 <fe520316-3863-e6c4-9581-5d709f49e906@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe520316-3863-e6c4-9581-5d709f49e906@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=MOBOZvRl c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=rOUgymgbAAAA:8 a=QyXUC8HyAAAA:8 a=7gkXJVJtAAAA:8
        a=hD80L64hAAAA:8 a=r0KyO4OkOOGdkHu8Tb4A:9 a=CjuIK1q_8ugA:10
        a=MP9ZtiD8KjrkvI0BhSjB:22 a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartlomiej

On Wed, Apr 29, 2020 at 12:48:24PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> powerpc allyesconfig fails like this:
> 
> drivers/video/fbdev/controlfb.c: In function 'controlfb_mmap':
> drivers/video/fbdev/controlfb.c:756:23: error: implicit declaration of function 'pgprot_cached_wthru'; did you mean 'pgprot_cached'? [-Werror=implicit-function-declaration]
>   756 |   vma->vm_page_prot = pgprot_cached_wthru(vma->vm_page_prot);
>       |                       ^~~~~~~~~~~~~~~~~~~
>       |                       pgprot_cached
> drivers/video/fbdev/controlfb.c:756:23: error: incompatible types when assigning to type 'pgprot_t' {aka 'struct <anonymous>'} from type 'int'
> 
> Fix it by adding missing PPC32 dependency.
> 
> Fixes: a07a63b0e24d ("video: fbdev: controlfb: add COMPILE_TEST support")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Reported-by: kbuild test robot <lkp@intel.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

I've updated my build script to include a few popwerpc 32 bit configs.
Patch looked correct, and my builds was OK.
So applied to drm-misc-next and pushed out.

If my prodding of Christoph will result in anything only time will tell.

	Sam

> ---
> v2: fix implicit btext_update_display() function declaration error
> 
>  drivers/video/fbdev/controlfb.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: b/drivers/video/fbdev/controlfb.c
> ===================================================================
> --- a/drivers/video/fbdev/controlfb.c
> +++ b/drivers/video/fbdev/controlfb.c
> @@ -55,7 +55,7 @@
>  #include "macmodes.h"
>  #include "controlfb.h"
>  
> -#ifndef CONFIG_PPC_PMAC
> +#if !defined(CONFIG_PPC_PMAC) || !defined(CONFIG_PPC32)
>  #define invalid_vram_cache(addr)
>  #undef in_8
>  #undef out_8
