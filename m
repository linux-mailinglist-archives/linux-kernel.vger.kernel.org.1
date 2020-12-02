Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6124C2CC61A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 20:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389494AbgLBTCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 14:02:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:47222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbgLBTCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 14:02:02 -0500
Date:   Wed, 2 Dec 2020 20:01:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606935682;
        bh=IjMI8CJE7unsaBbrJ0CoZSVehDUAHUWSL6E99lkW2po=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=P3L9lRg+20QNXHFBuMiDzDacZYK0dIgITJmdqeRgdL9xG+GkWn1+Jd9owrF4MMXT+
         YZjIwiDTUDnNm5QI6fVuQ61aSM2lyafmhtbmFQh2moP0RqgDPe0IbRfiquzRM4EITs
         fRoW6Y/tP9QTZS9f2EHgkloof96tsZz0vxEF0UE0=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     mark gross <mgross@linux.intel.com>
Cc:     markgross@kernel.org, arnd@arndb.de, bp@suse.de,
        damien.lemoal@wdc.com, dragan.cvetic@xilinx.com, corbet@lwn.net,
        leonard.crestez@nxp.com, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, peng.fan@nxp.com, robh+dt@kernel.org,
        shawnguo@kernel.org, linux-kernel@vger.kernel.org,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>
Subject: Re: [PATCH 03/22] keembay-ipc: Add Keem Bay IPC module
Message-ID: <X8fkflUXwSTGAoyQ@kroah.com>
References: <20201201223511.65542-1-mgross@linux.intel.com>
 <20201201223511.65542-4-mgross@linux.intel.com>
 <X8cxNA3GTi/LrTt/@kroah.com>
 <20201202174200.GG63356@mtg-dev.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202174200.GG63356@mtg-dev.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 09:42:00AM -0800, mark gross wrote:
> On Wed, Dec 02, 2020 at 07:16:20AM +0100, Greg KH wrote:
> > On Tue, Dec 01, 2020 at 02:34:52PM -0800, mgross@linux.intel.com wrote:
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -8955,6 +8955,14 @@ M:	Deepak Saxena <dsaxena@plexity.net>
> > >  S:	Maintained
> > >  F:	drivers/char/hw_random/ixp4xx-rng.c
> > >  
> > > +INTEL KEEM BAY IPC DRIVER
> > > +M:	Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> > > +M:	Mark Gross <mgross@linux.intel.com>
> > > +S:	Maintained
> > > +F:	Documentation/devicetree/bindings/soc/intel/intel,keembay-ipc.yaml
> > > +F:	drivers/soc/intel/keembay-ipc.c
> > > +F:	include/linux/soc/intel/keembay-ipc.h
> > 
> > Sad that Intel is not going to actually pay you all to do this
> > maintenance work for a brand new subsystem you are wanting to add to the
> > tree :(
> I thought adding my name to these maintainer items would help with continuity
> as the individual engineers tend to move on to other things over time.
> 
> While I'm paid for a number of things at intel this is one of them.  My role is
> as stable as I choose it to be at the point I'm at in my Intel career and the
> business unit I'm now part of.  We can leave my name off if that would be
> better.
> 
> Even if I'm not a VPU IP domain expert like Daniele is I can still chase down
> the experts as needed after Daniele grows into other things over time.

I'm not objecting to your, or anyone else's name on this at all.  I'm
just asking about Intel's support for this new codebase being added.
Having a new subsystem from a major company and not have someone paid to
actually maintain it seems really odd to me.

That's all.  If that's Intel's stance, that's fine, just wanted to
clarify it is correct as I know some people at Intel have been confused
recently about just what the S: field means.

thanks,

greg k-h
