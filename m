Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD9829E5E5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 09:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbgJ2IKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 04:10:46 -0400
Received: from mga11.intel.com ([192.55.52.93]:51038 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728356AbgJ2IIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 04:08:34 -0400
IronPort-SDR: qYZO8NAkHrLiE9dYxqBX0iYfmCGULKa8M17gGc/AYV28gqxlOw+Oli4IO7sgPza2ajqAZLz6lH
 UzGMJrulEaUw==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="164896972"
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; 
   d="scan'208";a="164896972"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 01:08:33 -0700
IronPort-SDR: dAeCCIfJdhGYZa++tV/qMn+Mhzqfm3IuejwD0V/iyyRsdyrxgeJVMCQny7evXKE7HmggvhfG0G
 bpqA3SOJ4OoA==
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; 
   d="scan'208";a="469045569"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 01:08:31 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 29 Oct 2020 10:08:27 +0200
Date:   Thu, 29 Oct 2020 10:08:27 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1] pinctrl: intel: Add Intel Alder Lake pin controller
 support
Message-ID: <20201029080827.GN2495@lahna.fi.intel.com>
References: <20201026192552.20903-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026192552.20903-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I think the $subject should say "Alder Lake-S" as this is for -S
variant.

On Mon, Oct 26, 2020 at 09:25:52PM +0200, Andy Shevchenko wrote:
> This driver adds pinctrl/GPIO support for Intel Alder Lake SoC. The
> GPIO controller is based on the next generation GPIO hardware but still
> compatible with the one supported by the Intel core pinctrl/GPIO driver.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pinctrl/intel/Kconfig             |   9 +
>  drivers/pinctrl/intel/Makefile            |   1 +
>  drivers/pinctrl/intel/pinctrl-alderlake.c | 437 ++++++++++++++++++++++
>  3 files changed, 447 insertions(+)
>  create mode 100644 drivers/pinctrl/intel/pinctrl-alderlake.c
> 
> diff --git a/drivers/pinctrl/intel/Kconfig b/drivers/pinctrl/intel/Kconfig
> index b9d78a4187e0..98494c8fdaf8 100644
> --- a/drivers/pinctrl/intel/Kconfig
> +++ b/drivers/pinctrl/intel/Kconfig
> @@ -70,6 +70,14 @@ config PINCTRL_INTEL
>  	select GPIOLIB
>  	select GPIOLIB_IRQCHIP
>  
> +config PINCTRL_ALDERLAKE
> +	tristate "Intel Alder Lake pinctrl and GPIO driver"
> +	depends on ACPI
> +	select PINCTRL_INTEL
> +	help
> +	  This pinctrl driver provides an interface that allows configuring
> +	  of Intel Alder Lake PCH pins and using them as GPIOs.
> +
>  config PINCTRL_BROXTON
>  	tristate "Intel Broxton pinctrl and GPIO driver"
>  	depends on ACPI
> @@ -158,4 +166,5 @@ config PINCTRL_TIGERLAKE
>  	help
>  	  This pinctrl driver provides an interface that allows configuring
>  	  of Intel Tiger Lake PCH pins and using them as GPIOs.
> +

Is this intentional ws change?

>  endif

Otherwise looks good to me.
