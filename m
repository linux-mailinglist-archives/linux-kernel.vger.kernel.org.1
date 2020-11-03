Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860EC2A3F38
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 09:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgKCIpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 03:45:08 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45492 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbgKCIpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 03:45:07 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id AEACD1F45388;
        Tue,  3 Nov 2020 08:45:05 +0000 (GMT)
Date:   Tue, 3 Nov 2020 09:45:02 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panfrost: Fix module unload
Message-ID: <20201103094502.70de59c9@collabora.com>
In-Reply-To: <20201030145833.29006-1-steven.price@arm.com>
References: <20201030145833.29006-1-steven.price@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Oct 2020 14:58:33 +0000
Steven Price <steven.price@arm.com> wrote:

> When unloading the call to pm_runtime_put_sync_suspend() will attempt to
> turn the GPU cores off, however panfrost_device_fini() will have turned
> the clocks off. This leads to the hardware locking up.
> 
> Instead don't call pm_runtime_put_sync_suspend() and instead simply mark
> the device as suspended using pm_runtime_set_suspended(). And also
> include this on the error path in panfrost_probe().
> 
> Fixes: aebe8c22a912 ("drm/panfrost: Fix possible suspend in panfrost_remove")
> Signed-off-by: Steven Price <steven.price@arm.com>

Queued to drm-misc-fixes.

Thanks,

Boris

> ---
>  drivers/gpu/drm/panfrost/panfrost_drv.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index 23513869500c..0ac8ad18fdc6 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -627,6 +627,7 @@ static int panfrost_probe(struct platform_device *pdev)
>  err_out1:
>  	pm_runtime_disable(pfdev->dev);
>  	panfrost_device_fini(pfdev);
> +	pm_runtime_set_suspended(pfdev->dev);
>  err_out0:
>  	drm_dev_put(ddev);
>  	return err;
> @@ -641,9 +642,9 @@ static int panfrost_remove(struct platform_device *pdev)
>  	panfrost_gem_shrinker_cleanup(ddev);
>  
>  	pm_runtime_get_sync(pfdev->dev);
> -	panfrost_device_fini(pfdev);
> -	pm_runtime_put_sync_suspend(pfdev->dev);
>  	pm_runtime_disable(pfdev->dev);
> +	panfrost_device_fini(pfdev);
> +	pm_runtime_set_suspended(pfdev->dev);
>  
>  	drm_dev_put(ddev);
>  	return 0;

