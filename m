Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10E42A406D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 10:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgKCJgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 04:36:38 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:53294 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbgKCJgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 04:36:38 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id BE1F62004C;
        Tue,  3 Nov 2020 10:36:33 +0100 (CET)
Date:   Tue, 3 Nov 2020 10:36:32 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm: Add the new api to install irq
Message-ID: <20201103093632.GA1474335@ravnborg.org>
References: <1604369441-65254-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604369441-65254-1-git-send-email-tiantao6@hisilicon.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VbvZwmh9 c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=BTeA3XvPAAAA:8 a=3yVtim9A5VgNDfYo_gMA:9
        a=CjuIK1q_8ugA:10 a=tafbbOV3vt1XuEhzTjGK:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tian.

Good to see more infrastructure support so one does not have to think about cleanup.

On Tue, Nov 03, 2020 at 10:10:41AM +0800, Tian Tao wrote:
> Add new api devm_drm_irq_install() to register interrupts,
> no need to call drm_irq_uninstall() when the drm module is removed.
> 
> v2:
> fixed the wrong parameter.
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
>  drivers/gpu/drm/drm_drv.c | 23 +++++++++++++++++++++++
>  include/drm/drm_drv.h     |  3 ++-
>  2 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index cd162d4..0fe5243 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -39,6 +39,7 @@
>  #include <drm/drm_color_mgmt.h>
>  #include <drm/drm_drv.h>
>  #include <drm/drm_file.h>
> +#include <drm/drm_irq.h>
>  #include <drm/drm_managed.h>
>  #include <drm/drm_mode_object.h>
>  #include <drm/drm_print.h>
> @@ -678,6 +679,28 @@ static int devm_drm_dev_init(struct device *parent,
>  	return ret;
>  }
>  
> +static void devm_drm_dev_irq_uninstall(void *data)
devm_drm_irq_uninstall??
It matches other names if you drop the _dev part.

> +{
> +	drm_irq_uninstall(data);
> +}
> +
> +int devm_drm_irq_install(struct device *parent,
> +			 struct drm_device *dev, int irq)
As this is an exported function please add appropriate kernel-doc
documentation. It should for example explain that there is no need to
uninstall as this is done automagically.

> +{
> +	int ret;
> +
> +	ret = drm_irq_install(dev, irq);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action(parent, devm_drm_dev_irq_uninstall, dev);
> +	if (ret)
> +		devm_drm_dev_irq_uninstall(dev);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(devm_drm_irq_install);

The above are in addition to Thomas' feedback.

	Sam
