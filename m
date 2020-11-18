Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDA652B7376
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 02:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbgKRBGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 20:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgKRBGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 20:06:21 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228E5C061A48
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 17:06:21 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id f18so27232pgi.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 17:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lCC2MNDhMsDM9oonU7PaUg8pw4Z2GypPso1Qfr4fex8=;
        b=oHN6oQnER2pBv76SZtXrUEs4eP8xPoJnAlvAAgTvts8qEq8H+3nNicbPa+u2SBfbGi
         lUCGl7+I3JSrd8DREpkTH10dQTukIS0NPpN4/uovmOmdGB6dEkdrUuugYuWwnLytTdeM
         bagFCyS0ygVaCrdwra7nFUmMToFWyDOAaWwIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lCC2MNDhMsDM9oonU7PaUg8pw4Z2GypPso1Qfr4fex8=;
        b=gwZ1jj+manOCdZ+IoH8aG3GE7DzrLv/CUlsibXZk0ZdnOqSNjbMZO2UJYyAeBeAJAw
         w2663p/G9gBnR+XtJEm96C0vx6hTncX/eDIIEsX9yWYKuFm+JnFVZ5JQqmDGr3/aLk9h
         WbwsHTP3YtK5iRnEZzaXAWwgkYkMBCgMkNPZE8fvTGUkfeXEOigq9uUejEANo2U/w65m
         ndR7Boa0IWiFTqB6HCW4n8GvclWqMhk96tqzuVE9WLQvhyctZZZwiVrbAMPBa5oXOjtz
         cFyo9+If82RNLrjZM0c7UtO9gBtSI/K7Ve2N5lEVzq6Icdh0ZMDyaAj7Zkb8O4a17PEa
         fK9w==
X-Gm-Message-State: AOAM5301GiXcYpUz+KKlYlmJ6ntV68XCl6vfhbpmFy+ZOTc57GqwcCVr
        xXIglTQP9hEobBg1TfyRpdPs5Q==
X-Google-Smtp-Source: ABdhPJxQCqu3SJgkg3RsGjXhJL4MZcligzJGgmmZeNs6GebOhd10ARAkEvWMMRYi+JTHmYEzsnsAdg==
X-Received: by 2002:a62:3047:0:b029:197:6ca1:24de with SMTP id w68-20020a6230470000b02901976ca124demr1934147pfw.8.1605661580565;
        Tue, 17 Nov 2020 17:06:20 -0800 (PST)
Received: from google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id mv5sm313200pjb.42.2020.11.17.17.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 17:06:20 -0800 (PST)
Date:   Tue, 17 Nov 2020 17:06:18 -0800
From:   Prashant Malani <pmalani@chromium.org>
To:     Utkarsh Patel <utkarsh.h.patel@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:USB NETWORKING DRIVERS" <linux-usb@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Azhar Shaikh <azhar.shaikh@intel.com>
Subject: Re: [PATCH v2 6/8] platform/chrome: cros_ec_typec: Use Thunderbolt 3
 cable discover mode VDO in USB4 mode
Message-ID: <CACeCKacedkvQDq7pJm7G5qbu__5PerUkTK5DjtWy5StMShSB3w@mail.gmail.com>
References: <20201113202503.6559-1-utkarsh.h.patel@intel.com>
 <20201113202503.6559-7-utkarsh.h.patel@intel.com>
 <20201117181918.GB1819103@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117181918.GB1819103@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, Nov 17, 2020 at 10:19 AM Prashant Malani <pmalani@chromium.org> wrote:
>
> Hi Utkarsh,
>
> On Fri, Nov 13, 2020 at 12:25:01PM -0800, Utkarsh Patel wrote:
> > Configure Thunderbolt3/USB4 cable generation value by filing Thunderbolt 3
> > cable discover mode VDO to support rounded and non-rounded Thunderbolt3/
> > USB4 cables.
> > While we are here use Thunderbolt 3 cable discover mode VDO to fill active
> > cable plug link training value.
> >
> > Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
> >
> > --
> > Changes in v2:
> > - No change.
> > --
> > ---
> >  drivers/platform/chrome/cros_ec_typec.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> > index 8111ed1fc574..b7416e82c3b3 100644
> > --- a/drivers/platform/chrome/cros_ec_typec.c
> > +++ b/drivers/platform/chrome/cros_ec_typec.c
> > @@ -514,8 +514,18 @@ static int cros_typec_enable_usb4(struct cros_typec_data *typec,
> >       else if (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_CABLE)
> >               data.eudo |= EUDO_CABLE_TYPE_RE_TIMER << EUDO_CABLE_TYPE_SHIFT;
> >
> > -     data.active_link_training = !!(pd_ctrl->control_flags &
> > -                                    USB_PD_CTRL_ACTIVE_LINK_UNIDIR);
> > +     /*
> > +      * This driver does not have access to the identity information or
> > +      * capabilities of the cable, so we don't know is it a real USB4 or
> > +      * TBT3 cable. Therefore pretending that it's always TBT3 cable by
> > +      * filling the TBT3 Cable VDO.
> > +      */
> > +     data.tbt_cable_vdo = TBT_MODE;
>
> Is it safe to be making this assumption unconditionally? It might work for
> Intel Mux agent but is it guaranteed to be safe for any other future
> mux implementation? In other words, what if a "true" USB4 cable is
> connected which doesn't have the Thunderbolt SVID alt mode?

I dug into this a bit more and can maybe articulate my concern better:

Is there a situation where both of the following are true ? :
- Cable type = EUDO_CABLE_TYPE_OPTICAL or EUDO_CABLE_TYPE_RE_TIMER
- No TBT_CABLE_LINK_TRAINING or TBT_CABLE_ROUNDED_SUPPORT defined (both
  these are 0).

If both the above are true, then in Patch 7/8, wouldn't we never hit the
else condition (labeled "Active USB cable") and therefore not set the
mode_data correctly?

>
> (Pre-fetching some alternatives in case the answer is no)
>
> You might want to check with the Cros EC team if you can repurpose a bit of
> the "reserved" field for specifying whether the cable is TBT or not.
>
> Either that or see if there is a way to determine from the pd_ctrl->cable_speed
> whether the cable is actually TBT or not.

It seems link cable_gen and USB_PD_CTRL_ACTIVE_LINK_UNIDIR are
reasonable proxies for whether the cable has TBT support, so perhaps
we should only set tbt_cable_vdo = TBT_MODE if either of those are
non-zero?

WDYT?

Best regards,

-Prashant
