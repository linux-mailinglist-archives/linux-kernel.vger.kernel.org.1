Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6182EF425
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 15:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbhAHOqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 09:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbhAHOq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 09:46:29 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAFDC0612FD
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 06:45:48 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 190so8027536wmz.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 06:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=nHZfmrLsnCXU18P2naZwZ/rk6gM2XqRiNjrN0fvyktI=;
        b=aKFaDhyA2RcZhDG52kY8ATxpamcGN/eDNi7Vbe1TQe0T4tDcd/HefsMQ1nkVR+21+I
         nau/AVOiziFGCjzSyHvbbF9zvOd5ZXB3rD90v9+3wS0zRzq7yqVGC3ZNpWqyBNmbe0Al
         xA1qoClAZdaMsHpketUzfz2Iteo2ZJgWFzUcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=nHZfmrLsnCXU18P2naZwZ/rk6gM2XqRiNjrN0fvyktI=;
        b=HWuC3wqhrTSUDCX/YfgV2U515YtsewLyR5dbpJU51swst0Qve9edBWe1ydheAZUWwH
         rRtCUsCJaX0PArC0LKY0siOugsqxZkm0uFtgTULjYt742KJT2+oAyMj6v6GbYT62VYY5
         /nr9wgWBlvQsgI9PHC0h+5inbFxPE5OMqqrU67GJM0EjYO9mYbbRTp9xTfPLc/nskFs+
         pUblV39yTfJqPmFOVzWnVoCqbv7yUZ89VZxgwF5LzkEoKXN9Sa1OypMTKVIWNHWoZ3Be
         13OxCjQl4OP1ANut9izNkU+EAozVxTfUYRSKQbuo/ALJt433XPt2m3Uu4gO6MpUPXhdD
         vCyA==
X-Gm-Message-State: AOAM5319zWU1+HOdIoewFRyxldTePpOXagpvkAKQtW6VQo5wbEQlUGmM
        b36cbKFlToqXInVfTzuMwxP14g==
X-Google-Smtp-Source: ABdhPJx9bsKSk3qdvWYUOz7Vz9aIwqpXCI4fvqlSKmubOv9ofxQQ02mrBxPZp+5JbuiSp2vd9T01NQ==
X-Received: by 2002:a1c:4384:: with SMTP id q126mr3426381wma.84.1610117147582;
        Fri, 08 Jan 2021 06:45:47 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id c4sm15815677wrw.72.2021.01.08.06.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 06:45:46 -0800 (PST)
Date:   Fri, 8 Jan 2021 15:45:45 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, tzimmermann@suse.de,
        kraxel@redhat.com, alexander.deucher@amd.com, tglx@linutronix.de,
        dri-devel@lists.freedesktop.org, xinliang.liu@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/hisilicon: Delete the empty function mode_valid
Message-ID: <X/hwGbCQ8mM4W4Dl@phenom.ffwll.local>
Mail-Followup-To: Tian Tao <tiantao6@hisilicon.com>, airlied@linux.ie,
        tzimmermann@suse.de, kraxel@redhat.com, alexander.deucher@amd.com,
        tglx@linutronix.de, dri-devel@lists.freedesktop.org,
        xinliang.liu@linaro.org, linux-kernel@vger.kernel.org
References: <1610102465-36501-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610102465-36501-1-git-send-email-tiantao6@hisilicon.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 06:41:05PM +0800, Tian Tao wrote:
> Based on the drm_connector_mode_valid, if the hibmc implementation
> of mode_valid only returns MODE_OK, then we can not implement the

s/can not/need not/

> mode_valid function.
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
> index c76f996..c74a35b 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
> @@ -43,12 +43,6 @@ static int hibmc_connector_get_modes(struct drm_connector *connector)
>  	return count;
>  }
>  
> -static enum drm_mode_status hibmc_connector_mode_valid(struct drm_connector *connector,
> -						       struct drm_display_mode *mode)
> -{
> -	return MODE_OK;
> -}
> -
>  static void hibmc_connector_destroy(struct drm_connector *connector)
>  {
>  	struct hibmc_connector *hibmc_connector = to_hibmc_connector(connector);
> @@ -60,7 +54,6 @@ static void hibmc_connector_destroy(struct drm_connector *connector)
>  static const struct drm_connector_helper_funcs
>  	hibmc_connector_helper_funcs = {
>  	.get_modes = hibmc_connector_get_modes,
> -	.mode_valid = hibmc_connector_mode_valid,
>  };
>  
>  static const struct drm_connector_funcs hibmc_connector_funcs = {
> -- 
> 2.7.4
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
