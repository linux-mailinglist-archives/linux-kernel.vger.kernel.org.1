Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 813882AC5B6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 21:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730248AbgKIUFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 15:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgKIUFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 15:05:25 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C945FC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 12:05:24 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id d12so8630893wrr.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 12:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kPawcM2lRAoO3n+xp9sxNFRPEQg9MejR4mgh152KlS0=;
        b=If2+gKTuuCSJPl479Z2BsVJoHGjvtH6Yef2QzoI4IsMaeWqkKuEEMsVecEj04f06aW
         B9+IWO7mJIZ2DQYxUQblUAod8w9LURDhPJAyyA1984GmL6ag5XrL61f14lr181C5X8Q3
         1dARIgqGU7fWXKavbrJgdapZDqHi8ii4eQ8sMhohZxDr9eHH9s70bwNTchEFLv6XETrb
         qJfbgBgxd3ERyRUNgTD3tXFIq3aGCqi8SiVDV4ZCqTBWGtRMSge/I/XMSMrj6xE5onRT
         9xqwdFqlVEUt8UVYdyV4jazGnMs9X4qfICiIJGrFlZ0cx6pXfCEtZmVIm1Ab3rDw37L0
         CdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kPawcM2lRAoO3n+xp9sxNFRPEQg9MejR4mgh152KlS0=;
        b=md7g9kPeDWJeB8J30mHBHMc2jrxSYiGVQXgo5/WminOwlcUeo7YRMDZC2+WsIEZyxn
         ZKvmYXTklZxFGHfbOQtUMAVO8peNUhGGbw6rauRsv3BDGLPCYCtUQY+0kSGUqIykiHfj
         0Yu/mM8FR4y8B3etPMkcoVbR6ScIH4I7iNNC7TsjzEbFLC6XXrymEVshYRuYYpXUB6PU
         te5TY0ApddSojwG0BprQa63dkhx5NDsu2YyG+klx2S3ai9rcRf0gCvj22eFmcAJdLE1c
         d2ALj+CmTGM93z0dMgAvXktCu42wLm5gZqtmwEBrP4HvD+r/UiqdUxUYnYJ5pTEfQMxX
         2HbA==
X-Gm-Message-State: AOAM530+X/Ep1diWYnKzIn1zq4vYPkRHLP/vN19WRcooJnwkgHfLzFrX
        9fCI+IJ41XfSO2BgPRqTOwn26kgYfV9zv++LkXo=
X-Google-Smtp-Source: ABdhPJyun/0BIFWEaMVeINGuxPshpk1mo0pjvZ1EKedP4jTF77Dhfmskkz8uTwhyyLMpNZBozm0Z+dw+N/2FPDyo6ck=
X-Received: by 2002:adf:e8d0:: with SMTP id k16mr19677980wrn.362.1604952323541;
 Mon, 09 Nov 2020 12:05:23 -0800 (PST)
MIME-Version: 1.0
References: <20201106214949.2042120-1-lee.jones@linaro.org> <20201106214949.2042120-17-lee.jones@linaro.org>
In-Reply-To: <20201106214949.2042120-17-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 9 Nov 2020 15:05:12 -0500
Message-ID: <CADnq5_O_kRMunO37MqKz2ychETgi6ZDB5BSO+Sxzos8YP1CKXA@mail.gmail.com>
Subject: Re: [PATCH 16/19] drm/amd/amdgpu/amdgpu_kms: Remove 'struct
 drm_amdgpu_info_device dev_info' from the stack
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 6, 2020 at 4:50 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Place it on the heap instead.
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c: In function =E2=80=98amdgpu_inf=
o_ioctl=E2=80=99:
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c:979:1: warning: the frame size o=
f 1128 bytes is larger than 1024 bytes [-Wframe-larger-than=3D]
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 104 +++++++++++++-----------
>  1 file changed, 55 insertions(+), 49 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index 918d4e9c6461a..ef6fa5007d135 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -721,38 +721,42 @@ static int amdgpu_info_ioctl(struct drm_device *dev=
, void *data, struct drm_file
>                 return n ? -EFAULT : 0;
>         }
>         case AMDGPU_INFO_DEV_INFO: {
> -               struct drm_amdgpu_info_device dev_info;
> +               struct drm_amdgpu_info_device *dev_info;
>                 uint64_t vm_size;
> +               int ret;
> +
> +               dev_info =3D kzalloc(sizeof(*dev_info), GFP_KERNEL);
> +               if (!dev_info)
> +                       return -ENOMEM;
>
> -               memset(&dev_info, 0, sizeof(dev_info));
> -               dev_info.device_id =3D dev->pdev->device;
> -               dev_info.chip_rev =3D adev->rev_id;
> -               dev_info.external_rev =3D adev->external_rev_id;
> -               dev_info.pci_rev =3D dev->pdev->revision;
> -               dev_info.family =3D adev->family;
> -               dev_info.num_shader_engines =3D adev->gfx.config.max_shad=
er_engines;
> -               dev_info.num_shader_arrays_per_engine =3D adev->gfx.confi=
g.max_sh_per_se;
> +               dev_info->device_id =3D dev->pdev->device;
> +               dev_info->chip_rev =3D adev->rev_id;
> +               dev_info->external_rev =3D adev->external_rev_id;
> +               dev_info->pci_rev =3D dev->pdev->revision;
> +               dev_info->family =3D adev->family;
> +               dev_info->num_shader_engines =3D adev->gfx.config.max_sha=
der_engines;
> +               dev_info->num_shader_arrays_per_engine =3D adev->gfx.conf=
ig.max_sh_per_se;
>                 /* return all clocks in KHz */
> -               dev_info.gpu_counter_freq =3D amdgpu_asic_get_xclk(adev) =
* 10;
> +               dev_info->gpu_counter_freq =3D amdgpu_asic_get_xclk(adev)=
 * 10;
>                 if (adev->pm.dpm_enabled) {
> -                       dev_info.max_engine_clock =3D amdgpu_dpm_get_sclk=
(adev, false) * 10;
> -                       dev_info.max_memory_clock =3D amdgpu_dpm_get_mclk=
(adev, false) * 10;
> +                       dev_info->max_engine_clock =3D amdgpu_dpm_get_scl=
k(adev, false) * 10;
> +                       dev_info->max_memory_clock =3D amdgpu_dpm_get_mcl=
k(adev, false) * 10;
>                 } else {
> -                       dev_info.max_engine_clock =3D adev->clock.default=
_sclk * 10;
> -                       dev_info.max_memory_clock =3D adev->clock.default=
_mclk * 10;
> +                       dev_info->max_engine_clock =3D adev->clock.defaul=
t_sclk * 10;
> +                       dev_info->max_memory_clock =3D adev->clock.defaul=
t_mclk * 10;
>                 }
> -               dev_info.enabled_rb_pipes_mask =3D adev->gfx.config.backe=
nd_enable_mask;
> -               dev_info.num_rb_pipes =3D adev->gfx.config.max_backends_p=
er_se *
> +               dev_info->enabled_rb_pipes_mask =3D adev->gfx.config.back=
end_enable_mask;
> +               dev_info->num_rb_pipes =3D adev->gfx.config.max_backends_=
per_se *
>                         adev->gfx.config.max_shader_engines;
> -               dev_info.num_hw_gfx_contexts =3D adev->gfx.config.max_hw_=
contexts;
> -               dev_info._pad =3D 0;
> -               dev_info.ids_flags =3D 0;
> +               dev_info->num_hw_gfx_contexts =3D adev->gfx.config.max_hw=
_contexts;
> +               dev_info->_pad =3D 0;
> +               dev_info->ids_flags =3D 0;
>                 if (adev->flags & AMD_IS_APU)
> -                       dev_info.ids_flags |=3D AMDGPU_IDS_FLAGS_FUSION;
> +                       dev_info->ids_flags |=3D AMDGPU_IDS_FLAGS_FUSION;
>                 if (amdgpu_mcbp || amdgpu_sriov_vf(adev))
> -                       dev_info.ids_flags |=3D AMDGPU_IDS_FLAGS_PREEMPTI=
ON;
> +                       dev_info->ids_flags |=3D AMDGPU_IDS_FLAGS_PREEMPT=
ION;
>                 if (amdgpu_is_tmz(adev))
> -                       dev_info.ids_flags |=3D AMDGPU_IDS_FLAGS_TMZ;
> +                       dev_info->ids_flags |=3D AMDGPU_IDS_FLAGS_TMZ;
>
>                 vm_size =3D adev->vm_manager.max_pfn * AMDGPU_GPU_PAGE_SI=
ZE;
>                 vm_size -=3D AMDGPU_VA_RESERVED_SIZE;
> @@ -762,45 +766,47 @@ static int amdgpu_info_ioctl(struct drm_device *dev=
, void *data, struct drm_file
>                     adev->vce.fw_version < AMDGPU_VCE_FW_53_45)
>                         vm_size =3D min(vm_size, 1ULL << 40);
>
> -               dev_info.virtual_address_offset =3D AMDGPU_VA_RESERVED_SI=
ZE;
> -               dev_info.virtual_address_max =3D
> +               dev_info->virtual_address_offset =3D AMDGPU_VA_RESERVED_S=
IZE;
> +               dev_info->virtual_address_max =3D
>                         min(vm_size, AMDGPU_GMC_HOLE_START);
>
>                 if (vm_size > AMDGPU_GMC_HOLE_START) {
> -                       dev_info.high_va_offset =3D AMDGPU_GMC_HOLE_END;
> -                       dev_info.high_va_max =3D AMDGPU_GMC_HOLE_END | vm=
_size;
> +                       dev_info->high_va_offset =3D AMDGPU_GMC_HOLE_END;
> +                       dev_info->high_va_max =3D AMDGPU_GMC_HOLE_END | v=
m_size;
>                 }
> -               dev_info.virtual_address_alignment =3D max((int)PAGE_SIZE=
, AMDGPU_GPU_PAGE_SIZE);
> -               dev_info.pte_fragment_size =3D (1 << adev->vm_manager.fra=
gment_size) * AMDGPU_GPU_PAGE_SIZE;
> -               dev_info.gart_page_size =3D AMDGPU_GPU_PAGE_SIZE;
> -               dev_info.cu_active_number =3D adev->gfx.cu_info.number;
> -               dev_info.cu_ao_mask =3D adev->gfx.cu_info.ao_cu_mask;
> -               dev_info.ce_ram_size =3D adev->gfx.ce_ram_size;
> -               memcpy(&dev_info.cu_ao_bitmap[0], &adev->gfx.cu_info.ao_c=
u_bitmap[0],
> +               dev_info->virtual_address_alignment =3D max((int)PAGE_SIZ=
E, AMDGPU_GPU_PAGE_SIZE);
> +               dev_info->pte_fragment_size =3D (1 << adev->vm_manager.fr=
agment_size) * AMDGPU_GPU_PAGE_SIZE;
> +               dev_info->gart_page_size =3D AMDGPU_GPU_PAGE_SIZE;
> +               dev_info->cu_active_number =3D adev->gfx.cu_info.number;
> +               dev_info->cu_ao_mask =3D adev->gfx.cu_info.ao_cu_mask;
> +               dev_info->ce_ram_size =3D adev->gfx.ce_ram_size;
> +               memcpy(&dev_info->cu_ao_bitmap[0], &adev->gfx.cu_info.ao_=
cu_bitmap[0],
>                        sizeof(adev->gfx.cu_info.ao_cu_bitmap));
> -               memcpy(&dev_info.cu_bitmap[0], &adev->gfx.cu_info.bitmap[=
0],
> +               memcpy(&dev_info->cu_bitmap[0], &adev->gfx.cu_info.bitmap=
[0],
>                        sizeof(adev->gfx.cu_info.bitmap));
> -               dev_info.vram_type =3D adev->gmc.vram_type;
> -               dev_info.vram_bit_width =3D adev->gmc.vram_width;
> -               dev_info.vce_harvest_config =3D adev->vce.harvest_config;
> -               dev_info.gc_double_offchip_lds_buf =3D
> +               dev_info->vram_type =3D adev->gmc.vram_type;
> +               dev_info->vram_bit_width =3D adev->gmc.vram_width;
> +               dev_info->vce_harvest_config =3D adev->vce.harvest_config=
;
> +               dev_info->gc_double_offchip_lds_buf =3D
>                         adev->gfx.config.double_offchip_lds_buf;
> -               dev_info.wave_front_size =3D adev->gfx.cu_info.wave_front=
_size;
> -               dev_info.num_shader_visible_vgprs =3D adev->gfx.config.ma=
x_gprs;
> -               dev_info.num_cu_per_sh =3D adev->gfx.config.max_cu_per_sh=
;
> -               dev_info.num_tcc_blocks =3D adev->gfx.config.max_texture_=
channel_caches;
> -               dev_info.gs_vgt_table_depth =3D adev->gfx.config.gs_vgt_t=
able_depth;
> -               dev_info.gs_prim_buffer_depth =3D adev->gfx.config.gs_pri=
m_buffer_depth;
> -               dev_info.max_gs_waves_per_vgt =3D adev->gfx.config.max_gs=
_threads;
> +               dev_info->wave_front_size =3D adev->gfx.cu_info.wave_fron=
t_size;
> +               dev_info->num_shader_visible_vgprs =3D adev->gfx.config.m=
ax_gprs;
> +               dev_info->num_cu_per_sh =3D adev->gfx.config.max_cu_per_s=
h;
> +               dev_info->num_tcc_blocks =3D adev->gfx.config.max_texture=
_channel_caches;
> +               dev_info->gs_vgt_table_depth =3D adev->gfx.config.gs_vgt_=
table_depth;
> +               dev_info->gs_prim_buffer_depth =3D adev->gfx.config.gs_pr=
im_buffer_depth;
> +               dev_info->max_gs_waves_per_vgt =3D adev->gfx.config.max_g=
s_threads;
>
>                 if (adev->family >=3D AMDGPU_FAMILY_NV)
> -                       dev_info.pa_sc_tile_steering_override =3D
> +                       dev_info->pa_sc_tile_steering_override =3D
>                                 adev->gfx.config.pa_sc_tile_steering_over=
ride;
>
> -               dev_info.tcc_disabled_mask =3D adev->gfx.config.tcc_disab=
led_mask;
> +               dev_info->tcc_disabled_mask =3D adev->gfx.config.tcc_disa=
bled_mask;
>
> -               return copy_to_user(out, &dev_info,
> -                                   min((size_t)size, sizeof(dev_info))) =
? -EFAULT : 0;
> +               ret =3D copy_to_user(out, dev_info,
> +                                  min((size_t)size, sizeof(*dev_info))) =
? -EFAULT : 0;
> +               kfree(dev_info);
> +               return ret;
>         }
>         case AMDGPU_INFO_VCE_CLOCK_TABLE: {
>                 unsigned i;
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
