Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00C8B2F6529
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 16:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbhANPud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 10:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727637AbhANPuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 10:50:32 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE1CC061574;
        Thu, 14 Jan 2021 07:49:52 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id v67so8704200lfa.0;
        Thu, 14 Jan 2021 07:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HsYb3ISmwqcZYohpIUCu38MljjWZZ4dkXVTquIJzHZM=;
        b=NIwYlP6CuqvXWqR/JtiP24TUaUTdSrV7XbEJH70mRLVASYG7oo+K3aJLKzV29jd6L2
         Ctn7RmRPom4fJNFQ0IfqSJ3GBOU1FIyA6RC+qDr+DZF75h9L07FUeiphLPn5FCQc7N++
         TFxdmC+d1wJxkFOeJhHGqNc8n7QN1EUlSptf8IyDCOyusf12IIPY3AtZkONN3AjemEpD
         9bylPWnmrrwC5jt779ufPtk3h4169aqlIv41nHRGWWaKdDRWIVHYXCRFs/mmCKf65MdV
         +PrEvItdPSfrDfSIDhQVLj0uya/3kqMPeHvStC94EQHTShsAHFozJKpaSUDhzKcoYgnz
         7o9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HsYb3ISmwqcZYohpIUCu38MljjWZZ4dkXVTquIJzHZM=;
        b=ICPrG68Jtw5ALOBVI3K/zNeLTVHO/GVARcTCbeAiS2cvYW1W8kIn31HLMTgKFeJiSe
         IeJ8KcCr1KIfuHRF/1pIEYFHb1M1jnBfxHv6XK/Q9qJ+mlJ3QKPAFBiKpQBjC0j+DQT9
         DU/eQdnH/fWa7AoLHD2nSujTVUjPZa7/sFDEHCiDkR4ukjvD8I3yvBLLnzFpHKZnPe7V
         gHjljOmF3FBNGXT3d8gl+/3ivg1SFU6EPzDAnd81dc4qwtsdnCJbJhA/elHEFuzLUz3q
         bo1+o3L5aZUOdTSInjcyf143XnZxXx0BBXn7uEC1rNKS5odIheDVUpKANXwnqCbbB714
         9qWw==
X-Gm-Message-State: AOAM531+mhk0LnHERGSKTu1e+Hl4/JjVFwecSbdknE+h/NBpghINcCkM
        y8tIUYYPu1wVqQUWj3LYJ50=
X-Google-Smtp-Source: ABdhPJwo9oVXjah7NnQ1zOABnQ0HZUZbeISWJjKo5Pe+t4Kk82UHcevH1dt0nRpp2K8MjW2ug8BWWw==
X-Received: by 2002:a19:c3cb:: with SMTP id t194mr3348315lff.599.1610639390391;
        Thu, 14 Jan 2021 07:49:50 -0800 (PST)
Received: from [192.168.1.101] ([178.176.75.106])
        by smtp.gmail.com with ESMTPSA id n20sm584377lfh.133.2021.01.14.07.49.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jan 2021 07:49:49 -0800 (PST)
Subject: Re: [PATCH] ata: remove redundant error print in
 rb532_pata_driver_probe
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
To:     menglong8.dong@gmail.com, axboe@kernel.dk
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <dong.menglong@zte.com.cn>
References: <20210112023619.5713-1-dong.menglong@zte.com.cn>
 <33bb1cd2-c202-0fd5-733d-b44e7e8fa92c@gmail.com>
Message-ID: <d9ce7fd8-00fc-c42d-5086-20aa0592213e@gmail.com>
Date:   Thu, 14 Jan 2021 18:49:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <33bb1cd2-c202-0fd5-733d-b44e7e8fa92c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/21 2:15 PM, Sergei Shtylyov wrote:

[...]
>> From: Menglong Dong <dong.menglong@zte.com.cn>
>>
>> Coccinelle reports a redundant error print in rb532_pata_driver_probe.
>> As 'platform_get_irq' already prints the error message, error print
>> here is redundant and can be removed.
>>
>> Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
>> ---
>>  drivers/ata/pata_rb532_cf.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
>> index 479c4b29b856..dcde84f571c4 100644
>> --- a/drivers/ata/pata_rb532_cf.c
>> +++ b/drivers/ata/pata_rb532_cf.c
>> @@ -115,10 +115,8 @@ static int rb532_pata_driver_probe(struct platform_device *pdev)
>>  	}
>>  
>>  	irq = platform_get_irq(pdev, 0);
>> -	if (irq <= 0) {
>> -		dev_err(&pdev->dev, "no IRQ resource found\n");
>> +	if (irq <= 0)
>>  		return -ENOENT;
> 
>    This still beaks the probe deferral. :-(
>    But that's another problem...

   BTW, your patch summary looks quite wrong -- we need the prefix to specify the patch locus,
like this:

pata_rb532_cf: remove redundant error printing in the probe() method

   I.e. "ata: " may even be omitted (your choise though).

> [...]

MBR, Sergei
