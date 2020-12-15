Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 523A12DB026
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 16:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729711AbgLOPdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 10:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbgLOPdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 10:33:10 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152CDC0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 07:32:30 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id q25so19716835otn.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 07:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dADoVhqZ0eCrNITD6Bvm1WHmMhRoEzX00n0WLxxa+1A=;
        b=StNk1QX+59BaR9NU1KLVnbD+R0duRWch7KJbgEIPL0LvM0MhdEdRUhw87Lwho4ar+S
         FCVLedLhYdoovSSuEXd6Ydp/d94Ncoey9GcPNmtroBhboL5BlTnmzc1qJKXQO33pyjZM
         P4ZaZ8NPYHookNTyomMZceud0uNGM2PtRXFySsYJVFMcLNyrQVbCmiCE7qq6HWZjn5Ha
         byQu24RWi2rUSXntiSEhqqdfhArQlsKCCS2VWJOJ4h5bIgq68LuCW4JO7a8ztRw5HSQN
         eBhvcQunaLwlKBwyvYJSVqRjVCfo51DhYHMwUleJvvvq9BM/XwAKs5/7rmZiw7Yu42oJ
         jBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dADoVhqZ0eCrNITD6Bvm1WHmMhRoEzX00n0WLxxa+1A=;
        b=oouPc5VzoamPC7j4ft7cA+ePdb+zIM8gElmoffKdQAHtpsqY7DeZ+UqX/5UHN/DwHS
         EZwgktwCTOjLetW+qYHCxQ34+HC0UZANQ/Y6f7eMoSH8dxkWfbMYs4+sbdp64jpFmJPx
         wVAgSnAJndinP4YPTG3MYEijI/JWePRnC85hnmZR9O1E6mFNrMqoXTdAUBrfJk6lkUlc
         MiHtvu5Rs+KTocV6hlZc2R74y8bW6Vy0H8yhBcIMoo3taWxFiZdnqLNpzcaFsBJErTQP
         zO6hzNouiOg/0FpMZSJLj6I+epk4c7iysREpXBh0+NVVsNR75cCWBwmU73c2JA8vUx9D
         b7Tw==
X-Gm-Message-State: AOAM533XmgiL0FvEFgsqVZd3buk9pELf/7fYqTtQavjuvlcNrBLUqTt0
        xxnzFzoqbvCEL/LmDtC6ePEZk5AZiVyA9qLXZlo=
X-Google-Smtp-Source: ABdhPJxDcMlqAHodJuJGqT32WemSVlNuVx+JRv7QS1U33+pBYGExCvbNXwfAfRe12U42dwT7HoKZLL2jhOIiYvbp1xQ=
X-Received: by 2002:a9d:5388:: with SMTP id w8mr23678895otg.311.1608046349451;
 Tue, 15 Dec 2020 07:32:29 -0800 (PST)
MIME-Version: 1.0
References: <20201215143835.1874487-1-trix@redhat.com> <e71eb9ef-d5f9-0829-670f-d5c2c644a493@amd.com>
 <a741836e-7f33-dcbb-d2bd-603091b9a2ad@redhat.com> <6be8d340-248d-3853-8799-4327b76c63ab@amd.com>
In-Reply-To: <6be8d340-248d-3853-8799-4327b76c63ab@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 15 Dec 2020 10:32:18 -0500
Message-ID: <CADnq5_MYTWLFAa0OHihY+ZgA0b0m=uhFk1tf+ir7w5RVmOB=2w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: remove h from printk format specifier
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Tom Rix <trix@redhat.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lee Jones <lee.jones@linaro.org>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        Nirmoy Das <nirmoy.das@amd.com>,
        Sonny Jiang <sonny.jiang@amd.com>,
        xinhui pan <xinhui.pan@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        James Zhu <James.Zhu@amd.com>, Leo Liu <leo.liu@amd.com>,
        Thong Thai <thong.thai@amd.com>,
        Veerabadhran G <vegopala@amd.com>,
        Boyuan Zhang <boyuan.zhang@amd.com>,
        "monk.liu" <Monk.Liu@amd.com>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 10:11 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 15.12.20 um 16:06 schrieb Tom Rix:
> > On 12/15/20 6:47 AM, Christian K=C3=B6nig wrote:
> >> Am 15.12.20 um 15:38 schrieb trix@redhat.com:
> >>> From: Tom Rix <trix@redhat.com>
> >>>
> >>> See Documentation/core-api/printk-formats.rst.
> >>> h should no longer be used in the format specifier for printk.
> >> In general looks valid to me, but my question is how does that work?
> >>
> >> I mean we specify h here because it is a short int. Are ints always 32=
bit on the stack?
> > The type of the argument is promoted to int.  This was discussed earlie=
r here
> >
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e.kernel.org%2Flkml%2Fa68114afb134b8633905f5a25ae7c4e6799ce8f1.camel%40perc=
hes.com%2F&amp;data=3D04%7C01%7Cchristian.koenig%40amd.com%7C0dd6fe7c17304d=
4ea72a08d8a10af765%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63743641577=
2411133%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI=
6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3Dta8M5iN%2Bj2J6tio%2FMuUi2lG%2Biy=
EhkdsFfpXcEjGKNwE%3D&amp;reserved=3D0
>
> Thanks, I expected this but just wanted to double check.
>
> In this case this patch as well as the radeon one are Reviewed-by:
> Christian K=C3=B6nig <christian.koenig@amd.com>.
>

Applied this and the radeon one.  Thanks!

Alex

> Regards,
> Christian.
>
> >
> > Tom
> >
> >> Thanks,
> >> Christian.
> >>
> >>> Signed-off-by: Tom Rix <trix@redhat.com>
> >>> ---
> >>>    drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 4 ++--
> >>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 2 +-
> >>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 4 ++--
> >>>    3 files changed, 5 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_uvd.c
> >>> index 7c5b60e53482..8b989670ed66 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> >>> @@ -240,7 +240,7 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev=
)
> >>>              version_major =3D (le32_to_cpu(hdr->ucode_version) >> 24=
) & 0xff;
> >>>            version_minor =3D (le32_to_cpu(hdr->ucode_version) >> 8) &=
 0xff;
> >>> -        DRM_INFO("Found UVD firmware Version: %hu.%hu Family ID: %hu=
\n",
> >>> +        DRM_INFO("Found UVD firmware Version: %u.%u Family ID: %u\n"=
,
> >>>                version_major, version_minor, family_id);
> >>>              /*
> >>> @@ -267,7 +267,7 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev=
)
> >>>            dec_minor =3D (le32_to_cpu(hdr->ucode_version) >> 8) & 0xf=
f;
> >>>            enc_minor =3D (le32_to_cpu(hdr->ucode_version) >> 24) & 0x=
3f;
> >>>            enc_major =3D (le32_to_cpu(hdr->ucode_version) >> 30) & 0x=
3;
> >>> -        DRM_INFO("Found UVD firmware ENC: %hu.%hu DEC: .%hu Family I=
D: %hu\n",
> >>> +        DRM_INFO("Found UVD firmware ENC: %u.%u DEC: .%u Family ID: =
%u\n",
> >>>                enc_major, enc_minor, dec_minor, family_id);
> >>>              adev->uvd.max_handles =3D AMDGPU_MAX_UVD_HANDLES;
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_vce.c
> >>> index 4861f8ddc1b5..ea6a62f67e38 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> >>> @@ -179,7 +179,7 @@ int amdgpu_vce_sw_init(struct amdgpu_device *adev=
, unsigned long size)
> >>>        version_major =3D (ucode_version >> 20) & 0xfff;
> >>>        version_minor =3D (ucode_version >> 8) & 0xfff;
> >>>        binary_id =3D ucode_version & 0xff;
> >>> -    DRM_INFO("Found VCE firmware Version: %hhd.%hhd Binary ID: %hhd\=
n",
> >>> +    DRM_INFO("Found VCE firmware Version: %d.%d Binary ID: %d\n",
> >>>            version_major, version_minor, binary_id);
> >>>        adev->vce.fw_version =3D ((version_major << 24) | (version_min=
or << 16) |
> >>>                    (binary_id << 8));
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_vcn.c
> >>> index 1e756186e3f8..99b82f3c2617 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> >>> @@ -181,7 +181,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev=
)
> >>>            enc_major =3D fw_check;
> >>>            dec_ver =3D (le32_to_cpu(hdr->ucode_version) >> 24) & 0xf;
> >>>            vep =3D (le32_to_cpu(hdr->ucode_version) >> 28) & 0xf;
> >>> -        DRM_INFO("Found VCN firmware Version ENC: %hu.%hu DEC: %hu V=
EP: %hu Revision: %hu\n",
> >>> +        DRM_INFO("Found VCN firmware Version ENC: %u.%u DEC: %u VEP:=
 %u Revision: %u\n",
> >>>                enc_major, enc_minor, dec_ver, vep, fw_rev);
> >>>        } else {
> >>>            unsigned int version_major, version_minor, family_id;
> >>> @@ -189,7 +189,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev=
)
> >>>            family_id =3D le32_to_cpu(hdr->ucode_version) & 0xff;
> >>>            version_major =3D (le32_to_cpu(hdr->ucode_version) >> 24) =
& 0xff;
> >>>            version_minor =3D (le32_to_cpu(hdr->ucode_version) >> 8) &=
 0xff;
> >>> -        DRM_INFO("Found VCN firmware Version: %hu.%hu Family ID: %hu=
\n",
> >>> +        DRM_INFO("Found VCN firmware Version: %u.%u Family ID: %u\n"=
,
> >>>                version_major, version_minor, family_id);
> >>>        }
> >>>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
