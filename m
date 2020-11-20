Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8C82BA8E4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 12:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbgKTLWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 06:22:23 -0500
Received: from mga14.intel.com ([192.55.52.115]:6974 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbgKTLWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 06:22:22 -0500
IronPort-SDR: zfBAXwUWRuduIt5oEDuie++mNe8H+DE8h3C8mCtlyXT4Ui+7DMZ0mCI7zmf5BmejquiznW/V9M
 RjQ2uw1/DF/A==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="170675948"
X-IronPort-AV: E=Sophos;i="5.78,356,1599548400"; 
   d="scan'208";a="170675948"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 03:22:22 -0800
IronPort-SDR: m9GpO1MafCyeQwBT5iEXCLRzXfrqovi/d/9Qic+sdGTev4ii61X1lVzA9Gs36QPmRpZal1LDDa
 8gGdZJuLDAkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,356,1599548400"; 
   d="scan'208";a="431539471"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 20 Nov 2020 03:22:19 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 20 Nov 2020 13:22:18 +0200
Date:   Fri, 20 Nov 2020 13:22:18 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Utkarsh Patel <utkarsh.h.patel@intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        enric.balletbo@collabora.com, rajmohan.mani@intel.com,
        azhar.shaikh@intel.com
Subject: Re: [PATCH v3 2/4] platform/chrome: cros_ec_typec: Use Thunderbolt 3
 cable discover mode VDO in USB4 mode
Message-ID: <20201120112218.GE4120550@kuha.fi.intel.com>
References: <20201119063211.2264-1-utkarsh.h.patel@intel.com>
 <20201119063211.2264-3-utkarsh.h.patel@intel.com>
 <20201119080906.GE3652649@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119080906.GE3652649@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 12:09:06AM -0800, Prashant Malani wrote:
> Hi Utkarsh,
> 
> On Wed, Nov 18, 2020 at 10:32:09PM -0800, Utkarsh Patel wrote:
> > Configure Thunderbolt 3 cable generation value by filling Thunderbolt 3
> > cable discover mode VDO to support rounded Thunderbolt 3 cables.
> > While we are here use Thunderbolt 3 cable discover mode VDO to fill active
> > cable plug link training value.
> > 
> > Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
> > 
> > --
> > Changes in v3:
> > - Added a check for cable's TBT support before filling TBT3 discover mode
> >   VDO.
> > 
> > Changes in v2:
> > - No change.
> > --
> > ---
> >  drivers/platform/chrome/cros_ec_typec.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> > index 8111ed1fc574..68b17ee1d1ae 100644
> > --- a/drivers/platform/chrome/cros_ec_typec.c
> > +++ b/drivers/platform/chrome/cros_ec_typec.c
> > @@ -514,8 +514,18 @@ static int cros_typec_enable_usb4(struct cros_typec_data *typec,
> >  	else if (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_CABLE)
> >  		data.eudo |= EUDO_CABLE_TYPE_RE_TIMER << EUDO_CABLE_TYPE_SHIFT;
> >  
> > -	data.active_link_training = !!(pd_ctrl->control_flags &
> > -				       USB_PD_CTRL_ACTIVE_LINK_UNIDIR);
> > +	/*
> > +	 * Filling TBT3 Cable VDO when TBT3 cable is being used to establish
> > +	 * USB4 connection.
> > +	 */
> > +	if (pd_ctrl->cable_gen) {
> > +		data.tbt_cable_vdo = TBT_MODE;
> > +
> > +		if (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_LINK_UNIDIR)
> > +			data.tbt_cable_vdo |= TBT_CABLE_LINK_TRAINING;
> > +
> > +		data.tbt_cable_vdo |= TBT_SET_CABLE_ROUNDED(pd_ctrl->cable_gen);
> > +	}
> 
> I think the following would decouple Rounded Support and Active Cable Link
> Training?:
> 
> 	struct typec_thunderbolt_data data = {};
> ...
> 	if (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_LINK_UNIDIR)
> 		data.tbt_cable_vdo |= TBT_CABLE_LINK_TRAINING;
> 
> 	data.tbt_cable_vdo |= TBT_SET_CABLE_ROUNDED(pd_ctrl->cable_gen);

I agree with this. We should not modify the data that we actually
have access to.

> 	if (data.tbt_cable_vdo)
> 		data.tbt_cable_vdo |= TBT_MODE;

That is wrong. If the LSRX communication is bi-directional, and/or the
data rates are non-rounded, the cable has to be TBT3 cable. So I think
what you would want is:

	if (!data.tbt_cable_vdo)
 		data.tbt_cable_vdo = TBT_MODE;

But of course we can not do that either, because we have to set the
TBT_MODE bit if there is any other data in tbt_cable_vdo (USB Type-C
spec does not define any other valid values except 0x0001 = TBT_MODE
for that field). Otherwise the mux driver should consider the data
corrupted. So we would have to do this:

        if (pd_ctrl->cable_gen &&
            pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_LINK_UNIDIR)
                data.tbt_cable_vdo = 0; /* We assume USB4 cable */
        else
 		data.tbt_cable_vdo |= TBT_MODE; /* It is for sure TBT3 cable */

But I would not do that. TBT3 cable can also support unidirectional
SBU communication and rounded data rates.

IMO safer bet for now would be to just claim that the cable is always
TBT3 cable until we have access to information that can really tell us
is the cable USB4 or TBT3.

But it's up to you guys.


Br,

-- 
heikki
