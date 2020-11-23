Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 344B22C142D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 20:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbgKWTDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 14:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729140AbgKWTDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 14:03:13 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196A6C0613CF;
        Mon, 23 Nov 2020 11:03:13 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id t3so1273846pgi.11;
        Mon, 23 Nov 2020 11:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yMuGjAGAYA+5ImbfC3OSe/xsrUqI4pHb2wVel7Ahm0Y=;
        b=cpumtOl8Hz9K/isd0gwzNo8XSlMa4wMmT8gH7nLi/Mc16Nd4BOlI/+Mq6l4WyKKzR5
         eargzdQq2Z6yaF/D2/DWzFt4X0iwusR6LHTk90uX9o1s0gGWJ+Gl3R9KeRcov0jIBd/D
         ieQX8eU3sCM8QAvANmDPMq9bFYGRbA8MZHeM1h07Arc8Ft/4MN7k8C+MdILF1xt3Fas2
         db1VzZnZoguVudl4f0KhSFVpoEcO69ywT4gtWgAtGKHtNLHB0li9p3xEpNx8Zqtd/X03
         roxC1VjTUgOybpemA64HOjAYDMNh63oVORwXvvYdMWrYMLmLzS/e3BeZ42Lh1FP1DX9V
         mBsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yMuGjAGAYA+5ImbfC3OSe/xsrUqI4pHb2wVel7Ahm0Y=;
        b=OKr/pOFeCR6buSLpO3MALpxgozQkLa/OUaWpk2ln45tsm/ZqB1zCCjwR/YYuxBU0aC
         Jz7THwR/jqirDmYuYTXkOMRJ9Owf1JcnqfLw0Pl/85oMXn7EI+ePRXJs1XajB2f47VpJ
         HUOh8BBnKc1ZDjEuv7DTiHfJIbsG/GPeZDeT4Ipy0xRkAJwR6ZAgUJVeu/MFDxm2xsz8
         RtWyMtgxNVJzK1zqElBxIHZ+Nk0+RmqjelrsfX+tyzkkgyDh3gTceVBi/3dxJif5NDPY
         ZkoBJpjb+4T/ruYNV5RyalQ9fl0YjAhQv7f4d1dYOYm7pIaJRWFHH8+rN1kMMDP1PK53
         tDHQ==
X-Gm-Message-State: AOAM531nbryLYzBwBBV0zhOvXNMK+/KeBYvpcS/YDfiBd0Gcxausb/w/
        H3o+E7OAYDNfGNg+uko4ZXA=
X-Google-Smtp-Source: ABdhPJwl8aybCD5NSXzQDDjdEDdtIbfM9OHag1+2pZRRFIqG+7hmC9anyar4R3Lrk+dUKLLVIGRhzA==
X-Received: by 2002:a62:52c6:0:b029:18c:a1fa:2fc2 with SMTP id g189-20020a6252c60000b029018ca1fa2fc2mr777841pfb.50.1606158192579;
        Mon, 23 Nov 2020 11:03:12 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91 (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id z128sm11365946pgz.69.2020.11.23.11.03.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Nov 2020 11:03:12 -0800 (PST)
Date:   Mon, 23 Nov 2020 11:03:09 -0800
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        taoren@fb.com, mikechoi@fb.com
Subject: Re: [PATCH v4 1/2] hwmon: (max127) Add Maxim MAX127 hardware
 monitoring driver
Message-ID: <20201123190308.GB7697@taoren-ubuntu-R90MNF91>
References: <20201123074532.3730-1-rentao.bupt@gmail.com>
 <20201123074532.3730-2-rentao.bupt@gmail.com>
 <20201123131832.GB136636@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123131832.GB136636@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 05:18:32AM -0800, Guenter Roeck wrote:
> On Sun, Nov 22, 2020 at 11:45:31PM -0800, rentao.bupt@gmail.com wrote:
> > From: Tao Ren <rentao.bupt@gmail.com>
> > 
> > Add hardware monitoring driver for the Maxim MAX127 chip.
> > 
> > MAX127 min/max range handling code is inspired by the max197 driver.
> > 
> > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> > ---
> >  Changes in v4:
> >    - delete unnecessary "#include" lines.
> >    - simplify i2c_transfer() error handling.
> >    - add mutex to protect ctrl_byte in write_min|max() functions.
> >  Changes in v3:
> >    - no code change. xdp maintainers were removed from to/cc list.
> >  Changes in v2:
> >    - replace devm_hwmon_device_register_with_groups() with
> >      devm_hwmon_device_register_with_info() API.
> >    - divide min/max read and write methods to separate functions.
> >    - fix raw-to-vin conversion logic.
> >    - refine ctrl_byte handling so mutex is not needed to protect the
> >      byte.
> >    - improve i2c_transfer() error handling.
> >    - a few other improvements (comments, variable naming, and etc.).
> > 
> >  drivers/hwmon/Kconfig  |   9 ++
> >  drivers/hwmon/Makefile |   1 +
> >  drivers/hwmon/max127.c | 346 +++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 356 insertions(+)
> >  create mode 100644 drivers/hwmon/max127.c
> > 
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index 9d600e0c5584..716df51edc87 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -950,6 +950,15 @@ config SENSORS_MAX1111
> >  	  This driver can also be built as a module. If so, the module
> >  	  will be called max1111.
> >  
> > +config SENSORS_MAX127
> > +	tristate "Maxim MAX127 12-bit 8-channel Data Acquisition System"
> > +	depends on I2C
> > +	help
> > +	  Say y here to support Maxim's MAX127 DAS chips.
> > +
> > +	  This driver can also be built as a module. If so, the module
> > +	  will be called max127.
> > +
> >  config SENSORS_MAX16065
> >  	tristate "Maxim MAX16065 System Manager and compatibles"
> >  	depends on I2C
> > diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> > index 1083bbfac779..01ca5d3fbad4 100644
> > --- a/drivers/hwmon/Makefile
> > +++ b/drivers/hwmon/Makefile
> > @@ -127,6 +127,7 @@ obj-$(CONFIG_SENSORS_LTC4260)	+= ltc4260.o
> >  obj-$(CONFIG_SENSORS_LTC4261)	+= ltc4261.o
> >  obj-$(CONFIG_SENSORS_LTQ_CPUTEMP) += ltq-cputemp.o
> >  obj-$(CONFIG_SENSORS_MAX1111)	+= max1111.o
> > +obj-$(CONFIG_SENSORS_MAX127)	+= max127.o
> >  obj-$(CONFIG_SENSORS_MAX16065)	+= max16065.o
> >  obj-$(CONFIG_SENSORS_MAX1619)	+= max1619.o
> >  obj-$(CONFIG_SENSORS_MAX1668)	+= max1668.o
> > diff --git a/drivers/hwmon/max127.c b/drivers/hwmon/max127.c
> > new file mode 100644
> > index 000000000000..1c54146b6086
> > --- /dev/null
> > +++ b/drivers/hwmon/max127.c
> > @@ -0,0 +1,346 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Hardware monitoring driver for MAX127.
> > + *
> > + * Copyright (c) 2020 Facebook Inc.
> > + */
> > +
> > +#include <linux/err.h>
> > +#include <linux/hwmon.h>
> > +#include <linux/i2c.h>
> > +#include <linux/init.h>
> > +#include <linux/module.h>
> > +
> > +/*
> > + * MAX127 Control Byte. Refer to MAX127 datasheet, Table 1 "Control-Byte
> > + * Format" for details.
> > + */
> > +#define MAX127_CTRL_START	BIT(7)
> > +#define MAX127_CTRL_SEL_SHIFT	4
> > +#define MAX127_CTRL_RNG		BIT(3)
> > +#define MAX127_CTRL_BIP		BIT(2)
> > +#define MAX127_CTRL_PD1		BIT(1)
> > +#define MAX127_CTRL_PD0		BIT(0)
> > +
> > +#define MAX127_NUM_CHANNELS	8
> > +#define MAX127_SET_CHANNEL(ch)	(((ch) & 7) << MAX127_CTRL_SEL_SHIFT)
> > +
> > +/*
> > + * MAX127 channel input ranges. Refer to MAX127 datasheet, Table 3 "Range
> > + * and Polarity Selection" for details.
> > + */
> > +#define MAX127_FULL_RANGE	10000	/* 10V */
> > +#define MAX127_HALF_RANGE	5000	/* 5V */
> > +
> > +/*
> > + * MAX127 returns 2 bytes at read:
> > + *   - the first byte contains data[11:4].
> > + *   - the second byte contains data[3:0] (MSB) and 4 dummy 0s (LSB).
> > + * Refer to MAX127 datasheet, "Read a Conversion (Read Cycle)" section
> > + * for details.
> > + */
> > +#define MAX127_DATA_LEN		2
> > +#define MAX127_DATA_SHIFT	4
> > +
> > +#define MAX127_SIGN_BIT		BIT(11)
> > +
> > +struct max127_data {
> > +	struct mutex lock;
> > +	struct i2c_client *client;
> > +	u8 ctrl_byte[MAX127_NUM_CHANNELS];
> > +};
> > +
> > +static int max127_select_channel(struct i2c_client *client, u8 ctrl_byte)
> > +{
> > +	int status;
> > +	struct i2c_msg msg = {
> > +		.addr = client->addr,
> > +		.flags = 0,
> > +		.len = sizeof(ctrl_byte),
> > +		.buf = &ctrl_byte,
> > +	};
> > +
> > +	status = i2c_transfer(client->adapter, &msg, 1);
> > +
> > +	return (status == 1) ? 0 : -EIO;
> 
> This isn't what I said and asked for. It drops the unnecessary else,
> but now it overwrites an error value.
> 
> Guenter
> 
> > +}
> > +
> > +static int max127_read_channel(struct i2c_client *client, long *val)
> > +{
> > +	int status;
> > +	u8 i2c_data[MAX127_DATA_LEN];
> > +	struct i2c_msg msg = {
> > +		.addr = client->addr,
> > +		.flags = I2C_M_RD,
> > +		.len = sizeof(i2c_data),
> > +		.buf = i2c_data,
> > +	};
> > +
> > +	status = i2c_transfer(client->adapter, &msg, 1);
> > +	if (status != 1)
> > +		return -EIO;
> 
> This isn't what I asked for.
> 
> Guenter

Both places are fixed in v5. Thanks for the clarify, Guenter.


Cheers,

Tao
