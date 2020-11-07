Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 754222AA620
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 16:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgKGPNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 10:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgKGPNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 10:13:49 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A93DC0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Nov 2020 07:13:48 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id a65so4003970wme.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Nov 2020 07:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Fe6CFZHB4eN2243CFprUL/n+G4vxgYInJJ6wj8YKWBk=;
        b=yxte38245MaYCKkeFpeoucGOLM90V4xE3nz3Cnj3+Pam0t1F1fbMS9wC9MundIMK2H
         UPpv/s3qUlbyQ01axD3II1Z2BuBIDINgXKwK2bhp+vaisZiHk8VTRAbqY8tzzKxgEU9M
         E3GiuyMz1aPvkPSGfy0Rw0HBumWxid8ptFtJOzcgegABv758cPFg4Fi2/SarChNNob1s
         E2C//PdsYp1Sok8XurQ1QdtUexRfPcjHbcN37l8HpHhDpfsyGgWi5n0VtIOA0z+mpBhk
         yTJVLKMMUL/ibfnKoPsTUVZ+PiKhaeuOMpHLv2gghWo190HmeMHu687awnTuITzS+hTM
         Fouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Fe6CFZHB4eN2243CFprUL/n+G4vxgYInJJ6wj8YKWBk=;
        b=BeioXKHoBuQXe+8aOzu2Zr7YdjPD1tG2GL4+7NWgCQxVqf8YnQBWm4QeHL1oGqTdQM
         tKNksZUoQL9EF5ub6Ko0zBXaiPW8ykgniM1o5GHf7D+yrPhA3J0EJsrxocFUFk8VgkH5
         zzk2CXiv0HYzbPFMt1jr8iLpMWzBoIYoqA7TEH0KRw6jIbuLQ1k2hC15y6Eyaigjicnf
         7cfB2jnDLQTf5SQdx2CAUpZ5YpxrGEo2yqTmFlAWarZ9sSaAjFJT3v8IH8EnemuNw0V4
         NJGThddHZXQutRzXgwDvEAWAHppEfDVX43pmM2D633JE60nLfbPTEIbcgULSCusNjr6C
         ZtXg==
X-Gm-Message-State: AOAM533XNEByZZbaPzcD+PqLNphZLBvDHwrbQD2yhr9w2LCP1k1y17TW
        bxwICUdDprxj5hES9L/r7g2CepRwX3TX5GOs
X-Google-Smtp-Source: ABdhPJy6Ii661kV3KJTNGTIaBkDIcEjLcbtut88fwfWuPoGhumpi22jfpd/9QuNPLMHXcJ8vc855nQ==
X-Received: by 2002:a1c:f417:: with SMTP id z23mr4969499wma.57.1604762026726;
        Sat, 07 Nov 2020 07:13:46 -0800 (PST)
Received: from dell ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id l16sm6447087wrr.83.2020.11.07.07.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 07:13:46 -0800 (PST)
Date:   Sat, 7 Nov 2020 15:13:42 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 17/19] drm/radeon/radeon_kms: Fix misnaming of
 'radeon_info_ioctl's dev param
Message-ID: <20201107151342.GQ2063125@dell>
References: <20201106214949.2042120-1-lee.jones@linaro.org>
 <20201106214949.2042120-18-lee.jones@linaro.org>
 <20201107142919.GB1014611@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201107142919.GB1014611@ravnborg.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 07 Nov 2020, Sam Ravnborg wrote:

> Hi Lee,
> 
> On Fri, Nov 06, 2020 at 09:49:47PM +0000, Lee Jones wrote:
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/gpu/drm/radeon/radeon_kms.c:226: warning: Function parameter or member 'dev' not described in 'radeon_info_ioctl'
> >  drivers/gpu/drm/radeon/radeon_kms.c:226: warning: Excess function parameter 'rdev' description in 'radeon_info_ioctl'
> > 
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: "Christian König" <christian.koenig@amd.com>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: amd-gfx@lists.freedesktop.org
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/gpu/drm/radeon/radeon_kms.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/radeon/radeon_kms.c
> > index 0d8fbabffcead..21c206795c364 100644
> > --- a/drivers/gpu/drm/radeon/radeon_kms.c
> > +++ b/drivers/gpu/drm/radeon/radeon_kms.c
> > @@ -213,7 +213,7 @@ static void radeon_set_filp_rights(struct drm_device *dev,
> >  /**
> >   * radeon_info_ioctl - answer a device specific request.
> >   *
> > - * @rdev: radeon device pointer
> > + * @dev: radeon device pointer
> >   * @data: request object
> >   * @filp: drm filp
> >   *
> 
> Delete all the kernel-doc annotation as we do not pull this file into
> the kernel-doc anyway.
> 
> Keep the /* Answer a device specific request */ part.
> 
> At least thats what I see as the best way to deal with it.

Demoting all headers, even if they are conformant, it not the way to
go.  Some contributors/maintainers prefer to keep the kernel-doc
(pretty colours, automated checking [a la, this patch!] and the-like)
formatting, even if they are not directly referenced from
/Documentation.

For now, so long as the build is happy, I am happy.

If you wish to make the build unhappy about this, you should take up
the argument to encompass `scripts/find-unused-docs.sh` into it.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
