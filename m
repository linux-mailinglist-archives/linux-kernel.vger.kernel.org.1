Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8B32DF664
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 19:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbgLTSGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 13:06:06 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:51200 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbgLTSGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 13:06:05 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4821231A;
        Sun, 20 Dec 2020 19:05:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1608487523;
        bh=/uCR53dI7SjM/vnAu1lmZpL/cHj+oSniBKFwC/k9qDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ofpM1sqZ6h/3Bd1eikMmQ5s7IytPGwZVTd+i9mNcX9hnMTpmgqZUq7lmKNJrNhtlN
         Di7fiqwyPxBX5gibcm/s/rZXp+ZqahhF0QPvId1+pIo87jUGYQRBoNuN0NUida6ecz
         6rXPHBvq6LpTLW8iQXox9gSMwyBalc8AGM1VPS+s=
Date:   Sun, 20 Dec 2020 20:05:15 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Xu Wang <vulab@iscas.ac.cn>
Cc:     a.hajda@samsung.com, narmstrong@baylibre.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, airlied@linux.ie, daniel@ffwll.ch,
        sam@ravnborg.org, boris.brezillon@collabora.com,
        victor.liu@nxp.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: bridge: dw-hdmi: Remove redundant null check before
 clk_disable_unprepare
Message-ID: <X9+SWwALw+qcEEps@pendragon.ideasonboard.com>
References: <20201127092332.50879-1-vulab@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201127092332.50879-1-vulab@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xu Wang,

Thank you for the patch.

On Fri, Nov 27, 2020 at 09:23:32AM +0000, Xu Wang wrote:
> Because clk_disable_unprepare() already checked NULL clock parameter,
> so the additional check is unnecessary, just remove them.
> 
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 0c79a9ba48bb..dda4fa9a1a08 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -3440,8 +3440,7 @@ struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
>  
>  err_iahb:
>  	clk_disable_unprepare(hdmi->iahb_clk);
> -	if (hdmi->cec_clk)
> -		clk_disable_unprepare(hdmi->cec_clk);
> +	clk_disable_unprepare(hdmi->cec_clk);
>  err_isfr:
>  	clk_disable_unprepare(hdmi->isfr_clk);
>  err_res:
> @@ -3465,8 +3464,7 @@ void dw_hdmi_remove(struct dw_hdmi *hdmi)
>  
>  	clk_disable_unprepare(hdmi->iahb_clk);
>  	clk_disable_unprepare(hdmi->isfr_clk);
> -	if (hdmi->cec_clk)
> -		clk_disable_unprepare(hdmi->cec_clk);
> +	clk_disable_unprepare(hdmi->cec_clk);
>  
>  	if (hdmi->i2c)
>  		i2c_del_adapter(&hdmi->i2c->adap);

-- 
Regards,

Laurent Pinchart
