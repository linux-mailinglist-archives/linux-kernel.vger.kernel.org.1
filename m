Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5152C03A3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 11:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbgKWKrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 05:47:33 -0500
Received: from mga11.intel.com ([192.55.52.93]:12772 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728523AbgKWKrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 05:47:32 -0500
IronPort-SDR: qiKvsgjyIHlJvlc+QUb5VV5XvgKb4M3Pam0DjaBrrJc/MTFb7BNQzQ6RBpzB4FYIKdGobXyS1q
 AB5X+x8jOxgw==
X-IronPort-AV: E=McAfee;i="6000,8403,9813"; a="168231271"
X-IronPort-AV: E=Sophos;i="5.78,363,1599548400"; 
   d="scan'208";a="168231271"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 02:47:32 -0800
IronPort-SDR: LfCAwxo4F4lVV9uPanZd01eRoxiOe650zTpb1q8P5GTEj11B2+EglGZ6JL4EGO8guQ+SPx0DxF
 xUo9YGhZy0ng==
X-IronPort-AV: E=Sophos;i="5.78,363,1599548400"; 
   d="scan'208";a="312842482"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 02:47:30 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kh9Oa-0097y3-2s; Mon, 23 Nov 2020 12:48:32 +0200
Date:   Mon, 23 Nov 2020 12:48:32 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH 01/38] ASoC: ak5558: drop of_match_ptr from of_device_id
 table
Message-ID: <20201123104832.GY4077@smile.fi.intel.com>
References: <20201120161653.445521-1-krzk@kernel.org>
 <20201120165202.GG6751@sirena.org.uk>
 <20201120194245.GA2925@kozik-lap>
 <20201120200429.GJ6751@sirena.org.uk>
 <20201122105813.GA3780@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201122105813.GA3780@kozik-lap>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 22, 2020 at 11:59:20AM +0100, Krzysztof Kozlowski wrote:
> On Fri, Nov 20, 2020 at 08:04:29PM +0000, Mark Brown wrote:
> > On Fri, Nov 20, 2020 at 08:42:45PM +0100, Krzysztof Kozlowski wrote:
> > > On Fri, Nov 20, 2020 at 04:56:34PM +0000, Mark Brown wrote:
> > 
> > > > It would be better to fix these by annotating the table as potentially
> > > > unused, if nothing else it means if someone wants to add ACPI support
> > > > (or it just works on their ACPI system with the plain old I2C ID) then
> > > > they don't need to revert this change.
> > 
> > > The point is after this patch - removal of of_match_ptr() - they will
> > > already support the ACPI matching through the PRP0001.
> > 
> > > Keeping of_match_ptr() and maybe_unused will prevent any ACPI re-usage
> > > unless explicit ACPI table is added
> > 
> > Surely if that's the desired outcome the fix is to change the definition
> > of of_match_ptr() such that it leaves the reference with CONFIG_ACPI,
> > perhaps hidden behind a config option for PRP0001?  That seems better
> > than going through the entire tree like this.
> 
> That could be indeed an easier way to achieve this.

...easier and wrong in my opinion. Not all drivers need that.
What the point to touch it in the driver which is OF-only?
(For IP which will quite unlikely to be present in ACPI world)
Or if the device will get the correct ACPI ID?

> +Cc Andy, Rafael,

I guess Rafael can correct me or others.

> I saw you were doing similar way as I did here [1] for the 698fffc2705c
> ("rtc: ds1307: Drop of_match_ptr and CONFIG_OF protections") with the
> same reasoning as mine ("These prevent use of this driver with ACPI via
> PRP0001.").

The above is a device which can be connected to any system, including
ACPI-based one. The patch has been cooked to have some means to make
it usable on such systems (because previous patch removes wrong ACPI IDs).

> Do you have thoughts on Mark's proposal above (to change the
> of_match_ptr())?
> 
> [1] https://lore.kernel.org/lkml/20201120161653.445521-1-krzk@kernel.org/

-- 
With Best Regards,
Andy Shevchenko


