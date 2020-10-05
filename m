Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36BC028390F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 17:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgJEPJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 11:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgJEPJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 11:09:04 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824C1C0613CE;
        Mon,  5 Oct 2020 08:09:04 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id u126so8982038oif.13;
        Mon, 05 Oct 2020 08:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5EyUBblOiDmWcpZQ14k8x7x0Ix+bWgSiATXrJ6A1d3s=;
        b=b3PyHH92xAoIoTSb2WnNAxkFT6t1E3QWOESREMgJHHILdTqiM7tSbDT3NXRjaKlm48
         Lb+yry5erSGfa35pCCyyrG9jXRzqD7lR/GUbme7dZHZmg9aO1E9lHk5zUFWOX7+RBCGU
         c04wCRbsCoxbMLipk6AEYFX29BM2NmsbLdMhIhuoc8W6vly9F/IL3GGuuKpGfziU4K1d
         mqdhLxufU+pV5NCPnfTJAXcHGmIceVa3nOjm2Ul7cAxgfVIyWiBRRX/cHgOBEVloYIvf
         XLHQ15j3k/b1+lxRUfQHMXywX/p8RR6TTlyiQdc6KVxl/Rx22gJmAHTBH8fvmVffMsF/
         BAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=5EyUBblOiDmWcpZQ14k8x7x0Ix+bWgSiATXrJ6A1d3s=;
        b=Tf30A6wV/tP0EvOn0FpD5yF5stQoB5fQhMwAZad4ndTHGgFYs/FFpxaffFJSUpdNhN
         9RTkSjYshLfMJyDCU272mKh+URHShGM32RIWQwfKLLC2DuPSsxio9UoJdKvFs4nLB21C
         j25HxJ0dUO1jrZboxTfP9pcI6e9j+F5ghUcc9sJvNrKrksqzqTbjh9HbMBTuCaCxh1BW
         X/T9MjYY5KWW2nPKLYiZfjynsvmuXFIuR4yf2HUWrgO7aL6BUe7A/KpybJLlIfVUAYAV
         5x9JR123N/Zf+Liex4kn3QhHXnWOeASx/Bs6CofDfOFfdDJWYNDDeYz/jXzfv8XgK6sP
         SAgw==
X-Gm-Message-State: AOAM530xvQZkYonD7KrGX2ik9Pdaip4qyp5YMuFpirgh30sjsezYX8Mk
        xkGk85wUbizC5lsw0bcZ3KrOKA6s6GY=
X-Google-Smtp-Source: ABdhPJy/q3Vh54Vq5544BqYSrD+mc8Cc55hhYcxBr5SxsY2ivMjpLddChO2mblKISOFUgkfLuFi0lA==
X-Received: by 2002:aca:db42:: with SMTP id s63mr52169oig.4.1601910543966;
        Mon, 05 Oct 2020 08:09:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k24sm53714oou.43.2020.10.05.08.09.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2020 08:09:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] hwmon: (pmbus/max34440) Fix/add missing break statements
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jdelvare@suse.com, foremans@google.com
References: <20201005115041.1750626-1-alexandru.ardelean@analog.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <40cc33b8-1dcf-898d-42f1-53b4404a80b9@roeck-us.net>
Date:   Mon, 5 Oct 2020 08:09:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201005115041.1750626-1-alexandru.ardelean@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/20 4:50 AM, Alexandru Ardelean wrote:
> This one was caught by the compiler.
> Adds missing break statements, which look omitted by accident.
> 
Most definitely.

> Fixes: 599a5ac5f96c ("hwmon: (pmbus/max34440) Fix/add missing break statements")

This should point to the culprit.

> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
> 
> Maybe the lkp bot also reported this [by now].
> I just bumped into this now, trying to work on another driver.
> Now whether this gets applied, or a V2 is created, is not important from my
> side.
> 
Thanks, folded into the original patch.

Guenter

> This is a heads-up [from my side].
> 
>  drivers/hwmon/pmbus/max34440.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/max34440.c b/drivers/hwmon/pmbus/max34440.c
> index bdea52996580..f4cb196aaaf3 100644
> --- a/drivers/hwmon/pmbus/max34440.c
> +++ b/drivers/hwmon/pmbus/max34440.c
> @@ -61,9 +61,11 @@ static int max34440_read_word_data(struct i2c_client *client, int page,
>  	case PMBUS_IOUT_OC_FAULT_LIMIT:
>  		ret = pmbus_read_word_data(client, page, phase,
>  					   MAX34440_IOUT_OC_FAULT_LIMIT);
> +		break;
>  	case PMBUS_IOUT_OC_WARN_LIMIT:
>  		ret = pmbus_read_word_data(client, page, phase,
>  					   MAX34440_IOUT_OC_WARN_LIMIT);
> +		break;
>  	case PMBUS_VIRT_READ_VOUT_MIN:
>  		ret = pmbus_read_word_data(client, page, phase,
>  					   MAX34440_MFR_VOUT_MIN);
> @@ -133,9 +135,11 @@ static int max34440_write_word_data(struct i2c_client *client, int page,
>  	case PMBUS_IOUT_OC_FAULT_LIMIT:
>  		ret = pmbus_write_word_data(client, page, MAX34440_IOUT_OC_FAULT_LIMIT,
>  					    word);
> +		break;
>  	case PMBUS_IOUT_OC_WARN_LIMIT:
>  		ret = pmbus_write_word_data(client, page, MAX34440_IOUT_OC_WARN_LIMIT,
>  					    word);
> +		break;
>  	case PMBUS_VIRT_RESET_POUT_HISTORY:
>  		ret = pmbus_write_word_data(client, page,
>  					    MAX34446_MFR_POUT_PEAK, 0);
> 

