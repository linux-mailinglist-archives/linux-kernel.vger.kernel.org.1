Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4447A2ED168
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 15:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbhAGOG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 09:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728519AbhAGOG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 09:06:56 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4AAC0612F4;
        Thu,  7 Jan 2021 06:06:16 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id u4so2099682pjn.4;
        Thu, 07 Jan 2021 06:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=o+UyASBdKjlwmry0POVJ2KZ2OqhSGLuefGxoigUsixA=;
        b=LPfFcI5Ru7M7DFFw38G/2AYoGtXDNlRPEWj8FRcJ+UlK1zNH1VjXeAfzL93AY1bDgv
         48kh6QI8/+4MVFVe8c6LG8hYopwDcoAhQXeRSa5bLWZbinQgUjwRdcDUoV7z5XZ7liBl
         xJMmnDgd8I+i9KE1asgFOmNb47EBu7h/l9YbseYqM8gA7XEW3HQXTcTPbvtN0IoHeGsR
         GtBwUOM7/QHzW78jTdaHEzSrglwYcLnH8MCk0fIDWW+UrePsXD86Yact4Fcz2d9/ZJnL
         Y8OAMAZR7mnbvcIcXpSS1tN6Idhf6YBWJk08VkMjsy2IjRETgQ0CsgOq+X6PEOL9q+fa
         YelQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=o+UyASBdKjlwmry0POVJ2KZ2OqhSGLuefGxoigUsixA=;
        b=j4gQvwzIXWwiQCbhbIZrU0CxeEiWNRcNiE7Vp6fKy6+aksHvUwZIn16qN1khl9Uiap
         gE8MZ2KgtkiJ97ppufppRj563+ky3FkoX+mMEe5Dlrp6x8fS7sXViO2O47XKxpdxM3FX
         GgJnz0zqZredEcV186Z1PWfDzlkWi66t3Fbwm+aw6pk908IN1qYhA3/+vECjTEuenFLY
         64fIeqqDvl2SUB2OUMuSlYB8T4wZyUuF0xyjKGmFwOLAiEgoPdsBT1gW2tFF5Yvje1ve
         GF82R08dP7SWP093Vc1W2kotz6xTldgn0zQORjReXTEEZpvUCuTne9hVIS8ijf1/LSJ7
         AwKA==
X-Gm-Message-State: AOAM533XIF0LT0hZ8lYP1asrs6m5WFz7J4NbebvZaL6ugD0XIPH6cvyF
        NONQiRIb1xRiNHqu8gJhYmBZkPXHDRcNlV2a
X-Google-Smtp-Source: ABdhPJxD/PX517nLX/q1hyo8Yf+YFXLvFcnWgHRj3RvQB28mHCDoRktmKkeOlgkUNtn8HFEnYHEIeg==
X-Received: by 2002:a17:902:6b89:b029:da:fc41:baec with SMTP id p9-20020a1709026b89b02900dafc41baecmr9327841plk.39.1610028375208;
        Thu, 07 Jan 2021 06:06:15 -0800 (PST)
Received: from [192.168.0.104] ([49.207.197.164])
        by smtp.gmail.com with ESMTPSA id z16sm6746840pgj.51.2021.01.07.06.06.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 06:06:14 -0800 (PST)
Subject: Re: [PATCH v2 08/15] usb: misc: idmouse: update to use
 usb_control_msg_send()
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201130011819.2576481-1-anant.thazhemadam@gmail.com>
 <20201130013031.2580265-1-anant.thazhemadam@gmail.com>
 <X8pL1bRUTyq2re7Z@localhost>
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
Message-ID: <1dd2bfc0-5190-1841-e04b-4a864dfd0be4@gmail.com>
Date:   Thu, 7 Jan 2021 19:36:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <X8pL1bRUTyq2re7Z@localhost>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/12/20 8:16 pm, Johan Hovold wrote:
> On Mon, Nov 30, 2020 at 07:00:31AM +0530, Anant Thazhemadam wrote:
>> The newer usb_control_msg_{send|recv}() API are an improvement on the
>> existing usb_control_msg() as it ensures that a short read/write is treated
>> as an error, data can be used off the stack, and raw usb pipes need not be
>> created in the calling functions.
>> For this reason, the instance of usb_control_msg() has been replaced with
>> usb_control_msg_send() appropriately.
>>
>> Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
>> ---
>>  drivers/usb/misc/idmouse.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
> Especially for control transfers without a data stage there isn't
> really any benefit of the new helper.
>
> I'd just leave this one unchanged.
>
>> diff --git a/drivers/usb/misc/idmouse.c b/drivers/usb/misc/idmouse.c
>> index e9437a176518..52126441a633 100644
>> --- a/drivers/usb/misc/idmouse.c
>> +++ b/drivers/usb/misc/idmouse.c
>> @@ -56,8 +56,9 @@ static const struct usb_device_id idmouse_table[] = {
>>  #define FTIP_SCROLL  0x24
>>  
>>  #define ftip_command(dev, command, value, index) \
>> -	usb_control_msg(dev->udev, usb_sndctrlpipe(dev->udev, 0), command, \
>> -	USB_TYPE_VENDOR | USB_RECIP_ENDPOINT | USB_DIR_OUT, value, index, NULL, 0, 1000)
>> +	usb_control_msg_send(dev->udev, 0, command, \
>> +	USB_TYPE_VENDOR | USB_RECIP_ENDPOINT | USB_DIR_OUT, \
>> +	value, index, NULL, 0, 1000, GFP_KERNEL)
>>  
>>  MODULE_DEVICE_TABLE(usb, idmouse_table);
> Johan

Understood. I'll make sure this is left out in the v3.

Thanks,
Anant

