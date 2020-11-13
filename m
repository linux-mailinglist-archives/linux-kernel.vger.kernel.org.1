Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA542B2289
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 18:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgKMRdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 12:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgKMRdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 12:33:37 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9F3C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:33:36 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id c9so8916364wml.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qGs9VC8jOc6afFqkpCh7JskFElPU1yEcg3k0a+lEsmg=;
        b=UXILF3Rrw2fNCJSw4Q9k0nglz6ze+BmvrGVJAJdCAeholmg6VIaK2FIYdlIyQ4i3N7
         1692Sq9NOfnAAJgsQN0w+Jd7XhYUWAWOUS+Dc4+EQqbmLn7V+pkWFOILiLYOfScke8Dl
         FxGQGVj/OvolRqUvJVPSIoPFYabXxDlBdoCpgStdGFEfuPz1tmT1EBa9lZn4YBQ833TH
         yrPGOR56luScchaUwetL5PMDzjj5NcWQjLtgiosBzJ68+4d54LtahFY2Qr0QTZEFyb30
         69MyTeEUgH4xa8LXBDAsZqW9sEmKkc6SfiTnByU8UewlhlLvHZxly9zwDi1yDPJFXgJj
         k1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qGs9VC8jOc6afFqkpCh7JskFElPU1yEcg3k0a+lEsmg=;
        b=VuKoJcRpnikR7LEdwy3hiusQxJ/nntzs84nvxyzRdhlEzb573Sf0DbkkJ93JRwUHjj
         DD1zfJZRlMJVaiOj5KrNQ2T/a22D2I+RDg53lxEjqmekrOWRMnQxk1Y93Wx2YOIjRV5a
         nPR6RI2PMbMAkO/CxvvwHQOilkvYz6l0CO1OGWH0m9V9k+RRKtv52t6dWOthPmOahd65
         AMMC3T+ucIV0czVLbifiKkKtSHMWRsrdjnEfsGqVekZoLye84hscbTEAez23Dlj7ngAp
         kGgAinnIbKl0cIrn22tQjs+UItkBk17JcMswzjcCHNIE2jS3XVRbKp+dKyGK43nNNWND
         u2Ww==
X-Gm-Message-State: AOAM533cuo8IQuS26qXe2AqKxReOpU/cP5GPUa/0CIUS4iX9MxpEUSZy
        4oYQhxfzi80p0yPPUQ+LbOFFeNPHFeJpzeD0DvM=
X-Google-Smtp-Source: ABdhPJzoOoTIHWvDnQYCLoi4+uXFnYAFsq8cLgkJySJ4m/H0YKbo1MkqvVMZjFBNtCwJySIiGevwMiZPHvEa8RdnQbA=
X-Received: by 2002:a1c:6302:: with SMTP id x2mr3652886wmb.56.1605288810795;
 Fri, 13 Nov 2020 09:33:30 -0800 (PST)
MIME-Version: 1.0
References: <20201113134938.4004947-1-lee.jones@linaro.org> <20201113134938.4004947-37-lee.jones@linaro.org>
In-Reply-To: <20201113134938.4004947-37-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 13 Nov 2020 12:33:19 -0500
Message-ID: <CADnq5_OTbwrqno6qsmjH9sFbo0PDoWcXW9uAqPQK+3Tj0q07ow@mail.gmail.com>
Subject: Re: [PATCH 36/40] drm/amd/amdgpu/amdgpu_fw_attestation: Consume our
 own header containing prototypes
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        John Clements <john.clements@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 8:51 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c:130:6: warning: no pr=
evious prototype for =E2=80=98amdgpu_fw_attestation_debugfs_init=E2=80=99 [=
-Wmissing-prototypes]
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Cc: John Clements <john.clements@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c
> index c6947d6c7ff51..e47bca1c76359 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c
> @@ -26,6 +26,7 @@
>  #include <linux/dma-mapping.h>
>
>  #include "amdgpu.h"
> +#include "amdgpu_fw_attestation.h"
>  #include "amdgpu_psp.h"
>  #include "amdgpu_ucode.h"
>  #include "soc15_common.h"
> @@ -139,4 +140,4 @@ void amdgpu_fw_attestation_debugfs_init(struct amdgpu=
_device *adev)
>                             adev,
>                             &amdgpu_fw_attestation_debugfs_ops);
>  #endif
> -}
> \ No newline at end of file
> +}
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
