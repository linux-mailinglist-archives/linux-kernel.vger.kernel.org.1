Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A389A2BA9CF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 13:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgKTMHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 07:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbgKTMHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 07:07:02 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE7EC0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 04:07:02 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id g7so7668389pfc.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 04:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uJHhx/AxyK3axmCVtjjJyERBoB3IcEXKufmPUG7ww+w=;
        b=LJ5EFoeVvniZutXMzpg31w/Ew+l08iJ1/9qKXr5w5FkEoxZmfd2GyCYGdrpQkkelU/
         eV6cnpojr4SUhv1/L6WxXoct4buUd3TpPLeVwojSkOt365J2T35KShgbItY6kk+VVH0i
         O93Wwf0lDgQg2M74nePC2rdyMQ7oaS7Iyyhfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uJHhx/AxyK3axmCVtjjJyERBoB3IcEXKufmPUG7ww+w=;
        b=HBIcqfezDMx0VVhEKjNFY5Q6VgDZDSLYNi+wMQaVy9cA9UwYADHL6FLNBFhuwuqN39
         PHCB3tooch5dWNiWZMC/PAd5xlAJG4LsVCfNUnrhSGCUayLJu2nv/jBKLN2UKaVF/FOH
         6CO4oCdahaPdQqtwLONm50ZkuuiLaLOf3JeewCuOC7ESNaFdh/z1m1ed4F8RvyG7mbgO
         lQ8+AVEmWu+mUF5+59nG/swVgEzNbL4CKUYHsyVBIF0WansW7OMYawwQRVErDWoeM7fF
         jFvdMT9RgMD4rH6i4iUmtrZadI4LYDGs5Z+OsnFLdbD6HGkTl2hViNo6D0gSHuGGUQXx
         770g==
X-Gm-Message-State: AOAM5306Z7WWn/F2FVeDJJIr1QmJIsmI7kgKeCl5sBNzHD/FABfx5gMw
        pVgn4KoROb1qUDDkeqwVSXnChw==
X-Google-Smtp-Source: ABdhPJzqKrNJe9AiB9fm05ov23PgocJ02N9nwvQTEhMKgQJcKNCHn2FbF73yTW43Kci9UDwlfErkAg==
X-Received: by 2002:aa7:9595:0:b029:18e:ecd5:bcdc with SMTP id z21-20020aa795950000b029018eecd5bcdcmr13850642pfj.47.1605874021922;
        Fri, 20 Nov 2020 04:07:01 -0800 (PST)
Received: from google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id h20sm2841253pgv.23.2020.11.20.04.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 04:07:01 -0800 (PST)
Date:   Fri, 20 Nov 2020 04:07:00 -0800
From:   Prashant Malani <pmalani@chromium.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Utkarsh Patel <utkarsh.h.patel@intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        enric.balletbo@collabora.com, rajmohan.mani@intel.com,
        azhar.shaikh@intel.com
Subject: Re: [PATCH v3 2/4] platform/chrome: cros_ec_typec: Use Thunderbolt 3
 cable discover mode VDO in USB4 mode
Message-ID: <20201120120700.GD4160865@google.com>
References: <20201119063211.2264-1-utkarsh.h.patel@intel.com>
 <20201119063211.2264-3-utkarsh.h.patel@intel.com>
 <20201119080906.GE3652649@google.com>
 <20201120112218.GE4120550@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120112218.GE4120550@kuha.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 01:22:18PM +0200, Heikki Krogerus wrote:
> On Thu, Nov 19, 2020 at 12:09:06AM -0800, Prashant Malani wrote:
> > Hi Utkarsh,
> > 
> > On Wed, Nov 18, 2020 at 10:32:09PM -0800, Utkarsh Patel wrote:
> > > Configure Thunderbolt 3 cable generation value by filling Thunderbolt 3
> > > cable discover mode VDO to support rounded Thunderbolt 3 cables.
> > > While we are here use Thunderbolt 3 cable discover mode VDO to fill active
> > > cable plug link training value.
> > > 
> > > Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
> > > 
> > > --
> > > Changes in v3:
> > > - Added a check for cable's TBT support before filling TBT3 discover mode
> > >   VDO.
> > > 
> > > Changes in v2:
> > > - No change.
> > > --
> > > ---
> > >  drivers/platform/chrome/cros_ec_typec.c | 14 ++++++++++++--
> > >  1 file changed, 12 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> > > index 8111ed1fc574..68b17ee1d1ae 100644
> > > --- a/drivers/platform/chrome/cros_ec_typec.c
> > > +++ b/drivers/platform/chrome/cros_ec_typec.c
> > > @@ -514,8 +514,18 @@ static int cros_typec_enable_usb4(struct cros_typec_data *typec,
> > >  	else if (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_CABLE)
> > >  		data.eudo |= EUDO_CABLE_TYPE_RE_TIMER << EUDO_CABLE_TYPE_SHIFT;
> > >  
> > > -	data.active_link_training = !!(pd_ctrl->control_flags &
> > > -				       USB_PD_CTRL_ACTIVE_LINK_UNIDIR);
> > > +	/*
> > > +	 * Filling TBT3 Cable VDO when TBT3 cable is being used to establish
> > > +	 * USB4 connection.
> > > +	 */
> > > +	if (pd_ctrl->cable_gen) {
> > > +		data.tbt_cable_vdo = TBT_MODE;
> > > +
> > > +		if (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_LINK_UNIDIR)
> > > +			data.tbt_cable_vdo |= TBT_CABLE_LINK_TRAINING;
> > > +
> > > +		data.tbt_cable_vdo |= TBT_SET_CABLE_ROUNDED(pd_ctrl->cable_gen);
> > > +	}
> > 
> > I think the following would decouple Rounded Support and Active Cable Link
> > Training?:
> > 
> > 	struct typec_thunderbolt_data data = {};
> > ...
> > 	if (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_LINK_UNIDIR)
> > 		data.tbt_cable_vdo |= TBT_CABLE_LINK_TRAINING;
> > 
> > 	data.tbt_cable_vdo |= TBT_SET_CABLE_ROUNDED(pd_ctrl->cable_gen);
> 
> I agree with this. We should not modify the data that we actually
> have access to.
> 
> > 	if (data.tbt_cable_vdo)
> > 		data.tbt_cable_vdo |= TBT_MODE;
> 
> That is wrong. If the LSRX communication is bi-directional, and/or the
> data rates are non-rounded, the cable has to be TBT3 cable. So I think
> what you would want is:

Thanks for pointing this out, I didn't consider this case.

> 
> 	if (!data.tbt_cable_vdo)
>  		data.tbt_cable_vdo = TBT_MODE;
> 
> But of course we can not do that either, because we have to set the
> TBT_MODE bit if there is any other data in tbt_cable_vdo (USB Type-C
> spec does not define any other valid values except 0x0001 = TBT_MODE
> for that field). Otherwise the mux driver should consider the data
> corrupted. So we would have to do this:
> 
>         if (pd_ctrl->cable_gen &&
>             pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_LINK_UNIDIR)
>                 data.tbt_cable_vdo = 0; /* We assume USB4 cable */
>         else
>  		data.tbt_cable_vdo |= TBT_MODE; /* It is for sure TBT3 cable */
> 
> But I would not do that. TBT3 cable can also support unidirectional
> SBU communication and rounded data rates.
> 
> IMO safer bet for now would be to just claim that the cable is always
> TBT3 cable until we have access to information that can really tell us
> is the cable USB4 or TBT3.

Which brings us back to v1 of the patch :S

That still leaves my underlying concern that we'll be telling the Mux
implementation that a TBT3 cable is connected when in fact it's a USB4
active cable.

How about we don't set the TBT_MODE bit at all ? IMO it's equally bad as setting it
always, but with the additional advantage:

- USB4 active cable case : you are covered (since if we unilaterally set
TBT_MODE then the Active USB4 cable case never gets executed in
pmc_usb_mux_usb4() in drivers/usb/typec/mux/intel_pmc_mux.c Patch 3/4)

- Bidirectional LSRX non-rounded TBT: Still supported since
  the code path in the Intel Mux agent is the same.

I understand neither of the options are ideal, but WDYT?

BR,

-Prashant
