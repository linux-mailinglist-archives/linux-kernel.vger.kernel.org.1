Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB3222AC593
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 20:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730952AbgKIT4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 14:56:04 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:52964 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729432AbgKIT4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 14:56:04 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 9DB822003C;
        Mon,  9 Nov 2020 20:55:58 +0100 (CET)
Date:   Mon, 9 Nov 2020 20:55:57 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 17/19] drm/radeon/radeon_kms: Fix misnaming of
 'radeon_info_ioctl's dev param
Message-ID: <20201109195557.GA1940813@ravnborg.org>
References: <20201106214949.2042120-1-lee.jones@linaro.org>
 <20201106214949.2042120-18-lee.jones@linaro.org>
 <CADnq5_Nys7igVo3sgzK0D4hnm=RHMrEM7Xty80jGROu_sy5svA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_Nys7igVo3sgzK0D4hnm=RHMrEM7Xty80jGROu_sy5svA@mail.gmail.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VbvZwmh9 c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=8nJEP1OIZ-IA:10 a=KKAkSRfTAAAA:8 a=zd2uoN0lAAAA:8 a=e5mUnYsNAAAA:8
        a=kWTj0bnMZsTtkSb_LzgA:9 a=wPNLvfGTeEIA:10 a=cvBusfyB2V15izCimMoJ:22
        a=Vxmtnl_E_bksehYqCbjh:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,
On Mon, Nov 09, 2020 at 02:50:35PM -0500, Alex Deucher wrote:
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

good spot. I am continuing the work on radeon and will post a patchset
that contains only radeon fixes with Lee's patches and a few more by me.
I will fix the above.

	Sam
