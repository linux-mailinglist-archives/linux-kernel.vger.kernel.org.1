Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E922C17D1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 22:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731354AbgKWVmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 16:42:12 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:41072 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbgKWVmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 16:42:12 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id BE4AD20051;
        Mon, 23 Nov 2020 22:42:09 +0100 (CET)
Date:   Mon, 23 Nov 2020 22:42:08 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Bernard Zhao <bernard@vivo.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
Subject: Re: [PATCH] via/via_irq: use __func__ to replace string function name
Message-ID: <20201123214208.GB675342@ravnborg.org>
References: <20201119072957.108941-1-bernard@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119072957.108941-1-bernard@vivo.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VbvZwmh9 c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=1WtWmnkvAAAA:8 a=iPqO3eFckTJRmb16J7wA:9
        a=CjuIK1q_8ugA:10 a=-_UHfarfsM-RsASml2Jt:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bernard.

On Wed, Nov 18, 2020 at 11:29:55PM -0800, Bernard Zhao wrote:
> This change also fix checkpatch.pl warning:
> WARNING: Prefer using '"%s...", __func__' to using
> 'via_driver_irq_postinstall', this function's name, in a string
> +	DRM_DEBUG("via_driver_irq_postinstall\n");
> 
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  drivers/gpu/drm/via/via_irq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/via/via_irq.c b/drivers/gpu/drm/via/via_irq.c
> index 24cc445169e2..56ce5d4ee24a 100644
> --- a/drivers/gpu/drm/via/via_irq.c
> +++ b/drivers/gpu/drm/via/via_irq.c
> @@ -308,7 +308,7 @@ int via_driver_irq_postinstall(struct drm_device *dev)
>  	drm_via_private_t *dev_priv = (drm_via_private_t *) dev->dev_private;
>  	u32 status;
>  
> -	DRM_DEBUG("via_driver_irq_postinstall\n");
> +	DRM_DEBUG("fun: %s\n", __func__);

DRM_DEBUG() will print the name of the calling function so the use of
__func__ here is not relevant.


For this old driver we should try to limit patches to bug fixing and
infrastructure updates.

	Sam
