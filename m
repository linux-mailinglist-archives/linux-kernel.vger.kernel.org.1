Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 772C82B1EFC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 16:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgKMPqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 10:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgKMPqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 10:46:00 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE063C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 07:45:59 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id d12so10357330wrr.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 07:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8040h1823exCptt290K2ZbCgSOfnPZC+bX9ayz7h03c=;
        b=ehw74WGQ3oAIgY9VTlCTqruI7XrRb+WbqPc8h7DTtqmbllTVLXzWmuz2tJiQjVfM32
         9BIK2RP0OEnRMrRqSrOyBigqDMVsYzpPPF/s6jrIgtWBofOCXSDzATo+SikKqe7POokl
         cen2S84YqJEyHOMFPfsXIBYUsu3D8luDEBBA2zim1n0sYnAUTLVZeqK+R2PV5coO6z+e
         UknNcWbaJFvl4h23tHWJhaaP0IikyYjm34xWGEeBGZdcYSPIssyn83QaV59qfxpNRAA3
         wXkOAQLvx8/mfVpzkBGpnOFqYL96K9kNkLlSKsMQ2WEXrR6t11ltbeZo422Q7mKKzJlf
         j2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8040h1823exCptt290K2ZbCgSOfnPZC+bX9ayz7h03c=;
        b=YfHm+yqYZ9WQ0c0d+xE3kPK7e5njM4ui+q4+q07ZEbopxElKhGiz/U2ehPqncLEYhw
         fht//vCAoJ0fMmZ3kwv6TJW4i5iiYOSYWp4sbifBAcpm/gT2njjD6PdkTofZTGkgQvvr
         ZEWUUvkO/aC3gIgHWSdoqJMRs43jhop2ufydzl2+xAFXshBP0CCsknqvO8NEgg1JnxSz
         HYdoLnvhx+952L72P++32j0gKT8M2ulpwkhyHJ8rzFkNHJUd9f3j2LYK2Cqhtj0kB488
         Ct1dcwbFm3oVQLfFiAFfF4vbISRstgvbia+jvCOura+LPT3QuSxv45RilSiuoOPtfoUj
         CFTA==
X-Gm-Message-State: AOAM532UpXO/AyXIZUov4N4nzq732JB0KvVPvaqxvdujr6w8JxNJUyrc
        9omyBp2rctJjh6yd4VeHzP1E7w==
X-Google-Smtp-Source: ABdhPJyiqhGILQ5wz3/bpboCSgRPXWW77kAhTnJTpNJP/Za6YqeYLUABaQ6YWDwE2o+MkrcH9VnNvQ==
X-Received: by 2002:a5d:69d1:: with SMTP id s17mr4337524wrw.104.1605282353498;
        Fri, 13 Nov 2020 07:45:53 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id k20sm10457006wmi.15.2020.11.13.07.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 07:45:52 -0800 (PST)
Date:   Fri, 13 Nov 2020 15:45:50 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Leo Li <sunpeng.li@amd.com>, LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 02/40] drm/amd/display/dc/core/dc_link_dp: Move
 DP_VGA_LVDS_CONVERTER_ID_{2, 3} to where they're used
Message-ID: <20201113154550.GK3718728@dell>
References: <20201113134938.4004947-1-lee.jones@linaro.org>
 <20201113134938.4004947-3-lee.jones@linaro.org>
 <CADnq5_N6iRUWZ=nYqRFWjUjsDL65WXEOg__n+yvbtqqcRSsWgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_N6iRUWZ=nYqRFWjUjsDL65WXEOg__n+yvbtqqcRSsWgQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Nov 2020, Alex Deucher wrote:

> On Fri, Nov 13, 2020 at 8:49 AM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > This patch fixes >200 warnings.
> >
> > Fixes the following W=1 kernel build warning(s):
> >
> >  drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:123:22: warning: ‘DP_VGA_LVDS_CONVERTER_ID_3’ defined but not used [-Wunused-const-variable=]
> >  123 | static const uint8_t DP_VGA_LVDS_CONVERTER_ID_3[] = "dnomlA";
> >  | ^~~~~~~~~~~~~~~~~~~~~~~~~~
> >  drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:121:22: warning: ‘DP_VGA_LVDS_CONVERTER_ID_2’ defined but not used [-Wunused-const-variable=]
> >  121 | static const uint8_t DP_VGA_LVDS_CONVERTER_ID_2[] = "sivarT";
> >
> > NB: Repeated ~100 times - snipped for brevity
> >
> > Cc: Harry Wentland <harry.wentland@amd.com>
> > Cc: Leo Li <sunpeng.li@amd.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: "Christian König" <christian.koenig@amd.com>
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
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> > index 6c60c1fdebdc1..f2023d2b53234 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> > @@ -15,6 +15,11 @@
> >  #include "dc_dmub_srv.h"
> >  #include "dce/dmub_hw_lock_mgr.h"
> >
> > +/*Travis*/
> > +static const uint8_t DP_VGA_LVDS_CONVERTER_ID_2[] = "sivarT";
> > +/*Nutmeg*/
> > +static const uint8_t DP_VGA_LVDS_CONVERTER_ID_3[] = "dnomlA";
> > +
> >  #define DC_LOGGER \
> >         link->ctx->logger
> >  #define DC_TRACE_LEVEL_MESSAGE(...) /* do nothing */
> > diff --git a/drivers/gpu/drm/amd/display/include/ddc_service_types.h b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
> > index c9be899cd25cd..b453ce5a9bfdb 100644
> > --- a/drivers/gpu/drm/amd/display/include/ddc_service_types.h
> > +++ b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
> > @@ -117,10 +117,6 @@ struct av_sync_data {
> >         uint8_t aud_del_ins3;/* DPCD 0002Dh */
> >  };
> >
> > -/*Travis*/
> > -static const uint8_t DP_VGA_LVDS_CONVERTER_ID_2[] = "sivarT";
> > -/*Nutmeg*/
> > -static const uint8_t DP_VGA_LVDS_CONVERTER_ID_3[] = "dnomlA";
> >  /*DP to Dual link DVI converter*/
> >  static const uint8_t DP_DVI_CONVERTER_ID_4[] = "m2DVIa";
> >  static const uint8_t DP_DVI_CONVERTER_ID_5[] = "3393N2";
> 
> Can we keep all of these strings together?

I don't think so.  They are consumed by different files.

Oh, one way to do it would be to mark them as __maybe_unused, but
I only tend to do that a last resort.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
