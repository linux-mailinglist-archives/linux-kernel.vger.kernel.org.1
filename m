Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B912BA0EA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 04:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgKTDOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 22:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgKTDOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 22:14:06 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912D6C0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 19:14:04 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id q5so7708230qkc.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 19:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/zGvD23D7UzPmkeJaICeLLr5BBiyIFomvZLFOZzlxm4=;
        b=K/ex82SL594RfazFznOBdSPZAoIgw2gtJlLr4AhlET3fTfMnmidSmJ5v48KHjGQUiz
         Bz4RUYB5LACvSG4sr8W5+BjRLaw4qYxFR6fHQzN3i2jG3AE7QyKRvbYJ5MQHQay0iWAe
         JoX589dbEyXYyLjASuftwf6P/H1Xa/9J8MAzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/zGvD23D7UzPmkeJaICeLLr5BBiyIFomvZLFOZzlxm4=;
        b=sWZbptmGyS0HPorNQPHEBCpGT7PWD1PZ2YKUlV704TIbMKf0omwrJYNl9x1MggZZGS
         3GC0IeLVmzgVRQ+swjXDkGwHoKyHVYFZBeKA8hH+6dX+jfKRDHYKXCa9fYE261x8sWZd
         BwGl5kY150JkX7hYFtM+6K0u0WzEg2JKt4Xu5xu8WJ4+Iuj6eBtbuIZjLYny9WQosJn+
         QMep6Nb1xb26cR5rFo4uIYqSfb7FG1ipIAnIfikSpMTHBkMiBwrmRNHi6vub9c2Sj4Ro
         K8Bre5HXAv/H9dG4wxPiHOBGBhZl3ziMEbpHGzJa8kZ5z3v3eLuNjk0RGk7twMcfGh9T
         34Ag==
X-Gm-Message-State: AOAM531lFX9Lrzq20BmqlJzZ2zYNAIt7FeRjLy52Ltl1uQMqbvkbDTjC
        iEdcsZPb+IcUBMe7HZiDdezU7lhjsfF/EL+qpH7ENg==
X-Google-Smtp-Source: ABdhPJzjhP/CSxgRJgE+YlE4odaKeOT22nWwH6kRTVVzdqJFbEKMz324CiWy7zrV6wEReKB3J/v4H0DoOJs0nApprAA=
X-Received: by 2002:a37:6195:: with SMTP id v143mr13545153qkb.71.1605842043665;
 Thu, 19 Nov 2020 19:14:03 -0800 (PST)
MIME-Version: 1.0
References: <20201119063211.2264-1-utkarsh.h.patel@intel.com>
 <20201119063211.2264-3-utkarsh.h.patel@intel.com> <20201119080906.GE3652649@google.com>
 <MWHPR11MB004898556A4CF622742D3EAAA9FF0@MWHPR11MB0048.namprd11.prod.outlook.com>
In-Reply-To: <MWHPR11MB004898556A4CF622742D3EAAA9FF0@MWHPR11MB0048.namprd11.prod.outlook.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Thu, 19 Nov 2020 19:13:51 -0800
Message-ID: <CACeCKafuh57RjjKJBxh96nvMDinbJ-QXho_8Kfzbe_-vPROmRg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] platform/chrome: cros_ec_typec: Use Thunderbolt 3
 cable discover mode VDO in USB4 mode
To:     "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "Mani, Rajmohan" <rajmohan.mani@intel.com>,
        "Shaikh, Azhar" <azhar.shaikh@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Utkarsh,

On Thu, Nov 19, 2020 at 6:32 PM Patel, Utkarsh H
<utkarsh.h.patel@intel.com> wrote:
>
> Hi Prashant,
>
> > -----Original Message-----
> > From: Prashant Malani <pmalani@chromium.org>
> > Sent: Thursday, November 19, 2020 12:09 AM
> > To: Patel, Utkarsh H <utkarsh.h.patel@intel.com>
> > Cc: linux-kernel@vger.kernel.org; linux-usb@vger.kernel.org;
> > heikki.krogerus@linux.intel.com; enric.balletbo@collabora.com; Mani,
> > Rajmohan <rajmohan.mani@intel.com>; Shaikh, Azhar
> > <azhar.shaikh@intel.com>
> > Subject: Re: [PATCH v3 2/4] platform/chrome: cros_ec_typec: Use Thunderbolt
> > 3 cable discover mode VDO in USB4 mode
> >
> > Hi Utkarsh,
> >
> > On Wed, Nov 18, 2020 at 10:32:09PM -0800, Utkarsh Patel wrote:
> > > Configure Thunderbolt 3 cable generation value by filling Thunderbolt
> > > 3 cable discover mode VDO to support rounded Thunderbolt 3 cables.
> > > While we are here use Thunderbolt 3 cable discover mode VDO to fill
> > > active cable plug link training value.
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
> > > diff --git a/drivers/platform/chrome/cros_ec_typec.c
> > > b/drivers/platform/chrome/cros_ec_typec.c
> > > index 8111ed1fc574..68b17ee1d1ae 100644
> > > --- a/drivers/platform/chrome/cros_ec_typec.c
> > > +++ b/drivers/platform/chrome/cros_ec_typec.c
> > > @@ -514,8 +514,18 @@ static int cros_typec_enable_usb4(struct
> > cros_typec_data *typec,
> > >     else if (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_CABLE)
> > >             data.eudo |= EUDO_CABLE_TYPE_RE_TIMER <<
> > EUDO_CABLE_TYPE_SHIFT;
> > >
> > > -   data.active_link_training = !!(pd_ctrl->control_flags &
> > > -                                  USB_PD_CTRL_ACTIVE_LINK_UNIDIR);
> > > +   /*
> > > +    * Filling TBT3 Cable VDO when TBT3 cable is being used to establish
> > > +    * USB4 connection.
> > > +    */
> > > +   if (pd_ctrl->cable_gen) {
> > > +           data.tbt_cable_vdo = TBT_MODE;
> > > +
> > > +           if (pd_ctrl->control_flags &
> > USB_PD_CTRL_ACTIVE_LINK_UNIDIR)
> > > +                   data.tbt_cable_vdo |= TBT_CABLE_LINK_TRAINING;
> > > +
> > > +           data.tbt_cable_vdo |= TBT_SET_CABLE_ROUNDED(pd_ctrl-
> > >cable_gen);
> > > +   }
> >
> > I think the following would decouple Rounded Support and Active Cable Link
> > Training?:
>
> Any reason you would want to decouple them?

Is there anything in the spec that says Active Cable Link Training
needs Rounded Cable support (or vice versa)?
If yes, could you kindly point me to the relevant portion in the spec
that states this?

If no, then the two should be set independently based on the response
from the Chrome EC.

FWIW, Table F-11 ( TBT3 Cable Discover Mode VDO Responses) from the
USB Type-C Cable & Connector Spec (Rel 2.0) suggests
the two are independent bits although I don't have access to the TBT3
spec to confirm.

BR,

-Prashant
