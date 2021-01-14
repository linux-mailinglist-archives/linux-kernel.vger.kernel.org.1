Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F18B2F669E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbhANREA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbhANRD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:03:59 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B23C061574
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:03:19 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id s75so6621332oih.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+/j75diR2guucFzV679rMmTuRdnH7rcJNIuUAmVd6H0=;
        b=MZGOCDgqzL9LvaTVCiymRsVtNTV9oFe56mjzIyeKmdJgMHJiKkKLeuwnsldFTF9a3j
         wmJWS1a6Z1ghmj4N+3N3X8sv5BldyZOtsRVXDLXC6F3fliWwnFHG86YnsWQhvzYCJW2F
         gO9rPqrWzWwdRpf8tA9kV9Doa78xA0FT98R0S7m8CdteDZON05b15YlE1lnbUSKIoNtA
         ixVR99H1Px13JdSPSxBHl+HZ8WwDghzpGywQL5xp/QXpLV+qo0SWS2UpPQqNgO2wOlcP
         SUVKs/6kGqvwj7jQ6qUnsaAJshTPaYTplncFyGNafGhXw+MZQggMANPeLmyLNOCYjbxt
         lOOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+/j75diR2guucFzV679rMmTuRdnH7rcJNIuUAmVd6H0=;
        b=JBg4m+TBFCKKc1ML+0b1smEyjBPb0GI72/qyqUyS8LByJzEp+Q7z+YrnG7VudLkcup
         n/NJHlSRLjJfZO/596xur9sQsjvLSGIEhnmwAs6A8s0uD7KfPY26Ql9szRqgsaQZfFnF
         58i5Wr/+6HN4951s6av1gB4GEFqzCS8+dP/atumuIVAkAAD9EqkfecnROH69TwuSzWet
         D3cdIOno2HunZzgIWkDFvrDQ2T5Erb8Jh6vEAUd4/uh9Fv1cQdgTM5gsJaC12/uKkYLv
         Fk8XnQsjUwizzMU4GvLtmdnNcugfLgu/1HHSwWSgat4hhoWvk70Gg//6DIL+vrxZWlF/
         EcxQ==
X-Gm-Message-State: AOAM530WaEP/wJbLORiKQfrqtpunRgZuuyXvsJAwOk2WlhatrGdeOHyB
        NcvTElOe0Pp2CoNxWHUWd9lSfbq+XzDxRQ1G9Es=
X-Google-Smtp-Source: ABdhPJxpJ72MBLuQ53Q0axY/aqRfj9CUGz65ZAWYoFEPZMgXlRoKQbSsKAMqLL4jpPT5aW4fRk7oCCmGEuTPj7IPJbc=
X-Received: by 2002:aca:6202:: with SMTP id w2mr2972991oib.5.1610643799058;
 Thu, 14 Jan 2021 09:03:19 -0800 (PST)
MIME-Version: 1.0
References: <20210113080752.1003793-1-lee.jones@linaro.org> <20210113080752.1003793-3-lee.jones@linaro.org>
In-Reply-To: <20210113080752.1003793-3-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 14 Jan 2021 12:03:07 -0500
Message-ID: <CADnq5_M-FtSgp3NQhiDQTOrOMxhAo-L0WJFg779uC96cKGhuNw@mail.gmail.com>
Subject: Re: [PATCH 02/30] drm/amd/include/renoir_ip_offset: Mark top-level
 IP_BASE as __maybe_unused
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

On Wed, Jan 13, 2021 at 3:08 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:226:29: warning=
: =E2=80=98UVD0_BASE=E2=80=99 defined but not used [-Wunused-const-variable=
=3D]
>  drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:219:29: warning=
: =E2=80=98USB0_BASE=E2=80=99 defined but not used [-Wunused-const-variable=
=3D]
>  drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:212:29: warning=
: =E2=80=98UMC_BASE=E2=80=99 defined but not used [-Wunused-const-variable=
=3D]
>  drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:205:29: warning=
: =E2=80=98THM_BASE=E2=80=99 defined but not used [-Wunused-const-variable=
=3D]
>  drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:198:29: warning=
: =E2=80=98SMUIO_BASE=E2=80=99 defined but not used [-Wunused-const-variabl=
e=3D]
>  drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:191:29: warning=
: =E2=80=98SDMA0_BASE=E2=80=99 defined but not used [-Wunused-const-variabl=
e=3D]
>  drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:184:29: warning=
: =E2=80=98PCIE0_BASE=E2=80=99 defined but not used [-Wunused-const-variabl=
e=3D]
>  drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:177:29: warning=
: =E2=80=98OSSSYS_BASE=E2=80=99 defined but not used [-Wunused-const-variab=
le=3D]
>  drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:172:29: warning=
: =E2=80=98DCN_BASE=E2=80=99 defined but not used [-Wunused-const-variable=
=3D]
>  drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:165:29: warning=
: =E2=80=98NBIF0_BASE=E2=80=99 defined but not used [-Wunused-const-variabl=
e=3D]
>  drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:158:29: warning=
: =E2=80=98MP1_BASE=E2=80=99 defined but not used [-Wunused-const-variable=
=3D]
>  drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:151:29: warning=
: =E2=80=98MP0_BASE=E2=80=99 defined but not used [-Wunused-const-variable=
=3D]
>  drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:144:29: warning=
: =E2=80=98MMHUB_BASE=E2=80=99 defined but not used [-Wunused-const-variabl=
e=3D]
>  drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:137:29: warning=
: =E2=80=98L2IMU0_BASE=E2=80=99 defined but not used [-Wunused-const-variab=
le=3D]
>  drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:130:29: warning=
: =E2=80=98ISP_BASE=E2=80=99 defined but not used [-Wunused-const-variable=
=3D]
>  drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:123:29: warning=
: =E2=80=98IOHC0_BASE=E2=80=99 defined but not used [-Wunused-const-variabl=
e=3D]
>  drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:116:29: warning=
: =E2=80=98HDP_BASE=E2=80=99 defined but not used [-Wunused-const-variable=
=3D]
>  drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:109:29: warning=
: =E2=80=98HDA_BASE=E2=80=99 defined but not used [-Wunused-const-variable=
=3D]
>  drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:102:29: warning=
: =E2=80=98GC_BASE=E2=80=99 defined but not used [-Wunused-const-variable=
=3D]
>  drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:95:29: warning:=
 =E2=80=98FUSE_BASE=E2=80=99 defined but not used [-Wunused-const-variable=
=3D]
>  drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:88:29: warning:=
 =E2=80=98DPCS_BASE=E2=80=99 defined but not used [-Wunused-const-variable=
=3D]
>  drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:81:29: warning:=
 =E2=80=98DMU_BASE=E2=80=99 defined but not used [-Wunused-const-variable=
=3D]
>  drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:74:29: warning:=
 =E2=80=98DIO_BASE=E2=80=99 defined but not used [-Wunused-const-variable=
=3D]
>  drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:67:29: warning:=
 =E2=80=98DF_BASE=E2=80=99 defined but not used [-Wunused-const-variable=3D=
]
>  drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:60:29: warning:=
 =E2=80=98DBGU_IO0_BASE=E2=80=99 defined but not used [-Wunused-const-varia=
ble=3D]
>  drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:53:29: warning:=
 =E2=80=98CLK_BASE=E2=80=99 defined but not used [-Wunused-const-variable=
=3D]
>  drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:46:29: warning:=
 =E2=80=98ATHUB_BASE=E2=80=99 defined but not used [-Wunused-const-variable=
=3D]
>  drivers/gpu/drm/amd/amdgpu/../include/renoir_ip_offset.h:39:29: warning:=
 =E2=80=98ACP_BASE=E2=80=99 defined but not used [-Wunused-const-variable=
=3D]
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
>  drivers/gpu/drm/amd/include/renoir_ip_offset.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/include/renoir_ip_offset.h b/drivers/gpu=
/drm/amd/include/renoir_ip_offset.h
> index 07633e22e99a1..7dff85c81e5a7 100644
> --- a/drivers/gpu/drm/amd/include/renoir_ip_offset.h
> +++ b/drivers/gpu/drm/amd/include/renoir_ip_offset.h
> @@ -33,7 +33,7 @@ struct IP_BASE_INSTANCE
>  struct IP_BASE
>  {
>      struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
> -};
> +} __maybe_unused;
>
>
>  static const struct IP_BASE ACP_BASE =3D{ { { { 0x02403800, 0x00480000, =
0, 0, 0 } },
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
