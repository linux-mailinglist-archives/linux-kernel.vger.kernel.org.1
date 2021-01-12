Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C28712F3216
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 14:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388736AbhALNoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 08:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732978AbhALNoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 08:44:11 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF84C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 05:43:31 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id m4so1182891wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 05:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7GPaHBbgnyk5B3N5fI+9q+MKf1p8x47yjYJoIegUJJE=;
        b=T0X7tbY2aa3ykx2c3EoOKFFN975w4TkCn4oK8TOIwtqXxVudL1OJaJ+cg2vjxG8mwN
         GofBdRyGaZ4y5Gd3vxwsigr5+FZA8wi3W5mOBbhaATFC/gVgf7+EscxFQ4Sj2ZLR88rR
         NVlJaHKlMmGMB13G23xEISd67laLcqzvwgyL8qP0zesmcqjSC5DTehToKlfqAID7zRQQ
         +5/04pzaCpIIqYkPqGsVm+e8T8UfX3e3pKkrXS1emn/Ri42Jt+8dhBkZ8xw6FoQKk5tR
         pjEjoTPD4Hp2ywks+xsjWhqYGZq2Q4NLbp0GFFp0iilLiIK/AQm9BDoKUvPtYq6rISAA
         JgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7GPaHBbgnyk5B3N5fI+9q+MKf1p8x47yjYJoIegUJJE=;
        b=eH3urEADMFpkGWuZBGdoMaTm/Qv5Ly97AKKyzw/ywxQ6g4HcicDNI7JLzZ3OlWtwu1
         YU+xj1AJWtvmLls6aue46ZqZZykg73edKMN6Jmo/7Ts0FQaxVnHe7WRqSb5Th4v7aoCs
         c/bgtGvHlpwq+fjtfkiLIttSx3oCZF6d4gX2Yc4giGMg0C2jb6q3zywD3a8YzOfQxjgI
         1dCG0s5IF8e9wkm8PHHGxGxcoTMrinldS8VKeUbQzV6sgKihIusztWuRwXlqLa9mDpJ/
         De2wEi74utehGQDs2qIvDtRA6lqeBRXce+kEkWsXVZnfJLqCD19cxGbsqFL+JYgLO/rJ
         hggA==
X-Gm-Message-State: AOAM531BF2ED/GyJ+hbSdOBTGkAQ4KR4gmwCD2lw6EBKTfbEci6wBaEs
        5KS18s7KHrzdDY7UFUuvIrT4DwpFmJaXPMm5
X-Google-Smtp-Source: ABdhPJw5kBWvWbhmvaWdRe/7kzStPjXQq/PxsdoyNcKzNP+Z+LDSIlF/LpVp1cQg7r47k3Cb+8STSA==
X-Received: by 2002:adf:e406:: with SMTP id g6mr4433015wrm.255.1610459009830;
        Tue, 12 Jan 2021 05:43:29 -0800 (PST)
Received: from dell ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id p15sm5033694wrt.15.2021.01.12.05.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 05:43:28 -0800 (PST)
Date:   Tue, 12 Jan 2021 13:43:27 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 14/40] drm/amd/display/dc/calcs/dce_calcs: Remove some
 large variables from the stack
Message-ID: <20210112134327.GC3575260@dell>
References: <20210111191926.3688443-1-lee.jones@linaro.org>
 <20210111191926.3688443-15-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210111191926.3688443-15-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jan 2021, Lee Jones wrote:

> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c: In function ‘bw_calcs_init’:
>  drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:2726:1: warning: the frame size of 1336 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> 
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  .../gpu/drm/amd/display/dc/calcs/dce_calcs.c  | 1115 +++++++++--------
>  1 file changed, 560 insertions(+), 555 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> index a0c69fae40ced..f69c2b84d432b 100644
> --- a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> +++ b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> @@ -2035,707 +2035,712 @@ void bw_calcs_init(struct bw_calcs_dceip *bw_dceip,
>  	struct bw_calcs_vbios *bw_vbios,
>  	struct hw_asic_id asic_id)
>  {
> -	struct bw_calcs_dceip dceip = { 0 };
> -	struct bw_calcs_vbios vbios = { 0 };
> +	struct bw_calcs_dceip *dceip;
> +	struct bw_calcs_vbios *vbios;
>  
>  	enum bw_calcs_version version = bw_calcs_version_from_asic_id(asic_id);
>  
> -	dceip.version = version;
> +	dceip = kzalloc(sizeof(dceip), GFP_KERNEL);
> +	vbios = kzalloc(sizeof(vbios), GFP_KERNEL);

Please don't review/merge this yet.  I missed some error checking.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
