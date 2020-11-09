Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54CCD2AC6BB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 22:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730493AbgKIVPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 16:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729336AbgKIVPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 16:15:33 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4548C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 13:15:32 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id t67so890663wmt.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 13:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cPfEKs3WQgi21dRprWvl0/cuPQQi8MnROC+cTFK/Hjk=;
        b=VK/PVkAs5xGOczSmdLeGGr1UjLAa1wNkT5KEULJPwAMYtTFospgWvQXmWweWxFrYSL
         q6U6xZf7/8yQcSPJDC9gc29/HZUDZJQxumZl8PUVUzDZQgsTT+tLbqAImT1M6MeJXwyZ
         oV7xNWvQnVaFCxNiqpxB+3voW1ZQ3/8BmZefBXukvEHYKHRH7eqIWIdfbW70msWZCwkK
         JvZY5XZ8k+JRvZILBg43HeLT/GvQXGoyf2hxdUCenBQmb+mura13aVQ8f3Xswo3giyBh
         18whO+eWLkOIZibns4Aiol1Az1LfYRH8imLmYxYgEPw2BD7hcD8kAl5lsTKjRErlRI3g
         nKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cPfEKs3WQgi21dRprWvl0/cuPQQi8MnROC+cTFK/Hjk=;
        b=rKsVmoLdP8WSQbEjjq/jUjbzTrQ094BJH75rqZQ/IXlvl8huUSN67xgcuzf/d9uRV3
         JR7IFhxT11SLPbcNmvWC8zdAG7B/akH43egC6G/8LuNLGRw3kpdF3EkoCPbizQ+d3qeh
         aZ0vi8gYHMdO6cWRH2bhvSaVYuJdB3A1OGwWUCcbXP1+P9budlP3egvz0mUUIX10BABr
         vamBPtmOw1MvkTpUXpi5KIRO0CW+9cElHT8Sup+1/4ThrC0Fn+WmMkHi7N3NEgChpYJ4
         GNQi8uoMyk/wpASCKWrRhq8WXwqhSEHP+/Cq6eYbzW61QP85eYJtiu0g1tgxJVd2sH8+
         YdoQ==
X-Gm-Message-State: AOAM533SKMAoAHMjHleY+CNa5LnW7ty77D0BrBdKvJiq/gOvEBsZjDkB
        d6yyq68+VxetlI6PESJnwltkjw==
X-Google-Smtp-Source: ABdhPJxyV7TDW5Pt0GMSmlw9Wcknf4YsuZ7MwnLmYcynaZ+tHhjDvCCTux+hN1vU/Ah+Y0DkH8bbAw==
X-Received: by 2002:a1c:4d03:: with SMTP id o3mr1161753wmh.150.1604956531356;
        Mon, 09 Nov 2020 13:15:31 -0800 (PST)
Received: from dell ([91.110.221.139])
        by smtp.gmail.com with ESMTPSA id 35sm12713729wro.71.2020.11.09.13.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 13:15:30 -0800 (PST)
Date:   Mon, 9 Nov 2020 21:15:28 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 17/19] drm/radeon/radeon_kms: Fix misnaming of
 'radeon_info_ioctl's dev param
Message-ID: <20201109211528.GD2063125@dell>
References: <20201106214949.2042120-1-lee.jones@linaro.org>
 <20201106214949.2042120-18-lee.jones@linaro.org>
 <CADnq5_Nys7igVo3sgzK0D4hnm=RHMrEM7Xty80jGROu_sy5svA@mail.gmail.com>
 <20201109195557.GA1940813@ravnborg.org>
 <20201109201013.GC2063125@dell>
 <20201109205236.GA1952447@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201109205236.GA1952447@ravnborg.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Nov 2020, Sam Ravnborg wrote:

> On Mon, Nov 09, 2020 at 08:10:13PM +0000, Lee Jones wrote:
> > On Mon, 09 Nov 2020, Sam Ravnborg wrote:
> > 
> > > Hi Alex,
> > > On Mon, Nov 09, 2020 at 02:50:35PM -0500, Alex Deucher wrote:
> > > > On Fri, Nov 6, 2020 at 4:50 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > > >
> > > > > Fixes the following W=1 kernel build warning(s):
> > > > >
> > > > >  drivers/gpu/drm/radeon/radeon_kms.c:226: warning: Function parameter or member 'dev' not described in 'radeon_info_ioctl'
> > > > >  drivers/gpu/drm/radeon/radeon_kms.c:226: warning: Excess function parameter 'rdev' description in 'radeon_info_ioctl'
> > > > >
> > > > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > > > Cc: "Christian König" <christian.koenig@amd.com>
> > > > > Cc: David Airlie <airlied@linux.ie>
> > > > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > > > Cc: amd-gfx@lists.freedesktop.org
> > > > > Cc: dri-devel@lists.freedesktop.org
> > > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > > ---
> > > > >  drivers/gpu/drm/radeon/radeon_kms.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/radeon/radeon_kms.c
> > > > > index 0d8fbabffcead..21c206795c364 100644
> > > > > --- a/drivers/gpu/drm/radeon/radeon_kms.c
> > > > > +++ b/drivers/gpu/drm/radeon/radeon_kms.c
> > > > > @@ -213,7 +213,7 @@ static void radeon_set_filp_rights(struct drm_device *dev,
> > > > >  /**
> > > > >   * radeon_info_ioctl - answer a device specific request.
> > > > >   *
> > > > > - * @rdev: radeon device pointer
> > > > > + * @dev: radeon device pointer
> > > > 
> > > > This should be:
> > > > + * @dev: drm device pointer
> > > 
> > > good spot. I am continuing the work on radeon and will post a patchset
> > > that contains only radeon fixes with Lee's patches and a few more by me.
> > > I will fix the above.
> > 
> > What do you mean by "continuing on"?
> > 
> > How will you prevent your work from conflicting with my current effort?
> 
> Quoting from previous mail in this thread:
> 
>   "
>   > > How would you like me to move forward?
>   >
>   > Fix the thousand of warnings in other places :-)
>   > I will take a look at radeon and post a new series based on your work
>   > with all W=1 warnings fixed.
> 
>   I'll drop this patch and carry on ploughing through the rest of them.
> "
> 
> Here I promised you to fix all warnings in the radeon driver.
> And despite this being more work than anticipated a promise is a
> promise. So therefore I started working on this.
> 
> If you want to do the rest of the radeon driver you are welcome and I
> will gladly drop this again. Just let me know your preference.

That was the plan.  To continue on and solve as many warnings as I can
before I start bumping into more serious issues like the one mentioned
above.  If you'd like to solve the radeon_init() issue right away;
however, that would be super helpful.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
