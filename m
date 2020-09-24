Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 892D42779F8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 22:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgIXUMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 16:12:50 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:53444 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIXUMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 16:12:50 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 7759420079;
        Thu, 24 Sep 2020 22:12:47 +0200 (CEST)
Date:   Thu, 24 Sep 2020 22:12:46 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Xiaofei Tan <tanxiaofei@huawei.com>
Cc:     b.zolnierkie@samsung.com, arnd@arndb.de,
        laurent.pinchart@ideasonboard.com, jani.nikula@intel.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH] fbdev: mx3fb: remove unused variable 'irq'
Message-ID: <20200924201246.GH1223313@ravnborg.org>
References: <1600334360-4214-1-git-send-email-tanxiaofei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600334360-4214-1-git-send-email-tanxiaofei@huawei.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=CaYmGojl c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=i0EeH86SAAAA:8 a=6gI2KA8OTFMSUhKLS0YA:9
        a=CjuIK1q_8ugA:10
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 05:19:20PM +0800, Xiaofei Tan wrote:
> Remove the variable 'irq' that is set but never used.
> 
> Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>

Thanks, applied to drm-misc-next.

	Sam

> ---
>  drivers/video/fbdev/mx3fb.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/mx3fb.c b/drivers/video/fbdev/mx3fb.c
> index 603731a..894617d 100644
> --- a/drivers/video/fbdev/mx3fb.c
> +++ b/drivers/video/fbdev/mx3fb.c
> @@ -1428,7 +1428,6 @@ static int init_fb_chan(struct mx3fb_data *mx3fb, struct idmac_channel *ichan)
>  	struct device *dev = mx3fb->dev;
>  	struct mx3fb_platform_data *mx3fb_pdata = dev_get_platdata(dev);
>  	const char *name = mx3fb_pdata->name;
> -	unsigned int irq;
>  	struct fb_info *fbi;
>  	struct mx3fb_info *mx3fbi;
>  	const struct fb_videomode *mode;
> @@ -1441,7 +1440,6 @@ static int init_fb_chan(struct mx3fb_data *mx3fb, struct idmac_channel *ichan)
>  	}
>  
>  	ichan->client = mx3fb;
> -	irq = ichan->eof_irq;
>  
>  	if (ichan->dma_chan.chan_id != IDMAC_SDC_0)
>  		return -EINVAL;
> -- 
> 2.8.1
