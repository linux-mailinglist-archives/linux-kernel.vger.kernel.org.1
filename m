Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C242B078C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 15:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgKLO2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 09:28:15 -0500
Received: from mga01.intel.com ([192.55.52.88]:33637 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbgKLO2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 09:28:13 -0500
IronPort-SDR: gt/mb+yLc3LwsolG0Wz+p732i3t0FO8vRO2pQkDQ+0N35HiHr7TFrDdnrCcrIsps1Tukhv5R4P
 EQOkzA+cgBJQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9802"; a="188310752"
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="188310752"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 06:28:06 -0800
IronPort-SDR: t/D92XzdhmxAj1Sfdzh4kAqjT5oZkqgkP1u3e9ZQk3ubqXHJ7zWZq8eUeWHUZWEPmreSjUR5wp
 dF+uoG7AEDCg==
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="532184068"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 06:28:04 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kdDb0-006DsY-03; Thu, 12 Nov 2020 16:29:06 +0200
Date:   Thu, 12 Nov 2020 16:29:05 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Cc:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mgross@linux.intel.com, lakshmi.bai.raja.subramanian@intel.com
Subject: Re: [PATCH v3 2/2] phy: intel: Add Keem Bay USB PHY support
Message-ID: <20201112142905.GH4077@smile.fi.intel.com>
References: <20201112095821.27110-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20201112095821.27110-3-wan.ahmad.zainie.wan.mohamad@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112095821.27110-3-wan.ahmad.zainie.wan.mohamad@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 05:58:21PM +0800, Wan Ahmad Zainie wrote:
> Add support for USB PHY on Intel Keem Bay SoC.

Any elaboration here? What is this PHY (USB2 or USB3 or?.. etc)?

...

> +config PHY_INTEL_KEEMBAY_USB
> +	tristate "Intel Keem Bay USB PHY driver"

> +	depends on ARCH_KEEMBAY || (ARM64 && COMPILE_TEST)

It seems other drivers that are not using ARM specific calls moved to

	depends on ARCH_KEEMBAY || COMPILE_TEST

> +	depends on HAS_IOMEM
> +	select GENERIC_PHY
> +	select REGMAP_MMIO

...

> +#define USS_CPR_MASK		0x7f

GENMASK() ?

...

> +static const struct regmap_config keembay_regmap_config = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,

.max_register?

> +};

-- 
With Best Regards,
Andy Shevchenko


