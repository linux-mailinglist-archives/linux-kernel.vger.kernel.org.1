Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9479227AE8E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 15:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgI1NCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 09:02:36 -0400
Received: from mga17.intel.com ([192.55.52.151]:51376 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbgI1NCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 09:02:35 -0400
IronPort-SDR: 2ty10jP2zj3eFybKQHP4h7FvBVc+u0e9oX+M/5fEU0HPlMGm8PyK08c8olpbMWp1tFjCiisE/N
 OWcMj//V7XAA==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="142004019"
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="142004019"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 06:01:45 -0700
IronPort-SDR: 2PYb7chxyfjfrLHr1gMCoPXK20Doql8Ipysr3XEkekNBhef/3QikprX/1U1qDPFgKsaDmmqgcW
 UeaWQB1ewDJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="340409775"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga008.jf.intel.com with SMTP; 28 Sep 2020 06:01:42 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 28 Sep 2020 16:01:41 +0300
Date:   Mon, 28 Sep 2020 16:01:41 +0300
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
Message-ID: <20200928130141.GV6112@intel.com>
References: <20200922210510.156220-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200922210510.156220-1-lyude@redhat.com>
X-Patchwork-Hint: comment
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 05:05:10PM -0400, Lyude Paul wrote:
> While I thought I had this correct (since it actually did reject modes
> like I expected during testing), Ville Syrjala from Intel pointed out
> that the logic here isn't correct. max_clock refers to the max symbol
> rate supported by the encoder, so limiting clock to ds_clock using max()
> doesn't make sense. Additionally, we want to check against 6bpc for the
> time being since that's the minimum possible bpc here, not the reported
> bpc from the connector. See:
> 
> https://lists.freedesktop.org/archives/dri-devel/2020-September/280276.html
> 
> For more info.
> 
> So, let's rewrite this using Ville's advice.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Fixes: 409d38139b42 ("drm/nouveau/kms/nv50-: Use downstream DP clock limits for mode validation")
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Ben Skeggs <bskeggs@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_dp.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_dp.c b/drivers/gpu/drm/nouveau/nouveau_dp.c
> index 7b640e05bd4cd..24c81e423d349 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_dp.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_dp.c
> @@ -231,23 +231,26 @@ nv50_dp_mode_valid(struct drm_connector *connector,
>  		   const struct drm_display_mode *mode,
>  		   unsigned *out_clock)
>  {
> -	const unsigned min_clock = 25000;
> -	unsigned max_clock, ds_clock, clock;
> +	const unsigned int min_clock = 25000;
> +	unsigned int max_clock, ds_clock, clock;
> +	const u8 bpp = 18; /* 6 bpc */

AFAICS nv50_outp_atomic_check() and nv50_msto_atomic_check()
just blindly use connector->display_info.bpc without any fallback
logic to lower the bpc. So Ilia's concerns seem well founded.
Without that logic I guess you should just use
connector->display_info.bpc here as well.

>  	enum drm_mode_status ret;
>  
>  	if (mode->flags & DRM_MODE_FLAG_INTERLACE && !outp->caps.dp_interlace)
>  		return MODE_NO_INTERLACE;
>  
>  	max_clock = outp->dp.link_nr * outp->dp.link_bw;
> -	ds_clock = drm_dp_downstream_max_dotclock(outp->dp.dpcd,
> -						  outp->dp.downstream_ports);
> -	if (ds_clock)
> -		max_clock = min(max_clock, ds_clock);
> -
> -	clock = mode->clock * (connector->display_info.bpc * 3) / 10;
> -	ret = nouveau_conn_mode_clock_valid(mode, min_clock, max_clock,
> -					    &clock);
> +	clock = mode->clock * bpp / 8;
> +	if (clock > max_clock)
> +		return MODE_CLOCK_HIGH;

This stuff vs. nouveau_conn_mode_clock_valid() still seems a bit messy.
The max_clock you pass to nouveau_conn_mode_clock_valid() is the max
symbol clock, but nouveau_conn_mode_clock_valid() checks it against the
dotclock. Also only nouveau_conn_mode_clock_valid() has any kind of
stereo 3D handling, but AFAICS stereo_allowed is also set for DP?

> +
> +	ds_clock = drm_dp_downstream_max_dotclock(outp->dp.dpcd, outp->dp.downstream_ports);
> +	if (ds_clock && mode->clock > ds_clock)
> +		return MODE_CLOCK_HIGH;
> +
> +	ret = nouveau_conn_mode_clock_valid(mode, min_clock, max_clock, &clock);
>  	if (out_clock)
>  		*out_clock = clock;
> +
>  	return ret;
>  }
> -- 
> 2.26.2

-- 
Ville Syrjälä
Intel
