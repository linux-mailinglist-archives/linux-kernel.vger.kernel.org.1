Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC5126CBEB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbgIPUg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:36:58 -0400
Received: from mga02.intel.com ([134.134.136.20]:21154 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726793AbgIPRKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:10:21 -0400
IronPort-SDR: L9i3YG3xSoZc/0ZTN1Lu/XgFkpizjcUbzLq06j2flQRUS5MqVo8AWWHEQG6kSVp+3y/9+xwy3Q
 dnB3l2hHmMZg==
X-IronPort-AV: E=McAfee;i="6000,8403,9745"; a="147137498"
X-IronPort-AV: E=Sophos;i="5.76,432,1592895600"; 
   d="scan'208";a="147137498"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2020 05:26:43 -0700
IronPort-SDR: p7/YuHpQIogTkInWLhal8vzrvsLtpNi254IL9RX3AA6hWTXoyG5ZN/rgH0eN/0RtWo9F/B+uOQ
 ipuMsEyloMzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,432,1592895600"; 
   d="scan'208";a="451832627"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.170]) ([10.237.72.170])
  by orsmga004.jf.intel.com with ESMTP; 16 Sep 2020 05:26:41 -0700
Subject: Re: [PATCH] xhci: workaround for S3 issue on AMD SNPS 3.0 xHC
To:     Nehal Bakulchandra Shah <Nehal-bakulchandra.Shah@amd.com>,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sandeep.Singh@amd.com,
        yuanmei@lenovo.com
References: <20200831065246.1166470-1-Nehal-bakulchandra.Shah@amd.com>
From:   Mathias Nyman <mathias.nyman@intel.com>
Message-ID: <897a7917-5ea6-025b-c516-482188759e0a@intel.com>
Date:   Wed, 16 Sep 2020 15:30:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200831065246.1166470-1-Nehal-bakulchandra.Shah@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.8.2020 9.52, Nehal Bakulchandra Shah wrote:
> From: Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
> 
> On some platform of AMD, S3 fails with HCE and SRE errors.To fix this,
> sparse controller enable bit has to be disabled.
> 
> Signed-off-by: Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
> ---
>  drivers/usb/host/xhci-pci.c | 12 ++++++++++++
>  drivers/usb/host/xhci.h     |  1 +
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index 3feaafebfe58..865a16e6c1ed 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -160,6 +160,9 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
>  	    (pdev->device == 0x15e0 || pdev->device == 0x15e1))
>  		xhci->quirks |= XHCI_SNPS_BROKEN_SUSPEND;
>  
> +	if (pdev->vendor == PCI_VENDOR_ID_AMD && pdev->device == 0x15e5)
> +		xhci->quirks |= XHCI_DISABLE_SPARSE;
> +
>  	if (pdev->vendor == PCI_VENDOR_ID_AMD)
>  		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
>  
> @@ -371,6 +374,15 @@ static int xhci_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	/* USB 2.0 roothub is stored in the PCI device now. */
>  	hcd = dev_get_drvdata(&dev->dev);
>  	xhci = hcd_to_xhci(hcd);
> +
> +	if (xhci->quirks & XHCI_DISABLE_SPARSE) {
> +		u32 reg;
> +
> +		reg = readl(hcd->regs + 0xC12C);
> +		reg &=  ~BIT(17);
> +		writel(reg, hcd->regs + 0xC12C);
> +	}
> +

Is disabling the bit once in probe enough?
xHC will be reset after hibernation as well, does this bit need to be cleared after that?

Also consider turning this into a separate function with a proper description,
see xhci_pme_quirk() for example. Avoids cluttering probe.
Actually if this bit only needs to be cleared once then that function could be called from xhci_pci_setup()

-Mathias
