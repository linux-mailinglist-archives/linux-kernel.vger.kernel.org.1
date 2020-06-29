Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8D620D753
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jun 2020 22:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730104AbgF2T2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 15:28:54 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:37784 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731269AbgF2T2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:28:40 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 2F01920021;
        Mon, 29 Jun 2020 09:39:33 +0200 (CEST)
Date:   Mon, 29 Jun 2020 09:39:31 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     shawnguo@kernel.org, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/zte: remove unneeded semicolon
Message-ID: <20200629073931.GA227119@ravnborg.org>
References: <20200504113230.40588-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504113230.40588-1-yanaijie@huawei.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=f+hm+t6M c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=i0EeH86SAAAA:8 a=e5mUnYsNAAAA:8
        a=08u2UhFWmFwjV6_hJKUA:9 a=CjuIK1q_8ugA:10 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 04, 2020 at 07:32:30PM +0800, Jason Yan wrote:
> Fix the following coccicheck warning:
> 
> drivers/gpu/drm/zte/zx_vga.c:158:2-3: Unneeded semicolon
> drivers/gpu/drm/zte/zx_vga.c:171:2-3: Unneeded semicolon
> drivers/gpu/drm/zte/zx_vga.c:179:2-3: Unneeded semicolon
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Applied to drm-misc-next.

	Sam

> ---
>  drivers/gpu/drm/zte/zx_vga.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/zte/zx_vga.c b/drivers/gpu/drm/zte/zx_vga.c
> index a7ed7f5ca837..0f9bbb7e3b8d 100644
> --- a/drivers/gpu/drm/zte/zx_vga.c
> +++ b/drivers/gpu/drm/zte/zx_vga.c
> @@ -155,7 +155,7 @@ static int zx_vga_register(struct drm_device *drm, struct zx_vga *vga)
>  	if (ret) {
>  		DRM_DEV_ERROR(dev, "failed to init encoder: %d\n", ret);
>  		return ret;
> -	};
> +	}
>  
>  	drm_encoder_helper_add(encoder, &zx_vga_encoder_helper_funcs);
>  
> @@ -168,7 +168,7 @@ static int zx_vga_register(struct drm_device *drm, struct zx_vga *vga)
>  	if (ret) {
>  		DRM_DEV_ERROR(dev, "failed to init connector: %d\n", ret);
>  		goto clean_encoder;
> -	};
> +	}
>  
>  	drm_connector_helper_add(connector, &zx_vga_connector_helper_funcs);
>  
> @@ -176,7 +176,7 @@ static int zx_vga_register(struct drm_device *drm, struct zx_vga *vga)
>  	if (ret) {
>  		DRM_DEV_ERROR(dev, "failed to attach encoder: %d\n", ret);
>  		goto clean_connector;
> -	};
> +	}
>  
>  	return 0;
>  
> -- 
> 2.21.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
