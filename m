Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2DB230374C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 08:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732627AbhAZHXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 02:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730297AbhAYPpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 10:45:06 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FC2C06178A;
        Mon, 25 Jan 2021 07:07:11 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id d7so5278014otf.3;
        Mon, 25 Jan 2021 07:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o+tF4kaBNHVUeLz+neiR9EKFSH0RfBoOkuSe1R44I6w=;
        b=Hwq67MQmYVPMYCZWKjORrY407ayyGMAmuweF5bGKJREWfqd/R8Ho/W3mHhkxOLOlGX
         1O5S4cg5i+y1RKR41/AMivqX7Z3HDLSHKPOOyjXA25qfSm/GSGnJbe4YAyrky3nLLOrC
         eNd1d1HRJBKjJqbAXfaYM/8knALrtXO6suGrMIxnJ0XORv6p41Dksgh4wOQ1pFXC3gyR
         4TPE9WNGXbowkiHp05fB9CNkTuEiXcnoLwLaQkNFcA5hNSbndfXnmiCMpy9AE5nk1TOI
         23FkgL6bSWXk5vvS+HbTxZzShPWFwMwt8cFrZeL20/fiaBcB9Fkj+3qG0+KAH+TS1jSU
         5JlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o+tF4kaBNHVUeLz+neiR9EKFSH0RfBoOkuSe1R44I6w=;
        b=d3/LOTdU5OCwfRbXRTY+mZKr3URxQvdYS6W2+KANLPFtqwPcnPqjCrqwLGFgZND3Kg
         UDUikLvl/SI3cyugZ8hKT530GvwQj9cfLHh2kzT8xvp/b8sEy0k08j6qThxvcI6lkq18
         I9DT1YBPUq1KYflaoQLTpt/dsg+BPmhIuHNXxmTlOpM8BtaYGzua4IrLbmmUq0zOcnWP
         sGhi4sBdA9wp1g8WKMnwDqkw6Y8/p+BSAU625UPpmVdmEIDQqB+WmP3gbaWjO8dVOqG7
         n16IR4vvoZAmWLHXH1vZ8lYbQNA7NeBAAa742wqINf8vXCKAmf6H8Ijh+9cHnvq1cu+o
         jM9A==
X-Gm-Message-State: AOAM531tXeOO/xJ2vf+my+wrKE+wvfsDnziP4lh9J/IVybbaObSttE0X
        +DOL3nDWus8XzZpoQpBRI7iOeYNo4YZKUjV5pK8=
X-Google-Smtp-Source: ABdhPJzLpiv5vCtKZgABLpe2a/nPpQqwY8M2+LbN3ZUR6u0pvsBbsKxXgCt2lRyPmJ3UDvMbTjbKzB9PzckuZRUW6tQ=
X-Received: by 2002:a9d:784a:: with SMTP id c10mr796878otm.132.1611587230413;
 Mon, 25 Jan 2021 07:07:10 -0800 (PST)
MIME-Version: 1.0
References: <20210122150022.209454-1-colin.king@canonical.com> <20210125043623.GD610615@hr-amd>
In-Reply-To: <20210125043623.GD610615@hr-amd>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 25 Jan 2021 10:06:58 -0500
Message-ID: <CADnq5_PgXRv5LKO=yhx6NnYE4Et_PHa45JArAjorJ6W-GiDG2A@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amdgpu: Fix masking binary not operator on two
 mask operations
To:     Huang Rui <ray.huang@amd.com>
Cc:     Colin King <colin.king@canonical.com>,
        David Airlie <airlied@linux.ie>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "Liu, Aaron" <Aaron.Liu@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Sun, Jan 24, 2021 at 11:36 PM Huang Rui <ray.huang@amd.com> wrote:
>
> On Fri, Jan 22, 2021 at 11:00:22PM +0800, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > Currently the ! operator is incorrectly being used to flip bits on
> > mask values. Fix this by using the bit-wise ~ operator instead.
> >
> > Addresses-Coverity: ("Logical vs. bitwise operator")
> > Fixes: 3c9a7b7d6e75 ("drm/amdgpu: update mmhub mgcg&ls for mmhub_v2_3")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
>
> Thanks.
>
> Reviewed-by: Huang Rui <ray.huang@amd.com>
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
> > index 1961745e89c7..ab9be5ad5a5f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
> > @@ -531,12 +531,12 @@ mmhub_v2_3_update_medium_grain_light_sleep(struct amdgpu_device *adev,
> >
> >       if (enable && (adev->cg_flags & AMD_CG_SUPPORT_MC_LS)) {
> >               data &= ~MM_ATC_L2_CGTT_CLK_CTRL__MGLS_OVERRIDE_MASK;
> > -             data1 &= !(DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_MASK |
> > +             data1 &= ~(DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_MASK |
> >                       DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_WRITE_MASK |
> >                       DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_READ_MASK |
> >                       DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_RETURN_MASK |
> >                       DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_REGISTER_MASK);
> > -             data2 &= !(DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_MASK |
> > +             data2 &= ~(DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_MASK |
> >                       DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_WRITE_MASK |
> >                       DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_READ_MASK |
> >                       DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_RETURN_MASK |
> > --
> > 2.29.2
> >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
