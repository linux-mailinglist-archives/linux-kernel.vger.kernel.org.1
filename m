Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6869F2C0C1D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 14:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732947AbgKWNoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 08:44:44 -0500
Received: from mga17.intel.com ([192.55.52.151]:34637 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730068AbgKWNoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 08:44:44 -0500
IronPort-SDR: inOmU/AvIQIaX/XWWABsvLuggE5Cy3AjKxBSmJPUKRca+3FU7uVQGm5a6kjjsqrMbOM1gwj57H
 uM9KFBMwiqwg==
X-IronPort-AV: E=McAfee;i="6000,8403,9813"; a="151606210"
X-IronPort-AV: E=Sophos;i="5.78,363,1599548400"; 
   d="scan'208";a="151606210"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 05:44:42 -0800
IronPort-SDR: 0YOEdlhbHllFXV0VXqJrmN57k5zXYl59TpMwgXZEw5gicLXxp0J3EJMiONcmLPyKhBoXftBuvt
 O4ukTwBlAwQw==
X-IronPort-AV: E=Sophos;i="5.78,363,1599548400"; 
   d="scan'208";a="327201580"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 05:44:40 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1khCA1-009AUS-TS; Mon, 23 Nov 2020 15:45:41 +0200
Date:   Mon, 23 Nov 2020 15:45:41 +0200
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
Message-ID: <20201123134541.GG4077@smile.fi.intel.com>
References: <20201120161653.445521-1-krzk@kernel.org>
 <20201120165202.GG6751@sirena.org.uk>
 <20201120194245.GA2925@kozik-lap>
 <20201120200429.GJ6751@sirena.org.uk>
 <20201122105813.GA3780@kozik-lap>
 <20201123104832.GY4077@smile.fi.intel.com>
 <20201123123731.GA6322@sirena.org.uk>
 <20201123124129.GA170000@kozik-lap>
 <20201123134225.GF4077@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201123134225.GF4077@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 03:42:25PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 23, 2020 at 01:41:29PM +0100, Krzysztof Kozlowski wrote:
> > On Mon, Nov 23, 2020 at 12:37:31PM +0000, Mark Brown wrote:
> > > On Mon, Nov 23, 2020 at 12:48:32PM +0200, Andy Shevchenko wrote:
> > > > On Sun, Nov 22, 2020 at 11:59:20AM +0100, Krzysztof Kozlowski wrote:
> > > > > On Fri, Nov 20, 2020 at 08:04:29PM +0000, Mark Brown wrote:
> > > 
> > > > > > Surely if that's the desired outcome the fix is to change the definition
> > > > > > of of_match_ptr() such that it leaves the reference with CONFIG_ACPI,
> > > > > > perhaps hidden behind a config option for PRP0001?  That seems better
> > > > > > than going through the entire tree like this.
> > > 
> > > > > That could be indeed an easier way to achieve this.
> > > 
> > > > ...easier and wrong in my opinion. Not all drivers need that.
> > > > What the point to touch it in the driver which is OF-only?
> > > > (For IP which will quite unlikely to be present in ACPI world)
> > > > Or if the device will get the correct ACPI ID?
> > > 
> > > That feels like something that should be done with Kconfig dependencies
> > > like a direct OF dependency (possibly a !PRP0001 dependency?) for the
> > > driver or possibly with having a variant of_match_ptr() for things that
> > > really don't want to support PRP0001.  Just removing all the use of
> > > of_match_ptr() is both noisy and confusing in that it looks like it's
> > > creating issues to fix, it makes it hard to understand when and why one
> > > should use the macro.
> > 
> > For the OF-only drivers (without other ID table), there is no point to
> > use the macro. Driver can bind only with DT, so what is the point of
> > of_match_ptr? To skip the OF table when building without OF? Driver
> > won't be usable at all in such case. So maybe for compile testing?
> > There is no need to remove OF table for simple build tests.
> 
> I'm on the same page here.

I should have elaborated that under OF only I meant rather !ACPI. So, when it
has no ID tables, I agree that macro is not needed. But, for instance, I²C
device drivers tend to have table even for ->probe_new() callback to be able to
instantiate them via user space.

-- 
With Best Regards,
Andy Shevchenko


