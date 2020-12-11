Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D6D2D78D8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 16:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437708AbgLKPLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 10:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392465AbgLKPKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 10:10:52 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F48C0613D6;
        Fri, 11 Dec 2020 07:10:11 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id d27so10145973oic.0;
        Fri, 11 Dec 2020 07:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iHJ0+YT0ZuQ160ES/8XaQZHgGFmJugTj3JOGwfxYxeI=;
        b=IoeSM4U//Vi8gEVmA4snGnIRPGevd7qR4wlmy8q573iQUCXMzQnl4fpmkvksYDsmx8
         YkYZVJV1VYFw/bYF5eI11R+b2yuExfejwMRd+Ao/5y3MvF0aUYjU2NfsP10heqRJzaIT
         TWwe8KLH1e6FBmAST6ZMHb/Mpj17cB3NFFfVmFbz/7mVVVyE8755osW4AerSRkY9xR1B
         txSTYUXWvlZ9byqAuNv6tiSjY3YZMw/yFrrudbNiyad6n+c18/gR3pSczVyAif247UAh
         1o0H791198IxRrPvWJpyqoSc715JsjI9kAm03WbC/Kc/yu0E8+Vs5o7BH+HYtuO1i3oR
         m4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=iHJ0+YT0ZuQ160ES/8XaQZHgGFmJugTj3JOGwfxYxeI=;
        b=NUcNK4LYidrDQ7RdHX9naHh4tLJBBrhaQeB7o7Ig+ySiFt0GoqJ1dh1CSvmdPPKPPF
         Gv8PcF3N/VLhzzDwNki2b34A2+SYuYoCHf9XP/VU0qdKTo3s4lowN/Cg1Bfex6TBAQgT
         6gFB5UkKCzYfIbRSdl4z1N0VhnRlP1ZAzOe9fWPCCIKQQUWd2d512VspZtqtZ8DHD5bS
         2MvvQ2K2lGa5JRjZxL7mOTbplh9tmO4FaxbvaymXjidLQLkbHfch5xik+cNvJ+98DpXy
         5tz/NrcFgmVVJDARDN5XGpRO7znoxI/jCTcKjncBjjWeMwJGH6L5Camzla4lRYdzAq/u
         L57g==
X-Gm-Message-State: AOAM533jUsSGy39HwsIAuDody3ETmYWWAk/ZS4dhjpvwHpDrzBDApHYo
        +4vbKSfdnqIjeHfcmM0HRpmxaNHqc50=
X-Google-Smtp-Source: ABdhPJx3lJ6W3CCkCCHuj+uqjN25kfyWg+IPpRzPDIs4ehhqOwuhkVAar7jFVv5rDYsfhvvjHEKmyg==
X-Received: by 2002:aca:d6c5:: with SMTP id n188mr9460336oig.131.1607699410542;
        Fri, 11 Dec 2020 07:10:10 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 5sm717432ota.62.2020.12.11.07.10.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Dec 2020 07:10:08 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH -next] usb: typec: tcpm: convert comma to semicolon
To:     Zheng Yongjun <zhengyongjun3@huawei.com>,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201211085553.2982-1-zhengyongjun3@huawei.com>
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
Message-ID: <134feafc-7ba8-0786-4e1b-86549f352b14@roeck-us.net>
Date:   Fri, 11 Dec 2020 07:10:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201211085553.2982-1-zhengyongjun3@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/20 12:55 AM, Zheng Yongjun wrote:
> Replace a comma between expression statements by a semicolon.
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index a6fae1f86505..4451507d600c 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -5024,14 +5024,14 @@ static int devm_tcpm_psy_register(struct tcpm_port *port)
>  	snprintf(psy_name, psy_name_len, "%s%s", tcpm_psy_name_prefix,
>  		 port_dev_name);
>  	port->psy_desc.name = psy_name;
> -	port->psy_desc.type = POWER_SUPPLY_TYPE_USB,
> +	port->psy_desc.type = POWER_SUPPLY_TYPE_USB;
>  	port->psy_desc.usb_types = tcpm_psy_usb_types;
>  	port->psy_desc.num_usb_types = ARRAY_SIZE(tcpm_psy_usb_types);
> -	port->psy_desc.properties = tcpm_psy_props,
> -	port->psy_desc.num_properties = ARRAY_SIZE(tcpm_psy_props),
> -	port->psy_desc.get_property = tcpm_psy_get_prop,
> -	port->psy_desc.set_property = tcpm_psy_set_prop,
> -	port->psy_desc.property_is_writeable = tcpm_psy_prop_writeable,
> +	port->psy_desc.properties = tcpm_psy_props;
> +	port->psy_desc.num_properties = ARRAY_SIZE(tcpm_psy_props);
> +	port->psy_desc.get_property = tcpm_psy_get_prop;
> +	port->psy_desc.set_property = tcpm_psy_set_prop;
> +	port->psy_desc.property_is_writeable = tcpm_psy_prop_writeable;
>  
>  	port->usb_type = POWER_SUPPLY_USB_TYPE_C;
>  
> 

