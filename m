Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 459373028FD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 18:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730827AbhAYReh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 12:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731016AbhAYRdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 12:33:04 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26E8C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 09:32:23 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1l45iw-0006oS-BC; Mon, 25 Jan 2021 18:32:22 +0100
Message-ID: <f65185790a373d293a111316768e3e8ece3e97da.camel@pengutronix.de>
Subject: Re: [PATCH] drm/etnaviv: provide more ID values via GET_PARAM ioctl.
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Date:   Mon, 25 Jan 2021 18:32:18 +0100
In-Reply-To: <20201216114209.276630-1-christian.gmeiner@gmail.com>
References: <20201216114209.276630-1-christian.gmeiner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3 (3.38.3-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, dem 16.12.2020 um 12:42 +0100 schrieb Christian Gmeiner:
> Make it possible for the user space to access these ID values.

Thanks, I've added this patch to my etnaviv/next branch.

Regards,
Lucas

> Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 12 ++++++++++++
>  include/uapi/drm/etnaviv_drm.h        |  3 +++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> index c6404b8d067f..ec16991ba8b6 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> @@ -156,6 +156,18 @@ int etnaviv_gpu_get_param(struct etnaviv_gpu *gpu, u32 param, u64 *value)
>  			*value = ~0ULL;
>  		break;
>  
> 
> 
> 
> +	case ETNAVIV_PARAM_GPU_PRODUCT_ID:
> +		*value = gpu->identity.product_id;
> +		break;
> +
> +	case ETNAVIV_PARAM_GPU_CUSTOMER_ID:
> +		*value = gpu->identity.customer_id;
> +		break;
> +
> +	case ETNAVIV_PARAM_GPU_ECO_ID:
> +		*value = gpu->identity.eco_id;
> +		break;
> +
>  	default:
>  		DBG("%s: invalid param: %u", dev_name(gpu->dev), param);
>  		return -EINVAL;
> diff --git a/include/uapi/drm/etnaviv_drm.h b/include/uapi/drm/etnaviv_drm.h
> index 09d0df8b71c5..af024d90453d 100644
> --- a/include/uapi/drm/etnaviv_drm.h
> +++ b/include/uapi/drm/etnaviv_drm.h
> @@ -74,6 +74,9 @@ struct drm_etnaviv_timespec {
>  #define ETNAVIV_PARAM_GPU_NUM_CONSTANTS             0x19
>  #define ETNAVIV_PARAM_GPU_NUM_VARYINGS              0x1a
>  #define ETNAVIV_PARAM_SOFTPIN_START_ADDR            0x1b
> +#define ETNAVIV_PARAM_GPU_PRODUCT_ID                0x1c
> +#define ETNAVIV_PARAM_GPU_CUSTOMER_ID               0x1d
> +#define ETNAVIV_PARAM_GPU_ECO_ID                    0x1e
>  
> 
> 
> 
>  #define ETNA_MAX_PIPES 4
>  
> 
> 
> 


