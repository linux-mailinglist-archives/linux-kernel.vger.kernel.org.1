Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E365F2A346A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 20:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgKBTlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 14:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbgKBTlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 14:41:16 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8732C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 11:41:14 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id p22so10549708wmg.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 11:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LqcHdLzSA2qQc1X68Vq82MBenpv7Ybc4DNUy5zNwiWw=;
        b=JHHV7/BsfOVqboob+IF/ztIUe6EPp4aKvN3PSgKuQH0mmfKvqGLjPLZ7wT+M2qfJGt
         Xhva+tJfn32hK1CMU1A3DtF2tmRhuT+vrNVkLIsQVnv1tmilaJ4J9596N97C8QBM14+P
         kicjmFdbg/Z1JA+d0q+buW8tJk5/a1T+Wj5OZdQqkVvlSSpPigIKjCafSQ6V53VeQU1W
         OC50CR22lT/WyZ0tWaERaJheZVqhD5ubOYEDgA1Up8XiOpYi+j8PkTr74Nr53+i669AH
         SRBLUbWZsMgAcL9BBewar+L//33a1Pu3oKv2Om5V+9jz/y6J6zr3+JT6uqALMgAEt2Ng
         jIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LqcHdLzSA2qQc1X68Vq82MBenpv7Ybc4DNUy5zNwiWw=;
        b=rGkc08mKH1OrO5f5y5sV4m2NHw90ERrbU3D4TrBw3gA2KkefL6VNHWiZfI/wPY4XKX
         0fpcBYdwbi5SZ73jEf44OfLh6ScrrjuYDvv9oHaxW7ZHgdpe4BNmCsEA6Syn1hJ/WMD9
         uCqqqeRm931Pb/PiDZNHR73C6g6W3H/+kBmlH0nOKrCDKBhJYU3qCb3YvcUMebcU+tym
         bBmoKZLVJ5+U4JVjUJFyQchuG+hLQf93gftgRHXiGmiCAACb0xNGsKsmlvNlrbUaMg1K
         g5pYBq2Jb9CO+1XK2QTlSmobC5x27uxN46H+sy538MgRMA2nKxw+NdQngk7hRbuv1yDe
         Dx/A==
X-Gm-Message-State: AOAM530RplXyG/pi4DfW1YwJfzi89xavXGrdqVmSEklDGfZjEASeSSrA
        iVFeIo4kCITGjZfuiAp5CqoadJ7PfkniqKm15As=
X-Google-Smtp-Source: ABdhPJwEMsA9LUizLq1KnAxynGdGw8Wz3csy+RlZ4tFBiRy0/zUCkfy3t0G4+5NIJwpVYuky3hphvTmJO+SvILqygT4=
X-Received: by 2002:a7b:c157:: with SMTP id z23mr19059635wmi.70.1604346073573;
 Mon, 02 Nov 2020 11:41:13 -0800 (PST)
MIME-Version: 1.0
References: <d644879c4cac32a7cbdbbeebc97c98efd421e17f.1604336791.git.mh12gx2825@gmail.com>
 <1b15f176289a7829c644dc9b7770f654eaee0efb.1604336791.git.mh12gx2825@gmail.com>
In-Reply-To: <1b15f176289a7829c644dc9b7770f654eaee0efb.1604336791.git.mh12gx2825@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 2 Nov 2020 14:41:01 -0500
Message-ID: <CADnq5_NdngaOKN4xSj1a-R7+ZnGxkqvpQsLOj-KnAqnB9WJ2oQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] drm/amdgpu: improve code indentation and alignment
To:     Deepak R Varma <mh12gx2825@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Greg KH <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Melissa Wen <melissa.srw@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied the series.  Thanks!

Alex

On Mon, Nov 2, 2020 at 12:44 PM Deepak R Varma <mh12gx2825@gmail.com> wrote:
>
> General code indentation and alignment changes such as replace spaces
> by tabs or align function arguments as per the coding style
> guidelines. The patch covers various .c files for this driver.
> Issue reported by checkpatch script.
>
> Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/atom.c       | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/cik_sdma.c   | 2 +-
>  drivers/gpu/drm/amd/amdgpu/df_v1_7.c    | 2 +-
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c  | 8 ++++----
>  drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/si.c         | 2 +-
>  drivers/gpu/drm/amd/amdgpu/si_ih.c      | 2 +-
>  drivers/gpu/drm/amd/amdgpu/soc15.c      | 2 +-
>  9 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
> index 4cfc786699c7..696e97ab77eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
> @@ -71,8 +71,8 @@ static int amdgpu_atom_execute_table_locked(struct atom_context *ctx, int index,
>  int amdgpu_atom_execute_table(struct atom_context *ctx, int index, uint32_t * params);
>
>  static uint32_t atom_arg_mask[8] =
> -    { 0xFFFFFFFF, 0xFFFF, 0xFFFF00, 0xFFFF0000, 0xFF, 0xFF00, 0xFF0000,
> -0xFF000000 };
> +       { 0xFFFFFFFF, 0xFFFF, 0xFFFF00, 0xFFFF0000, 0xFF, 0xFF00, 0xFF0000,
> +         0xFF000000 };
>  static int atom_arg_shift[8] = { 0, 0, 8, 16, 0, 8, 16, 24 };
>
>  static int atom_dst_to_src[8][4] = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> index 20f108818b2b..52f05d2f5ed9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> @@ -195,7 +195,7 @@ static void cik_sdma_ring_set_wptr(struct amdgpu_ring *ring)
>         struct amdgpu_device *adev = ring->adev;
>
>         WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[ring->me],
> -                       (lower_32_bits(ring->wptr) << 2) & 0x3fffc);
> +              (lower_32_bits(ring->wptr) << 2) & 0x3fffc);
>  }
>
>  static void cik_sdma_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
> diff --git a/drivers/gpu/drm/amd/amdgpu/df_v1_7.c b/drivers/gpu/drm/amd/amdgpu/df_v1_7.c
> index d6aca1c08068..2d01ac0d4c11 100644
> --- a/drivers/gpu/drm/amd/amdgpu/df_v1_7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/df_v1_7.c
> @@ -41,7 +41,7 @@ static void df_v1_7_sw_fini(struct amdgpu_device *adev)
>  }
>
>  static void df_v1_7_enable_broadcast_mode(struct amdgpu_device *adev,
> -                                          bool enable)
> +                                         bool enable)
>  {
>         u32 tmp;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index dbc8b76b9b78..6b04729d8fec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -145,7 +145,7 @@ static const struct amdgpu_irq_src_funcs gmc_v10_0_ecc_funcs = {
>         .process = amdgpu_umc_process_ecc_irq,
>  };
>
> - static void gmc_v10_0_set_irq_funcs(struct amdgpu_device *adev)
> +static void gmc_v10_0_set_irq_funcs(struct amdgpu_device *adev)
>  {
>         adev->gmc.vm_fault.num_types = 1;
>         adev->gmc.vm_fault.funcs = &gmc_v10_0_irq_funcs;
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> index 94caf5204c8b..7b1a18cbafc4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> @@ -32,19 +32,19 @@
>  #include "vcn/vcn_2_0_0_sh_mask.h"
>  #include "ivsrcid/vcn/irqsrcs_vcn_2_0.h"
>
> -#define mmUVD_JRBC_EXTERNAL_REG_INTERNAL_OFFSET                        0x1bfff
> +#define mmUVD_JRBC_EXTERNAL_REG_INTERNAL_OFFSET                                0x1bfff
>  #define mmUVD_JPEG_GPCOM_CMD_INTERNAL_OFFSET                           0x4029
>  #define mmUVD_JPEG_GPCOM_DATA0_INTERNAL_OFFSET                         0x402a
>  #define mmUVD_JPEG_GPCOM_DATA1_INTERNAL_OFFSET                         0x402b
>  #define mmUVD_LMI_JRBC_RB_MEM_WR_64BIT_BAR_LOW_INTERNAL_OFFSET         0x40ea
> -#define mmUVD_LMI_JRBC_RB_MEM_WR_64BIT_BAR_HIGH_INTERNAL_OFFSET        0x40eb
> +#define mmUVD_LMI_JRBC_RB_MEM_WR_64BIT_BAR_HIGH_INTERNAL_OFFSET                0x40eb
>  #define mmUVD_LMI_JRBC_IB_VMID_INTERNAL_OFFSET                         0x40cf
>  #define mmUVD_LMI_JPEG_VMID_INTERNAL_OFFSET                            0x40d1
> -#define mmUVD_LMI_JRBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET                0x40e8
> +#define mmUVD_LMI_JRBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET                        0x40e8
>  #define mmUVD_LMI_JRBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET               0x40e9
>  #define mmUVD_JRBC_IB_SIZE_INTERNAL_OFFSET                             0x4082
>  #define mmUVD_LMI_JRBC_RB_MEM_RD_64BIT_BAR_LOW_INTERNAL_OFFSET         0x40ec
> -#define mmUVD_LMI_JRBC_RB_MEM_RD_64BIT_BAR_HIGH_INTERNAL_OFFSET        0x40ed
> +#define mmUVD_LMI_JRBC_RB_MEM_RD_64BIT_BAR_HIGH_INTERNAL_OFFSET                0x40ed
>  #define mmUVD_JRBC_RB_COND_RD_TIMER_INTERNAL_OFFSET                    0x4085
>  #define mmUVD_JRBC_RB_REF_DATA_INTERNAL_OFFSET                         0x4084
>  #define mmUVD_JRBC_STATUS_INTERNAL_OFFSET                              0x4089
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> index f84701c562bf..0309d84c887d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> @@ -409,7 +409,7 @@ static void mmhub_v1_0_set_fault_enable_default(struct amdgpu_device *adev, bool
>                                 CRASH_ON_NO_RETRY_FAULT, 1);
>                 tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
>                                 CRASH_ON_RETRY_FAULT, 1);
> -    }
> +       }
>
>         WREG32_SOC15(MMHUB, 0, mmVM_L2_PROTECTION_FAULT_CNTL, tmp);
>  }
> @@ -712,7 +712,7 @@ static int mmhub_v1_0_get_ras_error_count(struct amdgpu_device *adev,
>         uint32_t sec_cnt, ded_cnt;
>
>         for (i = 0; i < ARRAY_SIZE(mmhub_v1_0_ras_fields); i++) {
> -               if(mmhub_v1_0_ras_fields[i].reg_offset != reg->reg_offset)
> +               if (mmhub_v1_0_ras_fields[i].reg_offset != reg->reg_offset)
>                         continue;
>
>                 sec_cnt = (value &
> diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
> index e5e336fd9e94..3cf0589bfea5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si.c
> @@ -1350,7 +1350,7 @@ static void si_vga_set_state(struct amdgpu_device *adev, bool state)
>
>  static u32 si_get_xclk(struct amdgpu_device *adev)
>  {
> -        u32 reference_clock = adev->clock.spll.reference_freq;
> +       u32 reference_clock = adev->clock.spll.reference_freq;
>         u32 tmp;
>
>         tmp = RREG32(CG_CLKPIN_CNTL_2);
> diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c b/drivers/gpu/drm/amd/amdgpu/si_ih.c
> index 621727d7fd18..51880f6ef634 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
> @@ -43,7 +43,7 @@ static void si_ih_enable_interrupts(struct amdgpu_device *adev)
>         WREG32(IH_RB_CNTL, ih_rb_cntl);
>         adev->irq.ih.enabled = true;
>  }
> -
> +
>  static void si_ih_disable_interrupts(struct amdgpu_device *adev)
>  {
>         u32 ih_rb_cntl = RREG32(IH_RB_CNTL);
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index afcccc6c0fc6..b4e6ff78ddd0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -822,7 +822,7 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
>                         amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
>  #if defined(CONFIG_DRM_AMD_DC)
>                  else if (amdgpu_device_has_dc_support(adev))
> -                        amdgpu_device_ip_block_add(adev, &dm_ip_block);
> +                       amdgpu_device_ip_block_add(adev, &dm_ip_block);
>  #endif
>                 amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_block);
>                 amdgpu_device_ip_block_add(adev, &jpeg_v2_0_ip_block);
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
