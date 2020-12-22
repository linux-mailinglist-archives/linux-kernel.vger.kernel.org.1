Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E212E0BE0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 15:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbgLVOcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 09:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbgLVOcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 09:32:50 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74E9C061793
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 06:32:09 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id 11so12009148oty.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 06:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c4M9zSBJFqnNL59k2s99c69IriPcRHDG0JntZaGWAdA=;
        b=el3VWZxwMa0Z6EOwx04gsN/F4sFSxCwdzy6vX1YIyTb+6d5vhfmAR1rVGzBX5lb3AC
         HZbje6eWH1K41/kwawy0YRGfK/i6QR6sE4hWdS3bmvYizZrQDaj67MR2qntUHfghgTgf
         agN8UtxPIqP6YiTGZoFl+uwSTW0IOh4abVXP0FKO7HrIJHhr38iNCctcfWSo/4owbt4l
         DTpXsYo02q8GuK0L4sTJHyKJ2VnlyUPMvXSEz3mxJcg2g5OjDctVEY+xQOuZ8XNa+cMh
         0h5ZdOsdXq1MGVvFwkJiV6Xk4qznaktH8O9ioDQnZc3rHjRL5RPu3GDyVkDY245epd1p
         i0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c4M9zSBJFqnNL59k2s99c69IriPcRHDG0JntZaGWAdA=;
        b=X/OjTHOB2wfd23aq5fRp1Q4LIh2SIWmlD4geOk7VBTVdF1Lte0CzB4rbFarZMJDtKH
         f+tzOHZw6pamI4ohHDCPgkotwLMvaOMzoyt0UqX5nO/IxXvwZYF5fNFJc/s+0T02j2bs
         zqPBGPG4DErIt+fsPL+2HlUqANegQJOHuAB3PtezEWzDAeUZOfNe5HciZxx7HhGBI1Rw
         43CtOt61ADjqnvxylkwnyGkBbZfI5UZPgIt2INsMY3S/qwuJJAY3aiJBscyeCBZF2NoZ
         cQijQg8mlD+cJQNneSk9QNsNPZTt+TR5BjKIc9DK9AnnZxO/yONZtBQms+1HBf8aOon2
         MqbQ==
X-Gm-Message-State: AOAM531+WCrOJaU6iPLkK8J+T5jUUgAwGcCuK0gfDUWrPvkbZVuiavWa
        n/iIulfXdYme19DB2i2Sf+N/wUdjaYsgS0UM3gzdzQ==
X-Google-Smtp-Source: ABdhPJwf1J7p++PZW3MLOd0KQwRu4VluEvLG9SydI3XYUTNsWFJ72MvzqONN14iBekrONzlG7w01vmdJNs93kurNlKI=
X-Received: by 2002:a05:6830:1092:: with SMTP id y18mr15880210oto.243.1608647529026;
 Tue, 22 Dec 2020 06:32:09 -0800 (PST)
MIME-Version: 1.0
References: <20201219191121.85142-1-robert.marko@sartura.hr>
 <20201219191121.85142-2-robert.marko@sartura.hr> <dc019655-aead-847c-3221-15f8e2e629ee@roeck-us.net>
In-Reply-To: <dc019655-aead-847c-3221-15f8e2e629ee@roeck-us.net>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Tue, 22 Dec 2020 15:31:58 +0100
Message-ID: <CA+HBbNGd0ftcpy6vkVqnB8BZaYrrxOuxpononVaLGRaCNoc4_A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] hwmon: add Texas Instruments TPS23861 driver
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luka Perkov <luka.perkov@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 5:26 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 12/19/20 11:11 AM, Robert Marko wrote:
> > Add basic monitoring support as well as port on/off control for Texas
> > Instruments TPS23861 PoE PSE IC.
> >
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > Cc: Luka Perkov <luka.perkov@sartura.hr>
> > ---
> > Changes in v2:
> > * Convert to devm_hwmon_device_register_with_info()
> > * Change license
> >
> >  drivers/hwmon/Kconfig    |  11 +
> >  drivers/hwmon/Makefile   |   1 +
> >  drivers/hwmon/tps23861.c | 538 +++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 550 insertions(+)
> >  create mode 100644 drivers/hwmon/tps23861.c
> >
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index a850e4f0e0bd..3368ecfa7a9c 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -1102,6 +1102,17 @@ config SENSORS_TC654
> >         This driver can also be built as a module. If so, the module
> >         will be called tc654.
> >
> > +config SENSORS_TPS23861
> > +     tristate "Texas Instruments TPS23861 PoE PSE"
> > +     depends on I2C
> > +     select REGMAP_I2C
> > +     help
> > +       If you say yes here you get support for Texas Instruments
> > +       TPS23861 802.3at PoE PSE chips.
> > +
> > +       This driver can also be built as a module. If so, the module
> > +       will be called tps23861.
> > +
> >  config SENSORS_MENF21BMC_HWMON
> >       tristate "MEN 14F021P00 BMC Hardware Monitoring"
> >       depends on MFD_MENF21BMC
> > diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> > index 9db2903b61e5..7493e9d5dc43 100644
> > --- a/drivers/hwmon/Makefile
> > +++ b/drivers/hwmon/Makefile
> > @@ -141,6 +141,7 @@ obj-$(CONFIG_SENSORS_MAX31790)    += max31790.o
> >  obj-$(CONFIG_SENSORS_MC13783_ADC)+= mc13783-adc.o
> >  obj-$(CONFIG_SENSORS_MCP3021)        += mcp3021.o
> >  obj-$(CONFIG_SENSORS_TC654)  += tc654.o
> > +obj-$(CONFIG_SENSORS_TPS23861)       += tps23861.o
> >  obj-$(CONFIG_SENSORS_MLXREG_FAN) += mlxreg-fan.o
> >  obj-$(CONFIG_SENSORS_MENF21BMC_HWMON) += menf21bmc_hwmon.o
> >  obj-$(CONFIG_SENSORS_MR75203)        += mr75203.o
> > diff --git a/drivers/hwmon/tps23861.c b/drivers/hwmon/tps23861.c
> > new file mode 100644
> > index 000000000000..2bb804ccdc8e
> > --- /dev/null
> > +++ b/drivers/hwmon/tps23861.c
> > @@ -0,0 +1,538 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) 2020 Sartura Ltd.
> > + *
> > + * Driver for the TI TPS23861 PoE PSE.
> > + *
> > + * Author: Robert Marko <robert.marko@sartura.hr>
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/delay.h>
> > +#include <linux/hwmon-sysfs.h>
> > +#include <linux/hwmon.h>
> > +#include <linux/i2c.h>
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
> > +#include <linux/regmap.h>
> > +
> > +#define TEMPERATURE                  0x2c
> > +#define INPUT_VOLTAGE_LSB            0x2e
> > +#define INPUT_VOLTAGE_MSB            0x2f
> > +#define PORT_1_CURRENT_LSB           0x30
> > +#define PORT_1_CURRENT_MSB           0x31
> > +#define PORT_1_VOLTAGE_LSB           0x32
> > +#define PORT_1_VOLTAGE_MSB           0x33
> > +#define PORT_2_CURRENT_LSB           0x34
> > +#define PORT_2_CURRENT_MSB           0x35
> > +#define PORT_2_VOLTAGE_LSB           0x36
> > +#define PORT_2_VOLTAGE_MSB           0x37
> > +#define PORT_3_CURRENT_LSB           0x38
> > +#define PORT_3_CURRENT_MSB           0x39
> > +#define PORT_3_VOLTAGE_LSB           0x3a
> > +#define PORT_3_VOLTAGE_MSB           0x3b
> > +#define PORT_4_CURRENT_LSB           0x3c
> > +#define PORT_4_CURRENT_MSB           0x3d
> > +#define PORT_4_VOLTAGE_LSB           0x3e
> > +#define PORT_4_VOLTAGE_MSB           0x3f
> > +#define PORT_N_CURRENT_LSB_OFFSET    0x04
> > +#define PORT_N_VOLTAGE_LSB_OFFSET    0x04
> > +#define VOLTAGE_CURRENT_MASK         GENMASK(13, 0)
> > +#define PORT_1_STATUS                        0x0c
> > +#define PORT_2_STATUS                        0x0d
> > +#define PORT_3_STATUS                        0x0e
> > +#define PORT_4_STATUS                        0x0f
> > +#define PORT_STATUS_CLASS_MASK               GENMASK(7, 4)
> > +#define PORT_STATUS_DETECT_MASK              GENMASK(3, 0)
> > +#define PORT_CLASS_UNKNOWN           0
> > +#define PORT_CLASS_1                 1
> > +#define PORT_CLASS_2                 2
> > +#define PORT_CLASS_3                 3
> > +#define PORT_CLASS_4                 4
> > +#define PORT_CLASS_RESERVED          5
> > +#define PORT_CLASS_0                 6
> > +#define PORT_CLASS_OVERCURRENT               7
> > +#define PORT_CLASS_MISMATCH          8
> > +#define PORT_DETECT_UNKNOWN          0
> > +#define PORT_DETECT_SHORT            1
> > +#define PORT_DETECT_RESERVED         2
> > +#define PORT_DETECT_RESISTANCE_LOW   3
> > +#define PORT_DETECT_RESISTANCE_OK    4
> > +#define PORT_DETECT_RESISTANCE_HIGH  5
> > +#define PORT_DETECT_OPEN_CIRCUIT     6
> > +#define PORT_DETECT_RESERVED_2               7
> > +#define PORT_DETECT_MOSFET_FAULT     8
> > +#define PORT_DETECT_LEGACY           9
> > +/* Measurment beyond clamp voltage */
> > +#define PORT_DETECT_CAPACITANCE_INVALID_BEYOND       10
> > +/* Insufficient voltage delta */
> > +#define PORT_DETECT_CAPACITANCE_INVALID_DELTA        11
> > +#define PORT_DETECT_CAPACITANCE_OUT_OF_RANGE 12
> > +#define POE_PLUS                             0x40
> > +
> > +#define DETECT_CLASS_RESTART         0x18
> > +#define POWER_ENABLE                 0x19
> > +
> > +#define TEMPERATURE_LSB                      652 /* 0.652 degrees Celsius */
> > +#define VOLTAGE_LSB                  3662 /* 3.662 mV */
> > +#define SHUNT_RESISTOR_DEFAULT               255000 /* 255 mOhm */
> > +#define CURRENT_LSB_255                      62260 /* 62.260 uA */
> > +#define CURRENT_LSB_250                      61039 /* 61.039 uA */
> > +
> > +struct tps23861_data {
> > +     struct regmap *regmap;
> > +     u32 shunt_resistor;
> > +};
> > +
> > +static struct regmap_config tps23861_regmap_config = {
> > +     .reg_bits = 8,
> > +     .val_bits = 8,
> > +};
> > +
> > +static int tps23861_read_temp(struct tps23861_data *data, long *val)
> > +{
> > +     unsigned int regval;
> > +     int err;
> > +
> > +     err = regmap_read(data->regmap, TEMPERATURE, &regval);
> > +     if (err < 0)
> > +             return err;
> > +
> > +     *val = (regval * TEMPERATURE_LSB) - 20000;
> > +
> > +     return 0;
> > +}
> > +
> > +static int tps23861_read_voltage(struct tps23861_data *data, int channel,
> > +                              long *val)
> > +{
> > +     unsigned int regval;
> > +     int err;
> > +
> > +     if (channel < 4) {
> > +             err = regmap_bulk_read(data->regmap,
> > +                                    PORT_1_VOLTAGE_LSB + channel * PORT_N_VOLTAGE_LSB_OFFSET,
> > +                                    &regval, 2);
> > +     } else {
> > +             err = regmap_bulk_read(data->regmap,
> > +                                    INPUT_VOLTAGE_LSB,
> > +                                    &regval, 2);
> > +     }
> > +     if (err < 0)
> > +             return err;
> > +
> > +     *val = (FIELD_GET(VOLTAGE_CURRENT_MASK, regval) * VOLTAGE_LSB) / 1000;
> > +
> > +     return 0;
> > +}
> > +
> > +static int tps23861_read_current(struct tps23861_data *data, int channel,
> > +                              long *val)
> > +{
> > +     unsigned int current_lsb;
> > +     unsigned int regval;
> > +     int err;
> > +
> > +     if (data->shunt_resistor == SHUNT_RESISTOR_DEFAULT)
> > +             current_lsb = CURRENT_LSB_255;
> > +     else
> > +             current_lsb = CURRENT_LSB_250;
> > +
> > +     err = regmap_bulk_read(data->regmap,
> > +                            PORT_1_CURRENT_LSB + channel * PORT_N_CURRENT_LSB_OFFSET,
> > +                            &regval, 2);
> > +     if (err < 0)
> > +             return err;
> > +
> > +     *val = (FIELD_GET(VOLTAGE_CURRENT_MASK, regval) * current_lsb) / 1000000;
> > +
> > +     return 0;
> > +}
> > +
> > +static int tps23861_calculate_power(struct tps23861_data *data, int channel,
> > +                                 long *val)
> > +{
> > +     long voltage, current_ma;
> > +     int err;
> > +
> > +     err = tps23861_read_voltage(data, channel, &voltage);
> > +     if (err < 0)
> > +             return err;
> > +
> > +     err = tps23861_read_current(data, channel, &current_ma);
> > +     if (err < 0)
> > +             return err;
> > +
>
> It is not the responsibility of the kernel to calculate power values.
> This can and should be done in userspace. Kenrel power attributes are
> only appropriate if reported by the hardware.

Ok, dropped it.
>
> > +     *val = voltage * current_ma;
> > +
> > +     return 0;
> > +}
> > +
> > +static umode_t tps23861_is_visible(const void *data, enum hwmon_sensor_types type,
> > +                                u32 attr, int channel)
> > +{
> > +     switch (type) {
> > +     case hwmon_temp:
> > +             switch (attr) {
> > +             case hwmon_temp_input:
> > +                     return 0444;
>
> default: missing. Same below.

Added in v3.
>
> > +             }
> > +             break;
> > +     case hwmon_in:
> > +             switch (attr) {
> > +             case hwmon_in_input:
> > +             case hwmon_in_label:
> > +                     return 0444;
> > +             }
> > +             break;
> > +     case hwmon_curr:
> > +             switch (attr) {
> > +             case hwmon_curr_input:
> > +             case hwmon_curr_label:
> > +                     return 0444;
> > +             }
> > +             break;
> > +     case hwmon_power:
> > +             switch (attr) {
> > +             case hwmon_power_input:
> > +             case hwmon_power_label:
> > +                     return 0444;
> > +             }
> > +             break;
> > +     default:
> > +             break;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int tps23861_read(struct device *dev, enum hwmon_sensor_types type,
> > +                      u32 attr, int channel, long *val)
> > +{
> > +     struct tps23861_data *data = dev_get_drvdata(dev);
> > +     int err;
> > +
> > +     switch (type) {
> > +     case hwmon_temp:
> > +             switch (attr) {
> > +             case hwmon_temp_input:
> > +                     err = tps23861_read_temp(data, val);
> > +                     break;
> > +             default:
> > +                     return -EINVAL;
>
>                         return -EOPNOTSUPP;
>
> same below.

Changed in v3.
>
> > +             }
> > +             break;
> > +     case hwmon_in:
> > +             switch (attr) {
> > +             case hwmon_in_input:
> > +                     err = tps23861_read_voltage(data, channel, val);
> > +                     break;
> > +             default:
> > +                     return -EINVAL;
> > +             }
> > +             break;
> > +     case hwmon_curr:
> > +             switch (attr) {
> > +             case hwmon_curr_input:
> > +                     err = tps23861_read_current(data, channel, val);
> > +                     break;
> > +             default:
> > +                     return -EINVAL;
> > +             }
> > +             break;
> > +     case hwmon_power:
> > +             switch (attr) {
> > +             case hwmon_power_input:
> > +                     err = tps23861_calculate_power(data, channel, val);
> > +                     break;
> > +             default:
> > +                     return -EINVAL;
> > +             }
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     return err;
> > +}
> > +
> > +static const char * const tps23861_port_label[] = {
> > +     "Port1",
> > +     "Port2",
> > +     "Port3",
> > +     "Port4",
> > +     "Input",
> > +};
> > +
> > +static int tps23861_read_string(struct device *dev,
> > +                             enum hwmon_sensor_types type,
> > +                             u32 attr, int channel, const char **str)
> > +{
> > +     switch (type) {
> > +     case hwmon_in:
> > +     case hwmon_curr:
> > +     case hwmon_power:
> > +             *str = tps23861_port_label[channel];
> > +             break;
> > +     default:
> > +             return -EOPNOTSUPP;
> > +     }
> > +     return 0;
> > +}
> > +
> > +static const struct hwmon_channel_info *tps23861_info[] = {
> > +     HWMON_CHANNEL_INFO(chip,
> > +                        HWMON_C_REGISTER_TZ),
> > +     HWMON_CHANNEL_INFO(temp,
> > +                        HWMON_T_INPUT),
> > +     HWMON_CHANNEL_INFO(in,
> > +                        HWMON_I_INPUT | HWMON_I_LABEL,
> > +                        HWMON_I_INPUT | HWMON_I_LABEL,
> > +                        HWMON_I_INPUT | HWMON_I_LABEL,
> > +                        HWMON_I_INPUT | HWMON_I_LABEL,
> > +                        HWMON_I_INPUT | HWMON_I_LABEL),
> > +     HWMON_CHANNEL_INFO(curr,
> > +                        HWMON_C_INPUT | HWMON_C_LABEL,
> > +                        HWMON_C_INPUT | HWMON_C_LABEL,
> > +                        HWMON_C_INPUT | HWMON_C_LABEL,
> > +                        HWMON_C_INPUT | HWMON_C_LABEL),
> > +     HWMON_CHANNEL_INFO(power,
> > +                        HWMON_P_INPUT | HWMON_P_LABEL,
> > +                        HWMON_P_INPUT | HWMON_P_LABEL,
> > +                        HWMON_P_INPUT | HWMON_P_LABEL,
> > +                        HWMON_P_INPUT | HWMON_P_LABEL),
> > +     NULL
> > +};
> > +
> > +static const struct hwmon_ops tps23861_hwmon_ops = {
> > +     .is_visible = tps23861_is_visible,
> > +     .read = tps23861_read,
> > +     .read_string = tps23861_read_string,
> > +};
> > +
> > +static const struct hwmon_chip_info tps23861_chip_info = {
> > +     .ops = &tps23861_hwmon_ops,
> > +     .info = tps23861_info,
> > +};
> > +
> > +static ssize_t tps23861_port_status_show(struct device *dev,
> > +                                      struct device_attribute *da,
> > +                                      char *buf)
> > +{
> > +     struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
> > +     struct tps23861_data *data = dev_get_drvdata(dev);
> > +     char *detect_status, *class_status;
> > +     unsigned int regval;
> > +     u8 class, detect;
> > +
> > +     regmap_read(data->regmap, attr->index, &regval);
> > +     detect = FIELD_GET(PORT_STATUS_DETECT_MASK, regval);
> > +     class = FIELD_GET(PORT_STATUS_CLASS_MASK, regval);
> > +
> > +     switch (detect) {
> > +     case PORT_DETECT_UNKNOWN:
> > +             detect_status = "Unknown device";
> > +             break;
> > +     case PORT_DETECT_SHORT:
> > +             detect_status = "Short circuit detected";
> > +             break;
> > +     case PORT_DETECT_RESISTANCE_LOW:
> > +             detect_status = "Too low resistance detected";
> > +             break;
> > +     case PORT_DETECT_RESISTANCE_OK:
> > +             detect_status = "Valid resistance detected";
> > +             break;
> > +     case PORT_DETECT_RESISTANCE_HIGH:
> > +             detect_status = "Too high resistance detected";
> > +             break;
> > +     case PORT_DETECT_OPEN_CIRCUIT:
> > +             detect_status = "Open circuit detected";
> > +             break;
> > +     case PORT_DETECT_MOSFET_FAULT:
> > +             detect_status = "MOSFET fault detected";
> > +             break;
> > +     case PORT_DETECT_LEGACY:
> > +             detect_status = "Legacy device detected";
> > +             break;
> > +     case PORT_DETECT_CAPACITANCE_INVALID_BEYOND:
> > +             detect_status = "Invalid capacitance, beyond clamp voltage";
> > +             break;
> > +     case PORT_DETECT_CAPACITANCE_INVALID_DELTA:
> > +             detect_status = "Invalid capacitance, insufficient voltage delta";
> > +             break;
> > +     case PORT_DETECT_CAPACITANCE_OUT_OF_RANGE:
> > +             detect_status = "Valid capacitance, outside of legacy range";
> > +             break;
> > +     case PORT_DETECT_RESERVED:
> > +     case PORT_DETECT_RESERVED_2:
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     switch (class) {
> > +     case PORT_CLASS_UNKNOWN:
> > +             class_status = "Unknown class";
> > +             break;
> > +     case PORT_CLASS_RESERVED:
> > +     case PORT_CLASS_0:
> > +             class_status = "Class 0";
> > +             break;
> > +     case PORT_CLASS_1:
> > +             class_status = "Class 1";
> > +             break;
> > +     case PORT_CLASS_2:
> > +             class_status = "Class 2";
> > +             break;
> > +     case PORT_CLASS_3:
> > +             class_status = "Class 3";
> > +             break;
> > +     case PORT_CLASS_4:
> > +             class_status = "Class 4";
> > +             break;
> > +     case PORT_CLASS_OVERCURRENT:
> > +             class_status = "Overcurrent";
> > +             break;
> > +     case PORT_CLASS_MISMATCH:
> > +             class_status = "Class mismatch";
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     return snprintf(buf, PAGE_SIZE, "%s, %s\n", detect_status, class_status);
> > +}
> > +
> > +static ssize_t tps23861_poe_plus_show(struct device *dev,
> > +                                   struct device_attribute *da,
> > +                                   char *buf)
> > +{
> > +     struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
> > +     struct tps23861_data *data = dev_get_drvdata(dev);
> > +     char *ports[4];
> > +     unsigned int regval;
> > +     int i;
> > +
> > +     regmap_read(data->regmap, attr->index, &regval);
> > +
> > +     for (i = 0; i < 4; i++) {
> > +             if (BIT(i + 4) & regval)
> > +                     ports[i] = "Yes";
> > +             else
> > +                     ports[i] = "No";
> > +     }
> > +
> > +     return snprintf(buf, PAGE_SIZE, "Port 1: %s\nPort 2: %s\nPort 3: %s\nPort 4: %s\n",
> > +                     ports[0], ports[1], ports[2], ports[3]);
> > +}
> > +
> > +static ssize_t tps23861_port_disable_store(struct device *dev,
> > +                                        struct device_attribute *da,
> > +                                        const char *buf, size_t count)
> > +{
> > +     struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
> > +     struct tps23861_data *data = dev_get_drvdata(dev);
> > +     unsigned int regval, port;
> > +     int ret;
> > +
> > +     ret = kstrtouint(buf, 0, &port);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     regmap_read(data->regmap, attr->index, &regval);
> > +     regval |= BIT(port + 3);
> > +     regmap_write(data->regmap, attr->index, regval);
> > +
> > +     return count;
> > +}
> > +
> > +static ssize_t tps23861_port_enable_store(struct device *dev,
> > +                                       struct device_attribute *da,
> > +                                       const char *buf, size_t count)
> > +{
> > +     struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
> > +     struct tps23861_data *data = dev_get_drvdata(dev);
> > +     unsigned int regval, port;
> > +     int ret;
> > +
> > +     ret = kstrtouint(buf, 0, &port);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     regmap_read(data->regmap, attr->index, &regval);
> > +     regval |= BIT(port - 1);
> > +     regval |= BIT(port + 3);
> > +     regmap_write(data->regmap, attr->index, regval);
> > +
> > +     return count;
> > +}
> > +
> > +static SENSOR_DEVICE_ATTR_RO(port1_status, tps23861_port_status, PORT_1_STATUS);
> > +static SENSOR_DEVICE_ATTR_RO(port2_status, tps23861_port_status, PORT_2_STATUS);
> > +static SENSOR_DEVICE_ATTR_RO(port3_status, tps23861_port_status, PORT_3_STATUS);
> > +static SENSOR_DEVICE_ATTR_RO(port4_status, tps23861_port_status, PORT_4_STATUS);
> > +static SENSOR_DEVICE_ATTR_RO(poe_plus_status, tps23861_poe_plus, POE_PLUS);
>
> sysfs files are supposed to return simple values. If the above is desired/needed,
> I would suggest to implement debugfs attributes.

Ok, moved these to debugfs.
>
> > +static SENSOR_DEVICE_ATTR_WO(port_disable, tps23861_port_disable, POWER_ENABLE);
> > +static SENSOR_DEVICE_ATTR_WO(port_enable, tps23861_port_enable, DETECT_CLASS_RESTART);
> > +
>
> We already have standard enable attributes. Please use those.
> Also, a separate 'disable' attribute is unnecessary.

Ok, implemented enable/disable using hwmon_in_enable in v3.

Regards,
Robert
>
> > +static struct attribute *tps23861_attrs[] = {
> > +     &sensor_dev_attr_port1_status.dev_attr.attr,
> > +     &sensor_dev_attr_port2_status.dev_attr.attr,
> > +     &sensor_dev_attr_port3_status.dev_attr.attr,
> > +     &sensor_dev_attr_port4_status.dev_attr.attr,
> > +     &sensor_dev_attr_poe_plus_status.dev_attr.attr,
> > +     &sensor_dev_attr_port_disable.dev_attr.attr,
> > +     &sensor_dev_attr_port_enable.dev_attr.attr,
> > +     NULL,
> > +};
> > +
> > +static const struct attribute_group tps23861_group = {
> > +     .attrs = tps23861_attrs,
> > +};
> > +__ATTRIBUTE_GROUPS(tps23861);
> > +
> > +static int tps23861_probe(struct i2c_client *client)
> > +{
> > +     struct device *dev = &client->dev;
> > +     struct tps23861_data *data;
> > +     struct device *hwmon_dev;
> > +     u32 shunt_resistor;
> > +
> > +     data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> > +     if (!data)
> > +             return -ENOMEM;
> > +
> > +     data->regmap = devm_regmap_init_i2c(client, &tps23861_regmap_config);
> > +     if (IS_ERR(data->regmap)) {
> > +             dev_err(dev, "failed to allocate register map\n");
> > +             return PTR_ERR(data->regmap);
> > +     }
> > +
> > +     if (of_property_read_u32(dev->of_node, "shunt-resistor-micro-ohms", &shunt_resistor) < 0)
> > +             data->shunt_resistor = shunt_resistor;
> > +     else
> > +             data->shunt_resistor = SHUNT_RESISTOR_DEFAULT;
> > +
> > +     hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name,
> > +                                                      data, &tps23861_chip_info,
> > +                                                      tps23861_groups);
> > +     return PTR_ERR_OR_ZERO(hwmon_dev);
> > +}
> > +
> > +static const struct of_device_id __maybe_unused tps23861_of_match[] = {
> > +     { .compatible = "ti,tps23861", },
> > +     { },
> > +};
> > +MODULE_DEVICE_TABLE(of, tps23861_of_match);
> > +
> > +static struct i2c_driver tps23861_driver = {
> > +     .probe_new              = tps23861_probe,
> > +     .driver = {
> > +             .name           = "tps23861",
> > +             .of_match_table = of_match_ptr(tps23861_of_match),
> > +     },
> > +};
> > +module_i2c_driver(tps23861_driver);
> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_AUTHOR("Robert Marko <robert.marko@sartura.hr>");
> > +MODULE_DESCRIPTION("TI TPS23861 PoE PSE");
> >
>
