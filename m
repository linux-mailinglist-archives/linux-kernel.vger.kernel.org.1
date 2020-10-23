Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144CF29776A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 20:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752881AbgJWS7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 14:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751579AbgJWS7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 14:59:52 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3ECC0613CE;
        Fri, 23 Oct 2020 11:59:52 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id c16so3047809wmd.2;
        Fri, 23 Oct 2020 11:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kGkqH9RayqCwaKSb4jbmhvrrm7waUI/efA+P4m3EI/A=;
        b=Ai18QAkff99+Y1ZJzQMpA+Anvykc4ZYymMK2J/s5hjPl95FQW84WHFcY8Upll/PB0L
         FQORIO2+5xX2NKYt2s1o+sKJQxJD7ao1TfE30g5VIycE/MBx7tKIa9NvGXwdPxoKWTdU
         FyEz1t2qMYWGqhRNsuiY0e1gTacfBeLmibK6J530Ekg/2QASZhhlNqPg7vXKEi8OtUFS
         /9QSvfrntzRcajetWfOn1RaJKMsqs4uWKzMj3KlBYjCLSFWk60pjLbSJSr059e5ooKMk
         rNgxaWJvUXLA1H7viV3qKcNvpBFKPMLEmunu7piPFWxjz8CQF8eeu89+nPAElW78Hs4y
         RFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kGkqH9RayqCwaKSb4jbmhvrrm7waUI/efA+P4m3EI/A=;
        b=ke47jgQpkG6wO+S7aa1ocF0dNme67ABTW8ybLcOU8njN6OlVR+ihrAF9Jvx/u5cdsA
         RHefmYyrCVvKQ3mTcj0L3WNf+VtuOBcJg5jKWAdbJlZpsPjt7cYcxmorDs2bXoaH60Sv
         npHcUAktyaayY9Uss9Sp/ssnnGDMaQ+S5NWCJsAFOxcC1P/PikS5aAgvL+OQKaXI/SYZ
         kgIGugEltylsUd8sp+MD5NqxHz4mvi3FcU7ej91maCg6aPOLawvXxZbj6Vmu2Ykyj7nu
         ZplC1G6S1Gj0/+BK5J2fh/MBXGiOxs3+5ZVcpQ3tljGIaIawRtfyz0pCsh0iva1ZPjyN
         TyrQ==
X-Gm-Message-State: AOAM5317DZUwa2rzdXXQTXmAgBIDDk26gFnFPW8LWQzzTLiDWgMFzD0Z
        +pMzNOMe0nUJUBFoqhqNysgQ6wQQku83olxVYp0=
X-Google-Smtp-Source: ABdhPJzzbJD6wGGAD04pOulswiRx+ZOpFnJUnflRMa3fKNUhFj/+eewn0SpJHTIqxm9mtAGa6ZtfL2QZ/+5H8dUC/5w=
X-Received: by 2002:a1c:e4c1:: with SMTP id b184mr3024912wmh.73.1603479591132;
 Fri, 23 Oct 2020 11:59:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
 <ffc1f2d59fd5005f365eb5d178a2d890112bb6bb.1603469755.git.mchehab+huawei@kernel.org>
 <5e7a3500-a84a-1dfb-0841-bb624eba30c8@amd.com>
In-Reply-To: <5e7a3500-a84a-1dfb-0841-bb624eba30c8@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 23 Oct 2020 14:59:38 -0400
Message-ID: <CADnq5_MK3YTpQB2qo5ms4E+tkB-So7vXdgj=-=OYO5yQTRaaRA@mail.gmail.com>
Subject: Re: [PATCH v3 11/56] drm/amdgpu: fix some kernel-doc markups
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Alex Sierra <alex.sierra@amd.com>,
        Jonathan Kim <jonathan.kim@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Airlie <airlied@linux.ie>,
        Bernard Zhao <bernard@vivo.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        xinhui pan <xinhui.pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Jacob He <jacob.he@amd.com>, Nirmoy Das <nirmoy.das@amd.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Ben Skeggs <bskeggs@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Dave Airlie <airlied@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Fri, Oct 23, 2020 at 12:51 PM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 23.10.20 um 18:32 schrieb Mauro Carvalho Chehab:
> > Some functions have different names between their prototypes
> > and the kernel-doc markup.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c       | 2 +-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 2 +-
> >   include/uapi/drm/amdgpu_drm.h                | 2 +-
> >   3 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.c
> > index df110afa97bf..a5f73a267fe5 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -2166,7 +2166,7 @@ struct amdgpu_bo_va *amdgpu_vm_bo_add(struct amdg=
pu_device *adev,
> >
> >
> >   /**
> > - * amdgpu_vm_bo_insert_mapping - insert a new mapping
> > + * amdgpu_vm_bo_insert_map - insert a new mapping
> >    *
> >    * @adev: amdgpu_device pointer
> >    * @bo_va: bo_va to store the address
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_vram_mgr.c
> > index 0c6b7c5ecfec..795bad307497 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> > @@ -528,7 +528,7 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device =
*adev,
> >   }
> >
> >   /**
> > - * amdgpu_vram_mgr_alloc_sgt - allocate and fill a sg table
> > + * amdgpu_vram_mgr_free_sgt - allocate and fill a sg table
> >    *
> >    * @adev: amdgpu device pointer
> >    * @sgt: sg table to free
> > diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_dr=
m.h
> > index c5ff2b275fcd..791a1d597d2a 100644
> > --- a/include/uapi/drm/amdgpu_drm.h
> > +++ b/include/uapi/drm/amdgpu_drm.h
> > @@ -667,7 +667,7 @@ struct drm_amdgpu_cs_chunk_data {
> >       };
> >   };
> >
> > -/**
> > +/*
> >    *  Query h/w info: Flag that this is integrated (a.h.a. fusion) GPU
> >    *
> >    */
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
