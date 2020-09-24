Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB1DA277A9F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 22:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgIXUmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 16:42:12 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:55966 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIXUmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 16:42:12 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 17F6420079;
        Thu, 24 Sep 2020 22:42:09 +0200 (CEST)
Date:   Thu, 24 Sep 2020 22:42:07 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Yannick Fertre <yannick.fertre@st.com>
Cc:     Philippe Cornu <philippe.cornu@st.com>,
        Antonio Borneo <antonio.borneo@st.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        dri-devel@lists.freedesktop.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/stm: dsi: Avoid printing errors for -EPROBE_DEFER
Message-ID: <20200924204207.GO1223313@ravnborg.org>
References: <20200918114624.10759-1-yannick.fertre@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918114624.10759-1-yannick.fertre@st.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=CaYmGojl c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=8b9GpE9nAAAA:8 a=e5mUnYsNAAAA:8
        a=A0EKk_GVOdhxRvflaKsA:9 a=CjuIK1q_8ugA:10 a=T3LWEMljR5ZiDmsYVIUa:22
        a=Vxmtnl_E_bksehYqCbjh:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yannick

On Fri, Sep 18, 2020 at 01:46:24PM +0200, Yannick Fertre wrote:
> Don't print error when probe deferred error is returned.
> 
> Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
> ---
>  drivers/gpu/drm/stm/dw_mipi_dsi-stm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
> index 2e1f2664495d..164f79ef6269 100644
> --- a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
> +++ b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
> @@ -419,7 +419,8 @@ static int dw_mipi_dsi_stm_probe(struct platform_device *pdev)
>  	dsi->dsi = dw_mipi_dsi_probe(pdev, &dw_mipi_dsi_stm_plat_data);
>  	if (IS_ERR(dsi->dsi)) {
>  		ret = PTR_ERR(dsi->dsi);
> -		DRM_ERROR("Failed to initialize mipi dsi host: %d\n", ret);
> +		if (ret != -EPROBE_DEFER)
> +			DRM_ERROR("Failed to initialize mipi dsi host: %d\n", ret);
>  		goto err_dsi_probe;

Please use dev_err_probe() here.
We will loose [drm] but gain more than we loose.

	Sam

>  	}
>  
> -- 
> 2.17.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
