Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C1F2B1E96
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 16:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgKMP06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 10:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbgKMP05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 10:26:57 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2992AC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 07:26:57 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id s13so8810170wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 07:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=G9TfsPNQuZodnze2hrFlCCZs5bDojQWMiw52AmraRWM=;
        b=uK5SglA4vTQ4iJCcvCvRIJF3mTuXKqt0Hrjt/oUsmnEW+bDApmE7CIAAaWf/qFMRXQ
         q3fXIc8v3pWqYGYNpN1nFaIgOB/pqj+0Lz15lfd1SCdX9iBHBUbbuYNnqf7Rt2lmR82l
         iruZUqUbX9Bp8ny6OW7+pykb/+gFSgxVcZcNA6jkKGmUfxPYRbw7InkjG+LLA3jxnjAw
         /G47Ei7HmI3bfVFiSb70aKeQQOaOx+Gk62rC4SKDmGCYMoQYpq5rjPONmEAtp3uP/Fkn
         ZuS/qVLnBax4KbQ2aEJ0cOH9wU3Pgm2FZadBCyAOas8dFuqA9Ggg1T0ysZebX6qi0G1K
         8+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G9TfsPNQuZodnze2hrFlCCZs5bDojQWMiw52AmraRWM=;
        b=lqRcr9ixbJZvdl7a1ZMzS4LivdFkI2ZqKS+4QRAM9JQRZWslpMmMFUX4LdTs7kOVnH
         aqRdFBgTz9Upwg7LaFIe0uU+dCIuDkpO2nQMNjHHr3gOCR6NSLxl+5pQ8ZqGh80hl3WQ
         NkVJ9x2dXPuTm95yX4p1YsUVn5qK5299hoFMJXeaS0wBxZmEGX/fkoTz9fp3Wnf1ZFsO
         PcoD9aC6j00pG3jjjP9qkt7HCEOJE5S5KgnaGfIh0C5c6GDiv7MCPJ4O36IyfQapgaZ5
         BlQqcyR0JNqaudcOHa3MxsCmsBvxh9wjkoTzaVTQTo7DqT1wO/0GiFui8Gs5EEuz8wU8
         M3yA==
X-Gm-Message-State: AOAM532wWUtR5eXE4xhnSNdYkbToKYXkRM3KrxswmTrfXEj74dg7QreM
        5doawljQvbXO2RtXuuRTxsxBrfq3ZnWXAglbu6lnqi0N
X-Google-Smtp-Source: ABdhPJzEnaDDGa7S6X7M+JzJV1x3tPLpk48+5+IeHGvSTjuAqAT+Y65hF97bdiVMt1b5gc2rf5+BO8xkGi7MdAAi8tc=
X-Received: by 2002:a1c:1c3:: with SMTP id 186mr3041461wmb.39.1605281210978;
 Fri, 13 Nov 2020 07:26:50 -0800 (PST)
MIME-Version: 1.0
References: <20201113134938.4004947-1-lee.jones@linaro.org>
 <20201113134938.4004947-3-lee.jones@linaro.org> <CADnq5_N6iRUWZ=nYqRFWjUjsDL65WXEOg__n+yvbtqqcRSsWgQ@mail.gmail.com>
In-Reply-To: <CADnq5_N6iRUWZ=nYqRFWjUjsDL65WXEOg__n+yvbtqqcRSsWgQ@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 13 Nov 2020 10:26:39 -0500
Message-ID: <CADnq5_M8c_BHN+T3T6nzv3FRy9dJ=dwy+6rx5+NGtZnD7o=n1g@mail.gmail.com>
Subject: Re: [PATCH 02/40] drm/amd/display/dc/core/dc_link_dp: Move
 DP_VGA_LVDS_CONVERTER_ID_{2, 3} to where they're used
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Leo Li <sunpeng.li@amd.com>, LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 10:23 AM Alex Deucher <alexdeucher@gmail.com> wrote=
:
>
> On Fri, Nov 13, 2020 at 8:49 AM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > This patch fixes >200 warnings.
> >
> > Fixes the following W=3D1 kernel build warning(s):
> >
> >  drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:123:=
22: warning: =E2=80=98DP_VGA_LVDS_CONVERTER_ID_3=E2=80=99 defined but not u=
sed [-Wunused-const-variable=3D]
> >  123 | static const uint8_t DP_VGA_LVDS_CONVERTER_ID_3[] =3D "dnomlA";
> >  | ^~~~~~~~~~~~~~~~~~~~~~~~~~
> >  drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:121:=
22: warning: =E2=80=98DP_VGA_LVDS_CONVERTER_ID_2=E2=80=99 defined but not u=
sed [-Wunused-const-variable=3D]
> >  121 | static const uint8_t DP_VGA_LVDS_CONVERTER_ID_2[] =3D "sivarT";
> >
> > NB: Repeated ~100 times - snipped for brevity
> >
> > Cc: Harry Wentland <harry.wentland@amd.com>
> > Cc: Leo Li <sunpeng.li@amd.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: amd-gfx@lists.freedesktop.org
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c        | 5 +++++
> >  drivers/gpu/drm/amd/display/include/ddc_service_types.h | 4 ----
> >  2 files changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers=
/gpu/drm/amd/display/dc/core/dc_link_dp.c
> > index 6c60c1fdebdc1..f2023d2b53234 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> > @@ -15,6 +15,11 @@
> >  #include "dc_dmub_srv.h"
> >  #include "dce/dmub_hw_lock_mgr.h"
> >
> > +/*Travis*/
> > +static const uint8_t DP_VGA_LVDS_CONVERTER_ID_2[] =3D "sivarT";
> > +/*Nutmeg*/
> > +static const uint8_t DP_VGA_LVDS_CONVERTER_ID_3[] =3D "dnomlA";
> > +
> >  #define DC_LOGGER \
> >         link->ctx->logger
> >  #define DC_TRACE_LEVEL_MESSAGE(...) /* do nothing */
> > diff --git a/drivers/gpu/drm/amd/display/include/ddc_service_types.h b/=
drivers/gpu/drm/amd/display/include/ddc_service_types.h
> > index c9be899cd25cd..b453ce5a9bfdb 100644
> > --- a/drivers/gpu/drm/amd/display/include/ddc_service_types.h
> > +++ b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
> > @@ -117,10 +117,6 @@ struct av_sync_data {
> >         uint8_t aud_del_ins3;/* DPCD 0002Dh */
> >  };
> >
> > -/*Travis*/
> > -static const uint8_t DP_VGA_LVDS_CONVERTER_ID_2[] =3D "sivarT";
> > -/*Nutmeg*/
> > -static const uint8_t DP_VGA_LVDS_CONVERTER_ID_3[] =3D "dnomlA";
> >  /*DP to Dual link DVI converter*/
> >  static const uint8_t DP_DVI_CONVERTER_ID_4[] =3D "m2DVIa";
> >  static const uint8_t DP_DVI_CONVERTER_ID_5[] =3D "3393N2";
>
> Can we keep all of these strings together?

Nevermind, I hadn't seen the later patch that deals with the later ones.

Alex

>
> Alex
>
> > --
> > 2.25.1
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
