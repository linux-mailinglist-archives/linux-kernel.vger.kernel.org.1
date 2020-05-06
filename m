Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E40761C77C3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 19:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgEFRYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 13:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbgEFRYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 13:24:23 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E83C061A0F;
        Wed,  6 May 2020 10:24:23 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 9DF802A23AD
Subject: Re: [PATCH -next] soc: mediatek: Missing platform_device_unregister()
 on error in mtk_mmsys_probe()
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20200506141317.119537-1-weiyongjun1@huawei.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <923a48d8-eb9e-2729-a4be-dad63a6df28a@collabora.com>
Date:   Wed, 6 May 2020 19:24:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200506141317.119537-1-weiyongjun1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei,

Thank you for your patch.

On 6/5/20 16:13, Wei Yongjun wrote:
> Add the missing platform_device_unregister() before return
> from mtk_mmsys_probe() in the error handling case.
> 
> Fixes: 667c769246b0 ("soc / drm: mediatek: Fix mediatek-drm device probing")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  drivers/soc/mediatek/mtk-mmsys.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
> index 05e322c9c301..05ce4cb464b0 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mtk-mmsys.c
> @@ -312,8 +312,10 @@ static int mtk_mmsys_probe(struct platform_device *pdev)
>  
>  	drm = platform_device_register_data(&pdev->dev, "mediatek-drm",
>  					    PLATFORM_DEVID_AUTO, NULL, 0);
> -	if (IS_ERR(drm))
> +	if (IS_ERR(drm)) {
> +		platform_device_unregister(clks);
>  		return PTR_ERR(drm);
> +	}
>  
>  	return 0;
>  }
> 
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
