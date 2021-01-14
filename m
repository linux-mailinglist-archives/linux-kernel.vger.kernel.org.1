Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47E9C2F669C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbhANRCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:02:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbhANRCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:02:49 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE20C061574
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:02:09 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id 15so6590049oix.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MDXD1cfaKjpnTdiyzujGkE6BL77maZcHvpSWDP0r0Sw=;
        b=UBTXrRvIShR7DHN41GepsBVsg73ac2CeJTJ3dGkf2PmB4N0seO5TuBbsBVtk3X4i5d
         lSvyD8fbtT9vOuSESwXNyEoz1of37dyGT/JDOG6raZhc/1ZjZK1hjAlqQvEtPHwV+pOk
         eAUda++7tjm+GPxvmP8OQ1cpPmTlZiQmWl8DnN3jSrP7EtyBJCjoXimzE5ujSFyqtUJa
         fYSofVo+XIasmfjhuZK443n6ETWm922+HmWRT3DU6SpaDibrHbybm2ay0qC3o1kIxddc
         jYGHtElVvB57rXxMQXDcbSfOLaYykyrVolPklyoiN3mhi73AvKPeg6vNRqk3psHSyOPv
         cqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MDXD1cfaKjpnTdiyzujGkE6BL77maZcHvpSWDP0r0Sw=;
        b=XAun+/1iMZxecdsE2gGayTe/WcIoKjDOTMD3OC22tUMpfzbPNNh7NfjqVHLkpwEjLw
         NVlYJ6Itn+l4ERkzWNdUAhG2JPQ0IvH8eBkxnZmOOA9VdJVs/bHnkTVLjtqI+KRjGQOk
         Jn+8QjmYwFuOFDdIjZK/cvgIkSQwXz0ckJLKdFrSffukaW5WHxUGSuClyYUyBjYveLLk
         3eBP0bbsKv4qS3ZNoT2nY4IpjqzfCScm6Ojpv8wNMX9b2IVoqBOiwjJf7bO8cSwhlAVy
         uPjdKr9QlaYhf5UYRF4V9k8ST0yIYy7s/bGdHPCpc+rTs+q1a/prghQnaKgWYI7hvkwA
         eIAw==
X-Gm-Message-State: AOAM5316s/s+806TF+hD+nWbRX2RQDY/lgZB/RhsuxVNtR5chM3mdIAH
        PzPx7QA7VMoiB04TvrRG4QmDBC95kNLQh6lRBoI=
X-Google-Smtp-Source: ABdhPJwIpHDSOSF7kEtQC/iojSc4V+wRjaZ6tvuatXz9KtQgqFlmrCz1RtxxZ3uIHOhyf34lZuB+sTvLax4c0pEFHxo=
X-Received: by 2002:aca:6202:: with SMTP id w2mr2968453oib.5.1610643729141;
 Thu, 14 Jan 2021 09:02:09 -0800 (PST)
MIME-Version: 1.0
References: <20210113080752.1003793-1-lee.jones@linaro.org> <20210113080752.1003793-2-lee.jones@linaro.org>
In-Reply-To: <20210113080752.1003793-2-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 14 Jan 2021 12:01:58 -0500
Message-ID: <CADnq5_OOvL4i1fJwTbufROF9RF7r7S5=tUvkkXf9ZeMqJYmteA@mail.gmail.com>
Subject: Re: [PATCH 01/30] drm/amd/display/dc/dc_helper: Include our own
 header, containing prototypes
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Noah Abradjian <noah.abradjian@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
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
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dc_helper.c:299:10: warning: no=
 previous prototype for =E2=80=98generic_reg_get=E2=80=99 [-Wmissing-protot=
ypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dc_helper.c:307:10: warning: no=
 previous prototype for =E2=80=98generic_reg_get2=E2=80=99 [-Wmissing-proto=
types]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dc_helper.c:317:10: warning: no=
 previous prototype for =E2=80=98generic_reg_get3=E2=80=99 [-Wmissing-proto=
types]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dc_helper.c:329:10: warning: no=
 previous prototype for =E2=80=98generic_reg_get4=E2=80=99 [-Wmissing-proto=
types]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dc_helper.c:343:10: warning: no=
 previous prototype for =E2=80=98generic_reg_get5=E2=80=99 [-Wmissing-proto=
types]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dc_helper.c:359:10: warning: no=
 previous prototype for =E2=80=98generic_reg_get6=E2=80=99 [-Wmissing-proto=
types]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dc_helper.c:377:10: warning: no=
 previous prototype for =E2=80=98generic_reg_get7=E2=80=99 [-Wmissing-proto=
types]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dc_helper.c:397:10: warning: no=
 previous prototype for =E2=80=98generic_reg_get8=E2=80=99 [-Wmissing-proto=
types]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dc_helper.c:503:6: warning: no =
previous prototype for =E2=80=98generic_write_indirect_reg=E2=80=99 [-Wmiss=
ing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dc_helper.c:511:10: warning: no=
 previous prototype for =E2=80=98generic_read_indirect_reg=E2=80=99 [-Wmiss=
ing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dc_helper.c:529:10: warning: no=
 previous prototype for =E2=80=98generic_indirect_reg_get=E2=80=99 [-Wmissi=
ng-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dc_helper.c:560:10: warning: no=
 previous prototype for =E2=80=98generic_indirect_reg_update_ex=E2=80=99 [-=
Wmissing-prototypes]
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Noah Abradjian <noah.abradjian@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dc_helper.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_helper.c b/drivers/gpu/drm=
/amd/display/dc/dc_helper.c
> index 57edb25fc3812..a612ba6dc3898 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_helper.c
> +++ b/drivers/gpu/drm/amd/display/dc/dc_helper.c
> @@ -34,6 +34,7 @@
>
>  #include "dc.h"
>  #include "dc_dmub_srv.h"
> +#include "reg_helper.h"
>
>  static inline void submit_dmub_read_modify_write(
>         struct dc_reg_helper_state *offload,
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
