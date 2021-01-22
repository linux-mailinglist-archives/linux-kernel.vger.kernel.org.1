Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A782FF939
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 01:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbhAVAGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 19:06:47 -0500
Received: from mga09.intel.com ([134.134.136.24]:51616 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbhAVAGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 19:06:16 -0500
IronPort-SDR: +og1ANQrdqEFSFbM58DblpJ0SF1TnMjan5P2MoGUPb4nHrGfSo1+b+Kuy0tf1YwAChg5GKQb0o
 EC401uKJ7tbQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="179515896"
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="179515896"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 16:04:22 -0800
IronPort-SDR: c1MKkzPbXEBhA/O+iW4qLxNCUCNeECnHbcXaZ0uNcOEE8JKinLn3XRejeSGn/uvKdMho+FRBAn
 8XuYUk1GGevg==
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="570906848"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 16:04:22 -0800
Received: from localhost (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id 1256D6365;
        Thu, 21 Jan 2021 16:04:22 -0800 (PST)
Date:   Thu, 21 Jan 2021 16:04:22 -0800
From:   mark gross <mgross@linux.intel.com>
To:     Pan Bian <bianpan2016@163.com>
Cc:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: amd-pmc: put device on error paths
Message-ID: <20210122000422.GC60912@linux.intel.com>
Reply-To: mgross@linux.intel.com
References: <20210121045005.73342-1-bianpan2016@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121045005.73342-1-bianpan2016@163.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 08:50:05PM -0800, Pan Bian wrote:
> Put the PCI device rdev on error paths to fix potential reference count
> leaks.

Can you make a stronger statment than "fix potenital reference count leaks?".
Also, make the commit comment match the code better.

maybe something like:
"On the prob error return paths associated with rdev we are leaking ref counts, add
pci_dev_put to return patch to avoid the leaks".

Note: I'm not sure there is a leak but, assuming the code is correct the commit
comment should be more clear and match the code.

Do you have a test case that show this change is good?

--mark


> 
> Signed-off-by: Pan Bian <bianpan2016@163.com>
> ---
>  drivers/platform/x86/amd-pmc.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/amd-pmc.c b/drivers/platform/x86/amd-pmc.c
> index 0102bf1c7916..df140019c4bd 100644
> --- a/drivers/platform/x86/amd-pmc.c
> +++ b/drivers/platform/x86/amd-pmc.c
> @@ -210,31 +210,39 @@ static int amd_pmc_probe(struct platform_device *pdev)
>  	dev->dev = &pdev->dev;
>  
>  	rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
> -	if (!rdev || !pci_match_id(pmc_pci_ids, rdev))
> +	if (!rdev || !pci_match_id(pmc_pci_ids, rdev)) {
> +		pci_dev_put(rdev);
>  		return -ENODEV;
> +	}
>  
>  	dev->cpu_id = rdev->device;
>  	err = pci_write_config_dword(rdev, AMD_PMC_SMU_INDEX_ADDRESS, AMD_PMC_BASE_ADDR_LO);
>  	if (err) {
>  		dev_err(dev->dev, "error writing to 0x%x\n", AMD_PMC_SMU_INDEX_ADDRESS);
> +		pci_dev_put(rdev);
>  		return pcibios_err_to_errno(err);
>  	}
>  
>  	err = pci_read_config_dword(rdev, AMD_PMC_SMU_INDEX_DATA, &val);
> -	if (err)
> +	if (err) {
> +		pci_dev_put(rdev);
>  		return pcibios_err_to_errno(err);
> +	}
>  
>  	base_addr_lo = val & AMD_PMC_BASE_ADDR_HI_MASK;
>  
>  	err = pci_write_config_dword(rdev, AMD_PMC_SMU_INDEX_ADDRESS, AMD_PMC_BASE_ADDR_HI);
>  	if (err) {
>  		dev_err(dev->dev, "error writing to 0x%x\n", AMD_PMC_SMU_INDEX_ADDRESS);
> +		pci_dev_put(rdev);
>  		return pcibios_err_to_errno(err);
>  	}
>  
>  	err = pci_read_config_dword(rdev, AMD_PMC_SMU_INDEX_DATA, &val);
> -	if (err)
> +	if (err) {
> +		pci_dev_put(rdev);
>  		return pcibios_err_to_errno(err);
> +	}
>  
>  	base_addr_hi = val & AMD_PMC_BASE_ADDR_LO_MASK;
>  	pci_dev_put(rdev);
> -- 
> 2.17.1
> 
> 
