Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B932C2C06
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 16:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389973AbgKXPyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 10:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728411AbgKXPyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 10:54:09 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03449C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 07:54:09 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id 64so9404294wra.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 07:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=i7hD3zJ1K3PBBJFnz1T2WxFa77hgAItBpjslem4fkk8=;
        b=vbh27YuT9OoI623hjwYYHrJplHAelGAu9sW/+87Kru0YRIfnd7PwllrOiw+DOJnTxL
         wPRlvwZs8eEkXGDGCfN0QWKObgCb78FvVt12/Y4LjkdBHq016nl6iG/9fOP4XDXi8rUh
         pfAWt2FYQEcWvq039qRJ96EACBGVXHmVV8krQPUQkAsuAzZkih9jOwXjqPngkzi9Z4wZ
         fw7Y+KcGCnpGWBGySLXQMveWTuGoesajBWINccTkF0UlAO5+wekAxReJeYaftUj55szH
         aREsN1lTn8sjWLD4GVbPUgmzGnU++cw5/QtzgwZzSaC2+RhdsGVFFTa9Wk5UGDtnqMBC
         iGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=i7hD3zJ1K3PBBJFnz1T2WxFa77hgAItBpjslem4fkk8=;
        b=RsJTfZOSbc+wV4GIlioff+lFs3aVLOaJ16adfqb2nnS3EAR780SH6DomWX90iWm4e0
         Y0X+yBo5BxgEcm438giRO/3t1V4rR+nBiZdZHFF3aW3cDluTRvHdX6MV74sjx1r3+89W
         YgRmNfc317uIp+yPqgX3K1rMrj0/vwnih8mE0j3Lp8EdvC9bkyGd1q4/ML9TjlYCbjQ+
         P/10I8ucf68s4lovJ9xHw5p6txBlTesLR+7mvn0UZI3MtQ+ArZ96LiuA0xQ1Vwq30QMz
         y5qXJgci/WE/wd1hH9zScUKT1Xqny7RK/K1V5zVH/VeYs4cnZuXHjZRsH1mFg8XAEdxW
         Q8Yg==
X-Gm-Message-State: AOAM530R4ncH4bpCwjcBaouRnRM/9uOp9DivLDBYtBLyP0kB9z25xp1p
        2yuFxKyi4Y12BwLXhmIeV/nGQ7KaM7s9Q9kFnm0=
X-Google-Smtp-Source: ABdhPJz2ezvid7RSMPd0rUl8+DovXOBC8RTujdJD2aZY/MUsapVxd2mIPeuDI+WsaaWT3QiiZE9XUbB5RuuJGucr8GE=
X-Received: by 2002:a5d:400a:: with SMTP id n10mr5958542wrp.362.1606233247733;
 Tue, 24 Nov 2020 07:54:07 -0800 (PST)
MIME-Version: 1.0
References: <20201123111919.233376-1-lee.jones@linaro.org> <20201123111919.233376-5-lee.jones@linaro.org>
In-Reply-To: <20201123111919.233376-5-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 24 Nov 2020 10:53:56 -0500
Message-ID: <CADnq5_Ou6R08rcLy_KEZmR3y52yXjtvtzmi8W-BdM3matwOr3w@mail.gmail.com>
Subject: Re: [PATCH 04/40] drm/amd/amdgpu/amdgpu_virt: Correct possible
 copy/paste or doc-rot misnaming issue
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

On Mon, Nov 23, 2020 at 6:20 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:115: warning: Function paramete=
r or member 'adev' not described in 'amdgpu_virt_request_full_gpu'
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:115: warning: Excess function p=
arameter 'amdgpu' description in 'amdgpu_virt_request_full_gpu'
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:138: warning: Function paramete=
r or member 'adev' not described in 'amdgpu_virt_release_full_gpu'
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:138: warning: Excess function p=
arameter 'amdgpu' description in 'amdgpu_virt_release_full_gpu'
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:159: warning: Function paramete=
r or member 'adev' not described in 'amdgpu_virt_reset_gpu'
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:159: warning: Excess function p=
arameter 'amdgpu' description in 'amdgpu_virt_reset_gpu'
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:194: warning: Function paramete=
r or member 'adev' not described in 'amdgpu_virt_wait_reset'
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:194: warning: Excess function p=
arameter 'amdgpu' description in 'amdgpu_virt_wait_reset'
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:210: warning: Function paramete=
r or member 'adev' not described in 'amdgpu_virt_alloc_mm_table'
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:210: warning: Excess function p=
arameter 'amdgpu' description in 'amdgpu_virt_alloc_mm_table'
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:239: warning: Function paramete=
r or member 'adev' not described in 'amdgpu_virt_free_mm_table'
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:239: warning: Excess function p=
arameter 'amdgpu' description in 'amdgpu_virt_free_mm_table'
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
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_virt.c
> index 905b85391e64a..462c5dd8ca72c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -106,7 +106,7 @@ void amdgpu_virt_kiq_reg_write_reg_wait(struct amdgpu=
_device *adev,
>
>  /**
>   * amdgpu_virt_request_full_gpu() - request full gpu access
> - * @amdgpu:    amdgpu device.
> + * @adev:      amdgpu device.
>   * @init:      is driver init time.
>   * When start to init/fini driver, first need to request full gpu access=
.
>   * Return: Zero if request success, otherwise will return error.
> @@ -129,7 +129,7 @@ int amdgpu_virt_request_full_gpu(struct amdgpu_device=
 *adev, bool init)
>
>  /**
>   * amdgpu_virt_release_full_gpu() - release full gpu access
> - * @amdgpu:    amdgpu device.
> + * @adev:      amdgpu device.
>   * @init:      is driver init time.
>   * When finishing driver init/fini, need to release full gpu access.
>   * Return: Zero if release success, otherwise will returen error.
> @@ -151,7 +151,7 @@ int amdgpu_virt_release_full_gpu(struct amdgpu_device=
 *adev, bool init)
>
>  /**
>   * amdgpu_virt_reset_gpu() - reset gpu
> - * @amdgpu:    amdgpu device.
> + * @adev:      amdgpu device.
>   * Send reset command to GPU hypervisor to reset GPU that VM is using
>   * Return: Zero if reset success, otherwise will return error.
>   */
> @@ -186,7 +186,7 @@ void amdgpu_virt_request_init_data(struct amdgpu_devi=
ce *adev)
>
>  /**
>   * amdgpu_virt_wait_reset() - wait for reset gpu completed
> - * @amdgpu:    amdgpu device.
> + * @adev:      amdgpu device.
>   * Wait for GPU reset completed.
>   * Return: Zero if reset success, otherwise will return error.
>   */
> @@ -202,7 +202,7 @@ int amdgpu_virt_wait_reset(struct amdgpu_device *adev=
)
>
>  /**
>   * amdgpu_virt_alloc_mm_table() - alloc memory for mm table
> - * @amdgpu:    amdgpu device.
> + * @adev:      amdgpu device.
>   * MM table is used by UVD and VCE for its initialization
>   * Return: Zero if allocate success.
>   */
> @@ -232,7 +232,7 @@ int amdgpu_virt_alloc_mm_table(struct amdgpu_device *=
adev)
>
>  /**
>   * amdgpu_virt_free_mm_table() - free mm table memory
> - * @amdgpu:    amdgpu device.
> + * @adev:      amdgpu device.
>   * Free MM table memory
>   */
>  void amdgpu_virt_free_mm_table(struct amdgpu_device *adev)
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
