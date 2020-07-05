Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19378214957
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jul 2020 02:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgGEAmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jul 2020 20:42:21 -0400
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:51550 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgGEAmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 20:42:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 9283F201825A;
        Sun,  5 Jul 2020 08:34:34 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VKIWJqM_6dRp; Sun,  5 Jul 2020 08:34:34 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 6F8602016B15;
        Sun,  5 Jul 2020 08:34:34 +0800 (HKT)
Received: from [10.128.2.32] (unknown [124.217.189.122])
        by s01.gtsys.com.hk (Postfix) with ESMTPSA id 328A0C01F9E;
        Sun,  5 Jul 2020 08:34:34 +0800 (HKT)
Subject: Re: [PATCH 1/2] hwmon: shtc1: add support for device tree bindings
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jack Lo <jack.lo@gtsys.com.hk>, devicetree@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200703034856.12846-1-chris.ruehl@gtsys.com.hk>
 <20200703034856.12846-2-chris.ruehl@gtsys.com.hk>
 <94043e67-1899-8e80-064c-50489cf7e4b2@roeck-us.net>
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
Message-ID: <83ed44a9-179e-f8c7-a712-e81302dd5d42@gtsys.com.hk>
Date:   Sun, 5 Jul 2020 08:34:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <94043e67-1899-8e80-064c-50489cf7e4b2@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On 3/7/2020 1:48 pm, Guenter Roeck wrote:
> On 7/2/20 8:48 PM, Chris Ruehl wrote:
>> Add support for DTS bindings to the shtc driver, use CONFIG_OF
>> to compile in the code if needed.
>>
> 
> Ah, here it is. The introducing patch should say something like "[PATCH 0/2]".
> 
>> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
>> ---
>>   drivers/hwmon/shtc1.c | 30 ++++++++++++++++++++++++++++++
>>   1 file changed, 30 insertions(+)
>>
>> diff --git a/drivers/hwmon/shtc1.c b/drivers/hwmon/shtc1.c
>> index a0078ccede03..3bcabc1cbce8 100644
>> --- a/drivers/hwmon/shtc1.c
>> +++ b/drivers/hwmon/shtc1.c
>> @@ -14,6 +14,9 @@
>>   #include <linux/err.h>
>>   #include <linux/delay.h>
>>   #include <linux/platform_data/shtc1.h>
>> +#ifdef CONFIG_OF
> 
> No. Please no conditional includes.

OK, will be fixed and same for below.

> 
>> +#include <linux/of.h>
>> +#endif
>>   
>>   /* commands (high precision mode) */
>>   static const unsigned char shtc1_cmd_measure_blocking_hpm[]    = { 0x7C, 0xA2 };
>> @@ -196,6 +199,10 @@ static int shtc1_probe(struct i2c_client *client,
>>   	enum shtcx_chips chip = id->driver_data;
>>   	struct i2c_adapter *adap = client->adapter;
>>   	struct device *dev = &client->dev;
>> +#ifdef CONFIG_OF
>> +	struct device_node *np = dev->of_node;
>> +	u8 value;
>> +#endif
>>   
>>   	if (!i2c_check_functionality(adap, I2C_FUNC_I2C)) {
>>   		dev_err(dev, "plain i2c transactions not supported\n");
>> @@ -235,6 +242,20 @@ static int shtc1_probe(struct i2c_client *client,
>>   
>>   	if (client->dev.platform_data)
>>   		data->setup = *(struct shtc1_platform_data *)dev->platform_data;
>> +
>> +#ifdef CONFIG_OF
> 
> Unnecessary ifdef. Selection of devicetree data or not can be made
> based on np != NULL. Also, if devictree data is available, platform
> data should be ignored to avoid confusion.

Ok, I wasn't aware this rule. Will change it.

> 
>> +	if (np) {
>> +		if (of_property_read_bool(np, "sensirion,blocking_io")) {
>> +			of_property_read_u8(np, "sensirion,blocking_io", &value);
>> +			data->setup.blocking_io = (value > 0) ? true : false;
>> +		}
> Why this complexity, and why not just make the property a boolean ?
> 
>> +		if (of_property_read_bool(np, "sensicon,high_precision")) {
>> +			of_property_read_u8(np, "sensirion,high_precision", &value);
>> +			data->setup.high_precision = (value > 0) ? true : false;
> 
> "sensicon,high_precision" should also be a boolean.
> 
>> +		}
>> +	}
>> +#endif
>> +
>>   	shtc1_select_command(data);
>>   	mutex_init(&data->update_lock);
>>   
>> @@ -257,6 +278,15 @@ static const struct i2c_device_id shtc1_id[] = {
>>   };
>>   MODULE_DEVICE_TABLE(i2c, shtc1_id);
>>   
>> +#ifdef CONFIG_OF
>> +static const struct of_device_id shtc1_of_match[] = {
>> +	{ .compatible = "sensirion,shtc1" },
>> +	{ .compatible = "sensirion,shtw1" },
>> +	{ .compatible = "sensirion,shtc3" },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, shtc1_of_match);
>> +#endif
>>   static struct i2c_driver shtc1_i2c_driver = {
>>   	.driver.name  = "shtc1",
>>   	.probe        = shtc1_probe,
>>
> Not sure how this works without setting of_match_table. I guess it just works
> accidentally because .id_table also provides a devicetree match. Still,
> of_match_table should be set.

Thanks, I will take care of this in the v2 version.

> 
> Guenter
> 

