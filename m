Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBE12CFAA6
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 09:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbgLEIlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 03:41:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:52856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbgLEIky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 03:40:54 -0500
Date:   Sat, 5 Dec 2020 09:40:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607157606;
        bh=c96FpZ3bft7tGDNQlyCJZapuv3MHuRnnDWuFkgNFGpY=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=f5SRoPrzMWbTqK6nTXNgW/+tOQc5WxtE6hF2n96ansyjkXmmWjPpdgdUP5WxBuBcZ
         TvwSvjIe12k2rA4XUmDqPfOx5/enhHyDtGZb+HGHYsfbx9x4Y0n4ocN06xcvI3lDKt
         4TOqCPt1qBxLTBcHtw6ZRPECbzyIMatLV+GPZbog=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     mark gross <mgross@linux.intel.com>
Cc:     markgross@kernel.org, arnd@arndb.de, bp@suse.de,
        damien.lemoal@wdc.com, dragan.cvetic@xilinx.com, corbet@lwn.net,
        leonard.crestez@nxp.com, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, peng.fan@nxp.com, robh+dt@kernel.org,
        shawnguo@kernel.org, linux-kernel@vger.kernel.org,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        sundar.iyer@intel.com
Subject: Re: [PATCH 03/22] keembay-ipc: Add Keem Bay IPC module
Message-ID: <X8tHY5W/ueQYEaN6@kroah.com>
References: <20201201223511.65542-1-mgross@linux.intel.com>
 <20201201223511.65542-4-mgross@linux.intel.com>
 <X8cxNA3GTi/LrTt/@kroah.com>
 <20201202174200.GG63356@mtg-dev.jf.intel.com>
 <X8fkflUXwSTGAoyQ@kroah.com>
 <20201205033517.GA49179@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201205033517.GA49179@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 07:35:17PM -0800, mark gross wrote:
> On Wed, Dec 02, 2020 at 08:01:18PM +0100, Greg KH wrote:
> > On Wed, Dec 02, 2020 at 09:42:00AM -0800, mark gross wrote:
> > > On Wed, Dec 02, 2020 at 07:16:20AM +0100, Greg KH wrote:
> > > > On Tue, Dec 01, 2020 at 02:34:52PM -0800, mgross@linux.intel.com wrote:
> > > > > --- a/MAINTAINERS
> > > > > +++ b/MAINTAINERS
> > > > > @@ -8955,6 +8955,14 @@ M:	Deepak Saxena <dsaxena@plexity.net>
> > > > >  S:	Maintained
> > > > >  F:	drivers/char/hw_random/ixp4xx-rng.c
> > > > >  
> > > > > +INTEL KEEM BAY IPC DRIVER
> > > > > +M:	Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> > > > > +M:	Mark Gross <mgross@linux.intel.com>
> > > > > +S:	Maintained
> > > > > +F:	Documentation/devicetree/bindings/soc/intel/intel,keembay-ipc.yaml
> > > > > +F:	drivers/soc/intel/keembay-ipc.c
> > > > > +F:	include/linux/soc/intel/keembay-ipc.h
> > > > 
> > > > Sad that Intel is not going to actually pay you all to do this
> > > > maintenance work for a brand new subsystem you are wanting to add to the
> > > > tree :(
> > > I thought adding my name to these maintainer items would help with continuity
> > > as the individual engineers tend to move on to other things over time.
> > > 
> > > While I'm paid for a number of things at intel this is one of them.  My role is
> > > as stable as I choose it to be at the point I'm at in my Intel career and the
> > > business unit I'm now part of.  We can leave my name off if that would be
> > > better.
> > > 
> > > Even if I'm not a VPU IP domain expert like Daniele is I can still chase down
> > > the experts as needed after Daniele grows into other things over time.
> > 
> > I'm not objecting to your, or anyone else's name on this at all.  I'm
> > just asking about Intel's support for this new codebase being added.
> > Having a new subsystem from a major company and not have someone paid to
> > actually maintain it seems really odd to me.
> > 
> > That's all.  If that's Intel's stance, that's fine, just wanted to
> > clarify it is correct as I know some people at Intel have been confused
> > recently about just what the S: field means.
> I've been following up on whether the status field should be "Supported" or
> "Maintained" at this time.  For this current instantiation of the VPU enabling
> under review here I think Maintained most appropriate.  There are a good number
> of people who look after it.
> 
> However; I have learned that the instantiations of the VPU after keem bay and
> its follow on SoC will include an evolution of this stack and between now and
> when those get close to landing that evolved version will become "Supported".
> 
> Given this, would it be more appropriate to put this stack into staging for a
> while?

drivers/staging/ is for code that for some reason is not good enough to
be merged to the "right" place in the kernel tree, and you need
community help to get it cleaned up because you can not do it yourself.

Is that the case here?  If not, then no, it should not go into
drivers/staging/.

thanks,

greg k-h
