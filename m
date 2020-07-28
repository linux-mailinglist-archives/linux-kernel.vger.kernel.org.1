Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA74231596
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 00:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbgG1WeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 18:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729223AbgG1WeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 18:34:00 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CF9C061794;
        Tue, 28 Jul 2020 15:34:00 -0700 (PDT)
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DF879563;
        Wed, 29 Jul 2020 00:33:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1595975639;
        bh=EpxA9pvxLOGaUuww38LTx5fEDKuye+ZbkE8mxs2jw5Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VmktEMvejHNl9eVNAkAAW8NWjRvGid8iVR5HjYVTUjZRHrRE2aKWIhbCrveknp52R
         qpol8xjcyCWqEkCd2Sn/GTmuLRw+P/6JEOT/vLL/dtvBSNatHC3FoK2medB9+PzV6R
         1z97QRitYZ+e8oynpX4usQklcg5sOkhjE8fqdZTI=
Date:   Wed, 29 Jul 2020 01:33:49 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Hyun Kwon <hyun.kwon@xilinx.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michal Simek <michal.simek@xilinx.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] drm: xlnx: Fix typo in parameter description
Message-ID: <20200728223349.GT13753@pendragon.ideasonboard.com>
References: <20200725063429.172139-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200725063429.172139-1-weiyongjun1@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei,

Thank you for the patch.

On Sat, Jul 25, 2020 at 06:34:29AM +0000, Wei Yongjun wrote:
> Fix typo in parameter description.
> 
> Fixes: d76271d22694 ("drm: xlnx: DRM/KMS driver for Xilinx ZynqMP DisplayPort Subsystem")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/xlnx/zynqmp_dp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> index 821f7a71e182..3d53638ab15e 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> @@ -44,7 +44,7 @@ MODULE_PARM_DESC(aux_timeout_ms, "DP aux timeout value in msec (default: 50)");
>   */
>  static uint zynqmp_dp_power_on_delay_ms = 4;
>  module_param_named(power_on_delay_ms, zynqmp_dp_power_on_delay_ms, uint, 0444);
> -MODULE_PARM_DESC(aux_timeout_ms, "DP power on delay in msec (default: 4)");
> +MODULE_PARM_DESC(power_on_delay_ms, "DP power on delay in msec (default: 4)");
>  
>  /* Link configuration registers */
>  #define ZYNQMP_DP_LINK_BW_SET				0x0

-- 
Regards,

Laurent Pinchart
