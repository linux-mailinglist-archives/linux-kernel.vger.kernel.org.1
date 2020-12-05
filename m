Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E54A2CF92E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 04:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgLEDg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 22:36:59 -0500
Received: from mga17.intel.com ([192.55.52.151]:43735 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725300AbgLEDg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 22:36:59 -0500
IronPort-SDR: 1p/KY83DLZHPINnIbKPlPOm5hToN6T3wIuni6FrgddPwClq53WZHIKF46WJ7cVg0ITcvY2rkZ/
 nwNdBDkXjUUA==
X-IronPort-AV: E=McAfee;i="6000,8403,9825"; a="153304691"
X-IronPort-AV: E=Sophos;i="5.78,394,1599548400"; 
   d="scan'208";a="153304691"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2020 19:35:18 -0800
IronPort-SDR: s/B+7u6X3afmwEuY1auMK2cQSXoEmJh9unjzkcQNSl7VQCeENL8eJ+N177KtR+81gQbYv2Ig1H
 XXLA8cXi2gpw==
X-IronPort-AV: E=Sophos;i="5.78,394,1599548400"; 
   d="scan'208";a="540949487"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2020 19:35:17 -0800
Received: from localhost (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id 472986363;
        Fri,  4 Dec 2020 19:35:17 -0800 (PST)
Date:   Fri, 4 Dec 2020 19:35:17 -0800
From:   mark gross <mgross@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     mark gross <mgross@linux.intel.com>, markgross@kernel.org,
        arnd@arndb.de, bp@suse.de, damien.lemoal@wdc.com,
        dragan.cvetic@xilinx.com, corbet@lwn.net, leonard.crestez@nxp.com,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        linux-kernel@vger.kernel.org,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        sundar.iyer@intel.com
Subject: Re: [PATCH 03/22] keembay-ipc: Add Keem Bay IPC module
Message-ID: <20201205033517.GA49179@linux.intel.com>
Reply-To: mgross@linux.intel.com
References: <20201201223511.65542-1-mgross@linux.intel.com>
 <20201201223511.65542-4-mgross@linux.intel.com>
 <X8cxNA3GTi/LrTt/@kroah.com>
 <20201202174200.GG63356@mtg-dev.jf.intel.com>
 <X8fkflUXwSTGAoyQ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X8fkflUXwSTGAoyQ@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 08:01:18PM +0100, Greg KH wrote:
> On Wed, Dec 02, 2020 at 09:42:00AM -0800, mark gross wrote:
> > On Wed, Dec 02, 2020 at 07:16:20AM +0100, Greg KH wrote:
> > > On Tue, Dec 01, 2020 at 02:34:52PM -0800, mgross@linux.intel.com wrote:
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -8955,6 +8955,14 @@ M:	Deepak Saxena <dsaxena@plexity.net>
> > > >  S:	Maintained
> > > >  F:	drivers/char/hw_random/ixp4xx-rng.c
> > > >  
> > > > +INTEL KEEM BAY IPC DRIVER
> > > > +M:	Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> > > > +M:	Mark Gross <mgross@linux.intel.com>
> > > > +S:	Maintained
> > > > +F:	Documentation/devicetree/bindings/soc/intel/intel,keembay-ipc.yaml
> > > > +F:	drivers/soc/intel/keembay-ipc.c
> > > > +F:	include/linux/soc/intel/keembay-ipc.h
> > > 
> > > Sad that Intel is not going to actually pay you all to do this
> > > maintenance work for a brand new subsystem you are wanting to add to the
> > > tree :(
> > I thought adding my name to these maintainer items would help with continuity
> > as the individual engineers tend to move on to other things over time.
> > 
> > While I'm paid for a number of things at intel this is one of them.  My role is
> > as stable as I choose it to be at the point I'm at in my Intel career and the
> > business unit I'm now part of.  We can leave my name off if that would be
> > better.
> > 
> > Even if I'm not a VPU IP domain expert like Daniele is I can still chase down
> > the experts as needed after Daniele grows into other things over time.
> 
> I'm not objecting to your, or anyone else's name on this at all.  I'm
> just asking about Intel's support for this new codebase being added.
> Having a new subsystem from a major company and not have someone paid to
> actually maintain it seems really odd to me.
> 
> That's all.  If that's Intel's stance, that's fine, just wanted to
> clarify it is correct as I know some people at Intel have been confused
> recently about just what the S: field means.
I've been following up on whether the status field should be "Supported" or
"Maintained" at this time.  For this current instantiation of the VPU enabling
under review here I think Maintained most appropriate.  There are a good number
of people who look after it.

However; I have learned that the instantiations of the VPU after keem bay and
its follow on SoC will include an evolution of this stack and between now and
when those get close to landing that evolved version will become "Supported".

Given this, would it be more appropriate to put this stack into staging for a
while?

--mark
