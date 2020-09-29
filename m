Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63AA327D52B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 19:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgI2RyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 13:54:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28646 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725779AbgI2RyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 13:54:22 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601402060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RB1qMPqA5Fuv69vC0OQ8pzSzT2FY50yu2m0896R3wr8=;
        b=fV68GcYU20i0fMnAvksiGmfgbmGRAlkQCxVN4SifP7KG6zqXtBKc8YAOC79VwNbBSXkW12
        9IDyjPU9ItSdL5VYrT8SP0dubU8UHt2TWuDvmeHcn93SRq6c1fXKX7BzEr+e+TdSwmqNQy
        yOIRLavi5hyxeuGdu0pK5EjS56WHWyk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-PhFJ_CA0NtmTdgW8xcKJ0A-1; Tue, 29 Sep 2020 13:54:16 -0400
X-MC-Unique: PhFJ_CA0NtmTdgW8xcKJ0A-1
Received: by mail-qt1-f199.google.com with SMTP id z27so3630495qtu.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 10:54:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=RB1qMPqA5Fuv69vC0OQ8pzSzT2FY50yu2m0896R3wr8=;
        b=EM50y8k9Z2u1UVFcjQ6QaOWFTJEPMi5Aroj5DM75Bw5UtmHI3locw+v6v8Yqkiys3l
         f99byb7VXmDYmX0dl8Z/69cl9lEVWUIRNCOwkqi4lyIRvJk9gpbIHZWzqSZoLJvMoLBK
         s1Lkd+RsAAyP3EGkJDk4PFOYfn4UVyjGx3L7eGNCqBbqtSLjM+4gvoWZXlR8vdB2NBAZ
         8SQSbJpbvt/QWo1T9nCMRKvzoU8JSji9pJmYN1mKRBybzq2eoUQ1wxL/FIfYU3nriiao
         5zwhcEFwvDUk4HExOMxEx3C5VVkjX4bC5tF7jXlxmRq/cVJw1m/a8NpbQnf8VKBp99Ns
         sGvQ==
X-Gm-Message-State: AOAM532JjiiXcTRAJ0Q8qyMtVwUUt1QXFhINYBdZvTJdx7/PY1C9fGZP
        6NPmZnF7dgyPxgk+l5HfgPxh/P5Hq5qPk2+kg7c/O+ZZQlCOX43oroJ4DSt3yYtzURS/hFr16Xj
        PAKc+ahtAwFgWAtV4cSJRIfev
X-Received: by 2002:ac8:5159:: with SMTP id h25mr4452894qtn.328.1601402055651;
        Tue, 29 Sep 2020 10:54:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwV+bFO7MhJ0AMnMicvOFYCYwL3jmCqbhV68goafFCYN30T29d9Br4VQUCjY5MWXadhB42r9g==
X-Received: by 2002:ac8:5159:: with SMTP id h25mr4452877qtn.328.1601402055427;
        Tue, 29 Sep 2020 10:54:15 -0700 (PDT)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id f127sm5673443qke.133.2020.09.29.10.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 10:54:14 -0700 (PDT)
Message-ID: <9e12d6c091d18be6253717f33f4c09013361e532.camel@redhat.com>
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
Date:   Tue, 29 Sep 2020 13:54:13 -0400
In-Reply-To: <20200928130141.GV6112@intel.com>
References: <20200922210510.156220-1-lyude@redhat.com>
         <20200928130141.GV6112@intel.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-09-28 at 16:01 +0300, Ville Syrjälä wrote:
> On Tue, Sep 22, 2020 at 05:05:10PM -0400, Lyude Paul wrote:
> > While I thought I had this correct (since it actually did reject modes
> > like I expected during testing), Ville Syrjala from Intel pointed out
> > that the logic here isn't correct. max_clock refers to the max symbol
> > rate supported by the encoder, so limiting clock to ds_clock using max()
> > doesn't make sense. Additionally, we want to check against 6bpc for the
> > time being since that's the minimum possible bpc here, not the reported
> > bpc from the connector. See:
> > 
> > https://lists.freedesktop.org/archives/dri-devel/2020-September/280276.html
> > 
> > For more info.
> > 
> > So, let's rewrite this using Ville's advice.
> > 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > Fixes: 409d38139b42 ("drm/nouveau/kms/nv50-: Use downstream DP clock
> > limits for mode validation")
> > Cc: Ville SyrjÃƒÂ¤lÃƒÂ¤ <ville.syrjala@linux.intel.com>
> > Cc: Lyude Paul <lyude@redhat.com>
> > Cc: Ben Skeggs <bskeggs@redhat.com>
> > ---
> >  drivers/gpu/drm/nouveau/nouveau_dp.c | 23 +++++++++++++----------
> >  1 file changed, 13 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_dp.c
> > b/drivers/gpu/drm/nouveau/nouveau_dp.c
> > index 7b640e05bd4cd..24c81e423d349 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_dp.c
> > +++ b/drivers/gpu/drm/nouveau/nouveau_dp.c
> > @@ -231,23 +231,26 @@ nv50_dp_mode_valid(struct drm_connector *connector,
> >  		   const struct drm_display_mode *mode,
> >  		   unsigned *out_clock)
> >  {
> > -	const unsigned min_clock = 25000;
> > -	unsigned max_clock, ds_clock, clock;
> > +	const unsigned int min_clock = 25000;
> > +	unsigned int max_clock, ds_clock, clock;
> > +	const u8 bpp = 18; /* 6 bpc */
> 
> AFAICS nv50_outp_atomic_check() and nv50_msto_atomic_check()
> just blindly use connector->display_info.bpc without any fallback
> logic to lower the bpc. So Ilia's concerns seem well founded.
> Without that logic I guess you should just use
> connector->display_info.bpc here as well.
> 
> >  	enum drm_mode_status ret;
> >  
> >  	if (mode->flags & DRM_MODE_FLAG_INTERLACE && !outp->caps.dp_interlace)
> >  		return MODE_NO_INTERLACE;
> >  
> >  	max_clock = outp->dp.link_nr * outp->dp.link_bw;
> > -	ds_clock = drm_dp_downstream_max_dotclock(outp->dp.dpcd,
> > -						  outp->dp.downstream_ports);
> > -	if (ds_clock)
> > -		max_clock = min(max_clock, ds_clock);
> > -
> > -	clock = mode->clock * (connector->display_info.bpc * 3) / 10;
> > -	ret = nouveau_conn_mode_clock_valid(mode, min_clock, max_clock,
> > -					    &clock);
> > +	clock = mode->clock * bpp / 8;
> > +	if (clock > max_clock)
> > +		return MODE_CLOCK_HIGH;
> 
> This stuff vs. nouveau_conn_mode_clock_valid() still seems a bit messy.
> The max_clock you pass to nouveau_conn_mode_clock_valid() is the max
> symbol clock, but nouveau_conn_mode_clock_valid() checks it against the
> dotclock. Also only nouveau_conn_mode_clock_valid() has any kind of
> stereo 3D handling, but AFAICS stereo_allowed is also set for DP?

...not sure I'm following you here, it's set to true for DP so don't we want
to check it and adjust the pixel clock we output accordingly?

> 
> > +
> > +	ds_clock = drm_dp_downstream_max_dotclock(outp->dp.dpcd, outp-
> > >dp.downstream_ports);
> > +	if (ds_clock && mode->clock > ds_clock)
> > +		return MODE_CLOCK_HIGH;
> > +
> > +	ret = nouveau_conn_mode_clock_valid(mode, min_clock, max_clock,
> > &clock);
> >  	if (out_clock)
> >  		*out_clock = clock;
> > +
> >  	return ret;
> >  }
> > -- 
> > 2.26.2
-- 
Cheers,
	Lyude Paul (she/her)
	Software Engineer at Red Hat

