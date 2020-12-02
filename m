Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37FE72CB332
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 04:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgLBDRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 22:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbgLBDRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 22:17:22 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6085C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 19:16:41 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id v21so311844plo.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 19:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=L7J2NgMNe6vrjfVIcXeYGceG0os8a/Wa3uB7OAYYPXo=;
        b=ZBH8V2Tfb0rQPTzaFpk+XstSOQb0gWNNqaqwcl41m0jduT8NNgTEtdddDBgtyQfOS2
         Vd1oqZk89ucn7RI86kPYZwSAgZ89JB7PsVRIPvekh57sF2xsm08befT7pi/it/ZWiukV
         2Vv0MrApqoTcuOmUtN/p6R9NuOz3O3HUWeUCQA2DSKDux+5epHxtE5VxbF3E/BmliSMr
         LxnYNBdL5F4OU83kfQXYnsaYJm5b+C94beAK/ebv6wWQivdg3ikh+PWyb5EkBYjz2v/1
         m1M9ElfFE7ZS6f9MXyGq/bzizGktOB0bGEmS2KorCTUw8TQps7ITahpJa+5+QXjV5pUG
         sKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=L7J2NgMNe6vrjfVIcXeYGceG0os8a/Wa3uB7OAYYPXo=;
        b=iVM2LX58202VP7OLzxBrZAW0EFTK7nZB8zhl8UnBL9CWFsf5StCjOD8A46T0a+yNhU
         qFK5M3pzWF8+PDdXGFi46WysdoKb4Lhz1/I2p5ghjYrCD/FpageRfuscIk86Hi+6A4/z
         dPTldnFl8H9bOoCw74gRB516WCQa8Ai7Y2L1ci0KTdJHt5RoG//cBzrXGEaltOJcydkE
         hDk9y67XR+7x/slFBfxtOF4L/T2C4+YFOC8tqWOGTLJlGjpYqrKM47t6c8rKXzu1Bgz5
         vZ63U7oN6A7fX1hgQrFXcgu+f3uASrgjonDwXGXaW2crECuB0Pp1LXX8n9eOJnNbg06R
         DXrQ==
X-Gm-Message-State: AOAM532sKw1N2hD1VQTsjRFZMHJlRZc+AhI7t9obzaEG955H87rPnot6
        2+nc4coVsgFo5YmVmse7wek=
X-Google-Smtp-Source: ABdhPJzZ0IA2/z/ic0/ZLe4bZ2VD8r5NVlJwdlmcyAYi1G6Uaz537unEZSS3o2wmrGXyGGND+6qIQg==
X-Received: by 2002:a17:90a:fe8:: with SMTP id 95mr360581pjz.114.1606879001498;
        Tue, 01 Dec 2020 19:16:41 -0800 (PST)
Received: from [0.0.0.0] ([103.149.248.59])
        by smtp.gmail.com with ESMTPSA id 85sm305530pfv.197.2020.12.01.19.16.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Dec 2020 19:16:41 -0800 (PST)
Subject: Re: [PATCH RESEND] tty/serial/imx: Enable TXEN bit in
 imx_poll_init().
To:     Greg KH <gregkh@linuxfoundation.org>
References: <20201201230307.5738-1-972931182@qq.com>
 <X8Zznz7950E8R+Ol@kroah.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, 972931182@qq.com
From:   jiladahe1997 <jiladahe1997@gmail.com>
Message-ID: <f8125a4f-5293-79f5-9dcb-62ebc5843f83@gmail.com>
Date:   Wed, 2 Dec 2020 11:16:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <X8Zznz7950E8R+Ol@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/2 0:47, Greg KH wrote:
> On Wed, Dec 02, 2020 at 07:03:08AM +0800, jiladahe1997 wrote:
>> From: Mingrui Ren <jiladahe1997@gmail.com>
>>
>> As described in Documentation, poll_init() is called by kgdb to initialize
>> hardware which supports both poll_put_char() and poll_get_char().
>>
>> It's necessary to enable TXEN bit, otherwise, it will cause hardware fault
>> and kernel panic when calling imx_poll_put_char().
>>
>> Generally, if use /dev/ttymxc0 as kgdb console as well as system
>> console, ttymxc0 is initialized early by system console which does enable
>> TXEN bit.But when use /dev/ttymxc1 as kgbd console, ttymxc1 is only
>> initialized by imx_poll_init() cannot enable the TXEN bit, which will
>> cause kernel panic.
>>
>> Signed-off-by: Mingrui Ren <jiladahe1997@gmail.com>
>> ---
>> Hi, thanks for your reply, and sorry for sending two identical emails.
>> The email service I used before seems to have some problems,
>> so I switched to gmail.This is the "correct" version, please check.
>>
>>   drivers/tty/serial/imx.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> index 43c6d7142fdd..7c665db3d897 100644
>> --- a/drivers/tty/serial/imx.c
>> +++ b/drivers/tty/serial/imx.c
>> @@ -1829,7 +1829,7 @@ static int imx_uart_poll_init(struct uart_port *port)
>>   	ucr1 |= UCR1_UARTEN;
>>   	ucr1 &= ~(UCR1_TRDYEN | UCR1_RTSDEN | UCR1_RRDYEN);
>>   
>> -	ucr2 |= UCR2_RXEN;
>> +	ucr2 |= UCR2_RXEN|UCR2_TXEN;
> Didn't checkpatch complain about this?  Please use ' ' characters around
> the '|' character.
>
> thanks,
>
> greg k-h
Yeah, checkpatch didn't complain:


root@iZ2zefbvkcoj7o7ledf4oqZ:~/workspace/linux-imx$
./scripts/checkpatch.pl 
0001-tty-serial-imx-Enable-TXEN-bit-in-imx_poll_init.patch
total: 0 errors, 0 warnings, 8 lines checked

0001-tty-serial-imx-Enable-TXEN-bit-in-imx_poll_init.patch has no
obvious style problems and is ready for submission.


Maybe some patches should be submitted to checkpatch.pl :).

Anyway, I will add  ' '  characters and send PATCH V2.


Thanks,

Mingrui Ren



