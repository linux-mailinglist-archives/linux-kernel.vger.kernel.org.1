Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC252F3F65
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405654AbhALWT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 17:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392985AbhALWT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:19:27 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC37C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:18:47 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id d8so9811otq.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Od+zSJfKa4Z6aPePHWW0VtrqDCrKYYEC4JyNh+WdTnU=;
        b=eaKJmvWGEow921M6Fs9SwyrCmgpcNbnIFEkktGJvIy1+SiX/caWuAu+CIsUdj+I7fd
         cF9xeMUAjuK7ctMAoeszK2RRZRZU63n0KlRRZcg+SRvasrRk4NNe52n0agCFOYNEKPuT
         6pYPPvdhpBJbhHG93HVh6aVUJas1NCMXWRRhdXSRcl3uzhKU7Z7ISUOozq4GrG477Q14
         Z+sLX0BnpBeSze0hLoxk/RjIcU28zFNywARPxJ3m51PqUiiindxPmsRhKyK0plXwjWuT
         hkvYJeuUfMq+mk82Ma38oGtruJMmnQW4rMu5HHRmt1uF+n7NWHSZaRtHoHhn5C4Q2dHF
         z55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Od+zSJfKa4Z6aPePHWW0VtrqDCrKYYEC4JyNh+WdTnU=;
        b=T2m+1JUeaI9kAhq0KUjyKzTt5VulbWidSmrh0sK0995cUaK6RW9bKgv49gRiRlhMyN
         j/KVgIRzzoS939FFgWUGDaD8KOeWOKfTgyJ9HMOqmfFTIBAnp1BBuhcsR3il26JVp6zO
         BPnqs3qy8PlgDIURsTQ321paC7OtUnybxZsKgL/XetMv4snV8LS6sYtNT0Pv6mr9Fw3f
         WGLrY72tMR2fJMV8p1ECCUFjnhvIu5557Zw7qK1q+347REWWKrWMJwL4p9kRp2NcJwHI
         BerKgiZ77DUcTI7DjxXxao28124tSLJDWDLzMtNUpfFk5n7w2D4RlaJe17JtF9k9Saut
         94zA==
X-Gm-Message-State: AOAM5304zzJpR5PpgrJETlMW/7zKO9i5FwTiEj6lFuiRjP4gHC75jS/E
        Y3hne+8d0HZBovwZ+1jr6IhBDYpiulq5OfNfGOQ=
X-Google-Smtp-Source: ABdhPJxRm1UAUowsFQsgEpfEUFrFqiLUYJb4jpm5M3vR60WksR0JiJ0iGdD/PaSerJLJl8UGHWh470g6qgC5EdXwh9Q=
X-Received: by 2002:a9d:75d4:: with SMTP id c20mr1022285otl.311.1610489926631;
 Tue, 12 Jan 2021 14:18:46 -0800 (PST)
MIME-Version: 1.0
References: <20210111191926.3688443-1-lee.jones@linaro.org> <20210111191926.3688443-21-lee.jones@linaro.org>
In-Reply-To: <20210111191926.3688443-21-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 12 Jan 2021 17:18:34 -0500
Message-ID: <CADnq5_PkVSbEQJ+MBNTsYOrbAs0j5TYtiFvRUt00Dd4JqJnNgA@mail.gmail.com>
Subject: Re: [PATCH 20/40] drm/amd/display/dc/dce110/dce110_timing_generator:
 Remove unused variable 'value_crtc_vtotal'
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Leo Li <sunpeng.li@amd.com>, Anthony Koo <Anthony.Koo@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Tony Cheng <Tony.Cheng@amd.com>,
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
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator.=
c: In function =E2=80=98dce110_timing_generator_tear_down_global_swap_lock=
=E2=80=99:
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator.=
c:1354:12: warning: variable =E2=80=98value_crtc_vtotal=E2=80=99 set but no=
t used [-Wunused-but-set-variable]
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Aric Cyr <Aric.Cyr@amd.com>
> Cc: Anthony Koo <Anthony.Koo@amd.com>
> Cc: Tony Cheng <Tony.Cheng@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex


> ---
>  .../gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c  | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generato=
r.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c
> index 1ea7db8eeb988..9a6c411bb7fe6 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c
> @@ -1351,10 +1351,7 @@ void dce110_timing_generator_tear_down_global_swap=
_lock(
>
>         /* Restore DCP_GSL_PURPOSE_SURFACE_FLIP */
>         {
> -               uint32_t value_crtc_vtotal;
> -
> -               value_crtc_vtotal =3D dm_read_reg(tg->ctx,
> -                               CRTC_REG(mmCRTC_V_TOTAL));
> +               dm_read_reg(tg->ctx, CRTC_REG(mmCRTC_V_TOTAL));
>
>                 set_reg_field_value(value,
>                                 0,
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
