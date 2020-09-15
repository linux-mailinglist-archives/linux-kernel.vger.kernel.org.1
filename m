Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7E2D26AD9B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 21:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbgIOT3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 15:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbgIOT3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 15:29:11 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657EFC061788
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 12:29:10 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o5so4446314wrn.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 12:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WNOfew7cieK0fIPLf+MgiYy15Qujw2hwL5Iyu+qX2xE=;
        b=ohIxN49DAtGodQKEvkH4w5EPA9qaRJCt40swRQWxkKBIH88SL2NiKg9Rkf+SzBnXum
         lbwoLOchshoLLVuj/uAxwWx5oPPjMuLlA9109ML1HwWD2mX1Tp1ri6h1INF0fFX9VlOJ
         d/GsTLZC97ULuqqanrTeAHEjN0FGguNndIdLqiP54DHqJPsWAuXyLuc5/cbPUF8Hm9Wy
         2rpCh6l9A4560fyFoRSa0Tvl0aMlPq3brU6PrQpl2cZqF99ydsKO+QHuABkBXxJ6xbdl
         EsUNJv7OaFIrRFGSEjhlRbCMp5w6JnmVQ5RxcY0SWg/pjOLDSgksRQQ2/64+eWdnlb+p
         nW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WNOfew7cieK0fIPLf+MgiYy15Qujw2hwL5Iyu+qX2xE=;
        b=LGbNUizR8hIka6YwvrkutsR+VJQyjD4WbPUszk0GmdPb9oBuEWi+t8Cg04emUGbQXW
         IJS+a/He5E5QQjJ6lknuOti0XOvXvnJOSooHjZh6NpRbALX9wxqJ63Ptoe9RGL1MNeyU
         lIba9vCPl7seT/etthXDCNHkazf0+Ythuouk54e36zMkVDLskokL+N0uoKablPKwoNJ2
         h/Wli14XdHEWLVv747uXvOeOD13bBjBqHSPHaMLcdj7GNJ9aNIHJ/Nw3uFOOTCVFETWe
         dKmddgHkUUQAVg4MdNMxMUzxwXJHaBojJ4kldhFpsORdl89Nx/mEgfvbOQ0/M/Y1BnND
         T4zw==
X-Gm-Message-State: AOAM532R0LjKWQcD9qdgZWM/P2Np+WFwESHmPjnU/TuJ/qTBDM3aC4ub
        mLcn9Dst49RIDX5q9vyaBPqBYi2o/65X9v+cNuc=
X-Google-Smtp-Source: ABdhPJwuQ0az1NkHLajypW7vFoAnyGiloF+XVUfUJYGPW+n9xw4FDqRbB7+px/Or23gTyNjs6vYN7wMcMcZ6+jqqP9A=
X-Received: by 2002:a5d:6886:: with SMTP id h6mr23815361wru.374.1600198149147;
 Tue, 15 Sep 2020 12:29:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200910023345.20428-1-yuehaibing@huawei.com> <1226ea65-a957-baa2-e9c7-fe88b1aae620@amd.com>
In-Reply-To: <1226ea65-a957-baa2-e9c7-fe88b1aae620@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 15 Sep 2020 15:28:58 -0400
Message-ID: <CADnq5_NFKaOmx5s2DA1fkaTpYXPnFwkeUP=rtgF9yij64KJ6yA@mail.gmail.com>
Subject: Re: [PATCH -next] drm/ttm/agp: Fix Wunused-variable warning
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function no longer exists.

Alex

On Thu, Sep 10, 2020 at 4:56 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 10.09.20 um 04:33 schrieb YueHaibing:
> > If CONFIG_AGP is not set, gcc warns:
> >
> > drivers/gpu/drm/radeon/radeon_ttm.c: In function =E2=80=98radeon_ttm_tt=
_bind=E2=80=99:
> > drivers/gpu/drm/radeon/radeon_ttm.c:692:24: warning: unused variable =
=E2=80=98rdev=E2=80=99 [-Wunused-variable]
> >    struct radeon_device *rdev =3D radeon_get_rdev(bdev);
> >                          ^~~~
> >
> > Move it to ifdef block to fix this.
> >
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >   drivers/gpu/drm/radeon/radeon_ttm.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/rade=
on/radeon_ttm.c
> > index 31c63d339629..449e77eb75f9 100644
> > --- a/drivers/gpu/drm/radeon/radeon_ttm.c
> > +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
> > @@ -689,9 +689,9 @@ static int radeon_ttm_tt_bind(struct ttm_bo_device =
*bdev,
> >                             struct ttm_tt *ttm,
> >                             struct ttm_resource *bo_mem)
> >   {
> > +#if IS_ENABLED(CONFIG_AGP)
> >       struct radeon_device *rdev =3D radeon_get_rdev(bdev);
> >
> > -#if IS_ENABLED(CONFIG_AGP)
> >       if (rdev->flags & RADEON_IS_AGP)
> >               return ttm_agp_bind(ttm, bo_mem);
> >   #endif
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
