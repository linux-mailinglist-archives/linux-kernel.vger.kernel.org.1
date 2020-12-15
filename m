Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0262DAC84
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 13:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgLOL63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 06:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbgLOL6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 06:58:10 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F020C06179C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 03:57:30 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id k10so16637688wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 03:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=QoOPRl84dn2oKZTg+ZEq0t+AX/2LfZIV7tg2IP07IX4=;
        b=J1rTQ06yt+iQ25tLOMNHttJ09Z8xx8DNTvFK1z4BLc89vzZuLGMWt5B0Ph4cFTSjg+
         tnCfpVYNb/sDPw2CakPfq6GI4szOwjfnCGW4l+2ZuHVpr4KhKvCb2FOZKqIoR7hK1DdY
         22mA+odPuF0d9JzuR0408JDknj1khQP2OkIrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=QoOPRl84dn2oKZTg+ZEq0t+AX/2LfZIV7tg2IP07IX4=;
        b=T8VeEn5gVKIMtcBVf7r09V90rrWABgxENTwHOVMgUtoAHM2s6ZqoBjGdV9pAn2y72C
         MLJfI3xyzmD0exYTSHtLmpcyil3L2zmLSZkSxA3GuPcal0eIahFHMJ0jsurDxY0DdweZ
         FJjF+nTmlHeDboYDLJz1nrt7e6d5o4Eh0QHi4IzRpw+iOFYxXnI/hXj+d0TykcOU/J0h
         bh50WpaxXM9HQ4d+y1opPBPK8Lrj0TtnZyU63rD+lX4xRyAlESSs5PHxu3erYeUPY1nT
         hft6oUx3G+zPjbjvn5A/SUCnRk3v6tZbK+A0shAu2V2itWMAWxf+ZVDLNSZa8k6919PD
         obrg==
X-Gm-Message-State: AOAM530LlDlcsT+D5Nd+nWkKWY0P3xbPMQOCY/mo/1El/UkmNB5br2/X
        OFRUn4AWlHW/MNytZ7FUBIkOKw==
X-Google-Smtp-Source: ABdhPJxLhg5oDzaChXMtbZz1Fc1+4sstZfmn90NRubflR2wQ4hp27VDpAP4boTlNgJs3aXwIOEod2g==
X-Received: by 2002:a1c:2d92:: with SMTP id t140mr9936339wmt.114.1608033449070;
        Tue, 15 Dec 2020 03:57:29 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id m17sm40710713wrn.0.2020.12.15.03.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 03:57:28 -0800 (PST)
Date:   Tue, 15 Dec 2020 12:57:26 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, tzimmermann@suse.de,
        kraxel@redhat.com, alexander.deucher@amd.com, tglx@linutronix.de,
        dri-devel@lists.freedesktop.org, xinliang.liu@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH drm/hisilicon 1/2] drm/irq: Add the new api to enable pci
 msi
Message-ID: <X9ikpqdJDgfulvL+@phenom.ffwll.local>
Mail-Followup-To: Tian Tao <tiantao6@hisilicon.com>, airlied@linux.ie,
        tzimmermann@suse.de, kraxel@redhat.com, alexander.deucher@amd.com,
        tglx@linutronix.de, dri-devel@lists.freedesktop.org,
        xinliang.liu@linaro.org, linux-kernel@vger.kernel.org
References: <1608032933-50187-1-git-send-email-tiantao6@hisilicon.com>
 <1608032933-50187-2-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1608032933-50187-2-git-send-email-tiantao6@hisilicon.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 07:48:52PM +0800, Tian Tao wrote:
> Add new api devm_drm_msi_install() to register interrupts,
> no need to call pci_disable_msi() when the drm module is removed.
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
>  drivers/gpu/drm/drm_irq.c | 33 +++++++++++++++++++++++++++++++++
>  include/drm/drm_irq.h     |  1 +
>  2 files changed, 34 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_irq.c b/drivers/gpu/drm/drm_irq.c
> index 803af4b..da58b2c 100644
> --- a/drivers/gpu/drm/drm_irq.c
> +++ b/drivers/gpu/drm/drm_irq.c
> @@ -246,6 +246,39 @@ int devm_drm_irq_install(struct drm_device *dev, int irq)
>  }
>  EXPORT_SYMBOL(devm_drm_irq_install);
>  
> +static void devm_drm_msi_uninstall(void *data)
> +{
> +	struct drm_device *dev = (struct drm_device *)data;
> +
> +	pci_disable_msi(dev->pdev);

This should be in the pci core, not in drm.
-Daniel

> +}
> +
> +/**
> + * devm_drm_msi_install - install IRQ handler
> + * @dev: DRM device
> + *
> + * devm_drm_msi_install is a  help function of pci_enable_msi.
> + *
> + * if the driver uses devm_drm_msi_install, there is no need
> + * to call pci_disable_msi when the drm module get unloaded,
> + * as this will done automagically.
> + *
> + * Returns:
> + * Zero on success or a negative error code on failure.
> + */
> +int devm_drm_msi_install(struct drm_device *dev)
> +{
> +	int ret;
> +
> +	ret = pci_enable_msi(dev->pdev);
> +	if (ret)
> +		return ret;
> +
> +	return devm_add_action_or_reset(dev->dev,
> +					devm_drm_msi_uninstall, dev);
> +}
> +EXPORT_SYMBOL(devm_drm_msi_install);
> +
>  #if IS_ENABLED(CONFIG_DRM_LEGACY)
>  int drm_legacy_irq_control(struct drm_device *dev, void *data,
>  			   struct drm_file *file_priv)
> diff --git a/include/drm/drm_irq.h b/include/drm/drm_irq.h
> index 631b22f..c8dff45 100644
> --- a/include/drm/drm_irq.h
> +++ b/include/drm/drm_irq.h
> @@ -29,4 +29,5 @@ struct drm_device;
>  int drm_irq_install(struct drm_device *dev, int irq);
>  int drm_irq_uninstall(struct drm_device *dev);
>  int devm_drm_irq_install(struct drm_device *dev, int irq);
> +int devm_drm_msi_install(struct drm_device *dev);
>  #endif
> -- 
> 2.7.4
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
