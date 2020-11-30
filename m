Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7FF62C92EF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730404AbgK3Xog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729627AbgK3Xog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:44:36 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4150C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:43:55 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id k26so16238135oiw.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LXttFR72uW7whiX6VrfKE+K9RR9Zk3Wvbi+Z+4eAetM=;
        b=D9R/CGP4Px1Xn7cMko+I3qT6mRaKmAMgRKWxsj2zLmKb3B/28Q+TspnkNw/YwgDC6k
         toleJ0+nSYCF5oam61Q49JLJY7Rv3WDJ664+AC6dMEwZsuDLZ+qTAW12K+Y7g3FgMr4G
         OwAt1/ymJ6IH2bB991JtQAncr/X+5ZtAkIs95ZkEcqc8FZeAcFmtxxzGhx244nVDk3VW
         OM4ST7qeOVijmgU5V1is89vLlsatdkWwTYWAtsXZxVgUnj+Ws8qy6qmLJ52iZRrTQX2G
         Kc9zC6yub/djuUBy4VZqY62G9cYV5ThGF5PVuQmW8gEqmMLAyH3VlWFznRr08WVJ4GaJ
         m5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LXttFR72uW7whiX6VrfKE+K9RR9Zk3Wvbi+Z+4eAetM=;
        b=A0Ebxa+ksPRIPpToGHk/hePllrFFExnTLLRh6gGAVUCZzAMlXfVU9BY2nNJVQ5vpsv
         094pIAmvtaT+8eRpp/hcvEQ2/iwIbwMcMKWSEeDZ+vgriOcrgeJkEWfEpIr1R6e65IdF
         gQf43wQM++quy8Z2LNj9GsFfgL+yEwr7B0Z0Q9w//nCoKDf9bjwYkYQzOy+pXGyFAFtn
         ewdiyPcTCYkkCc4s8L+E3K7kd5VYZ2NcAeNRpM9TM/bK8VixFefOnylh363Xb3pJ6VQj
         A8ZNsSsYXrbL+i1La8+hE3w5/kEEX3ZYVaKyhhL6pcwbPA5kpotkyWGTbv+w89oZof+a
         K6KQ==
X-Gm-Message-State: AOAM531N16ZgyxqrAo5nJlDqg7RG+vX+K6QNLVWwYcWQb04kKZhZ3fvg
        kRJctezStA/Y3GjOm0iloAWr7s//UB8eVV7XLgU=
X-Google-Smtp-Source: ABdhPJyaOIUx4tWcs6D/2KE4+hR0XI6fT/rG4XVdfQIE2xAxgyK7JHwIcN+SBDXvHDQSfFuWtyFgFkDoaiSuNqxPwX8=
X-Received: by 2002:aca:f50e:: with SMTP id t14mr171348oih.123.1606779835345;
 Mon, 30 Nov 2020 15:43:55 -0800 (PST)
MIME-Version: 1.0
References: <20201126134240.3214176-1-lee.jones@linaro.org> <20201126134240.3214176-21-lee.jones@linaro.org>
In-Reply-To: <20201126134240.3214176-21-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 18:43:44 -0500
Message-ID: <CADnq5_M0N1OfM73AHZpOLRBAaSw66XYu_Kx5M=8oi+vH-7BAYw@mail.gmail.com>
Subject: Re: [PATCH 20/40] drm/amd/pm/powerplay/hwmgr/vega10_processpptables:
 Make function invoked by reference static
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 8:43 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_processpptables.=
c:1148:5: warning: no previous prototype for =E2=80=98vega10_pp_tables_init=
ialize=E2=80=99 [-Wmissing-prototypes]
>
> Cc: Evan Quan <evan.quan@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptable=
s.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c
> index 535404de78a20..95b988823f50f 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c
> @@ -1145,7 +1145,7 @@ static int init_dpm_2_parameters(
>         return result;
>  }
>
> -int vega10_pp_tables_initialize(struct pp_hwmgr *hwmgr)
> +static int vega10_pp_tables_initialize(struct pp_hwmgr *hwmgr)
>  {
>         int result =3D 0;
>         const ATOM_Vega10_POWERPLAYTABLE *powerplay_table;
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
