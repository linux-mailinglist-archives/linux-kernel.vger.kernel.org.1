Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 197FC2B3E55
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 09:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbgKPIKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 03:10:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:52318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728007AbgKPIKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 03:10:33 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 450662225B;
        Mon, 16 Nov 2020 08:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605514232;
        bh=gBo6kcsTmHnIVoOISckwU065LqWskgvsIWbnexyS8Jk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b9xG+7K0AUIui1Az1PYlnyHeC9JFSxKe8YGCyllvkSPJFBrI6Iu7V8XDRBq4TZPcR
         c9Tc5T5onOI4/SzxRBjSCIUtW9VIahlacRHoGmz0Y4eZbMwzWHsnHMjaF7OrtGoO1A
         Nryj43pPJndIjws2R+0vdso7c1UXDdKqpmYPJv14=
Date:   Mon, 16 Nov 2020 16:10:26 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ivan Zaentsev <ivan.zaentsev@wirenboard.ru>
Cc:     Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Evgeny Boger <boger@wirenboard.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: mxs: Add serial number support for i.MX23, i.MX28
 SoCs
Message-ID: <20201116081025.GF5849@dragon>
References: <20201111051859.2776-1-ivan.zaentsev@wirenboard.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111051859.2776-1-ivan.zaentsev@wirenboard.ru>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 08:18:59AM +0300, Ivan Zaentsev wrote:
> i.MX23 and i.MX28 SoCs unique identifiers are factory-programmed
> in On-Chip OTP memory. i.MX28's 64-bit unique id is in
> HW_OCOTP_OPS2:HW_OCOTP_OPS3 (see MCIMX28 Ref. Man., sec. 20.4.22-23).
> 
> i.MX23 provides 32-bit long unique id in HW_OCOTP_OPS3.
> Though not clearly documented, there is a clue in sec. 35.9.3.
> 
> The unique id is reported in /sys/devices/soc0/serial_number
> and in /proc/cpuinfo
> 
> Signed-off-by: Ivan Zaentsev <ivan.zaentsev@wirenboard.ru>
> Suggested-by: Evgeny Boger <boger@wirenboard.com>
> ---
>  arch/arm/mach-mxs/mach-mxs.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
> index c109f47e9cbc..af96368cc16a 100644
> --- a/arch/arm/mach-mxs/mach-mxs.c
> +++ b/arch/arm/mach-mxs/mach-mxs.c
> @@ -23,6 +23,7 @@
>  #include <asm/mach/map.h>
>  #include <asm/mach/time.h>
>  #include <asm/system_misc.h>
> +#include <asm/system_info.h>

Can we move it above <asm/system_misc.h> to get them alphabetically
sorted?

>  
>  #include "pm.h"
>  
> @@ -51,6 +52,9 @@
>  #define MXS_CLR_ADDR		0x8
>  #define MXS_TOG_ADDR		0xc
>  
> +#define HW_OCOTP_OPS2       19	/* offset 0x150 */
> +#define HW_OCOTP_OPS3       20	/* offset 0x160 */

Use tabs instead of spaces for indent.

> +
>  static u32 chipid;
>  static u32 socid;
>  
> @@ -379,6 +383,8 @@ static void __init mxs_machine_init(void)
>  	struct device *parent;
>  	struct soc_device *soc_dev;
>  	struct soc_device_attribute *soc_dev_attr;
> +	u64 soc_uid = 0;
> +	const u32 *ocotp = mxs_get_ocotp();
>  	int ret;
>  
>  	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
> @@ -394,8 +400,22 @@ static void __init mxs_machine_init(void)
>  	soc_dev_attr->soc_id = mxs_get_soc_id();
>  	soc_dev_attr->revision = mxs_get_revision();
>  
> +	if (socid == HW_DIGCTL_CHIPID_MX23) {
> +		soc_uid = system_serial_low = ocotp[HW_OCOTP_OPS3];
> +	} else if (socid == HW_DIGCTL_CHIPID_MX28) {
> +		soc_uid = system_serial_high = ocotp[HW_OCOTP_OPS2];
> +		soc_uid <<= 32;
> +		system_serial_low = ocotp[HW_OCOTP_OPS3];
> +		soc_uid |= system_serial_low;
> +	}
> +
> +	if (soc_uid)
> +		soc_dev_attr->serial_number = kasprintf(GFP_KERNEL, "%016llX", soc_uid);
> +
>  	soc_dev = soc_device_register(soc_dev_attr);
> +

Unnecessary newline.

Shawn

>  	if (IS_ERR(soc_dev)) {
> +		kfree(soc_dev_attr->serial_number);
>  		kfree(soc_dev_attr->revision);
>  		kfree(soc_dev_attr);
>  		return;
> -- 
> 2.25.1
> 
