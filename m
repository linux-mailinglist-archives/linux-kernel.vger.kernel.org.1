Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD0A1E34EA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 03:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgE0BqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 21:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgE0BqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 21:46:06 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6108C061A0F;
        Tue, 26 May 2020 18:46:05 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id j21so10951263pgb.7;
        Tue, 26 May 2020 18:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MZLcc6FvvOdkLrr65+pE0QxY7X3K3DlXgtasljPdFOE=;
        b=gi8OFKEzmSJgoc4o6BpqkFTS/o613tcMjZEAEXaPfsJkFpBgLiOmr0VLpKr0QQwZOT
         IqRtDOJVwuJxMs19qf/cnyVDk8q1UM3QeCsWS/sJ9E4dP4kPRuAvlwjO8qMA9RFdqOC4
         f+VAiyf6l66e2+jlVzziC52F4Bc/wVHYgt/CRiysTHp7DzZPI9xnr5zspTXQ6UVxv7oc
         JOxkvW3MOicGqomUH3NMGNwq1vXYhsQneEwZ+rV1MegHR+do8vS68zad+8h6V02/v5Qz
         SZuBrYldQ/1S8FvbeCbp3deGsuuKYGvW1eDXmZZj2R8Pr5eXnkMI5dka1eFG2l2inGbm
         rJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=MZLcc6FvvOdkLrr65+pE0QxY7X3K3DlXgtasljPdFOE=;
        b=dOLBd4PFxvVuGQ5S9UXfMfQz9/CTynZjVhdXH7JeTUcUCj4ufNewJ2ZfQzEODfeVid
         hkGq4enCZ+a+jpMUz8Yjmw6XPmaqELqaTdRTjwgMI4t01tPDez6Yj/LCEhxkAT6fb19j
         FS5Bu9TRU5D7WAAy2AsNAS0VIt6k7j5l3fXL3fHpbnaOkZ4vv0ihOA8g0SboWW6hSC0Z
         4Adv03/G1RnjBC+fRvp6qthuyR7cZB726LelaGiLgYkdAV9aL5Yw3pfhPifdznUoo2UH
         ODyYpRFTLmlt8E2BPfZ0pjEGUUmD6dWxfk5A+AJp9r7EAvovE5RnziMyVk7MXwinxfBK
         GKqw==
X-Gm-Message-State: AOAM533EaR44O2T/m0NvV/C40XE0rDCfaY0Zgyi2q94zjC8MTo2K4D+4
        S2FNoEyuFRpLsoU1atDqmrrVT9YX
X-Google-Smtp-Source: ABdhPJxDxYp82tCTqbaj9xZV2lik9aWSCUbDGxUgn3OaYoxe5lPASUOvo32ty/T86ev5s2Kt8CzvHg==
X-Received: by 2002:a63:9304:: with SMTP id b4mr1585553pge.229.1590543965219;
        Tue, 26 May 2020 18:46:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k4sm689386pgg.88.2020.05.26.18.46.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 18:46:04 -0700 (PDT)
Subject: Re: [v1,1/1 2/2] Set the default timeout
To:     yuechao.zhao@advantech.com.cn, 345351830@qq.com
Cc:     amy.shih@advantech.com.tw, oakley.ding@advantech.com.tw,
        jia.sui@advantech.com.cn, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1590542319-35736-1-git-send-email-yuechao.zhao@advantech.com.cn>
 <1590542319-35736-2-git-send-email-yuechao.zhao@advantech.com.cn>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <80af4393-f7d9-6815-f156-44b0ba2c4c27@roeck-us.net>
Date:   Tue, 26 May 2020 18:46:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1590542319-35736-2-git-send-email-yuechao.zhao@advantech.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/20 6:18 PM, yuechao.zhao@advantech.com.cn wrote:
> From: Yuechao Zhao <yuechao.zhao@advantech.com.cn>
> 
> The timeout module parameter should not be used for setting the default
> timeout. Because, if you set the timeout = 0, the default timeout will
> be meaningless. And the wahtchdog_init_timeout() can not detect this
> error because the timeout module parameter of 0 means "no timeout
> module paraameter specified".
> 
> Signed-off-by: Yuechao Zhao <yuechao.zhao@advantech.com.cn>

Please fix the subject to something like "hmwmon: (nct7904) Set default timeout".

Also, the change only makes sense if you also change "static int timeout"
to default to 0. Then you can just drop patch 1/2.

Guenter

> ---
>  drivers/hwmon/nct7904.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
> index d069d59..ddbe47e 100644
> --- a/drivers/hwmon/nct7904.c
> +++ b/drivers/hwmon/nct7904.c
> @@ -1147,7 +1147,7 @@ static int nct7904_probe(struct i2c_client *client,
>  	data->wdt.ops = &nct7904_wdt_ops;
>  	data->wdt.info = &nct7904_wdt_info;
>  
> -	data->wdt.timeout = timeout * 60; /* in seconds */
> +	data->wdt.timeout = WATCHDOG_TIMEOUT * 60; /* Set default timeout */
>  	data->wdt.min_timeout = MIN_TIMEOUT;
>  	data->wdt.max_timeout = MAX_TIMEOUT;
>  	data->wdt.parent = &client->dev;
> 

