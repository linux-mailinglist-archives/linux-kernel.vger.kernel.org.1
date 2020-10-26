Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3546299386
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 18:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1787465AbgJZRQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 13:16:29 -0400
Received: from z5.mailgun.us ([104.130.96.5]:11208 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1773381AbgJZRQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 13:16:29 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603732588; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=ubLgLNz4mruxjMMlVTL1wQFtrF+CIhu/zLVlKRGmGmg=; b=LhgvjCrkEyKU8vFSfhHyUMMqWWo8qJfvawR8L9DBwYnlTsDR1D56FjuhG00SMMlZpGwyR8G4
 e9a7F5pZhohxmWUS5ksykiLF6cFQIob+MR0OTQckb3mqsrYq0Vlhe4BAd2I5VoQLpZF7LNEb
 tntYHnaLeoJL1FJwOdUSkDoEjJQ=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5f97043e6311e6e920aa0ef6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 26 Oct 2020 17:15:42
 GMT
Sender: jcrouse=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BD460C43385; Mon, 26 Oct 2020 17:15:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 72C2CC433F0;
        Mon, 26 Oct 2020 17:15:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 72C2CC433F0
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jcrouse@codeaurora.org
Date:   Mon, 26 Oct 2020 11:15:37 -0600
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Clark <robdclark@gmail.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        freedreno@lists.freedesktop.org,
        "Kristian H . Kristensen" <hoegsberg@google.com>,
        dri-devel@lists.freedesktop.org,
        Sharat Masetty <smasetty@codeaurora.org>
Subject: Re: [PATCHv6 3/6] drm/msm: rearrange the gpu_rmw() function
Message-ID: <20201026171537.GA23509@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Clark <robdclark@gmail.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        freedreno@lists.freedesktop.org,
        "Kristian H . Kristensen" <hoegsberg@google.com>,
        dri-devel@lists.freedesktop.org,
        Sharat Masetty <smasetty@codeaurora.org>
References: <cover.1603448364.git.saiprakash.ranjan@codeaurora.org>
 <863b0eb175fb2a4ebfefca09344e0055722190cf.1603448364.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <863b0eb175fb2a4ebfefca09344e0055722190cf.1603448364.git.saiprakash.ranjan@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 05:24:02PM +0530, Sai Prakash Ranjan wrote:
> From: Sharat Masetty <smasetty@codeaurora.org>
> 
> The register read-modify-write construct is generic enough
> that it can be used by other subsystems as needed, create
> a more generic rmw() function and have the gpu_rmw() use
> this new function.
> 
> Signed-off-by: Sharat Masetty <smasetty@codeaurora.org>
> Reviewed-by: Jordan Crouse <jcrouse@codeaurora.org>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

Rob - this should be safe to pull with msm-next regardless of the merge status
of the iommu side of things. Hopefully everything will be pulled for 5.11 but if
it isn't it would be good to get this out of the cycle.

Jordan

> ---
>  drivers/gpu/drm/msm/msm_drv.c | 8 ++++++++
>  drivers/gpu/drm/msm/msm_drv.h | 1 +
>  drivers/gpu/drm/msm/msm_gpu.h | 5 +----
>  3 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index 49685571dc0e..a1e22b974b77 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -180,6 +180,14 @@ u32 msm_readl(const void __iomem *addr)
>  	return val;
>  }
>  
> +void msm_rmw(void __iomem *addr, u32 mask, u32 or)
> +{
> +	u32 val = msm_readl(addr);
> +
> +	val &= ~mask;
> +	msm_writel(val | or, addr);
> +}
> +
>  struct msm_vblank_work {
>  	struct work_struct work;
>  	int crtc_id;
> diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
> index b9dd8f8f4887..655b3b0424a1 100644
> --- a/drivers/gpu/drm/msm/msm_drv.h
> +++ b/drivers/gpu/drm/msm/msm_drv.h
> @@ -478,6 +478,7 @@ void __iomem *msm_ioremap_quiet(struct platform_device *pdev, const char *name,
>  		const char *dbgname);
>  void msm_writel(u32 data, void __iomem *addr);
>  u32 msm_readl(const void __iomem *addr);
> +void msm_rmw(void __iomem *addr, u32 mask, u32 or);
>  
>  struct msm_gpu_submitqueue;
>  int msm_submitqueue_init(struct drm_device *drm, struct msm_file_private *ctx);
> diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
> index 6c9e1fdc1a76..b2b419277953 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.h
> +++ b/drivers/gpu/drm/msm/msm_gpu.h
> @@ -246,10 +246,7 @@ static inline u32 gpu_read(struct msm_gpu *gpu, u32 reg)
>  
>  static inline void gpu_rmw(struct msm_gpu *gpu, u32 reg, u32 mask, u32 or)
>  {
> -	uint32_t val = gpu_read(gpu, reg);
> -
> -	val &= ~mask;
> -	gpu_write(gpu, reg, val | or);
> +	msm_rmw(gpu->mmio + (reg << 2), mask, or);
>  }
>  
>  static inline u64 gpu_read64(struct msm_gpu *gpu, u32 lo, u32 hi)
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
