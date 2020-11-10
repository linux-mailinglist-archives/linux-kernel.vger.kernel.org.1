Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A832AD847
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 15:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730532AbgKJOIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 09:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730097AbgKJOIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 09:08:52 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26415C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 06:08:51 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id c9so3114086wml.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 06:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=RHr39ngr2B+98zAW9jkqgki28PWEHHD7DNBOpDOqDEA=;
        b=HV1vFSLajmjs7V264buCdkrOFNMsf0AR4R2hGN0vxaEboCaCkqKyTt32hrxiJaCQ6a
         xpaCGLcM4OxSX4xZjVrRoIWK17F9mTjWLKImBON99/hUj5iTEMC+GZGqicywHlFP4Z6g
         yPiVnDaCenDdW1OUxo3QB8QeHLBHTT1pCWbQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=RHr39ngr2B+98zAW9jkqgki28PWEHHD7DNBOpDOqDEA=;
        b=gvAtGxDnpwZiqBkB+tmJwDuD+hcEk5WoOrRbX5uR0sNBWmMAxWnnixQWw884hGQZ7x
         0tQur1hdN+N6vUsB2m60MNmgSHeSHY/D99gw/QULJXz+/li/pzZL4PBeAp6bIX1rEDq2
         CvvgWB3eOVnCyq9X6RHCTkpTEl0SkEivyFp2FyebF3Yyj/NbbsYIN9r4RS/jTCmrRyd9
         stm9+hvAtKsJm5fT3OLN7cZUxsvNsszbnKCpqCcqYWocOMCBozZ2nc3d2wIkUAlDW8L4
         M1cEJa7/FjpczO1m3agxvhBhsTVYepZ28tjNQhqrDPRxDGHItDAJAg5UKB4uHiUqDfnR
         aTOg==
X-Gm-Message-State: AOAM530KZzJZOqCHAX5gUEcCew9Yp8rBc4e1+jndQBwI/C3V1DP88lWR
        DV8j5rzWRmAXKXATicbA8wb2Gg==
X-Google-Smtp-Source: ABdhPJzk1WfduW7a7nXeRjJ0/LZCZ0FXcXwBYE+Pjgm1rOGjGVBG+u8E0OPSh7xm+PDQHm5FFQFHhw==
X-Received: by 2002:a7b:c242:: with SMTP id b2mr4985003wmj.162.1605017329923;
        Tue, 10 Nov 2020 06:08:49 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t23sm3073142wmn.4.2020.11.10.06.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 06:08:49 -0800 (PST)
Date:   Tue, 10 Nov 2020 15:08:46 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Deepak R Varma <mh12gx2825@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH v2] drm/vgem: replace idr_init() by idr_init_base()
Message-ID: <20201110140846.GH401619@phenom.ffwll.local>
Mail-Followup-To: Deepak R Varma <mh12gx2825@gmail.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org
References: <20201105173646.GA41732@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105173646.GA41732@localhost>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 11:06:46PM +0530, Deepak R Varma wrote:
> idr_init() uses base 0 which is an invalid identifier. The new function
> idr_init_base allows IDR to set the ID lookup from base 1. This avoids
> all lookups that otherwise starts from 0 since 0 is always unused.
> 
> References: commit 6ce711f27500 ("idr: Make 1-based IDRs more efficient")
> 
> Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>

Applied to drm-misc-next, thanks fory our patch.
-Daniel

> ---
> Changes since v1:
>    - Changes suggested by Daniel Vetter:
>      1. Correct typo in patch summary
>      2. cc intel-gfx to get the patch through CI bot test
> 
>  drivers/gpu/drm/vgem/vgem_fence.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/vgem/vgem_fence.c b/drivers/gpu/drm/vgem/vgem_fence.c
> index 17f32f550dd9..2902dc6e64fa 100644
> --- a/drivers/gpu/drm/vgem/vgem_fence.c
> +++ b/drivers/gpu/drm/vgem/vgem_fence.c
> @@ -233,7 +233,7 @@ int vgem_fence_signal_ioctl(struct drm_device *dev,
>  int vgem_fence_open(struct vgem_file *vfile)
>  {
>  	mutex_init(&vfile->fence_mutex);
> -	idr_init(&vfile->fence_idr);
> +	idr_init_base(&vfile->fence_idr, 1);
>  
>  	return 0;
>  }
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
