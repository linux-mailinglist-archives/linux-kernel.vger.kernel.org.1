Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828A62AB751
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbgKILkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:40:03 -0500
Received: from mga11.intel.com ([192.55.52.93]:49415 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727311AbgKILkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:40:03 -0500
IronPort-SDR: bgRX9y6qfVEE8mDoGITql9520iUh5mJT8XgtB2f8XrhDt15rAY17x/RF7DtVHNRx3Tkp3EVuFU
 XjzxKuFf486Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9799"; a="166276480"
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="166276480"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 03:40:02 -0800
IronPort-SDR: f0GZK/P7FVmWfHN7XXZxrKoFtbFbzhPXi0NlWKcPSAqDiCWUwQ9WIIIFZQW32V3gHvEULu0hwL
 JoR0CIj6g/TA==
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="327242336"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 03:40:00 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kc5Xi-005AOR-9j; Mon, 09 Nov 2020 13:41:02 +0200
Date:   Mon, 9 Nov 2020 13:41:02 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Cc:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mgross@linux.intel.com, lakshmi.bai.raja.subramanian@intel.com
Subject: Re: [PATCH v2 2/2] phy: intel: Add Keem Bay USB PHY support
Message-ID: <20201109114102.GY4077@smile.fi.intel.com>
References: <20201109031654.22443-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20201109031654.22443-3-wan.ahmad.zainie.wan.mohamad@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109031654.22443-3-wan.ahmad.zainie.wan.mohamad@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 11:16:54AM +0800, Wan Ahmad Zainie wrote:
> Add support for USB PHY on Intel Keem Bay SoC.

...

> +config PHY_INTEL_KEEMBAY_USB
> +	tristate "Intel Keem Bay USB PHY driver"
> +	depends on ARCH_KEEMBAY || (ARM64 && COMPILE_TEST)

> +	depends on OF && HAS_IOMEM

Do you really need dependency to OF (yes, I see that it will be not functional,
but still can be compile tested)?

> +	select GENERIC_PHY
> +	select REGMAP_MMIO
> +	help
> +	  Choose this option if you have an Intel Keem Bay SoC.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called phy-keembay-usb.ko.

...

> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/module.h>

> +#include <linux/of.h>

No evidence of anything being used in this code.
mod_devicetable.h is missed, though.

> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>

...

> +	usleep_range(30, 50);

Why 30-50?

...

> +	usleep_range(20, 50);

Why these numbers?

...

> +	usleep_range(2, 10);

Ditto.

...

> +	usleep_range(20, 50);

Ditto.


...

> +	struct device_node *np = dev->of_node;

It's being used only once and it doesn't bring any benefit.

-- 
With Best Regards,
Andy Shevchenko


