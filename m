Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30C8B2B221B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 18:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgKMRXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 12:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgKMRXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 12:23:35 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430E0C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:23:49 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id d142so8860311wmd.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6X451lbJ+PYGuYOFu2kTr7WQuY5qufumT5+PoxOj2as=;
        b=rfmqUL1Mj+MTQESwoTeNlE8a9U02FNNrnhR6p/9o8szpLCQr5UtovIZGxox1TZC8PD
         T1eWcfbe4ww413scpizx8sz/rrykh/1Cpp+uIOCBLOSJCOgzCUMgamLVFcD+wAt8+vU1
         7YLp7nwkwS2qneXG8fy8bkaaPyiYMPF9+TfQuwuyjaiUzqTGfzRhi84nUj/2kUA1TGCh
         ol51ugwOrkmLtK+S1TDr9fkz8b3slwGsW/pDPz2mFqFs6Sdxe3v7ZdeS8UHjQ1bx3dGK
         Kj1HWmY3yt8kZ0EcGXIjhGCtoAnDvzSr2XAa8o8XI49vkhMldyqgR/2KGqJY4IK8LjwO
         acKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6X451lbJ+PYGuYOFu2kTr7WQuY5qufumT5+PoxOj2as=;
        b=CCW8eX7EUp/IYQLxSSdmBDPbZr4guFA8VOsNmH+z84QW1uAj/p3/ZmTMGnkW4sFNcy
         dbVqPFP7OvhseGJfA9th65LMUq8rp6v3PbpCeopYArayzUKKD0mowf4cQ5MOI+89iVI8
         a4il2RSxsir+WD5QOnA4sFkxBD+SyJ0z+gSogaweUh0O7+NavxAjTXDYwN6GJrZnP42P
         pOGWeURYgIljX8puv33qTBOekSz4OhtqBdVDhjMChDxRtzDU0N+eSINRuBQlhpfEdrBl
         qgl+5ji20U0Z7WNyDZ1L1TQST1ifnyw71hOyqwTNXmZQU6MNqu8dEScdbW+N9U7qqpRo
         Go9Q==
X-Gm-Message-State: AOAM530ddiMYZWDHJGYV0d/LmTlUpthxRgRVnIV+Uzy4R37uFTTOuQUb
        TCklKZGJBA09/3VUcQXx6OVagqPku/VmDSO0nxo=
X-Google-Smtp-Source: ABdhPJy7Tz+IImQHryl81psj+Jw5opNp5XA26S6NA1Hc9BmKdvtxN3XW1uZJ7Aa2HnLDiF/E578RNi9d9xgYPp1oe9A=
X-Received: by 2002:a1c:80cb:: with SMTP id b194mr3550572wmd.73.1605288223150;
 Fri, 13 Nov 2020 09:23:43 -0800 (PST)
MIME-Version: 1.0
References: <20201113134938.4004947-1-lee.jones@linaro.org> <20201113134938.4004947-30-lee.jones@linaro.org>
In-Reply-To: <20201113134938.4004947-30-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 13 Nov 2020 12:23:31 -0500
Message-ID: <CADnq5_M9POgJS2Oo0icBmsug+NDLz+n_Ree-As8GyM847b4hYA@mail.gmail.com>
Subject: Re: [PATCH 29/40] drm/amd/amdgpu/amdgpu_csa: Remove set but unused
 variable 'r'
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "monk.liu" <Monk.liu@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 8:50 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c: In function =E2=80=98amdgpu_all=
ocate_static_csa=E2=80=99:
>  drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c:40:6: warning: variable =E2=80=
=98r=E2=80=99 set but not used [-Wunused-but-set-variable]
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Monk.liu@amd.com
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_csa.c
> index 08047bc4d5886..da21e60bb8272 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
> @@ -37,10 +37,9 @@ uint64_t amdgpu_csa_vaddr(struct amdgpu_device *adev)
>  int amdgpu_allocate_static_csa(struct amdgpu_device *adev, struct amdgpu=
_bo **bo,
>                                 u32 domain, uint32_t size)
>  {
> -       int r;
>         void *ptr;
>
> -       r =3D amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
> +       amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
>                                 domain, bo,
>                                 NULL, &ptr);
>         if (!*bo)
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
