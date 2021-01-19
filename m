Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC0C2FB497
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 09:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbhASIwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 03:52:01 -0500
Received: from mga12.intel.com ([192.55.52.136]:16685 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbhASIvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 03:51:43 -0500
IronPort-SDR: FipACqjkVmBWYPwgEfOd4XR0g7/fUWG1VhaahQtXxnhYGNqAqtXPo8UxA/sBaKwzGw0cNOuzBe
 dJCkfvujzrZw==
X-IronPort-AV: E=McAfee;i="6000,8403,9868"; a="158077570"
X-IronPort-AV: E=Sophos;i="5.79,358,1602572400"; 
   d="scan'208";a="158077570"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 00:49:51 -0800
IronPort-SDR: E1bgHeIxth2unR7Y9/+ZKbPWF0Dgu0jSZ73lc5I+JnKlpsfu01GBKf56QTKcTQDPZ0tSsy5KTT
 oc+BzXVAtIJA==
X-IronPort-AV: E=Sophos;i="5.79,358,1602572400"; 
   d="scan'208";a="350443947"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 00:49:48 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l1miw-003J3e-D7; Tue, 19 Jan 2021 10:50:50 +0200
Date:   Tue, 19 Jan 2021 10:50:50 +0200
From:   "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
To:     "Ayyathurai, Vijayakannan" <vijayakannan.ayyathurai@intel.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Seow, Chen Yong" <chen.yong.seow@intel.com>
Subject: Re: [PATCH v2 2/2] clocksource: Add Intel Keem Bay Timer Support
Message-ID: <20210119085050.GM4077@smile.fi.intel.com>
References: <cover.1609306622.git.vijayakannan.ayyathurai@intel.com>
 <2a7038bc170e31a668995c367bbae018bf805dbe.1609306622.git.vijayakannan.ayyathurai@intel.com>
 <73330c8b-4633-4a13-b4b5-7405ff1661fe@linaro.org>
 <DM6PR11MB4250EB33E23178D211D0411DFBA30@DM6PR11MB4250.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB4250EB33E23178D211D0411DFBA30@DM6PR11MB4250.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 02:56:36AM +0000, Ayyathurai, Vijayakannan wrote:

...

> > > +	data.base = of_iomap(np, 2);
> > > +	if (!data.base)
> > > +		return -ENXIO;
> > > +
> > > +	ret = keembay_clocksource_init(np, &data);
> > > +	if (ret)
> > > +		goto exit;
> > > +
> > > +	ret = keembay_clockevent_init(np, &data);
> > 
> > Is this missing ?
> > 
> 
> Yes. Either case it goes to the exit path. So I thought of avoiding this error handling code.

The point is that in success you probably won't call keembay_timer_cleanup().

> > 	if (ret)
> > 		goto exit;
> > 
> > 	return 0;
> > 
> > > +exit:
> > > +	keembay_timer_cleanup(np, &data);
> > > +
> > > +	return ret;
> > > +}

-- 
With Best Regards,
Andy Shevchenko


