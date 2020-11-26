Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE40E2C4C50
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 01:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbgKZAwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 19:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgKZAwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 19:52:54 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E01BC0613D4;
        Wed, 25 Nov 2020 16:52:52 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id y7so55470pfq.11;
        Wed, 25 Nov 2020 16:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=gJSR8VY56+ZbIzPwd/t5uTP9e1n8H4nOv7O6etXlWEk=;
        b=IHCr/GuO5EDeECcNd4w/RVtrid6ZaoOVJAcc78ukskYIBP6JnZGAlzTsz6cO5bWA64
         LhkSqBpZWbIdYlWdY2n9c5r0x+EWRPkgN9FcTMo0FjzdDAK4QusK9hHeQt25VRjzw8TC
         P7hXTWmoLo4zBgY+57epDoZ+beGvsj3AgDfNGRgT8uGq4FlqH7U9kOEL9hf70T6tCZtU
         NgwHjf7XuUcC27YEHPsL9Szl6P7u/A+7c9ocm5Fjm90Pq9k5mRmcZeMAO4vsVbywHto3
         +c+GeF33Nf40pbfseMQNRrt6/e8f/0NZ0bLoyahiSxIcIIQ4sW+NPx/FGvBaAWSogJGv
         fYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=gJSR8VY56+ZbIzPwd/t5uTP9e1n8H4nOv7O6etXlWEk=;
        b=gt065O/H4ZjQVHWJxd3dVAu4wvVT48prIil53GOYBoTTLazIA1WeaM/MS0wTJf9Yhf
         IHcACIEs3KlvbGZlZLiqAc5D4qrHfUG4/I69KBrJYktDLXDojIZ/vX9PX19XxO13IlRq
         M/3y9tQ4V7HNPIZQKT49nNp/Y57OVO/55+yNpzsa2YfK0rE3C9lLPHw0Y6i/mSdsq0Qr
         umgefYoXAo/9bz04kKTLUbcusaho/D5FeqtELlXvhH8pKwpklb3zwuyPNmsfeUFqVcMq
         DH9Bkg3Cf16G3nm5HPAxRX17PJRTVJJHg9Hb9QqpZcpNiYC3eM/n/7ZnYNo5HNHMLr9i
         OqeA==
X-Gm-Message-State: AOAM530ebbaeDMoTRPez18f7yt6an92+/wpKIRaJI6aXwu4MVFWULrBL
        ZK7/gWdovfujtLtxbiLhE3I=
X-Google-Smtp-Source: ABdhPJyZWK71QlA0x8DZBYGXc3spceuOjsO6xq8kETzdrL9DUcaIQzkqjeZEXZ/37X4o6qZmoTVOnA==
X-Received: by 2002:a05:6a00:1593:b029:198:195:4d93 with SMTP id u19-20020a056a001593b029019801954d93mr548590pfk.32.1606351972029;
        Wed, 25 Nov 2020 16:52:52 -0800 (PST)
Received: from [10.10.15.233] (220-135-135-179.HINET-IP.hinet.net. [220.135.135.179])
        by smtp.gmail.com with ESMTPSA id 199sm3039093pfb.219.2020.11.25.16.52.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2020 16:52:51 -0800 (PST)
Subject: Re: [PATCH v4] hwmon: Add driver for STMicroelectronics PM6764
 Voltage Regulator
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        alan@redhat.com
References: <35937351-f5ba-f019-c173-17f42c36da54@gmail.com>
 <20201122153618.GA21246@roeck-us.net>
From:   Charles <hsu.yungteng@gmail.com>
Message-ID: <a2d8c14a-de43-ccc8-56f0-9286117d1497@gmail.com>
Date:   Thu, 26 Nov 2020 08:50:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201122153618.GA21246@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2020 下午11:36, Guenter Roeck wrote:
> On Wed, Nov 11, 2020 at 03:10:08PM +0800, Charles wrote:
>> Add the pmbus driver for the STMicroelectronics pm6764 voltage regulator.
>>
>> the output voltage use the MFR_READ_VOUT 0xD4
>> vout value returned is linear11
>>
>> Signed-off-by: Charles Hsu <hsu.yungteng@gmail.com>
> Please fix all checkpatch errors and warnings before resubmitting,
> and make sure that your e-mail agent does not corrupt the patch.
>
> Guenter
>

There is still a warning can't fix.

Device tree bindings should be their own patch, right?

I'm not sure which patch should I submit first.

WARNING: DT compatible string "pm6764tr" appears un-documented -- check 
./Documentation/devicetree/bindings/
#189: FILE: drivers/hwmon/pmbus/pm6764tr.c:60:

+    {.compatible = "pm6764tr"},


>> ---
>>
>> v4:
>>    - Add pm6764tr to Documentation/hwmon/index.rst.
>> v3:
>>    - Add Documentation(Documentation/hwmon/pm6764tr.rst).
>>    - Fix include order.
>> v2:
>>    - Fix formatting.
>>    - Remove pmbus_do_remove.
>>    - Change from .probe to .probe_new.
>> v1:
>>    - Initial patchset.
>> ---
>>
>>    Documentation/hwmon/index.rst    |  1 +
>>    Documentation/hwmon/pm6764tr.rst | 33 ++++++++++++++
>>    drivers/hwmon/pmbus/Kconfig      |  9 ++++
>>    drivers/hwmon/pmbus/Makefile     |  1 +
>>    drivers/hwmon/pmbus/pm6764tr.c   | 78 ++++++++++++++++++++++++++++++++
>>    5 files changed, 122 insertions(+)
>>    create mode 100644 Documentation/hwmon/pm6764tr.rst
>>    create mode 100644 drivers/hwmon/pmbus/pm6764tr.c
>>
>> +MODULE_DESCRIPTION("PMBus driver for  ST PM6764TR");
>> +MODULE_LICENSE("GPL");
>>
>> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
>> index b797db738225..1bbd05e41de4 100644
>> --- a/Documentation/hwmon/index.rst
>> +++ b/Documentation/hwmon/index.rst
>> @@ -144,6 +144,7 @@ Hardware Monitoring Kernel Drivers
>>       pc87360
>>       pc87427
>>       pcf8591
>> +   pm6764tr
>>       pmbus
>>       powr1220
>>       pxe1610
>> diff --git a/Documentation/hwmon/pm6764tr.rst
>> b/Documentation/hwmon/pm6764tr.rst
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
>> +  * ST PM6764TR
>> +
>> +    Prefix: 'pm6764tr'
>> +
>> +    Addresses scanned: -
>> +
>> +    Datasheet: http://www.st.com/resource/en/data_brief/pm6764.pdf
>> +
>> +Authors:
>> +    <hsu.yungteng@gmail.com>
>> +
>> +Description:
>> +------------
>> +
>> +This driver supports the STMicroelectronics PM6764TR chip. The PM6764TR
>> is a high
>> +performance digital controller designed to power Intel’s VR12.5
>> processors and memories.
>> +
>> +The device utilizes digital technology to implement all control and
>> power management
>> +functions to provide maximum flexibility and performance. The NVM is
>> embedded to store
>> +custom configurations. The PM6764TR device features up to 4-phase
>> programmable operation.
>> +
>> +The PM6764TR supports power state transitions featuring VFDE, and
>> programmable DPM
>> +maintaining the best efficiency over all loading conditions without
>> compromising transient
>> +response. The device assures fast and independent protectionagainstload
>> overcurrent,
>> +under/overvoltage and feedback disconnections.
>> +
>> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
>> index a25faf69fce3..9c846facce9f 100644
>> --- a/drivers/hwmon/pmbus/Kconfig
>> +++ b/drivers/hwmon/pmbus/Kconfig
>> @@ -220,6 +220,15 @@ config SENSORS_MP2975
>>          This driver can also be built as a module. If so, the module will
>>          be called mp2975.
>>
>> +config SENSORS_PM6764TR
>> +    tristate "ST PM6764TR"
>> +    help
>> +      If you say yes here you get hardware monitoring support for ST
>> +      PM6764TR.
>> +
>> +      This driver can also be built as a module. If so, the module will
>> +      be called pm6764tr.
>> +
>>    config SENSORS_PXE1610
>>        tristate "Infineon PXE1610"
>>        help
>> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
>> index 4c97ad0bd791..31ebdef5d4a6 100644
>> --- a/drivers/hwmon/pmbus/Makefile
>> +++ b/drivers/hwmon/pmbus/Makefile
>> @@ -25,6 +25,7 @@ obj-$(CONFIG_SENSORS_MAX31785)    += max31785.o
>>    obj-$(CONFIG_SENSORS_MAX34440)    += max34440.o
>>    obj-$(CONFIG_SENSORS_MAX8688)    += max8688.o
>>    obj-$(CONFIG_SENSORS_MP2975)    += mp2975.o
>> +obj-$(CONFIG_SENSORS_PM6764TR)    += pm6764tr.o
>>    obj-$(CONFIG_SENSORS_PXE1610)    += pxe1610.o
>>    obj-$(CONFIG_SENSORS_TPS40422)    += tps40422.o
>>    obj-$(CONFIG_SENSORS_TPS53679)    += tps53679.o
>> diff --git a/drivers/hwmon/pmbus/pm6764tr.c b/drivers/hwmon/pmbus/pm6764tr.c
>> new file mode 100644
>> index 000000000000..2ab68036bb0c
>> --- /dev/null
>> +++ b/drivers/hwmon/pmbus/pm6764tr.c
>> @@ -0,0 +1,78 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Hardware monitoring driver for STMicroelectronics digital controller
>> PM6764TR
>> + */
>> +
>> +#include <linux/err.h>
>> +#include <linux/i2c.h>
>> +#include <linux/init.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/pmbus.h>
>> +#include <linux/slab.h>
>> +#include "pmbus.h"
>> +
>> +#define PM6764TR_PMBUS_READ_VOUT    0xD4
>> +
>> +static int pm6764tr_read_word_data(struct i2c_client *client, int page,
>> int reg)
>> +{
>> +    int ret;
>> +
>> +    switch (reg) {
>> +    case PMBUS_VIRT_READ_VMON:
>> +        ret = pmbus_read_word_data(client, page, PM6764TR_PMBUS_READ_VOUT);
>> +        break;
>> +    default:
>> +        ret = -ENODATA;
>> +        break;
>> +    }
>> +    return ret;
>> +}
>> +
>> +static struct pmbus_driver_info pm6764tr_info = {
>> +    .pages = 1,
>> +    .format[PSC_VOLTAGE_IN] = linear,
>> +    .format[PSC_VOLTAGE_OUT] = vid,
>> +    .format[PSC_TEMPERATURE] = linear,
>> +    .format[PSC_CURRENT_OUT] = linear,
>> +    .format[PSC_POWER] = linear,
>> +    .func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN |  PMBUS_HAVE_PIN |
>> +        PMBUS_HAVE_IOUT | PMBUS_HAVE_POUT | PMBUS_HAVE_VMON |
>> +        PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_STATUS_VOUT |
>> +        PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
>> +    .read_word_data = pm6764tr_read_word_data,
>> +};
>> +
>> +static int pm6764tr_probe(struct i2c_client *client,
>> +              const struct i2c_device_id *id)
>> +{
>> +    return pmbus_do_probe(client, id, &pm6764tr_info);
>> +}
>> +
>> +static const struct i2c_device_id pm6764tr_id[] = {
>> +    {"pm6764tr", 0},
>> +    {}
>> +};
>> +MODULE_DEVICE_TABLE(i2c, pm6764tr_id);
>> +
>> +static const struct of_device_id pm6764tr_of_match[] = {
>> +    {.compatible = "pm6764tr"},
>> +    {}
>> +};
>> +
>> +/* This is the driver that will be inserted */
>> +static struct i2c_driver pm6764tr_driver = {
>> +    .driver = {
>> +           .name = "pm6764tr",
>> +           .of_match_table = of_match_ptr(pm6764tr_of_match),
>> +           },
>> +    .probe_new = pm6764tr_probe,
>> +    .id_table = pm6764tr_id,
>> +};
>> +
>> +module_i2c_driver(pm6764tr_driver);
>> +
>> +MODULE_AUTHOR("Charles Hsu");


