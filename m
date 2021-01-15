Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5E52F8701
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 22:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732055AbhAOU7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 15:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbhAOU70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 15:59:26 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B87EC061757;
        Fri, 15 Jan 2021 12:58:46 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id y17so10583560wrr.10;
        Fri, 15 Jan 2021 12:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JNPQQq0esyAUv0SaJP9M+5H+0D0Ooff203N1KcpXtkI=;
        b=bjN1pCMQoob0hn1vxVNxALaWBggxOr0JAwGKdyH4dFjGsCcgrrK67crS2mMfYlL4R4
         Z3uHdnlcFVoiBpQom4yFMSCP7L+UPAsy2QS+pyl/BUjm+PT89w8JRFtGjNC127fwC/1F
         Pl9hGF3H/dzAsSAn+BSplb2+LKZ+JjIUCTYi7KrhnjElKScVeSOnpzX9xSn8TEw4eZRE
         n6EObZ+TIPvIr8aYbNRZuj3J01f47zRfn2wGL0uU8d/7VenVI7xG1GAQ8XVAg/a98aZj
         DXprMuplm5mNOn/u3HhgeuNA9YNUBGxWfS3cCllex8x+0w7uGhz6vh/XKSPOdHLkerX5
         7Qqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JNPQQq0esyAUv0SaJP9M+5H+0D0Ooff203N1KcpXtkI=;
        b=EOBhh8EJtUMug1EcP3ke2uGgwRuiQ3EcXEa9Or0U1l11O9gGGKacMBlCXUJ0uEGC2f
         pBmEs4Cw/fKclBM6946eYUEgHUGr0NXCzZ2wmjgmj6LxKVHF2Ftr1Gq9wu831Uan2feU
         2kUlhi5fof1r5UpWxJKZU0dDsEyp0NkftTFG2wVaXB7bxt250/MlyAe1DxHBw3LJeEbA
         fqrvNwHEBO9EJpU/xxcKnhYM+QzvEHSl3jarQHe6uCIIigl+yznzTZCAJ78/vJe+ouq4
         7bHW7Q+FiGzQMEPcuBGjzMpKL2ZZ6FWGkMYlo4QlI/HCgPSe7Qt25XlUO8RuCtnShjjs
         5GuA==
X-Gm-Message-State: AOAM530/Vqjx+5Zb+SL4seNEfKrIuvygnWaT+SN3cc6EB+QGPB8khZzW
        ov/2+NYFnbT7fFHzMSFCMdiYUyyHaLyheQ==
X-Google-Smtp-Source: ABdhPJxBjBNQ3eVsS6Me/YyVKPaoeFY86umXQH74NxE82tUEBDOT0B3bzYaEh4RJgUVktwEZLs4QyQ==
X-Received: by 2002:a5d:4e51:: with SMTP id r17mr15130734wrt.94.1610744325301;
        Fri, 15 Jan 2021 12:58:45 -0800 (PST)
Received: from smtp.gmail.com (a95-92-181-29.cpe.netcabo.pt. [95.92.181.29])
        by smtp.gmail.com with ESMTPSA id h14sm16016927wrx.37.2021.01.15.12.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 12:58:44 -0800 (PST)
Date:   Fri, 15 Jan 2021 17:58:38 -0300
From:   Melissa Wen <melissa.srw@gmail.com>
To:     Sumera Priyadarsini <sylphrenadin@gmail.com>
Cc:     Colin King <colin.king@canonical.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/vkms: Fix missing kmalloc allocation failure
 check
Message-ID: <20210115205838.7hff6mmyyl55pgek@smtp.gmail.com>
References: <20210115130911.71073-1-colin.king@canonical.com>
 <CACAkLuqG+4cq9w9=JEjB-5KPcxu==2+Sen6GMknM495vELgEFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACAkLuqG+4cq9w9=JEjB-5KPcxu==2+Sen6GMknM495vELgEFA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/15, Sumera Priyadarsini wrote:
> On Fri, Jan 15, 2021 at 6:39 PM Colin King <colin.king@canonical.com> wrote:
> >
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > Currently the kmalloc allocation for config is not being null
> > checked and could potentially lead to a null pointer dereference.
> > Fix this by adding the missing null check.
> >
> > Addresses-Coverity: ("Dereference null return value")
> > Fixes: 2df7af93fdad ("drm/vkms: Add vkms_config type")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> Good catch, thank you!
> 
> Reviewed-by: Sumera Priyadarsini <sylphrenadin@gmail.com>

Applied to drm-misc-next.

Thanks,
Melissa Wen
> > ---
> >  drivers/gpu/drm/vkms/vkms_drv.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> > index 708f7f54001d..2173b82606f6 100644
> > --- a/drivers/gpu/drm/vkms/vkms_drv.c
> > +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> > @@ -188,7 +188,11 @@ static int vkms_create(struct vkms_config *config)
> >
> >  static int __init vkms_init(void)
> >  {
> > -       struct vkms_config *config = kmalloc(sizeof(*config), GFP_KERNEL);
> > +       struct vkms_config *config;
> > +
> > +       config = kmalloc(sizeof(*config), GFP_KERNEL);
> > +       if (!config)
> > +               return -ENOMEM;
> >
> >         default_config = config;
> >
> > --
> > 2.29.2
> >
> regards,
> Sumera
