Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E741282AEE
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 15:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgJDN3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 09:29:18 -0400
Received: from mail-db8eur05on2113.outbound.protection.outlook.com ([40.107.20.113]:41728
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726073AbgJDN3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 09:29:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJnoUyi7O2y/E0/SPX+JFnN1XCdbSAa3XRidWaZ7v9g5uaKMnA8wJvCQjNRV9sKl63arZpB4+mCwv/YPgQpZHFKpZKkdH2+xgt8QNCl97Yx2YwqrIH0QgYIBJQ7eecxEKlFkIHnbfCFyPRu5Gpi4vzszSwf6RGp53Ue/GscdYrllf8J5p4LEM19fz+2kcK0CylIZZdFcWRnMFa3yKJIWrpjjkoPVfgXLoWd1RXqhlkTAnrFJmwv1GNrpSuEBhEVJTExWJi0YBFhyY0g4Vu7AB+jrzmz7orGJy7Rl3qgHwej7buJr7A8pl2BlIh7CwMvEDDeDb+tfKmlJSYSASO3S/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EK8N4OTjK5D7w88x9r3Gzk7mErw5VJeuHhvox+fD2v8=;
 b=Xyt4kycqod4sam6Fmp0YBwWRjRMEQIzMDwTstQzRPk3N35YcLEOPmpx3m67mXkVgNfhRYcRpwtaq3gl5kqjjjz223rgu0blOar7EPgaI5LphPRRea6FP20YiycNmfAIIyAbpKzbJTEUi8MdP2w00nmGiRXz74ULy2yfxzucYbMBzQ7vNyTyzEZF5hkjO+/6g9UrOdlDbsf02rnGCvrIzoREQrCqgmQy5kMF+sPvbnZ9RlWcPs/mZVnD+FyaFgGL0XbituaLUxl3PdgDNufWyA5mbSaYd07eJLZHUpoSKPi5z56LlvFOJiFbokVY1sIxh0rqGqVS6mxdpxL1mSVdxCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=asocscloud.com; dmarc=pass action=none
 header.from=asocscloud.com; dkim=pass header.d=asocscloud.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Asocs.onmicrosoft.com;
 s=selector2-Asocs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EK8N4OTjK5D7w88x9r3Gzk7mErw5VJeuHhvox+fD2v8=;
 b=ES1dsXiT0n0SdTG1mdUoxS1t2PM5Oh6TzHs537pm7KwIa0uli+5nGlk5aflKwUd17Y09mDBY8+tNrtnL0eUPo+o1z5JpVMhgas34nyxciAsCKz/Eyl9SWXvQUAhWclZ4ByF22xk6P5iRl9LRjFNhZT3LGezjNCYN1AGx1CCRbkk=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=asocscloud.com;
Received: from AM6PR10MB2582.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:a0::24)
 by AM7PR10MB3638.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:13b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Sun, 4 Oct
 2020 13:29:11 +0000
Received: from AM6PR10MB2582.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c4ca:176b:ff4:74f]) by AM6PR10MB2582.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c4ca:176b:ff4:74f%7]) with mapi id 15.20.3433.043; Sun, 4 Oct 2020
 13:29:11 +0000
Subject: Re: [PATCH] USB: serial: option: Add Telit FT980-KS composition
To:     Lars Melin <larsm17@gmail.com>,
        Leonid Bloch <lb.workbox@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>
References: <20201004095703.2633-1-lb.workbox@gmail.com>
 <886eb499-4db4-1d61-2e67-0335423bf077@gmail.com>
From:   Leonid Bloch <leonidb@asocscloud.com>
Message-ID: <ce86bc05-f4e2-b199-0cdc-792715e3f275@asocscloud.com>
Date:   Sun, 4 Oct 2020 16:29:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <886eb499-4db4-1d61-2e67-0335423bf077@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [62.0.130.144]
X-ClientProxiedBy: MRXP264CA0024.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:15::36) To AM6PR10MB2582.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:a0::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.4.121] (62.0.130.144) by MRXP264CA0024.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:15::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35 via Frontend Transport; Sun, 4 Oct 2020 13:29:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 796ace7b-3ba9-40e8-64bc-08d868697ade
X-MS-TrafficTypeDiagnostic: AM7PR10MB3638:
X-Microsoft-Antispam-PRVS: <AM7PR10MB36387FBD89F791BE3D529FA2CE0F0@AM7PR10MB3638.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:302;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3UrJpN1FF+iZC1aOENNZspt/qMG1KabhWe0ncUQmoAdYHkBeJWShh4wzQ3qGTYfRXnTqgj251iLvFJmzBztWA+NIQ/pkjkrngCgDaivljVJ/CTypKlUqauj+dgCgqSARZzeC1Zlh2KUBFX17uJC8e63OwQUTRZlJZDZJaw5Cggr4LcTIxcUD5nEvQ2J8djppJ5ZX1gFILVGIkqU4ECGvSF3zpADAOUefqi9WIUtB+CdwG2NL3wKQ7LK4DZd6Cvaq2WPe97x9LSYvBTJG4QAvrDxZW8vCYBIb5CfVCtc8T9xRu9YqVflewcm4TwdhubZGDBF2I+0I1pbptRBnSk9bkUtqDIWCj1WzLi793bqRcPkPhW+BJWvwVTx8CkZhCzfP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR10MB2582.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39830400003)(346002)(366004)(396003)(376002)(136003)(86362001)(53546011)(6486002)(31686004)(31696002)(2906002)(36756003)(478600001)(8676002)(316002)(52116002)(16576012)(110136005)(8936002)(66946007)(66556008)(54906003)(66476007)(5660300002)(4326008)(2616005)(956004)(26005)(16526019)(186003)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 0+PdutNXvoF1hgUE9S/RwT/TC1EHKj9jpvGPyF5lWawe/Uy8n9I0lTPsNwoxqvnjPQsAOsoIJOCBU51q/dBDYqOk6Gsbc2W00jd4DWXH3Qe/90qctFtENtqrTBbO3DhdboxO7AhpfZHA0ax7csfrMZCqe/Ugd3UDN72FED8vqNdd+qUngQZA/KAffWLuAOqLEosAli+onltnBPtcomSdirR3eghL0UefMMzFh7KM3v7p9rMb/g7zCVgcsOZDelgOBwowilHq+5PqfVP5PzvegkbiyOwKTXefONplYzTyqCIj7tkzkzZ7FSRSHQVypIR3MCml0iAlF9ciwml88P6yv9fu9NM0hlK0yTjASzoLhqWdxG7YTNODZVWNfaWfutrg68i2Q7Mxms2OsGxK0rzBoTpWYeTz38MtbUjGn3tyaYcWoEtUNC3W/SXQdCuS28yBq/Nu2hrJIE603nj8iSNTrRVfTb6N0vVI1u4qR7hgPo9cG5xcdXp+BLOvVsLyuu69Hybe30/e7LXSJTJB1NG+pL9TEFcGNUqak1Myw5riDNsv1VG2UnOZUoSTAcKsmE373DYlFVxdW7wU4Oq0dvdec3J8K4ob4vf4kupmLbsQFM/CN6xiLzMRcBAfdHeFH5mqBEDzPSnkif1WF8GDKMaZyg==
X-OriginatorOrg: asocscloud.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 796ace7b-3ba9-40e8-64bc-08d868697ade
X-MS-Exchange-CrossTenant-AuthSource: AM6PR10MB2582.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2020 13:29:11.6914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 09a71e5b-e130-419f-bde2-1e8422f00aaa
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TrMFvwWVitXICHqmVVTqC5aXBbqMg2078kgZfTn8WwAz9qwykzU4WTneXz765gbxwMFwqVubesbDzDjY6iI2zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3638
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/20 1:58 PM, Lars Melin wrote:
> On 10/4/2020 16:57, Leonid Bloch wrote:
>> This commit adds the following Telit FT980-KS composition:
>>
>> 0x1054: rndis, diag, adb, nmea, modem, modem, aux
>>
>> AT commands can be sent to /dev/ttyUSB5.
>>
> 
> Please submit a verbose lsusb listing for the device, I can't imagine
> that the adb interface should be handled by the option serial driver so
> there will never be a ttyUSB5.

Please see below.

Thanks,
Leonid.

```
Bus 001 Device 005: ID 1bc7:1054 Telit Wireless Solutions
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               2.10
   bDeviceClass            0
   bDeviceSubClass         0
   bDeviceProtocol         0
   bMaxPacketSize0        64
   idVendor           0x1bc7 Telit Wireless Solutions
   idProduct          0x1054
   bcdDevice            4.14
   iManufacturer           1 Telit Wireless Solutions
   iProduct                2 FT980-KS
   iSerial                 3 cb42f61
   bNumConfigurations      1
   Configuration Descriptor:
     bLength                 9
     bDescriptorType         2
     wTotalLength       0x013d
     bNumInterfaces          8
     bConfigurationValue     1
     iConfiguration          4 RNDIS_DIAG_ADB_NMEA_DUN_DUN_SER
     bmAttributes         0xa0
       (Bus Powered)
       Remote Wakeup
     MaxPower              500mA
     Interface Association:
       bLength                 8
       bDescriptorType        11
       bFirstInterface         0
       bInterfaceCount         2
       bFunctionClass        239 Miscellaneous Device
       bFunctionSubClass       4
       bFunctionProtocol       1
       iFunction               7 RNDIS
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        0
       bAlternateSetting       0
       bNumEndpoints           1
       bInterfaceClass       239 Miscellaneous Device
       bInterfaceSubClass      4
       bInterfaceProtocol      1
       iInterface              5 RNDIS Communications Control
       ** UNRECOGNIZED:  05 24 00 10 01
       ** UNRECOGNIZED:  05 24 01 00 01
       ** UNRECOGNIZED:  04 24 02 00
       ** UNRECOGNIZED:  05 24 06 00 01
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x81  EP 1 IN
         bmAttributes            3
           Transfer Type            Interrupt
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0008  1x 8 bytes
         bInterval               9
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        1
       bAlternateSetting       0
       bNumEndpoints           2
       bInterfaceClass        10 CDC Data
       bInterfaceSubClass      0
       bInterfaceProtocol      0
       iInterface              6 RNDIS Ethernet Data
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x8e  EP 14 IN
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0200  1x 512 bytes
         bInterval               0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x0f  EP 15 OUT
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0200  1x 512 bytes
         bInterval               0
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        2
       bAlternateSetting       0
       bNumEndpoints           2
       bInterfaceClass       255 Vendor Specific Class
       bInterfaceSubClass    255 Vendor Specific Subclass
       bInterfaceProtocol     48
       iInterface              0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x82  EP 2 IN
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0200  1x 512 bytes
         bInterval               0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x01  EP 1 OUT
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0200  1x 512 bytes
         bInterval               0
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        3
       bAlternateSetting       0
       bNumEndpoints           2
       bInterfaceClass       255 Vendor Specific Class
       bInterfaceSubClass     66
       bInterfaceProtocol      1
       iInterface              8 ADB Interface
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x02  EP 2 OUT
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0200  1x 512 bytes
         bInterval               0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x83  EP 3 IN
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0200  1x 512 bytes
         bInterval               0
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        4
       bAlternateSetting       0
       bNumEndpoints           3
       bInterfaceClass       255 Vendor Specific Class
       bInterfaceSubClass      0
       bInterfaceProtocol      0
       iInterface              0
       ** UNRECOGNIZED:  05 24 00 10 01
       ** UNRECOGNIZED:  05 24 01 00 00
       ** UNRECOGNIZED:  04 24 02 02
       ** UNRECOGNIZED:  05 24 06 00 00
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x85  EP 5 IN
         bmAttributes            3
           Transfer Type            Interrupt
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x000a  1x 10 bytes
         bInterval               9
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x84  EP 4 IN
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0200  1x 512 bytes
         bInterval               0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x03  EP 3 OUT
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0200  1x 512 bytes
         bInterval               0
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        5
       bAlternateSetting       0
       bNumEndpoints           3
       bInterfaceClass       255 Vendor Specific Class
       bInterfaceSubClass      0
       bInterfaceProtocol      0
       iInterface              0
       ** UNRECOGNIZED:  05 24 00 10 01
       ** UNRECOGNIZED:  05 24 01 00 00
       ** UNRECOGNIZED:  04 24 02 02
       ** UNRECOGNIZED:  05 24 06 00 00
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x87  EP 7 IN
         bmAttributes            3
           Transfer Type            Interrupt
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x000a  1x 10 bytes
         bInterval               9
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x86  EP 6 IN
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0200  1x 512 bytes
         bInterval               0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x04  EP 4 OUT
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0200  1x 512 bytes
         bInterval               0
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        6
       bAlternateSetting       0
       bNumEndpoints           3
       bInterfaceClass       255 Vendor Specific Class
       bInterfaceSubClass      0
       bInterfaceProtocol      0
       iInterface              0
       ** UNRECOGNIZED:  05 24 00 10 01
       ** UNRECOGNIZED:  05 24 01 00 00
       ** UNRECOGNIZED:  04 24 02 02
       ** UNRECOGNIZED:  05 24 06 00 00
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x89  EP 9 IN
         bmAttributes            3
           Transfer Type            Interrupt
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x000a  1x 10 bytes
         bInterval               9
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x88  EP 8 IN
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0200  1x 512 bytes
         bInterval               0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x05  EP 5 OUT
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0200  1x 512 bytes
         bInterval               0
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        7
       bAlternateSetting       0
       bNumEndpoints           3
       bInterfaceClass       255 Vendor Specific Class
       bInterfaceSubClass      0
       bInterfaceProtocol      0
       iInterface              0
       ** UNRECOGNIZED:  05 24 00 10 01
       ** UNRECOGNIZED:  05 24 01 00 00
       ** UNRECOGNIZED:  04 24 02 02
       ** UNRECOGNIZED:  05 24 06 00 00
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x8b  EP 11 IN
         bmAttributes            3
           Transfer Type            Interrupt
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x000a  1x 10 bytes
         bInterval               9
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x8a  EP 10 IN
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0200  1x 512 bytes
         bInterval               0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x06  EP 6 OUT
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0200  1x 512 bytes
         bInterval               0
Binary Object Store Descriptor:
   bLength                 5
   bDescriptorType        15
   wTotalLength       0x002a
   bNumDeviceCaps          3
   USB 2.0 Extension Device Capability:
     bLength                 7
     bDescriptorType        16
     bDevCapabilityType      2
     bmAttributes   0x00000006
       BESL Link Power Management (LPM) Supported
   SuperSpeed USB Device Capability:
     bLength                10
     bDescriptorType        16
     bDevCapabilityType      3
     bmAttributes         0x00
     wSpeedsSupported   0x000f
       Device can operate at Low Speed (1Mbps)
       Device can operate at Full Speed (12Mbps)
       Device can operate at High Speed (480Mbps)
       Device can operate at SuperSpeed (5Gbps)
     bFunctionalitySupport   1
       Lowest fully-functional device speed is Full Speed (12Mbps)
     bU1DevExitLat           1 micro seconds
     bU2DevExitLat         500 micro seconds
   SuperSpeedPlus USB Device Capability:
     bLength                20
     bDescriptorType        16
     bDevCapabilityType     10
     bmAttributes         0x00000001
       Sublink Speed Attribute count 1
       Sublink Speed ID count 0
     wFunctionalitySupport   0x1100
     bmSublinkSpeedAttr[0]   0x000a4030
       Speed Attribute ID: 0 10Gb/s Symmetric RX SuperSpeedPlus
     bmSublinkSpeedAttr[1]   0x000a40b0
       Speed Attribute ID: 0 10Gb/s Symmetric TX SuperSpeedPlus
Device Status:     0x0000
   (Bus Powered)

```

> 
> 
> thanks
> Lars
> 
