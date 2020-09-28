Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0E027B02D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 16:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgI1Ooj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 10:44:39 -0400
Received: from mga01.intel.com ([192.55.52.88]:49802 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbgI1Ooj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 10:44:39 -0400
IronPort-SDR: OcW52e/mxlSpEnawSgE7z4vh74aPtbTn9J211PIXUGGNdfZ85tVD5M9bL14iUEEA7+sCGKfBkb
 nK0Wo9i2jT6g==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="180159305"
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="180159305"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 07:17:35 -0700
IronPort-SDR: cLDVyLbdQfKfBKjP7K00a0MFqckXhTpS5t+J1Ixr91Qwyn2tT0f77bKAXvx5c2CrhB+AFq1Sv6
 hohZkyEuj37w==
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="488597872"
Received: from unknown (HELO jausmus-gentoo-dev6) ([10.165.21.157])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 28 Sep 2020 07:17:34 -0700
Date:   Mon, 28 Sep 2020 07:15:43 -0700
From:   James Ausmus <james.ausmus@intel.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, matthew.d.roper@intel.com,
        jose.souza@intel.com, ville.syrjala@linux.intel.com,
        lucas.demarchi@intel.com, hariom.pandey@intel.com
Subject: Re: [Intel-gfx] [PATCH 2/2] drm/i915/edp/jsl: Update vswing table
 for HBR and HBR2
Message-ID: <20200928141543.GG5197@jausmus-gentoo-dev6>
References: <20200928080931.246347-1-tejaskumarx.surendrakumar.upadhyay@intel.com>
 <20200928080931.246347-3-tejaskumarx.surendrakumar.upadhyay@intel.com>
 <87a6xaow40.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a6xaow40.fsf@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 04:43:11PM +0300, Jani Nikula wrote:
> On Mon, 28 Sep 2020, Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com> wrote:
> > JSL has update in vswing table for eDP
> 
> I've thought the TLA for Jasper Lake is JSP, not JSL. At least we have
> PCH_JSP for Jasper Lake PCH.

JSP == Point (the PCH), JSL == Lake

-James

> 
> >
> > BSpec: 21257
> > Signed-off-by: Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>
> > ---
> >  drivers/gpu/drm/i915/display/intel_ddi.c | 67 ++++++++++++++++++++++--
> >  1 file changed, 64 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
> > index 4d06178cd76c..fa08463bcf2e 100644
> > --- a/drivers/gpu/drm/i915/display/intel_ddi.c
> > +++ b/drivers/gpu/drm/i915/display/intel_ddi.c
> > @@ -582,6 +582,34 @@ static const struct cnl_ddi_buf_trans ehl_combo_phy_ddi_translations_dp[] = {
> >  	{ 0x6, 0x7F, 0x3F, 0x00, 0x00 },	/* 900   900      0.0   */
> >  };
> >  
> > +static const struct cnl_ddi_buf_trans jsl_combo_phy_ddi_translations_edp_hbr[] = {
> > +						/* NT mV Trans mV db    */
> > +	{ 0x8, 0x7F, 0x3F, 0x00, 0x00 },	/* 200   200      0.0   */
> > +	{ 0x8, 0x7F, 0x38, 0x00, 0x07 },	/* 200   250      1.9   */
> > +	{ 0x1, 0x7F, 0x33, 0x00, 0x0C },	/* 200   300      3.5   */
> > +	{ 0xA, 0x35, 0x36, 0x00, 0x09 },	/* 200   350      4.9   */
> > +	{ 0x8, 0x7F, 0x3F, 0x00, 0x00 },	/* 250   250      0.0   */
> > +	{ 0x1, 0x7F, 0x38, 0x00, 0x07 },	/* 250   300      1.6   */
> > +	{ 0xA, 0x35, 0x35, 0x00, 0x0A },	/* 250   350      2.9   */
> > +	{ 0x1, 0x7F, 0x3F, 0x00, 0x00 },	/* 300   300      0.0   */
> > +	{ 0xA, 0x35, 0x38, 0x00, 0x07 },	/* 300   350      1.3   */
> > +	{ 0xA, 0x35, 0x3F, 0x00, 0x00 },	/* 350   350      0.0   */
> > +};
> > +
> > +static const struct cnl_ddi_buf_trans jsl_combo_phy_ddi_translations_edp_hbr2[] = {
> > +						/* NT mV Trans mV db    */
> > +	{ 0x8, 0x7F, 0x3F, 0x00, 0x00 },	/* 200   200      0.0   */
> > +	{ 0x8, 0x7F, 0x3F, 0x00, 0x00 },	/* 200   250      1.9   */
> > +	{ 0x1, 0x7F, 0x3D, 0x00, 0x02 },	/* 200   300      3.5   */
> > +	{ 0xA, 0x35, 0x38, 0x00, 0x07 },	/* 200   350      4.9   */
> > +	{ 0x8, 0x7F, 0x3F, 0x00, 0x00 },	/* 250   250      0.0   */
> > +	{ 0x1, 0x7F, 0x3F, 0x00, 0x00 },	/* 250   300      1.6   */
> > +	{ 0xA, 0x35, 0x3A, 0x00, 0x05 },	/* 250   350      2.9   */
> > +	{ 0x1, 0x7F, 0x3F, 0x00, 0x00 },	/* 300   300      0.0   */
> > +	{ 0xA, 0x35, 0x38, 0x00, 0x07 },	/* 300   350      1.3   */
> > +	{ 0xA, 0x35, 0x3F, 0x00, 0x00 },	/* 350   350      0.0   */
> > +};
> > +
> >  struct icl_mg_phy_ddi_buf_trans {
> >  	u32 cri_txdeemph_override_11_6;
> >  	u32 cri_txdeemph_override_5_0;
> > @@ -1069,7 +1097,6 @@ icl_get_mg_buf_trans(struct intel_encoder *encoder, int type, int rate,
> >  	*n_entries = ARRAY_SIZE(icl_mg_phy_ddi_translations_rbr_hbr);
> >  	return icl_mg_phy_ddi_translations_rbr_hbr;
> >  }
> > -
> >  static const struct cnl_ddi_buf_trans *
> >  ehl_get_combo_buf_trans(struct intel_encoder *encoder, int type, int rate,
> >  			int *n_entries)
> > @@ -1098,6 +1125,34 @@ ehl_get_combo_buf_trans(struct intel_encoder *encoder, int type, int rate,
> >  	}
> >  }
> >  
> > +static const struct cnl_ddi_buf_trans *
> > +jsl_get_combo_buf_trans(struct intel_encoder *encoder, int type, int rate,
> > +			int *n_entries)
> > +{
> > +	struct drm_i915_private *dev_priv = to_i915(encoder->base.dev);
> > +
> > +	switch (type) {
> > +	case INTEL_OUTPUT_HDMI:
> > +		*n_entries = ARRAY_SIZE(icl_combo_phy_ddi_translations_hdmi);
> > +		return icl_combo_phy_ddi_translations_hdmi;
> > +	case INTEL_OUTPUT_EDP:
> > +		if (dev_priv->vbt.edp.low_vswing) {
> > +			if (rate > 270000) {
> > +				*n_entries = ARRAY_SIZE(jsl_combo_phy_ddi_translations_edp_hbr2);
> > +				return jsl_combo_phy_ddi_translations_edp_hbr2;
> > +			} else {
> > +				*n_entries = ARRAY_SIZE(jsl_combo_phy_ddi_translations_edp_hbr);
> > +				return jsl_combo_phy_ddi_translations_edp_hbr;
> > +			}
> > +		}
> > +		/* fall through */
> > +	default:
> > +		/* All combo DP and eDP ports that do not support low_vswing */
> > +		*n_entries = ARRAY_SIZE(icl_combo_phy_ddi_translations_dp_hbr2);
> > +		return icl_combo_phy_ddi_translations_dp_hbr2;
> > +	}
> > +}
> > +
> >  static const struct cnl_ddi_buf_trans *
> >  tgl_get_combo_buf_trans(struct intel_encoder *encoder, int type, int rate,
> >  			int *n_entries)
> > @@ -2265,9 +2320,12 @@ static u8 intel_ddi_dp_voltage_max(struct intel_dp *intel_dp)
> >  			tgl_get_dkl_buf_trans(encoder, encoder->type,
> >  					      intel_dp->link_rate, &n_entries);
> >  	} else if (INTEL_GEN(dev_priv) == 11) {
> > -		if (IS_ELKHARTLAKE(dev_priv))
> > +		if (IS_JASPERLAKE(dev_priv))
> > +			jsl_get_combo_buf_trans(encoder, encoder->type,
> > +					intel_dp->link_rate, &n_entries);
> > +		else if (IS_ELKHARTLAKE(dev_priv))
> >  			ehl_get_combo_buf_trans(encoder, encoder->type,
> > -						intel_dp->link_rate, &n_entries);
> > +					intel_dp->link_rate, &n_entries);
> 
> This is a good example of a potential trap that having IS_ELKHARTLAKE()
> cover both ELK and JSP creates. An unsuspecting coder might change the
> if ladder to have IS_ELKHARTLAKE() first, and the subsequent
> IS_JASPERLAKE() branch would never be taken.
> 
> BR,
> Jani.
> 
> >  		else if (intel_phy_is_combo(dev_priv, phy))
> >  			icl_get_combo_buf_trans(encoder, encoder->type,
> >  						intel_dp->link_rate, &n_entries);
> > @@ -2454,6 +2512,9 @@ static void icl_ddi_combo_vswing_program(struct intel_encoder *encoder,
> >  	if (INTEL_GEN(dev_priv) >= 12)
> >  		ddi_translations = tgl_get_combo_buf_trans(encoder, type, rate,
> >  							   &n_entries);
> > +	else if (IS_JASPERLAKE(dev_priv))
> > +		ddi_translations = jsl_get_combo_buf_trans(encoder, type, rate,
> > +							   &n_entries);
> >  	else if (IS_ELKHARTLAKE(dev_priv))
> >  		ddi_translations = ehl_get_combo_buf_trans(encoder, type, rate,
> >  							   &n_entries);
> 
> -- 
> Jani Nikula, Intel Open Source Graphics Center
