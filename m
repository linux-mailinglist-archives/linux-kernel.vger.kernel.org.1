Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBC5282B48
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 16:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgJDOcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 10:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgJDOcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 10:32:21 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5409C0613CE;
        Sun,  4 Oct 2020 07:32:21 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o25so4071753pgm.0;
        Sun, 04 Oct 2020 07:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l4l4BMbBfwlgcXtffhl1zomi5ytcpiDRWVr7K7NRh9w=;
        b=uuY92RYfjUtsh8Rjq75jZiFaTMLX68W8jDOh/Ce0/277DoxvAtphNtARmObLaIyxR9
         L8KFx0sYATNiBxGnKZX+JPPyET9sI4zjHQm4FggsZ3PdSPidth95e/UQSl1LwCS65btT
         gVyqS7EU2bMbwaWkygKlfiMAHzw7y1cODP6diUMGSGNNMa9e3CQ7eg7ymHNM/6MKxrhM
         j2MU+wbSBtLvXI1TTWICZU9SbNoc0WnSxX4+3iTlalYeQUCnNYTyF2dxyNKeOo/90T4I
         lWCizTeBHPcOnf8NXw1FGcAWw5buyLQzy53768HRxD2UMCMr11A5lMNlHH76/P70uKFr
         KVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l4l4BMbBfwlgcXtffhl1zomi5ytcpiDRWVr7K7NRh9w=;
        b=LHPDl7upqN2HiPvzsG+8M/KgMbCjtGd02QyIX7ONPhT++5ShdU5UYgG0BUSE+jyDKV
         45u3JWChMISJQoAjiMVhUyuRzupERPYAPZS7tE9JpwTMbLkOO/9oSzfjEUyFEqX0358F
         w5AVGNjqd7JhOvr74Xv9ZirMuYF4jRAvOB04GaNQyZCigA+LG+lMPmivSlJ8V9yXwuxX
         dy8kQv/vCgSLm6p3iFOaEnF6lsEsVmvBj4C1CDRt9OeX4ychJ7Aau/J65zl5Hx3bvvax
         EW1sbvLhoaHghicQQMnhJmn/aSu4MZQ003DUeNw7HZVqR/j1GKpmhL3v/gMY3Os+LlEN
         2RDw==
X-Gm-Message-State: AOAM530pTlOFEENFs4xhoglCjmM7LFDN4FoHgz0ok5GdySDkfHncIvZA
        2y+K09nKOykG+fSFtsSABP0=
X-Google-Smtp-Source: ABdhPJweggjHR5yPF05JM4Xb60MCqk0KqkNcbvK7Yct6J8vJS00S8uEUSioM2smVuDvZqayZaCgacQ==
X-Received: by 2002:a63:8f18:: with SMTP id n24mr10084595pgd.209.1601821941194;
        Sun, 04 Oct 2020 07:32:21 -0700 (PDT)
Received: from [192.168.1.5] ([110.77.216.3])
        by smtp.googlemail.com with ESMTPSA id c127sm8918582pfa.165.2020.10.04.07.32.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2020 07:32:20 -0700 (PDT)
Subject: Re: [PATCH] USB: serial: option: Add Telit FT980-KS composition
From:   Lars Melin <larsm17@gmail.com>
To:     Leonid Bloch <leonidb@asocscloud.com>,
        Leonid Bloch <lb.workbox@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>
References: <20201004095703.2633-1-lb.workbox@gmail.com>
 <886eb499-4db4-1d61-2e67-0335423bf077@gmail.com>
 <ce86bc05-f4e2-b199-0cdc-792715e3f275@asocscloud.com>
 <bf28e522-be94-a6f7-ea44-9c954849fca6@gmail.com>
Message-ID: <ab8c7550-19b9-f8a9-febb-9d2d558978e7@gmail.com>
Date:   Sun, 4 Oct 2020 21:32:17 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <bf28e522-be94-a6f7-ea44-9c954849fca6@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/2020 21:16, Lars Melin wrote:
> On 10/4/2020 20:29, Leonid Bloch wrote:
>> On 10/4/20 1:58 PM, Lars Melin wrote:
>>> On 10/4/2020 16:57, Leonid Bloch wrote:
>>>> This commit adds the following Telit FT980-KS composition:
>>>>
>>>> 0x1054: rndis, diag, adb, nmea, modem, modem, aux
>>>>
>>>> AT commands can be sent to /dev/ttyUSB5.
>>>>
>>>
>>> Please submit a verbose lsusb listing for the device, I can't imagine
>>> that the adb interface should be handled by the option serial driver so
>>> there will never be a ttyUSB5.
>>
>> Please see below.
>>
>> Thanks,
>> Leonid.
>>
>> ```
>> Bus 001 Device 005: ID 1bc7:1054 Telit Wireless Solutions
>> Device Descriptor:
>>    bLength                18
>>    bDescriptorType         1
>>    bcdUSB               2.10
>>    bDeviceClass            0
>>    bDeviceSubClass         0
>>    bDeviceProtocol         0
>>    bMaxPacketSize0        64
>>    idVendor           0x1bc7 Telit Wireless Solutions
>>    idProduct          0x1054
>>    bcdDevice            4.14
>>    iManufacturer           1 Telit Wireless Solutions
>>    iProduct                2 FT980-KS
>>    iSerial                 3 cb42f61
>>    bNumConfigurations      1
>>    Configuration Descriptor:
>>      bLength                 9
>>      bDescriptorType         2
>>      wTotalLength       0x013d
>>      bNumInterfaces          8
>>      bConfigurationValue     1
>>      iConfiguration          4 RNDIS_DIAG_ADB_NMEA_DUN_DUN_SER
>>      bmAttributes         0xa0
>>        (Bus Powered)
>>        Remote Wakeup
>>      MaxPower              500mA
>>      Interface Association:
>>        bLength                 8
>>        bDescriptorType        11
>>        bFirstInterface         0
>>        bInterfaceCount         2
>>        bFunctionClass        239 Miscellaneous Device
>>        bFunctionSubClass       4
>>        bFunctionProtocol       1
>>        iFunction               7 RNDIS
>>      Interface Descriptor:
>>        bLength                 9
>>        bDescriptorType         4
>>        bInterfaceNumber        0
>>        bAlternateSetting       0
>>        bNumEndpoints           1
>>        bInterfaceClass       239 Miscellaneous Device
>>        bInterfaceSubClass      4
>>        bInterfaceProtocol      1
>>        iInterface              5 RNDIS Communications Control
>>        ** UNRECOGNIZED:  05 24 00 10 01
>>        ** UNRECOGNIZED:  05 24 01 00 01
>>        ** UNRECOGNIZED:  04 24 02 00
>>        ** UNRECOGNIZED:  05 24 06 00 01
>>        Endpoint Descriptor:
>>          bLength                 7
>>          bDescriptorType         5
>>          bEndpointAddress     0x81  EP 1 IN
>>          bmAttributes            3
>>            Transfer Type            Interrupt
>>            Synch Type               None
>>            Usage Type               Data
>>          wMaxPacketSize     0x0008  1x 8 bytes
>>          bInterval               9
>>      Interface Descriptor:
>>        bLength                 9
>>        bDescriptorType         4
>>        bInterfaceNumber        1
>>        bAlternateSetting       0
>>        bNumEndpoints           2
>>        bInterfaceClass        10 CDC Data
>>        bInterfaceSubClass      0
>>        bInterfaceProtocol      0
>>        iInterface              6 RNDIS Ethernet Data
>>        Endpoint Descriptor:
>>          bLength                 7
>>          bDescriptorType         5
>>          bEndpointAddress     0x8e  EP 14 IN
>>          bmAttributes            2
>>            Transfer Type            Bulk
>>            Synch Type               None
>>            Usage Type               Data
>>          wMaxPacketSize     0x0200  1x 512 bytes
>>          bInterval               0
>>        Endpoint Descriptor:
>>          bLength                 7
>>          bDescriptorType         5
>>          bEndpointAddress     0x0f  EP 15 OUT
>>          bmAttributes            2
>>            Transfer Type            Bulk
>>            Synch Type               None
>>            Usage Type               Data
>>          wMaxPacketSize     0x0200  1x 512 bytes
>>          bInterval               0
>>      Interface Descriptor:
>>        bLength                 9
>>        bDescriptorType         4
>>        bInterfaceNumber        2
>>        bAlternateSetting       0
>>        bNumEndpoints           2
>>        bInterfaceClass       255 Vendor Specific Class
>>        bInterfaceSubClass    255 Vendor Specific Subclass
>>        bInterfaceProtocol     48
>>        iInterface              0
>>        Endpoint Descriptor:
>>          bLength                 7
>>          bDescriptorType         5
>>          bEndpointAddress     0x82  EP 2 IN
>>          bmAttributes            2
>>            Transfer Type            Bulk
>>            Synch Type               None
>>            Usage Type               Data
>>          wMaxPacketSize     0x0200  1x 512 bytes
>>          bInterval               0
>>        Endpoint Descriptor:
>>          bLength                 7
>>          bDescriptorType         5
>>          bEndpointAddress     0x01  EP 1 OUT
>>          bmAttributes            2
>>            Transfer Type            Bulk
>>            Synch Type               None
>>            Usage Type               Data
>>          wMaxPacketSize     0x0200  1x 512 bytes
>>          bInterval               0
>>      Interface Descriptor:
>>        bLength                 9
>>        bDescriptorType         4
>>        bInterfaceNumber        3
>>        bAlternateSetting       0
>>        bNumEndpoints           2
>>        bInterfaceClass       255 Vendor Specific Class
>>        bInterfaceSubClass     66
>>        bInterfaceProtocol      1
>>        iInterface              8 ADB Interface
>>        Endpoint Descriptor:
>>          bLength                 7
>>          bDescriptorType         5
>>          bEndpointAddress     0x02  EP 2 OUT
>>          bmAttributes            2
>>            Transfer Type            Bulk
>>            Synch Type               None
>>            Usage Type               Data
>>          wMaxPacketSize     0x0200  1x 512 bytes
>>          bInterval               0
>>        Endpoint Descriptor:
>>          bLength                 7
>>          bDescriptorType         5
>>          bEndpointAddress     0x83  EP 3 IN
>>          bmAttributes            2
>>            Transfer Type            Bulk
>>            Synch Type               None
>>            Usage Type               Data
>>          wMaxPacketSize     0x0200  1x 512 bytes
>>          bInterval               0
> 
> //snip
> 
> Interface #3 for ADB must be blacklisted in the option entry for the 
> device, by using .driver_info = RSVD(3)
> 


When looking at the entries for other Telit deices in the option driver 
I see that their diag interface always has
the NCTRL flag so it is likely that you need that for this device also.
See the entry for PID 1052


thanks
Lars
