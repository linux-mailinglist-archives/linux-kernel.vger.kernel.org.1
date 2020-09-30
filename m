Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6649E27E042
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 07:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbgI3FYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 01:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgI3FYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 01:24:08 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF40C061755;
        Tue, 29 Sep 2020 22:24:08 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id y5so638357otg.5;
        Tue, 29 Sep 2020 22:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RfD3alCecyPw2hwzwO//lBY+s7cL1+kfGhvyf5ERoX0=;
        b=K+wjcDIwZ6i49Ipi4WZEt1ci9DhcS4TmyOx7LTU5uqYNU7Rdo2hifyPNjXk6FGKjMP
         EuKD4J+3jAwyLccjnsBi1uTTd4XScbAwwh1A8h2CFBVUBkooas+x4WuzXzk434LDV/LD
         GpbZbP/noRmDv1xyYNfeA3M8L+fUz+orpIBFi0EBrFownsb18LylwCihJLH451j9fHlV
         lADbHeQfsVaLE5FzY/OyM1tpW5aKZwyKQDrueHm6GSG49p2HkCdU8Jl5sb0bujv0kgqr
         EGNoH16j/myDtymC8dv/sMMQ+MglJUdA8gHhO07HoVDmSi42/Olm+7F5OpvteWH9S+uV
         n+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=RfD3alCecyPw2hwzwO//lBY+s7cL1+kfGhvyf5ERoX0=;
        b=dvyDnp2LYMWSqLa2l8g+epGnHzh9EEwISSjlfaVy3wW0CjCiw7OUuCyYR+WxQyu/YK
         eVwxfsow/zRM8kI1p5EkpTrzk5LcRGoD8kDTckuObaQuI1jeM7kdYCpV1njc2zfdCXzY
         MRSoZbJmnosBF4ZVwDGoZzUF1h0fx2EHuqyFDoXIiu+PdK1Z+Pq5BPAlTjEoU9Oy/03W
         3UEl4sxupGhwuDRwMEcz9gFh3u76aKLhQWe+ibwbn3g4P2KiEMjrAvHeySFw1BKluNf1
         NVTei0jsrHgst8gPHqWbPWaEpZ+l7ZUXqKP58t+CMDlNUsGI1+mn1H9a+s48NCjO5kNX
         yXig==
X-Gm-Message-State: AOAM533/1ubq8IcGMAwP8a0pEOayjDSuRaiTNxToRyrvXXwvtiSblcE2
        uH7KS1msW3cy8ybjE2Uh5AA=
X-Google-Smtp-Source: ABdhPJzTOitytYOR6oQGE23sKSXgrNLZl1uwDnml6yoKrK6gwICOkDAYuUZLvdlVSUoAxKZYUaM3nw==
X-Received: by 2002:a9d:491:: with SMTP id 17mr512034otm.338.1601443447231;
        Tue, 29 Sep 2020 22:24:07 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u2sm129108oot.39.2020.09.29.22.24.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Sep 2020 22:24:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 29 Sep 2020 22:24:05 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chu Lin <linchuyuan@google.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        qiongwang@google.com, zhongqil@google.com, jasonling@google.com,
        belgaied@google.com
Subject: Re: [PATCH v3 2/2] hwmon: pmbus: max20730: adjust the vout reading
 given voltage divider
Message-ID: <20200930052405.GA194784@roeck-us.net>
References: <20200924215444.2865885-1-linchuyuan@google.com>
 <20200924215444.2865885-3-linchuyuan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924215444.2865885-3-linchuyuan@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 09:54:44PM +0000, Chu Lin wrote:
> Problem:
> We use voltage dividers so that the voltage presented at the voltage
> sense pins is confusing. We might need to convert these readings to more
> meaningful readings given the voltage divider.
> 
> Solution:
> Read the voltage divider resistance from dts and convert the voltage
> reading to a more meaningful reading.
> 
> Testing:
> max20730 with voltage divider
> 
> Signed-off-by: Chu Lin <linchuyuan@google.com>
> ---

<Formletter>  
Change log goes here. If it is missing, I won't know what changed.
That means I will have to dig out older patch versions to compare.
That costs time and will hold up both this patch as well as all other
patches which I still have to review.

Please keep this in mind when submitting patch revisions without change log.
</Formletter>

Worse, this is v3, and I had given v2 a Reviewed-by: tag which was dropped.
This means I have to compare the two versions to figure out what changed,
probably just to find out that nothing has changed since v2.

Patches like this are the reason why various patches won't make it into
the next kernel release. Sorry, I just don't have as much time as people
seem to think I have.

Guenter

>  drivers/hwmon/pmbus/max20730.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/max20730.c b/drivers/hwmon/pmbus/max20730.c
> index a151a2b588a5..fbf2f1e6c969 100644
> --- a/drivers/hwmon/pmbus/max20730.c
> +++ b/drivers/hwmon/pmbus/max20730.c
> @@ -31,6 +31,7 @@ struct max20730_data {
>  	struct pmbus_driver_info info;
>  	struct mutex lock;	/* Used to protect against parallel writes */
>  	u16 mfr_devset1;
> +	u32 vout_voltage_divider[2];
>  };
>  
>  #define to_max20730_data(x)  container_of(x, struct max20730_data, info)
> @@ -114,6 +115,14 @@ static int max20730_read_word_data(struct i2c_client *client, int page,
>  		max_c = max_current[data->id][(data->mfr_devset1 >> 5) & 0x3];
>  		ret = val_to_direct(max_c, PSC_CURRENT_OUT, info);
>  		break;
> +	case PMBUS_READ_VOUT:
> +		ret = pmbus_read_word_data(client, page, phase, reg);
> +		if (ret > 0 && data->vout_voltage_divider[0] && data->vout_voltage_divider[1]) {
> +			u64 temp = DIV_ROUND_CLOSEST_ULL((u64)ret * data->vout_voltage_divider[1],
> +							 data->vout_voltage_divider[0]);
> +			ret = clamp_val(temp, 0, 0xffff);
> +		}
> +		break;
>  	default:
>  		ret = -ENODATA;
>  		break;
> @@ -364,6 +373,15 @@ static int max20730_probe(struct i2c_client *client,
>  	data->id = chip_id;
>  	mutex_init(&data->lock);
>  	memcpy(&data->info, &max20730_info[chip_id], sizeof(data->info));
> +	if (of_property_read_u32_array(client->dev.of_node, "vout-voltage-divider",
> +				       data->vout_voltage_divider,
> +				       ARRAY_SIZE(data->vout_voltage_divider)) != 0)
> +		memset(data->vout_voltage_divider, 0, sizeof(data->vout_voltage_divider));
> +	if (data->vout_voltage_divider[1] < data->vout_voltage_divider[0]) {
> +		dev_err(dev,
> +			"The total resistance of voltage divider is less than output resistance\n");
> +		return -ENODEV;
> +	}
>  
>  	ret = i2c_smbus_read_word_data(client, MAX20730_MFR_DEVSET1);
>  	if (ret < 0)
