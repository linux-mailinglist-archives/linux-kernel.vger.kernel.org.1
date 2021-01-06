Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2F12EBF45
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 15:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbhAFOEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 09:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbhAFOEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 09:04:08 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1CCC06134C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 06:03:28 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id q22so5226527eja.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 06:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=+MBeK2vbWl6+ApJYvm4Zrpw/dzVSaM96ShLNrUOtiMc=;
        b=kkVUKK9XuCeybYnkNeAHjt1tBBNq/CSjwcUqlwJSKz6mYfFp9fTh0W/B6h4DKXFQxt
         Qo3u9zlERYQMOOQs40Ur9qukq9zmPtv6JsOMIE9iSaOLp2I3jXPHVrMhwQ+QNlBcMRHU
         eU+z1Nk/Z71T9VABxsNwHlBIsR/UXpndHiOR2HqqwDyJhLiv6FoHJB0wQU5HxLraGZXd
         x1z8tFiUbymYc3C89wsr3iqheyqYdubGrG1/VCYhqI1X2Ovwd2FXLmFOsbBelouaoJbQ
         6w8BzDA0auD+jx5w9dTTX1o3eQmbty/Yu4mC0os9GFn7ZsOm2iGrmEOnDUXK116PJk0W
         yzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=+MBeK2vbWl6+ApJYvm4Zrpw/dzVSaM96ShLNrUOtiMc=;
        b=PxAFxEwRRcHIlIkTNZgv5L/H1TCxGXpkKQg7Lw5BeudTaiFO+VwjDUWuldpt+L6clI
         rBJ4m/dxh60jR0P0eDoX0Ndgj7xu4INiAAcN0hAWkZCeCpV+P75CeLcoxFrR0IAg1Eir
         mT4PbH2d79vOBxj0yGgh31NtD7nwINeoo2f63PCT+2h1R+Bl0T4aDqbz84n95h5lPAz7
         Gf89lmtmNR0RNXs63//r2wwopvJuAIN8FCjMgvhakk+hKrCmnHBfXjMWTh1lSWYOvtoS
         TfLUq5MBqzGnVtlcyTGdAFzKzRSswIyuQvjXzW/hbvm3zwcXsT2zGNtHj6E23eDZXh3U
         49oQ==
X-Gm-Message-State: AOAM531O73R8RF10NuJKxapaD36k1MYZQGO+NRuR3LLhPkzKHWEMLylF
        ps6owKD8QAChTy7YbScwnwA=
X-Google-Smtp-Source: ABdhPJwqpu73kbRuaNAZaT36/LV9QgPsYcweYlUUqefjm8FjkJWJkUt5HEMpap/Beia6gsYTvt+4/g==
X-Received: by 2002:a17:907:6e6:: with SMTP id yh6mr3021608ejb.512.1609941806726;
        Wed, 06 Jan 2021 06:03:26 -0800 (PST)
Received: from [89.138.250.57] (89-138-250-57.bb.netvision.net.il. [89.138.250.57])
        by smtp.gmail.com with ESMTPSA id x20sm1292808ejv.66.2021.01.06.06.03.24
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 06 Jan 2021 06:03:25 -0800 (PST)
Message-ID: <5FF5C31C.6050804@gmail.com>
Date:   Wed, 06 Jan 2021 16:03:08 +0200
From:   Eli Billauer <eli.billauer@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: xillybus: Add driver for XillyUSB (Xillybus variant
 for USB)
References: <20201213170503.59017-1-eli.billauer@gmail.com> <X/Rt+bUJ9Hs2F8nF@kroah.com>
In-Reply-To: <X/Rt+bUJ9Hs2F8nF@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

Merging XillyUSB's driver into xillybus_core.c was of course the initial 
idea. Practically, it turned out that this doesn't reduce the number of 
code lines nor makes the code easier to understand: The XillyUSB driver 
is a completely different deal internally, in almost every aspect of it.

Indeed, the two drivers do basically the same thing: They create a 
pipe-like API using a hardware interface that is based upon buffers. 
This is what most of the code in both drivers is about. As this 
underlying hardware interface is so fundamentally different, there is 
little in common between the drivers.

The existing xillybus_core.c driver is based upon direct memory register 
+ DMA interaction with the hardware. XillyUSB relies on the USB 
framework for all communication. I'll try to demonstrate the practical 
differences with two examples.

(1) Sending commands to the hardware: The existing Xillybus driver just 
writes to registers in memory space. Its XillyUSB counterpart calls 
xillyusb_send_opcode() to prepare a little packet for transmission over 
USB, and may possibly sleep if there's a (temporary) lack of resources 
to complete that task.

(2) Data handling: The existing Xillybus driver just copies user data to 
and from DMA buffers. Its main business is to maintain and juggle these 
buffers with the hardware. The XillyUSB driver, on the other hand, 
manages a pool of URBs to efficiently shuffle the data to and from the 
hardware. The main challenge is to keep the data flowing at 400 MB/s.

This goes on for every single aspect of the two drivers: They do the 
same things essentially, but the actual actions are completely 
different, as they have different means to do get the job done. And 
completely different challenges.

The only sensible code reuse I can see, is to merge the new "xillyusb" 
device class into the existing "xillybus" class in a new common module 
file, say xillybus_class.c. Maybe also move the code snippets in the 
open() methods which look for a major/minor match to that new file. I 
don't expect that to reduce the total amount of code lines, nor make it 
friendlier to read. But this will reuse the existing device class name 
instead of creating a new one. Does this sound like a good idea?

Thanks and regards,
    Eli

On 05/01/21 15:47, Greg KH wrote:
> On Sun, Dec 13, 2020 at 07:05:03PM +0200,eli.billauer@gmail.com  wrote:
>    
>> From: Eli Billauer<eli.billauer@gmail.com>
>>
>> The XillyUSB driver is the USB variant for the Xillybus FPGA IP core.
>> Even though it presents a nearly identical API on the FPGA and host,
>> it's almost a complete rewrite of the driver: The framework for exchanging
>> data on a USB bus is fundamentally different from doing the same with a
>> PCIe interface, which leaves very little in common between the existing
>> driver and the new one for XillyUSB.
>>      
> But in this one you are talking to userspace directly through a char
> node, why not use the same interface that the xillybus_core.c code uses?
> Creating yet-another-class-device feels odd when you already have one
> that is in use.
>
> Try to merge them together to use the same framework, or document the
> heck out of why this is somehow different, yet looks the same...
>
> thanks,
>
> greg k-h
>
>    

