Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE2892F3FD5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437105AbhALWh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 17:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbhALWhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:37:55 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CBBC061794
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:37:15 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id k9so32330oop.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xERaZ+cRvJ1AT75s/Sd6NIg2My+pi/GZJ6ju2r6RLE8=;
        b=QNPZH26ZvfUFMYziW93/hi8p2JHjeYFMXyOqtHCSl6HRwlxhQ1bRgywJFpfFw2uKhp
         xsc/dRFV8i3s0dh4z4jUm1il9YFJLk+xyrfGWGCywpE8/UxKDoMlVVc1P5cLF/SuLxr0
         3MABguwvuVZurAXIOPdu9tDM9gfCfRrnGGm9g7zHZdlF3HBd0ljF0xEYrCWVomf6KhSd
         ZIpwm3v5EmKiOl/3gxzmGyz2BXzCndgBh4XHFIut5KxBjbum4mqlJMqnjBjbryN2+fzO
         oa5n1y2uzE8ZoXlqy5SJMNWbNz8tQlNWFG3GyFK/BTKTmbH8txCQMBPSS9xNg4W+bQlC
         VeoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xERaZ+cRvJ1AT75s/Sd6NIg2My+pi/GZJ6ju2r6RLE8=;
        b=cdrHfMQC8g81psTDE6ykf/O5kPiP84HR9b0DCFc5uutBvN3SEjFGmbIH7M7TmqX6Gj
         WuhcdrKOF/Y8R3C9Rnsvl1cnQh0BVGqg3oTmSEZux7e+cnRG7WqnWrMyTYsqDEkQ2Ie0
         wuYIMD7VxJlENsTkXHeTMV1GQLwjVxcDIuZpZulkyp1xOQhhqMQOqmyMMADbzO1Kp5i2
         1+Kvvm8NRvb2GD243SIlvgoA2oC8gLLH/Zea5t4qCdebsS/Ixx/CAFmVV4YoRorW794c
         nJA9OYQHri3aM3acdKfohbxWgAOdfelxrpso357KPtBGfCXZRLSvQLTD02GeqC7HdKyN
         f1jQ==
X-Gm-Message-State: AOAM5302vcLVAwaxS0c8g1ma9K7b5wgEigIhii5s+Yk+Afz93b0MXW1g
        YmGV3mZu8z2bpyID8s+nPGOHpiYhx5VFHOTYxN4=
X-Google-Smtp-Source: ABdhPJzqty4NpJdahSeM0tH4SU0UCXsnxmA3UxbVuNbJz1jQK8zoul1Fp2qrga9yxisZ2HVa+zpoB5DJQxuNzVw/2dE=
X-Received: by 2002:a4a:330b:: with SMTP id q11mr800770ooq.90.1610491034444;
 Tue, 12 Jan 2021 14:37:14 -0800 (PST)
MIME-Version: 1.0
References: <20210111191926.3688443-1-lee.jones@linaro.org> <20210111191926.3688443-35-lee.jones@linaro.org>
In-Reply-To: <20210111191926.3688443-35-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 12 Jan 2021 17:37:02 -0500
Message-ID: <CADnq5_PK9aukXtdcqcS-ELn9jB=Vysj+Gp0iL5nUcLXiQM=hfQ@mail.gmail.com>
Subject: Re: [PATCH 34/40] drm/amd/display/dc/dce110/dce110_transform_v:
 Demote kernel-doc abuse
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
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_transform_v.c:228=
: warning: bad line:    void
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_transform_v.c:233=
: warning: Function parameter or member 'xfm_dce' not described in 'program=
_overscan'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_transform_v.c:233=
: warning: Function parameter or member 'data' not described in 'program_ov=
erscan'
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
>  .../display/dc/dce110/dce110_transform_v.c    | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_transform_v.c b=
/drivers/gpu/drm/amd/display/dc/dce110/dce110_transform_v.c
> index b1aaab5590cc6..29438c6050dbb 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_transform_v.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_transform_v.c
> @@ -217,16 +217,15 @@ static bool setup_scaling_configuration(
>         return is_scaling_needed;
>  }
>
> -/**
> -* Function:
> -* void program_overscan
> -*
> -* Purpose: Programs overscan border
> -* Input:   overscan
> -*
> -* Output:
> -   void
> -*/
> +/*
> + * Function:
> + * void program_overscan
> + *
> + * Purpose: Programs overscan border
> + * Input:   overscan
> + *
> + * Output: void
> + */
>  static void program_overscan(
>                 struct dce_transform *xfm_dce,
>                 const struct scaler_data *data)
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
