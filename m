Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C084287AEB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 19:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732002AbgJHRXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 13:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731980AbgJHRXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 13:23:04 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52C1C0613D2;
        Thu,  8 Oct 2020 10:23:03 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id n15so7486089wrq.2;
        Thu, 08 Oct 2020 10:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Th8nI66DvtaZ0IVeBilAefR7QwQob2LTpsjIn1x8LsM=;
        b=tLRYcHUQ5hYXSooAZwqc+dONvA4JaaWG7/eT+978T0sPZB+Semwk7rkaDsaybmiHVe
         xYH7F73tbVs9KTVMeGfgchxoCjLCT42yvYMyLVHVi7dEsaBm3tYOQ2juGi/0VenRk6eT
         RFvm9ESuBjJIcyRySLyZabYiSxcC9tm2fxuev1LvoL1GNa0fqhHXrwDyRBupRUhs0IM7
         4bw/4Do2cBO826iWJQxk63yEvtf2SrRaSTMPrp/mTOuemxgN60z4Wtu1Y5fNFfVe/NXC
         BN9xrQ0+chdPtqonQyZqq/rWyA2VQVooVyg4Llau+V7P3jpzJRWx/KplcJ68ItZ/FKRM
         CsIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Th8nI66DvtaZ0IVeBilAefR7QwQob2LTpsjIn1x8LsM=;
        b=nxRKnOMgruXw2PNOZ/ubgjLmxX1aaQJ+WSD80mcgzcHouak3Q7jgGmofCwE0lkiZra
         Fjzmk+QUR0dHy9pcrzfwrAWy0yP5pdgfDwnCNwD4Jcgv8duNy20CmAUxku7pprJAqApP
         nsT6QSJS/21yI6bphwI6MO3FImBt+U6jhg7ZKPreb8BSqP8yK/DWGJM1qvQRWTuR/hk3
         J5z8Zme/IuB29tTzWVOlmKRXZW2aUDzUSYhP68p91g9dIxpn1z6LlyhMWMTFAiXOLnzp
         TgvoAR2Jw3kVX8DOMk2vxlgDDyZriMBCz9eNqhRSBZjL7i1MK5XlgKGcuo6/gMfr/EtX
         1UCQ==
X-Gm-Message-State: AOAM533JJzN04by1RdRRxemGMRoU3Z6xTw4X6DPUwoVkYDcDc0ToVFzc
        iCdLA0bKTQ8IWDuxrgtxwmUJA869F0t2QDTQwtY=
X-Google-Smtp-Source: ABdhPJzZ6GoeX2WpQfU+giynQG8KdCAt3+RG6EPJsd5+47Ui2pcrX/PGqpk0QmrwBrrDh6wRze0rpVHSdftoL+uv9Kk=
X-Received: by 2002:adf:f246:: with SMTP id b6mr4508843wrp.111.1602177782434;
 Thu, 08 Oct 2020 10:23:02 -0700 (PDT)
MIME-Version: 1.0
References: <20201008142305.GA21249@embeddedor>
In-Reply-To: <20201008142305.GA21249@embeddedor>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 8 Oct 2020 13:22:51 -0400
Message-ID: <CADnq5_NA+vck4=zq8LxkrJDx0AXcu8iLAs=TNdvxoWhFqeTfEA@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amdgpu: Use struct_size() helper in kmalloc()
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-hardening@vger.kernel.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Thu, Oct 8, 2020 at 10:17 AM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> Make use of the new struct_size() helper instead of the offsetof() idiom.
>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 5da487b64a66..30192dce7775 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -239,8 +239,7 @@ static int amdgpu_amdkfd_remove_eviction_fence(struct amdgpu_bo *bo,
>         if (!old)
>                 return 0;
>
> -       new = kmalloc(offsetof(typeof(*new), shared[old->shared_max]),
> -                     GFP_KERNEL);
> +       new = kmalloc(struct_size(new, shared, old->shared_max), GFP_KERNEL);
>         if (!new)
>                 return -ENOMEM;
>
> --
> 2.27.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
