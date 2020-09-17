Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4572726E7BD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 23:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgIQV6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 17:58:10 -0400
Received: from mga01.intel.com ([192.55.52.88]:12565 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbgIQV6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 17:58:10 -0400
IronPort-SDR: eZmnMcRLJHPUwH6NpXKPlyROlhGCNOhSYaNRqHZQ67zNfMzPMnA/4f6eVDqP8a8nC9wywu6uYt
 DmulWIr8356g==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="177899478"
X-IronPort-AV: E=Sophos;i="5.77,272,1596524400"; 
   d="scan'208";a="177899478"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 14:51:04 -0700
IronPort-SDR: uaVjyTv9QUwcyQXGGpSzY0pE64rTcroIgzRsGoBjzcxUvc0AcTwQM8esrtClai/wY+MrCpz4FM
 /EpabDmEKVbg==
X-IronPort-AV: E=Sophos;i="5.77,272,1596524400"; 
   d="scan'208";a="303099401"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 14:51:03 -0700
Received: from localhost (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id B74806369;
        Thu, 17 Sep 2020 14:51:03 -0700 (PDT)
Date:   Thu, 17 Sep 2020 14:51:03 -0700
From:   mark gross <mgross@linux.intel.com>
To:     Necip Fazil Yildiran <fazilyildiran@gmail.com>
Cc:     andy@infradead.org, matan@svgalib.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul@pgazz.com, jeho@cs.utexas.edu
Subject: Re: [PATCH] platform/x86: fix kconfig dependency warning for
 LG_LAPTOP
Message-ID: <20200917215103.GE29136@mtg-dev.jf.intel.com>
Reply-To: mgross@linux.intel.com
References: <20200915090922.16423-1-fazilyildiran@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915090922.16423-1-fazilyildiran@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: mark gross <mgross@linux.intel.com>

--mark

On Tue, Sep 15, 2020 at 12:09:23PM +0300, Necip Fazil Yildiran wrote:
> When LG_LAPTOP is enabled and NEW_LEDS is disabled, it results in the
> following Kbuild warning:
> 
> WARNING: unmet direct dependencies detected for LEDS_CLASS
>   Depends on [n]: NEW_LEDS [=n]
>   Selected by [y]:
>   - LG_LAPTOP [=y] && X86 [=y] && X86_PLATFORM_DEVICES [=y] && ACPI [=y] && ACPI_WMI [=y] && INPUT [=y]
> 
> The reason is that LG_LAPTOP selects LEDS_CLASS without depending on or
> selecting NEW_LEDS while LEDS_CLASS is subordinate to NEW_LEDS.
> 
> Honor the kconfig menu hierarchy to remove kconfig dependency warnings.
> 
> Fixes: dbf0c5a6b1f8 ("platform/x86: Add LG Gram laptop special features driver")
> Signed-off-by: Necip Fazil Yildiran <fazilyildiran@gmail.com>
> ---
>  drivers/platform/x86/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 40219bba6801..81f6079d08e6 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1112,6 +1112,7 @@ config LG_LAPTOP
>  	depends on ACPI_WMI
>  	depends on INPUT
>  	select INPUT_SPARSEKMAP
> +	select NEW_LEDS
>  	select LEDS_CLASS
>  	help
>  	 This driver adds support for hotkeys as well as control of keyboard
> -- 
> 2.25.1
> 
