Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0B2283794
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 16:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgJEOWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 10:22:45 -0400
Received: from z5.mailgun.us ([104.130.96.5]:13202 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgJEOWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 10:22:43 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601907762; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=kORaE4cBBfq+qvU6Hetuv1UcX0BfJ40u4vJsH37nAmg=; b=kFgBGiF2zzrHDYcII3v3pRDEd+0Ac0biIqJuoGj2bynl2Xrcw/RQ0F9e+JWZsVZwxzSlPv28
 92+5yu3CNNANABpIKKKl7ncyQm9U7/DIa9w8NPY3/J7DzaH6W2oVftRxD5ETUPTloMjPg7zT
 kEcdwrGsGui0rg+huK9TqWPCfH8=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5f7b2c294f8cc67c31ba3bf3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 05 Oct 2020 14:22:33
 GMT
Sender: jcrouse=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 82DD8C433C8; Mon,  5 Oct 2020 14:22:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6CFB3C433C8;
        Mon,  5 Oct 2020 14:22:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6CFB3C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jcrouse@codeaurora.org
Date:   Mon, 5 Oct 2020 08:22:26 -0600
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Eric Anholt <eric@anholt.net>,
        Emil Velikov <emil.velikov@collabora.com>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Jonathan Marek <jonathan@marek.ca>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <freedreno@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/14] drm/msm: Document and rename preempt_lock
Message-ID: <20201005142226.GD4204@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Rob Clark <robdclark@gmail.com>,
        dri-devel@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Eric Anholt <eric@anholt.net>,
        Emil Velikov <emil.velikov@collabora.com>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Jonathan Marek <jonathan@marek.ca>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" <freedreno@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20201004192152.3298573-1-robdclark@gmail.com>
 <20201004192152.3298573-6-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201004192152.3298573-6-robdclark@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 04, 2020 at 12:21:37PM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Before adding another lock, give ring->lock a more descriptive name.

Reviewed-by: Jordan Crouse <jcrouse@codeaurora.org>

> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c     |  4 ++--
>  drivers/gpu/drm/msm/adreno/a5xx_preempt.c | 12 ++++++------
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c     |  4 ++--
>  drivers/gpu/drm/msm/msm_ringbuffer.c      |  2 +-
>  drivers/gpu/drm/msm/msm_ringbuffer.h      |  7 ++++++-
>  5 files changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> index c941c8138f25..543437a2186e 100644
> --- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> @@ -36,7 +36,7 @@ void a5xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring,
>  		OUT_RING(ring, upper_32_bits(shadowptr(a5xx_gpu, ring)));
>  	}
>  
> -	spin_lock_irqsave(&ring->lock, flags);
> +	spin_lock_irqsave(&ring->preempt_lock, flags);
>  
>  	/* Copy the shadow to the actual register */
>  	ring->cur = ring->next;
> @@ -44,7 +44,7 @@ void a5xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring,
>  	/* Make sure to wrap wptr if we need to */
>  	wptr = get_wptr(ring);
>  
> -	spin_unlock_irqrestore(&ring->lock, flags);
> +	spin_unlock_irqrestore(&ring->preempt_lock, flags);
>  
>  	/* Make sure everything is posted before making a decision */
>  	mb();
> diff --git a/drivers/gpu/drm/msm/adreno/a5xx_preempt.c b/drivers/gpu/drm/msm/adreno/a5xx_preempt.c
> index 7e04509c4e1f..183de1139eeb 100644
> --- a/drivers/gpu/drm/msm/adreno/a5xx_preempt.c
> +++ b/drivers/gpu/drm/msm/adreno/a5xx_preempt.c
> @@ -45,9 +45,9 @@ static inline void update_wptr(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
>  	if (!ring)
>  		return;
>  
> -	spin_lock_irqsave(&ring->lock, flags);
> +	spin_lock_irqsave(&ring->preempt_lock, flags);
>  	wptr = get_wptr(ring);
> -	spin_unlock_irqrestore(&ring->lock, flags);
> +	spin_unlock_irqrestore(&ring->preempt_lock, flags);
>  
>  	gpu_write(gpu, REG_A5XX_CP_RB_WPTR, wptr);
>  }
> @@ -62,9 +62,9 @@ static struct msm_ringbuffer *get_next_ring(struct msm_gpu *gpu)
>  		bool empty;
>  		struct msm_ringbuffer *ring = gpu->rb[i];
>  
> -		spin_lock_irqsave(&ring->lock, flags);
> +		spin_lock_irqsave(&ring->preempt_lock, flags);
>  		empty = (get_wptr(ring) == ring->memptrs->rptr);
> -		spin_unlock_irqrestore(&ring->lock, flags);
> +		spin_unlock_irqrestore(&ring->preempt_lock, flags);
>  
>  		if (!empty)
>  			return ring;
> @@ -132,9 +132,9 @@ void a5xx_preempt_trigger(struct msm_gpu *gpu)
>  	}
>  
>  	/* Make sure the wptr doesn't update while we're in motion */
> -	spin_lock_irqsave(&ring->lock, flags);
> +	spin_lock_irqsave(&ring->preempt_lock, flags);
>  	a5xx_gpu->preempt[ring->id]->wptr = get_wptr(ring);
> -	spin_unlock_irqrestore(&ring->lock, flags);
> +	spin_unlock_irqrestore(&ring->preempt_lock, flags);
>  
>  	/* Set the address of the incoming preemption record */
>  	gpu_write64(gpu, REG_A5XX_CP_CONTEXT_SWITCH_RESTORE_ADDR_LO,
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 8915882e4444..fc85f008d69d 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -65,7 +65,7 @@ static void a6xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
>  		OUT_RING(ring, upper_32_bits(shadowptr(a6xx_gpu, ring)));
>  	}
>  
> -	spin_lock_irqsave(&ring->lock, flags);
> +	spin_lock_irqsave(&ring->preempt_lock, flags);
>  
>  	/* Copy the shadow to the actual register */
>  	ring->cur = ring->next;
> @@ -73,7 +73,7 @@ static void a6xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
>  	/* Make sure to wrap wptr if we need to */
>  	wptr = get_wptr(ring);
>  
> -	spin_unlock_irqrestore(&ring->lock, flags);
> +	spin_unlock_irqrestore(&ring->preempt_lock, flags);
>  
>  	/* Make sure everything is posted before making a decision */
>  	mb();
> diff --git a/drivers/gpu/drm/msm/msm_ringbuffer.c b/drivers/gpu/drm/msm/msm_ringbuffer.c
> index 935bf9b1d941..1b6958e908dc 100644
> --- a/drivers/gpu/drm/msm/msm_ringbuffer.c
> +++ b/drivers/gpu/drm/msm/msm_ringbuffer.c
> @@ -46,7 +46,7 @@ struct msm_ringbuffer *msm_ringbuffer_new(struct msm_gpu *gpu, int id,
>  	ring->memptrs_iova = memptrs_iova;
>  
>  	INIT_LIST_HEAD(&ring->submits);
> -	spin_lock_init(&ring->lock);
> +	spin_lock_init(&ring->preempt_lock);
>  
>  	snprintf(name, sizeof(name), "gpu-ring-%d", ring->id);
>  
> diff --git a/drivers/gpu/drm/msm/msm_ringbuffer.h b/drivers/gpu/drm/msm/msm_ringbuffer.h
> index 0987d6bf848c..4956d1bc5d0e 100644
> --- a/drivers/gpu/drm/msm/msm_ringbuffer.h
> +++ b/drivers/gpu/drm/msm/msm_ringbuffer.h
> @@ -46,7 +46,12 @@ struct msm_ringbuffer {
>  	struct msm_rbmemptrs *memptrs;
>  	uint64_t memptrs_iova;
>  	struct msm_fence_context *fctx;
> -	spinlock_t lock;
> +
> +	/*
> +	 * preempt_lock protects preemption and serializes wptr updates against
> +	 * preemption.  Can be aquired from irq context.
> +	 */
> +	spinlock_t preempt_lock;
>  };
>  
>  struct msm_ringbuffer *msm_ringbuffer_new(struct msm_gpu *gpu, int id,
> -- 
> 2.26.2
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
