Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 491252F3220
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 14:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389430AbhALNpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 08:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389332AbhALNpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 08:45:16 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B437C061786
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 05:44:34 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d26so2520342wrb.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 05:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7+CygbaNK8RHrTYKRH9okC/C8+mWeFn+wpyKag9alwM=;
        b=nb2va2lASe6ml4oEgsCucR2h4msVpa/5PWlMPxNIr3yB+4cvOjhdTE4RKYQEzeFzzH
         oiivQ5vvm9GCeZww1BgVbRfNGh2y18UHOlMD5gMo9D7R7/IwddYyhB3/IncauhM8P8bf
         NSQ8Vz40gJ2a9+HkIYXJCKt0hH8yCvN578LOFHcfXSesl/qX0XCieF7bXmUVuX3YZ79g
         LjbJosVcLaZCikduTj06Ie7qp7NMICNlavL6di1bEZID437VdvD1uMnAgkz8/EaVqjc3
         5vuoIamKNyat/YfZ9MQPmNxb0lNrt9GiGTHGEciDLlWOgc3bGaFpr8SyUzAb8qzTfwPo
         IHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7+CygbaNK8RHrTYKRH9okC/C8+mWeFn+wpyKag9alwM=;
        b=TAfPuaX+cOln69bj/6nAGhTU43khYRgpOAxZfl13Svua9z/ywaYan9+WbeQcy2vNVh
         ox+bCCy0XZfW4ODl0WizjpU+yTOa5KqNmk4U1tF4fJsAELqqp7v/iG4L0o8AREjZQUFK
         d+rEcNjEwU7PLJfMBfzS5hxi+NfHcccaHwp00UXAGxvsqGjyJpB6MXKZQTDL1ESN2ODI
         v6P400ysmUdjFI8+Bog+1viAwv47dWiE5GrG30pRLSQKifCsG+muPGNKECPys7lqYQTh
         0XJD0Qe41vsCM7R79lhCXP/SUxP9s8VbbG9FhE2fPMAkhEwNAMSVpYABume4dfmQ09mo
         RGEQ==
X-Gm-Message-State: AOAM533NIjsfo3cxeKdDSljCMoZBYqYaGMBibmD3ULqM3mv3/IUqqdjS
        y7DlOY55PnbKeUGLJs8H6//3HpFbCwwPipjl
X-Google-Smtp-Source: ABdhPJzZqlNguZvDKi2CFA1mo99Wnpi9WTqm4JhWMkWTz2Hy16qA5C3yjzwttwDyYbr3GW6kYbgLUg==
X-Received: by 2002:adf:e84f:: with SMTP id d15mr4464921wrn.245.1610459072649;
        Tue, 12 Jan 2021 05:44:32 -0800 (PST)
Received: from dell ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id y68sm4561267wmc.0.2021.01.12.05.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 05:44:32 -0800 (PST)
Date:   Tue, 12 Jan 2021 13:44:30 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Colin Ian King <colin.king@canonical.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 13/40] drm/amd/display/dc/calcs/dce_calcs: Move some
 large variables from the stack to the heap
Message-ID: <20210112134430.GA3975472@dell>
References: <20210111191926.3688443-1-lee.jones@linaro.org>
 <20210111191926.3688443-14-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210111191926.3688443-14-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jan 2021, Lee Jones wrote:

> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c: In function ‘calculate_bandwidth’:
>  drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:2016:1: warning: the frame size of 1216 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> 
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Colin Ian King <colin.king@canonical.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  .../gpu/drm/amd/display/dc/calcs/dce_calcs.c  | 21 +++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> index 158d927c03e55..a0c69fae40ced 100644
> --- a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> +++ b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> @@ -98,16 +98,16 @@ static void calculate_bandwidth(
>  	int32_t num_cursor_lines;
>  
>  	int32_t i, j, k;
> -	struct bw_fixed yclk[3];
> -	struct bw_fixed sclk[8];
> +	struct bw_fixed *yclk;
> +	struct bw_fixed *sclk;
>  	bool d0_underlay_enable;
>  	bool d1_underlay_enable;
>  	bool fbc_enabled;
>  	bool lpt_enabled;
>  	enum bw_defines sclk_message;
>  	enum bw_defines yclk_message;
> -	enum bw_defines tiling_mode[maximum_number_of_surfaces];
> -	enum bw_defines surface_type[maximum_number_of_surfaces];
> +	enum bw_defines *tiling_mode;
> +	enum bw_defines *surface_type;
>  	enum bw_defines voltage;
>  	enum bw_defines pipe_check;
>  	enum bw_defines hsr_check;
> @@ -122,6 +122,14 @@ static void calculate_bandwidth(
>  	int32_t number_of_displays_enabled_with_margin = 0;
>  	int32_t number_of_aligned_displays_with_no_margin = 0;
>  
> +	yclk = kzalloc(sizeof(*yclk) * 3, GFP_KERNEL);
> +	sclk = kzalloc(sizeof(*sclk) * 8, GFP_KERNEL);
> +
> +	tiling_mode = kzalloc(sizeof(*tiling_mode) *
> +			      maximum_number_of_surfaces, GFP_KERNEL);
> +	surface_type = kzalloc(sizeof(*surface_type) *
> +			       maximum_number_of_surfaces, GFP_KERNEL);

Please refrain from merging this yet.  I missed some error checking.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
