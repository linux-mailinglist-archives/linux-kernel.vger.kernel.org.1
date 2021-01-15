Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02AD92F7CAF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 14:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731418AbhAONcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 08:32:06 -0500
Received: from mga02.intel.com ([134.134.136.20]:4203 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727198AbhAONcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 08:32:05 -0500
IronPort-SDR: O55sX5ETQxJsZPkYlCr7P8nF5NRrMBmJ2vZHSZITNE6gZDdoxx3rY/HAZtDLGtuj9CTgwLgqb2
 b/GDwF9ZjzZw==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="165632800"
X-IronPort-AV: E=Sophos;i="5.79,349,1602572400"; 
   d="scan'208";a="165632800"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 05:30:34 -0800
IronPort-SDR: rkuGIN6PyV/OIl9tLX8fMuB71hxEhDyCqOQV8o22rtlXLRozEx++TRMRSr8fDCq7JXduWKXAYK
 N4h9wUCk8q8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,349,1602572400"; 
   d="scan'208";a="346200160"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.170]) ([10.237.72.170])
  by fmsmga007.fm.intel.com with ESMTP; 15 Jan 2021 05:30:32 -0800
Subject: Re: [PATCH v2] usb: host: xhci-plat: fix support for
 XHCI_SKIP_PHY_INIT quirk
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Peter Chen <peter.chen@nxp.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jun Li <jun.li@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
References: <20201221150903.26630-1-pali@kernel.org>
 <20201223161847.10811-1-pali@kernel.org>
 <20201224055836.GB27629@b29397-desktop>
 <20210113232057.niqamgsqlaw7gojw@pali>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Autocrypt: addr=mathias.nyman@linux.intel.com; prefer-encrypt=mutual; keydata=
 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 fiD/
Message-ID: <88b48c61-65e4-cc24-d90d-5fba92f05f27@linux.intel.com>
Date:   Fri, 15 Jan 2021 15:32:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210113232057.niqamgsqlaw7gojw@pali>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.1.2021 1.20, Pali Rohár wrote:
> On Thursday 24 December 2020 05:59:05 Peter Chen wrote:
>> On 20-12-23 17:18:47, Pali Rohár wrote:
>>> Currently init_quirk callbacks for xhci platform drivers are called
>>> xhci_plat_setup() function which is called after chip reset completes.
>>> It happens in the middle of the usb_add_hcd() function.
>>>
>>> But XHCI_SKIP_PHY_INIT quirk is checked in the xhci_plat_probe() function
>>> prior calling usb_add_hcd() function. Therefore this XHCI_SKIP_PHY_INIT
>>> currently does nothing as prior xhci_plat_setup() it is not set.
>>>
>>> Quirk XHCI_SKIP_PHY_INIT is only setting hcd->skip_phy_initialization value
>>> which really needs to be set prior calling usb_add_hcd() as this function
>>> at its beginning skips PHY init if this member is set.
>>>
>>> This patch fixes implementation of the XHCI_SKIP_PHY_INIT quirk by calling
>>> init_quirk callbacks (via xhci_priv_init_quirk()) prior checking if
>>> XHCI_SKIP_PHY_INIT is set. Also checking if either xhci->quirks or
>>> priv->quirks contains this XHCI_SKIP_PHY_INIT quirk.
>>>
>>> Signed-off-by: Pali Rohár <pali@kernel.org>
>>>
>>> ---
>>> Changes in v2:
>>> * Check also xhci->quirks as xhci_priv_init_quirk() callbacks are setting xhci->quirks
>>> * Tested with "usb: host: xhci: mvebu: make USB 3.0 PHY optional for Armada 3720" patch
>>> * Removed Fixes: line
>>> ---
>>>  drivers/usb/host/xhci-plat.c | 16 ++++++++--------
>>>  1 file changed, 8 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
>>> index 4d34f6005381..0eab7cb5a767 100644
>>> --- a/drivers/usb/host/xhci-plat.c
>>> +++ b/drivers/usb/host/xhci-plat.c
>>> @@ -89,13 +89,6 @@ static void xhci_plat_quirks(struct device *dev, struct xhci_hcd *xhci)
>>>  /* called during probe() after chip reset completes */
>>>  static int xhci_plat_setup(struct usb_hcd *hcd)
>>>  {
>>> -	int ret;
>>> -
>>> -
>>> -	ret = xhci_priv_init_quirk(hcd);
>>> -	if (ret)
>>> -		return ret;
>>> -
>>>  	return xhci_gen_setup(hcd, xhci_plat_quirks);
>>>  }
>>>  
>>> @@ -330,7 +323,14 @@ static int xhci_plat_probe(struct platform_device *pdev)
>>>  
>>>  	hcd->tpl_support = of_usb_host_tpl_support(sysdev->of_node);
>>>  	xhci->shared_hcd->tpl_support = hcd->tpl_support;
>>> -	if (priv && (priv->quirks & XHCI_SKIP_PHY_INIT))
>>> +
>>> +	if (priv) {
>>> +		ret = xhci_priv_init_quirk(hcd);
>>> +		if (ret)
>>> +			goto disable_usb_phy;
>>> +	}
>>> +
>>> +	if ((xhci->quirks & XHCI_SKIP_PHY_INIT) || (priv && (priv->quirks & XHCI_SKIP_PHY_INIT)))
>>>  		hcd->skip_phy_initialization = 1;
>>
>> I am not sure if others agree with you move the position of
>> xhci_priv_init_quirk, Let's see Mathias opinion.
> 
> Hello! Do you have an opinion how to handle this issue? As currently it
> is needed for another patch which is fixing issue/regression in xhci-mvebu:
> https://lore.kernel.org/linux-usb/20201223162403.10897-1-pali@kernel.org/
> 

I can see the benefit in this. 
In the xhci-plat case usb_create_hcd and usb_add_hcd are separate steps, and
we could both copy the xhci_plat_priv .quirks and run the .init_qurks before
adding the hcd.
I guess the current way is inherited from pci case where the earliest place
to do this after hcd is created is the hcd->driver->reset callback (which is
set to xhci_pci_setup() or xhci_plat_setup()).

xhci-rcar.c is using the .init_quirk to load firmware, we need to check with
them if this change is ok. (added Yoshihiro Shimoda to cc)
Their firmware would be loaded before phy parts are initialized, usb bus
registered, or roothub device allocated.

Thanks
-Mathias
