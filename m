Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEAC52EFA55
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 22:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbhAHVWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 16:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729348AbhAHVWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 16:22:45 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D508C061574
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 13:22:04 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id 11so11038057oty.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 13:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eGoGEbM4Kuo4zDKdZ7Y5vJVMzPL1lbpTN9+vCSCS16Y=;
        b=iwgkCp5hNYL1jru7mK9Ou7L5GkRKbtipDjwKYGPzk4a4qAwyUL2PrPsLNDLFOex9zc
         gEKa0JBfxIgeE5Es8l4100o8QLpAqEkNvhZox/Z9jeii05W7PxPF4kZDCPQqxREICK4g
         FkPWS/cj25HLzAPM+N8dn1MRs7ycXGpV0o5VEy/0y/3DT74/mLQYDXAFIb0a6cfUcfAC
         pul8pVNAKx+OE0RFN7qkNnMmG6fuw+acWnP9Py5PNOcAcwI3f+SVgW4BKUIaCSYHJD8K
         P69NB3K1QyIX/3nn6Iqpuim50W2B9TGem6u6yDsidSPa9dcpzF/b+goUjA9OBj7TodAW
         OsMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eGoGEbM4Kuo4zDKdZ7Y5vJVMzPL1lbpTN9+vCSCS16Y=;
        b=C+GVczw4IsXIJVlZgGMu0e7/wlJsezZOivN3IEwFc99Jp7+95neM7M74fhbfAlBDMv
         BeV+/88tmcknTw2Zd6BqL480zOiun+q+Bltvd/q5DPq67NVMUDVRZcgjkz1++3wDW1pG
         rs1C4RvRiyeUiuLxq3OHeWCxFtT3ULWpqpo181y+Z0a2CxPZZGPQ6g7QEc1A7Upp8KCX
         rz6WQLj7aXfJ6l++QRObiVCwks1aeiLZLgI5sgKt28Ogh7dxPuZCzrIbf34moVFAxvGA
         dzW/2Q/Qq07Bm5uApxFki5WPi+jBfxbqxmlYtrox6uoOy3E96gdeMQTrmsfWyP45DoYe
         GqWQ==
X-Gm-Message-State: AOAM531K21sbV4ypgH5C3gLk5p2gQcfCG4ypAXyLaJJghWfFayZwIiq7
        3msOyEnt0dE3Q9RbD2oU4UTHNCPPRXNxjl3txN9lNsr8
X-Google-Smtp-Source: ABdhPJzNSx+QP7P1tQILmHjAf4YBlXWsFGbapGW8eMFnXAyLPIsTBSUZOrAvKt3jszCLUeWHSpuHYBsbvZakkhIO9rw=
X-Received: by 2002:a05:6830:1d66:: with SMTP id l6mr3898666oti.23.1610140924362;
 Fri, 08 Jan 2021 13:22:04 -0800 (PST)
MIME-Version: 1.0
References: <20210108201457.3078600-1-lee.jones@linaro.org> <20210108201457.3078600-35-lee.jones@linaro.org>
In-Reply-To: <20210108201457.3078600-35-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 8 Jan 2021 16:21:53 -0500
Message-ID: <CADnq5_MkQRnX+KJkhmJ2-07iXG8TcLS9nq9jpqmRFpm5D=ydgA@mail.gmail.com>
Subject: Re: [PATCH 34/40] drm/amd/display/dc/bios/bios_parser: Fix
 misspelling of function parameter
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

On Fri, Jan 8, 2021 at 3:16 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:997: warning=
: Function parameter or member 'ss_info' not described in 'get_ss_info_from=
_tbl'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:997: warning=
: Excess function parameter 'ssinfo' description in 'get_ss_info_from_tbl'
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
>  drivers/gpu/drm/amd/display/dc/bios/bios_parser.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/=
gpu/drm/amd/display/dc/bios/bios_parser.c
> index d2654c50b0b20..c67d21a5ee52f 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
> @@ -987,8 +987,8 @@ static enum bp_result get_ss_info_from_internal_ss_in=
fo_tbl_V2_1(
>   *
>   * @bp:      pointer to the BIOS parser
>   * @id:      spread sprectrum info index
> - * @ssinfo:  sprectrum information structure,
> - * return::  BIOS parser result code
> + * @ss_info: sprectrum information structure,
> + * return:   BIOS parser result code
>   */
>  static enum bp_result get_ss_info_from_tbl(
>         struct bios_parser *bp,
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
