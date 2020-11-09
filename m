Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48EDB2AC5BF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 21:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbgKIUKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 15:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgKIUKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 15:10:17 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88618C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 12:10:17 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id s8so3068621wrw.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 12:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=isstW/OQk5HF3Gxwa/5PQfQfcdrrAl2gRootGHnfwmg=;
        b=b9PmNSlYDGTXgm8+ZOIIw75Zz9FayKmlZQMBFlq/6mVfAnkO2nu9FcaF8z3RttXIfL
         RO/f2qxY0L6ynfjlbKeCZPMyVwGDZ8bPS2WmdyZemy2grq6uchKDGN2aYda4e/voohrD
         CwWuP4BZaDa2HexXo5kLW3NptPW+USNYlfTX+IBqq56jlF/BNvsQsASxiTjyYyITR2sH
         1wzWJzmaNN2ZFteRqeLGBMDMsXz47vel7gFor5RGXrxvikzV13MMET4OtobqCexiir7T
         wmxgMJsGeysAgpBolAjAjB5Saukm+TsTubOenqrRUR18r7h9ZAzZ7KHLkFcCp2qOF5Qs
         Hqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=isstW/OQk5HF3Gxwa/5PQfQfcdrrAl2gRootGHnfwmg=;
        b=h6X/jBHl5e13QaBbzxhQAnCrzqMtpTb2HvSiqzz4vf6nj/5YDTa2UC960zVMefsSum
         aolhyjspAPC9gO8vgAqNIAj0kEcP1gZdFBbRD6MpXhEu0gg0J0cc4zuSsNmQkhFrXIGB
         1mpwhBFpV4XilVds763bdFsHJGc257SatvcPLdxeV/wlLHu5aoZPN4/xgt4hIh042lml
         +efgK++LqW6EQeQgQBM5g/nENnBeHerhrz0RMVVxwjqFe++Kz/kNoOce4bWb3+h6B6UU
         r+qRAKYLVGxogIx6cOoHwon0eIM/02cQgyOZ1ELwrv8idc/PpSINlzVRsYemg2pTfCWH
         MmmA==
X-Gm-Message-State: AOAM532WTrlTnzjXbfK68FO7QdtmC1UG8TG/0iICH9pafLZaeNSQkyuP
        qNcMh+gxPK3CdIv60p9pEi702g==
X-Google-Smtp-Source: ABdhPJwRP64JX7Dk2MtRgSE5kSbKtijqBvDcNaWUAaSen1GtFQoR1jaGfzfICezOVQkVgHguI9UVxg==
X-Received: by 2002:a5d:474d:: with SMTP id o13mr21094236wrs.178.1604952616295;
        Mon, 09 Nov 2020 12:10:16 -0800 (PST)
Received: from dell ([91.110.221.139])
        by smtp.gmail.com with ESMTPSA id v12sm15258395wro.72.2020.11.09.12.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 12:10:15 -0800 (PST)
Date:   Mon, 9 Nov 2020 20:10:13 +0000
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
Message-ID: <20201109201013.GC2063125@dell>
References: <20201106214949.2042120-1-lee.jones@linaro.org>
 <20201106214949.2042120-18-lee.jones@linaro.org>
 <CADnq5_Nys7igVo3sgzK0D4hnm=RHMrEM7Xty80jGROu_sy5svA@mail.gmail.com>
 <20201109195557.GA1940813@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201109195557.GA1940813@ravnborg.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Nov 2020, Sam Ravnborg wrote:

> Hi Alex,
> On Mon, Nov 09, 2020 at 02:50:35PM -0500, Alex Deucher wrote:
> > On Fri, Nov 6, 2020 at 4:50 PM Lee Jones <lee.jones@linaro.org> wrote:
> > >
> > > Fixes the following W=1 kernel build warning(s):
> > >
> > >  drivers/gpu/drm/radeon/radeon_kms.c:226: warning: Function parameter or member 'dev' not described in 'radeon_info_ioctl'
> > >  drivers/gpu/drm/radeon/radeon_kms.c:226: warning: Excess function parameter 'rdev' description in 'radeon_info_ioctl'
> > >
> > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > Cc: "Christian König" <christian.koenig@amd.com>
> > > Cc: David Airlie <airlied@linux.ie>
> > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > Cc: amd-gfx@lists.freedesktop.org
> > > Cc: dri-devel@lists.freedesktop.org
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >  drivers/gpu/drm/radeon/radeon_kms.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/radeon/radeon_kms.c
> > > index 0d8fbabffcead..21c206795c364 100644
> > > --- a/drivers/gpu/drm/radeon/radeon_kms.c
> > > +++ b/drivers/gpu/drm/radeon/radeon_kms.c
> > > @@ -213,7 +213,7 @@ static void radeon_set_filp_rights(struct drm_device *dev,
> > >  /**
> > >   * radeon_info_ioctl - answer a device specific request.
> > >   *
> > > - * @rdev: radeon device pointer
> > > + * @dev: radeon device pointer
> > 
> > This should be:
> > + * @dev: drm device pointer
> 
> good spot. I am continuing the work on radeon and will post a patchset
> that contains only radeon fixes with Lee's patches and a few more by me.
> I will fix the above.

What do you mean by "continuing on"?

How will you prevent your work from conflicting with my current effort?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
