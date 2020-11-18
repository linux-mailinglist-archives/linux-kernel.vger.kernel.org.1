Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9BB82B7900
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 09:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgKRInI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 03:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbgKRInI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 03:43:08 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911C5C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 00:43:06 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id w24so1903564wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 00:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=fnDyKeim6MLktf6goxDG8bETMIT1x5B36xRg+H6Tp/M=;
        b=PNvc5vIyrM8C6v8Z5V12ssPdpy36I2f7x9AozlD63o4mrUjyxSHNOAWNPdKG7szVFK
         aV3pcXO/4aHBMgR626nYQY0gAHd7ShMdqGKJooslFMOoueqx8cLs6V3YRVR8MWaXGcgC
         vtJMh4SY4YQNpGLF+SUfVbBpnPRL0EzKM9BxYxNjA73hUroITzc/5RJda6Kc13T5oC09
         shbKgF8A2HqrTC9Eytrz00gvcOtuqZeZ7USciOJIT0Rm9Wiz1EiXwRHrmb2ihwI7Uh5p
         Hoi/L6kQeF1dI34rorxfs5IkXdmHz+TSkkp8R97KD8IbEC8UoDc+0SpGzjZkxz7lm1Wg
         8MFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fnDyKeim6MLktf6goxDG8bETMIT1x5B36xRg+H6Tp/M=;
        b=Hi0g5e9+40EzheK87gQdWiVdoazXu5FySQI5NEyANEok3hTQjKbWU0kdhoj6YYBjuP
         jsVfvgVzzXmckOmMQNiPeJzgGyxNxVMaYVbgEqivkGqT9cJ6Wt7qvcLUFpFegaWuL81l
         3aXePpmD0Lg3nDOzA62CS1Ki23fAdQccoFmX0yGeo7A7bSi0IDmfK5aXXucPXLSxv7Kc
         VnRTHwTPIWLzwtUjgi8kPRp83YQ3R5sDWCud85bTS5fiD2NSKdY/FlULwF7Xaf7oeS0x
         /b9o7VY0hkK47nauYkU4yc/CYDA+LxKiVLY39YAcVK6+A3ui5nxxjJDF18AZDJ+o4qNj
         PHAQ==
X-Gm-Message-State: AOAM530scXICu77x5b33e4V9GPXJtgfTBlrfzbN8C22pQFiF44oJhc2Y
        XX0a80lSOL0/PG+yYCZ+o1K497cOa9hITBvC
X-Google-Smtp-Source: ABdhPJyIWUVccZyAXEsObevGW/HAb1nxmtfyuHFvXXaetFjntxj3sQMrjXfKIJTB0JRP1IXOQra5yw==
X-Received: by 2002:a7b:c92a:: with SMTP id h10mr1473209wml.138.1605688984839;
        Wed, 18 Nov 2020 00:43:04 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id e1sm1894406wmd.16.2020.11.18.00.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 00:43:03 -0800 (PST)
Date:   Wed, 18 Nov 2020 08:43:02 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 42/42] include/drm/drm_atomic: Make use of
 'new_crtc_state'
Message-ID: <20201118084302.GN1869941@dell>
References: <20201116174112.1833368-1-lee.jones@linaro.org>
 <20201116174112.1833368-43-lee.jones@linaro.org>
 <20201117194241.GV401619@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201117194241.GV401619@phenom.ffwll.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Nov 2020, Daniel Vetter wrote:

> On Mon, Nov 16, 2020 at 05:41:12PM +0000, Lee Jones wrote:
> > In the macro for_each_oldnew_crtc_in_state() 'crtc_state' is provided
> > as a container for state->crtcs[i].new_state, but is not utilised in
> > some use-cases, so we fake-use it instead.
> > 
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
> 
> Ok I merged them all except:
> - drm/amd and drm/imx, should be picked up already by respective
>   maintainers
> - drm/msm, Rob promised to take care
> 
> Thanks a lot for your patches.

Perfect.  Thank you for reviewing/merging them.

> > ---
> >  include/drm/drm_atomic.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
> > index dc5e0fbecc04e..54e051a957dfc 100644
> > --- a/include/drm/drm_atomic.h
> > +++ b/include/drm/drm_atomic.h
> > @@ -783,7 +783,8 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
> >  			      (void)(crtc) /* Only to avoid unused-but-set-variable warning */, \
> >  			     (old_crtc_state) = (__state)->crtcs[__i].old_state, \
> >  			     (void)(old_crtc_state) /* Only to avoid unused-but-set-variable warning */, \
> > -			     (new_crtc_state) = (__state)->crtcs[__i].new_state, 1))
> > +			     (new_crtc_state) = (__state)->crtcs[__i].new_state, \
> > +			     (void)(new_crtc_state) /* Only to avoid unused-but-set-variable warning */, 1))
> >  
> >  /**
> >   * for_each_old_crtc_in_state - iterate over all CRTCs in an atomic update
> 

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
