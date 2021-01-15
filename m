Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6961F2F8327
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbhAOR6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbhAOR6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:58:05 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCADC061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:57:25 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id n2so2608165iom.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=M5BcvnzgflJduEgKE2tu+RY63yJ/WtPEtTDr/c+TeE0=;
        b=ZW5wj3+U+c90HGP5GaNhKJ2gsEvMj6pxKQrrnVzHqrsKDGbvbXy+wgKbBTxWeo0g/f
         FZjdRxhnICm0GU8xIzBOydRTChXCzMLS9/aGuruWEJ/Ik0BUM+3llZlxz3xcwWenwfSo
         ObeznzDrdtzgT/B1NaSsHrLyytHz9VkfwVEio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M5BcvnzgflJduEgKE2tu+RY63yJ/WtPEtTDr/c+TeE0=;
        b=iumzDpuSufLmHbyLQLI6Az9n3oYpIoaVomehxgZwIDQYbUMW82QU4UIZbElr636Hxb
         ImI5m3HA2capkn1k7Mir1DrlckBNMN1ifumAqLeTdCsZt96UjoGBJf3HNQiyfHO+7KJE
         pZpUIDYk8FnJeYit9Zh+J49tMmE6Jaipkcmxxt/r+JVG1SYh/frfq016ptEW8Xn2+kIT
         8ENEXuSnQWba747Z6dJhNoAzV+9CPgXPsqDRfQ4Q2DJUHEYEF5MkUEfnCWTQZK974K9k
         QJHR6358GsyBkqFxVT1q2aN7/WxUNItNDtgld4RXO+Cc+zkg6lFStXKz6tU0qsad1wCt
         fVTg==
X-Gm-Message-State: AOAM530QRtAcle+1qsTKXrdpmj5gvleDVnhjTxalMos4A+6zCbSLXVfG
        eedo0mVkw1t3+pJoYP8j9BNGEQ==
X-Google-Smtp-Source: ABdhPJwojGycUje7NlW8TGiVdxup+AVmyN/RuH9EDoAAE6grjW/n8pvUKxk7ZASjnBeUQ9Lu6ewI0Q==
X-Received: by 2002:a92:4101:: with SMTP id o1mr12217020ila.82.1610733444929;
        Fri, 15 Jan 2021 09:57:24 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i4sm1610172ios.54.2021.01.15.09.57.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jan 2021 09:57:24 -0800 (PST)
Subject: Re: [PATCH -next] usb: usbip: Use DEFINE_SPINLOCK() for spinlock
To:     Zheng Yongjun <zhengyongjun3@huawei.com>,
        valentina.manea.m@gmail.com, shuah@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201223141431.835-1-zhengyongjun3@huawei.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <de699446-4f00-ce6a-4dfb-1f95669325f1@linuxfoundation.org>
Date:   Fri, 15 Jan 2021 10:57:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201223141431.835-1-zhengyongjun3@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/23/20 7:14 AM, Zheng Yongjun wrote:
> spinlock can be initialized automatically with DEFINE_SPINLOCK()
> rather than explicitly calling spin_lock_init().
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>   drivers/usb/usbip/stub_main.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/usbip/stub_main.c b/drivers/usb/usbip/stub_main.c
> index c1c0bbc9f8b1..77a5b3f8736a 100644
> --- a/drivers/usb/usbip/stub_main.c
> +++ b/drivers/usb/usbip/stub_main.c
> @@ -23,7 +23,7 @@ struct kmem_cache *stub_priv_cache;
>    */
>   #define MAX_BUSID 16
>   static struct bus_id_priv busid_table[MAX_BUSID];
> -static spinlock_t busid_table_lock;
> +static DEFINE_SPINLOCK(busid_table_lock);
>   
>   static void init_busid_table(void)
>   {
> @@ -35,8 +35,6 @@ static void init_busid_table(void)
>   	 */
>   	memset(busid_table, 0, sizeof(busid_table));
>   
> -	spin_lock_init(&busid_table_lock);
> -
>   	for (i = 0; i < MAX_BUSID; i++)
>   		spin_lock_init(&busid_table[i].busid_lock);
>   }
> 


Sorry for the delay on this.

Looks good to me.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
