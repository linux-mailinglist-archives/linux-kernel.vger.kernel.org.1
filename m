Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5772C2C86
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 17:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390255AbgKXQOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 11:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390230AbgKXQOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 11:14:46 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D0AC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 08:14:46 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id w24so3462488wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 08:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fnQXOuxdd9Ha+ttePt7McKRgCzdvenHzP3lYYv4e9C8=;
        b=iQr9hZJarUKN47tSlegz3dfYvVmhXO+wLaLi8i++bYjU3m8ghrvN2H2P5R88XLR5tb
         xXpvtaMnhOTf1ZnfkoXkK5YW3jJsNNYsAFcc8YobH57HGhbiB14Vven5VWkhDDBWDHk9
         y+UzYmbx3P9fUyyt4JWCxm5LZGMqHWEM1DmymOb1di3iEtkxnG4AdRzmhOjSWm9UjHhr
         g+1+8Kqzy1vE4EQDx48Bf1VmH3AGK4+sCbiQe2waRgnLwjk3VMCQwABcgLANjm1xNLl+
         K3NC2grE4LykHLwpyEBfQfJhYypnPFN6jtnn5cMtkOvy82kUYtqMV/tIjOJ2hbggp9zW
         i1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fnQXOuxdd9Ha+ttePt7McKRgCzdvenHzP3lYYv4e9C8=;
        b=ucL/TPFp2k3LbVBqzIokQ4iN3b3lmhnrnt01n77/rmkMnYormK93qBdxdzSpvtoX7H
         xI4bagusBYJEGfg2pQ9xbLvaLiyQqI7I8JBGiO8ecH8KBti0Gb1Yl8Tt/JEA7mTWFGpi
         s8OehtI1qlKIKB8VI+PgGXwmZsQiLRtlgVGPTUNzNVlryZR6q7KtiwcLjbg07lZadfZy
         qdD3vATqOFYHY4i0xoNuje7solTTCC0U0b5lTPCYCrsR3Po1JLPV4GuNDWhuesRs5qjk
         fmSjL3zx3+jM2xKW/cXnLZykk2rFMB1mFui1RFnbkz+K/KW8vyNwMTwBTaAPtlnr9dus
         Ck7w==
X-Gm-Message-State: AOAM530uvo9fJJ+zMYlBMW5oQtDPGblp1sg08U9Lo/Nll4X6wngFKf8g
        jmwj48bJkJ7+Rw0wTuooN3bYNsO1spxkv8JZwD4=
X-Google-Smtp-Source: ABdhPJyoL9NCFb0YR56K9kBdE5/l0ByJYqt0ZdToAT+wNNkUCvRJIp2gQxTEuQOFC63surxTV5bT/wYkRBY2Jj/1F5M=
X-Received: by 2002:a1c:2dc8:: with SMTP id t191mr5215330wmt.73.1606234485281;
 Tue, 24 Nov 2020 08:14:45 -0800 (PST)
MIME-Version: 1.0
References: <20201123111919.233376-1-lee.jones@linaro.org> <20201123111919.233376-28-lee.jones@linaro.org>
In-Reply-To: <20201123111919.233376-28-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 24 Nov 2020 11:14:34 -0500
Message-ID: <CADnq5_M7n2PqQq8XUEEHwMbc8H30aYz-sbyhTDiiRDXC_4sFmw@mail.gmail.com>
Subject: Re: [PATCH 27/40] drm/amd/include/navi12_ip_offset: Mark top-level
 IP_BASE as __maybe_unused
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
>  In file included from drivers/gpu/drm/amd/amdgpu/navi12_reg_init.c:27:
>  drivers/gpu/drm/amd/amdgpu/../include/navi12_ip_offset.h:179:29: warning=
: =E2=80=98USB0_BASE=E2=80=99 defined but not used [-Wunused-const-variable=
=3D]
>  179 | static const struct IP_BASE USB0_BASE =3D{ { { { 0x0242A800, 0x05B=
00000, 0, 0, 0 } },
>  | ^~~~~~~~~
>  drivers/gpu/drm/amd/amdgpu/../include/navi12_ip_offset.h:172:29: warning=
: =E2=80=98UMC_BASE=E2=80=99 defined but not used [-Wunused-const-variable=
=3D]
>  172 | static const struct IP_BASE UMC_BASE =3D{ { { { 0x00014000, 0x0242=
5800, 0, 0, 0 } },
>  | ^~~~~~~~
>  drivers/gpu/drm/amd/amdgpu/../include/navi12_ip_offset.h:151:29: warning=
: =E2=80=98SDMA_BASE=E2=80=99 defined but not used [-Wunused-const-variable=
=3D]
>  151 | static const struct IP_BASE SDMA_BASE =3D{ { { { 0x00001260, 0x000=
0A000, 0x02402C00, 0, 0 } },
>  | ^~~~~~~~~
>
> NB: Snipped a few of these
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
>  drivers/gpu/drm/amd/include/navi12_ip_offset.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/include/navi12_ip_offset.h b/drivers/gpu=
/drm/amd/include/navi12_ip_offset.h
> index 6c2cc6296c061..d8fc00478b6a0 100644
> --- a/drivers/gpu/drm/amd/include/navi12_ip_offset.h
> +++ b/drivers/gpu/drm/amd/include/navi12_ip_offset.h
> @@ -33,7 +33,7 @@ struct IP_BASE_INSTANCE
>  struct IP_BASE
>  {
>      struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
> -};
> +} __maybe_unused;
>
>
>  static const struct IP_BASE ATHUB_BASE =3D{ { { { 0x00000C00, 0x02408C00=
, 0, 0, 0 } },
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
