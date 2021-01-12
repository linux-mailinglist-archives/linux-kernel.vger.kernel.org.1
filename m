Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17FA62F3E14
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393834AbhALWB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 17:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391180AbhALWBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:01:54 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27647C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:01:14 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id w3so3784902otp.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uDgXaAc7GjnI10LhfsoqNmXSnUmmiZemrpWcOnIj94I=;
        b=M3RVDzYrqIP3u6OHFrOxpLkodlzSq3MDQx6G7IroukGaiphYRgkCtzdK/8Nva5+wNd
         oKtJUrjMYopz1EY0gMjb93n2sKyRcWtFUoVAh+0LvfjlFPxyXuusuDV8/UqEj7/VYM0G
         1YiqDM7CkiZHOvD7u5nIL627APi57ywnlAkIGJIV0d7RVFZzpBnIgTH2SgFuax6yJOjm
         crjYamCIy7B8edeijbnzNnCSua5/9aEfF0FqdCI/v47z+xtugFO/rNwI/T9qI36kI+PF
         J5czcwkvuUdCW3g3E7vMYdgJhsh/xqx3PBfzqhOF3VRZz3MKAc9D/W+Z7JH/8mkZIsha
         K6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uDgXaAc7GjnI10LhfsoqNmXSnUmmiZemrpWcOnIj94I=;
        b=i8D8uqeXKwvviEBvQ1UBpK4tNYBNnnjPswb9Mpi0Yb70LSnQVZbPxDFFUegJqra1pe
         YsgRSUjxeIiDqHNzPyTF41pxtAQ8eqXnnfQscfrLs+5b0VkjBgLekdaQYvwtyP1fBxex
         huroWariNVmy8pznf5BgaZF1vdRWHPKXlYZwZADdIzhD1AIL/kKhYHdpHrqpG8BOBiT9
         mSY/z6/hL4ZTEYbLdeUhi2viA/gseeWUHnpoclPiahpfR2LVq6TFyDeqKZoHxW2UVvK+
         RWFzOhJUE0Rnjh9k5B6m9tG4g+VjBShfJsOoBpU1Bi72XyVhxDvWJDb8IR61DK6RQLjL
         Y0gA==
X-Gm-Message-State: AOAM532i/aJXY6laMrGwTxVyIBVL/DV6/Y3+IdV0V36i9ELjz9+iB0SW
        qKr1es2+kxoUFqDwAXr7NR3IW3ODcPV2LLzqAHk=
X-Google-Smtp-Source: ABdhPJyyLnlZ0c/XFzX5hhTiscgmlUWNQdxYsP5RXf3GqkaPaFyUpzym8bAFtc+UJlYAi8PpkiijKyvYHrZZ/hdhau4=
X-Received: by 2002:a9d:2ac2:: with SMTP id e60mr993699otb.23.1610488873181;
 Tue, 12 Jan 2021 14:01:13 -0800 (PST)
MIME-Version: 1.0
References: <20210111191926.3688443-1-lee.jones@linaro.org> <20210111191926.3688443-6-lee.jones@linaro.org>
In-Reply-To: <20210111191926.3688443-6-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 12 Jan 2021 17:01:02 -0500
Message-ID: <CADnq5_P16YPwTUOQMLSbRcM54Wy1yCjO=fiinOwOFmkkV_gd5w@mail.gmail.com>
Subject: Re: [PATCH 05/40] drm/amd/display/dc/dce/dce_transform: Demote
 kernel-doc abuse
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

On Mon, Jan 11, 2021 at 2:19 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> The header doesn't provide any additional parameter descriptions.
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_transform.c:1104: warni=
ng: Cannot understand  ****************************************************=
*************************
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
>  drivers/gpu/drm/amd/display/dc/dce/dce_transform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c b/drivers=
/gpu/drm/amd/display/dc/dce/dce_transform.c
> index 6121bb7b009b8..abbaa6b0b2db9 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
> @@ -1100,7 +1100,7 @@ static void program_gamut_remap(
>
>  }
>
> -/**
> +/*
>   ***********************************************************************=
******
>   *  Function: dal_transform_wide_gamut_set_gamut_remap
>   *
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
