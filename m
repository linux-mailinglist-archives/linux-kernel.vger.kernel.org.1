Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2A72BA51D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 09:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbgKTIwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 03:52:55 -0500
Received: from mga11.intel.com ([192.55.52.93]:64252 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727043AbgKTIwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 03:52:54 -0500
IronPort-SDR: NsHZ3dn8mZ7Up7qsfZeWyYlddby2i8v2pu0qMDCRjV0dGx/uqARTpg/CkSv8nuDt1mN5YR08jt
 nVVM8MXTwgzA==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="167929497"
X-IronPort-AV: E=Sophos;i="5.78,356,1599548400"; 
   d="scan'208";a="167929497"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 00:52:53 -0800
IronPort-SDR: 1dVlrbhq0+neEjxEnD9VmRkqOme23/MNbM9v6o03BPHR4HC9q4+SzQOcuQFh0oed43dl4Qk+iO
 fA0euFqMj+vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,356,1599548400"; 
   d="scan'208";a="431507966"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 20 Nov 2020 00:52:51 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 20 Nov 2020 10:52:50 +0200
Date:   Fri, 20 Nov 2020 10:52:50 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Utkarsh Patel <utkarsh.h.patel@intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        enric.balletbo@collabora.com, rajmohan.mani@intel.com,
        azhar.shaikh@intel.com
Subject: Re: [PATCH v3 1/4] usb: typec: Use Thunderbolt 3 cable discover mode
 VDO in Enter_USB message
Message-ID: <20201120085250.GD4120550@kuha.fi.intel.com>
References: <20201119063211.2264-1-utkarsh.h.patel@intel.com>
 <20201119063211.2264-2-utkarsh.h.patel@intel.com>
 <20201120080514.GC4120550@kuha.fi.intel.com>
 <20201120083625.GB4160865@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120083625.GB4160865@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 12:36:25AM -0800, Prashant Malani wrote:
> On Fri, Nov 20, 2020 at 10:05:14AM +0200, Heikki Krogerus wrote:
> > On Wed, Nov 18, 2020 at 10:32:08PM -0800, Utkarsh Patel wrote:
> > > When Thunderbolt 3 cable is being used to create USB4 connection, use
> > > Thunderbolt 3 discover mode VDO to fill details such as active cable plug
> > > link training and cable rounded support.
> > > With USB4 cables, these VDO members need not be filled.
> > > 
> > > Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
> > > 
> > > --
> > > Changes in v3:
> > > - Changed the commit mesage to reflect why TBT3 VDO is being used.
> > > - Added more details in the header file about the usage of TBT3 VDO.
> > > 
> > > Changes in v2:
> > > - No change.
> > > --
> > > ---
> > >  include/linux/usb/typec.h | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
> > > index 6be558045942..25731ed863fa 100644
> > > --- a/include/linux/usb/typec.h
> > > +++ b/include/linux/usb/typec.h
> > > @@ -75,6 +75,10 @@ enum typec_orientation {
> > >  /*
> > >   * struct enter_usb_data - Enter_USB Message details
> > >   * @eudo: Enter_USB Data Object
> > > + * @tbt_cable_vdo: TBT3 Cable Discover Mode Response
> > 
> > This is fine..
> > 
> > > + * @tbt_cable_vdo needs to be filled with details of active cable plug link
> > > + * training and cable rounded support when thunderbolt 3 cable is being used to
> > > + * create USB4 connection. Do not fill this in case of USB4 cable.
> > 
> > But this is not. The description of the member tells what the member
> > contains, but it does not make sense to explain also how to use the
> > member in the same place.
> 
> Slightly tangential question here:
> 
> Is there a need to mention "active cable plug link training" and "cable
> rounded support" at all? Wouldn't it be sufficient to omit those in the
> description (in case some mux implementation wants to use the other fields
> of the VDO) ?

No, I don't think so. I think it would be enough to just mention that
we need the TBT3 Cable VDO only when the USB4 connection is created
using TBT3 cables. And that's it.


Br,

-- 
heikki
