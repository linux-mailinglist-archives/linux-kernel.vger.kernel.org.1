Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6FB12EFA3E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 22:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbhAHVTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 16:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbhAHVTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 16:19:47 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97978C061757
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 13:19:07 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id a109so11082539otc.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 13:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+BVMFNqO9VtQw50JkrleUaGJ0i7fU8M+bV3fNxrSKxc=;
        b=pLgTcndfV6cW6spCSGmjB9Fb3TfBg6Tmw3S+ubIj/B1HgTeqyjz5qA9/Z7BpIp2tVT
         AIAdfrenkZLlqi0vENVzKN5z6sRCG/HRIxDlE7rXaBHDMJ36kgnddELtWGMAWeX+vZVE
         hG47TowHgJIpYX6BIS+tu8ABMiCtX3NfE+4x2yCa2ADEX5cIBZN4BPcu+oLBeXmVBk2I
         O4EZVDZdWPKEtDWDquMvP9o7hq9V4ooPyqjY+vttyNwgIS2+V3ZqjNC4mqBtuDuyhFW+
         xK7g9eBKmIbWjVWdezeRFWB73Rm+B3xjuqs97WTfGUFhIdphaq81fYQ+YLGkggsDVhJq
         JEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+BVMFNqO9VtQw50JkrleUaGJ0i7fU8M+bV3fNxrSKxc=;
        b=JRfzeEHmcK5yolaZt8vTfoYgLUMk0bJ+1CA/5SCqv67UNOzzElfMtRUgkhzrG7ADZt
         miOQQmR1vjpqmxuXFJtEAjMncd9N10LRBrxSRb4IDobD8S/I1cTAATCD3RW9Gbaq14Sg
         pA6gwLD8kqG6yh1x9t9OoZuWzH8IrUEqzc4fkeqPZQMdUgYu3IC6yGAEJb1AamBlEGdm
         t4BigbWeXM12/m5g7rRuyQ82WT+tUYnhOUMRz+DTTwxm9JTkJY/QlLfkSeZvuYNKTPEo
         Dnjc27t8M37dJn5oD9TjovJdcUx+cGphN6Sn/iu+2NSaNk0k+KonKPoHQT2DxLl/VfNg
         ckhw==
X-Gm-Message-State: AOAM533jRKJr8IIETInUicXaPOyS3yYuMpCxOjddsQiUz9Xq5hz/Nw2H
        PY0Us18GBzRyqXBruch3Ktw+WS1jAXOqeMpZfbRB2fUw
X-Google-Smtp-Source: ABdhPJxeFs1iL9KeAXeDXqdeEvesZuOa6FUbcR/HvCtgBKTdtd+5IUJYYuhMsC+0OFyPkE66/LzhP1w3wx3BwPOu6CU=
X-Received: by 2002:a9d:75d4:: with SMTP id c20mr3901460otl.311.1610140747098;
 Fri, 08 Jan 2021 13:19:07 -0800 (PST)
MIME-Version: 1.0
References: <20210108201457.3078600-1-lee.jones@linaro.org> <20210108201457.3078600-31-lee.jones@linaro.org>
In-Reply-To: <20210108201457.3078600-31-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 8 Jan 2021 16:18:56 -0500
Message-ID: <CADnq5_PcfiXEc=dpOVM+xttj91tnPsw0UT4T-arzxZhvdusiqw@mail.gmail.com>
Subject: Re: [PATCH 30/40] drm/amd/display/dc/dce/dce_dmcu: Move
 'abm_gain_stepsize' to only source file it's used in
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Leo Li <sunpeng.li@amd.com>, Mauro Rossi <issor.oruam@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 8, 2021 at 3:15 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> And only declare it if it's to be used.
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_dmcu.h:320:23: warning:=
 =E2=80=98abm_gain_stepsize=E2=80=99 defined but not used [-Wunused-const-v=
ariable=3D]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_dmcu.h:320:23: warning:=
 =E2=80=98abm_gain_stepsize=E2=80=99 defined but not used [-Wunused-const-v=
ariable=3D]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_dmcu.h:320:23: warning:=
 =E2=80=98abm_gain_stepsize=E2=80=99 defined but not used [-Wunused-const-v=
ariable=3D]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_dmcu.h:320:23: warning:=
 =E2=80=98abm_gain_stepsize=E2=80=99 defined but not used [-Wunused-const-v=
ariable=3D]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_dmcu.h:320:23: warning:=
 =E2=80=98abm_gain_stepsize=E2=80=99 defined but not used [-Wunused-const-v=
ariable=3D]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_dmcu.h:320:23: warning:=
 =E2=80=98abm_gain_stepsize=E2=80=99 defined but not used [-Wunused-const-v=
ariable=3D]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_dmcu.h:320:23: warning:=
 =E2=80=98abm_gain_stepsize=E2=80=99 defined but not used [-Wunused-const-v=
ariable=3D]
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Mauro Rossi <issor.oruam@gmail.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c | 4 ++++
>  drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.h | 2 --
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c b/drivers/gpu/=
drm/amd/display/dc/dce/dce_dmcu.c
> index fa2b47d41ee2f..30264fc151a2b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
> @@ -65,6 +65,10 @@
>  //Register access policy version
>  #define mmMP0_SMN_C2PMSG_91                            0x1609B
>
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
> +static const uint32_t abm_gain_stepsize =3D 0x0060;
> +#endif
> +
>  static bool dce_dmcu_init(struct dmcu *dmcu)
>  {
>         // Do nothing
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.h b/drivers/gpu/=
drm/amd/display/dc/dce/dce_dmcu.h
> index 93e7f34d4775e..cefb7f5bf42cc 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.h
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.h
> @@ -317,6 +317,4 @@ struct dmcu *dcn21_dmcu_create(
>
>  void dce_dmcu_destroy(struct dmcu **dmcu);
>
> -static const uint32_t abm_gain_stepsize =3D 0x0060;
> -
>  #endif /* _DCE_ABM_H_ */
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
