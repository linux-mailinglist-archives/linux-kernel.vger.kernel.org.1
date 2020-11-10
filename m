Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD7E2AE429
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 00:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732129AbgKJXhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 18:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731657AbgKJXhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 18:37:48 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E0AC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 15:37:47 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id j7so358340wrp.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 15:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Yb+qWElcbxhMCHWdR7fvqrDOFqRL7kDPoCt4Qpb8NVI=;
        b=P4NviAcWcssz9ezsgrzOIc2ZuRPXmvMeotdPYhg+XibH4Xu2eHtaqn9e6vDTg1hoND
         1SGWGQwW6u3rHims7kJBOYiQ7hNeRTBdSXmR0Pl7Va7qOEWawyXDNKPUNdr3Kk5mFdbc
         67DX6iN9y0EFsA/No0jGJO9JpUGnwt2gdBPy3qOB/A22ywi6G7DMLpXv4krOSkvXskLH
         sGGc6dW1mBMcJx/F6CkpjnLla5lMqWBRvhvox8zD8Ncme8wqKBdntqZgDnFUM6i1Qink
         NGcq/iYvq4dWWNLsCj33KnJ8sJmNa2xq6G+J0saUh47rOegjtXblqP86IPH1QypZU4ji
         SvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Yb+qWElcbxhMCHWdR7fvqrDOFqRL7kDPoCt4Qpb8NVI=;
        b=KQEL7jN/wLemzB9HIyQCrLVLra8Yp+F24475EA2+VSSzhTJqN3QblVoNRKAJT4NCAX
         iTTx3of+vY66iTuqOWdtnF7g049idZ0y54i2masgJd+6hwt8szCdLVxz33vPJMXpLnmc
         UIdKxFWJgpyE2N2+Ywq1sJB07vp1tsid+bXNjayHk9ZWhkON3aNxPNVgtRYSCGjYbPR/
         1hCzXcxxPSpfItX7nkiqTc7hmKyDcgXqv14vYGJ2ftierAbXf3K+aHhF0Qhvmmn5bDDd
         ZY/u+/ugGMImQgPkYtJWUqXxxT876QZMOSdiRBZSLVmYFv0gwM0RH65i30vbyGgYHw96
         QaRw==
X-Gm-Message-State: AOAM532h5M7oTw1rop+x4l3tswXkSS03D25+BFOUp1pkiqZ5MPSf0FkX
        ZmYMpWOaYl0PotW5uYcEM40+5mvsXZ5bblnx00I=
X-Google-Smtp-Source: ABdhPJxXoZiUl01lutKzfekjHIbU0x1i5uZ4B+L+TrH5lx9RqoINm3Nn6eV0ShM/sP16yST3Hl5hzCLYtaiuTfkABUQ=
X-Received: by 2002:adf:e9c9:: with SMTP id l9mr28105445wrn.124.1605051466326;
 Tue, 10 Nov 2020 15:37:46 -0800 (PST)
MIME-Version: 1.0
References: <20201110193112.988999-1-lee.jones@linaro.org> <20201110193112.988999-8-lee.jones@linaro.org>
In-Reply-To: <20201110193112.988999-8-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 10 Nov 2020 18:37:35 -0500
Message-ID: <CADnq5_O92Xd+TFftii=VPOfzO_kVeL1OxbZ-N_5rMBJzYS5upA@mail.gmail.com>
Subject: Re: [PATCH 07/30] drm/radeon/kv_dpm: Strip out unused functions and
 their tables
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

On Tue, Nov 10, 2020 at 2:31 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> These haven't been used since the driver was upstreamed in 2013.
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/radeon/kv_dpm.c:161:40: warning: =E2=80=98cpl_cac_config=
_reg=E2=80=99 defined but not used [-Wunused-const-variable=3D]
>  drivers/gpu/drm/radeon/kv_dpm.c:156:40: warning: =E2=80=98mc3_cac_config=
_reg=E2=80=99 defined but not used [-Wunused-const-variable=3D]
>  drivers/gpu/drm/radeon/kv_dpm.c:151:40: warning: =E2=80=98mc2_cac_config=
_reg=E2=80=99 defined but not used [-Wunused-const-variable=3D]
>  drivers/gpu/drm/radeon/kv_dpm.c:146:40: warning: =E2=80=98mc1_cac_config=
_reg=E2=80=99 defined but not used [-Wunused-const-variable=3D]
>  drivers/gpu/drm/radeon/kv_dpm.c:141:40: warning: =E2=80=98mc0_cac_config=
_reg=E2=80=99 defined but not used [-Wunused-const-variable=3D]
>  drivers/gpu/drm/radeon/kv_dpm.c:136:40: warning: =E2=80=98sx0_cac_config=
_reg=E2=80=99 defined but not used [-Wunused-const-variable=3D]
>  drivers/gpu/drm/radeon/kv_dpm.c:104:43: warning: =E2=80=98cpl_local_cac_=
cfg_kv=E2=80=99 defined but not used [-Wunused-const-variable=3D]
>  drivers/gpu/drm/radeon/kv_dpm.c:98:43: warning: =E2=80=98mc3_local_cac_c=
fg_kv=E2=80=99 defined but not used [-Wunused-const-variable=3D]
>  drivers/gpu/drm/radeon/kv_dpm.c:92:43: warning: =E2=80=98mc2_local_cac_c=
fg_kv=E2=80=99 defined but not used [-Wunused-const-variable=3D]
>  drivers/gpu/drm/radeon/kv_dpm.c:86:43: warning: =E2=80=98mc1_local_cac_c=
fg_kv=E2=80=99 defined but not used [-Wunused-const-variable=3D]
>  drivers/gpu/drm/radeon/kv_dpm.c:80:43: warning: =E2=80=98mc0_local_cac_c=
fg_kv=E2=80=99 defined but not used [-Wunused-const-variable=3D]
>  drivers/gpu/drm/radeon/kv_dpm.c:67:43: warning: =E2=80=98sx_local_cac_cf=
g_kv=E2=80=99 defined but not used [-Wunused-const-variable=3D]
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
>  drivers/gpu/drm/radeon/kv_dpm.c | 205 +-------------------------------
>  1 file changed, 1 insertion(+), 204 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/kv_dpm.c b/drivers/gpu/drm/radeon/kv_=
dpm.c
> index 5e6086eb18073..f7735da07feb9 100644
> --- a/drivers/gpu/drm/radeon/kv_dpm.c
> +++ b/drivers/gpu/drm/radeon/kv_dpm.c
> @@ -64,105 +64,6 @@ extern void cik_exit_rlc_safe_mode(struct radeon_devi=
ce *rdev);
>  extern void cik_update_cg(struct radeon_device *rdev,
>                           u32 block, bool enable);
>
> -static const struct kv_lcac_config_values sx_local_cac_cfg_kv[] =3D
> -{
> -       {  0,       4,        1    },
> -       {  1,       4,        1    },
> -       {  2,       5,        1    },
> -       {  3,       4,        2    },
> -       {  4,       1,        1    },
> -       {  5,       5,        2    },
> -       {  6,       6,        1    },
> -       {  7,       9,        2    },
> -       { 0xffffffff }
> -};
> -
> -static const struct kv_lcac_config_values mc0_local_cac_cfg_kv[] =3D
> -{
> -       {  0,       4,        1    },
> -       { 0xffffffff }
> -};
> -
> -static const struct kv_lcac_config_values mc1_local_cac_cfg_kv[] =3D
> -{
> -       {  0,       4,        1    },
> -       { 0xffffffff }
> -};
> -
> -static const struct kv_lcac_config_values mc2_local_cac_cfg_kv[] =3D
> -{
> -       {  0,       4,        1    },
> -       { 0xffffffff }
> -};
> -
> -static const struct kv_lcac_config_values mc3_local_cac_cfg_kv[] =3D
> -{
> -       {  0,       4,        1    },
> -       { 0xffffffff }
> -};
> -
> -static const struct kv_lcac_config_values cpl_local_cac_cfg_kv[] =3D
> -{
> -       {  0,       4,        1    },
> -       {  1,       4,        1    },
> -       {  2,       5,        1    },
> -       {  3,       4,        1    },
> -       {  4,       1,        1    },
> -       {  5,       5,        1    },
> -       {  6,       6,        1    },
> -       {  7,       9,        1    },
> -       {  8,       4,        1    },
> -       {  9,       2,        1    },
> -       {  10,      3,        1    },
> -       {  11,      6,        1    },
> -       {  12,      8,        2    },
> -       {  13,      1,        1    },
> -       {  14,      2,        1    },
> -       {  15,      3,        1    },
> -       {  16,      1,        1    },
> -       {  17,      4,        1    },
> -       {  18,      3,        1    },
> -       {  19,      1,        1    },
> -       {  20,      8,        1    },
> -       {  21,      5,        1    },
> -       {  22,      1,        1    },
> -       {  23,      1,        1    },
> -       {  24,      4,        1    },
> -       {  27,      6,        1    },
> -       {  28,      1,        1    },
> -       { 0xffffffff }
> -};
> -
> -static const struct kv_lcac_config_reg sx0_cac_config_reg[] =3D
> -{
> -       { 0xc0400d00, 0x003e0000, 17, 0x3fc00000, 22, 0x0001fffe, 1, 0x00=
000001, 0 }
> -};
> -
> -static const struct kv_lcac_config_reg mc0_cac_config_reg[] =3D
> -{
> -       { 0xc0400d30, 0x003e0000, 17, 0x3fc00000, 22, 0x0001fffe, 1, 0x00=
000001, 0 }
> -};
> -
> -static const struct kv_lcac_config_reg mc1_cac_config_reg[] =3D
> -{
> -       { 0xc0400d3c, 0x003e0000, 17, 0x3fc00000, 22, 0x0001fffe, 1, 0x00=
000001, 0 }
> -};
> -
> -static const struct kv_lcac_config_reg mc2_cac_config_reg[] =3D
> -{
> -       { 0xc0400d48, 0x003e0000, 17, 0x3fc00000, 22, 0x0001fffe, 1, 0x00=
000001, 0 }
> -};
> -
> -static const struct kv_lcac_config_reg mc3_cac_config_reg[] =3D
> -{
> -       { 0xc0400d54, 0x003e0000, 17, 0x3fc00000, 22, 0x0001fffe, 1, 0x00=
000001, 0 }
> -};
> -
> -static const struct kv_lcac_config_reg cpl_cac_config_reg[] =3D
> -{
> -       { 0xc0400d80, 0x003e0000, 17, 0x3fc00000, 22, 0x0001fffe, 1, 0x00=
000001, 0 }
> -};
> -
>  static const struct kv_pt_config_reg didt_config_kv[] =3D
>  {
>         { 0x10, 0x000000ff, 0, 0x0, KV_CONFIGREG_DIDT_IND },
> @@ -254,32 +155,6 @@ static struct kv_power_info *kv_get_pi(struct radeon=
_device *rdev)
>         return pi;
>  }
>
> -#if 0
> -static void kv_program_local_cac_table(struct radeon_device *rdev,
> -                                      const struct kv_lcac_config_values=
 *local_cac_table,
> -                                      const struct kv_lcac_config_reg *l=
ocal_cac_reg)
> -{
> -       u32 i, count, data;
> -       const struct kv_lcac_config_values *values =3D local_cac_table;
> -
> -       while (values->block_id !=3D 0xffffffff) {
> -               count =3D values->signal_id;
> -               for (i =3D 0; i < count; i++) {
> -                       data =3D ((values->block_id << local_cac_reg->blo=
ck_shift) &
> -                               local_cac_reg->block_mask);
> -                       data |=3D ((i << local_cac_reg->signal_shift) &
> -                                local_cac_reg->signal_mask);
> -                       data |=3D ((values->t << local_cac_reg->t_shift) =
&
> -                                local_cac_reg->t_mask);
> -                       data |=3D ((1 << local_cac_reg->enable_shift) &
> -                                local_cac_reg->enable_mask);
> -                       WREG32_SMC(local_cac_reg->cntl, data);
> -               }
> -               values++;
> -       }
> -}
> -#endif
> -
>  static int kv_program_pt_config_registers(struct radeon_device *rdev,
>                                           const struct kv_pt_config_reg *=
cac_config_regs)
>  {
> @@ -398,39 +273,6 @@ static int kv_enable_didt(struct radeon_device *rdev=
, bool enable)
>         return 0;
>  }
>
> -#if 0
> -static void kv_initialize_hardware_cac_manager(struct radeon_device *rde=
v)
> -{
> -       struct kv_power_info *pi =3D kv_get_pi(rdev);
> -
> -       if (pi->caps_cac) {
> -               WREG32_SMC(LCAC_SX0_OVR_SEL, 0);
> -               WREG32_SMC(LCAC_SX0_OVR_VAL, 0);
> -               kv_program_local_cac_table(rdev, sx_local_cac_cfg_kv, sx0=
_cac_config_reg);
> -
> -               WREG32_SMC(LCAC_MC0_OVR_SEL, 0);
> -               WREG32_SMC(LCAC_MC0_OVR_VAL, 0);
> -               kv_program_local_cac_table(rdev, mc0_local_cac_cfg_kv, mc=
0_cac_config_reg);
> -
> -               WREG32_SMC(LCAC_MC1_OVR_SEL, 0);
> -               WREG32_SMC(LCAC_MC1_OVR_VAL, 0);
> -               kv_program_local_cac_table(rdev, mc1_local_cac_cfg_kv, mc=
1_cac_config_reg);
> -
> -               WREG32_SMC(LCAC_MC2_OVR_SEL, 0);
> -               WREG32_SMC(LCAC_MC2_OVR_VAL, 0);
> -               kv_program_local_cac_table(rdev, mc2_local_cac_cfg_kv, mc=
2_cac_config_reg);
> -
> -               WREG32_SMC(LCAC_MC3_OVR_SEL, 0);
> -               WREG32_SMC(LCAC_MC3_OVR_VAL, 0);
> -               kv_program_local_cac_table(rdev, mc3_local_cac_cfg_kv, mc=
3_cac_config_reg);
> -
> -               WREG32_SMC(LCAC_CPL_OVR_SEL, 0);
> -               WREG32_SMC(LCAC_CPL_OVR_VAL, 0);
> -               kv_program_local_cac_table(rdev, cpl_local_cac_cfg_kv, cp=
l_cac_config_reg);
> -       }
> -}
> -#endif
> -
>  static int kv_enable_smc_cac(struct radeon_device *rdev, bool enable)
>  {
>         struct kv_power_info *pi =3D kv_get_pi(rdev);
> @@ -1227,9 +1069,7 @@ int kv_dpm_enable(struct radeon_device *rdev)
>                 return ret;
>         }
>         kv_program_vc(rdev);
> -#if 0
> -       kv_initialize_hardware_cac_manager(rdev);
> -#endif
> +
>         kv_start_am(rdev);
>         if (pi->enable_auto_thermal_throttling) {
>                 ret =3D kv_enable_auto_thermal_throttling(rdev);
> @@ -1330,26 +1170,6 @@ void kv_dpm_disable(struct radeon_device *rdev)
>         kv_update_current_ps(rdev, rdev->pm.dpm.boot_ps);
>  }
>
> -#if 0
> -static int kv_write_smc_soft_register(struct radeon_device *rdev,
> -                                     u16 reg_offset, u32 value)
> -{
> -       struct kv_power_info *pi =3D kv_get_pi(rdev);
> -
> -       return kv_copy_bytes_to_smc(rdev, pi->soft_regs_start + reg_offse=
t,
> -                                   (u8 *)&value, sizeof(u16), pi->sram_e=
nd);
> -}
> -
> -static int kv_read_smc_soft_register(struct radeon_device *rdev,
> -                                    u16 reg_offset, u32 *value)
> -{
> -       struct kv_power_info *pi =3D kv_get_pi(rdev);
> -
> -       return kv_read_smc_sram_dword(rdev, pi->soft_regs_start + reg_off=
set,
> -                                     value, pi->sram_end);
> -}
> -#endif
> -
>  static void kv_init_sclk_t(struct radeon_device *rdev)
>  {
>         struct kv_power_info *pi =3D kv_get_pi(rdev);
> @@ -1939,29 +1759,6 @@ void kv_dpm_setup_asic(struct radeon_device *rdev)
>         kv_init_sclk_t(rdev);
>  }
>
> -#if 0
> -void kv_dpm_reset_asic(struct radeon_device *rdev)
> -{
> -       struct kv_power_info *pi =3D kv_get_pi(rdev);
> -
> -       if (rdev->family =3D=3D CHIP_KABINI || rdev->family =3D=3D CHIP_M=
ULLINS) {
> -               kv_force_lowest_valid(rdev);
> -               kv_init_graphics_levels(rdev);
> -               kv_program_bootup_state(rdev);
> -               kv_upload_dpm_settings(rdev);
> -               kv_force_lowest_valid(rdev);
> -               kv_unforce_levels(rdev);
> -       } else {
> -               kv_init_graphics_levels(rdev);
> -               kv_program_bootup_state(rdev);
> -               kv_freeze_sclk_dpm(rdev, true);
> -               kv_upload_dpm_settings(rdev);
> -               kv_freeze_sclk_dpm(rdev, false);
> -               kv_set_enabled_level(rdev, pi->graphics_boot_level);
> -       }
> -}
> -#endif
> -
>  //XXX use sumo_dpm_display_configuration_changed
>
>  static void kv_construct_max_power_limits_table(struct radeon_device *rd=
ev,
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
