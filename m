Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527802CAA19
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 18:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbgLARrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 12:47:25 -0500
Received: from mga17.intel.com ([192.55.52.151]:58592 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgLARrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 12:47:25 -0500
IronPort-SDR: rTZCZTJ46TYEVNFB/lIXOhhwBh9nVG2IBuB2Ba6ehYKkOVe18qSFZ98imDWV3ji/B1d0d+Feel
 lO+s/Tv+bHhA==
X-IronPort-AV: E=McAfee;i="6000,8403,9822"; a="152703199"
X-IronPort-AV: E=Sophos;i="5.78,384,1599548400"; 
   d="scan'208";a="152703199"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 09:45:43 -0800
IronPort-SDR: b9TtSB08Yw62onAxXyzR23D+l+0x/+faIwT6hDz4m1aaiPz89UNwA4vzt10qHCY25ZirdWXykL
 Dg6/NgvQdVOQ==
X-IronPort-AV: E=Sophos;i="5.78,384,1599548400"; 
   d="scan'208";a="481191895"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 09:45:43 -0800
Received: from localhost (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id 1A9EA6363;
        Tue,  1 Dec 2020 09:45:43 -0800 (PST)
Date:   Tue, 1 Dec 2020 09:45:43 -0800
From:   mark gross <mgross@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     mgross@linux.intel.com, linux-kernel@vger.kernel.org,
        markgross@kernel.org, adam.r.gretzinger@intel.com,
        Srikanth Thokala <srikanth.thokala@intel.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 07/22] misc: xlink-pcie: lh: Add PCIe EPF driver for
 Local Host
Message-ID: <20201201174542.GB56560@mtg-dev.jf.intel.com>
Reply-To: mgross@linux.intel.com
References: <20201130230707.46351-1-mgross@linux.intel.com>
 <20201130230707.46351-8-mgross@linux.intel.com>
 <X8YXMVD1i90VWaPa@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X8YXMVD1i90VWaPa@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 11:13:05AM +0100, Greg Kroah-Hartman wrote:
> On Mon, Nov 30, 2020 at 03:06:52PM -0800, mgross@linux.intel.com wrote:
> > From: Srikanth Thokala <srikanth.thokala@intel.com>
> > 
> > Add PCIe EPF driver for local host (lh) to configure BAR's and other
> > HW resources. Underlying PCIe HW controller is a Synopsys DWC PCIe core.
> > 
> > Cc: Derek Kiernan <derek.kiernan@xilinx.com>
> > Cc: Dragan Cvetic <dragan.cvetic@xilinx.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reviewed-by: Mark Gross <mgross@linux.intel.com>
> > Signed-off-by: Srikanth Thokala <srikanth.thokala@intel.com>
> 
> <snip>
> 
> Again, you sent this twice?  And it never got to lore.kernel.org nor the
> mailing lists?
In my excitement of sorting out my MTA misconfiguration work around I actually
hit entry without including the magic fix
"--envelope-sender=mgross@linux.intel.com" in my git send-email command line. 
> 
> And I can't see a 00/XX email anywhere explaining this, and I didn't get
> the whole series?
https://lore.kernel.org/lkml/20201130230707.46351-1-mgross@linux.intel.com/

Did I mess up on who all should get the 00/xx email?

> 
> Something is really wrong on your end with your email client
> configuration, please fix that up and send this so that we can actually
> see it all, and know what the heck we are supposed to be reviewing...

Yes, I think I have it fixed, or worked around now.

sorry,

--mark
