Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEA82A675E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 16:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730603AbgKDPUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 10:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730564AbgKDPUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 10:20:21 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDFCC061A4A
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 07:20:21 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id w1so21719959edv.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 07:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=9iHINUPztdXJT1/XCPbKjId6dxADhBL2QcIoiIOznIw=;
        b=vSPFqA8r2PbLFpSFPOF0HHZS1aGu+jgHNhjs0zSutvtxG3TPtJv4tLouv7B417H7R5
         6GFEaf12h5P+TJDjtKH0Pb+70xBpoKdYXLGU2KqpU4hv3lng0SivYVFvIqnhZLRbUrk4
         tu89ZLgNieR04bW7rvse9oJVl+TphAdB7z/u2u99o6+jnbaV7evSzrjwBYWy+QQlIuwE
         dkSff4xpYM6m27xQtEMrzOJU7bP6YfBQJ9Z2N/YwOP6EOyxi+1XUZJWrud74oHOGfA0B
         ptRfjuOltZLtFOZAJFxrY3EArR+p0zaXWD3gboZ3ggCoZ6AjXQObi35Fpkkryu522wdO
         hqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=9iHINUPztdXJT1/XCPbKjId6dxADhBL2QcIoiIOznIw=;
        b=pL8ar4jPMTWATN6FbuEVU0LUG6QoLsyawSrLw83ThFug8TY1fwv3hNy0p1ONmANN7i
         5VChpAmdm5UlmX5mdMTn2dxyTZqzEFhpFqGC8G+bhLYqgs+nzYf2mYJvXGRclMu72LSy
         /IqiZ/Hn25G2sPOFySCAtrEQhlXgiooWWBVdqXdS0L2eG0vILj6vlC426ldRsFiHUlc+
         vEz61Z4IJlyuqPS+8C3N4+I3WG2jIWlSYRODdekbjG5oIt0aLpHB/F9eeANVSYF8YFQB
         rTc45Fao58MDXxjoRxRBsCmzI3+zy10rLSlyqJ0JgAH14eIZPfvbHtopMFFD00bo1auz
         tDSw==
X-Gm-Message-State: AOAM5308l4NyKVC3GF5B+sRfo6Ij3vMH59AFOnmn6xRC8/CeIUpxi/uz
        Zltr7qPCtRVzrGSWTVuO6ZFokbma9iA=
X-Google-Smtp-Source: ABdhPJy+J2KPbmkO9Ole5/OvXG6TfuEtPx1fnftkDEYDhniSshEU7K3eTaHLQE4Ue/qXqWGf0Ig+cg==
X-Received: by 2002:a05:6402:3136:: with SMTP id dd22mr15592036edb.256.1604503220063;
        Wed, 04 Nov 2020 07:20:20 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id 22sm1157421ejw.27.2020.11.04.07.20.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 07:20:19 -0800 (PST)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH] drm/amdgpu: replace idr_init() by idr_init_base()
To:     Deepak R Varma <mh12gx2825@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20201104151630.GA69221@localhost>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <765f1539-c657-ede4-96d6-586555f5e658@gmail.com>
Date:   Wed, 4 Nov 2020 16:20:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201104151630.GA69221@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 04.11.20 um 16:16 schrieb Deepak R Varma:
> idr_init() uses base 0 which is an invalid identifier. The new function
> idr_init_base allows IDR to set the ID lookup from base 1. This avoids
> all lookups that otherwise starts from 0 since 0 is always unused.
>
> References: commit 6ce711f27500 ("idr: Make 1-based IDRs more efficient")
>
> Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index c80d8339f58c..b98ae173a9de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -576,7 +576,7 @@ int amdgpu_ctx_wait_prev_fence(struct amdgpu_ctx *ctx,
>   void amdgpu_ctx_mgr_init(struct amdgpu_ctx_mgr *mgr)
>   {
>   	mutex_init(&mgr->lock);
> -	idr_init(&mgr->ctx_handles);
> +	idr_init_base(&mgr->ctx_handles, 1);
>   }
>   
>   long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index efda38349a03..d65a1888683b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1052,7 +1052,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>   	}
>   
>   	mutex_init(&fpriv->bo_list_lock);
> -	idr_init(&fpriv->bo_list_handles);
> +	idr_init_base(&fpriv->bo_list_handles, 1);
>   
>   	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index df110afa97bf..0154282771c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -3199,7 +3199,7 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
>   	adev->vm_manager.vm_update_mode = 0;
>   #endif
>   
> -	idr_init(&adev->vm_manager.pasid_idr);
> +	idr_init_base(&adev->vm_manager.pasid_idr, 1);
>   	spin_lock_init(&adev->vm_manager.pasid_lock);
>   }
>   

