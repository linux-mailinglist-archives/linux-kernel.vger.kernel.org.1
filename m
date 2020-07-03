Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9532A214156
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 23:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgGCV7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 17:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgGCV7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 17:59:15 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7927BC061794;
        Fri,  3 Jul 2020 14:59:15 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mn17so1020157pjb.4;
        Fri, 03 Jul 2020 14:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=es7uSsK2kIHT3Qt9xpMkaP55J0rCS/Vn7TaGW0K3Ag0=;
        b=uL5kD7BQDCEBkNw89Wcsj1WS/83Vezp3D2EMNteano37u+bUGRiQzTlVkAFyzUPXUN
         UJfrUsDcHSeUtY3eXp0BkElbUsmNOHtodSLxC687/KPENiimZJNXRYy4xyV7Ai1eXB2S
         /SgCh0/4e57Jc0vjbkHdzUopWsx4UReVyym7fw19KjumX88cKhP2CMABgvW13EC/5diE
         zIdUkzDyhGD283UI+wWzLLteYxisRfeNAtQRS76UJDxmgCA5JSX1P2M/K385t9pcr0MB
         mI3kOLgpFTVrOb5t+PeqGzD0/JljavpkedlvqSU3ylMGzprTzyppm/dgSWYlxI7Wg0cc
         HsMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=es7uSsK2kIHT3Qt9xpMkaP55J0rCS/Vn7TaGW0K3Ag0=;
        b=FCOMcI6sXNnnZ+JzZhtjt+5TsqUCPg6R1fhTjHqDNVqWgGY7vG2ZEBb5wSh9whfMtc
         MY4evPv7AXEdyb+qTIT6VjhZoUMFnsF8IAEikSS8jVd/E29lfx1xUU6f/LPdBZfQpHaJ
         1Fh4NcXPMYp0XHUNUqUQrA3WCOUbuFJIMDml1XFzNKsekJ7CbTjA46oRmlivmgcYDMCp
         pn/HNSKPLubQf/hsRlWbrzFkoauDSxJPJ6/+YIlJRfm/nG39upQZTeOOvBR6FkfjdeMH
         6SxOhPmYP1tosxvLtwwcAYcAAscVbzeueOh6QscvtB5fgE5tvrbfJZA9KkpjDaoMU8/K
         0Ssw==
X-Gm-Message-State: AOAM533hprj0TenUleQkrZInF3CstEY9GGvoCE1JlRRTo5nvjnesz5Lt
        F3Cxfd4JrXB2NvF3sswNQNJzpestNUQ=
X-Google-Smtp-Source: ABdhPJxduWUQkkuoiRrkORTG6d2hs8BqMvx/8TD7p1ckPAyTT9Uzroo1sY7VEHRzyJvmb0zqoOlWcw==
X-Received: by 2002:a17:90a:71c1:: with SMTP id m1mr278003pjs.22.1593813554651;
        Fri, 03 Jul 2020 14:59:14 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bx18sm4019461pjb.49.2020.07.03.14.59.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2020 14:59:14 -0700 (PDT)
Subject: Re: [PATCH] dt-bindings: hwmon: Correct vendor for mcp980x
To:     "Daniel M. Weeks" <dan@danweeks.net>, jdelvare@suse.com,
        robh+dt@kernel.org
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200703153748.GA16156@dev.danweeks.net>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <4884254c-4406-5c04-3df7-030541b7c201@roeck-us.net>
Date:   Fri, 3 Jul 2020 14:59:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200703153748.GA16156@dev.danweeks.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/20 8:37 AM, Daniel M. Weeks wrote:
> Signed-off-by: Daniel M. Weeks <dan@danweeks.net>
> ---
>  Documentation/devicetree/bindings/hwmon/lm75.txt | 2 +-
>  drivers/hwmon/lm75.c                             | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/lm75.txt b/Documentation/devicetree/bindings/hwmon/lm75.txt
> index 273616702c51..e5bb554cd2c3 100644
> --- a/Documentation/devicetree/bindings/hwmon/lm75.txt
> +++ b/Documentation/devicetree/bindings/hwmon/lm75.txt
> @@ -14,10 +14,10 @@ Required properties:
>  		"maxim,max6626",
>  		"maxim,max31725",
>  		"maxim,max31726",
> -		"maxim,mcp980x",
>  		"nxp,pct2075",
>  		"st,stds75",
>  		"st,stlm75",
> +		"microchip,mcp980x",
>  		"microchip,tcn75",
>  		"ti,tmp100",
>  		"ti,tmp101",
> diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
> index ba0be48aeadd..a8cfc7e4a685 100644
> --- a/drivers/hwmon/lm75.c
> +++ b/drivers/hwmon/lm75.c
> @@ -690,10 +690,6 @@ static const struct of_device_id __maybe_unused lm75_of_match[] = {
>  		.compatible = "maxim,max31726",
>  		.data = (void *)max31725
>  	},
> -	{
> -		.compatible = "maxim,mcp980x",
> -		.data = (void *)mcp980x
> -	},
>  	{
>  		.compatible = "nxp,pct2075",
>  		.data = (void *)pct2075
> @@ -706,6 +702,10 @@ static const struct of_device_id __maybe_unused lm75_of_match[] = {
>  		.compatible = "st,stlm75",
>  		.data = (void *)stlm75
>  	},
> +	{
> +		.compatible = "microchip,mcp980x",
> +		.data = (void *)mcp980x

Hmm, makes me wonder if we should replace this with correct chip names
since we are at it. After all, it only includes mcp980{0,1,2,3} and not mcp9805.

Rob, any thoughts ?

Guenter

> +	},
>  	{
>  		.compatible = "microchip,tcn75",
>  		.data = (void *)tcn75
> 

