Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED8D2F6773
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbhANRXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbhANRXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:23:39 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570CCC061757
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:22:59 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id x5so5861040otp.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DUGT8yIZRmOY3BQpbBHhVF2lTkLNcilg449v2mrDwzM=;
        b=irCpQgghVr3R19Ry9aMiFWOeS1RsG4hWbm9bd0dUNsY8/kj2wTGkt7i1lskW+wTKHU
         pQ4AUI3gEB8Y/3kt3TDiik/4JkZOCIgiNqd50zP3GMdJmooo9e22XJn/v0CK5C36FPe3
         7tBNXOkSn9k3eNNgvdhwQ66qLDPKcYSYszpiWny9kmkMK7f8qUt2kutgn6cfvfMnWf3i
         ubneKAiZZgPg40N8S2ciQJbVnOC7sMs/njb+vCFvEZ9L3O48Jdxg44ktRdWo2ZzN7SWw
         lijXLvkwiPj19zJRQJpED/iQ/Y9tU9fr1lh93YjnRdRDUGY+qRrQnorMLUZn3uuIrAOf
         X9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DUGT8yIZRmOY3BQpbBHhVF2lTkLNcilg449v2mrDwzM=;
        b=M125QNB6ok68HujP2apTvwBCaHvHfR4iZnlAvJqrnNniuwsmjlI50QxYTcCSo86Cd5
         6l2zFNS7RUbazfnYEnojv0A6koCUbEXM+An7H6WE5U9GRNwMeM2jGUuB5D4IOT0p7t3e
         D9xq4GZvbkwN2tujvJBlO7pPTcTGLzp/O/aIvUTFx5CSInTY1jUQhwA5UNRE/PeOO/+E
         6bo+bF80tc2v9MU8EFhN288ySHGfv9ScoJqBpb3Dw9mVoIc2m8gasi9qpV9gNw4hI7zy
         NxBs82loziN4Vc+KHgN1ZFcIzNn24LlulI0Nlqxvyc7JEH1DEgbA3oYpuVmrVHEMYJg1
         ZJeA==
X-Gm-Message-State: AOAM533JjdhPUUCjRVm+C3/zH2wafOArEdc1N5kCzMKnuA/j2roLcu0d
        UXjNJ/KRe4LjfIpvkmiSrMAdQmPfm163dIp6rcY=
X-Google-Smtp-Source: ABdhPJzM9HtHVs4FsfAsMlHtiqpkCnS9ZSjL8CfKjLDCN8PuWnTj7gFAcsDDK1aYxkB+3jmF7JAihpBXhgUgjIXwnZs=
X-Received: by 2002:a05:6830:1b7b:: with SMTP id d27mr5496584ote.132.1610644978827;
 Thu, 14 Jan 2021 09:22:58 -0800 (PST)
MIME-Version: 1.0
References: <20210113080752.1003793-1-lee.jones@linaro.org> <20210113080752.1003793-22-lee.jones@linaro.org>
In-Reply-To: <20210113080752.1003793-22-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 14 Jan 2021 12:22:47 -0500
Message-ID: <CADnq5_Mq8AXb1qUgnLcDTY37FFqzGFzNzJQQZTN7TbPtadU59Q@mail.gmail.com>
Subject: Re: [PATCH 21/30] drm/amd/display/dc/core/dc_resource: Demote some
 kernel-doc abuses
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

On Wed, Jan 13, 2021 at 3:08 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1710: warnin=
g: Function parameter or member 'old_stream' not described in 'dc_is_stream=
_unchanged'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1710: warnin=
g: Function parameter or member 'stream' not described in 'dc_is_stream_unc=
hanged'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1726: warnin=
g: Function parameter or member 'old_stream' not described in 'dc_is_stream=
_scaling_unchanged'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1726: warnin=
g: Function parameter or member 'stream' not described in 'dc_is_stream_sca=
ling_unchanged'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1843: warnin=
g: Function parameter or member 'dc' not described in 'dc_add_stream_to_ctx=
'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1843: warnin=
g: Function parameter or member 'new_ctx' not described in 'dc_add_stream_t=
o_ctx'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1843: warnin=
g: Function parameter or member 'stream' not described in 'dc_add_stream_to=
_ctx'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1870: warnin=
g: Function parameter or member 'dc' not described in 'dc_remove_stream_fro=
m_ctx'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1870: warnin=
g: Function parameter or member 'new_ctx' not described in 'dc_remove_strea=
m_from_ctx'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1870: warnin=
g: Function parameter or member 'stream' not described in 'dc_remove_stream=
_from_ctx'
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
>  drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/=
gpu/drm/amd/display/dc/core/dc_resource.c
> index d423092c45dcd..185412d0c1429 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -1697,7 +1697,7 @@ static bool are_stream_backends_same(
>         return true;
>  }
>
> -/**
> +/*
>   * dc_is_stream_unchanged() - Compare two stream states for equivalence.
>   *
>   * Checks if there a difference between the two states
> @@ -1718,7 +1718,7 @@ bool dc_is_stream_unchanged(
>         return true;
>  }
>
> -/**
> +/*
>   * dc_is_stream_scaling_unchanged() - Compare scaling rectangles of two =
streams.
>   */
>  bool dc_is_stream_scaling_unchanged(
> @@ -1833,7 +1833,7 @@ static struct audio *find_first_free_audio(
>         return 0;
>  }
>
> -/**
> +/*
>   * dc_add_stream_to_ctx() - Add a new dc_stream_state to a dc_state.
>   */
>  enum dc_status dc_add_stream_to_ctx(
> @@ -1860,7 +1860,7 @@ enum dc_status dc_add_stream_to_ctx(
>         return res;
>  }
>
> -/**
> +/*
>   * dc_remove_stream_from_ctx() - Remove a stream from a dc_state.
>   */
>  enum dc_status dc_remove_stream_from_ctx(
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
