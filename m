Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03DB28D0BB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 16:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388972AbgJMO5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 10:57:21 -0400
Received: from foss.arm.com ([217.140.110.172]:32866 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730680AbgJMO5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 10:57:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A01630E;
        Tue, 13 Oct 2020 07:57:20 -0700 (PDT)
Received: from [10.57.48.76] (unknown [10.57.48.76])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F7133F66B;
        Tue, 13 Oct 2020 07:57:19 -0700 (PDT)
Subject: Re: [PATCH] reset: meson: make it possible to build as a module
To:     Neil Armstrong <narmstrong@baylibre.com>, p.zabel@pengutronix.de
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20201013133943.412119-1-narmstrong@baylibre.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <f8c0feba-c235-e22f-2ea5-61e54fe97c0f@arm.com>
Date:   Tue, 13 Oct 2020 15:57:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201013133943.412119-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-13 14:39, Neil Armstrong wrote:
> In order to reduce the kernel Image size on multi-platform distributions,
> make it possible to build the reset controller driver as a module.
> 
> This partially reverts 8290924e ("reset: meson: make it explicitly non-modular")
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>   drivers/reset/Kconfig       | 4 ++--
>   drivers/reset/reset-meson.c | 7 ++++++-
>   2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index d9efbfd29646..ab315617565f 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -94,8 +94,8 @@ config RESET_LPC18XX
>   	  This enables the reset controller driver for NXP LPC18xx/43xx SoCs.
>   
>   config RESET_MESON
> -	bool "Meson Reset Driver" if COMPILE_TEST
> -	default ARCH_MESON
> +	tristate "Meson Reset Driver"
> +	default ARCH_MESON || COMPILE_TEST

How about an actual dependency like:

	depends on ARCH_MESON || COMPILE_TEST
	default ARCH_MESON
?

That way the option won't be presented to users where it's completely 
irrelevant, e.g. running "make oldconfig" with an x86 distro config. It 
always bugs me when I rebase a branch and have to manually confirm that 
indeed I don't want to build random drivers specific to x86/RISC-V/etc. 
SoCs for my arm64 config... ;)

Robin.

>   	help
>   	  This enables the reset driver for Amlogic Meson SoCs.
>   
> diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
> index 94d7ba88d7d2..434d5c0f877e 100644
> --- a/drivers/reset/reset-meson.c
> +++ b/drivers/reset/reset-meson.c
> @@ -9,6 +9,7 @@
>   #include <linux/init.h>
>   #include <linux/io.h>
>   #include <linux/of.h>
> +#include <linux/module.h>
>   #include <linux/platform_device.h>
>   #include <linux/reset-controller.h>
>   #include <linux/slab.h>
> @@ -142,4 +143,8 @@ static struct platform_driver meson_reset_driver = {
>   		.of_match_table	= meson_reset_dt_ids,
>   	},
>   };
> -builtin_platform_driver(meson_reset_driver);
> +module_platform_driver(meson_reset_driver);
> +
> +MODULE_DESCRIPTION("Amlogic Meson Reset Controller driver");
> +MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
> +MODULE_LICENSE("Dual BSD/GPL");
> 
