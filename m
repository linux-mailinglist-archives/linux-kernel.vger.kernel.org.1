Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A7E2AC5B9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 21:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730416AbgKIUGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 15:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729835AbgKIUGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 15:06:20 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0CDC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 12:06:19 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id p8so9346522wrx.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 12:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Iy1xPaJP1RLahUMonTQA7uwMfpq1Q9nhzx/7OzBh5HI=;
        b=gR+OwL0DSP3nmXja2FT2NQXa3GZBLkj208UVIlNZNLAPmOm7McX378MITBppNVwqB5
         knZvmVAu1X+9c5EKNS+CowCbGgJOV5oVWllrajuwHPUUFA7bcM9ZXFyXQKlQe8Cb6LQh
         ICCdyVqoQsPtk32JZkY4hTvaE4j4iQZ213dA4emsRmEhbuxf49pEUIbLvot707yA4IVt
         ToqCUdzYnArRvfPzQg3pvUCLe5vrmb6HAgctbDq5lNlQFkQ6VLR4VtQrcwQq/+i9RyMA
         5DQzu0vtpYwtm09pKl0/iEaRkv9FUqE+bQAWFMWPyr3wfYetrfp3GZE/3fka+TxTM9+8
         FlWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Iy1xPaJP1RLahUMonTQA7uwMfpq1Q9nhzx/7OzBh5HI=;
        b=TVmvoMPsyC6FfNi94lnSBdAhjbfvDxNBtsgi1aqW+FZA438vGK53MRvoaMlCiYtmoV
         oINVEcvotFf3qkv+TzSnIUdtzVKqPaopw/5l/+BO3xJ5MAlEq+1iMGksiAEjee12Wa0H
         9adMocGJDNY7Wvq6IUq03qLSs6GXZxx42ztzBHMibWBTRMERG9YUrFq/Hsyo3wWLygdJ
         FVU6cON1PI+AAp7RleHgUgmC+o2j/ZVeqpdfRG6zoawjeOplkF/0xyb6rJtuQYvyUN5C
         j1gujoIoSXwAIEtZCj1mfT+5D+xb6ohSsVouCgSOD9rGmoILYsC6HHhsQSSOLaoi56Ck
         Y1vg==
X-Gm-Message-State: AOAM5313ZwXurgJGidauGwGBMIJDVcTwbNHjnwr5+ibXMve6H2YIF1ha
        bnPjPNuQwr/Jy0GasRnIh6xOSuPI4VXTF6XkLBGv8KfR
X-Google-Smtp-Source: ABdhPJzYSuaz92h+G6EWiAsIK4TeCchRsXCbsrwZAHYNgu49K7nh20b/IWe3P2GMd5scEfGAOk788sEEoW5SZ6Z/gTU=
X-Received: by 2002:adf:e8d0:: with SMTP id k16mr19681883wrn.362.1604952378759;
 Mon, 09 Nov 2020 12:06:18 -0800 (PST)
MIME-Version: 1.0
References: <20201106214949.2042120-1-lee.jones@linaro.org>
 <20201106214949.2042120-18-lee.jones@linaro.org> <CADnq5_Nys7igVo3sgzK0D4hnm=RHMrEM7Xty80jGROu_sy5svA@mail.gmail.com>
 <20201109195557.GA1940813@ravnborg.org>
In-Reply-To: <20201109195557.GA1940813@ravnborg.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 9 Nov 2020 15:06:07 -0500
Message-ID: <CADnq5_PpjYOwk1a=ioHXpeK239ToDS3GeObutiWBQ6OWK2i9Ug@mail.gmail.com>
Subject: Re: [PATCH 17/19] drm/radeon/radeon_kms: Fix misnaming of
 'radeon_info_ioctl's dev param
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Lee Jones <lee.jones@linaro.org>, David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 9, 2020 at 2:56 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Alex,
> On Mon, Nov 09, 2020 at 02:50:35PM -0500, Alex Deucher wrote:
> > On Fri, Nov 6, 2020 at 4:50 PM Lee Jones <lee.jones@linaro.org> wrote:
> > >
> > > Fixes the following W=3D1 kernel build warning(s):
> > >
> > >  drivers/gpu/drm/radeon/radeon_kms.c:226: warning: Function parameter=
 or member 'dev' not described in 'radeon_info_ioctl'
> > >  drivers/gpu/drm/radeon/radeon_kms.c:226: warning: Excess function pa=
rameter 'rdev' description in 'radeon_info_ioctl'
> > >
> > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> > > Cc: David Airlie <airlied@linux.ie>
> > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > Cc: amd-gfx@lists.freedesktop.org
> > > Cc: dri-devel@lists.freedesktop.org
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >  drivers/gpu/drm/radeon/radeon_kms.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/ra=
deon/radeon_kms.c
> > > index 0d8fbabffcead..21c206795c364 100644
> > > --- a/drivers/gpu/drm/radeon/radeon_kms.c
> > > +++ b/drivers/gpu/drm/radeon/radeon_kms.c
> > > @@ -213,7 +213,7 @@ static void radeon_set_filp_rights(struct drm_dev=
ice *dev,
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

Awesome.  Thanks!

Alex
