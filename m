Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5424D2ED77F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 20:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbhAGTdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 14:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729217AbhAGTdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 14:33:44 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE128C0612F4;
        Thu,  7 Jan 2021 11:33:03 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id o17so17327280lfg.4;
        Thu, 07 Jan 2021 11:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vxUip14RHVX/OnxxwbLmc0hVz7ijR2h5m5MRiT/bCAE=;
        b=a2fTOP8+Sw7uFzLwIHNPQPdw9SBnjjOYW0iyQO9mY99jrwJgS0BotesqRsiXc/Oa7y
         TxbfpgYRY5wJ/wUZ0sjQvoT5iWMZHYJIzxzbmxpDeD4EJIJ+upIGUY5GDja59hgUFp6R
         sxdJ2eQ+hPi6RQPM91nGwFXyRgvYDpxyd6pq1s/kJcVF5GiGvOKVYrTz5dZkaIZcXsIH
         9q0BXX/l4A8k4z3Cc3rK4LZld0x6DNSIzGZ5p+FANkYq9y4xxPVn4KEoD/UjfoxcK4jY
         irVwOaRdax8RX/Mg/clSYEDs5zOmfJCWL5ogALItAzrJxRtAzpyk2idSHRyQFidp9Y/L
         gP6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vxUip14RHVX/OnxxwbLmc0hVz7ijR2h5m5MRiT/bCAE=;
        b=fhkSQ/3YtjrymdCQiuRh1pPLRMUS0ucSdt+Mw8B/w0dxoz40plkdHxDnQxsunH3eJf
         g59rkSlWU75ln0v2ylY3CX5BjdaKSL0N0az/irz1Al8tn5yFiT2VTAeZ60g6a7KwlUB2
         Jz4sXKm0/Ua5GNVcEsRWwWM/DfeP2MERTqtnSIPKfZmMtTdfXpTJN7dhFsogVpx6snUY
         vCRnrC6NGkzYHNWbwstojKsiwPjEXCaPB0ZGbCZpg/IjB+QfQRHhMzqapS5kOgBKB6GF
         SQKJRVaYyAfC3HHE9RogE3XAgeyUaB/thgSL1xlInKejFdLh9NWFk0ELHaobeWGolKfk
         pJuQ==
X-Gm-Message-State: AOAM531KcbYT9azleoUCkSEDlwi5ePfqn14zdJ8mH5vmy2qxSXiVQGaH
        SsCxbRzzMlpRdTit+ET5E0xSkNn3R6M=
X-Google-Smtp-Source: ABdhPJwFmIgqOwxg/9mqqNTGbKZ765Zo2UcnYWWDC9ReW7Hi1/+lK4w+7lv34DtC/EwPZsVvTlNyPA==
X-Received: by 2002:a05:6512:4cf:: with SMTP id w15mr116805lfq.656.1610047981344;
        Thu, 07 Jan 2021 11:33:01 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.googlemail.com with ESMTPSA id a23sm1332780lfm.125.2021.01.07.11.33.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 11:33:00 -0800 (PST)
Subject: Re: [PATCH] usb: dwc3: Replace of_reset_control_array_get()
To:     Yejune Deng <yejune.deng@gmail.com>, balbi@kernel.org,
        gregkh@linuxfoundation.org, p.zabel@pengutronix.de
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1604395500-8086-1-git-send-email-yejune.deng@gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <49ee0444-4e0f-1dbe-c59a-74c72b34b140@gmail.com>
Date:   Thu, 7 Jan 2021 22:33:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <1604395500-8086-1-git-send-email-yejune.deng@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

03.11.2020 12:25, Yejune Deng пишет:
> of_reset_control_array_get_optional_exclusive() looks more readable
> 
> Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
> ---
>  drivers/usb/dwc3/dwc3-of-simple.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
> index e62ecd2..e358ff0 100644
> --- a/drivers/usb/dwc3/dwc3-of-simple.c
> +++ b/drivers/usb/dwc3/dwc3-of-simple.c
> @@ -52,8 +52,7 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
>  	if (of_device_is_compatible(np, "rockchip,rk3399-dwc3"))
>  		simple->need_reset = true;
>  
> -	simple->resets = of_reset_control_array_get(np, false, true,
> -						    true);
> +	simple->resets = of_reset_control_array_get_optional_exclusive(np);
>  	if (IS_ERR(simple->resets)) {
>  		ret = PTR_ERR(simple->resets);
>  		dev_err(dev, "failed to get device resets, err=%d\n", ret);
> 

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
