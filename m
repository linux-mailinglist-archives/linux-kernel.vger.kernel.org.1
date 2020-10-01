Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261542802A8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 17:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732633AbgJAPYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 11:24:04 -0400
Received: from mga04.intel.com ([192.55.52.120]:37854 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732346AbgJAPYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 11:24:04 -0400
IronPort-SDR: YzZgoNT0Z3Ol5gy2D9hmmeeJFHRakks5kBQXShgxP1rm04unaRj7DFcJvPjD/UCN67tUqNJq5a
 vDpCuOTUeoFg==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="160164644"
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="160164644"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 08:23:51 -0700
IronPort-SDR: 2LSkLNxDmCaJokfBHHpYAA+Oftl3Eqw7W8OAHLZXSQhkY4vRLUm+E3C/+tTZMJHMamfgML0LEp
 toHry8oB/K+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="325443848"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga002.jf.intel.com with SMTP; 01 Oct 2020 08:23:47 -0700
Received: by stinkbox (sSMTP sendmail emulation); Thu, 01 Oct 2020 18:23:46 +0300
Date:   Thu, 1 Oct 2020 18:23:46 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Stefan Joosten <stefan@atcomputing.nl>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Intel-gfx] [PATCH] Revert "drm/i915: Force state->modeset=true
 when distrust_bios_wm==true"
Message-ID: <20201001152346.GR6112@intel.com>
References: <60a804aa6357eb17daa1729f4bce25e762344e9f.camel@atcomputing.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <60a804aa6357eb17daa1729f4bce25e762344e9f.camel@atcomputing.nl>
X-Patchwork-Hint: comment
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 03:47:06PM +0200, Stefan Joosten wrote:
> The fix of flagging state->modeset whenever distrust_bios_wm is set
> causes a regression when initializing display(s) attached to a Lenovo
> USB-C docking station. The display remains blank until the dock is
> reattached. Revert to bring the behavior of the functional v5.6 stable.
> 
> This reverts commit 0f8839f5f323da04a800e6ced1136e4b1e1689a9.
> 
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1879442
> Signed-off-by: Stefan Joosten <stefan@atcomputing.nl>
> ---
>  drivers/gpu/drm/i915/display/intel_display.c | 14 --------------
>  1 file changed, 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
> index b18c5ac2934d..ece1c28278f7 100644
> --- a/drivers/gpu/drm/i915/display/intel_display.c
> +++ b/drivers/gpu/drm/i915/display/intel_display.c
> @@ -14942,20 +14942,6 @@ static int intel_atomic_check(struct drm_device *dev,
>  	if (ret)
>  		goto fail;
>  
> -	/*
> -	 * distrust_bios_wm will force a full dbuf recomputation
> -	 * but the hardware state will only get updated accordingly
> -	 * if state->modeset==true. Hence distrust_bios_wm==true &&
> -	 * state->modeset==false is an invalid combination which
> -	 * would cause the hardware and software dbuf state to get
> -	 * out of sync. We must prevent that.
> -	 *
> -	 * FIXME clean up this mess and introduce better
> -	 * state tracking for dbuf.
> -	 */
> -	if (dev_priv->wm.distrust_bios_wm)
> -		any_ms = true;
> -

Argh. If only I had managed to land the full dbuf rework and nuke this
mess before it came back to bite us...

This is definitely going to break something else, so not great.

Can you file an upstream bug at
https://gitlab.freedesktop.org/drm/intel/issues/new
and attach dmesgs from booting both good and bad kernels with
drm.debug=0x1e passed to the kernel cmdline? Bump log_buf_len=
if necessary to capture the full log.


>  	intel_fbc_choose_crtc(dev_priv, state);
>  	ret = calc_watermark_data(state);
>  	if (ret)
> -- 
> 2.25.4
> 
> 
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx

-- 
Ville Syrjälä
Intel
