Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E69627525A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 09:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgIWHia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 03:38:30 -0400
Received: from gloria.sntech.de ([185.11.138.130]:44886 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgIWHia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 03:38:30 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kKzM1-0005G0-UU; Wed, 23 Sep 2020 09:38:17 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Jian-Hong Pan <jhp@endlessos.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com, Jian-Hong Pan <jhp@endlessos.org>
Subject: Re: [PATCH] drm/rockchip: skip probed failed device
Date:   Wed, 23 Sep 2020 09:38:17 +0200
Message-ID: <4075212.IPEHUSCvie@diego>
In-Reply-To: <20200923065900.658666-1-jhp@endlessos.org>
References: <CAPpJ_efHX70Ej0uzRi-iRf7N0n6ZO5sMN-wK_YpszvVD-Un9RQ@mail.gmail.com> <20200923065900.658666-1-jhp@endlessos.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Mittwoch, 23. September 2020, 08:59:00 CEST schrieb Jian-Hong Pan:
> The cdn-dp sub driver probes the device failed on PINEBOOK Pro.
> 
> kernel: cdn-dp fec00000.dp: [drm:cdn_dp_probe [rockchipdrm]] *ERROR* missing extcon or phy
> kernel: cdn-dp: probe of fec00000.dp failed with error -22
> 
> Then, the device halts all of the DRM related device jobs. For example,
> the operations: vop_component_ops, vop_component_ops and
> rockchip_dp_component_ops cannot be bound to corresponding devices. So,
> Xorg cannot find the correct DRM device.
> 
> This patch skips the probing failed devices to fix this issue.
> 
> Link: http://lists.infradead.org/pipermail/linux-rockchip/2020-September/022352.html
> Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> ---
>  drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> index 0f3eb392fe39..de13588602b4 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> @@ -331,6 +331,12 @@ static struct component_match *rockchip_drm_match_add(struct device *dev)
>  
>  			if (!d)
>  				break;
> +			if (!d->driver) {
> +				DRM_DEV_ERROR(d,
> +					      "%s did not probe successfully",
> +					      drv->driver.name);
> +				continue;
> +			}

How does this relate to drivers doing EPROBE_DEFER?

Very often you have sub-drivers defering probe as they still need another
resource, so excluding them in that case would not work?

Heiko


>  
>  			device_link_add(dev, d, DL_FLAG_STATELESS);
>  			component_match_add(dev, &match, compare_dev, d);
> 




