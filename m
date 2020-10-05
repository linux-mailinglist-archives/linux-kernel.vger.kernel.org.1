Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0112836F1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 15:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgJENwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 09:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgJENwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 09:52:31 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4A6C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 06:52:31 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id t9so1031287wrq.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 06:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=BU4boLaeL27WfaueZ0RdQJHqbd/z9v+OnOYM/rLZ3Ow=;
        b=DUZjBumV8JuqrnnyjcXwlYtvbycyKoyCydnmMpPQH9elgQIqVsFSVENOhXLSZQz0SY
         2A1FxJuN/0Ixrdr3crtRgtSn7frljAGHGD8X+yx3hBOuw6YvXP1/UPBIobGscFEJry/7
         uHb1Zqr3YsAjZ8yb6SNKV4aZt58w1WVzlhWqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=BU4boLaeL27WfaueZ0RdQJHqbd/z9v+OnOYM/rLZ3Ow=;
        b=RIsR4f8lbeZFO+0m/EZ+/KJFXQfH8luI5e6qPnXmnlkQ/eOMEC/tM69iQ8mZwdFuUy
         YslEaFShbmGFn029Q/CLg3aDvSab7bKEpVtuPsXYDcfAFZi4YnduLrnQswlTmwFdechF
         ynDVecW7033UrE6Hm6ox1iWE6Z3pL0i1cpPZuCHObcypQy/iUMzyYQQHCV+5hw0EQ4f2
         8S+tODfv1apGEMa5RubfO3oeEHxacMGW5w7QKjluyUzYHh1ezewITOhfJD0isGeVRwgR
         ju+cVp20yGbJAZs5ChzcNqOrNwxY8GMSGM5mbzcz+Yo6frTc53u6q/Glnam4aX0Vr63d
         pBzA==
X-Gm-Message-State: AOAM533pNbOBPyqF2xWr7bqebnTVPk/dFhqzq8FHkK0eN1nh6+8pFYkQ
        vtvh13mV7HC2FkuRIgTx9NOMiA==
X-Google-Smtp-Source: ABdhPJyUiqJQc9GEz3Iplb2FeLUKTW9rPq9dka/vnODNYjGEudIjUqb9RTp59xqSVAaBl2WFBOqzvw==
X-Received: by 2002:adf:f6cd:: with SMTP id y13mr17676331wrp.161.1601905950163;
        Mon, 05 Oct 2020 06:52:30 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id a127sm6430302wmh.13.2020.10.05.06.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 06:52:29 -0700 (PDT)
Date:   Mon, 5 Oct 2020 15:52:27 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     trix@redhat.com
Cc:     patrik.r.jakobsson@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        natechancellor@gmail.com, ndesaulniers@google.com,
        alan@linux.intel.com, airlied@redhat.com, yakui.zhao@intel.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] drm/gma500: fix double free of gma_connector
Message-ID: <20201005135227.GQ438822@phenom.ffwll.local>
Mail-Followup-To: trix@redhat.com, patrik.r.jakobsson@gmail.com,
        airlied@linux.ie, natechancellor@gmail.com, ndesaulniers@google.com,
        alan@linux.intel.com, airlied@redhat.com, yakui.zhao@intel.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
References: <20201003193928.18869-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201003193928.18869-1-trix@redhat.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 03, 2020 at 12:39:28PM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> clang static analysis reports this problem:
> 
> cdv_intel_dp.c:2101:2: warning: Attempt to free released memory
>         kfree(gma_connector);
>         ^~~~~~~~~~~~~~~~~~~~
> 
> In cdv_intel_dp_init() when the call to cdv_intel_edp_panel_vdd_off()
> fails, the handler calls cdv_intel_dp_destroy(connector) which does
> the first free of gma_connector. So adjust the goto label and skip
> the second free.
> 
> Fixes: d112a8163f83 ("gma500/cdv: Add eDP support")
> Signed-off-by: Tom Rix <trix@redhat.com>

Thanks for your patch, queued in drm-misc-next for 5.11.
-Daniel

> ---
>  drivers/gpu/drm/gma500/cdv_intel_dp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/gma500/cdv_intel_dp.c b/drivers/gpu/drm/gma500/cdv_intel_dp.c
> index 720a767118c9..deb4fd13591d 100644
> --- a/drivers/gpu/drm/gma500/cdv_intel_dp.c
> +++ b/drivers/gpu/drm/gma500/cdv_intel_dp.c
> @@ -2083,7 +2083,7 @@ cdv_intel_dp_init(struct drm_device *dev, struct psb_intel_mode_device *mode_dev
>  			DRM_INFO("failed to retrieve link info, disabling eDP\n");
>  			drm_encoder_cleanup(encoder);
>  			cdv_intel_dp_destroy(connector);
> -			goto err_priv;
> +			goto err_connector;
>  		} else {
>          		DRM_DEBUG_KMS("DPCD: Rev=%x LN_Rate=%x LN_CNT=%x LN_DOWNSP=%x\n",
>  				intel_dp->dpcd[0], intel_dp->dpcd[1], 
> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
