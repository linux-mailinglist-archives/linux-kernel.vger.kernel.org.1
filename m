Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 219662F3F62
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438175AbhALWP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 17:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403924AbhALWN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:13:58 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D409C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:13:18 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id j12so3861371ota.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2rlldwJer3sr2AnmP99UBbkreO3bRQYA52H6Sx5kmiQ=;
        b=IyYfQtmGxqdwLuMw2jLptl7CZpr7L69oOQEeG0T1MRClpcYEGo4XkG8Z86Vxi8Tba9
         6A6BuP+5rXqtahnJpxjHcwlYXslQPmBrPOWyOg2oH9bt6JDygS7LMMP8LUAtFEIMMeBU
         8ewVNWLaVVpDOe5uTcqfI8llnZovv++pdUe/7kaQvt/zHWxFXaGX8/TVCn051Ko/9wF0
         yCRXU4OYF7tCfJKY6vGQrKqTXZbMGiXiyZsdPqq43b7cd3ipLgMN6OFknANxC9UrnMMR
         yXVQnFKMgJsMjk/Srd2Z4yTD5a6HPCrVW9UFqgq1RsEbf/chzCdEtgB40M2lJxq1ECVr
         4cFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2rlldwJer3sr2AnmP99UBbkreO3bRQYA52H6Sx5kmiQ=;
        b=gIJbX0keBFiLlFNLniwFScS8zSlUjv8A1u6CLmWPLVM8OaOaK+jOsgb9n1PfqWysC9
         oRdhjghkopiblOKBYW+m7D0Pjm9SFmeSfTHNa2N8QSqNWUXxhK/hPuDZz0JjL/WS/+IN
         ySP+g3TMuXpVV3W3X2rsB4O9jQKMHlN/8nlq1Ej7Bp9lKrZ520fCtb11E3pQBmfOhVo2
         Gdj7kZptyjuXWmpIS8c/dyWD7RaU+50RyvzCCnY53axBlDZyHlTh0NdNfdUHQDyKLFKN
         +T68Zmdr8L2nSsqtIhzb4EGLq02X400CH2jr5B0wzZjgz3PxeABw5yMtcDetUX8Sm1yh
         Zs6Q==
X-Gm-Message-State: AOAM530/nQJz3Cf2pgbXq/dIukykANnfs9zY/3SC67KJKx3ord788WY1
        4ErFU8o9ZNQAhc8yManUX03Ly0CfSMIXoLg5LfbSaJ7n
X-Google-Smtp-Source: ABdhPJxwfq2AxQIrtSkizdx8vM1pySI4RPQBKMgb6X6OWJ2O+MeEEmN6azW2gwZoxFByGqvNbOtEHgev/eUuuAvpuT4=
X-Received: by 2002:a05:6830:1b7b:: with SMTP id d27mr1096229ote.132.1610489597818;
 Tue, 12 Jan 2021 14:13:17 -0800 (PST)
MIME-Version: 1.0
References: <20210111191926.3688443-1-lee.jones@linaro.org> <20210111191926.3688443-13-lee.jones@linaro.org>
In-Reply-To: <20210111191926.3688443-13-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 12 Jan 2021 17:13:04 -0500
Message-ID: <CADnq5_M27hzKp0tOqqNq-RHhRo_0KdjGt8V0dP7EdMKFidgvFA@mail.gmail.com>
Subject: Re: [PATCH 12/40] drm/amd/display/dc/dce120/Makefile: Ignore
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
> Instead, let's just silence the warning.
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:277:15=
: warning: initialized field overwritten [-Woverride-init]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:281:2:=
 note: in expansion of macro =E2=80=98stream_enc_regs=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:277:15=
: note: (near initialization for =E2=80=98stream_enc_regs[0].TMDS_CNTL=E2=
=80=99)
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:281:2:=
 note: in expansion of macro =E2=80=98stream_enc_regs=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:277:15=
: warning: initialized field overwritten [-Woverride-init]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:282:2:=
 note: in expansion of macro =E2=80=98stream_enc_regs=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:277:15=
: note: (near initialization for =E2=80=98stream_enc_regs[1].TMDS_CNTL=E2=
=80=99)
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:282:2:=
 note: in expansion of macro =E2=80=98stream_enc_regs=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:277:15=
: warning: initialized field overwritten [-Woverride-init]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:283:2:=
 note: in expansion of macro =E2=80=98stream_enc_regs=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:277:15=
: note: (near initialization for =E2=80=98stream_enc_regs[2].TMDS_CNTL=E2=
=80=99)
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:283:2:=
 note: in expansion of macro =E2=80=98stream_enc_regs=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:277:15=
: warning: initialized field overwritten [-Woverride-init]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:284:2:=
 note: in expansion of macro =E2=80=98stream_enc_regs=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:277:15=
: note: (near initialization for =E2=80=98stream_enc_regs[3].TMDS_CNTL=E2=
=80=99)
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:284:2:=
 note: in expansion of macro =E2=80=98stream_enc_regs=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:277:15=
: warning: initialized field overwritten [-Woverride-init]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:285:2:=
 note: in expansion of macro =E2=80=98stream_enc_regs=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:277:15=
: note: (near initialization for =E2=80=98stream_enc_regs[4].TMDS_CNTL=E2=
=80=99)
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:285:2:=
 note: in expansion of macro =E2=80=98stream_enc_regs=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:277:15=
: warning: initialized field overwritten [-Woverride-init]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:286:2:=
 note: in expansion of macro =E2=80=98stream_enc_regs=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:277:15=
: note: (near initialization for =E2=80=98stream_enc_regs[5].TMDS_CNTL=E2=
=80=99)
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:286:2:=
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
>  drivers/gpu/drm/amd/display/dc/dce120/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce120/Makefile b/drivers/gpu=
/drm/amd/display/dc/dce120/Makefile
> index 37db1f8d45ea5..a9cc4b73270bb 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce120/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dce120/Makefile
> @@ -24,6 +24,8 @@
>  # It provides the control and status of HW CRTC block.
>
>
> +CFLAGS_$(AMDDALPATH)/dc/dce120/dce120_resource.o =3D $(call cc-disable-w=
arning, override-init)
> +
>  DCE120 =3D dce120_resource.o dce120_timing_generator.o \
>  dce120_hw_sequencer.o
>
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
