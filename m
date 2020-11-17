Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B082B6EFC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 20:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729715AbgKQTms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 14:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbgKQTmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 14:42:47 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE59AC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 11:42:45 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id 19so4525214wmf.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 11:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XGs5p15J8bd5oqq6/dG9hT/mjPxqhlpssSOVNxzVtFM=;
        b=NpcCAgOs/piKyNmzQiACjZTYxvL2yjyugx8dHk4QCDhX4CIz1pTMkikkPzjuR2mgZ2
         pl0p2L8ktXBfDFPTAoQ4vbEcunA+disS9eRbz1Z4bq8LP/MMa3T0jlBQjGVW30hHCW5D
         5Cl66XhYnCjpD0StUM7x581A6dlpy+EJwridI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=XGs5p15J8bd5oqq6/dG9hT/mjPxqhlpssSOVNxzVtFM=;
        b=Rh3bzk4f+h9CqCLUxhqK0/XxV7tgxbfabY+9q887DxTZwyoHRP1dMlI6ax8SmMT8UB
         fQ2KaxGzDLKamRMZz/DVy77y98BR6PNQDusbZTC5qiHrEHYiqVlWMn5uhMkPy5n9WjIv
         cJUNTHoCkowc5caLt/72BEODFBf1VVAGArQoeglC0XVTzmZWlSHTO0jsmIlf3Zmr7hqH
         JdzB0gIOnZ9daV0BUBxzXpKcYPJYfGVE8GLDlTWef02/HnjDUYPMdNlBQPo5YaBQ5gCJ
         B2b6uvae149un8SavT2q5/Ap5f4VgSeLX51POmPPAc3skQk6RP8hb2Di5XGPF38Hmm6A
         nNuQ==
X-Gm-Message-State: AOAM530mvFZbH/Gz4tg2rtfIzwLXReuWqlPzpK2X4SI5SeF5/HMH8ROa
        J8o2WkNd8xyc3Z+iwISyAnUqdg==
X-Google-Smtp-Source: ABdhPJwVbcfxoBso9bSJ7ajbgO2usBTSTH0E5tmNwKeJ8uY174HnqMGXWvFrSeBq6NuuMMTCtciAjw==
X-Received: by 2002:a7b:c055:: with SMTP id u21mr703539wmc.130.1605642164543;
        Tue, 17 Nov 2020 11:42:44 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 90sm8872735wrl.60.2020.11.17.11.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 11:42:43 -0800 (PST)
Date:   Tue, 17 Nov 2020 20:42:41 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 42/42] include/drm/drm_atomic: Make use of
 'new_crtc_state'
Message-ID: <20201117194241.GV401619@phenom.ffwll.local>
Mail-Followup-To: Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, dri-devel@lists.freedesktop.org
References: <20201116174112.1833368-1-lee.jones@linaro.org>
 <20201116174112.1833368-43-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201116174112.1833368-43-lee.jones@linaro.org>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 05:41:12PM +0000, Lee Jones wrote:
> In the macro for_each_oldnew_crtc_in_state() 'crtc_state' is provided
> as a container for state->crtcs[i].new_state, but is not utilised in
> some use-cases, so we fake-use it instead.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/gpu/drm/imx/ipuv3-plane.c: In function ‘ipu_planes_assign_pre’:
>  drivers/gpu/drm/imx/ipuv3-plane.c:746:42: warning: variable ‘crtc_state’ set but not used [-Wunused-but-set-variable]
> 
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Ok I merged them all except:
- drm/amd and drm/imx, should be picked up already by respective
  maintainers
- drm/msm, Rob promised to take care

Thanks a lot for your patches.
-Daniel

> ---
>  include/drm/drm_atomic.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
> index dc5e0fbecc04e..54e051a957dfc 100644
> --- a/include/drm/drm_atomic.h
> +++ b/include/drm/drm_atomic.h
> @@ -783,7 +783,8 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
>  			      (void)(crtc) /* Only to avoid unused-but-set-variable warning */, \
>  			     (old_crtc_state) = (__state)->crtcs[__i].old_state, \
>  			     (void)(old_crtc_state) /* Only to avoid unused-but-set-variable warning */, \
> -			     (new_crtc_state) = (__state)->crtcs[__i].new_state, 1))
> +			     (new_crtc_state) = (__state)->crtcs[__i].new_state, \
> +			     (void)(new_crtc_state) /* Only to avoid unused-but-set-variable warning */, 1))
>  
>  /**
>   * for_each_old_crtc_in_state - iterate over all CRTCs in an atomic update
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
