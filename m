Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9EC2922E5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 09:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbgJSHVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 03:21:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:40306 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727223AbgJSHVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 03:21:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7E795AB0E;
        Mon, 19 Oct 2020 07:21:01 +0000 (UTC)
Subject: Re: [PATCH] au1100fb: Remove NULL pointer check before
 clk_enable/disable
To:     Xu Wang <vulab@iscas.ac.cn>, b.zolnierkie@samsung.com,
        jani.nikula@intel.com, daniel.vetter@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201014082137.23320-1-vulab@iscas.ac.cn>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <6cf83ff0-eeae-5646-b068-34dbacf2d961@suse.de>
Date:   Mon, 19 Oct 2020 09:21:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201014082137.23320-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 14.10.20 10:21, Xu Wang wrote:
> Because clk_enable, clk_disable, clk_prepare, and clk_unprepare already
> checked NULL clock parameter, so the additional checks are unnecessary,
> just remove them.
> 
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>

Sam convinced me to merge this patch as-is with out the additional
cleanup of the driver. So

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

I'll merge it into drm-misc-next.

I'd still like to encourage you to send a patch for the other clk_*
calls in au1100fb.

Best regard
Thomas

> ---
>  drivers/video/fbdev/au1100fb.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au1100fb.c
> index 37a6512feda0..3659dfbb81c1 100644
> --- a/drivers/video/fbdev/au1100fb.c
> +++ b/drivers/video/fbdev/au1100fb.c
> @@ -560,8 +560,7 @@ int au1100fb_drv_suspend(struct platform_device *dev, pm_message_t state)
>  	/* Blank the LCD */
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
> 

-- 
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
(HRB 36809, AG Nürnberg)
Geschäftsführer: Felix Imendörffer
