Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7922CF0A5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 16:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730545AbgLDPWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 10:22:11 -0500
Received: from gproxy3-pub.mail.unifiedlayer.com ([69.89.30.42]:41651 "EHLO
        gproxy3-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730493AbgLDPWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 10:22:10 -0500
Received: from cmgw14.unifiedlayer.com (unknown [10.9.0.14])
        by gproxy3.mail.unifiedlayer.com (Postfix) with ESMTP id 0C29C40057
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 08:21:29 -0700 (MST)
Received: from bh-25.webhostbox.net ([208.91.199.152])
        by cmsmtp with ESMTP
        id lCtkkx5h5wNNllCtkk8kbH; Fri, 04 Dec 2020 08:21:29 -0700
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=Icqpp1ia c=1 sm=1 tr=0
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=kj9zAlcOel0A:10:nop_charset_1
 a=zTNgK-yGK50A:10:nop_rcvd_month_year
 a=evQFzbml-YQA:10:endurance_base64_authed_username_1 a=gAnH3GRIAAAA:8
 a=FKLIVFl7mNak6WWTxaYA:9 a=CjuIK1q_8ugA:10:nop_charset_2
 a=oVHKYsEdi7-vN-J5QA_j:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PNfgaoH8rLyWEGS0pemJZIJT1rnIBN/Ft6RtOLR1vDE=; b=LXIIV7nSAB6qj3R1O2KYx2WlY0
        d0MvkEXyLWOtx8kaDpfTAVKwqeJMtTDsZkfH//xeYdZxOiIrWtPCoo/e9eIeQFTSfwLHcdapF9Lg2
        pEn/QvUR5onnsG9B1oDsrupE56vy6rQcNs7YqNplzK50lrhZlDPPnFV75bSu62NOi/zDfRbN8qDkT
        mQ2Wpq72nDvrloewg7zLxEDgIoCGFZcU7hfvzEP0p9RIJ2yJLBCSdXPLzJINITlTQ66Mk9mCA+fWx
        6CpfKqyS9by4lOzBi5efRA0WnTXuRgtaxs3Ly7EE2bDEyjululq7Q8ZTpAaaJBG3fyf0+Yg1SDOb6
        Hu7uVcWQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:46526 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <linux@roeck-us.net>)
        id 1klCtk-001k7N-1D; Fri, 04 Dec 2020 15:21:28 +0000
Date:   Fri, 4 Dec 2020 07:21:27 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     alexandru.tachici@analog.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Weston.Sapia@analog.com,
        Brad.Lovell@analog.com, Sal.Afzal@analog.com, robh+dt@kernel.org
Subject: Re: [PATCH v3 2/3] hwmon: ltc2992: Add support for GPIOs.
Message-ID: <20201204152127.GB135107@roeck-us.net>
References: <20201203071155.68859-1-alexandru.tachici@analog.com>
 <20201203071155.68859-3-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203071155.68859-3-alexandru.tachici@analog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1klCtk-001k7N-1D
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:46526
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 14
X-Org:  HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 09:11:54AM +0200, alexandru.tachici@analog.com wrote:
> From: Alexandru Tachici <alexandru.tachici@analog.com>
> 
> LTC2992 has 4 open-drain GPIOS. This patch exports to user
> space the 4 GPIOs using the GPIO driver Linux API.
> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/Kconfig   |   1 +
>  drivers/hwmon/ltc2992.c | 160 +++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 160 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index bf9e387270d6..8a8eb42fb1ec 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -861,6 +861,7 @@ config SENSORS_LTC2990
>  config SENSORS_LTC2992
>  	tristate "Linear Technology LTC2992"
>  	depends on I2C
> +	depends on GPIOLIB
>  	help
>  	  If you say yes here you get support for Linear Technology LTC2992
>  	  I2C System Monitor. The LTC2992 measures current, voltage, and
> diff --git a/drivers/hwmon/ltc2992.c b/drivers/hwmon/ltc2992.c
> index c11d585a9600..69dbb5aa5dc2 100644
> --- a/drivers/hwmon/ltc2992.c
> +++ b/drivers/hwmon/ltc2992.c
> @@ -8,6 +8,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/bitops.h>
>  #include <linux/err.h>
> +#include <linux/gpio/driver.h>
>  #include <linux/hwmon.h>
>  #include <linux/i2c.h>
>  #include <linux/kernel.h>
> @@ -54,6 +55,9 @@
>  #define LTC2992_G4_MAX_THRESH		0x74
>  #define LTC2992_G4_MIN_THRESH		0x76
>  #define LTC2992_FAULT3			0x92
> +#define LTC2992_GPIO_STATUS		0x95
> +#define LTC2992_GPIO_IO_CTRL		0x96
> +#define LTC2992_GPIO_CTRL		0x97
>  
>  #define LTC2992_POWER(x)		(LTC2992_POWER1 + ((x) * 0x32))
>  #define LTC2992_POWER_MAX(x)		(LTC2992_POWER1_MAX + ((x) * 0x32))
> @@ -96,8 +100,18 @@
>  #define LTC2992_VADC_UV_LSB		25000
>  #define LTC2992_VADC_GPIO_UV_LSB	500
>  
> +#define LTC2992_GPIO_NR		4
> +#define LTC2992_GPIO1_BIT	7
> +#define LTC2992_GPIO2_BIT	6
> +#define LTC2992_GPIO3_BIT	0
> +#define LTC2992_GPIO4_BIT	6
> +#define LTC2992_GPIO_BIT(x)	(LTC2992_GPIO_NR - (x) - 1)
> +
>  struct ltc2992_state {
>  	struct i2c_client		*client;
> +	struct gpio_chip		gc;
> +	struct mutex			gpio_mutex; /* lock for gpio access */
> +	const char			*gpio_names[LTC2992_GPIO_NR];
>  	struct regmap			*regmap;
>  	u32				r_sense_uohm[2];
>  };
> @@ -111,6 +125,8 @@ struct ltc2992_gpio_regs {
>  	u8	alarm;
>  	u8	min_alarm_msk;
>  	u8	max_alarm_msk;
> +	u8	ctrl;
> +	u8	ctrl_bit;
>  };
>  
>  static const struct ltc2992_gpio_regs ltc2992_gpio_addr_map[] = {
> @@ -123,6 +139,8 @@ static const struct ltc2992_gpio_regs ltc2992_gpio_addr_map[] = {
>  		.alarm = LTC2992_FAULT1,
>  		.min_alarm_msk = LTC2992_GPIO1_FAULT_MSK(0),
>  		.max_alarm_msk = LTC2992_GPIO1_FAULT_MSK(1),
> +		.ctrl = LTC2992_GPIO_IO_CTRL,
> +		.ctrl_bit = LTC2992_GPIO1_BIT,
>  	},
>  	{
>  		.data = LTC2992_G2,
> @@ -133,6 +151,8 @@ static const struct ltc2992_gpio_regs ltc2992_gpio_addr_map[] = {
>  		.alarm = LTC2992_FAULT2,
>  		.min_alarm_msk = LTC2992_GPIO2_FAULT_MSK(0),
>  		.max_alarm_msk = LTC2992_GPIO2_FAULT_MSK(1),
> +		.ctrl = LTC2992_GPIO_IO_CTRL,
> +		.ctrl_bit = LTC2992_GPIO2_BIT,
>  	},
>  	{
>  		.data = LTC2992_G3,
> @@ -143,6 +163,8 @@ static const struct ltc2992_gpio_regs ltc2992_gpio_addr_map[] = {
>  		.alarm = LTC2992_FAULT3,
>  		.min_alarm_msk = LTC2992_GPIO3_FAULT_MSK(0),
>  		.max_alarm_msk = LTC2992_GPIO3_FAULT_MSK(1),
> +		.ctrl = LTC2992_GPIO_IO_CTRL,
> +		.ctrl_bit = LTC2992_GPIO3_BIT,
>  	},
>  	{
>  		.data = LTC2992_G4,
> @@ -153,14 +175,20 @@ static const struct ltc2992_gpio_regs ltc2992_gpio_addr_map[] = {
>  		.alarm = LTC2992_FAULT3,
>  		.min_alarm_msk = LTC2992_GPIO4_FAULT_MSK(0),
>  		.max_alarm_msk = LTC2992_GPIO4_FAULT_MSK(1),
> +		.ctrl = LTC2992_GPIO_CTRL,
> +		.ctrl_bit = LTC2992_GPIO4_BIT,
>  	},
>  };
>  
> +static const char *ltc2992_gpio_names[LTC2992_GPIO_NR] = {
> +	"GPIO1", "GPIO2", "GPIO3", "GPIO4",
> +};
> +
>  static int ltc2992_read_reg(struct ltc2992_state *st, u8 addr, const u8 reg_len)
>  {
>  	u8 regvals[4];
> -	int ret;
>  	int val;
> +	int ret;
>  	int i;
>  
>  	ret = regmap_bulk_read(st->regmap, addr, regvals, reg_len);
> @@ -185,6 +213,132 @@ static int ltc2992_write_reg(struct ltc2992_state *st, u8 addr, const u8 reg_len
>  	return regmap_bulk_write(st->regmap, addr, regvals, reg_len);
>  }
>  
> +static int ltc2992_gpio_get(struct gpio_chip *chip, unsigned int offset)
> +{
> +	struct ltc2992_state *st = gpiochip_get_data(chip);
> +	unsigned long gpio_status;
> +	int reg;
> +
> +	mutex_lock(&st->gpio_mutex);
> +	reg = ltc2992_read_reg(st, LTC2992_GPIO_STATUS, 1);
> +	mutex_unlock(&st->gpio_mutex);
> +
> +	if (reg < 0)
> +		return reg;
> +
> +	gpio_status = reg;
> +
> +	return !test_bit(LTC2992_GPIO_BIT(offset), &gpio_status);
> +}
> +
> +static int ltc2992_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
> +				     unsigned long *bits)
> +{
> +	struct ltc2992_state *st = gpiochip_get_data(chip);
> +	unsigned long gpio_status;
> +	unsigned int gpio_nr;
> +	int reg;
> +
> +	mutex_lock(&st->gpio_mutex);
> +	reg = ltc2992_read_reg(st, LTC2992_GPIO_STATUS, 1);
> +	mutex_unlock(&st->gpio_mutex);
> +
> +	if (reg < 0)
> +		return reg;
> +
> +	gpio_status = reg;
> +
> +	gpio_nr = 0;
> +	for_each_set_bit_from(gpio_nr, mask, LTC2992_GPIO_NR) {
> +		if (test_bit(LTC2992_GPIO_BIT(gpio_nr), &gpio_status))
> +			set_bit(gpio_nr, bits);
> +	}
> +
> +	return 0;
> +}
> +
> +static void ltc2992_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
> +{
> +	struct ltc2992_state *st = gpiochip_get_data(chip);
> +	unsigned long gpio_ctrl;
> +	int reg;
> +
> +	mutex_lock(&st->gpio_mutex);
> +	reg = ltc2992_read_reg(st, ltc2992_gpio_addr_map[offset].ctrl, 1);
> +	if (reg < 0) {
> +		mutex_unlock(&st->gpio_mutex);
> +		return;
> +	}
> +
> +	gpio_ctrl = reg;
> +	assign_bit(ltc2992_gpio_addr_map[offset].ctrl_bit, &gpio_ctrl, value);
> +
> +	ltc2992_write_reg(st, ltc2992_gpio_addr_map[offset].ctrl, 1, gpio_ctrl);
> +	mutex_unlock(&st->gpio_mutex);
> +}
> +
> +static void ltc2992_gpio_set_multiple(struct gpio_chip *chip, unsigned long *mask,
> +				      unsigned long *bits)
> +{
> +	struct ltc2992_state *st = gpiochip_get_data(chip);
> +	unsigned long gpio_ctrl_io = 0;
> +	unsigned long gpio_ctrl = 0;
> +	unsigned int gpio_nr;
> +
> +	for_each_set_bit(gpio_nr, mask, LTC2992_GPIO_NR) {
> +		if (gpio_nr < 3)
> +			assign_bit(ltc2992_gpio_addr_map[gpio_nr].ctrl_bit, &gpio_ctrl_io, true);
> +
> +		if (gpio_nr == 3)
> +			assign_bit(ltc2992_gpio_addr_map[gpio_nr].ctrl_bit, &gpio_ctrl, true);
> +	}
> +
> +	mutex_lock(&st->gpio_mutex);
> +	ltc2992_write_reg(st, LTC2992_GPIO_IO_CTRL, 1, gpio_ctrl_io);
> +	ltc2992_write_reg(st, LTC2992_GPIO_CTRL, 1, gpio_ctrl);
> +	mutex_unlock(&st->gpio_mutex);
> +}
> +
> +static int ltc2992_config_gpio(struct ltc2992_state *st)
> +{
> +	const char *name = dev_name(&st->client->dev);
> +	char *gpio_name;
> +	int ret;
> +	int i;
> +
> +	ret = ltc2992_write_reg(st, LTC2992_GPIO_IO_CTRL, 1, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	mutex_init(&st->gpio_mutex);
> +
> +	for (i = 0; i < ARRAY_SIZE(st->gpio_names); i++) {
> +		gpio_name = devm_kasprintf(&st->client->dev, GFP_KERNEL, "ltc2992-%x-%s",
> +					   st->client->addr, ltc2992_gpio_names[i]);
> +		if (!gpio_name)
> +			return -ENOMEM;
> +
> +		st->gpio_names[i] = gpio_name;
> +	}
> +
> +	st->gc.label = name;
> +	st->gc.parent = &st->client->dev;
> +	st->gc.owner = THIS_MODULE;
> +	st->gc.base = -1;
> +	st->gc.names = st->gpio_names;
> +	st->gc.ngpio = ARRAY_SIZE(st->gpio_names);
> +	st->gc.get = ltc2992_gpio_get;
> +	st->gc.get_multiple = ltc2992_gpio_get_multiple;
> +	st->gc.set = ltc2992_gpio_set;
> +	st->gc.set_multiple = ltc2992_gpio_set_multiple;
> +
> +	ret = devm_gpiochip_add_data(&st->client->dev, &st->gc, st);
> +	if (ret)
> +		dev_err(&st->client->dev, "GPIO registering failed (%d)\n", ret);
> +
> +	return ret;
> +}
> +
>  static umode_t ltc2992_is_visible(const void *data, enum hwmon_sensor_types type, u32 attr,
>  				  int channel)
>  {
> @@ -779,6 +933,10 @@ static int ltc2992_i2c_probe(struct i2c_client *client, const struct i2c_device_
>  	if (ret < 0)
>  		return ret;
>  
> +	ret = ltc2992_config_gpio(st);
> +	if (ret < 0)
> +		return ret;
> +
>  	hwmon_dev = devm_hwmon_device_register_with_info(&client->dev, client->name, st,
>  							 &ltc2992_chip_info, NULL);
>  
> -- 
> 2.20.1
> 
