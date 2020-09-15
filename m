Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 796A926A3F8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 13:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgIOLPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 07:15:43 -0400
Received: from foss.arm.com ([217.140.110.172]:33082 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbgIOLLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 07:11:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD00D101E;
        Tue, 15 Sep 2020 04:10:35 -0700 (PDT)
Received: from [192.168.1.205] (unknown [10.37.8.121])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3847B3F718;
        Tue, 15 Sep 2020 04:10:31 -0700 (PDT)
Subject: Re: [PATCH v1] soc: fsl: rcpm: Add ACPI support
To:     kuldip dwivedi <kuldip.dwivedi@puresoftware.com>,
        Li Yang <leoyang.li@nxp.com>, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Ran Wang <ran.wang_1@nxp.com>, Biwen Li <biwen.li@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Arokia Samy <arokia.samy@nxp.com>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>,
        Paul Yang <Paul.Yang@arm.com>,
        tanveer <tanveer.alam@puresoftware.com>
References: <20200915110647.846-1-kuldip.dwivedi@puresoftware.com>
From:   Ard Biesheuvel <ard.biesheuvel@arm.com>
Message-ID: <4e008f0a-69da-d5c2-4dfc-ef8695e17f47@arm.com>
Date:   Tue, 15 Sep 2020 14:10:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200915110647.846-1-kuldip.dwivedi@puresoftware.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/20 1:06 PM, kuldip dwivedi wrote:
> Add ACPI support in fsl RCPM driver. This is required
> to support ACPI S3 state. S3 is the ACPI sleep state
> that is known as "sleep" or "suspend to RAM".
> It essentially turns off most power of the system but
> keeps memory powered.
> 
> Signed-off-by: tanveer <tanveer.alam@puresoftware.com>
> Signed-off-by: kuldip dwivedi <kuldip.dwivedi@puresoftware.com>

Why does the OS need to program this device? Can't this be done by firmware?

> ---
> 
> Notes:
>      1. Add ACPI match table
>      2. NXP team members are added for confirming HID changes
>      3. There is only one node in ACPI so no need to check for
>         current device explicitly
>      4. These changes are tested on LX2160A and LS1046A platforms
> 
>   drivers/soc/fsl/rcpm.c | 22 +++++++++++++++++++---
>   1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/fsl/rcpm.c b/drivers/soc/fsl/rcpm.c
> index a093dbe6d2cb..e75a436fb159 100644
> --- a/drivers/soc/fsl/rcpm.c
> +++ b/drivers/soc/fsl/rcpm.c
> @@ -2,10 +2,12 @@
>   //
>   // rcpm.c - Freescale QorIQ RCPM driver
>   //
> -// Copyright 2019 NXP
> +// Copyright 2019-2020 NXP
> +// Copyright 2020 Puresoftware Ltd.
>   //
>   // Author: Ran Wang <ran.wang_1@nxp.com>
>   
> +#include <linux/acpi.h>
>   #include <linux/init.h>
>   #include <linux/module.h>
>   #include <linux/platform_device.h>
> @@ -57,8 +59,13 @@ static int rcpm_pm_prepare(struct device *dev)
>   				rcpm->wakeup_cells + 1);
>   
>   		/*  Wakeup source should refer to current rcpm device */
> -		if (ret || (np->phandle != value[0]))
> -			continue;
> +		if (is_acpi_node(dev->fwnode)) {
> +			if (ret)
> +				continue;
> +		} else {
> +			if (ret || (np->phandle != value[0]))
> +				continue;
> +		}
>   
>   		/* Property "#fsl,rcpm-wakeup-cells" of rcpm node defines the
>   		 * number of IPPDEXPCR register cells, and "fsl,rcpm-wakeup"
> @@ -139,10 +146,19 @@ static const struct of_device_id rcpm_of_match[] = {
>   };
>   MODULE_DEVICE_TABLE(of, rcpm_of_match);
>   
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id rcpm_acpi_match[] = {
> +	{ "NXP0015", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, rcpm_acpi_match);
> +#endif
> +
>   static struct platform_driver rcpm_driver = {
>   	.driver = {
>   		.name = "rcpm",
>   		.of_match_table = rcpm_of_match,
> +		.acpi_match_table = ACPI_PTR(rcpm_acpi_match),
>   		.pm	= &rcpm_pm_ops,
>   	},
>   	.probe = rcpm_probe,
> 

