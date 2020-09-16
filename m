Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2914726BA84
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 05:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbgIPDJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 23:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgIPDJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 23:09:21 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8021C06174A;
        Tue, 15 Sep 2020 20:09:20 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id y5so5342583otg.5;
        Tue, 15 Sep 2020 20:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rDIxqPOPy/jwE1fyBLQdvVBwmDeqK+FPS+2DQFsR9wU=;
        b=u8JR+SKL2EY/e96H8DkCrV0RnTLxg9b8MC4p8V/xSYbuq5+T/lLzN3yH3v+LhXkRWV
         FgfTEnolpKtJkyrCGEtSqkJkvEOtF1Vm16Fg/64SuQqlZZ+0HwfS91xVbZWTs8mraJpV
         0iQCAeQcGgL8YSE95HrHvwuHOHjzEX2gvwH5G9+DlJ4yfLxThAhielf4SAU0ZmxotYsU
         X5cACbER/eozqTSTM5pBgTTeBti1CDbGypTKakDbSWT1tdlLtqwAcPNXsxh2EWMyo8wQ
         +hgA7WHp75ePveuBOVvR8k+Hb2P4HzdiFRwbiZ4Mpp/nBXhqYEHyvrM9NR+OxYXsmCwJ
         XjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=rDIxqPOPy/jwE1fyBLQdvVBwmDeqK+FPS+2DQFsR9wU=;
        b=TLI90oTscic5zL/y+c08rqWQpcnTaxPuF21vVAQlGm9FlaSwsay1qIRWvjgH6WlHJE
         gxnfhkBycRyHpnu5orLSdoxEFcqktbPzsHhz/HGU+E+rcXmVsxeWOyta27Ob1AiBo989
         /IMbtdgxUvyWsfzZdoxpH/42n7zgBLRsYUUU2ohJAdYPL5zj23/Estua0WN6Rd6UB4yv
         g+Nta0xFADOtqmeXupMILhOQAR1jPW73T9ufOmgPsWIIWxAL+5WI+5yX2D2iNTneT/P9
         t1iRj2GrTGv3msYcUgr6PzGxqi6vlwALG+oojhta2E3OaGkrc/PYSgab32K7V9SKmnex
         5VUw==
X-Gm-Message-State: AOAM532o8tM3YP37vAB3gNdUm0QMD8vX2u4oRq6wxbxrXB2of3aMTTWq
        GBuA54eakPNXfSIwdDIQrGA=
X-Google-Smtp-Source: ABdhPJz5uPpzIQEzLcXZ6Eh8mUguD2ePQE/oB9E4x0Q3rDsyMpN+hukO68DmRFZsJXjsV6tX4QwmEQ==
X-Received: by 2002:a05:6830:2096:: with SMTP id y22mr15186350otq.158.1600225759608;
        Tue, 15 Sep 2020 20:09:19 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e18sm8109649oiy.52.2020.09.15.20.09.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Sep 2020 20:09:19 -0700 (PDT)
Date:   Tue, 15 Sep 2020 20:09:18 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chu Lin <linchuyuan@google.com>
Cc:     jdelvare@suse.com, belgaied@google.com, jasonling@google.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongqil@google.com
Subject: Re: [PATCH v3] hwmon: adm1272: Enable temperature sampling for
 adm1272 adm1278
Message-ID: <20200916030918.GA250417@roeck-us.net>
References: <20200721034900.2055889-1-linchuyuan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721034900.2055889-1-linchuyuan@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 03:49:00AM +0000, Chu Lin wrote:
> Problem:
> 	adm1272 and adm1278 supports temperature sampling. The
> current way of enabling it requires the user manually unbind the device
> from the driver, flip the temperature sampling control bit and then bind
> the device back to the driver. It would be nice if we can control this in a
> better way by reading the dt.
> 
> Solution:
> 	Introducing device tree binding analog,temp1-enable. If the
> flag is set, flip the temp1_en control bit on probing.
> 
> Testing:
> 1). iotools smbus_write16 35 0x10 0xd4 0x0037 // disable the temp1_en
> 2). recompile the dt to have  analog,temp1-enable set
> 3). Probe the driver and make sure tempX shows up in hwmon
> 
> Signed-off-by: Chu Lin <linchuyuan@google.com>

For my reference:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

We'll need to wait for DT review before I can apply the patch.

Thanks,
Guenter

> ---
> ChangeLog v1->v2:
>  - Rename adm1272-adm1278-temp1-en to analog-temperature1-enable
> 
> ChangeLog v2->v3:
>  - Rename analog-temperature1-enable analog,temp1-enable
> 
>  drivers/hwmon/pmbus/adm1275.c | 36 +++++++++++++++++++++--------------
>  1 file changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
> index 19317575d1c6..0482670281bd 100644
> --- a/drivers/hwmon/pmbus/adm1275.c
> +++ b/drivers/hwmon/pmbus/adm1275.c
> @@ -475,6 +475,7 @@ static int adm1275_probe(struct i2c_client *client,
>  	const struct coefficients *coefficients;
>  	int vindex = -1, voindex = -1, cindex = -1, pindex = -1;
>  	int tindex = -1;
> +	bool temp1_en;
>  	u32 shunt;
>  
>  	if (!i2c_check_functionality(client->adapter,
> @@ -536,6 +537,9 @@ static int adm1275_probe(struct i2c_client *client,
>  	if (shunt == 0)
>  		return -EINVAL;
>  
> +	temp1_en = of_property_read_bool(client->dev.of_node, "analog,temp1-enable") &&
> +		(mid->driver_data == adm1272 || mid->driver_data == adm1278);
> +
>  	data->id = mid->driver_data;
>  
>  	info = &data->info;
> @@ -614,16 +618,18 @@ static int adm1275_probe(struct i2c_client *client,
>  		info->func[0] |= PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT |
>  			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
>  
> +		ret = config;
> +		/* Enable temp if it is instructed by dt (it is disabled by default) */
> +		if (temp1_en && !(config & ADM1278_TEMP1_EN))
> +			config |= ADM1278_TEMP1_EN;
>  		/* Enable VOUT if not enabled (it is disabled by default) */
> -		if (!(config & ADM1278_VOUT_EN)) {
> +		if (!(config & ADM1278_VOUT_EN))
>  			config |= ADM1278_VOUT_EN;
> -			ret = i2c_smbus_write_byte_data(client,
> -							ADM1275_PMON_CONFIG,
> -							config);
> +		if (ret != config) {
> +			ret = i2c_smbus_write_word_data(client, ADM1275_PMON_CONFIG, config);
>  			if (ret < 0) {
> -				dev_err(&client->dev,
> -					"Failed to enable VOUT monitoring\n");
> -				return -ENODEV;
> +				dev_err(&client->dev, "Failed to enable config control bits");
> +				return ret;
>  			}
>  		}
>  
> @@ -685,16 +691,18 @@ static int adm1275_probe(struct i2c_client *client,
>  		info->func[0] |= PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT |
>  			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
>  
> +		ret = config;
> +		/* Enable temp if it is instructed by dt (it is disabled by default) */
> +		if (temp1_en && !(config & ADM1278_TEMP1_EN))
> +			config |= ADM1278_TEMP1_EN;
>  		/* Enable VOUT if not enabled (it is disabled by default) */
> -		if (!(config & ADM1278_VOUT_EN)) {
> +		if (!(config & ADM1278_VOUT_EN))
>  			config |= ADM1278_VOUT_EN;
> -			ret = i2c_smbus_write_byte_data(client,
> -							ADM1275_PMON_CONFIG,
> -							config);
> +		if (ret != config) {
> +			ret = i2c_smbus_write_word_data(client, ADM1275_PMON_CONFIG, config);
>  			if (ret < 0) {
> -				dev_err(&client->dev,
> -					"Failed to enable VOUT monitoring\n");
> -				return -ENODEV;
> +				dev_err(&client->dev, "Failed to enable config control bits");
> +				return ret;
>  			}
>  		}
>  
