Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22864274594
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 17:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgIVPlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 11:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgIVPlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 11:41:12 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589B0C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 08:41:12 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id b79so3810424wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 08:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Cbe74dQYS26tlKuXG2nmZit12ZE13LkNg/TYRM8EF0=;
        b=Mb4qv5RRsHgf4TheKQKAjNb+btsujvWoRv5n/Fawxz90sqTHE8ajFjEnN20a1ACwOP
         G+J1OANpx8s2OM43mvB3KSEGtD6Z7AleVSqCE4T/KHMu1So1QdeTk3tYePDzkOQuSmUt
         aMWaG1LcjGiRdOhwl1I+WWtN0l8uESdOqF9xqERHkXJRZKfHPf1Zt5kG3ssdOEljP4Sg
         lO7d8H8lhVA9DrDtJQ646b93JCYvMDylekCaTniSyatFkhp8Mpl0YHpQyXqpMc85rtAT
         srDkMcWNPUAar1EnRkMrLrw0fN3zA2Ua3ak2A6BzAcuuqUpzp28y+yHx4i67c8Ezi6b6
         RTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Cbe74dQYS26tlKuXG2nmZit12ZE13LkNg/TYRM8EF0=;
        b=cQAKTUPGN6W788odt8c4se+RblcyiEtQU+8sSntTNghhBrK3K00ZKvYIVbkesDL46c
         qt/ngYbqacsl8PG4muqAPHhjIy1L8njk0lxSZjaP/210zLJeLfoYeJKC8z/kneVb/th5
         kp8mW3FPBtZNBsfCeG2Rcf3M1XAY7Xs793uOM6/p7NV/ez4Nue8Lsb9AuyVyLbuLJr80
         MoQoJf4vGlJeEKRJt4fCRbseI6yv8WPsIZ1cNizX1yMHs6gmS1XNlcjHtdvW0f5gIOuW
         F0aqBdFrvRfiEaEGJqNzrkDhSiSSIk2BYoS5tiJTzUtZaXP5JHnjFkvBFzRRz8R2VSP/
         Ctng==
X-Gm-Message-State: AOAM530fWHAs3UNrUA5ghZLo5rcHidF8CXYw1UTlaaCzoAgXTgPOE3ss
        MxjR8YY2KUWiD18TxTztomFBFtCtRo94Ir9mU5U=
X-Google-Smtp-Source: ABdhPJwZUwy5qOgLBDJ3rndDnNGg29MsKwc8L72EOLM53unhVSRkufehHY2fqbfHZ3NijmF6JttkVh0uCCd1m6Tr3QM=
X-Received: by 2002:a1c:a184:: with SMTP id k126mr1640799wme.39.1600789270900;
 Tue, 22 Sep 2020 08:41:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200922125431.27943-1-bernard@vivo.com>
In-Reply-To: <20200922125431.27943-1-bernard@vivo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 22 Sep 2020 11:40:59 -0400
Message-ID: <CADnq5_Mdn6xh4OczCK=2d-U1FXLeerCb0WhH48MGLd-v+kRpgg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd:fix typoes in comments
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Nirmoy Das <nirmoy.das@amd.com>,
        xinhui pan <xinhui.pan@amd.com>,
        Jonathan Kim <jonathan.kim@amd.com>,
        James Zhu <James.Zhu@amd.com>, Huang Rui <ray.huang@amd.com>,
        Leo Liu <leo.liu@amd.com>, Boyuan Zhang <boyuan.zhang@amd.com>,
        Monk Liu <Monk.Liu@amd.com>, Jane Jian <Jane.Jian@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Tue, Sep 22, 2020 at 9:11 AM Bernard Zhao <bernard@vivo.com> wrote:
>
> Change the comment typo: "programm" -> "program".
>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 2 +-
>  drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c  | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c  | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c  | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c  | 2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c  | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c  | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c  | 4 ++--
>  8 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 770025a5e500..7c46937c1c0e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -98,7 +98,7 @@ struct amdgpu_bo_list_entry;
>  #define AMDGPU_PTE_MTYPE_NV10(a)       ((uint64_t)(a) << 48)
>  #define AMDGPU_PTE_MTYPE_NV10_MASK     AMDGPU_PTE_MTYPE_NV10(7ULL)
>
> -/* How to programm VM fault handling */
> +/* How to program VM fault handling */
>  #define AMDGPU_VM_FAULT_STOP_NEVER     0
>  #define AMDGPU_VM_FAULT_STOP_FIRST     1
>  #define AMDGPU_VM_FAULT_STOP_ALWAYS    2
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> index 3cafba726587..b0c0c438fc93 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> @@ -348,7 +348,7 @@ static int uvd_v4_2_start(struct amdgpu_device *adev)
>         /* Set the write pointer delay */
>         WREG32(mmUVD_RBC_RB_WPTR_CNTL, 0);
>
> -       /* programm the 4GB memory segment for rptr and ring buffer */
> +       /* program the 4GB memory segment for rptr and ring buffer */
>         WREG32(mmUVD_LMI_EXT40_ADDR, upper_32_bits(ring->gpu_addr) |
>                                    (0x7 << 16) | (0x1 << 31));
>
> @@ -541,7 +541,7 @@ static void uvd_v4_2_mc_resume(struct amdgpu_device *adev)
>         uint64_t addr;
>         uint32_t size;
>
> -       /* programm the VCPU memory controller bits 0-27 */
> +       /* program the VCPU memory controller bits 0-27 */
>         addr = (adev->uvd.inst->gpu_addr + AMDGPU_UVD_FIRMWARE_OFFSET) >> 3;
>         size = AMDGPU_UVD_FIRMWARE_SIZE(adev) >> 3;
>         WREG32(mmUVD_VCPU_CACHE_OFFSET0, addr);
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> index a566ff926e90..6e57001f6d0a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> @@ -253,7 +253,7 @@ static void uvd_v5_0_mc_resume(struct amdgpu_device *adev)
>         uint64_t offset;
>         uint32_t size;
>
> -       /* programm memory controller bits 0-27 */
> +       /* program memory controller bits 0-27 */
>         WREG32(mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
>                         lower_32_bits(adev->uvd.inst->gpu_addr));
>         WREG32(mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,
> @@ -404,7 +404,7 @@ static int uvd_v5_0_start(struct amdgpu_device *adev)
>         /* set the wb address */
>         WREG32(mmUVD_RBC_RB_RPTR_ADDR, (upper_32_bits(ring->gpu_addr) >> 2));
>
> -       /* programm the RB_BASE for ring buffer */
> +       /* program the RB_BASE for ring buffer */
>         WREG32(mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
>                         lower_32_bits(ring->gpu_addr));
>         WREG32(mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> index 0a880bc101b8..d2d90fe5c6f8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> @@ -583,7 +583,7 @@ static void uvd_v6_0_mc_resume(struct amdgpu_device *adev)
>         uint64_t offset;
>         uint32_t size;
>
> -       /* programm memory controller bits 0-27 */
> +       /* program memory controller bits 0-27 */
>         WREG32(mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
>                         lower_32_bits(adev->uvd.inst->gpu_addr));
>         WREG32(mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,
> @@ -825,7 +825,7 @@ static int uvd_v6_0_start(struct amdgpu_device *adev)
>         /* set the wb address */
>         WREG32(mmUVD_RBC_RB_RPTR_ADDR, (upper_32_bits(ring->gpu_addr) >> 2));
>
> -       /* programm the RB_BASE for ring buffer */
> +       /* program the RB_BASE for ring buffer */
>         WREG32(mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
>                         lower_32_bits(ring->gpu_addr));
>         WREG32(mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> index e07e3fae99b5..b44c8677ce8d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> @@ -1073,7 +1073,7 @@ static int uvd_v7_0_start(struct amdgpu_device *adev)
>                 WREG32_SOC15(UVD, k, mmUVD_RBC_RB_RPTR_ADDR,
>                                 (upper_32_bits(ring->gpu_addr) >> 2));
>
> -               /* programm the RB_BASE for ring buffer */
> +               /* program the RB_BASE for ring buffer */
>                 WREG32_SOC15(UVD, k, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
>                                 lower_32_bits(ring->gpu_addr));
>                 WREG32_SOC15(UVD, k, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 927c330fad21..73699eafb51e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -910,7 +910,7 @@ static int vcn_v1_0_start_spg_mode(struct amdgpu_device *adev)
>         WREG32_SOC15(UVD, 0, mmUVD_RBC_RB_RPTR_ADDR,
>                         (upper_32_bits(ring->gpu_addr) >> 2));
>
> -       /* programm the RB_BASE for ring buffer */
> +       /* program the RB_BASE for ring buffer */
>         WREG32_SOC15(UVD, 0, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
>                         lower_32_bits(ring->gpu_addr));
>         WREG32_SOC15(UVD, 0, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
> @@ -1068,7 +1068,7 @@ static int vcn_v1_0_start_dpg_mode(struct amdgpu_device *adev)
>         WREG32_SOC15(UVD, 0, mmUVD_RBC_RB_RPTR_ADDR,
>                                                                 (upper_32_bits(ring->gpu_addr) >> 2));
>
> -       /* programm the RB_BASE for ring buffer */
> +       /* program the RB_BASE for ring buffer */
>         WREG32_SOC15(UVD, 0, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
>                                                                 lower_32_bits(ring->gpu_addr));
>         WREG32_SOC15(UVD, 0, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index 23a9eb5b2c8a..e5d29dee0c88 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -900,7 +900,7 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
>         WREG32_SOC15(UVD, 0, mmUVD_RBC_RB_RPTR_ADDR,
>                 (upper_32_bits(ring->gpu_addr) >> 2));
>
> -       /* programm the RB_BASE for ring buffer */
> +       /* program the RB_BASE for ring buffer */
>         WREG32_SOC15(UVD, 0, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
>                 lower_32_bits(ring->gpu_addr));
>         WREG32_SOC15(UVD, 0, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
> @@ -1060,7 +1060,7 @@ static int vcn_v2_0_start(struct amdgpu_device *adev)
>         WREG32_SOC15(UVD, 0, mmUVD_RBC_RB_CNTL, tmp);
>
>         fw_shared->multi_queue.decode_queue_mode |= FW_QUEUE_RING_RESET;
> -       /* programm the RB_BASE for ring buffer */
> +       /* program the RB_BASE for ring buffer */
>         WREG32_SOC15(UVD, 0, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
>                 lower_32_bits(ring->gpu_addr));
>         WREG32_SOC15(UVD, 0, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index e99bef6e2354..aa6f66c31709 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -887,7 +887,7 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
>         WREG32_SOC15(VCN, inst_idx, mmUVD_RBC_RB_RPTR_ADDR,
>                 (upper_32_bits(ring->gpu_addr) >> 2));
>
> -       /* programm the RB_BASE for ring buffer */
> +       /* program the RB_BASE for ring buffer */
>         WREG32_SOC15(VCN, inst_idx, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
>                 lower_32_bits(ring->gpu_addr));
>         WREG32_SOC15(VCN, inst_idx, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
> @@ -1067,7 +1067,7 @@ static int vcn_v2_5_start(struct amdgpu_device *adev)
>                 WREG32_SOC15(VCN, i, mmUVD_RBC_RB_CNTL, tmp);
>
>                 fw_shared->multi_queue.decode_queue_mode |= FW_QUEUE_RING_RESET;
> -               /* programm the RB_BASE for ring buffer */
> +               /* program the RB_BASE for ring buffer */
>                 WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
>                         lower_32_bits(ring->gpu_addr));
>                 WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
> --
> 2.28.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
