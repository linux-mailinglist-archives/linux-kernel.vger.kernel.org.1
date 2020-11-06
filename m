Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE682A9098
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 08:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgKFHn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 02:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgKFHn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 02:43:27 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346D6C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 23:43:27 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id n18so262873wrs.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 23:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=WJgh+HBEsu1L1fjOdFQAJ5Y/gWjpi18ppr+5ULtL5qQ=;
        b=wRDfZ8rBweH6dZ5gW8C9cmrOxkAd2nBXFXxmFIdONmPF89lhHUhKrhTu3ada4fz+q/
         fckGDjsSMIJoJssQ7RTW3mhwSDrviDIeCMKuBCu2IwbDD/KW/3xs6ghyECza8Jmv4tIM
         lm/FLIn76J4Ie742EwKk51fWMP5gmc6tU8FR+rN9Es6s+5Cet/6i3G+YtRi7B9t7l0BZ
         uIJwoSascDCM1zFXXc6T10nWceHAH04y8C5h7HJvVt+DPKyGvdRsDxjMSdUy3lSiZvXz
         c098BK105g5fxqaJXxP9jGlpXOv1mOxif4FBMmTaHwyYaosQ+AXYjZqnKRk/RE4FJ+OZ
         xxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WJgh+HBEsu1L1fjOdFQAJ5Y/gWjpi18ppr+5ULtL5qQ=;
        b=NEhNb5MYWaJubItzvN9KmDD99sM4qfsEANuO3O2mkboB+LWaydqqVNQRmJemP6gk3t
         MrAP08YhOcW44i5apAGOcFzph/nh7RfFbI71ZUguUjHbKxGzZMHEEGmaEKESB6r+ANf8
         d+irWDubY87HfyG+jzghf5zirSbeGshnHoa/3kDkCJ18+W183NlQBFZZBitkmuD6ldX+
         BqmUrUzPulG94lpTLAeQBekpVGz9s14d27+3kMh2DLJ+8IQzM4FHqcpX2mzy8l2NDP5X
         eQ5u7VlY3ew/rwdpIfegE1Hkq4FK/0egeGAhhPhMFQaG/SLTli4sIjhgGPziFOAFvvXQ
         Xx6A==
X-Gm-Message-State: AOAM533NPFwn7GiZBvJf/XZiLXehhE0Hq0b0Sm53pNq15XDqEkPhNXhR
        upx28y9/bm4gpxPKJ9XywpQvdM2UezYQroEB
X-Google-Smtp-Source: ABdhPJyXDJSa31dfpTNuFZUt+9VFZTh4F6QW6PeZfl2cF/azUnMMw+f3Q1NUdj1PDZSSXIJ4Am3fqw==
X-Received: by 2002:adf:e486:: with SMTP id i6mr1090487wrm.397.1604648605819;
        Thu, 05 Nov 2020 23:43:25 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id u195sm975234wmu.18.2020.11.05.23.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 23:43:25 -0800 (PST)
Date:   Fri, 6 Nov 2020 07:43:23 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 16/19] gpu: drm: panel: panel-ilitek-ili9322: Demote
 non-conformant kernel-doc header
Message-ID: <20201106074323.GV4488@dell>
References: <20201105144517.1826692-1-lee.jones@linaro.org>
 <20201105144517.1826692-17-lee.jones@linaro.org>
 <20201105211742.GD216923@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201105211742.GD216923@ravnborg.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Nov 2020, Sam Ravnborg wrote:

> Hi Lee.
> 
> On Thu, Nov 05, 2020 at 02:45:14PM +0000, Lee Jones wrote:
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/gpu/drm/panel/panel-ilitek-ili9322.c:177: warning: Enum value 'ILI9322_INPUT_SRGB_THROUGH' not described in enum 'ili9322_input'
> >  drivers/gpu/drm/panel/panel-ilitek-ili9322.c:177: warning: Enum value 'ILI9322_INPUT_SRGB_ALIGNED' not described in enum 'ili9322_input'
> >  drivers/gpu/drm/panel/panel-ilitek-ili9322.c:177: warning: Enum value 'ILI9322_INPUT_SRGB_DUMMY_320X240' not described in enum 'ili9322_input'
> >  drivers/gpu/drm/panel/panel-ilitek-ili9322.c:177: warning: Enum value 'ILI9322_INPUT_SRGB_DUMMY_360X240' not described in enum 'ili9322_input'
> >  drivers/gpu/drm/panel/panel-ilitek-ili9322.c:177: warning: Enum value 'ILI9322_INPUT_DISABLED_1' not described in enum 'ili9322_input'
> >  drivers/gpu/drm/panel/panel-ilitek-ili9322.c:177: warning: Enum value 'ILI9322_INPUT_PRGB_THROUGH' not described in enum 'ili9322_input'
> >  drivers/gpu/drm/panel/panel-ilitek-ili9322.c:177: warning: Enum value 'ILI9322_INPUT_PRGB_ALIGNED' not described in enum 'ili9322_input'
> >  drivers/gpu/drm/panel/panel-ilitek-ili9322.c:177: warning: Enum value 'ILI9322_INPUT_YUV_640X320_YCBCR' not described in enum 'ili9322_input'
> >  drivers/gpu/drm/panel/panel-ilitek-ili9322.c:177: warning: Enum value 'ILI9322_INPUT_YUV_720X360_YCBCR' not described in enum 'ili9322_input'
> >  drivers/gpu/drm/panel/panel-ilitek-ili9322.c:177: warning: Enum value 'ILI9322_INPUT_DISABLED_2' not described in enum 'ili9322_input'
> >  drivers/gpu/drm/panel/panel-ilitek-ili9322.c:177: warning: Enum value 'ILI9322_INPUT_ITU_R_BT656_720X360_YCBCR' not described in enum 'ili9322_input'
> >  drivers/gpu/drm/panel/panel-ilitek-ili9322.c:177: warning: Enum value 'ILI9322_INPUT_ITU_R_BT656_640X320_YCBCR' not described in enum 'ili9322_input'
> >  drivers/gpu/drm/panel/panel-ilitek-ili9322.c:177: warning: Enum value 'ILI9322_INPUT_UNKNOWN' not described in enum 'ili9322_input'
> > 
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Cc: Sam Ravnborg <sam@ravnborg.org>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Applied to drm-misc-next.

Thanks for all these Sam.

Any idea what happens to the other patches?

Do they go in via a different Maintainer?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
