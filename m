Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA812A91CB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 09:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgKFItK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 03:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgKFItK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 03:49:10 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89ADEC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 00:49:08 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id y12so441915wrp.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 00:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4gXfZMux6ogf2vVPHPrkL0rjreUZC3GES5D2UkiysIw=;
        b=C6iQhO/6iKUaCjWMaeY8SSjPW3SPed7FleZjgyiTbeenEF+cP/6d0G2NFBlmZ6O+0H
         bioL6f0N8OmX7BWLovVyNsXDaR9/nfXxEHTy5jLd7+u3mFIq7wJlEri4rU3IlV4wqgcD
         83JOnHkogW2l+61CjQQr5BNpYIV7HEgBg3nmG4Fve6ZR37i8/7lAL2dsyLsJEnNchGiC
         lCshBq71mdswYGS4ahEw8pGeUEJY4WU8A7zy3kdNr9+wSwgQY8Lul4rkCPgz4TKI8hIP
         8zA+DSnXbK0DYB4g2q+MP09tRsmr/SaiyRXr01/x6G2Ah0fUMYHNlIKbDUVPgaVw88wV
         0F4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4gXfZMux6ogf2vVPHPrkL0rjreUZC3GES5D2UkiysIw=;
        b=qMZmewSsLijTqlj3quAAU6wnQXdWxwFfqJtPKjtkUK+9mee+aXZB4IaqClT6B2sa1/
         ZXUg6GNgD6TjqjSiisXDvijnoubVuRgeLGSSUKqSqcKToDTR6zXb9aOfW2/CWW4kNhxC
         uxckKpiScMbr/+NRY1yRqeb9vK75+jPi9gsEztF4v/7JQyLFuJdt4Dfq1FWuARs8wYIO
         9rRii9i4rxoDYhFjAy+gb1qU+ZckUebJWDnDcfFIgsHQFyz6zwjp/HpgSWIQx9n6pYqe
         0sTSq6jdjdgjplvhm2HbhzS8ziYNqfNHpbXPvegebhg5Geoh3qLA7E+D2K5Oa8B+Fuz6
         wlrg==
X-Gm-Message-State: AOAM5311c/o+5mDwJ8si5v/z8AA7e3dNFGkkB7N9epcrp80e/7Uah3Va
        MjCw8GTWUSaW3qjIJ3YZ4iyBuw==
X-Google-Smtp-Source: ABdhPJxV2f1/yepdeAvjiDc4ZJvmvoXzriD7P33clmKJfkWKfm32k8/eAy9mdgUCgs52Ep3+q+DT+A==
X-Received: by 2002:a05:6000:7:: with SMTP id h7mr1443346wrx.83.1604652547314;
        Fri, 06 Nov 2020 00:49:07 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id t11sm1163799wmf.35.2020.11.06.00.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 00:49:06 -0800 (PST)
Date:   Fri, 6 Nov 2020 08:49:04 +0000
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
Message-ID: <20201106084904.GY4488@dell>
References: <20201105144517.1826692-1-lee.jones@linaro.org>
 <20201105144517.1826692-4-lee.jones@linaro.org>
 <15a4a184-74c2-e630-193a-cdea61545a03@pengutronix.de>
 <20201106074151.GU4488@dell>
 <5056c156-9f6c-8e0d-54e8-5317fdd46c12@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5056c156-9f6c-8e0d-54e8-5317fdd46c12@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Nov 2020, Ahmad Fatoum wrote:

> On 11/6/20 8:41 AM, Lee Jones wrote:
> > On Thu, 05 Nov 2020, Ahmad Fatoum wrote:
> > 
> >> Hello Lee,
> >>
> >> On 11/5/20 3:45 PM, Lee Jones wrote:
> >>> In the macro for_each_oldnew_crtc_in_state() 'crtc_state' is provided
> >>> as a container for state->crtcs[i].new_state, but is not utilised in
> >>> this use-case.  We cannot simply delete the variable, so here we tell
> >>> the compiler that we're intentionally discarding the read value.
> >>
> >> for_each_oldnew_crtc_in_state already (void) casts the drm_crtc and the old
> >> drm_crtc_state to silence unused-but-set-variable warning. Should we maybe
> >> (void) cast the new crtc_state as well?
> > 
> > From what I saw, it only void casts the ones which aren't assigned.
> 
> How do you mean? I wonder if
> 
>  #define for_each_oldnew_crtc_in_state(__state, crtc, old_crtc_state, new_crtc_state, __i) \
>         for ((__i) = 0;                                                 \
>              (__i) < (__state)->dev->mode_config.num_crtc;              \
>              (__i)++)                                                   \
>                 for_each_if ((__state)->crtcs[__i].ptr &&               \
>                              ((crtc) = (__state)->crtcs[__i].ptr,       \
>                               (void)(crtc) /* Only to avoid unused-but-set-variable warning */, \
>                              (old_crtc_state) = (__state)->crtcs[__i].old_state, \
>                              (void)(old_crtc_state) /* Only to avoid unused-but-set-variable warning */, \
> -                            (new_crtc_state) = (__state)->crtcs[__i].new_state, 1))
> +                            (new_crtc_state) = (__state)->crtcs[__i].new_state, \
> +                            (void)(new_crtc_state), 1))
> 
> wouldn't be better.

That also works for me.  I can fix this up.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
