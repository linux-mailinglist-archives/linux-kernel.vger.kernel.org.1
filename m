Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A452F3F6F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404769AbhALWVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 17:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404681AbhALWVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:21:02 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196B2C061786
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:20:22 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id s2so29431oij.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AoUDA2QHniDR7mf7zEUOWTW+Wr2iXHVQBuhQ6j/vnxc=;
        b=JnPp+nXZRLtRwBPO4ZZNOXC4+E9XHHYEOKxyfA8NR2VPX7enweEQqBiTJEVwVa+CY6
         r8czRjtZQczsXac/S9UNwdmDb8QNrr6vDtcRLlC5e3AlLHvThDw/m0BgImcLVkfct8Y2
         aoDmquGKB/7MCKT3DzPwSH4iyQTz/AOKAVPEWWWXZ71gIRzQOvQVpunN0AzcqLfh1otp
         unpKIAnipJfwogG6lx+D8BwHI4G1cf6qqCqAsf9/mFK8AtCL2vqUGQnoQOuy/U2bPKSH
         uuJFMrGfyb/B15XLVawQRAMkH6Ptb5yomdsW6geYH1ikq2Ek4NgKdhgOjI8Q5iE4TUHt
         8fRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AoUDA2QHniDR7mf7zEUOWTW+Wr2iXHVQBuhQ6j/vnxc=;
        b=oNyQIgNgi2bsSKKmKVsyDdSjcl4WtxJIYy3mY+hMdGQN2CBL4Zl44h+j9DvKgvoUDW
         6wUhJMi/WQ2+OIAv6uQHpV0iNh5HnNCI/QD4I4hEXeyv5kdDZ6JHX29AHJNRA/SsdFBR
         UFpuhhKcAo8Ao78q92jcBMyI36yUVKcJI2JI96uJbdP0JcMazWhLoEiEt/gQ9grT6d7w
         XkdmpPhd6sLK9eY7NPYN2TcZaxDDG3q50L3x8/Y0ArcmLMGd1FJoPpCIAVPgFlM6qLsW
         B3H3xRffud+tgwDmuQKoA2hwR3L8Q0bhul904xWUbov3cfNJ2V2g4ZbBrtZwYF2TG1GA
         S6nA==
X-Gm-Message-State: AOAM5319W771z+uA68HgLKmGjjfc7uEE6rJw8ln5KP3fpkuhRSLsCqNf
        72hQQEy/RN7pYoIJg7eh7o/iFoTfXvHfr4AXd0Q=
X-Google-Smtp-Source: ABdhPJzw07+fNO+HAfmHstHOFCfLbKPANHdWUOpksi4akEuYxVxavydaxPc8XnhNSonBgK7UgCQFqxq4c6PsvjtR8HY=
X-Received: by 2002:aca:6202:: with SMTP id w2mr773214oib.5.1610490021530;
 Tue, 12 Jan 2021 14:20:21 -0800 (PST)
MIME-Version: 1.0
References: <20210111191926.3688443-1-lee.jones@linaro.org> <20210111191926.3688443-22-lee.jones@linaro.org>
In-Reply-To: <20210111191926.3688443-22-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 12 Jan 2021 17:20:02 -0500
Message-ID: <CADnq5_Oc0ftYKMCaWz5Sa8dAsJoGPWWAj-pBXxFqrBNZDNxLFQ@mail.gmail.com>
Subject: Re: [PATCH 21/40] drm/amd/display/dc/dce110/dce110_compressor: Remove
 unused function 'dce110_get_required_compressed_surfacesize
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Leo Li <sunpeng.li@amd.com>, LKML <linux-kernel@vger.kernel.org>,
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

On Mon, Jan 11, 2021 at 2:20 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_compressor.c:415:=
6: warning: no previous prototype for =E2=80=98dce110_get_required_compress=
ed_surfacesize=E2=80=99 [-Wmissing-prototypes]
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
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
>  .../amd/display/dc/dce110/dce110_compressor.c | 30 -------------------
>  1 file changed, 30 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c b/=
drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c
> index 72b580a4eb856..18b0a69b0b1e8 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c
> @@ -412,36 +412,6 @@ void dce110_compressor_destroy(struct compressor **c=
ompressor)
>         *compressor =3D NULL;
>  }
>
> -bool dce110_get_required_compressed_surfacesize(struct fbc_input_info fb=
c_input_info,
> -                                               struct fbc_requested_comp=
ressed_size size)
> -{
> -       bool result =3D false;
> -
> -       unsigned int max_x =3D FBC_MAX_X, max_y =3D FBC_MAX_Y;
> -
> -       get_max_support_fbc_buffersize(&max_x, &max_y);
> -
> -       if (fbc_input_info.dynamic_fbc_buffer_alloc =3D=3D 0) {
> -               /*
> -                * For DCE11 here use Max HW supported size:  HW Support =
up to 3840x2400 resolution
> -                * or 18000 chunks.
> -                */
> -               size.preferred_size =3D size.min_size =3D align_to_chunks=
_number_per_line(max_x) * max_y * 4;  /* (For FBC when LPT not supported). =
*/
> -               size.preferred_size_alignment =3D size.min_size_alignment=
 =3D 0x100;       /* For FBC when LPT not supported */
> -               size.bits.preferred_must_be_framebuffer_pool =3D 1;
> -               size.bits.min_must_be_framebuffer_pool =3D 1;
> -
> -               result =3D true;
> -       }
> -       /*
> -        * Maybe to add registry key support with optional size here to o=
verride above
> -        * for debugging purposes
> -        */
> -
> -       return result;
> -}
> -
> -
>  void get_max_support_fbc_buffersize(unsigned int *max_x, unsigned int *m=
ax_y)
>  {
>         *max_x =3D FBC_MAX_X;
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
