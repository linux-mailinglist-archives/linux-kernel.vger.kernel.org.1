Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC1F2B0ECA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 21:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgKLUI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 15:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbgKLUI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 15:08:56 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E56C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 12:08:56 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id a3so6561352wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 12:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=NdNkzlDaSwMULZwdt2G9+gSnA797TK1gCTMOnWVTmic=;
        b=SGdJxSQDiO/tnKMKOXGBrZdx4N8+4uGeEJZeArx9q3b8gl/6puets3SXatZ24xOzUG
         5V4HB5CkMr+hZ4MpidHT2pEscVwmvhBM9UGWQGfB71Qr5xgM+I/XJbw/vMDCFkzHpavL
         P1dBYBiiOYYXO4qs2HhiZgc0ImkGm745k0AQJc1z4UbipSOKVd6xLVQMNUSZByVOrFlw
         yJVGNf5ZASBtBthAo6HFvTk4xM+Z6zPtU+JEBTktOUYsmoX8WZVy2tDmN1xNk/L3HOuN
         z73rFsT0OKQR4T/2Y2aKoMOBqeLpc82FAeQROYZ5OCgqutPBxw2hpJA4vevxVlvGN2dE
         +ntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NdNkzlDaSwMULZwdt2G9+gSnA797TK1gCTMOnWVTmic=;
        b=MMSEIrZzh3gePzeeSOlL7BNCTjibPvJ7Vdl4+OevcMcxLHGILTd06GLNMiufolRur3
         xujwO3kWwFp4DmQPaZhwBOb9oIUjNJ3DWL/EqmG80ueti9MzhNwENGLips4AJJKqiNQg
         XJA/mxPNj2TgrGI3vr37N5QRi07077SXE2Ra70oJY0Fcjim2T1UvLI8yt2rzVhBSAB74
         MRpZdAipNI8ge+kdC83qOR/9Ago3Ll3JY9stJI6FugOSmhC8KKnutbrdjjZPxareVIw7
         sWgehn5tlsL3TDQmVFABuefTnbldL2yPTCG4hDsZunwiui41cAA/7ACdtMp8+rlNDB4X
         Capg==
X-Gm-Message-State: AOAM533rKzvUpD5M1wO7ozUOc3WEBzVC/ebAVIgEVgRfkilnND0VpOBy
        9e1zLof+JHjnlHtLDaW8Yj06I+CZSEqdFMHx
X-Google-Smtp-Source: ABdhPJytznGMi4YliKX3CB1LkC8RxmcXA4z6KnpfzORZmdGQuZFO+h1pMrtQhOCaNPKGhmoSFb3Lmg==
X-Received: by 2002:a1c:c286:: with SMTP id s128mr1346590wmf.88.1605211734707;
        Thu, 12 Nov 2020 12:08:54 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id x6sm8081055wmc.48.2020.11.12.12.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 12:08:54 -0800 (PST)
Date:   Thu, 12 Nov 2020 20:08:52 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/30] drm/savage/savage_bci: Remove set but never used
 'aper_rsrc' and 'fb_rsrc'
Message-ID: <20201112200852.GB2787115@dell>
References: <20201112190039.2785914-1-lee.jones@linaro.org>
 <20201112190039.2785914-2-lee.jones@linaro.org>
 <20201112193113.GD3287572@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201112193113.GD3287572@ravnborg.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Nov 2020, Sam Ravnborg wrote:

> On Thu, Nov 12, 2020 at 07:00:10PM +0000, Lee Jones wrote:
> > The comment about them (also removed) says:
> > 
> >  /* fb_rsrc and aper_rsrc aren't really used currently, but still exist
> >   * in case we decide we need information on the BAR for BSD in the
> >   * future.
> >   */
> > 
> > Well that was written 12 years ago in 2008.  We are now in the future
> > and they are still superfluous.  We can always add them again at a
> > later date if they are ever required.
> > 
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/gpu/drm/savage/savage_bci.c: In function ‘savage_driver_firstopen’:
> >  drivers/gpu/drm/savage/savage_bci.c:580:24: warning: variable ‘aper_rsrc’ set but not used [-Wunused-but-set-variable]
> >  drivers/gpu/drm/savage/savage_bci.c:580:15: warning: variable ‘fb_rsrc’ set but not used [-Wunused-but-set-variable]
> > 
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> 
> Thanks, applied to drm-misc-next.

Thanks for your prompt response Sam.  Much appreciated.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
