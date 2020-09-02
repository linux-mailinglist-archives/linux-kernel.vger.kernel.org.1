Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C637725B567
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 22:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgIBUlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 16:41:24 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:23406 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbgIBUlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 16:41:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1599079282; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=ZR7O+zlwzjrNxHhPuCpyTWPmkdSYakmavLsBES19fSU=; b=qPajwzdac21hfC6+cZ+g8RxFqyJnOPI5fBpgmoW1h2Sb1fwyX30WU7/QhshFmitOyq7MEWEi
 kEnSQ7VwxkOr7x3RP9LENcrzPHZGz92GJr5J6+ONV+GTUS0EXAqCE/6fi94TyO8oeUGL/Hdf
 68OcLVeOsBxdn3ZogLSiuaZSx9E=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5f500372380a624e4daf95ea (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 02 Sep 2020 20:41:22
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EA5CAC433AD; Wed,  2 Sep 2020 20:41:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4A0BAC43391;
        Wed,  2 Sep 2020 20:41:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4A0BAC43391
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Wed, 2 Sep 2020 14:41:16 -0600
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <freedreno@lists.freedesktop.org>, David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>, Sean Paul <sean@poorly.run>
Subject: Re: [Freedreno] [PATCH 2/3] drm/msm: Convert shrinker msgs to
 tracepoints
Message-ID: <20200902204115.GB22040@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Rob Clark <robdclark@gmail.com>,
        dri-devel@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" <freedreno@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>, Sean Paul <sean@poorly.run>
References: <20200901154200.2451899-1-robdclark@gmail.com>
 <20200901154200.2451899-3-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901154200.2451899-3-robdclark@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 08:41:55AM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> This reduces the spam in dmesg when we start hitting the shrinker, and
> replaces it with something we can put on a timeline while profiling or
> debugging system issues.

Reviewed-by: Jordan Crouse <jcrouse@codeaurora.org>

> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/msm_gem_shrinker.c |  5 +++--
>  drivers/gpu/drm/msm/msm_gpu_trace.h    | 26 ++++++++++++++++++++++++++
>  2 files changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_gem_shrinker.c b/drivers/gpu/drm/msm/msm_gem_shrinker.c
> index 722d61668a97..482576d7a39a 100644
> --- a/drivers/gpu/drm/msm/msm_gem_shrinker.c
> +++ b/drivers/gpu/drm/msm/msm_gem_shrinker.c
> @@ -6,6 +6,7 @@
>  
>  #include "msm_drv.h"
>  #include "msm_gem.h"
> +#include "msm_gpu_trace.h"
>  
>  static bool msm_gem_shrinker_lock(struct drm_device *dev, bool *unlock)
>  {
> @@ -87,7 +88,7 @@ msm_gem_shrinker_scan(struct shrinker *shrinker, struct shrink_control *sc)
>  		mutex_unlock(&dev->struct_mutex);
>  
>  	if (freed > 0)
> -		pr_info_ratelimited("Purging %lu bytes\n", freed << PAGE_SHIFT);
> +		trace_msm_gem_purge(freed << PAGE_SHIFT);
>  
>  	return freed;
>  }
> @@ -123,7 +124,7 @@ msm_gem_shrinker_vmap(struct notifier_block *nb, unsigned long event, void *ptr)
>  	*(unsigned long *)ptr += unmapped;
>  
>  	if (unmapped > 0)
> -		pr_info_ratelimited("Purging %u vmaps\n", unmapped);
> +		trace_msm_gem_purge_vmaps(unmapped);
>  
>  	return NOTIFY_DONE;
>  }
> diff --git a/drivers/gpu/drm/msm/msm_gpu_trace.h b/drivers/gpu/drm/msm/msm_gpu_trace.h
> index 07572ab179fa..1079fe551279 100644
> --- a/drivers/gpu/drm/msm/msm_gpu_trace.h
> +++ b/drivers/gpu/drm/msm/msm_gpu_trace.h
> @@ -114,6 +114,32 @@ TRACE_EVENT(msm_gmu_freq_change,
>  		TP_printk("freq=%u, perf_index=%u", __entry->freq, __entry->perf_index)
>  );
>  
> +
> +TRACE_EVENT(msm_gem_purge,
> +		TP_PROTO(u32 bytes),
> +		TP_ARGS(bytes),
> +		TP_STRUCT__entry(
> +			__field(u32, bytes)
> +			),
> +		TP_fast_assign(
> +			__entry->bytes = bytes;
> +			),
> +		TP_printk("Purging %u bytes", __entry->bytes)
> +);
> +
> +
> +TRACE_EVENT(msm_gem_purge_vmaps,
> +		TP_PROTO(u32 unmapped),
> +		TP_ARGS(unmapped),
> +		TP_STRUCT__entry(
> +			__field(u32, unmapped)
> +			),
> +		TP_fast_assign(
> +			__entry->unmapped = unmapped;
> +			),
> +		TP_printk("Purging %u vmaps", __entry->unmapped)
> +);
> +
>  #endif
>  
>  #undef TRACE_INCLUDE_PATH
> -- 
> 2.26.2
> 
> _______________________________________________
> Freedreno mailing list
> Freedreno@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/freedreno

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
