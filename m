Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9C32F3FF6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438415AbhALWm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 17:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbhALWm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:42:26 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8E3C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:41:46 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id l207so76434oib.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=egLrKEU1+M6eAj0Z3txs3WRoaKHxixfD2FW+3sjJsMs=;
        b=gifWfHeko7/e125zS2LykJ6IUQNIlOifVLfAMtiHXiEpanVmAlXPW6e4ekqAN/+wCi
         gjk9FMwU4E3u5RRUtFDxWjZA4xppAfv9nRY6n5D6u4lERofTX5BmSda9OPZQ6ujHSgNs
         s37US8Y7u7CU1Q+h/z78j3X20PX7jJ5JMGHgt5SBrDOa4cSGxBHOjciOdBB5vOovlkM0
         bxiFEVObKbOqgk6A1qLqFS31O4hVd8GrspvUXfVtZprhGXVwM/7iiHwX7C96aFewGiPo
         RE/ws0fPHoBzww/JKMN1Ex6QOJ4wU9pQktjz+BjU5mqgmU8iNK4gFKGAMkXYO1vg+OfE
         Ti8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=egLrKEU1+M6eAj0Z3txs3WRoaKHxixfD2FW+3sjJsMs=;
        b=qC4iw6Ro76jHSUAi6hwqboU0TO3ZrKp2dbdFf+LL17S1kd+Iflf7047JtNjLg+C6mH
         bW2tKaVy2bvGVd3jFUGEDc5P4BBnj7nUQ1xYerKJuKrrzZKAiRaLQ0QjdhtsqBdeYbO/
         G7mzjQEBFvPqDAJ6m3PaIg/8Hr+f0c6Syd7AnYEU80dOpxvoPOLR9S3+5Sc7KuSndWC7
         4MOWlRnH9VrEtmhgFZvCqzSVBmbU9QohxSa6nRWwh+RVpuoFRFHbIfw0XB6bZrQ57A3v
         gXpQIkdHgbGbDJDjGNPoNQRY/Io/Nu0HCBA+rj/scCaWbqXQZwTcK0Z9RycarSBXiHas
         6x8g==
X-Gm-Message-State: AOAM530OSwZiVwuuZFXzIhft0OZeGqdrmKDn8ksakwo6Yr9XlwJNAcHH
        xYsTwSB2Pg6uouOFe2cQ/tceSDlzFg6WkInpJP0=
X-Google-Smtp-Source: ABdhPJyjY8vBtqVnv5kIj0aWlMnuP5o+sSEBluFePKl8c52Zye1ZawN65sp00GumXkPQNFdod6To7+zi023mnjbpMNE=
X-Received: by 2002:aca:6202:: with SMTP id w2mr807550oib.5.1610491305563;
 Tue, 12 Jan 2021 14:41:45 -0800 (PST)
MIME-Version: 1.0
References: <20210111191926.3688443-1-lee.jones@linaro.org> <20210111191926.3688443-40-lee.jones@linaro.org>
In-Reply-To: <20210111191926.3688443-40-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 12 Jan 2021 17:41:33 -0500
Message-ID: <CADnq5_O-zFFSAQHtsCuz+ktm6X8sy-0nxjDh8mDUDZLvPH6hBg@mail.gmail.com>
Subject: Re: [PATCH 39/40] drm/amd/display/dc/core/dc_surface: Demote
 kernel-doc abuse
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Leo Li <sunpeng.li@amd.com>, Josip Pavic <Josip.Pavic@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
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
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_surface.c:119: warning:=
 Cannot understand  *******************************************************=
**********************
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Josip Pavic <Josip.Pavic@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex


> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_surface.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c b/drivers/g=
pu/drm/amd/display/dc/core/dc_surface.c
> index 3d7d27435f15e..e6b9c6a718413 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
> @@ -115,7 +115,7 @@ struct dc_plane_state *dc_create_plane_state(struct d=
c *dc)
>         return plane_state;
>  }
>
> -/**
> +/*
>   ***********************************************************************=
******
>   *  Function: dc_plane_get_status
>   *
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
