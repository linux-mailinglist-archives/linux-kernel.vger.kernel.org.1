Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C283C2DC298
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 15:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgLPO73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 09:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725274AbgLPO73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 09:59:29 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5089EC0617A6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 06:58:48 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id r7so23482951wrc.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 06:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=MNrGweTBevFAwXJiCBPMKng9cziWh0ECdDrExjr9k6g=;
        b=NIqfd50o6UdQ35tktufqu1X3RsQ28zq3bYtxzESZEH++wGd/4Ah1dcGde5unmTu4ri
         EqJyQ1k/u3VluztzNCcir0riikz3UtsUprbqKW3Xj0pPals7gQ3BMJPuROltvrtAGpYr
         By2sG7NzACrJotqT0xucq+eW0l2K/eNrObbkUqsdCNl6wAEFH7qRKaOXIZ0DyVyR2Ew5
         CCq66lAnl9gnS9VjO5WcHZ9l2PiM1ebJALrNWb6lfmk9iS7jKJDamG6UpaEf16Vtjc2/
         GzHct/cxM5Xg0whdIhqH75oUpPCyn5XEfmlRNqAZMwrmALLKGZT+d/9r/UDUjqPpcKDh
         lmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=MNrGweTBevFAwXJiCBPMKng9cziWh0ECdDrExjr9k6g=;
        b=rxSD281Dh9Ywb89cVJW9Z58LWVB/2xMn3vxH7JHprdtKxdSdDPmlOK7jWt/5/xkEeu
         MSJa2D06ITt9e6u39fdirwK/CN/DgWMBGAvc/8BEyNRPlr/HtZsJ9pxYKlquxE04KPVS
         P2jZCJIe5WSUGtY2agjYOUkUp1BucSFRwpPw1oYRHTWaWcmfWOztPTTOgbplkLUL24ft
         2YRvBIIA6UwDtduyQ42wkhjdnasEBX4FwBocQEVSnJQFECR6GH+BzrTdF6EodlMDh98O
         KqeUhzwkPzWXNPpJWckaAsbBKCB42ihXdH7Kz5ZPt2j9O/ipGYFjGByvex3BFAQjmrsS
         FhpQ==
X-Gm-Message-State: AOAM531ApqzmNd34ZDQmKRtlpOrvsXo+QUHw6HUze5kuQKYDvBIeJsS3
        HROMfriGgcxvMfCQ9l+OauhixK0W6lEdX8ao
X-Google-Smtp-Source: ABdhPJwuGOE/BG3gxiL745k1P6g5TQMb4qDWebaTgsq49X0mCnMlNXoQlhUn5rgKAvpiRS6b95KD1Q==
X-Received: by 2002:adf:9d49:: with SMTP id o9mr39652204wre.413.1608130726940;
        Wed, 16 Dec 2020 06:58:46 -0800 (PST)
Received: from dell ([91.110.221.200])
        by smtp.gmail.com with ESMTPSA id w4sm3098065wmc.13.2020.12.16.06.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 06:58:46 -0800 (PST)
Date:   Wed, 16 Dec 2020 14:58:44 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, cy_huang <cy_huang@richtek.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] mfd: rt4831: Adds support for Richtek RT4831 MFD
 core
Message-ID: <20201216145844.GH207743@dell>
References: <1607704424-16223-1-git-send-email-u0084500@gmail.com>
 <20201216141213.GE207743@dell>
 <CADiBU3_o6uyS7GsPcWHVUkat2cHk0armDz4FC_TB6XaHfU-rEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADiBU3_o6uyS7GsPcWHVUkat2cHk0armDz4FC_TB6XaHfU-rEQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Dec 2020, ChiYuan Huang wrote:

> Lee Jones <lee.jones@linaro.org> 於 2020年12月16日 週三 下午10:12寫道：
> >
> > On Sat, 12 Dec 2020, cy_huang wrote:
> >
> > > From: ChiYuan Huang <cy_huang@richtek.com>
> > >
> > > This adds support Richtek RT4831 MFD core. It includes four channel WLED driver
> >
> > Drop mentions of MFD.  Just core driver will do.
> >
> > > and Display Bias Voltage outputs.
> > >
> > > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > > ---
> > > since v2
> > > - Refine Kconfig descriptions.
> > > - Add copyright.
> > > - Refine error logs in probe.
> > > - Refine comment lines in remove and shutdown.
> > > ---
> > >  drivers/mfd/Kconfig       |  10 ++++
> > >  drivers/mfd/Makefile      |   1 +
> > >  drivers/mfd/rt4831-core.c | 124 ++++++++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 135 insertions(+)
> > >  create mode 100644 drivers/mfd/rt4831-core.c
> > >
> > > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > > index 8b99a13..dfb2640 100644
> > > --- a/drivers/mfd/Kconfig
> > > +++ b/drivers/mfd/Kconfig
> > > @@ -1088,6 +1088,16 @@ config MFD_RDC321X
> > >         southbridge which provides access to GPIOs and Watchdog using the
> > >         southbridge PCI device configuration space.
> > >
> > > +config MFD_RT4831
> > > +     tristate "Richtek RT4831 four channel WLED and Display Bias Voltage"
> > > +     depends on I2C
> > > +     select MFD_CORE
> > > +     select REGMAP_I2C
> > > +     help
> > > +       This enables support for the Richtek RT4831 that includes 4 channel
> > > +       WLED driving and Display Bias Voltage. It's commonly used to provide
> > > +       power to the LCD display and LCD backlight.
> > > +
> > >  config MFD_RT5033
> > >       tristate "Richtek RT5033 Power Management IC"
> > >       depends on I2C
> > > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > > index 1780019..4108141 100644
> > > --- a/drivers/mfd/Makefile
> > > +++ b/drivers/mfd/Makefile
> > > @@ -235,6 +235,7 @@ obj-$(CONFIG_MFD_MENF21BMC)       += menf21bmc.o
> > >  obj-$(CONFIG_MFD_HI6421_PMIC)        += hi6421-pmic-core.o
> > >  obj-$(CONFIG_MFD_HI655X_PMIC)   += hi655x-pmic.o
> > >  obj-$(CONFIG_MFD_DLN2)               += dln2.o
> > > +obj-$(CONFIG_MFD_RT4831)     += rt4831-core.o
> >
> > Why is this called -core ...
> >
> > >  obj-$(CONFIG_MFD_RT5033)     += rt5033.o
> >
> > ... and this isn't?
> >
> 
> Ok, I'm rename the mfd file to rt4831 only.
> Due to this mfd is the parent of all sub device, to use 'core' is
> trying to distinguish from rt4831-regulator  or rt4831-backlight.
> My original thought is not to let the user confused.
> If to add the postfix '-core' in the file name is bad, I think it can
> be removed.
> 
> > >  obj-$(CONFIG_MFD_SKY81452)   += sky81452.o
> > >
> > > diff --git a/drivers/mfd/rt4831-core.c b/drivers/mfd/rt4831-core.c
> > > new file mode 100644
> > > index 00000000..f837c06
> > > --- /dev/null
> > > +++ b/drivers/mfd/rt4831-core.c
> > > @@ -0,0 +1,124 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +/*
> > > + * Copyright (c) 2020 Richtek Technology Corp.
> > > + *
> > > + * Author: ChiYuan Huang <cy_huang@richtek.com>
> > > + */
> > > +
> > > +#include <linux/gpio/consumer.h>
> > > +#include <linux/i2c.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/mfd/core.h>
> > > +#include <linux/module.h>
> > > +#include <linux/regmap.h>
> > > +
> > > +#define RT4831_REG_REVISION  0x01
> > > +#define RT4831_REG_ENABLE    0x08
> > > +#define RT4831_REG_I2CPROT   0x15
> > > +
> > > +#define RICHTEK_VID          0x03
> > > +#define RT4831_VID_MASK              GENMASK(1, 0)
> > > +#define RT4831_RESET_MASK    BIT(7)
> > > +#define RT4831_I2CSAFETMR_MASK       BIT(0)
> > > +
> > > +static const struct mfd_cell rt4831_subdevs[] = {
> > > +     OF_MFD_CELL("rt4831-backlight", NULL, NULL, 0, 0, "richtek,rt4831-backlight"),
> > > +     MFD_CELL_NAME("rt4831-regulator")
> > > +};
> >
> > Just a little note about these helpers.  I'm planning on unifying the
> > names pretty soon.  So if you have to rebase, please watch out for the
> > rename.
> >
> > Essentially OF_MFD_CELL() will soon become MFD_CELL_OF().
> >
> Yes, I'll check this change. BTW, is it possible to get this patch
> that I can integrate it into my codebase in advance.

Once it's applied, it will be in Linux -next.

Until then, don't worry about it.

> > > +static int rt4831_probe(struct i2c_client *client)
> > > +{
> > > +     struct gpio_desc *enable;
> >
> > My preference would be "enable_gpio" to ensure it's easily
> > identifiable further on.
> >
> Yes, it make sense.
> > > +     struct regmap *regmap;
> > > +     unsigned int val;
> >
> > 'val' is not a great name for a variable that is used for a specific
> > purpose.  How about 'revision'?
> >
> Actually, this is just for the vendor id check.
> Maybe to named 'vendor_id' is more suitable.
> This register can be divided into two parts, bit[7:4] is the fixed
> vendor identifier, only bit[3:0] is for the chip revision.
> > > +     int ret;
> > > +
> > > +     enable = devm_gpiod_get_optional(&client->dev, "enable", GPIOD_OUT_HIGH);
> > > +     if (IS_ERR(enable)) {
> > > +             dev_err(&client->dev, "Failed to get 'enable' GPIO\n");
> > > +             return PTR_ERR(enable);
> > > +     }
> > > +
> > > +     regmap = devm_regmap_init_i2c(client, &rt4831_regmap_config);
> > > +     if (IS_ERR(regmap)) {
> > > +             dev_err(&client->dev, "Failed to initialize regmap\n");
> > > +             return PTR_ERR(regmap);
> > > +     }
> > > +
> > > +     ret = regmap_read(regmap, RT4831_REG_REVISION, &val);
> > > +     if (ret) {
> > > +             dev_err(&client->dev, "Failed to get H/W revision\n");
> > > +             return ret;
> > > +     }
> > > +
> > > +     if ((val & RT4831_VID_MASK) != RICHTEK_VID) {
> >
> > What does VID stand for here?
> >
> > The fact that I have to ask probably means it should be changed.
> >
> > Variant ID perhaps?  If so, call the define 'VARIANT_ID'.
> >
> Like as the the above explaination.
> 'RICHTEK_VID' may not be good. So it make you confused.
> I'll rename it to 'RICHTEK_VENDOR_ID'. How about this naming?
> 
> > > +             dev_err(&client->dev, "VID not matched, val = 0x%02x\n", val);
> >
> > Using variable names means nothing to the user.
> >
> > "revision:  0x%02x" ?
> >
> How about this one "CHIP ID: 0x%02x"?
> May I use 'chip_id to replace this variable 'val' naming?
> > > +             return -ENODEV;
> > > +     }
> > > +
> > > +     /*
> > > +      * Used to prevent the abnormal shutdown.
> > > +      * If SCL/SDA both keep low for one second to reset HW.
> > > +      */
> > > +     ret = regmap_update_bits(regmap, RT4831_REG_I2CPROT, RT4831_I2CSAFETMR_MASK,
> > > +                              RT4831_I2CSAFETMR_MASK);
> > > +     if (ret) {
> > > +             dev_err(&client->dev, "Failed to enable I2C safety timer\n");
> > > +             return ret;
> > > +     }
> > > +
> > > +     return devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_AUTO, rt4831_subdevs,
> > > +                                 ARRAY_SIZE(rt4831_subdevs), NULL, 0, NULL);
> > > +}
> > > +
> > > +static int rt4831_remove(struct i2c_client *client)
> > > +{
> > > +     struct regmap *regmap = dev_get_regmap(&client->dev, NULL);
> > > +
> > > +     /* Disable WLED and DSV outputs */
> > > +     return regmap_update_bits(regmap, RT4831_REG_ENABLE, RT4831_RESET_MASK, RT4831_RESET_MASK);
> > > +}
> > > +
> > > +static void rt4831_shutdown(struct i2c_client *client)
> > > +{
> > > +     struct regmap *regmap = dev_get_regmap(&client->dev, NULL);
> > > +
> > > +     /* Disable WLED and DSV outputs */
> > > +     regmap_update_bits(regmap, RT4831_REG_ENABLE, RT4831_RESET_MASK, RT4831_RESET_MASK);
> > > +}
> > > +
> > > +static const struct of_device_id __maybe_unused rt4831_of_match[] = {
> > > +     { .compatible = "richtek,rt4831", },
> > > +     {}
> > > +};
> > > +MODULE_DEVICE_TABLE(of, rt4831_of_match);
> > > +
> > > +static struct i2c_driver rt4831_driver = {
> > > +     .driver = {
> > > +             .name = "rt4831",
> > > +             .of_match_table = of_match_ptr(rt4831_of_match),
> >
> > The trend is to not use of_match_ptr() anymore, as these devices can
> > not be instantiated using ACPI.
> >
> OK, I'll remove 'of_match_ptr'.
> > > +     },
> > > +     .probe_new = rt4831_probe,
> > > +     .remove = rt4831_remove,
> > > +     .shutdown = rt4831_shutdown,
> > > +};
> > > +module_i2c_driver(rt4831_driver);
> > > +
> > > +MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
> > > +MODULE_LICENSE("GPL v2");

Yes, all fine.  Thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
