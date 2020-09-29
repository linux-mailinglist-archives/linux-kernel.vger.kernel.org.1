Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7D827D578
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 20:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgI2SJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 14:09:19 -0400
Received: from mga02.intel.com ([134.134.136.20]:44775 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727360AbgI2SJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 14:09:18 -0400
IronPort-SDR: kiMOeI4bXvaQipntBvReWLnt1eeO0/qfxXNgiJlqtuMSVccdoyQahnjgx9EMtZu6Q9/sI0Brzy
 ZuOblT3bX51g==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="149912527"
X-IronPort-AV: E=Sophos;i="5.77,319,1596524400"; 
   d="scan'208";a="149912527"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 11:09:17 -0700
IronPort-SDR: oSrUocykxI+vYQHmlxEf0u8Z1n658awzYDGwpTU9TobnVjIMvOoEtyeFNAlMTdDv5VB3Q0oi3R
 Q7gk/VA+gG6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,319,1596524400"; 
   d="scan'208";a="312304493"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga006.jf.intel.com with SMTP; 29 Sep 2020 11:09:13 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 29 Sep 2020 21:09:12 +0300
Date:   Tue, 29 Sep 2020 21:09:12 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/nouveau/kms/nv50-: Fix clock checking algorithm in
 nv50_dp_mode_valid()
Message-ID: <20200929180912.GG6112@intel.com>
References: <20200922210510.156220-1-lyude@redhat.com>
 <20200928130141.GV6112@intel.com>
 <9e12d6c091d18be6253717f33f4c09013361e532.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e12d6c091d18be6253717f33f4c09013361e532.camel@redhat.com>
X-Patchwork-Hint: comment
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 01:54:13PM -0400, Lyude Paul wrote:
> On Mon, 2020-09-28 at 16:01 +0300, Ville Syrjälä wrote:
> > On Tue, Sep 22, 2020 at 05:05:10PM -0400, Lyude Paul wrote:
> > > While I thought I had this correct (since it actually did reject modes
> > > like I expected during testing), Ville Syrjala from Intel pointed out
> > > that the logic here isn't correct. max_clock refers to the max symbol
> > > rate supported by the encoder, so limiting clock to ds_clock using max()
> > > doesn't make sense. Additionally, we want to check against 6bpc for the
> > > time being since that's the minimum possible bpc here, not the reported
> > > bpc from the connector. See:
> > > 
> > > https://lists.freedesktop.org/archives/dri-devel/2020-September/280276.html
> > > 
> > > For more info.
> > > 
> > > So, let's rewrite this using Ville's advice.
> > > 
> > > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > > Fixes: 409d38139b42 ("drm/nouveau/kms/nv50-: Use downstream DP clock
> > > limits for mode validation")
> > > Cc: Ville SyrjÃƒÂ¤lÃƒÂ¤ <ville.syrjala@linux.intel.com>
> > > Cc: Lyude Paul <lyude@redhat.com>
> > > Cc: Ben Skeggs <bskeggs@redhat.com>
> > > ---
> > >  drivers/gpu/drm/nouveau/nouveau_dp.c | 23 +++++++++++++----------
> > >  1 file changed, 13 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/nouveau/nouveau_dp.c
> > > b/drivers/gpu/drm/nouveau/nouveau_dp.c
> > > index 7b640e05bd4cd..24c81e423d349 100644
> > > --- a/drivers/gpu/drm/nouveau/nouveau_dp.c
> > > +++ b/drivers/gpu/drm/nouveau/nouveau_dp.c
> > > @@ -231,23 +231,26 @@ nv50_dp_mode_valid(struct drm_connector *connector,
> > >  		   const struct drm_display_mode *mode,
> > >  		   unsigned *out_clock)
> > >  {
> > > -	const unsigned min_clock = 25000;
> > > -	unsigned max_clock, ds_clock, clock;
> > > +	const unsigned int min_clock = 25000;
> > > +	unsigned int max_clock, ds_clock, clock;
> > > +	const u8 bpp = 18; /* 6 bpc */
> > 
> > AFAICS nv50_outp_atomic_check() and nv50_msto_atomic_check()
> > just blindly use connector->display_info.bpc without any fallback
> > logic to lower the bpc. So Ilia's concerns seem well founded.
> > Without that logic I guess you should just use
> > connector->display_info.bpc here as well.
> > 
> > >  	enum drm_mode_status ret;
> > >  
> > >  	if (mode->flags & DRM_MODE_FLAG_INTERLACE && !outp->caps.dp_interlace)
> > >  		return MODE_NO_INTERLACE;
> > >  
> > >  	max_clock = outp->dp.link_nr * outp->dp.link_bw;
> > > -	ds_clock = drm_dp_downstream_max_dotclock(outp->dp.dpcd,
> > > -						  outp->dp.downstream_ports);
> > > -	if (ds_clock)
> > > -		max_clock = min(max_clock, ds_clock);
> > > -
> > > -	clock = mode->clock * (connector->display_info.bpc * 3) / 10;
> > > -	ret = nouveau_conn_mode_clock_valid(mode, min_clock, max_clock,
> > > -					    &clock);
> > > +	clock = mode->clock * bpp / 8;
> > > +	if (clock > max_clock)
> > > +		return MODE_CLOCK_HIGH;
> > 
> > This stuff vs. nouveau_conn_mode_clock_valid() still seems a bit messy.
> > The max_clock you pass to nouveau_conn_mode_clock_valid() is the max
> > symbol clock, but nouveau_conn_mode_clock_valid() checks it against the
> > dotclock. Also only nouveau_conn_mode_clock_valid() has any kind of
> > stereo 3D handling, but AFAICS stereo_allowed is also set for DP?
> 
> ...not sure I'm following you here, it's set to true for DP so don't we want
> to check it and adjust the pixel clock we output accordingly?

Yes, but then you need to also double your your pixel clock
derived values in this function. Ie. all the mode->clock
needs to become mode->clock*2 when dealing with a 3D frame
packing mode.

> 
> > 
> > > +
> > > +	ds_clock = drm_dp_downstream_max_dotclock(outp->dp.dpcd, outp-
> > > >dp.downstream_ports);
> > > +	if (ds_clock && mode->clock > ds_clock)
> > > +		return MODE_CLOCK_HIGH;
> > > +
> > > +	ret = nouveau_conn_mode_clock_valid(mode, min_clock, max_clock,
> > > &clock);
> > >  	if (out_clock)
> > >  		*out_clock = clock;
> > > +
> > >  	return ret;
> > >  }
> > > -- 
> > > 2.26.2
> -- 
> Cheers,
> 	Lyude Paul (she/her)
> 	Software Engineer at Red Hat

-- 
Ville Syrjälä
Intel
