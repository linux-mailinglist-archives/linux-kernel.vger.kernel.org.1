Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4762D08E6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 02:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgLGBiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 20:38:22 -0500
Received: from mga17.intel.com ([192.55.52.151]:64927 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbgLGBiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 20:38:22 -0500
IronPort-SDR: EKjRHqbCSLKyBCWYeriPJK817narrhHuq6sL40mUakuWZG8JdfdTwCSxtC9BsxL6gyQo1VWNUd
 8ITHyRsss4uQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9827"; a="153444888"
X-IronPort-AV: E=Sophos;i="5.78,398,1599548400"; 
   d="scan'208";a="153444888"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2020 17:36:35 -0800
IronPort-SDR: dALR44GqyBP5MBWzUgeqnZP9AQDvBVCTKFBZ5lAQwml9EY2vA68FbP8tyP6sdjG9WoOP4mHKMC
 RYZqIs8/+V1Q==
X-IronPort-AV: E=Sophos;i="5.78,398,1599548400"; 
   d="scan'208";a="369601796"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2020 17:36:35 -0800
Received: from localhost (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id DA3FF6363;
        Sun,  6 Dec 2020 17:36:34 -0800 (PST)
Date:   Sun, 6 Dec 2020 17:36:34 -0800
From:   mark gross <mgross@linux.intel.com>
To:     "Gross, Mark" <mark.gross@intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        mark gross <mgross@linux.intel.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@suse.de" <bp@suse.de>,
        "damien.lemoal@wdc.com" <damien.lemoal@wdc.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "leonard.crestez@nxp.com" <leonard.crestez@nxp.com>,
        "palmerdabbelt@google.com" <palmerdabbelt@google.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "peng.fan@nxp.com" <peng.fan@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alessandrelli, Daniele" <daniele.alessandrelli@intel.com>,
        "Iyer, Sundar" <sundar.iyer@intel.com>
Subject: Re: [PATCH 03/22] keembay-ipc: Add Keem Bay IPC module
Message-ID: <20201207013634.GB49179@linux.intel.com>
Reply-To: mgross@linux.intel.com
References: <20201201223511.65542-1-mgross@linux.intel.com>
 <20201201223511.65542-4-mgross@linux.intel.com>
 <X8cxNA3GTi/LrTt/@kroah.com>
 <20201202174200.GG63356@mtg-dev.jf.intel.com>
 <X8fkflUXwSTGAoyQ@kroah.com>
 <20201205033517.GA49179@linux.intel.com>
 <X8tHY5W/ueQYEaN6@kroah.com>
 <MWHPR11MB16793B6D480A452273A60C5C8EF00@MWHPR11MB1679.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR11MB16793B6D480A452273A60C5C8EF00@MWHPR11MB1679.namprd11.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 05, 2020 at 04:37:25PM +0000, Gross, Mark wrote:
> 
> 
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Saturday, December 5, 2020 12:40 AM
> > To: mark gross <mgross@linux.intel.com>
> > Cc: markgross@kernel.org; arnd@arndb.de; bp@suse.de;
> > damien.lemoal@wdc.com; dragan.cvetic@xilinx.com; corbet@lwn.net;
> > leonard.crestez@nxp.com; palmerdabbelt@google.com;
> > paul.walmsley@sifive.com; peng.fan@nxp.com; robh+dt@kernel.org;
> > shawnguo@kernel.org; linux-kernel@vger.kernel.org; Alessandrelli, Daniele
> > <daniele.alessandrelli@intel.com>; Iyer, Sundar <sundar.iyer@intel.com>
> > Subject: Re: [PATCH 03/22] keembay-ipc: Add Keem Bay IPC module
> > 
> > On Fri, Dec 04, 2020 at 07:35:17PM -0800, mark gross wrote:
> > > On Wed, Dec 02, 2020 at 08:01:18PM +0100, Greg KH wrote:
> > > > On Wed, Dec 02, 2020 at 09:42:00AM -0800, mark gross wrote:
> > > > > On Wed, Dec 02, 2020 at 07:16:20AM +0100, Greg KH wrote:
> > > > > > On Tue, Dec 01, 2020 at 02:34:52PM -0800, mgross@linux.intel.com wrote:
> > > > > > > --- a/MAINTAINERS
> > > > > > > +++ b/MAINTAINERS
> > > > > > > @@ -8955,6 +8955,14 @@ M:	Deepak Saxena <dsaxena@plexity.net>
> > > > > > >  S:	Maintained
> > > > > > >  F:	drivers/char/hw_random/ixp4xx-rng.c
> > > > > > >
> > > > > > > +INTEL KEEM BAY IPC DRIVER
> > > > > > > +M:	Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> > > > > > > +M:	Mark Gross <mgross@linux.intel.com>
> > > > > > > +S:	Maintained
> > > > > > > +F:	Documentation/devicetree/bindings/soc/intel/intel,keembay-
> > ipc.yaml
> > > > > > > +F:	drivers/soc/intel/keembay-ipc.c
> > > > > > > +F:	include/linux/soc/intel/keembay-ipc.h
> > > > > >
> > > > > > Sad that Intel is not going to actually pay you all to do this
> > > > > > maintenance work for a brand new subsystem you are wanting to
> > > > > > add to the tree :(
> > > > > I thought adding my name to these maintainer items would help with
> > > > > continuity as the individual engineers tend to move on to other things over
> > time.
> > > > >
> > > > > While I'm paid for a number of things at intel this is one of
> > > > > them.  My role is as stable as I choose it to be at the point I'm
> > > > > at in my Intel career and the business unit I'm now part of.  We
> > > > > can leave my name off if that would be better.
> > > > >
> > > > > Even if I'm not a VPU IP domain expert like Daniele is I can still
> > > > > chase down the experts as needed after Daniele grows into other things over
> > time.
> > > >
> > > > I'm not objecting to your, or anyone else's name on this at all.
> > > > I'm just asking about Intel's support for this new codebase being added.
> > > > Having a new subsystem from a major company and not have someone
> > > > paid to actually maintain it seems really odd to me.
> > > >
> > > > That's all.  If that's Intel's stance, that's fine, just wanted to
> > > > clarify it is correct as I know some people at Intel have been
> > > > confused recently about just what the S: field means.
> > > I've been following up on whether the status field should be
> > > "Supported" or "Maintained" at this time.  For this current
> > > instantiation of the VPU enabling under review here I think Maintained
> > > most appropriate.  There are a good number of people who look after it.
> > >
> > > However; I have learned that the instantiations of the VPU after keem
> > > bay and its follow on SoC will include an evolution of this stack and
> > > between now and when those get close to landing that evolved version will
> > become "Supported".
> > >
> > > Given this, would it be more appropriate to put this stack into
> > > staging for a while?
> > 
> > drivers/staging/ is for code that for some reason is not good enough to be merged
> > to the "right" place in the kernel tree, and you need community help to get it
> > cleaned up because you can not do it yourself.
> > 
> > Is that the case here?  If not, then no, it should not go into drivers/staging/.
> That is not the case here.  Lets proceed as we are on this then.
>
I guess technically we have number of engineers paid to look after this version
of the VPU enabling.  I guess I'm over thinking things.  I'll change it S:
record from Maintained to Supported on the next version.

--mark

