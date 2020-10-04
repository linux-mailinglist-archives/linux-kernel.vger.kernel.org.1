Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E64282B23
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 16:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbgJDOQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 10:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgJDOQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 10:16:19 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36184C0613CE;
        Sun,  4 Oct 2020 07:16:19 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id u3so3705418pjr.3;
        Sun, 04 Oct 2020 07:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LstlgdKhENDfbKn3ustNkI+4Ru3zYOat1H014Cca/uo=;
        b=Nj//pC7Kv5tglDd1PdYEl1ay0wZMxUBghg/hNspFJHahir953vS2u0rhgqWFiMwen/
         IZbYWkgh37ycmndQQ38/jejyX1BvugQ6/n6E7LhOhOgv8t+zBGfb1OZeEmNXXRvQxJoP
         ZTivpc372DbAqoEKo6Lde/E3qunzimbt9Vyc0M4a1yy+wZFlqwS9mVpO3A0ACh1QQxoy
         IJmI2HmkF4jgC9gbQOlD85pR0LgH3IkgJQobycn5K0VLxEp8kn3cwpmUpxkVuLz6fDac
         3HyEmfd97cuyNnmdMWf4AppQJZWtM6jW21SWKwYdTr4Lo1ZY4SS8NycpJmOaxcb3aOvi
         lNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LstlgdKhENDfbKn3ustNkI+4Ru3zYOat1H014Cca/uo=;
        b=MntK+HoSR2NVwrUZPyQ/Sj3ehJD1cq5Nr6DiO9rX12iL1akHIKyONqwzVA/e10TltB
         GuC7pBgiyhfbFRP1SLbj8I3qdHHOKznO44vgPfDuwxe7NA/icmOQy7YXx4WF2lxwh7AT
         JmlDXWZnz4gb8hn9sp5HwCeDloV+Bneg6SNjK27KvU0IwecIAeCDyzpzDM2Wk9Hl6isJ
         KIKtsLbK9LfwFp/M+PHLFgVTRYytNrCl4VxweFwDbIvPSAZ0jbEoHl6UaAB4DTYnFRv5
         ak31xc9MmPhOTvkFedxRhnTsBeDQ3a7DcJuW4gsYYV1JYfxJ820qxLOcT3P1at5w9566
         VK1g==
X-Gm-Message-State: AOAM532qa7OhekHoDz09UwGXKrszsad+2kowlWjlzYgP3eH8Nq93u4tN
        Oh2myh+pys1x8NsK83qMxV8=
X-Google-Smtp-Source: ABdhPJwWn0HlPQweol3CEHmV3qMnuQOYCw30V2GYU7hbc83JnnBC2hPXNvgJn36B3ECk2mUrqzI7ag==
X-Received: by 2002:a17:90b:4394:: with SMTP id in20mr12589360pjb.70.1601820978618;
        Sun, 04 Oct 2020 07:16:18 -0700 (PDT)
Received: from [192.168.1.5] ([110.77.216.3])
        by smtp.googlemail.com with ESMTPSA id g4sm7539644pgh.65.2020.10.04.07.16.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2020 07:16:18 -0700 (PDT)
Subject: Re: [PATCH] USB: serial: option: Add Telit FT980-KS composition
To:     Leonid Bloch <leonidb@asocscloud.com>,
        Leonid Bloch <lb.workbox@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>
References: <20201004095703.2633-1-lb.workbox@gmail.com>
 <886eb499-4db4-1d61-2e67-0335423bf077@gmail.com>
 <ce86bc05-f4e2-b199-0cdc-792715e3f275@asocscloud.com>
From:   Lars Melin <larsm17@gmail.com>
Message-ID: <bf28e522-be94-a6f7-ea44-9c954849fca6@gmail.com>
Date:   Sun, 4 Oct 2020 21:16:14 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <ce86bc05-f4e2-b199-0cdc-792715e3f275@asocscloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/2020 20:29, Leonid Bloch wrote:
> On 10/4/20 1:58 PM, Lars Melin wrote:
>> On 10/4/2020 16:57, Leonid Bloch wrote:
>>> This commit adds the following Telit FT980-KS composition:
>>>
>>> 0x1054: rndis, diag, adb, nmea, modem, modem, aux
>>>
>>> AT commands can be sent to /dev/ttyUSB5.
>>>
>>
>> Please submit a verbose lsusb listing for the device, I can't imagine
>> that the adb interface should be handled by the option serial driver so
>> there will never be a ttyUSB5.
> 
> Please see below.
> 
> Thanks,
> Leonid.
> 
> ```
> Bus 001 Device 005: ID 1bc7:1054 Telit Wireless Solutions
> Device Descriptor:
>    bLength                18
>    bDescriptorType         1
>    bcdUSB               2.10
>    bDeviceClass            0
>    bDeviceSubClass         0
>    bDeviceProtocol         0
>    bMaxPacketSize0        64
>    idVendor           0x1bc7 Telit Wireless Solutions
>    idProduct          0x1054
>    bcdDevice            4.14
>    iManufacturer           1 Telit Wireless Solutions
>    iProduct                2 FT980-KS
>    iSerial                 3 cb42f61
>    bNumConfigurations      1
>    Configuration Descriptor:
>      bLength                 9
>      bDescriptorType         2
>      wTotalLength       0x013d
>      bNumInterfaces          8
>      bConfigurationValue     1
>      iConfiguration          4 RNDIS_DIAG_ADB_NMEA_DUN_DUN_SER
>      bmAttributes         0xa0
>        (Bus Powered)
>        Remote Wakeup
>      MaxPower              500mA
>      Interface Association:
>        bLength                 8
>        bDescriptorType        11
>        bFirstInterface         0
>        bInterfaceCount         2
>        bFunctionClass        239 Miscellaneous Device
>        bFunctionSubClass       4
>        bFunctionProtocol       1
>        iFunction               7 RNDIS
>      Interface Descriptor:
>        bLength                 9
>        bDescriptorType         4
>        bInterfaceNumber        0
>        bAlternateSetting       0
>        bNumEndpoints           1
>        bInterfaceClass       239 Miscellaneous Device
>        bInterfaceSubClass      4
>        bInterfaceProtocol      1
>        iInterface              5 RNDIS Communications Control
>        ** UNRECOGNIZED:  05 24 00 10 01
>        ** UNRECOGNIZED:  05 24 01 00 01
>        ** UNRECOGNIZED:  04 24 02 00
>        ** UNRECOGNIZED:  05 24 06 00 01
>        Endpoint Descriptor:
>          bLength                 7
>          bDescriptorType         5
>          bEndpointAddress     0x81  EP 1 IN
>          bmAttributes            3
>            Transfer Type            Interrupt
>            Synch Type               None
>            Usage Type               Data
>          wMaxPacketSize     0x0008  1x 8 bytes
>          bInterval               9
>      Interface Descriptor:
>        bLength                 9
>        bDescriptorType         4
>        bInterfaceNumber        1
>        bAlternateSetting       0
>        bNumEndpoints           2
>        bInterfaceClass        10 CDC Data
>        bInterfaceSubClass      0
>        bInterfaceProtocol      0
>        iInterface              6 RNDIS Ethernet Data
>        Endpoint Descriptor:
>          bLength                 7
>          bDescriptorType         5
>          bEndpointAddress     0x8e  EP 14 IN
>          bmAttributes            2
>            Transfer Type            Bulk
>            Synch Type               None
>            Usage Type               Data
>          wMaxPacketSize     0x0200  1x 512 bytes
>          bInterval               0
>        Endpoint Descriptor:
>          bLength                 7
>          bDescriptorType         5
>          bEndpointAddress     0x0f  EP 15 OUT
>          bmAttributes            2
>            Transfer Type            Bulk
>            Synch Type               None
>            Usage Type               Data
>          wMaxPacketSize     0x0200  1x 512 bytes
>          bInterval               0
>      Interface Descriptor:
>        bLength                 9
>        bDescriptorType         4
>        bInterfaceNumber        2
>        bAlternateSetting       0
>        bNumEndpoints           2
>        bInterfaceClass       255 Vendor Specific Class
>        bInterfaceSubClass    255 Vendor Specific Subclass
>        bInterfaceProtocol     48
>        iInterface              0
>        Endpoint Descriptor:
>          bLength                 7
>          bDescriptorType         5
>          bEndpointAddress     0x82  EP 2 IN
>          bmAttributes            2
>            Transfer Type            Bulk
>            Synch Type               None
>            Usage Type               Data
>          wMaxPacketSize     0x0200  1x 512 bytes
>          bInterval               0
>        Endpoint Descriptor:
>          bLength                 7
>          bDescriptorType         5
>          bEndpointAddress     0x01  EP 1 OUT
>          bmAttributes            2
>            Transfer Type            Bulk
>            Synch Type               None
>            Usage Type               Data
>          wMaxPacketSize     0x0200  1x 512 bytes
>          bInterval               0
>      Interface Descriptor:
>        bLength                 9
>        bDescriptorType         4
>        bInterfaceNumber        3
>        bAlternateSetting       0
>        bNumEndpoints           2
>        bInterfaceClass       255 Vendor Specific Class
>        bInterfaceSubClass     66
>        bInterfaceProtocol      1
>        iInterface              8 ADB Interface
>        Endpoint Descriptor:
>          bLength                 7
>          bDescriptorType         5
>          bEndpointAddress     0x02  EP 2 OUT
>          bmAttributes            2
>            Transfer Type            Bulk
>            Synch Type               None
>            Usage Type               Data
>          wMaxPacketSize     0x0200  1x 512 bytes
>          bInterval               0
>        Endpoint Descriptor:
>          bLength                 7
>          bDescriptorType         5
>          bEndpointAddress     0x83  EP 3 IN
>          bmAttributes            2
>            Transfer Type            Bulk
>            Synch Type               None
>            Usage Type               Data
>          wMaxPacketSize     0x0200  1x 512 bytes
>          bInterval               0

//snip

Interface #3 for ADB must be blacklisted in the option entry for the 
device, by using .driver_info = RSVD(3)


thanks
Lars
