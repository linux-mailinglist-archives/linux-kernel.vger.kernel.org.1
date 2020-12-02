Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7852CC417
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 18:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730847AbgLBRnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 12:43:41 -0500
Received: from mga09.intel.com ([134.134.136.24]:59251 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbgLBRnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 12:43:41 -0500
IronPort-SDR: k+2OEwZJgHnn38hSL16KY9ZFlXMgClN3MlvyAdojMQXFAYNvdz2kSQUUv4WM6JXkocGHViJTBE
 70kHJB0TWlYA==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="173218360"
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; 
   d="scan'208";a="173218360"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 09:42:00 -0800
IronPort-SDR: GN99K6ZbejK075craB6Rp39UmY7jDfEzgyElvmpjXBUw21k3H2hrm7cArnjc+O9Z9tyrdNEyvA
 7OGAlRuilHZg==
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; 
   d="scan'208";a="550151821"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 09:42:00 -0800
Received: from localhost (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id 59D246363;
        Wed,  2 Dec 2020 09:42:00 -0800 (PST)
Date:   Wed, 2 Dec 2020 09:42:00 -0800
From:   mark gross <mgross@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     mgross@linux.intel.com, markgross@kernel.org, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        corbet@lwn.net, leonard.crestez@nxp.com, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, peng.fan@nxp.com, robh+dt@kernel.org,
        shawnguo@kernel.org, linux-kernel@vger.kernel.org,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>
Subject: Re: [PATCH 03/22] keembay-ipc: Add Keem Bay IPC module
Message-ID: <20201202174200.GG63356@mtg-dev.jf.intel.com>
Reply-To: mgross@linux.intel.com
References: <20201201223511.65542-1-mgross@linux.intel.com>
 <20201201223511.65542-4-mgross@linux.intel.com>
 <X8cxNA3GTi/LrTt/@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X8cxNA3GTi/LrTt/@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 07:16:20AM +0100, Greg KH wrote:
> On Tue, Dec 01, 2020 at 02:34:52PM -0800, mgross@linux.intel.com wrote:
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -8955,6 +8955,14 @@ M:	Deepak Saxena <dsaxena@plexity.net>
> >  S:	Maintained
> >  F:	drivers/char/hw_random/ixp4xx-rng.c
> >  
> > +INTEL KEEM BAY IPC DRIVER
> > +M:	Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> > +M:	Mark Gross <mgross@linux.intel.com>
> > +S:	Maintained
> > +F:	Documentation/devicetree/bindings/soc/intel/intel,keembay-ipc.yaml
> > +F:	drivers/soc/intel/keembay-ipc.c
> > +F:	include/linux/soc/intel/keembay-ipc.h
> 
> Sad that Intel is not going to actually pay you all to do this
> maintenance work for a brand new subsystem you are wanting to add to the
> tree :(
I thought adding my name to these maintainer items would help with continuity
as the individual engineers tend to move on to other things over time.

While I'm paid for a number of things at intel this is one of them.  My role is
as stable as I choose it to be at the point I'm at in my Intel career and the
business unit I'm now part of.  We can leave my name off if that would be
better.

Even if I'm not a VPU IP domain expert like Daniele is I can still chase down
the experts as needed after Daniele grows into other things over time.

> 
> Does this mean you all will have to do it on your own time and not as
> part of your work at Intel?  If so, why not just use your personal email
> addresses instead to make it a bit more obvious?
nah, as I've been getting older I've been getting more stingy with my me time
with my non-tech hobbies.  When I do retire (or whatever) from Intel we'll need
to remove my name for the stuff I'll not be getting paid for any more.

--mark
