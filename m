Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F37172CAF9B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 23:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404264AbgLAWCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 17:02:24 -0500
Received: from mga01.intel.com ([192.55.52.88]:25630 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387480AbgLAWCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 17:02:07 -0500
IronPort-SDR: V0QKVYJtdV3h4WlvS2IPS7ORFlShU8YtwTl6mDCVXWTShSJuuYkvhfCMNYDkl2DWwx272Wetvw
 5R9uZU60rqBg==
X-IronPort-AV: E=McAfee;i="6000,8403,9822"; a="191121078"
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="191121078"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 14:00:24 -0800
IronPort-SDR: c7NLj3x8UC6aOg7Y02rqrxcuf6+O6P0Bi7t5wlQeDm748teSZt6Wyby17HP8q6A6H4hrcZFDA8
 wg6jWdAWN68A==
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="361207688"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 14:00:23 -0800
Received: from localhost (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id 2B5016363;
        Tue,  1 Dec 2020 14:00:23 -0800 (PST)
Date:   Tue, 1 Dec 2020 14:00:23 -0800
From:   mark gross <mgross@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     mark gross <mgross@linux.intel.com>, linux-kernel@vger.kernel.org,
        markgross@kernel.org, adam.r.gretzinger@intel.com,
        Srikanth Thokala <srikanth.thokala@intel.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 07/22] misc: xlink-pcie: lh: Add PCIe EPF driver for
 Local Host
Message-ID: <20201201220023.GA63356@mtg-dev.jf.intel.com>
Reply-To: mgross@linux.intel.com
References: <20201130230707.46351-1-mgross@linux.intel.com>
 <20201130230707.46351-8-mgross@linux.intel.com>
 <X8YXMVD1i90VWaPa@kroah.com>
 <20201201174542.GB56560@mtg-dev.jf.intel.com>
 <X8aDVALdoi/Mg2LA@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X8aDVALdoi/Mg2LA@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 06:54:28PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Dec 01, 2020 at 09:45:43AM -0800, mark gross wrote:
> > On Tue, Dec 01, 2020 at 11:13:05AM +0100, Greg Kroah-Hartman wrote:
> > > On Mon, Nov 30, 2020 at 03:06:52PM -0800, mgross@linux.intel.com wrote:
> > > > From: Srikanth Thokala <srikanth.thokala@intel.com>
> > > > 
> > > > Add PCIe EPF driver for local host (lh) to configure BAR's and other
> > > > HW resources. Underlying PCIe HW controller is a Synopsys DWC PCIe core.
> > > > 
> > > > Cc: Derek Kiernan <derek.kiernan@xilinx.com>
> > > > Cc: Dragan Cvetic <dragan.cvetic@xilinx.com>
> > > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Reviewed-by: Mark Gross <mgross@linux.intel.com>
> > > > Signed-off-by: Srikanth Thokala <srikanth.thokala@intel.com>
> > > 
> > > <snip>
> > > 
> > > Again, you sent this twice?  And it never got to lore.kernel.org nor the
> > > mailing lists?
> > In my excitement of sorting out my MTA misconfiguration work around I actually
> > hit entry without including the magic fix
> > "--envelope-sender=mgross@linux.intel.com" in my git send-email command line. 
> > > 
> > > And I can't see a 00/XX email anywhere explaining this, and I didn't get
> > > the whole series?
> > https://lore.kernel.org/lkml/20201130230707.46351-1-mgross@linux.intel.com/
> > 
> > Did I mess up on who all should get the 00/xx email?
> 
> Yes, you need to include the people that you want to review the
> individual patches, otherwise we have no idea :(
>

Ok, I will reset and try again. I appoligize for this false start.
I'll resend after I trim the CC list based on Dragon's feedback.


--mark
