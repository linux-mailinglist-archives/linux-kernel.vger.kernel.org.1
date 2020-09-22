Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56842739A9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 06:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbgIVEVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 00:21:37 -0400
Received: from mga18.intel.com ([134.134.136.126]:51222 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726790AbgIVEVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 00:21:35 -0400
IronPort-SDR: K6TEJh7RtMb86KxJ4/qzQvUTvJ7VFUkyueumbIcLtPexDJB0zur4nKX1FUX/r2AEDGG8VkD8a/
 WrjT6rCU9t6Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="148282267"
X-IronPort-AV: E=Sophos;i="5.77,289,1596524400"; 
   d="scan'208";a="148282267"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2020 21:21:34 -0700
IronPort-SDR: iGxqjyRDLUS1y98vuXY8eB3HROqQQ4TcOPMlcRFeWQUSzH3Sc5k0/f4+pxVJaWvaOtF3W41RWe
 v5S0VYXI3NBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,289,1596524400"; 
   d="scan'208";a="348343830"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 21 Sep 2020 21:21:35 -0700
Received: from [10.213.147.65] (vramuthx-MOBL1.gar.corp.intel.com [10.213.147.65])
        by linux.intel.com (Postfix) with ESMTP id 644AD580812;
        Mon, 21 Sep 2020 21:21:32 -0700 (PDT)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH -next] phy: fix USB_LGM_PHY warning & build errors
To:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Cc:     Li Yin <yin1.li@intel.com>, Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <d1dd0ddd-3143-5777-1c63-195e1a32f237@infradead.org>
 <cb3b277e-109d-82c5-9dec-153b4e035c2a@infradead.org>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <7a0129e7-b023-29ad-963f-345bb762b35e@linux.intel.com>
Date:   Tue, 22 Sep 2020 12:21:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <cb3b277e-109d-82c5-9dec-153b4e035c2a@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

   Thank you for the report, surely will fix it.

Regards
Vadivel

On 21/9/2020 11:45 pm, Randy Dunlap wrote:
> Ping.  Still seeing this in linux-next.
> 
> On 9/17/20 10:51 AM, Randy Dunlap wrote:
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> Fix a Kconfig warning that is causing lots of build errors
>> when USB_SUPPORT is not set.
>>
>> USB_PHY depends on USB_SUPPORT but "select" doesn't care about
>> dependencies, so this driver should also depend on USB_SUPPORT.
>> It should not select USB_SUPPORT.
>>
>> WARNING: unmet direct dependencies detected for USB_PHY
>>    Depends on [n]: USB_SUPPORT [=n]
>>    Selected by [m]:
>>    - USB_LGM_PHY [=m]
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Li Yin <yin1.li@intel.com>
>> Cc: Vadivel Murugan R <vadivel.muruganx.ramuthevar@linux.intel.com>
>> Cc: Kishon Vijay Abraham I <kishon@ti.com>
>> Cc: Vinod Koul <vkoul@kernel.org>
>> ---
>>   drivers/phy/Kconfig |    1 +
>>   1 file changed, 1 insertion(+)
>>
>> --- linux-next-20200917.orig/drivers/phy/Kconfig
>> +++ linux-next-20200917/drivers/phy/Kconfig
>> @@ -51,6 +51,7 @@ config PHY_XGENE
>>   
>>   config USB_LGM_PHY
>>   	tristate "INTEL Lightning Mountain USB PHY Driver"
>> +	depends on USB_SUPPORT
>>   	select USB_PHY
>>   	select REGULATOR
>>   	select REGULATOR_FIXED_VOLTAGE
>>
> 
> 
