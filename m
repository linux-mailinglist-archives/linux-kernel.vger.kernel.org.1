Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79EAC2AE185
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 22:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbgKJVUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 16:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKJVUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 16:20:44 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DF7C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 13:20:42 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id c16so4604579wmd.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 13:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=QIBJshKpv92POnG5rECWEfa1XG4D+wo2F1uj30221ws=;
        b=MQwkHYPkvDN417BZe5U6Pp09S/rmgt2LyTmKr39o80Gl8IVjOLC4+fbs2EX+mD1vVg
         BfHLXDrzZEkogEJFztCSPvzrIbNWeB4FB+Ko3qWk1l0zenpiTkaROItaxYWL1pj45M8z
         DAkcacHe5YPHy5055oswQsRNe4EJYM2eHtebBlQL6sad7DgMpJPFB9dNWoDmNfw3etWN
         FczHcnOOiPZoNL4PEwRNMWd1EZ/5NS7p7wXoPsdiHvcvpkUJVx2sOjHVcKesQp2q/G91
         +kU35alQnVbwVPHbnPLHCdKLoXK28BsRmxj5s5roTukIWMO3+T2ToE8Y68jYUuhUr43Y
         HyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QIBJshKpv92POnG5rECWEfa1XG4D+wo2F1uj30221ws=;
        b=kd0BMSG5eVelBdBexvYvNvWIzCmsarea9OYL6GyD+oOCpp9qhtF/GWAFlhYyZPhPNV
         pqrUbF1PqesROtKs81DX5fklhxfgMSoG6X7wFFBhmmNpy63wtWx2e6e8xMJnbA3R2Co5
         o+hI7DDYLgpdr4tpKYlzKabeWic8mVyNg8EPG6A9jegBcJfCKwojTiIwOaHROarsClEw
         szoO76oZmJ/7edLmC0OTVnHT61cNfzLuHf8ospG1ZV/tz+Li9/evRtgZE3X4cCb2bYla
         naX2a5ZBxT1S4uSPTKprxGu2z9yu6hW6z/fW9bxmC4d6S7qPIUyi/3ZAhmnd4ctXZdKL
         rsYg==
X-Gm-Message-State: AOAM531ssr04NUmLbyjnb/VqThGMxe9lOtxwO9IkfmUn7R4oPx3zjI11
        wFbDtO/p6egCvPce1G9YCugvtA==
X-Google-Smtp-Source: ABdhPJwCTUWwrks9Lt6bjM5yd8fytosAD9T3MWUv1CZE5JGhqzDgmOEGA7pKRClkRBXcOndIAPqC5Q==
X-Received: by 2002:a1c:4144:: with SMTP id o65mr34234wma.171.1605043241519;
        Tue, 10 Nov 2020 13:20:41 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id v8sm78027wmg.28.2020.11.10.13.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 13:20:40 -0800 (PST)
Date:   Tue, 10 Nov 2020 21:20:39 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Gareth Hughes <gareth@valinux.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 15/19] gpu: drm: radeon: radeon_drv: Remove unused
 variable 'ret'
Message-ID: <20201110212039.GL2063125@dell>
References: <20201105144517.1826692-1-lee.jones@linaro.org>
 <20201105144517.1826692-16-lee.jones@linaro.org>
 <CADnq5_PZRM0wmrcJAGfdyFqnR68gbVQK76TrHSbJJRK1t8cT8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_PZRM0wmrcJAGfdyFqnR68gbVQK76TrHSbJJRK1t8cT8g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Nov 2020, Alex Deucher wrote:

> On Thu, Nov 5, 2020 at 9:52 AM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > Fixes the following W=1 kernel build warning(s):
> >
> >  drivers/gpu/drm/radeon/radeon_drv.c: In function ‘radeon_pmops_runtime_suspend’:
> >  drivers/gpu/drm/radeon/radeon_drv.c:455:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
> >
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: "Christian König" <christian.koenig@amd.com>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Gareth Hughes <gareth@valinux.com>
> > Cc: amd-gfx@lists.freedesktop.org
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Applied.  Thanks!

Thanks Alex.

I'll rebase in a few days and fix/resend whatever is outstanding.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
