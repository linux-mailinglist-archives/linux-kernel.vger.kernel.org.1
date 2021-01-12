Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A963B2F2CB3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 11:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406120AbhALKYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 05:24:23 -0500
Received: from mga02.intel.com ([134.134.136.20]:22804 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730230AbhALKYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 05:24:23 -0500
IronPort-SDR: d7Ly89wBkFDEm7DyHg1v3mP7abA9Lkm4TiTqZlqDW0irwUcSWnnrBa2Dn4CMQeoW+H4OWVZN8V
 GE5DgoFBgVjQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="165100680"
X-IronPort-AV: E=Sophos;i="5.79,341,1602572400"; 
   d="scan'208";a="165100680"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 02:23:42 -0800
IronPort-SDR: cjILx6JghTB+Ny13NlPb2xrtXziGCVW1HRvKDRvCM6boccj4Osv75C9pPZqozQM5C66rXoTHiX
 gmsuciABpiew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,341,1602572400"; 
   d="scan'208";a="345168618"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.149]) ([10.237.72.149])
  by fmsmga007.fm.intel.com with ESMTP; 12 Jan 2021 02:23:40 -0800
Subject: Re: [PATCH] mmc: sdhci-brcmstb: Fix mmc timeout errors on S5 suspend
To:     Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <20210107221509.6597-1-alcooperx@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <fcb0cb27-a32a-fb13-68e4-fb4e6432723b@intel.com>
Date:   Tue, 12 Jan 2021 12:23:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20210107221509.6597-1-alcooperx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/01/21 12:15 am, Al Cooper wrote:
> Commit e7b5d63a82fe ("mmc: sdhci-brcmstb: Add shutdown callback")
> that added a shutdown callback to the diver, is causing "mmc timeout"
> errors on S5 suspend. The problem was that the "remove" was queuing
> additional MMC commands after the "shutdown" and these caused
> timeouts as the MMC queues were cleaned up for "remove". The
> shutdown callback will be changed to calling sdhci-pltfm_suspend
> which should get better power savings because the clocks will be
> shutdown.
> 
> Fixes: e7b5d63a82fe ("mmc: sdhci-brcmstb: Add shutdown callback")
> Signed-off-by: Al Cooper <alcooperx@gmail.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-brcmstb.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
> index bbf3496f4495..f9780c65ebe9 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -314,11 +314,7 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>  
>  static void sdhci_brcmstb_shutdown(struct platform_device *pdev)
>  {
> -	int ret;
> -
> -	ret = sdhci_pltfm_unregister(pdev);
> -	if (ret)
> -		dev_err(&pdev->dev, "failed to shutdown\n");
> +	sdhci_pltfm_suspend(&pdev->dev);
>  }
>  
>  MODULE_DEVICE_TABLE(of, sdhci_brcm_of_match);
> 

