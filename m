Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3D37285437
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 23:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgJFVzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 17:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbgJFVzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 17:55:54 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D01C061755;
        Tue,  6 Oct 2020 14:55:54 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id z26so185549oih.12;
        Tue, 06 Oct 2020 14:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qPX3xlYEkCVFEJ7SQA+ZBYnQiRoEfDKRNohYw4I7fUc=;
        b=nnOYOYnIuRdYoA8hDimnqCrsNcKdvCXrkoRiWW/B7tQwk20bxxSYi8CIywV8kgWM3r
         H71C2MO6lViyaBnpMRpLMGXBmuemoZoZ++dw2hBV/ZwFmEmM3t43sFbrpzgyOnjrToRS
         oMf0aJtU4RhuMQHfiibb/emlUkl74rEOpRqP/t427ooFu6JarODJXmlcXJDpCVbEbJ27
         9Q3xFwcT2y3lOEZIH9DecM3c3D69Mh6YxylNCGggDdIp46ts96hVouNJy/HdPUYyslXd
         S/4rHEbYPSFkBWUbcCC9uCytjcsN9dALkNRldcB+H44acC5KCIR6aKhysplVKQNasPMC
         aJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qPX3xlYEkCVFEJ7SQA+ZBYnQiRoEfDKRNohYw4I7fUc=;
        b=ZtmptKxXVujEK6XZHU6WFj4GsQszctzrI555IosKFolJ4vw2cwh3NxxCkaLEnKT+x7
         hpfp7PucMG3bfwHcz7kaUpdhr/f0pugwMPMsp5ULytvIUguRxD/9k0oU/KzFeO8i/k2G
         ggUmvLimGhGfORTIO2Mg2VO4DCJJLqLEcFZ45jATrN2K8iu9RAxbPDCVzbi4RRWQZoaE
         /s9PiNZDG1SlNqwttGCLkpLDQ1lkdZZ9fWXqvUOxodk26s6Ct0PxdNDs6a3O5ODcDjiw
         wBP9pkevmcyW6AVCRPJPTc3rqPNkWSuIog0bkQWfnP2a9n22R+0DENca1keFvQS4Ubug
         zy5w==
X-Gm-Message-State: AOAM530Z6WGB+eCsdHf4E5hmh3VsC4OO3W5KmeRySa//9iO+u4e6htWC
        wzHJ/f62oyQ/DKpAv8Vu9qCl7qwWLwU=
X-Google-Smtp-Source: ABdhPJyVFAc4xVraTI1NeRjHU6Aam9kZS7ykCm1oo9V5W9/I8sFXbAOds88PRaRe8n0OTFg28OErtg==
X-Received: by 2002:aca:b488:: with SMTP id d130mr231029oif.136.1602021354120;
        Tue, 06 Oct 2020 14:55:54 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9sm44174oig.56.2020.10.06.14.55.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Oct 2020 14:55:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 6 Oct 2020 14:55:52 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chu Lin <linchuyuan@google.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] hwmon: pmbus: max20730: adjust the vout reading
 given voltage divider
Message-ID: <20201006215552.GA96934@roeck-us.net>
References: <20201004031445.2321090-1-linchuyuan@google.com>
 <20201004031445.2321090-3-linchuyuan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201004031445.2321090-3-linchuyuan@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 04, 2020 at 03:14:45AM +0000, Chu Lin wrote:
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
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Applied to hwmon-next.

> ---
> ChangeLog v1 -> v2
>   hwmon: pmbus: max20730:
>   - Don't do anything to the ret if an error is returned from pmbus_read_word
>   - avoid overflow when doing multiplication
> 
> ChangeLog v2 -> v3
>   dt-bindings: hwmon: max20730:
>   - Provide the binding documentation in yaml format
>   hwmon: pmbus: max20730:
>   - No change
> 
> ChangeLog v3 -> v4
>   dt-bindings: hwmon: max20730:
>   - Fix highefficiency to high efficiency in description
>   - Fix presents to present in vout-voltage-divider
>   - Add additionalProperties: false
>   hwmon: pmbus: max20730:
>   - No change
> 
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
