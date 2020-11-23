Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E8D2C17A4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 22:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbgKWVXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 16:23:34 -0500
Received: from z5.mailgun.us ([104.130.96.5]:17978 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgKWVXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 16:23:33 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606166612; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=lQpDYY+11TFASEzr4WpQgNQgUN6/TRcIX2t5gwzRE4U=;
 b=nGrRI7PBCWIA/fHSqEEiDj/994lwfNsqOzKeO2heIgPmhXPZWNxV7I4gnChBQYueGyobsvDT
 /Uln/vYA4ZWzqX+k03mr3g/G3tthy5stN2qdaK9zhjXcVuBT4LAVDPB+oO3rEEsm7YQ9OAco
 fPL8oj/pGcx/lKdHcXU2UUDc/EY=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5fbc284e7ef0a8d84323d385 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 23 Nov 2020 21:23:26
 GMT
Sender: abhinavk=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7E17BC43464; Mon, 23 Nov 2020 21:23:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: abhinavk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 49900C433C6;
        Mon, 23 Nov 2020 21:23:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 23 Nov 2020 13:23:25 -0800
From:   abhinavk@codeaurora.org
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH 14/40] drm/msm/disp/dpu1/dpu_hw_catalog: Move definitions
 to the only place they are used
In-Reply-To: <20201123111919.233376-15-lee.jones@linaro.org>
References: <20201123111919.233376-1-lee.jones@linaro.org>
 <20201123111919.233376-15-lee.jones@linaro.org>
Message-ID: <56afb74961dab35946922ec5fed91502@codeaurora.org>
X-Sender: abhinavk@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-23 03:18, Lee Jones wrote:
> These tables are not large or overbearing, so moving them into the
> source file seems like the right thing to do.  The alternative is to
> use __maybe_unused, which is undesirable.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  In file included from 
> drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c:11:
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog_format.h:7:23: warning:
> ‘qcom_compressed_supported_formats’ defined but not used
> [-Wunused-const-variable=]
>  7 | static const uint32_t qcom_compressed_supported_formats[] = {
>  | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog_format.h:48:23: warning:
> ‘plane_formats_yuv’ defined but not used [-Wunused-const-variable=]
>  48 | static const uint32_t plane_formats_yuv[] = {
>  | ^~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog_format.h:17:23: warning:
> ‘plane_formats’ defined but not used [-Wunused-const-variable=]
>  17 | static const uint32_t plane_formats[] = {
>  | ^~~~~~~~~~~~~
> 
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: freedreno@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
I think this is reasonable,
Reviewed-by: Abhinav Kumar <abhinavk@codeaurora.org>
> ---
>  .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    | 74 +++++++++++++++-
>  .../drm/msm/disp/dpu1/dpu_hw_catalog_format.h | 88 -------------------
>  drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c     | 11 ++-
>  3 files changed, 83 insertions(+), 90 deletions(-)
>  delete mode 100644 
> drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog_format.h
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> index a7004f18523b0..9ed6d0c6cd9b2 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> @@ -8,7 +8,6 @@
>  #include <linux/platform_device.h>
>  #include "dpu_hw_mdss.h"
>  #include "dpu_hw_catalog.h"
> -#include "dpu_hw_catalog_format.h"
>  #include "dpu_kms.h"
> 
>  #define VIG_MASK \
> @@ -62,6 +61,79 @@
> 
>  #define STRCAT(X, Y) (X Y)
> 
> +static const uint32_t plane_formats[] = {
> +	DRM_FORMAT_ARGB8888,
> +	DRM_FORMAT_ABGR8888,
> +	DRM_FORMAT_RGBA8888,
> +	DRM_FORMAT_BGRA8888,
> +	DRM_FORMAT_XRGB8888,
> +	DRM_FORMAT_RGBX8888,
> +	DRM_FORMAT_BGRX8888,
> +	DRM_FORMAT_XBGR8888,
> +	DRM_FORMAT_RGB888,
> +	DRM_FORMAT_BGR888,
> +	DRM_FORMAT_RGB565,
> +	DRM_FORMAT_BGR565,
> +	DRM_FORMAT_ARGB1555,
> +	DRM_FORMAT_ABGR1555,
> +	DRM_FORMAT_RGBA5551,
> +	DRM_FORMAT_BGRA5551,
> +	DRM_FORMAT_XRGB1555,
> +	DRM_FORMAT_XBGR1555,
> +	DRM_FORMAT_RGBX5551,
> +	DRM_FORMAT_BGRX5551,
> +	DRM_FORMAT_ARGB4444,
> +	DRM_FORMAT_ABGR4444,
> +	DRM_FORMAT_RGBA4444,
> +	DRM_FORMAT_BGRA4444,
> +	DRM_FORMAT_XRGB4444,
> +	DRM_FORMAT_XBGR4444,
> +	DRM_FORMAT_RGBX4444,
> +	DRM_FORMAT_BGRX4444,
> +};
> +
> +static const uint32_t plane_formats_yuv[] = {
> +	DRM_FORMAT_ARGB8888,
> +	DRM_FORMAT_ABGR8888,
> +	DRM_FORMAT_RGBA8888,
> +	DRM_FORMAT_BGRX8888,
> +	DRM_FORMAT_BGRA8888,
> +	DRM_FORMAT_XRGB8888,
> +	DRM_FORMAT_XBGR8888,
> +	DRM_FORMAT_RGBX8888,
> +	DRM_FORMAT_RGB888,
> +	DRM_FORMAT_BGR888,
> +	DRM_FORMAT_RGB565,
> +	DRM_FORMAT_BGR565,
> +	DRM_FORMAT_ARGB1555,
> +	DRM_FORMAT_ABGR1555,
> +	DRM_FORMAT_RGBA5551,
> +	DRM_FORMAT_BGRA5551,
> +	DRM_FORMAT_XRGB1555,
> +	DRM_FORMAT_XBGR1555,
> +	DRM_FORMAT_RGBX5551,
> +	DRM_FORMAT_BGRX5551,
> +	DRM_FORMAT_ARGB4444,
> +	DRM_FORMAT_ABGR4444,
> +	DRM_FORMAT_RGBA4444,
> +	DRM_FORMAT_BGRA4444,
> +	DRM_FORMAT_XRGB4444,
> +	DRM_FORMAT_XBGR4444,
> +	DRM_FORMAT_RGBX4444,
> +	DRM_FORMAT_BGRX4444,
> +
> +	DRM_FORMAT_NV12,
> +	DRM_FORMAT_NV21,
> +	DRM_FORMAT_NV16,
> +	DRM_FORMAT_NV61,
> +	DRM_FORMAT_VYUY,
> +	DRM_FORMAT_UYVY,
> +	DRM_FORMAT_YUYV,
> +	DRM_FORMAT_YVYU,
> +	DRM_FORMAT_YUV420,
> +	DRM_FORMAT_YVU420,
> +};
> +
>  /*************************************************************
>   * DPU sub blocks config
>   *************************************************************/
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog_format.h
> b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog_format.h
> deleted file mode 100644
> index 3766f0fd0bf08..0000000000000
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog_format.h
> +++ /dev/null
> @@ -1,88 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/* Copyright (c) 2015-2018, The Linux Foundation. All rights reserved.
> - */
> -
> -#include "dpu_hw_mdss.h"
> -
> -static const uint32_t qcom_compressed_supported_formats[] = {
> -	DRM_FORMAT_ABGR8888,
> -	DRM_FORMAT_ARGB8888,
> -	DRM_FORMAT_XBGR8888,
> -	DRM_FORMAT_XRGB8888,
> -	DRM_FORMAT_BGR565,
> -
> -	DRM_FORMAT_NV12,
> -};
> -
> -static const uint32_t plane_formats[] = {
> -	DRM_FORMAT_ARGB8888,
> -	DRM_FORMAT_ABGR8888,
> -	DRM_FORMAT_RGBA8888,
> -	DRM_FORMAT_BGRA8888,
> -	DRM_FORMAT_XRGB8888,
> -	DRM_FORMAT_RGBX8888,
> -	DRM_FORMAT_BGRX8888,
> -	DRM_FORMAT_XBGR8888,
> -	DRM_FORMAT_RGB888,
> -	DRM_FORMAT_BGR888,
> -	DRM_FORMAT_RGB565,
> -	DRM_FORMAT_BGR565,
> -	DRM_FORMAT_ARGB1555,
> -	DRM_FORMAT_ABGR1555,
> -	DRM_FORMAT_RGBA5551,
> -	DRM_FORMAT_BGRA5551,
> -	DRM_FORMAT_XRGB1555,
> -	DRM_FORMAT_XBGR1555,
> -	DRM_FORMAT_RGBX5551,
> -	DRM_FORMAT_BGRX5551,
> -	DRM_FORMAT_ARGB4444,
> -	DRM_FORMAT_ABGR4444,
> -	DRM_FORMAT_RGBA4444,
> -	DRM_FORMAT_BGRA4444,
> -	DRM_FORMAT_XRGB4444,
> -	DRM_FORMAT_XBGR4444,
> -	DRM_FORMAT_RGBX4444,
> -	DRM_FORMAT_BGRX4444,
> -};
> -
> -static const uint32_t plane_formats_yuv[] = {
> -	DRM_FORMAT_ARGB8888,
> -	DRM_FORMAT_ABGR8888,
> -	DRM_FORMAT_RGBA8888,
> -	DRM_FORMAT_BGRX8888,
> -	DRM_FORMAT_BGRA8888,
> -	DRM_FORMAT_XRGB8888,
> -	DRM_FORMAT_XBGR8888,
> -	DRM_FORMAT_RGBX8888,
> -	DRM_FORMAT_RGB888,
> -	DRM_FORMAT_BGR888,
> -	DRM_FORMAT_RGB565,
> -	DRM_FORMAT_BGR565,
> -	DRM_FORMAT_ARGB1555,
> -	DRM_FORMAT_ABGR1555,
> -	DRM_FORMAT_RGBA5551,
> -	DRM_FORMAT_BGRA5551,
> -	DRM_FORMAT_XRGB1555,
> -	DRM_FORMAT_XBGR1555,
> -	DRM_FORMAT_RGBX5551,
> -	DRM_FORMAT_BGRX5551,
> -	DRM_FORMAT_ARGB4444,
> -	DRM_FORMAT_ABGR4444,
> -	DRM_FORMAT_RGBA4444,
> -	DRM_FORMAT_BGRA4444,
> -	DRM_FORMAT_XRGB4444,
> -	DRM_FORMAT_XBGR4444,
> -	DRM_FORMAT_RGBX4444,
> -	DRM_FORMAT_BGRX4444,
> -
> -	DRM_FORMAT_NV12,
> -	DRM_FORMAT_NV21,
> -	DRM_FORMAT_NV16,
> -	DRM_FORMAT_NV61,
> -	DRM_FORMAT_VYUY,
> -	DRM_FORMAT_UYVY,
> -	DRM_FORMAT_YUYV,
> -	DRM_FORMAT_YVYU,
> -	DRM_FORMAT_YUV420,
> -	DRM_FORMAT_YVU420,
> -};
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> index 7ea90d25a3b69..c0b1d77369e53 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> @@ -19,7 +19,6 @@
>  #include "dpu_kms.h"
>  #include "dpu_formats.h"
>  #include "dpu_hw_sspp.h"
> -#include "dpu_hw_catalog_format.h"
>  #include "dpu_trace.h"
>  #include "dpu_crtc.h"
>  #include "dpu_vbif.h"
> @@ -63,6 +62,16 @@ enum {
> 
>  #define DEFAULT_REFRESH_RATE	60
> 
> +static const uint32_t qcom_compressed_supported_formats[] = {
> +	DRM_FORMAT_ABGR8888,
> +	DRM_FORMAT_ARGB8888,
> +	DRM_FORMAT_XBGR8888,
> +	DRM_FORMAT_XRGB8888,
> +	DRM_FORMAT_BGR565,
> +
> +	DRM_FORMAT_NV12,
> +};
> +
>  /**
>   * enum dpu_plane_qos - Different qos configurations for each pipe
>   *
