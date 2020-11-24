Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC982C2CF6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 17:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390410AbgKXQaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 11:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389808AbgKXQaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 11:30:16 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7CAC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 08:30:16 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id p22so2931287wmg.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 08:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=G8IAtlr5m1gYnRAMobJiAIZSerjuCkgbFe4M5d9hPSg=;
        b=iOHS4wBfvNCggF1/tVIhDzsNrlETd0MbF+Jb7aCaUudrbcubXA/pNWjtFNvNYRqZ3r
         x8c4do+a7c2KzFNV/uELb3ag5z0UXboovCaP3iM9MK7FmyhQHcnhFiqQ+Pb6NLTaE1ay
         eHaIC6FOof1qwNxYouhJvJzjoPIviiCPKUQjY6f44VKJ1g3UA3p235BrAq7Z9cKompVZ
         vB8/y0IV++mlsADdnU9iQwGrwHIwtCTMx+Q65CZbJEp5oZIPJx6AM6cyj+V04IUSC7Rc
         6W48HQEb7kAcBQfmsfEy3669pUlL3MAzlaOCQk4lAtoey9uFLsi5n488mi+qJfWiXgS2
         N8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G8IAtlr5m1gYnRAMobJiAIZSerjuCkgbFe4M5d9hPSg=;
        b=QC58bpJ8MbcSYDiiNREZ0YGbqA8XrTLFHrs7wlsf6OF7WphdgIs8C/mFvENPHFP+hQ
         V6FFRZwH/UkD3yry17GOVeMh+TgA3kB0IkYlfp+tBfrO9pQIjl24LZtzTHx1oiY7JivB
         wl5G1QRrOuqqr45zkevAwz7LAnWneu6l4RRnk7eRZ6DBfumwKzzbsCu8zwzb0QR8Q5S1
         L4UGNyBg0rio8P1ld962O5DyfKaRx9c8fI2QtJGb1AWvn7BTqH6NDnQJmKdv076zSKw6
         vlCyBFwp0V1KNBr9M+oND7PLg2z30tyGpmvcwl4ig7mbvWwruclF1PpHpcSilB/fx2tX
         224Q==
X-Gm-Message-State: AOAM531w9fjxMKte5qVc4Qx3NPKITGoj023xBfCloeqdlPoVpFIyTHaH
        8s18OJysRDThklxHqP79VMuyDtMZ3DtO2JLmxnE=
X-Google-Smtp-Source: ABdhPJx8GcGOsSIBYK5cUimv6QWYaz7yYoCPmjQWAfTMLBeTCkWj3w0W1q3MnGgjxOgTL5xbim7VpqeTT61jbjsEX1U=
X-Received: by 2002:a7b:c157:: with SMTP id z23mr5340007wmi.70.1606235414853;
 Tue, 24 Nov 2020 08:30:14 -0800 (PST)
MIME-Version: 1.0
References: <20201123111919.233376-1-lee.jones@linaro.org> <20201123111919.233376-41-lee.jones@linaro.org>
In-Reply-To: <20201123111919.233376-41-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 24 Nov 2020 11:30:03 -0500
Message-ID: <CADnq5_OwhSqyfv-vybWM4R-NuNXdT=tF-Af75utcSDRmHBj9DQ@mail.gmail.com>
Subject: Re: [PATCH 40/40] drm/amd/amdgpu/gmc_v9_0: Suppy some missing
 function doc descriptions
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

On Mon, Nov 23, 2020 at 6:21 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c:382:23: warning: =E2=80=98ecc_umc_=
mcumc_status_addrs=E2=80=99 defined but not used [-Wunused-const-variable=
=3D]
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c:720: warning: Function parameter o=
r member 'vmhub' not described in 'gmc_v9_0_flush_gpu_tlb'
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c:836: warning: Function parameter o=
r member 'flush_type' not described in 'gmc_v9_0_flush_gpu_tlb_pasid'
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c:836: warning: Function parameter o=
r member 'all_hub' not described in 'gmc_v9_0_flush_gpu_tlb_pasid'
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied with minor changes.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v9_0.c
> index fbee43b4ba64d..a83743ab3e8bb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -675,6 +675,7 @@ static bool gmc_v9_0_get_atc_vmid_pasid_mapping_info(=
struct amdgpu_device *adev,
>   *
>   * @adev: amdgpu_device pointer
>   * @vmid: vm instance to flush
> + * @vmhub: vmhub type
>   * @flush_type: the flush type
>   *
>   * Flush the TLB for the requested page table using certain type.
> @@ -791,6 +792,8 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_devi=
ce *adev, uint32_t vmid,
>   *
>   * @adev: amdgpu_device pointer
>   * @pasid: pasid to be flush
> + * @flush_type: the flush type
> + * @all_hub: Used with PACKET3_INVALIDATE_TLBS_ALL_HUB()
>   *
>   * Flush the TLB for the requested pasid.
>   */
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
