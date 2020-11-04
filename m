Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13BA42A667E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 15:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbgKDOhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 09:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbgKDOhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 09:37:19 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F70C0613D3;
        Wed,  4 Nov 2020 06:37:19 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id g19so10031335otp.13;
        Wed, 04 Nov 2020 06:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=NFjmtsfmnj0C9Thp8xS2Sl3MiUrCZjVNBwOhOhlohCU=;
        b=I1EqiRwCJ3zLn2W2+3IAL3Ame+dCBJzvZK4h87AiYl2cxEiad0BWbbglOLlPK5uQVa
         7XNm3+Rd+s7/urVairePBJ8TXM5Dj7HMUq2Iw9WtGDcJvDQWHmSMbGQadi0d+TIUD1Me
         ezql4snXWiMgmdtVBgFZ0idWdFSCuAZVMCU5UKZ+aT3KluvxOE3Ck1DuKAU9zv9eA30r
         dRLLV7EQkp81Wdhxr3Mt71CKrXDxMflounRuaYEcwi4c45mhN46H02PG5tGIflnN5wQ+
         1kNq3DYzKrLnB1v7UEFAn9XX8m3Y0oDQkMFH/NLzJFjSwBATC71sLil7abK9N/i84AAE
         dC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=NFjmtsfmnj0C9Thp8xS2Sl3MiUrCZjVNBwOhOhlohCU=;
        b=Mz/ox60FOwADPrXWo+372fydcqZyFOUct8hcC5uQsgX3R9sGfsCjoUip/sA/X2gmYC
         3AAfhjANduVUwVdZBTAGdt7pB1tGOp8/nFMVQuKyC0gMA3XrQKWVKvezjVbEjGkhE09w
         jiNrIaRXHQhje+Wp+fNV4J8NUqdx/hi/4peDy2XffoUdHUkWN9GS25JQ7J4t1DWVtu5X
         QL3Ux9Esrc0knC6wqiIKoPVnZf8F2QLSbLa3dwhg9fwKeQSBjQq4uaSwsWZFUYJNx2jw
         igSxtLUcIs0vX/3BEM81eRCyPv2vXQcf+cmO7mevz3+HJfMpqAty2ZyavfyPWftgDJk+
         M7EA==
X-Gm-Message-State: AOAM53126Ehgx2BAN3TyCN+ridYontP9ui98olzBxcWBq9Bjwpg2XFoN
        jTdQ4IeOylsVvn+qlCrKd6k=
X-Google-Smtp-Source: ABdhPJxeosxE3+mqblez0F2z0oeNuHQtstF8ju49NM3hknLO4pkALghgsEcjBc//Dza+bnB0Z4kTyw==
X-Received: by 2002:a9d:6c4b:: with SMTP id g11mr18508267otq.265.1604500639031;
        Wed, 04 Nov 2020 06:37:19 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f124sm491231oia.27.2020.11.04.06.37.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Nov 2020 06:37:18 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 4 Nov 2020 06:37:17 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Yungteng Hsu <hsu.yungteng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        alan@redhat.com
Subject: Re: [PATCH] hwmon: (pmbus) Add driver for STMicroelectronics PM6764
 Voltage Regulator
Message-ID: <20201104143717.GA92239@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 03:09:23PM +0800, Yungteng Hsu wrote:
> Add the pmbus driver for the STMicroelectronics pm6764 voltage regulator.
> 
> the output voltage use the MFR_READ_VOUT 0xD4
> vout value returned is linear11
> 
> Signed-off-by: Charles Hsu <hsu.yungteng@gmail.com>

Please use standard Linux kernel code formatting rules.
Run checkpatch --strict on the patch and make sure it does not report
any problems.

total: 1 errors, 39 warnings, 3 checks, 96 lines checked

is a bit much for a 74-line patch.

> ---
>  drivers/hwmon/pmbus/Kconfig    |  8 ++++
>  drivers/hwmon/pmbus/Makefile   |  1 +
>  drivers/hwmon/pmbus/pm6764tr.c | 74 ++++++++++++++++++++++++++++++++++
>  3 files changed, 83 insertions(+)
>  create mode 100644 drivers/hwmon/pmbus/pm6764tr.c
> 
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index a25faf69fce3..2b487c401a4e 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -220,6 +220,14 @@ config SENSORS_MP2975
>    This driver can also be built as a module. If so, the module will
>    be called mp2975.
> 
> +config SENSORS_PM6764TR
> + tristate "PM6764TR"
> + help
> +  If you say yes here you get hardware monitoring support for PM6764TR.
> +
> +  This driver can also be built as a module. If so, the module will
> +  be called pm6764tr.
> +
>  config SENSORS_PXE1610
>   tristate "Infineon PXE1610"
>   help
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index 4c97ad0bd791..31ebdef5d4a6 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -25,6 +25,7 @@ obj-$(CONFIG_SENSORS_MAX31785) += max31785.o
>  obj-$(CONFIG_SENSORS_MAX34440) += max34440.o
>  obj-$(CONFIG_SENSORS_MAX8688) += max8688.o
>  obj-$(CONFIG_SENSORS_MP2975) += mp2975.o
> +obj-$(CONFIG_SENSORS_PM6764TR) += pm6764tr.o
>  obj-$(CONFIG_SENSORS_PXE1610) += pxe1610.o
>  obj-$(CONFIG_SENSORS_TPS40422) += tps40422.o
>  obj-$(CONFIG_SENSORS_TPS53679) += tps53679.o
> diff --git a/drivers/hwmon/pmbus/pm6764tr.c b/drivers/hwmon/pmbus/pm6764tr.c
> new file mode 100644
> index 000000000000..b125a1cbfea5
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/pm6764tr.c
> @@ -0,0 +1,74 @@
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/err.h>
> +#include <linux/slab.h>
> +#include <linux/mutex.h>
> +#include <linux/i2c.h>
> +#include <linux/pmbus.h>

Alphabetic include file order, please.

> +#include "pmbus.h"
> +
> +#define PM6764TR_PMBUS_READ_VOUT 0xD4

tab after PM6764TR_PMBUS_READ_VOUT, please.

I see you don't use any tabs in the patch. Please do.

> +
> +static int pm6764tr_read_word_data(struct i2c_client *client, int
> page, int reg)

Corrupted ?

That makes me wonder if the patch was corrupted by your e-mail system,
and if that system replaced tabs with spaces. Is that possible ?

> +{
> + int ret;
> +
> + switch (reg) {
> + case PMBUS_VIRT_READ_VMON:
> + ret = pmbus_read_word_data(client, page,
> +   PM6764TR_PMBUS_READ_VOUT);

That can be one line (line limit is now 100 columns).

> + break;
> + default:
> + ret = -ENODATA;
> + break;
> + }
> + return ret;
> +}
> +
> +static struct pmbus_driver_info pm6764tr_info = {
> + .pages = 1,
> + .format[PSC_VOLTAGE_IN] = linear,
> + .format[PSC_VOLTAGE_OUT] = vid,
> + .format[PSC_TEMPERATURE] = linear,
> + .format[PSC_CURRENT_OUT] = linear,
> + .format[PSC_POWER] = linear,
> + .func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN |  PMBUS_HAVE_PIN |
> +    PMBUS_HAVE_IOUT | PMBUS_HAVE_POUT | PMBUS_HAVE_VMON |
> + PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_STATUS_VOUT |
> + PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
> +    .read_word_data = pm6764tr_read_word_data,
> +};
> +
> +static int pm6764tr_probe(struct i2c_client *client,
> +  const struct i2c_device_id *id)

Please use the new style probe function (probe_new).

> +{
> + return pmbus_do_probe(client, id, &pm6764tr_info);
> +}
> +
> +static const struct i2c_device_id pm6764tr_id[] = {
> + {"pm6764tr", 0},
> + {}
> +};
> +MODULE_DEVICE_TABLE(i2c, pm6764tr_id);
> +
> +static const struct of_device_id pm6764tr_of_match[] = {
> + {.compatible = "pm6764tr"},
> + {}
> +};
> +/* This is the driver that will be inserted */
> +static struct i2c_driver pm6764tr_driver = {
> + .driver = {
> +   .name = "pm6764tr",
> +   .of_match_table = of_match_ptr(pm6764tr_of_match),
> +   },
> + .probe = pm6764tr_probe,
> + .remove = pmbus_do_remove,

pmbus_do_remove no longer exists.

> + .id_table = pm6764tr_id,
> +};
> +
> +module_i2c_driver(pm6764tr_driver);
> +
> +MODULE_AUTHOR("Charles Hsu");
> +MODULE_DESCRIPTION("PMBus driver for  ST PM6764TR");
> +MODULE_LICENSE("GPL");
> --
> 2.25.1
