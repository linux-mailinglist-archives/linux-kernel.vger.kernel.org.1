Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011F92978CB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 23:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756637AbgJWVYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 17:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756030AbgJWVYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 17:24:02 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C8BC0613CE;
        Fri, 23 Oct 2020 14:24:02 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id k3so2066792otp.1;
        Fri, 23 Oct 2020 14:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gUCiDILDTrTnxFKCvB7S7EViTN3weS1vsJ+gyCkYGxY=;
        b=L2l/CHHXGvMzS/7UXARz2o/4N3xwOscQDf44MR1qtny0cmOI++N4erjaZ+DuYoJIrR
         q7jIduPjqVCPwYs6+oUSUbLYysjXyuZm6OPPRQqlmxkdTWbWh5rBcQ9SvB/w04i5bHYN
         1r+RhUJH7DZxW2/cH/kCnZqk8ZcxtUuQTapyoG1Ock6T2Jz3XbOE+dnsFY2lrEgOByy8
         YmNZ8eGmLUkJlO48xvQ3Scrjj/ttDIVRNUj3SHw3m3zbVJmBi3E4MyusVPSGWvFrvS15
         ZRGvrDIfhY1cndtsBBW5ljTu1zgyjP4sqzipJe3NmTxtxr6JOEIgQxDQnqxN0FoKcMeW
         00kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=gUCiDILDTrTnxFKCvB7S7EViTN3weS1vsJ+gyCkYGxY=;
        b=pjqFKFaPoJ2RrPti3KROYosz9IeAGD7gWJnsOugecHVZNocxxUhbNPTOVx/eqSa4cV
         sfF4vder+3VOuhw83pxWrN7Gx6AnIKL8Y5hcDGEmiubqprzu0o433vp3MOzkJV4BGBrl
         HOgQKtdKfgsPr5WkDwwi5NvEq3QqqJi0g6JhZ61DbqVXfF5T4UM/O+RH1WZEqgp6nozA
         80xjYVOFHBat77q/3dKO+9iM/ve9WA71QtYPFaSz4/3UolUMmNSfT7cETE6qCn+LmenO
         C5HjNkiL7TYle46uHSmfiQlpnaTpqn36vss0QgCHElKF9KdFipmSgrocIWnKfdGv01O/
         gciQ==
X-Gm-Message-State: AOAM533Xk6qimX/N0UzgcwnUeXJEoa9F4TxyfbBYWE5W0/CVHTcSYN4n
        ZyNnBuppj8bGqT6ehCwnfZ4=
X-Google-Smtp-Source: ABdhPJx9HwEaL5bxnLhumSjN82nwcCXUKH6q5Ir5Wk1/LVeqroRUl4VTqRnuyAdT4KvETzAHWVRu7w==
X-Received: by 2002:a05:6830:1bce:: with SMTP id v14mr3051558ota.361.1603488241441;
        Fri, 23 Oct 2020 14:24:01 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v19sm676333ota.61.2020.10.23.14.24.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Oct 2020 14:24:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 23 Oct 2020 14:23:59 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     jdelvare@suse.com, Tobi Wulff <tobi.wulff@alliedtelesis.co.nz>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] hwmon: (adt7470) Create functions for updating
 readings and limits
Message-ID: <20201023212359.GA29197@roeck-us.net>
References: <20201019223423.31488-1-chris.packham@alliedtelesis.co.nz>
 <20201019223423.31488-2-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019223423.31488-2-chris.packham@alliedtelesis.co.nz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 11:34:22AM +1300, Chris Packham wrote:
> Split the body of adt7470_update_device() into two helper functions
> adt7470_update_sensors() and adt7470_update_limits(). Although neither
> of the new helpers returns an error yet lay the groundwork for
> propagating failures through to the sysfs readers.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/adt7470.c | 154 ++++++++++++++++++++++++++++++----------
>  1 file changed, 118 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
> index 740f39a54ab0..2e8feacccf84 100644
> --- a/drivers/hwmon/adt7470.c
> +++ b/drivers/hwmon/adt7470.c
> @@ -270,37 +270,11 @@ static int adt7470_update_thread(void *p)
>  	return 0;
>  }
>  
> -static struct adt7470_data *adt7470_update_device(struct device *dev)
> +static int adt7470_update_sensors(struct adt7470_data *data)
>  {
> -	struct adt7470_data *data = dev_get_drvdata(dev);
>  	struct i2c_client *client = data->client;
> -	unsigned long local_jiffies = jiffies;
>  	u8 cfg;
>  	int i;
> -	int need_sensors = 1;
> -	int need_limits = 1;
> -
> -	/*
> -	 * Figure out if we need to update the shadow registers.
> -	 * Lockless means that we may occasionally report out of
> -	 * date data.
> -	 */
> -	if (time_before(local_jiffies, data->sensors_last_updated +
> -			SENSOR_REFRESH_INTERVAL) &&
> -	    data->sensors_valid)
> -		need_sensors = 0;
> -
> -	if (time_before(local_jiffies, data->limits_last_updated +
> -			LIMIT_REFRESH_INTERVAL) &&
> -	    data->limits_valid)
> -		need_limits = 0;
> -
> -	if (!need_sensors && !need_limits)
> -		return data;
> -
> -	mutex_lock(&data->lock);
> -	if (!need_sensors)
> -		goto no_sensor_update;
>  
>  	if (!data->temperatures_probed)
>  		adt7470_read_temperatures(client, data);
> @@ -352,12 +326,13 @@ static struct adt7470_data *adt7470_update_device(struct device *dev)
>  	data->alarms_mask = adt7470_read_word_data(client,
>  						   ADT7470_REG_ALARM1_MASK);
>  
> -	data->sensors_last_updated = local_jiffies;
> -	data->sensors_valid = 1;
> +	return 0;
> +}
>  
> -no_sensor_update:
> -	if (!need_limits)
> -		goto out;
> +static int adt7470_update_limits(struct adt7470_data *data)
> +{
> +	struct i2c_client *client = data->client;
> +	int i;
>  
>  	for (i = 0; i < ADT7470_TEMP_COUNT; i++) {
>  		data->temp_min[i] = i2c_smbus_read_byte_data(client,
> @@ -382,12 +357,55 @@ static struct adt7470_data *adt7470_update_device(struct device *dev)
>  						ADT7470_REG_PWM_TMIN(i));
>  	}
>  
> -	data->limits_last_updated = local_jiffies;
> -	data->limits_valid = 1;
> +	return 0;
> +}
>  
> +static struct adt7470_data *adt7470_update_device(struct device *dev)
> +{
> +	struct adt7470_data *data = dev_get_drvdata(dev);
> +	unsigned long local_jiffies = jiffies;
> +	int need_sensors = 1;
> +	int need_limits = 1;
> +	int err;
> +
> +	/*
> +	 * Figure out if we need to update the shadow registers.
> +	 * Lockless means that we may occasionally report out of
> +	 * date data.
> +	 */
> +	if (time_before(local_jiffies, data->sensors_last_updated +
> +			SENSOR_REFRESH_INTERVAL) &&
> +	    data->sensors_valid)
> +		need_sensors = 0;
> +
> +	if (time_before(local_jiffies, data->limits_last_updated +
> +			LIMIT_REFRESH_INTERVAL) &&
> +	    data->limits_valid)
> +		need_limits = 0;
> +
> +	if (!need_sensors && !need_limits)
> +		return data;
> +
> +	mutex_lock(&data->lock);
> +	if (need_sensors) {
> +		err = adt7470_update_sensors(data);
> +		if (err < 0)
> +			goto out;
> +		data->sensors_last_updated = local_jiffies;
> +		data->sensors_valid = 1;
> +	}
> +
> +	if (need_limits) {
> +		err = adt7470_update_limits(data);
> +		if (err < 0)
> +			goto out;
> +		data->limits_last_updated = local_jiffies;
> +		data->limits_valid = 1;
> +	}
>  out:
>  	mutex_unlock(&data->lock);
> -	return data;
> +
> +	return err < 0 ? ERR_PTR(err) : data;
>  }
>  
>  static ssize_t auto_update_interval_show(struct device *dev,
> @@ -395,6 +413,10 @@ static ssize_t auto_update_interval_show(struct device *dev,
>  					 char *buf)
>  {
>  	struct adt7470_data *data = adt7470_update_device(dev);
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
>  	return sprintf(buf, "%d\n", data->auto_update_interval);
>  }
>  
> @@ -422,6 +444,10 @@ static ssize_t num_temp_sensors_show(struct device *dev,
>  				     char *buf)
>  {
>  	struct adt7470_data *data = adt7470_update_device(dev);
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
>  	return sprintf(buf, "%d\n", data->num_temp_sensors);
>  }
>  
> @@ -451,6 +477,10 @@ static ssize_t temp_min_show(struct device *dev,
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct adt7470_data *data = adt7470_update_device(dev);
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
>  	return sprintf(buf, "%d\n", 1000 * data->temp_min[attr->index]);
>  }
>  
> @@ -483,6 +513,10 @@ static ssize_t temp_max_show(struct device *dev,
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct adt7470_data *data = adt7470_update_device(dev);
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
>  	return sprintf(buf, "%d\n", 1000 * data->temp_max[attr->index]);
>  }
>  
> @@ -515,6 +549,10 @@ static ssize_t temp_show(struct device *dev, struct device_attribute *devattr,
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct adt7470_data *data = adt7470_update_device(dev);
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
>  	return sprintf(buf, "%d\n", 1000 * data->temp[attr->index]);
>  }
>  
> @@ -524,6 +562,9 @@ static ssize_t alarm_mask_show(struct device *dev,
>  {
>  	struct adt7470_data *data = adt7470_update_device(dev);
>  
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
>  	return sprintf(buf, "%x\n", data->alarms_mask);
>  }
>  
> @@ -554,6 +595,9 @@ static ssize_t fan_max_show(struct device *dev,
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct adt7470_data *data = adt7470_update_device(dev);
>  
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
>  	if (FAN_DATA_VALID(data->fan_max[attr->index]))
>  		return sprintf(buf, "%d\n",
>  			       FAN_PERIOD_TO_RPM(data->fan_max[attr->index]));
> @@ -590,6 +634,9 @@ static ssize_t fan_min_show(struct device *dev,
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct adt7470_data *data = adt7470_update_device(dev);
>  
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
>  	if (FAN_DATA_VALID(data->fan_min[attr->index]))
>  		return sprintf(buf, "%d\n",
>  			       FAN_PERIOD_TO_RPM(data->fan_min[attr->index]));
> @@ -626,6 +673,9 @@ static ssize_t fan_show(struct device *dev, struct device_attribute *devattr,
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct adt7470_data *data = adt7470_update_device(dev);
>  
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
>  	if (FAN_DATA_VALID(data->fan[attr->index]))
>  		return sprintf(buf, "%d\n",
>  			       FAN_PERIOD_TO_RPM(data->fan[attr->index]));
> @@ -637,6 +687,10 @@ static ssize_t force_pwm_max_show(struct device *dev,
>  				  struct device_attribute *devattr, char *buf)
>  {
>  	struct adt7470_data *data = adt7470_update_device(dev);
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
>  	return sprintf(buf, "%d\n", data->force_pwm_max);
>  }
>  
> @@ -670,6 +724,10 @@ static ssize_t pwm_show(struct device *dev, struct device_attribute *devattr,
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct adt7470_data *data = adt7470_update_device(dev);
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
>  	return sprintf(buf, "%d\n", data->pwm[attr->index]);
>  }
>  
> @@ -763,6 +821,10 @@ static ssize_t pwm_max_show(struct device *dev,
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct adt7470_data *data = adt7470_update_device(dev);
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
>  	return sprintf(buf, "%d\n", data->pwm_max[attr->index]);
>  }
>  
> @@ -794,6 +856,10 @@ static ssize_t pwm_min_show(struct device *dev,
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct adt7470_data *data = adt7470_update_device(dev);
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
>  	return sprintf(buf, "%d\n", data->pwm_min[attr->index]);
>  }
>  
> @@ -825,6 +891,10 @@ static ssize_t pwm_tmax_show(struct device *dev,
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct adt7470_data *data = adt7470_update_device(dev);
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
>  	/* the datasheet says that tmax = tmin + 20C */
>  	return sprintf(buf, "%d\n", 1000 * (20 + data->pwm_tmin[attr->index]));
>  }
> @@ -834,6 +904,10 @@ static ssize_t pwm_tmin_show(struct device *dev,
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct adt7470_data *data = adt7470_update_device(dev);
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
>  	return sprintf(buf, "%d\n", 1000 * data->pwm_tmin[attr->index]);
>  }
>  
> @@ -866,6 +940,10 @@ static ssize_t pwm_auto_show(struct device *dev,
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct adt7470_data *data = adt7470_update_device(dev);
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
>  	return sprintf(buf, "%d\n", 1 + data->pwm_automatic[attr->index]);
>  }
>  
> @@ -911,8 +989,12 @@ static ssize_t pwm_auto_temp_show(struct device *dev,
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct adt7470_data *data = adt7470_update_device(dev);
> -	u8 ctrl = data->pwm_auto_temp[attr->index];
> +	u8 ctrl;
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
>  
> +	ctrl = data->pwm_auto_temp[attr->index];
>  	if (ctrl)
>  		return sprintf(buf, "%d\n", 1 << (ctrl - 1));
>  	else
