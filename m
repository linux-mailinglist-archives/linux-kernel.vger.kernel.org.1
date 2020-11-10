Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5BA2ADE74
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 19:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731050AbgKJSft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 13:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730705AbgKJSfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 13:35:48 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3028DC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 10:35:48 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id 10so4200444wml.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 10:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fkc0ycbUoUtG+FjZeVMynAGeVGfFXsGCK1nH0SmgLw8=;
        b=GnGrGl8ndYX01vNQKIrlc8zSj69FGGJXTLXD7M3TAAt8RH+ROZUTNu+3vHZsgC59Tn
         BRRCF0o+A3dsav5WV3VHNRsqFwNyRkKL6rqcYYgg0bOlDdiL4KMs4o7DwxGN0lufrMZV
         1NWEJcTF3zCLZ/oSPDMqbsBV/RsZg6xLh2h3xj4oZHd/rTwmUfWHfIUGRF/E82cwW6+c
         XTUuPzPb3L12eXh3yT1X2sg56SXh5Jb12PgZKq5NStypmLmDIlEQyT6UoQJfEdYYp1Lf
         LEXkIWBxfxECp++Fyyr3o9j3BomLmLdNs7DCpG4qsHaJyA6P8ENyZuAl/1BR2h8zua1n
         elKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fkc0ycbUoUtG+FjZeVMynAGeVGfFXsGCK1nH0SmgLw8=;
        b=hybznwVexb7tyK0s9hT5DREO3gQ55zuE9IaNJAa/iQYhoNgQOfXc38o0wcgadYXafB
         ud2Pw8fGeJBqfmhYqLsSPXF6D/1iPGEMnQt+WV1/hkdT2iKfLT1hiMAgeaMy95HQYFWF
         Zu0hS09RfMOMEyjwYwtED7ivjrC5CtO7ir9LXtZomMaKT6ui4jc/6uoQ31kyEL0s7aEK
         2kDz4tA9/yzoDS41mRNXsDuzSZUHxFcoLjciuae4L3Hwt2SkQD/DJD8WoJ5y6jeVk+xl
         RGpZTPG58VcRpO9nIBO6FQRxWbou5jr+JJIa1VG/TKbP3DhBMbypckz3SIzdvgsYSm5T
         baXg==
X-Gm-Message-State: AOAM530ofQjFcAx6HCmvzM8Cabgn0ZiOJh1SHLvgRO43Zb00xZO3tpSK
        8kQwgeSet5sk/j39B+WH3qxkQxnsbSNYDfUD0Wc=
X-Google-Smtp-Source: ABdhPJy2ChBuZ6+CQB/VWapMjPxaAAPkbc670SCDgbKEh+lkqy+WwsAKQ2Dt+ne308QWwZAyJH8O53zHCeeE+VpiVCk=
X-Received: by 2002:a1c:46c6:: with SMTP id t189mr463104wma.79.1605033346841;
 Tue, 10 Nov 2020 10:35:46 -0800 (PST)
MIME-Version: 1.0
References: <20201110080318.36305-1-bernard@vivo.com> <2fcfe666-3c83-17ad-f287-6a1801268285@amd.com>
In-Reply-To: <2fcfe666-3c83-17ad-f287-6a1801268285@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 10 Nov 2020 13:35:35 -0500
Message-ID: <CADnq5_NdtkOgt7rwiaQcaWJ2P--7sz49+NC0iWYU+R-L5LN5Gw@mail.gmail.com>
Subject: Re: [PATCH] amd/display/amdgpu_dm: delete same check in if condition
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     Bernard Zhao <bernard@vivo.com>, Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Mikita Lipski <mikita.lipski@amd.com>,
        Stylon Wang <stylon.wang@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Roman Li <Roman.Li@amd.com>, hersen wu <hersenxs.wu@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Alexander Monakov <amonakov@ispras.ru>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Tue, Nov 10, 2020 at 9:13 AM Harry Wentland <harry.wentland@amd.com> wrote:
>
> On 2020-11-10 3:03 a.m., Bernard Zhao wrote:
> > In function amdgpu_dm_connector_get_modes, drm_edid_is_valid
> > will check weather (!edid), no need to check again in the if
> > branch.
> >
> > Signed-off-by: Bernard Zhao <bernard@vivo.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index e93e18c06c0e..0a283d07fe10 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -6352,7 +6352,7 @@ static int amdgpu_dm_connector_get_modes(struct drm_connector *connector)
> >
> >       encoder = amdgpu_dm_connector_to_encoder(connector);
> >
> > -     if (!edid || !drm_edid_is_valid(edid)) {
> > +     if (!drm_edid_is_valid(edid)) {
> >               amdgpu_dm_connector->num_modes =
> >                               drm_add_modes_noedid(connector, 640, 480);
> >       } else {
> >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
