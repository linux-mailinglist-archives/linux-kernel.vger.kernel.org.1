Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26FC01F3A8B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 14:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbgFIMUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 08:20:43 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:45463 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbgFIMUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 08:20:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1591705242; x=1623241242;
  h=references:from:to:cc:subject:in-reply-to:date:
   message-id:mime-version;
  bh=/ARMfJTWTJUqONEm3m+NvlVGabaqqM3z40RZZEwlMpo=;
  b=nKUcgDGqQjwA15aFOkqpp9uf7UZVnA4eGvz1uW39vR1DbqBrO94Sycaq
   fOlyU0RUZyXwuGXjdfoQAKaH48DS8xMyxsX0HdT+6zqHSrancwbwvil6W
   RiTu3gKRcDKEP3kcKwI1oaStqfTVDKK/1EfVGEXTQJnttVFWQ/Exex+10
   HRzu207xM54EMnZ3OY75415N8L6ALhAJHKMXoeeLvkwAzZ7eEP8x5ZCS/
   4J7oDz1bel6PztaWyqMXo+LP/n+IWeSX1tksv4KMFpKh9aXENSn4e/3T7
   DvQ6dQ8WROJURnC1m/urZgKEOmhn9ZypDhpcOiObsv//SgvjB/iIPbE6i
   g==;
IronPort-SDR: jMSRtlxIhw1KB3hsptje3YuoNtLg7hGMSiF68EEdeeTFqzEzPEXSAnsxs8fW/TYAMbZIBvsV6C
 JnLWPuQ41nD7YyMuqOYXFFGhTcXQPW8hHn+qv6C6KP0PnraA6VDsjpLNfc31EZO0cLeboaixXa
 OjQ5+naA6n8RzwLlsBdJfnRUjOaI3rhv1Yam3Yx8+KydO6usPbP56QeuA7KgqWk1kHbx/I/W9K
 FUC4gHHZ7XJ4m4RNaEsswSKvYg2cnU0rpAPZh6AIt1+Llx1IfeSgChoOs+GdjLDF2vktTDzOp0
 yeM=
X-IronPort-AV: E=Sophos;i="5.73,492,1583218800"; 
   d="scan'208";a="78736295"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jun 2020 05:20:42 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Tue, 9 Jun 2020 05:20:40 -0700
Received: from soft-dev15.microsemi.net.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3
 via Frontend Transport; Tue, 9 Jun 2020 05:20:38 -0700
References: <20200609072828.9088-1-lars.povlsen@microchip.com> <20200609074940.9529-1-lars.povlsen@microchip.com> <20200609093808.00003aad@Huawei.com>
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jean Delvare <jdelvare@suse.com>,
        <linux-kernel@vger.kernel.org>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 3/3] hwmon: sparx5: Add Sparx5 SoC temperature driver
In-Reply-To: <20200609093808.00003aad@Huawei.com>
Date:   Tue, 9 Jun 2020 14:20:37 +0200
Message-ID: <87h7vkig6i.fsf@soft-dev15.microsemi.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jonathan Cameron writes:

> On Tue, 9 Jun 2020 09:49:40 +0200
> Lars Povlsen <lars.povlsen@microchip.com> wrote:
>
>> This patch adds a temperature sensor driver to the Sparx5 SoC.
>>
>> Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
>> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
>
> Hi.  Quick drive by review whilst waiting for coffee time...
>
> A few minor suggestions inline.
>

Much appreciated!

> Thanks,
>
> Jonathan
>
>> ---
>>  drivers/hwmon/Kconfig       |  10 +++
>>  drivers/hwmon/Makefile      |   2 +-
>>  drivers/hwmon/sparx5-temp.c | 152 ++++++++++++++++++++++++++++++++++++
>>  3 files changed, 163 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/hwmon/sparx5-temp.c
>>
>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>> index 288ae9f63588c..ec6bb8b8b12df 100644
>> --- a/drivers/hwmon/Kconfig
>> +++ b/drivers/hwmon/Kconfig
>> @@ -515,6 +515,16 @@ config SENSORS_I5K_AMB
>>         This driver can also be built as a module. If so, the module
>>         will be called i5k_amb.
>>
>> +config SENSORS_SPARX5
>> +     tristate "Sparx5 SoC temperature sensor"
>> +     depends on ARCH_SPARX5
> Anything stop this building with COMPILE_TEST?
>
> That will great increase automated build coverage.
>
>> +     help
>> +       If you say yes here you get support for temperature monitoring
>> +       with the Microchip Sparx5 SoC.
>> +
>> +       This driver can also be built as a module. If so, the module
>> +       will be called sparx5-temp.
>> +
>>  config SENSORS_F71805F
>>       tristate "Fintek F71805F/FG, F71806F/FG and F71872F/FG"
>>       depends on !PPC
>> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
>> index 3e32c21f5efe3..144f09993a3f4 100644
>> --- a/drivers/hwmon/Makefile
>> +++ b/drivers/hwmon/Makefile
>> @@ -66,6 +66,7 @@ obj-$(CONFIG_SENSORS_DS1621)        += ds1621.o
>>  obj-$(CONFIG_SENSORS_EMC1403)        += emc1403.o
>>  obj-$(CONFIG_SENSORS_EMC2103)        += emc2103.o
>>  obj-$(CONFIG_SENSORS_EMC6W201)       += emc6w201.o
>> +obj-$(CONFIG_SENSORS_SPARX5) += sparx5-temp.o
>>  obj-$(CONFIG_SENSORS_F71805F)        += f71805f.o
>>  obj-$(CONFIG_SENSORS_F71882FG)       += f71882fg.o
>>  obj-$(CONFIG_SENSORS_F75375S)        += f75375s.o
>> @@ -193,4 +194,3 @@ obj-$(CONFIG_SENSORS_OCC) += occ/
>>  obj-$(CONFIG_PMBUS)          += pmbus/
>>
>>  ccflags-$(CONFIG_HWMON_DEBUG_CHIP) := -DDEBUG
>> -
>> diff --git a/drivers/hwmon/sparx5-temp.c b/drivers/hwmon/sparx5-temp.c
>> new file mode 100644
>> index 0000000000000..2e754462b6010
>> --- /dev/null
>> +++ b/drivers/hwmon/sparx5-temp.c
>> @@ -0,0 +1,152 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/* Sparx5 SoC temperature sensor driver
>> + *
>> + * Copyright (C) 2020 Lars Povlsen <lars.povlsen@microchip.com>
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/init.h>
>> +#include <linux/hwmon.h>
>> +#include <linux/io.h>
>> +#include <linux/of_device.h>
> I think you only have this to define the id table?
>
> If so, perhaps better to include mod_devicetable.h and not include
> the of header.

Well, I ended up needed other, so it became:

-#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/mod_devicetable.h>

Other of these drivers seem to use "linux/of_device.h" as well?

>
>> +
>> +#define TEMP_CTRL            0
>> +#define TEMP_CFG             4
>> +#define  TEMP_CFG_CYCLES     GENMASK(24, 15)
>> +#define  TEMP_CFG_CYCLES_OFF 15
>
> Could you used FIELD_PREP etc to avoid having to have both
> the mask and offset defined here?
>
>> +#define  TEMP_CFG_ENA                BIT(0)
>> +#define TEMP_STAT            8
>> +#define  TEMP_STAT_VALID     BIT(12)
>> +#define  TEMP_STAT_TEMP              GENMASK(11, 0)
>> +
>> +struct s5_hwmon {
>> +     void __iomem *base;
>> +};
>> +
>> +static void s5_temp_enable(struct s5_hwmon *hwmon)
>> +{
>> +     u32 val = readl(hwmon->base + TEMP_CFG);
>> +     u32 clk = 250;
>> +
>> +     val &= ~TEMP_CFG_CYCLES;
>> +     val |= (clk << TEMP_CFG_CYCLES_OFF);
>> +     val |= TEMP_CFG_ENA;
>> +
>> +     writel(val, hwmon->base + TEMP_CFG);
>> +}
>> +
>> +static void s5_temp_disable(void *data)
>> +{
>> +     struct s5_hwmon *hwmon = data;
>> +     u32 val = readl(hwmon->base + TEMP_CFG);
>> +
>> +     val &= ~TEMP_CFG_ENA;
>> +
>> +     writel(val, hwmon->base + TEMP_CFG);
>> +}
>> +
>> +static int s5_read(struct device *dev, enum hwmon_sensor_types type,
>> +                u32 attr, int channel, long *temp)
>> +{
>> +     struct s5_hwmon *hwmon = dev_get_drvdata(dev);
>> +     int rc = 0, value;
>> +     u32 stat;
>> +
>> +     switch (attr) {
>> +     case hwmon_temp_input:
>> +             stat = readl_relaxed(hwmon->base + TEMP_STAT);
>> +             if (!(stat & TEMP_STAT_VALID))
>> +                     return -EIO;
>> +             value = stat & TEMP_STAT_TEMP;
>> +             value = DIV_ROUND_CLOSEST(value * 3522, 4096) - 1094;
>> +             value *= 100;
>> +             *temp = value;
>> +             break;
>> +     default:
>> +             rc = -EOPNOTSUPP;
>> +             break;
>> +     }
>> +
>> +     return rc;
>> +}
>> +
>> +static umode_t s5_is_visible(const void *_data, enum hwmon_sensor_types type,
>> +                          u32 attr, int channel)
>> +{
>> +     if (type != hwmon_temp)
>> +             return 0;
>> +
>> +     switch (attr) {
>> +     case hwmon_temp_input:
>> +             return 0444;
>> +     default:
>> +             return 0;
>> +     }
>> +}
>> +
>> +static const struct hwmon_channel_info *s5_info[] = {
>> +     HWMON_CHANNEL_INFO(chip,
>> +                        HWMON_C_REGISTER_TZ),
>> +     HWMON_CHANNEL_INFO(temp,
>> +                        HWMON_T_INPUT),
>
> Excess line breaks.  The above 2 would be more readable on one line each.
>

Right.

>> +     NULL
>> +};
>> +
>> +static const struct hwmon_ops s5_hwmon_ops = {
>> +     .is_visible = s5_is_visible,
>> +     .read = s5_read,
>> +};
>> +
>> +static const struct hwmon_chip_info s5_chip_info = {
>> +     .ops = &s5_hwmon_ops,
>> +     .info = s5_info,
>> +};
>> +
>> +static int s5_temp_probe(struct platform_device *pdev)
>> +{
>> +     struct device *hwmon_dev;
>> +     struct s5_hwmon *hwmon;
>> +     int err;
>> +
>> +     hwmon = devm_kzalloc(&pdev->dev, sizeof(*hwmon), GFP_KERNEL);
>> +     if (!hwmon)
>> +             return -ENOMEM;
>> +
>> +     hwmon->base = devm_platform_ioremap_resource(pdev, 0);
>> +     if (IS_ERR(hwmon->base))
>> +             return PTR_ERR(hwmon->base);
>> +
>> +     err = devm_add_action(&pdev->dev, s5_temp_disable, hwmon);
>> +     if (err)
>> +             return err;
>
> Probably just my linear way of thinking, but unusual to put error
> handling / remove stuff in place _before_ the thing it's unwinding.
>
> We have devm_add_action_or_reset to make it safe to call this after
> the thing it unwinds.
>

Seems I got this "backwardness" from ltq-cputemp.c. However, its totally
unneeded here, so I'll just remove it.

Thanks!

---Lars

>> +
>> +     s5_temp_enable(hwmon);
>> +
>> +     hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev,
>> +                                                      "s5_temp",
>> +                                                      hwmon,
>> +                                                      &s5_chip_info,
>> +                                                      NULL);
>> +
>> +     return PTR_ERR_OR_ZERO(hwmon_dev);
>> +}
>> +
>> +const struct of_device_id s5_temp_match[] = {
>> +     { .compatible = "microchip,sparx5-temp" },
>> +     {},
>> +};
>> +MODULE_DEVICE_TABLE(of, s5_temp_match);
>> +
>> +static struct platform_driver s5_temp_driver = {
>> +     .probe = s5_temp_probe,
>> +     .driver = {
>> +             .name = "sparx5-temp",
>> +             .of_match_table = s5_temp_match,
>> +     },
>> +};
>> +
>> +module_platform_driver(s5_temp_driver);
>> +
>> +MODULE_AUTHOR("Lars Povlsen <lars.povlsen@microchip.com>");
>> +MODULE_DESCRIPTION("Sparx5 SoC temperature sensor driver");
>> +MODULE_LICENSE("GPL");
>> --
>> 2.27.0
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Lars Povlsen,
Microchip
