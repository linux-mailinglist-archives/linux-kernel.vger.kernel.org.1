Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 568012B9D3B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 22:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgKSV45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 16:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgKSV45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 16:56:57 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA27C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 13:56:57 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id c198so6679399wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 13:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tlLqDfAGYn0nYJ3DEoNWqwPsD3d58ZqJLDR3pX/h9LI=;
        b=aaONIso3P58VTJcyH558RGTSNI8DcgOx+J+A4s+NsJxRzoFR5feZMV3ZWp0qIxpL0Z
         SnP7g8Y3Fa/4igzONjn9VWSr8z244bjeVmZm1h9eMQb1Vo2nuTBZAsPOHvIi1bDeHEao
         iOWoCxnktaHRJYe67u94PIVWQkPIwA3/9B371y0tL7klgLfXBVdhUp4uKGxBLbMv54Dt
         n8GP1hegfYAd8ZN+z+tEjM/2VBuVL2mVuo96SMmmVElSmF7kKQutudcyiaB4cuSuazPX
         aq5RszqzGvaQO9rCOeo1PX+6BldMXzB4kxK29h2PYX7Vxhc0N6K0k2RzCLjLh03dVJ/m
         KTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tlLqDfAGYn0nYJ3DEoNWqwPsD3d58ZqJLDR3pX/h9LI=;
        b=aCqjhbnLQE0J877kPATvleM/MwUQWmwXHn/S4OsKffrDzt5xF4MZGpC1aXbGbQZzhp
         A5w0dKOElS8Ve6Lo/uSHXjYo226pRa7uJecaeEnNvQljAGbngzrgE8eONUUT6iNMecli
         E+J0vo7SNmHUowsQdS8LrpBhzzycjJg+XcbRVYr15G9ZviwBZSNRYj/lsAUQW3fohGzD
         Xgzh3luSVDPQApCf83t0PP5/l6DxMFWIKfy5dtPnPPWi4qYcEzcqEY1rshNXCwYuxFzz
         FLhxxhwUQSFT0ePM/V+RS009pBTs3atrg4KyrY7TB8YGylMXbjhbakiTi4Vy5fYktvnH
         mtkg==
X-Gm-Message-State: AOAM530RyjsuC/7vr4WTq2xjuPdMG+js3vvXj4RsoSUl1P2ycwzOSO2N
        99ZqGg7YhV4EHZY9ujdl4YdfkcRQWhYh0B444WU=
X-Google-Smtp-Source: ABdhPJya3DMRrcLHYiVQoTxYnrTiQXBAipjqux6cCTZEqPK09Qn227q+Dj18bKYo0PkLYXRUw/qYtfdSNm1UpJS1EWY=
X-Received: by 2002:a1c:1c3:: with SMTP id 186mr6576990wmb.39.1605823015772;
 Thu, 19 Nov 2020 13:56:55 -0800 (PST)
MIME-Version: 1.0
References: <20201118025503.102699-1-bernard@vivo.com> <f55ec782-9eff-c30b-2a0e-01a9898c9387@amd.com>
In-Reply-To: <f55ec782-9eff-c30b-2a0e-01a9898c9387@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 19 Nov 2020 16:56:44 -0500
Message-ID: <CADnq5_Pnv7+vu-mV3C5-zKXFexzs=qX6Jne6DKx-LteP_VQn-Q@mail.gmail.com>
Subject: Re: [PATCH] amd/amdgpu: use kmalloc_array to replace kmalloc with multiply
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Bernard Zhao <bernard@vivo.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Monk Liu <Monk.Liu@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Yintian Tao <yttao@amd.com>, Dennis Li <Dennis.Li@amd.com>,
        Wenhui Sheng <Wenhui.Sheng@amd.com>,
        chen gong <curry.gong@amd.com>,
        Bokun Zhang <Bokun.Zhang@amd.com>,
        "Stanley.Yang" <Stanley.Yang@amd.com>,
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

On Wed, Nov 18, 2020 at 3:18 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 18.11.20 um 03:55 schrieb Bernard Zhao:
> > Fix check_patch.pl warning:
> > WARNING: Prefer kmalloc_array over kmalloc with multiply
> > +bps =3D kmalloc(align_space * sizeof((*data)->bps), GFP_KERNEL);
> > WARNING: Prefer kmalloc_array over kmalloc with multiply
> > +bps_bo =3D kmalloc(align_space * sizeof((*data)->bps_bo),
> > GFP_KERNEL);
> > kmalloc_array has multiply overflow check, which will be safer.
> >
> > Signed-off-by: Bernard Zhao <bernard@vivo.com>
>
> Not userspace controllable values, but looks cleaner anyway.
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_virt.c
> > index d0aea5e39531..f2a0851c804f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > @@ -280,8 +280,8 @@ static int amdgpu_virt_init_ras_err_handler_data(st=
ruct amdgpu_device *adev)
> >       if (!*data)
> >               return -ENOMEM;
> >
> > -     bps =3D kmalloc(align_space * sizeof((*data)->bps), GFP_KERNEL);
> > -     bps_bo =3D kmalloc(align_space * sizeof((*data)->bps_bo), GFP_KER=
NEL);
> > +     bps =3D kmalloc_array(align_space, sizeof((*data)->bps), GFP_KERN=
EL);
> > +     bps_bo =3D kmalloc_array(align_space, sizeof((*data)->bps_bo), GF=
P_KERNEL);
> >
> >       if (!bps || !bps_bo) {
> >               kfree(bps);
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
