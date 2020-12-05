Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAE02CF9D2
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 06:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbgLEFoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 00:44:37 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55930 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728524AbgLEFoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 00:44:37 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0B55goS2128842;
        Fri, 4 Dec 2020 23:42:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607146970;
        bh=RaUGeA1gwPaJRn/Q7SztrlbrsY1X1SD32B6gKpX1juo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=kmilGrdGxB2UiOthrhPp/9Wsz7XNLlWG3SfO9lzIEPJC8PYwiKSqzUKCsAfXPhzMH
         Zqg1A3PPN/KFp7ISaV7s7SYT6OIPZQ68ulFn590syw2aMqwLkt6zqyqXpO2t409tUD
         U7EZPD6ZM8DOCq5lRx4xQOJGZOjFhmuOQteMDuBo=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0B55goNj028714
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 4 Dec 2020 23:42:50 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 4 Dec
 2020 23:42:49 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 4 Dec 2020 23:42:49 -0600
Received: from [10.250.232.169] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0B55gjji071782;
        Fri, 4 Dec 2020 23:42:46 -0600
Subject: RE: [PATCH v4 00/10] Introduced new Cadence USBSSP DRD Driver.
To:     Peter Chen <peter.chen@nxp.com>,
        Pawel Laszczak <pawell@cadence.com>,
        "rogerq@ti.com" <rogerq@ti.com>, "nsekhar@ti.com" <nsekhar@ti.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "kurahul@cadence.com" <kurahul@cadence.com>
References: <20201202132548.10736-1-pawell@cadence.com>
 <DBBPR04MB7979860970F8C89C648209EB8BF10@DBBPR04MB7979.eurprd04.prod.outlook.com>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <f65eb2d5-7afb-788f-3ada-8fb529a0cfba@ti.com>
Date:   Sat, 5 Dec 2020 11:12:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DBBPR04MB7979860970F8C89C648209EB8BF10@DBBPR04MB7979.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On 04/12/20 6:49 am, Peter Chen wrote:
>  
>> This patch introduce new Cadence USBSS DRD driver to linux kernel.
>>
>> The Cadence USBSS DRD Controller is a highly configurable IP Core which can
>> be instantiated as Dual-Role Device (DRD), Peripheral Only and Host Only
>> (XHCI)configurations.
>>
>> The current driver has been validated with FPGA burned. We have support for
>> PCIe bus, which is used on FPGA prototyping.
>>
>> The host side of USBSS-DRD controller is compliance with XHCI specification, so
>> it works with standard XHCI Linux driver.
>>
>> The device side of USBSS DRD controller is compliant with XHCI.
>> The architecture for device side is almost the same as for host side, and most
>> of the XHCI specification can be used to understand how this controller
>> operates.
>>
>> This controller and driver support Full Speed, Hight Speed, Supper Speed and
>> Supper Speed Plus USB protocol.
>>
>> The prefix cdnsp used in driver has chosen by analogy to cdn3 driver.
>> The last letter of this acronym means PLUS. The formal name of controller is
>> USBSSP but it's to generic so I've decided to use CDNSP.
>>
>> The patch 1: adds support for DRD CDNSP.
>> The patch 2: separates common code that can be reusable by cdnsp driver.
>> The patch 3: moves reusable code to separate module.
>> The patch 4: changes prefixes in reusable code from cdns3 to common cdns.
>> The patch 5: adopts gadget_dev pointer in cdns structure to make possible
>>              use it in both drivers.
>> The patches 6-8: add the main part of driver and has been intentionally
>>              split into 3 part. In my opinion such division should not
>>              affect understanding and reviewing the driver, and cause that
>>              main patch (7/8) is little smaller. Patch 6 introduces main
>>              header file for driver, 7 is the main part that implements all
>>              functionality of driver and 8 introduces tracepoints.
>> The patch 9: Adds cdns3 prefixes to files related with USBSS driver.
>> the patch 10: Adds USBSSP DRD IP driver entry to MAINTAINERS file.
>>
> 
> Hi Roger & Sekhar,
> 
> Would you please test this patch set and see if it works well at TI platforms?
> 

Tested this patch series on TI SOC J7200. All given below tests were
performed and they passed,

Host mode:
 - Connected a mass storage device (USB flash stick) and performed read
       and write tests
 - Connected mouse and keyboard to check enumeration

Device mode:
 - Tested g_mass_storage module by performing read and write
 - Tested g_ether module by the pinging host and device from either sides

OTG:
 - Switching between host and device mode based on the device connected.


Tested-by: Aswath Govindraju <a-govindraju@ti.com>

Thanks,
Aswath

> Peter
> 
>> Changlog from v3:
>> - added 'T' to MAINTAINERS file for CDNSP entry
>> - updated common code with latest cdns3 fixes
>>
>> Changlog from v2:
>> - removed not used pdev parameter from cdnsp_read/wite_64 functions
>> - fixed incorrect value assigned to CDNSP_ENDPOINTS_NUM (32 -> 31)
>> - replaced some constant value with CDNSP_ENDPOINTS_NUM macro
>> - replaced 'true' with '1' in bits description in cdnsp-gadget.h file
>> - fixed some typos
>> - some other less important changes suggested by Peter Chen
>>
>> Changlog from v1:
>> - updated common code to latest cdns3 driver
>> - moved cdnsp driver files to cdns3 as sugested by Peter Chan
>> - removed duplicate code from cdnsp_ep0_set_config function
>> - added cdns3 prefixes to file related with USBSS driver
>> - updated MAINTAINERS file
>> - fixed issue with U1
>> - fixed issue with L1
>> - some less improtant changes sugested by Chunfeng Yun
>> ---
>>
>> Pawel Laszczak (10):
>>   usb: cdns3: Add support for DRD CDNSP
>>   usb: cdns3: Split core.c into cdns3-plat and core.c file
>>   usb: cdns3: Moves reusable code to separate module
>>   usb: cdns3: Refactoring names in reusable code
>>   usb: cdns3: Changed type of gadget_dev in cdns structure
>>   usb: cdnsp: Device side header file for CDNSP driver
>>   usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver
>>   usb: cdnsp: Add tracepoints for CDNSP driver
>>   usb: cdns3: Change file names for cdns3 driver.
>>   MAINTAINERS: add Cadence USBSSP DRD IP driver entry
>>
>>  MAINTAINERS                                   |    9 +
>>  drivers/usb/Makefile                          |    2 +
>>  drivers/usb/cdns3/Kconfig                     |   61 +-
>>  drivers/usb/cdns3/Makefile                    |   30 +-
>>  drivers/usb/cdns3/{debug.h => cdns3-debug.h}  |    0
>>  drivers/usb/cdns3/{ep0.c => cdns3-ep0.c}      |    4 +-
>>  .../usb/cdns3/{gadget.c => cdns3-gadget.c}    |   28 +-
>>  .../usb/cdns3/{gadget.h => cdns3-gadget.h}    |    0
>>  drivers/usb/cdns3/cdns3-imx.c                 |    2 +-
>>  drivers/usb/cdns3/cdns3-plat.c                |  315 +++
>>  drivers/usb/cdns3/{trace.c => cdns3-trace.c}  |    2 +-
>>  drivers/usb/cdns3/{trace.h => cdns3-trace.h}  |    6 +-
>>  drivers/usb/cdns3/cdnsp-debug.h               |  583 ++++
>>  drivers/usb/cdns3/cdnsp-ep0.c                 |  495 ++++
>>  drivers/usb/cdns3/cdnsp-gadget.c              | 2017 ++++++++++++++
>>  drivers/usb/cdns3/cdnsp-gadget.h              | 1600 +++++++++++
>>  drivers/usb/cdns3/cdnsp-mem.c                 | 1325 +++++++++
>>  drivers/usb/cdns3/cdnsp-pci.c                 |  255 ++
>>  drivers/usb/cdns3/cdnsp-ring.c                | 2439
>> +++++++++++++++++
>>  drivers/usb/cdns3/cdnsp-trace.c               |   12 +
>>  drivers/usb/cdns3/cdnsp-trace.h               |  840 ++++++
>>  drivers/usb/cdns3/core.c                      |  455 +--
>>  drivers/usb/cdns3/core.h                      |   54 +-
>>  drivers/usb/cdns3/drd.c                       |  222 +-
>>  drivers/usb/cdns3/drd.h                       |   94 +-
>>  drivers/usb/cdns3/gadget-export.h             |   22 +-
>>  drivers/usb/cdns3/host-export.h               |   13 +-
>>  drivers/usb/cdns3/host.c                      |   22 +-
>>  28 files changed, 10400 insertions(+), 507 deletions(-)  rename
>> drivers/usb/cdns3/{debug.h => cdns3-debug.h} (100%)  rename
>> drivers/usb/cdns3/{ep0.c => cdns3-ep0.c} (99%)  rename
>> drivers/usb/cdns3/{gadget.c => cdns3-gadget.c} (99%)  rename
>> drivers/usb/cdns3/{gadget.h => cdns3-gadget.h} (100%)  create mode 100644
>> drivers/usb/cdns3/cdns3-plat.c  rename drivers/usb/cdns3/{trace.c =>
>> cdns3-trace.c} (89%)  rename drivers/usb/cdns3/{trace.h => cdns3-trace.h}
>> (99%)  create mode 100644 drivers/usb/cdns3/cdnsp-debug.h  create mode
>> 100644 drivers/usb/cdns3/cdnsp-ep0.c  create mode 100644
>> drivers/usb/cdns3/cdnsp-gadget.c  create mode 100644
>> drivers/usb/cdns3/cdnsp-gadget.h  create mode 100644
>> drivers/usb/cdns3/cdnsp-mem.c  create mode 100644
>> drivers/usb/cdns3/cdnsp-pci.c  create mode 100644
>> drivers/usb/cdns3/cdnsp-ring.c  create mode 100644
>> drivers/usb/cdns3/cdnsp-trace.c  create mode 100644
>> drivers/usb/cdns3/cdnsp-trace.h
>>
>> --
>> 2.17.1
> 

