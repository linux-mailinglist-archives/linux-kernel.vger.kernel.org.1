Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15FF82FA12B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 14:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403939AbhARNSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 08:18:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38262 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392000AbhARNPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 08:15:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610975634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HFZsBHiz4wdGL9jh27P3G4596mkxpbLR98+Xm6UedWU=;
        b=RCaggWcsKiuhTbAhHO75dx2jPXiZQPbRWsgr7AOH0HTvb7LA8ylBuYbIpMfSfC1ejNgqS7
        W4BL87jw4ESiQRzw6TgGXmRHSty4PGziMfAQoXx8ctom3lxuM0lxxCmDKSXa8IOML2rXzd
        xjvREVdo9GxL0muKUFtDdCeApgxHN40=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-bA_IYWyNOH6cUboIfr8_Kw-1; Mon, 18 Jan 2021 08:13:52 -0500
X-MC-Unique: bA_IYWyNOH6cUboIfr8_Kw-1
Received: by mail-ed1-f69.google.com with SMTP id dg17so7599374edb.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 05:13:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HFZsBHiz4wdGL9jh27P3G4596mkxpbLR98+Xm6UedWU=;
        b=OcgvPOxBgQLmSGTLp8MdinQXstg/jUdaxNYwHO1icIgpbkdtPGBwG4CPGKQQh58gPr
         uaXvYXTsDUp7gg5+6mZfdTe2IaK6s73qZwMSInGBBdnvOhHebmHJ/gPAWaUGEX2o/dnF
         Z7tADng0VbJ5u+a+HptMDJm5ra/aBqGI1YCJrgCnUYZ/LL7iQF9dIDAnulOTzTaa75dy
         DCAglptfaJ4aXprupppV9e6Pcvr6RqLjdKsNGT2WsX17xT1dE9hambndGi2oFbhvmg2A
         Ks1O/lYDFxAmpt5+52F0dYkZfbRKzJ2sWzatWJV98dU5RIyQZCStoyDBG0DgfPIJO7B/
         Gb/w==
X-Gm-Message-State: AOAM531sjBWMHCSyOgSp9FDktmWHg/Qwx7azGALuj8Pnr057Uc8XjW7B
        6q7PsFYzlylmAkeEHRm26AIHGDDUtVA1PHo5LUl4g8EzWbUgPX3OixwSM967xqA4XX96fb5A4dG
        lhUv2SVYgrowJ9Kymcxl7M+Gu
X-Received: by 2002:aa7:c9c9:: with SMTP id i9mr18998977edt.160.1610975631549;
        Mon, 18 Jan 2021 05:13:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyowQiRgZnged9Qb0Zo0/qKoQBk5KnmnJWS/yh3aTYVlECY53QqL30hVVGrJsyCFMoChS4w6Q==
X-Received: by 2002:aa7:c9c9:: with SMTP id i9mr18998965edt.160.1610975631416;
        Mon, 18 Jan 2021 05:13:51 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id e7sm7083396ejb.19.2021.01.18.05.13.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 05:13:50 -0800 (PST)
Subject: Re: [PATCH v3 3/5] mfd: arizona: Add support for ACPI enumeration of
 WM5102 connected over SPI
To:     Mark Brown <broonie@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org,
        Christian Hartmann <cornogle@googlemail.com>
References: <20210117212252.206115-1-hdegoede@redhat.com>
 <20210117212252.206115-4-hdegoede@redhat.com>
 <20210118130227.GI4455@sirena.org.uk>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <5ccf48f4-45dc-3a30-3d6a-cce066f01270@redhat.com>
Date:   Mon, 18 Jan 2021 14:13:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210118130227.GI4455@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/18/21 2:02 PM, Mark Brown wrote:
> On Sun, Jan 17, 2021 at 10:22:50PM +0100, Hans de Goede wrote:
> 
>> +	/*
>> +	 * Some DSDTs wrongly declare the IRQ trigger-type as IRQF_TRIGGER_FALLING
>> +	 * The IRQ line will stay low when a new IRQ event happens between reading
>> +	 * the IRQ status flags and acknowledging them. When the IRQ line stays
>> +	 * low like this the IRQ will never trigger again when its type is set
>> +	 * to IRQF_TRIGGER_FALLING. Correct the IRQ trigger-type to fix this.
>> +	 */
>> +	arizona->pdata.irq_flags = IRQF_TRIGGER_LOW;
> 
> Are you sure that all the relevant interrupt controllers support active
> low interrupts?  There were issues on some systems with missing support
> for active low interrupts (see the bodge in wm8994-irq.c to work around
> them) - it's entirely likely that there are DSDTs that are just plain
> buggy here but if someone's copying and pasting it smells like there may
> be some systems that actually need an edge triggered interrupt that
> they're getting it from.

I'm only aware of one series of devices / models which actually
use the combination of ACPI enumeration and the WM5102 codec, and that
is the Lenovo Yoga Tablet 2 series (in 8, 10 and 13 inch versions
shipping with both Windows and Android). These all use a Bay Trail
SoC which is capable of using active low interrupts.

More in general I'm not aware of any (recent-ish) x86 GPIO controllers
not being able to do active low interrupts. In theory we could hit this
code path on ARM devices using ACPI enumeration, but I don't think it
is likely we will see a combination of ARM + ACPI enumeration +
WM5102 + GPIO controller not capable of active-low interrupts.

This overriding of the flags definitely is necessary on the Lenovo
devices in question. I could add a
"if (dmi_name_in_vendors("LENOVO"))" guard around it, but that
seems unnecessary.

Regards,

Hans



> 
>> +
>> +	/* Wait 200 ms after jack insertion */
>> +	arizona->pdata.micd_detect_debounce = 200;
>> +
>> +	/* Use standard AOSP values for headset-button mappings */
>> +	arizona->pdata.micd_ranges = arizona_micd_aosp_ranges;
>> +	arizona->pdata.num_micd_ranges = ARRAY_SIZE(arizona_micd_aosp_ranges);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct acpi_device_id arizona_acpi_match[] = {
>> +	{
>> +		.id = "WM510204",
>> +		.driver_data = WM5102,
>> +	},
>> +	{
>> +		.id = "WM510205",
>> +		.driver_data = WM5102,
>> +	},
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(acpi, arizona_acpi_match);
>> +#else
>> +static int arizona_spi_acpi_probe(struct arizona *arizona)
>> +{
>> +	return -ENODEV;
>> +}
>> +#endif
>> +
>>  static int arizona_spi_probe(struct spi_device *spi)
>>  {
>>  	const struct spi_device_id *id = spi_get_device_id(spi);
>> @@ -77,6 +191,12 @@ static int arizona_spi_probe(struct spi_device *spi)
>>  	arizona->dev = &spi->dev;
>>  	arizona->irq = spi->irq;
>>  
>> +	if (has_acpi_companion(&spi->dev)) {
>> +		ret = arizona_spi_acpi_probe(arizona);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>>  	return arizona_dev_init(arizona);
>>  }
>>  
>> @@ -104,6 +224,7 @@ static struct spi_driver arizona_spi_driver = {
>>  		.name	= "arizona",
>>  		.pm	= &arizona_pm_ops,
>>  		.of_match_table	= of_match_ptr(arizona_of_match),
>> +		.acpi_match_table = ACPI_PTR(arizona_acpi_match),
>>  	},
>>  	.probe		= arizona_spi_probe,
>>  	.remove		= arizona_spi_remove,
>> -- 
>> 2.28.0
>>

