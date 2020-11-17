Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63EFC2B63E7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 14:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387458AbgKQNmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 08:42:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:41570 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733166AbgKQNlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 08:41:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0A77EAC1F;
        Tue, 17 Nov 2020 13:41:38 +0000 (UTC)
Subject: Re: [PATCH] drm/omap: dmm_tiler: fix return error code in
 omap_dmm_probe()
To:     Yang Yingliang <yangyingliang@huawei.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        tomi.valkeinen@ti.com
References: <20201117061045.3452287-1-yangyingliang@huawei.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <04c96207-3c67-0cab-d3e7-919b96fbb46b@suse.de>
Date:   Tue, 17 Nov 2020 14:41:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201117061045.3452287-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Am 17.11.20 um 07:10 schrieb Yang Yingliang:
> Return -ENOMEM when allocating refill memory failed.
> 
> Fixes: 71e8831f6407 ("drm/omap: DMM/TILER support for OMAP4+ platform")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/gpu/drm/omapdrm/omap_dmm_tiler.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
> index 42ec51bb7b1b..7f4317248812 100644
> --- a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
> +++ b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
> @@ -889,6 +889,7 @@ static int omap_dmm_probe(struct platform_device *dev)
>  					   &omap_dmm->refill_pa, GFP_KERNEL);
>  	if (!omap_dmm->refill_va) {
>  		dev_err(&dev->dev, "could not allocate refill memory\n");
> +		ret = -ENOMEM;

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks for the patch. I'll add it to drm-misc-next. There are more such
errors here. If the very first allocation fails, the function returns
-EFAULT, which makes no sense.

Best regards
Thomas

>  		goto fail;
>  	}
>  
> 

-- 
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
(HRB 36809, AG Nürnberg)
Geschäftsführer: Felix Imendörffer
