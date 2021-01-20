Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBA562FD7A4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 19:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390145AbhATR7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 12:59:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:42728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390729AbhATR6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 12:58:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E96A223DB;
        Wed, 20 Jan 2021 17:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611165481;
        bh=4UTf4DzBG4G1mpWGbL2tGpPcJFcqdXclypXVlwrxw0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=No+re5rmBxP7HsK1yCKsddd4AgMo4j1g4QcLvEyqUFMQo0qKObc7OleJwBEu64dZ8
         R6h+S6vQ/2R0IJzxY5NJfhsVfnN8tMUFo94qEOTwtVMXo1aLPhUgEfQsqSH+fzzP65
         awsdmfW38Z1waFby+I+NXseAoEG0YAWYPHn7I3uY=
Date:   Wed, 20 Jan 2021 18:57:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     mgross@linux.intel.com
Cc:     markgross@kernel.org, arnd@arndb.de, bp@suse.de,
        damien.lemoal@wdc.com, dragan.cvetic@xilinx.com, corbet@lwn.net,
        leonard.crestez@nxp.com, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, peng.fan@nxp.com, robh+dt@kernel.org,
        shawnguo@kernel.org, jassisinghbrar@gmail.com,
        linux-kernel@vger.kernel.org,
        Srikanth Thokala <srikanth.thokala@intel.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: Re: [PATCH v2 09/34] misc: xlink-pcie: lh: Add PCIe EPF driver for
 Local Host
Message-ID: <YAhvJ2MxqnX2g0nS@kroah.com>
References: <20210108212600.36850-1-mgross@linux.intel.com>
 <20210108212600.36850-10-mgross@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108212600.36850-10-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 01:25:35PM -0800, mgross@linux.intel.com wrote:
> From: Srikanth Thokala <srikanth.thokala@intel.com>
> 
> Add PCIe EPF driver for local host (lh) to configure BAR's and other
> HW resources. Underlying PCIe HW controller is a Synopsys DWC PCIe core.
> 
> Cc: Derek Kiernan <derek.kiernan@xilinx.com>
> Cc: Dragan Cvetic <dragan.cvetic@xilinx.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Mark Gross <mgross@linux.intel.com>
> Signed-off-by: Srikanth Thokala <srikanth.thokala@intel.com>
> ---
>  MAINTAINERS                                 |   6 +
>  drivers/misc/Kconfig                        |   1 +
>  drivers/misc/Makefile                       |   1 +
>  drivers/misc/xlink-pcie/Kconfig             |   9 +
>  drivers/misc/xlink-pcie/Makefile            |   1 +
>  drivers/misc/xlink-pcie/local_host/Makefile |   2 +
>  drivers/misc/xlink-pcie/local_host/epf.c    | 413 ++++++++++++++++++++
>  drivers/misc/xlink-pcie/local_host/epf.h    |  39 ++
>  drivers/misc/xlink-pcie/local_host/xpcie.h  |  38 ++

Why such a deep directory tree?  Why is "local_host" needed?

Anyway, one thing stood out instantly:

> +static int intel_xpcie_check_bar(struct pci_epf *epf,
> +				 struct pci_epf_bar *epf_bar,
> +				 enum pci_barno barno,
> +				 size_t size, u8 reserved_bar)
> +{
> +	if (reserved_bar & (1 << barno)) {
> +		dev_err(&epf->dev, "BAR%d is already reserved\n", barno);
> +		return -EFAULT;

That error is only allowed when you really have a fault from
reading/writing to/from userspace memory.  Not this type of foolish
programming error by the caller.

> +	}
> +
> +	if (epf_bar->size != 0 && epf_bar->size < size) {
> +		dev_err(&epf->dev, "BAR%d fixed size is not enough\n", barno);
> +		return -ENOMEM;

Did you really run out of memory or was the parameters sent to you
incorrect?  -EINVAL is the properly thing here, right?



> +	}
> +
> +	return 0;
> +}
> +
> +static int intel_xpcie_configure_bar(struct pci_epf *epf,
> +				     const struct pci_epc_features
> +					*epc_features)

Odd indentation :(

> +{
> +	struct pci_epf_bar *epf_bar;
> +	bool bar_fixed_64bit;
> +	int ret, i;
> +
> +	for (i = BAR_0; i <= BAR_5; i++) {
> +		epf_bar = &epf->bar[i];
> +		bar_fixed_64bit = !!(epc_features->bar_fixed_64bit & (1 << i));
> +		if (bar_fixed_64bit)
> +			epf_bar->flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
> +		if (epc_features->bar_fixed_size[i])
> +			epf_bar->size = epc_features->bar_fixed_size[i];
> +
> +		if (i == BAR_2) {
> +			ret = intel_xpcie_check_bar(epf, epf_bar, BAR_2,
> +						    BAR2_MIN_SIZE,
> +						    epc_features->reserved_bar);
> +			if (ret)
> +				return ret;
> +		}
> +
> +		if (i == BAR_4) {
> +			ret = intel_xpcie_check_bar(epf, epf_bar, BAR_4,
> +						    BAR4_MIN_SIZE,
> +						    epc_features->reserved_bar);
> +			if (ret)
> +				return ret;
> +		}

Why do you need to check all of this?  Where is the data coming from
that could be incorrect?

thanks,

greg k-h
