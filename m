Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 429982D8F1C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 18:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgLMRbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 12:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbgLMRbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 12:31:03 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180DAC0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 09:30:23 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id r5so14699706eda.12
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 09:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=y65Ed7t5TSbO0dBqe9mOeL9J+97H7TMQaJSm9JkCIJs=;
        b=RPu7bmSu/52FoKsxaI5YuzQuHrHBjTUK80qN0GDg4GBQ2JnWbgb9V8WYAUigZQDflK
         yCzRENY1ZJDhnkyPX4VOiry2J5Vh37d4jrsRLbyK6H89G7aXyP+O0pc+lBNdifsW9Riq
         wgYz6FK4u+KA8Jj560WWOGiJgWXlCct7Mn6jEM4Z4NgjioCCRopsip/hxEXaf/k/hOcr
         ETJNWYW9B1DQxMm0ZWsLzFz22vOXUwR0+8iGGJIWAPZx6//NeeS0iY7ISkGsdEBaU6am
         Mq5QtA3Hi1eO2qolYHTGDXp//G91riKIo/SvWaIaB0rjJEtYZiMhLdYWhJJVr2gxKXj7
         yylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=y65Ed7t5TSbO0dBqe9mOeL9J+97H7TMQaJSm9JkCIJs=;
        b=r+cV5QdznaiRupfuiAaB8+Z9RM3ogwWr/sZ53OxN/SxLRwE8boc8INkzG7lp574O/Y
         evvbEWDVKGYuLF4tkyHd2UjXBEKwOKOg4keJf+KWF1BgwJ6qcm4e2s+81m/7xdChfgtZ
         r23Q0WGzDL0AeE0CJ+JfqXpxZd52JCr8mf3uLhT4c+WXC9Y/Eakc2jffXOe+XWdE/xjD
         S9j/veVD4YinT+ywlOck8DjY4GrhTJNGzrte1kewuj8/Rz7YvDL14C0rAV3sra7TelM/
         S0ZyJlUVRtpw0w1zx2RPYn58jLzLX8Ah+C+vPt1Yx5oT63txd3Ty63cKdWfmfuRmTUMg
         C6gg==
X-Gm-Message-State: AOAM53308PYzVe5dwVMEIawX/+Nev1W6jG8ImEU4iixcwPLUAw3/jSPG
        aymkWuwwi7xU365t/YjXDTM=
X-Google-Smtp-Source: ABdhPJz1aDPRzndWvmQXSSCV7D6tykcRkE56TcQqnCDMOFDdAGECfvBnqxT9g08OYLcFHGQTd4CiSA==
X-Received: by 2002:aa7:db01:: with SMTP id t1mr21329444eds.185.1607880621727;
        Sun, 13 Dec 2020 09:30:21 -0800 (PST)
Received: from [109.186.216.164] (109-186-216-164.bb.netvision.net.il. [109.186.216.164])
        by smtp.gmail.com with ESMTPSA id s26sm12984819edc.33.2020.12.13.09.30.20
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 13 Dec 2020 09:30:21 -0800 (PST)
Message-ID: <5FD64F9A.3040807@gmail.com>
Date:   Sun, 13 Dec 2020 19:30:02 +0200
From:   Eli Billauer <eli.billauer@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     gregkh@linuxfoundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: xillybus: Add driver for XillyUSB (Xillybus variant
 for USB)
References: <20201213170503.59017-1-eli.billauer@gmail.com> <c661c10e-fa21-d3e5-9d94-6f8f2d89f1d0@infradead.org>
In-Reply-To: <c661c10e-fa21-d3e5-9d94-6f8f2d89f1d0@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Randy,

The new driver doesn't depend on XILLYBUS, so the patch puts it 
correctly outside the "if XILLYBUS" clause. It indeed looks like a 
mistake, but it isn't. :)

Thanks for paying attention to this.

Regards,
     Eli

On 13/12/20 19:22, Randy Dunlap wrote:
> On 12/13/20 9:05 AM, eli.billauer@gmail.com wrote:
>    
>> diff --git a/drivers/char/xillybus/Kconfig b/drivers/char/xillybus/Kconfig
>> index 130dbdce858f..18fa99ec1029 100644
>> --- a/drivers/char/xillybus/Kconfig
>> +++ b/drivers/char/xillybus/Kconfig
>> @@ -32,3 +32,14 @@ config XILLYBUS_OF
>>   	  system, say M.
>>
>>   endif # if XILLYBUS
>> +
>>      
> Hi Eli,
>
> You don't want this new part inside the "if XILLYBUS" block above?
> IOW, XILLYUSB does not need XILLYBUS?
>
>    
>> +config XILLYUSB
>> +	tristate "XillyUSB: Xillybus generic FPGA interface for USB"
>> +	depends on USB
>> +	select CRC32
>> +	help
>> +	  XillyUSB is the Xillybus variant which uses USB for communicating
>> +	  with the FPGA.
>> +
>> +	  Set to M if you want Xillybus to use USB for communicating with
>> +	  the FPGA.
>>      
> thanks.
>    

