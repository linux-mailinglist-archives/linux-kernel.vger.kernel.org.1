Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A6A2B3EE8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 09:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbgKPIk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 03:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgKPIk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 03:40:27 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA6FC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 00:40:27 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id l1so17697098wrb.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 00:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=66vgfrqqdZ/IjftnWRbyL4mui98MkxfRQBZDGIvtL2s=;
        b=rG3sxjughMIpsK016TP+ndDu9i6AsudSrG82mApavm72NuxKrKmrpmqp7UfsnrS+yr
         LPkQykKHB7bRePswqOeFuGE5U3urfRmgY8xCS2gNc18KwwFLvnk13kusPLexPkHCAW4J
         Q9HmnCCFvyN/irDbL+knw2OVY4WgR9jGxnNnnkdowuQhOUiVIrhDotn0STih9731kL2C
         /o8NkkcLheLF2oh3UB4RhqEomcfmm1va+jVfdm4csg0sztaacD7Acd252QOQanS4gjCV
         gVJG2ZjycLDmaEQGJe2yo8jij2ity89vkyHFF3HwoQOqrTAzFbKF1R57Z2dOgJPXgc73
         2pzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=66vgfrqqdZ/IjftnWRbyL4mui98MkxfRQBZDGIvtL2s=;
        b=jymA+Ta6wA70gk/Dm6dSs7/faiDMR0cUiBD66eap3Q8WSR0K7cf6KppLmlCrDvUTwB
         uz9aU/eF2/e1qBJ9VeITm95zrftvqF3LneNYmacqA5XOyu/3MxPBtzph7ETZUiwdNlEG
         A6NR3xJ10w5i4WgwXwmaKTPsxM0Xp85uofdNpQ6s/X6QUX3nfGt3On7lo4B4ZKSrYbA2
         HG7sCbdGtAjbMloXiblibC24tNSCITCTtdskZ8v2N8uKHUA96ZOSlaj+iUGbGHIBrSfu
         zIR/oMUiHUGlVSvPmDLwbdi9GcF1Z+5v3n4aSda6t9VGdOcItoy3YPBieW1osiwBLU85
         VXoA==
X-Gm-Message-State: AOAM532k4aUJUP5eXZUT7sX31mOPSvrBJNtn/b7MiFUWWb2PPuwLrr5l
        BOYBVh5gRjDNzUBTrigMDD9nwwjLczW/YWnV
X-Google-Smtp-Source: ABdhPJwtkF/gvhkWNlAdOMKy71DTjd+S++as5sylbMhPP9SVjdJjRBSawpKlXZ8BBiftB8AUIyg38Q==
X-Received: by 2002:adf:f94b:: with SMTP id q11mr18901740wrr.351.1605516026241;
        Mon, 16 Nov 2020 00:40:26 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id t5sm18937446wmg.19.2020.11.16.00.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 00:40:25 -0800 (PST)
Date:   Mon, 16 Nov 2020 08:40:23 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/40] drm/pl111/pl111_display: Make local function static
Message-ID: <20201116084023.GL3718728@dell>
References: <20201113134938.4004947-1-lee.jones@linaro.org>
 <20201113134938.4004947-13-lee.jones@linaro.org>
 <20201114191127.GB3797389@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201114191127.GB3797389@ravnborg.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Nov 2020, Sam Ravnborg wrote:

> Hi Lee,
> On Fri, Nov 13, 2020 at 01:49:10PM +0000, Lee Jones wrote:
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/gpu/drm/pl111/pl111_display.c:356:6: warning: no previous prototype for ‘pl111_display_disable’ [-Wmissing-prototypes]
> > 
> > Cc: Eric Anholt <eric@anholt.net>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Eric's was not copied on this or the other pl111 patch.
> Added Eric so he can be aware of this fix.

Eric Anholt?

He's on Cc?

> > ---
> >  drivers/gpu/drm/pl111/pl111_display.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/pl111/pl111_display.c b/drivers/gpu/drm/pl111/pl111_display.c
> > index b3e8697cafcf1..69c02e7c82b7e 100644
> > --- a/drivers/gpu/drm/pl111/pl111_display.c
> > +++ b/drivers/gpu/drm/pl111/pl111_display.c
> > @@ -353,7 +353,7 @@ static void pl111_display_enable(struct drm_simple_display_pipe *pipe,
> >  		drm_crtc_vblank_on(crtc);
> >  }
> >  
> > -void pl111_display_disable(struct drm_simple_display_pipe *pipe)
> > +static void pl111_display_disable(struct drm_simple_display_pipe *pipe)
> >  {
> >  	struct drm_crtc *crtc = &pipe->crtc;
> >  	struct drm_device *drm = crtc->dev;

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
