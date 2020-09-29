Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8852E27D5C4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 20:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgI2S3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 14:29:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49211 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727876AbgI2S3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 14:29:14 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601404152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TYAfSXWrazU7UOyNHROcvFceLCopxTS9CzVEpwGiPwc=;
        b=IjPs4JNtziVmnC7ww6Y63WZzJVLZ7kNpAlBL7sMgnKipM/WFLLDXVAgey7ZQ/0h6gDenid
        WBdXO2fVQkTq9nOxdLu7W2plDPeSsAAfX5fsGe0SJjSYZQvxSD9BYieZ9SrYzmvlxBg+3K
        PL4Np2GgXf/jh0S2PfPuWsxEJ2z/3d0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-xjts7mpPMVakNZzZc6N7sA-1; Tue, 29 Sep 2020 14:29:09 -0400
X-MC-Unique: xjts7mpPMVakNZzZc6N7sA-1
Received: by mail-qv1-f72.google.com with SMTP id f21so3068692qve.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 11:29:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=TYAfSXWrazU7UOyNHROcvFceLCopxTS9CzVEpwGiPwc=;
        b=QwnpQdl+h15UCfhjRuYeb4W/V01NIWC4/XSUvh+q03AsRt3uIJSfnGmAxJm+TBUXXT
         aSXVH2pehj+a6zk5MwGmdE39JatwgZK1ik/9UIJ95BjfpBxMVO8gL/pTkCJVq3rob8rP
         0plcXfs8cqgfMJLt0mMS4Msplp0fNn0P1flsuuUb0+hW/Od2ke+bP0SuqjZWJgUOQVeO
         GAkbv3eyekjSflZ1vCb5PXiar5vEkg9guql3MQ08UcDNWBlcQ7t66B5AOQeZLSqs5rUU
         eYXVZd2fWMJYUxRjxXJLJ7uLmjaXQK+XfwczoHG9S9ZHi4YKk5GPJ6zNiAyVRjsBAcWt
         M7tg==
X-Gm-Message-State: AOAM533ZDqOXE0AU2mujb1QwCH9MC9IzMz/5hKwv5v2noBtLeZmRv5bn
        wPwRwsziAOJocWqHEjAzKTVaiMxFwi81HswLcSoXFJ5ldPuloQfIGtzxKvqEwQX6vXQsqvOv8c5
        72x4QdB1PV7WzwUZu2kDZu3jg
X-Received: by 2002:ac8:1763:: with SMTP id u32mr4772921qtk.14.1601404148580;
        Tue, 29 Sep 2020 11:29:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZw2jlokC2NUPyXPDvs/gntWcgD+mmqIi6CX3P+uxJl2tTcMPV+nWWiY1DFs96ewi6/MDXQw==
X-Received: by 2002:ac8:1763:: with SMTP id u32mr4772892qtk.14.1601404148323;
        Tue, 29 Sep 2020 11:29:08 -0700 (PDT)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id z29sm6631580qtj.79.2020.09.29.11.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 11:29:07 -0700 (PDT)
Message-ID: <cc403d8fa9811e57694507213f95d6461b4b1d34.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/kms/nv50-: Fix clock checking algorithm in
 nv50_dp_mode_valid()
From:   Lyude Paul <lyude@redhat.com>
To:     Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     nouveau@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Tue, 29 Sep 2020 14:29:06 -0400
In-Reply-To: <20200929180912.GG6112@intel.com>
References: <20200922210510.156220-1-lyude@redhat.com>
         <20200928130141.GV6112@intel.com>
         <9e12d6c091d18be6253717f33f4c09013361e532.camel@redhat.com>
         <20200929180912.GG6112@intel.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-09-29 at 21:09 +0300, Ville Syrjälä wrote:
> On Tue, Sep 29, 2020 at 01:54:13PM -0400, Lyude Paul wrote:
> > On Mon, 2020-09-28 at 16:01 +0300, Ville Syrjälä wrote:
> > > On Tue, Sep 22, 2020 at 05:05:10PM -0400, Lyude Paul wrote:
> > > > While I thought I had this correct (since it actually did reject modes
> > > > like I expected during testing), Ville Syrjala from Intel pointed out
> > > > that the logic here isn't correct. max_clock refers to the max symbol
> > > > rate supported by the encoder, so limiting clock to ds_clock using
> > > > max()
> > > > doesn't make sense. Additionally, we want to check against 6bpc for
> > > > the
> > > > time being since that's the minimum possible bpc here, not the
> > > > reported
> > > > bpc from the connector. See:
> > > > 
> > > > https://lists.freedesktop.org/archives/dri-devel/2020-September/280276.html
> > > > 
> > > > For more info.
> > > > 
> > > > So, let's rewrite this using Ville's advice.
> > > > 
> > > > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > > > Fixes: 409d38139b42 ("drm/nouveau/kms/nv50-: Use downstream DP clock
> > > > limits for mode validation")
> > > > Cc: Ville SyrjÃƒÂ¤lÃƒÂ¤ <ville.syrjala@linux.intel.com>
> > > > Cc: Lyude Paul <lyude@redhat.com>
> > > > Cc: Ben Skeggs <bskeggs@redhat.com>
> > > > ---
> > > >  drivers/gpu/drm/nouveau/nouveau_dp.c | 23 +++++++++++++----------
> > > >  1 file changed, 13 insertions(+), 10 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/nouveau/nouveau_dp.c
> > > > b/drivers/gpu/drm/nouveau/nouveau_dp.c
> > > > index 7b640e05bd4cd..24c81e423d349 100644
> > > > --- a/drivers/gpu/drm/nouveau/nouveau_dp.c
> > > > +++ b/drivers/gpu/drm/nouveau/nouveau_dp.c
> > > > @@ -231,23 +231,26 @@ nv50_dp_mode_valid(struct drm_connector
> > > > *connector,
> > > >  		   const struct drm_display_mode *mode,
> > > >  		   unsigned *out_clock)
> > > >  {
> > > > -	const unsigned min_clock = 25000;
> > > > -	unsigned max_clock, ds_clock, clock;
> > > > +	const unsigned int min_clock = 25000;
> > > > +	unsigned int max_clock, ds_clock, clock;
> > > > +	const u8 bpp = 18; /* 6 bpc */
> > > 
> > > AFAICS nv50_outp_atomic_check() and nv50_msto_atomic_check()
> > > just blindly use connector->display_info.bpc without any fallback
> > > logic to lower the bpc. So Ilia's concerns seem well founded.
> > > Without that logic I guess you should just use
> > > connector->display_info.bpc here as well.
> > > 
> > > >  	enum drm_mode_status ret;
> > > >  
> > > >  	if (mode->flags & DRM_MODE_FLAG_INTERLACE && !outp-
> > > > >caps.dp_interlace)
> > > >  		return MODE_NO_INTERLACE;
> > > >  
> > > >  	max_clock = outp->dp.link_nr * outp->dp.link_bw;
> > > > -	ds_clock = drm_dp_downstream_max_dotclock(outp->dp.dpcd,
> > > > -						  outp-
> > > > >dp.downstream_ports);
> > > > -	if (ds_clock)
> > > > -		max_clock = min(max_clock, ds_clock);
> > > > -
> > > > -	clock = mode->clock * (connector->display_info.bpc * 3) / 10;
> > > > -	ret = nouveau_conn_mode_clock_valid(mode, min_clock,
> > > > max_clock,
> > > > -					    &clock);
> > > > +	clock = mode->clock * bpp / 8;
> > > > +	if (clock > max_clock)
> > > > +		return MODE_CLOCK_HIGH;
> > > 
> > > This stuff vs. nouveau_conn_mode_clock_valid() still seems a bit messy.
> > > The max_clock you pass to nouveau_conn_mode_clock_valid() is the max
> > > symbol clock, but nouveau_conn_mode_clock_valid() checks it against the
> > > dotclock. Also only nouveau_conn_mode_clock_valid() has any kind of
> > > stereo 3D handling, but AFAICS stereo_allowed is also set for DP?
> > 
> > ...not sure I'm following you here, it's set to true for DP so don't we
> > want
> > to check it and adjust the pixel clock we output accordingly?
> 
> Yes, but then you need to also double your your pixel clock
> derived values in this function. Ie. all the mode->clock
> needs to become mode->clock*2 when dealing with a 3D frame
> packing mode.

oh this is a good point, thanks for noticing. I guess I'll get to changing
this around once I start working on the rest of the bpp stuff, since I'd
rather get this fixed first (I doubt many folks are using nouveau for 3D right
now, but if other nouveau folks disagree i'm happy to change my mind)
> 
> > > > +
> > > > +	ds_clock = drm_dp_downstream_max_dotclock(outp->dp.dpcd, outp-
> > > > > dp.downstream_ports);
> > > > +	if (ds_clock && mode->clock > ds_clock)
> > > > +		return MODE_CLOCK_HIGH;
> > > > +
> > > > +	ret = nouveau_conn_mode_clock_valid(mode, min_clock,
> > > > max_clock,
> > > > &clock);
> > > >  	if (out_clock)
> > > >  		*out_clock = clock;
> > > > +
> > > >  	return ret;
> > > >  }
> > > > -- 
> > > > 2.26.2
> > -- 
> > Cheers,
> > 	Lyude Paul (she/her)
> > 	Software Engineer at Red Hat
-- 
Cheers,
	Lyude Paul (she/her)
	Software Engineer at Red Hat

