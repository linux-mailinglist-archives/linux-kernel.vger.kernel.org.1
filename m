Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2F5D1BC279
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 17:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgD1PPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 11:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727108AbgD1PPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 11:15:19 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D9EC03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 08:15:19 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 188so3220475wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 08:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=6RQa3/Ivl+erv2MC5JIerdVHsjcRsy5jElt25/tvg/I=;
        b=c/rDYXyVx+iz8SQtNmdLLH9jiyFcXnPbgx93UfB9RgZOLHKZjwmjlrpMpBrqvtv6Fw
         e3pdYB7gxw+aEHxM30rDVR+kHPY1rl9jcotFrTRSnlHN/Sy7vvx+LPXJNZwgEggzcTWB
         LuNAmn0HSFJVT70SwHLf3sgYl/Kx3gKsWpMIEQtqM8k0x9ytKRe8td2LPY1rCkMV3dw7
         psiw49gPvhkuxILNWN08yqhHImHmiI27uI55UfLBdsWcku7ZE2NvnEY2pv3lxOw5UkS9
         RV6DV8J10tXn4Za5fUe0JvrTCtHazLo7gOx6UIJnFQwRYybjgD3lh2zZDTK0vKtWyWpe
         IJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=6RQa3/Ivl+erv2MC5JIerdVHsjcRsy5jElt25/tvg/I=;
        b=MFTgEKGGn968/m/TAOYWMwd8UEQwDV03oeC2UZ8oio+XO1R2rRK0txU3zTXc3eqwPu
         bKqARY2ZA5Bo9sG22AG84bnxmxEhqcEu4F79ZPKn8MHL838lGHbgdxfzzeEHNQ7wpZKx
         jSF9a4ehC49OcUKvA1E1lOAO6xqZtr/QnaiON4Q9Y3Ik7UPKpjIN2ZuXRR3tA+ctKar1
         uPp95CmTuHkTr+kHbQw1sHIC0OOgU11Lv410TVr4uP9ALW9noaIvepF0QecsBrQ2fRqu
         Jm18zIbDy1KxogNPC5TaOa6nAtyCzSXvCrVF/SyqAcpDt/1A9XpcnO4XoARQB/NoST6m
         ZFIg==
X-Gm-Message-State: AGi0Pua1emrJK77M3DeORDDL9dGRXk4JKd0Z+fgHhrmfONprnegqKJhc
        chECHcNYTS1Kln/LBVk+T0Y=
X-Google-Smtp-Source: APiQypJXqdagbY7C95ErpdLoYp1uRYumNOUPPDPTkG1JE8zcrJsSYL5DCZa3nXGytS0h2Vy2ksxDbg==
X-Received: by 2002:a7b:c5d4:: with SMTP id n20mr5373467wmk.92.1588086918255;
        Tue, 28 Apr 2020 08:15:18 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id 74sm26988379wrk.30.2020.04.28.08.15.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2020 08:15:17 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [RFC 10/17] drm: radeon: fix sg_table nents vs. orig_nents misuse
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Christoph Hellwig <hch@lst.de>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-arm-kernel@lists.infradead.org
References: <20200428132005.21424-1-m.szyprowski@samsung.com>
 <CGME20200428132028eucas1p155a84ab14c6a6820b4c8240f01e98905@eucas1p1.samsung.com>
 <20200428132005.21424-11-m.szyprowski@samsung.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <94c45ded-6544-a922-7177-8255b44c4cfa@gmail.com>
Date:   Tue, 28 Apr 2020 17:15:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200428132005.21424-11-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 28.04.20 um 15:19 schrieb Marek Szyprowski:
> The Documentation/DMA-API-HOWTO.txt states that dma_map_sg returns the
> numer of the created entries in the DMA address space. However the
> subsequent calls to dma_sync_sg_for_{device,cpu} and dma_unmap_sg must be
> called with the original number of entries passed to dma_map_sg. The
> sg_table->nents in turn holds the result of the dma_map_sg call as stated
> in include/linux/scatterlist.h. Adapt the code to obey those rules.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/radeon/radeon_ttm.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
> index 5d50c9e..4770880 100644
> --- a/drivers/gpu/drm/radeon/radeon_ttm.c
> +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
> @@ -481,7 +481,7 @@ static int radeon_ttm_tt_pin_userptr(struct ttm_tt *ttm)
>   {
>   	struct radeon_device *rdev = radeon_get_rdev(ttm->bdev);
>   	struct radeon_ttm_tt *gtt = (void *)ttm;
> -	unsigned pinned = 0, nents;
> +	unsigned pinned = 0;
>   	int r;
>   
>   	int write = !(gtt->userflags & RADEON_GEM_USERPTR_READONLY);
> @@ -522,8 +522,8 @@ static int radeon_ttm_tt_pin_userptr(struct ttm_tt *ttm)
>   		goto release_sg;
>   
>   	r = -ENOMEM;
> -	nents = dma_map_sg(rdev->dev, ttm->sg->sgl, ttm->sg->nents, direction);
> -	if (nents == 0)
> +	ttm->sg->nents = dma_map_sg(rdev->dev, ttm->sg->sgl,
> +	if (ttm->sg->nents == 0)
>   		goto release_sg;
>   
>   	drm_prime_sg_to_page_addr_arrays(ttm->sg, ttm->pages,
> @@ -554,9 +554,9 @@ static void radeon_ttm_tt_unpin_userptr(struct ttm_tt *ttm)
>   		return;
>   
>   	/* free the sg table and pages again */
> -	dma_unmap_sg(rdev->dev, ttm->sg->sgl, ttm->sg->nents, direction);
> +	dma_unmap_sg(rdev->dev, ttm->sg->sgl, ttm->sg->orig_nents, direction);
>   
> -	for_each_sg_page(ttm->sg->sgl, &sg_iter, ttm->sg->nents, 0) {
> +	for_each_sg_page(ttm->sg->sgl, &sg_iter, ttm->sg->orig_nents, 0) {
>   		struct page *page = sg_page_iter_page(&sg_iter);
>   		if (!(gtt->userflags & RADEON_GEM_USERPTR_READONLY))
>   			set_page_dirty(page);

