Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3DF200888
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 14:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732922AbgFSMSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 08:18:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728712AbgFSMSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 08:18:24 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E84AF20776;
        Fri, 19 Jun 2020 12:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592569104;
        bh=aFk0yk8q9h/avs/fTrPLi5ZiBt9o03mS0UX/BHZZM4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0FNaTw+yL64IbmgXYQTg11sVaupKglunwKR2tig6/Z76zUTezGCNCAUT1XXxSyJws
         P0CkJTMFz3zMHzoQiNNf5H0PfHctQqs9s/Q8LwGz13ppmsJgeB94GGihVhVogL2imj
         wmCEN+AotiEHLuojrkqGPabb5wK3/0xJIpFfasFM=
Received: by pali.im (Postfix)
        id 8D38D820; Fri, 19 Jun 2020 14:18:21 +0200 (CEST)
Date:   Fri, 19 Jun 2020 14:18:21 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Jeffrey Lin <jeffrey@icurse.nl>
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (dell-smm) Add Latitude 5480 to fan control
 whitelist
Message-ID: <20200619121821.dz4slqvy4gigm6ns@pali>
References: <20200619015529.285241-1-jeffrey@icurse.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200619015529.285241-1-jeffrey@icurse.nl>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 June 2020 21:55:29 Jeffrey Lin wrote:
> This allows manual PWM control without the BIOS fighting back on Dell
> Latitude 5480.
> 
> Signed-off-by: Jeffrey Lin <jeffrey@icurse.nl>

If it is working fine on your machine, you can add my:

Acked-by: Pali Rohár <pali@kernel.org>

> ---
>  drivers/hwmon/dell-smm-hwmon.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> index 16be012a95ed..ec448f5f2dc3 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -1187,6 +1187,14 @@ static struct dmi_system_id i8k_whitelist_fan_control[] __initdata = {
>  		},
>  		.driver_data = (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
>  	},
> +	{
> +		.ident = "Dell Latitude 5480",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Latitude 5480"),
> +		},
> +		.driver_data = (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
> +	},
>  	{
>  		.ident = "Dell Latitude E6440",
>  		.matches = {
> -- 
> 2.27.0
> 
