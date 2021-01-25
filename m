Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63089304AA4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 21:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbhAZFCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 00:02:11 -0500
Received: from mga09.intel.com ([134.134.136.24]:40319 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726470AbhAYJX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 04:23:58 -0500
IronPort-SDR: fL6ScXw1Hp8bLEj59EFm5bfpo8AMBoczSzdx3WYukJOdTBq+UDL3qdzL1A8LRDVXv0d2OraUJO
 FY66PbeV49MQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9874"; a="179842884"
X-IronPort-AV: E=Sophos;i="5.79,373,1602572400"; 
   d="scan'208";a="179842884"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 01:22:00 -0800
IronPort-SDR: A+6R6t4KFN+e7YYc+geD8CA4cFQ+E9AOnuQE+MgzQsYJHCnyIceMqXckBGSXfWBevySIvu5olx
 KSclSfI92Czg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,373,1602572400"; 
   d="scan'208";a="471989144"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 25 Jan 2021 01:21:57 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 25 Jan 2021 11:21:56 +0200
Date:   Mon, 25 Jan 2021 11:21:56 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Kyle Tso <kyletso@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Badhri Jagan Sridharan <badhri@google.com>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: typec: tcpm: Create legacy PDOs for PD2 connection
Message-ID: <20210125092156.GA1720720@kuha.fi.intel.com>
References: <20210115163311.391332-1-kyletso@google.com>
 <20210121084101.GC423216@kuha.fi.intel.com>
 <CAGZ6i=0M6=cZpfm=Eu4s4XTjwz5GPbpStNNOdjnPAkJ1y2MRRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ6i=0M6=cZpfm=Eu4s4XTjwz5GPbpStNNOdjnPAkJ1y2MRRA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 21, 2021 at 05:48:46PM +0800, Kyle Tso wrote:
> On Thu, Jan 21, 2021 at 4:41 PM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > Hi Kyle,
> >
> > On Sat, Jan 16, 2021 at 12:33:11AM +0800, Kyle Tso wrote:
> > > If the port partner is PD2, the PDOs of the local port should follow the
> > > format defined in PD2 Spec. Dynamically modify the pre-defined PD3 PDOs
> > > and transform them into PD2 format before sending them to the PD2 port
> > > partner.
> >
> > I guess it's not possible for the system to supply separate static
> > PDOs for each PD revision?
> >
> We can do that for sure. But a problem is that if there are more PD
> revisions in the future, we will need to add more PDO arrays.
> For backward compatibility, the new revision usually uses the
> previously-reserved bits for the new features.
> >From my perspective, the better way to achieve the backward
> compatibility is to just clear the bits if those are reserved in the
> previous revision.

I was trying to think of something better for this, but I got nothing.
I'm not completely comfortable with this, but never mind. Let's just go
with this.

> I can submit another patch which adds another PDO array for PD2 if you
> think it is more appropriate.

Not necessary.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> > > Signed-off-by: Kyle Tso <kyletso@google.com>
> > > ---
> > >  drivers/usb/typec/tcpm/tcpm.c | 62 +++++++++++++++++++++++++++++------
> > >  include/linux/usb/pd.h        |  1 +
> > >  2 files changed, 53 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> > > index 22a85b396f69..1220ab1ed47d 100644
> > > --- a/drivers/usb/typec/tcpm/tcpm.c
> > > +++ b/drivers/usb/typec/tcpm/tcpm.c
> > > @@ -911,13 +911,47 @@ static int tcpm_set_pwr_role(struct tcpm_port *port, enum typec_role role)
> > >       return 0;
> > >  }
> > >
> > > +/*
> > > + * Transform the PDO to be compliant to PD rev2.0.
> > > + * Return 0 if the PDO type is not defined in PD rev2.0.
> > > + * Otherwise, return the converted PDO.
> > > + */
> > > +static u32 tcpm_forge_legacy_pdo(struct tcpm_port *port, u32 pdo, enum typec_role role)
> > > +{
> > > +     switch (pdo_type(pdo)) {
> > > +     case PDO_TYPE_FIXED:
> > > +             if (role == TYPEC_SINK)
> > > +                     return pdo & ~PDO_FIXED_FRS_CURR_MASK;
> > > +             else
> > > +                     return pdo & ~PDO_FIXED_UNCHUNK_EXT;
> > > +     case PDO_TYPE_VAR:
> > > +     case PDO_TYPE_BATT:
> > > +             return pdo;
> > > +     case PDO_TYPE_APDO:
> > > +     default:
> > > +             return 0;
> > > +     }
> > > +}
> > > +
> > >  static int tcpm_pd_send_source_caps(struct tcpm_port *port)
> > >  {
> > >       struct pd_message msg;
> > > -     int i;
> > > +     u32 pdo;
> > > +     unsigned int i, nr_pdo = 0;
> >
> > Side note. I think this driver uses the "reverse christmas tree"
> > style with the variables.
> 
> I will change the order (if there is a next version)
> 
> thanks,
> Kyle

-- 
heikki
