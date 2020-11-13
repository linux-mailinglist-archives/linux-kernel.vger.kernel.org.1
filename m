Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC9F2B1D8C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 15:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgKMOfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 09:35:00 -0500
Received: from mga18.intel.com ([134.134.136.126]:36568 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgKMOfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 09:35:00 -0500
IronPort-SDR: Vf8f9vJ6S4JFCiLR5P1/o/xj931Wf6zNFFIsXZ+jw89EPq6jg5XdpiIbUT/ea76mxj4UxWKHXx
 IaucvluCk+Vw==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="158256834"
X-IronPort-AV: E=Sophos;i="5.77,475,1596524400"; 
   d="scan'208";a="158256834"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 06:34:59 -0800
IronPort-SDR: FbNcqzMJ+olQMY5FMx2HHZZl4U87xOT8vpQvk8zw5ozodckLrmrigiE61eV4ds76R6YNmGazX4
 nVNolGyiNHQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,475,1596524400"; 
   d="scan'208";a="429514883"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 13 Nov 2020 06:34:56 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 13 Nov 2020 16:34:56 +0200
Date:   Fri, 13 Nov 2020 16:34:56 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:USB NETWORKING DRIVERS" <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH v3 2/2] usb: typec: Expose Product Type VDOs via sysfs
Message-ID: <20201113143456.GA2084313@kuha.fi.intel.com>
References: <20201023214328.1262883-1-pmalani@chromium.org>
 <20201023214328.1262883-2-pmalani@chromium.org>
 <20201110115453.GI1224435@kuha.fi.intel.com>
 <20201112024055.GA1367855@google.com>
 <20201112124345.GS1224435@kuha.fi.intel.com>
 <CACeCKafKODtbhCinwD=uwDa==atQoJFyXGwMhJEczh2NWq4NMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACeCKafKODtbhCinwD=uwDa==atQoJFyXGwMhJEczh2NWq4NMQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 08:50:55AM -0800, Prashant Malani wrote:
> Hi Heikki,
> 
> On Thu, Nov 12, 2020 at 4:43 AM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > On Wed, Nov 11, 2020 at 06:40:55PM -0800, Prashant Malani wrote:
> > > Hi Heikki,
> > >
> > > On Tue, Nov 10, 2020 at 01:54:53PM +0200, Heikki Krogerus wrote:
> > > > On Fri, Oct 23, 2020 at 02:43:28PM -0700, Prashant Malani wrote:
> > > >
> > > > I've now come to the conclusion that this is not the correct approach.
> > > > Instead, the whole identity, all six VDOs, should be supplied
> > > > separately with a "raw" sysfs attribute file after all.
> > > >
> > > > The three attribute files that we already have - so id_header,
> > > > cert_stat and product - can always supply the actual VDO as is,
> > > > regardless of the product type, so they are fine. But these new
> > > > attribute files, product_type_vdoX, would behave differently as they
> > > > supply different information depending on the product type. That just
> > > > does not feel right to me.
> > >
> > > OOI: I'd like to understand the reservations around this approach. Can't
> > > userspace just read these and then interpret them appropriately according
> > > to the id_header as well as PD revision (and version number) if that's exposed?
> > > The only thing I see changing is how we name those product_type_vdoX
> > > sysfs files, i.e product_type_vdo0 == passive_cable_vdo OR active_cable_vdo1
> > > depending on the product type.
> > >
> > > That said, perhaps I'm missing some aspect of this.
> >
> > I don't think the userspace should have to interpret any of these
> > VDOs. If the userspace has to interpret the information, then the
> > userspace should interpret everything for the sake of consistency (so
> > the "raw" attribute file).
> >
> > But I still think that defining separate device types for every
> > product type would be the best way to handle the identity. We could
> > then have sysfs attribute files that are specific for each product
> > type. It does not even matter that some of the product types are going
> > to be removed. We will have to handle all of them in any case,
> > including the ones that were removed. This way things would be much
> > more clear for the userspace.
> >
> > The only problem IMO with the separate device types for each product
> > type is that we don't always have access to the Discover Identity
> > result. It means depending on your system we will claim the
> > partner device type is "default" (no identity information) or the
> > actual product type. That is also a bit inconsistent, but is is
> > acceptable? I would really like to here what Greg thinks about all
> > this.
> 
> Thanks for explaining the rationale.
> Of course, I defer to Greg & your decision on this :)
> 
> I'm yet unable to grasp what benefit userspace gets from having the kernel parse
> and present this data in appropriately named sysfs files when the userspace has
> enough info to do so itself.
> 
> For that reason and also because the "raw" approach is IMO a bit more
> resilient to the changes
> we talk about (some product type VDOs being dropped off across PD spec
> uprevs [1] etc)
> the "raw" proposal sounded appealing to me.

I'm not saying no to the "raw" proposal. I would prefer that we parse
the data for the userspace in this case, but if you guys think that it
is better to just let the userspace take care of that, then I'm fine
with that too.

> > > > So lets just add the "raw" sysfs attribute file. We can think about
> > > > extracting some other details from the product type VDOs once the
> > > > specification has settled down a bit and we can be quite certain that
> > > > those details will always be available.
> > > >
> > > > Would this be OK to you? I think we should be able to dump the data to
> > > > the "raw" sysfs attribute file with something like hex_dump_to_buffer().
> > >
> > > FWIW, "raw" option SGTM (the product type VDOs can be parsed from the
> > > buffer since the format is fixed).
> >
> > Well, I'm starting to think that what if we just prepare patches where
> > we propose separate device type for every product type? Of course, if
> > they are OK to you?
> >
> SG. To clarify, will you prepare these patches?

I'll take a look at this. I can prepare something. Let's start with
the raw dump approach.


thanks,

-- 
heikki
