Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B06E2EF963
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbhAHUjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729087AbhAHUjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:39:12 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9888AC061380
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:38:32 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id r9so10887032otk.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F+uxettFRGlky9UwEMbAbyahgwrq7aawL5w5fcWbkBw=;
        b=IKm2Sfbj/rGYjYdtMySxzLxQ63/8U3+HzMldHBp0WK8F7M4aut+Td4yEkiAzQWi1h8
         L7msbhbiXEfUBKBsm521k+mcQgS1OBrApC/WxCfBt0j76wlLPRWUEhxHCOJmDKQW7rqP
         +Yn1qKhg91qdo+U9OEsjMGbkTFb1xMua4kJVZbP11xKXkaKTfJKniudOYqh84ag4OUmL
         S/g48yhAmRGkQC8vtW0C7y3SmJlBWOmRZIkbMI8hPdDsxs9P3JWwWkL7I57VOEaLBnVG
         hLwoLaf1jTWOcdF3GK8mpIWja45uxCxPrZR66syvQshT2XyDWkGf2IlAodIu6MLh4hjN
         6mGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F+uxettFRGlky9UwEMbAbyahgwrq7aawL5w5fcWbkBw=;
        b=rmdG3Ab0sorXpJ3SW0M8zVqVUZVqIJfBWdEnBs25Lry+fQe52uzpqbxTkdac32WUwB
         6fx8AECwI858W7UZvCKSbtSRzDvB5J95OMh2g3U8e0jialtA37vgQCJYWc62JC2yJKYZ
         VDqWZGcZaMRqAjQRW70JYu3fSAi7Pl9Vkv9avyk+Rj+v1AA2kfy+eYu4B1RoedP1sxOC
         e8iGfkpFx7159pcptufFdCQC73IgTeZ4lRszrTmIFAJ9KRd2VUrZAzk6/7ngguG2wG9q
         LvwozFmmtxP3VWfEY866BCOTm6yYmcCKLDtw3VcV2rI3c0MznR0eWIoshuxlQbX6M9ij
         lvbg==
X-Gm-Message-State: AOAM530Hk4qVVZNffBn0slJV1OwZ3tSxExe+wPq4NUpdsNLgt/CJRLUk
        y8ICEgnGQP9Fv8QHu4+XnOmMJK5tF7TNRIgrv8cYbSLT
X-Google-Smtp-Source: ABdhPJyo8W/DJW80s6mGIS4+XeSXcytFk1+4aHTkpjMoWGZLJOaZkhzJIbhnUhtDeNWFl8ywBkIrXIEKJ62N6myB/vc=
X-Received: by 2002:a05:6830:1b7b:: with SMTP id d27mr3992917ote.132.1610138312081;
 Fri, 08 Jan 2021 12:38:32 -0800 (PST)
MIME-Version: 1.0
References: <20210108201457.3078600-1-lee.jones@linaro.org> <20210108201457.3078600-14-lee.jones@linaro.org>
In-Reply-To: <20210108201457.3078600-14-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 8 Jan 2021 15:38:21 -0500
Message-ID: <CADnq5_O6dmro2Rjjf8m3cJ4Mtv3utoLCmtqBjgFT9NtNXUFEWQ@mail.gmail.com>
Subject: Re: [PATCH 13/40] drm/amd/display/dc/basics/conversion: Demote
 obvious kernel-doc abuse
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

On Fri, Jan 8, 2021 at 3:15 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/basics/conversion.c:86: warning=
: Function parameter or member 'matrix' not described in 'convert_float_mat=
rix'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/basics/conversion.c:86: warning=
: Function parameter or member 'flt' not described in 'convert_float_matrix=
'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/basics/conversion.c:86: warning=
: Function parameter or member 'buffer_size' not described in 'convert_floa=
t_matrix'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/basics/conversion.c:86: warning=
: Excess function parameter 'param' description in 'convert_float_matrix'
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/basics/conversion.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/basics/conversion.c b/drivers=
/gpu/drm/amd/display/dc/basics/conversion.c
> index 24ed03d8cda74..6767fab55c260 100644
> --- a/drivers/gpu/drm/amd/display/dc/basics/conversion.c
> +++ b/drivers/gpu/drm/amd/display/dc/basics/conversion.c
> @@ -73,12 +73,9 @@ uint16_t fixed_point_to_int_frac(
>
>         return result;
>  }
> -/**
> -* convert_float_matrix
> -* This converts a double into HW register spec defined format S2D13.
> -* @param :
> -* @return None
> -*/
> +/*
> + * convert_float_matrix - This converts a double into HW register spec d=
efined format S2D13.
> + */
>  void convert_float_matrix(
>         uint16_t *matrix,
>         struct fixed31_32 *flt,
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
