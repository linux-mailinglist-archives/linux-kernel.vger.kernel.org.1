Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 309EC2B2268
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 18:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgKMRaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 12:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgKMRaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 12:30:01 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287A7C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:30:01 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id l1so10758378wrb.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y5XLq8CASy6zy7N8oDE7rQcVOhoLkKsILxJE2K73xHE=;
        b=bAeFhepfBUbNFeZwG0IgNnzoRgTAR0H8PytEhCz6G00JYojWnocTe4WFCL37Gbv7Ne
         YiknUsYyV4DSBak+ucpmYZRa7qRPewOk/el126aeATJ2Hs0VLM2WImC34PvaO1YgYBO7
         s/5jFglrIIajRgEBP3qiJd97VsHz00drURd4GCRdV7u1WO7NSGhyXRahj4LgbmCOrTf9
         oSKqJcCggWFfQxuSP0DQ4ZJ3vt4+GT49VOSwEB6GGgezPWPW/Cp4DXZVo0d0UwSy8cjm
         oyl46q79YjGhYhnweeDLrmTQY+mGL9UzsnoQi7V17agunFgeGw0z9Wv1FPDFE3CVhTRm
         x36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y5XLq8CASy6zy7N8oDE7rQcVOhoLkKsILxJE2K73xHE=;
        b=Y1QzUAiED59w14cY36Zv4yABnUjJCKioJDxRlOOyoJfWewCVBqMwalctY/KydnkJlR
         odH+gqDJAFT50nH0fBL5FknA8uO4HIsSBdYHqRWl2ceilTZt5G1yne8xM3vlPW1rzEti
         5/kYuyAZqkzWy8QUK7pGFYfD+gbcXh2vkOQLvnM870+XJi+CTGSgpzEeBCf+2zGHF6RT
         JTTDii/XzVNL0IFFF3uZBDEsSljw4ILyZ1dxuIAnplQB8eSLQnFpufCo4plApASbyZQS
         634SMm6w+tam8C5ZQ5GI/bsXUyEIw6evKZYDEaewDL2Dpe6yESVQIT2+EMDiGvR4ognA
         t+ww==
X-Gm-Message-State: AOAM533A21KFvVFbSBTDN+GXc7mBu0vRDXdFRvYlBATbsD6+Ue9YEElS
        x9O7CREYKFngNmFvOK3ctFQ/tIVCvWtMCB5sURs=
X-Google-Smtp-Source: ABdhPJx2zNAq12dh1x7XfucHKP6PuR8scXjnDxKPL++TGsvkSUK4GgJN/HAUBWb12O7U0SBkdTqGCXOo+U2bqXboxSI=
X-Received: by 2002:adf:8028:: with SMTP id 37mr4695655wrk.111.1605288596860;
 Fri, 13 Nov 2020 09:29:56 -0800 (PST)
MIME-Version: 1.0
References: <20201113134938.4004947-1-lee.jones@linaro.org> <20201113134938.4004947-28-lee.jones@linaro.org>
In-Reply-To: <20201113134938.4004947-28-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 13 Nov 2020 12:29:45 -0500
Message-ID: <CADnq5_NAS5CCzHLPwL17-vy6tNLYw52+egThwid7Zdn2B=rMNQ@mail.gmail.com>
Subject: Re: [PATCH 27/40] drm/amd/amdgpu/amdgpu_ras: Remove unused function 'amdgpu_ras_error_cure'
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
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:908:5: warning: no previous prot=
otype for =E2=80=98amdgpu_ras_error_cure=E2=80=99 [-Wmissing-prototypes]
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
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ras.c
> index b96267068a72d..f89a991999428 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -905,13 +905,6 @@ int amdgpu_ras_error_inject(struct amdgpu_device *ad=
ev,
>         return ret;
>  }
>
> -int amdgpu_ras_error_cure(struct amdgpu_device *adev,
> -               struct ras_cure_if *info)
> -{
> -       /* psp fw has no cure interface for now. */
> -       return 0;
> -}
> -
>  /* get the total error counts on all IPs */
>  unsigned long amdgpu_ras_query_error_count(struct amdgpu_device *adev,
>                 bool is_ce)
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
