Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 886D82AF388
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 15:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgKKO3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 09:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgKKO3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 09:29:09 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856F3C0613D1;
        Wed, 11 Nov 2020 06:29:09 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id m13so2336218oih.8;
        Wed, 11 Nov 2020 06:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R8B3c+/kXSfNa1B6GwshGOoXMqR4OPpxhJAynKdEYDQ=;
        b=DzfXXepeB+68CS32asW2qhQM7ad77y5qB/kPEocKrvxFsok4AIZIv0VISIv6lGY6fu
         f87oqRjk3476vIxQ2C8XYd2FZDxa2dhxN3FX3CEzBY79Kv2DLdDibXV8R7xt3QujOaHD
         8Nbh/ysfiyUKmZzNxcKBXkbzPqJ1D/7idOEyXi1OlDLGR9mH7JP1NekoR4fmNrTugnMg
         sa+6IF+nnfAK57XbxizZ33hqCbWSZGapmR0VDUQatybR7U4H8gUeGaVL37scB1TrgDNk
         mBnhqlgMCBX91xrMvrbAaZ480PfChpXMGfHUtqtp+BgGicSbC1ODwhJz/IPCXxvZUOSu
         5o6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=R8B3c+/kXSfNa1B6GwshGOoXMqR4OPpxhJAynKdEYDQ=;
        b=B3vY0OAvWy5P/pRZjmgH74xozWyBqSSitCtom1P9Ci9AvjHH8jcdlqSbgQkny1erqV
         oCqr8I9ui1Za9yJM1OvnU6mxv+FPTYH9j9V8suS2vZ2Fcp02PIf5/o42V3abB5Vx39Xf
         UIR4DnA1dwWgv6FHfDyO4fqKdk6gTqTugsyhEDSIb0EtoFMKmHiQAfBO/zV/3Mg7skML
         piCskpdHUtjzR6R6JYYeBPp7nQqDuKY+v8yWTxhLaNQFTw3fjUR4syLwjtoaJjveuy+W
         goy6rk/Q1GFbPybcLoI66PLd1p22h7nIJ4rJp3fxrzxwBZC4AX0scfAr92FSemJtX4so
         83Pg==
X-Gm-Message-State: AOAM532IW5wBTNkS8h6vHV/kpO19+tqzTZ8W1CPQ7hjjCfOMDXTlbT7N
        uQvD5BNf6bb6i0R2m0eRJkLcU798zZE=
X-Google-Smtp-Source: ABdhPJwoRBLsGNjcAuGX7xXDAeLsAsnn7cHUXjwsJVJDLT09p0kpJQSEbLRzs5Foyi4arUhedwWPXg==
X-Received: by 2002:a05:6808:983:: with SMTP id a3mr2169480oic.15.1605104948907;
        Wed, 11 Nov 2020 06:29:08 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o63sm545158ooa.10.2020.11.11.06.29.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2020 06:29:07 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] hwmon: Fix unsigned 'reg' compared with zero in
 amc6821_update_device
To:     xiakaixu1987@gmail.com, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
References: <1605082396-26560-1-git-send-email-kaixuxia@tencent.com>
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
Message-ID: <6d1e9fbf-86a4-9427-de7a-48d946cb59b8@roeck-us.net>
Date:   Wed, 11 Nov 2020 06:29:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1605082396-26560-1-git-send-email-kaixuxia@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/20 12:13 AM, xiakaixu1987@gmail.com wrote:
> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> The unsigned variable reg is assigned a return value from the call
> to i2c_smbus_read_byte_data(), which may return negative error code.
> 
> Fixes coccicheck warning:
> 
> ./drivers/hwmon/amc6821.c:215:6-9: WARNING: Unsigned expression compared with zero: reg > 0
> ./drivers/hwmon/amc6821.c:228:6-9: WARNING: Unsigned expression compared with zero: reg > 0
> 
> Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
> ---
>  drivers/hwmon/amc6821.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
> index 6b1ce2242c61..ce7c9f412538 100644
> --- a/drivers/hwmon/amc6821.c
> +++ b/drivers/hwmon/amc6821.c
> @@ -166,7 +166,7 @@ static struct amc6821_data *amc6821_update_device(struct device *dev)
>  	struct amc6821_data *data = dev_get_drvdata(dev);
>  	struct i2c_client *client = data->client;
>  	int timeout = HZ;
> -	u8 reg;
> +	s8 reg;

That is pointless since the return value is not checked. On top of that,
there are many similar assignments to u8 variables, return values
from calls to i2c_smbus_read_byte_data() are never checked in
this function, and the u8 part is actually needed. If you want to
fix it, please go ahead, but please fix the entire driver and please
do it correctly (here: the variable should be 'int' and the return
value should be checked).

Thanks,
Guenter
