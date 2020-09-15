Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0DC426B09A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 00:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgIOWPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 18:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727759AbgIOQit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 12:38:49 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCA9C06178A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 09:37:50 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id i17so4557536oig.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 09:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j1IjPX42QV4ZtmFRWDiz+pKpHRVz7JIwU6XXJfdBbV8=;
        b=B0GnAyAMlkdBkFa/WL3TZAE+Js/7ZQOwxfCf8Ri+PiqaQ5dm3hLmTuwobKrbCRpMAz
         jTRuGgQ+xvJJ9LYvdbVGkrxJTR4ta9884mUF16m/oS6CNFPmbJEBdaBClf+rUMUKoz4j
         Yn0sH7WN0aSs9dW1P7Lrfknf7+/lJhZDZEP28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j1IjPX42QV4ZtmFRWDiz+pKpHRVz7JIwU6XXJfdBbV8=;
        b=IOBJZgPekCVm/VJAP46BmF+INTlXt2nnmVtKz4dBs4m3Xy+Vz0VUAIuj05NPqOOCcd
         T/LPg6mEYRiIyJeaF+hKbitbXkGgqZznCzG0sFzE0KUpkGUM9aRXdeloAXyTGsg/aOxr
         ovAwqCIwFvzSE4NnOYlYHk2N/RymOPY3yMBfXW8PpwNi6m5gLpQx2b403yN0sBCZLyRJ
         zc5IMzuzOkvZ8PNdA3BkHo8uqfRKy9EIm8qp0vAtq8R3HzXEm0aVK7ShgosopuqhgQ9Z
         fFvhFbJA+KspyQWhSs2+aiHDjaaLHuKLWdB0JYEWXSAkBZ+GhOqpz2pw5YNJxthoIRh8
         jNAg==
X-Gm-Message-State: AOAM531j0+w9fkpJ7Hnda/Ew6B1378wS4fHLK7GZCimcMVA0dgAwwhFJ
        KrJhO6g1YOUpfyvhJf9DDEQxJA==
X-Google-Smtp-Source: ABdhPJw6wj4ib5lJiJmrAZyhwGegpz0slieqSzCh8ct3zcoOAsww+au1Sc+hbv/5x4nr4RYgZFZwOg==
X-Received: by 2002:aca:fd95:: with SMTP id b143mr203924oii.68.1600187869898;
        Tue, 15 Sep 2020 09:37:49 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id m20sm7553821oof.23.2020.09.15.09.37.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 09:37:49 -0700 (PDT)
Subject: Re: [PATCH -next] usbip: simplify the return expression of
 usbip_core_init()
To:     Liu Shixin <liushixin2@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200915032631.1772673-1-liushixin2@huawei.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <81ff1561-ab22-905c-7fd1-424814e96c41@linuxfoundation.org>
Date:   Tue, 15 Sep 2020 10:37:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200915032631.1772673-1-liushixin2@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/20 9:26 PM, Liu Shixin wrote:
> Simplify the return expression.
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>   drivers/usb/usbip/usbip_common.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/usbip/usbip_common.c b/drivers/usb/usbip/usbip_common.c
> index e4b96674c405..4ce6c6a45eb1 100644
> --- a/drivers/usb/usbip/usbip_common.c
> +++ b/drivers/usb/usbip/usbip_common.c
> @@ -755,13 +755,7 @@ EXPORT_SYMBOL_GPL(usbip_recv_xbuff);
>   
>   static int __init usbip_core_init(void)
>   {
> -	int ret;
> -
> -	ret = usbip_init_eh();
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> +	return usbip_init_eh();
>   }
>   
>   static void __exit usbip_core_exit(void)
> 

Looks good to me.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
