Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C04D12F8E82
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 19:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbhAPSC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 13:02:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30301 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727284AbhAPSC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 13:02:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610820060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VcTYlJfv01axpJK4vnd7O3uwpWJGDHk4puaBt63QC6I=;
        b=OkX8tEIb0v+5kmOpi2KOX31Rf3jWQeRF8RBeb0BnBOCKI9y2T2ZwbF2CLA+Bw78k6i0hO+
        D7Hk5DVFyPjT4YDcIAfu+52X4RdEIj/iAkjGtJp32/N1XI17OJ/+1PoLefuE0Bz4uQxbmB
        8grZFhqUD++V1VrHxvm7k/tJ+4RbUA8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-kgBcD1TqMzaNhTqZt9rFHA-1; Sat, 16 Jan 2021 09:46:45 -0500
X-MC-Unique: kgBcD1TqMzaNhTqZt9rFHA-1
Received: by mail-ed1-f72.google.com with SMTP id x13so5421914edi.7
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 06:46:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VcTYlJfv01axpJK4vnd7O3uwpWJGDHk4puaBt63QC6I=;
        b=fdQRXlfPoCMuTRG2S+xrFH/yVbUzgwHFUs7xQjez/CinU2ZnX/VC3shnP5BRLTkKc3
         aEwgHW9RrAcWzPHaFpTNi2EUHwhCOXCpwzCg01frdalo1+uIdcG9X/XfJakZVbP2FpdS
         5PzKeUEjTTeTZUQDdgNBYDQzr2+eSwaDT+QTsNVtNK0DKRCNhfxqrA/huKn6W41b6cXw
         uNcBGIYCsI35T92WkweBxcxZE21ZDCsX1UOPL1F61OZ5rcNu3yRBV+ULFFWMMyfBFNOf
         NtvC2VRu6iqPuefRepoHKX22a0jY5I3deot24pgmuwmyafsgWJKd53b8K2/oqFo95EVR
         DXxg==
X-Gm-Message-State: AOAM530LZ9ycPbOgCdGB0c0hrO7J3/qtIt2AVxfmqnfK712mx5iHQGfw
        LuFpvTT0s0bn/4du70ip0R8m3bC4n/q4O8MoFhkay09ZlmvloAFUbDCWGUz5kX8/EUdM45Ly3J/
        DEFdsrQS8vZcEhzrs3UtgwjqT
X-Received: by 2002:a17:906:804c:: with SMTP id x12mr11998502ejw.42.1610808404324;
        Sat, 16 Jan 2021 06:46:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwh2dzEePXou8ehRPVsaKmmllVB6qkpljg6ffqyogAis6ElOP2KdZ5P145rlzQU4nWJvJd3WQ==
X-Received: by 2002:a17:906:804c:: with SMTP id x12mr11998494ejw.42.1610808404115;
        Sat, 16 Jan 2021 06:46:44 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id p16sm7478518edw.44.2021.01.16.06.46.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Jan 2021 06:46:43 -0800 (PST)
Subject: Re: [PATCH 03/14] mfd: arizona: Add support for ACPI enumeration of
 WM5102 connected over SPI
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Christian Hartmann <cornogle@googlemail.com>
References: <20201227211232.117801-1-hdegoede@redhat.com>
 <20201227211232.117801-4-hdegoede@redhat.com>
 <CAHp75VesAo9-GGCVyGcQuNLG8KOLcB_S+bokcxJTfeDn7sb0Bg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <3946c0c5-6ace-47f9-9a3e-182bf6615d1f@redhat.com>
Date:   Sat, 16 Jan 2021 15:46:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VesAo9-GGCVyGcQuNLG8KOLcB_S+bokcxJTfeDn7sb0Bg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the review.

On 12/28/20 3:14 PM, Andy Shevchenko wrote:
> On Sun, Dec 27, 2020 at 11:16 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> The Intel Bay Trail (x86/ACPI) based Lenovo Yoga Tablet 2 series use
>> a WM5102 codec connected over SPI.
>>
>> Add support for ACPI enumeration to arizona-spi so that arizona-spi can
>> bind to the codec on these tablets.
>>
>> This is loosely based on an earlier attempt (for Android-x86) at this by
>> Christian Hartmann, combined with insights in things like the speaker GPIO
>> from the android-x86 android port for the Lenovo Yoga Tablet 2 1051F/L [1].
> 
> Few nitpicks here and there, but the most important bit that hits me
> is device_get_match_data().
> 
>> [1] https://github.com/Kitsune2222/Android_Yoga_Tablet_2-1051F_Kernel
>>
>> Cc: Christian Hartmann <cornogle@googlemail.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/mfd/arizona-spi.c | 120 ++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 120 insertions(+)
>>
>> diff --git a/drivers/mfd/arizona-spi.c b/drivers/mfd/arizona-spi.c
>> index 704f214d2614..bcdbd72fefb5 100644
>> --- a/drivers/mfd/arizona-spi.c
>> +++ b/drivers/mfd/arizona-spi.c
>> @@ -7,7 +7,10 @@
>>   * Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
>>   */
>>
>> +#include <linux/acpi.h>
>>  #include <linux/err.h>
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/gpio/machine.h>
>>  #include <linux/module.h>
>>  #include <linux/pm_runtime.h>
>>  #include <linux/regmap.h>
>> @@ -15,11 +18,119 @@
>>  #include <linux/slab.h>
>>  #include <linux/spi/spi.h>
>>  #include <linux/of.h>
>> +#include <uapi/linux/input-event-codes.h>
>>
>>  #include <linux/mfd/arizona/core.h>
>>
>>  #include "arizona.h"
>>
>> +#ifdef CONFIG_ACPI
>> +const struct acpi_gpio_params reset_gpios = { 1, 0, false };
>> +const struct acpi_gpio_params ldoena_gpios = { 2, 0, false };
>> +
>> +static const struct acpi_gpio_mapping arizona_acpi_gpios[] = {
>> +       { "reset-gpios", &reset_gpios, 1, },
>> +       { "wlf,ldoena-gpios", &ldoena_gpios, 1 },
>> +       { }
>> +};
>> +
>> +/*
>> + * The ACPI resources for the device only describe external GPIO-s. They do
>> + * not provide mappings for the GPIO-s coming from the Arizona codec itself.
>> + */
>> +static const struct gpiod_lookup arizona_soc_gpios[] = {
>> +       { "arizona", 2, "wlf,spkvdd-ena", 0, GPIO_ACTIVE_HIGH },
>> +       { "arizona", 4, "wlf,micd-pol", 0, GPIO_ACTIVE_LOW },
>> +};
>> +
>> +/*
>> + * The AOSP 3.5 mm Headset: Accessory Specification gives the following values:
>> + * Function A Play/Pause:           0 ohm
>> + * Function D Voice assistant:    135 ohm
>> + * Function B Volume Up           240 ohm
>> + * Function C Volume Down         470 ohm
>> + * Minimum Mic DC resistance     1000 ohm
>> + * Minimum Ear speaker impedance   16 ohm
>> + * Note the first max value below must be less then the min. speaker impedance,
>> + * to allow CTIA/OMTP detection to work. The other max values are the closest
>> + * value from extcon-arizona.c:arizona_micd_levels halfway 2 button resistances.
>> + */
>> +static const struct arizona_micd_range arizona_micd_aosp_ranges[] = {
>> +       { .max =  11, .key = KEY_PLAYPAUSE },
>> +       { .max = 186, .key = KEY_VOICECOMMAND },
>> +       { .max = 348, .key = KEY_VOLUMEUP },
>> +       { .max = 752, .key = KEY_VOLUMEDOWN },
>> +};
>> +
>> +static void arizona_spi_acpi_remove_lookup(void *lookup)
>> +{
>> +       gpiod_remove_lookup_table(lookup);
>> +}
>> +
>> +static int arizona_spi_acpi_probe(struct arizona *arizona)
>> +{
>> +       struct gpiod_lookup_table *lookup;
>> +       int i, ret;
>> +
>> +       /* Add mappings for the 2 ACPI declared GPIOs used for reset and ldo-ena */
>> +       devm_acpi_dev_add_driver_gpios(arizona->dev, arizona_acpi_gpios);
>> +
>> +       /* Add lookups for the SoCs own GPIOs used for micdet-polarity and spkVDD-enable */
>> +       lookup = devm_kzalloc(arizona->dev,
>> +                             struct_size(lookup, table, ARRAY_SIZE(arizona_soc_gpios) + 1),
>> +                             GFP_KERNEL);
>> +       if (!lookup)
>> +               return -ENOMEM;
>> +
>> +       lookup->dev_id = dev_name(arizona->dev);
> 
>> +       for (i = 0; i < ARRAY_SIZE(arizona_soc_gpios); i++)
>> +               lookup->table[i] = arizona_soc_gpios[i];
> 
> Would memcpy() do the same at one pass?

True, fixed for v2.

>> +       gpiod_add_lookup_table(lookup);
>> +       ret = devm_add_action_or_reset(arizona->dev, arizona_spi_acpi_remove_lookup, lookup);
>> +       if (ret)
>> +               return ret;
> 
>> +       /* Enable 32KHz clock from SoC to codec for jack-detect */
>> +       acpi_evaluate_object(ACPI_HANDLE(arizona->dev), "CLKE", NULL, NULL);
> 
> No error check?

The codec will still work without the 32KHz clk, but we will loose jack-detect
functionality. I expect the ACPI call to already print some error, but to make
sure something is logged and to clarify what any previous logged ACPI errors are
about I've added code to log a warning when this fails for v2.

> 
>> +       /*
>> +        * Some DSDTs wrongly declare the IRQ trigger-type as IRQF_TRIGGER_FALLING
>> +        * The IRQ line will stay low when a new IRQ event happens between reading
>> +        * the IRQ status flags and acknowledging them. When the IRQ line stays
>> +        * low like this the IRQ will never trigger again when its type is set
>> +        * to IRQF_TRIGGER_FALLING. Correct the IRQ trigger-type to fix this.
>> +        */
>> +       arizona->pdata.irq_flags = IRQF_TRIGGER_LOW;
>> +
>> +       /* Wait 200 ms after jack insertion */
>> +       arizona->pdata.micd_detect_debounce = 200;
>> +
>> +       /* Use standard AOSP values for headset-button mappings */
>> +       arizona->pdata.micd_ranges = arizona_micd_aosp_ranges;
>> +       arizona->pdata.num_micd_ranges = ARRAY_SIZE(arizona_micd_aosp_ranges);
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct acpi_device_id arizona_acpi_match[] = {
>> +       {
>> +               .id = "WM510204",
>> +               .driver_data = WM5102,
>> +       },
>> +       {
>> +               .id = "WM510205",
>> +               .driver_data = WM5102,
>> +       },
> 
>> +       { },
> 
> No need for comma here.

Fixed for v2.

> 
>> +};
>> +MODULE_DEVICE_TABLE(acpi, arizona_acpi_match);
>> +#else
> 
>> +static void arizona_spi_acpi_probe(struct arizona *arizona)
>> +{
>> +}
> 
> Can be one line?

I find it more readable as is.

> 
>> +#endif
>> +
>>  static int arizona_spi_probe(struct spi_device *spi)
>>  {
>>         const struct spi_device_id *id = spi_get_device_id(spi);
>> @@ -30,6 +141,8 @@ static int arizona_spi_probe(struct spi_device *spi)
>>
>>         if (spi->dev.of_node)
>>                 type = arizona_of_get_type(&spi->dev);
>> +       else if (ACPI_COMPANION(&spi->dev))
>> +               type = (unsigned long)acpi_device_get_match_data(&spi->dev);
> 
> Can we rather get rid of these and use device_get_match_data() directly?

That is a good idea, I'll add a nw preparation patch to v2 replacing the
custom arizona_of_get_type() helper with device_get_match_data().

>>         else
>>                 type = id->driver_data;
>>
>> @@ -75,6 +188,12 @@ static int arizona_spi_probe(struct spi_device *spi)
>>         arizona->dev = &spi->dev;
>>         arizona->irq = spi->irq;
>>
>> +       if (ACPI_COMPANION(&spi->dev)) {
> 
> has_acpi_companion() ?

Fixed for v2.

>> +               ret = arizona_spi_acpi_probe(arizona);
>> +               if (ret)
>> +                       return ret;
>> +       }
>> +
>>         return arizona_dev_init(arizona);
>>  }
>>
>> @@ -102,6 +221,7 @@ static struct spi_driver arizona_spi_driver = {
>>                 .name   = "arizona",
>>                 .pm     = &arizona_pm_ops,
>>                 .of_match_table = of_match_ptr(arizona_of_match),
>> +               .acpi_match_table = ACPI_PTR(arizona_acpi_match),
>>         },
>>         .probe          = arizona_spi_probe,
>>         .remove         = arizona_spi_remove,
>> --
>> 2.28.0
>>
> 
> 

Regards,

Hans

