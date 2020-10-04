Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3156D282BA2
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 18:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbgJDQD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 12:03:58 -0400
Received: from mail-eopbgr70097.outbound.protection.outlook.com ([40.107.7.97]:10661
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725825AbgJDQD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 12:03:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OgrQd8nxtynS4Ms+9I4r5Tk9qi2Csn/fFicAkmXK9Hj5f+kai1UXS9Gxzq/F5gGNjs6oOAjRaZR9Hmb6iVn1ltIvOkH+IGrPZDrCr91LztW69LcshoInYFTTiI8AjSYRZOmq6koKX3cZd+qoBWkMbTRtZ2hEnDgjZPv+8le1viLKkbJSaf4IjpfRfIGn+vlcFywStPsT+uDqYxuA+anETs3sgaTS8hW+ZKQrVtg9e4zKYrEHOK7cDlBk2Jfip9TIhnY/n1EfAt+HZzJoj/UaZM2rzLT56+9apOEYUYr57IvAPQZWe678yn7yrt6jHdqvuo6VsfGZJFG3q+uuN8FmkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ury+diA/UHQbA5F/MKmpy1BSo/EUG8cyaGz7dcSG7bU=;
 b=UHO2GUy6obO/78N1LxWG0dFI/4SOVynSyA2ELZtZ2psae+LZjeCyfSvtDl0r8J5hzokfnwwfsgN5+MOBxYTL0tNU65VSJlR4tN5VhrB29MswkkGz0uMQr+VIKxyeDBly7NFvhWPn9OdU+6D8hcAe4vBZWlg9lyIF+Zkxb6z5r6um+12WJ8ch5UcNV8Los/EF8+9y92XyDQrDFm/wlE3hrJ1wyLhlj2swzLKG9cQHjDypGvNnDiF1k44e5fuFc1MPWXcoPFwTca/IdJc5t0MZL/Xh97Nyq8XrjH7WWhGbvBo/fmxqaRq/y0Didw8IK0OlHt35WhA/ndJ1VrU5rWCe/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=asocscloud.com; dmarc=pass action=none
 header.from=asocscloud.com; dkim=pass header.d=asocscloud.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Asocs.onmicrosoft.com;
 s=selector2-Asocs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ury+diA/UHQbA5F/MKmpy1BSo/EUG8cyaGz7dcSG7bU=;
 b=tbWqqQCBynHKNSjFDojkV9oVUVSjlSttFSSitE0YmwsEE3rppM1OBh3TcCUnn17EeacCTp9TNP0qTQtfahgmuh8Oj9f+oZA3H5q4jWOuP8lhzpL+7wu11fYHffMlcAi3OqUF4f+6wU9ByRKL9oKwNe04KGs8Hz1UexOOqayGNVQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=asocscloud.com;
Received: from AM6PR10MB2582.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:a0::24)
 by AM6PR10MB2440.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4c::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Sun, 4 Oct
 2020 16:03:50 +0000
Received: from AM6PR10MB2582.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c4ca:176b:ff4:74f]) by AM6PR10MB2582.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c4ca:176b:ff4:74f%7]) with mapi id 15.20.3433.043; Sun, 4 Oct 2020
 16:03:50 +0000
Subject: Re: [PATCH] USB: serial: option: Add Telit FT980-KS composition
To:     Lars Melin <larsm17@gmail.com>,
        Leonid Bloch <lb.workbox@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>
References: <20201004095703.2633-1-lb.workbox@gmail.com>
 <886eb499-4db4-1d61-2e67-0335423bf077@gmail.com>
 <ce86bc05-f4e2-b199-0cdc-792715e3f275@asocscloud.com>
 <bf28e522-be94-a6f7-ea44-9c954849fca6@gmail.com>
 <ab8c7550-19b9-f8a9-febb-9d2d558978e7@gmail.com>
From:   Leonid Bloch <leonidb@asocscloud.com>
Message-ID: <94352367-68b4-0bb4-073f-2bfdd9391061@asocscloud.com>
Date:   Sun, 4 Oct 2020 19:03:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <ab8c7550-19b9-f8a9-febb-9d2d558978e7@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [80.178.78.235]
X-ClientProxiedBy: MR2P264CA0068.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:31::32) To AM6PR10MB2582.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:a0::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.15.1.22] (80.178.78.235) by MR2P264CA0068.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:31::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35 via Frontend Transport; Sun, 4 Oct 2020 16:03:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37a1c6dc-da67-451d-e8da-08d8687f1539
X-MS-TrafficTypeDiagnostic: AM6PR10MB2440:
X-Microsoft-Antispam-PRVS: <AM6PR10MB2440C125DDB80B2EBDEC6650CE0F0@AM6PR10MB2440.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P+jI+A1c99SMN51aVf1IlM4/VFXCwEtKVd7/HZLgC9QcZMdIG7Qi69ts6XZY06gM6k08HiFZGyQQV+GczLVZBTrj7FA6r303dmdGWNa9ioXWXrysEEDYwzC1UVFl5CL2c/ooNKaS+bpT1b9QbwCTTjs9ZoUCnrfRSi4Q7/+wX3HUP0N/fFz3IjnYaY4qipeGTfUqesTf4JlH+gFQhWOb0ssnGOqO/yayTXKew90zTPg5z+RApibDp6UMnL5O7ry2iV/X1igRL1lZ1rTXJLZRY8TxsXZ5zkJjYF0chUejqYKvRNsw0dic+nJDleKxKzMJjlQr2g/MxtzNVTwnDFRjRzilCj+jGekLQeYeDvto7ew3gB+otIqBnD08Gkedc260iMZemD+gMCafx/kB8fS7Jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR10MB2582.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(39830400003)(346002)(396003)(366004)(376002)(6486002)(31686004)(5660300002)(8676002)(478600001)(36756003)(53546011)(83380400001)(8936002)(31696002)(52116002)(2616005)(66946007)(66476007)(956004)(66556008)(4326008)(186003)(2906002)(54906003)(110136005)(6706004)(26005)(86362001)(16526019)(16576012)(316002)(78286007)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 6wTUH3lT8l+Qki8VhhX7lM7cNQhlvaE1WzYrSupE++W6Z76ykj53oHhsAHDvIVTgBqdQ5SfpkD/Yqc8ZybJAa35rRdNeZHri71c7wiWpkZEfLxV14X5XCw7WGwVkn4wKenM5KlLZ0stHxnJ3h1T7XSadOizFsCqfte9XSDevj+iqEJjSNHs1AEdJ5pSMoaAM4tcb1hho45AI9pV8P19/slAUPipVyuBU5itZzO5KocJWONB8hEUX/PhbLH9j8GttusqAAd7SMSfpZNGCx2vGghzqHwKS/jss+X8dNC2gTq/q1Rv2m5alLyZjlidqJxqfBw67GF9JsGbaSg4pazsPxLVHv0R46SYxGdah/7eXd2KGjdxTwOK/B8dJ52zvxEEVdMAunp4zhwD0lRp8OidgnNt6Uj21COWMWSsOQbVn8NcPRAsTg3ZniixO4ajcIibWKBbNMKaG6eqLW5jez9r0B85fCZZjCaq6kbj4ip09V02q8iq+lVGnYbNK2FR3cSvnUHbM6ZZqAAeR1LmOsVXjuA/6b1jrnNjbA4bLU9VU+Ln8bLt++qaBckaeRIqxbKOfws12bgFkoy7J7uXWEPQK3M2qMK/cKloMt/bO6Bm6my1C+IY468H0/CqCbAi9K4UTmir357YebvQrDtR9IrjNEg==
X-OriginatorOrg: asocscloud.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37a1c6dc-da67-451d-e8da-08d8687f1539
X-MS-Exchange-CrossTenant-AuthSource: AM6PR10MB2582.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2020 16:03:50.0376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 09a71e5b-e130-419f-bde2-1e8422f00aaa
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k4aw2plvUMQZw93kA1uXHsdCIPQgn31GyoydnssGNq30ZVC5Bp40jxL/a4c6fdND+Imfp6q+bBi4U11rNYAZoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2440
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lars,


Thank you for your review! The changes which you have suggested also 
made ModemManager to recognize the device (which it didn't do before). 
Please check out the v2.


Cheers,
Leonid.

___

On 10/4/20 5:32 PM, Lars Melin wrote:
> On 10/4/2020 21:16, Lars Melin wrote:
>> On 10/4/2020 20:29, Leonid Bloch wrote:
>>> On 10/4/20 1:58 PM, Lars Melin wrote:
>>>> On 10/4/2020 16:57, Leonid Bloch wrote:
>>>>> This commit adds the following Telit FT980-KS composition:
>>>>>
>>>>> 0x1054: rndis, diag, adb, nmea, modem, modem, aux
>>>>>
>>>>> AT commands can be sent to /dev/ttyUSB5.
>>>>>
>>>>
>>>> Please submit a verbose lsusb listing for the device, I can't imagine
>>>> that the adb interface should be handled by the option serial driver so
>>>> there will never be a ttyUSB5.
>>>
>>> Please see below.
>>>
>>> Thanks,
>>> Leonid.
>>>
>>> ```
>>> Bus 001 Device 005: ID 1bc7:1054 Telit Wireless Solutions
>>> Device Descriptor:
>>>     bLength                18
>>>     bDescriptorType         1
>>>     bcdUSB               2.10
>>>     bDeviceClass            0
>>>     bDeviceSubClass         0
>>>     bDeviceProtocol         0
>>>     bMaxPacketSize0        64
>>>     idVendor           0x1bc7 Telit Wireless Solutions
>>>     idProduct          0x1054
>>>     bcdDevice            4.14
>>>     iManufacturer           1 Telit Wireless Solutions
>>>     iProduct                2 FT980-KS
>>>     iSerial                 3 cb42f61
>>>     bNumConfigurations      1
>>>     Configuration Descriptor:
>>>       bLength                 9
>>>       bDescriptorType         2
>>>       wTotalLength       0x013d
>>>       bNumInterfaces          8
>>>       bConfigurationValue     1
>>>       iConfiguration          4 RNDIS_DIAG_ADB_NMEA_DUN_DUN_SER
>>>       bmAttributes         0xa0
>>>         (Bus Powered)
>>>         Remote Wakeup
>>>       MaxPower              500mA
>>>       Interface Association:
>>>         bLength                 8
>>>         bDescriptorType        11
>>>         bFirstInterface         0
>>>         bInterfaceCount         2
>>>         bFunctionClass        239 Miscellaneous Device
>>>         bFunctionSubClass       4
>>>         bFunctionProtocol       1
>>>         iFunction               7 RNDIS
>>>       Interface Descriptor:
>>>         bLength                 9
>>>         bDescriptorType         4
>>>         bInterfaceNumber        0
>>>         bAlternateSetting       0
>>>         bNumEndpoints           1
>>>         bInterfaceClass       239 Miscellaneous Device
>>>         bInterfaceSubClass      4
>>>         bInterfaceProtocol      1
>>>         iInterface              5 RNDIS Communications Control
>>>         ** UNRECOGNIZED:  05 24 00 10 01
>>>         ** UNRECOGNIZED:  05 24 01 00 01
>>>         ** UNRECOGNIZED:  04 24 02 00
>>>         ** UNRECOGNIZED:  05 24 06 00 01
>>>         Endpoint Descriptor:
>>>           bLength                 7
>>>           bDescriptorType         5
>>>           bEndpointAddress     0x81  EP 1 IN
>>>           bmAttributes            3
>>>             Transfer Type            Interrupt
>>>             Synch Type               None
>>>             Usage Type               Data
>>>           wMaxPacketSize     0x0008  1x 8 bytes
>>>           bInterval               9
>>>       Interface Descriptor:
>>>         bLength                 9
>>>         bDescriptorType         4
>>>         bInterfaceNumber        1
>>>         bAlternateSetting       0
>>>         bNumEndpoints           2
>>>         bInterfaceClass        10 CDC Data
>>>         bInterfaceSubClass      0
>>>         bInterfaceProtocol      0
>>>         iInterface              6 RNDIS Ethernet Data
>>>         Endpoint Descriptor:
>>>           bLength                 7
>>>           bDescriptorType         5
>>>           bEndpointAddress     0x8e  EP 14 IN
>>>           bmAttributes            2
>>>             Transfer Type            Bulk
>>>             Synch Type               None
>>>             Usage Type               Data
>>>           wMaxPacketSize     0x0200  1x 512 bytes
>>>           bInterval               0
>>>         Endpoint Descriptor:
>>>           bLength                 7
>>>           bDescriptorType         5
>>>           bEndpointAddress     0x0f  EP 15 OUT
>>>           bmAttributes            2
>>>             Transfer Type            Bulk
>>>             Synch Type               None
>>>             Usage Type               Data
>>>           wMaxPacketSize     0x0200  1x 512 bytes
>>>           bInterval               0
>>>       Interface Descriptor:
>>>         bLength                 9
>>>         bDescriptorType         4
>>>         bInterfaceNumber        2
>>>         bAlternateSetting       0
>>>         bNumEndpoints           2
>>>         bInterfaceClass       255 Vendor Specific Class
>>>         bInterfaceSubClass    255 Vendor Specific Subclass
>>>         bInterfaceProtocol     48
>>>         iInterface              0
>>>         Endpoint Descriptor:
>>>           bLength                 7
>>>           bDescriptorType         5
>>>           bEndpointAddress     0x82  EP 2 IN
>>>           bmAttributes            2
>>>             Transfer Type            Bulk
>>>             Synch Type               None
>>>             Usage Type               Data
>>>           wMaxPacketSize     0x0200  1x 512 bytes
>>>           bInterval               0
>>>         Endpoint Descriptor:
>>>           bLength                 7
>>>           bDescriptorType         5
>>>           bEndpointAddress     0x01  EP 1 OUT
>>>           bmAttributes            2
>>>             Transfer Type            Bulk
>>>             Synch Type               None
>>>             Usage Type               Data
>>>           wMaxPacketSize     0x0200  1x 512 bytes
>>>           bInterval               0
>>>       Interface Descriptor:
>>>         bLength                 9
>>>         bDescriptorType         4
>>>         bInterfaceNumber        3
>>>         bAlternateSetting       0
>>>         bNumEndpoints           2
>>>         bInterfaceClass       255 Vendor Specific Class
>>>         bInterfaceSubClass     66
>>>         bInterfaceProtocol      1
>>>         iInterface              8 ADB Interface
>>>         Endpoint Descriptor:
>>>           bLength                 7
>>>           bDescriptorType         5
>>>           bEndpointAddress     0x02  EP 2 OUT
>>>           bmAttributes            2
>>>             Transfer Type            Bulk
>>>             Synch Type               None
>>>             Usage Type               Data
>>>           wMaxPacketSize     0x0200  1x 512 bytes
>>>           bInterval               0
>>>         Endpoint Descriptor:
>>>           bLength                 7
>>>           bDescriptorType         5
>>>           bEndpointAddress     0x83  EP 3 IN
>>>           bmAttributes            2
>>>             Transfer Type            Bulk
>>>             Synch Type               None
>>>             Usage Type               Data
>>>           wMaxPacketSize     0x0200  1x 512 bytes
>>>           bInterval               0
>>
>> //snip
>>
>> Interface #3 for ADB must be blacklisted in the option entry for the
>> device, by using .driver_info = RSVD(3)
>>
> 
> 
> When looking at the entries for other Telit deices in the option driver
> I see that their diag interface always has
> the NCTRL flag so it is likely that you need that for this device also.
> See the entry for PID 1052
> 
> 
> thanks
> Lars
> 
