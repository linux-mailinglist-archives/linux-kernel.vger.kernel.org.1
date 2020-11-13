Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADFC92B225A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 18:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgKMR2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 12:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgKMR2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 12:28:54 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A792CC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:28:53 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id c17so10732892wrc.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=C+0w2nBltIcPLOhtMLZ4S0PvakYggYrXZkCbBUTmbq0=;
        b=GrHaeW1ppx0bLiAObJsVnHiwxGBLMJkGdYRyPjzHR3pdOm7zuDvCsQJsahDDewdjr+
         iIQsy4tiGdL2sWEGJQdzgG002YgyWqyzpIdIxRwgNzz6y47GJVlsawkrckGP+I+qXOiF
         2f1y+AdYnM9scoXNsdfACnAW48roo5y4YgXQ9Oadcip29U1tcCwdfGBVqjN/YeXPWP0O
         ewwir+MKbyc1JHzUnbYoVyPjiZDY1TP3sYtSYgImzQCfm6HnDv+dy1HpthyRyBOJ43ZU
         CCFk0qeFT1hSUW2R1NhwzwwOUrg4QiV2t47PPDjMamatmBF12DxC4/YRhbMCIYv58W/0
         n4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=C+0w2nBltIcPLOhtMLZ4S0PvakYggYrXZkCbBUTmbq0=;
        b=RqEjm1rZDiCYJLlKfPnjCwp1P1s5GJB3jPdrgrB6Cwoh0OyUnlIxFp8j6lbnOBLF7C
         b/Q8VdeB9xX7Nn/QgiUu5P1e+qxpEfzqJZWSEBpEZSbLsodKGyCTGMLAY0D8LD0OVAUQ
         a79xi/wGr1tgEXRzcaGI6/ymEQXolkqyGMsYgivt+aj5sbIw0CSB4tzB5c/8bpf0+yqh
         mb9/4DfyMOFhdnjVh6obo48Wh3VO4NQw8/yEylvuV9d4IDDrt/Cqxa7zjp6gxfzr3qyy
         uJ1i1WS935i8VsPTZXbz9Tmf7Qab2pm8aHQH2EUayi2/Wg/R27IceTldnEsE/vD2+AKA
         MWTg==
X-Gm-Message-State: AOAM532W1BU4Qotuqb1JshluPe9e6ld0PzfFc/83EffLK9cincVj5ffn
        d6dtNvlZd8KovPqcbBRsWobtJv52I/jchpDh/jY=
X-Google-Smtp-Source: ABdhPJxuaa3hBBRuLvzp1t3KaqcAtdvwchrwB6YlbtVUL8bP+9zl0m9O5cz+ROgmeD2LRgIHwlg4TZND6aDOvazNpQw=
X-Received: by 2002:adf:e9c9:: with SMTP id l9mr5064718wrn.124.1605288527583;
 Fri, 13 Nov 2020 09:28:47 -0800 (PST)
MIME-Version: 1.0
References: <20201113134938.4004947-1-lee.jones@linaro.org> <20201113134938.4004947-27-lee.jones@linaro.org>
In-Reply-To: <20201113134938.4004947-27-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 13 Nov 2020 12:28:36 -0500
Message-ID: <CADnq5_PzV8ZRCRCS4EP-e=wbEtEbwsTT6MKH=YHDpGJoAA7nLQ@mail.gmail.com>
Subject: Re: [PATCH 26/40] drm/amd/amdgpu/amdgpu_gmc: Demote one and fix
 another function header
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

On Fri, Nov 13, 2020 at 8:50 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c:69: warning: Function parameter =
or member 'bo' not described in 'amdgpu_gmc_pd_addr'
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c:121: warning: Function parameter=
 or member 'bo' not described in 'amdgpu_gmc_agp_addr'
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c:121: warning: Excess function pa=
rameter 'tbo' description in 'amdgpu_gmc_agp_addr'
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
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gmc.c
> index 056cb87d09ea3..fede84509dbca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -61,9 +61,8 @@ void amdgpu_gmc_get_pde_for_bo(struct amdgpu_bo *bo, in=
t level,
>         amdgpu_gmc_get_vm_pde(adev, level, addr, flags);
>  }
>
> -/**
> +/*
>   * amdgpu_gmc_pd_addr - return the address of the root directory
> - *
>   */
>  uint64_t amdgpu_gmc_pd_addr(struct amdgpu_bo *bo)
>  {
> @@ -112,7 +111,7 @@ int amdgpu_gmc_set_pte_pde(struct amdgpu_device *adev=
, void *cpu_pt_addr,
>  /**
>   * amdgpu_gmc_agp_addr - return the address in the AGP address space
>   *
> - * @tbo: TTM BO which needs the address, must be in GTT domain
> + * @bo: TTM BO which needs the address, must be in GTT domain
>   *
>   * Tries to figure out how to access the BO through the AGP aperture. Re=
turns
>   * AMDGPU_BO_INVALID_OFFSET if that is not possible.
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
