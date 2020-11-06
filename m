Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195052A9091
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 08:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgKFHlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 02:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgKFHlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 02:41:55 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE33C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 23:41:55 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id c9so400229wml.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 23:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6ufj42Bv/86ArnSS/EsHZyzQ98Oc/FG+uTtO5PTygmc=;
        b=oLWx6Bsyrgz3NhKGWzEcRFID//Yk8EMYlq2WgiHL04Xqe+fXjhBHsNNetTodNCTJQg
         YnYjmwFrOO/cAHOSHWakseRDbfJOfr5yeyv1hBfk5mmKEWwZuWpm8zxTgkPcFD3DJLvr
         V55gd+MlEOTjQ4lfpqmtd7rQVYuVZIvxvoqkPojAFPszQ7tXk78SqH2wfcb4ZRU5fngC
         ETrYc7UeUU379hnFLQsmgniteVzGKzFxzSKbWe5wsZwf6qe9RTAqzoL+r8VM7nhPrMHN
         Czt5GXRlXWhkNa+mQ+V22iv5a44QaysNqwMxXjleavTBw/936bKBYuYDJQMrQychEFav
         EbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6ufj42Bv/86ArnSS/EsHZyzQ98Oc/FG+uTtO5PTygmc=;
        b=rQfmtC8B/3TDb3QjkO9hnq5SokHxFlkJ2xdyGOUNy9eBAOZenmQZuo0dwsIMGGYW9H
         L1t8g3qhuCKRBhKY9Ucpqe0OuVc0wcR9z7ZdmPrdIetRsgNR6hXiOcgReCd69L+VevxF
         hBIlgWXstweDRuDAAdpCCD7RIJiNdVPo7+Ra9wIewuKZMByFQJW/oRCHHxLZxvTq+yfx
         vBqCmjpjjNc8FlMTwqOIGT6suKoz0VeqeuzvYfvrejo6URm2EaX09r1/ZEJyv0OH3SR8
         UT7L69ElxOhF//gbKDD5RWIJtEtQoWI9TqEstcl7Jkq4n4clHIG/cVBARGlo8hDJdiyL
         5/5g==
X-Gm-Message-State: AOAM532aqFUB/k9R/pxZ3VNzEEBOxTuIs972oJCVLl3iexJFfwB/xOvu
        igHTwozXDd7fEGdlKv6MsvK9YA==
X-Google-Smtp-Source: ABdhPJzLc6OVDukzV94pq5ko/pywJDPvwYQgId12KwgvXF/J8yC5zh/9oAvErhJxoolu/oop54L0Sw==
X-Received: by 2002:a1c:80cb:: with SMTP id b194mr921576wmd.73.1604648514026;
        Thu, 05 Nov 2020 23:41:54 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id r1sm767193wro.18.2020.11.05.23.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 23:41:53 -0800 (PST)
Date:   Fri, 6 Nov 2020 07:41:51 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH 03/19] gpu: drm: imx: ipuv3-plane: Mark 'crtc_state' as
 __always_unused
Message-ID: <20201106074151.GU4488@dell>
References: <20201105144517.1826692-1-lee.jones@linaro.org>
 <20201105144517.1826692-4-lee.jones@linaro.org>
 <15a4a184-74c2-e630-193a-cdea61545a03@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15a4a184-74c2-e630-193a-cdea61545a03@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Nov 2020, Ahmad Fatoum wrote:

> Hello Lee,
> 
> On 11/5/20 3:45 PM, Lee Jones wrote:
> > In the macro for_each_oldnew_crtc_in_state() 'crtc_state' is provided
> > as a container for state->crtcs[i].new_state, but is not utilised in
> > this use-case.  We cannot simply delete the variable, so here we tell
> > the compiler that we're intentionally discarding the read value.
> 
> for_each_oldnew_crtc_in_state already (void) casts the drm_crtc and the old
> drm_crtc_state to silence unused-but-set-variable warning. Should we maybe
> (void) cast the new crtc_state as well?

From what I saw, it only void casts the ones which aren't assigned.

> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/gpu/drm/imx/ipuv3-plane.c: In function ‘ipu_planes_assign_pre’:
> >  drivers/gpu/drm/imx/ipuv3-plane.c:746:42: warning: variable ‘crtc_state’ set but not used [-Wunused-but-set-variable]
> > 
> > Cc: Philipp Zabel <p.zabel@pengutronix.de>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> > Cc: Fabio Estevam <festevam@gmail.com>
> > Cc: NXP Linux Team <linux-imx@nxp.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/gpu/drm/imx/ipuv3-plane.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/imx/ipuv3-plane.c b/drivers/gpu/drm/imx/ipuv3-plane.c
> > index 8a4235d9d9f1e..acc0a3ce4992f 100644
> > --- a/drivers/gpu/drm/imx/ipuv3-plane.c
> > +++ b/drivers/gpu/drm/imx/ipuv3-plane.c
> > @@ -743,7 +743,7 @@ bool ipu_plane_atomic_update_pending(struct drm_plane *plane)
> >  int ipu_planes_assign_pre(struct drm_device *dev,
> >  			  struct drm_atomic_state *state)
> >  {
> > -	struct drm_crtc_state *old_crtc_state, *crtc_state;
> > +	struct drm_crtc_state *old_crtc_state, __always_unused *crtc_state;
> >  	struct drm_plane_state *plane_state;
> >  	struct ipu_plane_state *ipu_state;
> >  	struct ipu_plane *ipu_plane;
> > 
> 

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
