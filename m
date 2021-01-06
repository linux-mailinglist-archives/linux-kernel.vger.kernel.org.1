Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3BBC2EBB0E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 09:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbhAFIYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 03:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbhAFIYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 03:24:15 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DDEC061357
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 00:23:35 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 190so1728379wmz.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 00:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jsXysLmmAKahz+diK17btY2BSAasKtoOA55hEYYs9tc=;
        b=GWNTh0pgUJ20aXg9bMvPpluN5bjr91sNWBryA09/JN12exKFaWmrzej6lEteI3Qb7F
         c+sKhWHW8Lt+2UgJKnJY0cQrpwafn086ChohKXyhXS65wPrJ6W4mhR5aUGkPX0YwZgnJ
         BFJ7zyQAj8wYnbpju/WOJ6v2yn+QhU4tRK4dHcB3iVtDRueN2VwpmEBiswWhujnq9YOm
         yEUaAmPWdSM7w3CZu00ek2ronqVjd5je7O4FQl7qN9o4FVN7eBGicXWKW9qqhNypS4pU
         96tT924wkPynmmvqvPo4wpaqHcyt3QbMPNPDR2P5qN9fp44yO9wQx9ZJ/zye1iseuYlW
         gEyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jsXysLmmAKahz+diK17btY2BSAasKtoOA55hEYYs9tc=;
        b=KpAJfUB11Bqf2nRM/dW6AEtXyO6KwP94Wp1HdjTrS0kjYIKLor/d4dILbcd9XT1gzr
         vP4ITTT1PSlKEMCWBbaqETw6M5rxWeAZpphUTnGIDPLd6YCEPvbo29KU3JU0W98TVVi4
         ZZRGG0sdCpHOt71KofNb1U/D1J0PjLSQdc10EPNgP2pFN+f9XWh0kaUWPlxxIunVOyo4
         nyr3qWSfWbSdzrDy4xRXpAkl1AZQ2UJBfuWcBCdnaO+rxTqP4RUVBILUoAM51/r15D7Y
         CjT3TvGs/dmD5VdLw7bfsy0YjqXTTuFlWFDChBpy4zfn+x0x5GKwWIhyV5IHff6Z8c6g
         JzCg==
X-Gm-Message-State: AOAM531DJ32VBTZ5M79/iMcA+lFFIrA0u//3kWRAY+ivydwHjIrfu/Gc
        ajc5D+91NbEOe3Hv1gySTWUvAApv9NWKmptK
X-Google-Smtp-Source: ABdhPJySlVrxaBmP+L2prWCwUTrKLXz3v3kXxF6ixcubx4lJUIOPoFPASoD4Q9bJwReh8GFYpjBWMw==
X-Received: by 2002:a1c:a912:: with SMTP id s18mr2589475wme.26.1609921413906;
        Wed, 06 Jan 2021 00:23:33 -0800 (PST)
Received: from dell ([91.110.221.182])
        by smtp.gmail.com with ESMTPSA id c20sm2077265wmb.38.2021.01.06.00.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 00:23:33 -0800 (PST)
Date:   Wed, 6 Jan 2021 08:23:30 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        russell.h.weight@intel.com
Subject: Re: [PATCH 1/2] mfd: intel-m10-bmc: specify the retimer sub devices
Message-ID: <20210106082330.GB1592923@dell>
References: <1609918567-13339-1-git-send-email-yilun.xu@intel.com>
 <1609918567-13339-2-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1609918567-13339-2-git-send-email-yilun.xu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Jan 2021, Xu Yilun wrote:

> The patch specifies the 2 retimer sub devices and their resources in the
> parent driver's mfd_cell. It also adds the register definition of the
> retimer sub devices.
> 
> There are 2 ethernet retimer chips (C827) connected to the Intel MAX 10
> BMC. They are managed by the BMC firmware, and host could query them via
> retimer interfaces (shared registers) on the BMC. The 2 retimers have
> identical register interfaces in different register addresses or fields,
> so it is better we define 2 retimer devices and handle them with the same
> driver.
> 
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> ---
>  drivers/mfd/intel-m10-bmc.c       | 19 ++++++++++++++++++-
>  include/linux/mfd/intel-m10-bmc.h |  7 +++++++
>  2 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
> index b84579b..e0a99a0 100644
> --- a/drivers/mfd/intel-m10-bmc.c
> +++ b/drivers/mfd/intel-m10-bmc.c
> @@ -17,9 +17,26 @@ enum m10bmc_type {
>  	M10_N3000,
>  };
>  
> +static struct resource retimer0_resources[] = {
> +	{M10BMC_PKVL_A_VER, M10BMC_PKVL_A_VER, "version", IORESOURCE_REG, },
> +};
> +
> +static struct resource retimer1_resources[] = {
> +	{M10BMC_PKVL_B_VER, M10BMC_PKVL_B_VER, "version", IORESOURCE_REG, },
> +};

Please use the DEFINE_RES_*() helpers for this.

>  static struct mfd_cell m10bmc_pacn3000_subdevs[] = {
>  	{ .name = "n3000bmc-hwmon" },
> -	{ .name = "n3000bmc-retimer" },
> +	{
> +		.name = "n3000bmc-retimer",
> +		.num_resources = ARRAY_SIZE(retimer0_resources),
> +		.resources = retimer0_resources,
> +	},
> +	{
> +		.name = "n3000bmc-retimer",
> +		.num_resources = ARRAY_SIZE(retimer1_resources),
> +		.resources = retimer1_resources,
> +	},
>  	{ .name = "n3000bmc-secure" },
>  };
>  
> diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
> index c8ef2f1..d6216f9 100644
> --- a/include/linux/mfd/intel-m10-bmc.h
> +++ b/include/linux/mfd/intel-m10-bmc.h
> @@ -21,6 +21,13 @@
>  #define M10BMC_VER_PCB_INFO_MSK		GENMASK(31, 24)
>  #define M10BMC_VER_LEGACY_INVALID	0xffffffff
>  
> +/* Retimer related registers, in system register region */
> +#define M10BMC_PKVL_LSTATUS		0x164
> +#define M10BMC_PKVL_A_VER		0x254
> +#define M10BMC_PKVL_B_VER		0x258
> +#define M10BMC_PKVL_SERDES_VER		GENMASK(15, 0)
> +#define M10BMC_PKVL_SBUS_VER		GENMASK(31, 16)
> +
>  /**
>   * struct intel_m10bmc - Intel MAX 10 BMC parent driver data structure
>   * @dev: this device

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
