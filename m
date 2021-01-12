Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFBE22F3F4F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438307AbhALWRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 17:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438278AbhALWRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:17:41 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041DEC061795
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:17:01 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id w3so3827347otp.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QDoGkX1nq3npr6u0eGjmH71uKw9TeUJ/k+zHvyVK850=;
        b=TUx0tDfq0mzy04iguDOG7xtDUoxTs40XthC2cESlJRc6WPDhZP5Uno3DZUAkmKTtuh
         DFfMV0T3S3PShcoK+R+wkNNG5uArhiVlcDS5+U8RQai9ta2iDYNSExd148dBRVYYs8B3
         WJXXMHLYBO3thXxTThrZWKhBJz5rAQ8vRsZbm4KkTH5etFZ+j1DJ4mCUY7MwiVzO/vCC
         +HYSF6ucQ0f1aZUujeTj6JtBul++KpHRW/ZJzY0KNjEdsYnP01DOcw8n27eCSTnXLQ3p
         yt0RegwOiC5c0z6tZcScz7KbBAI2W19PIJI7Ub7oM9Eqtp4rMC0FxReXwPAgFKD9p0sW
         EgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QDoGkX1nq3npr6u0eGjmH71uKw9TeUJ/k+zHvyVK850=;
        b=srGbiVvK6eDqqGtWFfHLlyg9uizv8IP7pwUL7ShCp7ASs/r3irsUQLb/bhgvqttWGR
         ky+oq2fKWrofMCfEt+OmDAPf+r4/216dCfi77y5zgjNGY4uHfqUPf8wdicMSmc3oyqWq
         JotoXAWl8+5vAwIqt+G0VbYDCnfPuUgguQQz2TfEs5j0X0TZlpKHr2qO1mhUowiVCE0R
         5AelT5HQqcmzG9x0m26d1/pzIEJ2KGYjXfQaf7+YNXf8PaRUrNbQ5qIJ4TwRVhZmZWTt
         rAKAb71dAEDaVDovB0F7BXkwQ7sqRSb9ogVxMFzo4yCJZpviaJn3bWUyn6Ug25xg4w7x
         ULPw==
X-Gm-Message-State: AOAM530E5bZinMJRYwUEQxZW7gn89wRrNnk2oM3Fpu3whSjuxKHpDZcy
        9DdemVOoRVTRqYP6M02QOAYyR2UATEB5Y2Nc5Lg=
X-Google-Smtp-Source: ABdhPJzu3m1eXtRds2N8Wkj7O7RZca+TnGAJK6TV5yAvIieJjz+XHgHS6EnYFQwGKEV7kxcYWDczZ5hgEywOjRsF+kI=
X-Received: by 2002:a05:6830:1b7b:: with SMTP id d27mr1104937ote.132.1610489820430;
 Tue, 12 Jan 2021 14:17:00 -0800 (PST)
MIME-Version: 1.0
References: <20210111191926.3688443-1-lee.jones@linaro.org> <20210111191926.3688443-19-lee.jones@linaro.org>
In-Reply-To: <20210111191926.3688443-19-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 12 Jan 2021 17:16:47 -0500
Message-ID: <CADnq5_PxK4Fxg2As8nZZqYW3U=Ja0jBm7sB4g+YbZNf-VK41ug@mail.gmail.com>
Subject: Re: [PATCH 18/40] drm/amd/display/dc/dce112/Makefile: Ignore
 -Woverride-init warning
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
> This file uses a complex abstracted set of hierarchical macros to
> setup its applicable register lists within constant structures.
> However in the case of TMDS_CNTL we wish to mark it as not applicable
> for this use-case.
>
> One method would be to de-const all of the definitions and users, then
> manually zero out TMDS_CNTL from the list.  Another would be to create
> a new set of hierarchical macros to omit TMDS_CNTL entirely.  Both
> would entail a great deal of unnecessary changes and maintenance
> burden.
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:286:15=
: warning: initialized field overwritten [-Woverride-init]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:290:2:=
 note: in expansion of macro =E2=80=98stream_enc_regs=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:286:15=
: note: (near initialization for =E2=80=98stream_enc_regs[0].TMDS_CNTL=E2=
=80=99)
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:290:2:=
 note: in expansion of macro =E2=80=98stream_enc_regs=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:286:15=
: warning: initialized field overwritten [-Woverride-init]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:291:2:=
 note: in expansion of macro =E2=80=98stream_enc_regs=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:286:15=
: note: (near initialization for =E2=80=98stream_enc_regs[1].TMDS_CNTL=E2=
=80=99)
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:291:2:=
 note: in expansion of macro =E2=80=98stream_enc_regs=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:286:15=
: warning: initialized field overwritten [-Woverride-init]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:292:2:=
 note: in expansion of macro =E2=80=98stream_enc_regs=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:286:15=
: note: (near initialization for =E2=80=98stream_enc_regs[2].TMDS_CNTL=E2=
=80=99)
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:292:2:=
 note: in expansion of macro =E2=80=98stream_enc_regs=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:286:15=
: warning: initialized field overwritten [-Woverride-init]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:293:2:=
 note: in expansion of macro =E2=80=98stream_enc_regs=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:286:15=
: note: (near initialization for =E2=80=98stream_enc_regs[3].TMDS_CNTL=E2=
=80=99)
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:293:2:=
 note: in expansion of macro =E2=80=98stream_enc_regs=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:286:15=
: warning: initialized field overwritten [-Woverride-init]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:294:2:=
 note: in expansion of macro =E2=80=98stream_enc_regs=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:286:15=
: note: (near initialization for =E2=80=98stream_enc_regs[4].TMDS_CNTL=E2=
=80=99)
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:294:2:=
 note: in expansion of macro =E2=80=98stream_enc_regs=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:286:15=
: warning: initialized field overwritten [-Woverride-init]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:295:2:=
 note: in expansion of macro =E2=80=98stream_enc_regs=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:286:15=
: note: (near initialization for =E2=80=98stream_enc_regs[5].TMDS_CNTL=E2=
=80=99)
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:295:2:=
 note: in expansion of macro =E2=80=98stream_enc_regs=E2=80=99
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
>  drivers/gpu/drm/amd/display/dc/dce112/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce112/Makefile b/drivers/gpu=
/drm/amd/display/dc/dce112/Makefile
> index 8e090446d5119..9de6501702d2c 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce112/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dce112/Makefile
> @@ -23,6 +23,8 @@
>  # Makefile for the 'controller' sub-component of DAL.
>  # It provides the control and status of HW CRTC block.
>
> +CFLAGS_$(AMDDALPATH)/dc/dce112/dce112_resource.o =3D $(call cc-disable-w=
arning, override-init)
> +
>  DCE112 =3D dce112_compressor.o dce112_hw_sequencer.o \
>  dce112_resource.o
>
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
