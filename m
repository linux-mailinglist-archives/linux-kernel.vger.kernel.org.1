Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9740126AD5E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 21:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgIOTT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 15:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbgIOTQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 15:16:49 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3E3C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 12:16:44 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j2so4472201wrx.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 12:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IJulLnUZRloj+JIxnR5PX7+lFtVvSPhO7Tu13HJYnvU=;
        b=fRCUJhJt4m5HTraGhNUTJq3D90tnnrpN/PFDlbV4+tqbEBKiBKEcP6Wl7NuWpLfE5M
         Wy77VehzVtlPVhgkjxS57wgsV0Fl9kcpWzMhJLPMm8yt4x/SFcj78pifD+1ne1/HlayR
         E/uLIFoGcyP8kNjtgo8sgZx2BkyTMvj2SiPxd8XnUymK9oag9D9eKx8Yx8PoKbZY/G3U
         Ui0Wsego+cv3uxjgYrSG0oD4aD1QN8QTrSHyCjgWCfdTvVcMp8tFDEp+pIvkRpAjQjBY
         A92iiwd6syDAXMtPxPicKDD9M04/061zWRAj612iPa0dDZ4RdrYbzH3F3KOoFqfjUgRD
         qpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IJulLnUZRloj+JIxnR5PX7+lFtVvSPhO7Tu13HJYnvU=;
        b=mmrvHIriiOwSzU4/WnG2ZJEtadiHLIqikvfy0tscY/QsBj4NZOOk7KJS7mPQh4vDmZ
         BbPSj9BoRd9LDVTVyhuA34egl67czTXg+4sCvpXAdfhYRUEsOYRkQbSWM+5A5sCq7cbS
         0YSy5kMi6SyV7ds1Ss7VMZy3yya+aPiP3d/LQfDdOuHjzie+E8MSIwj05C+p30qyfu2c
         tzryVn1R7gGf9BH606iffoNE+FT6wvsX5zvChsYPEmdcxyp0zry7AH75kLnWg4C+JwsC
         hx5dwpj/VjohG5LUQU2/az8pd8xaq8croPpZU3rp9+l5L+xHcJ+z8mnWfKuFiexpOft3
         XsBw==
X-Gm-Message-State: AOAM5317QkZWMMz0KYWXnjIOqXUVU4M/OZdJ1gLWKO3Z1p7Kr8+7pKWh
        JVcYNe21DUvWLt0tEEUZhxpZ9wy+O4ccuNSMuAM=
X-Google-Smtp-Source: ABdhPJyQUomgfLA7nRAd4EOSN4Oha3W9IbfJZwzhpRCnFkv6aM3OBZwCVVf3XV3dExbRxr/jNo1Fu1yMwERJL2QyiKQ=
X-Received: by 2002:adf:fc0a:: with SMTP id i10mr22548014wrr.111.1600197403261;
 Tue, 15 Sep 2020 12:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200909130720.105234-1-zhengbin13@huawei.com> <1fce0f2a-3777-e6d8-5a09-30261f843cfd@amd.com>
In-Reply-To: <1fce0f2a-3777-e6d8-5a09-30261f843cfd@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 15 Sep 2020 15:16:32 -0400
Message-ID: <CADnq5_NoeFbBAMT6s_ictVXsUc2tx1U48MLxnMbAr2Sd58jyYA@mail.gmail.com>
Subject: Re: [PATCH -next 0/8] drm/amd/amdgpu: fix comparison pointer to bool warning
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Zheng Bin <zhengbin13@huawei.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I question the value of these warnings.  Why even have a boolean type
if you are going to get warnings when you use them...
That said, applied to avoid getting these patches again and again
every time someone sees this.

Alex

On Wed, Sep 9, 2020 at 9:21 AM Christian K=C3=B6nig <christian.koenig@amd.c=
om> wrote:
>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com> for the series.
>
> Am 09.09.20 um 15:07 schrieb Zheng Bin:
> > Zheng Bin (8):
> >    drm/amd/amdgpu: fix comparison pointer to bool warning in gfx_v9_0.c
> >    drm/amd/amdgpu: fix comparison pointer to bool warning in gfx_v10_0.=
c
> >    drm/amd/amdgpu: fix comparison pointer to bool warning in sdma_v5_0.=
c
> >    drm/amd/amdgpu: fix comparison pointer to bool warning in sdma_v5_2.=
c
> >    drm/amd/amdgpu: fix comparison pointer to bool warning in si.c
> >    drm/amd/amdgpu: fix comparison pointer to bool warning in uvd_v6_0.c
> >    drm/amd/amdgpu: fix comparison pointer to bool warning in
> >      amdgpu_atpx_handler.c
> >    drm/amd/amdgpu: fix comparison pointer to bool warning in sdma_v4_0.=
c
> >
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c | 4 ++--
> >   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c           | 2 +-
> >   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c            | 2 +-
> >   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c           | 4 ++--
> >   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c           | 2 +-
> >   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c           | 2 +-
> >   drivers/gpu/drm/amd/amdgpu/si.c                  | 2 +-
> >   drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c            | 4 ++--
> >   8 files changed, 11 insertions(+), 11 deletions(-)
> >
> > --
> > 2.26.0.106.g9fadedd
> >
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
