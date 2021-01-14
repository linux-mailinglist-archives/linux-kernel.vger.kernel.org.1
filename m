Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440522F676F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbhANRVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbhANRVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:21:52 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DBAC061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:21:11 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id f132so6626822oib.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0potRu9mijL2B6HQx5jkNelrrnJJVWm3UpHe2HZ0UkI=;
        b=dkkmdGU5SlZ0ua3SCcGU3Bpw8R1lwPTH0z7h9tR3dKOXN5O2GusOiBM8f7ZQX8w/DX
         V8qYgr75uDn1fomgq80iLg9hjx7GVbiFxxR5Y+/o5ojzkgqHwSV/4YOnG135poq9Heft
         WXcD7NkHAxhXI2TO7+bQ7DO+HcyZ1LbcTzChM2XREx65/QW2ZIsMjQOyiuBrYPiIBNjV
         OxRs8w7Sr3gxgXxSGLg5+lXEf4pYnG/QXxtUItf2sfst4lyZD8DtrEHXJcge6Ltp18Bw
         kQG7G2AEaYQatprXSeT2LxELLyL07gKUZjo22q2J+QWpLfXCIybbK4dkGu1YgPQs/q6n
         7C5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0potRu9mijL2B6HQx5jkNelrrnJJVWm3UpHe2HZ0UkI=;
        b=RJgfPMkCAjmyxqt1Z5yqbtGavDNKLEOcLCXCezkZmpDPzRyUxxyjxpQtx7aJyNEx1Q
         rsLYzy0Chkj0Ik/axfXGLRJyQOBFIGib7ZNHiiJ44IgOLe8zayaVcSaCQjkMheB+hZM2
         +bR041la2n5Mu78rTe6/3XnCMGymPLlXE5M0V0qkb5rdYlW62H0Fxw1+MYGM9SpFuFae
         RUCD0u89CrJAlS3tO3wROGPjckM+0Lj/SQkKkeq/x79+YgZesqDExohpdZEP5h81TPHW
         CtLFSBoo5PjkCjhzJBzb7zyiKZod9GVjlD0ZbDePSL85FieOTCudy0GA92cxvi777Tre
         5LFg==
X-Gm-Message-State: AOAM5338Zy4z4PQjzVQ3weNue3ZiXdev666ndoYn+zdbXEUGZRTsMGA+
        SYXV0k0RJ0Emkz7oDvYLJ3b+r2uZe3QeafAhpXI=
X-Google-Smtp-Source: ABdhPJyn7PJvDDprZivb8ih1mYMbCzJxKFwXet2VyRvoQcNfjsbey8uwLYLhfIp0+R/GxGXpS0WipFfH3Bo27FZudg8=
X-Received: by 2002:a54:4083:: with SMTP id i3mr3148051oii.120.1610644871430;
 Thu, 14 Jan 2021 09:21:11 -0800 (PST)
MIME-Version: 1.0
References: <20210113080752.1003793-1-lee.jones@linaro.org> <20210113080752.1003793-20-lee.jones@linaro.org>
In-Reply-To: <20210113080752.1003793-20-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 14 Jan 2021 12:21:00 -0500
Message-ID: <CADnq5_O5mSkD0badwkm0ZsTnOBaoUd0grM7zwuKRX98U3zW8+Q@mail.gmail.com>
Subject: Re: [PATCH 19/30] drm/amd/display/dc/core/dc_link_dp: Mark
 'result_write_min_hblank' as __maybe_unused
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
> It looks like it could be used inside the DC_TRACE_LEVEL_MESSAGE() macro.
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c: In function =
=E2=80=98dpcd_set_source_specific_data=E2=80=99:
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:4403:18: warn=
ing: variable =E2=80=98result_write_min_hblank=E2=80=99 set but not used [-=
Wunused-but-set-variable]
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
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/g=
pu/drm/amd/display/dc/core/dc_link_dp.c
> index 3c33b8fe218e5..b9e5e0eee3d24 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -4400,7 +4400,7 @@ void dp_set_fec_enable(struct dc_link *link, bool e=
nable)
>  void dpcd_set_source_specific_data(struct dc_link *link)
>  {
>         if (!link->dc->vendor_signature.is_valid) {
> -               enum dc_status result_write_min_hblank =3D DC_NOT_SUPPORT=
ED;
> +               enum dc_status __maybe_unused result_write_min_hblank =3D=
 DC_NOT_SUPPORTED;
>                 struct dpcd_amd_signature amd_signature;
>                 amd_signature.AMD_IEEE_TxSignature_byte1 =3D 0x0;
>                 amd_signature.AMD_IEEE_TxSignature_byte2 =3D 0x0;
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
