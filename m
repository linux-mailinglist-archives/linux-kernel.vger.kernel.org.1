Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49DB527D3F8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 18:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgI2Qxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 12:53:34 -0400
Received: from mga07.intel.com ([134.134.136.100]:26056 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727871AbgI2Qxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 12:53:33 -0400
IronPort-SDR: EZH4zQYRuuacaSxhZuTOKx4C+Ge+AnhOaDH3ealxQ+QXhe1uinI8eoxc02px6jQTiNiLgr4vhC
 AaATsRkQNI0Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="226385071"
X-IronPort-AV: E=Sophos;i="5.77,319,1596524400"; 
   d="scan'208";a="226385071"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 09:53:32 -0700
IronPort-SDR: iaEAHSVLG8Cls/cyb2sG38KkiKCv0wiFG07Tx16NAdCCHmXDPm+bUQc5wdTROqoWYWPfLzy7rE
 cU9qR2RPRZog==
X-IronPort-AV: E=Sophos;i="5.77,319,1596524400"; 
   d="scan'208";a="338728130"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 09:53:30 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kNIsX-002qC9-Lx; Tue, 29 Sep 2020 19:53:25 +0300
Date:   Tue, 29 Sep 2020 19:53:25 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Limonciello, Mario" <Mario.Limonciello@dell.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.de>
Subject: Re: Keyboard regression by intel-vbtn
Message-ID: <20200929165325.GW3956970@smile.fi.intel.com>
References: <s5hft71klxl.wl-tiwai@suse.de>
 <bedb9d1b-3cca-43e2-ee44-1aac0e09a605@redhat.com>
 <s5h8sctkk2b.wl-tiwai@suse.de>
 <-ICwwoAndae7T9i-Ymr7Nx9jnXVd7H54dnkMmCWUcApM1S0FUPplPWhg8DVXkphN0L4DoTy24robhTiBzMmSBKZRl-P8VEXIX5r6ttceA_8=@protonmail.com>
 <8c3d8a56-541f-aafc-1be9-4d72d374effe@redhat.com>
 <DM6PR19MB2636C7C411E220565F39E741FA320@DM6PR19MB2636.namprd19.prod.outlook.com>
 <55e021b7-5e1b-986b-07ec-279398570e40@redhat.com>
 <DM6PR19MB2636FFC274423BB564A7532CFA320@DM6PR19MB2636.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR19MB2636FFC274423BB564A7532CFA320@DM6PR19MB2636.namprd19.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 02:25:12PM +0000, Limonciello, Mario wrote:
> > -----Original Message-----
> > From: Hans de Goede <hdegoede@redhat.com>
> > Sent: Tuesday, September 29, 2020 7:54
> > On 9/29/20 2:27 PM, Limonciello, Mario wrote:

...

> > >> I'm afraid that the only answer which I have to these questions
> > >> is not helpful, but in my experience it is true: "firmware sucks".
> > >
> > > So FWIW there is a Dell 2-in-1 that has been conflated into this same issue.
> > > https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1822394
> > 
> > That is what a somewhat old kernel (5.0.0) which I guess may
> > lack your fix to check the chassis-type.
> > 
> > Interesting that this actually is a 2-in-1 though.
> > 
> > Also interesting that according to the reporter this was
> > triggered by a BIOS update.
> > 
> > If you by any chance can provide an acpidump with both the
> > 1.2.0 and 1.4.0 BIOS versions that would be very interesting.
> 
> I requested on the Ubuntu bug for someone to provide these.
> 
> > > Something that is confusing to me is that on the Windows side all these
> > > machines use the same Intel driver for this infrastructure no matter the
> > > OEM.
> > > So they can't possibly be putting in quirk specific stuff in the driver side
> > > can they?
> > >
> > > It has to make you wonder if some baseline assumptions made in the
> > > driver early on around tablet mode support are completely false.
> > 
> > I'm not saying your wrong. If you can get Intel to provide
> > us with some documentation, or Windows driver source code
> > for this, then that would be great.
> > 
> > AFAICT the Linux driver currently is entirely based on
> > reverse engineering.
> 
> That's correct it was originally reverse engineered.
> 
> Andy,
> 
> As there is no publicly available documentation, could you see if it would it be
> possible to get someone internal to Intel to compare private documentation to the
> driver to see if something basic is missing or done wrong?

I'm afraid that's all was designed solely for Windows and all information is
not available to us in any form (basically somebody has to ask for WOS driver
sources, and funny that as a customer your has more power to get this than mere
in-house Linux engineer as me).

-- 
With Best Regards,
Andy Shevchenko


