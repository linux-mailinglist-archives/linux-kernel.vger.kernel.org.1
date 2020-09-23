Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0EA2756D4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 13:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgIWLFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 07:05:38 -0400
Received: from foss.arm.com ([217.140.110.172]:43580 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbgIWLFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 07:05:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8526AD6E;
        Wed, 23 Sep 2020 04:05:36 -0700 (PDT)
Received: from [10.57.48.76] (unknown [10.57.48.76])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B57D3F718;
        Wed, 23 Sep 2020 04:05:35 -0700 (PDT)
Subject: Re: [PATCH] drm/rockchip: skip probed failed device
To:     Jian-Hong Pan <jhp@endlessos.org>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux@endlessm.com,
        linux-arm-kernel@lists.infradead.org
References: <CAPpJ_efHX70Ej0uzRi-iRf7N0n6ZO5sMN-wK_YpszvVD-Un9RQ@mail.gmail.com>
 <20200923065900.658666-1-jhp@endlessos.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <439c4b59-b1e6-88bb-568e-1c2a0feceed4@arm.com>
Date:   Wed, 23 Sep 2020 12:05:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200923065900.658666-1-jhp@endlessos.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-23 07:59, Jian-Hong Pan wrote:
> The cdn-dp sub driver probes the device failed on PINEBOOK Pro.
> 
> kernel: cdn-dp fec00000.dp: [drm:cdn_dp_probe [rockchipdrm]] *ERROR* missing extcon or phy
> kernel: cdn-dp: probe of fec00000.dp failed with error -22

Wouldn't it make more sense to simply not enable the DisplayPort node in 
the upstream DT, until the type-C phy work has been done to make it 
usable at all? AIUI the "official" Manjaro kernel is carrying a bunch of 
hacks to make type-C work via extcon, but they know that isn't an 
upstreamable solution.

Robin.

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
>   drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> index 0f3eb392fe39..de13588602b4 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> @@ -331,6 +331,12 @@ static struct component_match *rockchip_drm_match_add(struct device *dev)
>   
>   			if (!d)
>   				break;
> +			if (!d->driver) {
> +				DRM_DEV_ERROR(d,
> +					      "%s did not probe successfully",
> +					      drv->driver.name);
> +				continue;
> +			}
>   
>   			device_link_add(dev, d, DL_FLAG_STATELESS);
>   			component_match_add(dev, &match, compare_dev, d);
> 
