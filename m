Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBA952EFA6E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 22:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbhAHV1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 16:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbhAHV1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 16:27:16 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD19C061574
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 13:26:35 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id l200so12902772oig.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 13:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pg+aRNqSia7uIJrT53otaUniNHucbbmYuXBbTJWObI0=;
        b=k9iXiSkSDexRzi5go+8BFdA01htiZOFnvjFAmAtI1+SFbftToBJlSzM/4axjB2Z0zy
         2+RLEzNlKHHfsj9ucJ8U9/76D7dbq2i4UGVOhfP6ehgOwB37TrOuNFSs6zONVKh7dFkE
         9XEA2pBJJF9Zw/WZgToFAC2gXzs8CaDydjFZRdV9LldlfYsGyCnGweUDm/jFuJdK2LRo
         TMhRBHodl0iz9wZ7SGEGgqbfn6ZmPwZdXQr/G879ECl12r2YbYd+bDjC7QQAR+ZCbN7F
         wY9N3o6kNbM2WA/5pNswCfRWN9iWxmnk4QsObjm9NE2D12RvSIbL3BplYnBPSwlwsjb/
         NS6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pg+aRNqSia7uIJrT53otaUniNHucbbmYuXBbTJWObI0=;
        b=OK/SUDwrbEuprifwbBPnr4fck5YqK3So+SwGiNRsB00N9NRzGrhXhDxMBH9VJF0mdd
         JdH+YtF2N9ubZGqbM7Zp6MD+Jwc+rG6B1+9fPgOvZ/Yv77e8ZI6wnBYuzv+H2uDfmqaQ
         kg45SitrMuWB4zpdO4trAJ8C1VGivfM58mAk1RdGQVMX9tqAPX70ESvP0mH5Cxrw/GML
         /+z0Riol2OiNT3pMKm+/I18SWDOFSR9lmjJo8AtOQWTeEIDagfkj0d6WjK4ERI3jTGMR
         0dN0HurfmlXsj1SP9h9R91p69X5SjRKu+/4GEZE/TwYQKFvylXgbvqCuvqVH5p+kJN59
         rc2g==
X-Gm-Message-State: AOAM532UNljqhs6U5QsB5y9o0Q/6FzKW7Eff3YGXEkGds7oSaQldJjb5
        tdfmqcJM85Qg7nab5aoL3xbckRm7WDEIAng+EBM=
X-Google-Smtp-Source: ABdhPJzqwHtjKRdnNH+fBKDZJAPGAZaI3o2wxr6GgKc8F8vRb7Oa1N1wsOZseHoQMykHnceb66uKR+KYUA0BbZEyl5g=
X-Received: by 2002:aca:4f97:: with SMTP id d145mr3526697oib.123.1610141195307;
 Fri, 08 Jan 2021 13:26:35 -0800 (PST)
MIME-Version: 1.0
References: <20210108201457.3078600-1-lee.jones@linaro.org> <20210108201457.3078600-40-lee.jones@linaro.org>
In-Reply-To: <20210108201457.3078600-40-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 8 Jan 2021 16:26:24 -0500
Message-ID: <CADnq5_OK7ApRm4EwuW6kqAdQ192N4GJ2bgEtgKjvO8qyKR4Meg@mail.gmail.com>
Subject: Re: [PATCH 39/40] drm/amd/display/dc/dce/dmub_psr: Demote
 non-conformant kernel-doc headers
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Leo Li <sunpeng.li@amd.com>, LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Wyatt Wood <wyatt.wood@amd.com>,
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
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:38: warning: Fun=
ction parameter or member 'raw_state' not described in 'convert_psr_state'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:81: warning: Fun=
ction parameter or member 'dmub' not described in 'dmub_psr_get_state'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:81: warning: Fun=
ction parameter or member 'state' not described in 'dmub_psr_get_state'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:97: warning: Fun=
ction parameter or member 'dmub' not described in 'dmub_psr_set_version'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:97: warning: Fun=
ction parameter or member 'stream' not described in 'dmub_psr_set_version'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:128: warning: Fu=
nction parameter or member 'dmub' not described in 'dmub_psr_enable'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:128: warning: Fu=
nction parameter or member 'enable' not described in 'dmub_psr_enable'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:128: warning: Fu=
nction parameter or member 'wait' not described in 'dmub_psr_enable'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:177: warning: Fu=
nction parameter or member 'dmub' not described in 'dmub_psr_set_level'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:177: warning: Fu=
nction parameter or member 'psr_level' not described in 'dmub_psr_set_level=
'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:203: warning: Fu=
nction parameter or member 'dmub' not described in 'dmub_psr_copy_settings'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:203: warning: Fu=
nction parameter or member 'link' not described in 'dmub_psr_copy_settings'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:203: warning: Fu=
nction parameter or member 'psr_context' not described in 'dmub_psr_copy_se=
ttings'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:284: warning: Fu=
nction parameter or member 'dmub' not described in 'dmub_psr_force_static'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:301: warning: Fu=
nction parameter or member 'dmub' not described in 'dmub_psr_get_residency'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:301: warning: Fu=
nction parameter or member 'residency' not described in 'dmub_psr_get_resid=
ency'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:323: warning: Fu=
nction parameter or member 'psr' not described in 'dmub_psr_construct'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:323: warning: Fu=
nction parameter or member 'ctx' not described in 'dmub_psr_construct'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:332: warning: Fu=
nction parameter or member 'ctx' not described in 'dmub_psr_create'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:349: warning: Fu=
nction parameter or member 'dmub' not described in 'dmub_psr_destroy'
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Wyatt Wood <wyatt.wood@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex


> ---
>  drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 22 +++++++++----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/=
drm/amd/display/dc/dce/dmub_psr.c
> index 17e84f34ceba1..4228caa741193 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
> @@ -31,7 +31,7 @@
>
>  #define MAX_PIPES 6
>
> -/**
> +/*
>   * Convert dmcub psr state to dmcu psr state.
>   */
>  static enum dc_psr_state convert_psr_state(uint32_t raw_state)
> @@ -74,7 +74,7 @@ static enum dc_psr_state convert_psr_state(uint32_t raw=
_state)
>         return state;
>  }
>
> -/**
> +/*
>   * Get PSR state from firmware.
>   */
>  static void dmub_psr_get_state(struct dmub_psr *dmub, enum dc_psr_state =
*state)
> @@ -90,7 +90,7 @@ static void dmub_psr_get_state(struct dmub_psr *dmub, e=
num dc_psr_state *state)
>         *state =3D convert_psr_state(raw_state);
>  }
>
> -/**
> +/*
>   * Set PSR version.
>   */
>  static bool dmub_psr_set_version(struct dmub_psr *dmub, struct dc_stream=
_state *stream)
> @@ -121,7 +121,7 @@ static bool dmub_psr_set_version(struct dmub_psr *dmu=
b, struct dc_stream_state *
>         return true;
>  }
>
> -/**
> +/*
>   * Enable/Disable PSR.
>   */
>  static void dmub_psr_enable(struct dmub_psr *dmub, bool enable, bool wai=
t)
> @@ -170,7 +170,7 @@ static void dmub_psr_enable(struct dmub_psr *dmub, bo=
ol enable, bool wait)
>         }
>  }
>
> -/**
> +/*
>   * Set PSR level.
>   */
>  static void dmub_psr_set_level(struct dmub_psr *dmub, uint16_t psr_level=
)
> @@ -194,7 +194,7 @@ static void dmub_psr_set_level(struct dmub_psr *dmub,=
 uint16_t psr_level)
>         dc_dmub_srv_wait_idle(dc->dmub_srv);
>  }
>
> -/**
> +/*
>   * Setup PSR by programming phy registers and sending psr hw context val=
ues to firmware.
>   */
>  static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
> @@ -277,7 +277,7 @@ static bool dmub_psr_copy_settings(struct dmub_psr *d=
mub,
>         return true;
>  }
>
> -/**
> +/*
>   * Send command to PSR to force static ENTER and ignore all state change=
s until exit
>   */
>  static void dmub_psr_force_static(struct dmub_psr *dmub)
> @@ -294,7 +294,7 @@ static void dmub_psr_force_static(struct dmub_psr *dm=
ub)
>         dc_dmub_srv_wait_idle(dc->dmub_srv);
>  }
>
> -/**
> +/*
>   * Get PSR residency from firmware.
>   */
>  static void dmub_psr_get_residency(struct dmub_psr *dmub, uint32_t *resi=
dency)
> @@ -316,7 +316,7 @@ static const struct dmub_psr_funcs psr_funcs =3D {
>         .psr_get_residency              =3D dmub_psr_get_residency,
>  };
>
> -/**
> +/*
>   * Construct PSR object.
>   */
>  static void dmub_psr_construct(struct dmub_psr *psr, struct dc_context *=
ctx)
> @@ -325,7 +325,7 @@ static void dmub_psr_construct(struct dmub_psr *psr, =
struct dc_context *ctx)
>         psr->funcs =3D &psr_funcs;
>  }
>
> -/**
> +/*
>   * Allocate and initialize PSR object.
>   */
>  struct dmub_psr *dmub_psr_create(struct dc_context *ctx)
> @@ -342,7 +342,7 @@ struct dmub_psr *dmub_psr_create(struct dc_context *c=
tx)
>         return psr;
>  }
>
> -/**
> +/*
>   * Deallocate PSR object.
>   */
>  void dmub_psr_destroy(struct dmub_psr **dmub)
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
