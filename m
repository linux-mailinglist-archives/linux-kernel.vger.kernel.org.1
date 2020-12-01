Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1410D2C93AD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 01:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731043AbgLAAHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 19:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgLAAHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 19:07:45 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5298DC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 16:07:05 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id h3so16256410oie.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 16:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Vo+tRjj+TvDhpBanVcRgzaWE8EwPmtDQZF4FRG6eKXY=;
        b=FPTgQsr72ct5YMfbQd/8bBoOc+nJMAYfufnd3HIj9QUe2gLM61BxOMmyuBqkg8clWs
         2lb1FRal9GojomQUPxANgXhyF/SyB3mpOXycLHsqsjhqRUhNHuQ8IhDXjdPLpIlAgTXa
         9YY+r6WfnF+eOPm9fSvFjL3VXchzUskf2CHow610wWMXmILNaaZ/Wozb/bAhXmJ1jbPM
         yFt3o+zwpaHCsH/rV0r8fqbeibzGhKQHK4dBBU2wrfkkrXq/LzPfgpUGr/HpTWxSRa7l
         qznMH+MoBAl0k/yLcXdjI4VoDuvJk1aw/5eTl9L7Mi+l3x/ebEDdr7I5Z4/IDVEUAgBz
         etzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Vo+tRjj+TvDhpBanVcRgzaWE8EwPmtDQZF4FRG6eKXY=;
        b=trFjRXTyAutL8nsoYQbUFDPAnVHWTtH8K1q96kbCXkTkvygFfbQuHCyp50zfx4pA5g
         13kBNocTGpq9Eu/fy/aaNV033lDFREWGbidcdRYPhceSXGyPptKhpDq4JioF2dMz3nW3
         RGfBjxSS5jKbsgBjyI7g+bj3NYLB7mAgLJjFNpXeyY3Q2ri/LznKNkMbVaQKmrGW68yb
         xbnbx8Jx6KWx9H/VgE9zV+lAM/RobXHPcP+58XKm26QJKvUE+B0Z881EPdWG/9fB0w1r
         nC5U+qYUpuOlplTpHhMFZakTJ4y393K0njovk3YqOmsbF7CvnkzAeeAQuopqNpiLd2CQ
         QQxQ==
X-Gm-Message-State: AOAM532HaX8c74NfCkjxuHmvny0LwirZ7BdtPRlCR1JUwWtop2Wm6jH1
        /KO4lGvLLoGXx55OTpEgLU/fD56W5eUfwECHfm/ZJJyO
X-Google-Smtp-Source: ABdhPJwv19U5fZe9MwiHGKE6plwyHcsTtrydbT5iN+fr9a6dO/iWooI7CFtk+go/ABD8ulFVXGOZ9FMelO/POjnwE/s=
X-Received: by 2002:aca:f50e:: with SMTP id t14mr36785oih.123.1606781224826;
 Mon, 30 Nov 2020 16:07:04 -0800 (PST)
MIME-Version: 1.0
References: <20201126134240.3214176-1-lee.jones@linaro.org> <20201126134240.3214176-40-lee.jones@linaro.org>
In-Reply-To: <20201126134240.3214176-40-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 19:06:53 -0500
Message-ID: <CADnq5_NBM_6Fz566zvFnW5X=s6NFhYM+eMx36sftjMRnNz6mPw@mail.gmail.com>
Subject: Re: [PATCH 39/40] drm/amd/display/dc/basics/fixpt31_32: Remove unused
 variable 'dc_fixpt_pi'
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

On Thu, Nov 26, 2020 at 8:44 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/basics/fixpt31_32.c:29:32: warn=
ing: =E2=80=98dc_fixpt_pi=E2=80=99 defined but not used [-Wunused-const-var=
iable=3D]
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
>  drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c b/drivers=
/gpu/drm/amd/display/dc/basics/fixpt31_32.c
> index 59f37563704ad..1726bdf89bae8 100644
> --- a/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c
> +++ b/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c
> @@ -26,7 +26,6 @@
>  #include "dm_services.h"
>  #include "include/fixed31_32.h"
>
> -static const struct fixed31_32 dc_fixpt_pi =3D { 13493037705LL };
>  static const struct fixed31_32 dc_fixpt_two_pi =3D { 26986075409LL };
>  static const struct fixed31_32 dc_fixpt_ln2 =3D { 2977044471LL };
>  static const struct fixed31_32 dc_fixpt_ln2_div_2 =3D { 1488522236LL };
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
