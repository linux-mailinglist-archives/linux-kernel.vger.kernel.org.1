Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839D72C1427
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 20:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390665AbgKWTBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 14:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730868AbgKWTBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 14:01:42 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817C6C0613CF;
        Mon, 23 Nov 2020 11:01:42 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id l1so1062391pld.5;
        Mon, 23 Nov 2020 11:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GDahuPRDY9sUNvHhb7QNuuqG8EJHBdjtGS0QzXojzmU=;
        b=sTgVZAkhh7dB6lO8jXe6q4NBtHSaNlxAbCo5U92Ka6YVwj4/38m49JobOrvK9CPUvC
         dGOCSBu5QXcjzDviFxMe/0c4jo0K88enc0ckyIJbodknyHTE2LB4nAcz0dV/iNryC9z+
         RntryzjfCpxa3M+bEEvyQLGOzBQAY06JmQFKehOi2RQXVqnyYKlokn7OEhrkz0FdNmyP
         kHrCpsITRRJsgRdYroehMyA9E0odj/kWHyDsaIDRmu8aTIMqG8+BHxk7RD+qxjTd0NCz
         nrw6xIkYO5UmnMvlLhYfJibt0Z6NM/LF/U4Ls5CbXqzg7c7+e9F4apXu5sh4u6CP+744
         sEJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GDahuPRDY9sUNvHhb7QNuuqG8EJHBdjtGS0QzXojzmU=;
        b=IQzRmf7jsqs/JUknbRgUun5dgL5Sr2Cm1FEYwyVjPb8phI/7mV40IWGU7Ih4rJ6l1f
         mFE85JqogL1DXgoTqph/9f7JDMlE3cO3cQW6bjfeAW3tQsY5DGKd4iQkph9ta6/9PXdL
         hCXrEwNLMWvCo7VM2ji3u+1EldtoXR1dx8bFoU3CoP8K301gyM3M1AwEv6a6S+my0QOo
         VPHvT7Bjs/sCF1bH++bLdMZIFbK9p41S1h/I4PQ3YjeoLNzskasBYUTpDe2zGuvV1Na7
         dWbLlRNLvh005KZ9aVWFXsDH+H2TVkqDmRRl4RVjihUS6PDuCGyaj3JKLPVxStzt6dyA
         w1Vg==
X-Gm-Message-State: AOAM5318LAtxzF9Wryvgz9Zw6H5ruGRHkIVEPDziLzmECrMo+7weyxF5
        FxFS+oMrpODkaxddQVEjuAmKOHRtXeWyno4j
X-Google-Smtp-Source: ABdhPJySfR1lvQTbWqU4vta4VmZWCAoruE/4U1/hh940i+xDfClLuHb5sliQ8Thf+Rea7yLnVRyuuA==
X-Received: by 2002:a17:902:bd02:b029:da:8fd:af6b with SMTP id p2-20020a170902bd02b02900da08fdaf6bmr911448pls.7.1606158101910;
        Mon, 23 Nov 2020 11:01:41 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91 (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id m2sm11710965pgv.0.2020.11.23.11.01.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Nov 2020 11:01:41 -0800 (PST)
Date:   Mon, 23 Nov 2020 11:01:34 -0800
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        taoren@fb.com, mikechoi@fb.com
Subject: Re: [PATCH v3 1/2] hwmon: (max127) Add Maxim MAX127 hardware
 monitoring driver
Message-ID: <20201123190133.GA7697@taoren-ubuntu-R90MNF91>
References: <20201119175324.22472-1-rentao.bupt@gmail.com>
 <20201119175324.22472-2-rentao.bupt@gmail.com>
 <20201122183342.GA69512@roeck-us.net>
 <20201123075448.GA3563@taoren-ubuntu-R90MNF91>
 <20201123131641.GA136636@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123131641.GA136636@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 05:16:41AM -0800, Guenter Roeck wrote:
> On Sun, Nov 22, 2020 at 11:54:49PM -0800, Tao Ren wrote:
> > On Sun, Nov 22, 2020 at 10:33:42AM -0800, Guenter Roeck wrote:
> > > On Thu, Nov 19, 2020 at 09:53:23AM -0800, rentao.bupt@gmail.com wrote:
> > > > From: Tao Ren <rentao.bupt@gmail.com>
> > > > 
> > > > Add hardware monitoring driver for the Maxim MAX127 chip.
> > > > 
> > > > MAX127 min/max range handling code is inspired by the max197 driver.
> > > > 
> > > > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> > > 
> > > Nice cleanup. Couple of minor comments.
> > > 
> > > Thanks,
> > > Guenter
> > > 
> > > > ---
> > > >  Changes in v3:
> > > >    - no code change. xdp maintainers were removed from to/cc list.
> > > >  Changes in v2:
> > > >    - replace devm_hwmon_device_register_with_groups() with
> > > >      devm_hwmon_device_register_with_info() API.
> > > >    - divide min/max read and write methods to separate functions.
> > > >    - fix raw-to-vin conversion logic.
> > > >    - refine ctrl_byte handling so mutex is not needed to protect the
> > > >      byte.
> > > >    - improve i2c_transfer() error handling.
> > > >    - a few other improvements (comments, variable naming, and etc.).
> > > > 
> > > >  drivers/hwmon/Kconfig  |   9 ++
> > > >  drivers/hwmon/Makefile |   1 +
> > > >  drivers/hwmon/max127.c | 346 +++++++++++++++++++++++++++++++++++++++++
> > > >  3 files changed, 356 insertions(+)
> > > >  create mode 100644 drivers/hwmon/max127.c
> > > > 
> > > > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > > > index 9d600e0c5584..716df51edc87 100644
> > > > --- a/drivers/hwmon/Kconfig
> > > > +++ b/drivers/hwmon/Kconfig
> > > > @@ -950,6 +950,15 @@ config SENSORS_MAX1111
> > > >  	  This driver can also be built as a module. If so, the module
> > > >  	  will be called max1111.
> > > >  
> > > > +config SENSORS_MAX127
> > > > +	tristate "Maxim MAX127 12-bit 8-channel Data Acquisition System"
> > > > +	depends on I2C
> > > > +	help
> > > > +	  Say y here to support Maxim's MAX127 DAS chips.
> > > > +
> > > > +	  This driver can also be built as a module. If so, the module
> > > > +	  will be called max127.
> > > > +
> > > >  config SENSORS_MAX16065
> > > >  	tristate "Maxim MAX16065 System Manager and compatibles"
> > > >  	depends on I2C
> > > > diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> > > > index 1083bbfac779..01ca5d3fbad4 100644
> > > > --- a/drivers/hwmon/Makefile
> > > > +++ b/drivers/hwmon/Makefile
> > > > @@ -127,6 +127,7 @@ obj-$(CONFIG_SENSORS_LTC4260)	+= ltc4260.o
> > > >  obj-$(CONFIG_SENSORS_LTC4261)	+= ltc4261.o
> > > >  obj-$(CONFIG_SENSORS_LTQ_CPUTEMP) += ltq-cputemp.o
> > > >  obj-$(CONFIG_SENSORS_MAX1111)	+= max1111.o
> > > > +obj-$(CONFIG_SENSORS_MAX127)	+= max127.o
> > > >  obj-$(CONFIG_SENSORS_MAX16065)	+= max16065.o
> > > >  obj-$(CONFIG_SENSORS_MAX1619)	+= max1619.o
> > > >  obj-$(CONFIG_SENSORS_MAX1668)	+= max1668.o
> > > > diff --git a/drivers/hwmon/max127.c b/drivers/hwmon/max127.c
> > > > new file mode 100644
> > > > index 000000000000..3df4c225a6a2
> > > > --- /dev/null
> > > > +++ b/drivers/hwmon/max127.c
> > > > @@ -0,0 +1,346 @@
> > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > +/*
> > > > + * Hardware monitoring driver for MAX127.
> > > > + *
> > > > + * Copyright (c) 2020 Facebook Inc.
> > > > + */
> > > > +
> > > > +#include <linux/err.h>
> > > > +#include <linux/hwmon.h>
> > > > +#include <linux/hwmon-sysfs.h>
> > > 
> > > Not needed.
> > > 
> > > > +#include <linux/i2c.h>
> > > > +#include <linux/init.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/sysfs.h>
> > > 
> > > Not needed.
> > 
> > Thanks for pointing it out. Both includes are deleted in v4.
> > 
> > > 
> > > > +
> > > > +/*
> > > > + * MAX127 Control Byte. Refer to MAX127 datasheet, Table 1 "Control-Byte
> > > > + * Format" for details.
> > > > + */
> > > > +#define MAX127_CTRL_START	BIT(7)
> > > > +#define MAX127_CTRL_SEL_SHIFT	4
> > > > +#define MAX127_CTRL_RNG		BIT(3)
> > > > +#define MAX127_CTRL_BIP		BIT(2)
> > > > +#define MAX127_CTRL_PD1		BIT(1)
> > > > +#define MAX127_CTRL_PD0		BIT(0)
> > > > +
> > > > +#define MAX127_NUM_CHANNELS	8
> > > > +#define MAX127_SET_CHANNEL(ch)	(((ch) & 7) << MAX127_CTRL_SEL_SHIFT)
> > > > +
> > > > +/*
> > > > + * MAX127 channel input ranges. Refer to MAX127 datasheet, Table 3 "Range
> > > > + * and Polarity Selection" for details.
> > > > + */
> > > > +#define MAX127_FULL_RANGE	10000	/* 10V */
> > > > +#define MAX127_HALF_RANGE	5000	/* 5V */
> > > > +
> > > > +/*
> > > > + * MAX127 returns 2 bytes at read:
> > > > + *   - the first byte contains data[11:4].
> > > > + *   - the second byte contains data[3:0] (MSB) and 4 dummy 0s (LSB).
> > > > + * Refer to MAX127 datasheet, "Read a Conversion (Read Cycle)" section
> > > > + * for details.
> > > > + */
> > > > +#define MAX127_DATA_LEN		2
> > > > +#define MAX127_DATA_SHIFT	4
> > > > +
> > > > +#define MAX127_SIGN_BIT		BIT(11)
> > > > +
> > > > +struct max127_data {
> > > > +	struct mutex lock;
> > > > +	struct i2c_client *client;
> > > > +	u8 ctrl_byte[MAX127_NUM_CHANNELS];
> > > > +};
> > > > +
> > > > +static int max127_select_channel(struct i2c_client *client, u8 ctrl_byte)
> > > > +{
> > > > +	int status;
> > > > +	struct i2c_msg msg = {
> > > > +		.addr = client->addr,
> > > > +		.flags = 0,
> > > > +		.len = sizeof(ctrl_byte),
> > > > +		.buf = &ctrl_byte,
> > > > +	};
> > > > +
> > > > +	status = i2c_transfer(client->adapter, &msg, 1);
> > > > +	if (status < 0)
> > > > +		return status;
> > > > +	else if (status != 1)
> > > 
> > > else after return is not needed.
> > > 
> > > > +		return -EIO;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int max127_read_channel(struct i2c_client *client, long *val)
> > > > +{
> > > > +	int status;
> > > > +	u8 i2c_data[MAX127_DATA_LEN];
> > > > +	struct i2c_msg msg = {
> > > > +		.addr = client->addr,
> > > > +		.flags = I2C_M_RD,
> > > > +		.len = sizeof(i2c_data),
> > > > +		.buf = i2c_data,
> > > > +	};
> > > > +
> > > > +	status = i2c_transfer(client->adapter, &msg, 1);
> > > > +	if (status < 0)
> > > > +		return status;
> > > > +	else if (status != 1)
> > > 
> > > else after return is not needed.
> > 
> > I'm not sure if I understand your suggestion correctly, and I added this
> > branch to handle the case when i2c_transfer() returns 0, which means the
> > message is not transferred. Perhaps it would never happen? but anyhow, I
> > just simplified the check in v4; please kindly review and let me know if
> > you have further suggestions.
> > 
> 
> 	if (status < 0)
> 		return status;
> 	if (status != 1)
> 		return -EIO;
> 
> Again, else after return is not needed (and static analyzers will complain
> about it).
> 
> Guenter

Ahh, I get it now (I didn't know static analyzers would complain about
it). Thanks for the sharing, and it's fixed in v5.


Cheers,

Tao
