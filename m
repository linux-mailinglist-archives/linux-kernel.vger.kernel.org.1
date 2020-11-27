Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B472C692A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 17:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731285AbgK0QKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 11:10:55 -0500
Received: from gproxy3-pub.mail.unifiedlayer.com ([69.89.30.42]:35401 "EHLO
        gproxy3-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726889AbgK0QKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 11:10:55 -0500
Received: from cmgw15.unifiedlayer.com (unknown [10.9.0.15])
        by gproxy3.mail.unifiedlayer.com (Postfix) with ESMTP id 748D64016E
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:10:53 -0700 (MST)
Received: from bh-25.webhostbox.net ([208.91.199.152])
        by cmsmtp with ESMTP
        id igKiksnjch41ligKjkwKQ2; Fri, 27 Nov 2020 09:10:53 -0700
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=LcMSFAXi c=1 sm=1 tr=0
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10:nop_charset_1
 a=nNwsprhYR40A:10:nop_rcvd_month_year
 a=evQFzbml-YQA:10:endurance_base64_authed_username_1 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=8b9GpE9nAAAA:8 a=gXLdhW2jAAAA:8 a=QyXUC8HyAAAA:8
 a=a_SMFhY1PeCmZ4XiELsA:9 a=QEXdDO2ut3YA:10:nop_charset_2
 a=AjGcO6oz07-iQ99wixmX:22 a=T3LWEMljR5ZiDmsYVIUa:22 a=Dn9eIPSr_RzuO0KTJioD:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QJGvqtSrdAvrBQvUHBYdnxNztPyZAk6Gn39o5VoA3mY=; b=BCNdXvzM904tvkdHPRepKe+nFP
        +vlxScFNpUu7p4C6CJ0q9LzSQdxN94BOlzMg3TepDLxRTyE6OoH+R/O3ppeix3VtnQnYSUkrWzpOn
        hP07heEZv+8cffAjW7fd2BmIMhcC32bzR/lD66XB0lgiUbF2No5BC7msh2mpMhcSphWcbW2zj8FMf
        hDuVFnR8PaxqHc/ZNhq6Z2oSREZR/OBuypu1AGggl1M3pJ19D7nR3dfhCcslUOjjH7u0kt9qtUqWv
        rRskB9qS1w+BzMZjKovGIeH764cUl7fweIufx6RoVDQJ8vuwEuXeRt3RdqvhucTui+6VEm2mMnYgs
        C8QUwZdg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:43460 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.93)
        (envelope-from <linux@roeck-us.net>)
        id 1kigKi-002ml1-HK; Fri, 27 Nov 2020 16:10:52 +0000
Date:   Fri, 27 Nov 2020 08:10:51 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Charles <hsu.yungteng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        alan@redhat.com
Subject: Re: [PATCH v5] hwmon: Add driver for STMicroelectronics PM6764
 Voltage Regulator
Message-ID: <20201127161051.GA9881@roeck-us.net>
References: <f8766ea1-b4ee-f298-a5a4-dc83f9a54617@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f8766ea1-b4ee-f298-a5a4-dc83f9a54617@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1kigKi-002ml1-HK
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:43460
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 3
X-Org:  HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 27, 2020 at 09:59:01AM +0800, Charles wrote:
> Add the pmbus driver for the STMicroelectronics pm6764 voltage regulator.
> 
> the output voltage use the MFR_READ_VOUT 0xD4
> vout value returned is linear11
> 
> Signed-off-by: Charles Hsu <hsu.yungteng@gmail.com>

This patch (again) didn't make it to any of the mailing lists.
Please try to find out why this is the case. I usually pick up
patches from https://patchwork.kernel.org/project/linux-hwmon/list/,
and may easily miss a patch if I can't find it there.

> ---
> 
> v5:
>  - Add MAINTAINERS
>  - Add a reference into trivial-devices.yaml
> v4:
>  - Add pm6764tr to Documentation/hwmon/index.rst.
> v3:
>  - Add Documentation(Documentation/hwmon/pm6764tr.rst).
>  - Fix include order.
> v2:
>  - Fix formatting.
>  - Remove pmbus_do_remove.
>  - Change from .probe to .probe_new.
> v1:
>  - Initial patchset.
> 
> ---
> 
>  .../devicetree/bindings/trivial-devices.yaml  |  2 +
>  Documentation/hwmon/index.rst                 |  1 +
>  Documentation/hwmon/pm6764tr.rst              | 33 ++++++++
>  MAINTAINERS                                   |  7 ++
>  drivers/hwmon/pmbus/Kconfig                   |  9 +++
>  drivers/hwmon/pmbus/Makefile                  |  1 +
>  drivers/hwmon/pmbus/pm6764tr.c                | 76 +++++++++++++++++++
>  7 files changed, 129 insertions(+)
>  create mode 100644 Documentation/hwmon/pm6764tr.rst
>  create mode 100644 drivers/hwmon/pmbus/pm6764tr.c
> 
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index ab623ba930d5..cdd7bdb6abbb 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -348,6 +348,8 @@ properties:
>            - socionext,synquacer-tpm-mmio
>              # i2c serial eeprom  (24cxx)
>            - st,24c256
> +            # SMBus/I2C Voltage Regulator
> +          - st,pm6764tr
>              # Ambient Light Sensor with SMBUS/Two Wire Serial Interface
>            - taos,tsl2550
>              # 8-Channels, 12-bit ADC

This, like all devicetre changes, needs to be a separate patch.
Also, please make sure to copy dt maintainers and the dt mailing list
when you send that patch.

> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index b797db738225..1bbd05e41de4 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -144,6 +144,7 @@ Hardware Monitoring Kernel Drivers
>     pc87360
>     pc87427
>     pcf8591
> +   pm6764tr
>     pmbus
>     powr1220
>     pxe1610
> diff --git a/Documentation/hwmon/pm6764tr.rst b/Documentation/hwmon/pm6764tr.rst
> new file mode 100644
> index 000000000000..5e8092e39297
> --- /dev/null
> +++ b/Documentation/hwmon/pm6764tr.rst
> @@ -0,0 +1,33 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +Kernel driver pm6764tr
> +======================
> +
> +Supported chips:
> +
> +  * ST PM6764TR
> +
> +    Prefix: 'pm6764tr'
> +
> +    Addresses scanned: -
> +
> +    Datasheet: http://www.st.com/resource/en/data_brief/pm6764.pdf
> +
> +Authors:
> +	<hsu.yungteng@gmail.com>
> +
> +Description:
> +------------
> +
> +This driver supports the STMicroelectronics PM6764TR chip. The PM6764TR is a high
> +performance digital controller designed to power Intel’s VR12.5 processors and memories.
> +

Unrelated side note: I understand this means that you are forced to keep the
datasheet under wraps, which in turn means I can not suggest functionality
improvements since I don't have access to it. If the chip happens to support
per-rail telemetry, you might want to consider adding support for that in a
follow-up patch.

> +The device utilizes digital technology to implement all control and power management
> +functions to provide maximum flexibility and performance. The NVM is embedded to store
> +custom configurations. The PM6764TR device features up to 4-phase programmable operation.
> +
> +The PM6764TR supports power state transitions featuring VFDE, and programmable DPM
> +maintaining the best efficiency over all loading conditions without compromising transient
> +response. The device assures fast and independent protectionagainstload overcurrent,

"protectionagainstload" -> "protection against load"

> +under/overvoltage and feedback disconnections.
> +

Drop empty line at end.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 94ac10a153c7..a3fea132c4ed 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13904,6 +13904,13 @@ M:	Logan Gunthorpe <logang@deltatee.com>
>  S:	Maintained
>  F:	drivers/dma/plx_dma.c

Add empty line.

> +PM6764TR DRIVER
> +M:	Charles Hsu	<hsu.yungteng@gmail.com>
> +L:	linux-hwmon@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/hwmon/pm6764tr.rst
> +F:	drivers/hwmon/pmbus/pm6764tr.c
> +
>  PM-GRAPH UTILITY
>  M:	"Todd E Brandt" <todd.e.brandt@linux.intel.com>
>  L:	linux-pm@vger.kernel.org
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index a25faf69fce3..9c846facce9f 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -220,6 +220,15 @@ config SENSORS_MP2975
>  	  This driver can also be built as a module. If so, the module will
>  	  be called mp2975.

Add empty line.

> +config SENSORS_PM6764TR
> +	tristate "ST PM6764TR"
> +	help
> +	  If you say yes here you get hardware monitoring support for ST
> +	  PM6764TR.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called pm6764tr.
> +
>  config SENSORS_PXE1610
>  	tristate "Infineon PXE1610"
>  	help
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index 4c97ad0bd791..31ebdef5d4a6 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -25,6 +25,7 @@ obj-$(CONFIG_SENSORS_MAX31785)	+= max31785.o
>  obj-$(CONFIG_SENSORS_MAX34440)	+= max34440.o
>  obj-$(CONFIG_SENSORS_MAX8688)	+= max8688.o
>  obj-$(CONFIG_SENSORS_MP2975)	+= mp2975.o
> +obj-$(CONFIG_SENSORS_PM6764TR)	+= pm6764tr.o
>  obj-$(CONFIG_SENSORS_PXE1610)	+= pxe1610.o
>  obj-$(CONFIG_SENSORS_TPS40422)	+= tps40422.o
>  obj-$(CONFIG_SENSORS_TPS53679)	+= tps53679.o
> diff --git a/drivers/hwmon/pmbus/pm6764tr.c b/drivers/hwmon/pmbus/pm6764tr.c
> new file mode 100644
> index 000000000000..70747c21c66e
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/pm6764tr.c
> @@ -0,0 +1,76 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Hardware monitoring driver for STMicroelectronics digital controller PM6764TR
> + */
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/pmbus.h>
> +#include "pmbus.h"
> +
> +#define PM6764TR_PMBUS_READ_VOUT	0xD4
> +
> +static int pm6764tr_read_word_data(struct i2c_client *client, int page, int reg)
> +{
> +	int ret;
> +
> +	switch (reg) {
> +	case PMBUS_VIRT_READ_VMON:
> +		ret = pmbus_read_word_data(client, page, PM6764TR_PMBUS_READ_VOUT);
> +		break;
> +	default:
> +		ret = -ENODATA;
> +		break;
> +	}
> +	return ret;
> +}
> +
> +static struct pmbus_driver_info pm6764tr_info = {
> +	.pages = 1,
> +	.format[PSC_VOLTAGE_IN] = linear,
> +	.format[PSC_VOLTAGE_OUT] = vid,
> +	.format[PSC_TEMPERATURE] = linear,
> +	.format[PSC_CURRENT_OUT] = linear,
> +	.format[PSC_POWER] = linear,
> +	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN |  PMBUS_HAVE_PIN |
> +	    PMBUS_HAVE_IOUT | PMBUS_HAVE_POUT | PMBUS_HAVE_VMON |
> +		PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_STATUS_VOUT |
> +		PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
> +	.read_word_data = pm6764tr_read_word_data,
> +};
> +
> +static int pm6764tr_probe(struct i2c_client *client,
> +			  const struct i2c_device_id *id)
> +{
> +	return pmbus_do_probe(client, id, &pm6764tr_info);
> +}
> +
> +static const struct i2c_device_id pm6764tr_id[] = {
> +	{"pm6764tr", 0},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, pm6764tr_id);
> +
> +static const struct of_device_id pm6764tr_of_match[] = {
> +	{.compatible = "st,pm6764tr"},
> +	{}
> +};
> +
> +/* This is the driver that will be inserted */
> +static struct i2c_driver pm6764tr_driver = {
> +	.driver = {
> +		   .name = "pm6764tr",
> +		   .of_match_table = of_match_ptr(pm6764tr_of_match),
> +		   },
> +	.probe_new = pm6764tr_probe,
> +	.id_table = pm6764tr_id,
> +};
> +
> +module_i2c_driver(pm6764tr_driver);
> +
> +MODULE_AUTHOR("Charles Hsu");
> +MODULE_DESCRIPTION("PMBus driver for  ST PM6764TR");
> +MODULE_LICENSE("GPL");
> -- 
> 2.25.1
> 
