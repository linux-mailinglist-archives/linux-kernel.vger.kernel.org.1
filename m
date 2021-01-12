Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7ED12F3FFC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438427AbhALWnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 17:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbhALWnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:43:19 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0BDC061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:42:39 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id x13so56221oto.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xTZum8U0xk9Dv1ypU93b7U3IcnwqshFIm7jl0nQp/ts=;
        b=H06c+s7+WWGU+D06Ioperjhl/8SSc8YaU8M4PWbl+EryEum2lFEFon5iv7u3tRqJhw
         Yc6wyTiDnTdw+ITsTG8vSQn9kOiVFOUqTf1OGwez9w3sFGsVZG4F4DzW3mD2GmqXXZvR
         vnUCe1QDlSKSgXq05xpamhKzPtcimteaa3krWD7ZPW+d+crcdaerMnB5+V0ViYkFOJk7
         QCRB0VntnSw4s9mLHxc5Gd3Uh5zfLSaWFQCzkg+wM6BN0JQ6oHL9WOJr6QihS2kweWmr
         zi3ZzjF0r05oqEXuPl282FwROWBhcRyQQ3FXWRfBIY0+jZpiXNEuWrX9SchGTWuRQMLj
         cE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xTZum8U0xk9Dv1ypU93b7U3IcnwqshFIm7jl0nQp/ts=;
        b=MD3hze6DXpO2rVV/JFDYcS9AykIkV11sDhVY9zR0KW3qzku3BJjsgCp2UffnwgeZlP
         bTD4Zu9j7WWsQwirUpNSZI1lGZEZUl4QDMBrTRpcF1xpu3/w2XzFiRd+IvxlhkXx5VsD
         k4oWcdbRylV+uC63Rcfl7Xc3oMI3bZQBP75tdzE41qYC/Q7rvTWurXSAoFwCg53cWBO1
         FWXdppN5GnbijjqwvglZh2AU4e2MahezMk+b2DnwmyjnPn4jwPoCPw6GVMhrIxiLb3bK
         twxhOIu7rtQVNpwdEClDFVBzYaXbgChNQX3nJuN9VZbay/F6Dd5RAKjQQ2r/EpsA5Gde
         +s/A==
X-Gm-Message-State: AOAM531oCmOUWNfE1YC3p8ZEN4V5EieSdTEO1yWb78TRDKW8T9qBsegl
        GZw/HbIuy8/KpQ9zMvHcnPate5vNIJcMNpo93xw=
X-Google-Smtp-Source: ABdhPJzaDe5yB/AAARqzGaTQA9vtvGwegQaGYAq/U+VyAbWoqTelxSadDrYrvrMhtNS7jYigiMWMeexj0XqYStq2KqM=
X-Received: by 2002:a05:6830:1b7b:: with SMTP id d27mr1156947ote.132.1610491359167;
 Tue, 12 Jan 2021 14:42:39 -0800 (PST)
MIME-Version: 1.0
References: <20210111191926.3688443-1-lee.jones@linaro.org> <20210111191926.3688443-41-lee.jones@linaro.org>
In-Reply-To: <20210111191926.3688443-41-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 12 Jan 2021 17:42:27 -0500
Message-ID: <CADnq5_NFY8cfqYcKCrd+Qxw6z7zmiXfbm9TeQGZ0uFc+8-eWHA@mail.gmail.com>
Subject: Re: [PATCH 40/40] drm/amd/display/dc/core/dc_stream: Demote
 non-conformant kernel-doc headers
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
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c:253: warning: =
Function parameter or member 'pStream' not described in 'dc_optimize_timing=
_for_fsft'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c:253: warning: =
Function parameter or member 'max_input_rate_in_khz' not described in 'dc_o=
ptimize_timing_for_fsft'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c:270: warning: =
Function parameter or member 'stream' not described in 'dc_stream_set_curso=
r_attributes'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c:270: warning: =
Function parameter or member 'attributes' not described in 'dc_stream_set_c=
ursor_attributes'
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
>  drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gp=
u/drm/amd/display/dc/core/dc_stream.c
> index c103f858375d0..25fa712a78474 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> @@ -244,7 +244,7 @@ struct dc_stream_status *dc_stream_get_status(
>  }
>
>  #ifndef TRIM_FSFT
> -/**
> +/*
>   * dc_optimize_timing_for_fsft() - dc to optimize timing
>   */
>  bool dc_optimize_timing_for_fsft(
> @@ -260,8 +260,7 @@ bool dc_optimize_timing_for_fsft(
>  }
>  #endif
>
> -
> -/**
> +/*
>   * dc_stream_set_cursor_attributes() - Update cursor attributes and set =
cursor surface address
>   */
>  bool dc_stream_set_cursor_attributes(
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
