Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1616B2C2185
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 10:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731326AbgKXJgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 04:36:20 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46086 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727901AbgKXJgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 04:36:19 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AO9a6xA059924;
        Tue, 24 Nov 2020 03:36:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1606210566;
        bh=9IuaD463M/O7x1ub80gs1VOzW7luN+hlcORuuHRJZFI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=of8SXsPKegrKNelju/P1soyMQPckY8yCcQHw7DyRsdsCj8jHEsU3JWUL931Gl61AJ
         VKO7ycs/M/KkzUjkbxpalSaorbLXSnKBAvjYmjgLaGPY+Yfr3sG2ynC959fpy3/B6a
         JCckzsYNHFO6fQyN9/v/+HPP+9qGBcOEQQ8vaBY8=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AO9a6H0082122
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 24 Nov 2020 03:36:06 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 24
 Nov 2020 03:36:06 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 24 Nov 2020 03:36:06 -0600
Received: from [10.24.69.198] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AO9ZxTL062055;
        Tue, 24 Nov 2020 03:36:00 -0600
Subject: Re: [PATCH v3 00/10] Introduced new Cadence USBSSP DRD Driver.
To:     Pawel Laszczak <pawell@cadence.com>,
        Peter Chen <peter.chen@nxp.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "rogerq@ti.com" <rogerq@ti.com>, Rahul Kumar <kurahul@cadence.com>,
        "Govindraju, Aswath" <a-govindraju@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
References: <20201119141307.8342-1-pawell@cadence.com>
 <20201124075023.GC32310@b29397-desktop>
 <DM6PR07MB55299F262CEA81216999CB05DDFB0@DM6PR07MB5529.namprd07.prod.outlook.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <45ffc5f8-f9de-e14d-3d03-9ef1f1c848d9@ti.com>
Date:   Tue, 24 Nov 2020 15:05:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <DM6PR07MB55299F262CEA81216999CB05DDFB0@DM6PR07MB5529.namprd07.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/11/20 2:51 PM, Pawel Laszczak wrote:
> Peter,
> 
>> On 20-11-19 15:12:57, Pawel Laszczak wrote:
>>> This patch introduce new Cadence USBSS DRD driver to linux kernel.
>>>
>>> The Cadence USBSS DRD Controller is a highly configurable IP Core which
>>> can be instantiated as Dual-Role Device (DRD), Peripheral Only and
>>> Host Only (XHCI)configurations.
>>>
>>> The current driver has been validated with FPGA burned. We have support
>>> for PCIe bus, which is used on FPGA prototyping.
>>>
>>> The host side of USBSS-DRD controller is compliance with XHCI
>>> specification, so it works with standard XHCI Linux driver.
>>>
>>> The device side of USBSS DRD controller is compliant with XHCI.
>>> The architecture for device side is almost the same as for host side,
>>> and most of the XHCI specification can be used to understand how
>>> this controller operates.
>>>
>>> This controller and driver support Full Speed, Hight Speed, Supper Speed
>>> and Supper Speed Plus USB protocol.
>>>
>>> The prefix cdnsp used in driver has chosen by analogy to cdn3 driver.
>>> The last letter of this acronym means PLUS. The formal name of controller
>>> is USBSSP but it's to generic so I've decided to use CDNSP.
>>>
>>> The patch 1: adds support for DRD CDNSP.
>>> The patch 2: separates common code that can be reusable by cdnsp driver.
>>> The patch 3: moves reusable code to separate module.
>>> The patch 4: changes prefixes in reusable code from cdns3 to common cdns.
>>> The patch 5: adopts gadget_dev pointer in cdns structure to make possible
>>>              use it in both drivers.
>>> The patches 6-8: add the main part of driver and has been intentionally
>>>              split into 3 part. In my opinion such division should not
>>>              affect understanding and reviewing the driver, and cause that
>>>              main patch (7/8) is little smaller. Patch 6 introduces main
>>>              header file for driver, 7 is the main part that implements all
>>>              functionality of driver and 8 introduces tracepoints.
>>> The patch 9: Adds cdns3 prefixes to files related with USBSS driver.
>>> the patch 10: Adds USBSSP DRD IP driver entry to MAINTAINERS file.
>>>
>>> Changlog from v2:
>>> - removed not used pdev parameter from cdnsp_read/wite_64 functions
>>> - fixed incorrect value assigned to CDNSP_ENDPOINTS_NUM (32 -> 31)
>>> - replaced some constant value with CDNSP_ENDPOINTS_NUM macro
>>> - replaced 'true' with '1' in bits description in cdnsp-gadget.h file
>>> - fixed some typos
>>> - some other less important changes suggested by Peter Chen
>>
>> Hi Pawel,
>>
>> I have updated my -next tree as the latest usb-next tree which v5.10-rc4
>> is included, would you please rebase my tree and send again, I could apply your
>> patches and test, if test could pass, I will apply it to my -next tree.
>> You don't need to rebase again since it is a huge patch set, will take some
>> efforts for rebase.
>>
> 
> I'll try to post it tomorrow.

Pawel, have you tested TI J7 for regressions after this series? After
your latest changes, can you post a tree which someone in TI can test?

Thanks,
Sekhar
