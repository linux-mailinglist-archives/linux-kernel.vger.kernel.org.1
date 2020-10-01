Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B8C27FA1E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 09:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731250AbgJAHWl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 1 Oct 2020 03:22:41 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40551 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgJAHWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 03:22:41 -0400
Received: by mail-ed1-f67.google.com with SMTP id t16so4528769edw.7;
        Thu, 01 Oct 2020 00:22:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=fwr1GeVaFEp1uM5sVnPT1yQbyvQmB6fV3m98V7FTLsE=;
        b=HlqT77hLOhdW7BqyeFS7+kf6Nm/XJ7DIwzXYMT/FP7ZXosS4WrUF3cjc5RImcQfeq6
         ukgQ41cklCvn7SsvrGLuLnIuZnk+/TEfDGNBgjA2UaLoLDZebRcxRc7jXIMFZB7a/EeV
         9gHsQc7hhI5dC8aYBAkJFpboOvV/pTwRYUzGYjtE8yTC5hQDx+0VWr5S44gJaOfaRQa9
         g2Xh1OJ5R8yRYXh0j5pkV+lYhm+jOqtPmJARIFc708a+oRNxaJVXUfr0naLo0Pn7sZUH
         kL7uJhRErWPffAKA3QUIEYjLArpa5hRI+UlhjquBCdZ0McfTsGNqkZlZb3S6Btu5GhnL
         8waA==
X-Gm-Message-State: AOAM5321M2qcwc+NuWAo0VCWX5deNi0uzt81Oa/kvWuQ/dX0lmTKk/px
        65aYfOZP4Co5yrMifwhaL7cTm+wdRKo=
X-Google-Smtp-Source: ABdhPJyursdQ3jc4/q0hvBhAH8cOPenfHB/GW7XJSvMFDQANFlI7O7t0Exapy9HiBOqu25ycbqhjvw==
X-Received: by 2002:aa7:ce15:: with SMTP id d21mr6744623edv.284.1601536959051;
        Thu, 01 Oct 2020 00:22:39 -0700 (PDT)
Received: from kozik-lap ([194.230.155.194])
        by smtp.googlemail.com with ESMTPSA id v25sm3367079edr.29.2020.10.01.00.22.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Oct 2020 00:22:38 -0700 (PDT)
Date:   Thu, 1 Oct 2020 09:22:36 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com
Subject: Re: [PATCH] ARM: dts: exynos: Add a placeholder for a MAC address
Message-ID: <20201001072236.GA4815@kozik-lap>
References: <CGME20200930143154eucas1p22c1560c485f5d8b8be729c76028c89c7@eucas1p2.samsung.com>
 <20200930143151.23961-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200930143151.23961-1-l.stelmach@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 04:31:51PM +0200, Łukasz Stelmach wrote:
> Add a placeholder for a MAC address. A bootloader may fill it
> to set the MAC address and override EEPROM settings.
> 
> Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5422-odroidxu3.dts | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3.dts b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
> index db0bc17a667b..9f7f3eacb750 100644
> --- a/arch/arm/boot/dts/exynos5422-odroidxu3.dts
> +++ b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
> @@ -70,3 +70,21 @@ &pwm {
>  &usbdrd_dwc3_1 {
>  	dr_mode = "peripheral";
>  };
> +
> +&usbhost2 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	hub@1 {
> +		compatible = "usb8087,0024";
> +		reg = <1>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ethernet: usbether@1 {
> +			compatible = "usb0c45,6310";
> +			reg = <1>;
> +			mac-address = [00 00 00 00 00 00]; /* Filled in by a bootloader */

Why do you need a placeholder? U-Boot can just append the
address/property.

Best regards,
Krzysztof
