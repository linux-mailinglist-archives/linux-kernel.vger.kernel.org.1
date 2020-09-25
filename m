Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F9327800D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 07:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgIYF4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 01:56:30 -0400
Received: from mga09.intel.com ([134.134.136.24]:41493 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbgIYF4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 01:56:30 -0400
IronPort-SDR: sVPH6mAot7GIq0Bd4Z2wMCrYja4tpUSefJXQZoBEm44GF1Ijlx+xizGBtGuk+vKTJqTZ52GYOZ
 r4wHrFaTWjUw==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="162346411"
X-IronPort-AV: E=Sophos;i="5.77,300,1596524400"; 
   d="scan'208";a="162346411"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 22:56:29 -0700
IronPort-SDR: CucfpYDGRDGLHDVYU+H5Nlz2kcPRy0f7CTiAsGWKeAPlPYzzjNKxnDVnHAc25kMTb0+Fn6oy5W
 ztmh5xT7nDNg==
X-IronPort-AV: E=Sophos;i="5.77,300,1596524400"; 
   d="scan'208";a="487322318"
Received: from erybin-mobl.ccr.corp.intel.com (HELO localhost) ([10.249.47.248])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 22:56:28 -0700
Date:   Fri, 25 Sep 2020 08:56:26 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] tpm: of: avoid __va() translation for event log address
Message-ID: <20200925055626.GC165011@linux.intel.com>
References: <20200922094128.26245-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922094128.26245-1-ardb@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 11:41:28AM +0200, Ard Biesheuvel wrote:
> The TPM event log is provided to the OS by the firmware, by loading
> it into an area in memory and passing the physical address via a node
> in the device tree.
> 
> Currently, we use __va() to access the memory via the kernel's linear
> map: however, it is not guaranteed that the linear map covers this
> particular address, as we may be running under HIGHMEM on a 32-bit
> architecture, or running firmware that uses a memory type for the
> event log that is omitted from the linear map (such as EfiReserved).

Makes perfect sense to the level that I wonder if this should have a
fixes tag and/or needs to be backported to the stable kernels?

> So instead, use memremap(), which will reuse the linear mapping if
> it is valid, or create another mapping otherwise.
> 
> Cc: Peter Huewe <peterhuewe@gmx.de>
> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/char/tpm/eventlog/of.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/eventlog/of.c b/drivers/char/tpm/eventlog/of.c
> index a9ce66d09a75..9178547589a3 100644
> --- a/drivers/char/tpm/eventlog/of.c
> +++ b/drivers/char/tpm/eventlog/of.c
> @@ -11,6 +11,7 @@
>   */
>  
>  #include <linux/slab.h>
> +#include <linux/io.h>
>  #include <linux/of.h>
>  #include <linux/tpm_eventlog.h>
>  
> @@ -25,6 +26,7 @@ int tpm_read_log_of(struct tpm_chip *chip)
>  	struct tpm_bios_log *log;
>  	u32 size;
>  	u64 base;
> +	void *p;

I'd just use 'ptr' for readability sake.

>  	log = &chip->log;
>  	if (chip->dev.parent && chip->dev.parent->of_node)
> @@ -65,7 +67,11 @@ int tpm_read_log_of(struct tpm_chip *chip)
>  		return -EIO;
>  	}
>  
> -	log->bios_event_log = kmemdup(__va(base), size, GFP_KERNEL);
> +	p = memremap(base, size, MEMREMAP_WB);
> +	if (!p)
> +		return -ENOMEM;
> +	log->bios_event_log = kmemdup(p, size, GFP_KERNEL);
> +	memunmap(p);
>  	if (!log->bios_event_log)
>  		return -ENOMEM;
>  
> -- 
> 2.17.1
> 

This is a really great catch!

I'm a bit late of my PR a bit because of SGX upstreaming madness
(sending v39 soon). If you can answer to my question above, I can do
that nitpick change to patch and get it to my v5.10 PR.

PS. Just so that you know, once I've applied it, it will be available
here:

git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git

I'll include MAINTAINERS update to that PR.

/Jarkko
