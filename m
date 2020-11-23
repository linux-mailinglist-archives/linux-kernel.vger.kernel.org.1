Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED9A32C0C08
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 14:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbgKWNlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 08:41:00 -0500
Received: from mga18.intel.com ([134.134.136.126]:48007 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729539AbgKWNk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 08:40:59 -0500
IronPort-SDR: DT+ZL7RcnXR3oBJoQ5fT248iemfp6kboAYj/1jOGvSDJRSgiOpc9jbmjY0SWBEoMDBqwEYGpTX
 h8gQJ0O99NXg==
X-IronPort-AV: E=McAfee;i="6000,8403,9813"; a="159530268"
X-IronPort-AV: E=Sophos;i="5.78,363,1599548400"; 
   d="scan'208";a="159530268"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 05:40:50 -0800
IronPort-SDR: 3TVv61qLh3jys0yf/ai6P3eILCIAnAKEr5FdTsJXPN1MoL9wBBUcHF6byFEyoZoQSIEWNHz2Ug
 ZYoYP1HWt2Lg==
X-IronPort-AV: E=Sophos;i="5.78,363,1599548400"; 
   d="scan'208";a="370040760"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 05:40:46 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1khC6F-009ARV-V6; Mon, 23 Nov 2020 15:41:47 +0200
Date:   Mon, 23 Nov 2020 15:41:47 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH 01/38] ASoC: ak5558: drop of_match_ptr from of_device_id
 table
Message-ID: <20201123134147.GE4077@smile.fi.intel.com>
References: <20201120161653.445521-1-krzk@kernel.org>
 <20201120165202.GG6751@sirena.org.uk>
 <20201120194245.GA2925@kozik-lap>
 <20201120200429.GJ6751@sirena.org.uk>
 <20201122105813.GA3780@kozik-lap>
 <20201123104832.GY4077@smile.fi.intel.com>
 <20201123123731.GA6322@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123123731.GA6322@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 12:37:31PM +0000, Mark Brown wrote:
> On Mon, Nov 23, 2020 at 12:48:32PM +0200, Andy Shevchenko wrote:
> > On Sun, Nov 22, 2020 at 11:59:20AM +0100, Krzysztof Kozlowski wrote:
> > > On Fri, Nov 20, 2020 at 08:04:29PM +0000, Mark Brown wrote:
> 
> > > > Surely if that's the desired outcome the fix is to change the definition
> > > > of of_match_ptr() such that it leaves the reference with CONFIG_ACPI,
> > > > perhaps hidden behind a config option for PRP0001?  That seems better
> > > > than going through the entire tree like this.
> 
> > > That could be indeed an easier way to achieve this.
> 
> > ...easier and wrong in my opinion. Not all drivers need that.
> > What the point to touch it in the driver which is OF-only?
> > (For IP which will quite unlikely to be present in ACPI world)
> > Or if the device will get the correct ACPI ID?
> 
> That feels like something that should be done with Kconfig dependencies
> like a direct OF dependency (possibly a !PRP0001 dependency?) for the
> driver or possibly with having a variant of_match_ptr() for things that
> really don't want to support PRP0001.  Just removing all the use of
> of_match_ptr() is both noisy and confusing in that it looks like it's
> creating issues to fix, it makes it hard to understand when and why one
> should use the macro.

My personal opinion is that in 99% using that macro (as well as ACPI_PTR() one)
is kinda mistake. We save dozen of bytes here and there by adding macro,
necessary ifdeferry, and dropping user to know that the driver might serve for
other device IDs as provided by OF / ACPI.

But I'm not the one who makes a decision here and I could see some want to have
a possibility to reduce their kernel memory footprint as much as possible.

-- 
With Best Regards,
Andy Shevchenko


