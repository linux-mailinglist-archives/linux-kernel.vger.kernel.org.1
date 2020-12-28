Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E182A2E3D6E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 15:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440689AbgL1OPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 09:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440654AbgL1OPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 09:15:24 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16CAC061796
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 06:14:44 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id n7so7411193pgg.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 06:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jzv76ZxrfyN9aLufGK4Ag7xuBKo0xh2BNWYNmVhmZnU=;
        b=rg7WbRj11lokwdONgJDWxxmo2Cd5hR3p5eTsMApwFhZ6YrjXaJ2X9Ld3UxV/xCqYPc
         h/65VLLkmldjIfJsYlSpXTBQWFibWMITt0L8g6yE9Y/Hw1E+qWVySxw6amuAbuWnaDeq
         p+MnueT1C2ayp5PExAHLUuQ6FMFRKlniOkFt600zGL6Wu7sFTqZtfcpoNuNNc0ZjXIL5
         lYOn1VnmkFaeI+zEPdHxh8xXir1e+F/6HcRf48MQ/x5fBra3uB9pw0QXKGOiuM717k0n
         7ZhUl5bhEqbO8+GXpI38MiNEFG2hHYa3jSRtzl6QpRhv6iaryfxb1rcN5sOgaNkilPVl
         UOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jzv76ZxrfyN9aLufGK4Ag7xuBKo0xh2BNWYNmVhmZnU=;
        b=WvUYIsYVc9elw4x7RMqJdmAsMs+Zgxqbo9r1+G/cMsfL4DYVXSKxnDmGuz2qg2eag8
         ZP/8Ff0BmyI/fWlYPaifqGFoxcWyFZrUL1FF0KIsiOa9iV+9klV5HlPwVUNaXLZLHBQ6
         2xWSdnQr4Rv2X79DBxW6Udh36kAZIYNlrYqc+vgk6YX6jF0xvenR+YLXZuwx77C6haYs
         mgueFb/am5lanegbKK6Ka+8evtvYFBUshG1OA+p9lgshfC7hdpSKabju+aMPrl1GaUTV
         3hWAD8gl/Jne7jZIQ/c0RX90snh4Eu8Kbqr4t1V4LOSKCxXpHu0KVruiOvJQo//VdlSj
         ZVbw==
X-Gm-Message-State: AOAM530H7j2r85ThgD87gallRw8ptwqWDGnqYBKP5BrDR1XB+8lY61oi
        DO5F1PKESLm9ns9YDnU7RKc4pm/uDh5xzBfQEMo=
X-Google-Smtp-Source: ABdhPJw0jdWVruIXOd+HR2C6dc9/TXCfNZWddyDREtzDGvhSptycRDJkF3safh2eGG216pDI3oUUfKtBMTD5AmHVd6g=
X-Received: by 2002:a63:b1e:: with SMTP id 30mr43734626pgl.203.1609164884087;
 Mon, 28 Dec 2020 06:14:44 -0800 (PST)
MIME-Version: 1.0
References: <20201227211232.117801-1-hdegoede@redhat.com> <20201227211232.117801-4-hdegoede@redhat.com>
In-Reply-To: <20201227211232.117801-4-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 28 Dec 2020 16:14:27 +0200
Message-ID: <CAHp75VesAo9-GGCVyGcQuNLG8KOLcB_S+bokcxJTfeDn7sb0Bg@mail.gmail.com>
Subject: Re: [PATCH 03/14] mfd: arizona: Add support for ACPI enumeration of
 WM5102 connected over SPI
To:     Hans de Goede <hdegoede@redhat.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 27, 2020 at 11:16 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> The Intel Bay Trail (x86/ACPI) based Lenovo Yoga Tablet 2 series use
> a WM5102 codec connected over SPI.
>
> Add support for ACPI enumeration to arizona-spi so that arizona-spi can
> bind to the codec on these tablets.
>
> This is loosely based on an earlier attempt (for Android-x86) at this by
> Christian Hartmann, combined with insights in things like the speaker GPIO
> from the android-x86 android port for the Lenovo Yoga Tablet 2 1051F/L [1].

Few nitpicks here and there, but the most important bit that hits me
is device_get_match_data().

> [1] https://github.com/Kitsune2222/Android_Yoga_Tablet_2-1051F_Kernel
>
> Cc: Christian Hartmann <cornogle@googlemail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/mfd/arizona-spi.c | 120 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 120 insertions(+)
>
> diff --git a/drivers/mfd/arizona-spi.c b/drivers/mfd/arizona-spi.c
> index 704f214d2614..bcdbd72fefb5 100644
> --- a/drivers/mfd/arizona-spi.c
> +++ b/drivers/mfd/arizona-spi.c
> @@ -7,7 +7,10 @@
>   * Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
>   */
>
> +#include <linux/acpi.h>
>  #include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/gpio/machine.h>
>  #include <linux/module.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
> @@ -15,11 +18,119 @@
>  #include <linux/slab.h>
>  #include <linux/spi/spi.h>
>  #include <linux/of.h>
> +#include <uapi/linux/input-event-codes.h>
>
>  #include <linux/mfd/arizona/core.h>
>
>  #include "arizona.h"
>
> +#ifdef CONFIG_ACPI
> +const struct acpi_gpio_params reset_gpios = { 1, 0, false };
> +const struct acpi_gpio_params ldoena_gpios = { 2, 0, false };
> +
> +static const struct acpi_gpio_mapping arizona_acpi_gpios[] = {
> +       { "reset-gpios", &reset_gpios, 1, },
> +       { "wlf,ldoena-gpios", &ldoena_gpios, 1 },
> +       { }
> +};
> +
> +/*
> + * The ACPI resources for the device only describe external GPIO-s. They do
> + * not provide mappings for the GPIO-s coming from the Arizona codec itself.
> + */
> +static const struct gpiod_lookup arizona_soc_gpios[] = {
> +       { "arizona", 2, "wlf,spkvdd-ena", 0, GPIO_ACTIVE_HIGH },
> +       { "arizona", 4, "wlf,micd-pol", 0, GPIO_ACTIVE_LOW },
> +};
> +
> +/*
> + * The AOSP 3.5 mm Headset: Accessory Specification gives the following values:
> + * Function A Play/Pause:           0 ohm
> + * Function D Voice assistant:    135 ohm
> + * Function B Volume Up           240 ohm
> + * Function C Volume Down         470 ohm
> + * Minimum Mic DC resistance     1000 ohm
> + * Minimum Ear speaker impedance   16 ohm
> + * Note the first max value below must be less then the min. speaker impedance,
> + * to allow CTIA/OMTP detection to work. The other max values are the closest
> + * value from extcon-arizona.c:arizona_micd_levels halfway 2 button resistances.
> + */
> +static const struct arizona_micd_range arizona_micd_aosp_ranges[] = {
> +       { .max =  11, .key = KEY_PLAYPAUSE },
> +       { .max = 186, .key = KEY_VOICECOMMAND },
> +       { .max = 348, .key = KEY_VOLUMEUP },
> +       { .max = 752, .key = KEY_VOLUMEDOWN },
> +};
> +
> +static void arizona_spi_acpi_remove_lookup(void *lookup)
> +{
> +       gpiod_remove_lookup_table(lookup);
> +}
> +
> +static int arizona_spi_acpi_probe(struct arizona *arizona)
> +{
> +       struct gpiod_lookup_table *lookup;
> +       int i, ret;
> +
> +       /* Add mappings for the 2 ACPI declared GPIOs used for reset and ldo-ena */
> +       devm_acpi_dev_add_driver_gpios(arizona->dev, arizona_acpi_gpios);
> +
> +       /* Add lookups for the SoCs own GPIOs used for micdet-polarity and spkVDD-enable */
> +       lookup = devm_kzalloc(arizona->dev,
> +                             struct_size(lookup, table, ARRAY_SIZE(arizona_soc_gpios) + 1),
> +                             GFP_KERNEL);
> +       if (!lookup)
> +               return -ENOMEM;
> +
> +       lookup->dev_id = dev_name(arizona->dev);

> +       for (i = 0; i < ARRAY_SIZE(arizona_soc_gpios); i++)
> +               lookup->table[i] = arizona_soc_gpios[i];

Would memcpy() do the same at one pass?

> +       gpiod_add_lookup_table(lookup);
> +       ret = devm_add_action_or_reset(arizona->dev, arizona_spi_acpi_remove_lookup, lookup);
> +       if (ret)
> +               return ret;

> +       /* Enable 32KHz clock from SoC to codec for jack-detect */
> +       acpi_evaluate_object(ACPI_HANDLE(arizona->dev), "CLKE", NULL, NULL);

No error check?

> +       /*
> +        * Some DSDTs wrongly declare the IRQ trigger-type as IRQF_TRIGGER_FALLING
> +        * The IRQ line will stay low when a new IRQ event happens between reading
> +        * the IRQ status flags and acknowledging them. When the IRQ line stays
> +        * low like this the IRQ will never trigger again when its type is set
> +        * to IRQF_TRIGGER_FALLING. Correct the IRQ trigger-type to fix this.
> +        */
> +       arizona->pdata.irq_flags = IRQF_TRIGGER_LOW;
> +
> +       /* Wait 200 ms after jack insertion */
> +       arizona->pdata.micd_detect_debounce = 200;
> +
> +       /* Use standard AOSP values for headset-button mappings */
> +       arizona->pdata.micd_ranges = arizona_micd_aosp_ranges;
> +       arizona->pdata.num_micd_ranges = ARRAY_SIZE(arizona_micd_aosp_ranges);
> +
> +       return 0;
> +}
> +
> +static const struct acpi_device_id arizona_acpi_match[] = {
> +       {
> +               .id = "WM510204",
> +               .driver_data = WM5102,
> +       },
> +       {
> +               .id = "WM510205",
> +               .driver_data = WM5102,
> +       },

> +       { },

No need for comma here.

> +};
> +MODULE_DEVICE_TABLE(acpi, arizona_acpi_match);
> +#else

> +static void arizona_spi_acpi_probe(struct arizona *arizona)
> +{
> +}

Can be one line?

> +#endif
> +
>  static int arizona_spi_probe(struct spi_device *spi)
>  {
>         const struct spi_device_id *id = spi_get_device_id(spi);
> @@ -30,6 +141,8 @@ static int arizona_spi_probe(struct spi_device *spi)
>
>         if (spi->dev.of_node)
>                 type = arizona_of_get_type(&spi->dev);
> +       else if (ACPI_COMPANION(&spi->dev))
> +               type = (unsigned long)acpi_device_get_match_data(&spi->dev);

Can we rather get rid of these and use device_get_match_data() directly?

>         else
>                 type = id->driver_data;
>
> @@ -75,6 +188,12 @@ static int arizona_spi_probe(struct spi_device *spi)
>         arizona->dev = &spi->dev;
>         arizona->irq = spi->irq;
>
> +       if (ACPI_COMPANION(&spi->dev)) {

has_acpi_companion() ?

> +               ret = arizona_spi_acpi_probe(arizona);
> +               if (ret)
> +                       return ret;
> +       }
> +
>         return arizona_dev_init(arizona);
>  }
>
> @@ -102,6 +221,7 @@ static struct spi_driver arizona_spi_driver = {
>                 .name   = "arizona",
>                 .pm     = &arizona_pm_ops,
>                 .of_match_table = of_match_ptr(arizona_of_match),
> +               .acpi_match_table = ACPI_PTR(arizona_acpi_match),
>         },
>         .probe          = arizona_spi_probe,
>         .remove         = arizona_spi_remove,
> --
> 2.28.0
>


-- 
With Best Regards,
Andy Shevchenko
