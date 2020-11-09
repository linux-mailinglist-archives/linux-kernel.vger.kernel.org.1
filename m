Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 313A52AC5A9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 21:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730379AbgKIUAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 15:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgKIUAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 15:00:01 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9872C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 12:00:00 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id d142so688890wmd.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 12:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=iSLk3+x7uenqlILFpaNoxyCB9G64i4wec0N4zPVtLds=;
        b=NBO0ty9u54emHjnfEXXnFOBSllklLV+aYFoqGVp5cQ9mAb56Dl+sd3zn/rP+aUSIzf
         DFCvXXhk001k2PTIsBSRdUzu2sUFlU6XVcNPdNhZsFvci9JTb2r6z/4FueX9Hq9e1MfU
         lzhOt4sbxh89rgwgXrX9BXrkVBx0pbqW9jaUjGALtGIA5+q9QPjAPt5ZWJlCD671pgeA
         bjemtpPIbR9qJ9S+0a7d+rfrgx6BcI5+GNi1mIE1yBCsZ4wudlv+S6WRhNhDnN6CH8nL
         FC8JRh+VSLieTqgZWyqK2OBEZ0sRn95k2W9ULT0oMOvw18vmnxJ4muh6Cb6rF+ToKQIv
         iOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iSLk3+x7uenqlILFpaNoxyCB9G64i4wec0N4zPVtLds=;
        b=ITdJOTAy/hr5W6BGjYdLdAA0Zfq1Au3Vqjg8sY4vrvtrjc6NFgqoQOGiSqiYYYtRWk
         Zx/ozL7xJTeA9ZOzTrOnqZupwv4tvyc1pJUuLBlDWv1P7e7abGVFXuStpQKJL7HxwekM
         hP0S88ddWZ67Cr+G33sJiNzmvbKZoVILDIv2aPh0GzZz56pEvG9umjUuZn/VirrH7+kG
         SoAFNqFQUOoH7ZTQocuhNgvhY2D/E6MN59egoiehhZt3PI0Yflq23nKZ1wwnBPW/2MPM
         4UzzIb8MCKVA1EwSvCbdZYlTK4osuyLnx2iofJHG8AWZOsVnX4nh5MlVhfMgN26W9tEb
         d2pQ==
X-Gm-Message-State: AOAM533pU3HEKrradF2neJPI6sHXxzQnGJv+8VzoBQjhQW/8TnHJB0r2
        XvnwgnqWs9rOFpKY0Tm8/RVkkg==
X-Google-Smtp-Source: ABdhPJwldywwbJ+oLDqj/fDJgp5SEWiJ5ZwxUHvawP8CtF53/49IYzNhHipfLfFh1313dpVLWLMYLg==
X-Received: by 2002:a1c:61c2:: with SMTP id v185mr839625wmb.152.1604951999546;
        Mon, 09 Nov 2020 11:59:59 -0800 (PST)
Received: from dell ([91.110.221.139])
        by smtp.gmail.com with ESMTPSA id f23sm463349wmb.43.2020.11.09.11.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 11:59:58 -0800 (PST)
Date:   Mon, 9 Nov 2020 19:59:57 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 17/19] drm/radeon/radeon_kms: Fix misnaming of
 'radeon_info_ioctl's dev param
Message-ID: <20201109195957.GB2063125@dell>
References: <20201106214949.2042120-1-lee.jones@linaro.org>
 <20201106214949.2042120-18-lee.jones@linaro.org>
 <CADnq5_Nys7igVo3sgzK0D4hnm=RHMrEM7Xty80jGROu_sy5svA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_Nys7igVo3sgzK0D4hnm=RHMrEM7Xty80jGROu_sy5svA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Nov 2020, Alex Deucher wrote:

> On Fri, Nov 6, 2020 at 4:50 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
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
> 
> This should be:
> + * @dev: drm device pointer

Makes sense.  If you don't fancy fixing this up, I'll send out a
fix-up in a few days.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
