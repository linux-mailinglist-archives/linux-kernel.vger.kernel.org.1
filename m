Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFB272D63A4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 18:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390049AbgLJRef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 12:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392735AbgLJReO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 12:34:14 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B809C0613D6;
        Thu, 10 Dec 2020 09:33:33 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id y19so9354420lfa.13;
        Thu, 10 Dec 2020 09:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tv47+Gn9kE/EuHtBfv1iSClR82qDNTS3+tgrsyQwWZI=;
        b=qeHHxg2I3V3mzqIR8CHFHAnKgte4wW0I/vBa1eU3K/yYv8NzcWkYKZL3QTnyoM785c
         pvqVLBr4jsdWzAK6vxa1gcnv46LDBbmgbyHE1J8qGuba1otBI84SM50fLdasWbifIN7p
         zld331qUX+H+7WtvVCPks1j9TH60xfERq1HWBiTgndHWGKtgJrZkMkNHb5Iy7dRUL1o9
         nqx068ePhrhfHk1SzkgrHZuWWWSi/lsAqj2k91Y+iShCUDjg0BIl+E94iovRpi5Ili9L
         K/o6TR4OHdjy46qQGyaCgUEP3rsxCl4foYMvT5g18DGS3f+UbQkQcKlaGW0ydrztB9rz
         WUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tv47+Gn9kE/EuHtBfv1iSClR82qDNTS3+tgrsyQwWZI=;
        b=bTXQ13VEIfZPRcB1Y/BDXWoRXbO6RaHd2BFzePfVkyFrGWVw3zKLnJr2zawUa/xh/6
         WK3vTq/Py/iaPf8hqNMTjVdYN7FyHQmnaBdP+UBISB7rUuRet+P8GuPStiCoaVQSE4v1
         d1HlpYEi+5nTAjEx5HjKxYx+sZ/uod5sj6FNnadnJWBODZDNkuei/QReuBNt5pX1DG93
         rMb4SH2GRBC4JL9tSY0qDwgZFj6FVvLJAb24BT6MZMMqrCwPXYpSnuErA9OaCO424O6B
         481kwk3DIJ5YXM/In9k4YbLRjGl1D8KDCdEE85qO9kG3idrp7DhNCiN+j1S7Dg1TogeK
         zcVA==
X-Gm-Message-State: AOAM532Obx/8Qo1/FGklxXOfvOORF+rUNp5XKhQNhzw5WHkmboq1YELi
        zPUk5A52768uuCXrqYpHK2A=
X-Google-Smtp-Source: ABdhPJzNKitFcR5xT9xBqWL+MiU/hMZbvU6keJXgcuRfRiEzojskCgnKER7r+yHYf/GlfmuUNKvrGg==
X-Received: by 2002:a19:c5:: with SMTP id 188mr3157333lfa.511.1607621612151;
        Thu, 10 Dec 2020 09:33:32 -0800 (PST)
Received: from [192.168.1.101] ([178.176.78.63])
        by smtp.gmail.com with ESMTPSA id z17sm588552lfg.275.2020.12.10.09.33.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 09:33:31 -0800 (PST)
Subject: Re: [PATCH v3] usb: musb: remove unused variable 'devctl'
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     min.guo@mediatek.com, Bin Liu <b-liu@ti.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        chunfeng.yun@mediatek.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20201124084955.30270-1-min.guo@mediatek.com>
 <c2f3f643-8514-5c4a-dd52-7abc8a6dc501@gmail.com> <X9I4L3E9EJlcPMEu@kroah.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <e59a754b-ad3e-2f8f-417a-96ddfcd3cbd3@gmail.com>
Date:   Thu, 10 Dec 2020 20:33:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <X9I4L3E9EJlcPMEu@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/20 6:01 PM, Greg Kroah-Hartman wrote:

[...]
>>> From: Min Guo <min.guo@mediatek.com>
>>>
>>> Remove unused 'devctl' variable to fix compile warnings:
>>>
>>>      drivers/usb/musb/musbhsdma.c: In function 'dma_controller_irq':
>>>      drivers/usb/musb/musbhsdma.c:324:8: warning: variable 'devctl' set
>>>      but not used [-Wunused-but-set-variable]
>>>
>>> Signed-off-by: Min Guo <min.guo@mediatek.com>
>>> ---
>>> changes in v3
>>> suggested by Greg Kroah-Hartman:
>>> Add a comment.
>>>
>>> changes in v2
>>> suggested by Alan Stern:
>>> Add void before musb_read to indicate that the register MUSB_DEVCTL
>>> was intended to be read and discarded.
>>> ---
>>>   drivers/usb/musb/musbhsdma.c | 8 +++++---
>>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
>>> index 0aacfc8be5a1..2a345b4ad015 100644
>>> --- a/drivers/usb/musb/musbhsdma.c
>>> +++ b/drivers/usb/musb/musbhsdma.c
>> [...]
>>> @@ -336,7 +334,11 @@ irqreturn_t dma_controller_irq(int irq, void *private_data)
>>>   						< musb_channel->len) ?
>>>   					"=> reconfig 0" : "=> complete");
>>> -				devctl = musb_readb(mbase, MUSB_DEVCTL);
>>> +				/*
>>> +				 * Some hardware may need to read the
>>> +				 * MUSB_DEVCTL register once to take effect.
>>> +				 */
>>> +				(void)musb_readb(mbase, MUSB_DEVCTL);
>>
>>    Hm, forcibly reading DevCtl in the DMA driver... sounds quite
>> nonsensically. Lemme take a look...
> 
> What happened to your look?

   I thought I posted it the same day... Indeed, here it is, archived:

https://marc.info/?l=linux-usb&m=160621841910477

> thanks,
> 
> greg k-h

MBR, Sergei
