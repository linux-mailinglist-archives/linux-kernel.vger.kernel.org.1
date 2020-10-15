Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E322528EE2E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 10:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387688AbgJOIIL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 15 Oct 2020 04:08:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:41092 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728048AbgJOIGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 04:06:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 03440AF84;
        Thu, 15 Oct 2020 08:05:59 +0000 (UTC)
Date:   Thu, 15 Oct 2020 10:05:57 +0200
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     Xu Wang <vulab@iscas.ac.cn>
Cc:     b.zolnierkie@samsung.com, jani.nikula@intel.com,
        daniel.vetter@ffwll.ch, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] au1100fb: Remove NULL pointer check before
 clk_enable/disable
Message-ID: <20201015100557.402f831f@linux-uq9g>
In-Reply-To: <20201014082137.23320-1-vulab@iscas.ac.cn>
References: <20201014082137.23320-1-vulab@iscas.ac.cn>
Organization: SUSE Software Solutions Germany GmbH
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Wed, 14 Oct 2020 08:21:37 +0000 Xu Wang <vulab@iscas.ac.cn> wrote:

> Because clk_enable, clk_disable, clk_prepare, and clk_unprepare already
> checked NULL clock parameter, so the additional checks are unnecessary,
> just remove them.

All clk_*() functions seem to handle NULL pointers gracefully, so you can
also remove these checks from the driver's _probe and _remove functions.

Best regards
Thomas

> 
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
> ---
>  drivers/video/fbdev/au1100fb.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au1100fb.c
> index 37a6512feda0..3659dfbb81c1 100644
> --- a/drivers/video/fbdev/au1100fb.c
> +++ b/drivers/video/fbdev/au1100fb.c
> @@ -560,8 +560,7 @@ int au1100fb_drv_suspend(struct platform_device *dev,
> pm_message_t state) /* Blank the LCD */
>  	au1100fb_fb_blank(VESA_POWERDOWN, &fbdev->info);
>  
> -	if (fbdev->lcdclk)
> -		clk_disable(fbdev->lcdclk);
> +	clk_disable(fbdev->lcdclk);
>  
>  	memcpy(&fbregs, fbdev->regs, sizeof(struct au1100fb_regs));
>  
> @@ -577,8 +576,7 @@ int au1100fb_drv_resume(struct platform_device *dev)
>  
>  	memcpy(fbdev->regs, &fbregs, sizeof(struct au1100fb_regs));
>  
> -	if (fbdev->lcdclk)
> -		clk_enable(fbdev->lcdclk);
> +	clk_enable(fbdev->lcdclk);
>  
>  	/* Unblank the LCD */
>  	au1100fb_fb_blank(VESA_NO_BLANKING, &fbdev->info);



-- 
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
(HRB 36809, AG Nürnberg)
Geschäftsführer: Felix Imendörffer
