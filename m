Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C54212978FB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 23:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756803AbgJWVkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 17:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756795AbgJWVkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 17:40:11 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5E1C0613CE;
        Fri, 23 Oct 2020 14:40:11 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id s21so3425547oij.0;
        Fri, 23 Oct 2020 14:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7NwhGKucfWtNS9zsx2seIu37AQoXTHpBbnOjktkrTLA=;
        b=BjqqpeqcH/Y6tjazLj+Zaapt/yMkqCdQt2JSJw1w/kVwwJzS12BCH/XqF/7ArdaP+Q
         U6EaD6bTkX5HQ85BF9Fpxj3zgnb4T6y+4qwb+VCelQm8RV8IDkUdYgu6Fk8axR5zK892
         wavT9h588oAw9iEXS13NYKgcOgF8UEDwCqQrMZD2SGeN/4JiSGwW1Ut0wipvEw3gSAN2
         YkX5NUeXU+zBSxTXh5zEN26QRg+cWhUxv9FymuoXGOFKUgor0J1ECO2Ql6+mR+5k6mIE
         4accQUS8c/Q9E9NeiPtM5Dt+o80Nb79zaxaNatWyNGxUkcy41XIodBGNMr81C5LMVIP5
         u41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7NwhGKucfWtNS9zsx2seIu37AQoXTHpBbnOjktkrTLA=;
        b=jPIgDcoSonfdgSEC4uO9v19bYD57m3yYZ98tzNAeipFWFjLnn1p5c7BYK7APQDNPuR
         oeQFuHGatodKzm9oLvKyeoix1Dw1UC8vpF/lnWYMGt15UcWXi6IbnServvnGNBzV0bUw
         oJfrmrJjX3RWVaeLd9Tw5DY1VJt67NQvLwN1yD1L0O9E23DTbImC6xi4TXBBhnvhqAqx
         uTck8pBwAPrsVdAF84M8PHuA/Kv/8KrU3WnF79IbLW2SitE68/P3H3MQVYeCN6NitO5S
         LeG0f6/2hyGdO/HRwX+WhXCAXr1XTDsyBnTk08fPQaEh1VlG3Kftsrn3fiKLMCDwTPYu
         vSfg==
X-Gm-Message-State: AOAM531r4w9MlzjrrkdqLqMWCEJPoRXP9Qy0BvJX+cmLr9uq/unIa3Pg
        0j1NIy7GohD0FM5CA6EkJ+k=
X-Google-Smtp-Source: ABdhPJzIVwzuUSwWIqIed8iHhikkQfe+k+LQBuO6pKnAReOlXWwJX8eYaC/pQU6f1ZxGMuChuwyXpA==
X-Received: by 2002:a05:6808:7d0:: with SMTP id f16mr3606828oij.63.1603489210104;
        Fri, 23 Oct 2020 14:40:10 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p17sm663510oov.1.2020.10.23.14.40.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Oct 2020 14:40:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 23 Oct 2020 14:40:08 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     jdelvare@suse.com, Tobi Wulff <tobi.wulff@alliedtelesis.co.nz>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: (adt7470) Convert to regmap
Message-ID: <20201023214008.GA29435@roeck-us.net>
References: <20201019223423.31488-1-chris.packham@alliedtelesis.co.nz>
 <20201019223423.31488-3-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019223423.31488-3-chris.packham@alliedtelesis.co.nz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 11:34:23AM +1300, Chris Packham wrote:
> Convert the adt7470 to using regmap and add error handling.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  drivers/hwmon/adt7470.c | 388 ++++++++++++++++++++++++++--------------
>  1 file changed, 250 insertions(+), 138 deletions(-)
> 
> diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
> index 2e8feacccf84..d20aeb3a2fdc 100644
> --- a/drivers/hwmon/adt7470.c
> +++ b/drivers/hwmon/adt7470.c
> @@ -18,6 +18,7 @@
>  #include <linux/delay.h>
>  #include <linux/log2.h>
>  #include <linux/kthread.h>
> +#include <linux/regmap.h>
>  #include <linux/slab.h>
>  #include <linux/util_macros.h>
>  
> @@ -137,7 +138,7 @@ static const unsigned short normal_i2c[] = { 0x2C, 0x2E, 0x2F, I2C_CLIENT_END };
>  #define ADT7470_FREQ_SHIFT	4
>  
>  struct adt7470_data {
> -	struct i2c_client	*client;
> +	struct regmap		*regmap;
>  	struct mutex		lock;
>  	char			sensors_valid;
>  	char			limits_valid;
> @@ -171,51 +172,73 @@ struct adt7470_data {
>   * 16-bit registers on the ADT7470 are low-byte first.  The data sheet says
>   * that the low byte must be read before the high byte.
>   */
> -static inline int adt7470_read_word_data(struct i2c_client *client, u8 reg)
> +static inline int adt7470_read_word_data(struct adt7470_data *data, u8 reg)
>  {
> -	u16 foo;
> -	foo = i2c_smbus_read_byte_data(client, reg);
> -	foo |= ((u16)i2c_smbus_read_byte_data(client, reg + 1) << 8);
> -	return foo;
> +	u8 val[2];
> +	int err;
> +
> +	err = regmap_bulk_read(data->regmap, reg, &val, 2);
> +	if (err < 0)
> +		return err;
> +
> +	return val[0] | (val[1] << 8);
>  }
>  
> -static inline int adt7470_write_word_data(struct i2c_client *client, u8 reg,
> +static inline int adt7470_write_word_data(struct adt7470_data *data, u8 reg,
>  					  u16 value)
>  {
> -	return i2c_smbus_write_byte_data(client, reg, value & 0xFF)
> -	       || i2c_smbus_write_byte_data(client, reg + 1, value >> 8);
> +	u8 val[2];
> +
> +	val[0] = value & 0xFF;
> +	val[1] = value >> 8;
> +
> +	return regmap_bulk_write(data->regmap, reg, &val, 2);
>  }
>  
>  /* Probe for temperature sensors.  Assumes lock is held */
> -static int adt7470_read_temperatures(struct i2c_client *client,
> -				     struct adt7470_data *data)
> +static int adt7470_read_temperatures(struct adt7470_data *data)
>  {
>  	unsigned long res;
> +	int err;
>  	int i;
>  	u8 cfg, pwm[4], pwm_cfg[2];
>  
>  	/* save pwm[1-4] config register */
> -	pwm_cfg[0] = i2c_smbus_read_byte_data(client, ADT7470_REG_PWM_CFG(0));
> -	pwm_cfg[1] = i2c_smbus_read_byte_data(client, ADT7470_REG_PWM_CFG(2));
> +	err = regmap_raw_read(data->regmap, ADT7470_REG_PWM_CFG(0), &pwm_cfg[0], 1);
> +	if (err < 0)
> +		return err;
> +	err = regmap_raw_read(data->regmap, ADT7470_REG_PWM_CFG(2), &pwm_cfg[1], 1);
> +	if (err < 0)
> +		return err;
>  
>  	/* set manual pwm to whatever it is set to now */
> -	for (i = 0; i < ADT7470_FAN_COUNT; i++)
> -		pwm[i] = i2c_smbus_read_byte_data(client, ADT7470_REG_PWM(i));
> +	err = regmap_bulk_read(data->regmap, ADT7470_REG_PWM(0), &pwm[0], ADT7470_FAN_COUNT);
> +	if (err < 0)
> +		return err;
>  
>  	/* put pwm in manual mode */
> -	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM_CFG(0),
> -		pwm_cfg[0] & ~(ADT7470_PWM_AUTO_MASK));
> -	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM_CFG(2),
> -		pwm_cfg[1] & ~(ADT7470_PWM_AUTO_MASK));
> +	pwm_cfg[0] &= ~ADT7470_PWM_AUTO_MASK;
> +	err = regmap_raw_write(data->regmap, ADT7470_REG_PWM_CFG(0), &pwm_cfg[0], 1);
> +	if (err < 0)
> +		return err;
> +	pwm_cfg[1] &= ~ADT7470_PWM_AUTO_MASK;
> +	err = regmap_raw_write(data->regmap, ADT7470_REG_PWM_CFG(2), &pwm_cfg[1], 1);
> +	if (err < 0)
> +		return err;
>  
Any special reason for not using regmap_update_bits() ? Also, why
regmap_raw_read() and regmap_raw_write() instead of just regmap_read()
and regmap_write() ?

There is a lot of similar code below. I don't really see the benefit of
switching to regmap if we don't use the functions it provides.


>  	/* write pwm control to whatever it was */
> -	for (i = 0; i < ADT7470_FAN_COUNT; i++)
> -		i2c_smbus_write_byte_data(client, ADT7470_REG_PWM(i), pwm[i]);
> +	err = regmap_bulk_write(data->regmap, ADT7470_REG_PWM(0), &pwm[0], ADT7470_FAN_COUNT);
> +	if (err < 0)
> +		return err;
>  
>  	/* start reading temperature sensors */
> -	cfg = i2c_smbus_read_byte_data(client, ADT7470_REG_CFG);
> +	err = regmap_raw_read(data->regmap, ADT7470_REG_CFG, &cfg, 1);
> +	if (err < 0)
> +		return err;
>  	cfg |= 0x80;
> -	i2c_smbus_write_byte_data(client, ADT7470_REG_CFG, cfg);
> +	err = regmap_raw_write(data->regmap, ADT7470_REG_CFG, &cfg, 1);
> +	if (err < 0)
> +		return err;
>  
>  	/* Delay is 200ms * number of temp sensors. */
>  	res = msleep_interruptible((data->num_temp_sensors >= 0 ?
> @@ -223,13 +246,21 @@ static int adt7470_read_temperatures(struct i2c_client *client,
>  				    TEMP_COLLECTION_TIME));
>  
>  	/* done reading temperature sensors */
> -	cfg = i2c_smbus_read_byte_data(client, ADT7470_REG_CFG);
> +	err = regmap_raw_read(data->regmap, ADT7470_REG_CFG, &cfg, 1);
> +	if (err < 0)
> +		return err;
>  	cfg &= ~0x80;
> -	i2c_smbus_write_byte_data(client, ADT7470_REG_CFG, cfg);
> +	err = regmap_raw_write(data->regmap, ADT7470_REG_CFG, &cfg, 1);
> +	if (err < 0)
> +		return err;
>  
>  	/* restore pwm[1-4] config registers */
> -	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM_CFG(0), pwm_cfg[0]);
> -	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM_CFG(2), pwm_cfg[1]);
> +	err = regmap_raw_write(data->regmap, ADT7470_REG_PWM_CFG(0), &pwm_cfg[0], 1);
> +	if (err < 0)
> +		return err;
> +	err = regmap_raw_write(data->regmap, ADT7470_REG_PWM_CFG(2), &pwm_cfg[1], 1);
> +	if (err < 0)
> +		return err;
>  
>  	if (res) {
>  		pr_err("ha ha, interrupted\n");
> @@ -240,13 +271,16 @@ static int adt7470_read_temperatures(struct i2c_client *client,
>  	if (data->num_temp_sensors >= 0)
>  		return 0;
>  
> +	err = regmap_bulk_read(data->regmap, ADT7470_TEMP_REG(0), &data->temp[0],
> +			       ADT7470_TEMP_COUNT);
> +	if (err < 0)
> +		return err;
>  	for (i = 0; i < ADT7470_TEMP_COUNT; i++) {
> -		data->temp[i] = i2c_smbus_read_byte_data(client,
> -						ADT7470_TEMP_REG(i));
>  		if (data->temp[i])
>  			data->num_temp_sensors = i + 1;
>  	}
>  	data->temperatures_probed = 1;
> +

whitespace change

>  	return 0;
>  }
>  
> @@ -254,10 +288,11 @@ static int adt7470_update_thread(void *p)
>  {
>  	struct i2c_client *client = p;
>  	struct adt7470_data *data = i2c_get_clientdata(client);
> +	int err = 0;
>  
>  	while (!kthread_should_stop()) {
>  		mutex_lock(&data->lock);
> -		adt7470_read_temperatures(client, data);
> +		err = adt7470_read_temperatures(data);
>  		mutex_unlock(&data->lock);
>  
>  		set_current_state(TASK_INTERRUPTIBLE);
> @@ -267,94 +302,124 @@ static int adt7470_update_thread(void *p)
>  		schedule_timeout(msecs_to_jiffies(data->auto_update_interval));
>  	}
>  
> -	return 0;
> +	return err;

I don't immediately see the benefit of returning an error here.
That seems to be quite random (it only returns an error if the
most recent operation failed).

>  }
>  
>  static int adt7470_update_sensors(struct adt7470_data *data)
>  {
> -	struct i2c_client *client = data->client;
> +	int alarms_mask;
> +	u8 vals[2];
>  	u8 cfg;
> +	int err;
>  	int i;
>  
>  	if (!data->temperatures_probed)
> -		adt7470_read_temperatures(client, data);
> +		err = adt7470_read_temperatures(data);
>  	else
> -		for (i = 0; i < ADT7470_TEMP_COUNT; i++)
> -			data->temp[i] = i2c_smbus_read_byte_data(client,
> -						ADT7470_TEMP_REG(i));
> +		err = regmap_bulk_read(data->regmap, ADT7470_TEMP_REG(0), &data->temp[0],
> +				       ADT7470_TEMP_COUNT);
> +	if (err < 0)
> +		return err;
>  
> -	for (i = 0; i < ADT7470_FAN_COUNT; i++)
> -		data->fan[i] = adt7470_read_word_data(client,
> -						ADT7470_REG_FAN(i));
> +	for (i = 0; i < ADT7470_FAN_COUNT; i++) {
> +		int val = adt7470_read_word_data(data, ADT7470_REG_FAN(i));
>  
> -	for (i = 0; i < ADT7470_PWM_COUNT; i++) {
> -		int reg;
> -		int reg_mask;
> +		if (val < 0)
> +			return val;
> +
> +		data->fan[i] =	val;
> +	}
>  
> -		data->pwm[i] = i2c_smbus_read_byte_data(client,
> -						ADT7470_REG_PWM(i));
> +	err = regmap_bulk_read(data->regmap, ADT7470_REG_PWM(0), &data->pwm[0], ADT7470_PWM_COUNT);
> +	if (err < 0)
> +		return err;
> +
> +	for (i = 0; i < ADT7470_PWM_COUNT; i++) {
> +		u8 mask;
> +		u8 val;
>  
>  		if (i % 2)
> -			reg_mask = ADT7470_PWM2_AUTO_MASK;
> +			mask = ADT7470_PWM2_AUTO_MASK;
>  		else
> -			reg_mask = ADT7470_PWM1_AUTO_MASK;
> +			mask = ADT7470_PWM1_AUTO_MASK;
>  
> -		reg = ADT7470_REG_PWM_CFG(i);
> -		if (i2c_smbus_read_byte_data(client, reg) & reg_mask)
> +		err = regmap_raw_read(data->regmap, ADT7470_REG_PWM_CFG(i), &val, 1);
> +		if (err < 0)
> +			return err;
> +		if (val & mask)
>  			data->pwm_automatic[i] = 1;
>  		else
>  			data->pwm_automatic[i] = 0;
>  
> -		reg = ADT7470_REG_PWM_AUTO_TEMP(i);
> -		cfg = i2c_smbus_read_byte_data(client, reg);
> +		err = regmap_raw_read(data->regmap, ADT7470_REG_PWM_AUTO_TEMP(i), &val, 1);
> +		if (err < 0)
> +			return err;
>  		if (!(i % 2))
> -			data->pwm_auto_temp[i] = cfg >> 4;
> +			data->pwm_auto_temp[i] = val >> 4;
>  		else
> -			data->pwm_auto_temp[i] = cfg & 0xF;
> +			data->pwm_auto_temp[i] = val & 0xF;
>  	}
>  
> -	if (i2c_smbus_read_byte_data(client, ADT7470_REG_CFG) &
> -	    ADT7470_FSPD_MASK)
> +	err = regmap_raw_read(data->regmap, ADT7470_REG_CFG, &cfg, 1);
> +	if (err < 0)
> +		return err;
> +	if (cfg & ADT7470_FSPD_MASK)
>  		data->force_pwm_max = 1;
>  	else
>  		data->force_pwm_max = 0;
>  
> -	data->alarm = i2c_smbus_read_byte_data(client, ADT7470_REG_ALARM1);
> +	err = regmap_bulk_read(data->regmap, ADT7470_REG_ALARM1, &vals[0], 2);
> +	if (err < 0)
> +		return err;
> +	data->alarm = vals[0];
>  	if (data->alarm & ADT7470_OOL_ALARM)
> -		data->alarm |= ALARM2(i2c_smbus_read_byte_data(client,
> -							ADT7470_REG_ALARM2));
> -	data->alarms_mask = adt7470_read_word_data(client,
> -						   ADT7470_REG_ALARM1_MASK);
> +		data->alarm |= ALARM2(vals[1]);
> +
> +	alarms_mask = adt7470_read_word_data(data, ADT7470_REG_ALARM1_MASK);
> +	if (alarms_mask < 0)
> +		return alarms_mask;
> +	data->alarms_mask = alarms_mask;
>  
>  	return 0;
>  }
>  
>  static int adt7470_update_limits(struct adt7470_data *data)
>  {
> -	struct i2c_client *client = data->client;
> +	int err;
>  	int i;
>  
>  	for (i = 0; i < ADT7470_TEMP_COUNT; i++) {
> -		data->temp_min[i] = i2c_smbus_read_byte_data(client,
> -						ADT7470_TEMP_MIN_REG(i));
> -		data->temp_max[i] = i2c_smbus_read_byte_data(client,
> -						ADT7470_TEMP_MAX_REG(i));
> +		err = regmap_raw_read(data->regmap, ADT7470_TEMP_MIN_REG(i), &data->temp_min[i], 1);
> +		if (err < 0)
> +			return err;
> +		err = regmap_raw_read(data->regmap, ADT7470_TEMP_MAX_REG(i), &data->temp_max[i], 1);
> +		if (err < 0)
> +			return err;
>  	}
>  
>  	for (i = 0; i < ADT7470_FAN_COUNT; i++) {
> -		data->fan_min[i] = adt7470_read_word_data(client,
> -						ADT7470_REG_FAN_MIN(i));
> -		data->fan_max[i] = adt7470_read_word_data(client,
> -						ADT7470_REG_FAN_MAX(i));
> +		int val;
> +
> +		val = adt7470_read_word_data(data, ADT7470_REG_FAN_MIN(i));
> +		if (val < 0)
> +			return val;
> +		data->fan_min[i] = val;
> +		val = adt7470_read_word_data(data, ADT7470_REG_FAN_MAX(i));
> +		if (val < 0)
> +			return val;
> +		data->fan_max[i] = val;
>  	}
>  
>  	for (i = 0; i < ADT7470_PWM_COUNT; i++) {
> -		data->pwm_max[i] = i2c_smbus_read_byte_data(client,
> -						ADT7470_REG_PWM_MAX(i));
> -		data->pwm_min[i] = i2c_smbus_read_byte_data(client,
> -						ADT7470_REG_PWM_MIN(i));
> -		data->pwm_tmin[i] = i2c_smbus_read_byte_data(client,
> -						ADT7470_REG_PWM_TMIN(i));
> +		err = regmap_raw_read(data->regmap, ADT7470_REG_PWM_MAX(i), &data->pwm_max[i], 1);
> +		if (err < 0)
> +			return err;
> +		err = regmap_raw_read(data->regmap, ADT7470_REG_PWM_MIN(i), &data->pwm_min[i], 1);
> +		if (err < 0)
> +			return err;
> +		err = regmap_raw_read(data->regmap, ADT7470_REG_PWM_TMIN(i), &data->pwm_tmin[i], 1);
> +		if (err < 0)
> +			return err;
>  	}
>  
>  	return 0;
> @@ -490,8 +555,8 @@ static ssize_t temp_min_store(struct device *dev,
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct adt7470_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
>  	long temp;
> +	int err;
>  
>  	if (kstrtol(buf, 10, &temp))
>  		return -EINVAL;
> @@ -501,11 +566,11 @@ static ssize_t temp_min_store(struct device *dev,
>  
>  	mutex_lock(&data->lock);
>  	data->temp_min[attr->index] = temp;
> -	i2c_smbus_write_byte_data(client, ADT7470_TEMP_MIN_REG(attr->index),
> -				  temp);
> +	err = regmap_raw_write(data->regmap, ADT7470_TEMP_MIN_REG(attr->index),
> +			       &data->temp_min[attr->index], 1);
>  	mutex_unlock(&data->lock);
>  
> -	return count;
> +	return err < 0 ? err : count;
>  }
>  
>  static ssize_t temp_max_show(struct device *dev,
> @@ -526,8 +591,8 @@ static ssize_t temp_max_store(struct device *dev,
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct adt7470_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
>  	long temp;
> +	int err;
>  
>  	if (kstrtol(buf, 10, &temp))
>  		return -EINVAL;
> @@ -537,11 +602,11 @@ static ssize_t temp_max_store(struct device *dev,
>  
>  	mutex_lock(&data->lock);
>  	data->temp_max[attr->index] = temp;
> -	i2c_smbus_write_byte_data(client, ADT7470_TEMP_MAX_REG(attr->index),
> -				  temp);
> +	err = regmap_raw_write(data->regmap, ADT7470_TEMP_MAX_REG(attr->index),
> +			       &data->temp_max[attr->index], 1);
>  	mutex_unlock(&data->lock);
>  
> -	return count;
> +	return err < 0 ? err : count;
>  }
>  
>  static ssize_t temp_show(struct device *dev, struct device_attribute *devattr,
> @@ -574,6 +639,7 @@ static ssize_t alarm_mask_store(struct device *dev,
>  {
>  	struct adt7470_data *data = dev_get_drvdata(dev);
>  	long mask;
> +	int err;
>  
>  	if (kstrtoul(buf, 0, &mask))
>  		return -EINVAL;
> @@ -583,10 +649,10 @@ static ssize_t alarm_mask_store(struct device *dev,
>  
>  	mutex_lock(&data->lock);
>  	data->alarms_mask = mask;
> -	adt7470_write_word_data(data->client, ADT7470_REG_ALARM1_MASK, mask);
> +	err = adt7470_write_word_data(data, ADT7470_REG_ALARM1_MASK, mask);
>  	mutex_unlock(&data->lock);
>  
> -	return count;
> +	return err < 0 ? err : count;
>  }
>  
>  static ssize_t fan_max_show(struct device *dev,
> @@ -611,7 +677,6 @@ static ssize_t fan_max_store(struct device *dev,
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct adt7470_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
>  	long temp;
>  
>  	if (kstrtol(buf, 10, &temp) || !temp)
> @@ -622,7 +687,7 @@ static ssize_t fan_max_store(struct device *dev,
>  
>  	mutex_lock(&data->lock);
>  	data->fan_max[attr->index] = temp;
> -	adt7470_write_word_data(client, ADT7470_REG_FAN_MAX(attr->index), temp);
> +	adt7470_write_word_data(data, ADT7470_REG_FAN_MAX(attr->index), temp);

Why no error handling here (and in some other places) ?

>  	mutex_unlock(&data->lock);
>  
>  	return count;
> @@ -650,7 +715,6 @@ static ssize_t fan_min_store(struct device *dev,
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct adt7470_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
>  	long temp;
>  
>  	if (kstrtol(buf, 10, &temp) || !temp)
> @@ -661,7 +725,7 @@ static ssize_t fan_min_store(struct device *dev,
>  
>  	mutex_lock(&data->lock);
>  	data->fan_min[attr->index] = temp;
> -	adt7470_write_word_data(client, ADT7470_REG_FAN_MIN(attr->index), temp);
> +	adt7470_write_word_data(data, ADT7470_REG_FAN_MIN(attr->index), temp);
>  	mutex_unlock(&data->lock);
>  
>  	return count;
> @@ -699,8 +763,8 @@ static ssize_t force_pwm_max_store(struct device *dev,
>  				   const char *buf, size_t count)
>  {
>  	struct adt7470_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
>  	long temp;
> +	int err;
>  	u8 reg;
>  
>  	if (kstrtol(buf, 10, &temp))
> @@ -708,15 +772,18 @@ static ssize_t force_pwm_max_store(struct device *dev,
>  
>  	mutex_lock(&data->lock);
>  	data->force_pwm_max = temp;
> -	reg = i2c_smbus_read_byte_data(client, ADT7470_REG_CFG);
> +	err = regmap_raw_read(data->regmap, ADT7470_REG_CFG, &reg, 1);
> +	if (err < 0)
> +		goto out;
>  	if (temp)
>  		reg |= ADT7470_FSPD_MASK;
>  	else
>  		reg &= ~ADT7470_FSPD_MASK;
> -	i2c_smbus_write_byte_data(client, ADT7470_REG_CFG, reg);
> +	err = regmap_raw_write(data->regmap, ADT7470_REG_CFG, &reg, 1);
> +out:
>  	mutex_unlock(&data->lock);
>  
> -	return count;
> +	return err < 0 ? err : count;
>  }
>  
>  static ssize_t pwm_show(struct device *dev, struct device_attribute *devattr,
> @@ -736,8 +803,8 @@ static ssize_t pwm_store(struct device *dev, struct device_attribute *devattr,
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct adt7470_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
>  	long temp;
> +	int err;
>  
>  	if (kstrtol(buf, 10, &temp))
>  		return -EINVAL;
> @@ -746,10 +813,11 @@ static ssize_t pwm_store(struct device *dev, struct device_attribute *devattr,
>  
>  	mutex_lock(&data->lock);
>  	data->pwm[attr->index] = temp;
> -	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM(attr->index), temp);
> +	err = regmap_raw_write(data->regmap, ADT7470_REG_PWM(attr->index),
> +			       &data->pwm[attr->index], 1);
>  	mutex_unlock(&data->lock);
>  
> -	return count;
> +	return err < 0 ? err : count;
>  }
>  
>  /* These are the valid PWM frequencies to the nearest Hz */
> @@ -761,13 +829,21 @@ static ssize_t pwm1_freq_show(struct device *dev,
>  			      struct device_attribute *devattr, char *buf)
>  {
>  	struct adt7470_data *data = adt7470_update_device(dev);
> -	unsigned char cfg_reg_1;
> -	unsigned char cfg_reg_2;
> +	u8 cfg_reg_1;
> +	u8 cfg_reg_2;
>  	int index;
> +	int err;
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
>  
>  	mutex_lock(&data->lock);
> -	cfg_reg_1 = i2c_smbus_read_byte_data(data->client, ADT7470_REG_CFG);
> -	cfg_reg_2 = i2c_smbus_read_byte_data(data->client, ADT7470_REG_CFG_2);
> +	err = regmap_raw_read(data->regmap, ADT7470_REG_CFG, &cfg_reg_1, 1);
> +	if (err < 0)
> +		goto out;
> +	err = regmap_raw_read(data->regmap, ADT7470_REG_CFG_2, &cfg_reg_2, 1);
> +	if (err < 0)
> +		goto out;
>  	mutex_unlock(&data->lock);
>  
>  	index = (cfg_reg_2 & ADT7470_FREQ_MASK) >> ADT7470_FREQ_SHIFT;
> @@ -777,6 +853,10 @@ static ssize_t pwm1_freq_show(struct device *dev,
>  		index = ARRAY_SIZE(adt7470_freq_map) - 1;
>  
>  	return scnprintf(buf, PAGE_SIZE, "%d\n", adt7470_freq_map[index]);
> +
> +out:
> +	mutex_unlock(&data->lock);
> +	return err;
>  }
>  
>  static ssize_t pwm1_freq_store(struct device *dev,
> @@ -784,11 +864,11 @@ static ssize_t pwm1_freq_store(struct device *dev,
>  			       const char *buf, size_t count)
>  {
>  	struct adt7470_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
>  	long freq;
>  	int index;
>  	int low_freq = ADT7470_CFG_LF;
> -	unsigned char val;
> +	int err;
> +	u8 val;
>  
>  	if (kstrtol(buf, 10, &freq))
>  		return -EINVAL;
> @@ -804,16 +884,26 @@ static ssize_t pwm1_freq_store(struct device *dev,
>  
>  	mutex_lock(&data->lock);
>  	/* Configuration Register 1 */
> -	val = i2c_smbus_read_byte_data(client, ADT7470_REG_CFG);
> -	i2c_smbus_write_byte_data(client, ADT7470_REG_CFG,
> -				  (val & ~ADT7470_CFG_LF) | low_freq);
> +	err = regmap_raw_read(data->regmap, ADT7470_REG_CFG, &val, 1);
> +	if (err < 0)
> +		goto out;
> +	val &= ~ADT7470_CFG_LF;
> +	val |= low_freq;
> +	err = regmap_raw_write(data->regmap, ADT7470_REG_CFG, &val, 1);
> +	if (err < 0)
> +		goto out;
> +
>  	/* Configuration Register 2 */
> -	val = i2c_smbus_read_byte_data(client, ADT7470_REG_CFG_2);
> -	i2c_smbus_write_byte_data(client, ADT7470_REG_CFG_2,
> -		(val & ~ADT7470_FREQ_MASK) | (index << ADT7470_FREQ_SHIFT));
> +	err = regmap_raw_read(data->regmap, ADT7470_REG_CFG_2, &val, 1);
> +	if (err < 0)
> +		goto out;
> +	val &= ~ADT7470_FREQ_MASK;
> +	val |= index << ADT7470_FREQ_SHIFT;
> +	err = regmap_raw_write(data->regmap, ADT7470_REG_CFG_2, &val, 1);
> +out:
>  	mutex_unlock(&data->lock);
>  
> -	return count;
> +	return err < 0 ? err : count;
>  }
>  
>  static ssize_t pwm_max_show(struct device *dev,
> @@ -834,8 +924,8 @@ static ssize_t pwm_max_store(struct device *dev,
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct adt7470_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
>  	long temp;
> +	int err;
>  
>  	if (kstrtol(buf, 10, &temp))
>  		return -EINVAL;
> @@ -844,11 +934,11 @@ static ssize_t pwm_max_store(struct device *dev,
>  
>  	mutex_lock(&data->lock);
>  	data->pwm_max[attr->index] = temp;
> -	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM_MAX(attr->index),
> -				  temp);
> +	err = regmap_raw_write(data->regmap, ADT7470_REG_PWM_MAX(attr->index),
> +			       &data->pwm_max[attr->index], 1);
>  	mutex_unlock(&data->lock);
>  
> -	return count;
> +	return err < 0 ? err : count;
>  }
>  
>  static ssize_t pwm_min_show(struct device *dev,
> @@ -869,8 +959,8 @@ static ssize_t pwm_min_store(struct device *dev,
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct adt7470_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
>  	long temp;
> +	int err;
>  
>  	if (kstrtol(buf, 10, &temp))
>  		return -EINVAL;
> @@ -878,12 +968,11 @@ static ssize_t pwm_min_store(struct device *dev,
>  	temp = clamp_val(temp, 0, 255);
>  
>  	mutex_lock(&data->lock);
> -	data->pwm_min[attr->index] = temp;
> -	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM_MIN(attr->index),
> -				  temp);
> +	err = regmap_raw_write(data->regmap, ADT7470_REG_PWM_MIN(attr->index),
> +			       &data->pwm_min[attr->index], 1);
>  	mutex_unlock(&data->lock);
>  
> -	return count;
> +	return err < 0 ? err : count;
>  }
>  
>  static ssize_t pwm_tmax_show(struct device *dev,
> @@ -917,8 +1006,8 @@ static ssize_t pwm_tmin_store(struct device *dev,
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct adt7470_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
>  	long temp;
> +	int err;
>  
>  	if (kstrtol(buf, 10, &temp))
>  		return -EINVAL;
> @@ -928,11 +1017,11 @@ static ssize_t pwm_tmin_store(struct device *dev,
>  
>  	mutex_lock(&data->lock);
>  	data->pwm_tmin[attr->index] = temp;
> -	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM_TMIN(attr->index),
> -				  temp);
> +	err = regmap_raw_write(data->regmap, ADT7470_REG_PWM_TMIN(attr->index),
> +			       &data->pwm_tmin[attr->index], 1);
>  	mutex_unlock(&data->lock);
>  
> -	return count;
> +	return err < 0 ? err : count;
>  }
>  
>  static ssize_t pwm_auto_show(struct device *dev,
> @@ -953,10 +1042,10 @@ static ssize_t pwm_auto_store(struct device *dev,
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct adt7470_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
>  	int pwm_auto_reg = ADT7470_REG_PWM_CFG(attr->index);
>  	int pwm_auto_reg_mask;
>  	long temp;
> +	int err;
>  	u8 reg;
>  
>  	if (kstrtol(buf, 10, &temp))
> @@ -973,15 +1062,18 @@ static ssize_t pwm_auto_store(struct device *dev,
>  
>  	mutex_lock(&data->lock);
>  	data->pwm_automatic[attr->index] = temp;
> -	reg = i2c_smbus_read_byte_data(client, pwm_auto_reg);
> +	err = regmap_raw_read(data->regmap, pwm_auto_reg, &reg, 1);
> +	if (err < 0)
> +		goto out;
>  	if (temp)
>  		reg |= pwm_auto_reg_mask;
>  	else
>  		reg &= ~pwm_auto_reg_mask;
> -	i2c_smbus_write_byte_data(client, pwm_auto_reg, reg);
> +	err = regmap_raw_write(data->regmap, pwm_auto_reg, &reg, 1);
> +out:
>  	mutex_unlock(&data->lock);
>  
> -	return count;
> +	return err < 0 ? err : count;
>  }
>  
>  static ssize_t pwm_auto_temp_show(struct device *dev,
> @@ -1016,9 +1108,9 @@ static ssize_t pwm_auto_temp_store(struct device *dev,
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct adt7470_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
>  	int pwm_auto_reg = ADT7470_REG_PWM_AUTO_TEMP(attr->index);
>  	long temp;
> +	int err;
>  	u8 reg;
>  
>  	if (kstrtol(buf, 10, &temp))
> @@ -1030,7 +1122,10 @@ static ssize_t pwm_auto_temp_store(struct device *dev,
>  
>  	mutex_lock(&data->lock);
>  	data->pwm_automatic[attr->index] = temp;
> -	reg = i2c_smbus_read_byte_data(client, pwm_auto_reg);
> +
> +	err = regmap_raw_read(data->regmap, pwm_auto_reg, &reg, 1);
> +	if (err < 0)
> +		goto out;
>  
>  	if (!(attr->index % 2)) {
>  		reg &= 0xF;
> @@ -1040,10 +1135,11 @@ static ssize_t pwm_auto_temp_store(struct device *dev,
>  		reg |= temp & 0xF;
>  	}
>  
> -	i2c_smbus_write_byte_data(client, pwm_auto_reg, reg);
> +	err = regmap_raw_write(data->regmap, pwm_auto_reg, &reg, 1);
> +out:
>  	mutex_unlock(&data->lock);
>  
> -	return count;
> +	return err < 0 ? err : count;
>  }
>  
>  static ssize_t alarm_show(struct device *dev,
> @@ -1287,23 +1383,35 @@ static int adt7470_detect(struct i2c_client *client,
>  	return 0;
>  }
>  
> -static void adt7470_init_client(struct i2c_client *client)
> +static int adt7470_init_client(struct device *dev, struct adt7470_data *data)
>  {
> -	int reg = i2c_smbus_read_byte_data(client, ADT7470_REG_CFG);
> +	int err;
> +	u8 val;
>  
> -	if (reg < 0) {
> -		dev_err(&client->dev, "cannot read configuration register\n");
> -	} else {
> -		/* start monitoring (and do a self-test) */
> -		i2c_smbus_write_byte_data(client, ADT7470_REG_CFG, reg | 3);
> +	err = regmap_raw_read(data->regmap, ADT7470_REG_CFG, &val, 1);
> +	if (err < 0) {
> +		dev_err(dev, "cannot read configuration register\n");
> +		return err;
>  	}
> +
> +	val |= 3;
> +
> +	return regmap_raw_write(data->regmap, ADT7470_REG_CFG, &val, 1);
>  }
>  
> +static const struct regmap_config adt7470_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.use_single_read = true,
> +	.use_single_write = true,
> +};
> +
>  static int adt7470_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct adt7470_data *data;
>  	struct device *hwmon_dev;
> +	int err;
>  
>  	data = devm_kzalloc(dev, sizeof(struct adt7470_data), GFP_KERNEL);
>  	if (!data)
> @@ -1311,15 +1419,19 @@ static int adt7470_probe(struct i2c_client *client)
>  
>  	data->num_temp_sensors = -1;
>  	data->auto_update_interval = AUTO_UPDATE_INTERVAL;
> +	data->regmap = devm_regmap_init_i2c(client, &adt7470_regmap_config);
> +	if (IS_ERR(data->regmap))
> +		return PTR_ERR(data->regmap);
>  
>  	i2c_set_clientdata(client, data);
> -	data->client = client;
>  	mutex_init(&data->lock);
>  
>  	dev_info(&client->dev, "%s chip found\n", client->name);
>  
>  	/* Initialize the ADT7470 chip */
> -	adt7470_init_client(client);
> +	err = adt7470_init_client(dev, data);
> +	if (err < 0)
> +		return err;
>  
>  	/* Register sysfs hooks */
>  	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
