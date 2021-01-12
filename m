Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E002F3FD7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438294AbhALWir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 17:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbhALWiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:38:46 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBA3C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:38:06 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id b24so90749otj.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wxsYVjMKSLjVspkXPLIbzpTupJ3YZOSiw7PZpIiWQyM=;
        b=XLp8nCeLhFAtOZUatvwUYUb2gGmH6kNqezId++H9o7h9c5xR1L1kDzh00wyaV1jxo3
         k8HYjeEjs2yDERvrCnLt0ed6MzB/ex+h1pntaW8zhhZhZA1/QvhDCTjj6Xg1IKnYtelu
         hWLNYpUBdS1wGRc0tQ/hrDZ1hZzlTCvSVZY1yt3SZ0QWQMDvpALYuJBea+/D8NTWX9Qs
         9W/8QXIcBQ+Q2jk2XIwFZnV7gqegGaAWG91W2QUdlK/PUn+6ta7XAhq5QTE8Rzy92vkr
         QuqG+aKRmHN/Gc1zptJXy0pafxCLIOwp2sfHs1nIN85xsLfEXO5Mi6VGwmcHlxK1lXNY
         Ozjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wxsYVjMKSLjVspkXPLIbzpTupJ3YZOSiw7PZpIiWQyM=;
        b=Gy5MJfuAlazaIzrClJOJxDzVt4g2b3eidXU8l/HPA7RgWba4DejrENJApJwBI41ZM7
         D5mDicLQJiMeh18NsQnEqOQid3SGq6PhlJC2Frx7iqnCC7FQePryaYn1AIVfUgoH0iTy
         ZVdDZ3D5d0xmvPCMz6vtFa90c57+B3Rp2hBVOd089jRTq3i4YVVQEkmeSkeITt7ELH9f
         rUD+B4632tzJP5D8cPymgT0rJcwNZAeOIYYpxZoZX3TIgD6hzN6XJgAKXG3TUiF15jYa
         LP9k6LiCkDeYqOB6qZcL4AhKp98TaSeAFfLC5hPRDCfl+EZCo58Ai9bYamDIDSROeSOD
         t64Q==
X-Gm-Message-State: AOAM532qDaqY6EtuZXRINWuq4mlU9WHVOYt4y/WSDHQHKmgpcaGyQwnK
        pIi0cs872xcuCtFtCRZ9pbFFVz58oDdVVlGvP6o=
X-Google-Smtp-Source: ABdhPJywXV/9ak613noS3mM30Z7CXwul6zSJF1SGnNPGOBR+bqpNNou96ebtx8C72ZXa9t5wEsC2NrucI3llN93ClkQ=
X-Received: by 2002:a9d:75d4:: with SMTP id c20mr1058349otl.311.1610491085959;
 Tue, 12 Jan 2021 14:38:05 -0800 (PST)
MIME-Version: 1.0
References: <20210111191926.3688443-1-lee.jones@linaro.org> <20210111191926.3688443-36-lee.jones@linaro.org>
In-Reply-To: <20210111191926.3688443-36-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 12 Jan 2021 17:37:52 -0500
Message-ID: <CADnq5_NtBq+_g7pTxQ3GJHhjg5qKG147sPFKzwb_RhCuatO-hg@mail.gmail.com>
Subject: Re: [PATCH 35/40] drm/amd/display/dc/dce60/dce60_timing_generator:
 Make 'dce60_configure_crc' invoked by reference static
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

On Mon, Jan 11, 2021 at 2:20 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_timing_generator.c:=
192:6: warning: no previous prototype for =E2=80=98dce60_configure_crc=E2=
=80=99 [-Wmissing-prototypes]
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
>  drivers/gpu/drm/amd/display/dc/dce60/dce60_timing_generator.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_timing_generator.=
c b/drivers/gpu/drm/amd/display/dc/dce60/dce60_timing_generator.c
> index fc1af0ff0ca4c..c1a85ee374d9d 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_timing_generator.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce60/dce60_timing_generator.c
> @@ -189,8 +189,8 @@ static bool dce60_is_tg_enabled(struct timing_generat=
or *tg)
>         return field =3D=3D 1;
>  }
>
> -bool dce60_configure_crc(struct timing_generator *tg,
> -                         const struct crc_params *params)
> +static bool dce60_configure_crc(struct timing_generator *tg,
> +                               const struct crc_params *params)
>  {
>         /* Cannot configure crc on a CRTC that is disabled */
>         if (!dce60_is_tg_enabled(tg))
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
