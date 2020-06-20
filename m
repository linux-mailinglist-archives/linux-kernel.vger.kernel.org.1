Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8774320234E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jun 2020 13:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbgFTLUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Jun 2020 07:20:11 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:50394 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbgFTLUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 07:20:10 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 1729920020;
        Sat, 20 Jun 2020 13:20:07 +0200 (CEST)
Date:   Sat, 20 Jun 2020 13:20:05 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philippe CORNU <philippe.cornu@st.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] drm/panel: otm8009a: Drop unnessary
 backlight_device_unregister()
Message-ID: <20200620112005.GA16901@ravnborg.org>
References: <20200618134650.44311-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618134650.44311-1-weiyongjun1@huawei.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=edQTgYMH c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=i0EeH86SAAAA:8 a=e5mUnYsNAAAA:8
        a=zABfKpiexC27CGjMe80A:9 a=CjuIK1q_8ugA:10 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei.

On Thu, Jun 18, 2020 at 01:46:50PM +0000, Wei Yongjun wrote:
> It's not necessary to unregister backlight device which
> registered with devm_backlight_device_register().
> 
> Fixes: 12a6cbd4f3f1 ("drm/panel: otm8009a: Use new backlight API")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Thanks, pushed to drm-misc-next.

	Sam

> ---
>  drivers/gpu/drm/panel/panel-orisetech-otm8009a.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c b/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
> index 895ee3d1371e..d956522f32ee 100644
> --- a/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
> +++ b/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
> @@ -479,7 +479,6 @@ static int otm8009a_probe(struct mipi_dsi_device *dsi)
>  	if (ret < 0) {
>  		dev_err(dev, "mipi_dsi_attach failed. Is host ready?\n");
>  		drm_panel_remove(&ctx->panel);
> -		backlight_device_unregister(ctx->bl_dev);
>  		return ret;
>  	}
> 
> 
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
