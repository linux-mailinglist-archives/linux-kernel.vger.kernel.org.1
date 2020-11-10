Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB252AE22C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 22:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731876AbgKJVuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 16:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731759AbgKJVus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 16:50:48 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E236DC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 13:50:47 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id c9so4680991wml.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 13:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zZU08qgOL1Jv0e0rNmAIA+4D26t5Wpp7BgkZFZSTv+o=;
        b=rTTA8UcuhsGzABUfJ+5KeTDlcwI9PrJoUqF1L/ikYKQUagTZolWXE8ARefdSSXvvZV
         n1LLIBHqEBKU7KDDMyPqtrpOHUQWXfVLbeXbEv8BXRcxjusljtAEbv0z3sUkb9UIyKVE
         UgPJgLLGNeIOUA3T7CXrr1zcDS5HkNiizclvp/n2XFU/1gp0GgbJjDnwfObamVBBawuS
         QeUdp5Ef6XDhdpAyC2W+lQMyEcQm+hDREJvoJWQPVR/Ongy5E32DjAqU+jFJ9/dV0Si2
         CBqRZbWuW4Kes7lHDzyTcJrbuYcma1ox4VRX7nSiHL/bWcELXcMJ+i2VpHnbeH6ZMCHd
         EISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zZU08qgOL1Jv0e0rNmAIA+4D26t5Wpp7BgkZFZSTv+o=;
        b=VRmCSpuduImwdmy71XoA1FtWh0CPcWArEnEsa7pNoODyleBcExp/649Tp7qsc/YVFz
         6W+Pd6NKCTdhiQTHA53D3tP7FaDtmYUrV8KOvIdfKMoNJ6yrwhzOIVHyJwdbzNuqc4uS
         YSs/7qKvGDaddwTcfYauyobxUflNfP29TzG9eNx9qQf346Eo2rO8269aBqBGc2Yq5JTW
         jM8s0OVgM238iFGTxcjJfFzWJkUoYaNHy5iCITT9n/xr2yUMrIRJAVX7+yqPbGj9rFHi
         vcvIiucKM9p/EajObcGX++GffnBTMD8uxl6ygSnrmg3caWab3X6HFxxP5/pTjz8aMxvj
         0mxA==
X-Gm-Message-State: AOAM5327yTIB9sj/yPEaRXHjZ8PSusSl//fWSNcpNpAgXh298ugIpGJy
        3hb0LlTvdtc17po5yJuCIi9jmAApWI7oJdhHajo=
X-Google-Smtp-Source: ABdhPJxzcSdqlId6DO2qFpL4VykR2hz9szQYXzXAs8eNTMiWvY1DMniO8LzZh66YRTeOK6bo5V9+SQPb4s+OugNvvT8=
X-Received: by 2002:a1c:46c6:: with SMTP id t189mr159786wma.79.1605045046623;
 Tue, 10 Nov 2020 13:50:46 -0800 (PST)
MIME-Version: 1.0
References: <20201105144517.1826692-1-lee.jones@linaro.org> <20201105144517.1826692-18-lee.jones@linaro.org>
In-Reply-To: <20201105144517.1826692-18-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 10 Nov 2020 16:50:34 -0500
Message-ID: <CADnq5_PEgvOgj_2ttKrhDX9e3Yv_B9zz-A3Be3R-1Z1PG7Hj-g@mail.gmail.com>
Subject: Re: [PATCH 17/19] gpu: drm: radeon: radeon_device: Fix a bunch of
 kernel-doc misdemeanours
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

On Thu, Nov 5, 2020 at 9:52 AM Lee Jones <lee.jones@linaro.org> wrote:
>
>  - Demote non-conformant headers
>  - Fix misnaming issues
>  - Rename labels with identical names
>  - Remove incorrect descriptions
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/radeon/radeon_device.c:637:6: warning: no previous proto=
type for =E2=80=98radeon_device_is_virtual=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/radeon/radeon_device.c:552: warning: duplicate section n=
ame 'Note'
>  drivers/gpu/drm/radeon/radeon_device.c:556: warning: duplicate section n=
ame 'Note'
>  drivers/gpu/drm/radeon/radeon_device.c:561: warning: duplicate section n=
ame 'Note'
>  drivers/gpu/drm/radeon/radeon_device.c:564: warning: duplicate section n=
ame 'Note'
>  drivers/gpu/drm/radeon/radeon_device.c:1106: warning: Function parameter=
 or member 'family' not described in 'radeon_gart_size_auto'
>  drivers/gpu/drm/radeon/radeon_device.c:1291: warning: Function parameter=
 or member 'ddev' not described in 'radeon_device_init'
>  drivers/gpu/drm/radeon/radeon_device.c:1565: warning: Function parameter=
 or member 'dev' not described in 'radeon_suspend_kms'
>  drivers/gpu/drm/radeon/radeon_device.c:1565: warning: Function parameter=
 or member 'suspend' not described in 'radeon_suspend_kms'
>  drivers/gpu/drm/radeon/radeon_device.c:1565: warning: Function parameter=
 or member 'fbcon' not described in 'radeon_suspend_kms'
>  drivers/gpu/drm/radeon/radeon_device.c:1565: warning: Function parameter=
 or member 'freeze' not described in 'radeon_suspend_kms'
>  drivers/gpu/drm/radeon/radeon_device.c:1565: warning: Excess function pa=
rameter 'pdev' description in 'radeon_suspend_kms'
>  drivers/gpu/drm/radeon/radeon_device.c:1565: warning: Excess function pa=
rameter 'state' description in 'radeon_suspend_kms'
>  drivers/gpu/drm/radeon/radeon_device.c:1669: warning: Function parameter=
 or member 'dev' not described in 'radeon_resume_kms'
>  drivers/gpu/drm/radeon/radeon_device.c:1669: warning: Function parameter=
 or member 'resume' not described in 'radeon_resume_kms'
>  drivers/gpu/drm/radeon/radeon_device.c:1669: warning: Function parameter=
 or member 'fbcon' not described in 'radeon_resume_kms'
>  drivers/gpu/drm/radeon/radeon_device.c:1669: warning: Excess function pa=
rameter 'pdev' description in 'radeon_resume_kms'
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
>  drivers/gpu/drm/radeon/radeon_device.c | 23 +++++++++--------------
>  1 file changed, 9 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/rad=
eon/radeon_device.c
> index 266e3cbbd09bd..7f384ffe848a7 100644
> --- a/drivers/gpu/drm/radeon/radeon_device.c
> +++ b/drivers/gpu/drm/radeon/radeon_device.c
> @@ -544,21 +544,21 @@ int radeon_wb_init(struct radeon_device *rdev)
>   * Note: GTT start, end, size should be initialized before calling this
>   * function on AGP platform.
>   *
> - * Note: We don't explicitly enforce VRAM start to be aligned on VRAM si=
ze,
> + * Note 1: We don't explicitly enforce VRAM start to be aligned on VRAM =
size,
>   * this shouldn't be a problem as we are using the PCI aperture as a ref=
erence.
>   * Otherwise this would be needed for rv280, all r3xx, and all r4xx, but
>   * not IGP.
>   *
> - * Note: we use mc_vram_size as on some board we need to program the mc =
to
> + * Note 2: we use mc_vram_size as on some board we need to program the m=
c to
>   * cover the whole aperture even if VRAM size is inferior to aperture si=
ze
>   * Novell bug 204882 + along with lots of ubuntu ones
>   *
> - * Note: when limiting vram it's safe to overwritte real_vram_size becau=
se
> + * Note 3: when limiting vram it's safe to overwritte real_vram_size bec=
ause
>   * we are not in case where real_vram_size is inferior to mc_vram_size (=
ie
>   * note afected by bogus hw of Novell bug 204882 + along with lots of ub=
untu
>   * ones)
>   *
> - * Note: IGP TOM addr should be the same as the aperture addr, we don't
> + * Note 4: IGP TOM addr should be the same as the aperture addr, we don'=
t
>   * explicitly check for that thought.
>   *
>   * FIXME: when reducing VRAM size align new size on power of 2.
> @@ -627,7 +627,7 @@ void radeon_gtt_location(struct radeon_device *rdev, =
struct radeon_mc *mc)
>   * GPU helpers function.
>   */
>
> -/**
> +/*
>   * radeon_device_is_virtual - check if we are running is a virtual envir=
onment
>   *
>   * Check if the asic has been passed through to a VM (all asics).
> @@ -1100,7 +1100,7 @@ static bool radeon_check_pot_argument(int arg)
>  /**
>   * Determine a sensible default GART size according to ASIC family.
>   *
> - * @family ASIC family name
> + * @family: ASIC family name
>   */
>  static int radeon_gart_size_auto(enum radeon_family family)
>  {
> @@ -1276,7 +1276,7 @@ static const struct vga_switcheroo_client_ops radeo=
n_switcheroo_ops =3D {
>   * radeon_device_init - initialize the driver
>   *
>   * @rdev: radeon_device pointer
> - * @pdev: drm dev pointer
> + * @ddev: drm dev pointer
>   * @pdev: pci dev pointer
>   * @flags: driver flags
>   *
> @@ -1550,12 +1550,9 @@ void radeon_device_fini(struct radeon_device *rdev=
)
>  /*
>   * Suspend & resume.
>   */
> -/**
> +/*
>   * radeon_suspend_kms - initiate device suspend
>   *
> - * @pdev: drm dev pointer
> - * @state: suspend state
> - *
>   * Puts the hw in the suspend state (all asics).
>   * Returns 0 for success or an error on failure.
>   * Called at driver suspend.
> @@ -1656,11 +1653,9 @@ int radeon_suspend_kms(struct drm_device *dev, boo=
l suspend,
>         return 0;
>  }
>
> -/**
> +/*
>   * radeon_resume_kms - initiate device resume
>   *
> - * @pdev: drm dev pointer
> - *
>   * Bring the hw back to operating state (all asics).
>   * Returns 0 for success or an error on failure.
>   * Called at driver resume.
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
