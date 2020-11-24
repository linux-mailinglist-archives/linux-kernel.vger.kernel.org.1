Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8292C2C72
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 17:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390245AbgKXQM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 11:12:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390144AbgKXQM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 11:12:27 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4FEC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 08:12:27 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id x13so2350249wmj.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 08:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cQHz4OVR739zwNES/8J50WC7NsAjzj5OIMmr/Jzv4QE=;
        b=ImbVpBGlG4hg9rU3HPv8rI53cXcpsM/EWXoa7Xooo6XIZXGhqkvuUSzbUGcG+erfPM
         ly4Mrszc/wKqjCk6Q2F7dog1bCuRtmci7uyWrPX+MqrJbIaguIzyBmp0HTRwArOyxa6q
         H9FzkoD89zxjwipG7cWymeQ8EejGXmHN+AOg1snNJ55YGAJkRtDnRrKw50KwtCPSsEXX
         06nYYVxfaIWPI53pR3wbcD0G1MFYUdHa/8LsJaYHpfszYMM1CUKVYbJDakoBcMnIEBxr
         trNbq0mgC0EKQ8H4XcYZrtUM1IRCWWZJhL9/3MnZJThpXR98JSz20HBMzs2NQtlkYZ1y
         aIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cQHz4OVR739zwNES/8J50WC7NsAjzj5OIMmr/Jzv4QE=;
        b=QGCMvWva+iPu5s8X+/IhOBpe9vLyDCBJvTOJu4RYjAZZl8UtWfvMYAJTrFNfnpJw93
         tyVoIR9f6Q8mTQ41MVqikzZMy6vT2HYAI4tiwTycLnU8ezgjUMJw+o6OZaiCgWXI5iiT
         t1JE5gxdDDd8rDNpWP9LBiBXk98rMPhgoOhnrqPrsHNQAafjulYYj22WXuBdaNNn9NEn
         efRt9DUXSSbFvgKGr1YQFcLieNTLWMEEg9CUWSmAfa0FqcDy39Ol8S+/TQYTXkJ+WnPi
         679E/MTyisvs5bi3AJnzLLwCKzZYEV5wA5NMIpNkxMjuCoTAWxGJUdF7p90FLYbhb/0l
         eZ4w==
X-Gm-Message-State: AOAM5330C5Ed0SlZr/SMdXsxp8/GjuzQIJkI37pCjOK6VcaYPuHnz0/Y
        4mWiKvfzCylh2DSUdjoVpAyvKrdRg8TemTsY4zA=
X-Google-Smtp-Source: ABdhPJwD8IyowhIYRqZII2g1HWePbg2xvy5Ec1D2IrSi0hVC9dUtfvGE9Njtgv6yU+WbjxItaoBGuwwDI9D6C4epdg4=
X-Received: by 2002:a1c:f017:: with SMTP id a23mr5235248wmb.56.1606234346379;
 Tue, 24 Nov 2020 08:12:26 -0800 (PST)
MIME-Version: 1.0
References: <20201123111919.233376-1-lee.jones@linaro.org> <20201123111919.233376-25-lee.jones@linaro.org>
In-Reply-To: <20201123111919.233376-25-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 24 Nov 2020 11:12:15 -0500
Message-ID: <CADnq5_MhNj7X3mOiBGX0AcDbmRALOafzfUCBGuLU6hW_WXOt6Q@mail.gmail.com>
Subject: Re: [PATCH 24/40] drm/amd/include/navi10_ip_offset: Mark top-level
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
>  In file included from drivers/gpu/drm/amd/amdgpu/navi10_reg_init.c:27:
>  drivers/gpu/drm/amd/amdgpu/../include/navi10_ip_offset.h:127:29: warning=
: =E2=80=98UMC_BASE=E2=80=99 defined but not used [-Wunused-const-variable=
=3D]
>  127 | static const struct IP_BASE UMC_BASE =3D{ { { { 0x00014000, 0, 0, =
0, 0, 0 } },
>  | ^~~~~~~~
>  drivers/gpu/drm/amd/amdgpu/../include/navi10_ip_offset.h:109:29: warning=
: =E2=80=98RSMU_BASE=E2=80=99 defined but not used [-Wunused-const-variable=
=3D]
>  109 | static const struct IP_BASE RSMU_BASE =3D { { { { 0x00012000, 0, 0=
, 0, 0, 0 } },
>  | ^~~~~~~~~
>  drivers/gpu/drm/amd/amdgpu/../include/navi10_ip_offset.h:61:29: warning:=
 =E2=80=98FUSE_BASE=E2=80=99 defined but not used [-Wunused-const-variable=
=3D]
>  61 | static const struct IP_BASE FUSE_BASE =3D{ { { { 0x00017400, 0, 0, =
0, 0, 0 } },
>  | ^~~~~~~~~
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
>  drivers/gpu/drm/amd/include/navi10_ip_offset.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/include/navi10_ip_offset.h b/drivers/gpu=
/drm/amd/include/navi10_ip_offset.h
> index d4a9ddc7782ff..d6824bb6139db 100644
> --- a/drivers/gpu/drm/amd/include/navi10_ip_offset.h
> +++ b/drivers/gpu/drm/amd/include/navi10_ip_offset.h
> @@ -31,7 +31,7 @@ struct IP_BASE_INSTANCE {
>
>  struct IP_BASE {
>         struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
> -};
> +} __maybe_unused;
>
>
>  static const struct IP_BASE ATHUB_BASE            =3D{ { { { 0x00000C00,=
 0, 0, 0, 0, 0 } },
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
