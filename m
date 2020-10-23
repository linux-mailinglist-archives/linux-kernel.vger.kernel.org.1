Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6512E296C2B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 11:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461557AbgJWJea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 05:34:30 -0400
Received: from mga06.intel.com ([134.134.136.31]:24739 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S461548AbgJWJe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 05:34:29 -0400
IronPort-SDR: p6OZsDLnePhckRChDeZrgrhj/42oxuLE7b6AhnVUEX6qYfEMjwvD0DZORBTezn6ZkYxlygQe9C
 RkhfiNyXYkXw==
X-IronPort-AV: E=McAfee;i="6000,8403,9782"; a="229286294"
X-IronPort-AV: E=Sophos;i="5.77,407,1596524400"; 
   d="scan'208";a="229286294"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2020 02:34:25 -0700
IronPort-SDR: 7nIceMAqsb3tZJlN2LSFSxFfmEqFlrKwx1b3s0Su60Z+3zKhLlJCp88QQmiJORXMg9ZppHpW6E
 hBPGjoRn9yaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,407,1596524400"; 
   d="scan'208";a="423383122"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 23 Oct 2020 02:34:22 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 23 Oct 2020 12:34:21 +0300
Date:   Fri, 23 Oct 2020 12:34:21 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Benson Leung <bleung@chromium.org>
Cc:     Prashant Malani <pmalani@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:USB NETWORKING DRIVERS" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v2] usb: typec: Expose Product Type VDOs via sysfs
Message-ID: <20201023093421.GS1667571@kuha.fi.intel.com>
References: <20201022061554.3418060-1-pmalani@chromium.org>
 <20201022065719.GA1440360@kroah.com>
 <CACeCKacvhtSfQ=hGYHi3AdrTT+XY2RpKmPHuYWoxNVmRWMeBBA@mail.gmail.com>
 <20201022071753.GA1470296@kroah.com>
 <CACeCKafjm-T5WnQNRbpKm3OwxqYH+_MxLMg60-=RrpJFBzcKyA@mail.gmail.com>
 <20201022124248.GQ1667571@kuha.fi.intel.com>
 <CANLzEkskrWXWLC+csObYwB+JUFdH+p6V6giMHtsKY-L61cTG9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLzEkskrWXWLC+csObYwB+JUFdH+p6V6giMHtsKY-L61cTG9g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 04:25:23PM -0700, Benson Leung wrote:
> Hi Heikki,
> 
> On Thu, Oct 22, 2020 at 5:43 AM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > On Thu, Oct 22, 2020 at 12:25:07AM -0700, Prashant Malani wrote:
> > > Hi Greg,
> > >
> > > On Thu, Oct 22, 2020 at 12:17 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > > > > +What:                /sys/class/typec/<port>-partner/identity/product_type_vdo
> > > > > > > +Date:                October 2020
> > > > > > > +Contact:     Prashant Malani <pmalani@chromium.org>
> > > > > > > +Description:
> > > > > > > +             Product Type VDOs part of Discover Identity command result. 3 values
> > > > > > > +             are displayed (for the 3 possible Product Type VDOs), one per line.
> > > > > >
> > > > > > sysfs is "one value per file", not "one value per line".  This is not
> > > > > > ok.
> > > > >
> > > > > I see. Would listing these out as three separate vdos (i.e vdo0, vdo1,
> > > > > vdo2) be better?
> > > >
> > > > Given that your current implementation is not acceptable, something has
> > > > to change :)
> > >
> > > Got it. I'd like to see if Heikki has any suggestions on naming these
> > > entries better.
> >
> > Why not have product type specific attribute files?
> >
> > So if the partner is UFP, then we expose ufp1 and ufp2 files that
> > return the UFP1 and UFP2 VDO values and hide the other files:
> >
> >         % ls /sys/class/typec/port0-partner/identity/
> >         id_header cert_stat product ufp1 ufp2
> >
> > If the partner is DFP, then you expose the dfp file and hide
> > everything else:
> >
> >         % ls /sys/class/typec/port0-partner/identity/
> >         id_header cert_stat product dfp
> >
> > And so on.
> 
> I would caution against any decoding of the VDO contents in the kernel
> and making assumptions about the # or the names of these three
> individual objects.
> 
> Since PD 2.0 through PD 3.0, and PD 3.0's different subrevisions (1.0,
> 1.3, 2.0), the # of VDOs that have been supported has changed in the
> various spec versions.
> 
> PD R3.0 V2.0 actually added extra objects here (UFP VDO1 UFP VDO2, DFP
> VDO), but thanks to some troublemaker (me, actually...), the PD spec's
> next version deprecates and deletes two of them (the AMA VDO and the
> UFP VDO2 are gone, thanks to an ECR I put into USB PD).
> 
> (If you've got USB PD working group access, the two ECRs in question
> are: https://groups.usb.org/wg/powerdelivery/document/11007 and
> https://groups.usb.org/wg/powerdelivery/document/10967).
> 
> Since the different spec versions need to all be supported (since the
> firmware of PD devices are baked for a particular version of the PD
> spec at the time they are released and don't change in practice), the
> software on USB PD hosts should provide these objects up to the next
> layer without adding any extra decoding, and the upper layer
> (userspace) can figure out the specifics based on comparing different
> revision and version fields to figure out what vdo1, vdo2, and vdo3
> are.

Agreed. This is a good point. This reminds me why I never exposed the
product type VDOs in the first place.

> Anyway, hope this helps, and sorry in advance for making this section
> of the PD spec more complicated to handle over time...

Thanks for the heads up. For the record, I don't think you are the
only troublemaker :-). Some of the parts in the USB PD specification
and many parts in the USB Type-C specification have been a bit of a
moving target (though, I was hoping that things would have settled
down by now).

This is btw. the reason why I wanted to use interpreted kernel
specific attribute files for example with the roles instead of trying
to expose things like the specs says. I never accepted terms like UFP,
DFP, DRP or DRD, and I'm really clad I didn't - the meaning of those
has changed over the time in the USB Type-C specifications.

Because of the constantly changing specifications, the goal remains
the same. We pick only the details that we need, and that we are
pretty certain will not change, and expose those in our own format
(which ideally is human readable as well as machine readable) instead
of exposing all the data that those details are part of in the raw
format that follows the specification of today.

But I guess we can't pick any more specific details out of the
response to the Discover Identity. We are going to have to dump the
whole thing to the user as it is.


thanks,

-- 
heikki
