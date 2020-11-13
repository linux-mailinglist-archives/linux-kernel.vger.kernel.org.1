Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44EF72B1E68
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 16:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgKMPQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 10:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgKMPQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 10:16:23 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADC9C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 07:16:23 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id l1so10277975wrb.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 07:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hBxlPAsmTTqlA4KgKc0Qe3iHm/Z7KbubIg6iBufbAdA=;
        b=Bd6+w3W8PksWdkg+yv1tcwmkh1XP8bxXGT3o+/1H+smyEle7ad6jagjnm151eAALRB
         hsojGauLKfFHM03dpJ0bsykrs/BnMXq2FdWBmSIZPd5J/SiGYchtcTEPTYJehzNXUPhR
         U+M4EVirLk+hNdP5n8zGCOFHOmQQWCg0eayT+4K/Erm/8A8QhR/NnzGO6hPIhV6aqZtl
         QP1xV5TC46lmfsdi4N2AZ5hStTPICyvmWCcW3f//SHsJhHH099WKq94YbXo5Vko8nQ6m
         aURh917aKUlrgHwDY0dOvMYaneyOgl8oNjSjgZnrZ+msz6gZqZZJqoXWzQZHrSTHecje
         3QQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hBxlPAsmTTqlA4KgKc0Qe3iHm/Z7KbubIg6iBufbAdA=;
        b=oXRF3yj9fMsUSDC2cOxZYYUQcXjetP3eK/LSOkdlUT4Gt4CWoAZBI/NuAcTE82LZ1Q
         dPNWj9r3QUeJ7UDlLJpwpxQRS7bsTh28JJPL8R6dJ20ZpvtBmd7MOTzsgQjBKyCDsjLh
         SdMA9OGGWtxLxkQA1u/qVi6j8AAX/xYQSgOFIhbZXsx9+9LTygUXQtt0yM4xMj98t9sZ
         cVDrzEGDh84eUZyhKLhixTCR71jR+y5S18Bbi6arQQJmNnARPlFf3ayVe0F4dr9ArB2s
         j+g27GUndnWJsOAzf1W97BVTgFkqih4ERlW+nD8lFgsL8WudrGberhUgbJDNPBNkPqHQ
         SROA==
X-Gm-Message-State: AOAM532IUNrsjp0mmnmJNBHZri1ozQa0/I957ojFz3+I3YiehYx9BVQh
        OZsX67BgH7ddv0AcVn2s5ZO3kRTLfwIOJPdBcpc=
X-Google-Smtp-Source: ABdhPJwpnWmJupwR6w+ld9cPh/YOPpYbXd1MMfrRWkh2itV6K8wFT3RVKZwWfZRJmHhKz2pLhXXo5uwBLBxUvsnXv8Q=
X-Received: by 2002:adf:8028:: with SMTP id 37mr3990354wrk.111.1605280580945;
 Fri, 13 Nov 2020 07:16:20 -0800 (PST)
MIME-Version: 1.0
References: <20201113134938.4004947-1-lee.jones@linaro.org> <20201113134938.4004947-2-lee.jones@linaro.org>
In-Reply-To: <20201113134938.4004947-2-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 13 Nov 2020 10:16:09 -0500
Message-ID: <CADnq5_NHYgJ6rxFEOTwKFiJtneRPiPU-gKNBK+dNbTE8V8eYOA@mail.gmail.com>
Subject: Re: [PATCH 01/40] drm/amd/include/vega10_ip_offset: Mark _BASE
 structs as __maybe_unused
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 8:49 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> This patch fixes nearly 400 warnings!
>
> These structures are too widely used in too many varying
> configurations to be split-up into different headers or moved into
> source files.
>
> Instead, we'll mark them as __maybe_unused which tells the compiler
> that we're aware they're being included into source files which do not
> make use of them - but we've looked into it, and it's okay.
>
> Let's tidy-up whilst were here.  Just alignment stuff.
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  In file included from drivers/gpu/drm/amd/amdgpu/navi14_reg_init.c:27:
>  drivers/gpu/drm/amd/amdgpu/../include/navi14_ip_offset.h:179:29: warning=
: =E2=80=98USB0_BASE=E2=80=99 defined but not used [-Wunused-const-variable=
=3D]
>  179 | static const struct IP_BASE USB0_BASE =3D{ { { { 0x0242A800, 0x05B=
00000, 0, 0, 0 } },
>  | ^~~~~~~~~
>  drivers/gpu/drm/amd/amdgpu/../include/navi14_ip_offset.h:172:29: warning=
: =E2=80=98UMC_BASE=E2=80=99 defined but not used [-Wunused-const-variable=
=3D]
>  172 | static const struct IP_BASE UMC_BASE =3D{ { { { 0x00014000, 0x0242=
5800, 0, 0, 0 } },
>  | ^~~~~~~~
>  drivers/gpu/drm/amd/amdgpu/../include/navi14_ip_offset.h:151:29: warning=
: =E2=80=98SDMA_BASE=E2=80=99 defined but not used [-Wunused-const-variable=
=3D]
>  151 | static const struct IP_BASE SDMA_BASE =3D{ { { { 0x00001260, 0x000=
0A000, 0x02402C00, 0, 0 } },
>  | ^~~~~~~~~
>  drivers/gpu/drm/amd/amdgpu/../include/navi14_ip_offset.h:144:29: warning=
: =E2=80=98PCIE0_BASE=E2=80=99 defined but not used [-Wunused-const-variabl=
e=3D]
>  144 | static const struct IP_BASE PCIE0_BASE =3D{ { { { 0x00000000, 0x00=
000014, 0x00000D20, 0x00010400, 0x0241B000 } },
>  | ^~~~~~~~~~
>
> NB: Snipped for brevity
>
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
>  .../gpu/drm/amd/include/vega10_ip_offset.h    | 76 +++++++++----------
>  1 file changed, 38 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/include/vega10_ip_offset.h b/drivers/gpu=
/drm/amd/include/vega10_ip_offset.h
> index 976dd2d565ba4..bb5463152f6b0 100644
> --- a/drivers/gpu/drm/amd/include/vega10_ip_offset.h
> +++ b/drivers/gpu/drm/amd/include/vega10_ip_offset.h
> @@ -35,177 +35,177 @@ struct IP_BASE
>  };
>
>
> -static const struct IP_BASE NBIF_BASE                  =3D { { { { 0x000=
00000, 0x00000014, 0x00000D20, 0x00010400, 0 } },
> +static const struct IP_BASE __maybe_unused NBIF_BASE   =3D { { { { 0x000=
00000, 0x00000014, 0x00000D20, 0x00010400, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } } } };
> -static const struct IP_BASE NBIO_BASE                  =3D { { { { 0x000=
00000, 0x00000014, 0x00000D20, 0x00010400, 0 } },
> +static const struct IP_BASE __maybe_unused NBIO_BASE   =3D { { { { 0x000=
00000, 0x00000014, 0x00000D20, 0x00010400, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } } } };
> -static const struct IP_BASE DCE_BASE                   =3D { { { { 0x000=
00012, 0x000000C0, 0x000034C0, 0, 0 } },
> +static const struct IP_BASE __maybe_unused DCE_BASE    =3D { { { { 0x000=
00012, 0x000000C0, 0x000034C0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } } } };
> -static const struct IP_BASE DCN_BASE                   =3D { { { { 0x000=
00012, 0x000000C0, 0x000034C0, 0, 0 } },
> +static const struct IP_BASE __maybe_unused DCN_BASE    =3D { { { { 0x000=
00012, 0x000000C0, 0x000034C0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } } } };
> -static const struct IP_BASE MP0_BASE                   =3D { { { { 0x000=
16000, 0, 0, 0, 0 } },
> +static const struct IP_BASE __maybe_unused MP0_BASE    =3D { { { { 0x000=
16000, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } } } };
> -static const struct IP_BASE MP1_BASE                   =3D { { { { 0x000=
16000, 0, 0, 0, 0 } },
> +static const struct IP_BASE __maybe_unused MP1_BASE    =3D { { { { 0x000=
16000, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } } } };
> -static const struct IP_BASE MP2_BASE                   =3D { { { { 0x000=
16000, 0, 0, 0, 0 } },
> +static const struct IP_BASE __maybe_unused MP2_BASE    =3D { { { { 0x000=
16000, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } } } };
> -static const struct IP_BASE DF_BASE                    =3D { { { { 0x000=
07000, 0, 0, 0, 0 } },
> +static const struct IP_BASE __maybe_unused DF_BASE     =3D { { { { 0x000=
07000, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } } } };
> -static const struct IP_BASE UVD_BASE                   =3D { { { { 0x000=
07800, 0x00007E00, 0, 0, 0 } },
> +static const struct IP_BASE __maybe_unused UVD_BASE    =3D { { { { 0x000=
07800, 0x00007E00, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } } } };  //note: GLN does not use the first segme=
nt
> -static const struct IP_BASE VCN_BASE                   =3D { { { { 0x000=
07800, 0x00007E00, 0, 0, 0 } },
> +static const struct IP_BASE __maybe_unused VCN_BASE    =3D { { { { 0x000=
07800, 0x00007E00, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } } } };  //note: GLN does not use the first segme=
nt
> -static const struct IP_BASE DBGU_BASE                  =3D { { { { 0x000=
00180, 0x000001A0, 0, 0, 0 } },
> +static const struct IP_BASE __maybe_unused DBGU_BASE   =3D { { { { 0x000=
00180, 0x000001A0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } } } }; // not exist
> -static const struct IP_BASE DBGU_NBIO_BASE             =3D { { { { 0x000=
001C0, 0, 0, 0, 0 } },
> +static const struct IP_BASE __maybe_unused DBGU_NBIO_BASE      =3D { { {=
 { 0x000001C0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } } } }; // not exist
> -static const struct IP_BASE DBGU_IO_BASE               =3D { { { { 0x000=
001E0, 0, 0, 0, 0 } },
> +static const struct IP_BASE __maybe_unused DBGU_IO_BASE        =3D { { {=
 { 0x000001E0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } } } }; // not exist
> -static const struct IP_BASE DFX_DAP_BASE               =3D { { { { 0x000=
005A0, 0, 0, 0, 0 } },
> +static const struct IP_BASE __maybe_unused DFX_DAP_BASE        =3D { { {=
 { 0x000005A0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } } } }; // not exist
> -static const struct IP_BASE DFX_BASE                   =3D { { { { 0x000=
00580, 0, 0, 0, 0 } },
> +static const struct IP_BASE __maybe_unused DFX_BASE    =3D { { { { 0x000=
00580, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } } } }; // this file does not contain registers
> -static const struct IP_BASE ISP_BASE                   =3D { { { { 0x000=
18000, 0, 0, 0, 0 } },
> +static const struct IP_BASE __maybe_unused ISP_BASE    =3D { { { { 0x000=
18000, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } } } }; // not exist
> -static const struct IP_BASE SYSTEMHUB_BASE             =3D { { { { 0x000=
00EA0, 0, 0, 0, 0 } },
> +static const struct IP_BASE __maybe_unused SYSTEMHUB_BASE      =3D { { {=
 { 0x00000EA0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } } } }; // not exist
> -static const struct IP_BASE L2IMU_BASE                 =3D { { { { 0x000=
07DC0, 0, 0, 0, 0 } },
> +static const struct IP_BASE __maybe_unused L2IMU_BASE  =3D { { { { 0x000=
07DC0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } } } };
> -static const struct IP_BASE IOHC_BASE                  =3D { { { { 0x000=
10000, 0, 0, 0, 0 } },
> +static const struct IP_BASE __maybe_unused IOHC_BASE   =3D { { { { 0x000=
10000, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } } } };
> -static const struct IP_BASE ATHUB_BASE                 =3D { { { { 0x000=
00C20, 0, 0, 0, 0 } },
> +static const struct IP_BASE __maybe_unused ATHUB_BASE  =3D { { { { 0x000=
00C20, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } } } };
> -static const struct IP_BASE VCE_BASE                   =3D { { { { 0x000=
07E00, 0x00048800, 0, 0, 0 } },
> +static const struct IP_BASE __maybe_unused VCE_BASE    =3D { { { { 0x000=
07E00, 0x00048800, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } } } };
> -static const struct IP_BASE GC_BASE                    =3D { { { { 0x000=
02000, 0x0000A000, 0, 0, 0 } },
> +static const struct IP_BASE __maybe_unused GC_BASE     =3D { { { { 0x000=
02000, 0x0000A000, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } } } };
> -static const struct IP_BASE MMHUB_BASE                 =3D { { { { 0x000=
1A000, 0, 0, 0, 0 } },
> +static const struct IP_BASE __maybe_unused MMHUB_BASE  =3D { { { { 0x000=
1A000, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } } } };
> -static const struct IP_BASE RSMU_BASE                  =3D { { { { 0x000=
12000, 0, 0, 0, 0 } },
> +static const struct IP_BASE __maybe_unused RSMU_BASE   =3D { { { { 0x000=
12000, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } } } };
> -static const struct IP_BASE HDP_BASE                   =3D { { { { 0x000=
00F20, 0, 0, 0, 0 } },
> +static const struct IP_BASE __maybe_unused HDP_BASE    =3D { { { { 0x000=
00F20, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } } } };
> -static const struct IP_BASE OSSSYS_BASE                =3D { { { { 0x000=
010A0, 0, 0, 0, 0 } },
> +static const struct IP_BASE __maybe_unused OSSSYS_BASE  =3D { { { { 0x00=
0010A0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } } } };
> -static const struct IP_BASE SDMA0_BASE                 =3D { { { { 0x000=
01260, 0, 0, 0, 0 } },
> +static const struct IP_BASE __maybe_unused SDMA0_BASE  =3D { { { { 0x000=
01260, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } } } };
> -static const struct IP_BASE SDMA1_BASE                 =3D { { { { 0x000=
01460, 0, 0, 0, 0 } },
> +static const struct IP_BASE __maybe_unused SDMA1_BASE  =3D { { { { 0x000=
01460, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } } } };
> -static const struct IP_BASE XDMA_BASE                  =3D { { { { 0x000=
03400, 0, 0, 0, 0 } },
> +static const struct IP_BASE __maybe_unused XDMA_BASE   =3D { { { { 0x000=
03400, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } } } };
> -static const struct IP_BASE UMC_BASE                   =3D { { { { 0x000=
14000, 0, 0, 0, 0 } },
> +static const struct IP_BASE __maybe_unused UMC_BASE    =3D { { { { 0x000=
14000, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } } } };
> -static const struct IP_BASE THM_BASE                   =3D { { { { 0x000=
16600, 0, 0, 0, 0 } },
> +static const struct IP_BASE __maybe_unused THM_BASE    =3D { { { { 0x000=
16600, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } } } };
> -static const struct IP_BASE SMUIO_BASE                 =3D { { { { 0x000=
16800, 0, 0, 0, 0 } },
> +static const struct IP_BASE __maybe_unused SMUIO_BASE  =3D { { { { 0x000=
16800, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } } } };
> -static const struct IP_BASE PWR_BASE                   =3D { { { { 0x000=
16A00, 0, 0, 0, 0 } },
> +static const struct IP_BASE __maybe_unused PWR_BASE    =3D { { { { 0x000=
16A00, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } } } };
> -static const struct IP_BASE CLK_BASE                   =3D { { { { 0x000=
16C00, 0, 0, 0, 0 } },
> -                                                                        =
   { { 0x00016E00, 0, 0, 0, 0 } },
> +static const struct IP_BASE __maybe_unused CLK_BASE    =3D { { { { 0x000=
16C00, 0, 0, 0, 0 } },
> +                                                                        =
       { { 0x00016E00, 0, 0, 0, 0 } },
>                                                                          =
       { { 0x00017000, 0, 0, 0, 0 } },
> -                                           { { 0x00017200, 0, 0, 0, 0 } =
},
> -                                                               { { 0x000=
17E00, 0, 0, 0, 0 } } } };
> -static const struct IP_BASE FUSE_BASE                  =3D { { { { 0x000=
17400, 0, 0, 0, 0 } },
> +                                                                        =
       { { 0x00017200, 0, 0, 0, 0 } },
> +                                                                        =
       { { 0x00017E00, 0, 0, 0, 0 } } } };
> +static const struct IP_BASE __maybe_unused FUSE_BASE   =3D { { { { 0x000=
17400, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
>                                                                          =
       { { 0, 0, 0, 0, 0 } },
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
