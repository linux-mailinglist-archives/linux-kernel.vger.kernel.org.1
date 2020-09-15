Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A76526AA4B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 19:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbgIORQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 13:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727682AbgIOQ2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 12:28:09 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB4DC061356
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 09:02:10 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id h6so3554161qtd.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 09:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qHGhBN6eHyO69pll+88g/3newfhKOBOeL1YWhiUfNUQ=;
        b=nqulYA+U+8v+m/92Wp/qSwp60FLL5ppEhy1d4NMu94BSSy3H2Ito9aUNKNk/I5IuqF
         2AE4pe89kb9T8+IkNkK+64vp4Ge5nYKuazgHAAaffRYj3+8m1pVdgR+m3KzypTAW/i/a
         D+qqPTFpwVw9dtuMkdYgfEIt/mJbD2MVLHjG6KXwJEcwTt3v3mO4mgIqigOWTLfp6EXF
         GCJWtRwdXqf9EG8mvvOXTJjxHrzejopjiwSnY8eGV5haayXSY6V8wwuUdO+7Rg2gMf6/
         xNHcvBSDcXJNH23tzlQX6k57Dp56al2z38KUSiRqE+wjWji75xqAqd2o+uhYjNzFbOtt
         92mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qHGhBN6eHyO69pll+88g/3newfhKOBOeL1YWhiUfNUQ=;
        b=AvclxHHy3ldR5Ct0YYjW0YPhTd9Zn1doePAF5E7u/CjtcEk/uA2rLHEV51q7MaurXK
         nSlLPvCFoWyhJsl7plrMHK4MGqZMlys9JiUP4MMBg9BWKC4zIJ10V1Brn7hTXG1cAjH7
         LO2bEY+3bhGgtDm1vgIRvlgtBoDcXLNKhZyl7QMY/R+15snhxkXxO4vms4srF5P1u0uI
         VOjMNpLFDkuIowj3oWi8aqNT06r/7eBT3j3XGedG/6hMbMJ1lD01nRTt4ZvFkwb7UHv0
         GdHaDJCKyvGO0QQDiHnF3LWF1GQEaTyDRLUPa41gJnvnyt3YBEoWkx2JrkFMb+CNN+To
         AL7A==
X-Gm-Message-State: AOAM530a9DgglsH8QNluI2vJ2eEvBa6pi3JE3zdL4GZQdHUyUZnlV/V8
        rasXqSO47zM3iCouQmiX1latl7R6pBz4Ef1Rxgg=
X-Google-Smtp-Source: ABdhPJw6xKxWuntGSjSpo2t0XQrHAfXtHFl9zB7oY4bDRoJpWdY84ipY+jn9cSINhlirpBQ32z97ug==
X-Received: by 2002:ac8:7188:: with SMTP id w8mr18494777qto.134.1600185729108;
        Tue, 15 Sep 2020 09:02:09 -0700 (PDT)
Received: from [192.168.0.189] ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id g37sm17775925qtk.76.2020.09.15.09.02.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 09:02:08 -0700 (PDT)
Subject: Re: [Freedreno] [PATCH] drm/msm: Fix the a650 hw_apriv check
To:     Jordan Crouse <jcrouse@codeaurora.org>,
        linux-arm-msm@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, freedreno@lists.freedesktop.org,
        Sharat Masetty <smasetty@codeaurora.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Eric Anholt <eric@anholt.net>, Rob Clark <robdclark@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Sean Paul <sean@poorly.run>
References: <20200915155638.1706161-1-jcrouse@codeaurora.org>
From:   Jonathan Marek <jonathan@marek.ca>
Message-ID: <821c76c7-32dd-4914-817f-7f52843e9b1b@marek.ca>
Date:   Tue, 15 Sep 2020 12:01:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200915155638.1706161-1-jcrouse@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/20 11:56 AM, Jordan Crouse wrote:
> Commit 604234f33658 ("drm/msm: Enable expanded apriv support for a650")
> was checking the result of adreno_is_a650() before the gpu revision
> got probed in adreno_gpu_init() so it was always coming across as
> false. Snoop into the revision ID ahead of time to correctly set the
> hw_apriv flag so that it can be used by msm_gpu to properly setup
> global buffers.
> 
> Fixes: 604234f33658 ("drm/msm: Enable expanded apriv support for a650")
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>

Tested-by: Jonathan Marek <jonathan@marek.ca>

> ---
> 
>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 74bc27eb4203..f3b6d93c207c 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -1048,6 +1048,8 @@ struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
>   {
>   	struct msm_drm_private *priv = dev->dev_private;
>   	struct platform_device *pdev = priv->gpu_pdev;
> +	struct adreno_platform_config *config = pdev->dev.platform_data;
> +	const struct adreno_info *info;
>   	struct device_node *node;
>   	struct a6xx_gpu *a6xx_gpu;
>   	struct adreno_gpu *adreno_gpu;
> @@ -1064,7 +1066,14 @@ struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
>   	adreno_gpu->registers = NULL;
>   	adreno_gpu->reg_offsets = a6xx_register_offsets;
>   
> -	if (adreno_is_a650(adreno_gpu))
> +	/*
> +	 * We need to know the platform type before calling into adreno_gpu_init
> +	 * so that the hw_apriv flag can be correctly set. Snoop into the info
> +	 * and grab the revision number
> +	 */
> +	info = adreno_info(config->rev);
> +
> +	if (info && info->revn == 650)
>   		adreno_gpu->base.hw_apriv = true;
>   
>   	ret = adreno_gpu_init(dev, pdev, adreno_gpu, &funcs, 1);
> 
