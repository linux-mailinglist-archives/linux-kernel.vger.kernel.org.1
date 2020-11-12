Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F1D2B1116
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 23:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbgKLWKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 17:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727483AbgKLWKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 17:10:52 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D3EC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 14:10:42 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id p19so7018103wmg.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 14:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0qnbq+VtAYJrqLWmWFv2NmhXM3gXrWp9ucRRD3D1vUY=;
        b=iurwi1R3VHGsEx/f+7EjFPiApRwfwXMCzMmqI1yZLs+X4Wz84WVe3aHLMI4/r074Ik
         1mrFDwWH6SdRYYfV9I8eiEQN03vjyaTp+IGIVjtVhaGB4rpD3Lc/lpl/XPpmkLEayseP
         kj29vLukJL9y/nm+6MCJofb8j136/9ir9GAFOs0xqmKnny1Z4npsaIiZ6x4GvfYEojJr
         Dsv8i0Kj33Z/VBn1IOW8kE+O9qXoxW4ani7DZIQqh1yPZqGEnOXc39ofXOsZqLEeb/aO
         WuVrCpYK9dlpqPUGvwVHdEyEMqls6Cn9Xlc/hypn+WAU3WV67YzLQePmL/AC9lzIS8Vr
         m+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0qnbq+VtAYJrqLWmWFv2NmhXM3gXrWp9ucRRD3D1vUY=;
        b=lgddYTB+BKFG4FHopECoKH8KZhE+gFYJtmL1qOAzahcH6TL5rTyS+ViM3GVngDCTlv
         I2ZVUrubLPXyYG6yj5L3FGkvJORLgmRp9eEZVS3SHa/b0Td/9KJOKRpkmvWObddTSq9E
         HFMLuUnqvCtZCWfDoBzonEGMCdjXcbD6t8DH6FlWR9q0bm0PB1/BNTNWVZLQEtVQWLNu
         UFje07NRWizY3mXMeUYSWmpLcAvqE7t5mhdHr5GMWwvH1Hf5/MOgalFDCnags0IFuzxn
         I/4i1tkgHTcrylhMhpTwY18B/5yHRIMUwAHRQ8j5SE1Yenk141YfJGdq7PVxwrUNlIrE
         5lUQ==
X-Gm-Message-State: AOAM5315Ti7aMOLvTIKqJiZGgHwUs8FxDWG2EZxxRgsMGk6Dd6rnDJuz
        oRmfOTxhTXmWKVpIh+sWoLF7Hu3TRcArVaWO
X-Google-Smtp-Source: ABdhPJwXjIC56WmbtyzjCCg4PGgk5NPg/06k7kufDSxq/IJGoMM1EPx00nmBb+swVbwgtTquGjcb0g==
X-Received: by 2002:a05:600c:230e:: with SMTP id 14mr1731202wmo.119.1605219041178;
        Thu, 12 Nov 2020 14:10:41 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id q2sm8388986wru.76.2020.11.12.14.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 14:10:40 -0800 (PST)
Date:   Thu, 12 Nov 2020 22:10:38 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 29/30] drm/amd/amdgpu/atombios_encoders: Remove set but
 unused variable 'backlight_level'
Message-ID: <20201112221038.GC2787115@dell>
References: <20201112190039.2785914-1-lee.jones@linaro.org>
 <20201112190039.2785914-30-lee.jones@linaro.org>
 <CADnq5_MjzzRhu0zwOeefjGP_mJ2tfTVvK1O5x55dE03kRxDa3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_MjzzRhu0zwOeefjGP_mJ2tfTVvK1O5x55dE03kRxDa3Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Nov 2020, Alex Deucher wrote:

> On Thu, Nov 12, 2020 at 2:01 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > Fixes the following W=1 kernel build warning(s):
> >
> >  drivers/gpu/drm/amd/amdgpu/atombios_encoders.c: In function ‘amdgpu_atombios_encoder_init_backlight’:
> >  drivers/gpu/drm/amd/amdgpu/atombios_encoders.c:174:5: warning: variable ‘backlight_level’ set but not used [-Wunused-but-set-variable]
> >
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: "Christian König" <christian.koenig@amd.com>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Luben Tuikov <luben.tuikov@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/atombios_encoders.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> > index fa817ebff9804..af87505ad7d57 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> > @@ -171,7 +171,6 @@ void amdgpu_atombios_encoder_init_backlight(struct amdgpu_encoder *amdgpu_encode
> >         struct backlight_properties props;
> >         struct amdgpu_backlight_privdata *pdata;
> >         struct amdgpu_encoder_atom_dig *dig;
> > -       u8 backlight_level;
> >         char bl_name[16];
> >
> >         /* Mac laptops with multiple GPUs use the gmux driver for backlight
> > @@ -207,7 +206,7 @@ void amdgpu_atombios_encoder_init_backlight(struct amdgpu_encoder *amdgpu_encode
> >
> >         pdata->encoder = amdgpu_encoder;
> >
> > -       backlight_level = amdgpu_atombios_encoder_get_backlight_level_from_reg(adev);
> > +       amdgpu_atombios_encoder_get_backlight_level_from_reg(adev);
> 
> We can drop this function call altogether.  We call it again below indirectly.

Will do, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
