Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC652C7F16
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 08:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbgK3HtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 02:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgK3HtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 02:49:13 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC96C0613CF;
        Sun, 29 Nov 2020 23:48:33 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id w187so9876611pfd.5;
        Sun, 29 Nov 2020 23:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=zAjHSZn5y902wry3Iep1PIFrktIPXS71UwHnv6V3yTI=;
        b=FOTAc2NLM9A6Ifh4MjFtESDZoVa6bbTGHJ+gCvRRvdlVpxN7xMo15JEa+OVULEY8GF
         eGAPzNzsL8wkiia/MlZNblwTZTTMBli3ouw04oaRjZuK6tj/HK68GrtOgmysg1yonJlO
         d/V3d7wG+cgNZrwjWcoRDesD5+4YgW96hiq7HustcH2nTSzwq7/IJD3zB5n0B4xTPt6A
         /DU9jmGmqunGMhapo7yWEGtGiyAiXut3sFREezXLlNRbMR3IBID5I68BfAgYJUXyr33y
         esWC1nq3C17jYr6rLmt1EUJofURUNY6aKa+t87LT+vN6KO3CFWyJ/ehTpri5EHWVtAbb
         HA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zAjHSZn5y902wry3Iep1PIFrktIPXS71UwHnv6V3yTI=;
        b=CnAx5t6BQ94kaVkytrOO0RKbzet9vL3mIjo/F00/d01qpdyW/IKpTqAndhxZ5cRXgj
         vGT7vxwChpe71atLpG6s06yV4KKUXTEKrtiK59DbmIT5mk/yiIOorPsfCiGwHVkQUJiu
         Es30nWCDZ344YQzJUjVa61y0YY8Pg6+EGksYYrMpp26Dr2jBJadbtIUS+5Hng9iaaOYG
         O1mz/fKh1IvOjLQG2tapalHgF+0WO4vqcm22nQG1ha4VTAQsldWpSh4NGFmdxWuy/r4e
         lGtLrOHHwdZXd6BfqehBv8aZ5V8EmaklyNuoZ5L2qp9uSVySKxsfCiG2/N4wRlUNUb/H
         BKJw==
X-Gm-Message-State: AOAM531uRlQRzich45/ejtOLTGzx6np4OSykY2zRNCOSOQUjqibP1vLc
        786LRi321Qa4JEqq/y/kaNSieSxMgrinDQ==
X-Google-Smtp-Source: ABdhPJyXSNKpPVDV+6mARxn1QiRP2ZQlUREol3iTnXbRV9QwHSpd3oXC/66Rw55LlAPPaRvtgwc1jg==
X-Received: by 2002:a63:b516:: with SMTP id y22mr16636909pge.140.1606722512822;
        Sun, 29 Nov 2020 23:48:32 -0800 (PST)
Received: from [10.10.15.233] (220-135-135-179.HINET-IP.hinet.net. [220.135.135.179])
        by smtp.gmail.com with ESMTPSA id s21sm14704699pgk.52.2020.11.29.23.48.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Nov 2020 23:48:32 -0800 (PST)
Subject: Re: [PATCH v5] hwmon: Add driver for STMicroelectronics PM6764
 Voltage Regulator
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        alan@redhat.com
References: <f8766ea1-b4ee-f298-a5a4-dc83f9a54617@gmail.com>
 <20201127161051.GA9881@roeck-us.net>
From:   Charles <hsu.yungteng@gmail.com>
Message-ID: <5c78a15e-4c4a-992c-ff5b-7bb709057871@gmail.com>
Date:   Mon, 30 Nov 2020 15:46:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201127161051.GA9881@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2020 上午12:10, Guenter Roeck wrote:
> On Fri, Nov 27, 2020 at 09:59:01AM +0800, Charles wrote:
>> Add the pmbus driver for the STMicroelectronics pm6764 voltage regulator.
>>
>> the output voltage use the MFR_READ_VOUT 0xD4
>> vout value returned is linear11
>>
>> Signed-off-by: Charles Hsu <hsu.yungteng@gmail.com>
> This patch (again) didn't make it to any of the mailing lists.
> Please try to find out why this is the case. I usually pick up
> patches from https://patchwork.kernel.org/project/linux-hwmon/list/,
> and may easily miss a patch if I can't find it there.
>
>> ---
>>
>> v5:
>>   - Add MAINTAINERS
>>   - Add a reference into trivial-devices.yaml
>> v4:
>>   - Add pm6764tr to Documentation/hwmon/index.rst.
>> v3:
>>   - Add Documentation(Documentation/hwmon/pm6764tr.rst).
>>   - Fix include order.
>> v2:
>>   - Fix formatting.
>>   - Remove pmbus_do_remove.
>>   - Change from .probe to .probe_new.
>> v1:
>>   - Initial patchset.
>>
>> ---
>>
>>   .../devicetree/bindings/trivial-devices.yaml  |  2 +
>>   Documentation/hwmon/index.rst                 |  1 +
>>   Documentation/hwmon/pm6764tr.rst              | 33 ++++++++
>>   MAINTAINERS                                   |  7 ++
>>   drivers/hwmon/pmbus/Kconfig                   |  9 +++
>>   drivers/hwmon/pmbus/Makefile                  |  1 +
>>   drivers/hwmon/pmbus/pm6764tr.c                | 76 +++++++++++++++++++
>>   7 files changed, 129 insertions(+)
>>   create mode 100644 Documentation/hwmon/pm6764tr.rst
>>   create mode 100644 drivers/hwmon/pmbus/pm6764tr.c
>>
>> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
>> index ab623ba930d5..cdd7bdb6abbb 100644
>> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
>> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
>> @@ -348,6 +348,8 @@ properties:
>>             - socionext,synquacer-tpm-mmio
>>               # i2c serial eeprom  (24cxx)
>>             - st,24c256
>> +            # SMBus/I2C Voltage Regulator
>> +          - st,pm6764tr
>>               # Ambient Light Sensor with SMBUS/Two Wire Serial Interface
>>             - taos,tsl2550
>>               # 8-Channels, 12-bit ADC
> This, like all devicetre changes, needs to be a separate patch.
> Also, please make sure to copy dt maintainers and the dt mailing list
> when you send that patch.


Thank you for your suggestions.

I will send that patch as soon as possible.


>> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
>> index b797db738225..1bbd05e41de4 100644
>> --- a/Documentation/hwmon/index.rst
>> +++ b/Documentation/hwmon/index.rst
>> @@ -144,6 +144,7 @@ Hardware Monitoring Kernel Drivers
>>      pc87360
>>      pc87427
>>      pcf8591
>> +   pm6764tr
>>      pmbus
>>      powr1220
>>      pxe1610
>> diff --git a/Documentation/hwmon/pm6764tr.rst b/Documentation/hwmon/pm6764tr.rst
>> new file mode 100644
>> index 000000000000..5e8092e39297
>> --- /dev/null
>> +++ b/Documentation/hwmon/pm6764tr.rst
>> @@ -0,0 +1,33 @@
>> +.. SPDX-License-Identifier: GPL-2.0-only
>> +
>> +Kernel driver pm6764tr
>> +======================
>> +
>> +Supported chips:
>> +
>> +  * ST PM6764TR
>> +
>> +    Prefix: 'pm6764tr'
>> +
>> +    Addresses scanned: -
>> +
>> +    Datasheet: http://www.st.com/resource/en/data_brief/pm6764.pdf
>> +
>> +Authors:
>> +	<hsu.yungteng@gmail.com>
>> +
>> +Description:
>> +------------
>> +
>> +This driver supports the STMicroelectronics PM6764TR chip. The PM6764TR is a high
>> +performance digital controller designed to power Intel’s VR12.5 processors and memories.
>> +
> Unrelated side note: I understand this means that you are forced to keep the
> datasheet under wraps, which in turn means I can not suggest functionality
> improvements since I don't have access to it. If the chip happens to support
> per-rail telemetry, you might want to consider adding support for that in a
> follow-up patch.
>
>> +The device utilizes digital technology to implement all control and power management
>> +functions to provide maximum flexibility and performance. The NVM is embedded to store
>> +custom configurations. The PM6764TR device features up to 4-phase programmable operation.
>> +
>> +The PM6764TR supports power state transitions featuring VFDE, and programmable DPM
>> +maintaining the best efficiency over all loading conditions without compromising transient
>> +response. The device assures fast and independent protectionagainstload overcurrent,
> "protectionagainstload" -> "protection against load"
>
>> +under/overvoltage and feedback disconnections.
>> +
> Drop empty line at end.
>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 94ac10a153c7..a3fea132c4ed 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -13904,6 +13904,13 @@ M:	Logan Gunthorpe <logang@deltatee.com>
>>   S:	Maintained
>>   F:	drivers/dma/plx_dma.c
> Add empty line.


There is an empty line here,

Should I add one more empty line?


>> +PM6764TR DRIVER
>> +M:	Charles Hsu	<hsu.yungteng@gmail.com>
>> +L:	linux-hwmon@vger.kernel.org
>> +S:	Maintained
>> +F:	Documentation/hwmon/pm6764tr.rst
>> +F:	drivers/hwmon/pmbus/pm6764tr.c
>> +
>>   PM-GRAPH UTILITY
>>   M:	"Todd E Brandt" <todd.e.brandt@linux.intel.com>
>>   L:	linux-pm@vger.kernel.org
>> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
>> index a25faf69fce3..9c846facce9f 100644
>> --- a/drivers/hwmon/pmbus/Kconfig
>> +++ b/drivers/hwmon/pmbus/Kconfig
>> @@ -220,6 +220,15 @@ config SENSORS_MP2975
>>   	  This driver can also be built as a module. If so, the module will
>>   	  be called mp2975.
> Add empty line.


Same as above.


>> +config SENSORS_PM6764TR
>> +	tristate "ST PM6764TR"
>> +	help
>> +	  If you say yes here you get hardware monitoring support for ST
>> +	  PM6764TR.
>> +
>> +	  This driver can also be built as a module. If so, the module will
>> +	  be called pm6764tr.
>> +
>>   config SENSORS_PXE1610
>>   	tristate "Infineon PXE1610"
>>   	help
>> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
>> index 4c97ad0bd791..31ebdef5d4a6 100644
>> --- a/drivers/hwmon/pmbus/Makefile
>> +++ b/drivers/hwmon/pmbus/Makefile
>> @@ -25,6 +25,7 @@ obj-$(CONFIG_SENSORS_MAX31785)	+= max31785.o
>>   obj-$(CONFIG_SENSORS_MAX34440)	+= max34440.o
>>   obj-$(CONFIG_SENSORS_MAX8688)	+= max8688.o
>>   obj-$(CONFIG_SENSORS_MP2975)	+= mp2975.o
>> +obj-$(CONFIG_SENSORS_PM6764TR)	+= pm6764tr.o
>>   obj-$(CONFIG_SENSORS_PXE1610)	+= pxe1610.o
>>   obj-$(CONFIG_SENSORS_TPS40422)	+= tps40422.o
>>   obj-$(CONFIG_SENSORS_TPS53679)	+= tps53679.o
>> diff --git a/drivers/hwmon/pmbus/pm6764tr.c b/drivers/hwmon/pmbus/pm6764tr.c
>> new file mode 100644
>> index 000000000000..70747c21c66e
>> --- /dev/null
>> +++ b/drivers/hwmon/pmbus/pm6764tr.c
>> @@ -0,0 +1,76 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Hardware monitoring driver for STMicroelectronics digital controller PM6764TR
>> + */
>> +
>> +#include <linux/err.h>
>> +#include <linux/i2c.h>
>> +#include <linux/init.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/pmbus.h>
>> +#include "pmbus.h"
>> +
>> +#define PM6764TR_PMBUS_READ_VOUT	0xD4
>> +
>> +static int pm6764tr_read_word_data(struct i2c_client *client, int page, int reg)
>> +{
>> +	int ret;
>> +
>> +	switch (reg) {
>> +	case PMBUS_VIRT_READ_VMON:
>> +		ret = pmbus_read_word_data(client, page, PM6764TR_PMBUS_READ_VOUT);
>> +		break;
>> +	default:
>> +		ret = -ENODATA;
>> +		break;
>> +	}
>> +	return ret;
>> +}
>> +
>> +static struct pmbus_driver_info pm6764tr_info = {
>> +	.pages = 1,
>> +	.format[PSC_VOLTAGE_IN] = linear,
>> +	.format[PSC_VOLTAGE_OUT] = vid,
>> +	.format[PSC_TEMPERATURE] = linear,
>> +	.format[PSC_CURRENT_OUT] = linear,
>> +	.format[PSC_POWER] = linear,
>> +	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN |  PMBUS_HAVE_PIN |
>> +	    PMBUS_HAVE_IOUT | PMBUS_HAVE_POUT | PMBUS_HAVE_VMON |
>> +		PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_STATUS_VOUT |
>> +		PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
>> +	.read_word_data = pm6764tr_read_word_data,
>> +};
>> +
>> +static int pm6764tr_probe(struct i2c_client *client,
>> +			  const struct i2c_device_id *id)
>> +{
>> +	return pmbus_do_probe(client, id, &pm6764tr_info);
>> +}
>> +
>> +static const struct i2c_device_id pm6764tr_id[] = {
>> +	{"pm6764tr", 0},
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(i2c, pm6764tr_id);
>> +
>> +static const struct of_device_id pm6764tr_of_match[] = {
>> +	{.compatible = "st,pm6764tr"},
>> +	{}
>> +};
>> +
>> +/* This is the driver that will be inserted */
>> +static struct i2c_driver pm6764tr_driver = {
>> +	.driver = {
>> +		   .name = "pm6764tr",
>> +		   .of_match_table = of_match_ptr(pm6764tr_of_match),
>> +		   },
>> +	.probe_new = pm6764tr_probe,
>> +	.id_table = pm6764tr_id,
>> +};
>> +
>> +module_i2c_driver(pm6764tr_driver);
>> +
>> +MODULE_AUTHOR("Charles Hsu");
>> +MODULE_DESCRIPTION("PMBus driver for  ST PM6764TR");
>> +MODULE_LICENSE("GPL");
>> -- 
>> 2.25.1
>>

