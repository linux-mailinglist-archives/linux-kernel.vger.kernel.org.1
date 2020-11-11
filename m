Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D61D62AEE12
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 10:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgKKJsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 04:48:42 -0500
Received: from mga05.intel.com ([192.55.52.43]:45825 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbgKKJsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 04:48:41 -0500
IronPort-SDR: abQ4RE8/u+Zytxkr41f9hWK/Xvd/gr3MqVLphKQ6QnVs5WinG6JsXyYXgjntNsxUTYoowSO529
 xKkmlt/r3Wiw==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="254831217"
X-IronPort-AV: E=Sophos;i="5.77,469,1596524400"; 
   d="scan'208";a="254831217"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2020 01:48:33 -0800
IronPort-SDR: 0a/5dAA42owuPF8WikIMxMCIWJMVuHbslnMTJG6pKrT6c2RCnKBuzjpyFklNVJBSFT4+/0WEWH
 NCdqf9vu51Dg==
X-IronPort-AV: E=Sophos;i="5.77,469,1596524400"; 
   d="scan'208";a="531632629"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2020 01:48:31 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kcmkv-005s6P-2n; Wed, 11 Nov 2020 11:49:33 +0200
Date:   Wed, 11 Nov 2020 11:49:33 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>
Cc:     "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>
Subject: Re: [PATCH v2 2/2] phy: intel: Add Keem Bay USB PHY support
Message-ID: <20201111094933.GG4077@smile.fi.intel.com>
References: <20201109031654.22443-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20201109031654.22443-3-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20201109114102.GY4077@smile.fi.intel.com>
 <DM6PR11MB3721899F79D7A75BBEE85C5FDDE80@DM6PR11MB3721.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB3721899F79D7A75BBEE85C5FDDE80@DM6PR11MB3721.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 09:28:34AM +0000, Wan Mohamad, Wan Ahmad Zainie wrote:
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: Monday, November 9, 2020 7:41 PM
> > To: Wan Mohamad, Wan Ahmad Zainie
> > On Mon, Nov 09, 2020 at 11:16:54AM +0800, Wan Ahmad Zainie wrote:

...

> > > +	usleep_range(30, 50);
> > 
> > Why 30-50?
> 
> I take this value from boot firmware.
> There is a delay of 30us after clearing IDDQ_enable bit.
> I believe the purpose is to ensure all analog blocks are powered up.

Then put it into comment.

...

> > > +	usleep_range(20, 50);
> > 
> > Why these numbers?
> 
> In Keem Bay data book, under USB initialization section,
> there is step that there must be a minimum 20us wait
> after clock enable, before bringing PHYs out of reset.
> 
> 50 is the value that I picked randomly. Is usleep_range(20, 20)
> Better?

No, the better as I told you already few times is to comment "why?" these
numbers. Above can be like:
"According to datasheet this step requires 20us wait..."

...

> > > +	usleep_range(2, 10);
> > 
> > Ditto.
> 
> Under the same section above, there is a step for 2us wait.
> I believe it is for register write to go through.

Ditto.

> > 
> > ...
> > 
> > > +	usleep_range(20, 50);
> > 
> > Ditto.
> 
> Under the same section above, there is a step to wait 20us
> after setting SRAM load bit, before release the controller
> reset.
> 
> I will add comment for those 4 delay above.

Yes, please.

...

> Before I proceed with v3, I would like to know if I should
> use udelay(), instead of usleep_range()?
> I refer to https://www.kernel.org/doc/Documentation/timers/timers-howto.txt.

You should know your code better than me. That howto is clear about when of
which API calls can be used.

-- 
With Best Regards,
Andy Shevchenko


