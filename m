Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59BBA2C93AA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 01:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731023AbgLAAGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 19:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgLAAGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 19:06:48 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25703C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 16:06:08 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id h3so16254045oie.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 16:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VJ6GVGZJnlia94V5K1MGzcsJQIbX5tNg1UJ/89bmUcU=;
        b=TSK5uOsu/FbeF3GDDL0u4zr97u2HPAHfevzLlKrwftFCYXCP3aV0mRrE9lPd14kA2a
         DxSKOeniR0G6XZzxjmAE6ROPljYL34xNeuDS24kRcTbg7yEcB5nEQoupithEVne70Mjh
         zPtHZec4cLhdz7O1yWy5yBLDG9ipUQ2X7Tqp5/9SPTtTqPSinqVXJxvzfiNc7J3VEo0e
         oGy7c8adhKiIx4aI785B/1Hx6qVLhif7HnSPeapZ8ImTo+2G5/E8rNMPArmHm90ZT+wh
         ap947bOeMkqVqWDX+PceR62RzRVNwH6oZLPU8tudP6EwP3a82BNbZb106+6Vcqfu//Vu
         8KMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VJ6GVGZJnlia94V5K1MGzcsJQIbX5tNg1UJ/89bmUcU=;
        b=olEpjhgBvsiu+gc1H0WME6uQOaZvpH7J4+DzfpBJAfK7yM+XYaMybP/aQwZ5ABlfcL
         MDLXFWogkN/z3KcDNpFJt6s2iwfJVx8uqBMPnZWYL2e7RDy2z1GGUmd3vEHVPoFJWCkL
         A0/6q5TI+K0fVbfdQzLsO6uMBT0YSj58xCDxuCkLLUpuXDy3/fjWExtHHUwVUSL62yJM
         rtOK+D+MJj/YObK9oaixb0H6XPxCbzFZF4CiDewQhO8CksotaW2shRMy2c67D9lAwXTN
         k/HB7YaJQr9ssbB1+2x7qULVaw+kx+cwAMRNiMxPFTWk3Ko/foGs33sLksVYA5VGg1hW
         ts+w==
X-Gm-Message-State: AOAM530IhocTj7VHybHJ3TpeF/fRa3LLiE+r57RIJkOv89Nzx7tctlbu
        da1n6cZ6btBp/CKxoSn53tbNoHhs/fIppJ3pNBw=
X-Google-Smtp-Source: ABdhPJy81PYJy+yCScmXWOfjTflC7etYxCUmcD2F95/TLx6FI5rVtQ+OVJq4ym2V/ewVERoAs5nFMaDLDb0Su4XxR94=
X-Received: by 2002:a54:4608:: with SMTP id p8mr49420oip.5.1606781167608; Mon,
 30 Nov 2020 16:06:07 -0800 (PST)
MIME-Version: 1.0
References: <20201126134240.3214176-1-lee.jones@linaro.org> <20201126134240.3214176-39-lee.jones@linaro.org>
In-Reply-To: <20201126134240.3214176-39-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 19:05:56 -0500
Message-ID: <CADnq5_O_-uxOa0463_ZX5D3jMwxJMWX7eCvGHyiwaku559bNLw@mail.gmail.com>
Subject: Re: [PATCH 38/40] drm/amd/display/dc/basics/conversion: Include
 header containing our prototypes
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
>  drivers/gpu/drm/amd/amdgpu/../display/dc/basics/conversion.c:34:10: warn=
ing: no previous prototype for =E2=80=98fixed_point_to_int_frac=E2=80=99 [-=
Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/basics/conversion.c:81:6: warni=
ng: no previous prototype for =E2=80=98convert_float_matrix=E2=80=99 [-Wmis=
sing-prototypes]
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
>  drivers/gpu/drm/amd/display/dc/basics/conversion.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/basics/conversion.c b/drivers=
/gpu/drm/amd/display/dc/basics/conversion.c
> index 50b47f11875c9..24ed03d8cda74 100644
> --- a/drivers/gpu/drm/amd/display/dc/basics/conversion.c
> +++ b/drivers/gpu/drm/amd/display/dc/basics/conversion.c
> @@ -24,6 +24,7 @@
>   */
>
>  #include "dm_services.h"
> +#include "conversion.h"
>
>  #define DIVIDER 10000
>
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
