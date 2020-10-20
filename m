Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84466285420
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 23:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbgJFVwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 17:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgJFVwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 17:52:03 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACC1C061755;
        Tue,  6 Oct 2020 14:52:03 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id n61so278325ota.10;
        Tue, 06 Oct 2020 14:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rzxHRgiHlz3JRFsvnPJw+BR0dBB7PId8TiaQAFAvBh0=;
        b=Od1XSQqbiJNCiQFMRWUnrHZEqw8FDzdkS+LeJtVoxAfvWjQjZFPjo0UwG5Qza0Omb8
         7PimikV22XEfP969Gat7vFNx2lL7/6ULncdoQ8BbPNlOzFUIYc0XuQ7J3mcmUISHrd8u
         8YZTLf/eKTyU6KQ75eouNpmlGRJmEoEXxTTU+BuKX+TR/zP3M1pwA038oc72eUe39OZd
         42yQRLzHmzcBI91hIb9rhuFmloa/fzt/IxGHNbmMgEot51DgCTIGG8bGomY7n753PFa6
         xg4UJSPw06dlyqg7YcAwqw4XHyKKwKBmVllbSsuPnWLokMRz2cduJzW4iXWRmY2HLM6S
         wYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=rzxHRgiHlz3JRFsvnPJw+BR0dBB7PId8TiaQAFAvBh0=;
        b=ttXVWx7Lj65zjhEvdIulTE7vLrLM9dKUBcg5Z/UkwUpZJ0tbVKlFYAX2dJoBQr4XzM
         3gJPOHpF+JmFRUz9byFXXCFylOP0vhy1vJu9nSWScwNcUyK6j19qRCQDzDT0X0X9VY2d
         NhEtXHdSRUWsJavB0ETTteAlJLkEuhaUi/NJTSIHksrVaoWV/wzhJszivApdoxIjqpr2
         wxogbV3uYPfAyZ8Or6UhByEYq51w0rAFkGHnf0Djve7YMvYMEE9+caDFEhf9zP4JbChp
         jdKlLk+H+0fpg3LLDY5encGgjemxvPCJtoxzUy+ptecEqjVW3LmA2vQg1xwjvCjADHqy
         JjxQ==
X-Gm-Message-State: AOAM531NbNXOwqf0vxjQzII0K2Lwqbx8I1PGQlmzSS/rhe/ZLUqu9W36
        C1wamHpZGByxAKGIwCZKIPc=
X-Google-Smtp-Source: ABdhPJx160sTk3sVX45FpAC/oLGkKcnwqTJ15pQ/sFjj3vNk15UJX/ePUf3lITQumiO38OkjKWiOpQ==
X-Received: by 2002:a05:6830:83c:: with SMTP id t28mr27261ots.20.1602021122859;
        Tue, 06 Oct 2020 14:52:02 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c7sm35633ots.20.2020.10.06.14.52.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Oct 2020 14:52:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 6 Oct 2020 14:52:01 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     jdelvare@suse.com, p.zabel@pengutronix.de,
        linux-hwmon@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, songjun.Wu@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        rtanwar@maxlinear.com
Subject: Re: [PATCH v5 2/2] Add hardware monitoring driver for Moortec
 MR75203 PVT controller
Message-ID: <20201006215201.GA96396@roeck-us.net>
References: <cover.1601889876.git.rahul.tanwar@linux.intel.com>
 <05b59cd860d2a1aa0a68ab300829efe709645184.1601889876.git.rahul.tanwar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05b59cd860d2a1aa0a68ab300829efe709645184.1601889876.git.rahul.tanwar@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 05:27:46PM +0800, Rahul Tanwar wrote:
> PVT controller (MR75203) is used to configure & control
> Moortec embedded analog IP which contains temprature
> sensor(TS), voltage monitor(VM) & process detector(PD)
> modules. Add hardware monitoring driver to support
> MR75203 PVT controller.
> 
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/Kconfig   |  10 +
>  drivers/hwmon/Makefile  |   1 +
>  drivers/hwmon/mr75203.c | 656 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 667 insertions(+)
>  create mode 100644 drivers/hwmon/mr75203.c
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 8dc28b26916e..2defb46677b4 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1112,6 +1112,16 @@ config SENSORS_MENF21BMC_HWMON
>  	  This driver can also be built as a module. If so the module
>  	  will be called menf21bmc_hwmon.
>  
> +config SENSORS_MR75203
> +	tristate "Moortec Semiconductor MR75203 PVT Controller"
> +	select REGMAP_MMIO
> +	help
> +	  If you say yes here you get support for Moortec MR75203
> +	  PVT controller.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called mr75203.
> +
>  config SENSORS_ADCXX
>  	tristate "National Semiconductor ADCxxxSxxx"
>  	depends on SPI_MASTER
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index a8f4b35b136b..bb4bd92a5149 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -142,6 +142,7 @@ obj-$(CONFIG_SENSORS_MCP3021)	+= mcp3021.o
>  obj-$(CONFIG_SENSORS_TC654)	+= tc654.o
>  obj-$(CONFIG_SENSORS_MLXREG_FAN) += mlxreg-fan.o
>  obj-$(CONFIG_SENSORS_MENF21BMC_HWMON) += menf21bmc_hwmon.o
> +obj-$(CONFIG_SENSORS_MR75203)	+= mr75203.o
>  obj-$(CONFIG_SENSORS_NCT6683)	+= nct6683.o
>  obj-$(CONFIG_SENSORS_NCT6775)	+= nct6775.o
>  obj-$(CONFIG_SENSORS_NCT7802)	+= nct7802.o
> diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
> new file mode 100644
> index 000000000000..18da5a25e89a
> --- /dev/null
> +++ b/drivers/hwmon/mr75203.c
> @@ -0,0 +1,656 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020 MaxLinear, Inc.
> + *
> + * This driver is a hardware monitoring driver for PVT controller
> + * (MR75203) which is used to configure & control Moortec embedded
> + * analog IP to enable multiple embedded temperature sensor(TS),
> + * voltage monitor(VM) & process detector(PD) modules.
> + */
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/hwmon.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +
> +/* PVT Common register */
> +#define PVT_IP_CONFIG	0x04
> +#define TS_NUM_MSK	GENMASK(4, 0)
> +#define TS_NUM_SFT	0
> +#define PD_NUM_MSK	GENMASK(12, 8)
> +#define PD_NUM_SFT	8
> +#define VM_NUM_MSK	GENMASK(20, 16)
> +#define VM_NUM_SFT	16
> +#define CH_NUM_MSK	GENMASK(31, 24)
> +#define CH_NUM_SFT	24
> +
> +/* Macro Common Register */
> +#define CLK_SYNTH		0x00
> +#define CLK_SYNTH_LO_SFT	0
> +#define CLK_SYNTH_HI_SFT	8
> +#define CLK_SYNTH_HOLD_SFT	16
> +#define CLK_SYNTH_EN		BIT(24)
> +#define CLK_SYS_CYCLES_MAX	514
> +#define CLK_SYS_CYCLES_MIN	2
> +#define HZ_PER_MHZ		1000000L
> +
> +#define SDIF_DISABLE	0x04
> +
> +#define SDIF_STAT	0x08
> +#define SDIF_BUSY	BIT(0)
> +#define SDIF_LOCK	BIT(1)
> +
> +#define SDIF_W		0x0c
> +#define SDIF_PROG	BIT(31)
> +#define SDIF_WRN_W	BIT(27)
> +#define SDIF_WRN_R	0x00
> +#define SDIF_ADDR_SFT	24
> +
> +#define SDIF_HALT	0x10
> +#define SDIF_CTRL	0x14
> +#define SDIF_SMPL_CTRL	0x20
> +
> +/* TS & PD Individual Macro Register */
> +#define COM_REG_SIZE	0x40
> +
> +#define SDIF_DONE(n)	(COM_REG_SIZE + 0x14 + 0x40 * (n))
> +#define SDIF_SMPL_DONE	BIT(0)
> +
> +#define SDIF_DATA(n)	(COM_REG_SIZE + 0x18 + 0x40 * (n))
> +#define SAMPLE_DATA_MSK	GENMASK(15, 0)
> +
> +#define HILO_RESET(n)	(COM_REG_SIZE + 0x2c + 0x40 * (n))
> +
> +/* VM Individual Macro Register */
> +#define VM_COM_REG_SIZE	0x200
> +#define VM_SDIF_DONE(n)	(VM_COM_REG_SIZE + 0x34 + 0x200 * (n))
> +#define VM_SDIF_DATA(n)	(VM_COM_REG_SIZE + 0x40 + 0x200 * (n))
> +
> +/* SDA Slave Register */
> +#define IP_CTRL			0x00
> +#define IP_RST_REL		BIT(1)
> +#define IP_RUN_CONT		BIT(3)
> +#define IP_AUTO			BIT(8)
> +#define IP_VM_MODE		BIT(10)
> +
> +#define IP_CFG			0x01
> +#define CFG0_MODE_2		BIT(0)
> +#define CFG0_PARALLEL_OUT	0
> +#define CFG0_12_BIT		0
> +#define CFG1_VOL_MEAS_MODE	0
> +#define CFG1_PARALLEL_OUT	0
> +#define CFG1_14_BIT		0
> +
> +#define IP_DATA		0x03
> +
> +#define IP_POLL		0x04
> +#define VM_CH_INIT	BIT(20)
> +#define VM_CH_REQ	BIT(21)
> +
> +#define IP_TMR			0x05
> +#define POWER_DELAY_CYCLE_256	0x80
> +#define POWER_DELAY_CYCLE_64	0x40
> +
> +#define PVT_POLL_DELAY_US	20
> +#define PVT_POLL_TIMEOUT_US	20000
> +#define PVT_H_CONST		100000
> +#define PVT_CAL5_CONST		2047
> +#define PVT_G_CONST		40000
> +#define PVT_CONV_BITS		10
> +#define PVT_N_CONST		90
> +#define PVT_R_CONST		245805
> +
> +struct pvt_device {
> +	struct regmap		*c_map;
> +	struct regmap		*t_map;
> +	struct regmap		*p_map;
> +	struct regmap		*v_map;
> +	struct clk		*clk;
> +	struct reset_control	*rst;
> +	u32			t_num;
> +	u32			p_num;
> +	u32			v_num;
> +	u32			ip_freq;
> +	u8			*vm_idx;
> +};
> +
> +static umode_t pvt_is_visible(const void *data, enum hwmon_sensor_types type,
> +			      u32 attr, int channel)
> +{
> +	switch (type) {
> +	case hwmon_temp:
> +		if (attr == hwmon_temp_input)
> +			return 0444;
> +		break;
> +	case hwmon_in:
> +		if (attr == hwmon_in_input)
> +			return 0444;
> +		break;
> +	default:
> +		break;
> +	}
> +	return 0;
> +}
> +
> +static int pvt_read_temp(struct device *dev, u32 attr, int channel, long *val)
> +{
> +	struct pvt_device *pvt = dev_get_drvdata(dev);
> +	struct regmap *t_map = pvt->t_map;
> +	u32 stat, nbs;
> +	int ret;
> +	u64 tmp;
> +
> +	switch (attr) {
> +	case hwmon_temp_input:
> +		ret = regmap_read_poll_timeout(t_map, SDIF_DONE(channel),
> +					       stat, stat & SDIF_SMPL_DONE,
> +					       PVT_POLL_DELAY_US,
> +					       PVT_POLL_TIMEOUT_US);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_read(t_map, SDIF_DATA(channel), &nbs);
> +		if(ret < 0)
> +			return ret;
> +
> +		nbs &= SAMPLE_DATA_MSK;
> +
> +		/*
> +		 * Convert the register value to
> +		 * degrees centigrade temperature
> +		 */
> +		tmp = nbs * PVT_H_CONST;
> +		do_div(tmp, PVT_CAL5_CONST);
> +		*val = tmp - PVT_G_CONST - pvt->ip_freq;
> +
> +		return 0;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int pvt_read_in(struct device *dev, u32 attr, int channel, long *val)
> +{
> +	struct pvt_device *pvt = dev_get_drvdata(dev);
> +	struct regmap *v_map = pvt->v_map;
> +	u32 n, stat;
> +	u8 vm_idx;
> +	int ret;
> +
> +	if (channel >= pvt->v_num)
> +		return -EINVAL;
> +
> +	vm_idx = pvt->vm_idx[channel];
> +
> +	switch (attr) {
> +	case hwmon_in_input:
> +		ret = regmap_read_poll_timeout(v_map, VM_SDIF_DONE(vm_idx),
> +					       stat, stat & SDIF_SMPL_DONE,
> +					       PVT_POLL_DELAY_US,
> +					       PVT_POLL_TIMEOUT_US);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_read(v_map, VM_SDIF_DATA(vm_idx), &n);
> +		if(ret < 0)
> +			return ret;
> +
> +		n &= SAMPLE_DATA_MSK;
> +		/* Convert the N bitstream count into voltage */
> +		*val = (PVT_N_CONST * n - PVT_R_CONST) >> PVT_CONV_BITS;
> +
> +		return 0;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int pvt_read(struct device *dev, enum hwmon_sensor_types type,
> +		    u32 attr, int channel, long *val)
> +{
> +	switch (type) {
> +	case hwmon_temp:
> +		return pvt_read_temp(dev, attr, channel, val);
> +	case hwmon_in:
> +		return pvt_read_in(dev, attr, channel, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static const u32 pvt_chip_config[] = {
> +	HWMON_C_REGISTER_TZ,
> +	0
> +};
> +
> +static const struct hwmon_channel_info pvt_chip = {
> +	.type = hwmon_chip,
> +	.config = pvt_chip_config,
> +};
> +
> +static struct hwmon_channel_info pvt_temp = {
> +	.type = hwmon_temp,
> +};
> +
> +static struct hwmon_channel_info pvt_in = {
> +	.type = hwmon_in,
> +};
> +
> +static const struct hwmon_ops pvt_hwmon_ops = {
> +	.is_visible = pvt_is_visible,
> +	.read = pvt_read,
> +};
> +
> +static struct hwmon_chip_info pvt_chip_info = {
> +	.ops = &pvt_hwmon_ops,
> +};
> +
> +static int pvt_init(struct pvt_device *pvt)
> +{
> +	u16 sys_freq, key, middle, low = 4, high = 8;
> +	struct regmap *t_map = pvt->t_map;
> +	struct regmap *p_map = pvt->p_map;
> +	struct regmap *v_map = pvt->v_map;
> +	u32 t_num = pvt->t_num;
> +	u32 p_num = pvt->p_num;
> +	u32 v_num = pvt->v_num;
> +	u32 clk_synth, val;
> +	int ret;
> +
> +	sys_freq = clk_get_rate(pvt->clk) / HZ_PER_MHZ;
> +	while (high >= low) {
> +		middle = (low + high + 1) / 2;
> +		key = DIV_ROUND_CLOSEST(sys_freq, middle);
> +		if (key > CLK_SYS_CYCLES_MAX) {
> +			low = middle + 1;
> +			continue;
> +		} else if (key < CLK_SYS_CYCLES_MIN) {
> +			high = middle - 1;
> +			continue;
> +		} else {
> +			break;
> +		}
> +	}
> +
> +	/*
> +	 * The system supports 'clk_sys' to 'clk_ip' frequency ratios
> +	 * from 2:1 to 512:1
> +	 */
> +	key = clamp_val(key, CLK_SYS_CYCLES_MIN, CLK_SYS_CYCLES_MAX) - 2;
> +
> +	clk_synth = ((key + 1) >> 1) << CLK_SYNTH_LO_SFT |
> +		    (key >> 1) << CLK_SYNTH_HI_SFT |
> +		    (key >> 1) << CLK_SYNTH_HOLD_SFT | CLK_SYNTH_EN;
> +
> +	pvt->ip_freq = sys_freq * 100 / (key + 2);
> +
> +	if (t_num) {
> +		ret = regmap_write(t_map, SDIF_SMPL_CTRL, 0x0);
> +		if(ret < 0)
> +			return ret;
> +
> +		ret = regmap_write(t_map, SDIF_HALT, 0x0);
> +		if(ret < 0)
> +			return ret;
> +
> +		ret = regmap_write(t_map, CLK_SYNTH, clk_synth);
> +		if(ret < 0)
> +			return ret;
> +
> +		ret = regmap_write(t_map, SDIF_DISABLE, 0x0);
> +		if(ret < 0)
> +			return ret;
> +
> +		ret = regmap_read_poll_timeout(t_map, SDIF_STAT,
> +					       val, !(val & SDIF_BUSY),
> +					       PVT_POLL_DELAY_US,
> +					       PVT_POLL_TIMEOUT_US);
> +		if (ret)
> +			return ret;
> +
> +		val = CFG0_MODE_2 | CFG0_PARALLEL_OUT | CFG0_12_BIT |
> +		      IP_CFG << SDIF_ADDR_SFT | SDIF_WRN_W | SDIF_PROG;
> +		ret = regmap_write(t_map, SDIF_W, val);
> +		if(ret < 0)
> +			return ret;
> +
> +		ret = regmap_read_poll_timeout(t_map, SDIF_STAT,
> +					       val, !(val & SDIF_BUSY),
> +					       PVT_POLL_DELAY_US,
> +					       PVT_POLL_TIMEOUT_US);
> +		if (ret)
> +			return ret;
> +
> +		val = POWER_DELAY_CYCLE_256 | IP_TMR << SDIF_ADDR_SFT |
> +			      SDIF_WRN_W | SDIF_PROG;
> +		ret = regmap_write(t_map, SDIF_W, val);
> +		if(ret < 0)
> +			return ret;
> +
> +		ret = regmap_read_poll_timeout(t_map, SDIF_STAT,
> +					       val, !(val & SDIF_BUSY),
> +					       PVT_POLL_DELAY_US,
> +					       PVT_POLL_TIMEOUT_US);
> +		if (ret)
> +			return ret;
> +
> +		val = IP_RST_REL | IP_RUN_CONT | IP_AUTO |
> +		      IP_CTRL << SDIF_ADDR_SFT |
> +		      SDIF_WRN_W | SDIF_PROG;
> +		ret = regmap_write(t_map, SDIF_W, val);
> +		if(ret < 0)
> +			return ret;
> +	}
> +
> +	if (p_num) {
> +		ret = regmap_write(p_map, SDIF_HALT, 0x0);
> +		if(ret < 0)
> +			return ret;
> +
> +		ret = regmap_write(p_map, SDIF_DISABLE, BIT(p_num) - 1);
> +		if(ret < 0)
> +			return ret;
> +
> +		ret = regmap_write(p_map, CLK_SYNTH, clk_synth);
> +		if(ret < 0)
> +			return ret;
> +	}
> +
> +	if (v_num) {
> +		ret = regmap_write(v_map, SDIF_SMPL_CTRL, 0x0);
> +		if(ret < 0)
> +			return ret;
> +
> +		ret = regmap_write(v_map, SDIF_HALT, 0x0);
> +		if(ret < 0)
> +			return ret;
> +
> +		ret = regmap_write(v_map, CLK_SYNTH, clk_synth);
> +		if(ret < 0)
> +			return ret;
> +
> +		ret = regmap_write(v_map, SDIF_DISABLE, 0x0);
> +		if(ret < 0)
> +			return ret;
> +
> +		ret = regmap_read_poll_timeout(v_map, SDIF_STAT,
> +					       val, !(val & SDIF_BUSY),
> +					       PVT_POLL_DELAY_US,
> +					       PVT_POLL_TIMEOUT_US);
> +		if (ret)
> +			return ret;
> +
> +		val = CFG1_VOL_MEAS_MODE | CFG1_PARALLEL_OUT |
> +		      CFG1_14_BIT | IP_CFG << SDIF_ADDR_SFT |
> +		      SDIF_WRN_W | SDIF_PROG;
> +		ret = regmap_write(v_map, SDIF_W, val);
> +		if(ret < 0)
> +			return ret;
> +
> +		ret = regmap_read_poll_timeout(v_map, SDIF_STAT,
> +					       val, !(val & SDIF_BUSY),
> +					       PVT_POLL_DELAY_US,
> +					       PVT_POLL_TIMEOUT_US);
> +		if (ret)
> +			return ret;
> +
> +		val = POWER_DELAY_CYCLE_64 | IP_TMR << SDIF_ADDR_SFT |
> +		      SDIF_WRN_W | SDIF_PROG;
> +		ret = regmap_write(v_map, SDIF_W, val);
> +		if(ret < 0)
> +			return ret;
> +
> +		ret = regmap_read_poll_timeout(v_map, SDIF_STAT,
> +					       val, !(val & SDIF_BUSY),
> +					       PVT_POLL_DELAY_US,
> +					       PVT_POLL_TIMEOUT_US);
> +		if (ret)
> +			return ret;
> +
> +		val = IP_RST_REL | IP_RUN_CONT | IP_AUTO | IP_VM_MODE |
> +		      IP_CTRL << SDIF_ADDR_SFT |
> +		      SDIF_WRN_W | SDIF_PROG;
> +		ret = regmap_write(v_map, SDIF_W, val);
> +		if(ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct regmap_config pvt_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +};
> +
> +static int pvt_get_regmap(struct platform_device *pdev, char *reg_name,
> +			  struct pvt_device *pvt)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct regmap **reg_map;
> +	void __iomem *io_base;
> +
> +	if (!strcmp(reg_name, "common"))
> +		reg_map = &pvt->c_map;
> +	else if (!strcmp(reg_name, "ts"))
> +		reg_map = &pvt->t_map;
> +	else if (!strcmp(reg_name, "pd"))
> +		reg_map = &pvt->p_map;
> +	else if (!strcmp(reg_name, "vm"))
> +		reg_map = &pvt->v_map;
> +	else
> +		return -EINVAL;
> +
> +	io_base = devm_platform_ioremap_resource_byname(pdev, reg_name);
> +	if (IS_ERR(io_base))
> +		return PTR_ERR(io_base);
> +
> +	pvt_regmap_config.name = reg_name;
> +	*reg_map = devm_regmap_init_mmio(dev, io_base, &pvt_regmap_config);
> +	if (IS_ERR(*reg_map)) {
> +		dev_err(dev, "failed to init register map\n");
> +		return PTR_ERR(*reg_map);
> +	}
> +
> +	return 0;
> +}
> +
> +static void pvt_clk_disable(void *data)
> +{
> +	struct pvt_device *pvt = data;
> +
> +	clk_disable_unprepare(pvt->clk);
> +}
> +
> +static int pvt_clk_enable(struct device *dev, struct pvt_device *pvt)
> +{
> +	int ret;
> +
> +	ret = clk_prepare_enable(pvt->clk);
> +	if (ret)
> +		return ret;
> +
> +	return devm_add_action_or_reset(dev, pvt_clk_disable, pvt);
> +}
> +
> +static void pvt_reset_control_assert(void *data)
> +{
> +	struct pvt_device *pvt = data;
> +
> +	reset_control_assert(pvt->rst);
> +}
> +
> +static int pvt_reset_control_deassert(struct device *dev, struct pvt_device *pvt)
> +{
> +	int ret;
> +
> +	ret = reset_control_deassert(pvt->rst);
> +	if (ret)
> +		return ret;
> +
> +	return devm_add_action_or_reset(dev, pvt_reset_control_assert, pvt);
> +}
> +
> +static int mr75203_probe(struct platform_device *pdev)
> +{
> +	const struct hwmon_channel_info **pvt_info;
> +	u32 ts_num, vm_num, pd_num, val, index, i;
> +	struct device *dev = &pdev->dev;
> +	u32 *temp_config, *in_config;
> +	struct device *hwmon_dev;
> +	struct pvt_device *pvt;
> +	int ret;
> +
> +	pvt = devm_kzalloc(dev, sizeof(*pvt), GFP_KERNEL);
> +	if (!pvt)
> +		return -ENOMEM;
> +
> +	ret = pvt_get_regmap(pdev, "common", pvt);
> +	if (ret)
> +		return ret;
> +
> +	pvt->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(pvt->clk))
> +		return dev_err_probe(dev, PTR_ERR(pvt->clk), "failed to get clock\n");
> +
> +	ret = pvt_clk_enable(dev, pvt);
> +	if (ret) {
> +		dev_err(dev, "failed to enable clock\n");
> +		return ret;
> +	}
> +
> +	pvt->rst = devm_reset_control_get_exclusive(dev, NULL);
> +	if (IS_ERR(pvt->rst))
> +		return dev_err_probe(dev, PTR_ERR(pvt->rst),
> +				     "failed to get reset control\n");
> +
> +	ret = pvt_reset_control_deassert(dev, pvt);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "cannot deassert reset control\n");
> +
> +	ret = regmap_read(pvt->c_map, PVT_IP_CONFIG, &val);
> +	if(ret < 0)
> +		return ret;
> +
> +	ts_num = (val & TS_NUM_MSK) >> TS_NUM_SFT;
> +	pd_num = (val & PD_NUM_MSK) >> PD_NUM_SFT;
> +	vm_num = (val & VM_NUM_MSK) >> VM_NUM_SFT;
> +	pvt->t_num = ts_num;
> +	pvt->p_num = pd_num;
> +	pvt->v_num = vm_num;
> +	val = 0;
> +	if (ts_num)
> +		val++;
> +	if (vm_num)
> +		val++;
> +	if (!val)
> +		return -ENODEV;
> +
> +	pvt_info = devm_kcalloc(dev, val + 2, sizeof(*pvt_info), GFP_KERNEL);
> +	if (!pvt_info)
> +		return -ENOMEM;
> +	pvt_info[0] = &pvt_chip;
> +	index = 1;
> +
> +	if (ts_num) {
> +		ret = pvt_get_regmap(pdev, "ts", pvt);
> +		if (ret)
> +			return ret;
> +
> +		temp_config = devm_kcalloc(dev, ts_num + 1,
> +					   sizeof(*temp_config), GFP_KERNEL);
> +		if (!temp_config)
> +			return -ENOMEM;
> +
> +		memset32(temp_config, HWMON_T_INPUT, ts_num);
> +		pvt_temp.config = temp_config;
> +		pvt_info[index++] = &pvt_temp;
> +	}
> +
> +	if (pd_num) {
> +		ret = pvt_get_regmap(pdev, "pd", pvt);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (vm_num) {
> +		u32 num = vm_num;
> +
> +		ret = pvt_get_regmap(pdev, "vm", pvt);
> +		if (ret)
> +			return ret;
> +
> +		pvt->vm_idx = devm_kcalloc(dev, vm_num, sizeof(*pvt->vm_idx),
> +					   GFP_KERNEL);
> +		if (!pvt->vm_idx)
> +			return -ENOMEM;
> +
> +		ret = device_property_read_u8_array(dev, "intel,vm-map",
> +						    pvt->vm_idx, vm_num);
> +		if (ret) {
> +			num = 0;
> +		} else {
> +			for (i = 0; i < vm_num; i++)
> +				if (pvt->vm_idx[i] >= vm_num ||
> +				    pvt->vm_idx[i] == 0xff) {
> +					num = i;
> +					break;
> +				}
> +		}
> +
> +		/*
> +		 * Incase intel,vm-map property is not defined, we assume
> +		 * incremental channel numbers.
> +		 */
> +		for (i = num; i < vm_num; i++)
> +			pvt->vm_idx[i] = i;
> +
> +		in_config = devm_kcalloc(dev, num + 1,
> +					 sizeof(*in_config), GFP_KERNEL);
> +		if (!in_config)
> +			return -ENOMEM;
> +
> +		memset32(in_config, HWMON_I_INPUT, num);
> +		in_config[num] = 0;
> +		pvt_in.config = in_config;
> +
> +		pvt_info[index++] = &pvt_in;
> +	}
> +
> +	ret = pvt_init(pvt);
> +	if (ret) {
> +		dev_err(dev, "failed to init pvt: %d\n", ret);
> +		return ret;
> +	}
> +
> +	pvt_chip_info.info = pvt_info;
> +	hwmon_dev = devm_hwmon_device_register_with_info(dev, "pvt",
> +							 pvt,
> +							 &pvt_chip_info,
> +							 NULL);
> +
> +	return PTR_ERR_OR_ZERO(hwmon_dev);
> +}
> +
> +static const struct of_device_id moortec_pvt_of_match[] = {
> +	{ .compatible = "moortec,mr75203" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, moortec_pvt_of_match);
> +
> +static struct platform_driver moortec_pvt_driver = {
> +	.driver = {
> +		.name = "moortec-pvt",
> +		.of_match_table = moortec_pvt_of_match,
> +	},
> +	.probe = mr75203_probe,
> +};
> +module_platform_driver(moortec_pvt_driver);
> +
> +MODULE_LICENSE("GPL v2");
