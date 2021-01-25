Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F05BB3024FF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 13:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbhAYMdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 07:33:40 -0500
Received: from mga11.intel.com ([192.55.52.93]:6423 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727945AbhAYMUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 07:20:42 -0500
IronPort-SDR: UUM+SgqLDM/RUWR/Mu/NYg87hsq6LpWFnhS+5ja+f9myNoNZeOlJleCKi6RcJ0/q4krQHk8GEp
 YKMVSHePH6EA==
X-IronPort-AV: E=McAfee;i="6000,8403,9874"; a="176204571"
X-IronPort-AV: E=Sophos;i="5.79,373,1602572400"; 
   d="scan'208";a="176204571"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 04:18:24 -0800
IronPort-SDR: oxSq+bW0tCqWU7I2UIGAZLet7pukoh2GDoYW+hDR7viC1W6Qv3oq8Ajr6Sxkxtvbu6MNER9gNl
 KhfYLaN582aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,373,1602572400"; 
   d="scan'208";a="361471544"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga008.fm.intel.com with SMTP; 25 Jan 2021 04:18:20 -0800
Received: by stinkbox (sSMTP sendmail emulation); Mon, 25 Jan 2021 14:18:20 +0200
Date:   Mon, 25 Jan 2021 14:18:20 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Koba Ko <koba.ko@canonical.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/dp_mst: Align mst link rate with soure rate
Message-ID: <YA63DOXXObWp6AF6@intel.com>
References: <20210113014105.28110-1-koba.ko@canonical.com>
 <20210113014105.28110-2-koba.ko@canonical.com>
 <8735z5t5qz.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8735z5t5qz.fsf@intel.com>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 01:51:00PM +0200, Jani Nikula wrote:
> On Wed, 13 Jan 2021, Koba Ko <koba.ko@canonical.com> wrote:
> > After read the link rate from MST hub, align with
> > maximum source rate.
> >
> > Signed-off-by: Koba Ko <koba.ko@canonical.com>
> > ---
> >  drivers/gpu/drm/drm_dp_mst_topology.c   | 8 ++++++++
> >  drivers/gpu/drm/i915/display/intel_dp.c | 7 +++++++
> >  include/drm/drm_dp_helper.h             | 8 ++++++++
> >  include/drm/drm_dp_mst_helper.h         | 4 ++++
> >  4 files changed, 27 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> > index 6982ecbf30b5..e7ceae97be85 100644
> > --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> > +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> > @@ -3672,6 +3672,10 @@ int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_mst_topology_mgr *mgr, bool ms
> >  {
> >  	int ret = 0;
> >  	struct drm_dp_mst_branch *mstb = NULL;
> > +	unsigned int max_link_rate_tbl[MAX_DRM_DP_MAX_RATE + 1] = {
> > +		DP_LINK_BW_1_62, DP_LINK_BW_2_7, DP_LINK_BW_5_4,
> > +		DP_LINK_BW_8_1, DP_LINK_RATE_TABLE
> > +	};
> 
> Please no. Read on for why.
> 
> >  
> >  	mutex_lock(&mgr->payload_lock);
> >  	mutex_lock(&mgr->lock);
> > @@ -3693,6 +3697,9 @@ int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_mst_topology_mgr *mgr, bool ms
> >  			goto out_unlock;
> >  		}
> >  
> > +		if (mgr->max_source_rate < MAX_DRM_DP_MAX_RATE)
> > +			mgr->dpcd[1] = max_link_rate_tbl[mgr->max_source_rate];
> 
> Make ->max_source_rate the actual physical rate in kHz, and use
> drm_dp_link_rate_to_bw_code() here.
> 
> > +
> >  		mgr->pbn_div = drm_dp_get_vc_payload_bw(mgr->dpcd[1],
> >  							mgr->dpcd[2] & DP_MAX_LANE_COUNT_MASK);
> >  		if (mgr->pbn_div == 0) {
> > @@ -5422,6 +5429,7 @@ int drm_dp_mst_topology_mgr_init(struct drm_dp_mst_topology_mgr *mgr,
> >  	mgr->aux = aux;
> >  	mgr->max_dpcd_transaction_bytes = max_dpcd_transaction_bytes;
> >  	mgr->max_payloads = max_payloads;
> > +	mgr->max_source_rate = MAX_DRM_DP_MAX_RATE;
> >  	mgr->conn_base_id = conn_base_id;
> >  	if (max_payloads + 1 > sizeof(mgr->payload_mask) * 8 ||
> >  	    max_payloads + 1 > sizeof(mgr->vcpi_mask) * 8)
> > diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> > index 469e765a1b7b..a89b4c823123 100644
> > --- a/drivers/gpu/drm/i915/display/intel_dp.c
> > +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> > @@ -5392,6 +5392,13 @@ intel_dp_configure_mst(struct intel_dp *intel_dp)
> >  	intel_dp->is_mst = sink_can_mst &&
> >  		i915->params.enable_dp_mst;
> >  
> > +	if (intel_dp_source_supports_hbr3(intel_dp))
> > +		intel_dp->mst_mgr.max_source_rate = DRM_DP_MAX_RATE_HBR3;
> > +	else if (intel_dp_source_supports_hbr2(intel_dp))
> > +		intel_dp->mst_mgr.max_source_rate = DRM_DP_MAX_RATE_HBR2;
> > +	else
> > +		intel_dp->mst_mgr.max_source_rate = DRM_DP_MAX_RATE_HBR;
> 
> Whenever this file references a "rate", it's the rate in kHz. This is
> confusing. Use the rate in kHz.
> 
> Also, please look at how intel_dp_source_supports_hbr* are implemented;
> we already have all the supported source rates cached in intel_dp.
> 
> The max source rate is:
> 
> 	intel_dp->source_rates[intel_dp->num_source_rates - 1].
> 
> No need to do the if ladder here at all. If you like, you can add a
> helper:
> 
> int intel_dp_max_source_rate(struct intel_dp *intel_dp)
> {
>         return intel_dp->source_rates[intel_dp->num_source_rates - 1];
> }

Using the max source rate isn't super great either. A bit better
than the current mess though.

The correct fix would be to let the driver provide the actually
used link_rate+lane_count to the MST code during atomic_check(),
instead of trying to guess what the driver is going to use.

-- 
Ville Syrjälä
Intel
