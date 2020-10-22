Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E250295BA4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 11:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895864AbgJVJWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 05:22:46 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:48473 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2508573AbgJVJWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 05:22:46 -0400
Received: from [192.168.1.155] ([95.115.71.8]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mwwhx-1kC4w63w4J-00yQA8; Thu, 22 Oct 2020 11:22:34 +0200
Subject: Re: [PATCH 1/2] x86: Conditional init of pcengines leds/keys gpios
To:     Ed Wildgoose <lists@wildgooses.com>, linux-kernel@vger.kernel.org
Cc:     fe@dev.tdt.de, hdegoede@redhat.com,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
References: <2ba7fc12-a3a7-2783-54e6-27e9eb60ec9c@redhat.com>
 <20201021214151.32229-1-lists@wildgooses.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <0720575c-88c3-4f88-caa7-4707139702a1@metux.net>
Date:   Thu, 22 Oct 2020 11:22:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201021214151.32229-1-lists@wildgooses.com>
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:f49xOwhI8wWTeY6YHO8kn0Mq0qk7cVcT+WfTr1sRaaQscawk+x5
 PcAvRghaTDtSp/FcSEcWYmReB+jZ2O7Yiu2jhSEKfyMBCwfPThrue/T/01+ef0yQc8VarSy
 pc1Rf6DsgxrnSoknw6aA+EOxnICP9lyc4HMxVjUxOm2JWKiZ2XvRM4mlkPKxbXeA4Ybc2xJ
 BcnpZzR2xa+8IRwAIy8Aw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+VBrUyRlTJQ=:JHL/v5B7O9PUfKGO4JPebk
 VJSXG+HqvbvO0UTdwyRe3GDVc4k3ARzjQ55MjLZLSWLsk4hLRCTyPm+9mP2XjQ0eoUP/zKHs1
 vSna67EmkILIUZObcXXC19PFM5yIhwnEMw4fmlDStpQa/Gg6CNd4N1NkeCQz3Qbn3W57fxftU
 iSBSaqx3osdQOZqk2pVQOzdbbB9OYY+KQBJ8mjjRC5KmORou3Jqhygg93pC7XBPe4eIlg6sxV
 8uPcLjHszfV1iWrvISYaJYQmq7zRBdbeh7Rj8SFwqBBdjMVqIdP43jx0wsaNTHMXTVRv9uB2Y
 KMPR61CLc0sm5F6XPslRa4BinLI7R6JO1qzwZDxmlTxDyL0+LJ8Fs+xzs9W+qTzJ5o97kZrt0
 T/NsLuM2eHCd3VWukJpXxmLyj0R///Hz4FG8jeJFVbCC8yneFkkgrYPCGD9gL
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.10.20 23:41, Ed Wildgoose wrote:

Hi,

> The pcengines bios/firmware includes ACPI tables (since 4.10.0.1) which
> will cause the kernel to automatically create led + gpio_key devices for
> the platform. This means that the platform setup now creates duplicates
> of all these led/key devices.
> 
> Driver conditionally initialises leds/keys only for older bios.

still breaks existing userlands as device names change - LEDs as well as
keys, and keycodes also change.

IOW: userland needs to be depending on specific BIOS versions.


--mtx


> 
> Signed-off-by: Ed Wildgoose <lists@wildgooses.com>
> ---
>  drivers/platform/x86/pcengines-apuv2.c | 115 +++++++++++++++++++------
>  1 file changed, 90 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/platform/x86/pcengines-apuv2.c b/drivers/platform/x86/pcengines-apuv2.c
> index c37349f97..45f7a89de 100644
> --- a/drivers/platform/x86/pcengines-apuv2.c
> +++ b/drivers/platform/x86/pcengines-apuv2.c
> @@ -128,6 +128,18 @@ static struct gpiod_lookup_table gpios_key_table = {
>  
>  /* Board setup */
>  
> +struct apu_driver_data {
> +	const struct amd_fch_gpio_pdata *board_data;
> +	const struct gpio_keys_platform_data *apu_keys_pdata;
> +	const struct gpio_led_platform_data *apu_leds_pdata;
> +};
> +
> +static struct apu_driver_data apu2_driver_data = {
> +	.board_data = &board_apu2,
> +	.apu_keys_pdata = &apu2_keys_pdata,
> +	.apu_leds_pdata = &apu2_leds_pdata
> +};
> +
>  /* Note: matching works on string prefix, so "apu2" must come before "apu" */
>  static const struct dmi_system_id apu_gpio_dmi_table[] __initconst = {
>  
> @@ -138,7 +150,7 @@ static const struct dmi_system_id apu_gpio_dmi_table[] __initconst = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
>  			DMI_MATCH(DMI_BOARD_NAME, "APU2")
>  		},
> -		.driver_data	= (void *)&board_apu2,
> +		.driver_data	= (void *)&apu2_driver_data,
>  	},
>  	/* APU2 w/ legacy BIOS >= 4.0.8 */
>  	{
> @@ -147,7 +159,7 @@ static const struct dmi_system_id apu_gpio_dmi_table[] __initconst = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
>  			DMI_MATCH(DMI_BOARD_NAME, "apu2")
>  		},
> -		.driver_data	= (void *)&board_apu2,
> +		.driver_data	= (void *)&apu2_driver_data,
>  	},
>  	/* APU2 w/ mainline BIOS */
>  	{
> @@ -156,7 +168,7 @@ static const struct dmi_system_id apu_gpio_dmi_table[] __initconst = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
>  			DMI_MATCH(DMI_BOARD_NAME, "PC Engines apu2")
>  		},
> -		.driver_data	= (void *)&board_apu2,
> +		.driver_data	= (void *)&apu2_driver_data,
>  	},
>  
>  	/* APU3 w/ legacy BIOS < 4.0.8 */
> @@ -166,7 +178,7 @@ static const struct dmi_system_id apu_gpio_dmi_table[] __initconst = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
>  			DMI_MATCH(DMI_BOARD_NAME, "APU3")
>  		},
> -		.driver_data = (void *)&board_apu2,
> +		.driver_data = (void *)&apu2_driver_data,
>  	},
>  	/* APU3 w/ legacy BIOS >= 4.0.8 */
>  	{
> @@ -175,7 +187,7 @@ static const struct dmi_system_id apu_gpio_dmi_table[] __initconst = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
>  			DMI_MATCH(DMI_BOARD_NAME, "apu3")
>  		},
> -		.driver_data = (void *)&board_apu2,
> +		.driver_data = (void *)&apu2_driver_data,
>  	},
>  	/* APU3 w/ mainline BIOS */
>  	{
> @@ -184,7 +196,7 @@ static const struct dmi_system_id apu_gpio_dmi_table[] __initconst = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
>  			DMI_MATCH(DMI_BOARD_NAME, "PC Engines apu3")
>  		},
> -		.driver_data = (void *)&board_apu2,
> +		.driver_data = (void *)&apu2_driver_data,
>  	},
>  	/* APU4 w/ legacy BIOS < 4.0.8 */
>  	{
> @@ -193,7 +205,7 @@ static const struct dmi_system_id apu_gpio_dmi_table[] __initconst = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
>  			DMI_MATCH(DMI_BOARD_NAME, "APU4")
>  		},
> -		.driver_data = (void *)&board_apu2,
> +		.driver_data = (void *)&apu2_driver_data,
>  	},
>  	/* APU4 w/ legacy BIOS >= 4.0.8 */
>  	{
> @@ -202,7 +214,7 @@ static const struct dmi_system_id apu_gpio_dmi_table[] __initconst = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
>  			DMI_MATCH(DMI_BOARD_NAME, "apu4")
>  		},
> -		.driver_data = (void *)&board_apu2,
> +		.driver_data = (void *)&apu2_driver_data,
>  	},
>  	/* APU4 w/ mainline BIOS */
>  	{
> @@ -211,11 +223,42 @@ static const struct dmi_system_id apu_gpio_dmi_table[] __initconst = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
>  			DMI_MATCH(DMI_BOARD_NAME, "PC Engines apu4")
>  		},
> -		.driver_data = (void *)&board_apu2,
> +		.driver_data = (void *)&apu2_driver_data,
>  	},
>  	{}
>  };
>  
> +int cmp_version(const char *base, const char *test)
> +{
> +	int i;
> +	int oct_base[4], oct_test[4];
> +	int matched_base, matched;
> +
> +	matched_base = sscanf(base, "v%4d.%4d.%4d.%4d",
> +					&oct_base[0], &oct_base[1],
> +					&oct_base[2], &oct_base[3]);
> +	matched = sscanf(test, "v%4d.%4d.%4d.%4d",
> +					&oct_test[0], &oct_test[1],
> +					&oct_test[2], &oct_test[3]);
> +
> +	/* opinionated: match as lower if we can't parse test version */
> +	if (matched == 0)
> +		return -1;
> +
> +	if (matched_base < matched)
> +		matched = matched_base;
> +
> +	for (i = 0; i < matched; i++) {
> +		if (oct_test[i] > oct_base[i])
> +			return 1;
> +		else if (oct_test[i] < oct_base[i])
> +			return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +
>  static struct platform_device *apu_gpio_pdev;
>  static struct platform_device *apu_leds_pdev;
>  static struct platform_device *apu_keys_pdev;
> @@ -244,41 +287,63 @@ static struct platform_device * __init apu_create_pdev(
>  static int __init apu_board_init(void)
>  {
>  	const struct dmi_system_id *id;
> +	const struct apu_driver_data *driver_data;
> +	char const *bios_ver;
> +
> +	apu_leds_pdev = apu_keys_pdev = NULL;
>  
>  	id = dmi_first_match(apu_gpio_dmi_table);
>  	if (!id) {
>  		pr_err("failed to detect APU board via DMI\n");
>  		return -ENODEV;
> +	} else {
> +		pr_info("Detected APU board: %s - BIOS: %s\n",
> +		dmi_get_system_info(DMI_BOARD_NAME),
> +		dmi_get_system_info(DMI_BIOS_VERSION));
>  	}
>  
> -	gpiod_add_lookup_table(&gpios_led_table);
> -	gpiod_add_lookup_table(&gpios_key_table);
> +	driver_data = id->driver_data;
> +	bios_ver = dmi_get_system_info(DMI_BIOS_VERSION);
>  
>  	apu_gpio_pdev = apu_create_pdev(
>  		AMD_FCH_GPIO_DRIVER_NAME,
> -		id->driver_data,
> +		driver_data->board_data,
>  		sizeof(struct amd_fch_gpio_pdata));
>  
> -	apu_leds_pdev = apu_create_pdev(
> -		"leds-gpio",
> -		&apu2_leds_pdata,
> -		sizeof(apu2_leds_pdata));
> -
> -	apu_keys_pdev = apu_create_pdev(
> -		"gpio-keys-polled",
> -		&apu2_keys_pdata,
> -		sizeof(apu2_keys_pdata));
> +	if (cmp_version("v4.10", bios_ver) < 0) {
> +		/* Newer bios configure LEDs/keys via ACPI */
> +
> +		if (driver_data->apu_keys_pdata) {
> +			gpiod_add_lookup_table(&gpios_key_table);
> +			apu_keys_pdev = apu_create_pdev(
> +				"gpio-keys-polled",
> +				driver_data->apu_keys_pdata,
> +				sizeof(struct gpio_keys_platform_data));
> +		}
> +
> +		if (driver_data->apu_leds_pdata) {
> +			gpiod_add_lookup_table(&gpios_led_table);
> +			apu_leds_pdev = apu_create_pdev(
> +				"leds-gpio",
> +				driver_data->apu_leds_pdata,
> +				sizeof(struct gpio_led_platform_data));
> +		}
> +	}
>  
>  	return 0;
>  }
>  
>  static void __exit apu_board_exit(void)
>  {
> -	gpiod_remove_lookup_table(&gpios_led_table);
> -	gpiod_remove_lookup_table(&gpios_key_table);
> +	if (apu_keys_pdev) {
> +		gpiod_remove_lookup_table(&gpios_key_table);
> +		platform_device_unregister(apu_keys_pdev);
> +	}
> +	if (apu_leds_pdev) {
> +		gpiod_remove_lookup_table(&gpios_led_table);
> +		platform_device_unregister(apu_leds_pdev);
> +	}
>  
> -	platform_device_unregister(apu_keys_pdev);
> -	platform_device_unregister(apu_leds_pdev);
>  	platform_device_unregister(apu_gpio_pdev);
>  }
>  
> 

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
