Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F23626C374
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 16:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgIPOAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 10:00:23 -0400
Received: from mga12.intel.com ([192.55.52.136]:30867 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726648AbgIPNlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 09:41:44 -0400
IronPort-SDR: 5oPOXgeW7uQ1mYhiHfWexAC+QwexYWCU3h2AcJk+UIdFpWmYIV1LpUyug21XegkvoVAt7ZZkn8
 K2/Y71ZgAhVQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9745"; a="138954082"
X-IronPort-AV: E=Sophos;i="5.76,432,1592895600"; 
   d="scan'208";a="138954082"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2020 05:43:52 -0700
IronPort-SDR: WOynIPceZCbhvv68/lf6IeVOaC2paax4n3bYUpPxg3kFa4mILFaNYtswptGHf859A0EEZOTdlJ
 dodjpcBiToWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,432,1592895600"; 
   d="scan'208";a="451838929"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.170]) ([10.237.72.170])
  by orsmga004.jf.intel.com with ESMTP; 16 Sep 2020 05:43:50 -0700
Subject: Re: [PATCH] xhci: workaround for S3 issue on AMD SNPS 3.0 xHC
To:     Greg KH <gregkh@linuxfoundation.org>,
        Nehal Bakulchandra Shah <Nehal-bakulchandra.Shah@amd.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sandeep.Singh@amd.com, yuanmei@lenovo.com
References: <20200831065246.1166470-1-Nehal-bakulchandra.Shah@amd.com>
 <20200916080611.GA486670@kroah.com>
From:   Mathias Nyman <mathias.nyman@intel.com>
Message-ID: <86106f56-68a7-8d58-0ba8-7e19788688f2@intel.com>
Date:   Wed, 16 Sep 2020 15:47:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200916080611.GA486670@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.9.2020 11.06, Greg KH wrote:
> On Mon, Aug 31, 2020 at 06:52:46AM +0000, Nehal Bakulchandra Shah wrote:
>> From: Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
>>
>> On some platform of AMD, S3 fails with HCE and SRE errors.To fix this,
>> sparse controller enable bit has to be disabled.
>>
>> Signed-off-by: Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
>> ---
>>  drivers/usb/host/xhci-pci.c | 12 ++++++++++++
>>  drivers/usb/host/xhci.h     |  1 +
>>  2 files changed, 13 insertions(+)
>>
>> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c  
>> @@ -371,6 +374,15 @@ static int xhci_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
>>  	/* USB 2.0 roothub is stored in the PCI device now. */
>>  	hcd = dev_get_drvdata(&dev->dev);
>>  	xhci = hcd_to_xhci(hcd);
>> +
>> +	if (xhci->quirks & XHCI_DISABLE_SPARSE) {
>> +		u32 reg;
>> +
>> +		reg = readl(hcd->regs + 0xC12C);
>> +		reg &=  ~BIT(17); 
>
> And is this the proper place to be testing for quirks and applying them?
> Why not do the above in the xhci_pci_quirks() call?

xhci_pci_quirks() is a confusing name, it actually only sets quirk flags based on PCI
vendor/device.

Anyway, point is still valid, this level of bitops in probe isn't very nice.
Turn it into a separate function, and call it from xhci_pci_setup(), or if flag
needs to be cleared more often, and is related to S3 problems then possibly from xhci_pci_suspend()

-Mathias
