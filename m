Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C33D2ADB66
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 17:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbgKJQP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 11:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgKJQP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 11:15:28 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66294C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 08:15:28 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id 10so3599475wml.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 08:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=7CGWOWW/W5NZPaOpqTfKKcrmTlDUB36jZ3I9AkmIH6I=;
        b=Oyb2FmYMYcgg5GEthU7jt9bPL3ouAxvWpva7pbs8v91NGyhpUCqh7bYu4tkpyT0ALU
         x4A/AOa1lWZB0RDjFVBwRe6INqMWSkMViRHDSXCBUBaZoq73SLM1M4v1iJyCtmmTVKDH
         6/2eIt4EyxEhLJNA5JflypvukRIdCSQYuaqFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=7CGWOWW/W5NZPaOpqTfKKcrmTlDUB36jZ3I9AkmIH6I=;
        b=Lgxi9QU5LPi5JYmtosOtAfqaj747pqvG7HtXuBEsimWvBnyEff5Dn454pUMbVGWeDf
         vQ0kSLIWcGrunnxjQKkWLXaWXQKq/nqty9PanpSV82QQdlank2r/cron4kLBgqW7Vlw0
         lgy6z+GWzjA/pEkuMxWWB8wyM6IVcLyhRwRSePMikfcqnvoklwFN7enP+grViiMOPG7H
         Xllb1GSDFNw+PQsfoZNu3j73fa7xOrgL4iXPSLhNC3nW6p6rWKAPkRbqy2Q/lW9QDIgi
         X33AO+Bqd26jfWp9VXnssJEc95gjJmzCOkgnsjDslld9k8A6xzyHB2c29amxzsYF7fZp
         2c1Q==
X-Gm-Message-State: AOAM530GqdNt9S2p27cxfMC8E0QvWsv0pywldrBnv8TSFyS8J74CtYWW
        69OBD0uCyC9ecRtRHC9oJ+/Gog==
X-Google-Smtp-Source: ABdhPJwhsIWxla7qG5MoctbGmInEVIF8xoR14d/2DvWqNkUzSlrZ+dLToTW7q8cmJUQcQpt1J4zGTw==
X-Received: by 2002:a1c:7213:: with SMTP id n19mr492446wmc.36.1605024927076;
        Tue, 10 Nov 2020 08:15:27 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id q17sm2660356wro.36.2020.11.10.08.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 08:15:26 -0800 (PST)
Date:   Tue, 10 Nov 2020 17:15:23 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Edmund Dea <edmund.j.dea@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: DRM_KMB_DISPLAY should depend on ARCH_KEEMBAY
Message-ID: <20201110161523.GN401619@phenom.ffwll.local>
Mail-Followup-To: Geert Uytterhoeven <geert+renesas@glider.be>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Edmund Dea <edmund.j.dea@intel.com>,
        David Airlie <airlied@linux.ie>, Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20201110144350.3279147-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110144350.3279147-1-geert+renesas@glider.be>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 03:43:50PM +0100, Geert Uytterhoeven wrote:
> The Intel Keem Bay display controller is only present on Intel Keem Bay
> SoCs.  Hence add a dependency on ARCH_KEEMBAY, to prevent asking the
> user about this driver when configuring a kernel without Intel Keem Bay
> platform support.
> 
> Note that:
>   1. The dependency on ARM is dropped, as Keem Bay SoCs are only
>      supported in arm64 kernel builds,
>   2. The dependencies on OF and COMMON_CLK can be dropped for
>      compile-testing, as the driver builds fine regardless.
> 
> Fixes: ed794057b052b52a ("drm/kmb: Build files for KeemBay Display driver")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Both drm/kmb fixes applied to drm-misc-next, thanks a lot!
-Daniel

> ---
>  drivers/gpu/drm/kmb/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/kmb/Kconfig b/drivers/gpu/drm/kmb/Kconfig
> index 022ef3e3f05635be..3921c57ac511e2fb 100644
> --- a/drivers/gpu/drm/kmb/Kconfig
> +++ b/drivers/gpu/drm/kmb/Kconfig
> @@ -1,7 +1,7 @@
>  config DRM_KMB_DISPLAY
>  	tristate "INTEL KEEMBAY DISPLAY"
> -	depends on DRM && OF && (ARM || ARM64)
> -	depends on COMMON_CLK
> +	depends on DRM
> +	depends on ARCH_KEEMBAY || COMPILE_TEST
>  	select DRM_KMS_HELPER
>  	select DRM_KMS_CMA_HELPER
>  	select DRM_GEM_CMA_HELPER
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
