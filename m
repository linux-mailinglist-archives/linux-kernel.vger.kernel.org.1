Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6422B9D36
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 22:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgKSVzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 16:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgKSVzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 16:55:15 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70B8C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 13:55:12 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id h21so8070589wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 13:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QPqvc1x5t7qLXCW8n18+RH8/nuMRFmIb+j6wkjvSoac=;
        b=Gwqz797TCkbOAVXSCqrZyYHhgCS7dzOjYtHH0GBsaR7yAMjfsqRYgOOflkXnGQoqak
         sQ9s5hKxA3pyQoNSOp12r4A+7s8b69QGMD3QIdbXngX7xoUK7N4c5E7NSiy6u8iaxP5H
         jIWTiAuptzNvlg/xBNvDmCANQYgytMNEnsMU1EDPZlYmBQ/9EDcOWj60bOZaKOIzZP/S
         ujjFP/4/RCnlt+H8abbC0kmLlmuagt9dLZFUklOFACs+21kZifVVdWqbNVyWng3YGFZH
         izvPt6qHxkhRnb6D0A8sL1LVc9B6G579wlb/QBQ8eTwx0Rk4frvNeRLCNqjV3jYNLSBF
         jw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QPqvc1x5t7qLXCW8n18+RH8/nuMRFmIb+j6wkjvSoac=;
        b=ApiVWWakdfqlxeHI9kVDuyMX5G765TWtU9hUS5ky6Ze/1cCabJ4OSZKZZ8m3mi+xr9
         sxIvi5CFQS3QDi2obrS03n5boIl2ovRdpg2wUlnAoFfOkdrEfhIi7Uv+5+YzKQV3UiEo
         YGoc6GFuH9cWtSLa6ZA3dnLhVfa2Ka0ACrDIyaEC3fbd6HpFfapc5r/GzuRI7WWLDP/E
         D/RhYLjEEVGe1HFt+U5JxSMDF2EBkQVUGzmqGB8BKeIP436bCchj88WA5rhSvkhJZt+A
         fmt0KUQRjgZj2/WZNJ+lD0z5OB/zIe/vzTHQx4t6TXtf3CQISM2rq8gctwDz9xKauKMx
         8UpA==
X-Gm-Message-State: AOAM532tOuPYOZtYGCWHiY1BOgVpspN4kmdwuu11mBOYp030j3KbWuyJ
        W3q386JDjKz0kuKkbFqzMmvujQgnKi9vplc71AY=
X-Google-Smtp-Source: ABdhPJwrarEP3o+nZ/cPmHQ+jbwoZm614gVVX5gD94S1cshyD2zw2A1NRL4NTTbfz8YAMyeIztWkhAVqGhHgLec1fR0=
X-Received: by 2002:a1c:f017:: with SMTP id a23mr6746684wmb.56.1605822911406;
 Thu, 19 Nov 2020 13:55:11 -0800 (PST)
MIME-Version: 1.0
References: <20201118024234.102485-1-bernard@vivo.com> <d61726de-c9a9-ee9c-cb8a-c34f0625a973@amd.com>
In-Reply-To: <d61726de-c9a9-ee9c-cb8a-c34f0625a973@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 19 Nov 2020 16:54:59 -0500
Message-ID: <CADnq5_M+seQ8Ui4p2uMKuGZ_9Y=jwmbSm1YiWxQV_=5PmEw9UA@mail.gmail.com>
Subject: Re: [PATCH] amdgpu/amdgpu_ids: fix kmalloc_array not uses number as
 first arg
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Bernard Zhao <bernard@vivo.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Wed, Nov 18, 2020 at 3:17 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 18.11.20 um 03:42 schrieb Bernard Zhao:
> > Fix check_patch.pl warning:
> > kmalloc_array uses number as first arg, sizeof is generally wrong.
> > +fences =3D kmalloc_array(sizeof(void *), id_mgr->num_ids,
> > GFP_KERNEL);
> >
> > Signed-off-by: Bernard Zhao <bernard@vivo.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ids.c
> > index 6e9a9e5dbea0..f2bd4b0e06f6 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> > @@ -208,7 +208,7 @@ static int amdgpu_vmid_grab_idle(struct amdgpu_vm *=
vm,
> >       if (ring->vmid_wait && !dma_fence_is_signaled(ring->vmid_wait))
> >               return amdgpu_sync_fence(sync, ring->vmid_wait);
> >
> > -     fences =3D kmalloc_array(sizeof(void *), id_mgr->num_ids, GFP_KER=
NEL);
> > +     fences =3D kmalloc_array(id_mgr->num_ids, sizeof(void *), GFP_KER=
NEL);
> >       if (!fences)
> >               return -ENOMEM;
> >
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
