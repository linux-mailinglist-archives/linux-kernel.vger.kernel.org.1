Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E95B275700
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 13:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgIWLRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 07:17:01 -0400
Received: from gloria.sntech.de ([185.11.138.130]:46428 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbgIWLRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 07:17:00 -0400
Received: from [95.90.166.74] (helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kL2la-0006fm-8p; Wed, 23 Sep 2020 13:16:54 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Jian-Hong Pan <jhp@endlessos.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux@endlessm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] drm/rockchip: skip probed failed device
Date:   Wed, 23 Sep 2020 13:16:53 +0200
Message-ID: <4641984.dSft4sXKFs@diego>
In-Reply-To: <439c4b59-b1e6-88bb-568e-1c2a0feceed4@arm.com>
References: <CAPpJ_efHX70Ej0uzRi-iRf7N0n6ZO5sMN-wK_YpszvVD-Un9RQ@mail.gmail.com> <20200923065900.658666-1-jhp@endlessos.org> <439c4b59-b1e6-88bb-568e-1c2a0feceed4@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 23. September 2020, 13:05:26 CEST schrieb Robin Murphy:
> On 2020-09-23 07:59, Jian-Hong Pan wrote:
> > The cdn-dp sub driver probes the device failed on PINEBOOK Pro.
> > 
> > kernel: cdn-dp fec00000.dp: [drm:cdn_dp_probe [rockchipdrm]] *ERROR* missing extcon or phy
> > kernel: cdn-dp: probe of fec00000.dp failed with error -22
> 
> Wouldn't it make more sense to simply not enable the DisplayPort node in 
> the upstream DT, until the type-C phy work has been done to make it 
> usable at all?

Or alternatively just disable the cdn-dp Rockchip driver in the kernel config,
which results in it also not getting probed.


> AIUI the "official" Manjaro kernel is carrying a bunch of 
> hacks to make type-C work via extcon, but they know that isn't an 
> upstreamable solution.
> 
> Robin.
> 
> > Then, the device halts all of the DRM related device jobs. For example,
> > the operations: vop_component_ops, vop_component_ops and
> > rockchip_dp_component_ops cannot be bound to corresponding devices. So,
> > Xorg cannot find the correct DRM device.
> > 
> > This patch skips the probing failed devices to fix this issue.
> > 
> > Link: http://lists.infradead.org/pipermail/linux-rockchip/2020-September/022352.html
> > Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> > ---
> >   drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> > index 0f3eb392fe39..de13588602b4 100644
> > --- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> > +++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> > @@ -331,6 +331,12 @@ static struct component_match *rockchip_drm_match_add(struct device *dev)
> >   
> >   			if (!d)
> >   				break;
> > +			if (!d->driver) {
> > +				DRM_DEV_ERROR(d,
> > +					      "%s did not probe successfully",
> > +					      drv->driver.name);
> > +				continue;
> > +			}
> >   
> >   			device_link_add(dev, d, DL_FLAG_STATELESS);
> >   			component_match_add(dev, &match, compare_dev, d);
> > 
> 




