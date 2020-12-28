Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696782E6C35
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 00:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbgL1Wzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 17:55:47 -0500
Received: from mga05.intel.com ([192.55.52.43]:6195 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729347AbgL1TvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 14:51:01 -0500
IronPort-SDR: vfepf90S0G186YQ6UQ1AtSo/n8ibqDTrMJDrtZdGurujhuLdF4WfPDFhqroFgsLdhT+f/fu7bO
 G8FKrsUDuiAw==
X-IronPort-AV: E=McAfee;i="6000,8403,9848"; a="261168940"
X-IronPort-AV: E=Sophos;i="5.78,455,1599548400"; 
   d="scan'208";a="261168940"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2020 11:49:16 -0800
IronPort-SDR: S4W4aPprC/5Ty2XdAV4Hd8phzN6N/tbwdt5JS3hTikeDhPRRQctPfSy7jRiu3TPQwmbE/2vVl9
 EhMEPNHNDuLw==
X-IronPort-AV: E=Sophos;i="5.78,455,1599548400"; 
   d="scan'208";a="459864859"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2020 11:49:14 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ktyX2-000HCf-O7; Mon, 28 Dec 2020 21:50:16 +0200
Date:   Mon, 28 Dec 2020 21:50:16 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Carsten Haitzler <carsten.haitzler@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH] drm/komeda: use bitmap API to convert U32 to bitmap
Message-ID: <20201228195016.GD4077@smile.fi.intel.com>
References: <20201228194343.88880-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201228194343.88880-1-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 28, 2020 at 11:43:43AM -0800, Yury Norov wrote:
> The commit be3e477effba636ad25 ("drm/komeda: Fix bit
> check to import to value of proper type") fixes possible
> out-of-bound issue related to find_first_bit() usage, but
> does not address the endianness problem.

Hmm... Can you elaborate?

...

>  				    u32 comp_mask)

> -	unsigned long comp_mask_local = (unsigned long)comp_mask;

Here we convert u32 to unsigned long (LSB is kept LSB since it happens in
native endianess).

> -	id = find_first_bit(&comp_mask_local, 32);

Here it takes an address to unsigned long and tries only lower 32 bits.

Are you telling that find_first_bit() has an issue?

-- 
With Best Regards,
Andy Shevchenko


