Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDE1326BA76
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 05:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbgIPDCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 23:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgIPDCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 23:02:49 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A68C06174A;
        Tue, 15 Sep 2020 20:02:49 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id m12so5354634otr.0;
        Tue, 15 Sep 2020 20:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P3ZDmBbidV1H7FTbdP5XdZRBLhou0d9Q+v5+7AuvbmI=;
        b=o/5yBanebXShlfaIO5CgjlHQf0TJaplZfyZ52reqFoVfCnoH2dcjwWsxpqp8nA9uNd
         avK+Dk3Ju3hvacrvy7MKffY6wRRjGCxrYNfTlV4FiRt81TC3mVPfyHQHtCO366cMy/Fq
         DXEbD2KSieYHDd9imMRKGnWa7/3TyqfNg9KqzjYl2d83ARFsaedlT4nwCoZ7+xhH6pCo
         bWGc3j5+v49vKLfHXtmjGPdkoB6Ln1Egz/rNZVboZTQvFg9P0bgM/eDweIbeJ9B4lY2S
         ZVOdGcQjcZOyoxtHMaYEq+r+hpQ72txDss3wBP83BAyoauqiVNWQ8YGtS86KFH6Tpgxt
         u3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=P3ZDmBbidV1H7FTbdP5XdZRBLhou0d9Q+v5+7AuvbmI=;
        b=UARFQS9vas8XEfT0n3Ib9tGxlblWRjxQ7QDOSUEWGMgpr0llqN/zc3PbsXpIwHq7kC
         39FImWnawBCNcm/PA6AF8fiE5XfHXwOO/x+/+FSOCsVq2k1mAmgtQDR3zxdWe/PDx/KD
         +eddGk2TzCl4BPSzD5af6zpJrUgzx9dF9SM0ZpL1grKBXsqo4a7BtKhZsfUKEtcCyFec
         Ik/AIQr6PJytPeXzG6eT00MyNCZzxoUDdcqWJNNIUCup8kESjSyA4PfBNUdYawldC953
         /f4HxI/5fh4/5vdJN/6yG6ibmne1CYtnTd2gq7E5SJKX7thx+rk4gQj6L7nclZA9f8tb
         ZS0g==
X-Gm-Message-State: AOAM530TaoyapsH11fM7zfPHiv0a65tkVMGv/KP0kkvb4PeTyDyKTDXA
        gQBTjGiGF592S7a7/w37JQ0=
X-Google-Smtp-Source: ABdhPJyAysd7TOGh7AMBcQlQL/mfyBKjlvXjichoqG7P48+mToLkSlqu46K53Fr1UlEziwjOyGy8xg==
X-Received: by 2002:a05:6830:12c7:: with SMTP id a7mr15757748otq.334.1600225368786;
        Tue, 15 Sep 2020 20:02:48 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e19sm6483441ote.37.2020.09.15.20.02.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 20:02:48 -0700 (PDT)
Subject: Re: [PATCH v2] hwmon: pmbus: max20730: adjust the vout reading given
 voltage divider
To:     Chu Lin <linchuyuan@google.com>, jdelvare@suse.com,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        qiongwang@google.com, zhongqil@google.com, jasonling@google.com,
        belgaied@google.com
References: <20200911000050.2301678-1-linchuyuan@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <196e30ce-634c-a543-814d-d17c6a926cf8@roeck-us.net>
Date:   Tue, 15 Sep 2020 20:02:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200911000050.2301678-1-linchuyuan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/20 5:00 PM, Chu Lin wrote:
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

For my reference:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

We'll have to wait for DT review before I can apply the patch.

Thanks,
Guenter

> ---
> ChangeLog v1 -> v2
>   - Don't do anything to the ret if an error is returned from
>     pmbus_read_word
>   - avoid overflow when doing multiplication
> 
>  drivers/hwmon/pmbus/max20730.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/max20730.c b/drivers/hwmon/pmbus/max20730.c
> index c0bb05487e0e..83affdad4060 100644
> --- a/drivers/hwmon/pmbus/max20730.c
> +++ b/drivers/hwmon/pmbus/max20730.c
> @@ -29,6 +29,7 @@ struct max20730_data {
>  	struct pmbus_driver_info info;
>  	struct mutex lock;	/* Used to protect against parallel writes */
>  	u16 mfr_devset1;
> +	u32 vout_voltage_divider[2];
>  };
>  
>  #define to_max20730_data(x)  container_of(x, struct max20730_data, info)
> @@ -111,6 +112,14 @@ static int max20730_read_word_data(struct i2c_client *client, int page,
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
> @@ -329,6 +338,15 @@ static int max20730_probe(struct i2c_client *client,
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
> 

