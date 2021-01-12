Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D26692F2C56
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 11:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392983AbhALKLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 05:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392944AbhALKLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 05:11:00 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0CEC061795
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 02:10:19 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id i63so1377871wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 02:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Bkg2PXaK2SWANw8IwP/AMIZLmCDZjaC0dDjfjSGMESw=;
        b=cxc3zmOOc8O4IH8V6hTkqvkq98jk+G0emPgAZJC4oEe9QTrnrtZqlQ7xqb+AWCjSWI
         9/CkLrijkGHQKj73HYCupxLFnlL3Y8d+pLHhBschRr/rq048z7ric/I1xr8+8t7AXml5
         a9v9NRGeeiONW1Cq3IFgq7Ul8aIgEKICYHmkG9N3hfUymD9i1L76tHGA5npX9IEkxyDA
         WkrP8L2n7ggp3PYaG/Wk8z2h1Kmnl/7q1Yof+15+CzeoQJ1gprctEBD/W3atO5hIirDg
         zt6HzVfEGQUSDK/rXiIVrXrORi+DKrMIE5Zt3uLM9BXa0vVM+s+UAHxPseo5esWwbBTT
         BcSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bkg2PXaK2SWANw8IwP/AMIZLmCDZjaC0dDjfjSGMESw=;
        b=inYgXUTLG+Eq7s7NOc5Glja7WzaahWHMkhWDYMhUy47ZzkNYFic/9JuBkFyfJ6jZRg
         NwmM3Nyk7c/1S0rbndOg6fseQqx45xF2TFY8syQ/NZgcbMDBBnLpHWq9btxB4nUVHlgU
         0iVqabSVb+Dc1kfI0KqVcOLF+YmwV8JXXjQDRedkptskmLkBha5mr0KFSqgtyq56Llrr
         YQKZ4zdMKoPxRWG3lLz2Z1G1r76k2km3JUZbJXHHxi45NhsT/l5PuKLzm5MLdnZL4jOR
         nRA7qjtMJo9cQrS+smmjuLPNxkyMU2IXUHDlhGTwbolD0KRgc4/UxRa/ihlXU6NWYxty
         mb4A==
X-Gm-Message-State: AOAM533HBTyOhae2ShhwzWr+c5qun7dwKBzDyRUmqAr3OHc8BG6RTJz4
        jLDPjlBwHP03yadRaAFmhus=
X-Google-Smtp-Source: ABdhPJxuWOHW4lhj241hPPbd10QF7Z7fViELfDVwFn+N7EUI4aG71W/c6XV/k326Dgsw7Hrg1Tl4fQ==
X-Received: by 2002:a05:600c:2158:: with SMTP id v24mr2716731wml.129.1610446218465;
        Tue, 12 Jan 2021 02:10:18 -0800 (PST)
Received: from smtp.gmail.com (a95-92-181-29.cpe.netcabo.pt. [95.92.181.29])
        by smtp.gmail.com with ESMTPSA id s133sm3158707wmf.38.2021.01.12.02.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 02:10:17 -0800 (PST)
Date:   Tue, 12 Jan 2021 07:10:12 -0300
From:   Melissa Wen <melissa.srw@gmail.com>
To:     Sumera Priyadarsini <sylphrenadin@gmail.com>
Cc:     rodrigosiqueiramelo@gmail.com, hamohammed.sa@gmail.com,
        daniel@ffwll.ch, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 2/3] drm/vkms: Add support for writeback module
Message-ID: <20210112101012.a6mjwhtmtj3k34wt@smtp.gmail.com>
References: <cover.1610391685.git.sylphrenadin@gmail.com>
 <15802da4f1cdfed2b728c3d35731732f161dd073.1610391685.git.sylphrenadin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15802da4f1cdfed2b728c3d35731732f161dd073.1610391685.git.sylphrenadin@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12, Sumera Priyadarsini wrote:
> Add enable_writeback feature to vkms_config as a module.
> 
> Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
> ---
>  drivers/gpu/drm/vkms/vkms_drv.c    | 5 +++++
>  drivers/gpu/drm/vkms/vkms_drv.h    | 1 +
>  drivers/gpu/drm/vkms/vkms_output.c | 9 ++++++---
>  3 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> index 6b33975a5cb2..708f7f54001d 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.c
> +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> @@ -40,6 +40,10 @@ static bool enable_cursor = true;
>  module_param_named(enable_cursor, enable_cursor, bool, 0444);
>  MODULE_PARM_DESC(enable_cursor, "Enable/Disable cursor support");
>  
> +static bool enable_writeback = true;
> +module_param_named(enable_writeback, enable_writeback, bool, 0444);
> +MODULE_PARM_DESC(enable_writeback, "Enable/Disable writeback connector support");
> +
>  DEFINE_DRM_GEM_FOPS(vkms_driver_fops);
>  
>  static void vkms_release(struct drm_device *dev)
> @@ -189,6 +193,7 @@ static int __init vkms_init(void)
>  	default_config = config;
>  
>  	config->cursor = enable_cursor;
> +	config->writeback = enable_writeback;
>  
>  	return vkms_create(config);
>  }
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> index 6a27bd8875f2..b9b4e2bc11c0 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.h
> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> @@ -83,6 +83,7 @@ struct vkms_output {
>  struct vkms_device;
>  
>  struct vkms_config {
> +	bool writeback;
>  	bool cursor;
>  	/* only set when instantiated */
>  	struct vkms_device *dev;
> diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
> index 8f3ffb28b9d1..f5f6f15c362c 100644
> --- a/drivers/gpu/drm/vkms/vkms_output.c
> +++ b/drivers/gpu/drm/vkms/vkms_output.c
> @@ -41,6 +41,7 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
>  	struct drm_crtc *crtc = &output->crtc;
>  	struct drm_plane *primary, *cursor = NULL;
>  	int ret;
> +	int writeback;
>  
>  	primary = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_PRIMARY, index);
>  	if (IS_ERR(primary))
> @@ -80,9 +81,11 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
>  		goto err_attach;
>  	}
>  
> -	ret = vkms_enable_writeback_connector(vkmsdev);
> -	if (ret)
> -		DRM_ERROR("Failed to init writeback connector\n");
> +	if (vkmsdev->config->writeback) {
> +		writeback = vkms_enable_writeback_connector(vkmsdev);
> +		if (writeback)
> +			DRM_ERROR("Failed to init writeback connector\n");
> +	}

Thanks,

Reviewed-by: Melissa Wen <melissa.srw@gmail.com>

>
>  	drm_mode_config_reset(dev);
>  
> -- 
> 2.25.1
>
