Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D7B2ED781
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 20:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbhAGTdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 14:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbhAGTdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 14:33:46 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E154AC0612F5;
        Thu,  7 Jan 2021 11:33:05 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id m25so17190213lfc.11;
        Thu, 07 Jan 2021 11:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qWIhu1B3Nxdf3nrEwuMLgmcfQjPaTVmJ9NBFWqTIxYE=;
        b=CeZz+JW6ehmM6nEkgfTptwufH7tQTVh6dYhOMMQ6CnMsbiXqneWoXvORou9FvVgbjj
         0JAj5M1OQv8ajKYTaDgPn//QMKOKins3JrVqJRyYBJ0Vae55VBbnoOwyqDt8I8xkcHDo
         WXB1baYLVrAVHPRwKOE4uNYGS79ucOpCVqJ1lQQ7S0tq+zZdRfxygxokhNARaJ5gqtdW
         169uSdB1ukVAZY3dGzQ1yRCYo9OT3zf/7hBz5B95wgn5FriC2ZgKwUJ2L1ge499fSgyT
         1VD6z4Sr3XD+yJBxTE9V7phMlN1dOC9QSTpes+fwcJ+/sPeYRY9GqJpxl7BbSK7jdMBv
         P71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qWIhu1B3Nxdf3nrEwuMLgmcfQjPaTVmJ9NBFWqTIxYE=;
        b=SBdfk90qT+KVb9D/BFlPy190tCKZvEqPqtmFwoihmg/GlhIiy1anuiEBZashbyOpca
         +q/D4eV6V7DdN5eLCrj4G3sa6e3xNLdiNnMN034lyGytky/GVpRJVmBKiJY278sSRF/b
         mI2sa+EmIctJc0cRJjaNPFIGoq2VDqs0gWRBvDUT5vPFBWHD3HGXJbosDhWyKIQdWkdJ
         6rlCBRvEcBlw+5qUKaBrVYsIDKsJAeYc4u+DQbWoBmTDALqPUxPMWqNeTEM0v5tr4Wm1
         OXe3Mh2DIo6N2ubsxqjH7oh07w8fWq/OGCjaDQYxn2wJzETsxhVfpVPINftZ3QsT0i7Z
         4gwg==
X-Gm-Message-State: AOAM530lw/yYy4cLPr8HQHa/OSo4jaOo33XiSbY7n7zVxc/NtTk6ZsQk
        wjAtGwrvx5aEXZjmh/xZcDvqDYH5NcI=
X-Google-Smtp-Source: ABdhPJyjDvPCCou0RO09CZ7HrA22/ijXyAyo5vyxnnC1jjFOETRZBl46QxCKPDDM8qnPcx3vgnbY4w==
X-Received: by 2002:a19:8b55:: with SMTP id n82mr104674lfd.485.1610047984305;
        Thu, 07 Jan 2021 11:33:04 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.googlemail.com with ESMTPSA id z3sm1375428lfj.140.2021.01.07.11.33.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 11:33:03 -0800 (PST)
Subject: Re: [PATCH] usb: dwc3: core: Replace devm_reset_control_array_get()
To:     Yejune Deng <yejune.deng@gmail.com>, balbi@kernel.org,
        gregkh@linuxfoundation.org, p.zabel@pengutronix.de
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1604375863-6649-1-git-send-email-yejune.deng@gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <18b30eab-cad4-d6e1-948f-c833ddfb2f79@gmail.com>
Date:   Thu, 7 Jan 2021 22:33:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <1604375863-6649-1-git-send-email-yejune.deng@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

03.11.2020 06:57, Yejune Deng пишет:
> devm_reset_control_array_get_optional_shared() looks more readable
> 
> Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
> ---
>  drivers/usb/dwc3/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 841daec..b87acf0 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -1490,7 +1490,7 @@ static int dwc3_probe(struct platform_device *pdev)
>  
>  	dwc3_get_properties(dwc);
>  
> -	dwc->reset = devm_reset_control_array_get(dev, true, true);
> +	dwc->reset = devm_reset_control_array_get_optional_shared(dev);
>  	if (IS_ERR(dwc->reset))
>  		return PTR_ERR(dwc->reset);
>  
> 

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
