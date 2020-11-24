Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9459A2C2C87
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 17:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390261AbgKXQPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 11:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389424AbgKXQPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 11:15:32 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21322C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 08:15:31 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id p22so2890500wmg.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 08:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NcGZEMoE8/OoazRbMXmgCCoABg8lK7yn+JEu89ArpnQ=;
        b=j93ka3XDSybeGE/pqWJYn2ugb5acGTe1U1xoLFPC3rS+FnLngGQ/CEdhDnhgXYkDYB
         ywPtr1zK89hhYJTSWiLxhqTtKnVjmycWxyxMn/+PD1zNxsCTBuYniOq8ObFSt+8av8Zy
         NsBOY6/hQStk/JA904y+gj4bVxZ9SnKiXk6I+x3LBHwieKqhS97HUGRD/f14srocrcVp
         hQD44Pt3ZsYUibWqgxNuslN+xiuChSOIqMFO+dx8AxGNNJ6Fc7jJjwbTWd8h08aB7Tf3
         IW6i51J7etgCp/XOGQ5jmHa2nASp7EkCzZvE7ACmQePc4lnrzN07casFyNrGJJM56u87
         o03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NcGZEMoE8/OoazRbMXmgCCoABg8lK7yn+JEu89ArpnQ=;
        b=Mju333uNt8ED8XzFla70+W+ZODN3nASSkOA9NXx07WOraTmPjxRmxH6PNEJcX/yha+
         ahuZWMmgZtx5H9xSm5gOqe5btG+VDutYwpfDbeThpki8SWS5AF48b9iaQfniCAIGm1Ck
         FHo00a4tWsNLv6jEUgyE68DsApucI4DzX/WPUt+E8jjun91yVU99GZiGZmHiAAegpekC
         sHuopM748DZ5vFRP19t0BgXWaF/BBOXN+9/JLDTmptMKbGLUnx77FaPoMjwtA1mMqPBW
         cSolOGExM8vCuOMzib0LNK8wXg2tzZgwJ7nI38Kx6HNORMsy2PDhIVIqSpUDnk6nAm3O
         zXdQ==
X-Gm-Message-State: AOAM530oAY38nHUq6m6zBJ86swhcgjTBhePeYwUVK+1n0wrJ3dPt5xrl
        /UDerglrWkWTKHZ6ErS7ao/M46TR1dIe1iJIJzA=
X-Google-Smtp-Source: ABdhPJwdaQ/TVaitOeF10AIFPfnBOC2nVg3yhW7E8XK9B1wAPPrx3uQi4eK71spnQFsMJKjFcCrifF9nuFQukBrEL7s=
X-Received: by 2002:a7b:c157:: with SMTP id z23mr5277089wmi.70.1606234529909;
 Tue, 24 Nov 2020 08:15:29 -0800 (PST)
MIME-Version: 1.0
References: <20201123111919.233376-1-lee.jones@linaro.org> <20201123111919.233376-29-lee.jones@linaro.org>
In-Reply-To: <20201123111919.233376-29-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 24 Nov 2020 11:15:18 -0500
Message-ID: <CADnq5_OH+qgkPK-W+Gw7WXEEGDY2RO0VYQZ4HWZB31ZAiWs8mQ@mail.gmail.com>
Subject: Re: [PATCH 28/40] drm/amd/include/sienna_cichlid_ip_offset: Mark
 top-level IP_BASE as __maybe_unused
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Likun Gao <Likun.Gao@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 6:20 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  In file included from drivers/gpu/drm/amd/amdgpu/sienna_cichlid_reg_init=
.c:28:
>  drivers/gpu/drm/amd/amdgpu/../include/sienna_cichlid_ip_offset.h:186:29:=
 warning: =E2=80=98USB0_BASE=E2=80=99 defined but not used [-Wunused-const-=
variable=3D]
>  186 | static const struct IP_BASE USB0_BASE =3D { { { { 0x0242A800, 0x05=
B00000, 0, 0, 0 } },
>  | ^~~~~~~~~
>  drivers/gpu/drm/amd/amdgpu/../include/sienna_cichlid_ip_offset.h:179:29:=
 warning: =E2=80=98UMC_BASE=E2=80=99 defined but not used [-Wunused-const-v=
ariable=3D]
>  179 | static const struct IP_BASE UMC_BASE =3D { { { { 0x00014000, 0x024=
25800, 0, 0, 0 } },
>  | ^~~~~~~~
>  drivers/gpu/drm/amd/amdgpu/../include/sienna_cichlid_ip_offset.h:158:29:=
 warning: =E2=80=98SDMA1_BASE=E2=80=99 defined but not used [-Wunused-const=
-variable=3D]
>  158 | static const struct IP_BASE SDMA1_BASE =3D { { { { 0x00001260, 0x0=
000A000, 0x0001C000, 0x02402C00, 0 } },
>  | ^~~~~~~~~~
>
> NB: Snipped lots of these
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Cc: Likun Gao <Likun.Gao@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/include/sienna_cichlid_ip_offset.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/include/sienna_cichlid_ip_offset.h b/dri=
vers/gpu/drm/amd/include/sienna_cichlid_ip_offset.h
> index 06800c6fa0495..b07bc2dd895dc 100644
> --- a/drivers/gpu/drm/amd/include/sienna_cichlid_ip_offset.h
> +++ b/drivers/gpu/drm/amd/include/sienna_cichlid_ip_offset.h
> @@ -33,7 +33,7 @@ struct IP_BASE_INSTANCE
>  struct IP_BASE
>  {
>      struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
> -};
> +} __maybe_unused;
>
>
>  static const struct IP_BASE ATHUB_BASE =3D { { { { 0x00000C00, 0x02408C0=
0, 0, 0, 0 } },
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
