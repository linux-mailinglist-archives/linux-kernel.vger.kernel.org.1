Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 738A92ED758
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 20:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbhAGTRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 14:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727246AbhAGTRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 14:17:33 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F7BC0612F4;
        Thu,  7 Jan 2021 11:16:53 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id h22so17278864lfu.2;
        Thu, 07 Jan 2021 11:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Tmi4ZZSFbtcWT3WEnk3PFHwNm6XPgiqZDQ0nhPqRrY4=;
        b=FYJ90/OELmFIWd4yql4tMTwnT+k32mYfMcr4W6A0RoYX9zrCACcY1poXZPjeRVxGO/
         3SIDNVUC9zFie59wc4vjfeJUnzCkZsifwMtWr0B5DK10aViNudpBWU5oXgjwdHzCZGdX
         WHHnyT5+cJGJQlg+7UviSrBQ26twxafVLqaEphpSFVWOl51/YcSK1+it3005QjG55sLL
         Mr+T1wVhNGRkPYKFylf9ouraQ7hBBzaDLWKJoxLgvyXWYCB6SS327llw+7Kb5pcjIZC2
         sg5RsRM23iC+CE/tOp3eF1r/sY0T4pISshxKL5ARPmNCYYZipxENtMpX9QgMoss5cSEz
         KhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Tmi4ZZSFbtcWT3WEnk3PFHwNm6XPgiqZDQ0nhPqRrY4=;
        b=hrdwkpigy6F0UsCXsFCINGQtFlqZRfCR+0ORlwagPVxPMvL7FL3r++XDo/gRplf8fm
         vMieInBdVVdQHveotX9MGP57MZTahnIO3Cc5TgS3kOTp0kDlHXgyy0enHOGSkAKbBn3H
         6Ze/z3W4y11vnIz+p401wJWyKGzlD5vlnuFDREW5M8UDp/zfp2DFBADQCQXkCWGAzVPV
         sErQ75bGt0pUQIKqbYdkSFkEH3Hmh9e5HsCIDG+DUapVvGUNN6CjElBMxiseTkFkSmMZ
         MJS1IqHVA1oa6A7Cj8q56224kdZiFnkefVAmQasi8WabA39+i/ZDi41NR9/b8PRMOZFe
         /frg==
X-Gm-Message-State: AOAM533E/Ch5qYGE+Tdxsso3JCvmHwDC1BPajR4kbdvq9wBjWjDzX0Q0
        JJ592I/VnTkpLH63QLgVn98LGj1KNj8=
X-Google-Smtp-Source: ABdhPJzyzCw6KHWbPYr+9pAygyyJQir9SV9jvJTpR6HBwy5Pe52UYDbBHpLg1h81NTsf0RtowmUw5w==
X-Received: by 2002:a2e:8599:: with SMTP id b25mr4600642lji.334.1610047011350;
        Thu, 07 Jan 2021 11:16:51 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.googlemail.com with ESMTPSA id y4sm1338485lfl.179.2021.01.07.11.16.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 11:16:50 -0800 (PST)
Subject: Re: [PATCH] usb: dwc3: core: Replace devm_reset_control_array_get()
To:     Yejune Deng <yejune.deng@gmail.com>, balbi@kernel.org,
        gregkh@linuxfoundation.org, p.zabel@pengutronix.de
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1604375863-6649-1-git-send-email-yejune.deng@gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <11be44c1-0bd5-d09a-7820-f320a37a9da8@gmail.com>
Date:   Thu, 7 Jan 2021 22:16:50 +0300
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

Greg / Felipe, could you please pick up this patch?

I want to add devm_reset_control_array_get_exclusive_released() for
NVIDIA Tegra drivers and we need to get rid of all the open-coded
devm_reset_control_array_get() users in order to extend the reset API
sanely.

Thanks in advance.
