Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30A02D12A1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 14:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgLGNzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 08:55:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32230 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726188AbgLGNzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 08:55:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607349222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z0LkzQwUfy3VSXbaI0zGos8FMVr/WHmEntut1gHn3+k=;
        b=FwEn1tS0f1hfI8htmFG8+qiX4WmOzQjioopkl7lwE7Sv3VjSp5M2o5MChHtAM41qZoU/of
        Moutn6m015HVWXjtvWwA32PBwxI0n8FM7PMeNFFNNIwEu/LVp5wS792LRb5yVPOKAz2xx+
        zn0te5beBW9XBJECmbGaNAdSaVPAV4w=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-ZBCqAqXCPiKfWDJNPel8Aw-1; Mon, 07 Dec 2020 08:53:40 -0500
X-MC-Unique: ZBCqAqXCPiKfWDJNPel8Aw-1
Received: by mail-ej1-f69.google.com with SMTP id a8so3857872ejc.19
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 05:53:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z0LkzQwUfy3VSXbaI0zGos8FMVr/WHmEntut1gHn3+k=;
        b=H/evyRjiIdHGO655Cpe7zadKX8Sv3wV+A3u1JmMNkKAjmhWikwWZ0xxjMsNyTubQ1R
         NwwzMVvJvfyXFObE1n85ZRcUeE8rH/cWk1T/Xn8n09sgVKoWYF5a7LAEVEORTATTVcIP
         H4qOZpbzXfiNYYXtHut5gXysYiGwSddGOadXw+rzMr3g4e0pfP2lM5ceOgum0+KNlnlI
         HwSrlCPUrSufmo5XHAQXS31UfIABu3K25xCKBT6WGrTCa9AddkWfP5TwTN1jAkdR0OPd
         Qg34PbJ65qPcNJiWreqggP7c8n20TptkYGmxZYqjF5FvUGkazFhsTxLL+xEogw4FQ7ss
         a2Kw==
X-Gm-Message-State: AOAM530rD9jLUrNykamErwKLvEQ6mL9G7PstWgl8MeQszL8vOz+lkqEk
        M/MifQOuktwin1au7i0H5RBUmQWLH1qLoOoie2uR5lsQ87fBXX5s2qTYXUkbgvMjEWWc6visF0I
        WdquJRQSqN7DPnAG94sjpoWDc
X-Received: by 2002:a17:906:3949:: with SMTP id g9mr1614658eje.493.1607349219540;
        Mon, 07 Dec 2020 05:53:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJznKUtld+R2eani16aYv7FkTYc+IAEjmmDGmWJ4/zXLR1uBNDrcK65++w70LLXnxfSN1v5fTw==
X-Received: by 2002:a17:906:3949:: with SMTP id g9mr1614646eje.493.1607349219349;
        Mon, 07 Dec 2020 05:53:39 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id p22sm12230242ejx.59.2020.12.07.05.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 05:53:38 -0800 (PST)
Subject: Re: [PATCH] platform/x86: mlx-platform: remove an unused variable
To:     Arnd Bergmann <arnd@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        Mark Gross <mgross@linux.intel.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Shych <michaelsh@mellanox.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
References: <20201203223105.1195709-1-arnd@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <64393b7e-ba81-1545-dfe8-bc3567dd534b@redhat.com>
Date:   Mon, 7 Dec 2020 14:53:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201203223105.1195709-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/3/20 11:30 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The only reference to the mlxplat_mlxcpld_psu[] array got removed,
> so there is now a warning from clang:
> 
> drivers/platform/x86/mlx-platform.c:322:30: error: variable 'mlxplat_mlxcpld_psu' is not needed and will not be emitted [-Werror,-Wunneeded-internal-declaration]
> static struct i2c_board_info mlxplat_mlxcpld_psu[] = {
> 
> Remove the array as well and adapt the ARRAY_SIZE() call
> accordingly.
> 
> Fixes: 912b341585e3 ("platform/x86: mlx-platform: Remove PSU EEPROM from MSN274x platform configuration")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thank you for your patch.

Note that there are 4 more cases where the foo1 and foo2 in:
.data = foo1 and .count = ARRAY_SIZE(foo2) are not the same.

There are 2 cases where .count is set to ARRAY_SIZE(mlxplat_mlxcpld_pwr)
instead of to ARRAY_SIZE(mlxplat_mlxcpld_default_pwr_items_data)

and there are 2 cases where .count is set to ARRAY_SIZE(mlxplat_mlxcpld_fan)
instead of to ARRAY_SIZE(mlxplat_mlxcpld_default_fan_items_data)

If one of the MLX people can provide a patch fixing this then that
would be great.

###

I've applied this patch to my review-hans  branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans





> ---
>  drivers/platform/x86/mlx-platform.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/platform/x86/mlx-platform.c b/drivers/platform/x86/mlx-platform.c
> index 598f44558764..6a634b72bfc2 100644
> --- a/drivers/platform/x86/mlx-platform.c
> +++ b/drivers/platform/x86/mlx-platform.c
> @@ -319,15 +319,6 @@ static struct i2c_mux_reg_platform_data mlxplat_extended_mux_data[] = {
>  };
>  
>  /* Platform hotplug devices */
> -static struct i2c_board_info mlxplat_mlxcpld_psu[] = {
> -	{
> -		I2C_BOARD_INFO("24c02", 0x51),
> -	},
> -	{
> -		I2C_BOARD_INFO("24c02", 0x50),
> -	},
> -};
> -
>  static struct i2c_board_info mlxplat_mlxcpld_pwr[] = {
>  	{
>  		I2C_BOARD_INFO("dps460", 0x59),
> @@ -456,7 +447,7 @@ static struct mlxreg_core_item mlxplat_mlxcpld_default_items[] = {
>  		.aggr_mask = MLXPLAT_CPLD_AGGR_PSU_MASK_DEF,
>  		.reg = MLXPLAT_CPLD_LPC_REG_PSU_OFFSET,
>  		.mask = MLXPLAT_CPLD_PSU_MASK,
> -		.count = ARRAY_SIZE(mlxplat_mlxcpld_psu),
> +		.count = ARRAY_SIZE(mlxplat_mlxcpld_default_psu_items_data),
>  		.inversed = 1,
>  		.health = false,
>  	},
> @@ -495,7 +486,7 @@ static struct mlxreg_core_item mlxplat_mlxcpld_comex_items[] = {
>  		.aggr_mask = MLXPLAT_CPLD_AGGR_MASK_CARRIER,
>  		.reg = MLXPLAT_CPLD_LPC_REG_PSU_OFFSET,
>  		.mask = MLXPLAT_CPLD_PSU_MASK,
> -		.count = ARRAY_SIZE(mlxplat_mlxcpld_psu),
> +		.count = ARRAY_SIZE(mlxplat_mlxcpld_default_psu_items_data),
>  		.inversed = 1,
>  		.health = false,
>  	},
> 

